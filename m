Return-Path: <SRS0=hFGi=CM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A85C433E7
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 08:06:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3A8720767
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 08:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3hPP9lw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A8720767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CF686E824;
	Thu,  3 Sep 2020 08:06:00 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C9916E199
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2020 08:05:59 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id a65so1860631wme.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Sep 2020 01:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=wktN63x8AOD2KnA7lPnvhJcZHJVie/mkkNQrkaaUXQs=;
 b=B3hPP9lwheRCEXNJhDR6Ll7uVxJfcsZKND7RuY18m6DoSX2kOeXjnIluLM34OSSaqj
 COTL9tXNCXn2iEi5dCKT2MM2ojspll7GDjJ+/KgudctqLbkPCq+2jc7WL0MweXPilcsv
 f8+VZLyipOXq81xqCldewDeFAAyIG8b5CodM5ZUyZmKEYJc+DR0zRn6G4jNtPaAzS0Gx
 4Eis8MHm8vgJR4W63AHmcDYg7fKAeYXgp7G9DwOitoXPp2PTf4F7bXrbK7poy2Q+0wmB
 HqMZvZ7LkdzbXGVjzZHUjXq5Y28sTulspAgHwvQZqmEwpY3HEKLd+QNZlhE2EYf845u4
 AQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=wktN63x8AOD2KnA7lPnvhJcZHJVie/mkkNQrkaaUXQs=;
 b=VAt5dM1VdlQBtlNC2Mfa8b3XzS1CJB2VfXcSH/RnMeB6NjtTSHh7iRF4OpexidiFLf
 jsFekad6tMf//jY6CG8+VHwwtiC/0xeDMPB8Vj5bx5fgDP7LV+2utfENH8br6JcOt4p6
 nlC9eOt8z1db/OSQg5VzCVhySu+vQxYo1UsYz7iOBfjqy1TZVcneevqOJt3OSFRNxQCp
 c9Uk8xrXvCiLACUEaX4kgjS9pjD8q/ii+gzc+8o07jfKZkPBe94FLZ6rgYKgFmVTZOm2
 LQ+vyIum0F2hMAAgRYbyvoBb02n3/zGPgII6vPo265p4/di3SQaRGulOXr+n1zZztRy8
 4q5A==
X-Gm-Message-State: AOAM5322fAm/rxzChYcLUbEyC7U4p/E8USdZGIE8De0U4DqWnwkHl7HH
 t3HmstWHfgb35If+NFb1ohoc8/SFpFY=
X-Google-Smtp-Source: ABdhPJyZonogJj7n6k0K4isIZ+TDtmif8F9g29TdQI5nQLWgRuPDLeWPeVIZITo5t4Qlk8NhGEnItA==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr1147141wmb.84.1599120357469; 
 Thu, 03 Sep 2020 01:05:57 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id n8sm3254243wra.32.2020.09.03.01.05.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 01:05:56 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: enable ih1 ih2 for Arcturus only
To: Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, Alex Sierra <alex.sierra@amd.com>
References: <20200902170118.30751-1-alex.sierra@amd.com>
 <CADnq5_NRFr5vYfuwgMHQ5Y+19_UqXPoJYomBkwGMoWkvjpA_Fw@mail.gmail.com>
 <CADnq5_MFC=r=NxhzZ2OmO7EaodZXtGDQxgqw2146DGQoioShwA@mail.gmail.com>
 <2ea7e8e2-8a96-8006-a5ee-41ebfecbf6f1@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <edce428d-eb18-23d3-418a-be720c5b227c@gmail.com>
