Return-Path: <SRS0=ffWE=ZP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46287C432C0
	for <amd-gfx@archiver.kernel.org>; Sat, 23 Nov 2019 00:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F3620706
	for <amd-gfx@archiver.kernel.org>; Sat, 23 Nov 2019 00:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F3620706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 500F86F598;
	Sat, 23 Nov 2019 00:54:14 +0000 (UTC)
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com [216.228.121.143])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C8F26F595;
 Sat, 23 Nov 2019 00:54:12 +0000 (UTC)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5dd883360002>; Fri, 22 Nov 2019 16:54:14 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 22 Nov 2019 16:54:11 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 22 Nov 2019 16:54:11 -0800
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
 Sat, 23 Nov 2019 00:54:09 +0000
Subject: Re: [PATCH v3 02/14] mm/mmu_notifier: add an interval tree notifier
To: Jason Gunthorpe <jgg@mellanox.com>, Christoph Hellwig <hch@infradead.org>
References: <20191112202231.3856-1-jgg@ziepe.ca>
 <20191112202231.3856-3-jgg@ziepe.ca> <20191113135952.GB20531@infradead.org>
 <20191113164620.GG21728@mellanox.com>
X-Nvconfidentiality: public
From: Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <cc5d4d76-df30-af7f-931c-eed8a7ada122@nvidia.com>
Date: Fri, 22 Nov 2019 16:54:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191113164620.GG21728@mellanox.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nvidia.com; s=n1; 
 t=1574470455; bh=bqXekT37QvQAiJj5unYfuv1fXYv5e9H7W3TE2f93DwM=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=GMQ2nBly/CsGkp3ClF3KTIJ1E88XFlogU0CKPbHKGfneOIgU32/QzyXGWCpi3ck0H
 UKmUjmgchhEpox9obaO4j3qQTTw6eSQygxCGNnxcaBK+BVpFaWRZVbrcittwqkbErs
 WJejHNJfQFwe6vLEnMD7C7HfZFs1YXQJh9yBGuilTWYTnXvxIDNykws8BWZk+SAp+S
 d+PBZV9+4/p5SkfIZLXh92wH6ivVMDsbJ2ewuKYIY2bfdn7qLRuC5hVl19t8Vx8dG/
 mVxeh0/CSHrPHgSQLh5+W8xVMKh8hIouqwSbqQwT0va/zbM7kkP01A2Fu3LxQSm5r1
 PfohngEf3JGCQ==
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
 Stefano Stabellini <sstabellini@kernel.org>, Philip Yang <Philip.Yang@amd.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 John Hubbard <jhubbard@nvidia.com>,
 "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Jerome Glisse <jglisse@redhat.com>,
 Dennis Dalessandro <dennis.dalessandro@intel.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Petr Cvek <petrcvekcz@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Ben Skeggs <bskeggs@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191123005408.m21JXBkwF0Ruu9EFfaN3Fro9AUQ5HoAL4ltloBDaeLA@z>

