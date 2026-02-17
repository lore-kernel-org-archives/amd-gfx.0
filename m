Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781D1E909CF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 16:02:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A8A810E00D;
	Tue, 17 Feb 2026 16:02:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E9qoWt1U";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06A0C10E00D
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Feb 2026 16:02:30 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-12734af2cdcso292800c88.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Feb 2026 08:02:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771344149; cv=none;
 d=google.com; s=arc-20240605;
 b=EFBI2tURG8zct/7B7OV1fKgR/Rl9cXkaDIfb6+KNCs7K3rp4O2yXu+dqokwISL5k1R
 xOZ4T9q/JRcwkH6vNUxqSBdDHeoDcTQ1l56tNkQ6kUTQXUSW7aficUJjqUu/Jpm/VozC
 eoqJj8MKwjaMhhQ/CllrYn6fxk1SZo/bX3/SRfBG6WVkO2psAH5bxe2eCWnxKRWGF8Yl
 /MgG/AFpN0isR1zwIkSGglSzoyuiRA7WjwI95NqEB+POQAHoGf6rNYfgP9bOKM/MGvBz
 Se4VvkUfbDjjZ2fIcpAffnTbT8FngrdWfN97eMLwVGe390nTlemlJ2kWNQmhoiaGLka+
 XkiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EqXPlDnCCR4VXmK4w3wj/qdnA6EVnGunafgo1gp6IFQ=;
 fh=Q9moay4qfMBzIfPjw6PB2oEQ9YEov5asM+HH8DuR0z4=;
 b=HyK8GiitxwZgAAqRFHKoUmUJy8fjW8hqiVUf7/4pOe6nMq2m2zc5KdxKiXxudv4NBG
 mrZ5N9JFY6Pp5D8UWke4MWkuOSQO0ah9LFsPdNdSCEpIo/vvKjx4qh1qYOlp6J2Y2DlK
 PxJ+u/98wWrxKMv1zI1mMjirAR5ns6X4oizjBkMGXQNaGc56HgOsvIjEWvLAdS60xYwu
 JbvB3ehrK3xyuFimLT2NhCVRy5b1lkV5GURNiPM07N1MtqXFkb5524622jCU+3999rpg
 JNoqoSGyxM09jctNoE0hrifPxrVNosqLWN0pmz8qSn3jhJQAXLoiEdbW3Y7UugO/tGwR
 h8Rg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771344149; x=1771948949; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EqXPlDnCCR4VXmK4w3wj/qdnA6EVnGunafgo1gp6IFQ=;
 b=E9qoWt1UXz4GqAF3vUOSVMN6elXtsv/tzqEdr0MdDhWLnOHzCSJ7rzIAJa9YRZSQS5
 dotvjjIOwkEYu9Os68Fb6Rr5UTY/oN9kMX92KaQVGD6ztmKbkKAA7fTVsj804OXmWDgX
 MqZJPucr0qh6NZfhiQt+TiSgAvzB9aGUhr2vYSb0rlFkN8MVKsKTZrSuMQVtcDzD5tOV
 eesTLk/KvsHwyxuP47PVRRuIWEkM6zqK8nvJoQ8qZRMEnGnLxn+jp3ohjSz8OKcebhPZ
 NYB7WRVspsKH9vO/1EMV1evkf3KQCzeTvqnkZzYRbMYbMGV82sg5Q/hJKZ4XtFPxt+T3
 vHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771344149; x=1771948949;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EqXPlDnCCR4VXmK4w3wj/qdnA6EVnGunafgo1gp6IFQ=;
 b=HPeq70f+Dw30g3Y53gS5RDOvuuTe21vkEVlGMHArjdQ1HpLRi4+rss2otJwlnuch78
 4FCrF164OXL75SyiQNFa2chBcFB5ZysD8hNV6upSbSh6mUgOSUyQu/VwNIIswNstnoqq
 1LTGuq2KIaCbXhxo4Oc1aYiu1Xrqd2lOzElV1OuDlJzvpiFWvZ3zvDLM/+YEyDS4aR0D
 EfVATy8+KmyUKY1RmI94IwmFQc2wQuvIzuQayNBkWqSKWbg0YvIrg1raAX33AqmjXKAa
 4LevaSBbRTiMfvWoZ60MVXGP81aZPjbXIVF/sGjk4ugMACNm08Ilc1QNnNNCVCOhapxp
 mGRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB+ttdSYYDyo0gkHU8vwlL3/hnt5TlGJMWEPRKD7iJKJFq45fKL+ujrB643WCeg1jRIVjbmWjS@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8hWpQG27oKyzOwbCxUepqzSTu4roCKHr3W7xbmiyxYQuVLmv3
 AnZsCJOml8zCGBof26AY+o8jc+CAqkBu80YXO6QPh7CzxA7/lUp/ik0eFJIBVS8qnWQOUkSl03R
 E8gySlafNvUlfdiR8u38pQ/jHAJhMh3OHqQ==
