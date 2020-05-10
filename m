Return-Path: <SRS0=XsTU=6Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB67C54E8D
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 07:19:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80E44207FF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 07:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/CJP4rf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E44207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39A3F6E248;
	Mon, 11 May 2020 07:19:15 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F89E8970B;
 Sun, 10 May 2020 00:16:14 +0000 (UTC)
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net
 [73.231.172.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 924AF20735;
 Sun, 10 May 2020 00:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589069774;
 bh=rcEsrsDljCvjlGQcVUHPCm18WB0VkP4lxtaiG5DbAyw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=W/CJP4rfOuAYUekGlno04mT1Bs4lSQLdciQD+tx1rHltWBYBtvFb+B4LUrQlbHjBw
 UW04g6EtzWPm5sfdxjNzKUcndsgGiQnoKqJbwTmr1gRmhfy5sziX1U8aQ0QHjqGc6a
 IYL4qvBvGH/VJgSMEmkxSCU36sL9Vj/k7/fB2KjE=
Date: Sat, 9 May 2020 17:16:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH hmm v2 1/5] mm/hmm: make CONFIG_DEVICE_PRIVATE into a
 select
Message-Id: <20200509171612.94ee332ad4f494521d911ac0@linux-foundation.org>
In-Reply-To: <1-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
References: <0-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
 <1-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-Mailman-Approved-At: Mon, 11 May 2020 07:19:12 +0000
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Ralph Campbell <rcampbell@nvidia.com>, "Yang, Philip" <Philip.Yang@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
 =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
 intel-gfx@lists.freedesktop.org,
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri,  1 May 2020 15:20:44 -0300 Jason Gunthorpe <jgg@ziepe.ca> wrote:

> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> There is no reason for a user to select this or not directly - it should
> be selected by drivers that are going to use the feature, similar to how
> CONFIG_HMM_MIRROR works.
> 
> Currently all drivers provide a feature kconfig that will disable use of
> DEVICE_PRIVATE in that driver, allowing users to avoid enabling this if
> they don't want the overhead.
> 

I'm not too sure what's going on here, but i386 allmodconfig broke.

kernel/resource.c: In function '__request_free_mem_region':
kernel/resource.c:1653:28: error: 'PA_SECTION_SHIFT' undeclared (first use in this function); did you mean 'SECTIONS_PGSHIFT'?
  size = ALIGN(size, 1UL << PA_SECTION_SHIFT);

because in current mainline, allmodconfig produces
CONFIG_DEVICE_PRIVATE=n but in current linux-next, allmodconfig
produces CONFIG_DEVICE_PRIVATE=y.  But CONFIG_SPARSEMEM=n so the build
breaks.

Bisection fingers this commit, but reverting it doesn't seem to fix
things.  Could you take a look please?

I'm seeing this from menuconfig:

WARNING: unmet direct dependencies detected for DEVICE_PRIVATE
  Depends on [n]: ZONE_DEVICE [=n]
  Selected by [m]:
  - DRM_NOUVEAU_SVM [=y] && HAS_IOMEM [=y] && DRM_NOUVEAU [=m] && MMU [=y] && STAGING [=y]
  - TEST_HMM [=m] && RUNTIME_TESTING_MENU [=y] && TRANSPARENT_HUGEPAGE [=y]

`select' rather sucks this way - easy to break dependencies.  Quite a
number of years ago the Kconfig gurus were saying "avoid", but I don't
recall the details.



_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
