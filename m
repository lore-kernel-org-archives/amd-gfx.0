Return-Path: <SRS0=VPxi=76=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E7AC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 13:17:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44F1620786
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 13:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SI/wklB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F1620786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3A8A89FFD;
	Wed, 17 Jun 2020 13:17:31 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD91189FFD
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 13:17:30 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id a6so341682wrm.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 06:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=QKWzRcgtOTmkrP4D1phOpq63vQXn5sBx4u2NDbhPLOM=;
 b=SI/wklB3/55xy6vxra8DQZjYpQPl/dGV/uGB93z+nfJP2fVlzdXeP0i2jo6DMxrqOa
 GcsK79ZvLbSqpNTrrQro6KAKq/1FT4zDrSzqjBCzXlKU1sjSVkWZQunhAaMUkPmWtg1g
 0f3b4jDB9Zt+jGTQ25iEKk1s41jPlWp7lYk8mcj/Xp629ae/42/BmOVitb+OnaH02Vx7
 YA7Nr2YMI2KOxk3MZv8hSPyOEp5NBxZetVfRc4O1TPaQrqPoRXtsvXPe1DTWD1wik8Qo
 fV5rrLn7JymuChcn96Q8cXtpCiGZRsbmG30PxTA/5IlF7uS1Z2nJPpW3uBS7FAzKJftZ
 NvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QKWzRcgtOTmkrP4D1phOpq63vQXn5sBx4u2NDbhPLOM=;
 b=I7VqJKofwHxiRAyTg3VrMq6mrl0u85wJoHXjIV246BBg2uCnLsvgGn566trE3/KH2y
 RmbvyhFVEpPzEjPAl6urJkaJZiTneP3LMb7o6nDQ2JHg0v11Sc/0H6blKDYzZcVfH6zK
 o6k3/DrFKgoBXpuYHRn3jHyyeDqHM48X2PtK9KeQ/3mzzmWFB3leUoVIuoCxazWYVfvn
 0V4F9++R0DBH+/QG6Dwp87diAK0qE+tSuHDeph1a3FV7wL2d6KptugZ9g2VHmvzBX/eu
 bM1Ln2WFs5OqHIpVLvOvEGG6E4ZUjf8AlD/Nq1O+KT9+xpJc6js0TJpKJkdbBKv1KbNP
 z9Bw==
X-Gm-Message-State: AOAM53070Xjf9ufCNwS4RtfX0sReckhhqC6XB7ds2SMCwMatz79OWzYU
 lK68JqQ7VEtxKixjx8jNb/5uga+X+Z74WJJilsgYsQ==
X-Google-Smtp-Source: ABdhPJxjF3he75Dz6vOBVcDh1bcpLwYDodmQtO3pFYyMjFoRWcF64fGwFkUKSlUfFuCRnbcy/929XpPRq15joi1U4ik=
X-Received: by 2002:a5d:400f:: with SMTP id n15mr9011251wrp.419.1592399849568; 
 Wed, 17 Jun 2020 06:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200617114218.42330-1-nirmoy.das@amd.com>
In-Reply-To: <20200617114218.42330-1-nirmoy.das@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Jun 2020 09:17:18 -0400
Message-ID: <CADnq5_NxbgC01FDd1VRFzZB3sEuTBKuuhA0uUqYehL1tkckKPQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: fix compiler warning
To: Nirmoy Das <nirmoy.aiemd@gmail.com>
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
Cc: Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBKdW4gMTcsIDIwMjAgYXQgNzo0MSBBTSBOaXJtb3kgRGFzIDxuaXJtb3kuYWllbWRA
Z21haWwuY29tPiB3cm90ZToKPgo+IEZpeGVzIGJlbG93IHdhcm5pbmc6Cj4gZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZGZfdjNfNi5jOiBJbiBmdW5jdGlvbiDigJhkZl92M182X3Jlc2V0X3Bl
cmZtb25fY250cuKAmToKPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9kZl92M182LmM6NTcx
OjI6IHdhcm5pbmc6IOKAmGhpX2Jhc2VfYWRkcuKAmSBtYXkgYmUgdXNlZAo+IHVuaW5pdGlhbGl6
ZWQgaW4gdGhpcyBmdW5jdGlvbiBbLVdtYXliZS11bmluaXRpYWxpemVkXQo+ICAgNTcxIHwgIGRm
X3YzXzZfcGVyZm1vbl93cmVnKGFkZXYsIGxvX2Jhc2VfYWRkciwgMCwgaGlfYmFzZV9hZGRyLCAw
KTsKPiAgICAgICB8ICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn4KPgo+IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5k
YXNAYW1kLmNvbT4KCkFja2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20+Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9kZl92M182LmMgfCAy
ICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RmX3YzXzYuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RmX3YzXzYuYwo+IGluZGV4IGE3YjgyOTJjZWZlZS4uMWFi
MjYxODM2OTgzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RmX3Yz
XzYuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RmX3YzXzYuYwo+IEBAIC01
NjAsNyArNTYwLDcgQEAgc3RhdGljIHZvaWQgZGZfdjNfNl9wbWNfcmVsZWFzZV9jbnRyKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICBzdGF0aWMgdm9pZCBkZl92M182X3Jlc2V0X3BlcmZt
b25fY250cihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IGNvbmZpZykKPiAgewo+IC0gICAgICAgdWlu
dDMyX3QgbG9fYmFzZV9hZGRyLCBoaV9iYXNlX2FkZHI7Cj4gKyAgICAgICB1aW50MzJfdCBsb19i
YXNlX2FkZHIgPSAwLCBoaV9iYXNlX2FkZHIgPSAwOwo+Cj4gICAgICAgICBkZl92M182X3BtY19n
ZXRfcmVhZF9zZXR0aW5ncyhhZGV2LCBjb25maWcsICZsb19iYXNlX2FkZHIsCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmaGlfYmFzZV9hZGRyKTsKPiAtLQo+IDIuMjYu
Mgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBh
bWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
