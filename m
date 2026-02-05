Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4BFAECD9A9
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 21:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6621310E0B4;
	Thu,  5 Feb 2026 21:53:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="izb1NM8D";
	dkim-atps=neutral
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 273B710E0B4
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 21:53:54 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2b807f85e10so167946eec.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Feb 2026 13:53:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770328433; cv=none;
 d=google.com; s=arc-20240605;
 b=kDpQQzAsGWlk8K9EvcWjSFkA/XpNetPvETgrcapuo73aKdQDFHzg+hdEZHVXdnHO9C
 Gz2jX0Bjc08llILDct5INWJzduDCBJGu+Rjx8dB6WCK/NkYvAVuExfUyeetI+O9zFjl+
 ZOFIY3kRX5p7MTT9cQVyR6h6+bXL82fNOVw31raXXquapOSbx4I0nQcWZ0nJFvytePPQ
 v/n5mJqQqForihycRMPMIMGNn81yynBq4Fr5Kr/pQMZachH2gBM3/Acd2t6K+4+hm5vJ
 1kOzdM1mE++iEpdGi0sj4ktYka/366eLar3CacmaTQDXCNPC772Tms+r26yWdJ28vlOM
 4pDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+WAMTAABoQZPX6lZI9z6UyeB8TxSuSEPXuSYJoq808g=;
 fh=F+sWvFG8+LgpudWxHWU7QkLMNS2HMweKIf2W0s+zJ74=;
 b=J0TnT94sl53XXuxhf2VK6cXTlx4TGQqFW0Xd+0dJ2SjxRMKoSTujjaiTozz7Yy+CaM
 C8yeCZkOYgNx8bPINFeh8N4nXcTKMc3YrVwMa7JKo6+i6xVWSWwZe4iJaLU9oDfqBiV4
 RsvNAqvkB0vUiNvFmpJJAdjisQwm9Nr3tjt072VZaihr8sRupdbzzyjD/cwncAeLt0+6
 5gp+mSWL8nYcz+FcfdOiHQV4TRuxRQ77szTCJfbYyYHEnma3D41YYLy1C9JaXUhMiS2u
 RHbBjaCUbQIQVjzcDPEkGSLdw0giGFfQleLnxO6Ii2fFSbsXBRDrsp8GgL9eOEuJgDQ8
 YU+Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770328433; x=1770933233; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+WAMTAABoQZPX6lZI9z6UyeB8TxSuSEPXuSYJoq808g=;
 b=izb1NM8D3nXHXWAZR9djqtkfDUkh09jE26gJcXA5rmzX8Ee0ON9Bkb+Oc0KdxPB628
 c6tTkvPz/4HXi3Focp0zLIRIHIZ/uCFhtY8dw2iMNCGHNO9UbhczDTfPglcpQmB+6L9V
 9tNmu39RRV9ESEdd7YT4Dr4ApiYn0PdQ8YX4DJzBzNhPhSeZwD5eK9VZuIzFWso1QLUX
 oKWlxbdDRyv2XY7Jx0lGkBxKMprgZBET8+I6R7gO6oUi25roIgw4ABdguFKnsQfVLaxe
 QspMLLXVWP3sjmgAPBR6YrAQ1PeoDX9iJ7A+94F7iicRlt9cMs8k0LhNJXD+s5ke5aVZ
 gOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770328433; x=1770933233;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+WAMTAABoQZPX6lZI9z6UyeB8TxSuSEPXuSYJoq808g=;
 b=PeET/iCVFBWEljqaT2BX4FoiL1iwOyxwJJ0EBhd1i7hjEBLn1EP5Dh0QDOW0t6shRL
 4ZkhcW/pUQr4J+hZzox3YZDJHRl06uzlwDDEmfYarOPWf7kqiAKpvihdwZ+ylMeOMAh7
 lXs8eCE2HHu4g9madDzkuqhOZ9L0dVsCsi6pw3ZywLsb3OaH2XWBaMuyoiq7PF1UK09e
 oFnNkQrmp8hGns7L3wzsjp1JLWC+8ikiSqjSsrvsyrTLL2Fn0OPeEvlHXq10JAK8Ja9w
 QG87kcBzDVDOlF86OUqJnqZmPPK9ViMo1w83kgYdJdc5EysGQsKYycg3Yf2ZG8ZAnQXb
 bcsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5fgOhIMgClLU1zUs13+eOnGkKe0wBDFBQs1SqFCVwwfIELEnGFwU/d4T94ehMc9fI0sZXxWGa@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzuHdpJxq6NMi9okMvAItadsG/PUiuqAWYrHUiIL27lvtGTNNJo
 cFtZLxj7pGOjSxeLq/HVsj3Wgeh5rkI6qbqmS/GvULhJ1fq9EbMTmfGRxtEG2EZc5xOsMFj6qLE
 QMnPnFz9ov/hMxgmxLjG6X3FS0c7HZGHcgQ==
