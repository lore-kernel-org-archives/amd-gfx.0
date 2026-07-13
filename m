Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF8EC43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 14:20:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54B6010E9D4;
	Mon, 13 Jul 2026 14:20:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TMXawPon";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9099A10E9D4
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 14:20:40 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2caf18d4904so7566005ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 07:20:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783952440; cv=none;
 d=google.com; s=arc-20260327;
 b=gZDYkB9Czf5z9oPClPPHPkS0D9Pl8MDncnLUOgXKT6gYxuGqQdhakCJ0nRNMxO+fmx
 82dFCyXP0Wsu/yyzIIYuiNTMNf+xB1Sv5PM/vHo55h+L9f8rZPUJ1m+TJ+m15L4WRj/T
 RIa9oZjWnSBcAUiKPS02lWOt2f5grvWT2yEd4FubFwkFItpYkis/pFChHR3PWkSSnyVQ
 e7L+2Vmsy2Du0yJTG7rRi60f7eO6v5FCwWvem8n3oLjSub7V5HXJ3YT1HNsr/B9xCN5Q
 N+wj1jf+je336Desb3KO2/Jzmcn7nBepudiNXAuWR0Vy8dHjaS3xZ+DF+PtPm3UhY2px
 pF7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=w4ixAGYQ3iLxgjQfDz+/RUCZM5NtPQu9ZWh2FbDKX/Q=;
 fh=VAfooS5I9Kvf682Ku34zx1KPfK8dmmr/lkgcsamIDGU=;
 b=U6nKoxiCYLBoNhEB7l5+uRx/WeMjIlzrnaUFjjqEYUfhNtVrkfiAJYcBl5Bg6bwUKy
 M6IKFwNKnpOac0KukyB/VraOk7H7K1sd3uvJqbhrK4XNYBOR8v2V8UOgU9UUnjwv1u1K
 S9cY9MTAo8BI+7YDL8qQZVfQCy9X9jjNferEKt/xe/anGYwdW+6onv9BYg80i7FHdv57
 YXG3kywII6dEscU/Kc5CPfMV4edETCVKKuWekn+usOKNh7WdyABpBVZhI7mpkrCyV9jc
 UdZYC7wpml32PiaYAa7YWrB+xvN3ZJLauTpjjRAU+ZjxxR8gA0DfcTkTyU7dGC767kZx
 Xpng==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783952440; x=1784557240; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=w4ixAGYQ3iLxgjQfDz+/RUCZM5NtPQu9ZWh2FbDKX/Q=;
 b=TMXawPongH8NjyocgEETaeP0/j3uOyBbwHq9ZjNUBotRNVMgX55hsjo9C71wDkuvbY
 qwDQei6pfVAnbQPAyx4Jc9gZcElA6jo347uXHdhmOxz2+2Zdfny0p7X932EMFWlIeae8
 CXE2aHqol0bhRMXpq7b/f7i2uE1/70dfccMy0wJv8OyX0qGRW2K8SAHWZEhXiq2WNamj
 MvAdMYVe/rF7e0YqUbOBlrrkBDHsTeuwL0pi/cvUAN4y0GMutjWs6TGRFv2r0Quvp2DZ
 z5tpe8KckpxeiRnkXMJFBJaBz85KchB1SC0PcQMM1Rc/YSbKa5jciDalTsR9LibfNEae
 bdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783952440; x=1784557240;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w4ixAGYQ3iLxgjQfDz+/RUCZM5NtPQu9ZWh2FbDKX/Q=;
 b=rhWQxHGA7Pq3sH/GWCr1Q/IHLm7yT9JB3rWqhUaIb29aqocI6z4Mr+Chc/GdNlXBwd
 gMMliOuxV9JMMBslb5XZ08kEoZlTTXAuF8f2uHqy4IyRip2dOwEg/Lwzx9dCTObgH099
 L9C+Nj54IjiJaBLV1KkhelRdWsoTYHj8PaOQvukYVqIsgnUWe+1obqImvx6c5tYcIeyR
 6mlJqbl/AKOe+Ulp1rtg01iIfLT+FQ2mjfZFKYGTSSL4Kqjego97gplQ4y3t9E8QajR0
 JrNTVKtsgVzP5Dm0MfIORBkUmHUjbNChHpa2oVrqoxKedoM4zl3ngs3Dbfv1BQpOjuoa
 Lmpg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoNCz4m6AVwKbU/vs2gzOaY/dyJx5Bp9q8S7UoxKL9YXEa+wOYnvzhIXJ4a8bRDsA/D361sqK55@lists.freedesktop.org
