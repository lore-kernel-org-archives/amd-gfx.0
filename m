From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/pm: Remove VLA usage
Date: Wed, 18 Jul 2018 10:45:02 +0000
Message-ID: <CY4PR12MB1687FBB0380F5C6D5FDC52FCFB530@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <20180620182647.GA24405@beast>
 <CAGXu5jK74ew7iTw2_OqJSj4wYjBggPpkN-ENEFRpuq0C-eGRDg@mail.gmail.com>
 <CY4PR12MB16874F4DB841A96E065E94EEFB5C0@CY4PR12MB1687.namprd12.prod.outlook.com>,
 <42ba5486-34a2-02bd-50a1-12314e6e2755@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0992178564=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <42ba5486-34a2-02bd-50a1-12314e6e2755-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0992178564==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687FBB0380F5C6D5FDC52FCFB530CY4PR12MB1687namp_"

--_000_CY4PR12MB1687FBB0380F5C6D5FDC52FCFB530CY4PR12MB1687namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Patch has been applied to our internal amd-staging-drm-next tree.


Thanks.


Best Regards

Rex

________________________________
From: Christian K?nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Tuesday, July 17, 2018 2:58:21 PM
To: Zhu, Rex; Kees Cook; Deucher, Alexander
Cc: Zhou, David(ChunMing); David Airlie; Kuehling, Felix; LKML; amd-gfx lis=
t; Huang, Ray; Maling list - DRI developers; Koenig, Christian
Subject: Re: [PATCH] drm/amdgpu/pm: Remove VLA usage

Who's tree should this go through?
To answer the question: When Rex is ok with that he pushes it to our intern=
al amd-staging-drm-next tree.

Alex then pushes that tree to a public server and at some point sends a pul=
l request for inclusion in drm-next.

Regards,
Christian.

Am 17.07.2018 um 08:23 schrieb Zhu, Rex:
Patch is:
Reviewed-by: Rex Zhu<rezhu-5C7GfCeVMHo@public.gmane.org<mailto:rezhu-5C7GfCeVMHo@public.gmane.org>>



Best Regards
Rex


________________________________
From: keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org<mailto:keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> <keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>=
<mailto:keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> on behalf of Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>=
<mailto:keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sent: Tuesday, July 17, 2018 11:59 AM
To: Deucher, Alexander
Cc: LKML; Koenig, Christian; Zhou, David(ChunMing); David Airlie; Zhu, Rex;=
 Huang, Ray; Kuehling, Felix; amd-gfx list; Maling list - DRI developers
Subject: Re: [PATCH] drm/amdgpu/pm: Remove VLA usage

On Wed, Jun 20, 2018 at 11:26 AM, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org><mailto:=
keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> uses the maximum sane buffer size and removes copy/paste code.
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=3DqPXyd=
AacU1RqZWA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org
>
> Signed-off-by: Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org><mailto:keescook@chromium=
.org>

Friendly ping! Who's tree should this go through?

Thanks!

