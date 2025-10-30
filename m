Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98039CCF9FF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 15:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD61010E9DB;
	Thu, 30 Oct 2025 15:14:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QTmZhOAS";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1628510E9D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 15:14:55 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-28d18e933a9so1319635ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 08:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761837294; x=1762442094; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DN/pbYB4B8AoSluG61yIBRMYAHI5CIdilOxZ1ThEy/I=;
 b=QTmZhOASeKHHrQCia5gqAqzuRODZJt9rFRcMY2TvqrmDCj92r6mgPDbW9v+m7BxD2q
 /bdbu6BviaIzq4KDTLXZMXvwsTWYgx5b1p7ASIB7u75XDDNrDSOgJfga0VYlXePoA3qV
 mUCzSe6yWp+UOxb19xHLLWltWauzTg8yVWU5d2AYpTs0jVCJ14me75WglPyrXZHGc/n6
 xFrGN89HJOvv10OEr2u8gemlYkmbSQqr0lNkEieJILbGSHKIgQdj9VrZZswD/h8J+rGO
 71pg7CRhFUhmZmhfB1ZPMCTVOcKeVNTA9RtXmDNYZ/WPSsf4xCvINh654KzkNc/7eCd0
 r5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761837294; x=1762442094;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DN/pbYB4B8AoSluG61yIBRMYAHI5CIdilOxZ1ThEy/I=;
 b=v5+6ZTAVpEz7qL33ykpy5544pFlKVKaTE442y63iGrkKovB6ypO4Eqbsdchhu/GikY
 GVm/quv582wca0zTzTaYoTN35O5z8UXgQAFk2ZqdKWG0rI0EWcfQjL/jEABsnLKq0E5T
 ObZN6E8j3v62ZsN5A5P598FSOfBZArTPyokrAIXFU1lz5eTdyrdQJZ6pwEmUNskVjNST
 L5lSkOPZ0PTficaqm4Zy2t1dO/BMuv8SBd9FyPomq8SSbI2hzZcKhmSRP4Y0PTfS6Kg5
 uPGX13lr4zJs0eRS/kQTd3YtI/24rIRxrD7nk4Rs0DxZBGuMQRxn9YjUfIiJGaJu14a4
 W5QQ==
X-Gm-Message-State: AOJu0Yx0Y78hEkYyiXd9MdS4cGfnC0ld1suvT3TKpjflXnh/76f6i785
 OmFoiGyuQycpyblR8inzIP2Fs4gerKJO2AUQ39Zq2lZp3AsD4fhmVgBK9JYxukKZuhZwY9+QrtA
 STSQcmrWF8fKAxRtzAg0PXmhomWw9hGo=
X-Gm-Gg: ASbGncuDAkK/IQFJ6swzW9cYWAksGPbNfYGdXmBI6HUxNofnT5cvBc5wK4lTff3VoaI
 5GqDWmBx9mMQzfbitxwUEh+VhQjiwzs8XnLAUqxuCqTxqtBeI0ORuN7sJ04CkGG1hfjqCsuUex2
 shRIeXrUGdor1+XlMl2cNjFKS1xKAlcqUigv+BzFtnHu6Nfwsniu7+HyYSdy7xAJqqghjOvLbnF
 nwrGTxvhKnQ/iFZNjbwnHFWEx2JByUukN13mA6urxB8LZX9QVP1CRCgSRLsqzT2WFQ6IWs=
X-Google-Smtp-Source: AGHT+IF8mSohYVoeGOwq/qEJ20XIBBl5ICDd4u0TJVIh33VnAbgv3L+xljeLFgucC725WRFuYKrwu71UvXKl2XUyUKI=
X-Received: by 2002:a17:903:41ca:b0:27e:eb9b:b80f with SMTP id
 d9443c01a7336-2951a37f5b0mr674345ad.2.1761837294314; Thu, 30 Oct 2025
 08:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20251026042942.549389-1-superm1@kernel.org>
 <20251026042942.549389-3-superm1@kernel.org>
In-Reply-To: <20251026042942.549389-3-superm1@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Oct 2025 11:14:42 -0400
X-Gm-Features: AWmQ_bloOG-sqSurqOlzOWwuQQHOjeffmBnR--ElbwvhxUqE0o7eXL8l6KDdelk
Message-ID: <CADnq5_NuD-h26B8tjPAKmWPE=48u6iFgYibi3uR9XXZuY=B5EA@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] drm/amd: Add an unwind for failures in
 amdgpu_device_ip_suspend_phase1()
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org
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

Patches 2-4 are:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Sun, Oct 26, 2025 at 12:36=E2=80=AFAM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> If any hardware IPs involved with the first phase of suspend fail, unwind
> all steps to restore back to original state.
>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index f6850b86e96f..b9ea91b2c92f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -178,6 +178,7 @@ struct amdgpu_init_level amdgpu_init_minimal_xgmi =3D=
 {
>                 BIT(AMD_IP_BLOCK_TYPE_COMMON) | BIT(AMD_IP_BLOCK_TYPE_IH)=
 |
>                 BIT(AMD_IP_BLOCK_TYPE_PSP)
>  };
> +static int amdgpu_device_ip_resume_phase3(struct amdgpu_device *adev);
>
>  static void amdgpu_device_load_switch_state(struct amdgpu_device *adev);
>
> @@ -3784,7 +3785,7 @@ static void amdgpu_device_delay_enable_gfx_off(stru=
ct work_struct *work)
>   */
>  static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
>  {
> -       int i, r;
> +       int i, r, rec;
>
>         amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>         amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> @@ -3807,10 +3808,23 @@ static int amdgpu_device_ip_suspend_phase1(struct=
 amdgpu_device *adev)
>
>                 r =3D amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
>                 if (r)
> -                       return r;
> +                       goto unwind;
>         }
>
>         return 0;
> +unwind:
> +       rec =3D amdgpu_device_ip_resume_phase3(adev);
> +       if (rec)
> +               dev_err(adev->dev,
> +                       "amdgpu_device_ip_resume_phase3 failed during unw=
ind: %d\n",
> +                       rec);
> +
> +       amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW);
> +
> +       amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
> +       amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
> +
> +       return r;
>  }
>
>  /**
> --
> 2.51.1
>
