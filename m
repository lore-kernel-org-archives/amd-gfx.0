From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 10/10] drm/amd/pp: Enable auto automan feature on Polaris
Date: Thu, 8 Feb 2018 16:35:16 +0000
Message-ID: <CY4PR12MB16870E53F3BC925170DD3F60FBF30@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1518081259-18120-1-git-send-email-Rex.Zhu@amd.com>
 <1518081259-18120-11-git-send-email-Rex.Zhu@amd.com>
 <CADnq5_Pme6WORs8Ns1DOhmXMSWWQHBkzkr=kWSF2_XqUakKQyg@mail.gmail.com>
 <CY4PR12MB1687A05815EB945E39F139F1FBF30@CY4PR12MB1687.namprd12.prod.outlook.com>,
 <CADnq5_M14etkDm6oZjDa+AF6eHgvjddy2-BZHZdXtWUd_+67AQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0904076318=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_M14etkDm6oZjDa+AF6eHgvjddy2-BZHZdXtWUd_+67AQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0904076318==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB16870E53F3BC925170DD3F60FBF30CY4PR12MB1687namp_"

--_000_CY4PR12MB16870E53F3BC925170DD3F60FBF30CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

>But in auto mode, we may want to force a particular profile within the
>driver for a specific use case.  E.g., for VR, we may want to select
>the VR profile when the user sets the priority to high in the context
>ioctl, and then switch it back to autowattman or the default profile
>when the context if freed or the priority is changes.  We may want to
>do something similar for video when the user submits work to the
>multi-media engines.

>  I guess it should just be
>a matter of disabling autowattman and switching to a profile when the
>driver needs it and then switching back when it's done.


Rex:

         For MM, we can disable auto wattman (if enabled), and set video pr=
ofile mode when enable uvd/vce dpm on smu7.

        restore to default when disable uvd/vce dpm when engine idle.



         VR, may be similar to compute case Eric have implemented, need use=
r ctrl through sysfs.



           Enter manual dpm mode(driver disable auto wattman), and select p=
refered profile mode, set sclk/mclk range(smu7).

            when enter auto dpm mode, restore default value.


>It's possible autowattman will perform ok and we
>don't need to manually change the profile in the driver, but we'll
>have to do some profiling to sorhat out.


Rex: Idealy, if autowan feature enabled, the proflling mode should be adjus=
ted based on workload with  some time delay caused by the work queue.

But need some time to verify.


Best Regards

Rex




________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, February 8, 2018 11:28 PM
To: Zhu, Rex
Cc: amd-gfx list
Subject: Re: [PATCH 10/10] drm/amd/pp: Enable auto automan feature on Polar=
is

On Thu, Feb 8, 2018 at 10:14 AM, Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> wrote:
> if user select manual dpm mode=1B$B!$=1B(Bwe will disabe autowattman.
> When switch to auto, we will restart the auto wattman on Polaris,
> Restore to default profile mode on other ASICS.
>

But in auto mode, we may want to force a particular profile within the
driver for a specific use case.  E.g., for VR, we may want to select
the VR profile when the user sets the priority to high in the context
ioctl, and then switch it back to autowattman or the default profile
when the context if freed or the priority is changes.  We may want to
do something similar for video when the user submits work to the
multi-media engines.  It's possible autowattman will perform ok and we
don't need to manually change the profile in the driver, but we'll
have to do some profiling to sort that out.  I guess it should just be
a matter of disabling autowattman and switching to a profile when the
driver needs it and then switching back when it's done.

Alex

>
> Best Regards
> Rex
> ________________________________
> From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Sent: Thursday, February 8, 2018 11:02:21 PM
> To: Zhu, Rex
> Cc: amd-gfx list
> Subject: Re: [PATCH 10/10] drm/amd/pp: Enable auto automan feature on
> Polaris
>
> On Thu, Feb 8, 2018 at 4:14 AM, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> wrote:
>> Change-Id: I69b24ce65ddb361a89e5ac9b197ae6df9b60a9e5
>> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
>
> Would be good to give a brief description of what autowattman actually
> does in the patch description.  Also, we may need to manually select a
> profile in some cases (e.g., VR).  Would that be a problem with
> autowattman?
>
> Alex
>
>> ---
>>  drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
>> b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
>> index f50b6cd..549e830 100644
>> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
>> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
>> @@ -1023,6 +1023,10 @@ int polaris_set_asic_special_caps(struct pp_hwmgr
>> *hwmgr)
>>                 phm_cap_set(hwmgr->platform_descriptor.platformCaps,
>>
>> PHM_PlatformCaps_TCPRamping);
>>         }
>> +
>> +       if (hwmgr->feature_mask & PP_AUTOWATTMAN_MASK)
>> +               hwmgr->autowattman_enabled =3D true; /* currently only
>> enabled on polaris */
>> +
>>         return 0;
>>  }
>>
>> --
>> 1.9.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...




