Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F3CBEB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 14:46:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71ABC10E551;
	Wed, 12 Jul 2023 14:46:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3156810E54C;
 Wed, 12 Jul 2023 14:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=f3+120nI0qsDe1YJ27JG6TM/bhTy85me+uHT6vnbIBE=; b=zhBomEzAEIF6Wet6D0dCEHoDc9
 okuiGV0HJ0zEb/6g3KT+kSOccac4dHYgXzgmsDXpd5wZ3ei7dOc22BhinkP4+RJ7NCVBTzXcBv0a+
 mkdQEaNEfbsySg6JXBXksLnyMs5HzC1sQyuqHi9VEKswmzd+kYtoaru5bwiCoPxrcZUBp1cO/xy0y
 bCCdNiZ53tTwhsypKPiuSuZw7PiowQJiG+Lccs0ykZtxq9QACS+jqeeBsft5s18KqNPAfTUUX1Wyk
 FGYopr5EI2NQOSV19zN5vF0sLOsQE6sT2ANw/qeJXOTthiv+T/qnW2z43h+s7zvVxmvcr5LASvDU5
 VUeU2pGA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qJb2z-000EDU-2z; Wed, 12 Jul 2023 14:42:29 +0000
Date: Wed, 12 Jul 2023 07:42:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH 3/5] drm/amdkfd: use vma_is_stack() and vma_is_heap()
Message-ID: <ZK671bHU1QLYagj8@infradead.org>
References: <20230712143831.120701-1-wangkefeng.wang@huawei.com>
 <20230712143831.120701-4-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712143831.120701-4-wangkefeng.wang@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Wed, 12 Jul 2023 14:46:20 +0000
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
Cc: selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-perf-users@vger.kernel.org,
 linux-mm@kvack.org, amd-gfx@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 12, 2023 at 10:38:29PM +0800, Kefeng Wang wrote:
> Use the helpers to simplify code.

Nothing against your addition of a helper, but a GPU driver really
should have no business even looking at this information..

