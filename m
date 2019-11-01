Return-Path: <SRS0=roBy=Y2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3283BCA9ED0
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Nov 2019 15:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 135DB20663
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Nov 2019 15:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135DB20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1E936E4B7;
	Sat,  2 Nov 2019 15:44:02 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A98706E314
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2019 19:54:08 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id h2so1210007qto.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Nov 2019 12:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=z+FjZERGJpTwj4Fyw0MaJE9Sqa2BYsQ42uoE0CYrL0A=;
 b=deVcFgvNx/zxP1pslhpwMl+GLLFjKJbqR766qTCWoNQiSLFmP/3LL8vpeZagGyjKNu
 W9HBS+i1wkoEESn/orS4RdLDpk3iGGnfAOACt6ho0kw862qqD5V9+BWHynPniry93MSg
 vqS6G2ImJZuEYx83ZtvaPU+8WXNPgDRMQ0bpNFkrr7gourkWpbsVHDo0q8Yi4vo+tkPl
 hxToDDeMgTdubGjj3piqCPo5x0JWrFwKlQOMW5Wm0x1ws/y8XAS8dDweKX369lQXf9jc
 +haxFl4+WMmCEgVPw2qJAw+GcJ93gi+ylKJj73Cq0nD7H2aP3pRmdFd2zilTAbMSJsLh
 Kcxg==
X-Gm-Message-State: APjAAAU8hS7pkre88uyYbjwVDFakU5BeyDuWsVv8yhLpJcRfjjYmWhFH
 F7/dsN9E6xSOcL/xPr5t+uNalA==
X-Google-Smtp-Source: APXvYqwugaF2JaYgADF6rOYRryDEd9+U+cO7L5fZ9F8hMoRL3wZJoN0ghN8hXeUNkkXowjkn9kbsRA==
X-Received: by 2002:a0c:fdcc:: with SMTP id g12mr11930964qvs.104.1572638047703; 
 Fri, 01 Nov 2019 12:54:07 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.180])
 by smtp.gmail.com with ESMTPSA id a18sm4727748qkc.2.2019.11.01.12.54.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Nov 2019 12:54:07 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1iQczm-00025n-Ng; Fri, 01 Nov 2019 16:54:06 -0300
Date: Fri, 1 Nov 2019 16:54:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>,
 Ralph Campbell <rcampbell@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Subject: Re: [PATCH v2 00/15] Consolidate the mmu notifier interval_tree and
 locking
Message-ID: <20191101195406.GA6732@ziepe.ca>
References: <20191028201032.6352-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191028201032.6352-1-jgg@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Sat, 02 Nov 2019 15:44:01 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=z+FjZERGJpTwj4Fyw0MaJE9Sqa2BYsQ42uoE0CYrL0A=;
 b=YeDYRdeeYeznofBfYHEGTgJUYYibnJM0tHbeYYbzhUa89eqWcwDFuoBvkqzuDcLc2T
 ofUfxex6y2BB77lEIINYfCe3LRDUm2ccatiS5G5es+IEQBkayJMlTpCysQ5WVX1USGCS
 jgTaU5H2sKmYyCCp5OAsj9y1/GibOpmNaDDE7+kpDMj1ch/KbEMGdmr4C8OACqF5MRIR
 AUJyBIqsDG9vpkYNm8vhMLDcsm1loVPhr52oeBb6m4QlAeB/pAlZ5GeOmXDE0INv1FyD
 pucRz+47DC7NbtxxhTdRuHewQn65NgI1RX8osOjLNPQ54S6sL1WB7AFJyClzypTR7d0s
 bh6w==
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
 Mike Marciniszyn <mike.marciniszyn@intel.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 linux-rdma@vger.kernel.org, nouveau@lists.freedesktop.org,
 Dennis Dalessandro <dennis.dalessandro@intel.com>,
 amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Petr Cvek <petrcvekcz@gmail.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191101195406.vsSF84l3XCB0qH3ZaOyuO0wgW80WiHUfACBHrWWEano@z>

T24gTW9uLCBPY3QgMjgsIDIwMTkgYXQgMDU6MTA6MTdQTSAtMDMwMCwgSmFzb24gR3VudGhvcnBl
IHdyb3RlOgo+IEZyb206IEphc29uIEd1bnRob3JwZSA8amdnQG1lbGxhbm94LmNvbT4KPiAKPiA4
IG9mIHRoZSBtbXVfbm90aWZpZXIgdXNpbmcgZHJpdmVycyAoaTkxNV9nZW0sIHJhZGVvbl9tbiwg
dW1lbV9vZHAsIGhmaTEsCj4gc2NpZl9kbWEsIHZob3N0LCBnbnRkZXYsIGhtbSkgZHJpdmVycyBh
cmUgdXNpbmcgYSBjb21tb24gcGF0dGVybiB3aGVyZQo+IHRoZXkgb25seSB1c2UgaW52YWxpZGF0
ZV9yYW5nZV9zdGFydC9lbmQgYW5kIGltbWVkaWF0ZWx5IGNoZWNrIHRoZQo+IGludmFsaWRhdGlu
ZyByYW5nZSBhZ2FpbnN0IHNvbWUgZHJpdmVyIGRhdGEgc3RydWN0dXJlIHRvIHRlbGwgaWYgdGhl
Cj4gZHJpdmVyIGlzIGludGVyZXN0ZWQuIEhhbGYgb2YgdGhlbSB1c2UgYW4gaW50ZXJ2YWxfdHJl
ZSwgdGhlIG90aGVycyBhcmUKPiBzaW1wbGUgbGluZWFyIHNlYXJjaCBsaXN0cy4KCk5vdyB0aGF0
IHdlIGhhdmUgdGhlIG1vc3Qgb2YgdGhlIGRyaXZlciBjaGFuZ2VzIHRlc3RlZCBhbmQgcmV2aWV3
ZWQKSSdtIGdvaW5nIHRvIG1vdmUgdGhpcyBzZXJpZXMgaW50byBsaW51eC1uZXh0IHZpYSB0aGUg
aG1tIHRyZWUsIG1pbnVzCnRoZSB4ZW4gZ250ZGV2IHBhdGNoZXMgYXMgdGhleSBhcmUgbm90IHdv
cmtpbmcgeWV0LgoKSSB3aWxsIGtlZXAgY29sbGVjdGluZyBhY2tzIGFuZCBhbnkgYWRkaXRpb25h
bCBjaGFuZ2VzLgoKVGhhbmtzLApKYXNvbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZng=
