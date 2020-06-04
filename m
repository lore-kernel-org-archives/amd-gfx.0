Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24A9C433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 09:27:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F0FE20738
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 09:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F0FE20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C149F6E13A;
	Thu,  4 Jun 2020 09:27:32 +0000 (UTC)
Received: from fireflyinternet.com (mail.fireflyinternet.com [109.228.58.192])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4545C6E0D8;
 Thu,  4 Jun 2020 09:27:31 +0000 (UTC)
X-Default-Received-SPF: pass (skip=forwardok (res=PASS))
 x-ip-name=78.156.65.138; 
Received: from localhost (unverified [78.156.65.138]) 
 by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id
 21392771-1500050 for multiple; Thu, 04 Jun 2020 10:27:01 +0100
MIME-Version: 1.0
In-Reply-To: <CAKMK7uGLAPvvgHCCZhg0cea3Fz=Zqhf-GKS2OC3mZudYe3mKhw@mail.gmail.com>
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-4-daniel.vetter@ffwll.ch>
 <edbfc1aa-9297-8202-cef8-1facafaa0dfe@shipmail.org>
 <CAKMK7uGLAPvvgHCCZhg0cea3Fz=Zqhf-GKS2OC3mZudYe3mKhw@mail.gmail.com>
From: Chris Wilson <chris@chris-wilson.co.uk>
To: Thomas Hellström (Intel) <thomas_os@shipmail.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH 03/18] dma-fence: basic lockdep annotations
Message-ID: <159126281827.25109.3992161193069793005@build.alporthouse.com>
User-Agent: alot/0.8.1
Date: Thu, 04 Jun 2020 10:26:58 +0100
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
Cc: linux-rdma <linux-rdma@vger.kernel.org>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, Thomas Hellstrom <thomas.hellstrom@intel.com>, DRI Development <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel.vetter@intel.com>, Mika Kuoppala <mika.kuoppala@intel.com>, Christian König <christian.koenig@amd.com>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UXVvdGluZyBEYW5pZWwgVmV0dGVyICgyMDIwLTA2LTA0IDEwOjIxOjQ2KQo+IE9uIFRodSwgSnVu
IDQsIDIwMjAgYXQgMTA6NTcgQU0gVGhvbWFzIEhlbGxzdHLDtm0gKEludGVsKQo+IDx0aG9tYXNf
b3NAc2hpcG1haWwub3JnPiB3cm90ZToKPiA+Cj4gPgo+ID4gT24gNi80LzIwIDEwOjEyIEFNLCBE
YW5pZWwgVmV0dGVyIHdyb3RlOgo+ID4gLi4uCj4gPiA+IFRocmVhZCBBOgo+ID4gPgo+ID4gPiAg
ICAgICBtdXRleF9sb2NrKEEpOwo+ID4gPiAgICAgICBtdXRleF91bmxvY2soQSk7Cj4gPiA+Cj4g
PiA+ICAgICAgIGRtYV9mZW5jZV9zaWduYWwoKTsKPiA+ID4KPiA+ID4gVGhyZWFkIEI6Cj4gPiA+
Cj4gPiA+ICAgICAgIG11dGV4X2xvY2soQSk7Cj4gPiA+ICAgICAgIGRtYV9mZW5jZV93YWl0KCk7
Cj4gPiA+ICAgICAgIG11dGV4X3VubG9jayhBKTsKPiA+ID4KPiA+ID4gVGhyZWFkIEIgaXMgYmxv
Y2tlZCBvbiBBIHNpZ25hbGxpbmcgdGhlIGZlbmNlLCBidXQgQSBuZXZlciBnZXRzIGFyb3VuZAo+
ID4gPiB0byB0aGF0IGJlY2F1c2UgaXQgY2Fubm90IGFjcXVpcmUgdGhlIGxvY2sgQS4KPiA+ID4K
PiA+ID4gTm90ZSB0aGF0IGRtYV9mZW5jZV93YWl0KCkgaXMgYWxsb3dlZCB0byBiZSBuZXN0ZWQg
d2l0aGluCj4gPiA+IGRtYV9mZW5jZV9iZWdpbi9lbmRfc2lnbmFsbGluZyBzZWN0aW9ucy4gVG8g
YWxsb3cgdGhpcyB0byBoYXBwZW4gdGhlCj4gPiA+IHJlYWQgbG9jayBuZWVkcyB0byBiZSB1cGdy
YWRlZCB0byBhIHdyaXRlIGxvY2ssIHdoaWNoIG1lYW5zIHRoYXQgYW55Cj4gPiA+IG90aGVyIGxv
Y2sgaXMgYWNxdWlyZWQgYmV0d2VlbiB0aGUgZG1hX2ZlbmNlX2JlZ2luX3NpZ25hbGxpbmcoKSBj
YWxsIGFuZAo+ID4gPiB0aGUgY2FsbCB0byBkbWFfZmVuY2Vfd2FpdCgpLCBhbmQgc3RpbGwgaGVs
ZCwgdGhpcyB3aWxsIHJlc3VsdCBpbiBhbgo+ID4gPiBpbW1lZGlhdGUgbG9ja2RlcCBjb21wbGFp
bnQuIFRoZSBvbmx5IG90aGVyIG9wdGlvbiB3b3VsZCBiZSB0byBub3QKPiA+ID4gYW5ub3RhdGUg
c3VjaCBjYWxscywgZGVmZWF0aW5nIHRoZSBwb2ludC4gVGhlcmVmb3JlIHRoZXNlIGFubm90YXRp
b25zCj4gPiA+IGNhbm5vdCBiZSBzcHJpbmtsZWQgb3ZlciB0aGUgY29kZSBlbnRpcmVseSBtaW5k
bGVzcyB0byBhdm9pZCBmYWxzZQo+ID4gPiBwb3NpdGl2ZXMuCj4gPgo+ID4gSnVzdCByZWFsaXpl
ZCwgaXNuJ3QgdGhhdCBleGFtcGxlIGFjdHVhbGx5IGEgdHJ1ZSBwb3NpdGl2ZSwgb3IgYXQgbGVh
c3QKPiA+IGEgZ3JlYXQgY2FuZGlkYXRlIGZvciBhIHRydWUgcG9zaXRpdmUsIHNpbmNlIGlmIGFu
b3RoZXIgdGhyZWFkIHJlZW50ZXJzCj4gPiB0aGF0IHNpZ25hbGluZyBwYXRoLCBpdCB3aWxsIGJs
b2NrIG9uIHRoYXQgbXV0ZXgsIGFuZCB0aGUgZmVuY2Ugd291bGQKPiA+IG5ldmVyIGJlIHNpZ25h
bGVkIHVubGVzcyB0aGVyZSBpcyBhbm90aGVyIHNpZ25hbGluZyBwYXRoPwo+IAo+IE5vdCBzdXJl
IEkgdW5kZXJzdGFuZCBmdWxseSwgYnV0IEkgdGhpbmsgdGhlIGFuc3dlciBpcyAiaXQncyBjb21w
bGljYXRlZCIuCgpTZWUgY2Q4MDg0ZjkxYzAyICgibG9ja2luZy9sb2NrZGVwOiBBcHBseSBjcm9z
c3JlbGVhc2UgdG8gY29tcGxldGlvbnMiKQoKZG1hX2ZlbmNlIHVzYWdlIGhlcmUgaXMgbm90aGlu
ZyBidXQgYW5vdGhlciBuYW1lIGZvciBhIGNvbXBsZXRpb24uCi1DaHJpcwpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