Ck9uIDExLzEzLzE5IDg6NDYgQU0sIEphc29uIEd1bnRob3JwZSB3cm90ZToKPiBPbiBXZWQsIE5v
diAxMywgMjAxOSBhdCAwNTo1OTo1MkFNIC0wODAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToK
Pj4+ICtpbnQgbW11X2ludGVydmFsX25vdGlmaWVyX2luc2VydChzdHJ1Y3QgbW11X2ludGVydmFs
X25vdGlmaWVyICptbmksCj4+PiArCQkJCSAgICAgIHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCB1bnNp
Z25lZCBsb25nIHN0YXJ0LAo+Pj4gKwkJCQkgICAgICB1bnNpZ25lZCBsb25nIGxlbmd0aCwKPj4+
ICsJCQkJICAgICAgY29uc3Qgc3RydWN0IG1tdV9pbnRlcnZhbF9ub3RpZmllcl9vcHMgKm9wcyk7
Cj4+PiAraW50IG1tdV9pbnRlcnZhbF9ub3RpZmllcl9pbnNlcnRfbG9ja2VkKAo+Pj4gKwlzdHJ1
Y3QgbW11X2ludGVydmFsX25vdGlmaWVyICptbmksIHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLAo+Pj4g
Kwl1bnNpZ25lZCBsb25nIHN0YXJ0LCB1bnNpZ25lZCBsb25nIGxlbmd0aCwKPj4+ICsJY29uc3Qg
c3RydWN0IG1tdV9pbnRlcnZhbF9ub3RpZmllcl9vcHMgKm9wcyk7Cj4+Cj4+IFZlcnkgaW5jb25z
aXN0ZW50IGluZGVudGF0aW9uIGJldHdlZW4gdGhlc2UgdHdvIHJlbGF0ZWQgZnVuY3Rpb25zLgo+
IAo+IGNsYW5nLWZvcm1hdC4uIFRoZSBrZXJuZWwgY29uZmlnIGlzIHNldCB0byBwcmVmZXIgYSBs
aW5lIHVwIHVuZGVyIHRoZQo+ICggaWYgYWxsIHRoZSBhcmd1bWVudHMgd2lsbCBmaXQgd2l0aGlu
IHRoZSA4MCBjb2xzIG90aGVyd2lzZSBpdCBkb2VzIGEKPiAxIHRhYiBjb250aW51YXRpb24gaW5k
ZW50Lgo+IAo+Pj4gKwkvKgo+Pj4gKwkgKiBUaGUgaW52X2VuZCBpbmNvcnBvcmF0ZXMgYSBkZWZl
cnJlZCBtZWNoYW5pc20gbGlrZQo+Pj4gKwkgKiBydG5sX3VubG9jaygpLiBBZGRzIGFuZCByZW1v
dmVzIGFyZSBxdWV1ZWQgdW50aWwgdGhlIGZpbmFsIGludl9lbmQKPj4+ICsJICogaGFwcGVucyB0
aGVuIHRoZXkgYXJlIHByb2dyZXNzZWQuIFRoaXMgYXJyYW5nZW1lbnQgZm9yIHRyZWUgdXBkYXRl
cwo+Pj4gKwkgKiBpcyB1c2VkIHRvIGF2b2lkIHVzaW5nIGEgYmxvY2tpbmcgbG9jayBkdXJpbmcK
Pj4+ICsJICogaW52YWxpZGF0ZV9yYW5nZV9zdGFydC4KPj4KPj4gTml0cGljazogIFRoYXQgY29t
bWVudCBjYW4gYmUgY29uZGVuc2VkIGludG8gb25lIGxlc3MgbGluZToKPiAKPiBUaGUgcnRubF91
bmxvY2sgY2FuIG1vdmUgdXAgYSBsaW5lIHRvby4gTXkgZWRpdG9yIGlzIGZhaWxpbmcgbWUgb24K
PiB0aGlzLgo+IAo+Pj4gKwkvKgo+Pj4gKwkgKiBUT0RPOiBTaW5jZSB3ZSBhbHJlYWR5IGhhdmUg
YSBzcGlubG9jayBhYm92ZSwgdGhpcyB3b3VsZCBiZSBmYXN0ZXIKPj4+ICsJICogYXMgd2FrZV91
cF9xCj4+PiArCSAqLwo+Pj4gKwlpZiAobmVlZF93YWtlKQo+Pj4gKwkJd2FrZV91cF9hbGwoJm1t
bl9tbS0+d3EpOwo+Pgo+PiBTbyB3aHkgaXMgdGhpcyBpbXBvcnRhbnQgZW5vdWdoIGZvciBhIFRP
RE8gY29tbWVudCwgYnV0IG5vdCBpbXBvcnRhbnQKPj4gZW5vdWdoIHRvIGRvIHJpZ2h0IGF3YXk/
Cj4gCj4gTGV0cyBkcm9wIHRoZSBjb21tZW50LCBJJ20gbm90byBzdXJlIHdha2VfdXBfcSBpcyBl
dmVuIGEgZnVuY3Rpb24gdGhpcwo+IGxheWVyIHNob3VsZCBiZSBjYWxsaW5nLgoKQWN0dWFsbHks
IEkgdGhpbmsgeW91IGNhbiByZW1vdmUgdGhlICJuZWVkX3dha2UiIHZhcmlhYmxlIHNpbmNlIGl0
IGlzCnVuY29uZGl0aW9uYWxseSBzZXQgdG8gInRydWUiLgoKQWxzbywgdGhlIGNvbW1lbnQgaW5f
X21tdV9pbnRlcnZhbF9ub3RpZmllcl9pbnNlcnQoKSBzYXlzCiJtbmktPm1yX2ludmFsaWRhdGVf
c2VxIiBhbmQgSSB0aGluayB0aGF0IHNob3VsZCBiZQoibW5pLT5pbnZhbGlkYXRlX3NlcSIuCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
