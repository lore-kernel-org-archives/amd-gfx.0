Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34EFC388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 07:56:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 664FA206B5
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 07:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mhLpXVeL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664FA206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9803689FA0;
	Wed, 11 Nov 2020 07:55:05 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AB9989DEC
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 07:16:08 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id c9so1249966wml.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 23:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=+nPLAs9D2ufq7P4TZ41Op/D3bZShS4W5mF/VA6cz7/U=;
 b=mhLpXVeLoB/gkb+Az2aKW+BxBUlNW8rOmuRdOt96oIEMScXjIzJcNXw+VyxJ2zyqqD
 63lwWwl1iABwU2vFZf+lFGzPhbV4zMGFQddJNtt4jKve+Eafqby5GghY9WhQJdlQqZVl
 YXOQuEYjZinIUoRx5rvmldASKFngyXdqpzIKEB5JzqOuwtXJsbfCV24ikJTrExjv9xPx
 EKunKqMNq5IHYKC0EfAMyeLkY2J5rxBHYqSy2jqLO0Iiars08t2njEz+EVypbmWcQFVT
 Wn9Uk2cW+kMLbLWMOIBtFWj9Rov1xWzWiZSppd2jTU1Qvra5tSmai8BsptEgEp/doiTJ
 zzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=+nPLAs9D2ufq7P4TZ41Op/D3bZShS4W5mF/VA6cz7/U=;
 b=dV5Lg6TMUyFf5xPJ7tYS95FbV7x+j8Q1lTT9QFA0EOB8rVsxC6qqDaebPPBs+ncBd2
 2ulUIsUuZpmSLxu+y1hQV5tT0CPpi5ufpMJkL/eFlpivCVHn8SjtEGGmYU+cN70zHhfr
 uvd2BksrsFNzaQOH3Syr9M2yOFQo6jcBLjjjy0f4hmuoX7QtfTYFmYznAXnBeMaXrk7j
 3pVaC7srvhD862cXK4pakFBDtnHP7iC1JXDgDZl/66dsspn2O5McDplkDM6t3mfYpkWq
 sucj8ysSrvK1GL4lP5mdnJlniXjewOApvrwih9to2z1XgiHpLKb3PrqqgssowP6l0bPr
 jQrg==
X-Gm-Message-State: AOAM531tT7AWV4zmHQCrFGyCLNuqbziJR0BhuUCdrXvjZkSEzP8QvsQ6
 HdCO0Yb161LV3q3UxvDnsZKdPQ==
X-Google-Smtp-Source: ABdhPJxq9nNsRdWxmsjRvYKprThebW/E99OrwREqb9B0XCSt/1vALQHP41UyvyzHl/CpRtuLhn++Fg==
X-Received: by 2002:a05:600c:22d3:: with SMTP id
 19mr2293473wmg.21.1605078966759; 
 Tue, 10 Nov 2020 23:16:06 -0800 (PST)
Received: from dell ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id w1sm1275524wro.44.2020.11.10.23.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 23:16:06 -0800 (PST)
Date: Wed, 11 Nov 2020 07:16:04 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 01/30] drm/radeon/evergreen: Add comment for
 'evergreen_page_flip()'s 'async' param
Message-ID: <20201111071604.GN2063125@dell>
References: <20201110193112.988999-1-lee.jones@linaro.org>
 <20201110193112.988999-2-lee.jones@linaro.org>
 <CADnq5_MMDnk7fvoOv8poVvCx1EVGQ0XvujHG=fBwR5XgSO+qww@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADnq5_MMDnk7fvoOv8poVvCx1EVGQ0XvujHG=fBwR5XgSO+qww@mail.gmail.com>
X-Mailman-Approved-At: Wed, 11 Nov 2020 07:55:04 +0000
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

T24gVHVlLCAxMCBOb3YgMjAyMCwgQWxleCBEZXVjaGVyIHdyb3RlOgoKPiBPbiBUdWUsIE5vdiAx
MCwgMjAyMCBhdCAyOjMxIFBNIExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+IHdyb3Rl
Ogo+ID4KPiA+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3YXJuaW5nKHMp
Ogo+ID4KPiA+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2V2ZXJncmVlbi5jOiBJbiBmdW5jdGlv
biDigJhldmVyZ3JlZW5fZ3B1X2luaXTigJk6Cj4gPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9l
dmVyZ3JlZW4uYzoxNDE5OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdh
c3luYycgbm90IGRlc2NyaWJlZCBpbiAnZXZlcmdyZWVuX3BhZ2VfZmxpcCcKPiA+Cj4gPiBDYzog
QWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+ID4gQ2M6ICJDaHJpc3Rp
YW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+ID4gQ2M6IERhdmlkIEFpcmxp
ZSA8YWlybGllZEBsaW51eC5pZT4KPiA+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwu
Y2g+Cj4gPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiA+IENjOiBkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxl
ZS5qb25lc0BsaW5hcm8ub3JnPgo+IAo+IEFwcGxpZWQgd2l0aCBtaW5vciBmaXh1cHMuICBUaGFu
a3MhCgpTdXBlcnN0YXIhICBUaGFua3MgQWxleC4KCk9uY2UgdGhlc2UgYXJlIGFsbCBpbiAtbmV4
dCwgSSdsbCByZWJhc2UgYW5kIGZpeCB0aGUgc3RyYWdnbGVycy4KCi0tIApMZWUgSm9uZXMgW+ad
jueQvOaWr10KU2VuaW9yIFRlY2huaWNhbCBMZWFkIC0gRGV2ZWxvcGVyIFNlcnZpY2VzCkxpbmFy
by5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBcm0gU29DcwpGb2xsb3cgTGluYXJv
OiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
