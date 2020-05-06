Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B36AC38A2A
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 14:34:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0F502076D
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 14:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msIGKH2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F502076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DED06E038;
	Wed,  6 May 2020 14:34:24 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 116166E038
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2020 14:34:23 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id l18so2473348wrn.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 May 2020 07:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=PE/opDAWC1cK9EQ6E1J7Uki/BZUIov6IqqroqoZUaSM=;
 b=msIGKH2OTw39PcpHnna7t0IypUbCYunrmCk75Ws756tRKX2wi91OGw811EPwtD5o8n
 3xXmjipSNFtOHILBUmY8vekQN6iafO936HMR7ufZcbsf17FbHUPu0RotIVDrRPvoeBOB
 XmVc1GQ/IRaXKMtpR1yZIve3m3MOgwDU6ZmFpWUgkO7HM9rf3T2ci5VnukYO/GT3OA+s
 /Dpn1fxlq+UPwbPJdFfpeaCROeNQFrKYppC3bbMf+BleoPm6/DRR53cji+Cx091EjTel
 jeKoGSTr88l0Ylk/i9XT3YC7LsLtLejp76P/lh/Z8PJBJosbKiMyaQ3VTwYzdbmCf26m
 Bp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=PE/opDAWC1cK9EQ6E1J7Uki/BZUIov6IqqroqoZUaSM=;
 b=J5p09Gfb5AW9T4uIR4XBYTsVmko5qNbpIQ6VILGmP2goDZySIgOj6JcLxnVNI2vMii
 VjQO7p5kXTRxsoOLt+tUEOomQDmnIO+B10YmATk/Wpi1thVmQaxyb1PLHlJrsotcFK7L
 lY6UM/CaOzuJ3d2d9BNR1ZUoToYyy7J93+9SCCYm0unyTlzNf2xCYGcbpWQyH46HryFI
 Kv679e8nw6YsTYqoMgzFVuIDs6jZqGEJ25xzFK9I99wtvEwPGQzig84L36vgfVkFKx5t
 2jI7GBsmRXjiR0mAm4Ux5oW0ZXYG69v9sV3ZOW6jxeJhI6cE1/4QHWrr3sn+h5BZ4AO/
 Nzyw==
X-Gm-Message-State: AGi0PubKwY5mDYB8v5Lp8TsndYtEc6lOovyqcaBr3hraJ0giuwnKvzc6
 +0TBrJ7MAO/8rC72aoPfKio=
X-Google-Smtp-Source: APiQypKKiRMwT61/9SWDEq/OXhv5/i7TbjcxprZZ4Qe3ze3vn5BCYeywx4MSl+AvWA+rJ5uFVeTcUg==
X-Received: by 2002:adf:e751:: with SMTP id c17mr10586231wrn.351.1588775661749; 
 Wed, 06 May 2020 07:34:21 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id w18sm2797869wrn.55.2020.05.06.07.34.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 May 2020 07:34:21 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: force fbdev into vram
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200506141411.860444-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <73391113-203a-cfdb-471f-0eca7e2ea64f@gmail.com>
Date: Wed, 6 May 2020 16:34:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200506141411.860444-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDYuMDUuMjAgdW0gMTY6MTQgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gV2Ugc2V0IHRoZSBm
YiBzbWVtIHBvaW50ZXIgdG8gdGhlIG9mZnNldCBpbnRvIHRoZSBCQVIsIHNvIGtlZXAKPiB0aGUg
ZmJkZXYgYm8gaW4gdnJhbS4KPgo+IEJ1ZzogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3No
b3dfYnVnLmNnaT9pZD0yMDc1ODEKPiBGaXhlczogNmM4ZDc0Y2FhMmZhMzMgKCJkcm0vYW1kZ3B1
OiBFbmFibGUgc2NhdHRlciBnYXRoZXIgZGlzcGxheSBzdXBwb3J0IikKPiBTaWduZWQtb2ZmLWJ5
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CgpSZXZpZXdlZC1ieTog
Q2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mYi5jIHwgMyArLS0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmIuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9mYi5jCj4gaW5kZXggOWFlN2I2MWY2OTZhLi4yNWRkYjQ4MjQ2NmEg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZiLmMKPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmIuYwo+IEBAIC0xMzMsOCAr
MTMzLDcgQEAgc3RhdGljIGludCBhbWRncHVmYl9jcmVhdGVfcGlubmVkX29iamVjdChzdHJ1Y3Qg
YW1kZ3B1X2ZiZGV2ICpyZmJkZXYsCj4gICAJdTMyIGNwcDsKPiAgIAl1NjQgZmxhZ3MgPSBBTURH
UFVfR0VNX0NSRUFURV9DUFVfQUNDRVNTX1JFUVVJUkVEIHwKPiAgIAkJCSAgICAgICBBTURHUFVf
R0VNX0NSRUFURV9WUkFNX0NPTlRJR1VPVVMgICAgIHwKPiAtCQkJICAgICAgIEFNREdQVV9HRU1f
Q1JFQVRFX1ZSQU1fQ0xFQVJFRCAJICAgICB8Cj4gLQkJCSAgICAgICBBTURHUFVfR0VNX0NSRUFU
RV9DUFVfR1RUX1VTV0M7Cj4gKwkJCSAgICAgICBBTURHUFVfR0VNX0NSRUFURV9WUkFNX0NMRUFS
RUQ7Cj4gICAKPiAgIAlpbmZvID0gZHJtX2dldF9mb3JtYXRfaW5mbyhhZGV2LT5kZGV2LCBtb2Rl
X2NtZCk7Cj4gICAJY3BwID0gaW5mby0+Y3BwWzBdOwoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
