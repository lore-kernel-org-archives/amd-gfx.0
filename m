Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094EBC4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:16:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3937361106
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3937361106
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B36C96E8C7;
	Thu, 19 Aug 2021 13:15:58 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3CF26E89A;
 Thu, 19 Aug 2021 09:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=30I+7nEm5zbvXFaNjeCP/URwvn0lUxkdZ8/N2SFqU4g=; b=hdp6qYYIiawPbHWzGgJGbeGDoL
 TskujUOUgkw5fqQ32Dq09FqOv51wvLWbNrcrdw3wg7CGsAtqwE0y+rW5EzXhdMJx/nO7U+/vDSAxy
 ZGC4r6aC4wc44wp1pn/5iT/tBmcMPk/3CafPQ6Y6Tjjhb6zYRI/6S5OA4cG/Qk8BIe9OYWnnx7d8w
 7GhnTeyRi2ZmTBFWwHRyV84JdQ6eKrGvxUZFLENaT0zcmJ62SNY0OjvyFBg+eHiiFyXh1CKCQ5zLg
 4phvLD2DSvHmVFPqRiYmTfBtb2/AVqElq02npejAimvBLZXPdunESEx0AVEqb2PzRTbXPbtdOrilL
 U+nUWJXA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mGejF-004tP2-Ci; Thu, 19 Aug 2021 09:53:07 +0000
Date: Thu, 19 Aug 2021 10:52:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
 linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
 Brijesh Singh <brijesh.singh@amd.com>,
 Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>,
 Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2 03/12] x86/sev: Add an x86 version of prot_guest_has()
Message-ID: <YR4p9TqKTLdN1A96@infradead.org>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <7d55bac0cf2e73f53816bce3a3097877ed9663f3.1628873970.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d55bac0cf2e73f53816bce3a3097877ed9663f3.1628873970.git.thomas.lendacky@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Thu, 19 Aug 2021 13:15:57 +0000
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

On Fri, Aug 13, 2021 at 11:59:22AM -0500, Tom Lendacky wrote:
> While the name suggests this is intended mainly for guests, it will
> also be used for host memory encryption checks in place of sme_active().

Which suggest that the name is not good to start with.  Maybe protected
hardware, system or platform might be a better choice?

> +static inline bool prot_guest_has(unsigned int attr)
> +{
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +	if (sme_me_mask)
> +		return amd_prot_guest_has(attr);
> +#endif
> +
> +	return false;
> +}

Shouldn't this be entirely out of line?

> +/* 0x800 - 0x8ff reserved for AMD */
> +#define PATTR_SME			0x800
> +#define PATTR_SEV			0x801
> +#define PATTR_SEV_ES			0x802

Why do we need reservations for a purely in-kernel namespace?

And why are you overoading a brand new generic API with weird details
of a specific implementation like this?
