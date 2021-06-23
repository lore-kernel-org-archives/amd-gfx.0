Return-Path: <SRS0=KKXi=LR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F909C4743C
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 08:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A69A6023B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 08:30:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A69A6023B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C30886E87B;
	Wed, 23 Jun 2021 08:30:29 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99CB16E87B;
 Wed, 23 Jun 2021 08:30:28 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id a13so1606906wrf.10;
 Wed, 23 Jun 2021 01:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=+DQ+0ACXfu3QGCRaHMkp2n6Xdtecrv2vBUk0jSTI9t0=;
 b=SwjaUdtkaX7HIiCjHwHbCWsEZ6ULepfoWGcKdlQVEo4i9OtBDs39npxbmTjFb1F9At
 zZ4i6oOo1G6Z5D7U9b2c0YxSpdQvHHF4rf1XzOFJUqJBtS3+5PSrO+OPB4ryWFEFntUs
 gcKZYyVXL4YwQxnVYTBMHfSlZZgmSSQZz3Au1DihCE0ifnhhZ4hVaUgv+pSX51Y4rTbw
 qPq2O5c5F664UAiZJZmqiXG10KPJVJEAC17dez9OJrymBh3OhJ/IOkpKL0toCkOXY2II
 rjfFVoUKjzEFZnLmKYCx7maJuCSr/gVjDYNhYQfA8osVGc3U8YeAcRVC7PDzKkg5poSa
 HnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=+DQ+0ACXfu3QGCRaHMkp2n6Xdtecrv2vBUk0jSTI9t0=;
 b=bX82WO3mhnjGQ3BelQ7bNtqGMoj04X74IGTLJzJvLDQfHT/MWLJNmtWVaO6UuBrvLe
 1d4DvF1u+6mji51ePRnqwpz4QU1w89XJNZLEUEab+dcg7moTUP2+Q9d4/Nv/MutQUhuE
 dg0mGqKRQogw+OOnTUnWlKuw24Vje5J/5jrDbKHIfn56X52jwkg/kWIdGOrneQ1IgFiJ
 4mMZ3+xMMb1OR1bOKINt4rVUq7NAPZwMsqAxEaCvtDPCTN9egGUvzBHfL6T1psLLHIeM
 b+IgA9m3d1dE4U7oj0YQmnLEhpGdE0708cwdWGjdB0mS1GyYo1vUsAaq86fffUU/uG9o
 9Usg==
X-Gm-Message-State: AOAM530yC7rnokzKidE+xkwcgMkgj1yiv4oY73LpSb8hkOSxB4UlQUhU
 09xZyP787Qg60w9Nu4GA/z4=
X-Google-Smtp-Source: ABdhPJxwWD3nqtQ+x1BmNzk2hTUx4nXZRPEufelxi8DtaVU7mGgpA/MbYlTDV3hl1MEoORc7DXXfxg==
X-Received: by 2002:a05:6000:180f:: with SMTP id
 m15mr10280416wrh.102.1624437027375; 
 Wed, 23 Jun 2021 01:30:27 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:69e4:a619:aa86:4e9c?
 ([2a02:908:1252:fb60:69e4:a619:aa86:4e9c])
 by smtp.gmail.com with ESMTPSA id d15sm2115444wrb.42.2021.06.23.01.30.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jun 2021 01:30:27 -0700 (PDT)
Subject: Re: [PATCH 5/6] drm/amdgpu: Fix BUG_ON assert
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20210622162339.761651-1-andrey.grodzovsky@amd.com>
 <20210622162339.761651-5-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <7f59fd45-b122-63be-5ef3-fe48b31d674d@gmail.com>
Date: Wed, 23 Jun 2021 10:30:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210622162339.761651-5-andrey.grodzovsky@amd.com>
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
Cc: Lang.Yu@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAyMi4wNi4yMSB1bSAxODoyMyBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+IFdpdGgg
YWRkZWQgQ1BVIGRvbWFpbiB0byBwbGFjZW1lbnQgeW91IGNhbiBoYXZlCj4gbm93IDMgcGxhY2Vt
bnRzIGF0IG9uY2UuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5
Lmdyb2R6b3Zza3lAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+CgpBbmQgcGxlYXNlIGFkZCBDQzogc3RhYmxlQGtlcm5lbC5v
cmcgc2luY2UgdGhpcyBpcyB0cmlnZ2VyIGFibGUgZnJvbSAKdXNlcnNwYWNlIGFuZCBhY3R1YWxs
eSBhIHJhdGhlciBuYXN0eSBidWcuCgpDaHJpc3RpYW4uCgo+IC0tLQo+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X29iamVjdC5jCj4gaW5kZXggYjdhMjA3MGQ5MGFmLi44MTI2OGVkZWQwNzMg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5j
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4gQEAg
LTE4MCw3ICsxODAsNyBAQCB2b2lkIGFtZGdwdV9ib19wbGFjZW1lbnRfZnJvbV9kb21haW4oc3Ry
dWN0IGFtZGdwdV9ibyAqYWJvLCB1MzIgZG9tYWluKQo+ICAgCQljKys7Cj4gICAJfQo+ICAgCj4g
LQlCVUdfT04oYyA+PSBBTURHUFVfQk9fTUFYX1BMQUNFTUVOVFMpOwo+ICsJQlVHX09OKGMgPiBB
TURHUFVfQk9fTUFYX1BMQUNFTUVOVFMpOwo+ICAgCj4gICAJcGxhY2VtZW50LT5udW1fcGxhY2Vt
ZW50ID0gYzsKPiAgIAlwbGFjZW1lbnQtPnBsYWNlbWVudCA9IHBsYWNlczsKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
