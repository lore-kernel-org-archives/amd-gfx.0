Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEE6C432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 21:19:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C91AA2068E
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 21:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91AA2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71B6A6E33F;
	Mon,  2 Dec 2019 21:19:00 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DBF46E11E;
 Mon,  2 Dec 2019 21:18:59 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id p17so1131084wmi.3;
 Mon, 02 Dec 2019 13:18:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qWAKBL9dXSSXFqr0Y4SwfKcwOpIQybFAyVXZWRq2Www=;
 b=ppNrMw7LLT2mBure1YIzC9x7qRVQJm9F9qlMA43Zqzs3GmCW48rKGuTF/YazJnW6bE
 iHDznRva8zVqb/b7UCnmELtudF8i6tJooDWfdlDbU16OoBX+M5wPPN49DCckE6fvdscW
 beh+9H3Kh9tzP5DPRR0PsgDYzoo+lnkYJXAixlGsYxWvxlVwqlSLl6TVeVNV/6opwA/s
 XpVzYGFksGdTvQEHtE3WzJFX08LNc4S8B8ZP3IjbCqsI5Ii+Q7+v1vuApKvjTfH188fu
 7GmgIXX7SCACV4a5ECM2bKCEgSEUYC4gq9xX1DU3q3ono/+VnwpxJDgjruQN4wQt/iKm
 NQtA==
X-Gm-Message-State: APjAAAUzvZ14xK4iYSTmx0Bgtp2KSaNXxC3nZbGH0DiyNoTbRfY+Umb/
 aV9Hy3cNEnJXx3SQ9febjp8tNTvIB2pluzGWCZ7iug==
X-Google-Smtp-Source: APXvYqxRYUBuXzQjcF8+auhZxoONV8UXqefPflH4Ow8waDvFt7frjYPrWgX/j2hzY8x8SaKTc9rJoXMa9Gke/eiuMYQ=
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr1226603wml.67.1575321537792; 
 Mon, 02 Dec 2019 13:18:57 -0800 (PST)
MIME-Version: 1.0
References: <20191126144310.23717-1-alexander.deucher@amd.com>
In-Reply-To: <20191126144310.23717-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Dec 2019 16:18:46 -0500
Message-ID: <CADnq5_NgXMNeJWEGW_kzQRw19zRCoP7aPKBuf=SGJ5UNYv4yHA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: fix r1xx/r2xx register checker for POT
 textures
