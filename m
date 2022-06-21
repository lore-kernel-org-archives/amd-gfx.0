Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FD9CCA473
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jun 2022 14:33:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF16F10E17D;
	Tue, 21 Jun 2022 14:33:58 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFD9D10E17D
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jun 2022 14:33:56 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id h23so27900005ejj.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jun 2022 07:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=E68f8rn5pJTpRe7eV4AGODe222l613ZKTDGqq7+53Do=;
 b=GcYxSQQ55VRYJQHomSC3qew/Q/oMjS8nTVD3K5beXzPlxwnlNGCUMVlwmb36ja8mVN
 DEaTnPsY2LWP3iZi1JTBue44I2ctH/bKpFO0FvhavDOHVll1olak43ULICwF76MxEUSE
 i1Y3+LWetsnszU1zlOVUBNW9Jai1e6weL68yoCVYLHr8nbNjr1yKF4c3Ad8S2T7lcszY
 hOy/bRZlJRugRBTUWc+0/xEpeu5ZtbYELVqf/QZH77qLiN2ukk87y/h8LH9H2K30HQ1C
 PEMwKv8zW8CwWnGLinxmsvHvqJBDCh3c6BPcJT+yxrJNK5q5hb+g7PHPFxka3ULiRjWl
 SrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E68f8rn5pJTpRe7eV4AGODe222l613ZKTDGqq7+53Do=;
 b=VDSTq1AhvaZvqsGOWwL2P3vgpuv6cK2nV5EZ2mmc2gZRCbpj0Ffv2GnQLrj8DB0PZm
 Iy3JQZw/DXDFwI5wftO691nbtsRU/6zuMqv0EqvU3URd2CKlmVU+DdtLMcUvTDIqp7+7
 N0G5eB6UC6USeHNiVryGWGMfuenY3lpz+Lo/2OKZQJdNKAHkh6crNRoUtAzqkZ8HvbDv
 eEclcAVWRc3s7RPvyvT+tDJjzCdJskBEFYVtMHYpG0linbgcJaH/znbJE+/gJ42yvMka
 JtOeeEw5JiNa8OKDL5iyNpBVAKKVsXepJjojoD+BAhGbkNVUuAIwnFMM/CkpRsqssgXC
 FHvw==
X-Gm-Message-State: AJIora+g4EUoTkaZYTNzNuLAj8sB88UnajWObvT9GRhgfd7Xd/oaZBh0
 2NYdf+RAsSYBrgZV8B1p8Ce1I5FjyZMr/ha4ir4=
X-Google-Smtp-Source: AGRyM1uyc+8QD3gq9tM9+INzG9IHkH9tTGnKgaFgwPk+dSpfcqN5aamxdZc5xdAAJanW1N0AJkKpuY2UX2/ataQ0BHY=
X-Received: by 2002:a17:906:c041:b0:718:c984:d9ee with SMTP id
 bm1-20020a170906c04100b00718c984d9eemr27641852ejb.722.1655822035390; Tue, 21
 Jun 2022 07:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220621022550.492588-1-ruili.ji@amd.com>
In-Reply-To: <20220621022550.492588-1-ruili.ji@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 21 Jun 2022 10:33:42 -0400
Message-ID: <CADnq5_MqPmkR5z2xPTU7bTBfvLKm_XbZWHQQ6PPYx2wi4ZB3QA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: To flush tlb for MMHUB of GFX9 series
To: "Ji, Ruili" <ruili.ji@amd.com>
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
Cc: Alex Sierra <alex.sierra@amd.com>, "Kuehling,
 Felix" <felix.kuehling@amd.com>, Ruili Ji <ruiliji2@amd.com>,
 Aaron Liu <aaron.liu@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Mon, Jun 20, 2022 at 10:26 PM Ji, Ruili <ruili.ji@amd.com> wrote:
>
> From: Ruili Ji <ruiliji2@amd.com>
>
> amdgpu: [mmhub0] no-retry page fault (src_id:0 ring:40 vmid:8 pasid:32769, for process test_basic pid 3305 thread test_basic pid 3305)
> amdgpu: in page starting at address 0x00007ff990003000 from IH client 0x12 (VMC)
> amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00840051
> amdgpu: Faulty UTCL2 client ID: MP1 (0x0)
> amdgpu: MORE_FAULTS: 0x1
> amdgpu: WALKER_ERROR: 0x0
> amdgpu: PERMISSION_FAULTS: 0x5
> amdgpu: MAPPING_ERROR: 0x0
> amdgpu: RW: 0x1
>
> When memory is allocated by kfd, no one triggers the tlb flush for MMHUB0.
> There is page fault from MMHUB0.
>
> Signed-off-by: Ruili Ji <ruiliji2@amd.com>
> Change-Id: I97786f02849dd047703d6e8feff53916b307715c
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 1d0c9762ebfb..12fc822c0a92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -739,7 +739,8 @@ int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>  {
>         bool all_hub = false;
>
> -       if (adev->family == AMDGPU_FAMILY_AI)
> +       if (adev->family == AMDGPU_FAMILY_AI
> +               || adev->family == AMDGPU_FAMILY_RV)
>                 all_hub = true;
>
>         return amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, flush_type, all_hub);
> --
> 2.25.1
>
