Return-Path: <SRS0=UwKb=ZU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B6DC432C0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 05:01:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1CE8215F1
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 05:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1CE8215F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FF956E045;
	Thu, 28 Nov 2019 05:01:52 +0000 (UTC)
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com
 [IPv6:2a00:1450:4864:20::243])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0356C6E045
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2019 05:01:50 +0000 (UTC)
Received: by mail-lj1-x243.google.com with SMTP id k15so26988260lja.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 21:01:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=l3tsud1xxuy9MthXEQOiNtgo/QvIM9smX36kYlpwFbM=;
 b=jcJJmyktyPgNkZ+Evn3P/o/i5GAPCHIAXI2mxY1KjkIdideOA8LPa7YFMEuvsAK1Xg
 hjOfN6ePmwNGq9ctPMS39s5RzQ+gdAJbnfIs/kktPA4HrbfddqFkrXLA5AXbfNKpGjIM
 4W5cz4dOxpJwc/TQO75GggcDkWKnO7U5hmebsDlrRgWEVjS7vCf6n5bhr9NA+ygNFFM1
 /j8AG2Cs9mBJsyGPOjFCgBDkeke/lOJA2sDlh3WbgmJDe8KVGQYxjPnRM+PSl0jrv3oD
 Yz3xytbv5Crf6aUCvHUS1Yefrih08vWThYPExafpCcWevJtgFD/+pVLRQWrfrl7datFQ
 hXvg==
X-Gm-Message-State: APjAAAVVS8FR2leteN/wuoUF9HXj5AcQv5cbhxbjHvMgWVxsnJP2ovFC
 luwZfzDyJZdbwOoQVynSR7Fp18daTW5rwwCwR9E=
X-Google-Smtp-Source: APXvYqylfwsL42/C7qSUguCDl5vzkteWFX7HwsQTOyiVwisRSfdfeIngeV/C+3R4SaUJSxY8KoWoDCqC/NgJ4nbLt6M=
X-Received: by 2002:a05:651c:120c:: with SMTP id
 i12mr6842066lja.130.1574917308927; 
 Wed, 27 Nov 2019 21:01:48 -0800 (PST)
MIME-Version: 1.0
References: <c53a99e5-eea0-17d1-05e6-b6e66746d774@gmail.com>
 <CAAxE2A7Q=qdxtm6HXF3Py9dYpARvA6+Z4ENkWTCEA572SdNEqw@mail.gmail.com>
 <CAAxE2A7ZApX2aO1nJKwbqMWWjX4ZL6zTdtsCbEA946J2CmtjrQ@mail.gmail.com>
 <aeec0bc1-4814-ee82-8e59-d460e74a8ba3@vodafone.de>
 <CAAxE2A5xuq59iWP=b+8=tCHNm81CGz4piY3EheSfLnVV6tXZLg@mail.gmail.com>
In-Reply-To: <CAAxE2A5xuq59iWP=b+8=tCHNm81CGz4piY3EheSfLnVV6tXZLg@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 28 Nov 2019 15:01:37 +1000
Message-ID:
 <CAPM=9tw3Q5prEVo=2p-=6++xsiB9rW9vtzws2eZT2s6HtRTwvQ@mail.gmail.com>
Subject: Re: GART write flush error on SI w/ amdgpu
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=l3tsud1xxuy9MthXEQOiNtgo/QvIM9smX36kYlpwFbM=;
 b=CIEOV85vPAsoz6aBwCklEmOZ0mM2z+MSsIe0smq333nZod0n2TEwYmZ59FBUjDPZxY
 W9pATnmNb8jlqlcEWgEGZ87orBCyhBdZUqcsPxG7PqPESTI6RNhLLwpCGs8lwJshTPBY
 jKb7v/V3R6KzqMmRWifOlba/cFNfIXMt2au5qTQsLcyzT+Ysc+RHECs0RC5ZnYkUu7Tt
 2aeHDcbtXXI5Cgd4pXFBgx5DrzWSEJIN2QcveMAhOEXrtafei7IeXl9NghsHumjtuVRD
 6ctBmwa6dzv3novZwNFTJ12EJ3+uJoXT0d33G2T9WMQ/VwcwBWmQ8CxNbdKUZtRNhBq0
 pHJA==
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple@vodafone.de>,
 =?UTF-8?Q?Nicolai_H=C3=A4hnle?= <nhaehnle@gmail.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191128050137.K-2vXc3RJwxFBzAzQef06ICNp0sKh21Nv_wmQXNosNs@z>

