Return-Path: <SRS0=l0jK=2O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FF7C2D0C3
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 18:38:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF76820663
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 18:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiqOKw54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF76820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A7B96E354;
	Tue, 24 Dec 2019 18:38:38 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79B0D6E354
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Dec 2019 18:38:36 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id p9so2980191wmc.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Dec 2019 10:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tkgm3rjc8O5GYOvywHsOx4yG5oB33ecetwfs82e7Ac4=;
 b=GiqOKw54tqLNgKtpC+wgSEuVYVTzFSmFRgfpD1e+Db1+NBSweQTjq8ca4k4n3EOJ27
 fNlc4l6Se3poEjQTcGfBYcxFe1Gz3JhkiWb7zZehY80npVcgPLHpxi6qDknYK69WftW1
 NmQnDg4eFl8gzMqO6qXDB4hrmRphF1hFhwe+CeB0xxpOIaBrIMmlO46+qCKHL81BBlVB
 1Z/1uxwG1olM+V2+l92GRIf1kIiBTe2dDJJqCErsVl0rTxr/55ED7lyyh7fz3ZX3S6Fm
 8CeCaWZDotWvTf1BpTaEigFNfp1GgbqhTto2HQmN47EG83kINN2sDxQKSkm6tI4IXG7J
 5Ibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tkgm3rjc8O5GYOvywHsOx4yG5oB33ecetwfs82e7Ac4=;
 b=MoVBNo9RPB1+CdoxO3axL8t8FfA5OxOI6LxS7TVj858F4aATV5J4BsJ4k1v6P6R4zO
 HU77YuCST24tNTrTXN63NtJhRfrDHxwORVCyUoRUaVB15ZJvu98z+TQZHiOKDcOxlt5a
 G6byOSY7YfQI4/PYEJVnZsWlJrQJMRb9KOKx2FFTi8fQq+X6t1ijcIQWle+sVCjYmkR6
 /vHF/OizfnC5/BCSMxrW5Qir14Ur4QeFJdII7AgAnSVhYYSDJZPdqIEm0V1G0a0xJp9F
 qFsFewek1z5lOqlgpXxZ597oSpMCJdZCck+0470XFJsFuAOPPpOxShO58wEVhMhIhZF3
 Wp2A==
X-Gm-Message-State: APjAAAVYvoGGgA6ROPtwM9T8OUL8SD7fs7jpUl6bBCk7xOtxLxN1IWod
 3NXdghhNAuePJfSbAO3B4vpgGp52dxdz7/cetLnpmQhz
X-Google-Smtp-Source: APXvYqwPXcQHa3DbQacKAIuXJYBbdkKiXzf4G3GN6MUUNXDIeIFp5X6egTVhX2RTYaA0GP1El6Gx1yRwZS6n4vUdKBk=
X-Received: by 2002:a1c:f30e:: with SMTP id q14mr5344477wmq.65.1577212715095; 
 Tue, 24 Dec 2019 10:38:35 -0800 (PST)
MIME-Version: 1.0
References: <CAGzVRjxOWf=0T9vd6u4-qasWPzzKZoafrz_02+A40=KGZkgrow@mail.gmail.com>
 <CADnq5_NVW1u9fJjA6xq3s-o+3XFLW4wajANN27ohAY=Hm4ZudA@mail.gmail.com>
 <CAGzVRjyAwhxhXK_V=Saydv_UgBrtfbLt3uwya7U6P0w5jrvD_w@mail.gmail.com>
