Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4356EC5DF61
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 13:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22FDD214D8
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 13:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22FDD214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3A166EA7D;
	Thu,  7 Nov 2019 13:54:18 +0000 (UTC)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66EDC6F3CA;
 Thu,  7 Nov 2019 09:39:10 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 798AAB1B8;
 Thu,  7 Nov 2019 09:39:08 +0000 (UTC)
Subject: Re: [PATCH v2 08/15] xen/gntdev: Use select for DMA_SHARED_BUFFER
To: Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
 Jerome Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-9-jgg@ziepe.ca>
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <8d2f67a8-7f71-9add-b130-f06b6c9227cb@suse.com>
Date: Thu, 7 Nov 2019 10:39:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191028201032.6352-9-jgg@ziepe.ca>
Content-Language: en-US
X-Mailman-Approved-At: Thu, 07 Nov 2019 13:54:18 +0000
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
Cc: David Zhou <David1.Zhou@amd.com>,
 Mike Marciniszyn <mike.marciniszyn@intel.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 linux-rdma@vger.kernel.org, nouveau@lists.freedesktop.org,
 Dennis Dalessandro <dennis.dalessandro@intel.com>,
 amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@mellanox.com>, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, xen-devel@lists.xenproject.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Petr Cvek <petrcvekcz@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Ben Skeggs <bskeggs@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107093906.O13BOsvNIcDtR0BAn-LQpZeknoH64B17rgt8QWdwyEc@z>

T24gMjguMTAuMTkgMjE6MTAsIEphc29uIEd1bnRob3JwZSB3cm90ZToKPiBGcm9tOiBKYXNvbiBH
dW50aG9ycGUgPGpnZ0BtZWxsYW5veC5jb20+Cj4gCj4gRE1BX1NIQVJFRF9CVUZGRVIgY2FuIG5v
dCBiZSBlbmFibGVkIGJ5IHRoZSB1c2VyIChpdCByZXByZXNlbnRzIGEgbGlicmFyeQo+IHNldCBp
biB0aGUga2VybmVsKS4gVGhlIGtjb25maWcgY29udmVudGlvbiBpcyB0byB1c2Ugc2VsZWN0IGZv
ciBzdWNoCj4gc3ltYm9scyBzbyB0aGV5IGFyZSB0dXJuZWQgb24gaW1wbGljaXRseSB3aGVuIHRo
ZSB1c2VyIGVuYWJsZXMgYSBrY29uZmlnCj4gdGhhdCBuZWVkcyB0aGVtLgo+IAo+IE90aGVyd2lz
ZSB0aGUgWEVOX0dOVERFVl9ETUFCVUYga2NvbmZpZyBpcyBvdmVybHkgZGlmZmljdWx0IHRvIGVu
YWJsZS4KPiAKPiBGaXhlczogOTMyZDY1NjIxNzllICgieGVuL2dudGRldjogQWRkIGluaXRpYWwg
c3VwcG9ydCBmb3IgZG1hLWJ1ZiBVQVBJIikKPiBDYzogT2xla3NhbmRyIEFuZHJ1c2hjaGVua28g
PG9sZWtzYW5kcl9hbmRydXNoY2hlbmtvQGVwYW0uY29tPgo+IENjOiBCb3JpcyBPc3Ryb3Zza3kg
PGJvcmlzLm9zdHJvdnNreUBvcmFjbGUuY29tPgo+IENjOiB4ZW4tZGV2ZWxAbGlzdHMueGVucHJv
amVjdC5vcmcKPiBDYzogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPgo+IENjOiBTdGVm
YW5vIFN0YWJlbGxpbmkgPHNzdGFiZWxsaW5pQGtlcm5lbC5vcmc+Cj4gUmV2aWV3ZWQtYnk6IEp1
ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4KPiBSZXZpZXdlZC1ieTogT2xla3NhbmRyIEFu
ZHJ1c2hjaGVua28gPG9sZWtzYW5kcl9hbmRydXNoY2hlbmtvQGVwYW0uY29tPgo+IFNpZ25lZC1v
ZmYtYnk6IEphc29uIEd1bnRob3JwZSA8amdnQG1lbGxhbm94LmNvbT4KCkFwcGxpZWQgdG8geGVu
L3RpcC5naXQgZm9yLWxpbnVzLTUuNWEKCgpKdWVyZ2VuCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
