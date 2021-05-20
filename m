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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3EFC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7280608FE
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7280608FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC4F56F4FE;
	Thu, 20 May 2021 19:19:35 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 657566F4FE;
 Thu, 20 May 2021 19:19:32 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 80-20020a9d08560000b0290333e9d2b247so5303777oty.7; 
 Thu, 20 May 2021 12:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=aOvxK05c6d3wLnFR8rUhQpFTkZU71eE9Pa/GUWPK6jA=;
 b=owH4E/XC406vIhUhSMWKPP8GyzYF1Mz7lVEo7LkRN7q76QG2sgiTXc/BMDNCWHxBV4
 5eIsWYI7Y06NM/nbZzTqTwVgMR6e8YFBUz8XTPxQBPhyv3tFmpVR3RADDLFn/rle8h4F
 cgPWUwXLPvFpOIo1cn5flHD7ieUjHUAv6/HsOUwVVqpU86IpKOeB18jJnXudzBMq47UQ
 VPs5Yt225e/0F5nRXeHuJE4+W5aRuoeIjCpuhmlNqTumAygglz9UidSgkiAqqtjWNv/0
 hSyBN5GXNzwhnfyOAUTEDHzsRiqdagH47HqhiF/mc6JMZlohcD9b9BkPYTAz4T7J96Gl
 QLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aOvxK05c6d3wLnFR8rUhQpFTkZU71eE9Pa/GUWPK6jA=;
 b=jCRvR4Ru4tIdJ8fRQNgLMrmJMje57B2s+kjtBj8rT4G+VakzL54lmhE6Dc9uajJn7I
 d0odIghMSrmPCniakRG4cdgWLGgV8H4BITBKeUOf+aGND1xHZr8SwmKxPkkixOUlQlbo
 90n5unsYNH+zyY78sYbcCx/K/VB0xQgf9lrtnyIU8noMHFt/goIb3eYrR0oVKFV04N5r
 sFxy2Rb3g+gItyn0bApw/0QCK7Tdf1OLAJqO3dxl+h1vLDaVhEW9TMBrylqK1xyud8I+
 Uf2MyFEEfaEcU0vT/JsF/fz7HaQzAUa2usk3IcOqpICn+ciO/V7er+k9OtiC9bFYs3t4
 kJGw==
X-Gm-Message-State: AOAM5316S+SC69S/1SjT/fk5iE39H6Y66sizwUsSEc6+Dwb42dRzmsWj
 e5nQ/CXCMD4gRfe+Rq5OKYUbDwQuyXJHJDCztSA=
X-Google-Smtp-Source: ABdhPJyH4iCQKcDPVu6k2YTOnGw2ittRAY+dS0HMOZ25P+LVhK/V3vl3eDM4n+HZ6KmurXcebwFwKqKfjYKus3pdk1U=
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr5144353otl.132.1621538371730; 
 Thu, 20 May 2021 12:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120248.3464013-1-lee.jones@linaro.org>
 <20210520120248.3464013-25-lee.jones@linaro.org>
In-Reply-To: <20210520120248.3464013-25-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 May 2021 15:19:20 -0400
Message-ID: <CADnq5_OtCr6KeYBOr-chNZRKuUOEE96B5WZN_mu2A2H_JutjeA@mail.gmail.com>
Subject: Re: [PATCH 24/38] drm/amd/amdgpu/mmhub_v9_4: Fix naming disparity
 with 'mmhub_v9_4_set_fault_enable_default()'
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCk9uIFRodSwgTWF5IDIwLCAyMDIxIGF0IDg6MDMgQU0gTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5n
IFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9tbWh1Yl92OV80LmM6NDQ2OiB3YXJuaW5nOiBleHBlY3RpbmcgcHJvdG90eXBlIGZvciBt
bWh1Yl92MV8wX3NldF9mYXVsdF9lbmFibGVfZGVmYXVsdCgpLiBQcm90b3R5cGUgd2FzIGZvciBt
bWh1Yl92OV80X3NldF9mYXVsdF9lbmFibGVfZGVmYXVsdCgpIGluc3RlYWQKPgo+IENjOiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4gS8O2
bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxp
ZWRAbGludXguaWU+Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBDYzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwo+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5v
cmc+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3Y5XzQuYyB8IDIg
Ky0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjlfNC5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjlfNC5jCj4gaW5kZXggNDdjOGRkOWQxYzc4
ZS4uYzRlZjgyMmJiZThjNSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9tbWh1Yl92OV80LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92
OV80LmMKPiBAQCAtNDM2LDcgKzQzNiw3IEBAIHN0YXRpYyB2b2lkIG1taHViX3Y5XzRfZ2FydF9k
aXNhYmxlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICB9Cj4KPiAgLyoqCj4gLSAqIG1t
aHViX3YxXzBfc2V0X2ZhdWx0X2VuYWJsZV9kZWZhdWx0IC0gdXBkYXRlIEdBUlQvVk0gZmF1bHQg
aGFuZGxpbmcKPiArICogbW1odWJfdjlfNF9zZXRfZmF1bHRfZW5hYmxlX2RlZmF1bHQgLSB1cGRh
dGUgR0FSVC9WTSBmYXVsdCBoYW5kbGluZwo+ICAgKgo+ICAgKiBAYWRldjogYW1kZ3B1X2Rldmlj
ZSBwb2ludGVyCj4gICAqIEB2YWx1ZTogdHJ1ZSByZWRpcmVjdHMgVk0gZmF1bHRzIHRvIHRoZSBk
ZWZhdWx0IHBhZ2UKPiAtLQo+IDIuMzEuMQo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
