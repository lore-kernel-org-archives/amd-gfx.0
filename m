Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA0DC021A9
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2025 14:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAE8610E324;
	Mon, 17 Feb 2025 14:15:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VsSNk7ie";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8F5110E324
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2025 14:15:07 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2fbfe16cbf5so1006784a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2025 06:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739801707; x=1740406507; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5DPwJ/pVFHn5TK1eEUf+pv7BC7q0bpcJnVZ+cerDLME=;
 b=VsSNk7ieZnNtkMuUzNhtgv42kWCr7FJSs3rAHXN30joiHVkOD21/jWF3iWtDRHVT70
 mj2T+Ho3itCGr/zaOpAlQNa/RkhGm0eNV9Pda945+WK3XmU2NdFxUV5ghfskzJngIV3q
 AUTy4bg8qcicej7SRxx1gs2E5NULF1y9nezxLcntCdgTwwVuM1TkRGto0qJQJj7HM7+J
 0QG5k32EkzlkFnnyy/ktehEndTf1NkESpdo+2iF398/lZFsdjC2FVsWPrIjm6AIDa0ro
 YCQHObllOOw7++QWN3/YtrKPPt1BoCL9z7Dcwjtv6KuYhoXDugnOJ1ZbCNj3+IxOMmAe
 kQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739801707; x=1740406507;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5DPwJ/pVFHn5TK1eEUf+pv7BC7q0bpcJnVZ+cerDLME=;
 b=QAL62zkUaIg8qKfmb2eZNPT79Z84Lk0Y5+xrLF82UMs+iB1pZQgDfD+MldpezS8WHB
 zB+4lBYP+nVFMcwjKmslRaF1u1Ogx7Y+kDRub0SZL3jId15Ki229hwiVrk2i/Ug39UR6
 qydRGiIfgm7nYsVz+pF8kPMJVjLoKtlO+BmXZb1Yb2jRvs55SXbcVGQBIpNcuoQVQ9Va
 rnReFlDzurHO1DjIeR7TcyIz8fryvgW7VnT+M7ktMR9SaiuvCoYX+e9zQX6EwNYTwzkI
 ibeUmurQoG8VDkj3Zsa2FR+2nRlYXSxWXutXrQjFpiYZZQ4pVsHUdIbkIRxrldinfGEd
 xIgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUYF00Xy5f7TXAMTpz7OX0yt2Cf3eCRf0MxlEANGaqN9veiV1V3wkQSRn+ZejqIlWdljfq6fqQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzxOp5rQ3rc9v3Y/9mreIQdbp/rffwjbuQzUW57dH4D7zOWJO9m
 yVjuyYYSuUHXeYEKoOHokFk2oPyf/Nj1Av4I0sydSrZ7LtDC3NVofm1Y4wB/iXBFLejI5N22D1r
 MFVqwbIODd3d79r2jYNw7YFWdbsGBcA==
X-Gm-Gg: ASbGncsMRFQ7UhGXWKcMUZKDQlG1Mw7zQKXoqH7+b+xiUs9S+YivqGj3KyjAtn5V3xF
 vWJESdBOfGMtKViXT4izcSu2YsyvM/uNdahyC5tDgVGtCnG3MdH7r+W0YHdhln4N3nSjuYIUC
X-Google-Smtp-Source: AGHT+IGANxbcznZYfepAqXzvoo089UA6oNnuCEmCAw1BlstjS6u+Pt5IZcryrndXBDbm5A5aPXwsjaftx4M45eRQ/L8=
X-Received: by 2002:a17:90b:384a:b0:2ee:cbc9:d50b with SMTP id
 98e67ed59e1d1-2fc4103d1ebmr5815281a91.4.1739801705712; Mon, 17 Feb 2025
 06:15:05 -0800 (PST)
MIME-Version: 1.0
References: <20250214173522.2373211-1-alexander.deucher@amd.com>
 <363007c1-064a-4017-abaf-a2b69bbc4679@amd.com>
In-Reply-To: <363007c1-064a-4017-abaf-a2b69bbc4679@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Feb 2025 09:14:53 -0500
X-Gm-Features: AWEUYZkTMLDLQnnyfvR-FtXLyxOYZgM2DfXVK-4EyVJ5RGH4bKmIhUzF32TEdB4
Message-ID: <CADnq5_OmnYXoc94h0LjG52wqwkOCAaB6eefYoqiJZY3k-hVm2Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/mes: keep enforce isolation up to date
To: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Shaoyun Liu <shaoyun.liu@amd.com>
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

