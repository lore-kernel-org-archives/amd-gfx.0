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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC64C47089
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 04:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EDBF613BC
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 04:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EDBF613BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6CBE6EE23;
	Thu, 27 May 2021 04:25:26 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA9DB6EE22;
 Thu, 27 May 2021 04:25:24 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id h9so3882963oih.4;
 Wed, 26 May 2021 21:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HlEEB7m4vbuZJ5U/IF3dSwz8wK0GbasA4XFoALDTWL8=;
 b=W5/+NkQahCgvZZ1x00cU/xU8h+8cEB/LHC5TNOw+Qcu43GEXKib+gni+t4UUYVyU4b
 FADaYkMAkf8n+5lPiHn9m+W+H90W/b4+4FFG1IhqblRjXl+llnwhZu+vXnhdi5E2btqk
 j2ebfn+If6EBldLbq5k4BPeGxAAzl84vP4VWe2xjRf1rEt3JbuqWusKzzRv3TsxB3qgz
 mkHT7vJ60Ml3mnW0UYPWWKOmAHFYD6tyohnS/NWdv82NutAwQmL1MIyJZ/y3B1SsSTAR
 KHTxUhr6/fXZaWhQJo0h4Ldg4iX5E6VgzBCWqsqFGk3mgABntDMN0AlzvPNf5MFgudsg
 sEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HlEEB7m4vbuZJ5U/IF3dSwz8wK0GbasA4XFoALDTWL8=;
 b=OjZ5oakAUmLUeQzQ28dYmOdnT6NUi6dFSQ3u4n/jzsvmfvBgEwIRDPXk0JHdIL05KL
 z8f1JQ1pxr7Nv7nmTZaEn/ts2sli9s5Y7zL6rIQB6W7pTeqOyz+dutIkQVAxai6ZA64d
 4TlW7mFXHW5mW60hlpOj+YMxq23+xo1jgs+6dja5RB6KyMqrwMPthdyB1P19EBnOw+vs
 dYN5ICO3l3pfkqlTTWBDxQDBlwkU2/Uw50OKvni4cHVtRu077SSCaIdTgA+Tde2qLpid
 O5nXUNRyy+rZgHUiIIH7E9J6xlEJSXYEexjaTuezP2p0KMOyfY7eigefPsx19zFYh+Xy
 c2aw==
X-Gm-Message-State: AOAM532Jm5p1m085ItpRQRHwyhsyVByD0B7efwJbOC8vGngziRaiVdOf
 bDApFvlJfRHNjwjDpGaH7TZQSiisJLWMxR76Xw8=
X-Google-Smtp-Source: ABdhPJzJ+S3b+XHZOW81VUxJ1mHkElsf0B94rZZm/7C5niMZ+YtERtmHEKDtM8Uc8rDW/9L+Ulyr21pntbu0H/HCLJk=
X-Received: by 2002:a05:6808:1592:: with SMTP id
 t18mr1076858oiw.123.1622089524295; 
 Wed, 26 May 2021 21:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org>
 <20210526084726.552052-22-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-22-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 May 2021 00:25:13 -0400
Message-ID: <CADnq5_O0upD-8xOmzd+jGdozS=F9k0+xTTOWYm29Xwop4Th9zg@mail.gmail.com>
Subject: Re: [PATCH 21/34] drm/amd/display/dc/dce110/dce110_hw_sequencer:
 Include header containing our prototypes
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
Cc: Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCk9uIFdlZCwgTWF5IDI2LCAyMDIxIGF0IDQ6NDggQU0gTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5n
IFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS8uLi9kaXNwbGF5L2RjL2RjZTExMC9kY2UxMTBfaHdfc2VxdWVuY2VyLmM6OTI5OjY6IHdh
cm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYZGNlMTEwX2VkcF93YWl0X2Zvcl9U
MTLigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQo+Cj4gQ2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJy
eS53ZW50bGFuZEBhbWQuY29tPgo+IENjOiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KPiBD
YzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IENjOiAiQ2hyaXN0
aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBDYzogRGF2aWQgQWlybGll
IDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+
Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRyaS1kZXZlbEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0Bs
aW5hcm8ub3JnPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEw
L2RjZTExMF9od19zZXF1ZW5jZXIuYyB8IDEgKwo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNl
MTEwL2RjZTExMF9od19zZXF1ZW5jZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9kY2UxMTAvZGNlMTEwX2h3X3NlcXVlbmNlci5jCj4gaW5kZXggOTIxOWRiNzlmMzJiNi4uMWVm
MWIxYjMzZmIwOSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
ZGNlMTEwL2RjZTExMF9od19zZXF1ZW5jZXIuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX2h3X3NlcXVlbmNlci5jCj4gQEAgLTY0LDYgKzY0LDcg
QEAKPiAgI2luY2x1ZGUgImF0b21maXJtd2FyZS5oIgo+Cj4gICNpbmNsdWRlICJkY2UxMTBfaHdf
c2VxdWVuY2VyLmgiCj4gKyNpbmNsdWRlICJkY24xMC9kY24xMF9od19zZXF1ZW5jZXIuaCIKPgo+
ICAjZGVmaW5lIEdBTU1BX0hXX1BPSU5UU19OVU0gMjU2Cj4KPiAtLQo+IDIuMzEuMQo+Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