To: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=qWAKBL9dXSSXFqr0Y4SwfKcwOpIQybFAyVXZWRq2Www=;
 b=kT3tldIFQgJJsL1cU+odyaXM86sIxtDXxqMDf6XLyn53vCpsE6Mmi0+PwpY7Enwv7N
 pgsFq33fDGr1wGwXz8EWw+Ex6sFuM8oQekSaf+hw6HLkriXEXP/HStNZrXtq52Jte7pE
 gSw4jXnhA7JEo/fSs5sVIn/a98/LLrqH3Lel44hMWE+Q4QrsuhF3dcK1AeUvVLlOcx0I
 aYCCGJyQNOoG+WqklYrgaSw8niU+NLF5BTRNfwrIZexdKkL+ycBC+kRosZ1OVhlRUVhP
 ksheeIhpz74UuyKPy65hei9esvnM2OLmVvngOFTfyIEVrqLclVlKtfmOnN0gLfBlhzWT
 +6MQ==
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UGluZz8KCkFsZXgKCk9uIFR1ZSwgTm92IDI2LCAyMDE5IGF0IDk6NDMgQU0gQWxleCBEZXVjaGVy
IDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gU2hpZnQgYW5kIG1hc2sgd2VyZSBy
ZXZlcnNlZC4gIE5vdGljZWQgYnkgY2hhbmNlLgo+Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3IxMDAuYyB8IDQgKystLQo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3IyMDAuYyB8
IDQgKystLQo+ICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3IxMDAuYyBiL2RyaXZl
cnMvZ3B1L2RybS9yYWRlb24vcjEwMC5jCj4gaW5kZXggNzA4OWRmYzhjMmE5Li4xY2NlZTRlNTg4
MGUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yMTAwLmMKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL3IxMDAuYwo+IEBAIC0xODI2LDggKzE4MjYsOCBAQCBzdGF0
aWMgaW50IHIxMDBfcGFja2V0MF9jaGVjayhzdHJ1Y3QgcmFkZW9uX2NzX3BhcnNlciAqcCwKPiAg
ICAgICAgICAgICAgICAgICAgICAgICB0cmFjay0+dGV4dHVyZXNbaV0udXNlX3BpdGNoID0gMTsK
PiAgICAgICAgICAgICAgICAgfSBlbHNlIHsKPiAgICAgICAgICAgICAgICAgICAgICAgICB0cmFj
ay0+dGV4dHVyZXNbaV0udXNlX3BpdGNoID0gMDsKPiAtICAgICAgICAgICAgICAgICAgICAgICB0
cmFjay0+dGV4dHVyZXNbaV0ud2lkdGggPSAxIDw8ICgoaWR4X3ZhbHVlID4+IFJBREVPTl9UWEZP
Uk1BVF9XSURUSF9TSElGVCkgJiBSQURFT05fVFhGT1JNQVRfV0lEVEhfTUFTSyk7Cj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgdHJhY2stPnRleHR1cmVzW2ldLmhlaWdodCA9IDEgPDwgKChpZHhf
dmFsdWUgPj4gUkFERU9OX1RYRk9STUFUX0hFSUdIVF9TSElGVCkgJiBSQURFT05fVFhGT1JNQVRf
SEVJR0hUX01BU0spOwo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHRyYWNrLT50ZXh0dXJlc1tpXS53aWR0aCA9IDEgPDwgKChpZHhfdmFsdWUgJiBSQURF
T05fVFhGT1JNQVRfV0lEVEhfTUFTSykgPj4gUkFERU9OX1RYRk9STUFUX1dJRFRIX1NISUZUKTsK
PiArICAgICAgICAgICAgICAgICAgICAgICB0cmFjay0+dGV4dHVyZXNbaV0uaGVpZ2h0ID0gMSA8
PCAoKGlkeF92YWx1ZSAmIFJBREVPTl9UWEZPUk1BVF9IRUlHSFRfTUFTSykgPj4gUkFERU9OX1RY
Rk9STUFUX0hFSUdIVF9TSElGVCk7Cj4gICAgICAgICAgICAgICAgIH0KPiAgICAgICAgICAgICAg
ICAgaWYgKGlkeF92YWx1ZSAmIFJBREVPTl9UWEZPUk1BVF9DVUJJQ19NQVBfRU5BQkxFKQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIHRyYWNrLT50ZXh0dXJlc1tpXS50ZXhfY29vcmRfdHlwZSA9
IDI7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjIwMC5jIGIvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yMjAwLmMKPiBpbmRleCA4NDA0MDE0MTNjNTguLmY1ZjJmZmVhNWFi
MiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3IyMDAuYwo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9yYWRlb24vcjIwMC5jCj4gQEAgLTQ3Niw4ICs0NzYsOCBAQCBpbnQgcjIw
MF9wYWNrZXQwX2NoZWNrKHN0cnVjdCByYWRlb25fY3NfcGFyc2VyICpwLAo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIHRyYWNrLT50ZXh0dXJlc1tpXS51c2VfcGl0Y2ggPSAxOwo+ICAgICAgICAg
ICAgICAgICB9IGVsc2Ugewo+ICAgICAgICAgICAgICAgICAgICAgICAgIHRyYWNrLT50ZXh0dXJl
c1tpXS51c2VfcGl0Y2ggPSAwOwo+IC0gICAgICAgICAgICAgICAgICAgICAgIHRyYWNrLT50ZXh0
dXJlc1tpXS53aWR0aCA9IDEgPDwgKChpZHhfdmFsdWUgPj4gUkFERU9OX1RYRk9STUFUX1dJRFRI
X1NISUZUKSAmIFJBREVPTl9UWEZPUk1BVF9XSURUSF9NQVNLKTsKPiAtICAgICAgICAgICAgICAg
ICAgICAgICB0cmFjay0+dGV4dHVyZXNbaV0uaGVpZ2h0ID0gMSA8PCAoKGlkeF92YWx1ZSA+PiBS
QURFT05fVFhGT1JNQVRfSEVJR0hUX1NISUZUKSAmIFJBREVPTl9UWEZPUk1BVF9IRUlHSFRfTUFT
Syk7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgdHJhY2stPnRleHR1cmVzW2ldLndpZHRoID0g
MSA8PCAoKGlkeF92YWx1ZSAmIFJBREVPTl9UWEZPUk1BVF9XSURUSF9NQVNLKSA+PiBSQURFT05f
VFhGT1JNQVRfV0lEVEhfU0hJRlQpOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIHRyYWNrLT50
ZXh0dXJlc1tpXS5oZWlnaHQgPSAxIDw8ICgoaWR4X3ZhbHVlICYgUkFERU9OX1RYRk9STUFUX0hF
SUdIVF9NQVNLKSA+PiBSQURFT05fVFhGT1JNQVRfSEVJR0hUX1NISUZUKTsKPiAgICAgICAgICAg
ICAgICAgfQo+ICAgICAgICAgICAgICAgICBpZiAoaWR4X3ZhbHVlICYgUjIwMF9UWEZPUk1BVF9M
T09LVVBfRElTQUJMRSkKPiAgICAgICAgICAgICAgICAgICAgICAgICB0cmFjay0+dGV4dHVyZXNb
aV0ubG9va3VwX2Rpc2FibGUgPSB0cnVlOwo+IC0tCj4gMi4yMy4wCj4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
