From: Eric Huang <jinhuieric.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 10/10] drm/amd/pp: Enable auto automan feature on Polaris
Date: Thu, 8 Feb 2018 11:47:05 -0500
Message-ID: <e7fa8f4e-ec12-d953-8541-681d94ca0961@amd.com>
References: <1518081259-18120-1-git-send-email-Rex.Zhu@amd.com>
 <1518081259-18120-11-git-send-email-Rex.Zhu@amd.com>
 <CADnq5_Pme6WORs8Ns1DOhmXMSWWQHBkzkr=kWSF2_XqUakKQyg@mail.gmail.com>
 <CY4PR12MB1687A05815EB945E39F139F1FBF30@CY4PR12MB1687.namprd12.prod.outlook.com>
 <CADnq5_M14etkDm6oZjDa+AF6eHgvjddy2-BZHZdXtWUd_+67AQ@mail.gmail.com>
 <CY4PR12MB16870E53F3BC925170DD3F60FBF30@CY4PR12MB1687.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0306504416=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB16870E53F3BC925170DD3F60FBF30-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============0306504416==
Content-Type: multipart/alternative;
 boundary="------------6DE9AF9D10FE6D6CA91F52A2"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------6DE9AF9D10FE6D6CA91F52A2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2018-02-08 11:35 AM, Zhu, Rex wrote:
>
> >But in auto mode, we may want to force a particular profile within the
> >driver for a specific use case.  E.g., for VR, we may want to select
> >the VR profile when the user sets the priority to high in the context
> >ioctl, and then switch it back to autowattman or the default profile
> >when the context if freed or the priority is changes.  We may want to
> >do something similar for video when the user submits work to the
> >multi-media engines.
>
> >  I guess it should just be
> >a matter of disabling autowattman and switching to a profile when the
> >driver needs it and then switching back when it's done.
>
>
> Rex:
>
>          For MM, we can disable auto wattman (if enabled), and set 
> video profile mode when enable uvd/vce dpm on smu7.
>
>         restore to default when disable uvd/vce dpm when engine idle.
>
>          VR, may be similar to compute case Eric have implemented, 
> need user ctrl through sysfs.
>

In case of compute, we have auto switching mechanism. when compute ring 
is coming, it switches to the default compute profile or user set 
profile, and switches back when it's done. So VR should be doing the 
same thing with compute. Auto wattman will be disabled when profile auto 
switching happens.

Regards,
Eric

