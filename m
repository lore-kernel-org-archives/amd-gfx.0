Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE43C54E94
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jan 2023 21:21:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23D0410E6F8;
	Tue, 24 Jan 2023 21:21:40 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8FC110E063
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jan 2023 20:28:04 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 1CD5EB81614;
 Tue, 24 Jan 2023 20:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA23C433EF;
 Tue, 24 Jan 2023 20:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1674592081;
 bh=1rWo2gVFCT7QVVmUxqzdOhYbMaH9XfT5CDozwm7NQrk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=RAkEtqME/g5HPD3EqT9y0QTJK7MhCN8INgZrUtwFtM5QOds0hQ9Af6E2ZtApEAO3o
 rS2tEWsnnl6xrSmpMlY0femzPWDjJ8QUQwz+8gM0sf3WkV4zK0zxPO7fPAgemxiaRK
 BaIWdULJtNQOpQmRSlJrtEHau89eFa5ePqH9ZhoE=
Date: Tue, 24 Jan 2023 12:28:00 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: kernel test robot <lkp@intel.com>
Subject: Re: [linux-next:master] BUILD REGRESSION
 a54df7622717a40ddec95fd98086aff8ba7839a6
Message-Id: <20230124122800.a8c3affd99d6d916a10a1479@linux-foundation.org>
In-Reply-To: <63d00931.j+gAM+ywiXvJX7wP%lkp@intel.com>
References: <63d00931.j+gAM+ywiXvJX7wP%lkp@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 24 Jan 2023 21:21:34 +0000
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
Cc: netdev@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Matthew Wilcox <willy@infradead.org>,
 Sidhartha Kumar <sidhartha.kumar@oracle.com>,
 linux-arm-kernel@lists.infradead.org, Mike Kravetz <mike.kravetz@oracle.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, 25 Jan 2023 00:37:05 +0800 kernel test robot <lkp@intel.com> wrote:

> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> branch HEAD: a54df7622717a40ddec95fd98086aff8ba7839a6  Add linux-next specific files for 20230124
> 
> Error/Warning: (recently discovered and may have been fixed)
> 
> ERROR: modpost: "devm_platform_ioremap_resource" [drivers/dma/fsl-edma.ko] undefined!
> ERROR: modpost: "devm_platform_ioremap_resource" [drivers/dma/idma64.ko] undefined!
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_training.c:1585:38: warning: variable 'result' set but not used [-Wunused-but-set-variable]
> 
> Unverified Error/Warning (likely false positive, please contact us if interested):
> 
> ...
>
> mm/hugetlb.c:3100 alloc_hugetlb_folio() error: uninitialized symbol 'h_cg'.

	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, folio);

The warning looks to be bogus.  I guess we could put a "= NULL" in
there to keep the compiler quiet?

