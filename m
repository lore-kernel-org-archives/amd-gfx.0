Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B79C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 08:08:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 099552250E
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 08:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1TWcBqk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 099552250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4F896E46C;
	Wed, 29 Jul 2020 08:08:48 +0000 (UTC)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32E6C6E46C;
 Wed, 29 Jul 2020 08:08:47 +0000 (UTC)
Received: by mail-ed1-x543.google.com with SMTP id b13so14348693edz.7;
 Wed, 29 Jul 2020 01:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=UIShQTjevhf8LbQzHIhLJElv7mhFTObQW0l7M8f53Bs=;
 b=W1TWcBqkp952EC0HOzy1jun3i871cexSHnJfzG6K66XBFtsm2tWDhUyO9BHYhmxgLV
 cZNtDzNUo39XQTcRiFnRIKMITEdCLKfJV+B1eg9aI2xzoJmRGb/RLRApQcyOSdd/5J0x
 WtyZQ2oHZvT4xa6xpVdstv/ocsl9tT2VhsFyFlOwToh3JwU1dsnwUOlLnh7p5HOn/JpI
 BUvMbAv16ukJN52fftzGKoA41mhqrLYVn9YRC7GorBOOLsL9YZoXF4H0HdDKADLPonuH
 tna/0IHH/aIZGus8gSXSHj9PQn4ShuPrfbVZ9WhmEqh29s4UZRTnZuLfgTSAqeGce5f0
 Hgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=UIShQTjevhf8LbQzHIhLJElv7mhFTObQW0l7M8f53Bs=;
 b=H/Gldq/s7Y/Kg9i6jvaFaOlueogke6p4rEhujfD6q1cz96QoGgynO/WUbgQJqX5SkU
 VwMnECGL+I3INbVy+pVvd5S5eB5dToqH81rBcblCpnZWg9gYTuGfC7QW/RV7yqmZZLzT
 ULwVCW6iNuTvenJ6QAjDxzdPPsYze+/8OSj7QkpJBPm+n6161wXb+g8eKsut1ezfp+73
 gqutuOe5DQh2AW75LhcmOZ8avsTA4gJRQHakHC2n1jf64Gqy7SqyBKDGJdlWHALRbtsd
 YtP4/5MYhW8qjDr1TX1XC9kHkkoLRQIDNokKuB9Wufu5kOw6oTwLLT9+nWh6S6r+iDAS
 Q7Yg==
X-Gm-Message-State: AOAM530wzZRw05QzvcXwcZdvI4F+xPd+bvIbry7cbBOhF9UowaYYA94H
 vNxdhgfdFMDkn3O93fKzBzEeAFUh
X-Google-Smtp-Source: ABdhPJwLzrnCJVDAZp/A0qRyhMNZBUfLxgnq1gfe7gy+mH51redmwz1UMY+W6xq2N47rmcIS0wUlPQ==
X-Received: by 2002:a05:6402:16c2:: with SMTP id
 r2mr29453022edx.127.1596010125857; 
 Wed, 29 Jul 2020 01:08:45 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id a8sm1178579edk.36.2020.07.29.01.08.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2020 01:08:40 -0700 (PDT)
Subject: Re: [PATCH 1/1] drm/ttm: fix offset in VMAs with a pg_offs in
 ttm_bo_vm_access
To: Felix Kuehling <Felix.Kuehling@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
References: <20200728182704.1809-1-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9994a650-8065-c51c-6454-47064d20c729@gmail.com>
Date: Wed, 29 Jul 2020 10:08:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728182704.1809-1-Felix.Kuehling@amd.com>
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
Cc: laurent.morichetti@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjguMDcuMjAgdW0gMjA6Mjcgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBWTUFzIHdpdGgg
YSBwZ19vZmZzIHRoYXQncyBvZmZzZXQgZnJvbSB0aGUgc3RhcnQgb2YgdGhlIHZtYV9ub2RlIG5l
ZWQKPiB0byBhZGp1c3QgdGhlIG9mZnNldCB3aXRoaW4gdGhlIEJPIGFjY29yZGluZ2x5LiBUaGlz
IG1hdGNoZXMgdGhlCj4gb2Zmc2V0IGNhbGN1bGF0aW9uIGluIHR0bV9ib192bV9mYXVsdF9yZXNl
cnZlZC4KPgo+IFNpZ25lZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0Bh
bWQuY29tPgo+IFRlc3RlZC1ieTogTGF1cmVudCBNb3JpY2hldHRpIDxsYXVyZW50Lm1vcmljaGV0
dGlAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+CgpHb2luZyB0byBwaWNrIHRoYXQgdXAgZm9yIGluY2x1c2lvbiBpbiBkcm0t
bWlzYy1uZXh0LgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3ZtLmMgfCA0
ICsrKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9ib192bS5jIGIvZHJpdmVy
cy9ncHUvZHJtL3R0bS90dG1fYm9fdm0uYwo+IGluZGV4IDM4OTEyOGI4YzRkZC4uNjBiNDE0NDdi
ZWM4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3ZtLmMKPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9ib192bS5jCj4gQEAgLTQwNSw4ICs0MDUsMTAgQEAg
c3RhdGljIGludCB0dG1fYm9fdm1fYWNjZXNzX2ttYXAoc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0
ICpibywKPiAgIGludCB0dG1fYm9fdm1fYWNjZXNzKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1h
LCB1bnNpZ25lZCBsb25nIGFkZHIsCj4gICAJCSAgICAgdm9pZCAqYnVmLCBpbnQgbGVuLCBpbnQg
d3JpdGUpCj4gICB7Cj4gLQl1bnNpZ25lZCBsb25nIG9mZnNldCA9IChhZGRyKSAtIHZtYS0+dm1f
c3RhcnQ7Cj4gICAJc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibyA9IHZtYS0+dm1fcHJpdmF0
ZV9kYXRhOwo+ICsJdW5zaWduZWQgbG9uZyBvZmZzZXQgPSAoYWRkcikgLSB2bWEtPnZtX3N0YXJ0
ICsKPiArCQkoKHZtYS0+dm1fcGdvZmYgLSBkcm1fdm1hX25vZGVfc3RhcnQoJmJvLT5iYXNlLnZt
YV9ub2RlKSkKPiArCQkgPDwgUEFHRV9TSElGVCk7Cj4gICAJaW50IHJldDsKPiAgIAo+ICAgCWlm
IChsZW4gPCAxIHx8IChvZmZzZXQgKyBsZW4pID4+IFBBR0VfU0hJRlQgPiBiby0+bnVtX3BhZ2Vz
KQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
