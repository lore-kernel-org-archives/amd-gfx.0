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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B209C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:16:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3C886135A
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C886135A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49DF46F4F6;
	Thu, 20 May 2021 19:16:13 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2A9E6F4F2;
 Thu, 20 May 2021 19:16:11 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id u11so17423636oiv.1;
 Thu, 20 May 2021 12:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8IA4EK6QCZUPS2VJM/CthWGQXD1VY0qEbTyCJO+YaKI=;
 b=IB7FUTa3Fm9U+stZPo8LH03erUcgUmfhx7Jry7EQ7Jtzc3Ac1SG4eaPkgQitM1UHr0
 jpEDSZeQG+skg4Dwxxv/gO/wLl867g1RwV0EN1QvM6I+Djtd7951uvKVrQnx7hOJfg+o
 miEzOj5wK5zSDduqudgNH7DiQDBvLljTQapNLDsAXmkfTZOF02r1LiNMkbwwlPnnVFIH
 VvXftcgZxL+5WaQrD86+D4UAPJ5Dp/4yu/z0PNs/LeQ8/NuzS0R31Fk8I68nEDKmDGjP
 5zohz3AsNpNBp5VfyqmlQ7bZTKU3kL7PcB/G5XVu3FrGbBJHk7ejRMG4qU8InVWmjbpW
 rw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8IA4EK6QCZUPS2VJM/CthWGQXD1VY0qEbTyCJO+YaKI=;
 b=Z5BeqQjMH5EdTVDS2UKBNGair9sr62afoxfyMTpIdDcKeTUpwT82fg85/edDeulLvf
 TLw+A2Xu8EjVkexKh/mVY6WoMH+w95TrrvM93Q6rAzueImcQVtV7d8jhr91QmUMfIL1c
 EkAxU/cvD3koNIblDATPFFdKCzlqbDffrFiyvlWJJGS3n7InKGg+bBwndRbhoiUni7cR
 GKoLiNSzY7Bo/RItmxXClCDjwMmFqsSzKQsK0L3+Ulrb9gaMPWpN71NhClzY1VjqTz9L
 7tJ4ZPKvLhe8dL5JmFcBACHNnzYvorfSSgwedTXrcZsUhjGOBiGRTjAHtSWQqYabgCU/
 kj7A==
X-Gm-Message-State: AOAM532fbAOEF0evJfJhzuXOVetjxDZE6bmxFgmr+FtWaGqhiqg233Os
 8JjhbvlQdX6PfG/lvfy6yuQb/qKnS31//ER6Oes=
X-Google-Smtp-Source: ABdhPJyjZJXNvUa5xHZWnGMQdRLZVinC4OBHnKgEG8wYkwieJ5ywWJUtdKBa3zvbFenStYoZkol8ak3wmyzA1Ffu+LI=
X-Received: by 2002:a05:6808:249:: with SMTP id
 m9mr4194241oie.120.1621538170961; 
 Thu, 20 May 2021 12:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120248.3464013-1-lee.jones@linaro.org>
 <20210520120248.3464013-20-lee.jones@linaro.org>
In-Reply-To: <20210520120248.3464013-20-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 May 2021 15:15:59 -0400
Message-ID: <CADnq5_OZR3qTX2hcDQyhgSGUyWAgCdUiJu3ODD_owJRip_RMOw@mail.gmail.com>
Subject: Re: [PATCH 19/38] drm/radeon/cik: Fix incorrectly named function
 'cik_irq_suspend()'
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

QXBwbGllZC4gIFRoYW5rcyEKCk9uIFRodSwgTWF5IDIwLCAyMDIxIGF0IDg6MDMgQU0gTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5n
IFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L2Npay5jOjc0NTA6IHdhcm5pbmc6IGV4cGVjdGluZyBwcm90b3R5cGUgZm9yIGNpa19pcnFfZGlz
YWJsZSgpLiBQcm90b3R5cGUgd2FzIGZvciBjaWtfaXJxX3N1c3BlbmQoKSBpbnN0ZWFkCj4KPiBD
YzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IENjOiAiQ2hyaXN0
aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBDYzogRGF2aWQgQWlybGll
IDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+
Cj4gQ2M6IFN1bWl0IFNlbXdhbCA8c3VtaXQuc2Vtd2FsQGxpbmFyby5vcmc+Cj4gQ2M6IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKPiBDYzogbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnCj4gQ2M6IGxpbmFyby1tbS1z
aWdAbGlzdHMubGluYXJvLm9yZwo+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVz
QGxpbmFyby5vcmc+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lrLmMgfCAyICst
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lrLmMgYi9kcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL2Npay5jCj4gaW5kZXggNDJhOGFmYTgzOWNiYi4uNzNlYTUxODlkZmIxYSAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2Npay5jCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9jaWsuYwo+IEBAIC03NDM5LDcgKzc0MzksNyBAQCBzdGF0aWMgdm9pZCBjaWtf
aXJxX2Rpc2FibGUoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpCj4gIH0KPgo+ICAvKioKPiAt
ICogY2lrX2lycV9kaXNhYmxlIC0gZGlzYWJsZSBpbnRlcnJ1cHRzIGZvciBzdXNwZW5kCj4gKyAq
IGNpa19pcnFfc3VzcGVuZCAtIGRpc2FibGUgaW50ZXJydXB0cyBmb3Igc3VzcGVuZAo+ICAgKgo+
ICAgKiBAcmRldjogcmFkZW9uX2RldmljZSBwb2ludGVyCj4gICAqCj4gLS0KPiAyLjMxLjEKPgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
