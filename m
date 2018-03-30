From: Eric Huang <jinhuieric.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerply: fix power reading on Fiji
Date: Fri, 30 Mar 2018 11:08:53 -0400
Message-ID: <fadc4a94-3362-f048-a413-35ba875e7731@amd.com>
References: <1522351312-27566-1-git-send-email-JinHuiEric.Huang@amd.com>
 <BN6PR12MB18093357508F0377D97DCBFCF7A20@BN6PR12MB1809.namprd12.prod.outlook.com>
 <cb84765d-f9bd-f3d0-973f-13ff15f5b13d@amd.com>
 <BN6PR12MB18094AA1EA63372A78E03B17F7A20@BN6PR12MB1809.namprd12.prod.outlook.com>
 <d34a1d2c-7f3d-4722-8f80-1ae0cba18df0@amd.com>
 <BN6PR12MB1809CD35DDC84D955B4C847DF7A20@BN6PR12MB1809.namprd12.prod.outlook.com>
 <CY4PR12MB1687D41D30442A05D1663E1FFBA10@CY4PR12MB1687.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0598317337=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1687D41D30442A05D1663E1FFBA10-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0598317337==
Content-Type: multipart/alternative;
 boundary="------------F99B255D21A6DB3946648E01"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------F99B255D21A6DB3946648E01
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

I reproduced the issue reported by customer. When running a HSA test, 
repeating to read power via AGT and rocm-smi (driver). We set power 
limit of 175w to a Fiji. The results from AGT are all below 175w and the 
results from driver have a lot of value over 175, some are almost double 
of 175. So your test cases are not enough, you should run some OCL and 
HSA tests.

I have tested 100ms and 150ms, the results still have some wrong. 200ms 
is good. It seems more sampling more accurate.

The theoretical period is quoted from smu team and tools team. AGT is 
using more than 1sec of period. I don't know how long one cycle of dpm 
task is, but is sampling based on dpm task cycle? we should ask smu team 
to confirm.

Regards,
Eric


