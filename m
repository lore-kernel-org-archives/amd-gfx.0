Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873C0103E168
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 12:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AAC210E3A5;
	Wed, 18 Mar 2026 12:53:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q/SyYOsr";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6F4C10E3A5
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 12:53:18 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-12734af2cdcso314999c88.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 05:53:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773838398; cv=none;
 d=google.com; s=arc-20240605;
 b=Hj5IrkAnJbFiDKk5HVwYr8Cd+946h17oF+tOwHjS5s+9qWyDdybA/X6+wes7TWdhM0
 h+Eyr3oy0WI58FcEaTxwROgPIju2sIoxxVQeWnbylmjVzNQtImKexxZY5l4cUjOQFIvb
 99QYlkvmXvVUnFeC8BdWzVLVTzhX4D87osNiSj+kIjFnNP+UDsNKjGBZfxewupzSP+hY
 tNtfN9tOWzVZwcengGySvE14+r/Vz1dW+pi66UUHYqwOeNj81BbxvPPcMuYhqzI40rvX
 Q5zraxS3127ZHJl/wmcwQS5woVAfX48thBa7OqS8/SnBLhIhKDSF3dlfzCiQ7+CzVjFp
 CBVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=41IjNqbC7hVmDY7TmMFLjxcbEwtMNrf6OaOcq6+N7lo=;
 fh=l3eoYdYAnt4lYm9FGg/FDgc/xxtBVzyVw0u/PZzbCWU=;
 b=VksvXKW1AchopawHP6Q2K6sr3Wes0nO4ZlO1qOYvFDfs7xCV+DQfsAgWLU4/6oFUpX
 R5+blZYlbQKN9qA7pVDktdhKFdbpFEo+rXWT3Ou9W6nuFZ2mzoAVQbjamIqJcr0/FHNv
 kkEKs9LIhJBi9ChZJB4O3KFsLsKU3YiUuX1TqX3/jAEsJxTsRSRXh3jrijHe6kf/e6qO
 vuPnv/mrLI3zVxgvun/Pzd9+wbWyLGsIIjINxSvRJnIMU19XmRT5OdvVGqVPbQau4LQt
 dCQZqQIVy8SSwYG0Kb00Lzeg2CvXXjsdHGDU+zZVWBmMpAVVzek+Pav7Jc13S2PXlK5D
 jykw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773838398; x=1774443198; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=41IjNqbC7hVmDY7TmMFLjxcbEwtMNrf6OaOcq6+N7lo=;
 b=Q/SyYOsrRS7N2opahs8eDDJXADului9vY9QpVMd9vzLO28uue427GLngwf1Dii1Gy7
 0Y02weHJ0FRIZ3p5epH6BKZERuUWBFuXd/+4PuVAuyGSsWdoTl4TpEPGzzP14/6FDNlb
 X4O2JlmkRWtVdoK1o+oBRNKOOsAX2xcg0iD7BzFViw5IWUL0E8yb+8zsjXtYDm1XnQm9
 U++pVIeuxTevK1zpHBi0q/jpDo2RO2op4FoXRqN8FR4fIK6s+tpi5/CM7JUy6D0KZG2Z
 Q8jpooq7yW+wvhzPZ9ynWtGPILwVZXEoSC7YyDGMotwto+0Ls2pFf9YIPxsZOXFkQw8a
 sS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773838398; x=1774443198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=41IjNqbC7hVmDY7TmMFLjxcbEwtMNrf6OaOcq6+N7lo=;
 b=lVZRDzqNffd+RIdpBxd1U47VIy2gfa1oOQwtcm6OuomL7vJoAeLvhqJeZ5XJ2MhGd8
 F/+GeG0Otxfhwwbh0By09hEfhpVXu1j7ty8zntEN9Tu93/LbvjBDXVodVqJKskBekDuz
 oBxkKwwVBf5CgJ73UutWIssuRUl3MyuYWKQpvccv/N4FNVSb1qNp0kgzPTmNJP9Dlf3w
 dS8KLHxP+QmFgTL+hilAhzqJKn/HRxmw5OCIxE3yMFBKs7D7tlvUfhJVMtPeXux9usgx
 D3+Rcy2Qgjqc1YH1atT/kFj/sJhz/wY+YV+UBf/wLDig1XRUhg7CGwmInmbph61Mso60
 2F/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFHr2J9vNTJFDDAZXVHdLXg92XR9RsjdUbEiq7zsGyRZZzK/qjmEA/3fUI0tephUoTLaYy3sLg@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzGIBCT1cM2bFp0IL5zUrLRTirztKxi58OhZ1K25BuTPoM+zrFM
 C1pjWtQNFBm49zj14HvcUvy8GauG1qKAfe45O4vcidOsT5cwOZWPQ8dSwf7NP90VIPqbs+LYzKO
 NpRUnGfs3+PZWM6x0GAnvPOCxrWKXK8Q=
