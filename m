Return-Path: <SRS0=SH5p=Z2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AA6C43603
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 13:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8436E20675
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 13:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8436E20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29CB86F4C7;
	Wed,  4 Dec 2019 13:50:28 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C3BF6F4C7
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2019 13:50:26 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id g17so8729434wro.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Dec 2019 05:50:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WTgSdkBwyPiiNGCsBNt+Og6HfDs7iEAPiJFXgjARK14=;
 b=C6X0zagRz+DYtDhvdCA5c5imJvHEAnVdHDFGQWJwzZSCwQ3naNXjHxy14EnHNz0ntR
 Ehtm78ouWPOx9VbrpwT7F/wrYccbxQNUcSW6Eoc1hxFO6U4W9TSJJLuBLWGwFL7pwF0t
 uBDueYsnBf2dMojY7AXsxxUHgS9xI0nU6fmu9WuTjpwnbLdG3ykF1diZOND7g4i/Xq7G
 CJRcTEorLHJmh4vy7AeOVjAYFeZD1pq9Ae/1JFcm7Pyb6tWyy6pVBWOQB5Ud0QH/0aMR
 mCigi6y5YS3wLeZNDeCSgge6589G6a+YuezaCwSJ/ys9i81+fT4xM7wm3vbbnSFwMwFR
 sTfA==
X-Gm-Message-State: APjAAAUsbNWeAAnDanY5DyGDE/FPSf529SwYWlWtAk2u3iiV33+qXSZ5
 RG61tEvMPkcG5PrxgfKTHQ18jCSit5CFOKngqRk=
X-Google-Smtp-Source: APXvYqw2dkBiRyrpc9ZKy1FAj0KgxxlvUhc0qrDFSZGOYEya1AoliqhaO3GQdyJZt6twXDL0beuTXGWz+FXgpOR3z08=
X-Received: by 2002:a5d:6a0f:: with SMTP id m15mr1862600wru.40.1575467425154; 
 Wed, 04 Dec 2019 05:50:25 -0800 (PST)
MIME-Version: 1.0
References: <20191204090344.17334-1-evan.quan@amd.com>
In-Reply-To: <20191204090344.17334-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Dec 2019 08:50:12 -0500
Message-ID: <CADnq5_P-DU2R8espA6LhyCPR8H6vmk2beQikF4dJiMwq0R4YRw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: drop unnecessary warning prompt
To: Evan Quan <evan.quan@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=WTgSdkBwyPiiNGCsBNt+Og6HfDs7iEAPiJFXgjARK14=;
 b=OBXd1rBkuJTHegLL73I7e0kpL1ya6unXuL+phV5TAvUA7yolI8fELECMwHD1AhHllB
 5ZW7Nzfkivk92VkoEQCe1UefP3wEubyt1dTmbmznupiBPL49EoC+H2UWiZPi+dq4ZGm2
 drCU/49y+hzsGct5+JMU922qO1+ycELy+bFl74aPgrGKPPHCnif7POSXd1xK5In+Bl1g
 MM+XQv3IAfh3zV+x8QsE4+u0oQEGI5fw5/thvb7XdbGL8EdncvFZgkDmp/h33cGgz8RH
 N36/uvl/C5dp1kpM+46ecSjGI49mzLbKEzahVP2O/9leYrPTay5nppoKlvd078VXXRSe
 jXXA==
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

T24gV2VkLCBEZWMgNCwgMjAxOSBhdCA0OjA0IEFNIEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5j
b20+IHdyb3RlOgo+Cj4gQXMgdGhlIGNoZWNrIG1heSBiZSBkb25lIHdpdGggcHVycG9zZSBhbmQg
dGhlIHdhcm5pbmcKPiBvdXRwdXQgd2lsbCBiZSBjb25mdXNpbmcuCj4KPiBDaGFuZ2UtSWQ6IEll
MDkyOGMzMjRhODE2MWQ0NDA2OGY4Y2U2NDhkNTZmNmQ5ZThjZDNkCj4gU2lnbmVkLW9mZi1ieTog
RXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KCkFja2VkLWJ5OiBBbGV4IERldWNoZXIgPGFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9hcmN0dXJ1c19wcHQuYyB8IDQgKy0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9hcmN0dXJ1c19wcHQuYwo+IGluZGV4IDNmMTM5ODZkOGU1MC4uNzBiMjk2YThmZWY4IDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FyY3R1cnVzX3BwdC5j
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMKPiBA
QCAtMjgwLDEwICsyODAsOCBAQCBzdGF0aWMgaW50IGFyY3R1cnVzX2dldF93b3JrbG9hZF90eXBl
KHN0cnVjdCBzbXVfY29udGV4dCAqc211LCBlbnVtIFBQX1NNQ19QT1dFUgo+ICAgICAgICAgICAg
ICAgICByZXR1cm4gLUVJTlZBTDsKPgo+ICAgICAgICAgbWFwcGluZyA9IGFyY3R1cnVzX3dvcmts
b2FkX21hcFtwcm9maWxlXTsKPiAtICAgICAgIGlmICghKG1hcHBpbmcudmFsaWRfbWFwcGluZykp
IHsKPiAtICAgICAgICAgICAgICAgcHJfd2FybigiVW5zdXBwb3J0ZWQgU01VIHBvd2VyIHNvdXJj
ZTogJWRcbiIsIHByb2ZpbGUpOwo+ICsgICAgICAgaWYgKCEobWFwcGluZy52YWxpZF9tYXBwaW5n
KSkKPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gLSAgICAgICB9Cj4KPiAgICAg
ICAgIHJldHVybiBtYXBwaW5nLm1hcF90bzsKPiAgfQo+IC0tCj4gMi4yNC4wCj4KPiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGlu
ZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
