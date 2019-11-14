Return-Path: <SRS0=uNvg=ZG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439A9C432C3
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 16:03:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2060F206DB
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 16:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2060F206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB16F898EA;
	Thu, 14 Nov 2019 16:03:31 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25346898EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2019 16:03:30 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id t26so6516120wmi.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2019 08:03:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Vqkk//xNM0ic3V86IC1bP3Sf/sukkiTwORo2+htnzSE=;
 b=PXor24X+LwXDUFaRt/h8b5jMJfcKA7zEdClRmrzwdmFpy3t4G6SroeEsPtbMkwHtCV
 ww1uswvjdz/XOxOx1Vcy3Ox2FdeWdhO6/r8WUyB+GT/e/qg/6WvcLtiH7ej3dDCMSXLX
 LSgdly/Q3ek5M5Lw8h4XO9U1TorVTa1MuZCnXEByx1ncFSlJkZIWPz3pLNwIBPOWeE2V
 CQf/5n1v+ksttbWlFdZbcpInJwi7d6xhzrM2Mp0nvmAdh1EppAfHAsb3aOMwHjuMb4bS
 MNnpt/KiRWLPkx6eVVKPaiZGJ+zGn84ryyn3V2ItulgVbAQvLOPP0sBWqgVqXbNbPpAU
 hvPQ==
X-Gm-Message-State: APjAAAUITK//fsZ7yOsyX3VAmj9C/rpqLbTtRxbSaFG+JrRRENomaZGB
 2fCkmr5mZ5rFzBv//jb5AR36T8itxDGb3REVNXk=
X-Google-Smtp-Source: APXvYqwyiDvhT5QjChCKZEk7lpU66sqTJ3+5L7o6TtaKf2Xl/HJoq1Gz4k2yPrvdpOsCbWl4H4g5QdLfbBeWgNzDoEg=
X-Received: by 2002:a7b:cb89:: with SMTP id m9mr8562110wmi.141.1573747408572; 
 Thu, 14 Nov 2019 08:03:28 -0800 (PST)
MIME-Version: 1.0
References: <20191112180329.3927-1-leo.liu@amd.com>
 <20191112180329.3927-17-leo.liu@amd.com>
In-Reply-To: <20191112180329.3927-17-leo.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Nov 2019 11:03:14 -0500
Message-ID:
 <CADnq5_PTs-1fU3o3rpQ1hhAdbiicwixWMHuOxSbZ7bshMSBVxA@mail.gmail.com>
Subject: Re: [PATCH 16/21] drm/amdgpu: enable JPEG2.0 dpm
To: Leo Liu <leo.liu@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=Vqkk//xNM0ic3V86IC1bP3Sf/sukkiTwORo2+htnzSE=;
 b=B4ZKxayFe1+2jx/GThnvQacwqyNPQ9QabghKLzTFR8hvzbla8esFfMJ9pwYWpW+oS4
 5tfEdA2adkdYlx5dfvhTjDJiBsMd8hJVaRcknJQtzo0psFdt1mr2fnGHNoT4VxcUlcb1
 TDvChw7W+m0bekcEOnZjYlkj8n9iet0MSHjKl1vJsgLp87bVhckBg072m/Ylk3reDiPD
 1Iv/uq9Fmw/+tCLRIuivVrk24DTjz8E4UyG9B3jBUpHUPXw3+1jXLWmXi9AcT/5gXRn5
 rhc/uUivWdIJrrAEF7kw0EUcFn+5ExE+1G0xT2oTLMtwgUsE0sdf3cl1DFTT18T2kztG
 U2pg==
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191114160314.oEOGh_FcRMK_WoyOmOqBfFIJm-02Tgd_Zq2ohTzmXqo@z>

