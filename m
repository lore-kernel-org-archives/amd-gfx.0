Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F64C07E95
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 16:47:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25766613E8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 16:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25766613E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC04A6E9C8;
	Fri, 16 Jul 2021 16:47:11 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF9176E9A4;
 Fri, 16 Jul 2021 15:07:49 +0000 (UTC)
Received: from callcc.thunk.org (96-65-121-81-static.hfc.comcastbusiness.net
 [96.65.121.81]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16GF7fnw014809
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Jul 2021 11:07:42 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
 id D6FEA4202F5; Fri, 16 Jul 2021 11:07:40 -0400 (EDT)
Date: Fri, 16 Jul 2021 11:07:40 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH v3 0/8] Support DEVICE_GENERIC memory in migrate_vma_*
Message-ID: <YPGgvNxfOCx/Sp0g@mit.edu>
References: <20210617151705.15367-1-alex.sierra@amd.com>
 <YM9NXrGlhdp0qb7S@mit.edu>
 <905418d1-9099-0ea8-a6e6-84cc8ef3d0b0@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <905418d1-9099-0ea8-a6e6-84cc8ef3d0b0@amd.com>
X-Mailman-Approved-At: Fri, 16 Jul 2021 16:47:10 +0000
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
Cc: Alex Sierra <alex.sierra@amd.com>, rcampbell@nvidia.com,
 amd-gfx@lists.freedesktop.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 jglisse@redhat.com, dri-devel@lists.freedesktop.org, jgg@nvidia.com,
 akpm@linux-foundation.org, linux-ext4@vger.kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jun 23, 2021 at 05:49:55PM -0400, Felix Kuehling wrote:
> 
> I can think of two ways to test the changes for MEMORY_DEVICE_GENERIC in
> this patch series in a way that is reproducible without special hardware and
> firmware:
> 
> For the reference counting changes we could use the dax driver with hmem and
> use efi_fake_mem on the kernel command line to create some DEVICE_GENERIC
> pages. I'm open to suggestions for good user mode tests to exercise dax
> functionality on this type of memory.

Sorry for the thread necromancy, but now that the merge window is
past....

Today I test ext4's dax support, without having any $$$ DAX hardware,
by using the kernel command line "memmap=4G!9G:memmap=9G!14G" which
reserves memory so that creates two pmem device and then I run
xfstests with DAX enabled using qemu or using a Google Compute Engine
VM, using TEST_DEV=/dev/pmem0 and SCRATCH_DEV=/dev/pmem1.

If you can give me a recipe for what kernel configs I should enable,
and what magic kernel command line arguments to use, then I'd be able
to test your patch set with ext4.

Cheers,

						- Ted
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
