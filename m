Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0553C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 13:29:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D917113D80;
	Thu, 25 Apr 2024 13:29:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AbWtm28p";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0AEA113D80
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 13:29:07 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-53fa455cd94so738099a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 06:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714051747; x=1714656547; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HGY9H3r0JnjVHOyFm4fQocU8JByimM8p65PlYBqnlGU=;
 b=AbWtm28poO2D5mVSogElXfQ/KPjaS9Bj71x4Q/DB7uW6g1hY4/kzoqAWOw5ozV7Mua
 yPUPMKhKom7m5vDUTh3lWn8+3qsqf+ZIL3fSiQDYE+6Z0sBGPezEIiV213FWjqNya3EE
 3CF1qWQfCwmiEMTuPN8O0NvwTCICMRgIlMOPt/gytAiETAKMWidaKGZJwySFwTG0YOME
 Pub75/Nr3E4ea5cEZfuBEBqV+08LeTAFtQ4LM7au3Z7sOCdru7fzLMkaghkRpG+UCn4L
 Wfzck6sTVRVILsz85BAu5vQ8rskDLtC1Oc1j9EQEhyjq9NVnSVdawy6c1ctnea7S5k0B
 YdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714051747; x=1714656547;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HGY9H3r0JnjVHOyFm4fQocU8JByimM8p65PlYBqnlGU=;
 b=OEfOBIRdK/8HPADJR/ICuWvV71E0rw8CtTfjpshFy4QwXBtPsWaVmpxNjeLhQSzkmB
 yzIYUxtbw8FXX+5UJ7RMOdrVmZE0f5rnmVdIILBzXwRg7Vt/I9Bxi67wacqd6se7fFRB
 OFuhiTse+g718/eWlQa0tmt1hTs341qtjVfyzGR8oCJoaFcydxAUHO+uzDqizbwRxSTf
 hAr1erBsIJZYkm1DUv3z1gGxLKtg9ysZETZpJBL29lFq7FN/58JlHLWHopHX9bhs5RfV
 Q3UNUYZSEnflQEMKTXAshRsrXjVYV6bVsugd1Jq5jM0WzhuIP8Y5dbaavfQ9Xla0T8OZ
 gD9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTQDVDWsaqsLgnDvKC0Uda30YCBr0ob3hyZnpoblLO2G9VTbZW2+rCy5Kl166twdPLxtNv14OfLqS3PjXDaZvhOz42+tTUqvU9qRseTA==
X-Gm-Message-State: AOJu0YzW32GlU5vljS4OYKTKe+OsuiCffe2zPnYciflsz8Qqj2kLW+ot
 kATO78xi+VfASyK/rUyik2ziY8MEzTd0rn4YKlcnqKXD0EafIpdYZFIU8vIEfpuytEKSQTXCBBB
 sPa5C1+3oQhp0Ux0IBhY8FqTlLaQ=
X-Google-Smtp-Source: AGHT+IEYgXJyW4bWRk5g5pFc7vqc93+y8/vEyZ5jfnUf30qlE4T7GAFpu5KSc5a7S5uRimxydFMN9tQovjkgVQSRnBs=
X-Received: by 2002:a17:90b:88f:b0:2a5:bf0d:2dc7 with SMTP id
 bj15-20020a17090b088f00b002a5bf0d2dc7mr6267071pjb.23.1714051747045; Thu, 25
 Apr 2024 06:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240425102318.14883-1-sunil.khatri@amd.com>
In-Reply-To: <20240425102318.14883-1-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Apr 2024 09:28:55 -0400
Message-ID: <CADnq5_PNme+G2vCCnxmMy4A77SfGOqZytfSzxh+Lm2dee_BK_w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: skip ip dump if devcoredump flag is set
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Ahmad Rehman <Ahmad.Rehman@amd.com>, Lijo Lazar p <lijo.lazar@amd.com>,
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

On Thu, Apr 25, 2024 at 6:23=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> Do not dump the ip registers during driver reload
> in passthrough environment.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 869256394136..b50758482530 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5372,10 +5372,12 @@ int amdgpu_do_asic_reset(struct list_head *device=
_list_handle,
>                 amdgpu_reset_reg_dumps(tmp_adev);
>
>         /* Trigger ip dump before we reset the asic */
> -       for (i =3D 0; i < tmp_adev->num_ip_blocks; i++)
> -               if (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
> -                       tmp_adev->ip_blocks[i].version->funcs->dump_ip_st=
ate(
> -                               (void *)tmp_adev);
> +       if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
> +               for (i =3D 0; i < tmp_adev->num_ip_blocks; i++)
> +                       if (tmp_adev->ip_blocks[i].version->funcs->dump_i=
p_state)
> +                               tmp_adev->ip_blocks[i].version->funcs
> +                               ->dump_ip_state((void *)tmp_adev);
> +       }
>
>         reset_context->reset_device_list =3D device_list_handle;
>         r =3D amdgpu_reset_perform_reset(tmp_adev, reset_context);
> --
> 2.34.1
>
