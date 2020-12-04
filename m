Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C08C433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 20:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E53022CE3
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 20:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E53022CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E98246EC6F;
	Fri,  4 Dec 2020 20:55:08 +0000 (UTC)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 728E26EC6F
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 20:55:07 +0000 (UTC)
Received: by mail-oi1-x243.google.com with SMTP id x16so7684882oic.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Dec 2020 12:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YRUbjlKe92QEY2CfZXnGa/m0VPFFQVH2yUT6ZoeiXl8=;
 b=lJDa2FmIC2me/YmGORnXgZvQAYjsveyS6BimUSNzITmxrhP971fWRkGI9ajrQe+C38
 caPK3GVXnGQ7/POnJN4nuqdBV47E+VQNek5MOq/7W+dXZMFp8mXM12wVo8Yksil22JUk
 qmS+oob0htMnPWbv1CLB1NU2WteIjhU9taalSJIfESQ5y7RNpNepgjnUghXcJPz1J2Jl
 IiUte6b4mEEWvAaN/0L9OlF+dnu800JBWxHYk29YgfDTPrH4LFucPKF3g4W3T+yXrZMf
 6iAwR1wUPiat9fu+nRV/WAqL/M4pWytYoTav2PWg95SM0Yag+Fc1kEIcWp0tRULEWgH7
 64nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YRUbjlKe92QEY2CfZXnGa/m0VPFFQVH2yUT6ZoeiXl8=;
 b=YqLOeua67Yh5WnAzTiroWmT7BO5GmBwYjo+abb236oG0uuUQebtSaiQu0ufdGZvtoo
 cGoxlH6LY5Ivc9Y7drb6RnJZ024Xo401IJbfCh8I8BtH140xAMKUz+xhqS6MBk4Ks4I5
 3p6x+TwLJ+qtLrywJTlEBQsQXP3jhZgxKUePU5c3LOY/DHaLgQTXXM+I/eX4EdLGXq0S
 iEzSOyFEFoMGSBZtc6ZZCh34BKOdzGRGgQmqNzTqRCYxGiqaweOqyZzbyd0WBJGy4Ov4
 Tc3c3VVFgL9186ItUW7P/W0EyKqlCKAdeiiTvjpfEPA6UKHvoDF6y7K4tbhnOGn/dATX
 nyLA==
X-Gm-Message-State: AOAM532U3eJMmvVAj+2rZWmWiChKyds83k6fZ12s+mcKWF96mcAMfvxA
 jeBQvLhdAugNKVD3feP09JYEtKqXJnECrxxV7kA=
X-Google-Smtp-Source: ABdhPJxtRMkduWCRiSyZ8Puilncf7XqmjViDnloGT7/jISz/bWAObFdVpbsI5Ug6ekb3d36CpZHOYJothvI5K8v9D8s=
X-Received: by 2002:a54:4608:: with SMTP id p8mr4362569oip.5.1607115306823;
 Fri, 04 Dec 2020 12:55:06 -0800 (PST)
MIME-Version: 1.0
References: <VzE0LPxcEehXwGUjgu3nUHOAd2MMYp2hKFqOo4BSJY@cp3-web-021.plabs.ch>
In-Reply-To: <VzE0LPxcEehXwGUjgu3nUHOAd2MMYp2hKFqOo4BSJY@cp3-web-021.plabs.ch>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 4 Dec 2020 15:54:55 -0500
Message-ID: <CADnq5_NrMczeDcsHgfBZ6gbnbozAEZhMW2TvBrk8pcTBSdV4Jg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd: print error on
 convert_tiling_flags_to_modifier failure
To: Simon Ser <contact@emersion.fr>
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
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBEZWMgNCwgMjAyMCBhdCAxMTo0OSBBTSBTaW1vbiBTZXIgPGNvbnRhY3RAZW1lcnNp
b24uZnI+IHdyb3RlOgo+Cj4gSWYgdGhpcyBmdW5jdGlvbiBmYWlscywgaXQgbWVhbnMgdGhlIHRp
bGluZyBmbGFncyBkaWRuJ3QgbWFrZSBzZW5zZS4KPiBUaGlzIGxpa2VseSBpbmRpY2F0ZXMgYSB1
c2VyLXNwYWNlIGJ1Zy4gTG9nIHRoZSBlcnJvciBhbG9uZ3NpZGUgd2l0aCB0aGUKPiBwcm92aWRl
ZCB0aWxpbmcgZmxhZ3MgdG8gbWFrZSBkZWJ1Z2dpbmcgZWFzaWVyLgo+Cj4gU2lnbmVkLW9mZi1i
eTogU2ltb24gU2VyIDxjb250YWN0QGVtZXJzaW9uLmZyPgo+IENjOiBBbGV4IERldWNoZXIgPGFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6IEhhcnJ5IFdlbnRsYW5kIDxod2VudGxhbkBh
bWQuY29tPgo+IENjOiBOaWNob2xhcyBLYXpsYXVza2FzIDxuaWNob2xhcy5rYXpsYXVza2FzQGFt
ZC5jb20+Cj4gQ2M6IEJhcyBOaWV1d2VuaHVpemVuIDxiYXNAYmFzbmlldXdlbmh1aXplbi5ubD4K
PiBDYzogTWljaGVsIETDpG56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD4KCkFwcGxpZWQgdGhlIHNl
cmllcy4gIFRoYW5rcyEKCkFsZXgKCgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGlzcGxheS5jIHwgNSArKysrLQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kaXNwbGF5LmMKPiBpbmRleCA3M2I4NWRhMmNjYmYuLmU5MGJlMmU4ZWIyYSAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5jCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYwo+IEBAIC05MDEs
OCArOTAxLDExIEBAIGludCBhbWRncHVfZGlzcGxheV9mcmFtZWJ1ZmZlcl9pbml0KHN0cnVjdCBk
cm1fZGV2aWNlICpkZXYsCj4gICAgICAgICBpZiAoZGV2LT5tb2RlX2NvbmZpZy5hbGxvd19mYl9t
b2RpZmllcnMgJiYKPiAgICAgICAgICAgICAhKHJmYi0+YmFzZS5mbGFncyAmIERSTV9NT0RFX0ZC
X01PRElGSUVSUykpIHsKPiAgICAgICAgICAgICAgICAgcmV0ID0gY29udmVydF90aWxpbmdfZmxh
Z3NfdG9fbW9kaWZpZXIocmZiKTsKPiAtICAgICAgICAgICAgICAgaWYgKHJldCkKPiArICAgICAg
ICAgICAgICAgaWYgKHJldCkgewo+ICsgICAgICAgICAgICAgICAgICAgICAgIGRybV9kYmdfa21z
KGRldiwgIkZhaWxlZCB0byBjb252ZXJ0IHRpbGluZyBmbGFncyAweCVsbFggdG8gYSBtb2RpZmll
ciIsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmZiLT50aWxpbmdfZmxh
Z3MpOwo+ICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZmFpbDsKPiArICAgICAgICAgICAg
ICAgfQo+ICAgICAgICAgfQo+Cj4gICAgICAgICBmb3IgKGkgPSAxOyBpIDwgcmZiLT5iYXNlLmZv
cm1hdC0+bnVtX3BsYW5lczsgKytpKSB7Cj4gLS0KPiAyLjI5LjIKPgo+Cj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlz
dAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
