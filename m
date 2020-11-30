Return-Path: <SRS0=Nkia=FE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A692C64E90
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 23:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3CCD20725
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 23:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGNh/RJJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3CCD20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DA5789C98;
	Mon, 30 Nov 2020 23:40:49 +0000 (UTC)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 530FA89C82;
 Mon, 30 Nov 2020 23:40:48 +0000 (UTC)
Received: by mail-ot1-x341.google.com with SMTP id e105so1083601ote.5;
 Mon, 30 Nov 2020 15:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WUKv34qtxSOJIcfls0yKx8KJWtFAnXOJgFSnubgtGqg=;
 b=IGNh/RJJ87DgGvzDZ1Ckv9pW5bIUwmR/4ZzR3Jb781Wpda4RInP2blSGgETAfALxlm
 Bk89O2QyQu66fPm8rLnMtDaxdOrZkZ1cTHxF0DDbvEvyBznHGrw0aLnEO65qjplfba32
 Txd/XWn8CmXRZCzAD9tNQrIa0rwDo/PkKblFfG6345rPBDbWUhjkhhOtsTYkdO2/1709
 fuEQgZMUVGxGDdcU8ZSMD2vn6OJ2QVMSewoqvQCQvsMGkIMC3ZGAlTRQmHVslk3qC/p6
 3qy9MHvfn8u5uh2s3qXLbcO/XdhN20+bAaWeo9gH1pmzTZjNQWu25EroDxu4V4tKuqqx
 p1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WUKv34qtxSOJIcfls0yKx8KJWtFAnXOJgFSnubgtGqg=;
 b=SSOdFNTNCVWq48Y4/KP0gWT04BDlyUk6C0o40dg4PeleayRZTEuFR0Z/6SOCOfcIKD
 DU7cTw/FO4cRLwkMzDToT0leVc8BkXhABfTKSiRBF/eXLnP4wSTNJHbh9uXoL4wU1obi
 6Bo6DtOn4uOF7ygEKrSohg+WnX4Y7J0etDldF8wCGLwpHqTjm2k5oUX6OY7I5WroB4UB
 1/SNAD9Zv7Yl+WSs3e4yXyKcEM7xyiT9R/0rH04EkXBYopoLbqZ5EoUsKrjzPnV+lPeX
 krW1egdZdCfCD4UpSOHrldejY4frxYyf/nZOD9Hj7cgx+C+gF+1Y0S9m8nxw279LgKFq
 JSSA==
X-Gm-Message-State: AOAM5313OdfHCl57X0gewcovHmypME6Ak7KAmf7NRFMhCvRObT0Ku1D1
 kqs0weyVOAZQrwW3/1W/IxrRZ0LS+8nt+8pSiRvIUmT4
X-Google-Smtp-Source: ABdhPJz5o1Vtz5zo1fATxAk/iLOIZ24Rtnyz9pEVUG886RxDl7LNB4OdkvWj12oEP+1+SdP9VgFNeLlQ9YtMWoX4g0I=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr18980735otg.311.1606779647728; 
 Mon, 30 Nov 2020 15:40:47 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org>
 <20201126134240.3214176-18-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-18-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Nov 2020 18:40:36 -0500
