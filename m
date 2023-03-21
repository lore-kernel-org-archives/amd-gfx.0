Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CAFC6FD1D
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Mar 2023 03:05:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F0D10E6BA;
	Tue, 21 Mar 2023 03:05:45 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 507C110E6BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Mar 2023 03:05:43 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id eg48so54367658edb.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 20:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679367941;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1HEs7Pl+kT1a9pyZLb16RddWdzigEeXbd53zhKfC4zc=;
 b=VCxaFZ1MMKNdWEoh3fzBblh5sptDIRZVlGWFbntgNTLFuCySXfLhNt1rpjojs8tMoQ
 ZVMk2vwVofGFDRT1LKp6wh9UhuDHFViS0WB+ntrjvIIUKYKcvIgrLflQXKuuPOLWKam+
 CmYwf1S3q7SKYhMPeaPrX+mKAql5SadurJjkcO4ah8Z/i3dljneanMT9PLUfjKQ2uMxc
 Rw4Pr681ThpnQvLEKLOVIOKuuOlJvxcoraG49tf/vwDnrohFLwDmjtp597wC0o+ti0sb
 G6OmUU3CGz/QNnbnS8+4uNYq3r+fLVc5Pd4+oziIfU4RBLfDaT59v+tOTvj3ezZWgmLX
 adfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679367941;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1HEs7Pl+kT1a9pyZLb16RddWdzigEeXbd53zhKfC4zc=;
 b=UobnvG1zLIxmLozWKudv0eUw6LdFO9FiaigcXBZNintWW8g6201dMJ7QTz8HR952XE
 OUvGxg2aSyKp4e7fVn9nimmexNHBZfySX7R1sxWy/ukOWaC8scFPdbnKNe3p8kJfQ+S1
 MUPyQJ6IajZi1RBO67KW70SKF5SThhN61tBOQrdRRzRgv+1IZbWYD3o9Vhkg9nCQu1uh
 Rz7/k5ZdNIGm8pst7481lIZuY+yE7pP1kL3c8ebvkE2XB22RqxyRzJ1gYFyMplm1lUa5
 q+3cMp4szmHPP4hDHADbjKv99yggMr77YBA9eJpDyafEea0Pa1qw8pbLyv9JdXEPWi5I
 Hnkw==
X-Gm-Message-State: AO0yUKUIhDSg1O8oN30gzctJ1LhdDFAqngKU4qeFcl3lP0zBlkHiujne
 c3XVEw4ejjpVt/3XcCRy9VqvT6WgkasZ03u96ZpgiCQWuZU=
X-Google-Smtp-Source: AK7set9jwnN6k8b3yFcPD9ER7Y+Bx8/izWYLTj26jvo/G/ISeX/OoprPxQ+QsCeCt/GzrKdzpihX7eCvSFMMENX8B3A=
X-Received: by 2002:a17:906:c7ca:b0:922:26ae:c68c with SMTP id
 dc10-20020a170906c7ca00b0092226aec68cmr5355677ejb.5.1679367941599; Mon, 20
 Mar 2023 20:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-2-shashank.sharma@amd.com>
In-Reply-To: <20220926214014.5450-2-shashank.sharma@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Mon, 20 Mar 2023 23:05:05 -0400
Message-ID: <CAAxE2A67NMxra-a9ZYbY8e8S4fjfdXgB1cpjYZsSS8DcUu=LbA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] drm/amdgpu: add UAPI for workload hints to ctx
 ioctl
To: Shashank Sharma <shashank.sharma@amd.com>
Content-Type: multipart/alternative; boundary="0000000000009b347605f7605186"
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: alexander.deucher@amd.com, amaranath.somalapuram@amd.com,
 christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--0000000000009b347605f7605186
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think we should do it differently because this interface will be mostly
unused by open source userspace in its current form.

