Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9514C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 18:42:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A9CA60D43
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 18:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8A9CA60D43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8CF56E852;
	Tue, 12 Oct 2021 18:42:16 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E94A89B20;
 Tue, 12 Oct 2021 18:40:01 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A60DA60EDF;
 Tue, 12 Oct 2021 18:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1634064001;
 bh=4NlzI4dFxtFWsmK4HNOLFkn2j8KfMJnWPwZWKJPEPAI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=aLV8P7/TA7iQMJF0qaKt5ZKy+gE2TiiPu2nZqetOP9YyyAcsJo/jiZgNVzTU1lkT+
 2W/4JR9XszN9+PCKAd86SS6HZy4Utp+IQoI/3t8eWWfSQ4e0sZiWOtAYA0TYppiR0t
 YJo2Ed+MK8pToXyv2626yPlvlXLxExtGRpdF1Mv4=
Date: Tue, 12 Oct 2021 11:39:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alex Sierra <alex.sierra@amd.com>
Cc: <Felix.Kuehling@amd.com>, <linux-mm@kvack.org>, <rcampbell@nvidia.com>,
 <linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <hch@lst.de>, <jgg@nvidia.com>, <jglisse@redhat.com>, <apopple@nvidia.com>
Subject: Re: [PATCH v1 00/12] MEMORY_DEVICE_COHERENT for CPU-accessible
 coherent device memory
Message-Id: <20211012113957.53f05928dd60f3686331fede@linux-foundation.org>
In-Reply-To: <20211012171247.2861-1-alex.sierra@amd.com>
References: <20211012171247.2861-1-alex.sierra@amd.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 12 Oct 2021 18:42:16 +0000
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

On Tue, 12 Oct 2021 12:12:35 -0500 Alex Sierra <alex.sierra@amd.com> wrote:

> This patch series introduces MEMORY_DEVICE_COHERENT, a type of memory
> owned by a device that can be mapped into CPU page tables like
> MEMORY_DEVICE_GENERIC and can also be migrated like MEMORY_DEVICE_PRIVATE.
> With MEMORY_DEVICE_COHERENT, we isolate the new memory type from other
> subsystems as far as possible, though there are some small changes to
> other subsystems such as filesystem DAX, to handle the new memory type
> appropriately.
> 
> We use ZONE_DEVICE for this instead of NUMA so that the amdgpu
> allocator can manage it without conflicting with core mm for non-unified
> memory use cases.
> 
> How it works: The system BIOS advertises the GPU device memory (aka VRAM)
> as SPM (special purpose memory) in the UEFI system address map.
> The amdgpu driver registers the memory with devmap as
> MEMORY_DEVICE_COHERENT using devm_memremap_pages.
> 
> The initial user for this hardware page migration capability will be
> the Frontier supercomputer project.

To what other uses will this infrastructure be put?

Because I must ask: if this feature is for one single computer which
presumably has a custom kernel, why add it to mainline Linux?

> Our nodes in the lab have .5 TB of
> system memory plus 256 GB of device memory split across 4 GPUs, all in
> the same coherent address space. Page migration is expected to improve
> application efficiency significantly. We will report empirical results
> as they become available.
> 
> This includes patches originally by Ralph Campbell to change ZONE_DEVICE
> reference counting as requested in previous reviews of this patch series
> (see https://patchwork.freedesktop.org/series/90706/). We extended
> hmm_test to cover migration of MEMORY_DEVICE_COHERENT. This patch set
> builds on HMM and our SVM memory manager already merged in 5.14.
> We would like to complete review and merge this migration patchset for
> 5.16.

