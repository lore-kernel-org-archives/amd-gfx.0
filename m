Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5452AC4707F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 09:06:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13C886100C
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 09:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C886100C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE1796EE3F;
	Thu, 27 May 2021 09:06:27 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 747126E84A
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 May 2021 08:21:40 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id n4so3803161wrw.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 May 2021 01:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=f3CJ+z+hW5+Yea+/asFQ8IaQ0miomCINEExuo2f0cM8=;
 b=FMDDOorktSQ8ooNfi6NxKtrZnQVdBPUh2hEKCR84OkxlJgJ+qFH+OlcrTw4z8RZ+K8
 YbzR4U9qFvpHKV3wh+zR1ywpA/o5PUTns5ygBKukAONbXcYZCvzj5LRhpJIvWpM/iilM
 BzP4irU6jawx1/er2EwVpsW/Lx4i3QMr9KZa4hn+VdI4dVT/ohL7xVxORZFOpO0Q3F03
 TBR4XryyY3+rYrJb2QlDM/mfjR1fA0YBbIoaP9l1iXMQ1WUKYbYI060+FYypvtOE8m2e
 tmTdztTXfm130Iazse6/nzeiBJ7RmV9svyIik/C0dFb586ZLU9MoavVvCo8hjGupm/ux
 CaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=f3CJ+z+hW5+Yea+/asFQ8IaQ0miomCINEExuo2f0cM8=;
 b=s66UMoV+1jpLwQcv9sOOFj6+HYcWbl8Ja2tyfbsAR8dfwfbI9zTqwLZqu3aLm/7b0k
 q7TeiJbgCaHN6lg1FOkFf0X3QFSqiZpy38XpeKQSoWOZQtabOO15ZBdF6/7mHR0z8/rO
 IRwhg4wpDxWvKMFZQC4d05fZ1C0HcJtpI0Ft7ux0uYi7qmZKx/t/8NxV8rzRn3PojjrF
 fuaHIfg12FVpLGDkwL3vSo5fF4gfda+0wkxgYnVTF99+ONFrcZ1XuB9+FlJLYTk4oopS
 ucdLoL5Qp8fghE2RIUmRZTrnwrHijibF7XWTUUB6Pd9BN2QWwwQWoca3oJ3VZEHW3FVx
 56Cw==
X-Gm-Message-State: AOAM531/fEe1yKQ2ieWTGin6mLqfHmOzD09Qe1dWQooWVrCB2ELaRvRK
 qHjHjYlUWWGaK7oUBZueRvlpFJUMk+WHCw==
X-Google-Smtp-Source: ABdhPJxR8s26m+hNIJRzWRa0T/Y4yDvMYFd7OxpV0j1/n7P5zZ420kzUeXWjjmpVTRPJ9d+zwEGgyQ==
X-Received: by 2002:a5d:5541:: with SMTP id g1mr2040676wrw.102.1622103699106; 
 Thu, 27 May 2021 01:21:39 -0700 (PDT)
Received: from dell ([91.110.221.223])
 by smtp.gmail.com with ESMTPSA id s134sm1880581wme.6.2021.05.27.01.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 May 2021 01:21:38 -0700 (PDT)
Date: Thu, 27 May 2021 09:21:36 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu/swsmu/aldebaran: fix check in is_dpm_running
Message-ID: <20210527082136.GH543307@dell>
References: <20210527034952.247846-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210527034952.247846-1-alexander.deucher@amd.com>
X-Mailman-Approved-At: Thu, 27 May 2021 09:06:27 +0000
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCAyNiBNYXkgMjAyMSwgQWxleCBEZXVjaGVyIHdyb3RlOgoKPiBJZiBzbXVfY21uX2dl
dF9lbmFibGVkX21hc2soKSBmYWlscywgcmV0dXJuIGZhbHNlIHRvIGJlCj4gY29uc2lzdGVudCB3
aXRoIG90aGVyIGFzaWNzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFu
ZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBDYzogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9y
Zz4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9hbGRlYmFyYW5f
cHB0LmMgfCA1ICsrKystCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKClJldmlld2VkLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgoK
LS0gCkxlZSBKb25lcyBb5p2O55C85pavXQpTZW5pb3IgVGVjaG5pY2FsIExlYWQgLSBEZXZlbG9w
ZXIgU2VydmljZXMKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFybSBT
b0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
