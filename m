Return-Path: <SRS0=mtj4=FF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A4CC64E7A
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 08:30:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8503B20659
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 08:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wYn5nmN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8503B20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8F7C89FD4;
	Tue,  1 Dec 2020 08:30:28 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C89C789A8B
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Dec 2020 07:19:42 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id 23so988279wrc.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Nov 2020 23:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=s4ekWG5Da7x/WlqkOj8PSgRoz7W2Hb23UEfpBiqdERA=;
 b=wYn5nmN58j3YBAM9oJ5NUmD1F8klWgjde92i623Ca9RiWgIL534fcOA9Lcia4oFz7M
 x24kwbi7GXajtELQDnw9ywTpPG4SALWUKaVDvQufJFEwwdF8t2fqxaNlWz2adxyEaHbJ
 2pSxZ4Xjlpz8L8qW1jDu4HypSuOHQ8W5JrOyuS8FjadVBt02HmwBHKFIBn+xWQXKgh40
 f2dxx5VOX6lnnFanIo+gDKf5PbUB+ZS5JWYFzDdfl1tWEd1QYcUwW61KERHnB3LtqBYF
 zQm4Sxc6OSLyQ1envR7P1rWBRGelrL4nRnx67y5sU9uRYO0I972UzWur4fIGGtmvJtRm
 +eLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=s4ekWG5Da7x/WlqkOj8PSgRoz7W2Hb23UEfpBiqdERA=;
 b=Qb3Gz08q6B3TgmPRW5F0shKbWKFnLDcQAr43JsGXkIoqiAZjWuDdnG566lTQpTG3cZ
 2RoTeBkqoK6RC9gjJ1ldR8re4XuY32mReF1t2d7qbhPZH5JkGwa1J5fW5gVFXHkttK1G
 aDOBNfZXjAHjgt8ubGm5RQBODiZBr7Qikt8HXURhs2qmAnB7BfU5aoc+Nrjb3A5QExDK
 8oBQgLVx45nD+JCEoCc34DUR/387spnOdiM/YKHLhcvOWR9dVLd5x5VKYcchJzlugStp
 DZjYKtlRF7oJDHYKYKaC0XAxrsumQKV+AsQF8Z+KVojNMvvG/tElLmTIERQQBAzI3zOR
 f4SA==
X-Gm-Message-State: AOAM5300/JJOiK9vzXMdh6FnsPQLHrfRg8ah8VPG3zjMyt/nuBBdz2UG
 hY25BFaFGMhVWbk1AgqwL8cHag==
X-Google-Smtp-Source: ABdhPJwJbBZx5ZXK6i3ydIfLDhrA0aJazi5AXeSMM1z90NtAPx49uDK1U9w9yKnMbSGOf8DJupBADw==
X-Received: by 2002:adf:ec0d:: with SMTP id x13mr1951722wrn.207.1606807181485; 
 Mon, 30 Nov 2020 23:19:41 -0800 (PST)
Received: from dell ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id z21sm1264690wmk.20.2020.11.30.23.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Nov 2020 23:19:40 -0800 (PST)
Date: Tue, 1 Dec 2020 07:19:38 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 32/40] drm/amd/display/amdgpu_dm/amdgpu_dm: Mark
 'link_bandwidth_kbps' as __maybe_unused
Message-ID: <20201201071938.GE4801@dell>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
 <20201126134240.3214176-33-lee.jones@linaro.org>
 <CADnq5_PtZRwNNV-EvMjkV9k2sYj9jdYBT3oqtS3-hm-pTsaaew@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADnq5_PtZRwNNV-EvMjkV9k2sYj9jdYBT3oqtS3-hm-pTsaaew@mail.gmail.com>
X-Mailman-Approved-At: Tue, 01 Dec 2020 08:30:27 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCAzMCBOb3YgMjAyMCwgQWxleCBEZXVjaGVyIHdyb3RlOgoKPiBPbiBUaHUsIE5vdiAy
NiwgMjAyMCBhdCA4OjQzIEFNIExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+IHdyb3Rl
Ogo+ID4KPiA+ICdsaW5rX2JhbmR3aWR0aF9rYnBzJyBpcyBhbHdheXMgb2J0YWluZWQsIGJ1dCBv
bmx5IHVzZWQgaWYKPiA+IENPTkZJR19EUk1fQU1EX0RDX0RDTiBpcyBkZWZpbmVkLgo+IAo+IFBy
b2JhYmx5IGJldHRlciB0byBqdXN0IG1vdmUgdGhpcyB1bmRlciBDT05GSUdfRFJNX0FNRF9EQ19E
Q04uICBJJ2xsCj4gc2VuZCBhIHBhdGNoLgoKSSBjb25zaWRlcmVkIHRoYXQsIGJ1dCB0aG91Z2h0
IHRoZXJlIHdvdWxkIGhhdmUgYmVlbiBnb29kIHJlYXNvbiBmb3IKdGhlIGNsYXVzZSBicmVhayBq
dXN0IGZvciBkY19saW5rX2JhbmR3aWR0aF9rYnBzKCkuCgotLSAKTGVlIEpvbmVzIFvmnY7nkLzm
lq9dClNlbmlvciBUZWNobmljYWwgTGVhZCAtIERldmVsb3BlciBTZXJ2aWNlcwpMaW5hcm8ub3Jn
IOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQXJtIFNvQ3MKRm9sbG93IExpbmFybzogRmFj
ZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