--_000_CY4PR12MB16870E53F3BC925170DD3F60FBF30CY4PR12MB1687namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">&gt;But in auto mod=
e, we
 may want to force a particular profile within the</span><br style=3D"font-=
family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&=
quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&qu=
ot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">
<span style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quo=
t;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quo=
t;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size=
: 14.6667px;"><span style=3D"font-family: Calibri, Helvetica, sans-serif, E=
mojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoCo=
lorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymb=
ols; font-size: 14.6667px;">&gt;</span>driver
 for a specific use case.&nbsp; E.g., for VR, we may want to select</span><=
br style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;A=
pple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;S=
egoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size: 1=
4.6667px;">
<span style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quo=
t;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quo=
t;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size=
: 14.6667px;"><span style=3D"font-family: Calibri, Helvetica, sans-serif, E=
mojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoCo=
lorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymb=
ols; font-size: 14.6667px;">&gt;</span>the
 VR profile when the user sets the priority to high in the context</span><b=
r style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Ap=
ple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Se=
goe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size: 14=
.6667px;">
<span style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quo=
t;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quo=
t;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size=
: 14.6667px;"><span style=3D"font-family: Calibri, Helvetica, sans-serif, E=
mojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoCo=
lorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymb=
ols; font-size: 14.6667px;">&gt;</span>ioctl,
 and then switch it back to autowattman or the default profile</span><br st=
yle=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple =
Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe =
UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size: 14.666=
7px;">
<span style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quo=
t;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quo=
t;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size=
: 14.6667px;"><span style=3D"font-family: Calibri, Helvetica, sans-serif, E=
mojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoCo=
lorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymb=
ols; font-size: 14.6667px;">&gt;</span>when
 the context if freed or the priority is changes.&nbsp; We may want to</spa=
n><br style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quo=
t;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quo=
t;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size=
: 14.6667px;">
<span style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quo=
t;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quo=
t;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size=
: 14.6667px;"><span style=3D"font-family: Calibri, Helvetica, sans-serif, E=
mojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoCo=
lorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymb=
ols; font-size: 14.6667px;">&gt;</span>do
 something similar for video when the user submits work to the</span><br st=
yle=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple =
Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe =
UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size: 14.666=
7px;">
<span style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quo=
t;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quo=
t;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size=
: 14.6667px;"><span style=3D"font-family: Calibri, Helvetica, sans-serif, E=
mojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoCo=
lorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymb=
ols; font-size: 14.6667px;">&gt;</span>multi-media
 engines.&nbsp;</span><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;"><span style=3D"font=
-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji=
&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&q=
uot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">&gt;
 &nbsp;I guess it should just be</span><br style=3D"font-family: Calibri, H=
elvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe=
 UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android=
 Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">
<span style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quo=
t;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quo=
t;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size=
: 14.6667px;">&gt;a matter of disabling autowattman and switching to a prof=
ile
 when the</span><br style=3D"font-family: Calibri, Helvetica, sans-serif, E=
mojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoCo=
lorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymb=
ols; font-size: 14.6667px;">
<span style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quo=
t;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quo=
t;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size=
: 14.6667px;">&gt;driver needs it and then switching back when it's done.</=
span><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;"><span style=3D"font=
-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji=
&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&q=
uot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size: 14.6667px;"><br>
</span></span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">Rex:&nbsp;</span></=
p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">&nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp;For MM, we
 can disable auto wattman (if enabled), and&nbsp;set video profile mode whe=
n enable uvd/vce dpm on smu7.</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">&nbsp; &nbsp; &nbsp=
; &nbsp; restore to default
 when disable uvd/vce dpm when engine idle.</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">&nbsp;</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;"><span style=3D"font=
-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji=
&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&q=
uot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">&nbsp=
;
 &nbsp; &nbsp; &nbsp; &nbsp;VR, may be&nbsp;similar to compute case Eric ha=
ve&nbsp;</span><span style=3D"font-family: Calibri, Helvetica, sans-serif, =
EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoC=
olorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSym=
bols; font-size: 14.6667px;">implemented,&nbsp;</span></span><span style=3D=
"font-size: 14.6667px;">need
 user ctrl through sysfs.</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;"><span style=3D"font=
-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji=
&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&q=
uot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">&nbsp=
;
 &nbsp; &nbsp; &nbsp;</span></span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;"><span style=3D"font=
-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji=
&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&q=
uot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">&nbsp=
;
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Enter manual dpm mode(driver disable aut=
o wattman), and select prefered&nbsp;profile mode, set sclk/mclk range(smu7=
).</span></span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;"><span style=3D"font=
-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji=
&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&q=
uot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">&nbsp=
;
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; when enter auto dpm mode, restore defau=
lt value.&nbsp;</span></span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;"><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;"><span style=3D"font=
-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji=
&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&q=
uot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">&gt;I=
t's
 possible autowattman will perform ok and we</span><br style=3D"font-family=
: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,=
 &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &=
quot;Android Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">
<span style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quo=
t;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quo=
t;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size=
: 14.6667px;">&gt;don't need to manually change the profile in the driver, =
but
 we'll</span><br style=3D"font-family: Calibri, Helvetica, sans-serif, Emoj=
iFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColor=
Emoji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols=
; font-size: 14.6667px;">
<span style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quo=
t;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quo=
t;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size=
: 14.6667px;">&gt;have to do some profiling to sorhat out.&nbsp;</span>&nbs=
p; &nbsp; &nbsp; &nbsp;</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;"><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">Rex: Idealy, if aut=
owan
 feature enabled, the proflling mode should be adjusted based on workload w=
ith &nbsp;some&nbsp;time delay caused by the work queue.</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">But need some time =
to
 verify.</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;"><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">Best Regards</span>=
