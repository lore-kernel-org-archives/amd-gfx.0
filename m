Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB52C106F31F
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 10:29:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B8FA10E0E2;
	Thu, 26 Mar 2026 10:29:31 +0000 (UTC)
Received: from redcrew.org (redcrew.org [37.157.195.192])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD9D010E05F
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 10:29:27 +0000 (UTC)
Received: from server.danny.cz (85-71-161-19.rce.o2.cz [85.71.161.19])
 by redcrew.org (Postfix) with ESMTP id 82805D4;
 Thu, 26 Mar 2026 11:29:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 redcrew.org 82805D4
Received: from talos.danny.cz (talos
 [IPv6:2001:470:5c11:160:47df:83f6:718e:218])
 by server.danny.cz (Postfix) with SMTP id 421DD17A006;
 Thu, 26 Mar 2026 11:29:20 +0100 (CET)
Date: Thu, 26 Mar 2026 11:29:20 +0100
From: Dan =?UTF-8?B?SG9yw6Fr?= <dan@danny.cz>
To: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Gaurav Batra <gbatra@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 amd-gfx@lists.freedesktop.org, Donet Tom <donettom@linux.ibm.com>
Subject: Re: amdgpu driver fails to initialize on ppc64le in 7.0-rc1 and newer
Message-Id: <20260326112920.07eb56ee6d133947d8bcf6f3@danny.cz>
In-Reply-To: <341nolfr.ritesh.list@gmail.com>
References: <20260313142351.609bc4c3efe1184f64ca5f44@danny.cz>
 <1phlu3bs.ritesh.list@gmail.com>
 <20260315105021.667e52d4a99b154ef1e6aa34@danny.cz>
 <da93575e-92ad-4a7b-83df-1cb956bd2bc2@linux.ibm.com>
 <5x6knm5q.ritesh.list@gmail.com>
 <2d5fd6ec-003f-4d24-aa2e-06ba94d6cba4@linux.ibm.com>
 <341nolfr.ritesh.list@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; powerpc64le-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Ritesh,

On Wed, 25 Mar 2026 23:12:16 +0530
Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:

> Gaurav Batra <gbatra@linux.ibm.com> writes:
> 
> > Hello Ritesh
> >
> > I think, what you are proposing to add dev->bus_dma_limit in the check 
> > might work. In the case of PowerNV, this is not set, but 
> > dev->dma_ops_bypass is set. So, for PowerNV, it will fall back to how it 
> > was before.
> >
> > Also, since these both are set in LPAR mode, the current patch as-is 
> > will work.
> >
> > Dan, can you please try Ritesh proposed fix on your PowerNV box? I am 
> > not able to lay my hands on a PowerNV box yet.
> >
> 
> It would be this diff then. Note, I have only compile tested it.
> 
> diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
> index 73e10bd4d56d..8b4de508d2eb 100644
> --- a/arch/powerpc/kernel/dma-iommu.c
> +++ b/arch/powerpc/kernel/dma-iommu.c
> @@ -67,7 +67,7 @@ bool arch_dma_unmap_sg_direct(struct device *dev, struct scatterlist *sg,
>  }
>  bool arch_dma_alloc_direct(struct device *dev)
>  {
> -       if (dev->dma_ops_bypass)
> +       if (dev->dma_ops_bypass && dev->bus_dma_limit)
>                 return true;
> 
>         return false;
> @@ -75,7 +75,7 @@ bool arch_dma_alloc_direct(struct device *dev)
> 
>  bool arch_dma_free_direct(struct device *dev, dma_addr_t dma_handle)
>  {
> -       if (!dev->dma_ops_bypass)
> +       if (!dev->dma_ops_bypass || !dev->bus_dma_limit)
>                 return false;
> 
>         return is_direct_handle(dev, dma_handle);

this seems to fix the amdgpu initialization, full kernel log available
as https://fedora.danny.cz/tmp/kernel-7.0-rc5.log

Tested-by: Dan Horák <dan@danny.cz>


		Dan
