Return-Path: <SRS0=Zv7j=A2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C03C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2020 09:21:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96E7B2064B
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2020 09:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYLUBEyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E7B2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66F436EA70;
	Wed, 15 Jul 2020 09:21:31 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3BF16EA70
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2020 09:21:29 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id f139so4836382wmf.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2020 02:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=mwdA3Qm7g2UNOS/4cWYfIqVD53VqxYiGC1fmIBkWYjY=;
 b=iYLUBEyuw0f+qO+JvtN5gLvJKA6W/wL5XG/kvYxSOH86n+nSQ7abNKj9YLpDCDLGYf
 jSCl4hqlw4RGWnjcmF3xFQjwXNZT0zLZwROcJWVzMXURulCPt71Yp/R9E7PESqp/5x6j
 +xGMVAZdbhDrlvOQt6lzzmE1/+rmH8zWqfMngsz27KlmHj65GLJU+K8LsqYAY3z0z7uW
 r2sxoh9B+rE1Ru+l+GEASdHX7ujGktwNmtK7e3H23YTIIwgO7SjqUnq1tl9adNnrC1Ga
 myU4ZC2nu5/11Z9i4+adovQcaEll0K3VQV44QcpPK0tvyQsFv1dC0R0VZYK4dcrqORqu
 ZM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=mwdA3Qm7g2UNOS/4cWYfIqVD53VqxYiGC1fmIBkWYjY=;
 b=AtnuzUhjy1fHkJ7LXK1H4n0haS4q8j1bqHGiLJKpSDJVFSPAZ8YtlQ6BXQvYV0ZyQl
 HDbbNOp3qKotd9USlFlFFxesujmvVEWINTW80bSlSF04mzTmYXlucX+XgxsTd68gDkHg
 XsdEo9VvzCh47xga/RMcw7FQNP5XSdI1L2Y63pmLSZr6yU/3mArNHbZIdjV7pnZYWxYA
 THHdV2fAEhlmaxm36ZQjcFCW0YaKm/gn2XpLCVZCQ+IevmyEdzLq/3EyvTTCInTN00Rn
 3Bv2Z8Er80zDv9uboKbebGfqPspwsRVVKE7qZIrcgRoxbv2KM9IxayBHuXVtxTpyO5Ju
 Pqmg==
X-Gm-Message-State: AOAM532TRMJ1OVKww5ntbaUrGfhYcu+TrClR5hFS1Pwo0JsmU1CaEWAn
 qvh21Sbjk9K2WKQdOFbbnjQ=
X-Google-Smtp-Source: ABdhPJxEkmbEj9w2Jw1x67qbMhyXwX0IAYAPjibr1VZ5OpvxXrQV6pP8Lf6lHyVVfX9+eqBkB0007w==
X-Received: by 2002:a7b:c14a:: with SMTP id z10mr7514977wmi.19.1594804888570; 
 Wed, 15 Jul 2020 02:21:28 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:68f0:d4d3:d7ff:52d6?
 ([2a02:908:1252:fb60:68f0:d4d3:d7ff:52d6])
 by smtp.gmail.com with ESMTPSA id h199sm2532421wme.42.2020.07.15.02.21.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Jul 2020 02:21:27 -0700 (PDT)
Subject: Re: [PATCH 01/42] drm/amdgpu: expand to add multiple trap event irq id
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200714182353.2164930-1-alexander.deucher@amd.com>
 <20200714182353.2164930-2-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <6609b826-c7ce-398a-e3a8-d146797063c9@gmail.com>
