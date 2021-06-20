Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2302C48BE5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 07:09:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86AA561156
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 07:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86AA561156
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F3ED89D86;
	Mon, 21 Jun 2021 07:09:12 +0000 (UTC)
X-Greylist: delayed 317 seconds by postgrey-1.36 at gabe;
 Sun, 20 Jun 2021 14:20:18 UTC
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2253C89590;
 Sun, 20 Jun 2021 14:20:18 +0000 (UTC)
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net
 [72.74.133.215]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15KEEsxi001510
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Jun 2021 10:14:55 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
 id 4EFFB15C3C9F; Sun, 20 Jun 2021 10:14:54 -0400 (EDT)
Date: Sun, 20 Jun 2021 10:14:54 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Alex Sierra <alex.sierra@amd.com>
Subject: Re: [PATCH v3 0/8] Support DEVICE_GENERIC memory in migrate_vma_*
Message-ID: <YM9NXrGlhdp0qb7S@mit.edu>
References: <20210617151705.15367-1-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210617151705.15367-1-alex.sierra@amd.com>
X-Mailman-Approved-At: Mon, 21 Jun 2021 07:09:08 +0000
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
Cc: rcampbell@nvidia.com, Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org, jglisse@redhat.com,
 dri-devel@lists.freedesktop.org, jgg@nvidia.com, akpm@linux-foundation.org,
 linux-ext4@vger.kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 17, 2021 at 10:16:57AM -0500, Alex Sierra wrote:
> v1:
> AMD is building a system architecture for the Frontier supercomputer with a
> coherent interconnect between CPUs and GPUs. This hardware architecture allows
> the CPUs to coherently access GPU device memory. We have hardware in our labs
> and we are working with our partner HPE on the BIOS, firmware and software
> for delivery to the DOE.
> 
> The system BIOS advertises the GPU device memory (aka VRAM) as SPM
> (special purpose memory) in the UEFI system address map. The amdgpu driver looks
> it up with lookup_resource and registers it with devmap as MEMORY_DEVICE_GENERIC
> using devm_memremap_pages.
> 
> Now we're trying to migrate data to and from that memory using the migrate_vma_*
> helpers so we can support page-based migration in our unified memory allocations,
> while also supporting CPU access to those pages.
> 
> This patch series makes a few changes to make MEMORY_DEVICE_GENERIC pages behave
> correctly in the migrate_vma_* helpers. We are looking for feedback about this
> approach. If we're close, what's needed to make our patches acceptable upstream?
> If we're not close, any suggestions how else to achieve what we are trying to do
> (i.e. page migration and coherent CPU access to VRAM)?

Is there a way we can test the codepaths touched by this patchset?  It
doesn't have to be via a complete qemu simulation of the GPU device
memory, but some way of creating MEMORY_DEVICE_GENERIC subject to
migrate_vma_* helpers so we can test for regressions moving forward.

Thanks,

					- Ted
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
