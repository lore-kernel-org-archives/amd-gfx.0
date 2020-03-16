Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B32C2BB1D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 20:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4997F206C0
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 20:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GGJyf40o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4997F206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 538A76E4CD;
	Mon, 16 Mar 2020 20:03:48 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26B0A8967B
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 19:49:22 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id t13so15321333qtn.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 12:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=o7JqLPPCRpGtDbfSiR++DTgayckzFt0qLULy0U0IXIw=;
 b=GGJyf40oBvUn3UsnYOHO6ftCMOlhlUE53mKdQJAM3RZ49VrR7NfNu6vFSbIJg0Vrp+
 nKaEHE/9u/3vvjCCe8WwHh8SthbR1oMP/lq3mlydxzkJGNn/tuTNACX8TZxQceM/9mon
 YIOCmCOQYTnLI6cUij9NQ1KEjPZ6YzkCBGaFSk2yslH5PGKF31RBGv+LalaZ8j2uIFLh
 bC7emlaCft8W3JdiciO0idkiwtVoNDBdFG9zx0aEVhvj80fXi5TE1dCzgDd5RWL/YOhG
 YYChBQ/vDVC92ft0WvWlgaDNuQmhJ1/CKwgNKV4aCfjmwGoqd/IKybrQhzqaZzus/5a5
 BRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=o7JqLPPCRpGtDbfSiR++DTgayckzFt0qLULy0U0IXIw=;
 b=lo3V7dQlyfaMvGw53jYwO40Md/2TpwwNIa1LJ4AVbRzfwJt6AgYftY/5nZPV5TAzou
 FLdN1Am/m1lyTuwYrVtGNycRAKJtIqA65CrDK+GdzraJmfK3X7tygKwAMzQvVYbUmOfD
 dJyvd1aPyOk99TVsHpvSUkttOJW1l4jBkozpqmezRFzYjNdT6RtqRvh2sBbEdrOgfvoL
 9nh89DmQGq6vlKT7LSGkCEu78f6Dax3sjsCRkCE0Zm2Xd2ed/wBK8B9d8duiBgupk0rQ
 f5MOh32QXiyqGAp+oCx4t30XV6voVlx3jk1L0cvMVHu89SlG4r+Gkc+Hs1YP/0i98926
 jV7A==
X-Gm-Message-State: ANhLgQ0imMkwemMZOTiQeBiTjLWKzCT0x3dSuJSAFd4r1deCaNwYpuqY
 1ipWTWdgSstWoIhy97Go9oQubcPZjaCjrQ==
X-Google-Smtp-Source: ADFU+vtYiqHgSFb/FCS3+UBgOOiW2jlaSoZd/0nI0+DDGOjwoiONzmkAwxqo+x9vqhMLJgCeBnROrw==
X-Received: by 2002:ac8:5209:: with SMTP id r9mr1812897qtn.61.1584388161299;
 Mon, 16 Mar 2020 12:49:21 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id m67sm406383qke.101.2020.03.16.12.49.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 16 Mar 2020 12:49:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jDvjk-00071k-6b; Mon, 16 Mar 2020 16:49:20 -0300
Date: Mon, 16 Mar 2020 16:49:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/4] mm: check the device private page owner in
 hmm_range_fault
Message-ID: <20200316194920.GA20010@ziepe.ca>
References: <20200316193216.920734-1-hch@lst.de>
 <20200316193216.920734-5-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200316193216.920734-5-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Mon, 16 Mar 2020 20:03:47 +0000
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
Cc: amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kvm-ppc@vger.kernel.org,
 Bharata B Rao <bharata@linux.ibm.com>, linux-mm@kvack.org,
 Jerome Glisse <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 16, 2020 at 08:32:16PM +0100, Christoph Hellwig wrote:
> Hmm range fault will succeed for any kind of device private memory,
> even if it doesn't belong to the calling entity.  While nouveau
> has some crude checks for that, they are broken because they assume
> nouveau is the only user of device private memory.  Fix this by
> passing in an expected pgmap owner in the hmm_range_fault structure.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Fixes: 4ef589dc9b10 ("mm/hmm/devmem: device memory hotplug using ZONE_DEVICE")
> ---
>  drivers/gpu/drm/nouveau/nouveau_dmem.c | 12 ------------
>  include/linux/hmm.h                    |  2 ++
>  mm/hmm.c                               | 10 +++++++++-
>  3 files changed, 11 insertions(+), 13 deletions(-)

Nice

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
