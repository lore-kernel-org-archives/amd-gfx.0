Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4423C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 15:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E9446196A
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 15:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9446196A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AE2B89EB4;
	Tue, 30 Mar 2021 15:27:01 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F4A36E91C
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 15:19:15 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 u5-20020a7bcb050000b029010e9316b9d5so8623321wmj.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 08:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=hCfGCExGZ032atZREFMuWQJ4hKJ6Pjl2rDpU87CxNjI=;
 b=d0tnXFEBbBdt3KAHMvZjgIVuPuUhTN5DpIRb16zr9Wk5NxGjXgpPfg14g44/A2DAeX
 0xH1xn8QdIWzGlu8Ghy6X5ovM6ayJD5ysiyMKXYOPHyLblqh1+i75rYM6w9+edrv+0ei
 jWP8gNuHMEB6Atp2OLtz6mkl0vofFczh8/mP/H5WPiMNg728lZoiDJKH8usabY4Sth8u
 7kgCg0JF0ybA0kgZvQ7ww95DwgsEXt+/XMHHgB2ANxE1zNrC8sssFlvNJvmCt6BS5+ed
 70/r6Eyxo7jcpJglZI/KMfaaLFBQyepOVVmKurGUAFmC82jpSGDcy9EbVcRinorFzDET
 0Apw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=hCfGCExGZ032atZREFMuWQJ4hKJ6Pjl2rDpU87CxNjI=;
 b=pvkzy5zxvgJBawRqTJROhXakmHiMMVAPibVKv3WrfJq/aIrPSyeq4NnMjp/ujerBvM
 fhLsPfRZSv5A6snFGRas/WEWT0Py9V0/5gFZNf5bhyvuZ46nfQf3rzGVQG3DlHuwyeal
 DZu9KibjXFRxca5VuxMVHMEC4+oMy8wL29i94eo51/5gpuWkc9GtFotWqqaHIxeLLJL4
 gJIJSS5vYwya+TwEuPy41O5DBZo0ceW3tXF/WxLpJRF4Y4TfSRR1Art3jBigHxb8UFKB
 T5Z2HMtUcQypvD8pBorRWY5j1JDFBMUMYbGPV3XluOnP6d3d1n8BLwNwPI7LqNF+HUmL
 yI9A==
X-Gm-Message-State: AOAM533ocVMJzdvF5914r5c5DZLVZhbkOsH2jKtRm4/+W0L12cc5fh/N
 I3Vbp+oplnXsKfAQEMmRLBHatQ==
X-Google-Smtp-Source: ABdhPJyYgKkqcDOow6JJ62djXw3iIsO/j+KvsfseIB+9/rwYszatw8KxsjLaOFanM+fL7Q88Q/+L0w==
X-Received: by 2002:a1c:5f54:: with SMTP id t81mr4641496wmb.84.1617117553836; 
 Tue, 30 Mar 2021 08:19:13 -0700 (PDT)
Received: from dell ([91.110.221.217])
 by smtp.gmail.com with ESMTPSA id n1sm41945988wro.36.2021.03.30.08.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Mar 2021 08:19:13 -0700 (PDT)
Date: Tue, 30 Mar 2021 16:19:11 +0100
From: Lee Jones <lee.jones@linaro.org>
To: linux-kernel@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx@lists.freedesktop.org, Anthony Koo <Anthony.Koo@amd.com>,
 Ben Skeggs <bskeggs@redhat.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Colin Ian King <colin.king@canonical.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>, Jeremy Kolb <jkolb@brandeis.edu>,
 Kuogee Hsieh <khsieh@codeaurora.org>, Leo Li <sunpeng.li@amd.com>,
 linaro-mm-sig@lists.linaro.org, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, nouveau@lists.freedesktop.org,
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [RESEND 00/19] Rid GPU from W=1 warnings
Message-ID: <20210330151911.GL2916463@dell>
References: <20210319082428.3294591-1-lee.jones@linaro.org>
 <20210324103611.GJ2916463@dell>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210324103611.GJ2916463@dell>
X-Mailman-Approved-At: Tue, 30 Mar 2021 15:27:00 +0000
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCAyNCBNYXIgMjAyMSwgTGVlIEpvbmVzIHdyb3RlOgoKPiBEYW5pZWwsCj4gCj4gPiBN
SU1FLVZlcnNpb246IDEuMAo+ID4gQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVU
Ri04Cj4gPiBDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0Cj4gPiAKPiA+IFRoaXMgaXMg
YSByZXNlbmQgb2YgdGhlIHJlbWFpbmluZyBwYXRjaGVzLgo+ID4gCj4gPiBBbGwgb2YgdGhlc2Ug
cGF0Y2hlcyBoYXZlIGJlZW4gc2VudCBiZWZvcmUuCj4gCj4gQXJlIHlvdSBzdGlsbCBrZWVuIHRv
ICdob292ZXIgdGhlc2UgdXAnPwo+IAo+IEp1c3QgbGVhdmUgdGhlIG9uZSB0aGF0IHJlcXVpcmVz
IHdvcmsgYW5kIHRha2UgdGhlIHJlc3QgcGVyaGFwcz8KCkhvdyB3b3VsZCB5b3UgbGlrZSBtZSB0
byBwcm9jZWVkIHdpdGggdGhpcz8KCi0tIApMZWUgSm9uZXMgW+adjueQvOaWr10KU2VuaW9yIFRl
Y2huaWNhbCBMZWFkIC0gRGV2ZWxvcGVyIFNlcnZpY2VzCkxpbmFyby5vcmcg4pSCIE9wZW4gc291
cmNlIHNvZnR3YXJlIGZvciBBcm0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0
ZXIgfCBCbG9nCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
