Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2574BC4707F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 04:06:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0B266113B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 04:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B266113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A0BE6EE12;
	Thu, 27 May 2021 04:06:40 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F5FC6EE12;
 Thu, 27 May 2021 04:06:38 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 t10-20020a05683022eab0290304ed8bc759so3161027otc.12; 
 Wed, 26 May 2021 21:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RtGwrkIZZiG/x3fVmHw4MZLqdOdAM4Gg7Y6DlMdvCdw=;
 b=pMPHrGUXErML46PYLsZlta62mAowxd0zO2JEe4M38/eyLaBxeCe4Xefjt7GTG0bxGo
 c3zV+MkFTIeXyqH3dUzGykGN86vNRYfDPsukBpabdLpFuB31Uh7TnSUtb1MaO9VgcTfE
 uTXK/gEpEari421GQlRRMqYqgjZWimNlHZtc+UINdA5SKPENYyNyDgfU+le/knyenmfb
 kgLDj0HbNkwHa+8rJiXRX1TA/GUzv2iGmTysZ/FzWWVauBZj7c13DwMvdAkn90kRDKBV
 ztf9H3Fb0e1yTZWEFcNoY9UjAsOPqH2YngGDPUI/X29iIn+ZpeW67ugUYuE9pHcIp+P/
 bc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RtGwrkIZZiG/x3fVmHw4MZLqdOdAM4Gg7Y6DlMdvCdw=;
 b=jQ07bv6A8xkzXI2kCM6HYWqBE/B6dwdksZElAlJpm37ik0skoQBtoTNkK0I5HqoCP6
 7odzhCCc+wDEb+qFHm0K6Qv7egy87Hn6rRQj8i98QFZPYpddXPEVFBRKcnZLUxgtOKPU
 IAa0kKOljE7vgG7t3f7YnpmGLtKKggj1T6vOq+BTBy7nFDF/eyfdcxzFY1rVIwYiU/wj
 7NCjEkJaShYAn1B9VJBxG/kLtek4DfK4AjtvwkV2OKZZVPlC+klxsOxAKC9pMHajdkWB
 kjqfv1GZeNbiS41pNzwKWlr5wG0pKF+sNuKSnU35DUGNiYORto043mnCtWsyG1Hz96HW
 Znyw==
X-Gm-Message-State: AOAM531CRYuhKXzI1NR43hnoxtXUXcgrDn7GPtzocjvwQoYrQ4rvLvpt
 ggedqdajpyJaSPNUSP1ZFd93UUz6sMYdINnnkww=
X-Google-Smtp-Source: ABdhPJx/wFysi+q75alNDvyWj5aqiElb2rD9pHI15NmXnWIaZUVQIc8U5fEeIBdUzugrq/hHK7fiisx/Y2U5yXXCjiM=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr1235375otl.311.1622088398310; 
 Wed, 26 May 2021 21:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org>
 <20210526084726.552052-15-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-15-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 May 2021 00:06:27 -0400