X-Gm-Gg: ATEYQzx2uvQY88yMaT25AN9olVoHLzGhvsIUL/VkGkXtEhKl4egFev+UnKM6zhsdJsp
 TlUgMi7Jb6SENFZ6h5mej4TB196EyU9ixjRBkvxXvAvyJuLgNHUHcv1fPIWMWzKXslYfo+Wam6c
 IHCF+tDcz0gX0BXf9yjNPcR1UBPa6ADEgcu6d47q04Bgp8vlkc09qeQxVDEj7fRSsKRhnIuHN/e
 FR1wV4dqUb5Hq7etxXzOwaq389ZFtfyG7XNJei9gXmv8gnAh4sgSAQWOsobpLyh4Fy8RcIRt1z+
 jOtJu45TPKYRsbSA8cSsljlxgX9H4vNkkFNmOHbo8VKIFy38lJ/Q4tx4duSEoyX8dOCERibfjjd
 d1P6p
X-Received: by 2002:a05:7022:3f0d:b0:128:d0cb:7a97 with SMTP id
 a92af1059eb24-129a70e3947mr547387c88.3.1773838397597; Wed, 18 Mar 2026
 05:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260306120513.57826-1-dev@pp3345.net>
In-Reply-To: <20260306120513.57826-1-dev@pp3345.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 18 Mar 2026 08:53:05 -0400
X-Gm-Features: AaiRm53W0wqHwWOZQryLUHuYnj_UK63FoqSdVyXvsgcd1PMM3eZeKbidyOHVnNE
Message-ID: <CADnq5_NtxbGSj9vVpEOn7-8BZ15ZDP-6HEna+jLJ9EjCn3W_Lw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Do not skip unrelated mode changes in
 DSC validation
To: Yussuf Khalil <dev@pp3345.net>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Leo (Sunpeng) Li" <Sunpeng.Li@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org
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

@Wentland, Harry
, @Leo (Sunpeng) Li Can you take a look at this?  I'm not familiar
enough with kms state handling.

Thanks,

Alex

