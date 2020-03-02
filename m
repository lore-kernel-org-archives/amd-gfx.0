Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7168C3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 12:07:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A95312173E
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 12:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrF5zjAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95312173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E3FA6E25E;
	Mon,  2 Mar 2020 12:07:30 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CAD76E25E
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 12:07:28 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id y17so12279369wrn.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Mar 2020 04:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=W+GxQTZIR4bQ9HX32/MXrAk+yHod6H95anu+gQODrp0=;
 b=nrF5zjAxqJ2t7gqfbrJ+cLVk687N13SXWCqwHI98ruMh/U2lpX/ZMOY7RXMX0FdrK1
 nx2NlWbSbVCyjFOjetqsyQ1XCK749dcyendmAsErBJBDvmTAQ4ar84ph2KxdADlG1Xdk
 tofeLqEDrQBHwyeqOJC9zKSuPPkXMiSlR7vwnrc+tAaVz9ONF+6eqadle0tjJ36NvXK5
 5dBkKfEMjozXBy2x4ENwV1u/Rld+EL34DiVuRltXLsgPnBjlwpVLzB7encOx2sUuMNgj
 77LbxrRvkcZl4TyVZl81lrJL2alqwJHjipqr1FAJzmkKSWNwKhXULSDMldG2QXz0xkx6
 1Tlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=W+GxQTZIR4bQ9HX32/MXrAk+yHod6H95anu+gQODrp0=;
 b=nftmDyuh6+MTHesW8A+8xj3AawxQ8z1ZHKI2mdP8UfdGRBpsUN9II6RNI2D9uyJwo7
 sZOPxhDBG/OLJTvJiaSOOwl8bo4n0nMjhpiXYqaSAOmj2dZCsbYHX0A3cIqfBsVvIhzl
 JOWeQDIOkCHzs/0cN6xin17pJYRXnB3Zzi4ENQNobzW6gyJDA2PjC/8XnaRLX58/Ec7J
 s6VHrKHtxDMOXfICQcWg62vH4mB4RhJ8RS5kySeN9IHDEJJXYXY40QXVp2AKiLJu2/Bf
 VoWRWWY8q6ZPBTVidXq+uQHcNlyyhJuZzMWw6oaM0q8vnyV4NFRRPYeHBJHtsNC9pUkL
 5CIQ==
X-Gm-Message-State: APjAAAXUZmsO7xQMCq7B0Gz51/M30spoWpja8Crp0/kl6mgN5UFXpDW2
 CO3J8+61f1zMM8ehmzQHowQ=
X-Google-Smtp-Source: APXvYqx0iT7dQdeUujUkCv2OFdX6LOgxU72/UHKqa5pyb/OOre7JgjogtAxJAVW48lg+w/Ij/M+lzg==
X-Received: by 2002:a5d:628e:: with SMTP id k14mr21350925wru.425.1583150847293; 
 Mon, 02 Mar 2020 04:07:27 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id b186sm15150034wmb.40.2020.03.02.04.07.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 02 Mar 2020 04:07:26 -0800 (PST)
Subject: Re: [PATCH v2 2/4] drm/scheduler: implement a function to modify
 sched list
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200302095234.3638-1-nirmoy.das@amd.com>
 <20200302095234.3638-2-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <8276a00d-ec11-cd8b-54e7-767345600d3f@gmail.com>
