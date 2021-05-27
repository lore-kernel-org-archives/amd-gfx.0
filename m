Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92244C4707F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 04:21:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 532CF613CC
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 04:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532CF613CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C12846EE20;
	Thu, 27 May 2021 04:21:09 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1921A6EE1D;
 Thu, 27 May 2021 04:21:08 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id c196so3850855oib.9;
 Wed, 26 May 2021 21:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=g3ObGWoYw8A3770dDfoAtEJd60ASO6sSETw7hq7iaWw=;
 b=jOs3/1jJupOalzeebxv4XckU9+Uu9UMC/mX+6ifUQ46qaTC0M/5bL7tZkCX2UZYODu
 gjR2CFjIrySHfkeUdf+ZsLqMwxDhghv9UDS9xWD4ty/L+uvKlpL5QJj/3/4s5LSrQ9h7
 sFVXC2ofmcrknmIAPan0e+iYNqsedzQLW529FdHYzR4qTd8P4QgLA79XgLKjBzRTaeye
 aBKoFNWbmICiMVRKzbfHhPlzEEbcszXkGs06yOIDu3APuchNNjH+oNyK163+l3B054oD
 NcM7OTxUYYcXGsZJFF5U/Ei4n8382PwTqcEgQlnE3JQ96J57UyPGajV5tqIi0O8q2gLX
 Clsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=g3ObGWoYw8A3770dDfoAtEJd60ASO6sSETw7hq7iaWw=;
 b=oqGoj5t2p6Fh3+u3UIULcWIFPZdUPY0HWhTQJh6JC3poqANjdNnAGpO/CwbmV283e2
 yrJr7Fwb+tkFbM4ESBaPsln2QzPcI+jdnMPMRvAk5cFV3R3lmAceXdHi65k1ViZPLmH1
 foIIUlP0w1g7i/uFP26OxBkwkuWblmog2gDW1FZqFU3eU8Vz5S5wMrJF7Y4DVcMcsvY4
 IENDbGQTrWdTKZx/4Mty5KDAE2c5NvK6RYxNWbNZJfG8hB+RqZLTMjuOSzu+B/u0CWvt
 q7uAzf4kUwlIFKVOgF258AkLhyOTFDYE4wypZLmck0UU0zUh4ssCVX8foSp/UxVMXRFu
 VFfQ==
X-Gm-Message-State: AOAM530ZRQj7kgf0Im9TeLV6TBpOUv2G0NuRRysyilDpdkjAiCwhj6HJ
 cqHPt5Jz4aVF3HPQcwjB9qiZOIgAcIAQo2LMFAU=
X-Google-Smtp-Source: ABdhPJyz5ycopmTnjB2ZTxePhB77r9FoMwpQJutSgFKAIAc3x1USuW/E9yoOdo9oKVskhKra+DE3aZI7rmCir48ptR0=
X-Received: by 2002:a05:6808:1592:: with SMTP id
 t18mr1068439oiw.123.1622089267401; 
 Wed, 26 May 2021 21:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org>
 <20210526084726.552052-20-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-20-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 May 2021 00:20:56 -0400
Message-ID: <CADnq5_NzewQQNd_JvZVKWibzJKL9GEQp9VD0qUZ4KdhJAmgY-Q@mail.gmail.com>
Subject: Re: [PATCH 19/34] drm/amd/amdgpu/amdgpu_device: Make local function
 static
To: Lee Jones <lee.jones@linaro.org>
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
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCk9uIFdlZCwgTWF5IDI2LCAyMDIxIGF0IDQ6NDggQU0gTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5n
IFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGV2aWNlLmM6NDYyNDo2OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5
cGUgZm9yIOKAmGFtZGdwdV9kZXZpY2VfcmVjaGVja19ndWlsdHlfam9ic+KAmSBbLVdtaXNzaW5n
LXByb3RvdHlwZXNdCj4KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQu
Y29tPgo+IENjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4K
PiBDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBEYW5pZWwgVmV0dGVy
IDxkYW5pZWxAZmZ3bGwuY2g+Cj4gQ2M6IFN1bWl0IFNlbXdhbCA8c3VtaXQuc2Vtd2FsQGxpbmFy
by5vcmc+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRyaS1kZXZl
bEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3Jn
Cj4gQ2M6IGxpbmFyby1tbS1zaWdAbGlzdHMubGluYXJvLm9yZwo+IFNpZ25lZC1vZmYtYnk6IExl
ZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jCj4gaW5kZXggNGEwNDBmODljYTVhYS4uZjE1ZTE4MDc2MmQyZSAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiBAQCAtNDY5
Miw3ICs0NjkyLDcgQEAgc3RhdGljIGludCBhbWRncHVfZGV2aWNlX3N1c3BlbmRfZGlzcGxheV9h
dWRpbyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgICAgICAgIHJldHVybiAwOwo+ICB9
Cj4KPiAtdm9pZCBhbWRncHVfZGV2aWNlX3JlY2hlY2tfZ3VpbHR5X2pvYnMoCj4gK3N0YXRpYyB2
b2lkIGFtZGdwdV9kZXZpY2VfcmVjaGVja19ndWlsdHlfam9icygKPiAgICAgICAgIHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3QgbGlzdF9oZWFkICpkZXZpY2VfbGlzdF9oYW5kbGUs
Cj4gICAgICAgICBzdHJ1Y3QgYW1kZ3B1X3Jlc2V0X2NvbnRleHQgKnJlc2V0X2NvbnRleHQpCj4g
IHsKPiAtLQo+IDIuMzEuMQo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