X-Gm-Message-State: AOJu0YysmpjcgDPlL5DGU3ZkEPPoVxXRN2kjkG8kr7Ff92yTaAxZCVxL
 xOs7+ouRZqdlOc6lP7iAAUQuBNKavRiA+KHYc97fF+zgu3YuBsfFWePU3adqoQ9BGCBhyZ2jBlq
 F90eabiQf+uV/NvvRwevC5+QI1SkgyX4=
X-Gm-Gg: AfdE7ck1b60vLnlIP8Kd8YmJQ+ee32AUuwa4HgcsIhunJ5KskIAntuP5GsIxcFZLB/W
 Fxm2EEOchTn6lOdo9cHaBuvacD4iW/gjb26RL57M6bhnr/ChO6tbO+kTkkHTKTHfP8kvpvgxadR
 orU+QRZ9fd+aayz/NoOck3GpvKxddSmo3hEL7BniH56xnUGTlBq5vRquZXdtY8NBea/JrlkUYbB
 AdrijlKLTrOjNe6dQezY9ytbzKB3itYfb+dpuzkPNIFf7YvUX9g45xulfEafXe0d9fBCgULU8/E
 6bweoMTbAR4SEtAhHN6/jQU20pBg6Tqa5iGKYI/itiBwJ/FcOsWutwY4Qh8=
X-Received: by 2002:a17:903:b85:b0:2c0:db23:4a6 with SMTP id
 d9443c01a7336-2ce9e2a0fb6mr71886975ad.1.1783952440035; Mon, 13 Jul 2026
 07:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260711032956.87948-1-venkat88@linux.ibm.com>
In-Reply-To: <20260711032956.87948-1-venkat88@linux.ibm.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Jul 2026 10:20:26 -0400
X-Gm-Features: AVVi8CcB2dqpTs105ob76x_imqEEzPY-WD1QMD_DNLZ4L-_LJeV3UARqjaSdjqw
Message-ID: <CADnq5_Ncims12dEqPybVFS0Hgi3Aqc798nxnFQ+ygm0-om2aFQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Shorten KUnit exported symbol names
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: alexander.deucher@amd.com, chleroy@kernel.org, alex.hung@amd.com, 
 maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, harry.wentland@amd.com, 
 sunpeng.li@amd.com, christian.koenig@amd.com, siqueira@igalia.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Sat, Jul 11, 2026 at 10:09=E2=80=AFAM Venkat Rao Bagalkote