Date: Mon, 2 Mar 2020 13:07:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200302095234.3638-2-nirmoy.das@amd.com>
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDIuMDMuMjAgdW0gMTA6NTIgc2NocmllYiBOaXJtb3kgRGFzOgo+IGltcGxlbWVudCBkcm1f
c2NoZWRfZW50aXR5X21vZGlmeV9zY2hlZCgpIHdoaWNoIGNhbiBtb2RpZnkgZXhpc3RpbmcKPiBz
Y2hlZF9saXN0IHdpdGggYSBkaWZmZXJlbnQgb25lLiBUaGlzIGlzIGdvaW5nIHRvIGJlIGhlbHBm
dWwgd2hlbgo+IHVzZXJzcGFjZSBjaGFuZ2VzIHByaW9yaXR5IG9mIGEgY3R4L2VudGl0eSB0aGVu
IGRyaXZlciBjYW4gc3dpdGNoIHRvCj4gY29ycmVzcG9uZGluZyBodyBzaGNlZCBsaXN0IGZvciB0
aGF0IHByaW9yaXR5Cj4KPiBTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFt
ZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0Bh
bWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5
LmMgfCAxOSArKysrKysrKysrKysrKysrKysrCj4gICBpbmNsdWRlL2RybS9ncHVfc2NoZWR1bGVy
LmggICAgICAgICAgICAgIHwgIDQgKysrKwo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRp
b25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9l
bnRpdHkuYyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMKPiBpbmRl
eCA2M2JjY2QyMDFiOTcuLmI5NDMxMjE1NGU1NiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3NjaGVk
dWxlci9zY2hlZF9lbnRpdHkuYwo+IEBAIC04Myw2ICs4MywyNSBAQCBpbnQgZHJtX3NjaGVkX2Vu
dGl0eV9pbml0KHN0cnVjdCBkcm1fc2NoZWRfZW50aXR5ICplbnRpdHksCj4gICB9Cj4gICBFWFBP
UlRfU1lNQk9MKGRybV9zY2hlZF9lbnRpdHlfaW5pdCk7Cj4KPiArLyoqCj4gKyAqIGRybV9zY2hl
ZF9lbnRpdHlfbW9kaWZ5X3NjaGVkIC0gTW9kaWZ5IHNjaGVkIG9mIGFuIGVudGl0eQo+ICsgKgo+
ICsgKiBAZW50aXR5OiBzY2hlZHVsZXIgZW50aXR5IHRvIGluaXQKPiArICogQHNjaGVkX2xpc3Q6
IHRoZSBsaXN0IG9mIG5ldyBkcm0gc2NoZWRzIHdoaWNoIHdpbGwgcmVwbGFjZQo+ICsgKgkJZXhp
c3RpbmcgZW50aXR5LT5zY2hlZF9saXN0Cj4gKyAqIEBudW1fc2NoZWRfbGlzdDogbnVtYmVyIG9m
IGRybSBzY2hlZCBpbiBzY2hlZF9saXN0Cj4gKyAqLwo+ICt2b2lkIGRybV9zY2hlZF9lbnRpdHlf
bW9kaWZ5X3NjaGVkKHN0cnVjdCBkcm1fc2NoZWRfZW50aXR5ICplbnRpdHksCj4gKwkJCQkgIHN0
cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAqKnNjaGVkX2xpc3QsCj4gKwkJCQkgIHVuc2lnbmVkIGlu
dCBudW1fc2NoZWRfbGlzdCkKPiArewo+ICsJV0FSTl9PTighbnVtX3NjaGVkX2xpc3QgfHwgIXNj
aGVkX2xpc3QpOwo+ICsKPiArCWVudGl0eS0+c2NoZWRfbGlzdCA9IHNjaGVkX2xpc3Q7Cj4gKwll
bnRpdHktPm51bV9zY2hlZF9saXN0ID0gbnVtX3NjaGVkX2xpc3Q7Cj4gK30KPiArRVhQT1JUX1NZ
TUJPTChkcm1fc2NoZWRfZW50aXR5X21vZGlmeV9zY2hlZCk7Cj4gKwo+ICAgLyoqCj4gICAgKiBk
cm1fc2NoZWRfZW50aXR5X2lzX2lkbGUgLSBDaGVjayBpZiBlbnRpdHkgaXMgaWRsZQo+ICAgICoK
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kcm0vZ3B1X3NjaGVkdWxlci5oIGIvaW5jbHVkZS9kcm0v
Z3B1X3NjaGVkdWxlci5oCj4gaW5kZXggNTg5YmU4NTFmOGExLi5mNzBhODRhYWFmN2EgMTAwNjQ0
Cj4gLS0tIGEvaW5jbHVkZS9kcm0vZ3B1X3NjaGVkdWxlci5oCj4gKysrIGIvaW5jbHVkZS9kcm0v
Z3B1X3NjaGVkdWxlci5oCj4gQEAgLTI5Nyw2ICsyOTcsMTAgQEAgdm9pZCBkcm1fc2NoZWRfZmlu
aShzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKnNjaGVkKTsKPiAgIGludCBkcm1fc2NoZWRfam9i
X2luaXQoc3RydWN0IGRybV9zY2hlZF9qb2IgKmpvYiwKPiAgIAkJICAgICAgIHN0cnVjdCBkcm1f
c2NoZWRfZW50aXR5ICplbnRpdHksCj4gICAJCSAgICAgICB2b2lkICpvd25lcik7Cj4gK3ZvaWQg
ZHJtX3NjaGVkX2VudGl0eV9tb2RpZnlfc2NoZWQoc3RydWN0IGRybV9zY2hlZF9lbnRpdHkgKmVu
dGl0eSwKPiArCQkJCSAgc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICoqc2NoZWRfbGlzdCwKPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBudW1fc2NoZWRf
bGlzdCk7Cj4gKwo+ICAgdm9pZCBkcm1fc2NoZWRfam9iX2NsZWFudXAoc3RydWN0IGRybV9zY2hl
ZF9qb2IgKmpvYik7Cj4gICB2b2lkIGRybV9zY2hlZF93YWtldXAoc3RydWN0IGRybV9ncHVfc2No
ZWR1bGVyICpzY2hlZCk7Cj4gICB2b2lkIGRybV9zY2hlZF9zdG9wKHN0cnVjdCBkcm1fZ3B1X3Nj
aGVkdWxlciAqc2NoZWQsIHN0cnVjdCBkcm1fc2NoZWRfam9iICpiYWQpOwo+IC0tCj4gMi4yNS4w
Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFt
ZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
