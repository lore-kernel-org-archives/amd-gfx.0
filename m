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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3B9C47088
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 13:59:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0ABF613D3
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 13:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0ABF613D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9395A6ED0A;
	Wed, 26 May 2021 13:59:04 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C30906ECD3;
 Wed, 26 May 2021 13:59:02 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id q5so1260620wrs.4;
 Wed, 26 May 2021 06:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=qnZDUyUJxT2SrosvmV6mZECKLimxNEOlXEw8XpUA5gw=;
 b=LWDDpRpI+wMN7+tBUQMF4Iqw2WP12uKyBJGaTZkQQrapDB/ycYrt01ma7nm1CTd16p
 cAUtS1M2myIX1WSYvLep7c4bVOj79H+yCoeEI322GlKLgbDmrzOvScUA5/StQXqABVnf
 WaOTsfbkJO1Bj0iLgLSGPZOuFKBe4hhyMKw3gPnLTXZLkDiyp/s/+98+cVS9mb5H4yWk
 PXu3WvV1k9esmvbNlpxtnFyzC33vdLquFONsqd2eYkXqK0jH7ycB3f0lWsjhn8lkzYgh
 sTpZIG90DopZKnxoHIP+m4UMqb3qd8bGggDPO55pIOQ0F+PEq+3KMzjvVQHdVdWnynCS
 soyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=qnZDUyUJxT2SrosvmV6mZECKLimxNEOlXEw8XpUA5gw=;
 b=r9dzWRWcTQZBapLI35RzWPsDaKpU7eVtAkuS0v6Rgsv1Xaax9JXdGOwIy3cRlFpvrZ
 SoqxHOedieFPK551ofdm30G07jOqlew/pHWViwWhPm1RzOqSbzVb36ERn/t7bZGiXf3h
 PtgD+9Uqj7zJ1GCeDm9Uo0M5c+yrpUYpih1rISUJzu1BrAJrkkpHMJTJeGtQZOFL1qYf
 vyYGyZt+AVSBF8sOhfT5RY/eKVWmY3viv5YZGZDrl2gfa4wr4HnRD/Pk4BKoMAzUvrdJ
 6hVj4srGteF/fiLam2cp3L+1Ikzr6loZ9Fov0Q2sQ4cVkvYLX1jajITEpxyOLznli6Vl
 MFcw==
X-Gm-Message-State: AOAM533bgPbnuHMiTEKpw6vwYXFfmSuM9zhxGuxjKJrBrxAZ/pYucxFK
 cGGtFJBYksJC44qGEUX/0MA/V3B6n2I=
X-Google-Smtp-Source: ABdhPJy6z7RRKv1VPZoSqwy7sKpPOoQdVz2adv9iN8MjhwaVjBd6Si7eBWu8sB39e5PqAJmjoIRmlQ==
X-Received: by 2002:adf:f544:: with SMTP id j4mr194995wrp.416.1622037541543;
 Wed, 26 May 2021 06:59:01 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:1950:35e:cae9:5bed?
 ([2a02:908:1252:fb60:1950:35e:cae9:5bed])
 by smtp.gmail.com with ESMTPSA id l8sm20663457wry.55.2021.05.26.06.59.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 May 2021 06:59:01 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Fix clang warning: unused label 'exit'
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20210525184431.1170373-1-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <2e692137-b837-adea-6e64-ab1c2a091555@gmail.com>
Date: Wed, 26 May 2021 15:59:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210525184431.1170373-1-andrey.grodzovsky@amd.com>
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
Cc: Alexander.Deucher@amd.com, kernel test robot <lkp@intel.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAyNS4wNS4yMSB1bSAyMDo0NCBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+IFByb2Js
ZW06Cj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jOjMzMjoxOiB3
YXJuaW5nOiB1bnVzZWQgbGFiZWwgJ2V4aXQnIFstV3VudXNlZC1sYWJlbF0KPiBleGl0Ogo+IF5+
fn5+Cj4KPiBGaXg6IFB1dCAjaWZkZWYgQ09ORklHXzY0QklUIGFyb3VuZCBleGl0Cj4KPiBSZXBv
cnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+Cj4gU2lnbmVkLW9mZi1i
eTogQW5kcmV5IEdyb2R6b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+CgpSZXZpZXdl
ZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDIgKysKPiAg
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiBpbmRleCBjNTQ3Yzc4ZjM1MTMuLmExMGI0YTdjY2Y1
ZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNl
LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiBA
QCAtMzMwLDcgKzMzMCw5IEBAIHZvaWQgYW1kZ3B1X2RldmljZV92cmFtX2FjY2VzcyhzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwgbG9mZl90IHBvcywKPiAgIAl9Cj4gICAJc3Bpbl91bmxvY2tf
aXJxcmVzdG9yZSgmYWRldi0+bW1pb19pZHhfbG9jaywgZmxhZ3MpOwo+ICAgCj4gKyNpZmRlZiBD
T05GSUdfNjRCSVQKPiAgIGV4aXQ6Cj4gKyNlbmRpZgo+ICAgCWRybV9kZXZfZXhpdChpZHgpOwo+
ICAgfQo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
