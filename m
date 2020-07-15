Return-Path: <SRS0=Zv7j=A2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14B2C433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2020 16:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 877B72065E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2020 16:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRp5yGnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877B72065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CDE66EBD4;
	Wed, 15 Jul 2020 16:21:03 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02C6C6EBD4
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2020 16:21:01 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id a6so3352127wrm.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2020 09:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CO3Cq2YDgI6uzexmjV0sagPUQk4IIaySBNIP7vG5r6E=;
 b=VRp5yGnM5AqIoMuSv/R9iiGeTrn+stsioxqHMq9nVvtutAFupvt6OtdE1URdokaQHf
 8iWKi6XmfN5kVGULtye6PYIeGigAv5RsF1jdQcqfOrk6awr1EejG3HTdNYAG6aYAwU8f
 yGOtmQ3deO+6vm8TsrJ/ircnSvoMxTMsHPQSccgZftWTJWTculUhmIicGvcupcqYjCwP
 RPk0zb9EI4en1529Tj0n5J/3jhKa83QSiuT8JVCejvWE8Tnn4+DItLnJ8+owyZE0gu6S
 IXvQOrZJEGz3KEIg9orLElTg/KHnuLQVSp5ESxa4i3hpUMHwm8ot2wVYNWCL8IvBTXXZ
 lq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CO3Cq2YDgI6uzexmjV0sagPUQk4IIaySBNIP7vG5r6E=;
 b=B3ibfx93fNTH2aSeRjDOAWb8XBKBbkRX8X9oQHQltVKfxWFemqwQx26ns1249ld+sb
 /H9z+5BfiIs2ra8DMzbqdLLXOTecA/UZBwkpsDKZesdAxQrEkWt4CwcI0YlFcMngk4Vm
 sYY85CFIVXR/kughxla3QxZSgsZFEY5uWCSvHc7Gus5DV9tWjdsVQKvEd9ZEkuo0Igew
 UYRwXHHm1nbFB8PJmyreWJHP8ZKsAeYs+bZ5leriXe9nmFt287q7VYhsO52w+jfqCtxR
 lY3zu0z4BBgF/j/TkEAJTDqd+juEO6gCqIvqccENy+WSR3g3bOT4oGcnz3JtE0wOIdVZ
 azjw==
X-Gm-Message-State: AOAM533gce2jZhRyUQXLTGv9aGYIltyWbP76JXRitp64tLYyLFwnX7no
 sA7nd8e7omUFjUmyDNlULq4rodHYk2XnEk+p7qc=
X-Google-Smtp-Source: ABdhPJy7XYhgPNG7WbJ3PH97Klttzk50Qg0rG/JnuhvX5B5vRwRPkR5dpfn1+SWctGZaSwag/VKE/VyN+sM+LI2k6QQ=
X-Received: by 2002:a5d:68cc:: with SMTP id p12mr146268wrw.111.1594830060623; 
 Wed, 15 Jul 2020 09:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200714182353.2164930-1-alexander.deucher@amd.com>
 <20200714182353.2164930-2-alexander.deucher@amd.com>
 <6609b826-c7ce-398a-e3a8-d146797063c9@gmail.com>
 <CADnq5_MzQSLfdm2_z=2rtd90WbaDGGzv2g+Gkr0hxeXeydmshw@mail.gmail.com>