Message-ID: <CADnq5_MMSGX1Ys+n_bm0KkR_xzANYAK37r2JXi532Wzf8t7w0Q@mail.gmail.com>
Subject: Re: [PATCH 14/34] drm/amd/display/dc/gpio/gpio_service: Pass around
 correct dce_{version, environment} types
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
Cc: Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCk9uIFdlZCwgTWF5IDI2LCAyMDIxIGF0IDQ6NDggQU0gTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5n
IFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS8uLi9kaXNwbGF5L2RjL2dwaW8vZ3Bpb19zZXJ2aWNlLmM6IEluIGZ1bmN0aW9uIOKAmGRh
bF9ncGlvX3NlcnZpY2VfY3JlYXRl4oCZOgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8u
Li9kaXNwbGF5L2RjL2dwaW8vZ3Bpb19zZXJ2aWNlLmM6NzE6NDogd2FybmluZzogaW1wbGljaXQg
Y29udmVyc2lvbiBmcm9tIOKAmGVudW0gZGNlX3ZlcnNpb27igJkgdG8g4oCYZW51bSBkY2VfZW52
aXJvbm1lbnTigJkgWy1XZW51bS1jb252ZXJzaW9uXQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS8uLi9kaXNwbGF5L2RjL2dwaW8vZ3Bpb19zZXJ2aWNlLmM6Nzc6NDogd2FybmluZzogaW1w
bGljaXQgY29udmVyc2lvbiBmcm9tIOKAmGVudW0gZGNlX3ZlcnNpb27igJkgdG8g4oCYZW51bSBk
Y2VfZW52aXJvbm1lbnTigJkgWy1XZW51bS1jb252ZXJzaW9uXQo+Cj4gQ2M6IEhhcnJ5IFdlbnRs
YW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgo+IENjOiBMZW8gTGkgPHN1bnBlbmcubGlAYW1k
LmNvbT4KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IENj
OiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBDYzogRGF2
aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxA
ZmZ3bGwuY2g+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRyaS1k
ZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxl
ZS5qb25lc0BsaW5hcm8ub3JnPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvZ3Bpby9ncGlvX3NlcnZpY2UuYyAgIHwgMTIgKysrKysrLS0tLS0tCj4gIC4uLi9kcm0vYW1k
L2Rpc3BsYXkvaW5jbHVkZS9ncGlvX3NlcnZpY2VfaW50ZXJmYWNlLmggfCAgNCArKy0tCj4gIDIg
ZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9ncGlvL2dwaW9fc2VydmljZS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2dwaW8vZ3Bpb19zZXJ2aWNlLmMKPiBp
bmRleCA5MjI4MGNjMDVlMmRiLi5kYWU4ZTQ4OWM4Y2Y0IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9ncGlvL2dwaW9fc2VydmljZS5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2dwaW8vZ3Bpb19zZXJ2aWNlLmMKPiBAQCAtNTMsOCAr
NTMsOCBAQAo+ICAgKi8KPgo+ICBzdHJ1Y3QgZ3Bpb19zZXJ2aWNlICpkYWxfZ3Bpb19zZXJ2aWNl
X2NyZWF0ZSgKPiAtICAgICAgIGVudW0gZGNlX3ZlcnNpb24gZGNlX3ZlcnNpb25fbWFqb3IsCj4g
LSAgICAgICBlbnVtIGRjZV92ZXJzaW9uIGRjZV92ZXJzaW9uX21pbm9yLAo+ICsgICAgICAgZW51
bSBkY2VfdmVyc2lvbiBkY2VfdmVyc2lvbiwKPiArICAgICAgIGVudW0gZGNlX2Vudmlyb25tZW50
IGRjZV9lbnZpcm9ubWVudCwKPiAgICAgICAgIHN0cnVjdCBkY19jb250ZXh0ICpjdHgpCj4gIHsK
PiAgICAgICAgIHN0cnVjdCBncGlvX3NlcnZpY2UgKnNlcnZpY2U7Cj4gQEAgLTY3LDE0ICs2Nywx
NCBAQCBzdHJ1Y3QgZ3Bpb19zZXJ2aWNlICpkYWxfZ3Bpb19zZXJ2aWNlX2NyZWF0ZSgKPiAgICAg
ICAgICAgICAgICAgcmV0dXJuIE5VTEw7Cj4gICAgICAgICB9Cj4KPiAtICAgICAgIGlmICghZGFs
X2h3X3RyYW5zbGF0ZV9pbml0KCZzZXJ2aWNlLT50cmFuc2xhdGUsIGRjZV92ZXJzaW9uX21ham9y
LAo+IC0gICAgICAgICAgICAgICAgICAgICAgIGRjZV92ZXJzaW9uX21pbm9yKSkgewo+ICsgICAg
ICAgaWYgKCFkYWxfaHdfdHJhbnNsYXRlX2luaXQoJnNlcnZpY2UtPnRyYW5zbGF0ZSwgZGNlX3Zl
cnNpb24sCj4gKyAgICAgICAgICAgICAgICAgICAgICAgZGNlX2Vudmlyb25tZW50KSkgewo+ICAg
ICAgICAgICAgICAgICBCUkVBS19UT19ERUJVR0dFUigpOwo+ICAgICAgICAgICAgICAgICBnb3Rv
IGZhaWx1cmVfMTsKPiAgICAgICAgIH0KPgo+IC0gICAgICAgaWYgKCFkYWxfaHdfZmFjdG9yeV9p
bml0KCZzZXJ2aWNlLT5mYWN0b3J5LCBkY2VfdmVyc2lvbl9tYWpvciwKPiAtICAgICAgICAgICAg
ICAgICAgICAgICBkY2VfdmVyc2lvbl9taW5vcikpIHsKPiArICAgICAgIGlmICghZGFsX2h3X2Zh
Y3RvcnlfaW5pdCgmc2VydmljZS0+ZmFjdG9yeSwgZGNlX3ZlcnNpb24sCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgZGNlX2Vudmlyb25tZW50KSkgewo+ICAgICAgICAgICAgICAgICBCUkVBS19U
T19ERUJVR0dFUigpOwo+ICAgICAgICAgICAgICAgICBnb3RvIGZhaWx1cmVfMTsKPiAgICAgICAg
IH0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2luY2x1ZGUvZ3Bp
b19zZXJ2aWNlX2ludGVyZmFjZS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2luY2x1
ZGUvZ3Bpb19zZXJ2aWNlX2ludGVyZmFjZS5oCj4gaW5kZXggOWM1NWQyNDcyMjdlYS4uN2UzMjQw
ZTczYzFmYyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvaW5jbHVk
ZS9ncGlvX3NlcnZpY2VfaW50ZXJmYWNlLmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvaW5jbHVkZS9ncGlvX3NlcnZpY2VfaW50ZXJmYWNlLmgKPiBAQCAtNDIsOCArNDIsOCBA
QCB2b2lkIGRhbF9ncGlvX2Rlc3Ryb3koCj4gICAgICAgICBzdHJ1Y3QgZ3BpbyAqKnB0cik7Cj4K
PiAgc3RydWN0IGdwaW9fc2VydmljZSAqZGFsX2dwaW9fc2VydmljZV9jcmVhdGUoCj4gLSAgICAg
ICBlbnVtIGRjZV92ZXJzaW9uIGRjZV92ZXJzaW9uX21ham9yLAo+IC0gICAgICAgZW51bSBkY2Vf
dmVyc2lvbiBkY2VfdmVyc2lvbl9taW5vciwKPiArICAgICAgIGVudW0gZGNlX3ZlcnNpb24gZGNl
X3ZlcnNpb24sCj4gKyAgICAgICBlbnVtIGRjZV9lbnZpcm9ubWVudCBkY2VfZW52aXJvbm1lbnQs
Cj4gICAgICAgICBzdHJ1Y3QgZGNfY29udGV4dCAqY3R4KTsKPgo+ICBzdHJ1Y3QgZ3BpbyAqZGFs
X2dwaW9fc2VydmljZV9jcmVhdGVfaXJxKAo+IC0tCj4gMi4zMS4xCj4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