Let's set the workload hint in drm_amdgpu_ctx_in::flags, and that will be
immutable for the lifetime of the context. No other interface is needed.

Marek

On Mon, Sep 26, 2022 at 5:41=E2=80=AFPM Shashank Sharma <shashank.sharma@am=
d.com>
wrote:

> Allow the user to specify a workload hint to the kernel.
> We can use these to tweak the dpm heuristics to better match
> the workload for improved performance.
>
> V3: Create only set() workload UAPI (Christian)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  include/uapi/drm/amdgpu_drm.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index c2c9c674a223..23d354242699 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -212,6 +212,7 @@ union drm_amdgpu_bo_list {
>  #define AMDGPU_CTX_OP_QUERY_STATE2     4
>  #define AMDGPU_CTX_OP_GET_STABLE_PSTATE        5
>  #define AMDGPU_CTX_OP_SET_STABLE_PSTATE        6
> +#define AMDGPU_CTX_OP_SET_WORKLOAD_PROFILE     7
>
>  /* GPU reset status */
>  #define AMDGPU_CTX_NO_RESET            0
> @@ -252,6 +253,17 @@ union drm_amdgpu_bo_list {
>  #define AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK  3
>  #define AMDGPU_CTX_STABLE_PSTATE_PEAK  4
>
> +/* GPU workload hints, flag bits 8-15 */
> +#define AMDGPU_CTX_WORKLOAD_HINT_SHIFT     8
> +#define AMDGPU_CTX_WORKLOAD_HINT_MASK      (0xff <<
> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +#define AMDGPU_CTX_WORKLOAD_HINT_NONE      (0 <<
> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +#define AMDGPU_CTX_WORKLOAD_HINT_3D        (1 <<
> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +#define AMDGPU_CTX_WORKLOAD_HINT_VIDEO     (2 <<
> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +#define AMDGPU_CTX_WORKLOAD_HINT_VR        (3 <<
> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +#define AMDGPU_CTX_WORKLOAD_HINT_COMPUTE   (4 <<
> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +#define AMDGPU_CTX_WORKLOAD_HINT_MAX      AMDGPU_CTX_WORKLOAD_HINT_COMPU=
TE
> +#define AMDGPU_CTX_WORKLOAD_INDEX(n)      (n >>
> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +
>  struct drm_amdgpu_ctx_in {
>         /** AMDGPU_CTX_OP_* */
>         __u32   op;
> @@ -281,6 +293,11 @@ union drm_amdgpu_ctx_out {
>                         __u32   flags;
>                         __u32   _pad;
>                 } pstate;
> +
> +               struct {
> +                       __u32   flags;
> +                       __u32   _pad;
> +               } workload;
>  };
>
>  union drm_amdgpu_ctx {
> --
> 2.34.1
>
>

--0000000000009b347605f7605186
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I think we should do it differently because this inte=
rface will be mostly unused by open source userspace in its current form.</=
div><div><br></div><div>Let&#39;s set the workload hint in drm_amdgpu_ctx_i=
n::flags, and that will be immutable for the lifetime of the context. No ot=
her interface is needed.<br></div><div><br></div><div>Marek<br></div></div>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon=
, Sep 26, 2022 at 5:41=E2=80=AFPM Shashank Sharma &lt;<a href=3D"mailto:sha=
shank.sharma@amd.com">shashank.sharma@amd.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">Allow the user to specify a wo=
rkload hint to the kernel.<br>
We can use these to tweak the dpm heuristics to better match<br>
the workload for improved performance.<br>
<br>
V3: Create only set() workload UAPI (Christian)<br>
<br>
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com=
" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
Signed-off-by: Shashank Sharma &lt;<a href=3D"mailto:shashank.sharma@amd.co=
m" target=3D"_blank">shashank.sharma@amd.com</a>&gt;<br>
---<br>
=C2=A0include/uapi/drm/amdgpu_drm.h | 17 +++++++++++++++++<br>
=C2=A01 file changed, 17 insertions(+)<br>
<br>
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h<=
br>
index c2c9c674a223..23d354242699 100644<br>
--- a/include/uapi/drm/amdgpu_drm.h<br>
+++ b/include/uapi/drm/amdgpu_drm.h<br>
@@ -212,6 +212,7 @@ union drm_amdgpu_bo_list {<br>
=C2=A0#define AMDGPU_CTX_OP_QUERY_STATE2=C2=A0 =C2=A0 =C2=A04<br>
=C2=A0#define AMDGPU_CTX_OP_GET_STABLE_PSTATE=C2=A0 =C2=A0 =C2=A0 =C2=A0 5<=
br>
=C2=A0#define AMDGPU_CTX_OP_SET_STABLE_PSTATE=C2=A0 =C2=A0 =C2=A0 =C2=A0 6<=
br>
+#define AMDGPU_CTX_OP_SET_WORKLOAD_PROFILE=C2=A0 =C2=A0 =C2=A07<br>
<br>
=C2=A0/* GPU reset status */<br>
=C2=A0#define AMDGPU_CTX_NO_RESET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
0<br>
@@ -252,6 +253,17 @@ union drm_amdgpu_bo_list {<br>
=C2=A0#define AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK=C2=A0 3<br>
=C2=A0#define AMDGPU_CTX_STABLE_PSTATE_PEAK=C2=A0 4<br>
<br>
+/* GPU workload hints, flag bits 8-15 */<br>
+#define AMDGPU_CTX_WORKLOAD_HINT_SHIFT=C2=A0 =C2=A0 =C2=A08<br>
+#define AMDGPU_CTX_WORKLOAD_HINT_MASK=C2=A0 =C2=A0 =C2=A0 (0xff &lt;&lt; A=
MDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
+#define AMDGPU_CTX_WORKLOAD_HINT_NONE=C2=A0 =C2=A0 =C2=A0 (0 &lt;&lt; AMDG=
PU_CTX_WORKLOAD_HINT_SHIFT)<br>
+#define AMDGPU_CTX_WORKLOAD_HINT_3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt;=
 AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
+#define AMDGPU_CTX_WORKLOAD_HINT_VIDEO=C2=A0 =C2=A0 =C2=A0(2 &lt;&lt; AMDG=
PU_CTX_WORKLOAD_HINT_SHIFT)<br>
+#define AMDGPU_CTX_WORKLOAD_HINT_VR=C2=A0 =C2=A0 =C2=A0 =C2=A0 (3 &lt;&lt;=
 AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
+#define AMDGPU_CTX_WORKLOAD_HINT_COMPUTE=C2=A0 =C2=A0(4 &lt;&lt; AMDGPU_CT=
X_WORKLOAD_HINT_SHIFT)<br>
+#define AMDGPU_CTX_WORKLOAD_HINT_MAX=C2=A0 =C2=A0 =C2=A0 AMDGPU_CTX_WORKLO=
AD_HINT_COMPUTE<br>
+#define AMDGPU_CTX_WORKLOAD_INDEX(n)=C2=A0 =C2=A0 =C2=A0 (n &gt;&gt; AMDGP=
U_CTX_WORKLOAD_HINT_SHIFT)<br>
+<br>
=C2=A0struct drm_amdgpu_ctx_in {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /** AMDGPU_CTX_OP_* */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32=C2=A0 =C2=A0op;<br>
@@ -281,6 +293,11 @@ union drm_amdgpu_ctx_out {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 __u32=C2=A0 =C2=A0flags;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 __u32=C2=A0 =C2=A0_pad;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } pstate;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0__u32=C2=A0 =C2=A0flags;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0__u32=C2=A0 =C2=A0_pad;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} workload;<br>
=C2=A0};<br>
<br>
=C2=A0union drm_amdgpu_ctx {<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--0000000000009b347605f7605186--