Date: Wed, 15 Jul 2020 11:21:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200714182353.2164930-2-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTQuMDcuMjAgdW0gMjA6MjMgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gRnJvbTogSHVhbmcg
UnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KPgo+IFNpZW5uYV9jaWNobGlkIGhhcyBmb3VyIHNkbWEg
aW5zdGFuY2VzLCBidXQgb3RoZXIgY2hpcHMgZG9uJ3QuCj4gU28gd2UgbmVlZCBleHBhbmQgdG8g
YWRkIG11bHRpcGxlIHRyYXAgZXZlbnQgaXJxIGlkIGluIHNkbWEKPiB2NS4yLgo+Cj4gU2lnbmVk
LW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KPiBSZXZpZXdlZC1ieTogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CgpCdXQgc2lkZSBxdWVzdGlv
biB3aHkgZG8gd2UgaGF2ZSB0aGUgX1NpZW5uYV9DaWNobGlkIHBvc3RmaXggb24gdGhlIGRlZmlu
ZT8KCkNocmlzdGlhbi4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1h
X3Y1XzIuYyB8IDY3ICsrKysrKysrKysrKysrKystLS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdl
ZCwgNDEgaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8yLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9zZG1hX3Y1XzIuYwo+IGluZGV4IDgyNGYzZTIzYzNkOS4uZGU4MzQyMjgzZmRiIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMi5jCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8yLmMKPiBAQCAtMTE2NSw2ICsx
MTY1LDQwIEBAIHN0YXRpYyBpbnQgc2RtYV92NV8yX2Vhcmx5X2luaXQodm9pZCAqaGFuZGxlKQo+
ICAgCXJldHVybiAwOwo+ICAgfQo+ICAgCj4gK3N0YXRpYyB1bnNpZ25lZCBzZG1hX3Y1XzJfc2Vx
X3RvX2lycV9pZChpbnQgc2VxX251bSkKPiArewo+ICsJc3dpdGNoIChzZXFfbnVtKSB7Cj4gKwlj
YXNlIDA6Cj4gKwkJcmV0dXJuIFNPQzE1X0lIX0NMSUVOVElEX1NETUEwOwo+ICsJY2FzZSAxOgo+
ICsJCXJldHVybiBTT0MxNV9JSF9DTElFTlRJRF9TRE1BMTsKPiArCWNhc2UgMjoKPiArCQlyZXR1
cm4gU09DMTVfSUhfQ0xJRU5USURfU0RNQTI7Cj4gKwljYXNlIDM6Cj4gKwkJcmV0dXJuIFNPQzE1
X0lIX0NMSUVOVElEX1NETUEzX1NpZW5uYV9DaWNobGlkOwo+ICsJZGVmYXVsdDoKPiArCQlicmVh
azsKPiArCX0KPiArCXJldHVybiAtRUlOVkFMOwo+ICt9Cj4gKwo+ICtzdGF0aWMgdW5zaWduZWQg
c2RtYV92NV8yX3NlcV90b190cmFwX2lkKGludCBzZXFfbnVtKQo+ICt7Cj4gKwlzd2l0Y2ggKHNl
cV9udW0pIHsKPiArCWNhc2UgMDoKPiArCQlyZXR1cm4gU0RNQTBfNV8wX19TUkNJRF9fU0RNQV9U
UkFQOwo+ICsJY2FzZSAxOgo+ICsJCXJldHVybiBTRE1BMV81XzBfX1NSQ0lEX19TRE1BX1RSQVA7
Cj4gKwljYXNlIDI6Cj4gKwkJcmV0dXJuIFNETUEyXzVfMF9fU1JDSURfX1NETUFfVFJBUDsKPiAr
CWNhc2UgMzoKPiArCQlyZXR1cm4gU0RNQTNfNV8wX19TUkNJRF9fU0RNQV9UUkFQOwo+ICsJZGVm
YXVsdDoKPiArCQlicmVhazsKPiArCX0KPiArCXJldHVybiAtRUlOVkFMOwo+ICt9Cj4gKwo+ICAg
c3RhdGljIGludCBzZG1hX3Y1XzJfc3dfaW5pdCh2b2lkICpoYW5kbGUpCj4gICB7Cj4gICAJc3Ry
dWN0IGFtZGdwdV9yaW5nICpyaW5nOwo+IEBAIC0xMTcyLDMyICsxMjA2LDEzIEBAIHN0YXRpYyBp
bnQgc2RtYV92NV8yX3N3X2luaXQodm9pZCAqaGFuZGxlKQo+ICAgCXN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOwo+ICAgCj4gICAJLyog
U0RNQSB0cmFwIGV2ZW50ICovCj4gLQlyID0gYW1kZ3B1X2lycV9hZGRfaWQoYWRldiwgU09DMTVf
SUhfQ0xJRU5USURfU0RNQTAsCj4gLQkJCSAgICAgIFNETUEwXzVfMF9fU1JDSURfX1NETUFfVFJB
UCwKPiAtCQkJICAgICAgJmFkZXYtPnNkbWEudHJhcF9pcnEpOwo+IC0JaWYgKHIpCj4gLQkJcmV0
dXJuIHI7Cj4gLQo+IC0JLyogU0RNQSB0cmFwIGV2ZW50ICovCj4gLQlyID0gYW1kZ3B1X2lycV9h
ZGRfaWQoYWRldiwgU09DMTVfSUhfQ0xJRU5USURfU0RNQTEsCj4gLQkJCSAgICAgIFNETUExXzVf
MF9fU1JDSURfX1NETUFfVFJBUCwKPiAtCQkJICAgICAgJmFkZXYtPnNkbWEudHJhcF9pcnEpOwo+
IC0JaWYgKHIpCj4gLQkJcmV0dXJuIHI7Cj4gLQo+IC0JLyogU0RNQSB0cmFwIGV2ZW50ICovCj4g
LQlyID0gYW1kZ3B1X2lycV9hZGRfaWQoYWRldiwgU09DMTVfSUhfQ0xJRU5USURfU0RNQTIsCj4g
LQkJCSAgICAgIFNETUEyXzVfMF9fU1JDSURfX1NETUFfVFJBUCwKPiAtCQkJICAgICAgJmFkZXYt
PnNkbWEudHJhcF9pcnEpOwo+IC0JaWYgKHIpCj4gLQkJcmV0dXJuIHI7Cj4gLQo+IC0JLyogU0RN
QSB0cmFwIGV2ZW50ICovCj4gLQlyID0gYW1kZ3B1X2lycV9hZGRfaWQoYWRldiwgU09DMTVfSUhf
Q0xJRU5USURfU0RNQTNfU2llbm5hX0NpY2hsaWQsCj4gLQkJCSAgICAgIFNETUEzXzVfMF9fU1JD
SURfX1NETUFfVFJBUCwKPiAtCQkJICAgICAgJmFkZXYtPnNkbWEudHJhcF9pcnEpOwo+IC0JaWYg
KHIpCj4gLQkJcmV0dXJuIHI7Cj4gKwlmb3IgKGkgPSAwOyBpIDwgYWRldi0+c2RtYS5udW1faW5z
dGFuY2VzOyBpKyspIHsKPiArCQlyID0gYW1kZ3B1X2lycV9hZGRfaWQoYWRldiwgc2RtYV92NV8y
X3NlcV90b19pcnFfaWQoaSksCj4gKwkJCQkgICAgICBzZG1hX3Y1XzJfc2VxX3RvX3RyYXBfaWQo
aSksCj4gKwkJCQkgICAgICAmYWRldi0+c2RtYS50cmFwX2lycSk7Cj4gKwkJaWYgKHIpCj4gKwkJ
CXJldHVybiByOwo+ICsJfQo+ICAgCj4gICAJciA9IHNkbWFfdjVfMl9pbml0X21pY3JvY29kZShh
ZGV2KTsKPiAgIAlpZiAocikgewoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