Date: Thu, 3 Sep 2020 10:05:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2ea7e8e2-8a96-8006-a5ee-41ebfecbf6f1@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDIuMDkuMjAgdW0gMjA6Mjggc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBBbSAyMDIwLTA5
LTAyIHVtIDI6MTMgcC5tLiBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPj4gT24gV2VkLCBTZXAgMiwg
MjAyMCBhdCAyOjA4IFBNIEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPiB3cm90
ZToKPj4+IE9uIFdlZCwgU2VwIDIsIDIwMjAgYXQgMTowMSBQTSBBbGV4IFNpZXJyYSA8YWxleC5z
aWVycmFAYW1kLmNvbT4gd3JvdGU6Cj4+Pj4gRW5hYmxlIG11bHRpLXJpbmcgaWgxIGFuZCBpaDIg
Zm9yIEFyY3R1cnVzIG9ubHkuCj4+Pj4gRm9yIE5hdmkxMCBmYW1pbHkgbXVsdGktcmluZyBoYXMg
YmVlbiBkaXNhYmxlZC4KPj4+PiBBcHBhcmVudGx5LCBoYXZpbmcgbXVsdGktcmluZyBlbmFibGVk
IGluIE5hdmkgd2FzIGNhdXNpbmcKPj4+PiBjb250aW51cyBwYWdlIGZhdWx0IGludGVycnVwdHMu
Cj4+Pj4gRnVydGhlciBpbnZlc3RpZ2F0aW9uIGlzIG5lZWRlZCB0byBnZXQgdG8gdGhlIHJvb3Qg
Y2F1c2UuCj4+Pj4gUmVsYXRlZCBpc3N1ZSBsaW5rOgo+Pj4+IGh0dHBzOi8vZ2l0bGFiLmZyZWVk
ZXNrdG9wLm9yZy9kcm0vYW1kLy0vaXNzdWVzLzEyNzkKPj4+Pgo+Pj4gQmVmb3JlIGNvbW1pdHRp
bmcsIGxldCdzIHZlcmlmeSB0aGF0IGl0IGZpeGVzIHRoYXQgaXNzdWUuCj4+IExvb2tpbmcgYXQg
dGhlIGJ1ZyByZXBvcnQsIHRoZSBPU1MgKHByZXN1bWFibHkgSUgpIGJsb2NrIGlzIGNhdXNpbmcg
YQo+PiB3cml0ZSBmYXVsdCBzbyBJIHN1c3BlY3QgYXJjdHVydXMgbWF5IGJlIGFmZmVjdGVkIGJ5
IHRoaXMgYXMgd2VsbC4gIFdlCj4+IHNob3VsZCBkb3VibGUgY2hlY2sgdGhlIHJpbmcgc2l6ZXMg
YW5kIGFsbG9jYXRpb25zLgo+IEFsZWphbmRybyBoYXMgYmVlbiBkb2luZyBhIGxvdCBvZiB0ZXN0
aW5nIG9uIEFyY3R1cnVzIGFuZCBkaWRuJ3QgcnVuCj4gaW50byB0aGlzIHByb2JsZW0uIFRoYXQn
cyB3aHkgSSBzdWdnZXN0ZWQgb25seSBkaXNhYmxpbmcgdGhlIElIIHJpbmdzIG9uCj4gTmF2aTEw
IGZvciBub3cuIFdlIG5lZWQgdGhlIGV4dHJhIHJpbmdzIG9uIEFyY3R1cnVzIGZvciBvdXIgSE1N
IHdvcmsuCgpJIHRoaW5rIHdlIHNob3VsZCBmdXJ0aGVyIGludmVzdGlnYXRlIHRoaXMgYmVmb3Jl
IGFwcGx5aW5nIGFueSBwYXRjaGVzLgoKV2hlbiBOYXZpMTAgaXMgYWZmZWN0ZWQgaXQncyBsaWtl
bHkgdGhhdCBvdGhlciBOYXZpIGdlbmVyYXRpb25zIGFyZSBhcyAKd2VsbCBzaW5jZSBBRkFJSyB0
aGUgT1NTIGhhc24ndCBjaGFuZ2VkIG11Y2ggYmV0d2VlbiBnZW5lcmF0aW9ucy4KClJlZ2FyZHMs
CkNocmlzdGlhbi4KCj4KPiBSZWdhcmRzLAo+ICDCoCBGZWxpeAo+Cj4KPj4gQWxleAo+Pgo+Pgo+
Pj4gQWxleAo+Pj4KPj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogQWxleCBTaWVycmEgPGFsZXguc2ll
cnJhQGFtZC5jb20+Cj4+Pj4gLS0tCj4+Pj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9u
YXZpMTBfaWguYyB8IDMwICsrKysrKysrKysrKysrKystLS0tLS0tLS0tCj4+Pj4gICAxIGZpbGUg
Y2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCj4+Pj4KPj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmF2aTEwX2loLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9uYXZpMTBfaWguYwo+Pj4+IGluZGV4IDM1MGYxYmYwNjNjNi4u
NGQ3Mzg2OTg3MGFiIDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L25hdmkxMF9paC5jCj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmF2aTEw
X2loLmMKPj4+PiBAQCAtMzA2LDcgKzMwNiw4IEBAIHN0YXRpYyBpbnQgbmF2aTEwX2loX2lycV9p
bml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+Pj4+ICAgICAgICAgIH0gZWxzZSB7Cj4+
Pj4gICAgICAgICAgICAgICAgICBXUkVHMzJfU09DMTUoT1NTU1lTLCAwLCBtbUlIX1JCX0NOVEws
IGloX3JiX2NudGwpOwo+Pj4+ICAgICAgICAgIH0KPj4+PiAtICAgICAgIG5hdmkxMF9paF9yZXJv
dXRlX2loKGFkZXYpOwo+Pj4+ICsgICAgICAgaWYgKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX0FS
Q1RVUlVTKQo+Pj4+ICsgICAgICAgICAgICAgICBuYXZpMTBfaWhfcmVyb3V0ZV9paChhZGV2KTsK
Pj4+Pgo+Pj4+ICAgICAgICAgIGlmICh1bmxpa2VseShhZGV2LT5maXJtd2FyZS5sb2FkX3R5cGUg
PT0gQU1ER1BVX0ZXX0xPQURfRElSRUNUKSkgewo+Pj4+ICAgICAgICAgICAgICAgICAgaWYgKGlo
LT51c2VfYnVzX2FkZHIpIHsKPj4+PiBAQCAtNjY4LDE5ICs2NjksMjYgQEAgc3RhdGljIGludCBu
YXZpMTBfaWhfc3dfaW5pdCh2b2lkICpoYW5kbGUpCj4+Pj4gICAgICAgICAgYWRldi0+aXJxLmlo
LnVzZV9kb29yYmVsbCA9IHRydWU7Cj4+Pj4gICAgICAgICAgYWRldi0+aXJxLmloLmRvb3JiZWxs
X2luZGV4ID0gYWRldi0+ZG9vcmJlbGxfaW5kZXguaWggPDwgMTsKPj4+Pgo+Pj4+IC0gICAgICAg
ciA9IGFtZGdwdV9paF9yaW5nX2luaXQoYWRldiwgJmFkZXYtPmlycS5paDEsIFBBR0VfU0laRSwg
dHJ1ZSk7Cj4+Pj4gLSAgICAgICBpZiAocikKPj4+PiAtICAgICAgICAgICAgICAgcmV0dXJuIHI7
Cj4+Pj4gKyAgICAgICBhZGV2LT5pcnEuaWgxLnJpbmdfc2l6ZSA9IDA7Cj4+Pj4gKyAgICAgICBh
ZGV2LT5pcnEuaWgyLnJpbmdfc2l6ZSA9IDA7Cj4+Pj4KPj4+PiAtICAgICAgIGFkZXYtPmlycS5p
aDEudXNlX2Rvb3JiZWxsID0gdHJ1ZTsKPj4+PiAtICAgICAgIGFkZXYtPmlycS5paDEuZG9vcmJl
bGxfaW5kZXggPSAoYWRldi0+ZG9vcmJlbGxfaW5kZXguaWggKyAxKSA8PCAxOwo+Pj4+ICsgICAg
ICAgaWYgKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX0FSQ1RVUlVTKSB7Cj4+Pj4gKyAgICAgICAg
ICAgICAgIHIgPSBhbWRncHVfaWhfcmluZ19pbml0KGFkZXYsICZhZGV2LT5pcnEuaWgxLCBQQUdF
X1NJWkUsIHRydWUpOwo+Pj4+ICsgICAgICAgICAgICAgICBpZiAocikKPj4+PiArICAgICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gcjsKPj4+Pgo+Pj4+IC0gICAgICAgciA9IGFtZGdwdV9paF9y
aW5nX2luaXQoYWRldiwgJmFkZXYtPmlycS5paDIsIFBBR0VfU0laRSwgdHJ1ZSk7Cj4+Pj4gLSAg
ICAgICBpZiAocikKPj4+PiAtICAgICAgICAgICAgICAgcmV0dXJuIHI7Cj4+Pj4gKyAgICAgICAg
ICAgICAgIGFkZXYtPmlycS5paDEudXNlX2Rvb3JiZWxsID0gdHJ1ZTsKPj4+PiArICAgICAgICAg
ICAgICAgYWRldi0+aXJxLmloMS5kb29yYmVsbF9pbmRleCA9Cj4+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIChhZGV2LT5kb29yYmVsbF9pbmRleC5paCArIDEpIDw8
IDE7Cj4+Pj4gKwo+Pj4+ICsgICAgICAgICAgICAgICByID0gYW1kZ3B1X2loX3JpbmdfaW5pdChh
ZGV2LCAmYWRldi0+aXJxLmloMiwgUEFHRV9TSVpFLCB0cnVlKTsKPj4+PiArICAgICAgICAgICAg
ICAgaWYgKHIpCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHI7Cj4+Pj4KPj4+
PiAtICAgICAgIGFkZXYtPmlycS5paDIudXNlX2Rvb3JiZWxsID0gdHJ1ZTsKPj4+PiAtICAgICAg
IGFkZXYtPmlycS5paDIuZG9vcmJlbGxfaW5kZXggPSAoYWRldi0+ZG9vcmJlbGxfaW5kZXguaWgg
KyAyKSA8PCAxOwo+Pj4+ICsgICAgICAgICAgICAgICBhZGV2LT5pcnEuaWgyLnVzZV9kb29yYmVs
bCA9IHRydWU7Cj4+Pj4gKyAgICAgICAgICAgICAgIGFkZXYtPmlycS5paDIuZG9vcmJlbGxfaW5k
ZXggPQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoYWRldi0+
ZG9vcmJlbGxfaW5kZXguaWggKyAyKSA8PCAxOwo+Pj4+ICsgICAgICAgfQo+Pj4+Cj4+Pj4gICAg
ICAgICAgciA9IGFtZGdwdV9pcnFfaW5pdChhZGV2KTsKPj4+Pgo+Pj4+IC0tCj4+Pj4gMi4xNy4x
Cj4+Pj4KPj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+Pj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+Pj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKPj4+PiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngKPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KPj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKPj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBh
bWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
