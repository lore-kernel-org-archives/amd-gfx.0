Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6EDC52D7C
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 16:01:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C8A410E132;
	Thu, 15 Aug 2024 16:01:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KKzDaDy4";
	dkim-atps=neutral
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6B3E10E132
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 16:01:47 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id
 46e09a7af769-7093705c708so1055120a34.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 09:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723737707; x=1724342507; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K0DqZEThPb5emBs3Rc4VSWLD6xB3+uGQCYDiofTb/q8=;
 b=KKzDaDy4Tpq5ZAK/mRAp6pAcP4zmpIAdu71sC6pZIH1RPQGXY5VgLTyS8l1hUgAu/I
 +0FLgnug5iCmn1ttP00yvGQ8W0lF9iao5bDBf270EMCCgirA8RkpGkSnFTY+iPrCAfOB
 2fwy5rEE1M+YQoaI3pZQ7852BWWTieVD9mehnEfj/0qll3HO+Dv/S6qoIxfLe79qRC/H
 pNBEwKkhFkm/LgjPLIRUPcsfNWFbKmhHmZEGZWVOs69ClitO06UXVbbi/F3JxHy2rga1
 zeanSPWbGtxzaD1SLHRI03nrNy9arDmiHtYUd0rGSJTg5FqB9ON2/GBth1cF61eM6eoe
 2oJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723737707; x=1724342507;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K0DqZEThPb5emBs3Rc4VSWLD6xB3+uGQCYDiofTb/q8=;
 b=BuX6P+B4JdIf++9Sd4EsQFzDR1NtqnEjEGKS/DN9ZoaeUJo92qdf1Q4oZKeUpqJ4eg
 BoILo6z2fEWAwuW873p9fhUAhxewi8LTJ/918X07dGV4ouT8kiLqVc6bXqd8OLEiwB0u
 Or8JA1vTpg0TI5q9Wby2+t56PcM//wG3qNV8j6nc2mpu9L1zSTxdBg2uEYGRbx7Ipsfq
 CpQmZ8FkTVMYl1nBtP1O1xlTgYHUaIcBTEh4lr97VRi8idM2mTHLW4awUjWxiTp9+Q97
 e6pA2Q0rG8do+DX2daJ0NWR4JvOvS9kpuLqX3KYOoksJH90ZgzuO7RJFRC5Z0yEbtOOw
 FdCw==
X-Gm-Message-State: AOJu0YxMFcy2WW9SpJXdkcbWCABHWKxTnquv8ntKse8O2xLluC+tpyDN
 cB1RoklysjQjRCprYvVV2do8oVGVWG9spPTfVVqcopgolttx0HCEl8qn79n9jbo+8J1FPoSCp1i
 0XkV2gU9ipFh+OlxG9FUe75fuzIc=
X-Google-Smtp-Source: AGHT+IGAby6PLtgxVir7YNvU1BmT1nYu+GNpiTzPtaFn0YHMtNPKGWW8AG1O9KhpiFp7fulHw45lyeXiTtgZu203xAc=
X-Received: by 2002:a05:6358:3226:b0:1a6:783c:a70f with SMTP id
 e5c5f4694b2df-1b39331487dmr22669055d.27.1723737706826; Thu, 15 Aug 2024
 09:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240815113836.399377-1-Trigger.Huang@amd.com>
 <20240815113836.399377-2-Trigger.Huang@amd.com>
In-Reply-To: <20240815113836.399377-2-Trigger.Huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Aug 2024 12:01:34 -0400
Message-ID: <CADnq5_NumwJ6ujpJERTF7gK7TAJMkG7MNMNgrtr3=k8pqYnBvg@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: Add gpu_coredump parameter
To: Trigger.Huang@amd.com
Cc: amd-gfx@lists.freedesktop.org, sunil.khatri@amd.com, 
 alexander.deucher@amd.com
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

On Thu, Aug 15, 2024 at 7:39=E2=80=AFAM <Trigger.Huang@amd.com> wrote:
>
> From: Trigger Huang <Trigger.Huang@amd.com>
>
> Add new separate parameter to control GPU coredump procedure. This can
> be used to decouple the coredump procedure from gpu recovery procedure
>
> Signed-off-by: Trigger Huang <Trigger.Huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 937de21a7142..4dd465ad14af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -201,6 +201,7 @@ extern uint amdgpu_force_long_training;
>  extern int amdgpu_lbpw;
>  extern int amdgpu_compute_multipipe;
>  extern int amdgpu_gpu_recovery;
> +extern int amdgpu_gpu_coredump;
>  extern int amdgpu_emu_mode;
>  extern uint amdgpu_smu_memory_pool_size;
>  extern int amdgpu_smu_pptable_id;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index b9529948f2b2..c5d357420236 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -178,6 +178,7 @@ uint amdgpu_force_long_training;
>  int amdgpu_lbpw =3D -1;
>  int amdgpu_compute_multipipe =3D -1;
>  int amdgpu_gpu_recovery =3D -1; /* auto */
> +int amdgpu_gpu_coredump;
>  int amdgpu_emu_mode;
>  uint amdgpu_smu_memory_pool_size;
>  int amdgpu_smu_pptable_id =3D -1;
> @@ -556,6 +557,13 @@ module_param_named(compute_multipipe, amdgpu_compute=
_multipipe, int, 0444);
>  MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (1 =3D en=
able, 0 =3D disable, -1 =3D auto)");
>  module_param_named(gpu_recovery, amdgpu_gpu_recovery, int, 0444);
>
> +/**
> + * DOC: gpu_coredump (int)
> + * Set to enable GPU coredump mechanism (1 =3D enable, 0 =3D disable). T=
he default is 0
> + */
> +MODULE_PARM_DESC(gpu_coredump, "Enable GPU coredump mechanism, (1 =3D en=
able, 0 =3D disable (default))");
> +module_param_named(gpu_coredump, amdgpu_gpu_coredump, int, 0444);

I don't think we need a separate parameter for this, although if we
do, this would need to be enabled by default.  If it needs to be
decoupled from reset, that's fine, but I don't see the need for a
separate knob.

Alex

> +
>  /**
>   * DOC: emu_mode (int)
>   * Set value 1 to enable emulation mode. This is only needed when runnin=
g on an emulator. The default is 0 (disabled).
> --
> 2.34.1
>
