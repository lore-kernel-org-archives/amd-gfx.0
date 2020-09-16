Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D44C433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 20:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10153206B7
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 20:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lq8Jwawb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10153206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 761136E07D;
	Wed, 16 Sep 2020 20:11:39 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FD3C6E07D
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 20:11:39 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id y15so4323449wmi.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 13:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GQx/JKfcAktUHydb9jnwYbuataL36V+e9cZWbvY/1AY=;
 b=lq8JwawbJdEkJ7FfsFkfmT7+Uv2FdGPfjnAp18yRCjcfogg4iG42Nle1dRxOMMO8Xk
 7Lp7qT2ivWop4KCA46rU9UCzjWmjs5eylhpLxg6izHP6x6ShMzlKWhphZUIVvnHQSdqW
 ktnCDmDWt/H7N/ZGl7ZSpIlogi6Xrvja6bOZE0jCZ7pHzgdxRYCPRJlLN4yzdRgYWeg4
 k1zOc+Y1gNgErPPKyomas98cO+s8vnghdhvgD8eL8b/gGG8wbODIga16wnRppWeKPCte
 Rbp7+DNrLyrq1RO954FJud+fvQ1F4AsgcEDs9ro96Awafsicv2spdVsb68U7HyVfkiXv
 q4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GQx/JKfcAktUHydb9jnwYbuataL36V+e9cZWbvY/1AY=;
 b=IgubPOnvepMEPiTHoHzTmixRkCHF68Q8PBZfRus7hOGDlzJO9m9KWDrJvt+/InfP+y
 XFTI7VnqO9zHdofq7ButV1S6FT6Nhp5OInOR8PvWyHRhxqjgBO35T+bpjlGzn9yj19Hn
 5U97bKLudrRhpSXjRFYDiiS+q67LcBl9JlQIGHsLGV8ihs+MS26KI0BIhVmaHR52uowb
 i3pPtqb1d1m23cKDshNTR3BQTKGx8HEA5dRdvub1AOcajeah/l+j8Mpe0dla28s+d2Rl
 e0CPNlyveNxRQPVY6jUv9s/HOPCmarFu5+DJ4z4waDjMnLqKA7Nr6RmefhdfagGg7V14
 kxZg==
X-Gm-Message-State: AOAM533K7l4sUfO/bjrA/RvJS2XOxeG35dlO02picVb1uo/6LK4yukTi
 H6bhKC2C6z1gTlUtZ3W5pDwKubZZ4c/ipgkvoLs=
X-Google-Smtp-Source: ABdhPJxJmYNbnJ0z2BTcKk/FCQ7oHruS2JZjDc9gih43r++FnLAZydpMSIgpweHKnFQR2QDMeesH6XxFKhIebfoTMug=
X-Received: by 2002:a7b:c141:: with SMTP id z1mr6646289wmi.79.1600287097853;
 Wed, 16 Sep 2020 13:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200916010858.83903-1-yebin10@huawei.com>
