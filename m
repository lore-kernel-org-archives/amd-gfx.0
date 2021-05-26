Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702CAC47088
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 13:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 261C1611C9
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 13:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261C1611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB3646E503;
	Wed, 26 May 2021 13:58:25 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AF046E503
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 13:58:25 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 f20-20020a05600c4e94b0290181f6edda88so578716wmq.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 06:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=cZ9hgqoNXvM+VV2tzsrOLvzwuYm+YURCYb6aWXys4WI=;
 b=aHhVFwKmpuESYQQT1ZvFai/JYesPWl3fuOQy0WTaWWlAboMK5w2r8kJLjgcY4efIem
 7OvhgrhiiSY9XZhG38vKikMAh57fadNP9I/5G9OgMOIkW5AyY/YM56zkBPC3F0yk7wOt
 a6YM8LSsGmD7oudTL9HTIzj5tMF/rKK26+gRaByURO2xz9W8fZf+UbQqCJdJp0tXuTOu
 UL3gxAxHD+4qhee8FHZH3YOzMVb8SYQoMdyUU/c5tSOs7TwOQBDkeMUc7n+Qr5mup9QT
 pLQ7ZpdfBw8OUee2BjYBJawxYO+nxBPA/wLstegVvfIxvVfRcQGmZGeB+Sqa7XsKv943
 YMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=cZ9hgqoNXvM+VV2tzsrOLvzwuYm+YURCYb6aWXys4WI=;
 b=fPR7944i3LmIZwW2Jy2rZuRYtNCicjASW2Z5Kw6JX9ykhoCHwTUKnJTGXs5RFyEd/3
 okAkNGtibMlQLYkaGsVvunYeHOMH31MMKNcONrcPmavdEJTiHMxBRx2ZmkgEOkklwTEy
 QYYQ4qNsdpEmrtaVZ1hPoXsuFruN6rSP/X8/gaNpZbQXz8sLxxSCO07Qjgdj99n5f4Vp
 ECS3ZsYTWRnIP5N+SLRn8SgtAHw6Y9upUCPJkG5MINmzdsD+AdwYB7sKL7iR3DhGGQDV
 AMqdWC/B3T96w9WMdMetRhXjr2ZAMmOh4DkUOJWoeO9ugZe2FviJj1sQVB8ihO6DqtYz
 r9Lg==
X-Gm-Message-State: AOAM532sVpf0mjEu49H8UYszJFcWmjewZ5NGLFSZ1+LKdEDEr7vieIGg
 q0d8iZa4nFzhusZZAb0Lo0rvAzc9dR0=
X-Google-Smtp-Source: ABdhPJzz5FwLGqGm0063nC81OyDmnzE4LbmticN5Ly8ApsbXM5SE+nubbecsnKQq4YLtIQEJeC4E3g==
X-Received: by 2002:a7b:cb1a:: with SMTP id u26mr3500431wmj.125.1622037503761; 
 Wed, 26 May 2021 06:58:23 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:1950:35e:cae9:5bed?
 ([2a02:908:1252:fb60:1950:35e:cae9:5bed])
 by smtp.gmail.com with ESMTPSA id c7sm6599940wml.33.2021.05.26.06.58.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 May 2021 06:58:23 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Don't flush HDP on A+A
To: Eric Huang <jinhuieric.huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <92d943b2-7a72-e1a2-f29c-b5b54cf80d20@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <7e5db1d9-9b9c-4aa6-b009-fda1117dda05@gmail.com>
Date: Wed, 26 May 2021 15:58:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <92d943b2-7a72-e1a2-f29c-b5b54cf80d20@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjUuMDUuMjEgdW0gMTk6NTYgc2NocmllYiBFcmljIEh1YW5nOgo+IFdpdGggWEdNSSBjb25u
ZWN0aW9uIGZsdXNoaW5nIEhEUCBvbiBQQ0llIGlzIHVubmVjZXNzYXJ5LAo+IGl0IGlzIGFsc28g
dG8gb3B0aW1pemUgbWVtb3J5IGFsbG9jYXRpb24gbGF0ZW5jeS4KPgo+IFNpZ25lZC1vZmYtYnk6
IEVyaWMgSHVhbmcgPGppbmh1aWVyaWMuaHVhbmdAYW1kLmNvbT4KPgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fY3B1LmMgCj4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fY3B1LmMKPiBpbmRleCBhYzQ1ZDljN2E0ZTkuLmFl
ZmIzZDI5MjdkNSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm1fY3B1LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1f
Y3B1LmMKPiBAQCAtMTA4LDYgKzEwOCw4IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2NwdV91cGRh
dGUoc3RydWN0IAo+IGFtZGdwdV92bV91cGRhdGVfcGFyYW1zICpwLAo+IMKgc3RhdGljIGludCBh
bWRncHVfdm1fY3B1X2NvbW1pdChzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgKnAsCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc3RydWN0IGRtYV9mZW5jZSAqKmZlbmNlKQo+IMKgewo+ICvCoMKgwqDCoMKgwqAgaWYg
KHAtPmFkZXYtPmdtYy54Z21pLmNvbm5lY3RlZF90b19jcHUpCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIDA7CgpZb3Ugc3RpbGwgbmVlZCBhdCBsZWFzdCB0aGUgbWVtb3J5
IGJhcnJpZXIgYW5kIEkgc3VnZ2VzdCB0byBhZGQgYSBjb21tb24gCmZsYWcvZnVuY3Rpb24gdG8g
Y2hlY2sgaWYgSERQIGZsdXNoaW5nIGlzIG5lZWRlZCBvciBub3QuCgpXZSBhbHNvIGhhdmUgYSBi
dW5jaCBvZiBjYXNlcyBpbiB0aGUgSUIgc3VibWlzc2lvbiBjb2RlIGFzIHdlbGwuCgpDaHJpc3Rp
YW4uCgo+IMKgwqDCoMKgwqDCoMKgIC8qIEZsdXNoIEhEUCAqLwo+IMKgwqDCoMKgwqDCoMKgIG1i
KCk7Cj4gwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2FzaWNfZmx1c2hfaGRwKHAtPmFkZXYsIE5VTEwp
Owo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1k
LWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
