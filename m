Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11E8C56201
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A8D420872
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HpLbM+V0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8D420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94B526E91F;
	Wed, 25 Nov 2020 08:22:59 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7869C6E51A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 19:02:08 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id 1so12874wme.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 11:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=Iqfo9keS2TpK9GfS0c0b6OiBQlmC8pD8aAHf7OaR9CI=;
 b=HpLbM+V0jq7UNWv0s31h85bdrOxL/5xJyr4X+waMFda7d4JHut00b11AorcytoyUtN
 yc05zp19+B6hk0tcP5+pMqJW6JswuODpPbEiJIrRNS8f3syEKd3rfr/jJJso5oMeC8U6
 toNcyx5kAUZ0sZwYUj1VDTelp9sf1KXX8OWxt5lMwnhDHg9NB+XkCDYJFBaDtvrUIIJn
 lkAjiRQKIgi6BESygC6wxEjIv+fHTgdVrbELD+HhjlZTR0NcST3xGIweqIg3nxffRm2m
 8H6X49MT1ec7hpZFwM1o2lNu1czV1fdnifqMxZ1ofEc2KOSHxeT6myWUPRhjnAI9EfND
 LVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Iqfo9keS2TpK9GfS0c0b6OiBQlmC8pD8aAHf7OaR9CI=;
 b=AALQUTKp3ediSq64pjg5TJgcDXebQTYH3EfLrwZ2qO38784HSwXlH3z0ySi5k3XS9D
 lzeS4Q7bSXxmfXHNYW7CWA1w+QGdjWTmxKnsjGSezddDOjeak2Mmz3edQWosBhtAws7N
 3VVUeQst5NIpmRVACMjXMcm+5QCODkOe+NWnEQyCb4SzlUzwKLZcuw8RmInD/dLMZeAp
 MCX+DJSpMQ/LkillMlP4Ed5D9iuW1DLXQJYjRS/ULB6HjuT8VTn2J3POzLQsttLaBdqk
 encPFHId8BUP1mGg8XH79J320uWWi1jMctcXMX5E2qqa4j5HtH63Ws85lL5rWqgmkDhJ
 BGmg==
X-Gm-Message-State: AOAM532kpyPcGPOOpIEq+tvqnfUwk35f7bePTSW610dugib1ecyck+t/
 dx9yQgO7zWy3e7XFCyRvzQB5yQ==
X-Google-Smtp-Source: ABdhPJw/HJ98oz834LeZOvm1TSSpQe1fptg/MS2M8idKTbhtYAnFb4PUY3/ynRryGMQT1piVK1X2KQ==
X-Received: by 2002:a1c:b787:: with SMTP id h129mr5980131wmf.67.1606244527085; 
 Tue, 24 Nov 2020 11:02:07 -0800 (PST)
Received: from dell ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id 6sm33311328wrn.72.2020.11.24.11.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2020 11:02:06 -0800 (PST)
Date: Tue, 24 Nov 2020 19:02:04 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 01/40] drm/radeon/radeon_device: Consume our own header
 where the prototypes are located
Message-ID: <20201124190204.GC4716@dell>
References: <20201123111919.233376-1-lee.jones@linaro.org>
 <20201123111919.233376-2-lee.jones@linaro.org>
 <CADnq5_PaFeyNAc3a8e0MmZRKzPxPQCxGyhD_7TP+jcuPvRt9NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADnq5_PaFeyNAc3a8e0MmZRKzPxPQCxGyhD_7TP+jcuPvRt9NQ@mail.gmail.com>
X-Mailman-Approved-At: Wed, 25 Nov 2020 08:22:58 +0000
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
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCAyNCBOb3YgMjAyMCwgQWxleCBEZXVjaGVyIHdyb3RlOgoKPiBPbiBNb24sIE5vdiAy
MywgMjAyMCBhdCA2OjE5IEFNIExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+IHdyb3Rl
Ogo+ID4KPiA+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3YXJuaW5nKHMp
Ogo+ID4KPiA+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kZXZpY2UuYzo2Mzc6Njog
d2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhyYWRlb25fZGV2aWNlX2lzX3Zp
cnR1YWzigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQo+ID4KPiA+IENjOiBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gPiBDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gPiBDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxp
bnV4LmllPgo+ID4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiA+IENjOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+ID4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKPiA+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFy
by5vcmc+Cj4gCj4gQXBwbGllZC4gIFRoYW5rcyEKClRoYW5rcyBhZ2FpbiBBbGV4LiAgR3JlYXQg
d29yayEKCkFsbW9zdCB0aGVyZSBub3cgLi4uCgotLSAKTGVlIEpvbmVzIFvmnY7nkLzmlq9dClNl
bmlvciBUZWNobmljYWwgTGVhZCAtIERldmVsb3BlciBTZXJ2aWNlcwpMaW5hcm8ub3JnIOKUgiBP
cGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQXJtIFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sg
fCBUd2l0dGVyIHwgQmxvZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
