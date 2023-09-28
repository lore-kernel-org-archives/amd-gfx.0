Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3B3E732C8
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Sep 2023 13:20:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4B0B10E127;
	Thu, 28 Sep 2023 13:20:12 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A43C510E5D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 07:05:46 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-405621baba7so98024335e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 00:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695884745; x=1696489545; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7idhm3Ef5vKd+Hb5yMnzQgjmcruc9Jiv92Poys9iQLQ=;
 b=G5o1Uxb31tz9g4JdPaA/tVHXI6nJ5NwnNz30jSZuG1XsSoZ8BJ15vd53C9fnRgveNS
 Mdvz/g3c+MP+Yre4ETAX+c56EN8I4JGli0l4qJWOOVUzF8SivbQE8Ohljv9ygww5k0kU
 MulT+BScMnO2fB721+XRo0vMzCJTA0RpEt9nWOlHRYV5jR3OxAwlDPpKA06hkTHB9Esp
 zHmp/f+Uu9/jEcBMD2Q4p+bPuXNajyXdV3TInrSNEsFWfVS0vJdZabeNp4sZfJCXK1jx
 BK8wdWfN9+mSEpesedODUlIG9xwKJiwE1HdsxgzpAt+Knv+h76U3c4sGfNQYOpJuvga9
 ly8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695884745; x=1696489545;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7idhm3Ef5vKd+Hb5yMnzQgjmcruc9Jiv92Poys9iQLQ=;
 b=wqbhe3H41O9bIMdYitNYVNof+RjMFo1eu2s7P0hKxmOcUkDDk4Inl5zI4yLtsLM/pD
 IEWGEKo0uonzEoMPAVwh64ZqPMqs93zeqqYyuIc5+/ZrrdgfdUqVvijPHqUUlvNh0ERZ
 HwymIoPR3OZtYLs4FmJZBbp8823WT6wIcNTsO8eZqUCXEj+77Ey9vLRB5Lch8/d1iCeV
 K0xNiym38WF31IKlOwlCH+BfHYwn0sanNUjQX03hNzCbjDstE1MLOlnHNRCORIOHLRTx
 zeGcCukcdEuWSZEyjYJO0Fs4YkEfA4+yWi9ZL8Xf1BizBHdMFJGxHOmrLKP9Zwmoj/aG
 HrOA==
X-Gm-Message-State: AOJu0YwUiW6rRPQM4ld0geXJihyOYaKq/t1F8UL+XLv2E6CcFbr+eZYq
 HcDTLPXL7NKVeTMLH72STTLZRJd/chDPI7AaZMc=
X-Google-Smtp-Source: AGHT+IFJj2iMpr42gFO5lHyxcMnnbM6UXm+0XgpZOWOUL4o0GiswCVdY2cpcQ7s+GCB9TROd2PEj3A==
X-Received: by 2002:a05:600c:229a:b0:405:3a3b:2a9e with SMTP id
 26-20020a05600c229a00b004053a3b2a9emr413635wmf.9.1695884745040; 
 Thu, 28 Sep 2023 00:05:45 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 x17-20020a5d6b51000000b0031980294e9fsm18747250wrw.116.2023.09.28.00.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Sep 2023 00:05:44 -0700 (PDT)
Date: Thu, 28 Sep 2023 10:05:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: hamza.mahfooz@amd.com
Subject: [bug report] drm/amd/display: switch DC over to the new DRM logging
 macros
Message-ID: <c0e7d55a-26e4-4870-8fdc-28575238b387@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 28 Sep 2023 13:20:11 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Hamza Mahfooz,

The patch 5d72e247e58c: "drm/amd/display: switch DC over to the new
DRM logging macros" from Sep 20, 2023 (linux-next), leads to the
following Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c:542 dm_helpers_dp_read_dpcd()
	error: we previously assumed 'aconnector' could be null (see line 541)

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c
    531 bool dm_helpers_dp_read_dpcd(
    532                 struct dc_context *ctx,
    533                 const struct dc_link *link,
    534                 uint32_t address,
    535                 uint8_t *data,
    536                 uint32_t size)
    537 {
    538 
    539         struct amdgpu_dm_connector *aconnector = link->priv;
    540 
    541         if (!aconnector) {
                     ^^^^^^^^^^
Check for NULL

--> 542                 drm_dbg_dp(aconnector->base.dev,
                                   ^^^^^^^^^^^^^^^^^^^^
NULL dereference.

    543                            "Failed to find connector for link!\n");
    544                 return false;
    545         }
    546 
    547         return drm_dp_dpcd_read(&aconnector->dm_dp_aux.aux, address, data,
    548                                 size) == size;
    549 }

regards,
dan carpenter
