Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631ABC43603
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 22:12:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39D7420659
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 22:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D7420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E91146F912;
	Thu,  5 Dec 2019 22:12:47 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B1E06F912
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 22:12:46 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id p9so5717779wmc.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Dec 2019 14:12:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z59cP7IJ2xyIwdgHITy7GBFMbEnvhRR1iA/eK0WfT4o=;
 b=PXZ7kus3o/jUwHlD/WP6RH/cRXfM+NPhe/klljSIIgZwMIvCN/PaHd7y3LDXLK8lEE
 e3UjjQoV5DxLZtS649ImjOGhVHod02MzATpl9S5feq5FwLdOLcwFOX9LxmsNI7sNmHc9
 nGE6Y/wKj4RontppnMNP49dNQR21qLuBLmX7GV4KoQ3GimK2OjB16/oOyQAgFSTsiAQZ
 rtmKs7ne3GJQ2xO0xLsOfBJwStXnBHwqfIzgxLHnDV9yEMgEpCiH0XmItbulUf292TeF
 AjEi5fQg7cFgJhuIQ7toa3NRP3oXzJt2WiYICKuhjdeZuUT2filokWZSl14m39vxB0ex
 15Sw==
X-Gm-Message-State: APjAAAWw64jhjp3+NHBSlkOwrOiJ2PIZJg0b07k+4T2LbMvHFjLSigZC
 JumUJC2aeO2dLoFzNVy58CfiiQhPQJJqE+/hKsI=
X-Google-Smtp-Source: APXvYqyEtX4DwinS9CWHB1McmyrQiZM6OAvFJuuYo8wGM6wLTM4Zn6rRbVdRxYNJJVS46u/CNp+rDpp8NQOny+tgJlw=
X-Received: by 2002:a1c:4454:: with SMTP id r81mr7448292wma.143.1575583965118; 
 Thu, 05 Dec 2019 14:12:45 -0800 (PST)
MIME-Version: 1.0
References: <20191205213904.278244-1-alexander.deucher@amd.com>
 <DM6PR12MB3466EA1AD3EB09CE509900B19E5C0@DM6PR12MB3466.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3466EA1AD3EB09CE509900B19E5C0@DM6PR12MB3466.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Dec 2019 17:12:33 -0500
