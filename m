Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCF1C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 22:33:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E1D860F92
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 22:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2E1D860F92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=u92.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D52646E0B7;
	Fri, 17 Sep 2021 22:33:01 +0000 (UTC)
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com
 [64.147.123.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 843C46E0AD;
 Fri, 17 Sep 2021 22:33:00 +0000 (UTC)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailnew.west.internal (Postfix) with ESMTP id 509562B00BB2;
 Fri, 17 Sep 2021 18:32:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Fri, 17 Sep 2021 18:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=date
 :from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm3; bh=Pwv+7pylkaIrPBg3R0kBxNlV+Qf
 DULkAa/KMRtw0Pno=; b=cfp6Lw7yuzUQ0udmdQnhrDY8tgotCYiVevyu0EjtXCj
 KJacrwUjOBWZJWeXN0Sz14XZVtEJbMQ46gwVn6S1HQDcYsNwDq2jqyZiY/Z9ObdO
 1vJkK66GTlosny/xLMkHvVNIThNMfn2VG5maIVFf20nlpR+9y6b7Y89jzNN572hk
 56+i9UG6adSGYwQ+Ha31bT/ZKo9JEls6qXOWdhaZTvDO9o5zx71d0IBKkOQ1eFff
 xsujTYE1EkvMBaAhi/ZXTcU8E874UTt+PSSKenlNB4Qwsc820XcLR/zmuMcJiBc8
 KJKf7gSTcbrzfH7NRU1t3SomC0fkGuaSxmJoGjYxgqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Pwv+7p
 ylkaIrPBg3R0kBxNlV+QfDULkAa/KMRtw0Pno=; b=OT0vUGuSB3Q5GUldtkZ4hD
 ISjHzWRc9lXwqyHNnnx6Peo23H19RklTOphrbBZUNdCTQyRu5r+kbWTEfrLUFbHn
 5svWwEO38lRt1VJqd6W69ohk0Lo6XGOyxrMZCQ/s0MX7w0Y9zOl7yzNQTBDa9CqW
 gfObJfg1FFmTZZkocCGwnLlqeMCyw5TTzIhfMXhBYHPcT/CA7lCCezfXVtBz2bQr
 Exf8wJBCzAWDF+/QpJo68z7TBJlF2+S/9bP0qmexdv61MBJR0XRFhXBu/g7cOSdz
 hvpXFlV7dEfudE1n3FV692nxLddDL1PkqVzv7PyUPUclMd0L+xUiUJvz9AaEmy8g
 ==
X-ME-Sender: <xms:mhdFYbBBlz_6nrWMgjtxeQJo0MHomyJWN7ILPvbkC1UQTnGB5INQ7w>
 <xme:mhdFYRg0oW7LqwRzCPWzRjcoPFmyhwP_ICrJan_ClGt6MSvJbTa9By4nL4P9NiW3I
 -8urXjsqHxaduPQRA>
X-ME-Received: <xmr:mhdFYWkW8bxmH_uOwsWTsTtXCb-KcfiMzAk-jd6UIksbA44xHuzaB0hK-orp-q_H1wbT88zr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehjedgudduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefhvghrnhgr
 nhguohcutfgrmhhoshcuoehgrhgvvghnfhhoohesuhelvddrvghuqeenucggtffrrghtth
 gvrhhnpedvjeeifeelhfetiefhhfdthfefkefhhfeutdetvdfgvefgveefheffgfekjeef
 heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrh
 gvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:mhdFYdxMeAjK1wBVSQh1hHIPI8lZVjEAub0quqxAjCGVrclzqvqGBQ>
 <xmx:mhdFYQQmWo_y31divswy8Lt1Y68E3N1OdkcJFlWUsF3JK1OlUIfXMg>
 <xmx:mhdFYQZkIAwiNuGSzUsVOQBcn479ovRRuwdSLwS86L20TRh6QIGOkw>
 <xmx:mhdFYZ9c6ocv8m6ErBEB8z2Qcha4_Xl_cFXbUOTIrICPGY7HC2YRmeitXP0>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Sep 2021 18:32:55 -0400 (EDT)
Date: Sat, 18 Sep 2021 00:32:52 +0200
From: Fernando Ramos <greenfoo@u92.eu>
To: Sean Paul <sean@poorly.run>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 08/15] drm/radeon: cleanup: drm_modeset_lock_all() -->
 DRM_MODESET_LOCK_ALL_BEGIN()
Message-ID: <YUUXlOh0rKcynrPZ@zacax395.localdomain>
References: <20210916211552.33490-1-greenfoo@u92.eu>
 <20210916211552.33490-9-greenfoo@u92.eu>
 <20210917154031.GH2515@art_vandelay>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210917154031.GH2515@art_vandelay>
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

> > +	struct drm_modeset_acquire_ctx ctx;
> >  	int i, r;
> > +	int ret;
> 
> Could you please tuck this up with i & r?

Done!


> > -	drm_modeset_unlock_all(dev);
> > +	DRM_MODESET_LOCK_ALL_END(dev, ctx, ret);
> 
> You should check ret here

Would it be save to return at this point if the lock fails?

In other words, can I just add this? --> "if (ret) return ret;"


> > +	struct drm_modeset_acquire_ctx ctx;
> >  	int r;
> > +	int ret;
> 
> Same suggestion here, move up with r

Done!


> > -		drm_modeset_unlock_all(dev);
> > +		DRM_MODESET_LOCK_ALL_END(dev, ctx, ret);
> 
> Also check ret here

Same question. Would "if (ret) return ret;" be safe here?


> >  	int i;
> > +	int ret;
> 
> Move up with i

Done!


> > -	drm_modeset_unlock_all(dev);
> > +	DRM_MODESET_LOCK_ALL_END(dev, ctx, ret);
> >  	return 0;

I can also "return ret;" instead of "0".

What happens when a DEFINE_SHOW_ATTRIBUTE'd function returns non-zero? Is it ok?
Or do we want to always return "0" to print whatever we can?