T24gVHVlLCBOb3YgMTIsIDIwMTkgYXQgMTowNCBQTSBMZW8gTGl1IDxsZW8ubGl1QGFtZC5jb20+
IHdyb3RlOgo+Cj4gQnkgdXNpbmcgaXRzIG93biBlbmFibGluZyBmdW5jdGlvbgo+Cj4gU2lnbmVk
LW9mZi1ieTogTGVvIExpdSA8bGVvLmxpdUBhbWQuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uYyB8ICA4ICsrKysrKysrCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5oIHwgIDEgKwo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9qcGVnX3YyXzAuYyB8IDEwICsrKysrKysrKy0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAxOCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcG0uYwo+IGluZGV4IGYyMDVmNTZlMzM1OC4uYjcxNTAxNzFlOGQ3IDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BtLmMKPiBAQCAtMjcxOCw2ICsyNzE4LDE0IEBA
IHZvaWQgYW1kZ3B1X3BtX3ByaW50X3Bvd2VyX3N0YXRlcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikKPgo+ICB9Cj4KPiArdm9pZCBhbWRncHVfZHBtX2VuYWJsZV9qcGVnKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2LCBib29sIGVuYWJsZSkKPiArewoKSSB3b3VsZCBhZGQgYW4gImlmIChp
c19zdXBwb3J0X3N3X3NtdShhZGV2KSkiIGNoZWNrIGhlcmUgaW4gY2FzZSB0aGlzCmV2ZXIgZ2V0
cyBjYWxsZWQgb24gb2xkZXIgYXNpY3MuICBPdGhlciB0aGFuIHRoYXQsIHRoZSBzZXJpZXMgKHdp
dGgKdGhlIHYyIHBhdGNoZXMpIGlzOgpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPgoKPiArICAgICAgIGludCByZXQgPSBzbXVfZHBtX3NldF9wb3dl
cl9nYXRlKCZhZGV2LT5zbXUsIEFNRF9JUF9CTE9DS19UWVBFX0pQRUcsIGVuYWJsZSk7Cj4gKyAg
ICAgICBpZiAocmV0KQo+ICsgICAgICAgICAgICAgICBEUk1fRVJST1IoIltTVyBTTVVdOiBkcG0g
ZW5hYmxlIGpwZWcgZmFpbGVkLCBzdGF0ZSA9ICVzLCByZXQgPSAlZC4gXG4iLAo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgZW5hYmxlID8gInRydWUiIDogImZhbHNlIiwgcmV0KTsKPiArfQo+
ICsKPiAgaW50IGFtZGdwdV9wbV92aXJ0X3N5c2ZzX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpCj4gIHsKPiAgICAgICAgIGludCByZXQgPSAwOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9wbS5oCj4gaW5kZXggZWYzMTQ0OGVlOGQ4Li4zZGExZGEyNzc4MDUgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BtLmgKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uaAo+IEBAIC00MSw1ICs0MSw2IEBA
IHZvaWQgYW1kZ3B1X3BtX2NvbXB1dGVfY2xvY2tzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KTsKPiAgdm9pZCBhbWRncHVfZHBtX3RoZXJtYWxfd29ya19oYW5kbGVyKHN0cnVjdCB3b3JrX3N0
cnVjdCAqd29yayk7Cj4gIHZvaWQgYW1kZ3B1X2RwbV9lbmFibGVfdXZkKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LCBib29sIGVuYWJsZSk7Cj4gIHZvaWQgYW1kZ3B1X2RwbV9lbmFibGVfdmNl
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBib29sIGVuYWJsZSk7Cj4gK3ZvaWQgYW1kZ3B1
X2RwbV9lbmFibGVfanBlZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgYm9vbCBlbmFibGUp
Owo+Cj4gICNlbmRpZgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9q
cGVnX3YyXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjJfMC5jCj4gaW5k
ZXggMzg2OTczMGIyMzMxLi5hNzgyOTJkODQ4NTQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvanBlZ192Ml8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9qcGVnX3YyXzAuYwo+IEBAIC0zMzMsNiArMzMzLDkgQEAgc3RhdGljIGludCBqcGVnX3Yy
XzBfc3RhcnQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAgICAgICBzdHJ1Y3QgYW1k
Z3B1X3JpbmcgKnJpbmcgPSAmYWRldi0+anBlZy5pbnN0LT5yaW5nX2RlYzsKPiAgICAgICAgIGlu
dCByOwo+Cj4gKyAgICAgICBpZiAoYWRldi0+cG0uZHBtX2VuYWJsZWQpCj4gKyAgICAgICAgICAg
ICAgIGFtZGdwdV9kcG1fZW5hYmxlX2pwZWcoYWRldiwgdHJ1ZSk7Cj4gKwo+ICAgICAgICAgLyog
ZGlzYWJsZSBwb3dlciBnYXRpbmcgKi8KPiAgICAgICAgIHIgPSBqcGVnX3YyXzBfZGlzYWJsZV9w
b3dlcl9nYXRpbmcoYWRldik7Cj4gICAgICAgICBpZiAocikKPiBAQCAtMzg4LDggKzM5MSwxMyBA
QCBzdGF0aWMgaW50IGpwZWdfdjJfMF9zdG9wKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+
Cj4gICAgICAgICAvKiBlbmFibGUgcG93ZXIgZ2F0aW5nICovCj4gICAgICAgICByID0ganBlZ192
Ml8wX2VuYWJsZV9wb3dlcl9nYXRpbmcoYWRldik7Cj4gKyAgICAgICBpZiAocikKPiArICAgICAg
ICAgICAgICAgcmV0dXJuIHI7Cj4KPiAtICAgICAgIHJldHVybiByOwo+ICsgICAgICAgaWYgKGFk
ZXYtPnBtLmRwbV9lbmFibGVkKQo+ICsgICAgICAgICAgICAgICBhbWRncHVfZHBtX2VuYWJsZV9q
cGVnKGFkZXYsIGZhbHNlKTsKPiArCj4gKyAgICAgICByZXR1cm4gMDsKPiAgfQo+Cj4gIC8qKgo+
IC0tCj4gMi4xNy4xCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