-Kees

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 100 +++++++++++--------------
>  1 file changed, 42 insertions(+), 58 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_pm.c
> index b455da487782..5eb98cde22ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -593,40 +593,59 @@ static ssize_t amdgpu_get_pp_dpm_sclk(struct device=
 *dev,
>                 return snprintf(buf, PAGE_SIZE, "\n");
>  }
>
> -static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
> -               struct device_attribute *attr,
> -               const char *buf,
> -               size_t count)
> +/*
> + * Worst case: 32 bits individually specified, in octal at 12 characters
> + * per line (+1 for \n).
> + */
> +#define AMDGPU_MASK_BUF_MAX    (32 * 13)
> +
> +static ssize_t amdgpu_read_mask(const char *buf, size_t count, uint32_t =
*mask)
>  {
> -       struct drm_device *ddev =3D dev_get_drvdata(dev);
> -       struct amdgpu_device *adev =3D ddev->dev_private;
>         int ret;
>         long level;
> -       uint32_t mask =3D 0;
>         char *sub_str =3D NULL;
>         char *tmp;
> -       char buf_cpy[count];
> +       char buf_cpy[AMDGPU_MASK_BUF_MAX + 1];
>         const char delimiter[3] =3D {' ', '\n', '\0'};
> +       size_t bytes;
>
> -       memcpy(buf_cpy, buf, count+1);
> +       *mask =3D 0;
> +
> +       bytes =3D min(count, sizeof(buf_cpy) - 1);
> +       memcpy(buf_cpy, buf, bytes);
> +       buf_cpy[bytes] =3D '\0';
>         tmp =3D buf_cpy;
>         while (tmp[0]) {
> -               sub_str =3D  strsep(&tmp, delimiter);
> +               sub_str =3D strsep(&tmp, delimiter);
>                 if (strlen(sub_str)) {
>                         ret =3D kstrtol(sub_str, 0, &level);
> -
> -                       if (ret) {
> -                               count =3D -EINVAL;
> -                               goto fail;
> -                       }
> -                       mask |=3D 1 << level;
> +                       if (ret)
> +                               return -EINVAL;
> +                       *mask |=3D 1 << level;
>                 } else
>                         break;
>         }
> +
> +       return 0;
> +}
> +
> +static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
> +               struct device_attribute *attr,
> +               const char *buf,
> +               size_t count)
> +{
> +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> +       struct amdgpu_device *adev =3D ddev->dev_private;
> +       int ret;
> +       uint32_t mask =3D 0;
> +
> +       ret =3D amdgpu_read_mask(buf, count, &mask);
> +       if (ret)
> +               return ret;
> +
>         if (adev->powerplay.pp_funcs->force_clock_level)
>                 amdgpu_dpm_force_clock_level(adev, PP_SCLK, mask);
>
> -fail:
>         return count;
>  }
>
> @@ -651,32 +670,15 @@ static ssize_t amdgpu_set_pp_dpm_mclk(struct device=
 *dev,
>         struct drm_device *ddev =3D dev_get_drvdata(dev);
>         struct amdgpu_device *adev =3D ddev->dev_private;
>         int ret;
> -       long level;
>         uint32_t mask =3D 0;
> -       char *sub_str =3D NULL;
> -       char *tmp;
> -       char buf_cpy[count];
> -       const char delimiter[3] =3D {' ', '\n', '\0'};
>
> -       memcpy(buf_cpy, buf, count+1);
> -       tmp =3D buf_cpy;
> -       while (tmp[0]) {
> -               sub_str =3D  strsep(&tmp, delimiter);
> -               if (strlen(sub_str)) {
> -                       ret =3D kstrtol(sub_str, 0, &level);
> +       ret =3D amdgpu_read_mask(buf, count, &mask);
> +       if (ret)
> +               return ret;
>
> -                       if (ret) {
> -                               count =3D -EINVAL;
> -                               goto fail;
> -                       }
> -                       mask |=3D 1 << level;
> -               } else
> -                       break;
> -       }
>         if (adev->powerplay.pp_funcs->force_clock_level)
>                 amdgpu_dpm_force_clock_level(adev, PP_MCLK, mask);
>
> -fail:
>         return count;
>  }
>
> @@ -701,33 +703,15 @@ static ssize_t amdgpu_set_pp_dpm_pcie(struct device=
 *dev,
>         struct drm_device *ddev =3D dev_get_drvdata(dev);
>         struct amdgpu_device *adev =3D ddev->dev_private;
>         int ret;
> -       long level;
>         uint32_t mask =3D 0;
> -       char *sub_str =3D NULL;
> -       char *tmp;
> -       char buf_cpy[count];
> -       const char delimiter[3] =3D {' ', '\n', '\0'};
> -
> -       memcpy(buf_cpy, buf, count+1);
> -       tmp =3D buf_cpy;
>
> -       while (tmp[0]) {
> -               sub_str =3D  strsep(&tmp, delimiter);
> -               if (strlen(sub_str)) {
> -                       ret =3D kstrtol(sub_str, 0, &level);
> +       ret =3D amdgpu_read_mask(buf, count, &mask);
> +       if (ret)
> +               return ret;
>
> -                       if (ret) {
> -                               count =3D -EINVAL;
> -                               goto fail;
> -                       }
> -                       mask |=3D 1 << level;
> -               } else
> -                       break;
> -       }
>         if (adev->powerplay.pp_funcs->force_clock_level)
>                 amdgpu_dpm_force_clock_level(adev, PP_PCIE, mask);
>
> -fail:
>         return count;
>  }
>
> --
> 2.17.1
>
>
> --
> Kees Cook
> Pixel Security



--
Kees Cook
Pixel Security



