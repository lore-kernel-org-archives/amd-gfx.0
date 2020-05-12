Return-Path: <SRS0=6vDE=62=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F93C47077
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 21:12:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5454520740
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 21:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=spliet.org header.i=@spliet.org header.b="Zmme1FWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5454520740
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=spliet.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FE4F6E9A2;
	Tue, 12 May 2020 21:12:20 +0000 (UTC)
X-Greylist: delayed 391 seconds by postgrey-1.36 at gabe;
 Tue, 12 May 2020 20:59:08 UTC
Received: from mupuf.org (mupuf.org [167.71.42.210])
 by gabe.freedesktop.org (Postfix) with ESMTP id 4870C6E98C;
 Tue, 12 May 2020 20:59:08 +0000 (UTC)
Received: from [131.111.247.158] (unknown [131.111.247.158])
 by Neelix.spliet.org (Postfix) with ESMTPSA id 7C83F60069;
 Tue, 12 May 2020 21:52:31 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 Neelix.spliet.org 7C83F60069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spliet.org;
 s=default; t=1589316751;
 bh=QxNAjllyL411XRfFd2j9T+M8m0gpBrdynhZPokKmeHY=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Zmme1FWN0cie1MA/vRRVLTcqHe1aviavUYAe15XMVeWiCTzBCXtCuylC+WVO6jeXt
 4Jya15RrVF5WumOI+DidkGJ0CqvbyDdUr5xuOBkZpnIqHxvqpqI38VSt1258D9cPAc
 3Smu3hH4uQoKNnReCpSeULt8YzEr7s/XolAfJtxE=
Subject: Re: [Nouveau] [PATCH 1/3] drm/radeon: remove AGP support
To: Alex Deucher <alexdeucher@gmail.com>, =?UTF-8?Q?Michel_D=c3=a4nzer?=
 <michel@daenzer.net>
References: <20200511171722.96576-1-christian.koenig@amd.com>
 <20200511171722.96576-2-christian.koenig@amd.com>
 <CADnq5_MyO_L+1w69qDLzhg34W6Qer-uSRR2tb7-2uXLC_6PXSg@mail.gmail.com>
 <ba0b1ab7-3078-a6f2-41cd-326ca21ee99f@daenzer.net>
 <CADnq5_MdbJUXs7wbG=HCOKj4Vp_NmLkcJng=EXynSXPe9gsyOQ@mail.gmail.com>
