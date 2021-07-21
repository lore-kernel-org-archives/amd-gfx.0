Return-Path: <SRS0=ovQZ=MN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5ECC07E9B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 07:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95D7860230
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 07:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D7860230
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 586526E30D;
	Wed, 21 Jul 2021 07:29:55 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B81E76E90D
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jul 2021 06:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=2Tg6rDmREVX1ceiTKGgiYnKUFpoX6FiU/JNm2fWqBkw=; b=t3hopBQTUruM/ENRFxNyEOoUC+
 5oJEQnciSH7H7I8MBiuNHyNhq7XNi/0H9lWN4pG4JSoChs5UkzgXC23DuhuRBWouYCC04xOkyZ1xV
 rR+ywDmkEKE0nnaaZ5dg8qfF0i8IuE7hW6GwCxdzrrEd18zJIIHurdno+HOqRNXejciU760Nh3WQx
 3AOh2nuu5mW+eF0HaQSNswWOgds534d05ahBQ3vI0rR4UkVwl5iObPL+K+tNrdsch3TtjxYoxhGnS
 hW5Qq+sSJ88nW4YhTG3gLQZhM3cY/AdifCtrpRz3dSoygFIOUXVfb1SJ8YEApxUrgC5VPetggN9c3
 7B06dTQQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1m66BG-008tyJ-Id; Wed, 21 Jul 2021 06:58:13 +0000
Date: Wed, 21 Jul 2021 07:58:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Anson Jacob <Anson.Jacob@amd.com>
Subject: Re: [RFC v2 1/2] ppc/fpu: Add generic FPU api similar to x86
Message-ID: <YPfFgkD+kcRaH8Ow@infradead.org>
References: <20210721044801.840501-1-Anson.Jacob@amd.com>
 <20210721044801.840501-2-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210721044801.840501-2-Anson.Jacob@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Wed, 21 Jul 2021 07:29:54 +0000
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
Cc: Bhawanpreet.Lakha@amd.com, Harry Wentland <harry.wentland@amd.com>,
 Sunpeng.Li@amd.com, mpe@ellerman.id.au, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, roman.li@amd.com,
 Christoph Hellwig <hch@infradead.org>, Aurabindo.Pillai@amd.com,
 paulus@samba.org, christophe.leroy@csgroup.eu, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org, Christian K??nig <christian.koenig@amd.com>,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

> +
> +/*
> + * Use kernel_fpu_begin/end() if you intend to use FPU in kernel context. It
> + * disables preemption so be careful if you intend to use it for long periods
> + * of time.
> + * TODO: If you intend to use the FPU in irq/softirq you need to check first with
> + * irq_fpu_usable() if it is possible.

Please avoid the overly lone lines comments.

> +extern bool kernel_fpu_enabled(void);
> +extern void kernel_fpu_begin(void);
> +extern void kernel_fpu_end(void);

No need for the externs.

> +/*
> + * Track whether the kernel is using the FPU state
> + * currently.

This all fits on a single line.

> +static bool fpu_support(void)
> +{
> +	if (cpu_has_feature(CPU_FTR_VSX_COMP)) {
> +		return true;
> +	} else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP)) {
> +		return true;
> +	} else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE)) {
> +		return true;
> +	}

No need for the braces, or else after a return.  In fact this could
be simplified down to:

	return cpu_has_feature(CPU_FTR_VSX_COMP) ||
		cpu_has_feature(CPU_FTR_ALTIVEC_COMP) ||
		cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE));

> +	preempt_disable();
> +
> +#ifdef CONFIG_VSX
> +	if (cpu_has_feature(CPU_FTR_VSX_COMP)) {
> +		enable_kernel_vsx();
> +		return;
> +	}
> +#endif
> +
> +#ifdef CONFIG_ALTIVEC
> +	if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP)) {
> +		enable_kernel_altivec();
> +		return;
> +	}
> +#endif
> +
> +#ifdef CONFIG_PPC_FPU
> +	if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE)) {
> +		enable_kernel_fp();
> +		return;
> +	}
> +#endif

All the features are defined away if not supported (and we already rely
on that in fpu_support()).  So this could become:

	if (cpu_has_feature(CPU_FTR_VSX_COMP))
		enable_kernel_vsx();
	else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP))
		enable_kernel_altivec();
	else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
		enable_kernel_fp();

Same for the disable path.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
