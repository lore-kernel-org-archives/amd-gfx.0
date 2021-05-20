Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85941C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:26:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46FEE6105A
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46FEE6105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9145D6F513;
	Thu, 20 May 2021 19:26:26 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B3D86F512;
 Thu, 20 May 2021 19:26:25 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 n32-20020a9d1ea30000b02902a53d6ad4bdso15878298otn.3; 
 Thu, 20 May 2021 12:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=L/aKDgdFp8azkNRPkBfwbGry+KpDDgeXnCjUZiXUHAk=;
 b=Iw2EOxuFQfHZ+eCHYMxU66KVGsltX5SDbaLnDelNONGLKRdnxrXhfh6GppGwh9hF03
 zNvDroo3j7IUMxWxmZItxH2vSffYWDPnXuVYVtLzvighVR1J1ro5K5lH4V4PSepWV0G4
 gvXSbivlFa1OnRM2D+IU6gdjLxPfcOtdfwX5/T6rhck+gIPtsOygu76ZuH1axb5/d0fc
 IBMpwixmy7uqUA5RhLSu+puEmdboK+4ah5hkBntYbSM0xU8NxvJmiwnGzmOfqMwPu1RB
 twbrTkQ+A+Dtnwhoe3AAYNOOdzIONhJ6vseidUA3CV9HPcPV0t6tz8Q/xDC7s7YVh947
 A1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=L/aKDgdFp8azkNRPkBfwbGry+KpDDgeXnCjUZiXUHAk=;
 b=jjKRiIw5L14+bl+24O6UM1fCCKd63mHbe5H/HTchHrVMuITu9nyMGbRk6Ri0x3tH9H
 paXdq8rES2qNwYWXqgJrLaeVnmfsIBgZvgGwdDoHGlwImvYW4HK13svfTVTvJjoiKMBr
 auXBwbd87aXKzk4VF2z5xqzkVfzIYDfqGNbplrVlz/Y02quXmcISrbZJW8FAzdvnNl00
 P8jTXFIY5JDsOz18L9nUF6E4JEcP/7/2ZX6JcB0fdewOntYD9QUcHfalhyWF9Q4sur/G
 h8SWiBWM5UAZGc/ixmROAhoLsStav8Fvp6rWhU12IYVZrUBG7ILQK3ki2ZZ9W6ZBu2Eg
 TM7Q==
X-Gm-Message-State: AOAM531Zm+NFaMuNFxRKiKfE+qwtvPOxVUsGydxK0Ccma1VZROKhYqCY
 upq0Ef13FtlDo9OvmAqAn0rD/frhdLuymprJtHY=
X-Google-Smtp-Source: ABdhPJx0fYn3UtO85WnCHYo3oCG9Ca6arkIE1QlALKzujCj8PWSdmjcwps+puWxR/yT2HWQLUUkvJ/ALvmm3ZQZ3twg=
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr5160706otl.132.1621538784761; 
 Thu, 20 May 2021 12:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120248.3464013-1-lee.jones@linaro.org>
 <20210520120248.3464013-38-lee.jones@linaro.org>
In-Reply-To: <20210520120248.3464013-38-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 May 2021 15:26:13 -0400
Message-ID: <CADnq5_OuzthTQOUkYRSPz0coL1-xgpfzMq57=9SzW3WDSrY_uA@mail.gmail.com>
Subject: Re: [PATCH 37/38] drm/amd/amdgpu/gfx_v10_0: Demote kernel-doc abuse
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

QXBwbGllZC4gIFRoYW5rcyEKCk9uIFRodSwgTWF5IDIwLCAyMDIxIGF0IDg6MDQgQU0gTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5n
IFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjEwXzAuYzo1MTogd2FybmluZzogVGhpcyBjb21tZW50IHN0YXJ0cyB3aXRoICcv
KionLCBidXQgaXNuJ3QgYSBrZXJuZWwtZG9jIGNvbW1lbnQuIFJlZmVyIERvY3VtZW50YXRpb24v
ZG9jLWd1aWRlL2tlcm5lbC1kb2MucnN0Cj4KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPgo+IENjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4KPiBDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBE
YW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Cj4gQ2M6IFN1bWl0IFNlbXdhbCA8c3VtaXQu
c2Vtd2FsQGxpbmFyby5vcmc+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4g
Q2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogbGludXgtbWVkaWFAdmdl
ci5rZXJuZWwub3JnCj4gQ2M6IGxpbmFyby1tbS1zaWdAbGlzdHMubGluYXJvLm9yZwo+IFNpZ25l
ZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Cj4gLS0tCj4gIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92MTBfMC5jCj4gaW5kZXggZmMxMmUzYzNlOWNhZS4uYzgzM2JlMzFlNGFlNiAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCj4gQEAgLTQ3LDcgKzQ3LDcg
QEAKPiAgI2luY2x1ZGUgImdmeF92MTBfMC5oIgo+ICAjaW5jbHVkZSAibmJpb192Ml8zLmgiCj4K
PiAtLyoqCj4gKy8qCj4gICAqIE5hdmkxMCBoYXMgdHdvIGdyYXBoaWMgcmluZ3MgdG8gc2hhcmUg
ZWFjaCBncmFwaGljIHBpcGUuCj4gICAqIDEuIFByaW1hcnkgcmluZwo+ICAgKiAyLiBBc3luYyBy
aW5nCj4gLS0KPiAyLjMxLjEKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
