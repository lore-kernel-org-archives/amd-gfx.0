Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82331CA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 15:22:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F38E10EA27;
	Thu, 28 Aug 2025 15:22:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TDmgIpc/";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84B6610EA27
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 15:22:18 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b4c27bdc259so186441a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 08:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756394538; x=1756999338; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PoFav8oQnP9+BhVAjGCtjQdYUOO5V1kFPM9tdRrHtmc=;
 b=TDmgIpc/olUhV8w710zheNUFnh3J1XRtJ7Lz36jAbl+y8yrk8KFnfyp8NcmIOaeYdU
 CY/BTUr0wb+ex4SAPG8WrdlFraCPhNuM2sE4n4jisaWLfm14RfDFVV0zKbCf7reLCubR
 1cxZV7kM87NB7+3EIcL+w61b5j+uEJuBO9e88y7o70m7Fg3UMdoXkMEletuVDaPQ6NAv
 rM5M3RkrTAYJvh5q/m9nacVUgYc09oyZVg1Yna87FecgSdfv955M3QYfM8cHibhy4WPm
 UiUrG5Kiwq1UmvsUzufnCnbUS+2UAFKFGrJj8HDGnIRIjy6VgCIyP0BOnBMyRs7KfSWH
 Sy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756394538; x=1756999338;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PoFav8oQnP9+BhVAjGCtjQdYUOO5V1kFPM9tdRrHtmc=;
 b=ZfPp2axTNTJcF87NrE6jBtfTLR2sibH1+7GlfnuOcLCwOntmj8GEdrh4qsHQN3/q+z
 SVGvcWHKMCBWK9EgT/c8W6pi8v2jz8EpctwC/xfJel3mDuk6ocatR6X8DNOt/QsOsvo7
 +HiDHb3+wV5JovkJm93qzWEgUuIZFN1aRzNa5kvDsf0G4NLiVRY9qWm1Ux8hRm+5OgZ5
 LegMAc+PSpRgsCzWX1+T1yVAk2Ud47YxwbowKZ+LQ8VFtpCO4pYQxEq/h+PwLdtMEb/g
 +jQLyGIkx6WXn/8arjcT0rJVR6KTbHQBTEOeZy94i0scbxNiqmPX47EqAXlGV6XmjrYv
 VCvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+qspHKsqqTwqqq8maVMBDs9mGzoqbnX/FdtlP/lYUA4vq2mWbo6ozc2/mDT82Z2GnqY4w4mm6@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2ejk06mkn6Juvo6ygj6+gDdeqqWUEGr5OrssiE3wrCnnkeLfZ
 +GuPVZ3PnBACVlfjPdSNgl6KVBQh/zUfBOPL0b8I1+qlE7G6Lr9Ne8BZ9mDXMPK7T/PhCsDl05c
 mrD+7salz667CSnvTnET47Oj7dJ+TQ0Q=
X-Gm-Gg: ASbGncsdNEZe6NSn9Dv8fjtaLozmqs10MkhRAR+jZAtoWfl8Dck8dZ5i/LzZ2luI4SL
 GJAANriR3FjnJ1zE9DAUs/zbtDzRYPUn1Hb/8RiacVYuUXClrFxc4zwxAT+4xNm1pv/44afOnJ5
 w3p2zataAnvSrg6aMyuEZRG6x2N9d2K4plAU9a6+tBH7q6zNnreH4jYmxgbMY9sci3SeS+5dXKM
 OHhZ/3JNP/tOoTWpg==
X-Google-Smtp-Source: AGHT+IEMU8jnin+qippbNg2kKkugIka8yS/qmNl6Z4ConiIvoFKLet5t/fJkiP6hOEUxoTyoial/YPBDovRHZF/LbSg=
X-Received: by 2002:a17:902:d506:b0:246:b1cf:fec2 with SMTP id
 d9443c01a7336-246b1d002d1mr122259245ad.4.1756394537950; Thu, 28 Aug 2025
 08:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250828071335.3948819-1-srinivasan.shanmugam@amd.com>
 <20250828071335.3948819-6-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250828071335.3948819-6-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 Aug 2025 11:22:06 -0400
X-Gm-Features: Ac12FXzdkUaxaypCYvzQhf32qWcQkw12dR2rNDKn9rVOkxUAvuFaykpeX_C0ZEY
Message-ID: <CADnq5_MvLXap=apwtHq_dcqAfxfumP-+d4E8_7avRPxfZe00QQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] drm/amdgpu: Add mmio_remap bookkeeping to
 amdgpu_device
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Thu, Aug 28, 2025 at 5:21=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Add bookkeeping for the remap page to struct amdgpu_device:
>
> * bo:   kernel-owned singleton BO
>
> v2:
> - Use existing amdgpu_mmio_remap container; remove per-field members
>   (Alex).
> - Use AMD_GPU_PAGE_SIZE (always 4K) per Christian/Alex.
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index ddd472e56f69..24501d3fbefe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -752,6 +752,7 @@ typedef void (*amdgpu_block_wreg_t)(struct amdgpu_dev=
ice*, uint32_t, uint32_t, u
>  struct amdgpu_mmio_remap {
>         u32 reg_offset;
>         resource_size_t bus_addr;
> +       struct amdgpu_bo *bo;
>  };
>
>  /* Define the HW IP blocks will be used in driver , add more if necessar=
y */
> --
> 2.34.1
>
