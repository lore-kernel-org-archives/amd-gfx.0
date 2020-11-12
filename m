Return-Path: <SRS0=wW4+=ES=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F17C388F7
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 21:28:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74E56216C4
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 21:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjSmxuzU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E56216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C83F66E448;
	Thu, 12 Nov 2020 21:28:58 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 947506E448;
 Thu, 12 Nov 2020 21:28:57 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id c16so6727365wmd.2;
 Thu, 12 Nov 2020 13:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=G2BYNuIxlaObS9p75wcHPXenJKV2OHZTqCiRZ3u3/NU=;
 b=MjSmxuzUy3A5nn2fW066uU93yV94ooVSUHoz6odmOf1nsFJ03GGRyLVDJVCSyYOY85
 8u7A1f43k99+/zp9KJUZ2aXt3pkZ1x1fbWRfRDFXLwnOd0EX6W7bfBuG6Ww0CSZQOD5K
 xeM7/Xw2pc+2/ZRW7NKqr3he6CaUEQfzuswJ5vpMnSp0tz3natDcFiqp0DOwAisWXBdt
 AShV7rRe5dbd74S0/maGQK0u88EIwPn/JgtF5Rc0Xy8N2FCLafPZGvKYSWRxzZVYUYdT
 VaTklWmbH8dCI6aK/0sv1qpWkNgSP5u7yc9wmLkaf+yGTYudq1KpsVZFEnrfGDH6K0Ir
 rPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=G2BYNuIxlaObS9p75wcHPXenJKV2OHZTqCiRZ3u3/NU=;
 b=mM1pNQ94eUUDfH9eblNhWMWHEL+qpi4htzqzNCUDK/KoJ0USAaCgAq24MNY4Dms8vg
 FeTDos78wnj2AfAVejmdUCTMGR0DiN/ju3wir2X2uN8gYHoKkoomy9pbJdy/CR4gPKM7
 1049GDswx2eZZXOCnY54C0SfRgfEQ9gIq3keyRpq03oJ+LXqL87pIUTGFsQ+ic2uyXXM
 Ch60DiVxfqzxmtOhxukDGp+0BMAbpQ8aTTQlx/H9IASeoocVJ/c48LFI3TAd44dkAtf4
 SPmszfvS11eb9zO8/cWtvf+IsKP2CANIptRxwg83Ad8CGxJtXSCs9pR/CPgwLGZefhpe
 XqMA==
X-Gm-Message-State: AOAM532I5e2PAotDSyFKec64jOn60uSz7J4ItNbYp5h3Wih0hff1SAZ1
 Idkd97uaUQYpe4NS05+aeYOCNF8K6HjF5jtNv4M=
X-Google-Smtp-Source: ABdhPJwACnsJDr0htDUIcZ1390M+ztGM6mHPEVrjB75T5GqTdIpxllFizlL3nKTN1oMXRIMVR4CpDhPQIZX/zXW37Sk=
X-Received: by 2002:a1c:8150:: with SMTP id c77mr1687617wmd.26.1605216522204; 
 Thu, 12 Nov 2020 13:28:42 -0800 (PST)
MIME-Version: 1.0
References: <20201112190039.2785914-1-lee.jones@linaro.org>
 <20201112190039.2785914-20-lee.jones@linaro.org>
In-Reply-To: <20201112190039.2785914-20-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Nov 2020 16:28:30 -0500
Message-ID: <CADnq5_Pu0v=JHsRnB_M1OJNqKOZT0otcU1GCtif12GnKt4ArAg@mail.gmail.com>
Subject: Re: [PATCH 19/30] drm/amd/amdgpu/amdgpu_cs: Add a couple of missing
 function param descriptions