On Sat, Feb 15, 2025 at 3:02=E2=80=AFAM SRINIVASAN SHANMUGAM
<srinivasan.shanmugam@amd.com> wrote:
>
>
> On 2/14/2025 11:05 PM, Alex Deucher wrote:
>
> Re-send the mes message on resume to make sure the
> mes state is up to date.
>
> Fixes: 8521e3c5f058 ("drm/amd/amdgpu: limit single process inside MES")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Shaoyun Liu <shaoyun.liu@amd.com>
> Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 13 ++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 20 +++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 +-
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  |  4 ++++
>  5 files changed, 32 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index b9bd6654f3172..a194bf3347cbc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1665,24 +1665,19 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(s=
truct device *dev,
>   }
>
>   mutex_lock(&adev->enforce_isolation_mutex);
> -
>   for (i =3D 0; i < num_partitions; i++) {
> - if (adev->enforce_isolation[i] && !partition_values[i]) {
> + if (adev->enforce_isolation[i] && !partition_values[i])
>   /* Going from enabled to disabled */
>   amdgpu_vmid_free_reserved(adev, AMDGPU_GFXHUB(i));
> - if (adev->enable_mes && adev->gfx.enable_cleaner_shader)
> - amdgpu_mes_set_enforce_isolation(adev, i, false);
> - } else if (!adev->enforce_isolation[i] && partition_values[i]) {
> + else if (!adev->enforce_isolation[i] && partition_values[i])
>   /* Going from disabled to enabled */
>   amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(i));
> - if (adev->enable_mes && adev->gfx.enable_cleaner_shader)
> - amdgpu_mes_set_enforce_isolation(adev, i, true);
> - }
>   adev->enforce_isolation[i] =3D partition_values[i];
>   }
> -
>   mutex_unlock(&adev->enforce_isolation_mutex);
>
> + amdgpu_mes_update_enforce_isolation(adev);
> +
>   return count;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index cee38bb6cfaf2..ca076306adba4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1508,7 +1508,8 @@ bool amdgpu_mes_suspend_resume_all_supported(struct=
 amdgpu_device *adev)
>  }
>
>  /* Fix me -- node_id is used to identify the correct MES instances in th=
e future */
> -int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev, uint32_=
t node_id, bool enable)
> +static int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev,
> +    uint32_t node_id, bool enable)
>  {
>   struct mes_misc_op_input op_input =3D {0};
>   int r;
> @@ -1530,6 +1531,23 @@ int amdgpu_mes_set_enforce_isolation(struct amdgpu=
_device *adev, uint32_t node_i
>   return r;
>  }
>
> +int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev)
> +{
> + int i, r =3D 0;
> +
> + if (adev->enable_mes && adev->gfx.enable_cleaner_shader) {
> + mutex_lock(&adev->enforce_isolation_mutex);
> + for (i =3D 0; i < (adev->xcp_mgr ? adev->xcp_mgr->num_xcps : 1); i++) {
> + if (adev->enforce_isolation[i])
> + r |=3D amdgpu_mes_set_enforce_isolation(adev, i, true);
> + else
> + r |=3D amdgpu_mes_set_enforce_isolation(adev, i, false);
> + }
> + mutex_unlock(&adev->enforce_isolation_mutex);
> + }
> + return r;
> +}
> +
>  #if defined(CONFIG_DEBUG_FS)
>
>  static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *u=
nused)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.h
> index 6a792ffc81e33..3a65c3788956d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -532,6 +532,6 @@ static inline void amdgpu_mes_unlock(struct amdgpu_me=
s *mes)
>
>  bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev)=
;
>
> -int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev, uint32_=
t node_id, bool enable);
> +int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev);
>
>  #endif /* __AMDGPU_MES_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index 530371e6a7aee..fc7b17463cb4d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1660,6 +1660,10 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>   goto failure;
>   }
>
> + r =3D amdgpu_mes_update_enforce_isolation(adev);
> + if (r)
> + goto failure;
> +
>
> Hi Alex,
>
> Should this also be moved to mes_v11_0_hw_init. Please let me know your t=
houghts?

I'm not sure I follow.  This is in hw_init.

Alex

>
>  out:
>   /*
>   * Disable KIQ ring usage from the driver once MES is enabled.
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index 6db88584dd529..ec91c78468f30 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -1773,6 +1773,10 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>   goto failure;
>   }
>
> + r =3D amdgpu_mes_update_enforce_isolation(adev);
> + if (r)
> + goto failure;
> +
>
> And Similarly here also?
>
> Thanks!
>
> Srini
>
>  out:
>   /*
>   * Disable KIQ ring usage from the driver once MES is enabled.
