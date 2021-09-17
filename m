Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF3EC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 22:34:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9424061155
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 22:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9424061155
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=u92.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30AE56E0AF;
	Fri, 17 Sep 2021 22:34:20 +0000 (UTC)
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com
 [64.147.123.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DD086E0AF;
 Fri, 17 Sep 2021 22:34:19 +0000 (UTC)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailnew.west.internal (Postfix) with ESMTP id 887FE2B00BBD;
 Fri, 17 Sep 2021 18:34:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Fri, 17 Sep 2021 18:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=date
 :from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm3; bh=NEn6f5nwKhtlnq0PJmZb3sd10FJ
 pseStLYb5gftDgpM=; b=bamYZWYBd65OjqTjyIfE5+RM74VnH3PJLdGAvLX6xtD
 gShsfCfxBSdd2s+vtVanAMEDc+G1cQtG5Kwq7Xen4aPET/lhwyRfN0YEiJ4j4TSh
 u5DDTaek9RRMZFk3JETDcYKdqiW0BWqXYsATKqDKuUr6dkDO/HK5g9ZOdDiqGJ2h
 B27ZS9Wp9t4cWk+7wmAZ3XKMwOszDYmES0JMTTAJzjZIjXGUYV4Uq8j24TOD+uR7
 NJZggRlZuLnb5PT8tnVpjlyA87xW4dFVIt8uQmhITVTrLU5nHUI2UvxGEEvnA0Tl
 uosMxdue4JEGrbt9e/3QkZdR+W7ewrCx5HHlbae8dkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=NEn6f5
 nwKhtlnq0PJmZb3sd10FJpseStLYb5gftDgpM=; b=BBxBPOaBcRj5HGM2JAMku2
 dCIFy0kwWhy1vQWkmT5ieWhtbFtj7RvOTOjjuWvGbfwqNMzmkF5ppKVIY0GKxDmR
 e32beEtE54V5+ELeQHpzZ9jMgRc8UMTqQMHSveZP2mzNY3+n+nhPsTMhLYHG7aIV
 +BbhY/JGcNKBao+CYhZ+fJh0J65oVxjE9oSsFdEG653T76Np10sb8vBKgLEloPGT
 y74WMF9re5sFq0gdcwcGsaAczuGq6Bt+vKnVWgJ7Dth88nJ9kcNbnSjDU2wO+koG
 oOH1+ZBFPQV7Xrl5DPm/CdBwo9h2Z22hgHwf0RJYk6z0pRemi3RfzCurBPXfnqiA
 ==
X-ME-Sender: <xms:6RdFYf5Ok9ND1rQMWK3kDvv2wjBALO3Q8f8WH-n0mmmj6djSh2bctA>
 <xme:6RdFYU7yzsxBYL-VSm1VsnbXqiGmNCD3-pq5XF96Ls7DsAeiVjPIxmLDrhu13KvCp
 CkjYU8cDY1B7XcyYw>
X-ME-Received: <xmr:6RdFYWeXFx1fO_FK3UvC7T7TtL__I-oahbGhCAlZxFgQvj2gK6E0khM1HyKt3PNmP_gjbsCh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehjedgudduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefhvghrnhgr
 nhguohcutfgrmhhoshcuoehgrhgvvghnfhhoohesuhelvddrvghuqeenucggtffrrghtth
 gvrhhnpedvjeeifeelhfetiefhhfdthfefkefhhfeutdetvdfgvefgveefheffgfekjeef
 heenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrh
 gvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:6RdFYQJt6b6BpcOK2dsf5glSeYKJdPml5a4ItJDU4MvIkSxjxLobGg>
 <xmx:6RdFYTL6bnfyISPgIeryfHnaZp_BKZ8cCYpsZyEMzBwmkS70qdfwSQ>
 <xmx:6RdFYZwPCBI0rzuGJK4NZ8TI150igvq0q4DLXOrxRLrCPyIdPbzhHw>
 <xmx:6hdFYUXSG444WVG43RZURHJ1OFX4p79N5I6eaTeAB6vvxKRFDIy9IqwmH50>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Sep 2021 18:34:14 -0400 (EDT)
Date: Sat, 18 Sep 2021 00:34:12 +0200
From: Fernando Ramos <greenfoo@u92.eu>
To: Sean Paul <sean@poorly.run>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 06/15] drm/tegra: cleanup: drm_modeset_lock_all() -->
 DRM_MODESET_LOCK_ALL_BEGIN()
Message-ID: <YUUX5KukyKKPy9jE@zacax395.localdomain>
References: <20210916211552.33490-1-greenfoo@u92.eu>
 <20210916211552.33490-7-greenfoo@u92.eu>
 <20210917153805.GF2515@art_vandelay>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210917153805.GF2515@art_vandelay>
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

> >  	int err = 0;
> > +	int ret;
> 
> You can use err here instead.

Done!
