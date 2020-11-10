Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3D7C388F7
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 21:55:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6443E20781
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 21:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+rlA+7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6443E20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE29388007;
	Tue, 10 Nov 2020 21:55:37 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A234288007;
 Tue, 10 Nov 2020 21:55:36 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id s8so7267661wrw.10;
 Tue, 10 Nov 2020 13:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=u5GBjym3rJCQnWuSZFpqf2iaAs/Z53sDeT3dHdMb+hg=;
 b=a+rlA+7yejDdiDJ1N41A0WeGf5WFRpRtpLmadnxbsb1EgT0Xgo5qSDYl7J0upXNIY4
 2Zpm7kJdm8DO97O2FYVJiA2ovCEYpNbpmseJxXqQPXZKTeD5Id0OuEHeIULgH0iic2GR
 13QAgZ1VgmF4g6xoXAa10zDM/B3Oa7rTU7Za47YkTVJQXtjUA34UXNbcAZhBdB2COi6G
 gD96lDc2wpbJFINDGeeldbUTgXS/DtB9tFfFDOa03E3qTavhD3XovJnfsmC3cqODi0B1
 dlyeQdpTOz3io+9Xxxw4foS8XIYrIjO91ILrQZGANqJl3y2d8bFcW8Rr7LEJ+wqDKht1
 wyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=u5GBjym3rJCQnWuSZFpqf2iaAs/Z53sDeT3dHdMb+hg=;
 b=t0RYxHh8yrUqCaBELNW6jDYCGv89uisc7O8IyXGFaaFLsJsGCHOuEzC8iAZNcBlG97
 AZU12CFDd7tE6c3iZAcBNALfRw5KfcdmBf8YJaPZP/9GxrNK9i16Sycl2ijMUuL5OX2h
 4bWYTG/H06nUp7ZRG/OqtC5QI9yzmTaaKgu6JZIAmexY4z5Ce9v75xruo9yOhjCzTfjI
 tcD8b/ivfv0CI41gg7ZDKkrMJni9qMVCClI4O/HPmJhidPjyGhIg+OOL4ExDGfYhv0+W
 65BdghsuxkuhpnSxr/+FfbsIML4+Dg7jXrkP0lqXXUrKfiXfM809Hh71iu30RU9ZApUD
 brBA==
X-Gm-Message-State: AOAM5326SIRywjwhjOgMeZq/niTTQ9H48wSqW3jLr/3R5vA28K67fJmh
 pSUvgBrbsbNvHtXu/yL1Iq4DNt7cMfoZyBpI/kJgXKng
X-Google-Smtp-Source: ABdhPJwePm6TFap7im1Q+lSU6k6M6ANru3aJxBPToXCnRsuNls8yQIItyzhUJCqEhxkEbMddFz5085Z0/KT51cBCPkI=
X-Received: by 2002:adf:e350:: with SMTP id n16mr26986533wrj.419.1605045335345; 
 Tue, 10 Nov 2020 13:55:35 -0800 (PST)
MIME-Version: 1.0
References: <20201106214949.2042120-1-lee.jones@linaro.org>
 <20201106214949.2042120-8-lee.jones@linaro.org>
In-Reply-To: <20201106214949.2042120-8-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Nov 2020 16:55:24 -0500
Message-ID: <CADnq5_NrnBHFJGVzO-dbMCJrquaUOAYyCiN2zQVXJwe74xEj5w@mail.gmail.com>
Subject: Re: [PATCH 07/19] drm/radeon/radeon_kms: Include header containing
 our own prototypes
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
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBOb3YgNiwgMjAyMCBhdCA0OjUwIFBNIExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFy
by5vcmc+IHdyb3RlOgo+Cj4gRml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdh
cm5pbmcocyk6Cj4KPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmM6NjE6Njog
d2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhyYWRlb25fZHJpdmVyX3VubG9h
ZF9rbXPigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3JhZGVvbl9rbXMuYzoxMDQ6NTogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDi
gJhyYWRlb25fZHJpdmVyX2xvYWRfa21z4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KPiAgZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmM6NjE4OjY6IHdhcm5pbmc6IG5vIHByZXZp
b3VzIHByb3RvdHlwZSBmb3Ig4oCYcmFkZW9uX2RyaXZlcl9sYXN0Y2xvc2Vfa21z4oCZIFstV21p
c3NpbmctcHJvdG90eXBlc10KPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmM6
NjMzOjU6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYcmFkZW9uX2RyaXZl
cl9vcGVuX2ttc+KAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCj4gIGRyaXZlcnMvZ3B1L2RybS9y
YWRlb24vcmFkZW9uX2ttcy5jOjcwNDo2OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUg
Zm9yIOKAmHJhZGVvbl9kcml2ZXJfcG9zdGNsb3NlX2ttc+KAmSBbLVdtaXNzaW5nLXByb3RvdHlw
ZXNdCj4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2ttcy5jOjc1NTo1OiB3YXJuaW5n
OiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmHJhZGVvbl9nZXRfdmJsYW5rX2NvdW50ZXJf
a21z4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9y
YWRlb25fa21zLmM6ODI1OjU6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCY
cmFkZW9uX2VuYWJsZV92Ymxhbmtfa21z4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KPiAgZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmM6ODUyOjY6IHdhcm5pbmc6IG5vIHByZXZp
b3VzIHByb3RvdHlwZSBmb3Ig4oCYcmFkZW9uX2Rpc2FibGVfdmJsYW5rX2ttc+KAmSBbLVdtaXNz
aW5nLXByb3RvdHlwZXNdCj4KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPgo+IENjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4KPiBDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBEYW5pZWwgVmV0
dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBM
ZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgoKQXBwbGllZC4gIFRoYW5rcyEKCkFsZXgK
Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9rbXMuYyB8IDEgKwo+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl9rbXMuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9u
X2ttcy5jCj4gaW5kZXggOTllZTYwZjhiNjA0ZC4uMGQ4ZmJhYmZmY2VhZCAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9rbXMuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9yYWRlb24vcmFkZW9uX2ttcy5jCj4gQEAgLTQwLDYgKzQwLDcgQEAKPgo+ICAjaW5jbHVk
ZSAicmFkZW9uLmgiCj4gICNpbmNsdWRlICJyYWRlb25fYXNpYy5oIgo+ICsjaW5jbHVkZSAicmFk
ZW9uX2Rydi5oIgo+Cj4gICNpZiBkZWZpbmVkKENPTkZJR19WR0FfU1dJVENIRVJPTykKPiAgYm9v
bCByYWRlb25faGFzX2F0cHgodm9pZCk7Cj4gLS0KPiAyLjI1LjEKPgo+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gZHJpLWRldmVsIG1haWxpbmcgbGlz
dAo+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbApfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
