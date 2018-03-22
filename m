From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/6] drm/amd/pp: Lock powerplay when reset pp table
Date: Thu, 22 Mar 2018 09:47:52 -0400
Message-ID: <CADnq5_MPgAwdVj_5YrpxvnYkjAQkZmrYwse_s0w2rNF6xD3X=A@mail.gmail.com>
References: <1521718818-22687-1-git-send-email-Rex.Zhu@amd.com>
 <1521718818-22687-3-git-send-email-Rex.Zhu@amd.com>
 <CADnq5_PoA0JtqbsepaX0D0RMxTwDi89Uw9DHmvL7tzXduk_EaA@mail.gmail.com>
 <CY4PR12MB16878FF235D78E9C0A3A722BFBA90@CY4PR12MB1687.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0068681189=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB16878FF235D78E9C0A3A722BFBA90-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0068681189==
Content-Type: multipart/alternative; boundary="94eb2c1307dee2f3b90568008d0c"

--94eb2c1307dee2f3b90568008d0c
Content-Type: text/plain; charset="UTF-8"

On Thu, Mar 22, 2018 at 9:44 AM, Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> wrote:

> Please see inline.
>
> Best Regards
> Rex
> ------------------------------
> *From:* Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Thursday, March 22, 2018 9:17 PM
> *To:* Zhu, Rex
> *Cc:* amd-gfx list
> *Subject:* Re: [PATCH 3/6] drm/amd/pp: Lock powerplay when reset pp table
>
> On Thu, Mar 22, 2018 at 7:40 AM, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> wrote:
> > Change-Id: Ib02cd71593bee9606822a466a56f2d01ac2e04cc
> > Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
>
> Please include a commit description.  It's not clear to me what's
> happening here.
>
> Alex
>
> > ---
> >  drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 28
> +++++++++++++--------------
> >  1 file changed, 14 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> > index 5d7d9ec..1ae4905 100644
> > --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> > +++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> > @@ -31,8 +31,6 @@
> >  #include "amdgpu.h"
> >  #include "hwmgr.h"
> >
> > -static int pp_dpm_dispatch_tasks(void *handle, enum amd_pp_task task_id,
> > -               enum amd_pm_state_type *user_state);
> >
> >  static const struct amd_pm_funcs pp_dpm_funcs;
> >
> > @@ -146,10 +144,12 @@ static int pp_late_init(void *handle)
> >         struct amdgpu_device *adev = handle;
> >         struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
> >
> > -       if (hwmgr && hwmgr->pm_en)
> > -               pp_dpm_dispatch_tasks(hwmgr,
> > +       if (hwmgr && hwmgr->pm_en) {
> > +               mutex_lock(&hwmgr->smu_lock);
> > +               hwmgr_handle_task(hwmgr,
> >                                         AMD_PP_TASK_COMPLETE_INIT,
> NULL);
> > -
> > +               mutex_unlock(&hwmgr->smu_lock);
> > +       }
> >         return 0;
> >  }
>
> Rex : use hwmgr_handle_task instand of  pp_dpm_dispatch_tasks. because i
> think it is not make sense that call
> pp_function in ip_function.
>
> > @@ -620,7 +620,7 @@ static int amd_powerplay_reset(void *handle)
> >  static int pp_dpm_set_pp_table(void *handle, const char *buf, size_t
> size)
> >  {
> >         struct pp_hwmgr *hwmgr = handle;
> > -       int ret = 0;
> > +       int ret = -ENOMEM;
> >
> >         if (!hwmgr || !hwmgr->pm_en)
> >                 return -EINVAL;
> > @@ -630,28 +630,28 @@ static int pp_dpm_set_pp_table(void *handle, const
> char *buf, size_t size)
> >                 hwmgr->hardcode_pp_table = kmemdup(hwmgr->soft_pp_table,
> >
> hwmgr->soft_pp_table_size,
> >                                                    GFP_KERNEL);
> > -               if (!hwmgr->hardcode_pp_table) {
> > -                       mutex_unlock(&hwmgr->smu_lock);
> > -                       return -ENOMEM;
> > -               }
> > +               if (!hwmgr->hardcode_pp_table)
> > +                       goto err;
> >         }
> >
> >         memcpy(hwmgr->hardcode_pp_table, buf, size);
> >
> >         hwmgr->soft_pp_table = hwmgr->hardcode_pp_table;
> > -       mutex_unlock(&hwmgr->smu_lock);
> >
> >         ret = amd_powerplay_reset(handle);
> >         if (ret)
> > -               return ret;
> > +               goto err;
> >
> >         if (hwmgr->hwmgr_func->avfs_control) {
> >                 ret = hwmgr->hwmgr_func->avfs_control(hwmgr, false);
> >                 if (ret)
> > -                       return ret;
> > +                       goto err;
> >         }
> > -
> > +       mutex_unlock(&hwmgr->smu_lock);
> >         return 0;
> > +err:
> > +       mutex_unlock(&hwmgr->smu_lock);
> > +       return ret;
> >  }
>
>
> Rex: unlock mutex until  set pp table complete to avoid other pp functions
> were called simultaneously
> <http://www.baidu.com/link?url=8RpXVOm53HQyZI9h-ZIs8Ipio9NEDj98vxJiiM0Wx4hbUUpanLuj7jZHEnm0Javd7_rpySIGVAwaxX_ICV-y2nDz_TZqF8mzUGZT8RPrw2WCcNsGFsoAh9nirArCSm9s>
> .
>