_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--_000_CY4PR12MB1687FBB0380F5C6D5FDC52FCFB530CY4PR12MB1687namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Patch has been applied to <span s=
tyle=3D"background-color:white;">
our internal amd-staging-drm-next tree</span>.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Thanks.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K&ouml;nig =
&lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, July 17, 2018 2:58:21 PM<br>
<b>To:</b> Zhu, Rex; Kees Cook; Deucher, Alexander<br>
<b>Cc:</b> Zhou, David(ChunMing); David Airlie; Kuehling, Felix; LKML; amd-=
gfx list; Huang, Ray; Maling list - DRI developers; Koenig, Christian<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/pm: Remove VLA usage</font>
<div>&nbsp;</div>
</div>
<meta content=3D"text/html; charset=3DWindows-1252">
<div style=3D"background-color:#FFFFFF">
<div class=3D"x_moz-cite-prefix">
<blockquote type=3D"cite"><font size=3D"2"><span style=3D"font-size:11pt">W=
ho's tree should this go through?</span></font></blockquote>
To answer the question: When Rex is ok with that he pushes it to our intern=
al amd-staging-drm-next tree.<br>
<br>
Alex then pushes that tree to a public server and at some point sends a pul=
l request for inclusion in drm-next.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 17.07.2018 um 08:23 schrieb Zhu, Rex:<br>
</div>
<blockquote type=3D"cite"><style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<div dir=3D"auto" style=3D"direction:ltr; margin:0px; padding:0px; font-fam=
ily:sans-serif,serif,&quot;EmojiFont&quot;; font-size:11pt; color:black">
Patch is:<br>
Reviewed-by: Rex Zhu&lt;<a href=3D"mailto:rezhu-5C7GfCeVMHo@public.gmane.org" target=3D"_blank" =
rel=3D"noopener noreferrer" id=3D"LPlnk600685" class=3D"x_OWAAutoLink">rezh=
u@amd.com</a>&gt;&nbsp;<br>
<br>
<br>
<br>
</div>
<div align=3D"left">
<div dir=3D"auto" style=3D"direction:ltr; margin:0px; padding:0px; font-fam=
ily:sans-serif,serif,&quot;EmojiFont&quot;; font-size:11pt; color:black">
<font color=3D"#000000">Best Regards</font><br>
</div>
</div>
<font color=3D"#000000">Rex</font><br>
<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font color=3D"#000000" face=3D"Cal=
ibri, sans-serif" style=3D"font-size:11pt"><b>From:</b>
<a class=3D"x_moz-txt-link-abbreviated" href=3D"mailto:keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org"=
>keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org</a>
<a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org">&l=
t;keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org&gt;</a> on behalf of Kees Cook
<a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org">=
&lt;keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org&gt;</a><br>
<b>Sent:</b> Tuesday, July 17, 2018 11:59 AM<br>
<b>To:</b> Deucher, Alexander<br>
<b>Cc:</b> LKML; Koenig, Christian; Zhou, David(ChunMing); David Airlie; Zh=
u, Rex; Huang, Ray; Kuehling, Felix; amd-gfx list; Maling list - DRI develo=
pers<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/pm: Remove VLA usage</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">On Wed, Jun 20, 2018 at 11:26 AM, Kees Cook <a c=
lass=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org">
&lt;keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org&gt;</a> wrote:<br>
&gt; In the quest to remove all stack VLA usage from the kernel[1], this<br=
>
&gt; uses the maximum sane buffer size and removes copy/paste code.<br>
&gt;<br>
&gt; [1] <a href=3D"https://lkml.kernel.org/r/CA&#43;55aFzCG-zNmZwX4A2FQpad=
afLfEzK6CC=3DqPXydAacU1RqZWA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org" id=3D"LPlnk141741" class=3D"x_=
OWAAutoLink">
https://lkml.kernel.org/r/CA&#43;55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=3DqPXydAa=
cU1RqZWA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org</a><br>
&gt;<br>
&gt; Signed-off-by: Kees Cook <a class=3D"x_moz-txt-link-rfc2396E" href=3D"=
mailto:keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org">
&lt;keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org&gt;</a><br>
<br>
Friendly ping! Who's tree should this go through?<br>
<br>
Thanks!<br>
<br>
-Kees<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 100 &#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--------------<br>
&gt;&nbsp; 1 file changed, 42 insertions(&#43;), 58 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_pm.c<br>
&gt; index b455da487782..5eb98cde22ed 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; @@ -593,40 &#43;593,59 @@ static ssize_t amdgpu_get_pp_dpm_sclk(struct=
 device *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<=
br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; -static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; const char *buf,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; size_t count)<br>
&gt; &#43;/*<br>
&gt; &#43; * Worst case: 32 bits individually specified, in octal at 12 cha=
racters<br>
&gt; &#43; * per line (&#43;1 for \n).<br>
&gt; &#43; */<br>
&gt; &#43;#define AMDGPU_MASK_BUF_MAX&nbsp;&nbsp;&nbsp; (32 * 13)<br>
&gt; &#43;<br>
&gt; &#43;static ssize_t amdgpu_read_mask(const char *buf, size_t count, ui=
nt32_t *mask)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =3D dev_=
get_drvdata(dev);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D d=
dev-&gt;dev_private;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long level;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mask =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *sub_str =3D NULL=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *tmp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char buf_cpy[count];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char buf_cpy[AMDGPU_MASK_BUF=
_MAX &#43; 1];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char delimiter[3=
] =3D {' ', '\n', '\0'};<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t bytes;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(buf_cpy, buf, count&#43;1=
);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *mask =3D 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bytes =3D min(count, sizeof(=
buf_cpy) - 1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(buf_cpy, buf, bytes);=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf_cpy[bytes] =3D '\0';<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D buf_cpy;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (tmp[0]) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; sub_str =3D&nbsp; strsep(&amp;tmp, delimiter);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; sub_str =3D strsep(&amp;tmp, delimiter);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (strlen(sub_str)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r=
et =3D kstrtol(sub_str, 0, &amp;level);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count =3D -EINVAL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto fail;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mask |=3D 1=
 &lt;&lt; level;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret=
)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *mask |=
=3D 1 &lt;&lt; level;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b=
reak;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; const char *buf,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; size_t count)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =3D =
dev_get_drvdata(dev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D ddev-&gt;dev_private;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mask =3D 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_read_mask(buf=
, count, &amp;mask);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay=
.pp_funcs-&gt;force_clock_level)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_force_clock_level(adev, PP_SCLK, mask)=
;<br>
&gt;<br>
&gt; -fail:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; @@ -651,32 &#43;670,15 @@ static ssize_t amdgpu_set_pp_dpm_mclk(struct=
 device *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *dde=
