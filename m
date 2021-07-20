Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3A6C07E9B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 07:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F28461175
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 07:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F28461175
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E96B26E283;
	Tue, 20 Jul 2021 07:35:34 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C18006E0AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 06:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=xo2+BXQHItnxNJhVgG4zVbHYnMLsWJSV/TYOAQ+LULo=; b=PlZqnYBfjarsc8dkKeEA6qDvnn
 EkEdH+uR1mGSy+NzSb0UqFrT9stVKc1KdGeLOpo2ihsIjh+VHV1EqpXjdFQWb9AY7rOMbZJXOOZhn
 1h3MB5xJ27u0Of29QELCsxqdzVeJxNMHNp//J1G/jBQ7+9ej5xkCyFRNTer0JNpfwqWZspKyx3hPw
 opwkZ5soOWPHENTN5kAiuMvolFMNwkfVjBnBHKfm/NniA2k1y8Vy1Kz9PsoNmcFaVYCptAAphuNLy
 oKrmX6kAha1Tk9aWjFqVOd82NHJAOOWYw12i61EMBQkzJBLRP4wHQa8j4wcyymTim8cLoyvKtkngL
 PM730Bng==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1m5irU-007oCE-Hk; Tue, 20 Jul 2021 06:04:20 +0000
Date: Tue, 20 Jul 2021 07:04:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Anson Jacob <Anson.Jacob@amd.com>
Subject: Re: [RFC 1/2] ppc/fpu: Add generic FPU api similar to x86
Message-ID: <YPZnXDQLwV70qyrb@infradead.org>
References: <20210719195211.520428-1-Anson.Jacob@amd.com>
 <20210719195211.520428-2-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210719195211.520428-2-Anson.Jacob@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Tue, 20 Jul 2021 07:35:33 +0000
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
Cc: Harry.Wentland@amd.com, Sunpeng.Li@amd.com, mpe@ellerman.id.au,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org, Bhawanpreet.Lakha@amd.com,
 Aurabindo.Pillai@amd.com, paulus@samba.org, christophe.leroy@csgroup.eu,
 benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jul 19, 2021 at 03:52:10PM -0400, Anson Jacob wrote:
> - Add kernel_fpu_begin & kernel_fpu_end API as x86
> - Add logic similar to x86 to ensure fpu
>   begin/end call correctness
> - Add kernel_fpu_enabled to know if FPU is enabled
> 
> Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>

All the x86 FPU support is EXPORT_SYMBOL_GPL for a good reason, so
please stick to that.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