X-Gm-Gg: AZuq6aLelqzhJc3IY6JLRscL4bLrNkKqGVPXl0b2MaExlV8HfQiLn8a32iA5rbxGLeG
 7Apaya5NqWT8Co4de8VUminbjjD8RBT6tQh0N5l/i+zzZmM2xbgBo7zzftoE8VmOgFmGw4HR2gQ
 GqgEswdtyc+VOY7V7oMk3qu5VaZ6ao9vlFq+uqd8nJZ1OYtpHPlpqa7o68i9MmVgsFz0mXp5VEN
 dkplWcKdgeMyGX/fohb4NVkTmebFyyCIsWZou0+yECJ649RHeyOCrhj2dKU1jfmxWFBWHYw0sXE
 HuKRJaFlK3vgRRNkZFEeSbLV1Isa6/v6HtCCtGLJkSb+4FXrNz8unpmvIKWcnIhCGVryCg==
X-Received: by 2002:a05:7022:2508:b0:11e:3e9:3e98 with SMTP id
 a92af1059eb24-127399685bfmr3520040c88.7.1771344148947; Tue, 17 Feb 2026
 08:02:28 -0800 (PST)
MIME-Version: 1.0
References: <20260211102657.4180-1-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20260211102657.4180-1-pierre-eric.pelloux-prayer@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Feb 2026 11:02:15 -0500
X-Gm-Features: AaiRm51NhEBeOoc9apveFMnbjgnXnafm5yb1e5nA61D0DGNbsMPeN_hhEcOJsMo
Message-ID: <CADnq5_NsUnDMCQHH=cGVLpkqZeBE-ntaTALN=OYLZdLNg6qz-A@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] drm/amdgpu: include ip discovery data in
 devcoredump
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Wed, Feb 11, 2026 at 5:28=E2=80=AFAM Pierre-Eric Pelloux-Prayer
<pierre-eric.pelloux-prayer@amd.com> wrote:
>
> This is the best way to describe the GPU to a tool loading
> the devcoredump.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 42 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  3 ++
>  3 files changed, 47 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index 0bb430853a9f..42a969512dcc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -262,6 +262,8 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, =
size_t count,
>                 }
>         }
>
> +       amdgpu_discovery_dump(coredump->adev, &p);
> +
>         /* IP firmware information */
>         drm_printf(&p, "\nIP Firmwares\n");
>         amdgpu_devcoredump_fw_info(coredump->adev, &p);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 41e63c286912..d7325c23fa53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1380,6 +1380,48 @@ static void amdgpu_discovery_sysfs_fini(struct amd=
gpu_device *adev)
>         kobject_put(&ip_top->kobj);
>  }
>
> +/* devcoredump support */
> +void amdgpu_discovery_dump(struct amdgpu_device *adev, struct drm_printe=
r *p)
> +{
> +       struct ip_discovery_top *ip_top =3D adev->discovery.ip_top;
> +       struct ip_die_entry *ip_die_entry;
> +       struct list_head *el_die, *el_hw_id, *el_hw_inst;
> +       struct ip_hw_id *hw_id;
> +       struct kset *die_kset;
> +       struct ip_hw_instance *ip_inst;
> +       int i =3D 0, j;
> +
> +       die_kset =3D &ip_top->die_kset;
> +
> +       drm_printf(p, "\nHW IP Discovery\n");
> +       spin_lock(&die_kset->list_lock);
> +       list_for_each(el_die, &die_kset->list) {
> +               drm_printf(p, "die %d\n", i++);
> +               ip_die_entry =3D to_ip_die_entry(list_to_kobj(el_die));
> +
> +               list_for_each(el_hw_id, &ip_die_entry->ip_kset.list) {
> +                       hw_id =3D to_ip_hw_id(list_to_kobj(el_hw_id));
> +                       drm_printf(p, "hw_id %d %s\n", hw_id->hw_id, hw_i=
d_names[hw_id->hw_id]);
> +
> +                       list_for_each(el_hw_inst, &hw_id->hw_id_kset.list=
) {
> +                               ip_inst =3D to_ip_hw_instance(list_to_kob=
j(el_hw_inst));
> +                               drm_printf(p, "\tinstance %d\n", ip_inst-=
>num_instance);
> +                               drm_printf(p, "\tmajor %d\n", ip_inst->ma=
jor);
> +                               drm_printf(p, "\tminor %d\n", ip_inst->mi=
nor);
> +                               drm_printf(p, "\trevision %d\n", ip_inst-=
>revision);
> +                               drm_printf(p, "\tharvest 0x%01X\n", ip_in=
st->harvest);
> +                               drm_printf(p, "\tnum_base_addresses %d\n"=
,
> +                                          ip_inst->num_base_addresses);
> +                               for (j =3D 0; j < ip_inst->num_base_addre=
sses; j++)
> +                                       drm_printf(p, "\tbase_addr[%d] 0x=
%08X\n",
> +                                                  j, ip_inst->base_addr[=
j]);
> +                       }
> +               }
> +       }
> +       spin_unlock(&die_kset->list_lock);
> +}
> +
> +
>  /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D */
>
>  static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.h
> index 4ce04486cc31..c8242992c912 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> @@ -30,6 +30,7 @@
>  #define DISCOVERY_TMR_OFFSET    (64 << 10)
>
>  struct ip_discovery_top;
> +struct drm_printer;
>
>  struct amdgpu_discovery_info {
>         struct debugfs_blob_wrapper debugfs_blob;
> @@ -47,4 +48,6 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_device =
*adev,
>                                   struct amdgpu_gmc_memrange **ranges,
>                                   int *range_cnt, bool refresh);
>
> +void amdgpu_discovery_dump(struct amdgpu_device *adev, struct drm_printe=
r *p);
> +
>  #endif /* __AMDGPU_DISCOVERY__ */
> --
> 2.43.0
>
