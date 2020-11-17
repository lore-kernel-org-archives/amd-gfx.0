Return-Path: <SRS0=Y8VF=EX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB7AC6379D
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 08:52:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E741D222E8
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 08:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TZQDVLDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E741D222E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A25156E155;
	Tue, 17 Nov 2020 08:52:07 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01A066E135
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2020 08:42:44 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id 23so1523670wmg.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2020 00:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=INVepkInhsjBHSvjvAvny9URQAKXqQU8PTJjrdyilLg=;
 b=TZQDVLDqGyhoKFtvLeWZ9D6JvfFDVq4YVlcxXgVDbox+jB0SsBAUuhzq4kxSLDZLx7
 tA+VgCtW1erqoJIc8z07yw3lm6p8aZlF55+CU1a7SzZKEte8obieZnLXPaDlPWhdMJ0T
 Bz7aMyMAkSstYfbqY8YRK0KEK1Hpk+DQlDbvnl78N4YGpH6p33GTCcEdYX2FRd1u/6ea
 7BYX2gQh2juy/3g7glEG9oyJOHulags6Aoj+YnqU8fr0YPt3p9UY/4jeRTV1x3TF2cOD
 Qxda6iNjGPjBT6bKBIWqkOT/jfZoXTNaIyZFygEK6H1052iF37L+TESdmQwARohUr/63
 7bzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=INVepkInhsjBHSvjvAvny9URQAKXqQU8PTJjrdyilLg=;
 b=JmcVSJGTutQXy67CHEgHEfhzvKNNXdRYQ/AHr22iCpjo3CvM6oczxpmMws6TsHK4xA
 7DGNIRM+E/j0rTx5OAPrrgs7aM1gyDYRepqTEQWctQa/MKdjOoDUI7Q0KRC9mEbDcECk
 j1d0bPsbSWsb48U0mcJ1i3PrCtKrXUHtKx5oQGfHlNBMZ29Uq48/yEVwi0xNgxDWgq5n
 D3z4lUZaTh36Lyn8Rg71N9iN0YlqnT/v6W9+k3qbYnWqYLt9h25W0rXgxZ5K++APD6Wf
 HZAwCe9tujSqK6IpFSuwWTvOkgnIF+lQnvH5bqVsA/etTuSm0GuXoZP8EPITDCe9Qt8N
 v/gQ==
X-Gm-Message-State: AOAM531vefIVINuPNCw4S0nV+IOlMaQGA3oT2/R2c+SEQWkmJ1W8x2bE
 ldJQei8asYg9svB9r4X0bF4vZw==
X-Google-Smtp-Source: ABdhPJyNVLesnBzBLGwI8R/r91IU6DQIR0oUVG7aPWGO4TNkn9RRrKNJU7HvQjW4Pp8LVhnPffCnxg==
X-Received: by 2002:a1c:6284:: with SMTP id w126mr3140057wmb.145.1605602563687; 
 Tue, 17 Nov 2020 00:42:43 -0800 (PST)
Received: from dell ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id o17sm2471180wmd.34.2020.11.17.00.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2020 00:42:42 -0800 (PST)
Date: Tue, 17 Nov 2020 08:42:41 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 01/43] drm/radeon/atombios_encoders: Move
 'radeon_atom_get_tv_timings()'s prototype into shared location
Message-ID: <20201117084241.GC1869941@dell>
References: <20201116173005.1825880-1-lee.jones@linaro.org>
 <20201116173005.1825880-2-lee.jones@linaro.org>
 <CADnq5_NnPiySfPv4Jgk4j8rvzxYkoVxRBGUAjdQJW_tL2RuTBA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADnq5_NnPiySfPv4Jgk4j8rvzxYkoVxRBGUAjdQJW_tL2RuTBA@mail.gmail.com>
X-Mailman-Approved-At: Tue, 17 Nov 2020 08:52:06 +0000
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

T24gTW9uLCAxNiBOb3YgMjAyMCwgQWxleCBEZXVjaGVyIHdyb3RlOgoKPiBPbiBNb24sIE5vdiAx
NiwgMjAyMCBhdCAxMjozMCBQTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPiB3cm90
ZToKPiA+Cj4gPiBGaXhlcyB0aGUgZm9sbG93aW5nIFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhz
KToKPiA+Cj4gPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXRvbWJpb3MuYzoxNzkx
OjY6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYcmFkZW9uX2F0b21fZ2V0
X3R2X3RpbWluZ3PigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQo+ID4gIDE3OTEgfCBib29sIHJh
ZGVvbl9hdG9tX2dldF90dl90aW1pbmdzKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LCBpbnQg
aW5kZXgsCj4gPiAgfCBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgo+ID4KPiA+IENjOiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gPiBDYzogIkNocmlzdGlhbiBL
w7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gPiBDYzogRGF2aWQgQWlybGllIDxh
aXJsaWVkQGxpbnV4LmllPgo+ID4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4K
PiA+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+ID4gQ2M6IGRyaS1kZXZlbEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKPiA+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpv
bmVzQGxpbmFyby5vcmc+Cj4gCj4gQXBwbGllZC4gIFRoYW5rcyEKClN1cGVyc3RhciEgIFRoYW5r
cyBBbGV4LgoKLS0gCkxlZSBKb25lcyBb5p2O55C85pavXQpTZW5pb3IgVGVjaG5pY2FsIExlYWQg
LSBEZXZlbG9wZXIgU2VydmljZXMKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUg
Zm9yIEFybSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
