Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E299C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 21:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17DEB64ED0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 21:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DEB64ED0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 937336E883;
	Mon,  1 Feb 2021 21:34:53 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00E906E883
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 21:34:51 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id w124so20491793oia.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Feb 2021 13:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GAHndxj+yGgZ6dMFaQZVauOxcABKituMahb6+uJvtzA=;
 b=FqQ68sTdy1WCtyxbo5Uot98b8ehAxzh+5Pozjn1UYk0XPSp1pj+i5usqHQDkzUxJ/z
 MZApDkzz4fhbJyRICdQQEzxn/VGWmpioljsvfJVpstpVo0V8hlgbu+pgFNeMUqLeY3qg
 Y/ho3Iip/cfvn7IexXmpicbfLmk9r34XZ8dTeTivq+5tq0Ic5kHl3Pf3GhO1EmFps8kd
 TjRgaTlSy0ae9wiHoprpuDZhTLIVnQPUZJHxjlFXszrcwov8YJrvaXt/SiI87RWEYMy2
 +a16RHnUn7FDRnLJnnsd947Evb7SsHSUXuGNJGojiA0UQRpW6gB3a6UTB/qmG8K9sGRr
 wRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GAHndxj+yGgZ6dMFaQZVauOxcABKituMahb6+uJvtzA=;
 b=X9cy7Fy746NqlgsQlm/jqKfNiDuvv1bzwbyPCrInPbfHFIUav0yxGz4Q8KV/6Csa/F
 xc7RX7aHCW+hMp7EaryWemgEYz5ozYe9JoyKs5+JPYEPXsZm6KKJAQkCkAJUpG/ArSFc
 BHaYz9UK0mAIxG78O0k+5P/+maMwe2Y8LRZgp+mBg5S1e2usHIwe1rcnjL3jEj3r7c/R
 qon6BBn1q0vulBs+yXSTToPahsF2iOVOfiX4k0HDMv+vlL/X/K/N5wWSG21QcW37B/Rr
 8UGyKQW60mzOBMZqwcl9i45LYvVyP20A6DUTekaxG9noIuCVfsz9lzjwLcVPcUBm1TAO
 txZg==
X-Gm-Message-State: AOAM532qCbeDHeNSXjsk2vxtarSznOH9yclbI9ChOL8RYbyLo7+/fcyZ
 QtrdY6PQztduUTeu0+3evrurig5SMfz0yc3p8t8=
X-Google-Smtp-Source: ABdhPJzvjU4W9CtjLOyKkNHppf0mKYw4iHHDCxjrqBgXbH2AXzJ/GGVVeEuevG1JN6LtxLli9rJDLnf10nr2WnUwRZk=
X-Received: by 2002:aca:f5d1:: with SMTP id t200mr572943oih.123.1612215291290; 
 Mon, 01 Feb 2021 13:34:51 -0800 (PST)
MIME-Version: 1.0
References: <20210201155155.103360-1-nirmoy.das@amd.com>
 <ececcadc-6be5-124c-74b7-7addae2abf76@amd.com>
