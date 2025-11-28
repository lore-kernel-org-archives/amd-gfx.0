Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699FDCFD376
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Nov 2025 13:54:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3CF010E164;
	Fri, 28 Nov 2025 13:54:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WFyGcvUb";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A14F110E0DB
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Nov 2025 13:54:38 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so16501195e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Nov 2025 05:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764338077; x=1764942877; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=k/Xb6ZCd9zF9LuAxz9w5rrqI6yry5pZrnJ0XGKjtAGk=;
 b=WFyGcvUbykdRIQ7Cp+0qaV/+5Q8zybrkfz6zOC3mbqdFKt+DkcIuCQq6ieffDp3Vu8
 sIRxBsSebz9o6EPWNQ5wNSLQNOP1g+6r9+Ea6R8AErJuZtlX9tzH/+lejyRrSZ2oHHWw
 hY4fEtdvshL8lsWPYl2xka++aWAMAEgCnFhOzYl0/2MuPcCUKQGScLaKNdBEepKvH8qL
 Vmq5PGeR0ZuhRcNUkCHHn8dobxn4EERm1Rt1rbFAjL6zDo0yOWJV9elWz+Ts5FhoxYdH
 v7I19ZBeXMVRPFpdWccbbZ7QfKtJWhQGk5laSOemeCFvq5H/8LXkasV74BBbVTH3/gBr
 sDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764338077; x=1764942877;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k/Xb6ZCd9zF9LuAxz9w5rrqI6yry5pZrnJ0XGKjtAGk=;
 b=EExRYAR19ckXrxqFjb89vnVr+ttgZtOjZ9gS5MEusMgFNoRfQ9OK17QTZ9T8T9Glv0
 YoeyB3T/OVstQn7LP9pM0AI6NZrw13RZHluOdDmgGuv+etN/wP9aYKqKu8br1iLmncUu
 XL41noVnns3xlLx/UU3UW6K9M4CSG/2Tkocj7VrY/a1r/IMz6ukYA1DJbdKXuUXJ6S1l
 Hi+LbfCEEE7ZYoOpnV4TTPm6W7clMP2/ZUFvmRK9lu+W0sW5P1I6MteriW4SaChR4NVr
 7sqdb4HMQhpVCPppURHCCeYOeGvkhiS5u9SmbjhiGn6/TYSBTytgsCtDzubXlUw+ggPN
 FuKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMqT7ThH7w9cO5xB7+Cw/5PragmR+v40W7PI+oktb5eUKv/D8t5CFNWugBLkgV5ZNH5ttePqKp@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwtI+a0UX+GOL2g0xHqNDq2lLfhF6gp00TZmv97+XAw60PDpx1x
 7ICaAug0y2ashUkL9VxEejP9zzCAOVJQqflMzG4xQ6CIAs71n0ndl87c
X-Gm-Gg: ASbGnctQ1CsY0RMxu8A9uhkY+53yMugZNG5ZCphyEGgek4aMD9EOvFWBI3mkxtEAH4t
 9VrtTJT1MZ+NAp3ONlnZCdKFdBFjt0D0/oepmlGXXXASIPzLOt5DugQXlk+eL+WOB3M5fOXO0dP
 OMjvgrwgwi4Vqbeho0Dc7fxGsXCzTktPR0xKqnrGrbp1G8xDlLwpMQHQcXIeKAEHTbC986VPz/4
 xPcmimswGXRgUwIoDvk1N2FSzZsxdpPVJ5+RNB1EAh8DtHwmoP8/56UB1dHH8zi+IZ9+9Z5bHy1
 9e716bm9ln1BjCQcdiJLkIpzZG2eHYMQDpJqDrGYnDEh572vw7xvZ8uPwr4OkHW956cYXIYnj9e
 diiHKRKzEI7I9/F61XJhNeXRWL3jBjye9EEjt605XfusqpP4lgqrTZd3I+rZmkgOWM09yZGY0aj
 RwZpVRqEfMk5VgghFVr7mDBlg8zjQVYi47NOo9uVFcTEqeyD3bs7VWQPJV94sJeelfy+aud8qTg
 Bz/S8+0r8XYe8UZIyjIqJ0vasYaSToo9tHiWm4S4ncB
X-Google-Smtp-Source: AGHT+IFjzXZvzpt+SKVjE+s/Mc2rpsJBXYzaMLfsa3spISyTarb/RUg39ECVstUsYvePJWsDRKJCUw==
X-Received: by 2002:a05:600c:4ed3:b0:477:b734:8c22 with SMTP id
 5b1f17b1804b1-47904ad05bbmr153772985e9.8.1764338076825; 
 Fri, 28 Nov 2025 05:54:36 -0800 (PST)
