Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE356C98326
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 07:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B664210F92C;
	Fri, 25 Sep 2026 07:39:29 +0000 (UTC)
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
 by gabe.freedesktop.org (Postfix) with ESMTP id A96F410E44C
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 07:30:19 +0000 (UTC)
Received: from 8bytes.org
 (p200300f6af404a000b03c3c046b119f0.dip0.t-ipconnect.de
 [IPv6:2003:f6:af40:4a00:b03:c3c0:46b1:19f0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id E2CC41C7759;
 Fri, 25 Sep 2026 09:30:18 +0200 (CEST)
Date: Fri, 25 Sep 2026 09:30:17 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>, 
 Jatin Kataria <jkataria@netflix.com>, Boqun Feng <boqunf@netflix.com>, 
 "Derek J . Clark" <derekjohn.clark@gmail.com>
Subject: Re: [PATCH v2 1/2] iommu/amd: Add PerfOpt IOMMU performance
 optimization support
Message-ID: <arYiqAIbThf5mLLr@8bytes.org>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
 <20260908041207.38113-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908041207.38113-2-mario.limonciello@amd.com>
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:39:28 +0000
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

On Mon, Sep 07, 2026 at 11:12:06PM -0500, Mario Limonciello wrote:
> +#ifdef CONFIG_AMD_IOMMU
> +int amd_iommu_enable_perfopt(struct pci_dev *pdev);
> +void amd_iommu_disable_perfopt(struct pci_dev *pdev);
> +#else
> +static inline int amd_iommu_enable_perfopt(struct pci_dev *pdev)
> +{
> +	return 0;
> +}
> +static inline void amd_iommu_disable_perfopt(struct pci_dev *pdev) { }
> +#endif

This commit broke build on i386, I fixed it up but please compile test on
32-bit next time.

-Joerg
