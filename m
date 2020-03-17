Return-Path: <SRS0=ZDaT=5C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1324DC10F29
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2020 14:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F49205ED
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2020 14:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xk4370EY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F49205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 899A06E23B;
	Tue, 17 Mar 2020 14:48:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7BD26E207;
 Tue, 17 Mar 2020 14:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=B6sA4U5uRHUb7HI5o2pzoUyTxYgVxOvVSCm5M9an9bE=; b=Xk4370EY5RcaiZI1isImzRUH0E
 VO5SIS3h3IqnpST+F2Bq5ZhkHyuJ8iERh86pRF8HaVz0S9oI7bSD83kZLl+DJp+die3GSBDBHl6Tu
 ES/hHJBMHD7zCqNJTFLsB3hCk3hZL7duoYR5N6i5C+BVfq9GBnNWI7egNyZ6qWhRaycim/JrDJAJb
 ji2YytLB4I38W55UTSyqfDIb9f5kHIvtD1T73/v0pXh6B2McDIzmSCodiqq+pc8Bt0DIc/T9ENyNq
 i8GMwKCtpIos1xcBawV/ebtDKRxbShzENa8/S93xWPpRdZBVKumMGjnMlChK81EeH8yFYMACP0j9s
 ZKD9Z/fg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jEDVD-000884-OG; Tue, 17 Mar 2020 14:47:31 +0000
Date: Tue, 17 Mar 2020 07:47:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mikel Rychliski <mikel@mikelr.com>
Subject: Re: [PATCH RESEND v2 2/2] PCI: Use ioremap(), not phys_to_virt() for
 platform ROM
Message-ID: <20200317144731.GG23471@infradead.org>
References: <20200313222258.15659-1-mikel@mikelr.com>
 <20200313222258.15659-3-mikel@mikelr.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200313222258.15659-3-mikel@mikelr.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Tue, 17 Mar 2020 14:48:36 +0000
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>, linux-pci@vger.kernel.org,
 Matthew Garrett <matthewgarrett@google.com>, amd-gfx@lists.freedesktop.org,
 Bjorn Helgaas <bhelgaas@google.com>, Ben Skeggs <bskeggs@redhat.com>,
 nouveau@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Mar 13, 2020 at 06:22:58PM -0400, Mikel Rychliski wrote:
>  /**
> + * pci_platform_rom - ioremap() the ROM image provided by the platform
>   * @pdev: pointer to pci device struct
>   * @size: pointer to receive size of pci window over ROM
> + *
> + * Return: kernel virtual pointer to image of ROM
> + *
> + * The caller is responsible for removing the mapping with iounmap()
>   */
>  void __iomem *pci_platform_rom(struct pci_dev *pdev, size_t *size)
>  {
>  	if (pdev->rom && pdev->romlen) {
>  		*size = pdev->romlen;
> -		return phys_to_virt((phys_addr_t)pdev->rom);
> +		return ioremap(pdev->rom, pdev->romlen);
>  	}

What is the value of this helper over just open coding an ioremap
of pdev->rom in the callers?
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