<venkat88@linux.ibm.com> wrote:
>
> The KUnit exported helpers
>
>   amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers()
>   amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers()
>
> exceed MODULE_NAME_LEN and cause modpost to fail with:
>
>   ERROR: modpost: too long symbol
>   "amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers"
>
> Shorten the helper names while preserving their functionality.
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Link: https://lore.kernel.org/all/fde3656e-9e22-4e4c-937f-7e8cb918da6b@li=
nux.ibm.com/
> Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c  | 12 ++++++------
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h  |  4 ++--
>  .../display/amdgpu_dm/tests/amdgpu_dm_plane_test.c   |  8 ++++----
>  3 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 1b564cfe2120..b58225338bc4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -328,7 +328,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_plane_validate_dcc(str=
uct amdgpu_device *adev,
>  }
>  EXPORT_IF_KUNIT(amdgpu_dm_plane_validate_dcc);
>
> -STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx9_plane_attributes_from_mod=
ifiers(struct amdgpu_device *adev,
> +STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers(stru=
ct amdgpu_device *adev,
>                                                                          =
      const struct amdgpu_framebuffer *afb,
>                                                                          =
      const enum surface_pixel_format format,
>                                                                          =
      const enum dc_rotation_angle rotation,
> @@ -378,9 +378,9 @@ STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx9_plane_=
attributes_from_modifiers(s
>
>         return ret;
>  }
> -EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifier=
s);
> +EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers);
>
> -STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx12_plane_attributes_from_mo=
difiers(struct amdgpu_device *adev,
> +STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers(str=
uct amdgpu_device *adev,
>                                                                          =
       const struct amdgpu_framebuffer *afb,
>                                                                          =
       const enum surface_pixel_format format,
>                                                                          =
       const enum dc_rotation_angle rotation,
> @@ -419,7 +419,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx12_plane=
_attributes_from_modifiers(
>
>         return ret;
>  }
> -EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifie=
rs);
> +EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers);
>
>  static void amdgpu_dm_plane_add_gfx10_1_modifiers(const struct amdgpu_de=
vice *adev,
>                                                   uint64_t **mods,
> @@ -927,14 +927,14 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(st=
ruct amdgpu_device *adev,
>         }
>
>         if (adev->family =3D=3D AMDGPU_FAMILY_GC_12_0_0) {
> -               ret =3D amdgpu_dm_plane_fill_gfx12_plane_attributes_from_=
modifiers(adev, afb, format,
> +               ret =3D amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers(a=
dev, afb, format,
>                                                                          =
        rotation, plane_size,
>                                                                          =
        tiling_info, dcc,
>                                                                          =
        address);
>                 if (ret)
>                         return ret;
>         } else if (adev->family >=3D AMDGPU_FAMILY_AI) {
> -               ret =3D amdgpu_dm_plane_fill_gfx9_plane_attributes_from_m=
odifiers(adev, afb, format,
> +               ret =3D amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers(ad=
ev, afb, format,
>                                                                          =
       rotation, plane_size,
>                                                                          =
       tiling_info, dcc,
>                                                                          =
       address);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
> index 911fb2d73e22..55c33e051aee 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
> @@ -92,7 +92,7 @@ int amdgpu_dm_plane_get_plane_modifiers(struct amdgpu_d=
evice *adev,
>  int amdgpu_dm_plane_get_plane_formats(const struct drm_plane *plane,
>                                       const struct dc_plane_cap *plane_ca=
p,
>                                       uint32_t *formats, int max_formats)=
;
> -int amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(struct amd=
gpu_device *adev,
> +int amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers(struct amdgpu_device =
*adev,
>                                                               const struc=
t amdgpu_framebuffer *afb,
>                                                               const enum =
surface_pixel_format format,
>                                                               const enum =
dc_rotation_angle rotation,
> @@ -100,7 +100,7 @@ int amdgpu_dm_plane_fill_gfx9_plane_attributes_from_m=
odifiers(struct amdgpu_devi
>                                                               struct dc_t=
iling_info *tiling_info,
>                                                               struct dc_p=
lane_dcc_param *dcc,
>                                                               struct dc_p=
lane_address *address);
> -int amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(struct am=
dgpu_device *adev,
> +int amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers(struct amdgpu_device=
 *adev,
>                                                                const stru=
ct amdgpu_framebuffer *afb,
>                                                                const enum=
 surface_pixel_format format,
>                                                                const enum=
 dc_rotation_angle rotation,
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_=
test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
> index 46c9af432e37..fc84f5a08596 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
> @@ -579,7 +579,7 @@ static void dm_test_fill_gfx12_plane_attributes_from_=
modifiers(struct kunit *tes
>         plane_size.surface_size.height =3D 1080;
>
>         KUNIT_EXPECT_EQ(test,
> -                       amdgpu_dm_plane_fill_gfx12_plane_attributes_from_=
modifiers(
> +                       amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers(
>                         adev, afb, SURFACE_PIXEL_FORMAT_GRPH_ARGB8888,
>                         ROTATION_ANGLE_0, &plane_size, &tiling_info, &dcc=
, &address),
>                         0);
> @@ -623,7 +623,7 @@ static void dm_test_fill_gfx9_plane_attributes_from_m=
odifiers(struct kunit *test
>         afb->base.modifier =3D DRM_FORMAT_MOD_LINEAR;
>
>         KUNIT_EXPECT_EQ(test,
> -                       amdgpu_dm_plane_fill_gfx9_plane_attributes_from_m=
odifiers(
> +                       amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers(
>                         adev, afb, SURFACE_PIXEL_FORMAT_GRPH_ARGB8888,
>                         ROTATION_ANGLE_0, &plane_size, &tiling_info, &dcc=
, &address),
>                         0);
> @@ -1187,9 +1187,9 @@ static struct kunit_case amdgpu_dm_plane_test_cases=
[] =3D {
>         KUNIT_CASE(dm_test_get_cursor_position),
>         /* amdgpu_dm_plane_format_mod_supported() */
>         KUNIT_CASE(dm_test_format_mod_supported),
> -       /* amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers() *=
/
> +       /* amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers() */
>         KUNIT_CASE(dm_test_fill_gfx12_plane_attributes_from_modifiers),
> -       /* amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers() */
> +       /* amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers() */
>         KUNIT_CASE(dm_test_fill_gfx9_plane_attributes_from_modifiers),
>         /* amdgpu_dm_plane_helper_check_state() */
>         KUNIT_CASE(dm_test_helper_check_state_viewport_reject),
> --
> 2.45.2
>
