Return-Path: <SRS0=Jh+1=BW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D972BC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 13:42:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A27D2207DA
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 13:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZe5uJMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27D2207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4431C6E123;
	Wed, 12 Aug 2020 13:42:19 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 052666E0FF;
 Wed, 12 Aug 2020 13:42:18 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id o23so2336316ejr.1;
 Wed, 12 Aug 2020 06:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=3W8RrOcieXQTHbwagMgPr+h9faxaX5DdAWlD9cZaad8=;
 b=GZe5uJMKa6M7aZOFurAGN9HZW+E47x14RvVije8+4VEvriC8FqaaAmxuAbfh/vNXjI
 K8Fz+9UcesZrEUV8U3cmbM/MbXyDttUuOqRHBPoa5aoZsC44ZQFv5B8ZRwkqC0qlwIpz
 BJTi+EGpDG6HD/qV5gCGf4X5j0YCVwOsIM/VhLuV/KvaWiAPJQT3R+LQ+orGAwJOxR1D
 wdEpg4zSX453qYPv6keXc8ut7IeNYE1rhYcWzLtwAFRrFpRDvti6F7QZ8O6Opxacf1h0
 NnIXwmlk2b1h6v8pC9lO/ZHa/XaxMwdds/CjRDIV1dgXDvDriD10tQhJuZQSNq/39zB3
 XrLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=3W8RrOcieXQTHbwagMgPr+h9faxaX5DdAWlD9cZaad8=;
 b=rBCAbV3hRnhcHwORJJlb8TE/SaXeU/iJflLy83Nr3cBvj4IXyQ+eHyF1v/qFJ4aGFa
 eJP+g4bjhkkArcl5fpC29qLSqVAZOdvNocLSxPvU008pcbHRkTWxDwDz2L4LbCnN3EDH
 ZIDzFsjo92rgNBIGxwRCaZyAp+doMLZvXs9ng4fwvCHvLkQP/520Ziwvbl1LVxa9wMUQ
 gk7tGi+KH0J7K6uduwdhB6H5ZabXB4hkV9TMGeLmaAbKyfI8ZRKwwwTMKXuUfwVGs00v
 dBZhAiUw7bY/EuqzSEmMGcGLeh8xk92BGT/sRV2Jw5GHFounEv+FRYo3b8on4YXtO+74
 aBUQ==
X-Gm-Message-State: AOAM533NErPPmf3+LX8rJeYyv5uH4Kt0jxrYO3HoR2vhJvT9Ra+Bp1gH
 QuWL4ylvCS2mtl+X5XWTXGYpNWCc
X-Google-Smtp-Source: ABdhPJz5PfpdpcG7CvEvziHljHL6qv3bHCRPg+EEp6qGqe5AMSuEHoC83YTMk3D0FiNYd5rGdhNvIg==
X-Received: by 2002:a17:906:cc4a:: with SMTP id
 mm10mr30488102ejb.451.1597239736717; 
 Wed, 12 Aug 2020 06:42:16 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id n10sm1503001edo.43.2020.08.12.06.42.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 06:42:14 -0700 (PDT)
Subject: Re: RFC: How to adjust the trace pid?
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, daniel.vetter@ffwll.ch,
 Dave Airlie <airlied@gmail.com>
References: <20200807133658.1866-1-christian.koenig@amd.com>
Message-ID: <1975d7d1-8f94-5852-6ccc-19fde4d4a919@gmail.com>
Date: Wed, 12 Aug 2020 15:42:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807133658.1866-1-christian.koenig@amd.com>
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
Cc: alexander.deucher@amd.com, Shashank.Sharma@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UGluZz8gRGFuaWVsLCBEYXZlIGFueSBvcGluaW9uIG9uIHRoaXM/CgpDaHJpc3RpYW4uCgpBbSAw
Ny4wOC4yMCB1bSAxNTozNiBzY2hyaWViIENocmlzdGlhbiBLw7ZuaWc6Cj4gSGkgZXZlcnlib2R5
LAo+Cj4gaW4gYW1kZ3B1IHdlIGdvdCB0aGUgZm9sbG93aW5nIGlzc3VlIHdoaWNoIEknbSBzZWVr
aW5nIGFkdmlzZSBob3cgdG8gY2xlYW5seSBoYW5kbGUgaXQuCj4KPiBXZSBoYXZlIGEgYnVuY2gg
b2YgdHJhY2UgcG9pbnRzIHdoaWNoIGFyZSByZWxhdGVkIHRvIHRoZSBWTSBzdWJzeXN0ZW0gYW5k
IGV4ZWN1dGVkIGluIGVpdGhlciBhIHdvcmsgaXRlbSwga3RocmVhZCBvciBmb3JlaWduIHByb2Nl
c3MgY29udGV4dC4KPgo+IE5vdyB0cmFjaW5nIHRoZSBwaWQgb2YgdGhlIGNvbnRleHQgd2hpY2gg
d2UgYXJlIGV4ZWN1dGluZyBpbiBpcyBub3QgcmVhbGx5IHRoYXQgdXNlZnVsLCBzbyBJJ20gd29u
ZGVyaW5nIGlmIHdlIGNvdWxkIGp1c3Qgb3ZlcndyaXRlIHRoZSBwaWQgcmVjb3JkZWQgaW4gdGhl
IHRyYWNlIGVudHJ5Pwo+Cj4gVGhlIGZvbGxvd2luZyBwYXRjaCBkb2VzIGV4YWN0bHkgdGhhdCBm
b3IgdGhlIHZtX2dyYWJfaWQoKSB0cmFjZSBwb2ludCwgYnV0IEknbSBub3QgMTAwJSBzdXJlIGlm
IHRoYXQgaXMgbGVnYWwgb3Igbm90Lgo+Cj4gQW55IGlkZWFzPyBDb21tZW50cz8KPgo+IFRoYW5r
cywKPiBDaHJpc3RpYW4uCj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
