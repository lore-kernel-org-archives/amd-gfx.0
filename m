From: Eric Huang <jinhuieric.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amd/pp: Refine get_gpu_power for VI
Date: Wed, 4 Apr 2018 12:00:02 -0400
Message-ID: <dfcb5127-c6ad-2a09-793e-42ca3cdcff1d@amd.com>
References: <1522830304-15505-1-git-send-email-Rex.Zhu@amd.com>
 <1522830304-15505-2-git-send-email-Rex.Zhu@amd.com>
 <a3566d2f-4b35-00b4-1df1-ab50076f704c@amd.com>
 <CY4PR12MB1687C34CD0753343A795544CFBA40@CY4PR12MB1687.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1886412757=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1687C34CD0753343A795544CFBA40-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1886412757==
Content-Type: multipart/alternative;
 boundary="------------73053F9E381F4509CD402EEC"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------73053F9E381F4509CD402EEC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

So you didn't compare the result with AGT, but I did. The reality is not 
like your speculation.


Regards,

Eric


On 2018-04-04 11:50 AM, Zhu, Rex wrote:
>
> If user send message PPSMC_MSG_GetCurrPkgPwr, firmware will return the 
> pkgpwr immediately as current power value.
>
> as no PPSMC_MSG_GetCurrPkgPwr support, so send message  let firmware 
> write pkgpwr  to ixSMU_PM_STATUS_94,
>
> and driver delay 10ms to read ixSMU_PM_STATUS_94.
>
>
> I don't think there is any problem. otherwise, there is same issue on 
> polaris/vega.
>
>
> I clean ixSMU_PM_STATUS_94 before let smu write it.
>
> The delay time is enough unless we got 0 from ixSMU_PM_STATUS_94 .
>
>
>
> Best Regards
>
> Rex
>
>
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Eric Huang <jinhuieric.huang-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Wednesday, April 4, 2018 11:36 PM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH 2/3] drm/amd/pp: Refine get_gpu_power for VI
> Sampling period is too short. The power reading value will be not
> aligned with AGT's. It will confuse user that why AMD provides two
> different power results.
>
> Regards,
> Eric
>
> On 2018-04-04 04:25 AM, Rex Zhu wrote:
> > 1. On polaris10/11/12, Sending smu message PPSMC_MSG_GetCurrPkgPwr to
> >     read currentpkgpwr directly.
> > 2. On Fiji/tonga/bonaire/hawwii, no PPSMC_MSG_GetCurrPkgPwr support.
> >     Send PPSMC_MSG_PmStatusLogStart to let smu write currentpkgpwr
> >     to ixSMU_PM_STATUS_94. this is asynchronous. need to delay no less
> >     than 1ms.
> > 3. Clean ixSMU_PM_STATUS_94 immediately when send 
> PPSMC_MSG_PmStatusLogStart
> >     to avoid read old value.
> > 4. delay 10 ms instand of 20 ms. so the result will more similar to
> >     the output of PPSMC_MSG_GetCurrPkgPwr.
> > 5. remove max power/vddc/vddci output to keep consistent with vega.
> > 6. for vddc/vddci power, we can calculate the average value per
> >     [10ms, 4s] in other interface if needed.
> >
> > Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> > ---
> > drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 45 
> +++++++++++-------------
> >   1 file changed, 21 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c 
> b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> > index 40f2f87..c0ce672 100644
> > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> > @@ -3363,30 +3363,27 @@ static int smu7_get_pp_table_entry(struct 
> pp_hwmgr *hwmgr,
> >   static int smu7_get_gpu_power(struct pp_hwmgr *hwmgr,
> >                struct pp_gpu_power *query)
> >   {
> > - PP_ASSERT_WITH_CODE(!smum_send_msg_to_smc(hwmgr,
> > - PPSMC_MSG_PmStatusLogStart),
> > -                     "Failed to start pm status log!",
> > -                     return -1);
> > -
> > -     msleep_interruptible(20);
> > -
> > - PP_ASSERT_WITH_CODE(!smum_send_msg_to_smc(hwmgr,
> > - PPSMC_MSG_PmStatusLogSample),
> > -                     "Failed to sample pm status log!",
> > -                     return -1);
> > -
> > -     query->vddc_power = cgs_read_ind_register(hwmgr->device,
> > -                     CGS_IND_REG__SMC,
> > -                     ixSMU_PM_STATUS_40);
> > -     query->vddci_power = cgs_read_ind_register(hwmgr->device,
> > -                     CGS_IND_REG__SMC,
> > -                     ixSMU_PM_STATUS_49);
> > -     query->max_gpu_power = cgs_read_ind_register(hwmgr->device,
> > -                     CGS_IND_REG__SMC,
> > -                     ixSMU_PM_STATUS_94);
> > -     query->average_gpu_power = cgs_read_ind_register(hwmgr->device,
> > -                     CGS_IND_REG__SMC,
> > -                     ixSMU_PM_STATUS_95);
> > +     if (!query)
> > +             return -EINVAL;
> > +
> > +     memset(query, 0, sizeof *query);
> > +
> > +     if (hwmgr->chip_id >= CHIP_POLARIS10) {
> > +             smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrPkgPwr);
> > +             query->average_gpu_power = 
> cgs_read_register(hwmgr->device, mmSMC_MSG_ARG_0);
> > +     } else {
> > +             smum_send_msg_to_smc(hwmgr, PPSMC_MSG_PmStatusLogStart);
> > + cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC,
> > + ixSMU_PM_STATUS_94, 0);
> > +
> > +             msleep_interruptible(10);
> > +
> > +             smum_send_msg_to_smc(hwmgr, PPSMC_MSG_PmStatusLogSample);
> > +
> > +             query->average_gpu_power = 
> cgs_read_ind_register(hwmgr->device,
> > + CGS_IND_REG__SMC,
> > + ixSMU_PM_STATUS_94);
> > +     }
> >
> >        return 0;
> >   }
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> amd-gfx Info Page - freedesktop.org 
> <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
> lists.freedesktop.org
> Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the 
> following form. Use of all freedesktop.org lists is subject to our 
> Code of Conduct.
>
>
>


