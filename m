Return-Path: <SRS0=5//3=ZA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9F2C5DF61
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 02:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE4CF222C4
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 02:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4CF222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14AA66F82B;
	Fri,  8 Nov 2019 02:00:55 +0000 (UTC)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C5396F82C
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2019 02:00:54 +0000 (UTC)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-qWlwQnQQOJmU_alVVJU2pA-1; Thu, 07 Nov 2019 21:00:43 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF2891800D7B;
 Fri,  8 Nov 2019 02:00:40 +0000 (UTC)
Received: from redhat.com (ovpn-122-19.rdu2.redhat.com [10.10.122.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E5B6B600D3;
 Fri,  8 Nov 2019 02:00:36 +0000 (UTC)
Date: Thu, 7 Nov 2019 21:00:34 -0500
From: Jerome Glisse <jglisse@redhat.com>
To: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH v2 02/15] mm/mmu_notifier: add an interval tree notifier
Message-ID: <20191108020034.GA470884@redhat.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-3-jgg@ziepe.ca>
 <35c2b322-004e-0e18-87e4-1920dc71bfd5@nvidia.com>
 <20191107020807.GA747656@redhat.com>
 <20191107201102.GC21728@mellanox.com>
 <20191107210408.GA4716@redhat.com>
 <20191108003219.GD21728@mellanox.com>
MIME-Version: 1.0
In-Reply-To: <20191108003219.GD21728@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: qWlwQnQQOJmU_alVVJU2pA-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1573178452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qmaB2CyqCtOYzlfv/kbgamUkAPvC2mHzu/cckynz8S8=;
 b=G4poe+r/wEa/NSI3+U0S5UlSzP+df7vM9qlOZYeRK0WOxB7kKfwnGpTCFfLPQJgl+kUchP
 tCjadp06C5KGcRAMFN5gC1np4W2oKJTguDVVwEpBkwOt2ul482h7OD2u2kNJf+8U65/Z24
 U8zFsJxJFR7YC3Qk9oH4+Z1n3JvCIbA=
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
Cc: "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Michal Hocko <mhocko@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Andrea Arcangeli <aarcange@redhat.com>, David Zhou <David1.Zhou@amd.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Christoph Hellwig <hch@infradead.org>, Ben Skeggs <bskeggs@redhat.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Petr Cvek <petrcvekcz@gmail.com>,
 Juergen Gross <jgross@suse.com>, Mike Marciniszyn <mike.marciniszyn@intel.com>,
 "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Dennis Dalessandro <dennis.dalessandro@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191108020034.MHUwM06GgoHyI7PmW9CbDexEMorT0TOcUXJ2gNYMZYk@z>

T24gRnJpLCBOb3YgMDgsIDIwMTkgYXQgMTI6MzI6MjVBTSArMDAwMCwgSmFzb24gR3VudGhvcnBl
IHdyb3RlOgo+IE9uIFRodSwgTm92IDA3LCAyMDE5IGF0IDA0OjA0OjA4UE0gLTA1MDAsIEplcm9t
ZSBHbGlzc2Ugd3JvdGU6Cj4gPiBPbiBUaHUsIE5vdiAwNywgMjAxOSBhdCAwODoxMTowNlBNICsw
MDAwLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6Cj4gPiA+IE9uIFdlZCwgTm92IDA2LCAyMDE5IGF0
IDA5OjA4OjA3UE0gLTA1MDAsIEplcm9tZSBHbGlzc2Ugd3JvdGU6Cj4gPiA+IAo+ID4gPiA+ID4g
Cj4gPiA+ID4gPiBFeHRyYSBjcmVkaXQ6IElNSE8sIHRoaXMgY2xlYXJseSBkZXNlcnZlcyB0byBh
bGwgYmUgaW4gYSBuZXcgbW11X3JhbmdlX25vdGlmaWVyLmgKPiA+ID4gPiA+IGhlYWRlciBmaWxl
LCBidXQgSSBrbm93IHRoYXQncyBleHRyYSB3b3JrLiBNYXliZSBsYXRlciBhcyBhIGZvbGxvdy11
cCBwYXRjaCwKPiA+ID4gPiA+IGlmIGFueW9uZSBoYXMgdGhlIHRpbWUuCj4gPiA+ID4gCj4gPiA+
ID4gVGhlIHJhbmdlIG5vdGlmaWVyIHNob3VsZCBnZXQgdGhlIGV2ZW50IHRvbywgaXQgd291bGQg
YmUgYSB3YXN0ZSwgaSB0aGluayBpdCBpcwo+ID4gPiA+IGFuIG92ZXJzaWdodCBoZXJlLiBUaGUg
cmVsZWFzZSBldmVudCBpcyBmaW5lIHNvIE5BSyB0byB5b3Ugc2VwYXJhdGUgZXZlbnQuIEV2ZW50
Cj4gPiA+ID4gaXMgcmVhbGx5IGFuIGhlbHBlciBmb3Igbm90aWZpZXIgaSBoYWQgYSBzZXQgb2Yg
cGF0Y2ggZm9yIG5vdXZlYXUgdG8gbGV2ZXJhZ2UKPiA+ID4gPiB0aGlzIGkgbmVlZCB0byByZXN1
Y2l0ZSB0aGVtLiBTbyBubyBuZWVkIHRvIHNwbGl0IHRoaW5nLCBpIHdvdWxkIGp1c3QgZm9yd2Fy
ZAo+ID4gPiA+IHRoZSBldmVudCBpZSBhZGQgZXZlbnQgdG8gbW11X3JhbmdlX25vdGlmaWVyX29w
cy5pbnZhbGlkYXRlKCkgaSBmYWlsZWQgdG8gY2F0Y2gKPiA+ID4gPiB0aGF0IGluIHYxIHNvcnJ5
Lgo+ID4gPiAKPiA+ID4gSSB0aGluayB3aGF0IHlvdSBtZWFuIGlzIGFscmVhZHkgZG9uZT8KPiA+
ID4gCj4gPiA+IHN0cnVjdCBtbXVfcmFuZ2Vfbm90aWZpZXJfb3BzIHsKPiA+ID4gCWJvb2wgKCpp
bnZhbGlkYXRlKShzdHJ1Y3QgbW11X3JhbmdlX25vdGlmaWVyICptcm4sCj4gPiA+IAkJCSAgIGNv
bnN0IHN0cnVjdCBtbXVfbm90aWZpZXJfcmFuZ2UgKnJhbmdlLAo+ID4gPiAJCQkgICB1bnNpZ25l
ZCBsb25nIGN1cl9zZXEpOwo+ID4gCj4gPiBZZXMgaXQgaXMgc29ycnksIGkgZ290IGNvbmZ1c2Ug
d2l0aCBtbXVfcmFuZ2Vfbm90aWZpZXIgYW5kIG1tdV9ub3RpZmllcl9yYW5nZSA6KQo+ID4gSXQg
aXMgYWxtb3N0IGEgcGFseW5kcm9tZSBzdHJ1Y3R1cmUgOykKPiAKPiBMZXRzIGNoYW5nZSB0aGUg
bmFtZSB0aGVuLCB0aGlzIGlzIGNsZWFybHkgbm90IHdvcmtpbmcuIEknbGwgcmVmbG93Cj4gZXZl
cnl0aGluZyB0b21vcnJvdwoKU2VtYW50aWMgcGF0Y2ggdG8gZG8gdGhhdCBydW4gZnJvbSB5b3Vy
IGxpbnV4IGtlcm5lbCBkaXJlY3Rvcnkgd2l0aCB5b3VyIHBhdGNoCmFwcGxpZWQgKHlvdSBjYW4g
cnVuIGl0IG9uZSBwYXRjaCBhZnRlciB0aGUgb3RoZXIgYW5kIHRoZSBnaXQgY29tbWl0IC1hIC0t
Zml4dXAgSEVBRCkKCnNwYXRjaCAtLXNwLWZpbGUgbmFtZS1vZi10aGUtZmlsZS1iZWxvdyAtLWRp
ciAuIC0tYWxsLWluY2x1ZGVzIC0taW4tcGxhY2UKCiU8IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpAQApAQApzdHJ1Y3QK
LW1tdV9yYW5nZV9ub3RpZmllcgorbW11X2ludGVydmFsX25vdGlmaWVyCgpAQApAQApzdHJ1Y3QK
LW1tdV9yYW5nZV9ub3RpZmllcgorbW11X2ludGVydmFsX25vdGlmaWVyCnsuLi59OwoKLy8gQ2hh
bmdlIG1ybiBuYW1lIHRvIG1tdV9pbgpAQApzdHJ1Y3QgbW11X2ludGVydmFsX25vdGlmaWVyICpt
cm47CkBACi1tcm4KK21tdV9pbgoKQEAKaWRlbnRpZmllciBmbjsKQEAKZm4oLi4uLCAKLXN0cnVj
dCBtbXVfaW50ZXJ2YWxfbm90aWZpZXIgKm1ybiwKK3N0cnVjdCBtbXVfaW50ZXJ2YWxfbm90aWZp
ZXIgKm1tdV9pbiwKLi4uKSB7Li4ufQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gPiUKCllvdSBuZWVkIGNvY2NpbmVsbGUg
KHdoaWNoIHByb3ZpZGVzIHNwYXRjaCkuIEl0IGlzIHVudGVzdGVkIGJ1dCBpdCBzaG91bGQgd29y
awphbHNvIGkgY291bGQgbm90IGNvbWUgdXAgd2l0aCBhIG5pY2UgbmFtZSB0byB1cGRhdGUgbXJu
IGFzIG1pbiBpcyB3YXkgdG9vCmNvbmZ1c2luZy4gSWYgeW91IGhhdmUgYmV0dGVyIG5hbWUgZmVl
bCBmcmVlIHRvIHVzZSBpdC4KCk9oIGFuZCBjb2NjaW5lbGxlIGlzIHByZXR0eSBjbGV2ZXIgYWJv
dXQgY29kZSBmb3JtYXRpbmcgc28gaXQgc2hvdWxkIGRvIGEgZ29vZApqb2JzIGF0IGtlZXBpbmcg
dGhpbmdzIG5pY2VseSBmb3JtYXRlZCBhbmQgYWxpZ24uCgpDaGVlcnMsCkrDqXLDtG1lCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