Message-ID: <CADnq5_Nqy+thHD-9jirZD9h=J+gE9_NnTwrzD3K-ZkvVJ0UHgQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: add fallthrough comment
To: "Liu, Zhan" <Zhan.Liu@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=z59cP7IJ2xyIwdgHITy7GBFMbEnvhRR1iA/eK0WfT4o=;
 b=fvmgIsW5ksfI+fluaQI1bxKo7VXwfZcLJ31FqcOsGdXDMMC6Dy4S6CSqwIWkK1M4fk
 lEzp8PNHID3Ybnm53eaik/gq2QPtJ711+O2xRNzM1PNVLsiBxe8/q6HuifeBMTkjOGoi
 p2Yj21zmzmal6Orxcb1DzXk/7bvcluLQqwz8SKqkgblxr0Z10rDVU5tqOQJmoL44Lp61
 9UBLhQV0KW9QCY6D+2CIF56N+HtK6iPWK5RyZfnGwhLyB2gk4LchMnds2dt9bAhuaEPe
 /uenoXp/E9Fd9KgpCr1XzJ/KNUypy2d3/Ze36mzifw62UB0prssrk60Xs+0tqhl8+2hB
 /fkg==
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCBEZWMgNSwgMjAxOSBhdCA1OjEwIFBNIExpdSwgWmhhbiA8Wmhhbi5MaXVAYW1kLmNv
bT4gd3JvdGU6Cj4KPgo+Cj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+ID4gRnJvbTog
YW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxm
IE9mIEFsZXgKPiA+IERldWNoZXIKPiA+IFNlbnQ6IDIwMTkvRGVjZW1iZXIvMDUsIFRodXJzZGF5
IDQ6MzkgUE0KPiA+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+ID4gQ2M6IERl
dWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4KPiA+IFN1YmplY3Q6
IFtQQVRDSF0gZHJtL2FtZGdwdS9kaXNwbGF5OiBhZGQgZmFsbHRocm91Z2ggY29tbWVudAo+ID4K
PiA+IFRvIGF2b2lkIGEgY29tcGlsZXIgd2FybmluZy4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gPiAtLS0KPiA+ICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9hdXguYyB8IDEgKwo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9hdXguYwo+ID4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9hdXguYwo+ID4gaW5kZXggMTkxYjY4YjgxNjNhLi5mMWE1
ZDJjNmFhMzcgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
ZGNlL2RjZV9hdXguYwo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Rj
ZS9kY2VfYXV4LmMKPiA+IEBAIC02NDUsNiArNjQ1LDcgQEAgYm9vbCBkY2VfYXV4X3RyYW5zZmVy
X3dpdGhfcmV0cmllcyhzdHJ1Y3QKPiA+IGRkY19zZXJ2aWNlICpkZGMsCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgY2FzZSBBVVhfVFJBTlNBQ1RJT05fUkVQTFlfQVVYX0RFRkVSOgo+ID4gICAg
ICAgICAgICAgICAgICAgICAgIGNhc2UKPiA+IEFVWF9UUkFOU0FDVElPTl9SRVBMWV9JMkNfT1ZF
Ul9BVVhfREVGRVI6Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXRyeV9vbl9k
ZWZlciA9IHRydWU7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBmYWxsIHRo
cm91Z2ggKi8KPgo+IEkgYW0gYSBiaXQgY29uZnVzaW5nIGhlcmUuIFdoeSBhIGNvbW1lbnQgY2Fu
IGF2b2lkIGEgY29tcGlsZXIgd2FybmluZz8KClRoZSBrZXJuZWwgZW5hYmxlcyBmYWxsIHRocm91
Z2ggd2FybmluZ3MsIHNvIHVubGVzcyB0aGVyZSBpcyBhIGNvbW1lbnQKbWVudGlvbmluZyB0aGF0
IGFyZSBhcmUgZXhwZWN0aW5nIHRvIGZhbGwgdGhyb3VnaCBoZXJlLCB3ZSBnZXQgYQp3YXJuaW5n
LiAgVGhlIGlkZWEgaXMgdG8gZmluZCBtaXNzaW5nIGJyZWFrcyBpbiBzd2l0Y2ggY29kZS4KCkFs
ZXgKCj4KPiA+ICAgICAgICAgICAgICAgICAgICAgICBjYXNlCj4gPiBBVVhfVFJBTlNBQ1RJT05f
UkVQTFlfSTJDX09WRVJfQVVYX05BQ0s6Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBpZiAoKythdXhfZGVmZXJfcmV0cmllcyA+PQo+ID4gQVVYX01BWF9ERUZFUl9SRVRSSUVTKSB7
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZmFpbDsKPiA+
IC0tCj4gPiAyLjIzLjAKPiA+Cj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwo+ID4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiA+IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCj4gPiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91
dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy4KPiA+IGZyZWVkZXNrdG9wLm9yZyUy
Rm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC0KPiA+IGdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDemhh
bi5saXUlNDBhbWQuY29tJTdDNzdkODVhMDI3NWFhNGMwYTc4Cj4gPiAyZjA4ZDc3OWNiOTcxNiU3
QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Cj4gPiAzNzExMTc4
ODIwODcwMjM0MCZhbXA7c2RhdGE9M20lMkZ1TnVOSWdxODJ6JTJCQWVYSjl5N3duODFrViUKPiA+
IDJGaUR0M0F5QzNDRGlUUnJjJTNEJmFtcDtyZXNlcnZlZD0wCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeA==
