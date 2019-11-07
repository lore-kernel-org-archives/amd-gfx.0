Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FBCC43331
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 21:04:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 652B621D79
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 21:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 652B621D79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFE3E6F7CA;
	Thu,  7 Nov 2019 21:04:49 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC8936F7A5
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 20:36:32 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id o49so3858932qta.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Nov 2019 12:36:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=71LM+xH1wkNpW127vr6ZxQkFrR5SvDtsBzUQHq660ZY=;
 b=oCB8ggY5BfYgGaFx/gTvxJAS5U8tWqOiVPpgXiJrZQQrG2HLlGtJeQzh0dMy3j+ehC
 7EYsbLrOB7i/NqdhN4b9Iec40oBnorEtsbARJcYmrA2GD42yrbltwJiCrohdMKeJopxo
 +ppLZyVp/6+cvOqu5SV28wb/pWRByVf81CES7+JwslZz+O5efLRWmAYZZLIWp8lD/FxI
 A7kcsp+fRgpbpDhtl82ezZSQZ5ZJMCY+gsxfNRIV5gm7UGrk7J6ohXsw4h4MQ5ayKAKQ
 NqP90FB8yXLpynTMtp7wieECrTaHTFdJtTSr+ajoicxFjKRDnBZKjSzqk1tzO/Kz/HQF
 RqwQ==
X-Gm-Message-State: APjAAAXJegJQPKluuvmjzULhwvjHvCYMOGU/Wl+gxwEjJ+YcaIn4ayau
 +C2fe4Ay34cn3IZ8A4Ij1Bx3Nw==
X-Google-Smtp-Source: APXvYqyNBsBryLeEi7SIRoAPqzH4cK3zfUarxZiwLJPOIp00fgPi4tyHDHRm5q/vs9/sR4SDhwZ/Hw==
X-Received: by 2002:ac8:67d9:: with SMTP id r25mr6108730qtp.7.1573158991013;
 Thu, 07 Nov 2019 12:36:31 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.180])
 by smtp.gmail.com with ESMTPSA id q17sm2194836qtq.58.2019.11.07.12.36.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Nov 2019 12:36:30 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1iSoW5-0000Io-Qj; Thu, 07 Nov 2019 16:36:29 -0400
Date: Thu, 7 Nov 2019 16:36:29 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v2 09/15] xen/gntdev: use mmu_range_notifier_insert
Message-ID: <20191107203629.GF6730@ziepe.ca>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-10-jgg@ziepe.ca>
 <3938b588-c6c5-3bd1-8ea9-47e4d5b2045c@oracle.com>
 <20191105023108.GN22766@mellanox.com>
 <a62e58f6-d98b-1feb-d0ca-fb8210f3e831@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a62e58f6-d98b-1feb-d0ca-fb8210f3e831@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Thu, 07 Nov 2019 21:04:48 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent;
 bh=71LM+xH1wkNpW127vr6ZxQkFrR5SvDtsBzUQHq660ZY=;
 b=D3bFpO22vYKzoP0y0kJzENmUIyEWWuBeZdrbWOd1NSHyV6jshwYAek9v0UQlPVNFPm
 gMM8Mo2Kxc8gRUHzzjxaadcVCTPEcRYvCbAIX8OusFUjw7o9YpFUkiK3RoQQUeow2ms9
 eGazhDIo9mJpashFsikQQIbjd6TISyD1pZmFKifpX4Zhcl//XXhGcH3+Zo5Kzt51FlB3
 w1yAflYz0ICBGX3upadZlsBXvu1aRMmxOCzSLHPZYss2G0V4O2B7ESmEO3vtegVYkAKW
 tSKEpqMzverpHSnG3I+axEeI7kQum6AfY8LA3KuUKxqL3srA0wFn9Z1ou/8PeWVKM40a
 a1yA==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Juergen Gross <jgross@suse.com>, David Zhou <David1.Zhou@amd.com>,
 Ralph Campbell <rcampbell@nvidia.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 John Hubbard <jhubbard@nvidia.com>,
 "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
 Mike Marciniszyn <mike.marciniszyn@intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Christoph Hellwig <hch@infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Jerome Glisse <jglisse@redhat.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Dennis Dalessandro <dennis.dalessandro@intel.com>,
 Petr Cvek <petrcvekcz@gmail.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107203629.f_3u0vTa0q-1JhqSj2cq6EmOTcURrv9ShLlqDx4GMLs@z>

T24gVHVlLCBOb3YgMDUsIDIwMTkgYXQgMTA6MTY6NDZBTSAtMDUwMCwgQm9yaXMgT3N0cm92c2t5
IHdyb3RlOgoKPiA+IFNvLCBJIHN1cHBvc2UgaXQgY2FuIGJlIHJlbGF4ZWQgdG8gYSBudWxsIHRl
c3QgYW5kIGEgV0FSTl9PTiB0aGF0IGl0Cj4gPiBoYXNuJ3QgY2hhbmdlZD8KPiAKPiBZb3UgbWVh
bgo+IAo+IGlmICh1c2VfcHRlbW9kKSB7Cj4gwqDCoMKgwqDCoMKgwqAgV0FSTl9PTihtYXAtPnZt
YSAhPSB2bWEpOwo+IMKgwqDCoMKgwqDCoMKgIC4uLgo+IAo+IAo+IFllcywgdGhhdCBzb3VuZHMg
Z29vZC4KCkkgYW1lbmRlZCBteSBjb3B5IG9mIHRoZSBwYXRjaCB3aXRoIHRoZSBhYm92ZSwgaGFz
IHRoaXMgcmV3b3JrIHNob3duCnNpZ25zIG9mIHdvcmtpbmc/CgpAQCAtNDM2LDcgKzQzNiw4IEBA
IHN0YXRpYyB2b2lkIGdudGRldl92bWFfY2xvc2Uoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEp
CiAgICAgICAgc3RydWN0IGdudGRldl9wcml2ICpwcml2ID0gZmlsZS0+cHJpdmF0ZV9kYXRhOwog
CiAgICAgICAgcHJfZGVidWcoImdudGRldl92bWFfY2xvc2UgJXBcbiIsIHZtYSk7Ci0gICAgICAg
aWYgKHVzZV9wdGVtb2QgJiYgbWFwLT52bWEgPT0gdm1hKSB7CisgICAgICAgaWYgKHVzZV9wdGVt
b2QpIHsKKyAgICAgICAgICAgICAgIFdBUk5fT04obWFwLT52bWEgIT0gdm1hKTsKICAgICAgICAg
ICAgICAgIG1tdV9yYW5nZV9ub3RpZmllcl9yZW1vdmUoJm1hcC0+bm90aWZpZXIpOwogICAgICAg
ICAgICAgICAgbWFwLT52bWEgPSBOVUxMOwogICAgICAgIH0KCkphc29uCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
