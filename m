Return-Path: <SRS0=Uo0t=KY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E58C47082
	for <amd-gfx@archiver.kernel.org>; Sat, 29 May 2021 10:20:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C28A86103E
	for <amd-gfx@archiver.kernel.org>; Sat, 29 May 2021 10:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28A86103E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D807F6EDCA;
	Sat, 29 May 2021 10:20:32 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A97606E0DB;
 Sat, 29 May 2021 06:41:26 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9ACAB68B05; Sat, 29 May 2021 08:41:24 +0200 (CEST)
Date: Sat, 29 May 2021 08:41:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [RFC PATCH 0/5] Support DEVICE_GENERIC memory in migrate_vma_*
Message-ID: <20210529064124.GC15834@lst.de>
References: <20210527230809.3701-1-Felix.Kuehling@amd.com>
 <20210528130816.GM1002214@nvidia.com>
 <f0bb142b-ab80-c16e-77dd-c7e1aa88c755@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f0bb142b-ab80-c16e-77dd-c7e1aa88c755@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Mailman-Approved-At: Sat, 29 May 2021 10:20:31 +0000
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
Cc: Felix Kuehling <felix.kuehling@gmail.com>, amd-gfx@lists.freedesktop.org,
 linux-mm@kvack.org, jglisse@redhat.com, dri-devel@lists.freedesktop.org,
 Jason Gunthorpe <jgg@nvidia.com>, akpm@linux-foundation.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 28, 2021 at 11:56:36AM -0400, Felix Kuehling wrote:
> Am 2021-05-28 um 9:08 a.m. schrieb Jason Gunthorpe:
> > On Thu, May 27, 2021 at 07:08:04PM -0400, Felix Kuehling wrote:
> >> Now we're trying to migrate data to and from that memory using the
> >> migrate_vma_* helpers so we can support page-based migration in our
> >> unified memory allocations, while also supporting CPU access to those
> >> pages.
> > So you have completely coherent and indistinguishable GPU and CPU
> > memory and the need of migration is basicaly alot like NUMA policy
> > choice - get better access locality?
> 
> Yes. For a typical GPU compute application it means the GPU gets the
> best bandwidth/latency, and the CPU can coherently access the results
> without page faults and migrations. That's especially valuable for
> applications with persistent compute kernels that want to exploit
> concurrency between CPU and GPU.

So why not expose the GPU memory as a CPUless memory node?
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