To: Lee Jones <lee.jones@linaro.org>
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
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Jerome Glisse <glisse@freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCBOb3YgMTIsIDIwMjAgYXQgMjowNyBQTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jOjY4
NTogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnYmFja29mZicgbm90IGRl
c2NyaWJlZCBpbiAnYW1kZ3B1X2NzX3BhcnNlcl9maW5pJwo+ICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfY3MuYzoxNjU1OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3Ig
bWVtYmVyICdtYXAnIG5vdCBkZXNjcmliZWQgaW4gJ2FtZGdwdV9jc19maW5kX21hcHBpbmcnCj4K
PiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IENjOiAiQ2hy
aXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBDYzogRGF2aWQgQWly
bGllIDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwu
Y2g+Cj4gQ2M6IFN1bWl0IFNlbXdhbCA8c3VtaXQuc2Vtd2FsQGxpbmFyby5vcmc+Cj4gQ2M6IEpl
cm9tZSBHbGlzc2UgPGdsaXNzZUBmcmVlZGVza3RvcC5vcmc+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBD
YzogbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnCj4gQ2M6IGxpbmFyby1tbS1zaWdAbGlzdHMu
bGluYXJvLm9yZwo+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5v
cmc+CgpBcHBsaWVkLiAgVGhhbmtzIQoKQWxleAoKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9jcy5jIHwgMiArKwo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2NzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYwo+IGluZGV4IDhk
Mjg3OGU5NTBkYWIuLjU5NGEwMTA4ZTkwZmEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfY3MuYwo+IEBAIC02NzYsNiArNjc2LDcgQEAgc3RhdGljIGludCBhbWRncHVfY3Nf
c3luY19yaW5ncyhzdHJ1Y3QgYW1kZ3B1X2NzX3BhcnNlciAqcCkKPiAgICogY3NfcGFyc2VyX2Zp
bmkoKSAtIGNsZWFuIHBhcnNlciBzdGF0ZXMKPiAgICogQHBhcnNlcjogICAgcGFyc2VyIHN0cnVj
dHVyZSBob2xkaW5nIHBhcnNpbmcgY29udGV4dC4KPiAgICogQGVycm9yOiAgICAgZXJyb3IgbnVt
YmVyCj4gKyAqIEBiYWNrb2ZmOiAgIGluZGljYXRvciB0byBiYWNrb2ZmIHRoZSByZXNlcnZhdGlv
bgo+ICAgKgo+ICAgKiBJZiBlcnJvciBpcyBzZXQgdGhhbiB1bnZhbGlkYXRlIGJ1ZmZlciwgb3Ro
ZXJ3aXNlIGp1c3QgZnJlZSBtZW1vcnkKPiAgICogdXNlZCBieSBwYXJzaW5nIGNvbnRleHQuCj4g
QEAgLTE2NDQsNiArMTY0NSw3IEBAIGludCBhbWRncHVfY3Nfd2FpdF9mZW5jZXNfaW9jdGwoc3Ry
dWN0IGRybV9kZXZpY2UgKmRldiwgdm9pZCAqZGF0YSwKPiAgICogQHBhcnNlcjogY29tbWFuZCBz
dWJtaXNzaW9uIHBhcnNlciBjb250ZXh0Cj4gICAqIEBhZGRyOiBWTSBhZGRyZXNzCj4gICAqIEBi
bzogcmVzdWx0aW5nIEJPIG9mIHRoZSBtYXBwaW5nIGZvdW5kCj4gKyAqIEBtYXA6IFBsYWNlaG9s
ZGVyIHRvIHJldHVybiBmb3VuZCBCTyBtYXBwaW5nCj4gICAqCj4gICAqIFNlYXJjaCB0aGUgYnVm
ZmVyIG9iamVjdHMgaW4gdGhlIGNvbW1hbmQgc3VibWlzc2lvbiBjb250ZXh0IGZvciBhIGNlcnRh
aW4KPiAgICogdmlydHVhbCBtZW1vcnkgYWRkcmVzcy4gUmV0dXJucyBhbGxvY2F0aW9uIHN0cnVj
dHVyZSB3aGVuIGZvdW5kLCBOVUxMCj4gLS0KPiAyLjI1LjEKPgo+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gZHJpLWRldmVsIG1haWxpbmcgbGlzdAo+
IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbApfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