On 03/30/2018 03:52 AM, Zhu, Rex wrote:
>
> >> Power value is wrong reported by customer.
>
> Hi Eric,
>
> What is the wrong value customer reported?
>
> In my end, there is no big difference between 20ms and 200ms or 2s. I 
> tested on Fiji/Tonga when gpu idle or running fullscreen glxgears.
>
> why need 50 ms?
>
> How long does the SMU core take to complete one cycle of dpm tasks? I 
> tested, it is less than 1 ms.
>
>
> So when we delay 20 ms, The output is the average value of more than 
> 20 sampling.
>
> Best Regards
>
> Rex
>
> *From:*amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] *On 
> Behalf Of *Deucher, Alexander
> *Sent:* Friday, March 30, 2018 4:00 AM
> *To:* Huang, JinHuiEric; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH] drm/amd/powerply: fix power reading on Fiji
>
> Fiji and tonga I presume.  The current code seems to work fine on 
> tonga at least.
>
> Alex
>
> ------------------------------------------------------------------------
>
> *From:*Huang, JinHuiEric
> *Sent:* Thursday, March 29, 2018 3:58:42 PM
> *To:* Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org 
> <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> *Subject:* Re: [PATCH] drm/amd/powerply: fix power reading on Fiji
>
> Right. This is only for Fiji. We should use PPSMC_MSG_GetCurrPkgPwr on 
> poaris.
>
> Thanks,
>
> Eric
>
> On 2018-03-29 03:54 PM, Deucher, Alexander wrote:
>
>     Thanks. Patch is:
>
>     Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>     <mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>
>     Care to make a patch to use PPSMC_MSG_GetCurrPkgPwr on polaris
>     boards so we don't have to worry about the delay on them?
>
>     Alex
>
>     ------------------------------------------------------------------------
>
>     *From:*Huang, JinHuiEric
>     *Sent:* Thursday, March 29, 2018 3:40:22 PM
>     *To:* Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>     <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>     *Subject:* Re: [PATCH] drm/amd/powerply: fix power reading on Fiji
>
>     This reading method is shared with AGT tool only on Fiji, because
>     SMU FW doesn't support PPSMC_MSG_GetCurrPkgPwr message on Fiji.
>     But since polaris10, PPSMC_MSG_GetCurrPkgPwr has been supported.
>     We also use PPSMC_MSG_GetCurrPkgPwr on vega which SMU FW control
>     sampling period. Driver will not care about it.
>
>     Eric
>
>     On 2018-03-29 03:31 PM, Deucher, Alexander wrote:
>
>         Do you know what the sampling period is on vega?  We should
>         try and be consistent.  How about making this selectable via
>         hwmon:
>
>         power[1-*]_average_interval       Power use averaging
>         interval.  A poll
>
>                                   notification is sent to this file if the
>
>                                   hardware changes the averaging interval.
>
>                                   Unit: milliseconds
>
>                                   RW
>
>         power[1-*]_average_interval_max   Maximum power use averaging
>         interval
>
>                                   Unit: milliseconds
>
>                                   RO
>
>         power[1-*]_average_interval_min   Minimum power use averaging
>         interval
>
>                                   Unit: milliseconds
>
>                                   RO
>
>         Then the user can select the interval they want.
>
>         Alex
>
>         ------------------------------------------------------------------------
>
>         *From:*amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>         <mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of
>         Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
>         <mailto:JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
>         *Sent:* Thursday, March 29, 2018 3:21:52 PM
>         *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>         <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>         *Cc:* Huang, JinHuiEric
>         *Subject:* [PATCH] drm/amd/powerply: fix power reading on Fiji
>
>         Power value is wrong reported by customer. It is a regression by
>
>         commit a7c7bc4c0c47eaac77b8fa92f0672032df7f4254
>         Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> <mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
>         Date:   Mon Mar 27 15:32:59 2017 +0800
>
>             drm/amd/powerplay: reduce sample period time
>
>             for power readings.
>
>             Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
>         <mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
>             Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>         <mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>             Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>         <mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>
>         The theoretical sampling period is from 50ms to 4sec, original
>         2sec
>         is long but correct, and 20ms is too short. change it to more
>         reasonable 200ms.
>
>         Signed-off-by: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
>         <mailto:JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
>         ---
>          drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 3 ++-
>          1 file changed, 2 insertions(+), 1 deletion(-)
>
>         diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>         b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>         index a03b7fe..7631d80 100644
>         --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>         +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>         @@ -3377,7 +3377,8 @@ static int smu7_get_gpu_power(struct
>         pp_hwmgr *hwmgr,
>                                  "Failed to start pm status log!",
>                                  return -1);
>
>         -       msleep_interruptible(20);
>         +       /* Sampling period from 50ms to 4sec */
>         +       msleep_interruptible(200);
>
>         PP_ASSERT_WITH_CODE(!smum_send_msg_to_smc(hwmgr,
>         PPSMC_MSG_PmStatusLogSample),
>         -- 
>         2.7.4
>
>         _______________________________________________
>         amd-gfx mailing list
>         amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>         <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>         https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>


--------------F99B255D21A6DB3946648E01
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    I reproduced the issue reported by customer. When running a HSA
    test, repeating to read power via AGT and rocm-smi (driver). We set
    power limit of 175w to a Fiji. The results from AGT are all below
    175w and the results from driver have a lot of value over 175, some
    are almost double of 175. So your test cases are not enough, you
    should run some OCL and HSA tests.<br>
    <br>
    I have tested 100ms and 150ms, the results still have some wrong.
    200ms is good. It seems more sampling more accurate.<br>
    <br>
    The theoretical period is quoted from smu team and tools team. AGT
    is using more than 1sec of period. I don't know how long one cycle
    of dpm task is, but is sampling based on dpm task cycle? we should
    ask smu team to confirm.<br>
    <br>
    Regards,<br>
    Eric<br>
    <br>
    <br>
    <div class="moz-cite-prefix">On 03/30/2018 03:52 AM, Zhu, Rex wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CY4PR12MB1687D41D30442A05D1663E1FFBA10-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Word 14 (filtered
        medium)">
      <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
      <style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Times New Roman","serif";}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Courier New";}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:SimSun;}
