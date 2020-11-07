Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AB2C2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 08:59:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D18F8206ED
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 08:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OdxcA/HW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18F8206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70C6589728;
	Mon,  9 Nov 2020 08:59:17 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B0D76E2D8
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 Nov 2020 15:14:43 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id k18so3992223wmj.5
 for <amd-gfx@lists.freedesktop.org>; Sat, 07 Nov 2020 07:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=5Yfpcznfq7zUC+nbLYSd5qw9mgk2f1+fj8pB/pC5wlY=;
 b=OdxcA/HWczLQ90m1mnY48hp3qEOBvLprtrlUSRDiLVQPdiPIaKMmmXp/mQLsSd0sKK
 mOVPeIQ4LT8aH8g8HdwQItMt4AUvV+6siH4x51zO91HFX3HysYW0LmzGthb1pFGr1brY
 awUYslxY/OgiFK5LReEhL6axPFWgesZxAV/DiqUILXxjBnEFRXHVt6Ld1BXWtb5hbgsX
 n3zFf+NsdBb6KHxE4JwYCdTIq/jUj9tkLIGmV4gXqhxKBsMSwK/ZS4LiB49MYVSaVfOn
 wpxVIz322u55aL2OIiCtrOZXNlM2ABvBav6YcdbDPHvYqcAcVJDR5Lh770fj0JQs3wvD
 NwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=5Yfpcznfq7zUC+nbLYSd5qw9mgk2f1+fj8pB/pC5wlY=;
 b=FBcjZO35zAjVj8MJZn0K9Rw4eOsEMamdLG5sqC4X7kmFoDA2fzq3LtUxV+tCBIDWPC
 VbQg6xAQ9SkPpGUNNiQnpqnjNZfxDFvHbWyTrLKrXRyXe1Jp9Xv6Ge9JClXcD5xfoycH
 1mUIqjfne5JJriyN5aqQoC96HaN/WRHixpWSjaPCMmwmTW6hVaw0krLovQDAX8ti6UJS
 CBflRqJKeq/QAWzGgjG7v+OSLYkutrtbMLWXXPwFtwu7SeCHu6MBjyU6SSUId8xusQxp
 8BWppLbKsdH5Q5HWXKFk1L6CqXroc1dA9PA9vyB5g+ajjRa8C9C4qIAfULFXde143xM0
 3UHQ==
X-Gm-Message-State: AOAM532k7KfQzgjMq4or5rKyeujvocprxCjDnS3QPO0xRLaUHS0gjnwM
 N2Dz8PbdYRf4O4UAUfgBDVJBvA==
X-Google-Smtp-Source: ABdhPJxPCaNJ0MahQ/W3b9fSaGgk7MqXhKrOOHN2l3VTEbRE4u5vnj39pfkLusOtw7OARbYyPzCG8A==
X-Received: by 2002:a7b:c848:: with SMTP id c8mr2974808wml.86.1604762082229;
 Sat, 07 Nov 2020 07:14:42 -0800 (PST)
Received: from dell ([91.110.221.236])
 by smtp.gmail.com with ESMTPSA id f20sm6370386wmc.26.2020.11.07.07.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2020 07:14:41 -0800 (PST)
Date: Sat, 7 Nov 2020 15:14:24 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 10/19] drm/radeon/radeon: Move prototype into shared header
Message-ID: <20201107151424.GR2063125@dell>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
 <20201106214949.2042120-11-lee.jones@linaro.org>
 <20201107142651.GA1014611@ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201107142651.GA1014611@ravnborg.org>
X-Mailman-Approved-At: Mon, 09 Nov 2020 08:59:16 +0000
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gU2F0LCAwNyBOb3YgMjAyMCwgU2FtIFJhdm5ib3JnIHdyb3RlOgoKPiBIaSBMZWUsCj4gCj4g
T24gRnJpLCBOb3YgMDYsIDIwMjAgYXQgMDk6NDk6NDBQTSArMDAwMCwgTGVlIEpvbmVzIHdyb3Rl
Ogo+ID4gVW5mb3J0dW5hdGVseSwgYSBzdWl0YWJsZSBvbmUgZGlkbid0IGFscmVhZHkgZXhpc3Qu
Cj4gPiAKPiA+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3YXJuaW5nKHMp
Ogo+ID4gCj4gPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGV2aWNlLmM6NjM3OjY6
IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYcmFkZW9uX2RldmljZV9pc192
aXJ0dWFs4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KPiA+ICA2MzcgfCBib29sIHJhZGVvbl9k
ZXZpY2VfaXNfdmlydHVhbCh2b2lkKQo+ID4gIHwgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Cj4g
PiAKPiA+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gPiBD
YzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gPiBDYzog
RGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+ID4gQ2M6IERhbmllbCBWZXR0ZXIgPGRh
bmllbEBmZndsbC5jaD4KPiA+IENjOiBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdhbEBsaW5hcm8u
b3JnPgo+ID4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gPiBDYzogZHJpLWRl
dmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+ID4gQ2M6IGxpbnV4LW1lZGlhQHZnZXIua2VybmVs
Lm9yZwo+ID4gQ2M6IGxpbmFyby1tbS1zaWdAbGlzdHMubGluYXJvLm9yZwo+ID4gU2lnbmVkLW9m
Zi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KPiA+IC0tLQo+ID4gIGRyaXZl
cnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2RldmljZS5jIHwgIDEgKwo+ID4gIGRyaXZlcnMvZ3B1
L2RybS9yYWRlb24vcmFkZW9uX2RldmljZS5oIHwgMzIgKysrKysrKysrKysrKysrKysrKysrKysr
KysKPiA+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kcnYuYyAgICB8ICAzICstLQo+
ID4gIDMgZmlsZXMgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGV2aWNl
LmgKPiAKPiBPdGhlciBwdWJsaWMgZnVuY3Rpb25zIGluIHJhZGVvbl9kZXZpY2UuYyBoYXZlIHRo
ZWlyIHByb3RvdHlwZSBpbgo+IHJhZGVvbi5oIC0gZm9yIGV4YW1wbGUgcmFkZW9uX2lzX3B4KCkK
PiAKPiBBZGQgcmFkZW9uX2RldmljZV9pc192aXJ0dWFsKCkgdGhlcmUgc28gd2UgYXZvaWlkIHRo
aXMgbmV3IGhlYWRlci4KCkknbSBoYXBweSB0byBkbyB0aGF0LCBpZiBpdCdzIGRlZW1lZCBiZXR0
ZXIuCgotLSAKTGVlIEpvbmVzIFvmnY7nkLzmlq9dClNlbmlvciBUZWNobmljYWwgTGVhZCAtIERl
dmVsb3BlciBTZXJ2aWNlcwpMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3Ig
QXJtIFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
