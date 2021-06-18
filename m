Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF885C49EA2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 07:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF09611BD
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 07:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF09611BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 119B189D67;
	Mon, 21 Jun 2021 07:09:09 +0000 (UTC)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C24C76E986
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jun 2021 08:46:23 +0000 (UTC)
Received: by mail-io1-xd32.google.com with SMTP id k11so5070080ioa.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jun 2021 01:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=oCkAPeADNlD30dtyMxWQj6bi3FwZFRDFbIwfBCBHIJg=;
 b=OREbKGDpCVfmXaU5WImRuocE+I3mgclxrXibPia26wWv18pLgiykzKzqJhg0MlOPo2
 QX6hMAB/e23Vb9Drdtq5ajJJfumF3dPdS+kEORUYEo1LrAUPmLgpTqHV0YPfuCmv+sCv
 V1zu1ukO3uZeU72DGA4pJDFwBN8GRbLoFUzjQpb6XMw5Vwx+2w5hrU9vy64yxxcEvzz4
 jvZbI3KhoB7kL6eiIWv5X9uLgeLWh8JRD6UGci1SS6kg+Gv47pH2ZQfYI0k/eibikhZh
 D7df32/5pyuX5wyzyCZApQiqwUzeN+O5M1IDpKIpxgLcS28OFFu26bzv5gdrmaEIp1gS
 n+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=oCkAPeADNlD30dtyMxWQj6bi3FwZFRDFbIwfBCBHIJg=;
 b=ojtG5k3jtdNkxCMuwGrYh/PE/vePQ11jKi6fhNUg2rhZxPtfB+hTULDSO19pBqZAib
 ViW69L5KCfKL3O/+QrKHDRBpcQ2ZSEwonOKNfiaVJQm8ld6eHeavfg2UNFwm2hpwb/jp
 LKXFwYEAqaTynr9h2UZsWDeaiz+ladR9JHmzyUdetBlrA+nxk0k3jyu1Q3sF8FYgls9M
 qHSgg3A/cZhKrDcJSazDpEfca3OP1nBLyLO7M+zdYcoU9aPEzlsk9vi2BoFuiF3dp0gi
 T2NDp9EwRAePiu3+pfChQJx+0yuymL+0OjdxkNHYzzPeRIspwRFyThQKdQf2DwnTcq2e
 FL1A==
X-Gm-Message-State: AOAM530D1gtZfYD2StSxGJAOQ1vfFSCZZUeV3vzF0WHvgSIZyt5CrMTu
 AJAxypQuTlYIsol9hHs9s2HSVPMfJLcFBbhBUdaC
X-Google-Smtp-Source: ABdhPJwO7nzNasC2RvD07xmbZvFuYWt+Qrx8+76qN8/3D3ngN/x1pPnImlATl6uKvKLTNlbLFbEzp3LxNIfyLGieeS8=
X-Received: by 2002:a02:a784:: with SMTP id e4mr2286752jaj.18.1624005982919;
 Fri, 18 Jun 2021 01:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210617081843.26987-1-lb@semihalf.com>
 <99e54dc1-d73c-1cef-a062-f46bcff3a74e@daenzer.net>
