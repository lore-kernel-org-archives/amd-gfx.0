Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06F3C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 14:07:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32FA110E72C;
	Mon, 13 Dec 2021 14:07:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A8DE89D4A;
 Mon, 13 Dec 2021 09:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=E1tfJAJEo2ii3UUfFc4sMr4HPboIoKFc3I0QAP/7CAY=; b=aIrkrI+KqL28ZA6400YDIn5IRt
 l/K5scmwRddqvQ4sE0ypmZYXJJlYitkGODVJZb+y0TgOVv54m15f3u+j3oQp6CC7XNdvtxL6zewm5
 wVLwzhTVZ0guWNcDSliGheB19UtdIGNOf8Edd9tenuethftMe2lSvWjMDGO5BIVsYw60DVxcIJXg9
 8D9jlXCJajiE7uuBy01ct8hzHIr96VtnyABQb2KZDfCcEK6qALNDGh6d7/eoKvaptsKAfe4c1Pf0O
 DZ5/9P6Hm20Gs2DvIGP1uc4PJK+LjSecS4BbZPZ+UQm524ZMKszJ/5wNQbln7cKISDMGA1UQglJ/u
 ZRpyi5wQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mwhFf-008UXb-Be; Mon, 13 Dec 2021 09:04:07 +0000
Date: Mon, 13 Dec 2021 01:04:07 -0800
From: Christoph Hellwig <hch@infradead.org>
To: ira.weiny@intel.com
Subject: Re: [PATCH 1/7] drm/i915: Replace kmap() with kmap_local_page()
Message-ID: <YbcMhzfm31aL5fzx@infradead.org>
References: <20211210232404.4098157-1-ira.weiny@intel.com>
 <20211210232404.4098157-2-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210232404.4098157-2-ira.weiny@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Mon, 13 Dec 2021 14:07:46 +0000
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
Cc: David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>,
 intel-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Dec 10, 2021 at 03:23:58PM -0800, ira.weiny@intel.com wrote:
> -		vaddr = kmap(page);
> +		vaddr = kmap_local_page(page);
>  		memcpy(vaddr, data, len);
> -		kunmap(page);
> +		kunmap_local(vaddr);

memcpy_to_page?
