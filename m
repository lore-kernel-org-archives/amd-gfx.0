From: Eric Huang <jinhuieric.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amd/pp: Implement set_power_profile_mode on smu7
Date: Wed, 24 Jan 2018 15:47:23 -0500
Message-ID: <2a05588c-f998-8fca-dad3-3a01677b51ec@amd.com>
References: <1516786649-14914-1-git-send-email-Rex.Zhu@amd.com>
 <1516786649-14914-4-git-send-email-Rex.Zhu@amd.com>
 <e21a2657-7a80-5b59-6c1c-a578d3bf79a9@amd.com>
 <CY4PR12MB1687B4CBFF3BC4DD121752A4FBE20@CY4PR12MB1687.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0544688971=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1687B4CBFF3BC4DD121752A4FBE20-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
--===============0544688971==
Content-Type: multipart/alternative;
 boundary="------------3C9BF326F1BECE0C91ABAFA8"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------3C9BF326F1BECE0C91ABAFA8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rex,

So you intend to separate previous one integrated profile parameters 
into two sets implemented by two/three sysfs entries.

Regards,
Eric

On 2018-01-24 03:13 PM, Zhu, Rex wrote:
> Hi Eric,
>
> We have sysfs pp-dpm-sclk/mclk to set min dpm level
>
> Best Regards
> Rex
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Eric Huang <jinhuieric.huang-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Thursday, January 25, 2018 12:04:55 AM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH 4/4] drm/amd/pp: Implement 
> set_power_profile_mode on smu7
> We have min_sclk and min_mclk in previous power profile parameters for
> VI, which are similar with min_active_level for Vega10. How to implement
> these parameters?
>
> Regards,
> Eric
>
> On 2018-01-24 04:37 AM, Rex Zhu wrote:
> > User can set smu7 profile pamameters through sysfs
> >
> > echo "0/1/2/3/4">pp_power_profile_mode
> > to select 3D_FULL_SCREEN/POWER_SAVING/VIDEO/VR/COMPUTE
> > mode.
> > echo "5 * * * * * * * *">pp_power_profile_mode
> > to config custom mode.
> > "5 * * * * * * * *" mean "CUSTOM enable_sclk SCLK_UP_HYST
> > SCLK_DOWN_HYST SCLK_ACTIVE_LEVEL enable_mclk MCLK_UP_HYST
> > MCLK_DOWN_HYST MCLK_ACTIVE_LEVEL"
> >
> > Change-Id: Ic6d6f37363bc81ab17051285f6ace847edf725de
> > Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> > ---
> >   drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 49 
> +++++++++++++++++++++++-
> >   1 file changed, 48 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c 
> b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> > index 9f6afd5..13db75c 100644
> > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> > @@ -5036,7 +5036,54 @@ static int smu7_get_power_profile_mode(struct 
> pp_hwmgr *hwmgr, char *buf)
> >
> >   static int smu7_set_power_profile_mode(struct pp_hwmgr *hwmgr, 
> long *input, uint32_t size)
> >   {
> > -     /* To Do */
> > +     struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
> > +     struct profile_mode_setting tmp;
> > +
> > +     hwmgr->power_profile_mode = input[size];
> > +
> > +     switch (hwmgr->power_profile_mode) {
> > +     case PP_SMC_POWER_PROFILE_CUSTOM:
> > +             if (size < 8)
> > +                     return -EINVAL;
> > +
> > + data->custom_profile_setting.bupdate_sclk = input[0];
> > + data->custom_profile_setting.sclk_up_hyst = input[1];
> > + data->custom_profile_setting.sclk_down_hyst = input[2];
> > + data->custom_profile_setting.sclk_activity =  input[3];
> > + data->custom_profile_setting.bupdate_mclk = input[4];
> > + data->custom_profile_setting.mclk_up_hyst = input[5];
> > + data->custom_profile_setting.mclk_down_hyst = input[6];
> > + data->custom_profile_setting.mclk_activity =  input[7];
> > +             if (!smum_update_dpm_settings(hwmgr, 
> &data->custom_profile_setting))
> > + memcpy(&data->current_profile_setting, 
> &data->custom_profile_setting, sizeof(struct profile_mode_setting));
> > +             break;
> > +     case PP_SMC_POWER_PROFILE_FULLSCREEN3D:
> > +     case PP_SMC_POWER_PROFILE_POWERSAVING:
> > +     case PP_SMC_POWER_PROFILE_VIDEO:
> > +     case PP_SMC_POWER_PROFILE_VR:
> > +     case PP_SMC_POWER_PROFILE_COMPUTE:
> > +             memcpy(&tmp, 
> &smu7_profiling[hwmgr->power_profile_mode], sizeof(struct 
> profile_mode_setting));
> > +             if (!smum_update_dpm_settings(hwmgr, &tmp)) {
> > +                     if (tmp.bupdate_sclk) {
> > + data->current_profile_setting.bupdate_sclk = tmp.bupdate_sclk;
> > + data->current_profile_setting.sclk_up_hyst = tmp.sclk_up_hyst;
> > + data->current_profile_setting.sclk_down_hyst = tmp.sclk_down_hyst;
> > + data->current_profile_setting.sclk_activity = tmp.sclk_activity;
> > +                     }
> > +                     if (tmp.bupdate_mclk) {
> > + data->current_profile_setting.bupdate_mclk = tmp.bupdate_mclk;
> > + data->current_profile_setting.mclk_up_hyst = tmp.mclk_up_hyst;
> > + data->current_profile_setting.mclk_down_hyst = tmp.mclk_down_hyst;
> > + data->current_profile_setting.mclk_activity = tmp.mclk_activity;
> > +                     }
> > +             }
> > +             break;
> > +     case PP_SMC_POWER_PROFILE_AUTO: /* TO DO auto wattman feature 
> not implement */
> > +             return 0;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> >        return 0;
> >   }
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------3C9BF326F1BECE0C91ABAFA8
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hi Rex,</p>
    <p>So you intend to separate previous one integrated profile
      parameters into two sets implemented by two/three sysfs entries.<br>
    </p>
    Regards,<br>
    Eric<br>
    <br>
    <div class="moz-cite-prefix">On 2018-01-24 03:13 PM, Zhu, Rex wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CY4PR12MB1687B4CBFF3BC4DD121752A4FBE20-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      Hi Eric,<br>
      <br>
      We have sysfs pp-dpm-sclk/mclk to set min dpm level<br>
      <br>
      Best Regards<br>
      Rex
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          face="Calibri, sans-serif" color="#000000"><b>From:</b>
          amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on
          behalf of Eric Huang <a class="moz-txt-link-rfc2396E" href="mailto:jinhuieric.huang-5C7GfCeVMHo@public.gmane.org">&lt;jinhuieric.huang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
          <b>Sent:</b> Thursday, January 25, 2018 12:04:55 AM<br>
          <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
          <b>Subject:</b> Re: [PATCH 4/4] drm/amd/pp: Implement
          set_power_profile_mode on smu7</font>
        <div> </div>
      </div>
      <div class="BodyFragment"><font size="2"><span
            style="font-size:11pt;">
            <div class="PlainText">We have min_sclk and min_mclk in
              previous power profile parameters for
              <br>
              VI, which are similar with min_active_level for Vega10.
              How to implement <br>
              these parameters?<br>
              <br>
              Regards,<br>
              Eric<br>
              <br>
              On 2018-01-24 04:37 AM, Rex Zhu wrote:<br>
              &gt; User can set smu7 profile pamameters through sysfs<br>
              &gt;<br>
              &gt; echo "0/1/2/3/4"&gt;pp_power_profile_mode<br>
              &gt; to select
              3D_FULL_SCREEN/POWER_SAVING/VIDEO/VR/COMPUTE<br>
              &gt; mode.<br>
              &gt; echo "5 * * * * * * * *"&gt;pp_power_profile_mode<br>
              &gt; to config custom mode.<br>
              &gt; "5 * * * * * * * *" mean "CUSTOM enable_sclk
              SCLK_UP_HYST<br>
              &gt; SCLK_DOWN_HYST SCLK_ACTIVE_LEVEL enable_mclk
              MCLK_UP_HYST<br>
              &gt; MCLK_DOWN_HYST MCLK_ACTIVE_LEVEL"<br>
              &gt;<br>
              &gt; Change-Id: Ic6d6f37363bc81ab17051285f6ace847edf725de<br>
              &gt; Signed-off-by: Rex Zhu <a class="moz-txt-link-rfc2396E" href="mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org">&lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              &gt; ---<br>
              &gt;   drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c |
              49 +++++++++++++++++++++++-<br>
              &gt;   1 file changed, 48 insertions(+), 1 deletion(-)<br>
              &gt;<br>
              &gt; diff --git
              a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
              b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
              &gt; index 9f6afd5..13db75c 100644<br>
              &gt; ---
              a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
              &gt; +++
              b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
              &gt; @@ -5036,7 +5036,54 @@ static int
              smu7_get_power_profile_mode(struct pp_hwmgr *hwmgr, char
              *buf)<br>
              &gt;   <br>
              &gt;   static int smu7_set_power_profile_mode(struct
              pp_hwmgr *hwmgr, long *input, uint32_t size)<br>
              &gt;   {<br>
              &gt; -     /* To Do */<br>
              &gt; +     struct smu7_hwmgr *data = (struct smu7_hwmgr
              *)(hwmgr-&gt;backend);<br>
              &gt; +     struct profile_mode_setting tmp;<br>
              &gt; +<br>
              &gt; +     hwmgr-&gt;power_profile_mode = input[size];<br>
              &gt; +<br>
              &gt; +     switch (hwmgr-&gt;power_profile_mode) {<br>
              &gt; +     case PP_SMC_POWER_PROFILE_CUSTOM:<br>
              &gt; +             if (size &lt; 8)<br>
              &gt; +                     return -EINVAL;<br>
              &gt; +<br>
              &gt; +            
              data-&gt;custom_profile_setting.bupdate_sclk = input[0];<br>
              &gt; +            
              data-&gt;custom_profile_setting.sclk_up_hyst = input[1];<br>
              &gt; +            
              data-&gt;custom_profile_setting.sclk_down_hyst = input[2];<br>
              &gt; +            
              data-&gt;custom_profile_setting.sclk_activity =  input[3];<br>
              &gt; +            
              data-&gt;custom_profile_setting.bupdate_mclk = input[4];<br>
              &gt; +            
              data-&gt;custom_profile_setting.mclk_up_hyst = input[5];<br>
              &gt; +            
              data-&gt;custom_profile_setting.mclk_down_hyst = input[6];<br>
              &gt; +            
              data-&gt;custom_profile_setting.mclk_activity =  input[7];<br>
              &gt; +             if (!smum_update_dpm_settings(hwmgr,
              &amp;data-&gt;custom_profile_setting))<br>
              &gt; +                    
              memcpy(&amp;data-&gt;current_profile_setting,
              &amp;data-&gt;custom_profile_setting, sizeof(struct
              profile_mode_setting));<br>
              &gt; +             break;<br>
              &gt; +     case PP_SMC_POWER_PROFILE_FULLSCREEN3D:<br>
              &gt; +     case PP_SMC_POWER_PROFILE_POWERSAVING:<br>
              &gt; +     case PP_SMC_POWER_PROFILE_VIDEO:<br>
              &gt; +     case PP_SMC_POWER_PROFILE_VR:<br>
              &gt; +     case PP_SMC_POWER_PROFILE_COMPUTE:<br>
              &gt; +             memcpy(&amp;tmp,
              &amp;smu7_profiling[hwmgr-&gt;power_profile_mode],
              sizeof(struct profile_mode_setting));<br>
              &gt; +             if (!smum_update_dpm_settings(hwmgr,
              &amp;tmp)) {<br>
              &gt; +                     if (tmp.bupdate_sclk) {<br>
              &gt; +                            
              data-&gt;current_profile_setting.bupdate_sclk =
              tmp.bupdate_sclk;<br>
              &gt; +                            
              data-&gt;current_profile_setting.sclk_up_hyst =
              tmp.sclk_up_hyst;<br>
              &gt; +                            
              data-&gt;current_profile_setting.sclk_down_hyst =
              tmp.sclk_down_hyst;<br>
              &gt; +                            
              data-&gt;current_profile_setting.sclk_activity =
              tmp.sclk_activity;<br>
              &gt; +                     }<br>
              &gt; +                     if (tmp.bupdate_mclk) {<br>
              &gt; +                            
              data-&gt;current_profile_setting.bupdate_mclk =
              tmp.bupdate_mclk;<br>
              &gt; +                            
              data-&gt;current_profile_setting.mclk_up_hyst =
              tmp.mclk_up_hyst;<br>
              &gt; +                            
              data-&gt;current_profile_setting.mclk_down_hyst =
              tmp.mclk_down_hyst;<br>
              &gt; +                            
              data-&gt;current_profile_setting.mclk_activity =
              tmp.mclk_activity;<br>
              &gt; +                     }<br>
              &gt; +             }<br>
              &gt; +             break;<br>
              &gt; +     case PP_SMC_POWER_PROFILE_AUTO: /* TO DO auto
              wattman feature not implement */<br>
              &gt; +             return 0;<br>
              &gt; +     default:<br>
              &gt; +             return -EINVAL;<br>
              &gt; +     }<br>
              &gt; +<br>
              &gt;        return 0;<br>
              &gt;   }<br>
              &gt;   <br>
              <br>
              _______________________________________________<br>
              amd-gfx mailing list<br>
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <a
                href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
            </div>
          </span></font></div>
    </blockquote>
    <br>
  </body>
</html>

--------------3C9BF326F1BECE0C91ABAFA8--

--===============0544688971==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0544688971==--
