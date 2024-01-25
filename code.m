classdef standard_calculator < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                 matlab.ui.Figure
        ResultLabel              matlab.ui.control.Label
        ResultsText              matlab.ui.control.TextArea
        FormulaText              matlab.ui.control.TextArea
        InputEquationLabel       matlab.ui.control.Label
        DebugMATLABLabel         matlab.ui.control.Label
        DebugButton              matlab.ui.control.StateButton
        Button_percent           matlab.ui.control.Button
        Button_reciprocal        matlab.ui.control.Button
        Button_sqrt              matlab.ui.control.Button
        Button_mpower            matlab.ui.control.Button
        StandardCalculatorLabel  matlab.ui.control.Label
        ACButton                 matlab.ui.control.Button
        Button_equal             matlab.ui.control.Button
        Button_Backspace         matlab.ui.control.Button
        Button_bracket           matlab.ui.control.Button
        Button_divide            matlab.ui.control.Button
        Button_mutiply           matlab.ui.control.Button
        Button_subtract          matlab.ui.control.Button
        Button_add               matlab.ui.control.Button
        Button_point             matlab.ui.control.Button
        Button_0                 matlab.ui.control.Button
        Button_00                matlab.ui.control.Button
        Button_9                 matlab.ui.control.Button
        Button_8                 matlab.ui.control.Button
        Button_7                 matlab.ui.control.Button
        Button_6                 matlab.ui.control.Button
        Button_5                 matlab.ui.control.Button
        Button_4                 matlab.ui.control.Button
        Button_3                 matlab.ui.control.Button
        Button_2                 matlab.ui.control.Button
        Button_1                 matlab.ui.control.Button
    end

    
    properties (Access = private)
        Property % Description
        res=0;
        formula=[];
        Lb=0;
        Rb=0;
        Exclu=['+','-','×','÷','(','√','^'];
        arithmetic=['+','-','×','÷'];
        idpp=0
        fpp=0
        nextChar=[]
        numCLformula=0
        counts=0
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: Button_1
        function Button_1Pushed(app, event)
            app.formula=[app.formula,'1'];
            app.FormulaText.Value=app.formula;
        end

        % Button pushed function: Button_2
        function Button_2Pushed(app, event)
            app.formula=[app.formula,'2'];
            app.FormulaText.Value=app.formula;
        end

        % Button pushed function: Button_3
        function Button_3Pushed(app, event)
            app.formula=[app.formula,'3'];
            app.FormulaText.Value=app.formula;
        end

        % Button pushed function: Button_4
        function Button_4Pushed(app, event)
            app.formula=[app.formula,'4'];
            app.FormulaText.Value=app.formula;
        end

        % Button pushed function: Button_5
        function Button_5Pushed(app, event)
            app.formula=[app.formula,'5'];
            app.FormulaText.Value=app.formula;
        end

        % Button pushed function: Button_6
        function Button_6Pushed(app, event)
            app.formula=[app.formula,'6'];
            app.FormulaText.Value=app.formula;
        end

        % Button pushed function: Button_7
        function Button_7Pushed(app, event)
            app.formula=[app.formula,'7'];
            app.FormulaText.Value=app.formula;
        end

        % Button pushed function: Button_8
        function Button_8Pushed(app, event)
            app.formula=[app.formula,'8'];
            app.FormulaText.Value=app.formula;
        end

        % Button pushed function: Button_9
        function Button_9Pushed(app, event)
            app.formula=[app.formula,'9'];
            app.FormulaText.Value=app.formula;
        end

        % Button pushed function: Button_00
        function Button_00Pushed(app, event)
            if isempty(app.formula)
            else
                app.formula=[app.formula,'00'];
                app.FormulaText.Value=app.formula;
            end
        end

        % Button pushed function: Button_0
        function Button_0Pushed(app, event)
            if isempty(app.formula)
            else
                app.formula=[app.formula,'0'];
                app.FormulaText.Value=app.formula;
            end
        end

        % Button pushed function: Button_point
        function Button_pointPushed(app, event)
            if isempty(app.formula)
                app.formula=[app.formula,'0.'];
            elseif app.formula(end)=='.'
            elseif isstrprop(app.formula(end),'digit')
                app.numCLformula=length(app.formula);
                while app.numCLformula>app.counts&&isstrprop(app.formula(end-app.counts),'digit')
                    app.counts=app.counts+1;
                end
                if app.numCLformula==app.counts
                    app.formula=[app.formula,'.'];
                elseif app.formula(end-app.counts)=='.'
                elseif ~isstrprop(app.formula(end-app.counts),'digit')
                    app.formula=[app.formula,'.'];
                end
                app.counts=0;
            else
                if ismember(app.formula(end),app.Exclu)
                    app.formula=[app.formula,'0'];
                elseif app.formula(end)=='%'||app.formula(end)==')'
                    app.formula=[app.formula,'×0'];
                elseif app.formula(end)=='^'
                    app.formula=[app.formula,'(0'];
                end
                app.formula=[app.formula,'.'];
            end
            app.FormulaText.Value=app.formula;
        end

        % Button pushed function: Button_add
        function Button_addPushed(app, event)
            if isempty(app.formula)||app.formula(end)=='.'
                app.formula=[app.formula,'0'];
            elseif ismember(app.formula(end),app.arithmetic)
                app.formula(end)=[];
            elseif ~isstrprop(app.formula(end),'digit')&&app.formula(end)~=')'&&app.formula(end)~='%'
                app.formula=[app.formula,'0'];
            end
            app.formula=[app.formula,'+'];
            app.FormulaText.Value=app.formula;
        end

        % Button pushed function: Button_subtract
        function Button_subtractPushed(app, event)
            if isempty(app.formula)||app.formula(end)=='.'
                app.formula=[app.formula,'0'];
            elseif ismember(app.formula(end),app.arithmetic)
                app.formula(end)=[];
            elseif ~isstrprop(app.formula(end),'digit')&&app.formula(end)~=')'&&app.formula(end)~='%'
                app.formula=[app.formula,'0'];
            end
            app.formula=[app.formula,'-'];
            app.FormulaText.Value=app.formula;
        end

        % Button pushed function: Button_mutiply
        function Button_mutiplyPushed(app, event)
            if isempty(app.formula)||app.formula(end)=='.'
                app.formula=[app.formula,'0'];
            elseif ismember(app.formula(end),app.arithmetic)
                app.formula(end)=[];
            elseif ~isstrprop(app.formula(end),'digit')&&app.formula(end)~=')'&&app.formula(end)~='%'
                app.formula=[app.formula,'0'];
            end
            app.formula=[app.formula,'×'];
            app.FormulaText.Value=app.formula;
        end

        % Button pushed function: Button_divide
        function Button_dividePushed(app, event)
            if isempty(app.formula)||app.formula(end)=='.'
                app.formula=[app.formula,'0'];
            elseif ismember(app.formula(end),app.arithmetic)
                app.formula(end)=[];
            elseif ~isstrprop(app.formula(end),'digit')&&app.formula(end)~=')'&&app.formula(end)~='%'
                app.formula=[app.formula,'0'];
            end
            app.formula=[app.formula,'÷'];
            app.FormulaText.Value=app.formula;
        end

        % Button pushed function: Button_bracket
        function Button_bracketPushed(app, event)
            if isempty(app.formula)||ismember(app.formula(end),app.Exclu)||app.formula(end)=='^'
                app.formula=[app.formula,'('];
            else
                if app.formula(end)=='.'
                    app.formula=[app.formula,'0'];
                end
                app.Lb=count(app.formula,'(');
                app.Rb=count(app.formula,')');
                if app.Lb==app.Rb
                    if isstrprop(app.formula(end),'digit')||app.formula(end)=='%'||app.formula(end)==')'
                        app.formula=[app.formula,'×'];
                    end
                    app.formula=[app.formula,'('];
                else
                    app.formula=[app.formula,')'];
                end
            end
            app.FormulaText.Value=app.formula;
        end

        % Button pushed function: Button_Backspace
        function Button_BackspacePushed(app, event)
            app.numCLformula=length(app.formula);
            if isempty(app.formula)
                app.formula=app.formula;
            elseif app.numCLformula==1
                app.formula='0';
                app.FormulaText.Value=app.formula;
                app.formula=[];
            elseif app.numCLformula>1
                if app.formula(end-1)=='√'||app.formula(end-1)=='^'
                    if app.formula(end)=='('
                        app.formula(end-1:end)=[];
                    else
                        app.formula(end)=[];
                    end
                else
                    app.formula(end)=[];
                end
                app.FormulaText.Value=app.formula;
            end
        end

        % Button pushed function: ACButton
        function ACButtonPushed(app, event)
            app.FormulaText.Value='0';
            app.formula=[];
            app.ResultsText.Value='';
            app.res=0;
        end

        % Button pushed function: Button_equal
        function Button_equalPushed(app, event)
            if isempty(app.formula)||app.formula(end)=='.'
                app.formula=[app.formula,'0'];
            end

            if ismember(app.formula(end),app.Exclu)
                app.FormulaText.Value=[app.formula,newline,newline,'Incomplete input.'];
            else
                app.Lb=count(app.formula,'(');
                app.Rb=count(app.formula,')');
                while app.Lb>app.Rb
                    app.formula=[app.formula,')'];
                    app.Lb=count(app.formula,'(');
                    app.Rb=count(app.formula,')');
                end

                app.idpp=strfind(app.formula,'%');
                app.numCLformula=length(app.formula);
                pcount=numel(app.idpp);
                while pcount~=0
                    app.fpp=app.idpp(pcount);
                    if app.fpp~=0&&app.numCLformula~=app.fpp
                        app.nextChar=app.formula(app.fpp+1);
                        if isstrprop(app.nextChar,'digit')
                            app.formula=insertBefore(app.formula,app.fpp+1,'×');
                        end
                        app.numCLformula=length(app.formula);
                    end
                    pcount=pcount-1;
                end

                Equation=app.formula;

                app.numCLformula=length(app.formula);
                while app.numCLformula~=0
                    if strcmp(app.formula(app.numCLformula),'%')
                        i=app.numCLformula-1;
                        while i~=0&&(isstrprop(app.formula(i),'digit')||strcmp(app.formula(i),'.'))
                            i=i-1;
                        end
                        if i~=0
                            app.formula=[app.formula(1:i),'(',app.formula(i+1:end)];
                        else
                            app.formula=['(',app.formula(1:end)];
                        end
                    end
                    app.numCLformula=app.numCLformula-1;
                end

                app.idpp=strfind(app.formula,'%');
                app.numCLformula=length(app.formula);
                while ~isempty(app.idpp)
                    app.fpp=app.idpp(1);
                    app.formula=[app.formula(1:app.fpp-1),'÷100)',app.formula(app.fpp+1:end)];
                    app.idpp=strfind(app.formula,'%');
                    app.numCLformula=length(app.formula);
                end
                
                if strfind(app.formula,'()')
                    app.ResultsText.Value='ERROR';
                    app.FormulaText.Value=['Invalid input.',newline,'But how did you do this?'];
                    app.formula=[];
                    app.res=0;
                else
                    app.formula=replace(app.formula,'×','*');
                    app.formula=replace(app.formula,'÷','/');
                    app.formula=replace(app.formula,'√','sqrt');
                    app.res=eval(app.formula);
                    app.ResultsText.Value=num2str(app.res);
                    Equation=[Equation,'=',num2str(app.res)];
                    app.FormulaText.Value=Equation;
                    app.formula=[num2str(app.res)];
                    if app.res==Inf||app.res==-Inf||isnan(app.res)
                        app.formula=[];
                        app.res=0;
                    end
                end
            end
        end

        % Button pushed function: Button_percent
        function Button_percentPushed(app, event)
            if isempty(app.formula)||app.formula(end)=='.'
                app.formula=[app.formula,'0'];
            elseif ~isstrprop(app.formula(end),'digit')&&app.formula(end)~=')'
                app.formula=[app.formula,'1'];
            end
            app.formula=[app.formula,'%'];
            app.FormulaText.Value=app.formula;
        end

        % Value changed function: DebugButton
        function Debug(app, event)
            assignin('base','counts',app.counts)
            assignin('base','nextChar',app.nextChar)
            assignin('base','idpp',app.idpp)
            assignin('base','fpp',app.fpp)
            assignin('base','numCLformula',app.numCLformula)
            assignin('base','formula',app.formula)
            app.numCLformula=length(app.formula);
        end

        % Button pushed function: Button_sqrt
        function Button_sqrtPushed(app, event)
            if isempty(app.formula)
            elseif app.formula(end)=='.'
                app.formula=[app.formula,'0×'];
            elseif isstrprop(app.formula(end),'digit')||app.formula(end)==')'||app.formula(end)=='%'
                app.formula=[app.formula,'×'];
            end
            app.formula=[app.formula,'√('];
            app.FormulaText.Value=app.formula;
        end

        % Button pushed function: Button_mpower
        function Button_mpowerPushed(app, event)
            if isempty(app.formula)
            elseif ismember(app.formula(end),app.Exclu)
            else
                if app.formula(end)=='.'
                    app.formula=[app.formula,'0'];
                end
                app.formula=[app.formula,'^('];
                app.FormulaText.Value=app.formula;
            end
        end

        % Button pushed function: Button_reciprocal
        function Button_reciprocalPushed(app, event)
            if isempty(app.formula)
                app.formula=['1÷(',app.formula,];
            elseif ismember(app.formula(end),app.Exclu)
                app.formula=['1÷(',app.formula];
            else
                app.formula=['1÷(',app.formula,')'];
            end
            app.FormulaText.Value=app.formula;
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create Button_1
            app.Button_1 = uibutton(app.UIFigure, 'push');
            app.Button_1.ButtonPushedFcn = createCallbackFcn(app, @Button_1Pushed, true);
            app.Button_1.Position = [69 212 100 22];
            app.Button_1.Text = '1';

            % Create Button_2
            app.Button_2 = uibutton(app.UIFigure, 'push');
            app.Button_2.ButtonPushedFcn = createCallbackFcn(app, @Button_2Pushed, true);
            app.Button_2.Position = [168 212 100 22];
            app.Button_2.Text = '2';

            % Create Button_3
            app.Button_3 = uibutton(app.UIFigure, 'push');
            app.Button_3.ButtonPushedFcn = createCallbackFcn(app, @Button_3Pushed, true);
            app.Button_3.Position = [267 212 100 22];
            app.Button_3.Text = '3';

            % Create Button_4
            app.Button_4 = uibutton(app.UIFigure, 'push');
            app.Button_4.ButtonPushedFcn = createCallbackFcn(app, @Button_4Pushed, true);
            app.Button_4.Position = [69 191 100 22];
            app.Button_4.Text = '4';

            % Create Button_5
            app.Button_5 = uibutton(app.UIFigure, 'push');
            app.Button_5.ButtonPushedFcn = createCallbackFcn(app, @Button_5Pushed, true);
            app.Button_5.Position = [168 191 100 22];
            app.Button_5.Text = '5';

            % Create Button_6
            app.Button_6 = uibutton(app.UIFigure, 'push');
            app.Button_6.ButtonPushedFcn = createCallbackFcn(app, @Button_6Pushed, true);
            app.Button_6.Position = [267 191 100 22];
            app.Button_6.Text = '6';

            % Create Button_7
            app.Button_7 = uibutton(app.UIFigure, 'push');
            app.Button_7.ButtonPushedFcn = createCallbackFcn(app, @Button_7Pushed, true);
            app.Button_7.Position = [69 170 100 22];
            app.Button_7.Text = '7';

            % Create Button_8
            app.Button_8 = uibutton(app.UIFigure, 'push');
            app.Button_8.ButtonPushedFcn = createCallbackFcn(app, @Button_8Pushed, true);
            app.Button_8.Position = [168 170 100 22];
            app.Button_8.Text = '8';

            % Create Button_9
            app.Button_9 = uibutton(app.UIFigure, 'push');
            app.Button_9.ButtonPushedFcn = createCallbackFcn(app, @Button_9Pushed, true);
            app.Button_9.Position = [267 170 100 22];
            app.Button_9.Text = '9';

            % Create Button_00
            app.Button_00 = uibutton(app.UIFigure, 'push');
            app.Button_00.ButtonPushedFcn = createCallbackFcn(app, @Button_00Pushed, true);
            app.Button_00.Position = [69 149 100 22];
            app.Button_00.Text = '00';

            % Create Button_0
            app.Button_0 = uibutton(app.UIFigure, 'push');
            app.Button_0.ButtonPushedFcn = createCallbackFcn(app, @Button_0Pushed, true);
            app.Button_0.Position = [168 149 100 22];
            app.Button_0.Text = '0';

            % Create Button_point
            app.Button_point = uibutton(app.UIFigure, 'push');
            app.Button_point.ButtonPushedFcn = createCallbackFcn(app, @Button_pointPushed, true);
            app.Button_point.Position = [267 149 100 22];
            app.Button_point.Text = '.';

            % Create Button_add
            app.Button_add = uibutton(app.UIFigure, 'push');
            app.Button_add.ButtonPushedFcn = createCallbackFcn(app, @Button_addPushed, true);
            app.Button_add.Position = [379 170 100 22];
            app.Button_add.Text = '+';

            % Create Button_subtract
            app.Button_subtract = uibutton(app.UIFigure, 'push');
            app.Button_subtract.ButtonPushedFcn = createCallbackFcn(app, @Button_subtractPushed, true);
            app.Button_subtract.Position = [379 191 100 22];
            app.Button_subtract.Text = '-';

            % Create Button_mutiply
            app.Button_mutiply = uibutton(app.UIFigure, 'push');
            app.Button_mutiply.ButtonPushedFcn = createCallbackFcn(app, @Button_mutiplyPushed, true);
            app.Button_mutiply.Position = [379 212 100 22];
            app.Button_mutiply.Text = '×';

            % Create Button_divide
            app.Button_divide = uibutton(app.UIFigure, 'push');
            app.Button_divide.ButtonPushedFcn = createCallbackFcn(app, @Button_dividePushed, true);
            app.Button_divide.Position = [379 233 100 22];
            app.Button_divide.Text = '÷';

            % Create Button_bracket
            app.Button_bracket = uibutton(app.UIFigure, 'push');
            app.Button_bracket.ButtonPushedFcn = createCallbackFcn(app, @Button_bracketPushed, true);
            app.Button_bracket.Position = [267 233 100 22];
            app.Button_bracket.Text = '( )';

            % Create Button_Backspace
            app.Button_Backspace = uibutton(app.UIFigure, 'push');
            app.Button_Backspace.ButtonPushedFcn = createCallbackFcn(app, @Button_BackspacePushed, true);
            app.Button_Backspace.BackgroundColor = [0.302 0.7451 0.9333];
            app.Button_Backspace.Position = [168 233 100 22];
            app.Button_Backspace.Text = '←Backspace';

            % Create Button_equal
            app.Button_equal = uibutton(app.UIFigure, 'push');
            app.Button_equal.ButtonPushedFcn = createCallbackFcn(app, @Button_equalPushed, true);
            app.Button_equal.BackgroundColor = [0.4667 0.6745 0.1882];
            app.Button_equal.Position = [379 149 198 22];
            app.Button_equal.Text = '=';

            % Create ACButton
            app.ACButton = uibutton(app.UIFigure, 'push');
            app.ACButton.ButtonPushedFcn = createCallbackFcn(app, @ACButtonPushed, true);
            app.ACButton.BackgroundColor = [1 0 0];
            app.ACButton.FontColor = [1 1 1];
            app.ACButton.Position = [69 233 100 22];
            app.ACButton.Text = 'AC';

            % Create StandardCalculatorLabel
            app.StandardCalculatorLabel = uilabel(app.UIFigure);
            app.StandardCalculatorLabel.HorizontalAlignment = 'center';
            app.StandardCalculatorLabel.WordWrap = 'on';
            app.StandardCalculatorLabel.FontName = 'Formula1 Display Bold';
            app.StandardCalculatorLabel.FontSize = 30;
            app.StandardCalculatorLabel.Position = [225 391 274 39];
            app.StandardCalculatorLabel.Text = 'Standard  Calculator';

            % Create Button_mpower
            app.Button_mpower = uibutton(app.UIFigure, 'push');
            app.Button_mpower.ButtonPushedFcn = createCallbackFcn(app, @Button_mpowerPushed, true);
            app.Button_mpower.Position = [478 233 100 22];
            app.Button_mpower.Text = 'xⁿ';

            % Create Button_sqrt
            app.Button_sqrt = uibutton(app.UIFigure, 'push');
            app.Button_sqrt.ButtonPushedFcn = createCallbackFcn(app, @Button_sqrtPushed, true);
            app.Button_sqrt.Position = [477 212 100 22];
            app.Button_sqrt.Text = '√x';

            % Create Button_reciprocal
            app.Button_reciprocal = uibutton(app.UIFigure, 'push');
            app.Button_reciprocal.ButtonPushedFcn = createCallbackFcn(app, @Button_reciprocalPushed, true);
            app.Button_reciprocal.Position = [477 191 100 22];
            app.Button_reciprocal.Text = '¹/x';

            % Create Button_percent
            app.Button_percent = uibutton(app.UIFigure, 'push');
            app.Button_percent.ButtonPushedFcn = createCallbackFcn(app, @Button_percentPushed, true);
            app.Button_percent.Position = [477 170 100 22];
            app.Button_percent.Text = '%';

            % Create DebugButton
            app.DebugButton = uibutton(app.UIFigure, 'state');
            app.DebugButton.ValueChangedFcn = createCallbackFcn(app, @Debug, true);
            app.DebugButton.Text = '标准计算器';
            app.DebugButton.FontName = '等线';
            app.DebugButton.FontSize = 5;
            app.DebugButton.FontColor = [0.651 0.651 0.651];
            app.DebugButton.Position = [70 71 100 22];

            % Create DebugMATLABLabel
            app.DebugMATLABLabel = uilabel(app.UIFigure);
            app.DebugMATLABLabel.FontColor = [0.8706 0.8706 0.8706];
            app.DebugMATLABLabel.Position = [182 51 235 42];
            app.DebugMATLABLabel.Text = {'←Debug 按钮'; '　相关数据请于MATLAB主程序工作区查看'; '　目前，该按钮的使命已完成'};

            % Create InputEquationLabel
            app.InputEquationLabel = uilabel(app.UIFigure);
            app.InputEquationLabel.HorizontalAlignment = 'right';
            app.InputEquationLabel.FontSize = 15;
            app.InputEquationLabel.Position = [69 309 65 22];
            app.InputEquationLabel.Text = 'Equation';

            % Create FormulaText
            app.FormulaText = uitextarea(app.UIFigure);
            app.FormulaText.FontSize = 15;
            app.FormulaText.Position = [149 273 426 60];
            app.FormulaText.Value = {'0'};

            % Create ResultsText
            app.ResultsText = uitextarea(app.UIFigure);
            app.ResultsText.HorizontalAlignment = 'right';
            app.ResultsText.FontSize = 20;
            app.ResultsText.FontColor = [0.651 0.651 0.651];
            app.ResultsText.Position = [430 332 145 29];

            % Create ResultLabel
            app.ResultLabel = uilabel(app.UIFigure);
            app.ResultLabel.HorizontalAlignment = 'right';
            app.ResultLabel.FontSize = 15;
            app.ResultLabel.FontColor = [0.651 0.651 0.651];
            app.ResultLabel.Position = [367 336 48 22];
            app.ResultLabel.Text = 'Result';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = standard_calculator

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end
