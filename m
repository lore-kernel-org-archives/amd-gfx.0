Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44885CD4F21
	for <amd-gfx@archiver.kernel.org>; Sun, 17 May 2026 13:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0266410E263;
	Sun, 17 May 2026 13:53:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y6UY5Lbm";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 572BB10E174
 for <amd-gfx@lists.freedesktop.org>; Sun, 17 May 2026 13:53:55 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-48e82c23840so8641195e9.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 17 May 2026 06:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779026034; x=1779630834; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ay6bnjdiJykakdEpJojMy3BsnRfLjHl5B+Mr2CQ/Omw=;
 b=Y6UY5LbmRLlDfhUT6XrVuOvHxDWHGGLUE0xVr8hiR76fyg2JtZpYCivy/xfSzRI2eE
 kl0mNnZfNa/OUR1FG1XnqQotH3YtnzWyVDORk4QT3Ws/DSae+DS/Z/28DRMb5t6LrqB6
 a+hf6Iaol26pI6Ql5xCs3/jGqs1p87ULV4heZypYvCUPEdkQgqSgtRFDMQITJ66XPVOP
 4NHG6mwSgtx4Sd8bM42vGLAI7jUzegsWxnhxyDFv3Ov+CQAaEYB550yI/nbZzLeFs6oJ
 CydqJ4qibX9O+PkIjiAsff16n8GxPBLuVQNQ1fDnNvcNCkJMyCRMG9b3xKdgF88grvl7
 jPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779026034; x=1779630834;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ay6bnjdiJykakdEpJojMy3BsnRfLjHl5B+Mr2CQ/Omw=;
 b=qh3auQ5BdbuuMkTcFcBznQ/QNdpDsX35uhs1lPVroHB90CIzifIEqLVLXIKtFITjz6
 ytVcCX9L1sZ/voizhq7u1lTMMV9C/XBwgELgMnRELkV4XcBIftQy/5tiwRSTN+Sq29Yl
 BHTVJ4MseShV6OSOx0ceMTsL56gaAK7VsZiihz+2/5ToT2buImXHii+tVXw9WElvapCi
 SodGYtxB+ydenUpE2NVCbd+6n0fHUMYa+85r096OqDQRyoKHHpHh9/h86hq8/5TqqGGj
 VPydNTb4g0wJxLNQoT3NlYDcbJ4RspaBoRaL1xzvC5qY83H0afooJdWlDKqIyG9YJYaK
 YpSQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9N0sxcF9lhvhoIC62n6nPCw5Ww+z8U7T9Cw6dPWPE3a8iNNsMWMogkO3qqLnybm7VqwpEi9QOf@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxAe1UTz3yjU1x4eqS4i5KuyFuP0VVHcHJsy2ehBgGqEV1/z0IV
 jfnnCkKCHk+MdKBY8cj29x1f3deAH4vBNJ4EIJCfgul8pU3WlKhSC7MR
X-Gm-Gg: Acq92OHhqVD4aZohDAaAzzJYjpD0EpkErHApPQr2g/6/J1101TgtSc86P23qAlGf/wz
 Ae6mbfZhpV6RLRQywo0oVWrBvLeLg2mQ8fb6SZGiq6bjNRBkpRe4mrixdFq02+CWeXm0xUAlD8D
 o2eS+WLhWd8WjFc+aEqjxClO91T//9tjiGSUdkacOmrpdt4yK9T4S4PzYOGcY0Y7GB22x7Iuc5K
 RQiu1qBzvB7DXv+zIt3Hp+YaU+JAG+IVK5ea4AQvZSjEO0iwryOYRSuuI1O4twJUUUm1EwL8POp
 WhLXlMizm62b8feTOiHZnY99+JndY9Edxhsljb1eKgjUG+5Rrcm52s+9b3NwmqzqyCwK3GergRz
 LLNapuIyCPZEyGkfDcP/NIrl0Bj23u7WdWwaeXQJBFZUuaONHVLTtD294dKLy6hOEDGEl+8HLG3
 mrGVeI/hHFTJZvYEYVwE/05/Nf6Mg/rjOCR+IORiNVT14Hqsysg7R7i9EmG5WpqAxUTnWenmXmh
 /Q7PeSPg0+7dw1E
X-Received: by 2002:a05:600c:8189:b0:488:ac01:72b6 with SMTP id
 5b1f17b1804b1-48fe6323addmr174059765e9.21.1779026033650; 
 Sun, 17 May 2026 06:53:53 -0700 (PDT)
Received: from ?IPV6:2a06:4944:10fb:f400:509b:3e86:dfb4:f404?
 ([2a06:4944:10fb:f400:509b:3e86:dfb4:f404])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-48febf8305dsm81575455e9.9.2026.05.17.06.53.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 06:53:53 -0700 (PDT)
Message-ID: <d5262f65-22b5-4ff3-b905-12bb2a4b587d@gmail.com>
Date: Sun, 17 May 2026 15:53:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/radeon: fix internal display on iMac11, 1
 (RV770/DCE3.1)
To: Lukas Wunner <lukas@wunner.de>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260510185426.4264-1-gilles.risch@gmail.com>
 <20260516092420.3579-2-gilles.risch@gmail.com> <agiy9II5jkHEgPAq@wunner.de>
Content-Language: en-US
From: Gilles Risch <gilles.risch@gmail.com>
In-Reply-To: <agiy9II5jkHEgPAq@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Good afternoon Lukas,

thanks for the review.

The initial launch date can either be verified in the TeraScale 
architecture comparison table on Wikipedia [1] or directly in the kernel 
source at drivers/gpu/drm/radeon/radeon_family.h where CHIP_RV770 (line 
74) precedes CHIP_RV730 (line 75).

The test robot mentions that it cannot find ASIC_IS_DCE31(); this is 
because both patches build on one another. Should I submit both patches 
as a series?

Kind regards,
Gilles

On 16.05.26 20:09, Lukas Wunner wrote:
> On Sat, May 16, 2026 at 11:24:21AM +0200, Gilles Risch wrote:
>> The Apple iMac11,1 (late 2009) has an integrated ATI Mobility Radeon
>> HD 4850 (RV770/M98L) with a 2560x1440 internal panel connected via an
>> internal DisplayPort path. This machine suffers from a similar problem
>> as the iMac10,1 (late 2009) and the iMac11,2 (mid 2010). Without this
>> fix the display stays dark under KMS. Two issues are addressed:
>>
>> 1. The RV770 implements DCE3.1 and not DCE3.2. ASIC_IS_DCE32() starts at
>>     CHIP_RV730 which is newer than RV770, so the RV770 never matched the
>>     DCE3.2 PLL and encoder logic. Introduce ASIC_IS_DCE31() starting at
>>     CHIP_RV770 to fix this.
>>
>> 2. Apple routed the internal display through Link B of the DIG encoder
>>     instead of Link A, as observed in the kernel display connector log.
>>     The same quirk already exists for iMac10,1 and iMac11,2 - iMac11,1
>>     was simply missing from the list.
> Not an expert in the radeon driver or AMD chip revisions, but if it
> helps improve support for older Macs I'll be happy to offer my:
>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
>
> It's not immediately obvious that CHIP_RV770 precedes CHIP_RV730
> in the enum and that hence ASIC_IS_DCE31() subsumes ASIC_IS_DCE32().
>
> Thanks,
>
> Lukas