span.EmailStyle22
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal"><span style="font-size:11.0pt" lang="EN-US">&gt;&gt;
            Power value is wrong reported by customer.<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt" lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt" lang="EN-US">Hi
            Eric,<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt" lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt" lang="EN-US">What
            is the wrong value customer reported?<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt" lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt" lang="EN-US">In
            my end, there is no big difference between 20ms and 200ms or
            2s. I tested on Fiji/Tonga when gpu idle or running
            fullscreen glxgears.<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt" lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt" lang="EN-US">why
            need 50 ms? <o:p>
            </o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt" lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt" lang="EN-US">How
            long does the SMU core take to complete one cycle of dpm
            tasks? I tested, it is less than 1 ms.<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt" lang="EN-US"><o:p><br>
            </o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt" lang="EN-US">So
            when we delay 20 ms, The output is the average value of more
            than 20 sampling.<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt" lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt" lang="EN-US">Best
            Regards<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt" lang="EN-US">Rex<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt" lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"
            lang="EN-US"><o:p> </o:p></span></p>
        <div>
          <div style="border:none;border-top:solid #B5C4DF
            1.0pt;padding:3.0pt 0cm 0cm 0cm">
            <p class="MsoNormal"><b><span
style="font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"
                  lang="EN-US">From:</span></b><span