>            Enter manual dpm mode(driver disable auto wattman), and 
> select prefered profile mode, set sclk/mclk range(smu7).
>
>             when enter auto dpm mode, restore default value.
>
>
> >It's possible autowattman will perform ok and we
> >don't need to manually change the profile in the driver, but we'll
> >have to do some profiling to sorhat out. 
>
>
> Rex: Idealy, if autowan feature enabled, the proflling mode should be 
> adjusted based on workload with  some time delay caused by the work queue.
>
> But need some time to verify.
>
>
> Best Regards
>
> Rex
>
>
>
> ------------------------------------------------------------------------
> *From:* Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Thursday, February 8, 2018 11:28 PM
> *To:* Zhu, Rex
> *Cc:* amd-gfx list
> *Subject:* Re: [PATCH 10/10] drm/amd/pp: Enable auto automan feature 
> on Polaris
> On Thu, Feb 8, 2018 at 10:14 AM, Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> wrote:
> > if user select manual dpm mode，we will disabe autowattman.
> > When switch to auto, we will restart the auto wattman on Polaris,
> > Restore to default profile mode on other ASICS.
> >
>
> But in auto mode, we may want to force a particular profile within the
> driver for a specific use case.  E.g., for VR, we may want to select
> the VR profile when the user sets the priority to high in the context
> ioctl, and then switch it back to autowattman or the default profile
> when the context if freed or the priority is changes. We may want to
> do something similar for video when the user submits work to the
> multi-media engines.  It's possible autowattman will perform ok and we
> don't need to manually change the profile in the driver, but we'll
> have to do some profiling to sort that out.  I guess it should just be
> a matter of disabling autowattman and switching to a profile when the
> driver needs it and then switching back when it's done.
>
> Alex
>
> >
> > Best Regards
> > Rex
> > ________________________________
> > From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Sent: Thursday, February 8, 2018 11:02:21 PM
> > To: Zhu, Rex
> > Cc: amd-gfx list
> > Subject: Re: [PATCH 10/10] drm/amd/pp: Enable auto automan feature on
> > Polaris
> >
> > On Thu, Feb 8, 2018 at 4:14 AM, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> wrote:
> >> Change-Id: I69b24ce65ddb361a89e5ac9b197ae6df9b60a9e5
> >> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> >
> > Would be good to give a brief description of what autowattman actually
> > does in the patch description.  Also, we may need to manually select a
> > profile in some cases (e.g., VR).  Would that be a problem with
> > autowattman?
> >
> > Alex
> >
> >> ---
> >>  drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
> >> b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
> >> index f50b6cd..549e830 100644
> >> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
> >> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
> >> @@ -1023,6 +1023,10 @@ int polaris_set_asic_special_caps(struct 
> pp_hwmgr
> >> *hwmgr)
> >> phm_cap_set(hwmgr->platform_descriptor.platformCaps,
> >>
> >> PHM_PlatformCaps_TCPRamping);
> >>         }
> >> +
> >> +       if (hwmgr->feature_mask & PP_AUTOWATTMAN_MASK)
> >> +               hwmgr->autowattman_enabled = true; /* currently only
> >> enabled on polaris */
> >> +
> >>         return 0;
> >>  }
> >>
> >> --
> >> 1.9.1
> >>
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> amd-gfx Info Page - freedesktop.org 
> <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
> lists.freedesktop.org
> Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the 
> following form. Use of all freedesktop.org lists is subject to our 
> Code of ...
>
>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------6DE9AF9D10FE6D6CA91F52A2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 2018-02-08 11:35 AM, Zhu, Rex wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CY4PR12MB16870E53F3BC925170DD3F60FBF30-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <p style="margin-top:0;margin-bottom:0"><span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;">&gt;But in auto mode, we may want to force a
            particular profile within the</span><br style="font-family:
            Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color
            Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji,
            &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;,
            EmojiSymbols; font-size: 14.6667px;">
          <span style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;"><span style="font-family: Calibri, Helvetica,
              sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,
              &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI
              Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;
              font-size: 14.6667px;">&gt;</span>driver for a specific
            use case.  E.g., for VR, we may want to select</span><br
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;">
          <span style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;"><span style="font-family: Calibri, Helvetica,
              sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,
              &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI
              Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;
              font-size: 14.6667px;">&gt;</span>the VR profile when the
            user sets the priority to high in the context</span><br
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;">
          <span style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;"><span style="font-family: Calibri, Helvetica,
              sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,
              &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI
              Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;
              font-size: 14.6667px;">&gt;</span>ioctl, and then switch
            it back to autowattman or the default profile</span><br
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;">
          <span style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;"><span style="font-family: Calibri, Helvetica,
              sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,
              &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI
              Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;
              font-size: 14.6667px;">&gt;</span>when the context if
            freed or the priority is changes.  We may want to</span><br
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;">
          <span style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;"><span style="font-family: Calibri, Helvetica,
              sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,
              &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI
              Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;
              font-size: 14.6667px;">&gt;</span>do something similar for
            video when the user submits work to the</span><br
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;">
          <span style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;"><span style="font-family: Calibri, Helvetica,
              sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,
              &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI
              Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;
              font-size: 14.6667px;">&gt;</span>multi-media engines. </span><br>
        </p>
        <p style="margin-top:0;margin-bottom:0"><span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;"><span style="font-family: Calibri, Helvetica,
              sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,
              &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI
              Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;
              font-size: 14.6667px;">&gt;  I guess it should just be</span><br
              style="font-family: Calibri, Helvetica, sans-serif,
              EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
              Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
              &quot;Android Emoji&quot;, EmojiSymbols; font-size:
              14.6667px;">
            <span style="font-family: Calibri, Helvetica, sans-serif,
              EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
              Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
              &quot;Android Emoji&quot;, EmojiSymbols; font-size:
              14.6667px;">&gt;a matter of disabling autowattman and
              switching to a profile when the</span><br
              style="font-family: Calibri, Helvetica, sans-serif,
              EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
              Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
              &quot;Android Emoji&quot;, EmojiSymbols; font-size:
              14.6667px;">
            <span style="font-family: Calibri, Helvetica, sans-serif,
              EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
              Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
              &quot;Android Emoji&quot;, EmojiSymbols; font-size:
              14.6667px;">&gt;driver needs it and then switching back
              when it's done.</span><br>
          </span></p>
        <p style="margin-top:0;margin-bottom:0"><span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;"><span style="font-family: Calibri, Helvetica,
              sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,
              &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI
              Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;
              font-size: 14.6667px;"><br>
            </span></span></p>
        <p style="margin-top:0;margin-bottom:0"><span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;">Rex: </span></p>
        <p style="margin-top:0;margin-bottom:0"><span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;">         For MM, we can disable auto wattman (if
            enabled), and set video profile mode when enable uvd/vce dpm
            on smu7.</span></p>
        <p style="margin-top:0;margin-bottom:0"><span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;">        restore to default when disable uvd/vce
            dpm when engine idle.</span></p>
        <p style="margin-top:0;margin-bottom:0"><span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;"> </span></p>
        <p style="margin-top:0;margin-bottom:0"><span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;"><span style="font-family: Calibri, Helvetica,
              sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,
              &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI
              Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;
              font-size: 14.6667px;">         VR, may be similar to
              compute case Eric have </span><span style="font-family:
              Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple
              Color Emoji&quot;, &quot;Segoe UI Emoji&quot;,
              NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android
              Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">implemented, </span></span><span
            style="font-size: 14.6667px;">need user ctrl through sysfs.</span></p>
      </div>
    </blockquote>
    <br>
    In case of compute, we have auto switching mechanism. when compute
    ring is coming, it switches to the default compute profile or user
    set profile, and switches back when it's done. So VR should be doing
    the same thing with compute. Auto wattman will be disabled when
    profile auto switching happens.<br>
    <br>
    Regards,<br>
    Eric<br>
    <span style="font-family: Calibri, Helvetica, sans-serif, EmojiFont,
      &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;,
      NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android
      Emoji&quot;, EmojiSymbols; font-size: 14.6667px;"><span
        style="font-family: Calibri, Helvetica, sans-serif, EmojiFont,
        &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;,
        NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android
        Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">       <br>
      </span></span>
    <blockquote type="cite"
