Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1419FC4741F
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 08:59:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF2120702
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 08:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uUhdDeWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF2120702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 146B68976D;
	Mon,  9 Nov 2020 08:59:18 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 242386E113
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 Nov 2020 18:41:43 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id 10so3717788wml.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 07 Nov 2020 10:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=VIFvmjQkWdDW6b37HhMnD+C4qQoz3DcHwcIERG/uILw=;
 b=uUhdDeWrWvg3kBhnJ3Z5YbNUUjnHf8w9qNV7Jplf6JSbdZ7NN9mecduDua0Ypen4LI
 q3RGxZW6lSDcmREgAEbrTek0BAC4ZPw3kSH8EZAB27hPAJ2kDdYvfEODw7qFdIy7DDdd
 PHbbkdyxd+Pu1lLwuRITcSqgd8dC7RL2lwV1XC+4fwKpT6yoXraAQXBmVaAoqOuKuPvK
 FhMbqAoO3BK3KHXAaNJ2ojFcmrUx92pVsgd7G78Bq+YoNIPXIb6aeM4kboMNyhspppIk
 /lv5sxHY+q2QuKUuxjBexspwuSO9Yhqp3S4NzwWjBlsFoRMNMMycqFbGs1V1+OPw8lzb
 80/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=VIFvmjQkWdDW6b37HhMnD+C4qQoz3DcHwcIERG/uILw=;
 b=cyhapqJCsmugd+v3LhqVl3Iyp5AWGwJXVAz/R5W0L6SsJVLevR1l7mKOY4iDem3mzP
 EkkZ4jTk9jwhPo0msX7mZNAKkkfYQkfqGjt4w1DoRHReE7nXPgiK60f/F/muF3PTfJYV
 mGH4/bDhIqkQdeV/hsjSvbAOj9tdqpt9XqBkErpfumhL1E+XIure82H7vxiYt1Do2/L0
 AbiGtjX/gJkWx0gHMFqVUy79maqOawyNC6myJbzmQvm8GlPk73RD7tpZp/dQY4r6YCmM
 z7reNy0RbGITeojbs8FZL8ZCRLL88EpM7yRjLrd66QGiUf9WcIROQ5M05WXpMaHry0N9
 f9Og==
X-Gm-Message-State: AOAM533UrJDidoZm0ZS7vKeqgpP4s32NDqonjSCMVHO2fHFxbZffmFJ+
 rXC5NphZs3VC2A8YM1FqFEJ97w==
X-Google-Smtp-Source: ABdhPJweZLZnBdauFcGjFjaKCOPZtQ1RPvK4RlU+S0OevZUoKH28NQgQTvj7HEfsbFBzHknvb1VdXQ==
X-Received: by 2002:a7b:c5c3:: with SMTP id n3mr5782826wmk.44.1604774501714;
 Sat, 07 Nov 2020 10:41:41 -0800 (PST)
Received: from dell ([91.110.221.236])
 by smtp.gmail.com with ESMTPSA id d8sm7061086wmb.11.2020.11.07.10.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2020 10:41:40 -0800 (PST)
Date: Sat, 7 Nov 2020 18:41:38 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 00/19] [Set 2] Rid W=1 warnings from GPU
Message-ID: <20201107184138.GS2063125@dell>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
 <9d4be6a4-4f39-b908-4086-2b6adb695465@amd.com>
 <20201107173406.GA1030984@ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201107173406.GA1030984@ravnborg.org>
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
Cc: Faith <faith@valinux.com>, Alex Deucher <alexander.deucher@amd.com>,
 Andy Gross <andy.gross@ti.com>, David Airlie <airlied@linux.ie>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Rob Clark <rob.clark@linaro.org>,
 linaro-mm-sig@lists.linaro.org, Leo Li <sunpeng.li@amd.com>,
 Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org,
 Keith Whitwell <keith@tungstengraphics.com>,
 Jeff Hartmann <jhartmann@valinux.com>, Rob Clark <rob@ti.com>,
 Gareth Hughes <gareth@valinux.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 by <jhartmann@precisioninsight.com>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gU2F0LCAwNyBOb3YgMjAyMCwgU2FtIFJhdm5ib3JnIHdyb3RlOgoKPiBIaSBDaHJpc3RpYW4u
Cj4gCj4gPiBJJ20gbm90IHN1cmUgaWYgd2Ugd2FudCB0byBkbyBzb21lIG9mIHRoZSBzdWdnZXN0
ZWQgY2hhbmdlcyB0byByYWRlb24uCj4gCj4gQWxsIHBhdGNoZXMgZm9yIHJhZGVvbiBsb29rcyBn
b29kIHRvIG1lIGV4Y2VwdCAiZHJtL3JhZGVvbi9yYWRlb246IE1vdmUKPiBwcm90b3R5cGUgaW50
byBzaGFyZWQgaGVhZGVyIi4KCldhcyB0aGF0IHRoZSBvbmUgd2hlcmUgdGhlIHByb3RvdHlwZSBu
ZWVkcyBtb3ZpbmcgdG8gcmFkZW9uLmg/Cgo+IEFja2VkLWJ5OiBTYW0gUmF2bmJvcmcgPHNhbUBy
YXZuYm9yZy5vcmc+Cj4gZnJvbSBtZSB0byBoYXZlIHRoZW0gYXBwbGllZCAoZXhjZXB0IHRoZSBz
aGFyZWQgaGVhZGVyIG9uZSkuCgpUaGFua3MgU2FtLgoKPiBJIGNhbiByZXBseSB0byB0aGUgaW5k
aXZpZHVhbCBwYXRjaGVzIGlmIHlvdSBsaWtlLgoKLS0gCkxlZSBKb25lcyBb5p2O55C85pavXQpT
ZW5pb3IgVGVjaG5pY2FsIExlYWQgLSBEZXZlbG9wZXIgU2VydmljZXMKTGluYXJvLm9yZyDilIIg
T3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFybSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29r
IHwgVHdpdHRlciB8IEJsb2cKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
