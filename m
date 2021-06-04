Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF709C4743D
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 17:16:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82AD1613F9
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 17:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82AD1613F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2815E6E255;
	Fri,  4 Jun 2021 17:16:28 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05C5A6F629
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 17:03:41 +0000 (UTC)
Received: by mail-lf1-x12d.google.com with SMTP id f30so15141708lfj.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Jun 2021 10:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8BGMDCj5hofHAgnvVqm/BgotkKX1C328ad8hFxC0eIE=;
 b=MSikhLoelb6cSlKXZsYOSHDyYWDBDZPfaiRnLdOhz3bxf5oGUeuFJGJvbKn5C0RlBw
 XsXoBjzIdAj4DZ1iPgfkX7RVCrNOnHy+CEN8OlUOJ5JTGpdsiMzYZj056su2qmzNR89s
 BswesFVty3BNiIM1vZOkhlzk5BifpgNvahNyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8BGMDCj5hofHAgnvVqm/BgotkKX1C328ad8hFxC0eIE=;
 b=MwV4WWk0WtFe+iV5/aZTD8ddCkuqO0GSwe0ZDZJPs9v7Opr14GFwozeRC8mTRkDxXI
 SfsgrxutGOmIGq+k2rkJP65n2hpx3rSodhESKLRljoXajGlI2UG6CcgsgZnxyPDzxlxm
 PuyqsSai7Hgjlvk3u4DZTBnB0+XhmxzhgkZVNoQe7D5CNvmWtkXK4y2gah07hNzYKhD/
 w112Rh7ZylUcN8Kq+y3tHtkMNkW8TNcdkT3d+s4wooW1ansF+yx7MO8VFXpeF11FYMMw
 rsTD3yN5pighnPbUvLE8BVDt2ZMGPf0VRlQfV0OMm/3GaytmoFMb9Oauj85qQRafeVTj
 f5DQ==
X-Gm-Message-State: AOAM533lg8jIOf6I6u9CwiPNvkKlRQxnJVguI35BNQyLxLvbb9hfiBPJ
 5vMGh8iODV+/o7ognZUU8W174M/zTC7bcdJbWopQfrqGJtR5Rw==
X-Google-Smtp-Source: ABdhPJygpUYfO8VjLTy/VAziOV+P+rzQ01PdVsqKXDRg+bdNMaTrtP4QAaAR5oOljl2BgXsBtDzGd1bFwi1Ur7TXG6M=
X-Received: by 2002:ac2:46f6:: with SMTP id q22mr3370669lfo.493.1622826219114; 
 Fri, 04 Jun 2021 10:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210604165938.2022663-1-markyacoub@chromium.org>
In-Reply-To: <20210604165938.2022663-1-markyacoub@chromium.org>
From: Mark Yacoub <markyacoub@chromium.org>
Date: Fri, 4 Jun 2021 13:03:27 -0400
Message-ID: <CAJUqKUoPEeAAVxzZVsBjOgtGFiYHBFyGWUsMrSoucuKsXqdCqQ@mail.gmail.com>
Subject: Re: [PATCH] Verify Gamma & Degamma LUT sizes in amdgpu_dm_atomic_check
To: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
X-Mailman-Approved-At: Fri, 04 Jun 2021 17:16:27 +0000
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, "Siqueira,
 Rodrigo" <rodrigo.siqueira@amd.com>, Sean Paul <seanpaul@chromium.org>,
 Mark Yacoub <markyacoub@google.com>
Content-Type: multipart/mixed; boundary="===============0236361494=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0236361494==
Content-Type: multipart/alternative; boundary="00000000000052a4f705c3f3ac9a"

--00000000000052a4f705c3f3ac9a
Content-Type: text/plain; charset="UTF-8"