On Fri, Mar 6, 2026 at 7:24=E2=80=AFAM Yussuf Khalil <dev@pp3345.net> wrote=
:
>
> Starting with commit 17ce8a6907f7 ("drm/amd/display: Add dsc pre-validati=
on in
> atomic check"), amdgpu resets the CRTC state mode_changed flag to false w=
hen
> recomputing the DSC configuration results in no timing change for a parti=
cular
> stream.
>
> However, this is incorrect in scenarios where a change in MST/DSC configu=
ration
> happens in the same KMS commit as another (unrelated) mode change. For ex=
ample,
> the integrated panel of a laptop may be configured differently (e.g., HDR
> enabled/disabled) depending on whether external screens are attached. In =
this
> case, plugging in external DP-MST screens may result in the mode_changed =
flag
> being dropped incorrectly for the integrated panel if its DSC configurati=
on
> did not change during precomputation in pre_validate_dsc().
>
> At this point, however, dm_update_crtc_state() has already created new st=
reams
> for CRTCs with DSC-independent mode changes. In turn,
> amdgpu_dm_commit_streams() will never release the old stream, resulting i=
n a
> memory leak. amdgpu_dm_atomic_commit_tail() will never acquire a referenc=
e to
> the new stream either, which manifests as a use-after-free when the strea=
m gets
> disabled later on:
>
> BUG: KASAN: use-after-free in dc_stream_release+0x25/0x90 [amdgpu]
> Write of size 4 at addr ffff88813d836524 by task kworker/9:9/29977
>
> Workqueue: events drm_mode_rmfb_work_fn
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x6e/0xa0
>  print_address_description.constprop.0+0x88/0x320
>  ? dc_stream_release+0x25/0x90 [amdgpu]
>  print_report+0xfc/0x1ff
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __virt_addr_valid+0x225/0x4e0
>  ? dc_stream_release+0x25/0x90 [amdgpu]
>  kasan_report+0xe1/0x180
>  ? dc_stream_release+0x25/0x90 [amdgpu]
>  kasan_check_range+0x125/0x200
>  dc_stream_release+0x25/0x90 [amdgpu]
>  dc_state_destruct+0x14d/0x5c0 [amdgpu]
>  dc_state_release.part.0+0x4e/0x130 [amdgpu]
>  dm_atomic_destroy_state+0x3f/0x70 [amdgpu]
>  drm_atomic_state_default_clear+0x8ee/0xf30
>  ? drm_mode_object_put.part.0+0xb1/0x130
>  __drm_atomic_state_free+0x15c/0x2d0
>  atomic_remove_fb+0x67e/0x980
>
> Since there is no reliable way of figuring out whether a CRTC has unrelat=
ed
> mode changes pending at the time of DSC validation, remember the value of=
 the
> mode_changed flag from before the point where a CRTC was marked as potent=
ially
> affected by a change in DSC configuration. Reset the mode_changed flag to=
 this
> earlier value instead in pre_validate_dsc().
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5004
> Fixes: 17ce8a6907f7 ("drm/amd/display: Add dsc pre-validation in atomic c=
heck")
> Signed-off-by: Yussuf Khalil <dev@pp3345.net>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           | 5 +++++
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h           | 1 +
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 4 +++-
>  3 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b3d6f2cd8..4efd77477 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -12523,6 +12523,11 @@ static int amdgpu_dm_atomic_check(struct drm_dev=
ice *dev,
>         }
>
>         if (dc_resource_is_dsc_encoding_supported(dc)) {
> +               for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state=
, new_crtc_state, i) {
> +                       dm_new_crtc_state =3D to_dm_crtc_state(new_crtc_s=
tate);
> +                       dm_new_crtc_state->mode_changed_independent_from_=
dsc =3D new_crtc_state->mode_changed;
> +               }
> +
>                 for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state=
, new_crtc_state, i) {
>                         if (drm_atomic_crtc_needs_modeset(new_crtc_state)=
) {
>                                 ret =3D add_affected_mst_dsc_crtcs(state,=
 crtc);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 800813671..d15812d51 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -984,6 +984,7 @@ struct dm_crtc_state {
>
>         bool freesync_vrr_info_changed;
>
> +       bool mode_changed_independent_from_dsc;
>         bool dsc_force_changed;
>         bool vrr_supported;
>         struct mod_freesync_config freesync_config;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 7be50e8c0..5d8c4c702 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -1744,9 +1744,11 @@ int pre_validate_dsc(struct drm_atomic_state *stat=
e,
>                         int ind =3D find_crtc_index_in_state_by_stream(st=
ate, stream);
>
>                         if (ind >=3D 0) {
> +                               struct dm_crtc_state *dm_new_crtc_state =
=3D to_dm_crtc_state(state->crtcs[ind].new_state);
> +
>                                 DRM_INFO_ONCE("%s:%d MST_DSC no mode chan=
ged for stream 0x%p\n",
>                                                 __func__, __LINE__, strea=
m);
> -                               state->crtcs[ind].new_state->mode_changed=
 =3D 0;
> +                               dm_new_crtc_state->base.mode_changed =3D =
dm_new_crtc_state->mode_changed_independent_from_dsc;
>                         }
>                 }
>         }
> --
> 2.53.0
>
>
