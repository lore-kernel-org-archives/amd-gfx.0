Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9ADAC982DA
	for <amd-gfx@archiver.kernel.org>; Sun, 20 Sep 2026 14:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19FF010E05E;
	Sun, 20 Sep 2026 14:10:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I+dMzfJm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAA4110E05E
 for <amd-gfx@lists.freedesktop.org>; Sun, 20 Sep 2026 14:10:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D55F4601F7;
 Sun, 20 Sep 2026 14:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FF81F000FF;
 Sun, 20 Sep 2026 14:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789913430;
 bh=2B9LnN586cCJ8oJndzvw11pG3pLIFjDqBsRKszoJFYs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=I+dMzfJmh0BOEQJ6z6rgmntlGJBuemO7FEG2DVCfVPli4TgEI+RRmhmFfZ0RIDle7
 S56sc30mip2Ekse0gRv7PZbWklbXgFX/f0+pKMs5DKCAN+z8CWDReOZWKUUfuy81Xw
 ANqPuqG+fVp6u3k15RiYGfogG2+8w5IiLdLFJL9B5UMFA3YV0kXIbTMQX9I1eirXTe
 INW4WDRvevy0RhEr4zZ3SYE8xTEJcqvo1cLIb59wtgjUiUwb6t2PaE3vMyc1ziH5xZ
 An+utZ6wyyhsdAn+WQlrWvxNGU/A8hpNy+dnJh2R/HQS6GsUsUpOgHZwHzsfXge9Aq
 eeC4QvXYv/bwQ==
Message-ID: <9bdf290e-0e3f-46dd-893b-bbe1fe5d8406@kernel.org>
Date: Sun, 20 Sep 2026 09:10:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] IOMMU Performance Optimization support
To: Alex Deucher <alexander.deucher@amd.com>, Joerg Roedel <joro@8bytes.org>, 
 Vasant Hegde <vasant.hegde@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>,
 Jatin Kataria <jkataria@netflix.com>, Boqun Feng <boqunf@netflix.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260908041207.38113-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/7/26 11:12 PM, Mario Limonciello wrote:
> Add support for the AMD IOMMU Performance Optimization (PerfOpt)
> feature as defined in the AMD I/O Virtualization Technology (IOMMU)
> Specification, Section 3.4.9 (MMIO Offset 016Ch).
> 
> This feature allows privileged integrated I/O devices (GPUs) to bypass
> the IOMMU when directly accessing system memory.  The IOMMU only
> enforces the IR/IW permission bits without GPA->SPA translations.
> 
> Drivers will opt into this behavior, and enable amdgpu to turn this
> feature on when an integrated GPU is already in identity mode.
> If a user prefers to keep it always off (even with identity mode)
> there is also a module parameter to force it off.
> 
> v2:
>   * Rebase on 7.3-rc2
>   * Adjust amdgpu parameter behavior
> 
> Mario Limonciello (2):
>    iommu/amd: Add PerfOpt IOMMU performance optimization support
>    drm/amdgpu: Enable PerfOpt IOMMU perf optimization when GPU in
>      identity domain
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  50 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  12 ++
>   drivers/iommu/amd/amd_iommu.h              |   3 +
>   drivers/iommu/amd/amd_iommu_types.h        |   7 +
>   drivers/iommu/amd/init.c                   |  43 +++++
>   drivers/iommu/amd/iommu.c                  | 214 +++++++++++++++++++++
>   include/linux/amd-iommu.h                  |  11 ++
>   8 files changed, 341 insertions(+)
> 

Alex, Vasant, Joerg,

Gentle ping on this series.

Thanks,
