Return-Path: <SRS0=+G2B=YQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31015CA9EB6
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2019 09:09:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1117820659
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2019 09:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1117820659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37EAD6E9FF;
	Wed, 23 Oct 2019 09:09:04 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2C446E9FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2019 09:09:02 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id e11so12465743wrv.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2019 02:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to:user-agent;
 bh=I3CdxrHaNyHyRZEG1FuNTtm7TdLvAqPyeGgl25NH314=;
 b=hZdnTdFuIZlXrOdO4abfxh2dk1QkiwdhP1YC9SCeoocj7OaE60Xnq4f3pooRfqZzl0
 YmRIbDxcbKt2A5DFaVwiI9SAu2JGn+LO/pLPt+a9qw14M0T/nGV4GsBZHq0+U4v/boAc
 VIp1uzbTHGg5m+ArDh8mMrPjlgzzmlBNmvAHRhgMohtWGNZQ3U8a/fgghircXqzHJcSD
 joN/ZzZylAJrgeor1HJ2ZPgRDCq8cjNI1704cAaqJM5LJGBF8b3uRune3oq4iCvKUxZe
 tARZmlJeLG81RY/hVsW/Kl0IYhFh8hqR+yiWUTifCdHOsBXmoWjNfQdtYkA8P4waM3VQ
 F55A==
X-Gm-Message-State: APjAAAWAbAfJRs+6mCSqD5OuYbZao0KARFBInRwUIB1ClbKBMoiNRIJ+
 nkUP9y3VxH7jUZHGBcsOG3+q2w==
X-Google-Smtp-Source: APXvYqxBlWiMbV68z/4WCdyBIn/eYixlaxzfRL2TT2uj5JcOqKaRJpFzViyC4G1k4Zqgafht+vBoZw==
X-Received: by 2002:adf:f192:: with SMTP id h18mr7782727wro.148.1571821741491; 
 Wed, 23 Oct 2019 02:09:01 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net.
 [212.51.149.96])
 by smtp.gmail.com with ESMTPSA id a189sm7456296wma.2.2019.10.23.02.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 02:09:00 -0700 (PDT)
Date: Wed, 23 Oct 2019 11:08:58 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH hmm 00/15] Consolidate the mmu notifier interval_tree and
 locking
Message-ID: <20191023090858.GV11828@phenom.ffwll.local>
Mail-Followup-To: Jason Gunthorpe <jgg@mellanox.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 "Yang, Philip" <Philip.Yang@amd.com>,
 Ralph Campbell <rcampbell@nvidia.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 John Hubbard <jhubbard@nvidia.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Jerome Glisse <jglisse@redhat.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Ben Skeggs <bskeggs@redhat.com>
References: <2df298e2-ee91-ef40-5da9-2bc1af3a17be@gmail.com>
 <2046e0b4-ba05-0683-5804-e9bbf903658d@amd.com>
 <d6bcbd2a-2519-8945-eaf5-4f4e738c7fa9@amd.com>
 <20191018203608.GA5670@mellanox.com>
 <f7e34d8f-f3b0-b86d-7388-1f791674a4a9@amd.com>
 <20191021135744.GA25164@mellanox.com>
 <e07092c3-8ccd-9814-835c-6c462017aff8@amd.com>
 <20191021151221.GC25164@mellanox.com>
 <20191022075735.GV11828@phenom.ffwll.local>
 <20191022150109.GF22766@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191022150109.GF22766@mellanox.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google;
 h=sender:date:from:to:cc:subject:message-id:mail-followup-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=I3CdxrHaNyHyRZEG1FuNTtm7TdLvAqPyeGgl25NH314=;
 b=MOj/ylauwCVvu9XlWustyHzaSLBCLB0r8SxcpbGt/WNTTA+W3Eilry/hQ3LwrBxwyx
 gPOiRymXCK2dsCqO5dOhpdZklU2lV9U4UJv9kLSbljZH7tQDvZUYhNl9OO0bjpWmAYUq
 m7WRQS+woMs4MAqmlMSC3ZrjaNArF8FIbkVWU=
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, "Yang,
 Philip" <Philip.Yang@amd.com>, Ralph Campbell <rcampbell@nvidia.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 John Hubbard <jhubbard@nvidia.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Jerome Glisse <jglisse@redhat.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191023090858.ToT_mvdfLr21IO6xv8JX1NaFbhkNXeIg30ywxPNXiIo@z>

