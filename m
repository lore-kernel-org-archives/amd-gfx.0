From: Eric Huang <jinhuieric.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerply: fix power reading on Fiji
Date: Thu, 29 Mar 2018 15:58:42 -0400
Message-ID: <d34a1d2c-7f3d-4722-8f80-1ae0cba18df0@amd.com>
References: <1522351312-27566-1-git-send-email-JinHuiEric.Huang@amd.com>
 <BN6PR12MB18093357508F0377D97DCBFCF7A20@BN6PR12MB1809.namprd12.prod.outlook.com>
 <cb84765d-f9bd-f3d0-973f-13ff15f5b13d@amd.com>
 <BN6PR12MB18094AA1EA63372A78E03B17F7A20@BN6PR12MB1809.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0918850747=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB18094AA1EA63372A78E03B17F7A20-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0918850747==
Content-Type: multipart/alternative;
 boundary="------------61365BF33384272B1A1A8390"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------61365BF33384272B1A1A8390
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Right. This is only for Fiji. We should use PPSMC_MSG_GetCurrPkgPwr on 
poaris.


Thanks,

Eric


On 2018-03-29 03:54 PM, Deucher, Alexander wrote:
>
> Thanks. Patch is:
>
> Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>
> Care to make a patch to use PPSMC_MSG_GetCurrPkgPwr on polaris boards 
> so we don't have to worry about the delay on them?
>
>
> Alex
>
> ------------------------------------------------------------------------
> *From:* Huang, JinHuiEric
> *Sent:* Thursday, March 29, 2018 3:40:22 PM
> *To:* Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH] drm/amd/powerply: fix power reading on Fiji
>
> This reading method is shared with AGT tool only on Fiji, because SMU 
> FW doesn't support PPSMC_MSG_GetCurrPkgPwr message on Fiji. But since 
> polaris10, PPSMC_MSG_GetCurrPkgPwr has been supported. We also use 
> PPSMC_MSG_GetCurrPkgPwr on vega which SMU FW control sampling period. 
> Driver will not care about it.
>
>
> Eric
>
>
> On 2018-03-29 03:31 PM, Deucher, Alexander wrote:
>>
>> Do you know what the sampling period is on vega?  We should try and 
>> be consistent.  How about making this selectable via hwmon:
>>
>> power[1-*]_average_interval	Power use averaging interval.  A poll
>> 				notification is sent to this file if the
>> 				hardware changes the averaging interval.
>> 				Unit: milliseconds
>> 				RW
>>
>> power[1-*]_average_interval_max	Maximum power use averaging interval
>> 				Unit: milliseconds
>> 				RO
>>
>> power[1-*]_average_interval_min	Minimum power use averaging interval
>> 				Unit: milliseconds
>> 				RO
>>
>>
>> Then the user can select the interval they want.
>>
>>
>> Alex
>>
>> ------------------------------------------------------------------------
>> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> 
>> <mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Eric 
>> Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org> <mailto:JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
>> *Sent:* Thursday, March 29, 2018 3:21:52 PM
>> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org 
>> <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>> *Cc:* Huang, JinHuiEric
>> *Subject:* [PATCH] drm/amd/powerply: fix power reading on Fiji
>> Power value is wrong reported by customer. It is a regression by
>>
>> commit a7c7bc4c0c47eaac77b8fa92f0672032df7f4254
>> Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> <mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
>> Date:   Mon Mar 27 15:32:59 2017 +0800
>>
>>     drm/amd/powerplay: reduce sample period time
>>
>>     for power readings.
>>
>>     Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> <mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
>>     Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org> 
>> <mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>>     Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org> 
>> <mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>>
>> The theoretical sampling period is from 50ms to 4sec, original 2sec
>> is long but correct, and 20ms is too short. change it to more
>> reasonable 200ms.
>>
>> Signed-off-by: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org> 
>> <mailto:JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
>> ---
>>  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c 
>> b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>> index a03b7fe..7631d80 100644
>> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>> @@ -3377,7 +3377,8 @@ static int smu7_get_gpu_power(struct pp_hwmgr 
>> *hwmgr,
>>                          "Failed to start pm status log!",
>>                          return -1);
>>
>> -       msleep_interruptible(20);
>> +       /* Sampling period from 50ms to 4sec */
>> +       msleep_interruptible(200);
>>
>> PP_ASSERT_WITH_CODE(!smum_send_msg_to_smc(hwmgr,
>>                          PPSMC_MSG_PmStatusLogSample),
>> -- 
>> 2.7.4
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>


--------------61365BF33384272B1A1A8390
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Right. This is only for Fiji. We should use
      PPSMC_MSG_GetCurrPkgPwr on poaris.</p>
    <p><br>
    </p>
    <p>Thanks,</p>
    <p>Eric<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 2018-03-29 03:54 PM, Deucher,
      Alexander wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:BN6PR12MB18094AA1EA63372A78E03B17F7A20-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <p style="margin-top:0;margin-bottom:0">Thanks. Patch is:</p>
        <p style="margin-top:0;margin-bottom:0">Acked-by: Alex Deucher
          <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a></p>
        <p style="margin-top:0;margin-bottom:0">Care to make a patch to
          use <span style="background-color:white;">
            PPSMC_MSG_GetCurrPkgPwr </span>on polaris boards so we
          don't have to worry about the delay on them?</p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <p style="margin-top:0;margin-bottom:0">Alex<br>
        </p>
      </div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          face="Calibri, sans-serif" color="#000000"><b>From:</b> Huang,
          JinHuiEric<br>
          <b>Sent:</b> Thursday, March 29, 2018 3:40:22 PM<br>
          <b>To:</b> Deucher, Alexander; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
          <b>Subject:</b> Re: [PATCH] drm/amd/powerply: fix power
          reading on Fiji</font>
        <div> </div>
      </div>
      <div style="background-color:#FFFFFF">
        <p>This reading method is shared with AGT tool only on Fiji,
          because SMU FW doesn't support PPSMC_MSG_GetCurrPkgPwr message
          on Fiji. But since polaris10, PPSMC_MSG_GetCurrPkgPwr has been
          supported. We also use PPSMC_MSG_GetCurrPkgPwr on vega which
          SMU FW control sampling period. Driver will not care about it.</p>
        <p><br>
        </p>
        <p>Eric<br>
        </p>
        <br>
        <div class="x_moz-cite-prefix">On 2018-03-29 03:31 PM, Deucher,
          Alexander wrote:<br>
        </div>
        <blockquote type="cite">
          <style type="text/css" style="display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
          <div id="x_divtagdefaultwrapper" dir="ltr"
            style="font-size:12pt; color:#000000;
            font-family:Calibri,Helvetica,sans-serif">
            <p style="margin-top:0; margin-bottom:0">Do you know what
              the sampling period is on vega?  We should try and be
              consistent.  How about making this selectable via hwmon:</p>
            <pre>power[1-*]_average_interval	Power use averaging interval.  A poll
				notification is sent to this file if the
				hardware changes the averaging interval.
				Unit: milliseconds
				RW

power[1-*]_average_interval_max	Maximum power use averaging interval
				Unit: milliseconds
				RO

power[1-*]_average_interval_min	Minimum power use averaging interval
				Unit: milliseconds
				RO</pre>
            <p style="margin-top:0; margin-bottom:0"><br>
            </p>
            <p style="margin-top:0; margin-bottom:0">Then the user can
              select the interval they want.<br>
            </p>
            <p style="margin-top:0; margin-bottom:0"><br>
            </p>
            <p style="margin-top:0; margin-bottom:0">Alex<br>
            </p>
          </div>
          <hr tabindex="-1" style="display:inline-block; width:98%">
          <div id="x_divRplyFwdMsg" dir="ltr"><font
              style="font-size:11pt" face="Calibri, sans-serif"
              color="#000000"><b>From:</b> amd-gfx
              <a class="x_moz-txt-link-rfc2396E"
                href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                moz-do-not-send="true">
                &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on
              behalf of Eric Huang <a class="x_moz-txt-link-rfc2396E"
                href="mailto:JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org"
                moz-do-not-send="true">
                &lt;JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              <b>Sent:</b> Thursday, March 29, 2018 3:21:52 PM<br>
              <b>To:</b> <a class="x_moz-txt-link-abbreviated"
                href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                moz-do-not-send="true">
                amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <b>Cc:</b> Huang, JinHuiEric<br>
              <b>Subject:</b> [PATCH] drm/amd/powerply: fix power
              reading on Fiji</font>
            <div> </div>
          </div>
          <div class="x_BodyFragment"><font size="2"><span
                style="font-size:11pt">
                <div class="x_PlainText">Power value is wrong reported
                  by customer. It is a regression by<br>
                  <br>
                  commit a7c7bc4c0c47eaac77b8fa92f0672032df7f4254<br>
                  Author: Rex Zhu <a class="x_moz-txt-link-rfc2396E"
                    href="mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" moz-do-not-send="true">
                    &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                  Date:   Mon Mar 27 15:32:59 2017 +0800<br>
                  <br>
                      drm/amd/powerplay: reduce sample period time<br>
                  <br>
                      for power readings.<br>
                  <br>
                      Signed-off-by: Rex Zhu <a
                    class="x_moz-txt-link-rfc2396E"
                    href="mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" moz-do-not-send="true">
                    &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                      Reviewed-by: Alex Deucher <a
                    class="x_moz-txt-link-rfc2396E"
                    href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">
                    &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                      Signed-off-by: Alex Deucher <a
                    class="x_moz-txt-link-rfc2396E"
                    href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">
                    &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                  <br>
                  The theoretical sampling period is from 50ms to 4sec,
                  original 2sec<br>
                  is long but correct, and 20ms is too short. change it
                  to more<br>
                  reasonable 200ms.<br>
                  <br>
                  Signed-off-by: Eric Huang <a
                    class="x_moz-txt-link-rfc2396E"
                    href="mailto:JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">
                    &lt;JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                  ---<br>
                   drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 3
                  ++-<br>
                   1 file changed, 2 insertions(+), 1 deletion(-)<br>
                  <br>
                  diff --git
                  a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
                  b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
                  index a03b7fe..7631d80 100644<br>
                  --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
                  +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
                  @@ -3377,7 +3377,8 @@ static int
                  smu7_get_gpu_power(struct pp_hwmgr *hwmgr,<br>
                                           "Failed to start pm status
                  log!",<br>
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
                  <a class="x_moz-txt-link-abbreviated"
                    href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                    moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                  <a
                    href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                    moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
                </div>
              </span></font></div>
        </blockquote>
        <br>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------61365BF33384272B1A1A8390--

--===============0918850747==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0918850747==--