v =3D dev_get_drvdata(dev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *=
adev =3D ddev-&gt;dev_private;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long level;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mask =3D 0;<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *sub_str =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *tmp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char buf_cpy[count];<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char delimiter[3] =3D {' '=
, '\n', '\0'};<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(buf_cpy, buf, count&#43;1=
);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D buf_cpy;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (tmp[0]) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; sub_str =3D&nbsp; strsep(&amp;tmp, delimiter);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (strlen(sub_str)) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D kst=
rtol(sub_str, 0, &amp;level);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_read_mask(buf=
, count, &amp;mask);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count =3D -EINVAL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto fail;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mask |=3D 1=
 &lt;&lt; level;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; } else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay=
.pp_funcs-&gt;force_clock_level)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_force_clock_level(adev, PP_MCLK, mask)=
;<br>
&gt;<br>
&gt; -fail:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; @@ -701,33 &#43;703,15 @@ static ssize_t amdgpu_set_pp_dpm_pcie(struct=
 device *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *dde=
v =3D dev_get_drvdata(dev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *=
adev =3D ddev-&gt;dev_private;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long level;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mask =3D 0;<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *sub_str =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *tmp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char buf_cpy[count];<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char delimiter[3] =3D {' '=
, '\n', '\0'};<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(buf_cpy, buf, count&#43;1=
);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D buf_cpy;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (tmp[0]) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; sub_str =3D&nbsp; strsep(&amp;tmp, delimiter);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (strlen(sub_str)) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D kst=
rtol(sub_str, 0, &amp;level);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_read_mask(buf=
, count, &amp;mask);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count =3D -EINVAL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto fail;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mask |=3D 1=
 &lt;&lt; level;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; } else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay=
.pp_funcs-&gt;force_clock_level)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_force_clock_level(adev, PP_PCIE, mask)=
;<br>
&gt;<br>
&gt; -fail:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; --<br>
&gt; 2.17.1<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Kees Cook<br>
&gt; Pixel Security<br>
<br>
<br>
<br>
-- <br>
Kees Cook<br>
Pixel Security<br>
</div>
</span></font></div>
</div>
</div>
<br>
<fieldset class=3D"x_mimeAttachmentHeader"></fieldset> <br>
<pre>_______________________________________________
amd-gfx mailing list
<a class=3D"x_moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class=3D"x_moz-txt-link-freetext" href=3D"https://lists.freedesktop.org/=
mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/am=
d-gfx</a>
</pre>
</blockquote>
<br>
</div>
</body>
</html>

--_000_CY4PR12MB1687FBB0380F5C6D5FDC52FCFB530CY4PR12MB1687namp_--

--===============0992178564==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0992178564==--