In-Reply-To: <CADnq5_MzQSLfdm2_z=2rtd90WbaDGGzv2g+Gkr0hxeXeydmshw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Jul 2020 12:20:49 -0400
Message-ID: <CADnq5_Nz=NFfhbp1F=aTjTeJf9Wmnkbq_QhuDceDJyYvhvpHMQ@mail.gmail.com>
Subject: Re: [PATCH 01/42] drm/amdgpu: expand to add multiple trap event irq id
To: Christian Koenig <christian.koenig@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBKdWwgMTUsIDIwMjAgYXQgOToyNCBBTSBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVy
QGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBPbiBXZWQsIEp1bCAxNSwgMjAyMCBhdCA1OjIxIEFNIENo
cmlzdGlhbiBLw7ZuaWcKPiA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IHdyb3Rl
Ogo+ID4KPiA+IEFtIDE0LjA3LjIwIHVtIDIwOjIzIHNjaHJpZWIgQWxleCBEZXVjaGVyOgo+ID4g
PiBGcm9tOiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgo+ID4gPgo+ID4gPiBTaWVubmFf
Y2ljaGxpZCBoYXMgZm91ciBzZG1hIGluc3RhbmNlcywgYnV0IG90aGVyIGNoaXBzIGRvbid0Lgo+
ID4gPiBTbyB3ZSBuZWVkIGV4cGFuZCB0byBhZGQgbXVsdGlwbGUgdHJhcCBldmVudCBpcnEgaWQg
aW4gc2RtYQo+ID4gPiB2NS4yLgo+ID4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBIdWFuZyBSdWkg
PHJheS5odWFuZ0BhbWQuY29tPgo+ID4gPiBSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4
YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gPgo+ID4gUmV2aWV3ZWQtYnk6IENocmlzdGlh
biBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiA+Cj4gPiBCdXQgc2lkZSBxdWVz
dGlvbiB3aHkgZG8gd2UgaGF2ZSB0aGUgX1NpZW5uYV9DaWNobGlkIHBvc3RmaXggb24gdGhlIGRl
ZmluZT8KPgo+IEkgc3VzcGVjdCB3aGVuIGl0IHdhcyBvcmlnaW5hbGx5IGFkZGVkIGl0IHdhcyBz
cGVjaWZpYyB0byBzaWVubmEKPiBjaWNobGlkLCBidXQgaXQgc2hvdWxkIGJlIGRyb3BwZWQgc2lu
Y2UgaXQncyBnZW5lcmljLgoKSnVzdCBjaGVja2VkIGFuZCBpdCdzIHNwZWNpZmljIHRvIHRoaXMg
ZmFtaWx5IG9mIGFzaWNzLiAgT3RoZXIgYXNpY3MKdXNlIGEgZGlmZmVyZW50IGNsaWVudCBpZCBm
b3IgU0RNQTMuICBTZWUgc29jMTVfaWhfY2xpZW50aWQuaC4KCkFsZXgKCj4KPiBBbGV4Cj4KPgo+
ID4KPiA+IENocmlzdGlhbi4KPiA+Cj4gPiA+IC0tLQo+ID4gPiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3NkbWFfdjVfMi5jIHwgNjcgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0KPiA+
ID4gICAxIGZpbGUgY2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pCj4g
PiA+Cj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1
XzIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMi5jCj4gPiA+IGluZGV4
IDgyNGYzZTIzYzNkOS4uZGU4MzQyMjgzZmRiIDEwMDY0NAo+ID4gPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzIuYwo+ID4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9zZG1hX3Y1XzIuYwo+ID4gPiBAQCAtMTE2NSw2ICsxMTY1LDQwIEBAIHN0YXRp
YyBpbnQgc2RtYV92NV8yX2Vhcmx5X2luaXQodm9pZCAqaGFuZGxlKQo+ID4gPiAgICAgICByZXR1
cm4gMDsKPiA+ID4gICB9Cj4gPiA+Cj4gPiA+ICtzdGF0aWMgdW5zaWduZWQgc2RtYV92NV8yX3Nl
cV90b19pcnFfaWQoaW50IHNlcV9udW0pCj4gPiA+ICt7Cj4gPiA+ICsgICAgIHN3aXRjaCAoc2Vx
X251bSkgewo+ID4gPiArICAgICBjYXNlIDA6Cj4gPiA+ICsgICAgICAgICAgICAgcmV0dXJuIFNP
QzE1X0lIX0NMSUVOVElEX1NETUEwOwo+ID4gPiArICAgICBjYXNlIDE6Cj4gPiA+ICsgICAgICAg
ICAgICAgcmV0dXJuIFNPQzE1X0lIX0NMSUVOVElEX1NETUExOwo+ID4gPiArICAgICBjYXNlIDI6
Cj4gPiA+ICsgICAgICAgICAgICAgcmV0dXJuIFNPQzE1X0lIX0NMSUVOVElEX1NETUEyOwo+ID4g
PiArICAgICBjYXNlIDM6Cj4gPiA+ICsgICAgICAgICAgICAgcmV0dXJuIFNPQzE1X0lIX0NMSUVO
VElEX1NETUEzX1NpZW5uYV9DaWNobGlkOwo+ID4gPiArICAgICBkZWZhdWx0Ogo+ID4gPiArICAg
ICAgICAgICAgIGJyZWFrOwo+ID4gPiArICAgICB9Cj4gPiA+ICsgICAgIHJldHVybiAtRUlOVkFM
Owo+ID4gPiArfQo+ID4gPiArCj4gPiA+ICtzdGF0aWMgdW5zaWduZWQgc2RtYV92NV8yX3NlcV90
b190cmFwX2lkKGludCBzZXFfbnVtKQo+ID4gPiArewo+ID4gPiArICAgICBzd2l0Y2ggKHNlcV9u
dW0pIHsKPiA+ID4gKyAgICAgY2FzZSAwOgo+ID4gPiArICAgICAgICAgICAgIHJldHVybiBTRE1B
MF81XzBfX1NSQ0lEX19TRE1BX1RSQVA7Cj4gPiA+ICsgICAgIGNhc2UgMToKPiA+ID4gKyAgICAg
ICAgICAgICByZXR1cm4gU0RNQTFfNV8wX19TUkNJRF9fU0RNQV9UUkFQOwo+ID4gPiArICAgICBj
YXNlIDI6Cj4gPiA+ICsgICAgICAgICAgICAgcmV0dXJuIFNETUEyXzVfMF9fU1JDSURfX1NETUFf
VFJBUDsKPiA+ID4gKyAgICAgY2FzZSAzOgo+ID4gPiArICAgICAgICAgICAgIHJldHVybiBTRE1B
M181XzBfX1NSQ0lEX19TRE1BX1RSQVA7Cj4gPiA+ICsgICAgIGRlZmF1bHQ6Cj4gPiA+ICsgICAg
ICAgICAgICAgYnJlYWs7Cj4gPiA+ICsgICAgIH0KPiA+ID4gKyAgICAgcmV0dXJuIC1FSU5WQUw7
Cj4gPiA+ICt9Cj4gPiA+ICsKPiA+ID4gICBzdGF0aWMgaW50IHNkbWFfdjVfMl9zd19pbml0KHZv
aWQgKmhhbmRsZSkKPiA+ID4gICB7Cj4gPiA+ICAgICAgIHN0cnVjdCBhbWRncHVfcmluZyAqcmlu
ZzsKPiA+ID4gQEAgLTExNzIsMzIgKzEyMDYsMTMgQEAgc3RhdGljIGludCBzZG1hX3Y1XzJfc3df
aW5pdCh2b2lkICpoYW5kbGUpCj4gPiA+ICAgICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOwo+ID4gPgo+ID4gPiAgICAgICAvKiBT
RE1BIHRyYXAgZXZlbnQgKi8KPiA+ID4gLSAgICAgciA9IGFtZGdwdV9pcnFfYWRkX2lkKGFkZXYs
IFNPQzE1X0lIX0NMSUVOVElEX1NETUEwLAo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAg
ICAgU0RNQTBfNV8wX19TUkNJRF9fU0RNQV9UUkFQLAo+ID4gPiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgJmFkZXYtPnNkbWEudHJhcF9pcnEpOwo+ID4gPiAtICAgICBpZiAocikKPiA+ID4g
LSAgICAgICAgICAgICByZXR1cm4gcjsKPiA+ID4gLQo+ID4gPiAtICAgICAvKiBTRE1BIHRyYXAg
ZXZlbnQgKi8KPiA+ID4gLSAgICAgciA9IGFtZGdwdV9pcnFfYWRkX2lkKGFkZXYsIFNPQzE1X0lI
X0NMSUVOVElEX1NETUExLAo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgU0RNQTFf
NV8wX19TUkNJRF9fU0RNQV9UUkFQLAo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAg
JmFkZXYtPnNkbWEudHJhcF9pcnEpOwo+ID4gPiAtICAgICBpZiAocikKPiA+ID4gLSAgICAgICAg
ICAgICByZXR1cm4gcjsKPiA+ID4gLQo+ID4gPiAtICAgICAvKiBTRE1BIHRyYXAgZXZlbnQgKi8K
PiA+ID4gLSAgICAgciA9IGFtZGdwdV9pcnFfYWRkX2lkKGFkZXYsIFNPQzE1X0lIX0NMSUVOVElE
X1NETUEyLAo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgU0RNQTJfNV8wX19TUkNJ
RF9fU0RNQV9UUkFQLAo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgJmFkZXYtPnNk
bWEudHJhcF9pcnEpOwo+ID4gPiAtICAgICBpZiAocikKPiA+ID4gLSAgICAgICAgICAgICByZXR1
cm4gcjsKPiA+ID4gLQo+ID4gPiAtICAgICAvKiBTRE1BIHRyYXAgZXZlbnQgKi8KPiA+ID4gLSAg
ICAgciA9IGFtZGdwdV9pcnFfYWRkX2lkKGFkZXYsIFNPQzE1X0lIX0NMSUVOVElEX1NETUEzX1Np
ZW5uYV9DaWNobGlkLAo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgU0RNQTNfNV8w
X19TUkNJRF9fU0RNQV9UUkFQLAo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgJmFk
ZXYtPnNkbWEudHJhcF9pcnEpOwo+ID4gPiAtICAgICBpZiAocikKPiA+ID4gLSAgICAgICAgICAg
ICByZXR1cm4gcjsKPiA+ID4gKyAgICAgZm9yIChpID0gMDsgaSA8IGFkZXYtPnNkbWEubnVtX2lu
c3RhbmNlczsgaSsrKSB7Cj4gPiA+ICsgICAgICAgICAgICAgciA9IGFtZGdwdV9pcnFfYWRkX2lk
KGFkZXYsIHNkbWFfdjVfMl9zZXFfdG9faXJxX2lkKGkpLAo+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzZG1hX3Y1XzJfc2VxX3RvX3RyYXBfaWQoaSksCj4gPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZhZGV2LT5zZG1hLnRyYXBfaXJxKTsK
PiA+ID4gKyAgICAgICAgICAgICBpZiAocikKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiByOwo+ID4gPiArICAgICB9Cj4gPiA+Cj4gPiA+ICAgICAgIHIgPSBzZG1hX3Y1XzJfaW5p
dF9taWNyb2NvZGUoYWRldik7Cj4gPiA+ICAgICAgIGlmIChyKSB7Cj4gPgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
