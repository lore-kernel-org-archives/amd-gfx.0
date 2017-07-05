From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: The amd-stagint-4.11 doen't contain the commit
 ab51ee31dda1a37b473074e402394f879c51d591 in amd-staging-4.9
Date: Wed, 5 Jul 2017 16:06:38 +0200
Message-ID: <e839006f-e5e7-dbf0-08ec-3ee01f884ae3@vodafone.de>
References: <CY4PR12MB112513FA1BFD2E8EDCB4EF858FD40@CY4PR12MB1125.namprd12.prod.outlook.com>
 <BLUPR12MB0449F1803799EB0FFD93EE0B84D40@BLUPR12MB0449.namprd12.prod.outlook.com>
 <CY4PR12MB1653832B883B5257DD3F36B4F7D40@CY4PR12MB1653.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1445567233=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1653832B883B5257DD3F36B4F7D40-rpdhrqHFk06apTa93KjAaQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1445567233==
Content-Type: multipart/alternative;
 boundary="------------D54C84732FB42757A4F93C2C"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------D54C84732FB42757A4F93C2C
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Well the switch over to 4.11 was made in quite a haste while Alex was on 
vacation.

I've did my best to cherry-pick everything over from 4.9 to 4.11, but it 
is entirely possible that the patch was either missed accidentally or 
committed after the switch to 4.11.

Christian.

Am 05.07.2017 um 15:29 schrieb Deucher, Alexander:
>
> I guess it was just missed?  Was it committed before we switched to 
> 4.11? Once we switched to 4.11, all teams are responsible for making 
> sure they land their patches in the current staging branch.
>
> Alex
>
> *From:*Liu, Monk
> *Sent:* Tuesday, July 04, 2017 11:55 PM
> *To:* Deng, Emily; Deucher, Alexander
> *Cc:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* RE: The amd-stagint-4.11 doen't contain the commit 
> ab51ee31dda1a37b473074e402394f879c51d591 in amd-staging-4.9
>
> + amd-gfx
>
> We really need to understand why this commit is not shown in 4.11 
> staging, because we worry other patches may meet same issue, and cause 
> regression
>
> BR Monk
>
> *From:* Deng, Emily
> *Sent:* Tuesday, July 04, 2017 11:31 PM
> *To:* Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org 
> <mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>>; Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org 
> <mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org>>
> *Subject:* The amd-stagint-4.11 doen't contain the commit 
> ab51ee31dda1a37b473074e402394f879c51d591 in amd-staging-4.9
>
> Hi Alex,
>
>      Monk has submitted a commit 
> ab51ee31dda1a37b473074e402394f879c51d591 in amd-staging-4.9, but 
> amd-staging-4.11 doesn’t contain it.
>
>      So is there any reason to prevent the commit being port to 
> amd-staging-4.11? Or just missed this commit?
>
> *Best Wishes,*
>
> *Emily Deng**//*
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------D54C84732FB42757A4F93C2C
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Well the switch over to 4.11 was made
      in quite a haste while Alex was on vacation.<br>
      <br>
      I've did my best to cherry-pick everything over from 4.9 to 4.11,
      but it is entirely possible that the patch was either missed
      accidentally or committed after the switch to 4.11.<br>
      <br>
      Christian.<br>
      <br>
      Am 05.07.2017 um 15:29 schrieb Deucher, Alexander:<br>
    </div>
    <blockquote type="cite"
cite="mid:CY4PR12MB1653832B883B5257DD3F36B4F7D40-rpdhrqHFk06apTa93KjAaQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <meta name="Generator" content="Microsoft Word 14 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:\4EFF\5B8B;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal"><span style="color:#1F497D">I guess it was
            just missed?  Was it committed before we switched to 4.11? 
            Once we switched to 4.11, all teams are responsible for
            making sure they land their patches in the current staging
            branch.<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="color:#1F497D"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span style="color:#1F497D">Alex<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="color:#1F497D"><o:p> </o:p></span></p>
        <div style="border:none;border-left:solid blue 1.5pt;padding:0in
          0in 0in 4.0pt">
          <div>
            <div style="border:none;border-top:solid #B5C4DF
              1.0pt;padding:3.0pt 0in 0in 0in">
              <p class="MsoNormal"><b><span
style="font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span
style="font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;">
                  Liu, Monk
                  <br>
                  <b>Sent:</b> Tuesday, July 04, 2017 11:55 PM<br>
                  <b>To:</b> Deng, Emily; Deucher, Alexander<br>
                  <b>Cc:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                  <b>Subject:</b> RE: The amd-stagint-4.11 doen't
                  contain the commit
                  ab51ee31dda1a37b473074e402394f879c51d591 in
                  amd-staging-4.9
                  <o:p></o:p></span></p>
            </div>
          </div>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p class="MsoNormal"><span style="color:#1F497D">+ amd-gfx<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="color:#1F497D"><o:p> </o:p></span></p>
          <p class="MsoNormal"><span style="color:#1F497D">We really
              need to understand why this commit is not shown in 4.11
              staging, because we worry other patches may meet same
              issue, and cause regression
              <o:p></o:p></span></p>
          <p class="MsoNormal"><span style="color:#1F497D"><o:p> </o:p></span></p>
          <p class="MsoNormal"><span style="color:#1F497D">BR Monk<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="color:#1F497D"><o:p> </o:p></span></p>
          <div>
            <div style="border:none;border-top:solid #E1E1E1
              1.0pt;padding:3.0pt 0in 0in 0in">
              <p class="MsoNormal"><b>From:</b> Deng, Emily <br>
                <b>Sent:</b> Tuesday, July 04, 2017 11:31 PM<br>
                <b>To:</b> Deucher, Alexander &lt;<a
                  href="mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org"
                  moz-do-not-send="true">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;;
                Liu, Monk &lt;<a href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org"
                  moz-do-not-send="true">Monk.Liu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
                <b>Subject:</b> The amd-stagint-4.11 doen't contain the
                commit ab51ee31dda1a37b473074e402394f879c51d591 in
                amd-staging-4.9
                <o:p></o:p></p>
            </div>
          </div>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p class="MsoNormal">Hi Alex,<o:p></o:p></p>
          <p class="MsoNormal">     Monk has submitted a commit
            ab51ee31dda1a37b473074e402394f879c51d591 in amd-staging-4.9,
            but amd-staging-4.11 doesn’t contain it.
            <o:p></o:p></p>
          <p class="MsoNormal">     So is there any reason to prevent
            the commit being port to amd-staging-4.11? Or just missed
            this commit?<o:p></o:p></p>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p class="MsoNormal"><b><span
                style="font-size:9.0pt;font-family:&quot;Times New
                Roman&quot;,&quot;serif&quot;">Best Wishes,<o:p></o:p></span></b></p>
          <p class="MsoNormal"><b><span
                style="font-size:9.0pt;font-family:&quot;Times New
                Roman&quot;,&quot;serif&quot;">Emily Deng</span></b><b><i><span
                  style="font-size:12.0pt;font-family:\4EFF\5B8B"><o:p></o:p></span></i></b></p>
          <p class="MsoNormal"><o:p> </o:p></p>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------D54C84732FB42757A4F93C2C--

--===============1445567233==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1445567233==--