In-Reply-To: <20200916010858.83903-1-yebin10@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Sep 2020 16:11:27 -0400
Message-ID: <CADnq5_No_dB8BKOAcOwCuqfvi8kE2RPD775WmZhhGUYFA1m5KQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove set but used 'temp'
To: Ye Bin <yebin10@huawei.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBTZXAgMTUsIDIwMjAgYXQgMTE6MzQgUE0gWWUgQmluIDx5ZWJpbjEwQGh1YXdlaS5j
b20+IHdyb3RlOgo+Cj4gQWRkcmVzc2VzIHRoZSBmb2xsb3dpbmcgZ2NjIHdhcm5pbmcgd2l0aCAi
bWFrZSBXPTEiOgo+Cj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1Ly4uL2Rpc3BsYXkvZG11Yi9zcmMvLi4vZG11Yl9zcnYuaDo2NzowLAo+ICAgICAgICAg
ZnJvbSBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RtdWIvc3JjL2RtdWJf
ZGNuMjEuYzoyNjoKPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RtdWIv
c3JjLy4uL2luYy9kbXViX2NtZC5oOiBJbiBmdW5jdGlvbiDigJhkbXViX3JiX2ZsdXNoX3BlbmRp
bmfigJk6Cj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kbXViL3NyYy8u
Li9pbmMvZG11Yl9jbWQuaDo3OTU6MTI6IHdhcm5pbmc6IHZhcmlhYmxlIOKAmHRlbXDigJkgc2V0
IGJ1dCBub3QgdXNlZAo+ICBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0KPiAgICAgdWludDY0
X3QgdGVtcDsKPiAgICAgICAgICAgICAgICAgXgo+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RtdWIvc3JjLy4uL2RtdWJfc3J2Lmg6
Njc6MCwKPiAgICAgICAgICAgICAgICAgIGZyb20gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Li4vZGlzcGxheS9kbXViL3NyYy9kbXViX2RjbjMwLmM6MjY6Cj4gZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvLi4vZGlzcGxheS9kbXViL3NyYy8uLi9pbmMvZG11Yl9jbWQuaDogSW4gZnVuY3Rp
b24g4oCYZG11Yl9yYl9mbHVzaF9wZW5kaW5n4oCZOgo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1Ly4uL2Rpc3BsYXkvZG11Yi9zcmMvLi4vaW5jL2RtdWJfY21kLmg6Nzk1OjEyOiB3YXJuaW5n
OiB2YXJpYWJsZSDigJh0ZW1w4oCZIHNldCBidXQgbm90IHVzZWQKPiBbLVd1bnVzZWQtYnV0LXNl
dC12YXJpYWJsZV0KPiAgICB1aW50NjRfdCB0ZW1wOwo+Cj4gUmVwb3J0ZWQtYnk6IEh1bGsgUm9i
b3QgPGh1bGtjaUBodWF3ZWkuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFllIEJpbiA8eWViaW4xMEBo
dWF3ZWkuY29tPgoKQXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kbXViL2luYy9kbXViX2NtZC5oIHwgNCArLS0tCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9pbmMvZG11Yl9jbWQuaCBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kbXViL2luYy9kbXViX2NtZC5oCj4gaW5kZXggZDdlN2YyZWRh
OTJmLi5lMzI4MjhmZmMzZTAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RtdWIvaW5jL2RtdWJfY21kLmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZG11Yi9pbmMvZG11Yl9jbWQuaAo+IEBAIC03OTEsMTIgKzc5MSwxMCBAQCBzdGF0aWMgaW5s
aW5lIHZvaWQgZG11Yl9yYl9mbHVzaF9wZW5kaW5nKGNvbnN0IHN0cnVjdCBkbXViX3JiICpyYikK
Pgo+ICAgICAgICAgd2hpbGUgKHJwdHIgIT0gd3B0cikgewo+ICAgICAgICAgICAgICAgICB1aW50
NjRfdCB2b2xhdGlsZSAqZGF0YSA9ICh1aW50NjRfdCB2b2xhdGlsZSAqKXJiLT5iYXNlX2FkZHJl
c3MgKyBycHRyIC8gc2l6ZW9mKHVpbnQ2NF90KTsKPiAtICAgICAgICAgICAgICAgLy91aW50NjRf
dCB2b2xhdGlsZSAqcCA9ICh1aW50NjRfdCB2b2xhdGlsZSAqKWRhdGE7Cj4gLSAgICAgICAgICAg
ICAgIHVpbnQ2NF90IHRlbXA7Cj4gICAgICAgICAgICAgICAgIGludCBpOwo+Cj4gICAgICAgICAg
ICAgICAgIGZvciAoaSA9IDA7IGkgPCBETVVCX1JCX0NNRF9TSVpFIC8gc2l6ZW9mKHVpbnQ2NF90
KTsgaSsrKQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHRlbXAgPSAqZGF0YSsrOwo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICpkYXRhKys7Cj4KPiAgICAgICAgICAgICAgICAgcnB0ciArPSBE
TVVCX1JCX0NNRF9TSVpFOwo+ICAgICAgICAgICAgICAgICBpZiAocnB0ciA+PSByYi0+Y2FwYWNp
dHkpCj4gLS0KPiAyLjE2LjIuZGlydHkKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