Ignore this patch, in favor of (
https://patchwork.freedesktop.org/series/91023/), which appends the commit
title with drm/amd/display.


On Fri, Jun 4, 2021 at 12:59 PM Mark Yacoub <markyacoub@chromium.org> wrote:

> From: Mark Yacoub <markyacoub@google.com>
>
> For each CRTC state, check the size of Gamma and Degamma LUTs  so
> unexpected and larger sizes wouldn't slip through.
>
> TEST: IGT:kms_color::pipe-invalid-gamma-lut-sizes
>
> Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 ++
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
>  .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 40 ++++++++++++++++---
>  3 files changed, 38 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 38d497d30dba8..f6cd522b42a80 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9402,6 +9402,9 @@ static int amdgpu_dm_atomic_check(struct drm_device
> *dev,
>                         dm_old_crtc_state->dsc_force_changed == false)
>                         continue;
>
> +               if ((ret = amdgpu_dm_verify_lut_sizes(new_crtc_state)))
> +                       goto fail;
> +
>                 if (!new_crtc_state->enable)
>                         continue;
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 8bfe901cf2374..1b77cd2612691 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -541,6 +541,7 @@ void amdgpu_dm_trigger_timing_sync(struct drm_device
> *dev);
>  #define MAX_COLOR_LEGACY_LUT_ENTRIES 256
>
>  void amdgpu_dm_init_color_mod(void);
> +int amdgpu_dm_verify_lut_sizes(const struct drm_crtc_state *crtc_state);
>  int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc);
>  int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
>                                       struct dc_plane_state
> *dc_plane_state);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index 157fe4efbb599..da6f9fcc0b415 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -284,6 +284,37 @@ static int __set_input_tf(struct dc_transfer_func
> *func,
>         return res ? 0 : -ENOMEM;
>  }
>
> +/**
> + * Verifies that the Degamma and Gamma LUTs attached to the |crtc_state|
> are of
> + * the expected size.
> + * Returns 0 on success.
> + */
> +int amdgpu_dm_verify_lut_sizes(const struct drm_crtc_state *crtc_state)
> +{
> +       const struct drm_color_lut *lut = NULL;
> +       uint32_t size = 0;
> +
> +       lut = __extract_blob_lut(crtc_state->degamma_lut, &size);
> +       if (lut && size != MAX_COLOR_LUT_ENTRIES) {
> +               DRM_DEBUG_DRIVER(
> +                       "Invalid Degamma LUT size. Should be %u but got
> %u.\n",
> +                       MAX_COLOR_LUT_ENTRIES, size);
> +               return -EINVAL;
> +       }
> +
> +       lut = __extract_blob_lut(crtc_state->gamma_lut, &size);
> +       if (lut && size != MAX_COLOR_LUT_ENTRIES &&
> +           size != MAX_COLOR_LEGACY_LUT_ENTRIES) {
> +               DRM_DEBUG_DRIVER(
> +                       "Invalid Gamma LUT size. Should be %u (or %u for
> legacy) but got %u.\n",
> +                       MAX_COLOR_LUT_ENTRIES,
> MAX_COLOR_LEGACY_LUT_ENTRIES,
> +                       size);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
>  /**
>   * amdgpu_dm_update_crtc_color_mgmt: Maps DRM color management to DC
> stream.
>   * @crtc: amdgpu_dm crtc state
> @@ -317,14 +348,11 @@ int amdgpu_dm_update_crtc_color_mgmt(struct
> dm_crtc_state *crtc)
>         bool is_legacy;
>         int r;
>
> -       degamma_lut = __extract_blob_lut(crtc->base.degamma_lut,
> &degamma_size);
> -       if (degamma_lut && degamma_size != MAX_COLOR_LUT_ENTRIES)
> -               return -EINVAL;
> +       if ((r = amdgpu_dm_verify_lut_sizes(&crtc->base)))
> +               return r;
>
> +       degamma_lut = __extract_blob_lut(crtc->base.degamma_lut,
> &degamma_size);
>         regamma_lut = __extract_blob_lut(crtc->base.gamma_lut,
> &regamma_size);
> -       if (regamma_lut && regamma_size != MAX_COLOR_LUT_ENTRIES &&
> -           regamma_size != MAX_COLOR_LEGACY_LUT_ENTRIES)
> -               return -EINVAL;
>
>         has_degamma =
>                 degamma_lut && !__is_lut_linear(degamma_lut, degamma_size);
> --
> 2.32.0.rc1.229.g3e70b5a671-goog
>
>

--00000000000052a4f705c3f3ac9a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ignore this patch, in favor of (<a href=3D"https://patchwo=
rk.freedesktop.org/series/91023/">https://patchwork.freedesktop.org/series/=
91023/</a>), which appends the commit title with drm/amd/display.</div><br>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri=
, Jun 4, 2021 at 12:59 PM Mark Yacoub &lt;<a href=3D"mailto:markyacoub@chro=
mium.org">markyacoub@chromium.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">From: Mark Yacoub &lt;<a href=3D"mailto:ma=
rkyacoub@google.com" target=3D"_blank">markyacoub@google.com</a>&gt;<br>
<br>
For each CRTC state, check the size of Gamma and Degamma LUTs=C2=A0 so<br>
unexpected and larger sizes wouldn&#39;t slip through.<br>
<br>
TEST: IGT:kms_color::pipe-invalid-gamma-lut-sizes<br>
<br>
Signed-off-by: Mark Yacoub &lt;<a href=3D"mailto:markyacoub@chromium.org" t=
arget=3D"_blank">markyacoub@chromium.org</a>&gt;<br>
---<br>
=C2=A0.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |=C2=A0 3 ++<br>
=C2=A0.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |=C2=A0 1 +<br>
=C2=A0.../amd/display/amdgpu_dm/amdgpu_dm_color.c=C2=A0 =C2=A0| 40 ++++++++=
++++++++---<br>
=C2=A03 files changed, 38 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 38d497d30dba8..f6cd522b42a80 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -9402,6 +9402,9 @@ static int amdgpu_dm_atomic_check(struct drm_device *=
dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dm_old_crtc_state-&gt;dsc_force_changed =3D=3D false)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 continue;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((ret =3D amdgpu=
_dm_verify_lut_sizes(new_crtc_state)))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto fail;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!new_crtc_state=
-&gt;enable)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 continue;<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.h<br>
index 8bfe901cf2374..1b77cd2612691 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h<br>
@@ -541,6 +541,7 @@ void amdgpu_dm_trigger_timing_sync(struct drm_device *d=
ev);<br>
=C2=A0#define MAX_COLOR_LEGACY_LUT_ENTRIES 256<br>
<br>
=C2=A0void amdgpu_dm_init_color_mod(void);<br>
+int amdgpu_dm_verify_lut_sizes(const struct drm_crtc_state *crtc_state);<b=
r>
=C2=A0int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc);<br>
=C2=A0int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dc_plane=
_state *dc_plane_state);<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c<br>
index 157fe4efbb599..da6f9fcc0b415 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c<br>
@@ -284,6 +284,37 @@ static int __set_input_tf(struct dc_transfer_func *fun=
c,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return res ? 0 : -ENOMEM;<br>
=C2=A0}<br>
<br>
+/**<br>
+ * Verifies that the Degamma and Gamma LUTs attached to the |crtc_state| a=
re of<br>
+ * the expected size.<br>
+ * Returns 0 on success.<br>
+ */<br>
+int amdgpu_dm_verify_lut_sizes(const struct drm_crtc_state *crtc_state)<br=
>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct drm_color_lut *lut =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t size =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0lut =3D __extract_blob_lut(crtc_state-&gt;degam=
ma_lut, &amp;size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (lut &amp;&amp; size !=3D MAX_COLOR_LUT_ENTR=
IES) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_DEBUG_DRIVER(<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;Invalid Degamma LUT size. Should be %u but got %u.\n&quot;,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0MAX_COLOR_LUT_ENTRIES, size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0lut =3D __extract_blob_lut(crtc_state-&gt;gamma=
_lut, &amp;size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (lut &amp;&amp; size !=3D MAX_COLOR_LUT_ENTR=
IES &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size !=3D MAX_COLOR_LEGACY_LUT_EN=
TRIES) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_DEBUG_DRIVER(<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;Invalid Gamma LUT size. Should be %u (or %u for legacy) but=
 got %u.\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0MAX_COLOR_LUT_ENTRIES, MAX_COLOR_LEGACY_LUT_ENTRIES,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
=C2=A0/**<br>
=C2=A0 * amdgpu_dm_update_crtc_color_mgmt: Maps DRM color management to DC =
stream.<br>
=C2=A0 * @crtc: amdgpu_dm crtc state<br>
@@ -317,14 +348,11 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_s=
tate *crtc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool is_legacy;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int r;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0degamma_lut =3D __extract_blob_lut(crtc-&gt;bas=
e.degamma_lut, &amp;degamma_size);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (degamma_lut &amp;&amp; degamma_size !=3D MA=
X_COLOR_LUT_ENTRIES)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((r =3D amdgpu_dm_verify_lut_sizes(&amp;crtc=
-&gt;base)))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0degamma_lut =3D __extract_blob_lut(crtc-&gt;bas=
e.degamma_lut, &amp;degamma_size);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 regamma_lut =3D __extract_blob_lut(crtc-&gt;bas=
e.gamma_lut, &amp;regamma_size);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (regamma_lut &amp;&amp; regamma_size !=3D MA=
X_COLOR_LUT_ENTRIES &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0regamma_size !=3D MAX_COLOR_LEGAC=
Y_LUT_ENTRIES)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 has_degamma =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 degamma_lut &amp;&a=
mp; !__is_lut_linear(degamma_lut, degamma_size);<br>
-- <br>
2.32.0.rc1.229.g3e70b5a671-goog<br>
<br>
</blockquote></div>

--00000000000052a4f705c3f3ac9a--

--===============0236361494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0236361494==--