</p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">Rex</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;"><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;"><span style=3D"font=
-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji=
&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&q=
uot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">&nbsp=
;</span><br>
</span></p>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, February 8, 2018 11:28 PM<br>
<b>To:</b> Zhu, Rex<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> Re: [PATCH 10/10] drm/amd/pp: Enable auto automan feature o=
n Polaris</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Thu, Feb 8, 2018 at 10:14 AM, Zhu, Rex &lt;Rex.=
Zhu-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt; if user select manual dpm mode=1B$B!$=1B(Bwe will disabe autowattman.<=
br>
&gt; When switch to auto, we will restart the auto wattman on Polaris,<br>
&gt; Restore to default profile mode on other ASICS.<br>
&gt;<br>
<br>
But in auto mode, we may want to force a particular profile within the<br>
driver for a specific use case.&nbsp; E.g., for VR, we may want to select<b=
r>
the VR profile when the user sets the priority to high in the context<br>
ioctl, and then switch it back to autowattman or the default profile<br>
when the context if freed or the priority is changes.&nbsp; We may want to<=
br>
do something similar for video when the user submits work to the<br>
multi-media engines.&nbsp; It's possible autowattman will perform ok and we=
<br>
don't need to manually change the profile in the driver, but we'll<br>
have to do some profiling to sort that out.&nbsp; I guess it should just be=
<br>
a matter of disabling autowattman and switching to a profile when the<br>
driver needs it and then switching back when it's done.<br>
<br>
Alex<br>
<br>
&gt;<br>
&gt; Best Regards<br>
&gt; Rex<br>
&gt; ________________________________<br>
&gt; From: Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
&gt; Sent: Thursday, February 8, 2018 11:02:21 PM<br>
&gt; To: Zhu, Rex<br>
&gt; Cc: amd-gfx list<br>
&gt; Subject: Re: [PATCH 10/10] drm/amd/pp: Enable auto automan feature on<=
br>
&gt; Polaris<br>
&gt;<br>
&gt; On Thu, Feb 8, 2018 at 4:14 AM, Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt; wrote:=
<br>
&gt;&gt; Change-Id: I69b24ce65ddb361a89e5ac9b197ae6df9b60a9e5<br>
&gt;&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;<br>
&gt; Would be good to give a brief description of what autowattman actually=
<br>
&gt; does in the patch description.&nbsp; Also, we may need to manually sel=
ect a<br>
&gt; profile in some cases (e.g., VR).&nbsp; Would that be a problem with<b=
r>
&gt; autowattman?<br>
&gt;<br>
&gt; Alex<br>
&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c | 4 &#43;&#43;&#=
43;&#43;<br>
&gt;&gt;&nbsp; 1 file changed, 4 insertions(&#43;)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
&gt;&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
&gt;&gt; index f50b6cd..549e830 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
&gt;&gt; @@ -1023,6 &#43;1023,10 @@ int polaris_set_asic_special_caps(struc=
t pp_hwmgr<br>
&gt;&gt; *hwmgr)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_cap_set(hwmgr-&gt;platform_descriptor.pla=
tformCaps,<br>
&gt;&gt;<br>
&gt;&gt; PHM_PlatformCaps_TCPRamping);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;feature_ma=
sk &amp; PP_AUTOWATTMAN_MASK)<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;autowattman_enabled =3D true; /* currentl=
y only<br>
&gt;&gt; enabled on polaris */<br>
&gt;&gt; &#43;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; 1.9.1<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; amd-gfx mailing list<br>
&gt;&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 id=3D"LPlnk701098" previewremoved=3D"true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15181063864470.00843799685583213" style=3D"margin-bo=
ttom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15181063864440.7826349524682992" role=3D"presentat=
ion" cellspacing=3D"0" style=3D"width: 90%; background-color: rgb(255, 255,=
 255); position: relative; overflow: auto; padding-top: 20px; padding-botto=
m: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200); borde=
r-bottom: 1px dotted rgb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_15181063864450.20973627117231164" colspan=3D"2" style=3D=
"vertical-align: top; position: relative; padding: 0px; display: table-cell=
;">
<div id=3D"LPRemovePreviewContainer_15181063864450.8159857358513902"></div>
<div id=3D"LPTitle_15181063864450.5421321631930409" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: normal; font-size: 21px; font-family: wf_=
segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-he=
ight: 21px;">
<a id=3D"LPUrlAnchor_15181063864460.047752596355657095" href=3D"https://lis=
ts.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"tex=
t-decoration: none;">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15181063864460.030891965966879598" style=3D"margin: 1=
0px 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: =
wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Ari=
al, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15181063864460.8458243757989772" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_seg=
oe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sa=
ns-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow: =
hidden;">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...</div>
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
</body>
</html>

--_000_CY4PR12MB16870E53F3BC925170DD3F60FBF30CY4PR12MB1687namp_--

--===============0904076318==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0904076318==--
