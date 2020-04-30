Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBCEC47247
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 17:35:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5A1820731
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 17:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJR8ozLs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A1820731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 594876E0F3;
	Thu, 30 Apr 2020 17:35:12 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E75006E0F3
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 17:35:10 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id y24so2928385wma.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 10:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zsfGbtTXl8zxz7hnkZfp6evZMpph882cw3vOIDmUlcE=;
 b=kJR8ozLsca4HuBJ8/INJEE0/mJGHqX9O8M2mI8npSNG34R4/Bq3V288FgXqbjg2LPg
 WFOPDwhEVGMT7CSifKleO4iRNJ+gl2F2P+jvwd+IuZ2i+JN++gPK0+2HMRux85dnForH
 OMY8Mbrpyu87CO0XQ8Pflq0GpMwzlpCuQNd/sJedSVVXZEHDKt5P2ElxEDHHr8uhZLMG
 O9c4hGoZz8Ns/ALD24BozsdTc5A6oMwJsis2qBOsLrGiNob9O1MBwTlYK/z+BYpSipjM
 ZLnkKgnOYgPUsp8UMAS18rrH4EVwliL8SuyhPF1P2en6FgsbanQPv4unimy2WzrZ2Ucn
 Xw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zsfGbtTXl8zxz7hnkZfp6evZMpph882cw3vOIDmUlcE=;
 b=nzSxLCBM5TKy4Y2FUtaK5X8lQivYSWy1FiPAYkH8UwOHUlXk683sB82G31tViNEdz8
 fMAbjKNZvg/lAmJRZVZhWQKIFYa+2P6NSX/3mm0nT8LKStBvla0qOx2ZhdAOOdiGOH8W
 XQ79f8DwoRColJIcORTCKYEHkaZ7LHOJyT8/1z/CGlRQ0E5n12HhSeFf48aFlOmlcLmQ
 0IYz0MJjT4OKfuzE2cVDdmXzydJ5/Gg2EXumKb03jc9mQcPVgJqmwWo/MV6xWNoph+wG
 8CkhX4ortD39hsBnWtexLSVTBkzQRIxS66DRD9oKp7jLALqMczErLXNamBTEFzof1JJ5
 skVQ==
X-Gm-Message-State: AGi0PuYcTplp8k9AovoiD52a/OhkzPPsCi9x9xfFne5VYpf2OZPEqORD
 OrWVCHKRq+kej0MbAnIs9jI8IGwdVLmMclvH87I=
X-Google-Smtp-Source: APiQypKzi3jyfg8wL7G3VbtTvE6rAbh0wkEhE1vJCaRNQko/3nh74qhgtVxdbhM+Q/lRp1OtrKdW8SnqPmSvZD1mEh8=
X-Received: by 2002:a7b:cc0e:: with SMTP id f14mr4163526wmh.39.1588268109409; 
 Thu, 30 Apr 2020 10:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200429162801.18598-1-michel@daenzer.net>
 <CADnq5_Oh9n-tfJM4dpoSmczkRtSMpdhey=CP5E4qW9vJtYA68g@mail.gmail.com>
 <83e45cee-5102-3ead-3796-eb962d6f2026@daenzer.net>
In-Reply-To: <83e45cee-5102-3ead-3796-eb962d6f2026@daenzer.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Apr 2020 13:34:57 -0400
Message-ID: <CADnq5_NYrtA7aDPjDnKjCRnssC=sjwbZ7DTGwzq9b4Q5BKaL3w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/dc: Use WARN_ON_ONCE for ASSERT
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
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
Cc: Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCBBcHIgMzAsIDIwMjAgYXQgMTI6NDMgUE0gTWljaGVsIETDpG56ZXIgPG1pY2hlbEBk
YWVuemVyLm5ldD4gd3JvdGU6Cj4KPiBPbiAyMDIwLTA0LTMwIDQ6NTUgcC5tLiwgQWxleCBEZXVj
aGVyIHdyb3RlOgo+ID4gT24gV2VkLCBBcHIgMjksIDIwMjAgYXQgMTI6MjggUE0gTWljaGVsIETD
pG56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD4gd3JvdGU6Cj4gPj4KPiA+PiBGcm9tOiBNaWNoZWwg
RMOkbnplciA8bWRhZW56ZXJAcmVkaGF0LmNvbT4KPiA+Pgo+ID4+IE9uY2Ugc2hvdWxkIGdlbmVy
YWxseSBiZSBlbm91Z2ggZm9yIGRpYWdub3Npbmcgd2hhdCBsZWFkIHVwIHRvIGl0LAo+ID4+IHJl
cGVhdGluZyBpdCBvdmVyIGFuZCBvdmVyIGNhbiBiZSBwcmV0dHkgYW5ub3lpbmcuCj4gPj4KPiA+
PiBTaWduZWQtb2ZmLWJ5OiBNaWNoZWwgRMOkbnplciA8bWRhZW56ZXJAcmVkaGF0LmNvbT4KPiA+
Cj4gPiBBcHBsaWVkLiAgVGhhbmtzIQo+Cj4gVGhhbmsgeW91Lgo+Cj4gQlRXLCBpdCBtaWdodCBi
ZSBiZXR0ZXIgdG8gbWVyZ2UgdGhpcyBmb3IgNS43IGZpbmFsLCBzaW5jZQo+IGh0dHBzOi8vZ2l0
bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0vYW1kLy0vaXNzdWVzLzkxMiBpcyBlYXN5IHRvIGhpdCB3
aXRoCj4gNS43IGFuZCBjYW4gYmUgdmVyeSBub2lzeSB3aXRoIFdBUk5fT04uCgpZZWFoLCBJIHBs
YW4gdG8gYXBwbHkgaXQgZm9yIDUuNy4KCkFsZXgKCj4KPgo+IC0tCj4gRWFydGhsaW5nIE1pY2hl
bCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHBzOi8vcmVkaGF0LmNv
bQo+IExpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBN
ZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