X-Gm-Gg: AZuq6aKwIccA0HbX+QQT1QtWNMQOXwMeNpBTa+uLo5+cxaQuPYPJ+lsxyUazaq9hVS2
 miQtwCZrIXBu6nf3zMamaH+JFBe5wrvEY875swvGhNS/rQNg6Ixs6QxSOhLP4G0i7AI7opQpusG
 NDu3n8hpeOsJ6vONQwsv6NhgR/dk6oA6ZGUkjzTyy32IMfEFnsjM1q9m6tXoFnR+uIuI2vmbt7i
 dZ2HjE3WAM8UzFBuOJqE2goSZ/hnHFRDMkFHmALdHTaQSAZD8EXDVFmsFOLpgdvaa8kHQ4Z
X-Received: by 2002:a05:7022:6ba3:b0:11b:98e8:624e with SMTP id
 a92af1059eb24-12703fb0931mr172877c88.4.1770328433238; Thu, 05 Feb 2026
 13:53:53 -0800 (PST)
MIME-Version: 1.0
References: <20260205065130.654921-1-perry.yuan@amd.com>
 <20260205065130.654921-18-perry.yuan@amd.com>
In-Reply-To: <20260205065130.654921-18-perry.yuan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Feb 2026 16:53:41 -0500
X-Gm-Features: AZwV_Qirj-DE3lfo2AqkQZqYyPrIUeqHNyBv-41Zbmu-_0VlYVgQh2o-tT8H4PQ
Message-ID: <CADnq5_O=GYNKR4KBq52yGBvB3u2ENY=cZ9B-Q8iU=0LYFMd0tw@mail.gmail.com>
Subject: Re: [PATCH 18/22] drm/amdgpu: clean up PTL structure member naming
 convention
To: Perry Yuan <perry.yuan@amd.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 yifan1.zhang@amd.com
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

On Thu, Feb 5, 2026 at 1:52=E2=80=AFAM Perry Yuan <perry.yuan@amd.com> wrot=
e:
>
> Remove redundant 'ptl_' prefix from amdgpu_ptl structure members
> since they are already accessed through a ptl pointer, making the
> prefix redundant and verbose.
>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

