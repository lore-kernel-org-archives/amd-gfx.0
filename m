Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F93FC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 17:21:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB89661924
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 17:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB89661924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81D1D6E9E2;
	Tue, 23 Mar 2021 17:21:12 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C0856E91E
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 17:15:45 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id k8so21572131wrc.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 10:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=jkD/89hzNsqmkTz0cgn45+3G97+hdN9w0MYvdcADVJY=;
 b=h8rraCmPEqparAn5HJ+4/mzapBhqLvKpCahb5I3lLD89c+5vSx0qm5c/WvW7Hkg0QW
 vLuQyjlK6th2ka7h1zdWq2tmQMvAueieDzg2NMMFh/wTs+KFqeDjfk8lMmtIsSDInfkj
 hgumkG5eOb9/9AvlNf9fzgg5pyrhWZAfJFjsgYr7T/qefxwDnXtc/szmhIhYx8BvhfHa
 5Ab99TVj4UW5nyy0ZNc0XDiExScRPMt0UBdDfxHlVqOGJRB6auO/+tvXmAP6dPMWr+wN
 J9ybc4PVrTZFO2L6EUnKoiv15Dx12limTVkfQqobEnnMtgbSy9vwB9+4RA9s9Cjouc2r
 +FNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=jkD/89hzNsqmkTz0cgn45+3G97+hdN9w0MYvdcADVJY=;
 b=GUwQxSUOzXjzFaOsk69J0JV3c/9QAYzjsJI/ew1XxrBB/9AHlM6S1+Jd2daR64bYBW
 0S8EKsrZEJoHHB4bxl6SkxZ1JXx3W0Zl1YTFfgoS9d+V9Nc1+jbYw9BwKaxMLJUDNU5r
 2xa244dugFU20W07t7JP+jdb1w3lb/XsiGVELbq2qb7QM3Y+lMTaYFfPTDlg/AR17zxV
 etOvnrgfQAwFfOCYMJ7VCl4KTA4Qh7hINVJ+bIAtpb38SRTijBEGFb05v7fX2QLN5qIe
 WE/6l4kkvlNveB8BPz40UDFqyVy7RDwWb+phy1ggo0RNVjW3KZTzDbcA9aZVPCpZL76u
 ii9Q==
X-Gm-Message-State: AOAM532lKCd35gSQefZdEEgIx8LTPnqjg1RKMHTCS+VSu3cJdfn/+Jl9
 mMueDhvMG/eMMmKsM3T7rIha3A==
X-Google-Smtp-Source: ABdhPJzWk/7mbyRrWGJqZM8T40XSMeZ7AZ+LrfMOt0Jd/pLxU2JubXbpvZ4enfFd1MIJMNCEbK4leQ==
X-Received: by 2002:adf:e68e:: with SMTP id r14mr4985288wrm.273.1616519744011; 
 Tue, 23 Mar 2021 10:15:44 -0700 (PDT)
Received: from dell ([91.110.221.180])
 by smtp.gmail.com with ESMTPSA id g15sm2957207wmq.31.2021.03.23.10.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Mar 2021 10:15:43 -0700 (PDT)
Date: Tue, 23 Mar 2021 17:15:41 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Colin King <colin.king@canonical.com>
Subject: Re: [PATCH][next] drm/amd/display/dc/calcs/dce_calcs: Fix allocation
 size for dceip and vbios
Message-ID: <20210323171541.GX2916463@dell>
References: <20210323141541.348376-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210323141541.348376-1-colin.king@canonical.com>
X-Mailman-Approved-At: Tue, 23 Mar 2021 17:21:10 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCAyMyBNYXIgMjAyMSwgQ29saW4gS2luZyB3cm90ZToKCj4gRnJvbTogQ29saW4gSWFu
IEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KPiAKPiBDdXJyZW50bHkgdGhlIGFsbG9j
YXRpb25zIGZvciBkY2VpcCBhbmQgdmJpb3MgYXJlIGJhc2VkIG9uIHRoZSBzaXplIG9mCj4gdGhl
IHBvaW50ZXIgcmF0aGVyIHRoYW4gdGhlIHNpemUgb2YgdGhlIGRhdGEgc3RydWN0dXJlcywgY2F1
c2luZyBoZWFwCj4gaXNzdWVzLiBGaXggdGhpcyBieSB1c2luZyB0aGUgY29ycmVjdCBhbGxvY2F0
aW9uIHNpemVzLgo+IAo+IEFkZHJlc3Nlcy1Db3Zlcml0eTogKCJXcm9uZyBzaXplIG9mIGFyZ3Vt
ZW50IikKPiBGaXhlczogYTJhODU1NzcyMjEwICgiZHJtL2FtZC9kaXNwbGF5L2RjL2NhbGNzL2Rj
ZV9jYWxjczogUmVtb3ZlIHNvbWUgbGFyZ2UgdmFyaWFibGVzIGZyb20gdGhlIHN0YWNrIikKPiBT
aWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPgo+
IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY2FsY3MvZGNlX2NhbGNzLmMg
fCA0ICsrLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKCkZpeGVkIGFscmVhZHkgbWF0ZS4KCi0tIApMZWUgSm9uZXMgW+adjueQvOaWr10KU2VuaW9y
IFRlY2huaWNhbCBMZWFkIC0gRGV2ZWxvcGVyIFNlcnZpY2VzCkxpbmFyby5vcmcg4pSCIE9wZW4g
c291cmNlIHNvZnR3YXJlIGZvciBBcm0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3
aXR0ZXIgfCBCbG9nCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
