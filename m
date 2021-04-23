Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76804C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 14:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A6E6141C
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 14:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A6E6141C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E50A46EBA6;
	Fri, 23 Apr 2021 14:41:35 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 035F36E0F4
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 08:28:52 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 w7-20020a1cdf070000b0290125f388fb34so751891wmg.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 01:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=h5v4zIXPv6WHWTKJvFYWSELVGuItjZYfaJrXobHmfuo=;
 b=LLTmm9mVlUi6clUD7JUsKWh0K7EL9Qw1q+pdK4ZgZuITlf3H+/lF//Fd0MDVRsaqTW
 /oIEliN++BGSRU87nOuOB2UvKwiAAbsHuQy6Zynb7CvSh5n2sNrZTWMKmO0kKOavskOS
 aBl2Rl8MoS3ZpdXFYhkzVmL5jCn1HXJVQeeElRhahx5oerQBev0+84SKaIvKSgFEKVYi
 NvrdvcLb0CTLSceov4ymzZfGhdkqLHjBDesJyKYl60PycziYY7wMyvWFFS1ncEkiVuQl
 DwFZ8G1IJ2GiCiBgxAeAbN2dk1H6malE9XSGm002jWeT1FwQ7cgnUwofPJDv3NAZ6oOM
 giyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=h5v4zIXPv6WHWTKJvFYWSELVGuItjZYfaJrXobHmfuo=;
 b=jzttRHuaNMa1swo5cU3MGMiSWhhSsiKebgPTz0dpijRskVikVikExrL6spzPdpGfHi
 7iM5AlfL1MABUHXnwl21IJCMlZn0Cjeb740/0b/dV+gmgSJiEEtuZKNVSD6NGD39cYBP
 reUmWBw/Ctjz2O3Ibz4OUa64u5CLR2Vr7V6L9odix7hOqBUAuUFP4EO3rrbkcr6hl+rA
 rw5eXhjt3do7BtVLlXf2FEXOwRaK/D8HFYelqiiyFxgKDSksAtMF5uSvrfay4Ad/mioI
 tBbN9R8kTL5Qfqw36bs3a7iRsgeuCMsudVeXRW93rd3zwbgJrv1Tb6uzSNyamBN87ly+
 ojlA==
X-Gm-Message-State: AOAM532ERCwiGTnjyVynZNgOxKnbUH8aAYklEictw4pvmaY/s4q5S7Xw
 UzDihhMZC7f1YgXvPZIP6fzSsw==
X-Google-Smtp-Source: ABdhPJxWpAEBcc/UIoHyOrRT4kaqZXgVnkDlB7IPILt72r+qVIyQSieMIAQdqs2mehCKPaIeN0ZGvQ==
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr4203194wmi.160.1619166531614; 
 Fri, 23 Apr 2021 01:28:51 -0700 (PDT)
Received: from dell ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id 2sm9611435wmi.19.2021.04.23.01.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Apr 2021 01:28:51 -0700 (PDT)
Date: Fri, 23 Apr 2021 09:28:49 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 31/40] drm/amd/amdgpu/amdgpu_gart: Correct a couple of
 function names in the docs
Message-ID: <20210423082849.GD6446@dell>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
 <20210416143725.2769053-32-lee.jones@linaro.org>
 <2029fbcf-8d2b-7a85-edd2-481a571ae43d@amd.com>
 <CADnq5_N5_poFcOpQzV+Ae22rwD0PG3kq0O3q10gmbb7=fNpEyA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADnq5_N5_poFcOpQzV+Ae22rwD0PG3kq0O3q10gmbb7=fNpEyA@mail.gmail.com>
X-Mailman-Approved-At: Fri, 23 Apr 2021 14:41:34 +0000
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
 Nirmoy Das <nirmoy.das@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCAyMCBBcHIgMjAyMSwgQWxleCBEZXVjaGVyIHdyb3RlOgoKPiBBcHBsaWVkLiAgdGhh
bmtzIQoKTG92ZWx5LiAgVGhhbmtzIGZvciB0aGVzZSBBbGV4LgoKLS0gCkxlZSBKb25lcyBb5p2O
55C85pavXQpTZW5pb3IgVGVjaG5pY2FsIExlYWQgLSBEZXZlbG9wZXIgU2VydmljZXMKTGluYXJv
Lm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFybSBTb0NzCkZvbGxvdyBMaW5hcm86
IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