In-Reply-To: <ececcadc-6be5-124c-74b7-7addae2abf76@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 1 Feb 2021 16:34:40 -0500
Message-ID: <CADnq5_PYxEUT8m7DewKW7T11qvg3ez7DW+af5JwDA_7=rgG8Rw@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amdgpu: cleanup struct amdgpu_ring
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Alan Harrison <Alan.Harrison@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, Huang Rui <ray.huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Nirmoy Das <nirmoy.das@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBGZWIgMSwgMjAyMSBhdCAxMToxMyBBTSBDaHJpc3RpYW4gS8O2bmlnCjxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+IHdyb3RlOgo+Cj4gQW0gMDEuMDIuMjEgdW0gMTY6NTEgc2Nocmll
YiBOaXJtb3kgRGFzOgo+ID4gVGhpcyBwYXRjaCBjb25zaXN0IG9mIGJlbG93IHJlbGF0ZWQgY2hh
bmdlczoKPiA+Cj4gPiAxIFJlbmFtZSByaW5nLT5wcmlvcml0eSB0byByaW5nLT5od19wcmlvLgo+
ID4gMiBBc3NpZ24gY29ycmVjdCBoYXJkd2FyZSByaW5nIHByaW9yaXR5Lgo+ID4gMyBSZW1vdmUg
cmluZy0+cHJpb3JpdHlfbXV0ZXggYXMgcmluZyBwcmlvcml0eSByZW1haW5zIHVuY2hhbmdlZAo+
ID4gICAgYWZ0ZXIgaW5pdGlhbGl6YXRpb24uCj4gPiA0IFJlbW92ZSB1bnVzZWQgcmluZy0+bnVt
X2pvYnMuCj4gPgo+ID4gdjM6IHJlbW92ZSByaW5nLT5udW1fam9icy4KPiA+IHYyOiByZW1vdmUg
cmluZy0+cHJpb3JpdHlfbXV0ZXguCj4gPgo+ID4gRml4ZXM6IDMzYWJjYjFmNWExNyAoImRybS9h
bWRncHU6IHNldCBjb21wdXRlIHF1ZXVlIHByaW9yaXR5IGF0IG1xZF9pbml0IikKPiA+IFNpZ25l
ZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KPgo+IFJldmlld2VkLWJ5
OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+IGZvciBwYXRjaCAj
MSwgIzMKPiBhbmQgIzQuCj4KPiBNYXliZSBwaW5nIEFsZXggZm9yIGFuIHJiIG9uIHBhdGNoICMy
LgoKU2VyaWVzIGxvb2tzIGdvb2QgdG8gbWUgdG9vLiAgTWF5YmUgYWRkIHNvbWV0aGluZyB0byB0
aGUgY29tbWl0Cm1lc3NhZ2UgZm9yIHBhdGNoIDMgdG8gZXhwbGFpbiB3aHkgd2UgZG9uJ3QgbmVl
ZCB0aGlzIG9uIGdmeDEwIHNvCnNvbWVvbmUgZG9lc24ndCB0cnkgYW5kIG1ha2UgdGhlIGNoYW5n
ZSB0aGVyZSBpbiB0aGUgZnV0dXJlLiAgV2l0aAp0aGF0IGZpeGVzIHNlcmllcyBpczoKUmV2aWV3
ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KCkFsZXgKCgoK
Pgo+IENocmlzdGlhbi4KPgo+ID4gLS0tCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9yaW5nLmMgfCA4ICsrLS0tLS0tCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9yaW5nLmggfCA2ICstLS0tLQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcmluZy5jCj4gPiBpbmRleCAxYTYxMmY1MWVjZDkuLmI2NDRjNzg0NzVmZCAx
MDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMK
PiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMKPiA+IEBA
IC0xNjYsNyArMTY2LDcgQEAgaW50IGFtZGdwdV9yaW5nX2luaXQoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywKPiA+ICAgICAgICAgICAgICAgICAg
ICB1bnNpZ25lZCBpbnQgbWF4X2R3LCBzdHJ1Y3QgYW1kZ3B1X2lycV9zcmMgKmlycV9zcmMsCj4g
PiAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IGlycV90eXBlLCB1bnNpZ25lZCBpbnQg
aHdfcHJpbykKPiA+ICAgewo+ID4gLSAgICAgaW50IHIsIGk7Cj4gPiArICAgICBpbnQgcjsKPiA+
ICAgICAgIGludCBzY2hlZF9od19zdWJtaXNzaW9uID0gYW1kZ3B1X3NjaGVkX2h3X3N1Ym1pc3Np
b247Cj4gPiAgICAgICB1MzIgKm51bV9zY2hlZDsKPiA+ICAgICAgIHUzMiBod19pcDsKPiA+IEBA
IC0yNTgsOCArMjU4LDcgQEAgaW50IGFtZGdwdV9yaW5nX2luaXQoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywKPiA+ICAgICAgIH0KPiA+Cj4gPiAg
ICAgICByaW5nLT5tYXhfZHcgPSBtYXhfZHc7Cj4gPiAtICAgICByaW5nLT5wcmlvcml0eSA9IERS
TV9TQ0hFRF9QUklPUklUWV9OT1JNQUw7Cj4gPiAtICAgICBtdXRleF9pbml0KCZyaW5nLT5wcmlv
cml0eV9tdXRleCk7Cj4gPiArICAgICByaW5nLT5od19wcmlvID0gaHdfcHJpbzsKPiA+Cj4gPiAg
ICAgICBpZiAoIXJpbmctPm5vX3NjaGVkdWxlcikgewo+ID4gICAgICAgICAgICAgICBod19pcCA9
IHJpbmctPmZ1bmNzLT50eXBlOwo+ID4gQEAgLTI2OCw5ICsyNjcsNiBAQCBpbnQgYW1kZ3B1X3Jp
bmdfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV9yaW5nICpy
aW5nLAo+ID4gICAgICAgICAgICAgICAgICAgICAgICZyaW5nLT5zY2hlZDsKPiA+ICAgICAgIH0K
PiA+Cj4gPiAtICAgICBmb3IgKGkgPSBEUk1fU0NIRURfUFJJT1JJVFlfTUlOOyBpIDwgRFJNX1ND
SEVEX1BSSU9SSVRZX0NPVU5UOyArK2kpCj4gPiAtICAgICAgICAgICAgIGF0b21pY19zZXQoJnJp
bmctPm51bV9qb2JzW2ldLCAwKTsKPiA+IC0KPiA+ICAgICAgIHJldHVybiAwOwo+ID4gICB9Cj4g
Pgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5n
LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5oCj4gPiBpbmRleCA3
MTEyMTM3Njg5ZGIuLjJhZGE4MGNlNDJmNSAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmgKPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9yaW5nLmgKPiA+IEBAIC0yNDIsMTEgKzI0Miw3IEBAIHN0cnVjdCBhbWRn
cHVfcmluZyB7Cj4gPiAgICAgICBzdHJ1Y3QgZG1hX2ZlbmNlICAgICAgICAqdm1pZF93YWl0Owo+
ID4gICAgICAgYm9vbCAgICAgICAgICAgICAgICAgICAgaGFzX2NvbXB1dGVfdm1fYnVnOwo+ID4g
ICAgICAgYm9vbCAgICAgICAgICAgICAgICAgICAgbm9fc2NoZWR1bGVyOwo+ID4gLQo+ID4gLSAg
ICAgYXRvbWljX3QgICAgICAgICAgICAgICAgbnVtX2pvYnNbRFJNX1NDSEVEX1BSSU9SSVRZX0NP
VU5UXTsKPiA+IC0gICAgIHN0cnVjdCBtdXRleCAgICAgICAgICAgIHByaW9yaXR5X211dGV4Owo+
ID4gLSAgICAgLyogcHJvdGVjdGVkIGJ5IHByaW9yaXR5X211dGV4ICovCj4gPiAtICAgICBpbnQg
ICAgICAgICAgICAgICAgICAgICBwcmlvcml0eTsKPiA+ICsgICAgIGludCAgICAgICAgICAgICAg
ICAgICAgIGh3X3ByaW87Cj4gPgo+ID4gICAjaWYgZGVmaW5lZChDT05GSUdfREVCVUdfRlMpCj4g
PiAgICAgICBzdHJ1Y3QgZGVudHJ5ICplbnQ7Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
