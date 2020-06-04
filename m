Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E39CC433E1
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 09:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1511E206C3
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 09:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VXb0tquW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1511E206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD4B16E30C;
	Thu,  4 Jun 2020 09:36:38 +0000 (UTC)
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com
 [IPv6:2607:f8b0:4864:20::c44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 325036E2D8
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 09:36:37 +0000 (UTC)
Received: by mail-oo1-xc44.google.com with SMTP id v3so1123200oot.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Jun 2020 02:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Z9Gmt7c5N9Wuf1xRRCeQ6LGP+x2nsJ1lC3QXqc/8Dhc=;
 b=VXb0tquWgjUAVrjUQvBFkjElO+us0sp63/gsGT4muxVdIPXG+oOFyRdt5aJn92ZJCE
 JEx8kDimDYdhzsWhF2WmVH5MN3MfzCxv74ky6abUFQGxx1keKlESVewu1Qc/kd4r6C/w
 DTSeetaURTCVMFTRo+qfVX0P6p2YnA4RabcrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Z9Gmt7c5N9Wuf1xRRCeQ6LGP+x2nsJ1lC3QXqc/8Dhc=;
 b=Q5zr6IABP437NNd7pAdZDDfGem75cK7CAd+3F92dmRzLE9DErFWKm3EHfjuRFiRiIL
 QOx922MYJsiIkGrEds7hx/OZYFqiAIHiMagsrLIU7We4Uv2fKVE5D+cvt30bXsL7f+lx
 Vgu+jXR3TLpj4Sgc5U6HkbrNXdTZUaSxbMI5DHh+o74svaQ6+XOmKc0BQViW4bFxLwKw
 eI5MsprBjlhrlRS2mT1TeGl1vwlqNSH2qtCG/uygmCzBHm0G8gLzJhbzogIuTNvj1Rtw
 ELmqLgY+xmfmdS6ZHauVMqGwmB+HPV8OJwh4WwIO/rfmvYUqk6onwxjidFvUtGsMNMx2
 93DQ==
X-Gm-Message-State: AOAM531b+OFgOnYmuAJe6fhp77Cmx3BtaVC844mtWWlirm8Dga1lPWf9
 VRSOdRHzRmPRnIx0NvgcY0O17GTnahzT9NVmBbryvA==
X-Google-Smtp-Source: ABdhPJxAG9oiM1c1QpEnWLT/EWRbfMWy2gQklxD/IkomQ4LgpvxeJOMC+BW+nd+79+C1K6VQUmsFQCXuYgbPlpehCRs=
X-Received: by 2002:a4a:311d:: with SMTP id k29mr3016059ooa.89.1591263396299; 
 Thu, 04 Jun 2020 02:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-4-daniel.vetter@ffwll.ch>
 <edbfc1aa-9297-8202-cef8-1facafaa0dfe@shipmail.org>
 <CAKMK7uGLAPvvgHCCZhg0cea3Fz=Zqhf-GKS2OC3mZudYe3mKhw@mail.gmail.com>
 <159126281827.25109.3992161193069793005@build.alporthouse.com>
In-Reply-To: <159126281827.25109.3992161193069793005@build.alporthouse.com>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Thu, 4 Jun 2020 11:36:24 +0200
Message-ID: <CAKMK7uHOcH+rWhor7zzqqcjCUtxz_-5stLAOVD=4_ED+QjN8oQ@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH 03/18] dma-fence: basic lockdep annotations
To: Chris Wilson <chris@chris-wilson.co.uk>
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
Cc: linux-rdma <linux-rdma@vger.kernel.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Thomas Hellstrom <thomas.hellstrom@intel.com>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel.vetter@intel.com>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Mika Kuoppala <mika.kuoppala@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCBKdW4gNCwgMjAyMCBhdCAxMToyNyBBTSBDaHJpcyBXaWxzb24gPGNocmlzQGNocmlz
LXdpbHNvbi5jby51az4gd3JvdGU6Cj4KPiBRdW90aW5nIERhbmllbCBWZXR0ZXIgKDIwMjAtMDYt
MDQgMTA6MjE6NDYpCj4gPiBPbiBUaHUsIEp1biA0LCAyMDIwIGF0IDEwOjU3IEFNIFRob21hcyBI
ZWxsc3Ryw7ZtIChJbnRlbCkKPiA+IDx0aG9tYXNfb3NAc2hpcG1haWwub3JnPiB3cm90ZToKPiA+
ID4KPiA+ID4KPiA+ID4gT24gNi80LzIwIDEwOjEyIEFNLCBEYW5pZWwgVmV0dGVyIHdyb3RlOgo+
ID4gPiAuLi4KPiA+ID4gPiBUaHJlYWQgQToKPiA+ID4gPgo+ID4gPiA+ICAgICAgIG11dGV4X2xv
Y2soQSk7Cj4gPiA+ID4gICAgICAgbXV0ZXhfdW5sb2NrKEEpOwo+ID4gPiA+Cj4gPiA+ID4gICAg
ICAgZG1hX2ZlbmNlX3NpZ25hbCgpOwo+ID4gPiA+Cj4gPiA+ID4gVGhyZWFkIEI6Cj4gPiA+ID4K
PiA+ID4gPiAgICAgICBtdXRleF9sb2NrKEEpOwo+ID4gPiA+ICAgICAgIGRtYV9mZW5jZV93YWl0
KCk7Cj4gPiA+ID4gICAgICAgbXV0ZXhfdW5sb2NrKEEpOwo+ID4gPiA+Cj4gPiA+ID4gVGhyZWFk
IEIgaXMgYmxvY2tlZCBvbiBBIHNpZ25hbGxpbmcgdGhlIGZlbmNlLCBidXQgQSBuZXZlciBnZXRz
IGFyb3VuZAo+ID4gPiA+IHRvIHRoYXQgYmVjYXVzZSBpdCBjYW5ub3QgYWNxdWlyZSB0aGUgbG9j
ayBBLgo+ID4gPiA+Cj4gPiA+ID4gTm90ZSB0aGF0IGRtYV9mZW5jZV93YWl0KCkgaXMgYWxsb3dl
ZCB0byBiZSBuZXN0ZWQgd2l0aGluCj4gPiA+ID4gZG1hX2ZlbmNlX2JlZ2luL2VuZF9zaWduYWxs
aW5nIHNlY3Rpb25zLiBUbyBhbGxvdyB0aGlzIHRvIGhhcHBlbiB0aGUKPiA+ID4gPiByZWFkIGxv
Y2sgbmVlZHMgdG8gYmUgdXBncmFkZWQgdG8gYSB3cml0ZSBsb2NrLCB3aGljaCBtZWFucyB0aGF0
IGFueQo+ID4gPiA+IG90aGVyIGxvY2sgaXMgYWNxdWlyZWQgYmV0d2VlbiB0aGUgZG1hX2ZlbmNl
X2JlZ2luX3NpZ25hbGxpbmcoKSBjYWxsIGFuZAo+ID4gPiA+IHRoZSBjYWxsIHRvIGRtYV9mZW5j
ZV93YWl0KCksIGFuZCBzdGlsbCBoZWxkLCB0aGlzIHdpbGwgcmVzdWx0IGluIGFuCj4gPiA+ID4g
aW1tZWRpYXRlIGxvY2tkZXAgY29tcGxhaW50LiBUaGUgb25seSBvdGhlciBvcHRpb24gd291bGQg
YmUgdG8gbm90Cj4gPiA+ID4gYW5ub3RhdGUgc3VjaCBjYWxscywgZGVmZWF0aW5nIHRoZSBwb2lu
dC4gVGhlcmVmb3JlIHRoZXNlIGFubm90YXRpb25zCj4gPiA+ID4gY2Fubm90IGJlIHNwcmlua2xl
ZCBvdmVyIHRoZSBjb2RlIGVudGlyZWx5IG1pbmRsZXNzIHRvIGF2b2lkIGZhbHNlCj4gPiA+ID4g
cG9zaXRpdmVzLgo+ID4gPgo+ID4gPiBKdXN0IHJlYWxpemVkLCBpc24ndCB0aGF0IGV4YW1wbGUg
YWN0dWFsbHkgYSB0cnVlIHBvc2l0aXZlLCBvciBhdCBsZWFzdAo+ID4gPiBhIGdyZWF0IGNhbmRp
ZGF0ZSBmb3IgYSB0cnVlIHBvc2l0aXZlLCBzaW5jZSBpZiBhbm90aGVyIHRocmVhZCByZWVudGVy
cwo+ID4gPiB0aGF0IHNpZ25hbGluZyBwYXRoLCBpdCB3aWxsIGJsb2NrIG9uIHRoYXQgbXV0ZXgs
IGFuZCB0aGUgZmVuY2Ugd291bGQKPiA+ID4gbmV2ZXIgYmUgc2lnbmFsZWQgdW5sZXNzIHRoZXJl
IGlzIGFub3RoZXIgc2lnbmFsaW5nIHBhdGg/Cj4gPgo+ID4gTm90IHN1cmUgSSB1bmRlcnN0YW5k
IGZ1bGx5LCBidXQgSSB0aGluayB0aGUgYW5zd2VyIGlzICJpdCdzIGNvbXBsaWNhdGVkIi4KPgo+
IFNlZSBjZDgwODRmOTFjMDIgKCJsb2NraW5nL2xvY2tkZXA6IEFwcGx5IGNyb3NzcmVsZWFzZSB0
byBjb21wbGV0aW9ucyIpCj4KPiBkbWFfZmVuY2UgdXNhZ2UgaGVyZSBpcyBub3RoaW5nIGJ1dCBh
bm90aGVyIG5hbWUgZm9yIGEgY29tcGxldGlvbi4KClF1b3RpbmcgZnJvbSBteSBwcmV2aW91cyBj
b3ZlciBsZXR0ZXI6CgoiSSd2ZSBkcmFnZ2VkIG15IGZlZXQgZm9yIHllYXJzIG9uIHRoaXMsIGhv
cGluZyB0aGF0IGNyb3NzLXJlbGVhc2UgbG9ja2RlcAp3b3VsZCBkbyB0aGlzIGZvciB1cywgYnV0
IHdlbGwgdGhhdCBuZXZlciByZWFsbHkgaGFwcGVuZWQgdW5mb3J0dW5hdGVseS4KU28gaGVyZSB3
ZSBhcmUuIgoKSSBkaXNjdXNzZWQgdGhpcyB3aXRoIFBldGVyLCBjcm9zcy1yZWxlYXNlIG5vdCBn
ZXR0aW5nIGluIGlzIHByZXR0eQpmaW5hbCBpdCBzZWVtcy4gVGhlIHRyb3VibGUgaXMgZmFsc2Ug
cG9zaXRpdmVzIHdpdGhvdXQgZXhwbGljaXQKYmVnaW4vZW5kIGFubm90YXRpb25zIHJldmlld2Vk
IGJ5IGh1bWFucyAtIGltZSBmcm9tIGp1c3QgdGhlc2UgZmV3CmV4YW1wbGVzIHlvdSBqdXN0IGNh
bid0IGd1ZXNzIHRoaXMgc3R1ZmYgYnkgY29tcHV0ZXJlcywgeW91IG5lZWQgcmVhbApicmFpbnMg
dGhpbmtpbmcgYWJvdXQgYWxsIHRoZSBlZGdlIGNhc2VzLCBhbmQgd2hlcmUgZXhhY3RseSB0aGUK
Y3JpdGljYWwgc2VjdGlvbiBzdGFydHMgYW5kIGVuZHMuIFdpdGhvdXQgdGhhdCB5b3UncmUganVz
dCBnb2luZyB0bwpkcm93biBpbiBhIHNlYSBvZiBmYWxzZSBwb3NpdGl2ZXMgYW5kIHl1Y2suCgpT
byB5ZWFoIEkgaGFkIGhvcGVzIGZvciBjcm9zcy1yZWxlYXNlIHRvbywgdW5mb3J0dW5hdGVseSB0
aGF0IHdhcwplbnRpcmVseSBpbiB2YWluIGFuZCBhIGRpc3RyYWN0aW9uLgoKTm93IEkgZ3Vlc3Mg
aXQgd291bGQgYmUgbmljZSBpZiB0aGVyZSdzIGEgcGVyLWNsYXNzCmNvbXBsZXRpb25fYmVnaW4v
ZW5kIGFubm90YXRpb24gZm9yIHRoZSBtb3JlIGdlbmVyaWMgcHJvYmxlbS4gQnV0IHRoZW4KYWxz
byBtb3N0IHBlb3BsZSBkb24ndCBoYXZlIGEgY3Jvc3MtZHJpdmVyIGNvbXBsZXRpb24gYXBpIGNv
bnRyYWN0Cmxpa2UgZG1hX2ZlbmNlIGlzLCB3aXRoIHNvbWUgb2YgdGhlIG1vc3QgcmlkaWN1bG91
cyBvdmVyIHRoZSB0b3AKY29uc3RyYWludHMgb2Ygd2hhdCdzIHBvc3NpYmxlIGFuZCB3aGF0J3Mg
bm90IHBvc3NpYmxlIG9uIGVhY2ggc2lkZSBvZgp0aGUgY3Jvc3MtcmVsZWFzZS4gV2UgZG8gaGF2
ZSBhIGJpdCBhbiBvdXRzaXplZCBiZW5lZml0IChpbiBwYWluCnJlZHVjdGlvbikgdnMgY29zdCBy
YXRpbyBoZXJlLgotRGFuaWVsCi0tIApEYW5pZWwgVmV0dGVyClNvZnR3YXJlIEVuZ2luZWVyLCBJ
bnRlbCBDb3Jwb3JhdGlvbgorNDEgKDApIDc5IDM2NSA1NyA0OCAtIGh0dHA6Ly9ibG9nLmZmd2xs
LmNoCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
