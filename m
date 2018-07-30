From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/4] drm/amdgpu: Put enable gfx off feature to a delay
 thread
Date: Mon, 30 Jul 2018 12:49:14 +0200
Message-ID: <acfd6ab0-a069-f5df-1d1a-dabd2bb5fa52@gmail.com>
References: <1532942625-26876-1-git-send-email-Rex.Zhu@amd.com>
 <1532942625-26876-2-git-send-email-Rex.Zhu@amd.com>
 <CY4PR12MB168727FC303FDB625880C440FB2F0@CY4PR12MB1687.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1919968409=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB168727FC303FDB625880C440FB2F0-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
--===============1919968409==
Content-Type: multipart/alternative;
 boundary="------------03BB4509046401240BD05AA1"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------03BB4509046401240BD05AA1
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

A bit large, maybe 100ms is enough.

Apart from that the set now looks good on first glance, but I really 
don't know that code that well.

Christian.

Am 30.07.2018 um 12:25 schrieb Zhu, Rex:
>
> One problem,
>
>
> I delay 500ms to enable gfx off feature.
>
>
> Any concern about the delay time?
>
>
> Best Regards
>
> Rex
>
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Monday, July 30, 2018 5:23 PM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Cc:* Zhu, Rex
> *Subject:* [PATCH v2 2/4] drm/amdgpu: Put enable gfx off feature to a 
> delay thread
> delay to enable gfx off feature to avoid gfx on/off frequently
> suggested by Alex and Evan.
>
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  8 ++++++--
>  3 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 188bc53..ff16689 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -992,6 +992,8 @@ struct amdgpu_gfx {
>          bool gfx_off_state; /* true: enabled, false: disabled */
>          struct mutex gfx_off_mutex;
>          uint32_t gfx_off_req_count; /* default 1, enable gfx off: dec 
> 1, disable gfx off: add 1 */
> +       struct delayed_work gfx_off_delay_work;
> +
>          /* pipe reservation */
>          struct mutex pipe_reserve_mutex;
>          DECLARE_BITMAP (pipe_reserve_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 122653f..f6a6fb5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1925,6 +1925,19 @@ static void 
> amdgpu_device_ip_late_init_func_handler(struct work_struct *work)
>                  DRM_ERROR("ib ring test failed (%d).\n", r);
>  }
>
> +static void amdgpu_device_delay_enable_gfx_off(struct work_struct *work)
> +{
> +       struct amdgpu_device *adev =
> +               container_of(work, struct amdgpu_device, 
> gfx.gfx_off_delay_work.work);
> +
> +       mutex_lock(&adev->gfx.gfx_off_mutex);
> +       if (!adev->gfx.gfx_off_state && !adev->gfx.gfx_off_req_count) {
> +               if (!amdgpu_dpm_set_powergating_by_smu(adev, 
> AMD_IP_BLOCK_TYPE_GFX, true))
> +                       adev->gfx.gfx_off_state = true;
> +       }
> +       mutex_unlock(&adev->gfx.gfx_off_mutex);
> +}
> +
>  /**
>   * amdgpu_device_ip_suspend_phase1 - run suspend for hardware IPs 
> (phase 1)
>   *
> @@ -2394,6 +2407,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>
> INIT_DELAYED_WORK(&adev->late_init_work,
> amdgpu_device_ip_late_init_func_handler);
> + INIT_DELAYED_WORK(&adev->gfx.gfx_off_delay_work,
> + amdgpu_device_delay_enable_gfx_off);
>
>          adev->gfx.gfx_off_req_count = 1;
>          adev->pm.ac_power = power_supply_is_system_supplied() > 0 ? 
> true : false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 1cdb264..11d4d9f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -26,6 +26,9 @@
>  #include "amdgpu.h"
>  #include "amdgpu_gfx.h"
>
> +/* 0.5 second timeout */
> +#define GFX_OFF_DELAY_ENABLE msecs_to_jiffies(500)
> +
>  /*
>   * GPU scratch registers helpers function.
>   */
> @@ -360,6 +363,7 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device 
> *adev, bool enable)
>          if (!adev->powerplay.pp_funcs->set_powergating_by_smu)
>                  return;
>
> +
>          mutex_lock(&adev->gfx.gfx_off_mutex);
>
>          if (!enable)
> @@ -368,11 +372,11 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device 
> *adev, bool enable)
>                  adev->gfx.gfx_off_req_count--;
>
>          if (enable && !adev->gfx.gfx_off_state && 
> !adev->gfx.gfx_off_req_count) {
> -               if (!amdgpu_dpm_set_powergating_by_smu(adev, 
> AMD_IP_BLOCK_TYPE_GFX, true))
> -                       adev->gfx.gfx_off_state = true;
> + schedule_delayed_work(&adev->gfx.gfx_off_delay_work, 
> GFX_OFF_DELAY_ENABLE);
>          } else if (!enable && adev->gfx.gfx_off_state) {
>                  if (!amdgpu_dpm_set_powergating_by_smu(adev, 
> AMD_IP_BLOCK_TYPE_GFX, false))
>                          adev->gfx.gfx_off_state = false;
>          }
> +
> mutex_unlock(&adev->gfx.gfx_off_mutex);
>  }
> -- 
> 1.9.1
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
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------03BB4509046401240BD05AA1
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">A bit large, maybe 100ms is enough.<br>
      <br>
      Apart from that the set now looks good on first glance, but I
      really don't know that code that well.<br>
      <br>
      Christian.<br>
      <br>
      Am 30.07.2018 um 12:25 schrieb Zhu, Rex:<br>
    </div>
    <blockquote type="cite"
