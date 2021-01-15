Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B828C4332E
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 15:08:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51E552388B
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 15:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E552388B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0D3C6E487;
	Fri, 15 Jan 2021 15:08:56 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E77976E40D
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 14:07:25 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id q18so9425376wrn.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 06:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=9Odw20q3gXEAR4ejM8R6GdIUwRRcRbw8490h9rdPUcc=;
 b=AgxSUMFlUUPIvv5CYCVhB9ESxAU/YovP86kvO6uaoO3YUhCn/NbP5bnTR0EIBU9ZiN
 yvqKyoIXK9gB8xT4mX+zhYkBmmXwXheA4RVTFgM414NFIygpbsjMcIcb/VbXjqK5JhgB
 HRE/V75QGZHM0XUoq0gL8otFPNuBmuSuzEbG+bDQa063NoQ0CI++ra9hOzkhcsprxYu+
 Lc+A9KrrYycapTqQ1hEhwruMZ5F/EbtfJf9uD1KMw1BwRVeeCYLyCmxtbQwChxP+MEVv
 URKmYLPDpHh3jHWd1mIpbSbYfpffZOtqWQSu3RVIhB4DGed6evZt6h4C0+cJpGIb8vig
 auWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=9Odw20q3gXEAR4ejM8R6GdIUwRRcRbw8490h9rdPUcc=;
 b=DtEonX6bje28kr1RdX9UxZ+gAQropzV6F4PF0gKSEF8Y+75ZW0bQ6hb1rFG2E2KqSV
 2Ot01xJKusiweOFL2sgHR/7kfuPE4p6r7atr1FcLAEzJ0YUNXj/mhC6epMqH1CyXD0Zs
 LoFeUt7ktbGyfac1c6dzU7oWEX8tQzavaVuvECaIl/T0o64xe19TSB4z5fJeqmLHr/Mj
 KfOpi1DzXbkZ6K/OEWyIybxVFD6I5b/Szg2Fq3cM62JNy9PryE54ZveFNKiGohGNDlbQ
 rv+1I/LspuKk0bT4weEmSH4Xe7i22NfFbeM6PT3dr4EnOYEwBS2d+4PT1dT7hsomhynM
 am5g==
X-Gm-Message-State: AOAM533CO0PWYqyLTyP007CGD6GEaOlIeHcTeB0IQcmXdaPDQwHJ25HJ
 qxioFqLsym/1v3oSfz3KY6U1+QLHjNwWA1xr
X-Google-Smtp-Source: ABdhPJxiLYmwvJfOBJMdQDu9lMmxNcI4jkYOF85BSMCzp9muy7yWWxOB/j6pIYgi/9NxvFduOKtHiQ==
X-Received: by 2002:adf:b781:: with SMTP id s1mr9354399wre.290.1610719644600; 
 Fri, 15 Jan 2021 06:07:24 -0800 (PST)
Received: from dell ([91.110.221.158])
 by smtp.gmail.com with ESMTPSA id o13sm17471975wrh.88.2021.01.15.06.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Jan 2021 06:07:23 -0800 (PST)
Date: Fri, 15 Jan 2021 14:07:22 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Huang Rui <ray.huang@amd.com>
Subject: Re: [PATCH] drm/amd/display: fix the coding style issue of
 integrated_info
Message-ID: <20210115140722.GO3975472@dell>
References: <20210115215423.525965-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210115215423.525965-1-ray.huang@amd.com>
X-Mailman-Approved-At: Fri, 15 Jan 2021 15:08:45 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Jiansong.Chen@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gU2F0LCAxNiBKYW4gMjAyMSwgSHVhbmcgUnVpIHdyb3RlOgoKPiBGb2xsb3cgdGhlIGNvZGlu
ZyBzdHlsZSBvZiBzaXplIG9mIGEgc3RydWN0LCBjaGFuZ2luZyB0bzoKPiAKPiBwID0ga21hbGxv
YyhzaXplb2YoKnApLCAuLi4pOwo+IAo+IFNpZ25lZC1vZmYtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1
YW5nQGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3Jl
L2RjX2xpbmsuYyB8IDQgKystLQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQoKUmV2aWV3ZWQtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5v
cmc+CgotLSAKTGVlIEpvbmVzIFvmnY7nkLzmlq9dClNlbmlvciBUZWNobmljYWwgTGVhZCAtIERl
dmVsb3BlciBTZXJ2aWNlcwpMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3Ig
QXJtIFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