In-Reply-To: <99e54dc1-d73c-1cef-a062-f46bcff3a74e@daenzer.net>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date: Fri, 18 Jun 2021 10:46:11 +0200
Message-ID: <CAK8ByeJWnXAbJVDtmMAfW1hQ6SzzfTUiK96pTU1=cQxVCNQJCw@mail.gmail.com>
Subject: Re: [PATCH v1] drm/amdgpu: fix framebuffer memory use after free
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
X-Mailman-Approved-At: Mon, 21 Jun 2021 07:09:08 +0000
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
Cc: upstream@semihalf.com, amd-gfx@lists.freedesktop.org,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Y3p3LiwgMTcgY3plIDIwMjEgbyAxNjoxOCBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRhZW56ZXIu
bmV0PiBuYXBpc2HFgihhKToKPgo+IE9uIDIwMjEtMDYtMTcgMTA6MTggYS5tLiwgTHVrYXN6IEJh
cnRvc2lrIHdyb3RlOgo+ID4gV2l0aCBvcHRpb24gQ09ORklHX0RFQlVHX0xJU1QgZW5hYmxlZCB0
aGUga2VybmVsIGxvZ3Mgc2hvdyBsaXN0X2FkZAo+ID4gY29ycnVwdGlvbiB3YXJuaW5nLiBUaGUg
d2FybmluZyBvcmlnaW5hdGVzIGZyb20gZHJtX2ZyYW1lYnVmZmVyX2luaXQoKQo+ID4gZnVuY3Rp
b24gd2hpY2ggYWRkcyBmcmFtZWJ1ZmZlciB0byBhIGZyYW1lYnVmZmVycyBsaXN0IGFuZCBpcyBj
YWxsZWQgYnkKPiA+IGFtZGdwdV9kaXNwbGF5X2dlbV9mYl92ZXJpZnlfYW5kX2luaXQoKS4KPiA+
IElmIGFtZGdwdV9kaXNwbGF5X2dlbV9mYl92ZXJpZnlfYW5kX2luaXQoKSBlbmNvdW50ZXJzIGFu
IGVycm9yIGFmdGVyCj4gPiBjYWxsaW5nIGRybV9mcmFtZWJ1ZmZlcl9pbml0KCkgdGhlbiBmcmFt
ZWJ1ZmZlciBtZW1vcnkgaXMgcmVsZWFzZWQKPiA+IGluIGFtZGdwdV9kaXNwbGF5X3VzZXJfZnJh
bWVidWZmZXJfY3JlYXRlKCkgd2l0aG91dCByZW1vdmluZyBmcmFtZWJ1ZmZlcgo+ID4gZnJvbSB0
aGUgbGlzdCB3aGVyZSBpdCB3YXMgYWRkZWQuIFJldXNlIG9mIHRoYXQgbWVtb3J5IGJ5IGFueSBv
dGhlcgo+ID4gcGFydHkgY2F1c2UgY29ycnVwdGlvbiBvZiB0aGUgZnJhbWVidWZmZXJzIGxpbmtl
ZCBsaXN0LiBUaGlzIGZpeCByZW1vdmVzCj4gPiBmcmFtZWJ1ZmZlciBmcm9tIHRoZSBsaW5rZWQg
bGlzdCBhbmQgdW5yZWdpc3RlcnMgaXQgaW4gY2FzZSBvZiBmYWlsdXJlLgo+ID4KPiA+IFsuLi5d
Cj4gPgo+ID4gRml4ZXM6IDZlZWQ5NWIwMGI0NSAoImRybS9hbWQvZGlzcGxheTogU3RvcmUgdGls
aW5nX2ZsYWdzIGluIHRoZSBmcmFtZWJ1ZmZlci4iKQo+Cj4gSSBkaWRuJ3QgcmVhbGl6ZSB0aGVy
ZSB3YXMgYWxyZWFkeSBhbiBpc3N1ZSBiZWZvcmUgZjI1ODkwN2ZkZDgzNWUgImRybS9hbWRncHU6
IFZlcmlmeSBibyBzaXplIGNhbiBmaXQgZnJhbWVidWZmZXIgc2l6ZSBvbiBpbml0LiIuIExvb2tp
bmcgYXQKPiB0aGUgR2l0IGhpc3RvcnkgYWdhaW4sIEkgYWdyZWUgdGhlcmUncyBhbHJlYWR5IGF0
IGxlYXN0IGEgdGhlb3JldGljYWwgaXNzdWUgaW4gNS4xMSwgdGhvdWdoIEkgc3VzcGVjdCBpdCdz
IGhhcmRlciB0byBoaXQgaW4gcHJhY3RpY2UuCj4KPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGlzcGxheS5jCj4gPiBpbmRleCBjMTM5ODVmYjM1YmUuLjkzMzE5MDI4
MWI5MSAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
aXNwbGF5LmMKPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNw
bGF5LmMKPiA+IEBAIC0xMDg1LDE0ICsxMDg1LDE3IEBAIGludCBhbWRncHVfZGlzcGxheV9nZW1f
ZmJfdmVyaWZ5X2FuZF9pbml0KAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICBtb2RlX2Nt
ZC0+bW9kaWZpZXJbMF0pOwo+ID4KPiA+ICAgICAgICAgICAgICAgcmV0ID0gLUVJTlZBTDsKPiA+
IC0gICAgICAgICAgICAgZ290byBlcnI7Cj4gPiArICAgICAgICAgICAgIGdvdG8gZXJyX2ZiX2Ns
ZWFudXA7Cj4gPiAgICAgICB9Cj4gPgo+ID4gICAgICAgcmV0ID0gYW1kZ3B1X2Rpc3BsYXlfZnJh
bWVidWZmZXJfaW5pdChkZXYsIHJmYiwgbW9kZV9jbWQsIG9iaik7Cj4gPiAgICAgICBpZiAocmV0
KQo+ID4gLSAgICAgICAgICAgICBnb3RvIGVycjsKPiA+ICsgICAgICAgICAgICAgZ290byBlcnJf
ZmJfY2xlYW51cDsKPiA+Cj4gPiAgICAgICByZXR1cm4gMDsKPiA+ICtlcnJfZmJfY2xlYW51cDoK
PiA+ICsgICAgIGRybV9mcmFtZWJ1ZmZlcl91bnJlZ2lzdGVyX3ByaXZhdGUoJnJmYi0+YmFzZSk7
Cj4gPiArICAgICBkcm1fZnJhbWVidWZmZXJfY2xlYW51cCgmcmZiLT5iYXNlKTsKPiA+ICBlcnI6
Cj4gPiAgICAgICBkcm1fZGJnX2ttcyhkZXYsICJGYWlsZWQgdG8gdmVyaWZ5IGFuZCBpbml0IGdl
bSBmYjogJWRcbiIsIHJldCk7Cj4gPiAgICAgICByZmItPmJhc2Uub2JqWzBdID0gTlVMTDsKPiA+
Cj4KPiBUaGVyZSdzIGEgc2ltaWxhciBpc3N1ZSBpbiBhbWRncHVfZGlzcGxheV9nZW1fZmJfaW5p
dC4gaHR0cHM6Ly9wYXRjaHdvcmsuZnJlZWRlc2t0b3Aub3JnL3BhdGNoLzQzOTU0Mi8gZml4ZXMg
dGhhdCBhcyB3ZWxsLCBhbmQgc2VlbXMgc2ltcGxlciAodGhvdWdoIEknbSBiaWFzZWQgb2J2aW91
c2x5IDopLgoKSSBhZ3JlZSB5b3VyIHBhdGNoIGlzIHNpbXBsZXIgYW5kIGNvdmVycyBtb3JlIGNh
c2VzLCBidXQgSU1ITyBteQphcHByb2FjaCB3aXRoIGV4cGxpY2l0IGZyYW1lYnVmZmVyIGNsZWFu
dXAgaGFzIHRoZSBhZHZhbnRhZ2UKdGhhdCBpdCB3aWxsIGJlIGhhcmQgdG8gbWlzcyBpbiBjYXNl
IG9mIGZ1dHVyZSBjb2RlIHJlb3JnYW5pemF0aW9ucyBpbgp0aGF0IGFyZWEuCgo+Cj4KPiBOZWl0
aGVyIHBhdGNoIGNhbiBiZSB0cml2aWFsbHkgY2hlcnJ5IHBpY2tlZCBmb3IgZml4aW5nIHRoZSBp
c3N1ZSBpbiA1LjExLzUuMTIgZHVlIHRvIGYyNTg5MDdmZGQ4MzVlLgo+Cj4KPiAtLQo+IEVhcnRo
bGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwczov
L3JlZGhhdC5jb20KPiBMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAg
ICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