T24gV2VkLCAyMSBKdW4gMjAxNyBhdCAwMDowMywgTWFyZWsgT2zFocOhayA8bWFyYWVvQGdtYWls
LmNvbT4gd3JvdGU6Cj4KPiBPbiBUdWUsIEp1biAyMCwgMjAxNyBhdCAxOjQ2IFBNLCBDaHJpc3Rp
YW4gS8O2bmlnCj4gPGRlYXRoc2ltcGxlQHZvZGFmb25lLmRlPiB3cm90ZToKPiA+IEFtIDIwLjA2
LjIwMTcgdW0gMTI6MzQgc2NocmllYiBNYXJlayBPbMWhw6FrOgo+ID4+Cj4gPj4gQlRXLCBJIG5v
dGljZWQgdGhlIGZsdXNoIHNlcXVlbmNlIGluIHRoZSBrZXJuZWwgaXMgd3JvbmcuIFRoZSBjb3Jy
ZWN0Cj4gPj4gZmx1c2ggc2VxdWVuY2Ugc2hvdWxkIGJlOgo+ID4+Cj4gPj4gMSkgRVZFTlRfV1JJ
VEVfRU9QIC0gQ0FDSEVfRkxVU0hfQU5EX0lOVl9UUyAtIHdyaXRlIGEgZHdvcmQgdG8gbWVtb3J5
LAo+ID4+IGJ1dCBubyBmZW5jZS9pbnRlcnJ1cHQuCj4gPj4gMikgV0FJVF9SRUdfTUVNIG9uIHRo
ZSBkd29yZCB0byB3YWl0IGZvciBpZGxlIGJlZm9yZSBTVVJGQUNFX1NZTkMuCj4gPj4gMykgU1VS
RkFDRV9TWU5DIChUQywgSyQsIEkkKQo+ID4+IDQpIFdyaXRlIENQX0NPSEVSX0NOVEwyLgo+ID4+
IDUpIEVWRU5UX1dSSVRFX0VPUCAtIEJPVFRPTV9PRl9QSVBFX1RTIC0gd3JpdGUgdGhlIGZlbmNl
IHdpdGggdGhlCj4gPj4gaW50ZXJydXB0Lgo+ID4+Cj4gPj4gV0FJVF9SRUdfTUVNIHdvdWxkbid0
IGJlIG5lZWRlZCBpZiB3ZSB3ZXJlIGFibGUgdG8gbWVyZ2UKPiA+PiBDQUNIRV9GTFVTSF9BTkRf
SU5WLCBTVVJGQUNFX1NZTkMsIGFuZCBDUF9DT0hFUl9DTlRMMiBpbnRvIG9uZSBFT1AKPiA+PiBl
dmVudC4KPiA+Pgo+ID4+IFRoZSBtYWluIGlzc3VlIHdpdGggdGhlIGN1cnJlbnQgZmx1c2ggc2Vx
dWVuY2UgaW4gcmFkZW9uIGFuZCBhbWRncHUgaXMKPiA+PiB0aGF0IGl0IGRvZXNuJ3Qgd2FpdCBm
b3IgaWRsZSBiZWZvcmUgd3JpdGluZyBDUF9DT0hFUl9DTlRMMiBhbmQKPiA+PiBTVVJGQUNFX1NZ
TkMuIFNvIGZhciB3ZSd2ZSBiZWVuIGFibGUgdG8gYXZvaWQgdGhlIGJ1ZyBieSB3YWl0aW5nIGZv
cgo+ID4+IGlkbGUgaW4gdXNlcnNwYWNlIElCcy4KPiA+Cj4gPgo+ID4gV2VsbCBub3Qgd2FpdGlu
ZyBmb3IgaWRsZSBiZXR3ZWVuIElCcyBpcyBhbiBleHBsaWNpdCByZXF1aXJlbWVudCwgYmVjYXVz
ZSBpdAo+ID4gaXMgcmF0aGVyIGJhZCBmb3IgcGVyZm9ybWFuY2UgdG8gZG8gc28uCj4gPgo+ID4g
RGF2aWQgWmhvdSwgTW9uayBhbmQgSSB3b3JrZWQgcXVpdGUgYSBsb3Qgb24gdGhpcyB0byBhdm9p
ZCBib3RoIHBvc3NpYmxlCj4gPiBoYXphcmQgYW5kIHBlcmZvcm1hbmNlIGRyb3AuCj4KPiBJIGd1
ZXNzIHRoZSByZXF1aXJlbWVudCB3YXMgaWdub3JlZCBmb3IgU0kuIElmIHlvdSBkb24ndCBkbyB0
aGUgVEMKPiBmbHVzaCBhcyBwYXJ0IHRoZSBFT1AgZXZlbnQsIHlvdSBoYXZlIHRvIHdhaXQgZm9y
IGlkbGUgYmVmb3JlCj4gU1VSRkFDRV9TWU5DLCBiZWNhdXNlIFNVUkZBQ0VfU1lOQyBkb2Vzbid0
IHdhaXQgZm9yIGlkbGUuIEl0J3Mga2luZGEKPiB1c2VsZXNzIHRvIGZsdXNoIFRDIHdoZW4gc2hh
ZGVycyBhcmUgc3RpbGwgaW4gZmxpZ2h0LgoKSSd2ZSBiZWVuIGNoYXNpbmcgVmVyZGUgd2llcmRu
ZXNzLCBkaWQgdGhpcyBpc3N1ZSBldmVyIGdldCByZXNvbHZlZD8KCkRhdmUuCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
