Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A389C98314
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 12:46:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C322B10F509;
	Thu, 24 Sep 2026 12:46:14 +0000 (UTC)
X-Greylist: delayed 506 seconds by postgrey-1.36 at gabe;
 Thu, 24 Sep 2026 11:51:12 UTC
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9CE8910E91D
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 11:51:12 +0000 (UTC)
Received: from 8bytes.org
 (p200300f6af404a00e4ccc4fdbbd66590.dip0.t-ipconnect.de
 [IPv6:2003:f6:af40:4a00:e4cc:c4fd:bbd6:6590])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id 5DF211C7465;
 Thu, 24 Sep 2026 13:42:45 +0200 (CEST)
Date: Thu, 24 Sep 2026 13:42:44 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
 amd-gfx@lists.freedesktop.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>, 
 Jatin Kataria <jkataria@netflix.com>, Boqun Feng <boqunf@netflix.com>
Subject: Re: [PATCH v2 0/2] IOMMU Performance Optimization support
Message-ID: <arUMU5QGhb34exFV@8bytes.org>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908041207.38113-1-mario.limonciello@amd.com>
X-Mailman-Approved-At: Thu, 24 Sep 2026 12:46:10 +0000
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

Hi Alex,

On Mon, Sep 07, 2026 at 11:12:05PM -0500, Mario Limonciello wrote:
> Mario Limonciello (2):
>   iommu/amd: Add PerfOpt IOMMU performance optimization support
>   drm/amdgpu: Enable PerfOpt IOMMU perf optimization when GPU in
>     identity domain
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  50 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  12 ++
>  drivers/iommu/amd/amd_iommu.h              |   3 +
>  drivers/iommu/amd/amd_iommu_types.h        |   7 +
>  drivers/iommu/amd/init.c                   |  43 +++++
>  drivers/iommu/amd/iommu.c                  | 214 +++++++++++++++++++++
>  include/linux/amd-iommu.h                  |  11 ++
>  8 files changed, 341 insertions(+)

What is your preference on what tree this should go through? The IOMMU changes
are bigger, so my preference is the iommu tree, but for that I need your Ack on
the GPU part. Or let me know whether you prefer this to go through your tree.

-Joerg