In general with this patch set, I'd suggest cleaning up the history
and splitting up the patches with the various fixes and reworks
squashed into the original patches.  That way we don't have in
consistent states in the middle of the series that may affect
bisecing.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 57 +++++++++++-----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    | 12 ++---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 12 ++---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   | 26 +++++-----
>  5 files changed, 55 insertions(+), 54 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 827fbdb81011..da7585d1c6e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4442,7 +4442,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         mutex_init(&adev->virt.vf_errors.lock);
>         hash_init(adev->mn_hash);
>         mutex_init(&adev->psp.mutex);
> -       mutex_init(&adev->psp.ptl.ptl_mutex);
> +       mutex_init(&adev->psp.ptl.mutex);
>         mutex_init(&adev->notifier_lock);
>         mutex_init(&adev->pm.stable_pstate_ctx_lock);
>         mutex_init(&adev->benchmark_mutex);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 357357523347..95af5f1d8f5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1267,9 +1267,9 @@ static int psp_ptl_invoke(struct psp_context *psp, =
u32 req_code,
>                 break;
>         case PSP_PTL_PERF_MON_SET:
>                 /* Update cached state only on success */
> -               ptl->ptl_enabled =3D *ptl_state;
> -               ptl->ptl_fmt1    =3D *fmt1;
> -               ptl->ptl_fmt2    =3D *fmt2;
> +               ptl->enabled =3D *ptl_state;
> +               ptl->fmt1    =3D *fmt1;
> +               ptl->fmt2    =3D *fmt2;
>                 break;
>         }
>
> @@ -1285,7 +1285,7 @@ int amdgpu_ptl_perf_monitor_ctrl(struct amdgpu_devi=
ce *adev, u32 req_code,
>  {
>         uint32_t ptl_fmt1, ptl_fmt2;
>         struct psp_context *psp;
> -       struct amdgpu_ptl *ptl =3D &adev->psp.ptl;
> +       struct amdgpu_ptl *ptl;
>
>         if (!adev || !ptl_state || !fmt1 || !fmt2)
>                 return -EINVAL;
> @@ -1294,6 +1294,7 @@ int amdgpu_ptl_perf_monitor_ctrl(struct amdgpu_devi=
ce *adev, u32 req_code,
>                 return 0;
>
>         psp =3D &adev->psp;
> +       ptl =3D &psp->ptl;
>
>         if (amdgpu_ip_version(adev, GC_HWIP, 0) !=3D IP_VERSION(9, 4, 4) =
||
>                         psp->sos.fw_version < 0x0036081a)
> @@ -1308,9 +1309,9 @@ int amdgpu_ptl_perf_monitor_ctrl(struct amdgpu_devi=
ce *adev, u32 req_code,
>          * Add check to skip if state and formats are identical to curren=
t ones
>          */
>         if (req_code =3D=3D PSP_PTL_PERF_MON_SET &&
> -                       ptl->ptl_enabled =3D=3D *ptl_state &&
> -                       ptl->ptl_fmt1 =3D=3D ptl_fmt1 &&
> -                       ptl->ptl_fmt2 =3D=3D ptl_fmt2)
> +                       ptl->enabled =3D=3D *ptl_state &&
> +                       ptl->fmt1 =3D=3D ptl_fmt1 &&
> +                       ptl->fmt2 =3D=3D ptl_fmt2)
>                 return 0;
>
>         return psp_ptl_invoke(psp, req_code, ptl_state, &ptl_fmt1, &ptl_f=
mt2);
> @@ -1354,33 +1355,33 @@ static ssize_t ptl_enable_store(struct device *de=
v,
>         uint32_t ptl_state, fmt1, fmt2;
>         int ret;
>
> -       mutex_lock(&ptl->ptl_mutex);
> +       mutex_lock(&ptl->mutex);
>         if (sysfs_streq(buf, "enabled") || sysfs_streq(buf, "1")) {
>                 enable =3D true;
>         } else if (sysfs_streq(buf, "disabled") || sysfs_streq(buf, "0"))=
 {
>                 enable =3D false;
>         } else {
> -               mutex_unlock(&ptl->ptl_mutex);
> +               mutex_unlock(&ptl->mutex);
>                 return -EINVAL;
>         }
>
> -       fmt1 =3D ptl->ptl_fmt1;
> -       fmt2 =3D ptl->ptl_fmt2;
> +       fmt1 =3D ptl->fmt1;
> +       fmt2 =3D ptl->fmt2;
>         ptl_state =3D enable ? 1 : 0;
>
> -       cur_enabled =3D READ_ONCE(psp->ptl_enabled);
> +       cur_enabled =3D READ_ONCE(psp->enabled);
>         if (cur_enabled =3D=3D enable) {
> -               mutex_unlock(&psp->ptl_mutex);
> +               mutex_unlock(&psp->mutex);
>                 return count;
>         }
>
>         ret =3D amdgpu_ptl_perf_monitor_ctrl(adev, PSP_PTL_PERF_MON_SET, =
&ptl_state, &fmt1, &fmt2);
>         if (ret) {
>                 dev_err(adev->dev, "Failed to set PTL err =3D %d\n", ret)=
;
> -               mutex_unlock(&ptl->ptl_mutex);
> +               mutex_unlock(&ptl->mutex);
>                 return ret;
>         }
> -       mutex_unlock(&ptl->ptl_mutex);
> +       mutex_unlock(&ptl->mutex);
>
>         return count;
>  }
> @@ -1391,7 +1392,7 @@ static ssize_t ptl_enable_show(struct device *dev, =
struct device_attribute *attr
>         struct amdgpu_device *adev =3D drm_to_adev(ddev);
>         struct psp_context *psp =3D &adev->psp;
>
> -       return sysfs_emit(buf, "%s\n", psp->ptl.ptl_enabled ? "enabled" :=
 "disabled");
> +       return sysfs_emit(buf, "%s\n", psp->ptl.enabled ? "enabled" : "di=
sabled");
>  }
>
>  static ssize_t ptl_format_store(struct device *dev,
> @@ -1408,13 +1409,13 @@ static ssize_t ptl_format_store(struct device *de=
v,
>         int ret;
>
>         /* Only allow format update when PTL is enabled */
> -       if (!ptl->ptl_enabled)
> +       if (!ptl->enabled)
>                 return -EPERM;
>
> -       mutex_lock(&ptl->ptl_mutex);
> +       mutex_lock(&ptl->mutex);
>         /* Parse input, expecting "FMT1,FMT2" */
>         if (sscanf(buf, "%7[^,],%7s", fmt1_str, fmt2_str) !=3D 2) {
> -               mutex_unlock(&ptl->ptl_mutex);
> +               mutex_unlock(&ptl->mutex);
>                 return -EINVAL;
>         }
>
> @@ -1424,20 +1425,20 @@ static ssize_t ptl_format_store(struct device *de=
v,
>         if (fmt1_enum >=3D AMDGPU_PTL_FMT_INVALID ||
>                         fmt2_enum >=3D AMDGPU_PTL_FMT_INVALID ||
>                         fmt1_enum =3D=3D fmt2_enum) {
> -               mutex_unlock(&ptl->ptl_mutex);
> +               mutex_unlock(&ptl->mutex);
>                 return -EINVAL;
>         }
>
> -       ptl_state =3D ptl->ptl_enabled;
> +       ptl_state =3D ptl->enabled;
>         fmt1 =3D fmt1_enum;
>         fmt2 =3D fmt2_enum;
>         ret =3D amdgpu_ptl_perf_monitor_ctrl(adev, PSP_PTL_PERF_MON_SET, =
&ptl_state, &fmt1, &fmt2);
>         if (ret) {
>                 dev_err(adev->dev, "Failed to update PTL err =3D %d\n", r=
et);
> -               mutex_unlock(&ptl->ptl_mutex);
> +               mutex_unlock(&ptl->mutex);
>                 return ret;
>         }
> -       mutex_unlock(&ptl->ptl_mutex);
> +       mutex_unlock(&ptl->mutex);
>
>         return count;
>  }
> @@ -1449,8 +1450,8 @@ static ssize_t ptl_format_show(struct device *dev, =
struct device_attribute *attr
>         struct psp_context *psp =3D &adev->psp;
>
>         return sysfs_emit(buf, "%s,%s\n",
> -                       amdgpu_ptl_fmt_str[psp->ptl.ptl_fmt1],
> -                       amdgpu_ptl_fmt_str[psp->ptl.ptl_fmt2]);
> +                       amdgpu_ptl_fmt_str[psp->ptl.fmt1],
> +                       amdgpu_ptl_fmt_str[psp->ptl.fmt2]);
>  }
>
>  static umode_t amdgpu_ptl_is_visible(struct kobject *kobj, struct attrib=
ute *attr, int idx)
> @@ -1460,7 +1461,7 @@ static umode_t amdgpu_ptl_is_visible(struct kobject=
 *kobj, struct attribute *att
>         struct amdgpu_device *adev =3D drm_to_adev(ddev);
>
>         /* Only show PTL sysfs files if PTL hardware is supported */
> -       if (!adev->psp.ptl.ptl_hw_supported)
> +       if (!adev->psp.ptl.hw_supported)
>                 return 0;
>
>         return attr->mode;
> @@ -1468,7 +1469,7 @@ static umode_t amdgpu_ptl_is_visible(struct kobject=
 *kobj, struct attribute *att
>
>  int amdgpu_ptl_sysfs_init(struct amdgpu_device *adev)
>  {
> -       if (!adev->psp.ptl.ptl_hw_supported)
> +       if (!adev->psp.ptl.hw_supported)
>                 return 0;
>
>         return sysfs_create_group(&adev->dev->kobj, &amdgpu_ptl_attr_grou=
p);
> @@ -1476,7 +1477,7 @@ int amdgpu_ptl_sysfs_init(struct amdgpu_device *ade=
v)
>
>  void amdgpu_ptl_sysfs_fini(struct amdgpu_device *adev)
>  {
> -       if (!adev->psp.ptl.ptl_hw_supported)
> +       if (!adev->psp.ptl.hw_supported)
>                 return;
>
>         sysfs_remove_group(&adev->dev->kobj, &amdgpu_ptl_attr_group);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.h
> index d8591602b304..0997b13a5f41 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -383,13 +383,13 @@ struct psp_ptl_perf_req {
>  };
>
>  struct amdgpu_ptl {
> -       enum amdgpu_ptl_fmt             ptl_fmt1;
> -       enum amdgpu_ptl_fmt             ptl_fmt2;
> -       bool                            ptl_enabled;
> -       bool                            ptl_hw_supported;
> +       enum amdgpu_ptl_fmt             fmt1;
> +       enum amdgpu_ptl_fmt             fmt2;
> +       bool                            enabled;
> +       bool                            hw_supported;
>         /* PTL disable reference counting */
> -       atomic_t                        ptl_disable_ref;
> -       struct mutex                    ptl_mutex;
> +       atomic_t                        disable_ref;
> +       struct mutex                    mutex;
>  };
>
>  struct psp_context {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index f53934edfd3b..13933e3ee096 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -2380,12 +2380,12 @@ static int gfx_v9_4_3_perf_monitor_ptl_init(struc=
t amdgpu_device *adev, bool sta
>         if (!adev->psp.funcs)
>                 return -EOPNOTSUPP;
>
> -       if (!ptl->ptl_hw_supported) {
> +       if (!ptl->hw_supported) {
>                 fmt1 =3D GFX_FTYPE_I8;
>                 fmt2 =3D GFX_FTYPE_BF16;
>         } else {
> -               fmt1 =3D ptl->ptl_fmt1;
> -               fmt2 =3D ptl->ptl_fmt2;
> +               fmt1 =3D ptl->fmt1;
> +               fmt2 =3D ptl->fmt2;
>         }
>
>         /* initialize PTL with default formats: GFX_FTYPE_I8 & GFX_FTYPE_=
BF16 */
> @@ -2394,9 +2394,9 @@ static int gfx_v9_4_3_perf_monitor_ptl_init(struct =
amdgpu_device *adev, bool sta
>         if (r)
>                 return r;
>
> -       ptl->ptl_hw_supported =3D true;
> +       ptl->hw_supported =3D true;
>
> -       atomic_set(&ptl->ptl_disable_ref, 0);
> +       atomic_set(&ptl->disable_ref, 0);
>
>         return 0;
>  }
> @@ -2406,7 +2406,7 @@ static int gfx_v9_4_3_hw_fini(struct amdgpu_ip_bloc=
k *ip_block)
>         struct amdgpu_device *adev =3D ip_block->adev;
>         int i, num_xcc;
>
> -       if (adev->psp.ptl.ptl_hw_supported)
> +       if (adev->psp.ptl.hw_supported)
>                 gfx_v9_4_3_perf_monitor_ptl_init(adev, 0);
>
>         amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_chardev.c
> index efdd19d6d6da..c276ef6801d0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1768,12 +1768,12 @@ int kfd_ptl_control(struct kfd_process_device *pd=
d, bool enable)
>  {
>         struct amdgpu_device *adev =3D pdd->dev->adev;
>         struct amdgpu_ptl *ptl =3D &adev->psp.ptl;
> -       enum amdgpu_ptl_fmt pref_format1 =3D ptl->ptl_fmt1;
> -       enum amdgpu_ptl_fmt pref_format2 =3D ptl->ptl_fmt2;
> +       enum amdgpu_ptl_fmt pref_format1 =3D ptl->fmt1;
> +       enum amdgpu_ptl_fmt pref_format2 =3D ptl->fmt2;
>         uint32_t ptl_state =3D enable ? 1 : 0;
>         int ret;
>
> -       if (!ptl->ptl_hw_supported)
> +       if (!ptl->hw_supported)
>                 return -EOPNOTSUPP;
>
>         if (!pdd->dev->kfd2kgd || !pdd->dev->kfd2kgd->ptl_ctrl)
> @@ -1800,15 +1800,15 @@ int kfd_ptl_disable_request(struct kfd_process_de=
vice *pdd,
>         struct amdgpu_ptl *ptl =3D &adev->psp.ptl;
>         int ret =3D 0;
>
> -       mutex_lock(&ptl->ptl_mutex);
> +       mutex_lock(&ptl->mutex);
>
>         if (pdd->ptl_disable_req)
>                 goto out;
>
> -       if (atomic_inc_return(&ptl->ptl_disable_ref) =3D=3D 1) {
> +       if (atomic_inc_return(&ptl->disable_ref) =3D=3D 1) {
>                 ret =3D kfd_ptl_control(pdd, false);
>                 if (ret) {
> -                       atomic_dec(&ptl->ptl_disable_ref);
> +                       atomic_dec(&ptl->disable_ref);
>                         dev_warn(pdd->dev->adev->dev,
>                                         "failed to disable PTL\n");
>                         goto out;
> @@ -1817,7 +1817,7 @@ int kfd_ptl_disable_request(struct kfd_process_devi=
ce *pdd,
>         pdd->ptl_disable_req =3D true;
>
>  out:
> -       mutex_unlock(&ptl->ptl_mutex);
> +       mutex_unlock(&ptl->mutex);
>         return ret;
>  }
>
> @@ -1828,15 +1828,15 @@ int kfd_ptl_disable_release(struct kfd_process_de=
vice *pdd,
>         struct amdgpu_ptl *ptl =3D &adev->psp.ptl;
>         int ret =3D 0;
>
> -       mutex_lock(&ptl->ptl_mutex);
> +       mutex_lock(&ptl->mutex);
>
>         if (!pdd->ptl_disable_req)
>                 goto out;
>
> -       if (atomic_dec_return(&ptl->ptl_disable_ref) =3D=3D 0) {
> +       if (atomic_dec_return(&ptl->disable_ref) =3D=3D 0) {
>                 ret =3D kfd_ptl_control(pdd, true);
>                 if (ret) {
> -                       atomic_inc(&ptl->ptl_disable_ref);
> +                       atomic_inc(&ptl->disable_ref);
>                         dev_warn(adev->dev, "Failed to enable PTL on rele=
ase: %d\n", ret);
>                         goto out;
>                 }
> @@ -1845,7 +1845,7 @@ int kfd_ptl_disable_release(struct kfd_process_devi=
ce *pdd,
>         pdd->ptl_disable_req =3D false;
>
>  out:
> -       mutex_unlock(&ptl->ptl_mutex);
> +       mutex_unlock(&ptl->mutex);
>         return ret;
>  }
>
> @@ -3338,7 +3338,7 @@ static inline uint32_t profile_lock_device(struct k=
fd_process *p,
>                         kfd->profiler_process =3D p;
>                         status =3D 0;
>                         mutex_unlock(&kfd->profiler_lock);
> -                       if (ptl->ptl_hw_supported) {
> +                       if (ptl->hw_supported) {
>                                 status =3D kfd_ptl_disable_request(pdd, p=
);
>                                 if (status !=3D 0)
>                                         dev_err(kfd_device,
> @@ -3356,7 +3356,7 @@ static inline uint32_t profile_lock_device(struct k=
fd_process *p,
>                 status =3D 0;
>                 mutex_unlock(&kfd->profiler_lock);
>
> -               if (ptl->ptl_hw_supported) {
> +               if (ptl->hw_supported) {
>                         status =3D kfd_ptl_disable_release(pdd, p);
>                         if (status)
>                                 dev_err(kfd_device,
> --
> 2.34.1
>