style="font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"
                lang="EN-US"> amd-gfx
                [<a class="moz-txt-link-freetext" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>]
                <b>On Behalf Of </b>Deucher, Alexander<br>
                <b>Sent:</b> Friday, March 30, 2018 4:00 AM<br>
                <b>To:</b> Huang, JinHuiEric;
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <b>Subject:</b> Re: [PATCH] drm/amd/powerply: fix power
                reading on Fiji<o:p></o:p></span></p>
          </div>
        </div>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <div id="divtagdefaultwrapper">
          <p><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"
              lang="EN-US">Fiji and tonga I presume.  The current code
              seems to work fine on tonga at least.<o:p></o:p></span></p>
          <p><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"
              lang="EN-US"><o:p> </o:p></span></p>
          <p><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"
              lang="EN-US">Alex<o:p></o:p></span></p>
        </div>
        <div class="MsoNormal" style="text-align:center" align="center"><span
            lang="EN-US">
            <hr size="2" align="center" width="98%">
          </span></div>
        <div id="divRplyFwdMsg">
          <p class="MsoNormal"><b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"
                lang="EN-US">From:</span></b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"
              lang="EN-US"> Huang, JinHuiEric<br>
              <b>Sent:</b> Thursday, March 29, 2018 3:58:42 PM<br>
              <b>To:</b> Deucher, Alexander; <a
                href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <b>Subject:</b> Re: [PATCH] drm/amd/powerply: fix power
              reading on Fiji</span><span lang="EN-US">
              <o:p></o:p></span></p>
          <div>
            <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
          </div>
        </div>
        <div>
          <p style="background:white"><span lang="EN-US">Right. This is
              only for Fiji. We should use PPSMC_MSG_GetCurrPkgPwr on
              poaris.<o:p></o:p></span></p>
          <p style="background:white"><span lang="EN-US"><o:p> </o:p></span></p>
          <p style="background:white"><span lang="EN-US">Thanks,<o:p></o:p></span></p>
          <p style="background:white"><span lang="EN-US">Eric<o:p></o:p></span></p>
          <p class="MsoNormal" style="background:white"><span
              lang="EN-US"><o:p> </o:p></span></p>
          <div>
            <p class="MsoNormal" style="background:white"><span
                lang="EN-US">On 2018-03-29 03:54 PM, Deucher, Alexander
                wrote:<o:p></o:p></span></p>
          </div>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <div id="x_divtagdefaultwrapper">
              <p style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"
                  lang="EN-US">Thanks. Patch is:<o:p></o:p></span></p>
              <p style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"
                  lang="EN-US">Acked-by: Alex Deucher
                  <a href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><o:p></o:p></span></p>
              <p style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"
                  lang="EN-US">Care to make a patch to use
                  <span style="background:white">PPSMC_MSG_GetCurrPkgPwr
                  </span>on polaris boards so we don't have to worry
                  about the delay on them?<o:p></o:p></span></p>
              <p style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"
                  lang="EN-US"><o:p> </o:p></span></p>
              <p style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"
                  lang="EN-US">Alex<o:p></o:p></span></p>
            </div>
            <div class="MsoNormal"
              style="text-align:center;background:white" align="center">
              <span lang="EN-US">
                <hr size="2" align="center" width="98%">
              </span></div>
            <div id="x_divRplyFwdMsg">
              <p class="MsoNormal" style="background:white"><b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"
                    lang="EN-US">From:</span></b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"
                  lang="EN-US"> Huang, JinHuiEric<br>
                  <b>Sent:</b> Thursday, March 29, 2018 3:40:22 PM<br>
                  <b>To:</b> Deucher, Alexander; <a
                    href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                    moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                  <b>Subject:</b> Re: [PATCH] drm/amd/powerply: fix
                  power reading on Fiji</span><span lang="EN-US">
                  <o:p></o:p></span></p>
              <div>
                <p class="MsoNormal" style="background:white"><span
                    lang="EN-US"> <o:p></o:p></span></p>
              </div>
            </div>
            <div>
              <p style="background:white"><span lang="EN-US">This
                  reading method is shared with AGT tool only on Fiji,
                  because SMU FW doesn't support PPSMC_MSG_GetCurrPkgPwr
                  message on Fiji. But since polaris10,
                  PPSMC_MSG_GetCurrPkgPwr has been supported. We also
                  use PPSMC_MSG_GetCurrPkgPwr on vega which SMU FW
                  control sampling period. Driver will not care about
                  it.<o:p></o:p></span></p>
              <p style="background:white"><span lang="EN-US"><o:p> </o:p></span></p>
              <p style="background:white"><span lang="EN-US">Eric<o:p></o:p></span></p>
              <p class="MsoNormal" style="background:white"><span
                  lang="EN-US"><o:p> </o:p></span></p>
              <div>
                <p class="MsoNormal" style="background:white"><span
                    lang="EN-US">On 2018-03-29 03:31 PM, Deucher,
                    Alexander wrote:<o:p></o:p></span></p>
              </div>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <div id="x_x_divtagdefaultwrapper">
                  <p style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"
                      lang="EN-US">Do you know what the sampling period
                      is on vega?  We should try and be consistent.  How
                      about making this selectable via hwmon:<o:p></o:p></span></p>
                  <pre style="background:white"><span style="color:black" lang="EN-US">power[1-*]_average_interval       Power use averaging interval.  A poll<o:p></o:p></span></pre>
                  <pre style="background:white"><span style="color:black" lang="EN-US">                          notification is sent to this file if the<o:p></o:p></span></pre>
                  <pre style="background:white"><span style="color:black" lang="EN-US">                          hardware changes the averaging interval.<o:p></o:p></span></pre>
                  <pre style="background:white"><span style="color:black" lang="EN-US">                          Unit: milliseconds<o:p></o:p></span></pre>
                  <pre style="background:white"><span style="color:black" lang="EN-US">                          RW<o:p></o:p></span></pre>
                  <pre style="background:white"><span style="color:black" lang="EN-US"><o:p> </o:p></span></pre>
                  <pre style="background:white"><span style="color:black" lang="EN-US">power[1-*]_average_interval_max   Maximum power use averaging interval<o:p></o:p></span></pre>
                  <pre style="background:white"><span style="color:black" lang="EN-US">                          Unit: milliseconds<o:p></o:p></span></pre>
                  <pre style="background:white"><span style="color:black" lang="EN-US">                          RO<o:p></o:p></span></pre>
                  <pre style="background:white"><span style="color:black" lang="EN-US"><o:p> </o:p></span></pre>
                  <pre style="background:white"><span style="color:black" lang="EN-US">power[1-*]_average_interval_min   Minimum power use averaging interval<o:p></o:p></span></pre>
                  <pre style="background:white"><span style="color:black" lang="EN-US">                          Unit: milliseconds<o:p></o:p></span></pre>
                  <pre style="background:white"><span style="color:black" lang="EN-US">                          RO<o:p></o:p></span></pre>
                  <p style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"
                      lang="EN-US"><o:p> </o:p></span></p>
                  <p style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"
                      lang="EN-US">Then the user can select the interval
                      they want.<o:p></o:p></span></p>
                  <p style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"
                      lang="EN-US"><o:p> </o:p></span></p>
                  <p style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"
                      lang="EN-US">Alex<o:p></o:p></span></p>
                </div>
                <div class="MsoNormal"
                  style="text-align:center;background:white"
                  align="center">
                  <span lang="EN-US">
                    <hr size="2" align="center" width="98%">
                  </span></div>
                <div id="x_x_divRplyFwdMsg">
                  <p class="MsoNormal" style="background:white"><b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"
                        lang="EN-US">From:</span></b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"
                      lang="EN-US"> amd-gfx
                      <a
                        href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                        moz-do-not-send="true">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a>
                      on behalf of Eric Huang
                      <a href="mailto:JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org"
                        moz-do-not-send="true">&lt;JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                      <b>Sent:</b> Thursday, March 29, 2018 3:21:52 PM<br>
                      <b>To:</b> <a
                        href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                        moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                      <b>Cc:</b> Huang, JinHuiEric<br>
                      <b>Subject:</b> [PATCH] drm/amd/powerply: fix
                      power reading on Fiji</span><span lang="EN-US">
                      <o:p></o:p></span></p>
                  <div>
                    <p class="MsoNormal" style="background:white"><span
                        lang="EN-US"> <o:p></o:p></span></p>
                  </div>
                </div>
                <div>
                  <div>
                    <p class="MsoNormal" style="background:white"><span
                        style="font-size:11.0pt" lang="EN-US">Power
                        value is wrong reported by customer. It is a
                        regression by<br>
                        <br>
                        commit a7c7bc4c0c47eaac77b8fa92f0672032df7f4254<br>
                        Author: Rex Zhu <a
                          href="mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org"
                          moz-do-not-send="true">&lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                        Date:   Mon Mar 27 15:32:59 2017 +0800<br>
                        <br>
                            drm/amd/powerplay: reduce sample period time<br>
                        <br>
                            for power readings.<br>
                        <br>
                            Signed-off-by: Rex Zhu <a
                          href="mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org"
                          moz-do-not-send="true">&lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                            Reviewed-by: Alex Deucher <a
                          href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org"
                          moz-do-not-send="true">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                            Signed-off-by: Alex Deucher <a
                          href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org"
                          moz-do-not-send="true">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                        <br>
                        The theoretical sampling period is from 50ms to
                        4sec, original 2sec<br>
                        is long but correct, and 20ms is too short.
                        change it to more<br>
                        reasonable 200ms.<br>
                        <br>
                        Signed-off-by: Eric Huang <a
                          href="mailto:JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org"
                          moz-do-not-send="true">&lt;JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                        ---<br>
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 3 ++-<br>
                         1 file changed, 2 insertions(+), 1 deletion(-)<br>
                        <br>
                        diff --git
                        a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
                        index a03b7fe..7631d80 100644<br>
                        ---
                        a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
                        +++
                        b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
                        @@ -3377,7 +3377,8 @@ static int
                        smu7_get_gpu_power(struct pp_hwmgr *hwmgr,<br>
                                                 "Failed to start pm
                        status log!",<br>
                                                 return -1);<br>
                         <br>
                        -       msleep_interruptible(20);<br>
                        +       /* Sampling period from 50ms to 4sec */<br>
                        +       msleep_interruptible(200);<br>
                         <br>
                                
                        PP_ASSERT_WITH_CODE(!smum_send_msg_to_smc(hwmgr,<br>
                                                
                        PPSMC_MSG_PmStatusLogSample),<br>
                        -- <br>
                        2.7.4<br>
                        <br>
                        _______________________________________________<br>
                        amd-gfx mailing list<br>
                        <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                          moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                        <a
                          href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                          moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></span></p>
                  </div>
                </div>
              </blockquote>
              <p class="MsoNormal" style="background:white"><span
                  lang="EN-US"><o:p> </o:p></span></p>
            </div>
          </blockquote>
          <p class="MsoNormal" style="background:white"><span
              lang="EN-US"><o:p> </o:p></span></p>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------F99B255D21A6DB3946648E01--

--===============0598317337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0598317337==--
