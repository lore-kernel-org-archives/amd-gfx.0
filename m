Return-Path: <SRS0=uNvg=ZG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FF6C43141
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 20:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68CD220679
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 20:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68CD220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDCC56EF2B;
	Thu, 14 Nov 2019 20:11:39 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13E166EF2A;
 Thu, 14 Nov 2019 20:11:38 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id i12so8120479wro.5;
 Thu, 14 Nov 2019 12:11:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y4hdHdRBUC8JqWM6F1BxW7P5Ys4p04wGlCPsa5sNxgE=;
 b=V9pF9ar3k9FQ3qSxePFpu9tYqqB4xpR9zZ4FH/EcKmMtzQJ7Pc5Vu7p9QpqR3pTI5u
 Klf/AAKaXSSsqzARPFllzhVJ4EvV1iPLrJlqVhiJfbjgYE8h3vl4dB+st/rJhZlxLHwn
 s3jqti9Qhrz8eOrmnAuDd4xH54rHc90dmso7b/C72s7iWh+z8dOHkp9lNyAvbbr97XzL
 H3cX1LiflNfagzINIHgPURpNm3VThUE4QnHZl6Sd/6Mjbhflcs+lx2rJAEbs66Ar1UrK
 6LndpbrmBGT0KKmNH6Rekjk5wZMXbldPop4AtD1UHr3M5wGg1Amyi+AF4bHRRc8MMEZ3
 Ar0g==
X-Gm-Message-State: APjAAAXjpDJMOSxi7QMxB0wj3rPoQj/9rPfYQN19jx7Dvc9QCoJJ3qse
 J0P3zgWSLfhoGYRuvvp/yRsahoblcpqXrmPfVgQ=
X-Google-Smtp-Source: APXvYqxxl/ssXWFhKF62T2yks/7TqOejA7M6dHVcRiZht+SDb13PfhhgatTgkw1ukV82ik63fjj2qr8ZMhY7zLSvMXo=
X-Received: by 2002:adf:fb0b:: with SMTP id c11mr10783667wrr.50.1573762295542; 
 Thu, 14 Nov 2019 12:11:35 -0800 (PST)
MIME-Version: 1.0
References: <1573734987-119703-1-git-send-email-zhengbin13@huawei.com>
 <e1bfa8cc-1552-9f81-3705-ef6b832461c8@amd.com>
In-Reply-To: <e1bfa8cc-1552-9f81-3705-ef6b832461c8@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Nov 2019 15:11:23 -0500
Message-ID:
 <CADnq5_NhHCg80K6FA9nxost=1wqaLDc3dM6u-Q+hd003PMfjdg@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/amd/display: remove some set but not used
 variables
To: Harry Wentland <hwentlan@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=y4hdHdRBUC8JqWM6F1BxW7P5Ys4p04wGlCPsa5sNxgE=;
 b=a3gax86FtdcnY78DGlr+/q7e42Akebwcs2M9Z5IQuhtT/9xjUw5hCto7SI8pb869UV
 GPpfLhQV6nJqDkAry1q6VD7Rs16fhHIJVgZChU4EuaAGS4gv2F7iwl0NiBOSwPhxQvbU
 s7gItiwKDPXx7oJxg+3To/AdrayMi7h0kM9K/f9YCVkEJWjqAT0S/0xFnc2zAb/2fzSv
 w8//t47uG5FGuUGuCfxnxn4tRSUPrFqceeTSmx+6yd+hSEuYQKoBMGue2ejkyHGKDAbF
 5uuV+YjruQ5fqSbeNcRFBdgFWCGxLzfXqhJFyVG2DvnNf7qbRJU1qKe5/rIfaeh/FVlh
 hJRA==
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
Cc: Chunming Zhou <David1.Zhou@amd.com>,
 "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, zhengbin <zhengbin13@huawei.com>,
 Dave Airlie <airlied@linux.ie>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191114201123.R-2G1616h3TXNglgPTh7_6T4YnVCl1uvgeHo7av9tNo@z>

T24gVGh1LCBOb3YgMTQsIDIwMTkgYXQgMTE6NDEgQU0gSGFycnkgV2VudGxhbmQgPGh3ZW50bGFu
QGFtZC5jb20+IHdyb3RlOgo+Cj4gT24gMjAxOS0xMS0xNCA3OjM2IGEubS4sIHpoZW5nYmluIHdy
b3RlOgo+ID4gemhlbmdiaW4gKDQpOgo+ID4gICBkcm0vYW1kL2Rpc3BsYXk6IHJlbW92ZSBzZXQg
YnV0IG5vdCB1c2VkIHZhcmlhYmxlICdvbGRfcGxhbmVfY3J0YycKPiA+ICAgZHJtL2FtZC9kaXNw
bGF5OiByZW1vdmUgc2V0IGJ1dCBub3QgdXNlZCB2YXJpYWJsZSAnYnAnIGluCj4gPiAgICAgYmlv
c19wYXJzZXIyLmMKPiA+ICAgZHJtL2FtZC9kaXNwbGF5OiByZW1vdmUgc2V0IGJ1dCBub3QgdXNl
ZCB2YXJpYWJsZSAnYnAnIGluCj4gPiAgICAgYmlvc19wYXJzZXIuYwo+ID4gICBkcm0vYW1kL2Rp
c3BsYXk6IHJlbW92ZSBzZXQgYnV0IG5vdCB1c2VkIHZhcmlhYmxlICdtaW5fY29udGVudCcKPiA+
Cj4KPiBUaGVzZSB3b3VsZCBiZSBmaW5lIGFzIGEgc2luZ2xlIHBhdGNoIGFzIHdlbGwgYnV0IEkg
ZG9uJ3QgaGF2ZSBhIHN0cm9uZwo+IHByZWZlcmVuY2UgZWl0aGVyIHdheS4KPgo+IFBhdGNoZXMg
YXJlOgo+IFJldmlld2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNv
bT4KCkFwcGxpZWQuICBUaGFua3MhCgpBbGV4Cgo+Cj4gSGFycnkKPgo+ID4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgICAgICAgfCAzICstLQo+ID4g
IGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iaW9zL2Jpb3NfcGFyc2VyLmMgICAgICAg
fCAyIC0tCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3MvYmlvc19wYXJz
ZXIyLmMgICAgICB8IDIgLS0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxl
cy9jb2xvci9jb2xvcl9nYW1tYS5jIHwgMiAtLQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDggZGVsZXRpb25zKC0pCj4gPgo+ID4gLS0KPiA+IDIuNy40Cj4gPgo+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gZHJpLWRldmVsIG1h
aWxpbmcgbGlzdAo+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbApfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