T24gVHVlLCBPY3QgMjIsIDIwMTkgYXQgMDM6MDE6MTNQTSArMDAwMCwgSmFzb24gR3VudGhvcnBl
IHdyb3RlOgo+IE9uIFR1ZSwgT2N0IDIyLCAyMDE5IGF0IDA5OjU3OjM1QU0gKzAyMDAsIERhbmll
bCBWZXR0ZXIgd3JvdGU6Cj4gCj4gPiA+IFRoZSB1bnVzdWFsIGJpdCBpbiBhbGwgb2YgdGhpcyBp
cyB1c2luZyBhIGxvY2sncyBjcml0aWNhbCByZWdpb24gdG8KPiA+ID4gJ3Byb3RlY3QnIGRhdGEg
Zm9yIHJlYWQsIGJ1dCB1cGRhdGluZyB0aGF0IHNhbWUgZGF0YSBiZWZvcmUgdGhlIGxvY2sncwo+
ID4gPiBjcml0aWNhbCBzZWNpb24uIGllIHJlbHlpbmcgb24gdGhlIHVubG9jayBiYXJyaWVyIHRv
ICdyZWxlYXNlJyBwcm9ncmFtCj4gPiA+IG9yZGVyZWQgc3RvcmVzIGRvbmUgYmVmb3JlIHRoZSBs
b2NrJ3Mgb3duIGNyaXRpY2FsIHJlZ2lvbiwgYW5kIHRoZQo+ID4gPiBsb2NrIHNpZGUgYmFycmll
ciB0byAnYWNxdWlyZScgdGhvc2Ugc3RvcmVzLgo+ID4gCj4gPiBJIHRoaW5rIHRoaXMgdW51c3Vh
bCB1c2Ugb2YgbG9ja3MgYXMgYmFycmllcnMgZm9yIG90aGVyIHVubG9ja2VkIGFjY2Vzc2VzCj4g
PiBkZXNlcnZlcyBjb21tZW50cyBldmVuIG1vcmUgdGhhbiBqdXN0IG5vcm1hbCBiYXJyaWVycy4g
Q2FuIHlvdSBwbHMgYWRkCj4gPiB0aGVtPyBJIHRoaW5rIHRoZSBkZXNpZ24gc2VlZW1zIHNvdW5k
IC4uLgo+ID4gCj4gPiBBbHNvIHRoZSBjb21tZW50IG9uIHRoZSBkcml2ZXIncyBsb2NrIGhvcGVm
dWxseSBwcmV2ZW50cyBkcml2ZXIKPiA+IG1haW50YWluZXJzIGZyb20gbW92aW5nIHRoZSBkcml2
ZXJfbG9jayBhcm91bmQgaW4gYSB3YXkgdGhhdCB3b3VsZCB2ZXJ5Cj4gPiBzdWJ0bGUgYnJlYWsg
dGhlIHNjaGVtZSwgc28gSSB0aGluayBoYXZpbmcgdGhlIGFjcXVpcmUgYmFycmllciBjb21tZW50
ZWQKPiA+IGluIGVhY2ggcGxhY2Ugd291bGQgYmUgcmVhbGx5IGdvb2QuCj4gCj4gVGhlcmUgaXMg
YWxyZWFkeSBhIGxvdCBvZiBkb2N1bWVudGF0aW9uLCBJIHRoaW5rIGl0IHdvdWxkIGJlIGhlbHBm
dWwKPiBpZiB5b3UgY291bGQgc3VnZ2VzdCBzb21lIHNwZWNpZmljIHBsYWNlcyB3aGVyZSB5b3Ug
dGhpbmsgYW4gYWRkaXRpb24KPiB3b3VsZCBoZWxwPyBJIHRoaW5rIHRoZSBwZXJzcGVjdGl2ZSBv
ZiBzb21lb25lIGxlc3MgZmFtaWxpYXIgd2l0aCB0aGlzCj4gZGVzaWduIHdvdWxkIHJlYWxseSBp
bXByb3ZlIHRoZSBkb2N1bWVudGF0aW9uCgpIbSBJIGp1c3QgbWVhbnQgdGhlIHVzdWFsIHJlY29t
bWVuZGF0aW9uIHRoYXQgImJhcnJpZXJzIG11c3QgaGF2ZSBjb21tZW50cwpleHBsYWluaW5nIHdo
YXQgdGhleSBvcmRlciwgYW5kIHdoZXJlIHRoZSBvdGhlciBzaWRlIG9mIHRoZSBiYXJyaWVyIGlz
Ii4KVXNpbmcgdW5sb2NrL2xvY2sgYXMgYSBiYXJyaWVyIGltbyBqdXN0IG1ha2VzIHRoYXQgYW4g
ZXZlbiBiZXR0ZXIgaWRlYS4KVXN1YWxseSB3aGF0IEkgZG8gaXMgc29tZXRoaW5nIGxpa2UgIndl
IG5lZWQgdG8gb3JkZXIgJHRoaXMgYWdhaW5zdCAkdGhhdApiZWxvdywgYW5kIHRoZSBvdGhlciBz
aWRlIG9mIHRoaXMgYmFycmllciBpcyBpbiBmdW5jdGlvbigpLiIgV2l0aCBtYXliZSBhCmJpdCBt
b3JlIGlmIGl0J3Mgbm90IG9idmlvdXMgaG93IHRoaW5ncyBnbyB3cm9uZyBpZiB0aGUgb3JkZXJp
biBpcyBicm9rZW4uCgpPZmMgc2VxbG9jay5oIGl0c2VsZiBza2ltcHMgb24gdGhhdCBydWxlIGFu
ZCBkb2Vzbid0IGJvdGhlciBleHBsYWluaW5nIGl0cwpiYXJyaWVycyA6LS8KCj4gSSd2ZSBiZWVu
IHRlbXB0ZWQgdG8gZm9yY2UgdGhlIGRyaXZlciB0byBzdG9yZSB0aGUgc2VxIG51bWJlciBkaXJl
Y3RseQo+IHVuZGVyIHRoZSBkcml2ZXIgbG9jayAtIHRoaXMgbWFrZXMgdGhlIHNjaGVtZSBtdWNo
IGNsZWFyZXIsIGllCj4gc29tZXRoaW5nIGxpa2UgdGhpczoKPiAKPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL25vdXZlYXUvbm91dmVhdV9zdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9ub3V2
ZWF1L25vdXZlYXVfc3ZtLmMKPiBpbmRleCA3MTJjOTk5MTg1NTFiYy4uNzM4ZmE2NzBkY2ZiMTkg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL25vdXZlYXUvbm91dmVhdV9zdm0uYwo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L25vdXZlYXVfc3ZtLmMKPiBAQCAtNDg4LDcgKzQ4
OCw4IEBAIHN0cnVjdCBzdm1fbm90aWZpZXIgewo+ICB9Owo+ICAKPiAgc3RhdGljIGJvb2wgbm91
dmVhdV9zdm1fcmFuZ2VfaW52YWxpZGF0ZShzdHJ1Y3QgbW11X3JhbmdlX25vdGlmaWVyICptcm4s
Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3Qg
bW11X25vdGlmaWVyX3JhbmdlICpyYW5nZSkKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCBtbXVfbm90aWZpZXJfcmFuZ2UgKnJhbmdlLAo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBzZXEp
Cj4gIHsKPiAgICAgICAgIHN0cnVjdCBzdm1fbm90aWZpZXIgKnNuID0KPiAgICAgICAgICAgICAg
ICAgY29udGFpbmVyX29mKG1ybiwgc3RydWN0IHN2bV9ub3RpZmllciwgbm90aWZpZXIpOwo+IEBA
IC01MDQsNiArNTA1LDcgQEAgc3RhdGljIGJvb2wgbm91dmVhdV9zdm1fcmFuZ2VfaW52YWxpZGF0
ZShzdHJ1Y3QgbW11X3JhbmdlX25vdGlmaWVyICptcm4sCj4gICAgICAgICAgICAgICAgIG11dGV4
X2xvY2soJnNuLT5zdm1tLT5tdXRleCk7Cj4gICAgICAgICBlbHNlIGlmICghbXV0ZXhfdHJ5bG9j
aygmc24tPnN2bW0tPm11dGV4KSkKPiAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOwo+ICsg
ICAgICAgbW11X3JhbmdlX25vdGlmaWVyX3VwZGF0ZV9zZXEobXJuLCBzZXEpOwo+ICAgICAgICAg
bXV0ZXhfdW5sb2NrKCZzbi0+c3ZtbS0+bXV0ZXgpOwo+ICAgICAgICAgcmV0dXJuIHRydWU7Cj4g
IH0KPiAKPiAKPiBBdCB0aGUgY29zdCBvZiBtYWtpbmcgdGhlIGRyaXZlciBhIGJpdCBtb3JlIGNv
bXBsZXgsIHdoYXQgZG8geW91Cj4gdGhpbms/CgpIbSwgc3Bpbm5pbmcgdGhpcyBmdXJ0aGVyIC4u
LiBjb3VsZCB3ZSBpbml0aWFsaXplIHRoZSBtbXUgcmFuZ2Ugbm90aWZpZXIKd2l0aCBhIHBvaW50
ZXIgdG8gdGhlIGRyaXZlciBsb2NrLCBzbyB0aGF0IHdlIGNvdWxkIHB1dCBhCmxvY2tkZXBfYXNz
ZXJ0X2hlbGQgaW50byBtbXVfcmFuZ2Vfbm90aWZpZXJfdXBkYXRlX3NlcT8gSSB0aGluayB0aGF0
IHdvdWxkCm1ha2UgdGhpcyBzY2hlbWUgc3Vic3RhbnRpYWxseSBtb3JlIGRyaXZlci1oYWNrZXIg
cHJvb2YgOi0pCgpDaGVlcnMsIERhbmllbAotLSAKRGFuaWVsIFZldHRlcgpTb2Z0d2FyZSBFbmdp
bmVlciwgSW50ZWwgQ29ycG9yYXRpb24KaHR0cDovL2Jsb2cuZmZ3bGwuY2gKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