Received: from ?IPv6:2001:4c4e:24f0:8900:9d3a:f8:80b:b4b?
 (20014C4E24F089009D3A00F8080B0B4B.dsl.pool.telekom.hu.
 [2001:4c4e:24f0:8900:9d3a:f8:80b:b4b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479138711a0sm30448765e9.2.2025.11.28.05.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 05:54:36 -0800 (PST)
Message-ID: <f771e717b5a8d85fd85fcc11d1014717b1d17290.camel@gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu/gmc11: add amdgpu_vm_handle_fault()
 handling
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric@damsy.net>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Christian =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>
Date: Fri, 28 Nov 2025 14:54:34 +0100
In-Reply-To: <CADnq5_N9rcs9F-V=BYWUaVDLnN7Lcqh7XOFjmfx0u6BuSruHMg@mail.gmail.com>
References: <20251118220637.3594610-1-alexander.deucher@amd.com>
 <264534d7-86cc-4964-8225-07a32e2373cd@damsy.net>
 <CADnq5_PZr7Ce4weM1zc+CnwREM6A2=e57QBKBsbkm0s4theseg@mail.gmail.com>
 <CADnq5_N9rcs9F-V=BYWUaVDLnN7Lcqh7XOFjmfx0u6BuSruHMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCAyMDI1LTExLTI2IGF0IDA5OjEyIC0wNTAwLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4g
UGluZyBvbiB0aGlzIHNlcmllcz8KCk15IGFwb2xvZ2llcywgSSd2ZSBtaXNzZWQgdGhpcy4KClRo
ZSBzZXJpZXMgbWFrZXMgZ29vZCBzZW5zZSB0byBtZS4KUmV2aWV3ZWQtYnk6IFRpbXVyIEtyaXN0
w7NmIDx0aW11ci5rcmlzdG9mQGdtYWlsLmNvbT4KClRob3VnaCwgaGF2ZW4ndCB5ZXQgdGVzdGVk
IHBlcnNvbmFsbHkuCkFsc28gYWRkZWQgQ2hyaXN0aWFuIHRvIENDLgoKPiAKPiBPbiBXZWQsIE5v
diAxOSwgMjAyNSBhdCAxMDoxNuKAr0FNIEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwu
Y29tPgo+IHdyb3RlOgo+ID4gCj4gPiBPbiBXZWQsIE5vdiAxOSwgMjAyNSBhdCAzOjE04oCvQU0g
UGllcnJlLUVyaWMgUGVsbG91eC1QcmF5ZXIKPiA+IDxwaWVycmUtZXJpY0BkYW1zeS5uZXQ+IHdy
b3RlOgo+ID4gPiAKPiA+ID4gCj4gPiA+IAo+ID4gPiBMZSAxOC8xMS8yMDI1IMOgIDIzOjA2LCBB
bGV4IERldWNoZXIgYSDDqWNyaXQgOgo+ID4gPiA+IFdlIG5lZWQgdG8gY2FsbCBhbWRncHVfdm1f
aGFuZGxlX2ZhdWx0KCkgb24gcGFnZSBmYXVsdAo+ID4gPiA+IG9uIGFsbCBnZng5IGFuZCBuZXdl
ciBwYXJ0cyB0byBwcm9wZXJseSB1cGRhdGUgdGhlCj4gPiA+ID4gcGFnZSB0YWJsZXMsIG5vdCBq
dXN0IGZvciByZWNvdmVyYWJsZSBwYWdlIGZhdWx0cy4KPiA+ID4gPiAKPiA+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gPiA+ID4g
LS0tCj4gPiA+ID4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMV8wLmMgfCAy
Nwo+ID4gPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrCj4gPiA+ID4gwqAgMSBmaWxlIGNo
YW5nZWQsIDI3IGluc2VydGlvbnMoKykKPiA+ID4gPiAKPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMV8wLmMKPiA+ID4gPiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dtY192MTFfMC5jCj4gPiA+ID4gaW5kZXggN2JjMzg5ZDlmNWM0OC4u
MjVjZGNiODUwNDE2YyAxMDA2NDQKPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nbWNfdjExXzAuYwo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dtY192MTFfMC5jCj4gPiA+ID4gQEAgLTEwMywxMiArMTAzLDM5IEBAIHN0YXRpYyBpbnQKPiA+
ID4gPiBnbWNfdjExXzBfcHJvY2Vzc19pbnRlcnJ1cHQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsCj4gPiA+ID4gwqDCoMKgwqDCoCB1aW50MzJfdCB2bWh1Yl9pbmRleCA9IGVudHJ5LT5jbGll
bnRfaWQgPT0KPiA+ID4gPiBTT0MyMV9JSF9DTElFTlRJRF9WTUMgPwo+ID4gPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFNREdQVV9N
TUhVQjAoMCkgOgo+ID4gPiA+IEFNREdQVV9HRlhIVUIoMCk7Cj4gPiA+ID4gwqDCoMKgwqDCoCBz
dHJ1Y3QgYW1kZ3B1X3ZtaHViICpodWIgPSAmYWRldi0+dm1odWJbdm1odWJfaW5kZXhdOwo+ID4g
PiA+ICvCoMKgwqDCoCBib29sIHJldHJ5X2ZhdWx0ID0gISEoZW50cnktPnNyY19kYXRhWzFdICYg
MHg4MCk7Cj4gPiA+ID4gK8KgwqDCoMKgIGJvb2wgd3JpdGVfZmF1bHQgPSAhIShlbnRyeS0+c3Jj
X2RhdGFbMV0gJiAweDIwKTsKPiA+ID4gPiDCoMKgwqDCoMKgIHVpbnQzMl90IHN0YXR1cyA9IDA7
Cj4gPiA+ID4gwqDCoMKgwqDCoCB1NjQgYWRkcjsKPiA+ID4gPiAKPiA+ID4gPiDCoMKgwqDCoMKg
IGFkZHIgPSAodTY0KWVudHJ5LT5zcmNfZGF0YVswXSA8PCAxMjsKPiA+ID4gPiDCoMKgwqDCoMKg
IGFkZHIgfD0gKCh1NjQpZW50cnktPnNyY19kYXRhWzFdICYgMHhmKSA8PCA0NDsKPiA+ID4gPiAK
PiA+ID4gPiArwqDCoMKgwqAgaWYgKHJldHJ5X2ZhdWx0KSB7Cj4gPiA+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAvKiBSZXR1cm5pbmcgMSBoZXJlIGFsc28gcHJldmVudHMgc2VuZGluZyB0
aGUgSVYKPiA+ID4gPiB0byB0aGUgS0ZEICovCj4gPiA+ID4gKwo+ID4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgLyogUHJvY2VzcyBpdCBvbnlsIGlmIGl0J3MgdGhlIGZpcnN0IGZhdWx0
IGZvcgo+ID4gPiA+IHRoaXMgYWRkcmVzcyAqLwo+ID4gPiAKPiA+ID4gdHlwbzogb255bCAtPiBv
bmx5IChzYW1lIGZvciBwYXRjaCAyLzMpCj4gPiAKPiA+IEZpeGVkIGxvY2FsbHkuwqAgdGhhbmtz
IQo+ID4gCj4gPiBBbGV4Cj4gPiAKPiA+ID4gCj4gPiA+IFBpZXJyZS1FcmljCj4gPiA+IAo+ID4g
PiAKPiA+ID4gCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZW50cnktPmlo
ICE9ICZhZGV2LT5pcnEuaWhfc29mdCAmJgo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBhbWRncHVfZ21jX2ZpbHRlcl9mYXVsdHMoYWRldiwgZW50cnktPmloLAo+ID4g
PiA+IGFkZHIsIGVudHJ5LT5wYXNpZCwKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBlbnRyeS0+dGltZXN0YW1wKSkKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gMTsKPiA+ID4gPiArCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAvKiBEZWxlZ2F0ZSBpdCB0byBhIGRpZmZlcmVudCByaW5nIGlmIHRoZQo+ID4g
PiA+IGhhcmR3YXJlIGhhc24ndAo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAq
IGFscmVhZHkgZG9uZSBpdC4KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8K
PiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChlbnRyeS0+aWggPT0gJmFkZXYt
PmlycS5paCkgewo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGFtZGdwdV9pcnFfZGVsZWdhdGUoYWRldiwgZW50cnksIDgpOwo+ID4gPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAxOwo+ID4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+ID4gPiA+ICsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIC8qIFRyeSB0byBoYW5kbGUgdGhlIHJlY292ZXJhYmxlIHBhZ2UgZmF1bHRzIGJ5
Cj4gPiA+ID4gZmlsbGluZyBwYWdlCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICogdGFibGVzCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gPiA+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoYW1kZ3B1X3ZtX2hhbmRsZV9mYXVsdChhZGV2
LCBlbnRyeS0+cGFzaWQsIDAsCj4gPiA+ID4gMCwgYWRkciwKPiA+ID4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGVudHJ5LT50aW1lc3RhbXAsCj4gPiA+ID4gd3JpdGVfZmF1bHQpKQo+ID4gPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAxOwo+ID4g
PiA+ICvCoMKgwqDCoCB9Cj4gPiA+ID4gKwo+ID4gPiA+IMKgwqDCoMKgwqAgaWYgKCFhbWRncHVf
c3Jpb3ZfdmYoYWRldikpIHsKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKgo+
ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBJc3N1ZSBhIGR1bW15IHJlYWQg
dG8gd2FpdCBmb3IgdGhlIHN0YXR1cwo+ID4gPiA+IHJlZ2lzdGVyIHRvCg==