Message-ID: <CADnq5_OJBza2OCgXKH=kG7-z6vdV_BHh=ZJLTVLRo4FSxit1yw@mail.gmail.com>
Subject: Re: [PATCH 17/40] drm/amd/pm/powerplay/hwmgr/hardwaremanager: Fix
 function header related formatting issues
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
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCBOb3YgMjYsIDIwMjAgYXQgODo0MyBBTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL3BtL3Bvd2VycGxh
eS9od21nci9oYXJkd2FyZW1hbmFnZXIuYzoyMzI6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRl
ciBvciBtZW1iZXIgJ2h3bWdyJyBub3QgZGVzY3JpYmVkIGluICdwaG1fc3RhcnRfdGhlcm1hbF9j
b250cm9sbGVyJwo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9wbS9wb3dlcnBsYXkv
aHdtZ3IvaGFyZHdhcmVtYW5hZ2VyLmM6MzgzOiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIg
b3IgbWVtYmVyICdod21ncicgbm90IGRlc2NyaWJlZCBpbiAncGhtX2dldF9jbG9ja19pbmZvJwo+
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9wbS9wb3dlcnBsYXkvaHdtZ3IvaGFyZHdh
cmVtYW5hZ2VyLmM6MzgzOiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdz
dGF0ZScgbm90IGRlc2NyaWJlZCBpbiAncGhtX2dldF9jbG9ja19pbmZvJwo+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS8uLi9wbS9wb3dlcnBsYXkvaHdtZ3IvaGFyZHdhcmVtYW5hZ2VyLmM6
MzgzOiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdwY2xvY2tfaW5mbycg
bm90IGRlc2NyaWJlZCBpbiAncGhtX2dldF9jbG9ja19pbmZvJwo+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS8uLi9wbS9wb3dlcnBsYXkvaHdtZ3IvaGFyZHdhcmVtYW5hZ2VyLmM6MzgzOiB3
YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdkZXNpZ25hdGlvbicgbm90IGRl
c2NyaWJlZCBpbiAncGhtX2dldF9jbG9ja19pbmZvJwo+Cj4gQ2M6IEV2YW4gUXVhbiA8ZXZhbi5x
dWFuQGFtZC5jb20+Cj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4KPiBDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4g
Q2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KPiBDYzogRGFuaWVsIFZldHRlciA8
ZGFuaWVsQGZmd2xsLmNoPgo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENj
OiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gU2lnbmVkLW9mZi1ieTogTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KCkFwcGxpZWQuICBUaGFua3MhCgpBbGV4Cgo+IC0t
LQo+ICAuLi4vYW1kL3BtL3Bvd2VycGxheS9od21nci9oYXJkd2FyZW1hbmFnZXIuYyAgfCAyNSAr
KysrKysrKysrLS0tLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAx
MiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bv
d2VycGxheS9od21nci9oYXJkd2FyZW1hbmFnZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
cG93ZXJwbGF5L2h3bWdyL2hhcmR3YXJlbWFuYWdlci5jCj4gaW5kZXggNDVkZGUzZTc0YjU3OC4u
MjViNTgzMWExNWNkMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2Vy
cGxheS9od21nci9oYXJkd2FyZW1hbmFnZXIuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG0vcG93ZXJwbGF5L2h3bWdyL2hhcmR3YXJlbWFuYWdlci5jCj4gQEAgLTIyMywxMSArMjIzLDEx
IEBAIGludCBwaG1fcmVnaXN0ZXJfaXJxX2hhbmRsZXJzKHN0cnVjdCBwcF9od21nciAqaHdtZ3Ip
Cj4gIH0KPgo+ICAvKioKPiAtKiBJbml0aWFsaXplcyB0aGUgdGhlcm1hbCBjb250cm9sbGVyIHN1
YnN5c3RlbS4KPiAtKgo+IC0qIEBwYXJhbSAgICBwSHdNZ3IgIHRoZSBhZGRyZXNzIG9mIHRoZSBw
b3dlcnBsYXkgaGFyZHdhcmUgbWFuYWdlci4KPiAtKiBAZXhjZXB0aW9uIFBQX1Jlc3VsdF9GYWls
ZWQgaWYgYW55IG9mIHRoZSBwYXJhbXRlcnMgaXMgTlVMTCwgb3RoZXJ3aXNlIHRoZSByZXR1cm4g
dmFsdWUgZnJvbSB0aGUgZGlzcGF0Y2hlci4KPiAtKi8KPiArICogcGhtX3N0YXJ0X3RoZXJtYWxf
Y29udHJvbGxlciAtIEluaXRpYWxpemVzIHRoZSB0aGVybWFsIGNvbnRyb2xsZXIgc3Vic3lzdGVt
Lgo+ICsgKgo+ICsgKiBAaHdtZ3I6ICAgdGhlIGFkZHJlc3Mgb2YgdGhlIHBvd2VycGxheSBoYXJk
d2FyZSBtYW5hZ2VyLgo+ICsgKiBFeGNlcHRpb24gUFBfUmVzdWx0X0ZhaWxlZCBpZiBhbnkgb2Yg
dGhlIHBhcmFtdGVycyBpcyBOVUxMLCBvdGhlcndpc2UgdGhlIHJldHVybiB2YWx1ZSBmcm9tIHRo
ZSBkaXNwYXRjaGVyLgo+ICsgKi8KPiAgaW50IHBobV9zdGFydF90aGVybWFsX2NvbnRyb2xsZXIo
c3RydWN0IHBwX2h3bWdyICpod21ncikKPiAgewo+ICAgICAgICAgaW50IHJldCA9IDA7Cj4gQEAg
LTM3MSwxMyArMzcxLDE0IEBAIGludCBwaG1fZ2V0X3BlcmZvcm1hbmNlX2xldmVsKHN0cnVjdCBw
cF9od21nciAqaHdtZ3IsIGNvbnN0IHN0cnVjdCBwcF9od19wb3dlcl9zCj4KPgo+ICAvKioKPiAt
KiBHZXRzIENsb2NrIEluZm8uCj4gLSoKPiAtKiBAcGFyYW0gICAgcEh3TWdyICB0aGUgYWRkcmVz
cyBvZiB0aGUgcG93ZXJwbGF5IGhhcmR3YXJlIG1hbmFnZXIuCj4gLSogQHBhcmFtICAgIHBQb3dl
clN0YXRlIHRoZSBhZGRyZXNzIG9mIHRoZSBQb3dlciBTdGF0ZSBzdHJ1Y3R1cmUuCj4gLSogQHBh
cmFtICAgIHBDbG9ja0luZm8gdGhlIGFkZHJlc3Mgb2YgUFBfQ2xvY2tJbmZvIHN0cnVjdHVyZSB3
aGVyZSB0aGUgcmVzdWx0IHdpbGwgYmUgcmV0dXJuZWQuCj4gLSogQGV4Y2VwdGlvbiBQUF9SZXN1
bHRfRmFpbGVkIGlmIGFueSBvZiB0aGUgcGFyYW10ZXJzIGlzIE5VTEwsIG90aGVyd2lzZSB0aGUg
cmV0dXJuIHZhbHVlIGZyb20gdGhlIGJhY2stZW5kLgo+IC0qLwo+ICsgKiBwaG1fZ2V0X2Nsb2Nr
X2luZm8KPiArICoKPiArICogQGh3bWdyOiAgdGhlIGFkZHJlc3Mgb2YgdGhlIHBvd2VycGxheSBo
YXJkd2FyZSBtYW5hZ2VyLgo+ICsgKiBAc3RhdGU6IHRoZSBhZGRyZXNzIG9mIHRoZSBQb3dlciBT
dGF0ZSBzdHJ1Y3R1cmUuCj4gKyAqIEBwY2xvY2tfaW5mbzogdGhlIGFkZHJlc3Mgb2YgUFBfQ2xv
Y2tJbmZvIHN0cnVjdHVyZSB3aGVyZSB0aGUgcmVzdWx0IHdpbGwgYmUgcmV0dXJuZWQuCj4gKyAq
IEBkZXNpZ25hdGlvbjogUEhNIHBlcmZvcm1hbmNlIGxldmVsIGRlc2lnbmF0aW9uCj4gKyAqIEV4
Y2VwdGlvbiBQUF9SZXN1bHRfRmFpbGVkIGlmIGFueSBvZiB0aGUgcGFyYW10ZXJzIGlzIE5VTEws
IG90aGVyd2lzZSB0aGUgcmV0dXJuIHZhbHVlIGZyb20gdGhlIGJhY2stZW5kLgo+ICsgKi8KPiAg
aW50IHBobV9nZXRfY2xvY2tfaW5mbyhzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLCBjb25zdCBzdHJ1
Y3QgcHBfaHdfcG93ZXJfc3RhdGUgKnN0YXRlLCBzdHJ1Y3QgcHBfY2xvY2tfaW5mbyAqcGNsb2Nr
X2luZm8sCj4gICAgICAgICAgICAgICAgICAgICAgICAgUEhNX1BlcmZvcm1hbmNlTGV2ZWxEZXNp
Z25hdGlvbiBkZXNpZ25hdGlvbikKPiAgewo+IC0tCj4gMi4yNS4xCj4KPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxp
c3QKPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
