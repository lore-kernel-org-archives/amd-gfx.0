Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343D9C47083
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 14:56:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9A03613BA
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 14:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A03613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE2526ECDC;
	Wed,  2 Jun 2021 14:56:31 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE0EC6E08A
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 14:45:47 +0000 (UTC)
Received: by mail-lf1-x129.google.com with SMTP id w33so3804748lfu.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Jun 2021 07:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=yrw6uKfT1Qi3r/OkP0AeQAQF+3IOEVvM9VF+wwelGvw=;
 b=oSGCRXiRj1B1BvhvPXrI0asPw4hi7EQEGDcAYz4oG3/wgfAfvwQxWysrRiVjwazHFD
 Vn6rEjgh8vNrwNy4w3zqrChiXPipgpMEVgHuau2fu9n0oucTyOQUW7/HzDxr5h8F59JD
 kfjeB5uV5ySw8ZYHwCghvgHZGloOWccJ9mXTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yrw6uKfT1Qi3r/OkP0AeQAQF+3IOEVvM9VF+wwelGvw=;
 b=fwfsRMuI7hCkrnTbz2xsg01p9pue7sQkQRBvAd+wofGeUGxkQaQLCWt6M7BYfCbVrT
 WLPvaqM6pmWMRxlZUe+mPHv7+pJY8bTn3fkDwQmbGwMXsT2PQxonskc6mQIEBL9JBabW
 DqE+uUOSExRv4OoIpLcAdtOxk1E3I2fkWntnNoTnAg6p5Tq7zsT9QEE6u5Uy/OTd0B5L
 OovfmPg/F920QLaMYzt0Y3Dkg4r4/uRThFzczRgldIdll2PZs6Hh3jbIB/IQVdkw5kcm
 vz95dS6XmYxgXY+C2v81LxyEuabRjOXmBMPuVK0qVavi/ewliqdDFkT7HGeMXLXDUmQh
 XXaA==
X-Gm-Message-State: AOAM53273YJsqOb+COIS0YYxVGzOmdVO8W3B5iCkonhuTy91TgQtE7yB
 paPSKji/t1b/60CFl4XNlw3cetXe2Dncp2+5Wfa3GsTXufhm5w==
X-Google-Smtp-Source: ABdhPJygkAdAuc9dQWp1aqcitTBPgEZi+SsZXMiXYzVSXpVbLA8SBSjzM7SlLVQG54ZLMUxXPbh9H5nBTak6o/H81dE=
X-Received: by 2002:a05:6512:2037:: with SMTP id
 s23mr23093904lfs.542.1622645146238; 
 Wed, 02 Jun 2021 07:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210602095305.41936-1-michel@daenzer.net>
 <1cb79c0b-63f4-777d-29f3-552987aeb790@gmail.com>
 <CAC0gqY4iO3kXq_6zafWnfQehXCgzPLhzmuJ3qSnC-nSnw0MGHQ@mail.gmail.com>
In-Reply-To: <CAC0gqY4iO3kXq_6zafWnfQehXCgzPLhzmuJ3qSnC-nSnw0MGHQ@mail.gmail.com>
From: Mark Yacoub <markyacoub@chromium.org>
Date: Wed, 2 Jun 2021 10:45:35 -0400
Message-ID: <CAJUqKUq8oshLvTaLfz6mR4qYY_B7RedXCqqOu56nG7rB6vYBRw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Use drm_dbg_kms for reporting failure to get
 a GEM FB
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
X-Mailman-Approved-At: Wed, 02 Jun 2021 14:56:30 +0000
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
Cc: ckoenig.leichtzumerken@gmail.com,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

bGd0bS4gVGhhbmtzIQoKPiBPbiBXZWQsIEp1biAyLCAyMDIxIGF0IDU6NTYgQU0gQ2hyaXN0aWFu
IEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IHdyb3RlOgo+Pgo+Pgo+
Pgo+PiBBbSAwMi4wNi4yMSB1bSAxMTo1MyBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+PiA+IEZy
b206IE1pY2hlbCBEw6RuemVyIDxtZGFlbnplckByZWRoYXQuY29tPgo+PiA+Cj4+ID4gZHJtX2Vy
ciBtZWFudCBicm9rZW4gdXNlciBzcGFjZSBjb3VsZCBzcGFtIGRtZXNnLgo+PiA+Cj4+ID4gRml4
ZXM6IGYyNTg5MDdmZGQ4MzVlICJkcm0vYW1kZ3B1OiBWZXJpZnkgYm8gc2l6ZSBjYW4gZml0IGZy
YW1lYnVmZmVyCj4+ID4gICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZSBvbiBpbml0LiIKPj4g
PiBTaWduZWQtb2ZmLWJ5OiBNaWNoZWwgRMOkbnplciA8bWRhZW56ZXJAcmVkaGF0LmNvbT4KPj4K
Pj4gUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4KPj4KPj4gPiAtLS0KPj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
aXNwbGF5LmMgfCA0ICsrLS0KPj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCj4+ID4KPj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kaXNwbGF5LmMKPj4gPiBpbmRleCA4MTcwZTI0Y2UzN2QuLjJhNGNkN2QzNzdiZiAxMDA2
NDQKPj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5j
Cj4+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYwo+
PiA+IEBAIC0xMDU4LDcgKzEwNTgsNyBAQCBpbnQgYW1kZ3B1X2Rpc3BsYXlfZ2VtX2ZiX2luaXQo
c3RydWN0IGRybV9kZXZpY2UgKmRldiwKPj4gPgo+PiA+ICAgICAgIHJldHVybiAwOwo+PiA+ICAg
ZXJyOgo+PiA+IC0gICAgIGRybV9lcnIoZGV2LCAiRmFpbGVkIHRvIGluaXQgZ2VtIGZiOiAlZFxu
IiwgcmV0KTsKPj4gPiArICAgICBkcm1fZGJnX2ttcyhkZXYsICJGYWlsZWQgdG8gaW5pdCBnZW0g
ZmI6ICVkXG4iLCByZXQpOwo+PiA+ICAgICAgIHJmYi0+YmFzZS5vYmpbMF0gPSBOVUxMOwo+PiA+
ICAgICAgIHJldHVybiByZXQ7Cj4+ID4gICB9Cj4+ID4gQEAgLTEwOTYsNyArMTA5Niw3IEBAIGlu
dCBhbWRncHVfZGlzcGxheV9nZW1fZmJfdmVyaWZ5X2FuZF9pbml0KAo+PiA+Cj4+ID4gICAgICAg
cmV0dXJuIDA7Cj4+ID4gICBlcnI6Cj4+ID4gLSAgICAgZHJtX2VycihkZXYsICJGYWlsZWQgdG8g
dmVyaWZ5IGFuZCBpbml0IGdlbSBmYjogJWRcbiIsIHJldCk7Cj4+ID4gKyAgICAgZHJtX2RiZ19r
bXMoZGV2LCAiRmFpbGVkIHRvIHZlcmlmeSBhbmQgaW5pdCBnZW0gZmI6ICVkXG4iLCByZXQpOwo+
PiA+ICAgICAgIHJmYi0+YmFzZS5vYmpbMF0gPSBOVUxMOwo+PiA+ICAgICAgIHJldHVybiByZXQ7
Cj4+ID4gICB9Cj4+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
