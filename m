Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFD2C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 12:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 430C661107
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 12:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430C661107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 370F66E201;
	Fri, 16 Apr 2021 12:54:13 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2DB36E1F9;
 Fri, 16 Apr 2021 12:54:11 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id e14so41951016ejz.11;
 Fri, 16 Apr 2021 05:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=7EUGgFCxVJzb8pyDoiyMM78nVcqyNM7ePeNkigUmMe4=;
 b=YT2X/Fq3yd7QUnOI+LErRgAfU6T2haUDfUl/gmbt/p0O1O/4GHJzmzBnuay/JGl3sT
 58Ba+j57iGN7+yM/6KWyvbAs3SJKvnbEF4rQo8BULSysyV+n8ySVcssRLOtKGCoLlEVT
 Ef/c+3OkaxWD6ZFVlDdbCYmH21TMSNuoOcHmHWq0qOTTOIVUjc5Mf5UiZlva4IqEF5qt
 BeSAL9B4zX5HigKtMF4QMTW0846J7dU5NgMYfeniSt/ktAUpJrCQoaRR93Fhp+Hpz1R7
 9YlO8SAX2yb6op1aBAoHelbe/sLqhLSTP8ujhCKzj3jDfREgtvcDXM+GyPcvFzRnTB4B
 kv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=7EUGgFCxVJzb8pyDoiyMM78nVcqyNM7ePeNkigUmMe4=;
 b=gefVbAVMRGQqUrXHD2rA7/IE50qB54g5ufQpv+aul9kGbkqzAn1pC6wFdX/oTwFMmm
 H7n5eNciQRekrRV71lT7SARpQkbMVOtGk75+L1pguVMO0Tt+oqQPYx/quH8cYtlDomix
 CMYCsPFAwuNiOWU9fvJqJKdt1Pfdsxqi1h7yM2FErZCzhbL3jvm+GBRRUu90U5+qgJ1f
 rVyUVjvgmKD6uEkyvPmMHuqDvQGTefXJ93nrmkJ4zENyAQ8ySKg92btJ2GC8EA0fPh4i
 5cFYnw58BMKEoptlNIqT4+Wlp8kHxuYD0gUxdBgEZeEusmVg6Qy0vxDP/1MZVKWKxBvj
 iS3A==
X-Gm-Message-State: AOAM531IrT/p5I/ElL9H2WaAgtSYSTr7ABY7HYI8BX+tx2vF3BmvP26d
 byvq7nYsf6hiXq3EAJnLqXlme5G7MMw=
X-Google-Smtp-Source: ABdhPJz/ckqeRBEmgo7V+3swl7gUDKhG1Ao+Rv8Rr2mrwcHHd2G9UdkacysCVjxHmdvskHY2ELPreg==
X-Received: by 2002:a17:907:20f0:: with SMTP id
 rh16mr8588642ejb.320.1618577650519; 
 Fri, 16 Apr 2021 05:54:10 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:6a8a:26d6:7403:5ada?
 ([2a02:908:1252:fb60:6a8a:26d6:7403:5ada])
 by smtp.gmail.com with ESMTPSA id l15sm5125833edb.48.2021.04.16.05.54.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Apr 2021 05:54:10 -0700 (PDT)
Subject: Re: [PATCH 1/3] drm/amdgpu: make sure we unpin the UVD BO
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20210415084730.2057-1-christian.koenig@amd.com>
Message-ID: <a15d4af8-98af-1036-c6f4-7738f08678e1@gmail.com>
Date: Fri, 16 Apr 2021 14:54:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210415084730.2057-1-christian.koenig@amd.com>
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
Cc: daniel@ffwll.ch
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UGluZz8KCkFtIDE1LjA0LjIxIHVtIDEwOjQ3IHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPiBS
ZWxlYXNpbmcgcGlubmVkIEJPcyBpcyBpbGxlZ2FsIG5vdy4KPgo+IFNpZ25lZC1vZmYtYnk6IENo
cmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92N18wLmMgfCAxICsKPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3V2ZF92N18wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjdfMC5jCj4g
aW5kZXggN2NkNjdjYjJhYzVmLi4xYTJiZjJjYTFiZTUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y3XzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3V2ZF92N18wLmMKPiBAQCAtMzYzLDYgKzM2Myw3IEBAIHN0YXRpYyBpbnQgdXZkX3Y3
XzBfZW5jX3JpbmdfdGVzdF9pYihzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsIGxvbmcgdGltZW91
dCkKPiAgIAo+ICAgZXJyb3I6Cj4gICAJZG1hX2ZlbmNlX3B1dChmZW5jZSk7Cj4gKwlhbWRncHVf
Ym9fdW5waW4oYm8pOwo+ICAgCWFtZGdwdV9ib191bnJlc2VydmUoYm8pOwo+ICAgCWFtZGdwdV9i
b191bnJlZigmYm8pOwo+ICAgCXJldHVybiByOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
