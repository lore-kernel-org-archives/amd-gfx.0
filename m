Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B63C4167B
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Dec 2023 16:12:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE90710E490;
	Mon, 11 Dec 2023 16:12:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB18510E483
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 16:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=i6oUa6SzUya9Rmly7/Zxj3QlUW
 c7C2ZU8RWDdRpdXSwTpmJv/zTz25YG2AUDH8WXLPLt2iAxWbrJeCAZtqsrMKsQONNkcGH5ra7YMRt
 nRpjB+G24LbfISNXhpu1+8YMsphtwLnGFJrIchrf+j6pub21fjTFCeZeiBzJRFmRDYKYRY7/t8MOm
 y+ZbBLIaD13VO7VSaB+QWOnvvhkuVaK8g7Zyie/hXf53i3mAGdYxyE+fvi6oZig7ffUGfTL6WB+Le
 fQF2uR6kJa1ZkkN1MCu1CkQaPrWoB0x+jQx+Tq7F2eGUwUzhIi9rgCsMVqUnJtS/SvhM6J7ICEdk6
 4b3Adhmg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1rCijy-005cgY-0w; Mon, 11 Dec 2023 16:02:42 +0000
Date: Mon, 11 Dec 2023 08:02:42 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [RFC PATCH 01/12] arch: Add ARCH_HAS_KERNEL_FPU_SUPPORT
Message-ID: <ZXcyolSnTj1sts33@infradead.org>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-2-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208055501.2916202-2-samuel.holland@sifive.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Mon, 11 Dec 2023 16:12:41 +0000
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
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
