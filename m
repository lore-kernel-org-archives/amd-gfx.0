Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEC9C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:17:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BA99608FE
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA99608FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC1296F4F9;
	Thu, 20 May 2021 19:17:06 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ABFE6F4F8;
 Thu, 20 May 2021 19:17:05 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id h9so17452281oih.4;
 Thu, 20 May 2021 12:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Du5kz67a/iQ6a/NjTr+Df2buicUv7+vIDaRHiI4Tcpc=;
 b=WXsOHWQnfuFGEy/0apmg3pys11mvrLhSyFPuVqhVuh7E+rjuByzK56J+my50Jk/pEj
 OReru0IMuPnzI1aZb2My0T191LPM4bid2i8FL78Wpz1/eYdYfVzZ1qExUnGDLikO1Pgi
 KMvALHv7Mi8P1CJRvSqJRX+hQbk5EFGz4dmf3gJlQsNr0vXnpR+/QFo8Bc/ql3YUrTML
 EehvuwxUgeYpKr4xU9Su+R/6A/xMgF9OSInuCWd+oKiJH2MUyYQ32MGjFw0UIO1z+tgH
 nUZFaYMI9sJ3gK1sHEuGCiRiX5QIDGoWZmsGOrKzberNzmkexJLmikoP0bGWNENqF8mK
 Gb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Du5kz67a/iQ6a/NjTr+Df2buicUv7+vIDaRHiI4Tcpc=;
 b=AD6+XE6y2ztsykbUjIxqL57m/AD48FLPTfCZuPNrU9KtOKIVYtWift8tejx6R6OrR2
 SzC1NQep7F4BP/RaOXeO3UbwAgRANKELPIyjn7W7zJQCo+w8XIS027wUONHC1Ff8sd+t
 JKcHPfD3qv2ytismXJWMHsmjQbm6xOWV7+DjMhcbi2QkQgAmyvBxm+pB9h6cDQQ7hHqx
 RKgYu1UNc/AcEBQdoS1pA73LrlgMHRV2opsYjYlcZU+OP9f4dgYOZ0S3SUqy/fIeNdkf
 nLkAGwqtlJmTE/qnU3RTLXfDssb6Nr+FAyLIdyHQe2Tg+UcpiAYSswYmCx08U+RW3Ggb
 iOjQ==
X-Gm-Message-State: AOAM531fJCi51f8aOzU/Y7YZAEssQQvfXG0BdF429bk7y/cDc5dWF7/Y
 MzI2T1ilpHaCPx0eMQBCV/kIssbwTC/5t0QXcBojw0qX
X-Google-Smtp-Source: ABdhPJxdH46PVylAq5rTQ6Izow1yHwsSulVm3OW7d6kIYtHslqzWnlyagjo4KPAVAi6bcRGTXb2IYNf9hlUcE89yz7M=
X-Received: by 2002:a05:6808:1592:: with SMTP id
 t18mr2477039oiw.123.1621538225046; 
 Thu, 20 May 2021 12:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120248.3464013-1-lee.jones@linaro.org>
 <20210520120248.3464013-21-lee.jones@linaro.org>
 <c2b7cf7c-0b37-3581-4a9c-368ca0b89a36@amd.com>
In-Reply-To: <c2b7cf7c-0b37-3581-4a9c-368ca0b89a36@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 May 2021 15:16:53 -0400
Message-ID: <CADnq5_PJM7qiy-sK=KqgAjFKhwd7GPsVcsPfC4uOQw-2f+k1yA@mail.gmail.com>
Subject: Re: [PATCH 20/38] drm/radeon/radeon_vm: Fix function naming
 disparities
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCgpPbiBUaHUsIE1heSAyMCwgMjAyMSBhdCA4OjA1IEFNIENocmlz
dGlhbiBLw7ZuaWcKPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4KPiBBbSAyMC4w
NS4yMSB1bSAxNDowMiBzY2hyaWViIExlZSBKb25lczoKPiA+IEZpeGVzIHRoZSBmb2xsb3dpbmcg
Vz0xIGtlcm5lbCBidWlsZCB3YXJuaW5nKHMpOgo+ID4KPiA+ICAgZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9yYWRlb25fdm0uYzo2MTogd2FybmluZzogZXhwZWN0aW5nIHByb3RvdHlwZSBmb3IgcmFk
ZW9uX3ZtX251bV9wZGUoKS4gUHJvdG90eXBlIHdhcyBmb3IgcmFkZW9uX3ZtX251bV9wZGVzKCkg
aW5zdGVhZAo+ID4gICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl92bS5jOjY0Mjogd2Fy
bmluZzogZXhwZWN0aW5nIHByb3RvdHlwZSBmb3IgcmFkZW9uX3ZtX3VwZGF0ZV9wZGVzKCkuIFBy
b3RvdHlwZSB3YXMgZm9yIHJhZGVvbl92bV91cGRhdGVfcGFnZV9kaXJlY3RvcnkoKSBpbnN0ZWFk
Cj4gPgo+ID4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiA+
IENjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiA+IENj
OiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+Cj4gPiBDYzogRGFuaWVsIFZldHRlciA8
ZGFuaWVsQGZmd2xsLmNoPgo+ID4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4g
PiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+ID4gU2lnbmVkLW9mZi1ieTog
TGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KPgo+IFJldmlld2VkLWJ5OiBDaHJpc3Rp
YW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4KPiA+IC0tLQo+ID4gICBkcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl92bS5jIHwgNCArKy0tCj4gPiAgIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3JhZGVvbl92bS5jCj4gPiBpbmRleCAyZGM5YzlmOTgwNDliLi4zNmEzOGFkYWFlYTk2IDEw
MDY0NAo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdm0uYwo+ID4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdm0uYwo+ID4gQEAgLTUxLDcgKzUxLDcg
QEAKPiA+ICAgICovCj4gPgo+ID4gICAvKioKPiA+IC0gKiByYWRlb25fdm1fbnVtX3BkZSAtIHJl
dHVybiB0aGUgbnVtYmVyIG9mIHBhZ2UgZGlyZWN0b3J5IGVudHJpZXMKPiA+ICsgKiByYWRlb25f
dm1fbnVtX3BkZXMgLSByZXR1cm4gdGhlIG51bWJlciBvZiBwYWdlIGRpcmVjdG9yeSBlbnRyaWVz
Cj4gPiAgICAqCj4gPiAgICAqIEByZGV2OiByYWRlb25fZGV2aWNlIHBvaW50ZXIKPiA+ICAgICoK
PiA+IEBAIC02MjYsNyArNjI2LDcgQEAgc3RhdGljIHVpbnQzMl90IHJhZGVvbl92bV9wYWdlX2Zs
YWdzKHVpbnQzMl90IGZsYWdzKQo+ID4gICB9Cj4gPgo+ID4gICAvKioKPiA+IC0gKiByYWRlb25f
dm1fdXBkYXRlX3BkZXMgLSBtYWtlIHN1cmUgdGhhdCBwYWdlIGRpcmVjdG9yeSBpcyB2YWxpZAo+
ID4gKyAqIHJhZGVvbl92bV91cGRhdGVfcGFnZV9kaXJlY3RvcnkgLSBtYWtlIHN1cmUgdGhhdCBw
YWdlIGRpcmVjdG9yeSBpcyB2YWxpZAo+ID4gICAgKgo+ID4gICAgKiBAcmRldjogcmFkZW9uX2Rl
dmljZSBwb2ludGVyCj4gPiAgICAqIEB2bTogcmVxdWVzdGVkIHZtCj4KPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0
Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