Thanks.  Please include these comments in the patch description.  With that
fixed:
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>


>
>
> >  static int pp_dpm_force_clock_level(void *handle,
> > --
> > 1.9.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9xlNPtJONSTn@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> amd-gfx Info Page - freedesktop.org
> <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
> lists.freedesktop.org
> Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following
> form. Use of all freedesktop.org lists is subject to our Code of ...
>
>
>

--94eb2c1307dee2f3b90568008d0c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><div class=3D"gmail_quote">=
On Thu, Mar 22, 2018 at 9:44 AM, Zhu, Rex <span dir=3D"ltr">&lt;<a href=3D"=
mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Rex.Zhu-5C7GfCeVMHo@public.gmane.org</a>&gt;</span> wr=
ote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">




<div dir=3D"ltr">
<div id=3D"m_-3969800545744392271divtagdefaultwrapper" style=3D"font-size:1=
2pt;color:#000000;font-family:Calibri,Helvetica,sans-serif" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Please see inline.</p>
<br>
Best Regards
<div>Rex<br>
<div style=3D"color:rgb(0,0,0)">
<hr style=3D"display:inline-block;width:98%">
<div id=3D"m_-3969800545744392271divRplyFwdMsg" dir=3D"ltr"><font style=3D"=
font-size:11pt" face=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b>=
 Alex Deucher &lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank=
">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Thursday, March 22, 2018 9:17 PM<br>
<b>To:</b> Zhu, Rex<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> Re: [PATCH 3/6] drm/amd/pp: Lock powerplay when reset pp ta=
ble</font>
<div>=C2=A0</div>
</div>
<div class=3D"m_-3969800545744392271BodyFragment"><font size=3D"2"><span st=
yle=3D"font-size:11pt">
<div class=3D"m_-3969800545744392271PlainText"><div><div class=3D"h5">On Th=
u, Mar 22, 2018 at 7:40 AM, Rex Zhu &lt;<a href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" =
target=3D"_blank">Rex.Zhu-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br>
&gt; Change-Id: Ib02cd71593bee9606822a466a56f2<wbr>d01ac2e04cc<br>
&gt; Signed-off-by: Rex Zhu &lt;<a href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" target=
=3D"_blank">Rex.Zhu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<br>
Please include a commit description.=C2=A0 It&#39;s not clear to me what&#3=
9;s<br>
happening here.<br>
<br>
Alex<br>
<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/powerplay/<wbr>amd_powerplay.c | 28 ++++++++=
+++++--------------<br>
&gt;=C2=A0 1 file changed, 14 insertions(+), 14 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/<wbr>powerplay/amd_powerplay.c b/driv=
ers/gpu/drm/amd/<wbr>powerplay/amd_powerplay.c<br>
&gt; index 5d7d9ec..1ae4905 100644<br>
&gt; --- a/drivers/gpu/drm/amd/<wbr>powerplay/amd_powerplay.c<br>
&gt; +++ b/drivers/gpu/drm/amd/<wbr>powerplay/amd_powerplay.c<br>
&gt; @@ -31,8 +31,6 @@<br>
&gt;=C2=A0 #include &quot;amdgpu.h&quot;<br>
&gt;=C2=A0 #include &quot;hwmgr.h&quot;<br>
&gt;<br>
&gt; -static int pp_dpm_dispatch_tasks(void *handle, enum amd_pp_task task_=
id,<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 enum amd_pm_state_type *user_state);<br>
&gt;<br>
&gt;=C2=A0 static const struct amd_pm_funcs pp_dpm_funcs;<br>
&gt;<br>
&gt; @@ -146,10 +144,12 @@ static int pp_late_init(void *handle)<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_device *=
adev =3D handle;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pp_hwmgr *hwmgr=
 =3D adev-&gt;powerplay.pp_handle;<br>
&gt;<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (hwmgr &amp;&amp; hwmgr-&gt;p=
m_en)<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pp_dpm_dispatch_tasks(hwmgr,<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (hwmgr &amp;&amp; hwmgr-&gt;p=
m_en) {<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 mutex_lock(&amp;hwmgr-&gt;smu_lock);<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 hwmgr_handle_task(hwmgr,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 AMD_PP_TASK_COMPLETE_INIT, NULL);<br>
&gt; -<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 mutex_unlock(&amp;hwmgr-&gt;smu_lock)<wbr>;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;<br>
&gt;=C2=A0 }<br>
<br></div></div>
Rex : use=C2=A0<span style=3D"font-family:Calibri,Helvetica,sans-serif,Emoj=
iFont,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmo=
ji,&quot;Segoe UI Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols;font-=
size:14.6667px">hwmgr_handle_task instand of =C2=A0<span style=3D"font-fami=
ly:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Apple Color Emoji&quot;,&qu=
ot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI Symbol&quot;,&quot;An=
droid Emoji&quot;,EmojiSymbols;font-size:14.6667px">pp_dpm_dispatch_tasks.
 because i think it is not make sense that=C2=A0call=C2=A0</span></span></d=
iv>
<div class=3D"m_-3969800545744392271PlainText"><span style=3D"font-family:C=
alibri,Helvetica,sans-serif,EmojiFont,&quot;Apple Color Emoji&quot;,&quot;S=
egoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI Symbol&quot;,&quot;Androi=
d Emoji&quot;,EmojiSymbols;font-size:14.6667px"><span style=3D"font-family:=
Calibri,Helvetica,sans-serif,EmojiFont,&quot;Apple Color Emoji&quot;,&quot;=
Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI Symbol&quot;,&quot;Andro=
id Emoji&quot;,EmojiSymbols;font-size:14.6667px">pp_function
 in ip_function.=C2=A0</span></span></div>
<div class=3D"m_-3969800545744392271PlainText"><div><div class=3D"h5">=C2=
=A0<br>
&gt; @@ -620,7 +620,7 @@ static int amd_powerplay_reset(void *handle)<br>
&gt;=C2=A0 static int pp_dpm_set_pp_table(void *handle, const char *buf, si=
ze_t size)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pp_hwmgr *hwmgr=
 =3D handle;<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D 0;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D -ENOMEM;<br>
&gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!hwmgr || !hwmgr-&=
gt;pm_en)<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;<br>
&gt; @@ -630,28 +630,28 @@ static int pp_dpm_set_pp_table(void *handle, con=
st char *buf, size_t size)<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwmgr-&gt;hardcode_pp_table =3D kmemdup(hwmgr-&=
gt;soft_pp_table,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 hwmgr-&gt;soft_pp_table_size,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 GFP_KERNEL);<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (!hwmgr-&gt;hardcode_pp_table) {<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unloc=
k(&amp;hwmgr-&gt;smu_lock)<wbr>;<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENO=
MEM;<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 }<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (!hwmgr-&gt;hardcode_pp_table)<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err;<b=
r>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(hwmgr-&gt;hardc=
ode_pp_<wbr>table, buf, size);<br>
&gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwmgr-&gt;soft_pp_tabl=
e =3D hwmgr-&gt;hardcode_pp_table;<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&amp;hwmgr-&gt;smu_=
lock)<wbr>;<br>
&gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D amd_powerplay_=
reset(handle);<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return ret;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto err;<br>
&gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (hwmgr-&gt;hwmgr_fu=
nc-&gt;avfs_<wbr>control) {<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D hwmgr-&gt;hwmgr_func-&gt;avfs_<wbr>cont=
rol(hwmgr, false);<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;=
<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err;<b=
r>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt; -<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&amp;hwmgr-&gt;smu_=
lock)<wbr>;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;<br>
&gt; +err:<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&amp;hwmgr-&gt;smu_=
lock)<wbr>;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;<br>
&gt;=C2=A0 }<br>
<br>
<br></div></div>
Rex: unlock mutex until =C2=A0set pp table complete to avoid other pp funct=
ions were called=C2=A0<a href=3D"http://www.baidu.com/link?url=3D8RpXVOm53H=
QyZI9h-ZIs8Ipio9NEDj98vxJiiM0Wx4hbUUpanLuj7jZHEnm0Javd7_rpySIGVAwaxX_ICV-y2=
nDz_TZqF8mzUGZT8RPrw2WCcNsGFsoAh9nirArCSm9s" style=3D"color:rgb(51,51,51);t=
ext-decoration:none;font-size:13px;font-family:arial" id=3D"m_-396980054574=
4392271LPlnk788007" target=3D"_blank">simultaneously</a>.</div></span></fon=
t></div></div></div></div></div></blockquote><div><br></div><div>Thanks.=C2=
=A0 Please include these comments in the patch description.=C2=A0 With that=
 fixed:<br>Reviewed-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deuche=