cite="mid:CY4PR12MB168727FC303FDB625880C440FB2F0-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <p style="margin-top:0;margin-bottom:0">One problem,</p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <p style="margin-top:0;margin-bottom:0">I delay 500ms to enable
          gfx off feature. <br>
        </p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <p style="margin-top:0;margin-bottom:0">Any concern about the
          delay time?</p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <p style="margin-top:0;margin-bottom:0">Best Regards</p>
        <p style="margin-top:0;margin-bottom:0">Rex<br>
        </p>
        <br>
        <div style="color: rgb(0, 0, 0);">
          <hr style="display:inline-block;width:98%" tabindex="-1">
          <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
              face="Calibri, sans-serif" color="#000000"><b>From:</b>
              amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on
              behalf of Rex Zhu <a class="moz-txt-link-rfc2396E" href="mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org">&lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              <b>Sent:</b> Monday, July 30, 2018 5:23 PM<br>
              <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <b>Cc:</b> Zhu, Rex<br>
              <b>Subject:</b> [PATCH v2 2/4] drm/amdgpu: Put enable gfx
              off feature to a delay thread</font>
            <div> </div>
          </div>
          <div class="BodyFragment"><font size="2"><span
                style="font-size:11pt;">
                <div class="PlainText">delay to enable gfx off feature
                  to avoid gfx on/off frequently<br>
                  suggested by Alex and Evan.<br>
                  <br>
                  Signed-off-by: Rex Zhu <a class="moz-txt-link-rfc2396E" href="mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org">&lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                  ---<br>
                   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++<br>
                   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15
                  +++++++++++++++<br>
                   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  8
                  ++++++--<br>
                   3 files changed, 23 insertions(+), 2 deletions(-)<br>
                  <br>
                  diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                  index 188bc53..ff16689 100644<br>
                  --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                  +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                  @@ -992,6 +992,8 @@ struct amdgpu_gfx {<br>
                           bool                           
                  gfx_off_state; /* true: enabled, false: disabled */<br>
                           struct mutex                   
                  gfx_off_mutex;<br>
                           uint32_t                       
                  gfx_off_req_count; /* default 1, enable gfx off: dec
                  1, disable gfx off: add 1 */<br>
                  +       struct delayed_work            
                  gfx_off_delay_work;<br>
                  +<br>
                           /* pipe reservation */<br>
                           struct mutex                   
                  pipe_reserve_mutex;<br>
                           DECLARE_BITMAP                 
                  (pipe_reserve_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);<br>
                  diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                  index 122653f..f6a6fb5 100644<br>
                  --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                  +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                  @@ -1925,6 +1925,19 @@ static void
                  amdgpu_device_ip_late_init_func_handler(struct
                  work_struct *work)<br>
                                   DRM_ERROR("ib ring test failed
                  (%d).\n", r);<br>
                   }<br>
                   <br>
                  +static void amdgpu_device_delay_enable_gfx_off(struct
                  work_struct *work)<br>
                  +{<br>
                  +       struct amdgpu_device *adev =<br>
                  +               container_of(work, struct
                  amdgpu_device, gfx.gfx_off_delay_work.work);<br>
                  +<br>
                  +       mutex_lock(&amp;adev-&gt;gfx.gfx_off_mutex);<br>
                  +       if (!adev-&gt;gfx.gfx_off_state &amp;&amp;
                  !adev-&gt;gfx.gfx_off_req_count) {<br>
                  +               if
                  (!amdgpu_dpm_set_powergating_by_smu(adev,
                  AMD_IP_BLOCK_TYPE_GFX, true))<br>
                  +                       adev-&gt;gfx.gfx_off_state =
                  true;<br>
                  +       }<br>
                  +       mutex_unlock(&amp;adev-&gt;gfx.gfx_off_mutex);<br>
                  +}<br>
                  +<br>
                   /**<br>
                    * amdgpu_device_ip_suspend_phase1 - run suspend for
                  hardware IPs (phase 1)<br>
                    *<br>
                  @@ -2394,6 +2407,8 @@ int amdgpu_device_init(struct
                  amdgpu_device *adev,<br>
                   <br>
                          
                  INIT_DELAYED_WORK(&amp;adev-&gt;late_init_work,<br>
                                            
                  amdgpu_device_ip_late_init_func_handler);<br>
                  +      
                  INIT_DELAYED_WORK(&amp;adev-&gt;gfx.gfx_off_delay_work,<br>
                  +                        
                  amdgpu_device_delay_enable_gfx_off);<br>
                   <br>
                           adev-&gt;gfx.gfx_off_req_count = 1;<br>
                           adev-&gt;pm.ac_power =
                  power_supply_is_system_supplied() &gt; 0 ? true :
                  false;<br>
                  diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
                  index 1cdb264..11d4d9f 100644<br>
                  --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
                  +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
                  @@ -26,6 +26,9 @@<br>
                   #include "amdgpu.h"<br>
                   #include "amdgpu_gfx.h"<br>
                   <br>
                  +/* 0.5 second timeout */<br>
                  +#define GFX_OFF_DELAY_ENABLE        
                  msecs_to_jiffies(500)<br>
                  +<br>
                   /*<br>
                    * GPU scratch registers helpers function.<br>
                    */<br>
                  @@ -360,6 +363,7 @@ void amdgpu_gfx_off_ctrl(struct
                  amdgpu_device *adev, bool enable)<br>
                           if
                  (!adev-&gt;powerplay.pp_funcs-&gt;set_powergating_by_smu)<br>
                                   return;<br>
                   <br>
                  +<br>
                           mutex_lock(&amp;adev-&gt;gfx.gfx_off_mutex);<br>
                   <br>
                           if (!enable)<br>
                  @@ -368,11 +372,11 @@ void amdgpu_gfx_off_ctrl(struct
                  amdgpu_device *adev, bool enable)<br>
                                   adev-&gt;gfx.gfx_off_req_count--;<br>
                   <br>
                           if (enable &amp;&amp;
                  !adev-&gt;gfx.gfx_off_state &amp;&amp;
                  !adev-&gt;gfx.gfx_off_req_count) {<br>
                  -               if
                  (!amdgpu_dpm_set_powergating_by_smu(adev,
                  AMD_IP_BLOCK_TYPE_GFX, true))<br>
                  -                       adev-&gt;gfx.gfx_off_state =
                  true;<br>
                  +              
                  schedule_delayed_work(&amp;adev-&gt;gfx.gfx_off_delay_work,
                  GFX_OFF_DELAY_ENABLE);<br>
                           } else if (!enable &amp;&amp;
                  adev-&gt;gfx.gfx_off_state) {<br>
                                   if
                  (!amdgpu_dpm_set_powergating_by_smu(adev,
                  AMD_IP_BLOCK_TYPE_GFX, false))<br>
                                           adev-&gt;gfx.gfx_off_state =
                  false;<br>
                           }<br>
                  +<br>
                          
                  mutex_unlock(&amp;adev-&gt;gfx.gfx_off_mutex);<br>
                   }<br>
                  -- <br>
                  1.9.1<br>
                  <br>
                  _______________________________________________<br>
                  amd-gfx mailing list<br>
                  <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                  <a
                    href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                    id="LPlnk310070" class="OWAAutoLink"
                    previewremoved="true" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
                  <div id="LPBorder_GT_15329462020160.38730110100591353"
                    style="margin-bottom: 20px; overflow: auto; width:
                    100%; text-indent: 0px;">
                    <table
                      id="LPContainer_15329462019920.183265909738499"
                      style="width: 90%; background-color: rgb(255, 255,
                      255); position: relative; overflow: auto;
                      padding-top: 20px; padding-bottom: 20px;
                      margin-top: 20px; border-top: 1px dotted rgb(200,
                      200, 200); border-bottom: 1px dotted rgb(200, 200,
                      200);" role="presentation" cellspacing="0">
                      <tbody>
                        <tr style="border-spacing: 0px;" valign="top">
                          <td
                            id="TextCell_15329462020140.9481943918689965"
                            style="vertical-align: top; position:
                            relative; padding: 0px; display:
                            table-cell;" colspan="2">
                            <div
                              id="LPTitle_15329462020140.9927739848518842"
                              style="top: 0px; color: rgb(0, 120, 215);
                              font-weight: 400; font-size: 21px;
                              font-family:
                              &quot;wf_segoe-ui_light&quot;, &quot;Segoe
                              UI Light&quot;, &quot;Segoe WP
                              Light&quot;, &quot;Segoe UI&quot;,
                              &quot;Segoe WP&quot;, Tahoma, Arial,
                              sans-serif; line-height: 21px;">
                              <a
                                id="LPUrlAnchor_15329462020140.8930778402849151"
                                style="text-decoration: none;"
                                href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                                target="_blank" moz-do-not-send="true">amd-gfx
                                Info Page - freedesktop.org</a></div>
                            <div
                              id="LPMetadata_15329462020140.5491656576271345"
                              style="margin: 10px 0px 16px; color:
                              rgb(102, 102, 102); font-weight: 400;
                              font-family:
                              &quot;wf_segoe-ui_normal&quot;,
                              &quot;Segoe UI&quot;, &quot;Segoe
                              WP&quot;, Tahoma, Arial, sans-serif;
                              font-size: 14px; line-height: 14px;">
                              lists.freedesktop.org</div>
                            <div
                              id="LPDescription_15329462020160.11393197229432894"
                              style="display: block; color: rgb(102,
                              102, 102); font-weight: 400; font-family:
                              &quot;wf_segoe-ui_normal&quot;,
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
                </div>
              </span></font></div>
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
    <br>
  </body>
</html>

--------------03BB4509046401240BD05AA1--

--===============1919968409==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1919968409==--