In-Reply-To: <CAGzVRjyAwhxhXK_V=Saydv_UgBrtfbLt3uwya7U6P0w5jrvD_w@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Dec 2019 13:38:23 -0500
Message-ID: <CADnq5_Mj9S8ixks06zfdbY-p37WtDfkEuatWj5U9+Uxd8SbMKA@mail.gmail.com>
Subject: Re: polaris12_mc.bin error
To: =?UTF-8?Q?Yusuf_Alt=C4=B1parmak?= <yusufalti1997@gmail.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBEZWMgMjQsIDIwMTkgYXQgMTozNiBQTSBZdXN1ZiBBbHTEsXBhcm1hawo8eXVzdWZh
bHRpMTk5N0BnbWFpbC5jb20+IHdyb3RlOgo+Cj4gSGVsbG8gQWxleCwKPgo+IElzIHRoaXMgZmly
bXdhcmUgZGlmZmVycyBvbiBrZXJuZWwgdmVyc2lvbiA/IEkgYW0gdXNpbmcgbGludXgga2VybmVs
IGZvciBlbWJlZGRlZCBkZXZpY2UuIElmIG5vdCwgY2FuIEkgdXNlIHRoZSBvbmVzIEkgZm91bmQg
d2l0aCBnb29nbGUgPwoKVGhlIGtlcm5lbCB2ZXJzaW9uIGRvZXNuJ3QgbWF0dGVyLiAgVGhlIGZp
cm13YXJlIGNhbiBiZSBmb3VuZCBoZXJlOgpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20v
bGludXgva2VybmVsL2dpdC9maXJtd2FyZS9saW51eC1maXJtd2FyZS5naXQvCk1vc3QgZGlzdHJv
cyBwYWNrYWdlIHRoYXQuCgpBbGV4Cgo+Cj4gVGhhbmtzLgo+Cj4gQWxleCBEZXVjaGVyIDxhbGV4
ZGV1Y2hlckBnbWFpbC5jb20+LCAyNCBBcmEgMjAxOSBTYWwsIDIxOjAwIHRhcmloaW5kZSDFn3Vu
dSB5YXpkxLE6Cj4+Cj4+IE9uIFR1ZSwgRGVjIDI0LCAyMDE5IGF0IDE6MzggQU0gWXVzdWYgQWx0
xLFwYXJtYWsKPj4gPHl1c3VmYWx0aTE5OTdAZ21haWwuY29tPiB3cm90ZToKPj4gPgo+PiA+IEhl
bGxvLCBJIGp1c3QgY29tcGlsZWQgbXkgNC4xOSBrZXJuZWwgd2l0aCBhbWRncHUgZHJpdmVyIChh
bWRncHUgYXMgYnVpbHRpbikuIFRoZSBkcml2ZXIgaXMgZ2l2aW5nIG1lICAtMiBlcnJvciBiZWNh
dXNlIG9mIHBvbGFyaXMxMl9tYy5iaW4gZGlkIG5vdCBmb3VuZC4gSSBjb3VsZG4ndCBmaW5kIHRo
YXQgZmlsZSBhbnl3aGVyZS4gSG93IGNhbiBpIGdldCBwb2xhcmlzMTJfbWMuYmluIGFuZCB3aGVy
ZSBzaG91bGQgSSBwbGFjZSBpdCA/Cj4+ID4KPj4KPj4gSWYgeW91IGFyZSBidWlsZGluZyBhbWRn
cHUgaW50byB5b3VyIGtlcm5lbCwgeW91IG5lZWQgdG8gYnVpbGQgdGhlCj4+IGZpcm13YXJlIGlu
dG8gdGhlIGtlcm5lbCB0b28uICBJZiB5b3UgYXJlIHVzaW5nIGFuIGluaXRyZCwgeW91IG5lZWQg
dG8KPj4gaW5jbHVkZSB0aGUgZmlybXdhcmUgaW4gdGhlIGluaXRyZC4gIFRoZSBmaXJtd2FyZSBp
cyB1c3VhbGx5IGluCj4+IC9saWIvZmlybXdhcmUsIGJ1dCBtYXkgdmFyeSBhIGJpdCBkZXBlbmRp
bmcgb24geW91ciBkaXN0cm8uCj4+Cj4+IEFsZXgKPj4KPj4gPiBEbWVzZzoKPj4gPiBbICAgIDUu
NDI1MzIzXSBbZHJtXSBhbWRncHUga2VybmVsIG1vZGVzZXR0aW5nIGVuYWJsZWQuCj4+ID4gWyAg
ICA1LjQyOTA2Nl0gYW1kZ3B1IDAwMDE6MDE6MDAuMDogcnVudGltZSBJUlEgbWFwcGluZyBub3Qg
cHJvdmlkZWQgYnkgYXJjaAo+PiA+IFsgICAgNS40Mjk2MDldIFtkcm1dIGluaXRpYWxpemluZyBr
ZXJuZWwgbW9kZXNldHRpbmcgKFBPTEFSSVMxMiAweDEwMDI6MHg2OTg3IDB4MTc4NzoweDIzODkg
MHg4MCkuCj4+ID4gWyAgICA1LjQzNzA5MV0gW2RybV0gcmVnaXN0ZXIgbW1pbyBiYXNlOiAweDIw
MjAwMDAwCj4+ID4gWyAgICA1LjQ0NTMwM10gW2RybV0gcmVnaXN0ZXIgbW1pbyBzaXplOiAyNjIx
NDQKPj4gPiBbICAgIDUuNDQ4Mjg4XSBbZHJtXSBhZGQgaXAgYmxvY2sgbnVtYmVyIDAgPHZpX2Nv
bW1vbj4KPj4gPiBbICAgIDUuNDUxODY0XSBbZHJtXSBhZGQgaXAgYmxvY2sgbnVtYmVyIDEgPGdt
Y192OF8wPgo+PiA+IFsgICAgNS40NTUzNTFdIFtkcm1dIGFkZCBpcCBibG9jayBudW1iZXIgMiA8
dG9uZ2FfaWg+Cj4+ID4gWyAgICA1LjQ1ODgzM10gW2RybV0gYWRkIGlwIGJsb2NrIG51bWJlciAz
IDxwb3dlcnBsYXk+Cj4+ID4gWyAgICA1LjQ2MjQxMF0gW2RybV0gYWRkIGlwIGJsb2NrIG51bWJl
ciA0IDxkbT4KPj4gPiBbICAgIDUuNDY1Mzc2XSBbZHJtXSBhZGQgaXAgYmxvY2sgbnVtYmVyIDUg
PGdmeF92OF8wPgo+PiA+IFsgICAgNS40Njg4NjRdIFtkcm1dIGFkZCBpcCBibG9jayBudW1iZXIg
NiA8c2RtYV92M18wPgo+PiA+IFsgICAgNS40NzI0MzhdIFtkcm1dIGFkZCBpcCBibG9jayBudW1i
ZXIgNyA8dXZkX3Y2XzA+Cj4+ID4gWyAgICA1LjQ3NTkyOV0gW2RybV0gYWRkIGlwIGJsb2NrIG51
bWJlciA4IDx2Y2VfdjNfMD4KPj4gPiBbICAgIDUuNDc5NTMwXSBbZHJtXSBVVkQgaXMgZW5hYmxl
ZCBpbiBWTSBtb2RlCj4+ID4gWyAgICA1LjQ4MjQxMV0gW2RybV0gVVZEIEVOQyBpcyBlbmFibGVk
IGluIFZNIG1vZGUKPj4gPiBbICAgIDUuNDg1NjQ3XSBbZHJtXSBWQ0UgZW5hYmxlZCBpbiBWTSBt
b2RlCj4+ID4gWyAgICA1LjcxNzkzMl0gQVRPTSBCSU9TOiAxMTMtRVIxNkJGQy0wMDEKPj4gPiBb
ICAgIDUuNzIwNDEyXSBbZHJtXSBHUFUgcG9zdGluZyBub3cuLi4KPj4gPiBbICAgIDUuODQzMTYw
XSBbZHJtXSB2bSBzaXplIGlzIDY0IEdCLCAyIGxldmVscywgYmxvY2sgc2l6ZSBpcyAxMC1iaXQs
IGZyYWdtZW50IHNpemUgaXMgOS1iaXQKPj4gPiBbICAgIDUuODUwMTc1XSBhbWRncHUgMDAwMTow
MTowMC4wOiBEaXJlY3QgZmlybXdhcmUgbG9hZCBmb3IgYW1kZ3B1L3BvbGFyaXMxMl9tYy5iaW4g
ZmFpbGVkIHdpdGggZXJyb3IgLTIKPj4gPiBbICAgIDUuODU4MTg3XSBtYzogRmFpbGVkIHRvIGxv
YWQgZmlybXdhcmUgImFtZGdwdS9wb2xhcmlzMTJfbWMuYmluIgo+PiA+IFsgICAgNS44NjM3NTJd
IFtkcm06LmdtY192OF8wX3N3X2luaXQgW2FtZGdwdV1dICpFUlJPUiogRmFpbGVkIHRvIGxvYWQg
bWMgZmlybXdhcmUhCj4+ID4gWyAgICA1Ljg3MDUwMV0gW2RybTouYW1kZ3B1X2RldmljZV9pbml0
IFthbWRncHVdXSAqRVJST1IqIHN3X2luaXQgb2YgSVAgYmxvY2sgPGdtY192OF8wPiBmYWlsZWQg
LTIKPj4gPiBbICAgIDUuODc3OTE4XSBhbWRncHUgMDAwMTowMTowMC4wOiBhbWRncHVfZGV2aWNl
X2lwX2luaXQgZmFpbGVkCj4+ID4gWyAgICA1Ljg4MjM2NV0gYW1kZ3B1IDAwMDE6MDE6MDAuMDog
RmF0YWwgZXJyb3IgZHVyaW5nIEdQVSBpbml0Cj4+ID4gWyAgICA1Ljg4NjcyMl0gW2RybV0gYW1k
Z3B1OiBmaW5pc2hpbmcgZGV2aWNlLgo+PiA+IFsgICAgNS44OTAwNTRdIGFtZGdwdTogcHJvYmUg
b2YgMDAwMTowMTowMC4wIGZhaWxlZCB3aXRoIGVycm9yIC0yCj4+ID4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4gPiBhbWQtZ2Z4IG1haWxpbmcgbGlz
dAo+PiA+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+ID4gaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