cite="mid:CY4PR12MB16870E53F3BC925170DD3F60FBF30-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <p style="margin-top:0;margin-bottom:0"><span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;"><span style="font-family: Calibri, Helvetica,
              sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,
              &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI
              Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;
              font-size: 14.6667px;">           Enter manual dpm
              mode(driver disable auto wattman), and select
              prefered profile mode, set sclk/mclk range(smu7).</span></span></p>
        <p style="margin-top:0;margin-bottom:0"><span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;"><span style="font-family: Calibri, Helvetica,
              sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,
              &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI
              Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;
              font-size: 14.6667px;">            when enter auto dpm
              mode, restore default value. </span></span></p>
        <p style="margin-top:0;margin-bottom:0"><span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;"><br>
          </span></p>
        <p style="margin-top:0;margin-bottom:0"><span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;"><span style="font-family: Calibri, Helvetica,
              sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,
              &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI
              Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;
              font-size: 14.6667px;">&gt;It's possible autowattman will
              perform ok and we</span><br style="font-family: Calibri,
              Helvetica, sans-serif, EmojiFont, &quot;Apple Color
              Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji,
              &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;,
              EmojiSymbols; font-size: 14.6667px;">
            <span style="font-family: Calibri, Helvetica, sans-serif,
              EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
              Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
              &quot;Android Emoji&quot;, EmojiSymbols; font-size:
              14.6667px;">&gt;don't need to manually change the profile
              in the driver, but we'll</span><br style="font-family:
              Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple
              Color Emoji&quot;, &quot;Segoe UI Emoji&quot;,
              NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android
              Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">
            <span style="font-family: Calibri, Helvetica, sans-serif,
              EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
              Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
              &quot;Android Emoji&quot;, EmojiSymbols; font-size:
              14.6667px;">&gt;have to do some profiling to sorhat out. </span> 
                 </span></p>
        <p style="margin-top:0;margin-bottom:0"><span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;"><br>
          </span></p>
        <p style="margin-top:0;margin-bottom:0"><span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;">Rex: Idealy, if autowan feature enabled, the
            proflling mode should be adjusted based on workload with
             some time delay caused by the work queue.</span></p>
        <p style="margin-top:0;margin-bottom:0"><span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;">But need some time to verify.</span></p>
        <p style="margin-top:0;margin-bottom:0"><span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;"><br>
          </span></p>
        <p style="margin-top:0;margin-bottom:0"><span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;">Best Regards</span></p>
        <p style="margin-top:0;margin-bottom:0"><span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;">Rex</span></p>
        <p style="margin-top:0;margin-bottom:0"><span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;"><br>
          </span></p>
        <p style="margin-top:0;margin-bottom:0"><span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;"><span style="font-family: Calibri, Helvetica,
              sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,
              &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI
              Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;
              font-size: 14.6667px;"> </span><br>
          </span></p>
        <div style="color: rgb(0, 0, 0);">
          <hr style="display:inline-block;width:98%" tabindex="-1">
          <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
              face="Calibri, sans-serif" color="#000000"><b>From:</b>
              Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
              <b>Sent:</b> Thursday, February 8, 2018 11:28 PM<br>
              <b>To:</b> Zhu, Rex<br>
              <b>Cc:</b> amd-gfx list<br>
              <b>Subject:</b> Re: [PATCH 10/10] drm/amd/pp: Enable auto
              automan feature on Polaris</font>
            <div> </div>
          </div>
          <div class="BodyFragment"><font size="2"><span
                style="font-size:11pt;">
                <div class="PlainText">On Thu, Feb 8, 2018 at 10:14 AM,
                  Zhu, Rex <a class="moz-txt-link-rfc2396E" href="mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org">&lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a> wrote:<br>
                  &gt; if user select manual dpm mode，we will disabe
                  autowattman.<br>
                  &gt; When switch to auto, we will restart the auto
                  wattman on Polaris,<br>
                  &gt; Restore to default profile mode on other ASICS.<br>
                  &gt;<br>
                  <br>
                  But in auto mode, we may want to force a particular
                  profile within the<br>
                  driver for a specific use case.  E.g., for VR, we may
                  want to select<br>
                  the VR profile when the user sets the priority to high
                  in the context<br>
                  ioctl, and then switch it back to autowattman or the
                  default profile<br>
                  when the context if freed or the priority is changes. 
                  We may want to<br>
                  do something similar for video when the user submits
                  work to the<br>
                  multi-media engines.  It's possible autowattman will
                  perform ok and we<br>
                  don't need to manually change the profile in the
                  driver, but we'll<br>
                  have to do some profiling to sort that out.  I guess
                  it should just be<br>
                  a matter of disabling autowattman and switching to a
                  profile when the<br>
                  driver needs it and then switching back when it's
                  done.<br>
                  <br>
                  Alex<br>
                  <br>
                  &gt;<br>
                  &gt; Best Regards<br>
                  &gt; Rex<br>
                  &gt; ________________________________<br>
                  &gt; From: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
                  &gt; Sent: Thursday, February 8, 2018 11:02:21 PM<br>
                  &gt; To: Zhu, Rex<br>
                  &gt; Cc: amd-gfx list<br>
                  &gt; Subject: Re: [PATCH 10/10] drm/amd/pp: Enable
                  auto automan feature on<br>
                  &gt; Polaris<br>
                  &gt;<br>
                  &gt; On Thu, Feb 8, 2018 at 4:14 AM, Rex Zhu
                  <a class="moz-txt-link-rfc2396E" href="mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org">&lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a> wrote:<br>
                  &gt;&gt; Change-Id:
                  I69b24ce65ddb361a89e5ac9b197ae6df9b60a9e5<br>
                  &gt;&gt; Signed-off-by: Rex Zhu
                  <a class="moz-txt-link-rfc2396E" href="mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org">&lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                  &gt;<br>
                  &gt; Would be good to give a brief description of what
                  autowattman actually<br>
                  &gt; does in the patch description.  Also, we may need
                  to manually select a<br>
                  &gt; profile in some cases (e.g., VR).  Would that be
                  a problem with<br>
                  &gt; autowattman?<br>
                  &gt;<br>
                  &gt; Alex<br>
                  &gt;<br>
                  &gt;&gt; ---<br>
                  &gt;&gt;  drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
                  | 4 ++++<br>
                  &gt;&gt;  1 file changed, 4 insertions(+)<br>
                  &gt;&gt;<br>
                  &gt;&gt; diff --git
                  a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
                  &gt;&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
                  &gt;&gt; index f50b6cd..549e830 100644<br>
                  &gt;&gt; ---
                  a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
                  &gt;&gt; +++
                  b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
                  &gt;&gt; @@ -1023,6 +1023,10 @@ int
                  polaris_set_asic_special_caps(struct pp_hwmgr<br>
                  &gt;&gt; *hwmgr)<br>
                  &gt;&gt;                
                  phm_cap_set(hwmgr-&gt;platform_descriptor.platformCaps,<br>
                  &gt;&gt;<br>
                  &gt;&gt; PHM_PlatformCaps_TCPRamping);<br>
                  &gt;&gt;         }<br>
                  &gt;&gt; +<br>
                  &gt;&gt; +       if (hwmgr-&gt;feature_mask &amp;
                  PP_AUTOWATTMAN_MASK)<br>
                  &gt;&gt; +               hwmgr-&gt;autowattman_enabled
                  = true; /* currently only<br>
                  &gt;&gt; enabled on polaris */<br>
                  &gt;&gt; +<br>
                  &gt;&gt;         return 0;<br>
                  &gt;&gt;  }<br>
                  &gt;&gt;<br>
                  &gt;&gt; --<br>
                  &gt;&gt; 1.9.1<br>
                  &gt;&gt;<br>
                  &gt;&gt;
                  _______________________________________________<br>
                  &gt;&gt; amd-gfx mailing list<br>
                  &gt;&gt; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                  &gt;&gt; <a
                    href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                    id="LPlnk701098" previewremoved="true"
                    moz-do-not-send="true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
                  <div id="LPBorder_GT_15181063864470.00843799685583213"
                    style="margin-bottom: 20px; overflow: auto; width:
                    100%; text-indent: 0px;">
                    <table
                      id="LPContainer_15181063864440.7826349524682992"
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
                            id="TextCell_15181063864450.20973627117231164"
                            colspan="2" style="vertical-align: top;
                            position: relative; padding: 0px; display:
                            table-cell;">
                            <div
                              id="LPTitle_15181063864450.5421321631930409"
                              style="top: 0px; color: rgb(0, 120, 215);
                              font-weight: normal; font-size: 21px;
                              font-family: wf_segoe-ui_light,
                              &quot;Segoe UI Light&quot;, &quot;Segoe WP
                              Light&quot;, &quot;Segoe UI&quot;,
                              &quot;Segoe WP&quot;, Tahoma, Arial,
                              sans-serif; line-height: 21px;">
                              <a
                                id="LPUrlAnchor_15181063864460.047752596355657095"
href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                                target="_blank" style="text-decoration:
                                none;" moz-do-not-send="true">amd-gfx
                                Info Page - freedesktop.org</a></div>
                            <div
                              id="LPMetadata_15181063864460.030891965966879598"
                              style="margin: 10px 0px 16px; color:
                              rgb(102, 102, 102); font-weight: normal;
                              font-family: wf_segoe-ui_normal,
                              &quot;Segoe UI&quot;, &quot;Segoe
                              WP&quot;, Tahoma, Arial, sans-serif;
                              font-size: 14px; line-height: 14px;">
                              lists.freedesktop.org</div>
                            <div
                              id="LPDescription_15181063864460.8458243757989772"
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
                              subject to our Code of ...</div>
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

--------------6DE9AF9D10FE6D6CA91F52A2--

--===============0306504416==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0306504416==--