r@amd.com">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br></div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex"><div dir=3D"ltr"><div id=3D"m_-39698005457443922=
71divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font-family:C=
alibri,Helvetica,sans-serif" dir=3D"ltr"><div><div style=3D"color:rgb(0,0,0=
)"><div class=3D"m_-3969800545744392271BodyFragment"><font size=3D"2"><span=
 style=3D"font-size:11pt">
<div class=3D"m_-3969800545744392271PlainText"><span class=3D""><br>
<br>
&gt;=C2=A0 static int pp_dpm_force_clock_level(void *handle,<br>
&gt; --<br>
&gt; 1.9.1<br>
&gt;<br>
&gt; ______________________________<wbr>_________________<br>
&gt; amd-gfx mailing list<br></span>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>.<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=
=3D"m_-3969800545744392271LPlnk522444" target=3D"_blank">
https://lists.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a>
<div id=3D"m_-3969800545744392271LPBorder_GT_15217258717160.768809182015890=
7" style=3D"margin-bottom:20px;overflow:auto;width:100%;text-indent:0px">
<table id=3D"m_-3969800545744392271LPContainer_15217258717130.2290840894361=
8563" style=3D"width:90%;background-color:rgb(255,255,255);overflow:auto;pa=
dding-top:20px;padding-bottom:20px;margin-top:20px;border-top:1px dotted rg=
b(200,200,200);border-bottom:1px dotted rgb(200,200,200)" cellspacing=3D"0"=
>
<tbody>
<tr style=3D"border-spacing:0px" valign=3D"top">
<td id=3D"m_-3969800545744392271TextCell_15217258717140.47403618146898485" =
colspan=3D"2" style=3D"vertical-align:top;padding:0px;display:table-cell">
<div id=3D"m_-3969800545744392271LPRemovePreviewContainer_15217258717140.33=
50244639142821"></div>
<div id=3D"m_-3969800545744392271LPTitle_15217258717140.3623822377742081" s=
tyle=3D"color:rgb(0,120,215);font-weight:normal;font-size:21px;font-family:=
wf_segoe-ui_light,&quot;Segoe UI Light&quot;,&quot;Segoe WP Light&quot;,&qu=
ot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif;line-height:=
21px">
<a id=3D"m_-3969800545744392271LPUrlAnchor_15217258717150.7344540130325998"=
 href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" style=3D"t=
ext-decoration:none" target=3D"_blank">amd-gfx Info Page - freedesktop.org<=
/a></div>
<div id=3D"m_-3969800545744392271LPMetadata_15217258717150.5144749743928732=
" style=3D"margin:10px 0px 16px;color:rgb(102,102,102);font-weight:normal;f=
ont-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tah=
oma,Arial,sans-serif;font-size:14px;line-height:14px">
<a href=3D"http://lists.freedesktop.org" target=3D"_blank">lists.freedeskto=
p.org</a></div>
<div id=3D"m_-3969800545744392271LPDescription_15217258717150.4169471652740=
233" style=3D"display:block;color:rgb(102,102,102);font-weight:normal;font-=
family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,=
Arial,sans-serif;font-size:14px;line-height:20px;max-height:100px;overflow:=
hidden">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all <a href=3D"http://freedesktop.org" target=3D"_blank">freede=
sktop.org</a> lists is subject to our Code of ...</div>
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
</div>
</div>

</blockquote></div><br></div></div>

--94eb2c1307dee2f3b90568008d0c--

--===============0068681189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0068681189==--
