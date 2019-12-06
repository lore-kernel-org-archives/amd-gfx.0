Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76300C2D0C2
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 13:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50ECF20706
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 13:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50ECF20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16BB76FA27;
	Fri,  6 Dec 2019 13:58:57 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1A0A6FA27
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 13:58:55 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id g17so7901745wro.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Dec 2019 05:58:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aTpHsrWOf5LBr5T/bAA+kMwchFBNwA6ocU2D9qb/HHY=;
 b=qNgI+H7hQUNZoK+aZl9rHDRH+5N7PHKAIajVYNVtPLIwL8wgNVpNHTHH/yAH/M0ufw
 B1G6efqqTvl1vZ+Z/KL2Q5bE8IetEW+Vqw+by6J9eMuP5DqZwd813ri3X/5sJj86jtsK
 xVMqHAV04p+xQaLqf34W/IMnOS0ZrfmOBAPhrpbLSa9ZsSDnC894NT0J1bJFfzGR+SeZ
 RV15gsnmkSxQlNtsd1q1F2jTdd0XJSOIIs0KDAB6JwqOq+Q2D3+eV+pvxrMnUHuxjSLx
 V3/FG2vZLm7LfapuONk/KN+vqZ3Du9QEddFThcMfWXuszTg2akZRyJZW5EKdH2OCU3jo
 oYzg==
X-Gm-Message-State: APjAAAXSXCgnEtmKsezYAypolRV2nxuGmj35K9vN3ypmO5bxfHEhEKAU
 ZFj9TQNdJ4YhLrwcsi5AS2lynQLp0aIrplHJ/f8=
X-Google-Smtp-Source: APXvYqzZb0HpWSuDcI+S3p2YQt4qvbhbzhg+QXX4YlqwzFZE6hvmcJOTJeEFXBN+CMwNafef5ykdbUFCYbxft7sHA5I=
X-Received: by 2002:a5d:6886:: with SMTP id h6mr15802119wru.154.1575640734428; 
 Fri, 06 Dec 2019 05:58:54 -0800 (PST)
MIME-Version: 1.0
References: <20191206033543.3131-1-evan.quan@amd.com>
In-Reply-To: <20191206033543.3131-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 Dec 2019 08:58:43 -0500
Message-ID: <CADnq5_M+90MX=04BZC5skrjE3pQUVNXmAjEhVxSf6EiNhufYFg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: clear VBIOS scratchs on baco exit
To: Evan Quan <evan.quan@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=aTpHsrWOf5LBr5T/bAA+kMwchFBNwA6ocU2D9qb/HHY=;
 b=Enub1E+qjnUCQKv8n2gydTon4PH2svnlcZm9t8nJnMX6+aynjLN5H7uUkju2BwCemR
 6xDNKP3Z/mdxCGH0hSVaemSrtNIqhJf+nHiP+qvZj0MUQLNE+zjQWivA5AOcOy4gQfsg
 AtKSGMUAFWxBBZl5HUY7ZUvlkfW+H/SxslthemqQZIhb9XzRX7/MDFyH5SiOhZpg6bCq
 fZ46thpBUgW02AZeKQ+zz5V5tqwcnOWtV9rq2PrPOFddN8qj577sGGSTFTp+Handw/cu
 hDBF+ZWs3SdCh+T3kFdwL9gQY39R+G7DgVaC0NAyzoxxCtRNHc2eORFF6xrzcNUPKR+W
 f0hQ==
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
Cc: Zhigang.Luo@amd.com, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCBEZWMgNSwgMjAxOSBhdCAxMDozNiBQTSBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQu
Y29tPiB3cm90ZToKPgo+IFRoaXMgaXMgbmVlZGVkIGZvciBjb21pbmcgYXNpYyBpbml0IG9uIHBl
cmZvcm1pbmcgZ3B1IHJlc2V0Lgo+Cj4gQ2hhbmdlLUlkOiBJZjM2NzFhMjRkMjM5ZTNkMjg4NjY1
ZmFkYWEyYzQwYzg3ZDVkYTQwYgo+IFNpZ25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFu
QGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFf
MC5jIHwgNiArKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQo+Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMKPiBpbmRleCAzOWVjMDZhZWU4
MDkuLmFiODA5ZGY3YmMzNSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9zbXVfdjExXzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3Nt
dV92MTFfMC5jCj4gQEAgLTE2NTksNiArMTY1OSwxMiBAQCBpbnQgc211X3YxMV8wX2JhY29fc2V0
X3N0YXRlKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCBlbnVtIHNtdV9iYWNvX3N0YXRlIHN0YXRl
KQo+ICAgICAgICAgICAgICAgICB9Cj4gICAgICAgICB9IGVsc2Ugewo+ICAgICAgICAgICAgICAg
ICByZXQgPSBzbXVfc2VuZF9zbWNfbXNnKHNtdSwgU01VX01TR19FeGl0QmFjbyk7Cj4gKyAgICAg
ICAgICAgICAgIGlmIChyZXQpCj4gKyAgICAgICAgICAgICAgICAgICAgICAgZ290byBvdXQ7Cj4g
Kwo+ICsgICAgICAgICAgICAgICBXUkVHMzJfU09DMTUoTkJJTywgMCwgbW1CSU9TX1NDUkFUQ0hf
NiwgMCk7Cj4gKyAgICAgICAgICAgICAgIFdSRUczMl9TT0MxNShOQklPLCAwLCBtbUJJT1NfU0NS
QVRDSF83LCAwKTsKClBsZWFzZSB1c2U6CldSRUczMihhZGV2LT5iaW9zX3NjcmF0Y2hfcmVnX29m
ZnNldCArIDYsIDApOwpXUkVHMzIoYWRldi0+Ymlvc19zY3JhdGNoX3JlZ19vZmZzZXQgKyA3LCAw
KTsKU28gd2UgZG9uJ3QgaGF2ZSB0byB3b3JyeSBhYm91dCBhc2ljIHNwZWNpZmljIHNjcmF0Y2gg
cmVnaXN0ZXIgb2Zmc2V0cy4KCj4gKwo+ICAgICAgICAgICAgICAgICBiaWZfZG9vcmJlbGxfaW50
cl9jbnRsID0gUkVHX1NFVF9GSUVMRChiaWZfZG9vcmJlbGxfaW50cl9jbnRsLAo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJJRl9ET09SQkVMTF9JTlRf
Q05UTCwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBE
T09SQkVMTF9JTlRFUlJVUFRfRElTQUJMRSwgMCk7Cj4gLS0KPiAyLjI0LjAKPgo+IF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5n
IGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZng=
