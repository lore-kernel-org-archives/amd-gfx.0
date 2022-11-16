Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF076C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Nov 2022 21:06:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF0F110E049;
	Wed, 16 Nov 2022 21:06:30 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E716510E049
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 21:06:25 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-13ba86b5ac0so21626594fac.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 13:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RnRzsByXeGC9zGs+CoNcawDRdqPaXTwmuP90g2Pl2fw=;
 b=FY3xTSepHl57catPS1Vrsn48updWRM+UUMwbNrllQGESNuiPNGrcEenLoJiTFg9wHB
 CDzww2Cgwnaz87Hku2BrK7phGFitzkomRyWmd1vC1ZjPEyZD8pg8Tu686fufgW3D5OaH
 3pOxVBFSHGaV05HAnZ4DYwxPdCjjrwD7EYt+A8PzF4tGV6cQUHoLmL2UiG+i4SBfC8J7
 9FklrTk9monQDgXMaZmRQH21BBOPMIm1JgFA04XZnLxppYu2WrfjRwKpp3KumdlozWfs
 wHFD01zzq9dyehIEczkhq8z/XOVayWCy6P4o3hFnAnXUNLoPiSQsPFKiE6l5hXvxSY5u
 6V2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RnRzsByXeGC9zGs+CoNcawDRdqPaXTwmuP90g2Pl2fw=;
 b=sqWNjGSE5ewr4v5XeNJNpIXIwA3ouDmsGCiG9pLiNPF3K5aRvnTZOya73uHipQKxKe
 ZapqnoBiLQQEV/xc1AWVI5/mk0XKWugPSJJSMQH1IrrtFYcBl4/ObsCCAYTLgE2sC6e6
 SjdrKZeYB1pLXFx/dccfFas0ZZTR1dOkAln9nGhA6s1uSTXkvZ2AmTalVsZ5PMUhH0MX
 xmhNCLLIrJBOS6j7+caBkX+qoIr7FDuUZFUMCpYheTPQjWT0srgRecmWDdCB6wwNYE86
 Xd0RF2AIuaqQoCkmBGEcxyVbQSJfr22bKCrtMv1945govwKyEiItgok424NUWYPhPqJs
 dFBw==
X-Gm-Message-State: ANoB5pnz/RChM1Ye6EqrqQF39NzPEtAVprs2jQ0TyFrnis5if2PXB9bT
 SWQviqA3PJKQ/jv5NkZO4Iuk+YEGKvW1SabzPGk=
X-Google-Smtp-Source: AA0mqf52irXYhyt++cQS9Lz9p51DfFkQHfUWnOhiM9AJeD5oJuC232HI74tT7jC2gmV6abDaNVvADI/MiNwwVu6gsUQ=
X-Received: by 2002:a05:6870:2b05:b0:12d:58c1:33f9 with SMTP id
 ld5-20020a0568702b0500b0012d58c133f9mr2903610oab.46.1668632785154; Wed, 16
 Nov 2022 13:06:25 -0800 (PST)
MIME-Version: 1.0
References: <20221116165407.2285608-1-Ramesh.Errabolu@amd.com>
In-Reply-To: <20221116165407.2285608-1-Ramesh.Errabolu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Nov 2022 16:06:14 -0500
Message-ID: <CADnq5_MQD4dT57NGTtAxUayG=E0MYxs9XYSgG=4R3Mx6MX35zA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Enable Aldebaran devices to report CU
 Occupancy
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 16, 2022 at 11:54 AM Ramesh Errabolu
<Ramesh.Errabolu@amd.com> wrote:
>
> Allow user to know number of compute units (CU) that are in use at any
> given moment. Enable access to the method kgd_gfx_v9_get_cu_occupancy
> that computes CU occupancy.
>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> index c8935d718207..4485bb29bec9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> @@ -41,5 +41,6 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
>         .get_atc_vmid_pasid_mapping_info =
>                                 kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
>         .set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
> +       .get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
>         .program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings
>  };
> --
> 2.35.1
>