From: Roy Spliet <nouveau@spliet.org>
Message-ID: <777c08d1-3ac3-16ca-0222-e2d62c281e50@spliet.org>
Date: Tue, 12 May 2020 21:52:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_MdbJUXs7wbG=HCOKj4Vp_NmLkcJng=EXynSXPe9gsyOQ@mail.gmail.com>
Content-Language: en-GB
X-Virus-Scanned: clamav-milter 0.102.2 at Neelix
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 12 May 2020 21:12:19 +0000
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 nouveau <nouveau@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T3AgMTItMDUtMjAyMCBvbSAxNDozNiBzY2hyZWVmIEFsZXggRGV1Y2hlcjoKPiBPbiBUdWUsIE1h
eSAxMiwgMjAyMCBhdCA0OjE2IEFNIE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnplci5uZXQ+
IHdyb3RlOgo+Pgo+PiBPbiAyMDIwLTA1LTExIDEwOjEyIHAubS4sIEFsZXggRGV1Y2hlciB3cm90
ZToKPj4+IE9uIE1vbiwgTWF5IDExLCAyMDIwIGF0IDE6MTcgUE0gQ2hyaXN0aWFuIEvDtm5pZwo+
Pj4gPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiB3cm90ZToKPj4+Pgo+Pj4+IEFH
UCBpcyBkZXByZWNhdGVkIGZvciAxMCsgeWVhcnMgbm93IGFuZCBub3QgdXNlZCBhbnkgbW9yZSBv
biBtb2Rlcm4gaGFyZHdhcmUuCj4+Pj4KPj4+PiBPbGQgaGFyZHdhcmUgc2hvdWxkIGNvbnRpbnVl
IHRvIHdvcmsgaW4gUENJIG1vZGUuCj4+Pgo+Pj4gTWlnaHQgd2FudCB0byBjbGFyaWZ5IHRoYXQg
dGhlcmUgaXMgbm8gbG9zcyBvZiBmdW5jdGlvbmFsaXR5IGhlcmUuCj4+PiBTb21ldGhpbmcgbGlr
ZToKPj4+Cj4+PiAiVGhlcmUgaXMgbm8gbG9zcyBvZiBmdW5jdGlvbmFsaXR5IGhlcmUuICBHUFVz
IHdpbGwgY29udGludWUgdG8KPj4+IGZ1bmN0aW9uLiAgVGhpcyBqdXN0IGRyb3BzIHRoZSB1c2Ug
b2YgdGhlIEFHUCBNTVUgaW4gdGhlIGNoaXBzZXQgaW4KPj4+IGZhdm9yIG9mIHRoZSBNTVUgb24g
dGhlIGRldmljZSB3aGljaCBoYXMgcHJvdmVuIHRvIGJlIG11Y2ggbW9yZQo+Pj4gcmVsaWFibGUu
ICBEdWUgdG8gaXRzIHVucmVsaWFiaWxpdHksIEFHUCBzdXBwb3J0IGhhcyBiZWVuIGRpc2FibGVk
IG9uCj4+PiBQb3dlclBDIGZvciB5ZWFycyBhbHJlYWR5IHNvIHRoZXJlIGlzIG5vIGNoYW5nZSBv
biBQb3dlclBDLiIKPj4KPj4gVGhlcmUncyBhIGRpZmZlcmVuY2UgYmV0d2VlbiBzb21ldGhpbmcg
YmVpbmcgZGlzYWJsZWQgYnkgZGVmYXVsdCBvciBub3QKPj4gYmVpbmcgYXZhaWxhYmxlIGF0IGFs
bC4gV2UgbWF5IGRlY2lkZSBpdCdzIHdvcnRoIGl0IGFueXdheSwgYnV0IGxldCdzIGRvCj4+IGl0
IGJhc2VkIG9uIGZhY3RzLgo+Pgo+IAo+IEkgZGlkbid0IG1lYW4gdG8gaW1wbHkgdGhhdCBBR1Ag
R0FSVCBzdXBwb3J0IHdhcyBhbHJlYWR5IHJlbW92ZWQuICBCdXQKPiBmb3IgdGhlIHZhc3QgbWFq
b3JpdHkgb2YgdXNlcnMgdGhlIGVuZCByZXN1bHQgaXMgdGhlIHNhbWUuICBJZiB5b3UKPiBrbmV3
IGVub3VnaCByZS1lbmFibGUgQUdQIEdBUlQsIHlvdSBwcm9iYWJseSB3b3VsZG4ndCBoYXZlIGJl
ZW4gYXMKPiBjb25mdXNlZCBhYm91dCB3aGF0IHRoaXMgcGF0Y2ggc2V0IGRvZXMgZWl0aGVyLiAg
VG8gcmVpdGVyYXRlLCB0aGlzCj4gcGF0Y2ggc2V0IGRvZXMgbm90IHJlbW92ZSBzdXBwb3J0IGZv
ciBBR1AgY2FyZHMsIGl0IG9ubHkgcmVtb3ZlcyB0aGUKPiBzdXBwb3J0IGZvciBBR1AgR0FSVC4g
IFRoZSBjYXJkcyB3aWxsIHN0aWxsIGJlIGZ1bmN0aW9uYWwgdXNpbmcgdGhlCj4gZGV2aWNlIEdB
UlQuICBUaGVyZSBtYXkgYmUgcGVyZm9ybWFuY2UgdHJhZGVvZmZzIHRoZXJlIGluIHNvbWUgY2Fz
ZXMuCgpJJ2xsIHZvbHVudGVlciB0byBiZSB0aGUgb25lIGFza2luZzogaG93IGJpZyBpcyB0aGlz
IHBlcmZvcm1hbmNlIApkaWZmZXJlbmNlPyBIYXZlIGFueSBiZW5jaG1hcmtzIGJlZW4gcnVuIGJl
Zm9yZSBhbmQgYWZ0ZXIgcmVtb3ZhbCBvZiBBR1AgCkdBUlQgY29kZSBvbiBhZmZlY3RlZCBub3V2
ZWF1L3JhZGVvbiBzeXN0ZW1zPyBPciBpcyB0aGlzIGNvZGUgYmVpbmcgCmRyb3BwZWQgX2p1c3Rf
IGJlY2F1c2UgaXQncyBjdW1iZXJzb21lLCB3aXRoIG5vIHJlZ2FyZCBmb3IgbWV0cmljcyB0aGF0
IApkZXRlcm1pbmUgdGhlIHZhbHVlIG9mIEFHUCBHQVJUIHN1cHBvcnQ/CgpSb3kKCj4gCj4gQWxl
eAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gTm91
dmVhdSBtYWlsaW5nIGxpc3QKPiBOb3V2ZWF1QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vbm91dmVhdQo+IAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
