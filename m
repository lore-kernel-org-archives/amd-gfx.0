From: Eric Huang <jinhuieric.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/4] drm/amd/pp: Add new smu callback function
Date: Fri, 26 Jan 2018 11:39:49 -0500
Message-ID: <7a30b53f-ca9d-4a2c-5709-23846b2dbbf1@amd.com>
References: <1516786649-14914-1-git-send-email-Rex.Zhu@amd.com>
 <cba449fc-1e35-382f-919d-e429d325a553@amd.com>
 <CY4PR12MB168701E9A698764CDCC6D278FBE10@CY4PR12MB1687.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1571856860=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB168701E9A698764CDCC6D278FBE10-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
--===============1571856860==
Content-Type: multipart/alternative;
 boundary="------------D596F0968E29636D913CCEAA"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------D596F0968E29636D913CCEAA
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Power containment has two parts, TDC limit and power limit. Only 
changing power limit is not equal to disabling power containment.

Power containment in Fiji degrades compute performance. So we disable it 
to fix. It has been verified by compute performance test. If you want to 
replace it, it has to be verified, otherwise it will make a regression.

Regards,
Eric


On 2018-01-25 06:15 PM, Zhu, Rex wrote:
> For the power containment issue on Fiji.
> We want to expose set power limit function.
> Maybe we can adjust the power limit instand of just disable this feature.
> But I am not sure this can meet kfd ‘ s requirement.
>
> Best Regards
> Rex
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Eric Huang <jinhuieric.huang-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Friday, January 26, 2018 12:18:45 AM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH 1/4] drm/amd/pp: Add new smu callback function
> Hi Rex,
>
> Why don't you use function smum_populate_requested_graphic_levels()
> which is doing exactly the same thing as the function you add ?
>
> And in old power profile setting function
> smu7_set_power_profile_state(), we implement this:
>
> if (hwmgr->chip_id == CHIP_FIJI) {
>          if (request->type == AMD_PP_GFX_PROFILE)
>              smu7_enable_power_containment(hwmgr);
>          else if (request->type == AMD_PP_COMPUTE_PROFILE)
>              smu7_disable_power_containment(hwmgr);
>      }
>
> This should be merged into your new power profile setting.
>
> Regards,
> Eric
>
> On 2018-01-24 04:37 AM, Rex Zhu wrote:
> > it is used for update dpm settings
> >
> > Change-Id: Idc0362c219d84564693ca90adf9299e56cfeb6a4
> > Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> > ---
> >   drivers/gpu/drm/amd/powerplay/inc/hwmgr.h     | 1 +
> >   drivers/gpu/drm/amd/powerplay/inc/smumgr.h    | 1 +
> >   drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c | 8 ++++++++
> >   3 files changed, 10 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h 
> b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> > index 604a7cb..3e8959e 100644
> > --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> > +++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> > @@ -238,6 +238,7 @@ struct pp_smumgr_func {
> >        int (*populate_requested_graphic_levels)(struct pp_hwmgr *hwmgr,
> >                        struct amd_pp_profile *request);
> >        bool (*is_hw_avfs_present)(struct pp_hwmgr *hwmgr);
> > +     int (*update_dpm_settings)(struct pp_hwmgr *hwmgr, void 
> *profile_setting);
> >   };
> >
> >   struct pp_hwmgr_func {
> > diff --git a/drivers/gpu/drm/amd/powerplay/inc/smumgr.h 
> b/drivers/gpu/drm/amd/powerplay/inc/smumgr.h
> > index b1b27b2..e05a57e 100644
> > --- a/drivers/gpu/drm/amd/powerplay/inc/smumgr.h
> > +++ b/drivers/gpu/drm/amd/powerplay/inc/smumgr.h
> > @@ -134,5 +134,6 @@ extern int 
> smum_populate_requested_graphic_levels(struct pp_hwmgr *hwmgr,
> >
> >   extern bool smum_is_hw_avfs_present(struct pp_hwmgr *hwmgr);
> >
> > +extern int smum_update_dpm_settings(struct pp_hwmgr *hwmgr, void 
> *profile_setting);
> >
> >   #endif
> > diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c 
> b/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c
> > index 8673884..1ce4959 100644
> > --- a/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c
> > @@ -253,3 +253,11 @@ bool smum_is_hw_avfs_present(struct pp_hwmgr 
> *hwmgr)
> >
> >        return false;
> >   }
> > +
> > +int smum_update_dpm_settings(struct pp_hwmgr *hwmgr, void 
> *profile_setting)
> > +{
> > +     if (hwmgr->smumgr_funcs->update_dpm_settings)
> > +             return hwmgr->smumgr_funcs->update_dpm_settings(hwmgr, 
> profile_setting);
> > +
> > +     return -EINVAL;
> > +}
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------D596F0968E29636D913CCEAA
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Power containment has two parts, TDC limit and power limit. Only
      changing power limit is not equal to disabling power containment.</p>
    <p>Power containment in Fiji degrades compute performance. So we
      disable it to fix. It has been verified by compute performance
      test. If you want to replace it, it has to be verified, otherwise
      it will make a regression.</p>
    Regards,<br>
    Eric<br>
    <br>
    <br>
    <div class="moz-cite-prefix">On 2018-01-25 06:15 PM, Zhu, Rex wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CY4PR12MB168701E9A698764CDCC6D278FBE10-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      For the power containment issue on Fiji.<br>
      We want to expose set power limit function.<br>
      Maybe we can adjust the power limit instand of just disable this
      feature.<br>
      But I am not sure this can meet kfd ‘ s requirement.<br>
      <br>
      Best Regards<br>
      Rex<br>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          face="Calibri, sans-serif" color="#000000"><b>From:</b>
          amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on
          behalf of Eric Huang <a class="moz-txt-link-rfc2396E" href="mailto:jinhuieric.huang-5C7GfCeVMHo@public.gmane.org">&lt;jinhuieric.huang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
          <b>Sent:</b> Friday, January 26, 2018 12:18:45 AM<br>
          <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
          <b>Subject:</b> Re: [PATCH 1/4] drm/amd/pp: Add new smu
          callback function</font>
        <div> </div>
      </div>
      <div class="BodyFragment"><font size="2"><span
            style="font-size:11pt;">
            <div class="PlainText">Hi Rex,<br>
              <br>
              Why don't you use function
              smum_populate_requested_graphic_levels() <br>
              which is doing exactly the same thing as the function you
              add ?<br>
              <br>
              And in old power profile setting function <br>
              smu7_set_power_profile_state(), we implement this:<br>
              <br>
              if (hwmgr-&gt;chip_id == CHIP_FIJI) {<br>
                       if (request-&gt;type == AMD_PP_GFX_PROFILE)<br>
                           smu7_enable_power_containment(hwmgr);<br>
                       else if (request-&gt;type ==
              AMD_PP_COMPUTE_PROFILE)<br>
                           smu7_disable_power_containment(hwmgr);<br>
                   }<br>
              <br>
              This should be merged into your new power profile setting.<br>
              <br>
              Regards,<br>
              Eric<br>
              <br>
              On 2018-01-24 04:37 AM, Rex Zhu wrote:<br>
              &gt; it is used for update dpm settings<br>
              &gt;<br>
              &gt; Change-Id: Idc0362c219d84564693ca90adf9299e56cfeb6a4<br>
              &gt; Signed-off-by: Rex Zhu <a class="moz-txt-link-rfc2396E" href="mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org">&lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              &gt; ---<br>
              &gt;   drivers/gpu/drm/amd/powerplay/inc/hwmgr.h     | 1 +<br>
              &gt;   drivers/gpu/drm/amd/powerplay/inc/smumgr.h    | 1 +<br>
              &gt;   drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c | 8
              ++++++++<br>
              &gt;   3 files changed, 10 insertions(+)<br>
              &gt;<br>
              &gt; diff --git
              a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
              b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
              &gt; index 604a7cb..3e8959e 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
              &gt; +++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
              &gt; @@ -238,6 +238,7 @@ struct pp_smumgr_func {<br>
              &gt;        int
              (*populate_requested_graphic_levels)(struct pp_hwmgr
              *hwmgr,<br>
              &gt;                        struct amd_pp_profile
              *request);<br>
              &gt;        bool (*is_hw_avfs_present)(struct pp_hwmgr 
              *hwmgr);<br>
              &gt; +     int (*update_dpm_settings)(struct pp_hwmgr
              *hwmgr, void *profile_setting);<br>
              &gt;   };<br>
              &gt;   <br>
              &gt;   struct pp_hwmgr_func {<br>
              &gt; diff --git
              a/drivers/gpu/drm/amd/powerplay/inc/smumgr.h
              b/drivers/gpu/drm/amd/powerplay/inc/smumgr.h<br>
              &gt; index b1b27b2..e05a57e 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/powerplay/inc/smumgr.h<br>
              &gt; +++ b/drivers/gpu/drm/amd/powerplay/inc/smumgr.h<br>
              &gt; @@ -134,5 +134,6 @@ extern int
              smum_populate_requested_graphic_levels(struct pp_hwmgr
              *hwmgr,<br>
              &gt;   <br>
              &gt;   extern bool smum_is_hw_avfs_present(struct pp_hwmgr
              *hwmgr);<br>
              &gt;   <br>
              &gt; +extern int smum_update_dpm_settings(struct pp_hwmgr
              *hwmgr, void *profile_setting);<br>
              &gt;   <br>
              &gt;   #endif<br>
              &gt; diff --git
              a/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c
              b/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c<br>
              &gt; index 8673884..1ce4959 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c<br>
              &gt; +++ b/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c<br>
              &gt; @@ -253,3 +253,11 @@ bool
              smum_is_hw_avfs_present(struct pp_hwmgr *hwmgr)<br>
              &gt;   <br>
              &gt;        return false;<br>
              &gt;   }<br>
              &gt; +<br>
              &gt; +int smum_update_dpm_settings(struct pp_hwmgr *hwmgr,
              void *profile_setting)<br>
              &gt; +{<br>
              &gt; +     if
              (hwmgr-&gt;smumgr_funcs-&gt;update_dpm_settings)<br>
              &gt; +             return
              hwmgr-&gt;smumgr_funcs-&gt;update_dpm_settings(hwmgr,
              profile_setting);<br>
              &gt; +<br>
              &gt; +     return -EINVAL;<br>
              &gt; +}<br>
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

--------------D596F0968E29636D913CCEAA--

--===============1571856860==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1571856860==--
