Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C994C5DF64
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 17:20:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC3B217D7
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 17:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC3B217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8CD76EE05;
	Wed,  6 Nov 2019 17:19:59 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B451C6EDFE;
 Wed,  6 Nov 2019 17:19:57 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id a15so26845809wrf.9;
 Wed, 06 Nov 2019 09:19:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VEFt1uDyCOf9byzc/+I2oUmCLLbN+yoaKtpp3kXStiQ=;
 b=Wq+QRtZQLdnMJtNearmvGc26OApMrCtQsTPl0pNAFpZYSU89GiYWhzworneWOx9GYv
 zAutlOcMho9KBe8WvS0dr+3mFf2k6J4JeoW3ymaDDZxHQYo3Tv8Q+ShpaayMVy3k+Nxx
 xt+6iCGSSap+H/lIBc/N/vLy0n+/mbDIcWRqnjGrpEHydJ+BE5jyfc1lCoXFMBKi4tXK
 SlqQdCFp3ZZVDF5ril0RAjx4EP5h53OaTq79tO6RTIrMkjJwiTUOE/Qrg9EU2UiHHwkF
 U9v2/+1pwVUa5QN7JUVdsXS7/LP3hT/QONoPcO9jM3CJ7LgfWIIudhIJjz++3ynApeF7
 d6rA==
X-Gm-Message-State: APjAAAU7psKx8IJOel0uKlQbDC0+PcEeKYWVsdu5pk9Nqe069x/1gEqB
 JF1khV3E4AUVbH6CaDv4aUvw7klu7aOJg7VsJNDajQ==
X-Google-Smtp-Source: APXvYqxQDizOvsmqJu2teV0euv/pULrxf7co2fHWEzPJyNf1zIY7VU9n8EzZ9MflQsAg2oZCeCMFZG7HKHm9BnivS10=
X-Received: by 2002:a5d:4688:: with SMTP id u8mr3712583wrq.40.1573060796240;
 Wed, 06 Nov 2019 09:19:56 -0800 (PST)
MIME-Version: 1.0
References: <1573031685-25969-1-git-send-email-bianpan2016@163.com>
 <52555cc3-b8ea-63c0-1c8c-ae8318c4f469@amd.com>
In-Reply-To: <52555cc3-b8ea-63c0-1c8c-ae8318c4f469@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Nov 2019 12:19:43 -0500
Message-ID:
 <CADnq5_NogpdgxHhm-QnJmLBiVFOrjVRSAzfAr1U1YVuSz5CyOA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix potential double drop fence reference
To: "Koenig, Christian" <Christian.Koenig@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VEFt1uDyCOf9byzc/+I2oUmCLLbN+yoaKtpp3kXStiQ=;
 b=f+rwUzELPTt1/uRn0Z+NUjCwrKfI2KUgy6g4XjIOGJ7T5sRnNKQBsH/l0W5gHHQ79l
 KDRyJNWaDGGvaIQhHmtmUqE5m+CYEdkIYUyNM81xIQiIKiOypKsYybX50uGFCxNihVTV
 YXES3vtJz/ijYeJgc8VkfvdQoordEo2J83rziwHcCmnnyoxoO1SlZKvdeNrUoOJsoac1
 0RT5WZIRU7gbRHLeOVnX/RRoX7lTqPIVh4yRRTqJPArPzU3i5WqPNa5fkWjJ4AaRT2b6
 yqgksH4yvFJEnPu2jHwcBI7oNAU/PPX7p8/ZWlhIDZMUt+ich7OSagC0J9OcHzAE/18V
 PN0g==
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
Cc: "Zhou, David\(ChunMing\)" <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>, Pan Bian <bianpan2016@163.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191106171943.o5NPnkaerO3HFCT5AeSbBXpsylzdVBiH5DVRrp8UvyY@z>

T24gV2VkLCBOb3YgNiwgMjAxOSBhdCA0OjM5IEFNIEtvZW5pZywgQ2hyaXN0aWFuCjxDaHJpc3Rp
YW4uS29lbmlnQGFtZC5jb20+IHdyb3RlOgo+Cj4gQW0gMDYuMTEuMTkgdW0gMTA6MTQgc2Nocmll
YiBQYW4gQmlhbjoKPiA+IFRoZSBvYmplY3QgZmVuY2UgaXMgbm90IHNldCB0byBOVUxMIGFmdGVy
IGl0cyByZWZlcmVuY2UgaXMgZHJvcHBlZC4gQXMgYQo+ID4gcmVzdWx0LCBpdHMgcmVmZXJlbmNl
IG1heSBiZSBkcm9wcGVkIGFnYWluIGlmIGVycm9yIG9jY3VycyBhZnRlciB0aGF0LAo+ID4gd2hp
Y2ggbWF5IGxlYWQgdG8gYSB1c2UgYWZ0ZXIgZnJlZSBidWcuIFRvIGF2b2lkIHRoZSBpc3N1ZSwg
ZmVuY2UgaXMKPiA+IGV4cGxpY2l0bHkgc2V0IHRvIE5VTEwgYWZ0ZXIgZHJvcHBpbmcgaXRzIHJl
ZmVyZW5jZS4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBQYW4gQmlhbiA8YmlhbnBhbjIwMTZAMTYz
LmNvbT4KPgo+IEFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+CgpBcHBsaWVkLiAgdGhhbmtzIQoKQWxleAoKPgo+ID4gLS0tCj4gPiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90ZXN0LmMgfCAyICsrCj4gPiAgIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Rlc3QuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV90ZXN0LmMKPiA+IGluZGV4IGI2NmQyOWQ1ZmZhMi4uYjE1ODIzMGFmOGRiIDEwMDY0NAo+
ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Rlc3QuYwo+ID4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Rlc3QuYwo+ID4gQEAgLTEzOCw2
ICsxMzgsNyBAQCBzdGF0aWMgdm9pZCBhbWRncHVfZG9fdGVzdF9tb3ZlcyhzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldikKPiA+ICAgICAgICAgICAgICAgfQo+ID4KPiA+ICAgICAgICAgICAgICAg
ZG1hX2ZlbmNlX3B1dChmZW5jZSk7Cj4gPiArICAgICAgICAgICAgIGZlbmNlID0gTlVMTDsKPiA+
Cj4gPiAgICAgICAgICAgICAgIHIgPSBhbWRncHVfYm9fa21hcCh2cmFtX29iaiwgJnZyYW1fbWFw
KTsKPiA+ICAgICAgICAgICAgICAgaWYgKHIpIHsKPiA+IEBAIC0xODMsNiArMTg0LDcgQEAgc3Rh
dGljIHZvaWQgYW1kZ3B1X2RvX3Rlc3RfbW92ZXMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYp
Cj4gPiAgICAgICAgICAgICAgIH0KPiA+Cj4gPiAgICAgICAgICAgICAgIGRtYV9mZW5jZV9wdXQo
ZmVuY2UpOwo+ID4gKyAgICAgICAgICAgICBmZW5jZSA9IE5VTEw7Cj4gPgo+ID4gICAgICAgICAg
ICAgICByID0gYW1kZ3B1X2JvX2ttYXAoZ3R0X29ialtpXSwgJmd0dF9tYXApOwo+ID4gICAgICAg
ICAgICAgICBpZiAocikgewo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