--------------73053F9E381F4509CD402EEC
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>So you didn't compare the result with AGT, but I did. The reality
      is not like your speculation.</p>
    <p><br>
    </p>
    <p>Regards,</p>
    <p>Eric<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 2018-04-04 11:50 AM, Zhu, Rex wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CY4PR12MB1687C34CD0753343A795544CFBA40-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <p style="margin-top:0;margin-bottom:0">If user send <span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;">message PPSMC_MSG_GetCurrPkgPwr, firmware will
            return the pkgpwr immediately as current power value.</span></p>
        <p style="margin-top:0;margin-bottom:0"><span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;">as no <span style="font-family: Calibri,
              Helvetica, sans-serif, EmojiFont, &quot;Apple Color
              Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji,
              &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;,
              EmojiSymbols; font-size: 14.6667px;">PPSMC_MSG_GetCurrPkgPwr
              support, so send message  let firmware write <span
                style="font-family: Calibri, Helvetica, sans-serif,
                EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
                Emoji&quot;, NotoColorEmoji, &quot;Segoe UI
                Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;
                font-size: 14.6667px;">pkgpwr  to <span
                  style="font-family: Calibri, Helvetica, sans-serif,
                  EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe
                  UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI
                  Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;
                  font-size: 14.6667px;">ixSMU_PM_STATUS_94,</span></span></span></span></p>
        <p style="margin-top:0;margin-bottom:0"><span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;"><span style="font-family: Calibri, Helvetica,
              sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,
              &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI
              Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;
              font-size: 14.6667px;"><span style="font-family: Calibri,
                Helvetica, sans-serif, EmojiFont, &quot;Apple Color
                Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji,
                &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;,
                EmojiSymbols; font-size: 14.6667px;"><span
                  style="font-family: Calibri, Helvetica, sans-serif,
                  EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe
                  UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI
                  Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;
                  font-size: 14.6667px;">and driver delay 10ms to read <span
                    style="font-family: Calibri, Helvetica, sans-serif,
                    EmojiFont, &quot;Apple Color Emoji&quot;,
                    &quot;Segoe UI Emoji&quot;, NotoColorEmoji,
                    &quot;Segoe UI Symbol&quot;, &quot;Android
                    Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">
                    ixSMU_PM_STATUS_94.</span></span></span></span></span></p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <p style="margin-top:0;margin-bottom:0">I don't think there is
          any problem. otherwise, there is same issue on polaris/vega.</p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <p style="margin-top:0;margin-bottom:0">I clean <span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;">
            ixSMU_PM_STATUS_94 before let smu write it.</span></p>
        <p style="margin-top:0;margin-bottom:0"><span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;">The delay time is enough unless we got 0 from <span
              style="font-family: Calibri, Helvetica, sans-serif,
              EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
              Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
              &quot;Android Emoji&quot;, EmojiSymbols; font-size:
              14.6667px;">
              ixSMU_PM_STATUS_94 </span>.</span></p>
        <p style="margin-top:0;margin-bottom:0"><span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;"><br>
          </span></p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <p style="margin-top:0;margin-bottom:0">Best Regards</p>
        <p style="margin-top:0;margin-bottom:0">Rex</p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <br>
        <div style="color: rgb(0, 0, 0);">
          <hr style="display:inline-block;width:98%" tabindex="-1">
          <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
              face="Calibri, sans-serif" color="#000000"><b>From:</b>
              amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on
              behalf of Eric Huang <a class="moz-txt-link-rfc2396E" href="mailto:jinhuieric.huang-5C7GfCeVMHo@public.gmane.org">&lt;jinhuieric.huang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              <b>Sent:</b> Wednesday, April 4, 2018 11:36 PM<br>
              <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <b>Subject:</b> Re: [PATCH 2/3] drm/amd/pp: Refine
              get_gpu_power for VI</font>
            <div> </div>
          </div>
          <div class="BodyFragment"><font size="2"><span
                style="font-size:11pt;">
                <div class="PlainText">Sampling period is too short. The
                  power reading value will be not
                  <br>
                  aligned with AGT's. It will confuse user that why AMD
                  provides two <br>
                  different power results.<br>
                  <br>
                  Regards,<br>
                  Eric<br>
                  <br>
                  On 2018-04-04 04:25 AM, Rex Zhu wrote:<br>
                  &gt; 1. On polaris10/11/12, Sending smu message
                  PPSMC_MSG_GetCurrPkgPwr to<br>
                  &gt;     read currentpkgpwr directly.<br>
                  &gt; 2. On Fiji/tonga/bonaire/hawwii, no
                  PPSMC_MSG_GetCurrPkgPwr support.<br>
                  &gt;     Send PPSMC_MSG_PmStatusLogStart to let smu
                  write currentpkgpwr<br>
                  &gt;     to ixSMU_PM_STATUS_94. this is asynchronous.
                  need to delay no less<br>
                  &gt;     than 1ms.<br>
                  &gt; 3. Clean ixSMU_PM_STATUS_94 immediately when send
                  PPSMC_MSG_PmStatusLogStart<br>
                  &gt;     to avoid read old value.<br>
                  &gt; 4. delay 10 ms instand of 20 ms. so the result
                  will more similar to<br>
                  &gt;     the output of PPSMC_MSG_GetCurrPkgPwr.<br>
                  &gt; 5. remove max power/vddc/vddci output to keep
                  consistent with vega.<br>
                  &gt; 6. for vddc/vddci power, we can calculate the
                  average value per<br>
                  &gt;     [10ms, 4s] in other interface if needed.<br>
                  &gt;<br>
                  &gt; Signed-off-by: Rex Zhu <a class="moz-txt-link-rfc2396E" href="mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org">&lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                  &gt; ---<br>
                  &gt;  
                  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 45
                  +++++++++++-------------<br>
                  &gt;   1 file changed, 21 insertions(+), 24
                  deletions(-)<br>
                  &gt;<br>
                  &gt; diff --git
                  a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
                  b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
                  &gt; index 40f2f87..c0ce672 100644<br>
                  &gt; ---
                  a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
                  &gt; +++
                  b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
                  &gt; @@ -3363,30 +3363,27 @@ static int
                  smu7_get_pp_table_entry(struct pp_hwmgr *hwmgr,<br>
                  &gt;   static int smu7_get_gpu_power(struct pp_hwmgr
                  *hwmgr,<br>
                  &gt;                struct pp_gpu_power *query)<br>
                  &gt;   {<br>
                  &gt; -    
                  PP_ASSERT_WITH_CODE(!smum_send_msg_to_smc(hwmgr,<br>
                  &gt; -                    
                  PPSMC_MSG_PmStatusLogStart),<br>
                  &gt; -                     "Failed to start pm status
                  log!",<br>
                  &gt; -                     return -1);<br>
                  &gt; -<br>
                  &gt; -     msleep_interruptible(20);<br>
                  &gt; -<br>
                  &gt; -    
                  PP_ASSERT_WITH_CODE(!smum_send_msg_to_smc(hwmgr,<br>
                  &gt; -                    
                  PPSMC_MSG_PmStatusLogSample),<br>
                  &gt; -                     "Failed to sample pm status
                  log!",<br>
                  &gt; -                     return -1);<br>
                  &gt; -<br>
                  &gt; -     query-&gt;vddc_power =
                  cgs_read_ind_register(hwmgr-&gt;device,<br>
                  &gt; -                     CGS_IND_REG__SMC,<br>
                  &gt; -                     ixSMU_PM_STATUS_40);<br>
                  &gt; -     query-&gt;vddci_power =
                  cgs_read_ind_register(hwmgr-&gt;device,<br>
                  &gt; -                     CGS_IND_REG__SMC,<br>
                  &gt; -                     ixSMU_PM_STATUS_49);<br>
                  &gt; -     query-&gt;max_gpu_power =
                  cgs_read_ind_register(hwmgr-&gt;device,<br>
                  &gt; -                     CGS_IND_REG__SMC,<br>
                  &gt; -                     ixSMU_PM_STATUS_94);<br>
                  &gt; -     query-&gt;average_gpu_power =
                  cgs_read_ind_register(hwmgr-&gt;device,<br>
                  &gt; -                     CGS_IND_REG__SMC,<br>
                  &gt; -                     ixSMU_PM_STATUS_95);<br>
                  &gt; +     if (!query)<br>
                  &gt; +             return -EINVAL;<br>
                  &gt; +<br>
                  &gt; +     memset(query, 0, sizeof *query);<br>
                  &gt; +<br>
                  &gt; +     if (hwmgr-&gt;chip_id &gt;= CHIP_POLARIS10)
                  {<br>
                  &gt; +             smum_send_msg_to_smc(hwmgr,
                  PPSMC_MSG_GetCurrPkgPwr);<br>
                  &gt; +             query-&gt;average_gpu_power =
                  cgs_read_register(hwmgr-&gt;device, mmSMC_MSG_ARG_0);<br>
                  &gt; +     } else {<br>
                  &gt; +             smum_send_msg_to_smc(hwmgr,
                  PPSMC_MSG_PmStatusLogStart);<br>
                  &gt; +            
                  cgs_write_ind_register(hwmgr-&gt;device,
                  CGS_IND_REG__SMC,<br>
                  &gt; +                                    
                  ixSMU_PM_STATUS_94, 0);<br>
                  &gt; +<br>
                  &gt; +             msleep_interruptible(10);<br>
                  &gt; +<br>
                  &gt; +             smum_send_msg_to_smc(hwmgr,
                  PPSMC_MSG_PmStatusLogSample);<br>
                  &gt; +<br>
                  &gt; +             query-&gt;average_gpu_power =
                  cgs_read_ind_register(hwmgr-&gt;device,<br>
                  &gt;
                  +                                                    
                  CGS_IND_REG__SMC,<br>
                  &gt;
                  +                                                    
                  ixSMU_PM_STATUS_94);<br>
                  &gt; +     }<br>
                  &gt;   <br>
                  &gt;        return 0;<br>
                  &gt;   }<br>
                  <br>
                  _______________________________________________<br>
                  amd-gfx mailing list<br>
                  <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                  <a
                    href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                    id="LPlnk731909" previewremoved="true"
                    moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
                  <div id="LPBorder_GT_15228562333390.979542144089784"
                    style="margin-bottom: 20px; overflow: auto; width:
                    100%; text-indent: 0px;">
                    <table
                      id="LPContainer_15228562333280.30238014676002334"
                      role="presentation" style="width: 90%;
                      background-color: rgb(255, 255, 255); position:
                      relative; overflow: auto; padding-top: 20px;
                      padding-bottom: 20px; margin-top: 20px;
                      border-top: 1px dotted rgb(200, 200, 200);
                      border-bottom: 1px dotted rgb(200, 200, 200);"
                      cellspacing="0">
                      <tbody>
                        <tr style="border-spacing: 0px;" valign="top">
                          <td
                            id="TextCell_15228562333320.0901521230341924"
                            colspan="2" style="vertical-align: top;
                            position: relative; padding: 0px; display:
                            table-cell;">
                            <div
                              id="LPTitle_15228562333330.17088493377011438"
                              style="top: 0px; color: rgb(0, 120, 215);
                              font-weight: normal; font-size: 21px;
                              font-family: wf_segoe-ui_light,
                              &quot;Segoe UI Light&quot;, &quot;Segoe WP
                              Light&quot;, &quot;Segoe UI&quot;,
                              &quot;Segoe WP&quot;, Tahoma, Arial,
                              sans-serif; line-height: 21px;">
                              <a
                                id="LPUrlAnchor_15228562333350.45851088175032095"
href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                                target="_blank" style="text-decoration:
                                none;" moz-do-not-send="true">amd-gfx
                                Info Page - freedesktop.org</a></div>
                            <div
                              id="LPMetadata_15228562333360.9650973279775443"
                              style="margin: 10px 0px 16px; color:
                              rgb(102, 102, 102); font-weight: normal;
                              font-family: wf_segoe-ui_normal,
                              &quot;Segoe UI&quot;, &quot;Segoe
                              WP&quot;, Tahoma, Arial, sans-serif;
                              font-size: 14px; line-height: 14px;">
                              lists.freedesktop.org</div>
                            <div
                              id="LPDescription_15228562333370.9839175290800748"
                              style="display: block; color: rgb(102,
                              102, 102); font-weight: normal;
                              font-family: wf_segoe-ui_normal,
                              &quot;Segoe UI&quot;, &quot;Segoe
                              WP&quot;, Tahoma, Arial, sans-serif;
                              font-size: 14px; line-height: 20px;
                              max-height: 100px; overflow: hidden;">
                              Subscribing to amd-gfx: Subscribe to
                              amd-gfx by filling out the following form.
                              Use of all freedesktop.org lists is
                              subject to our Code of Conduct.</div>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                  <br>
                  <br>
                </div>
              </span></font></div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------73053F9E381F4509CD402EEC--

--===============1886412757==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1886412757==--
