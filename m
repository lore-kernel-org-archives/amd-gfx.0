Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14ACBD59D99
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 10:17:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFE0810E1DE;
	Mon, 15 Dec 2025 10:17:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N80/wuvT";
	dkim-atps=neutral
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3726010E1DE
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 10:17:00 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-8b2148ca40eso482874585a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 02:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765793819; x=1766398619; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2Y/WOqyJ5LSKSoY9YadKQdhw288Q2WSk5PQ1H5e4WoQ=;
 b=N80/wuvTy6xyw3kWsIUAyBfhwscaH2aBOfK9dLC6iYRlYnsE3QaFmLVtyDs809j7WQ
 Yz52BPkZYIzta93udpqaFw/W9DJUr0CnSS2epk3bVNphm2bnOa/mFDKeHvxOp7D30L+Z
 dvnVBBBVpZEQdgu17HoFmWMJrbOv3EssBUjY54BYrggyhqPwEjTggDMtNsrHJ9NUmEYE
 7CeQ8GKiwvWDnxB95tgFeo4vhv8gt1kZv1c16eQ+y08Y9nRXT20dVE31TgtuYaCvhQH5
 9Lfw5JoH/ZkHl7p8gtscmZwgxC2nEJDpQIkrYjxt5JEEHofYXtrHSThFflyLTC+Dy85H
 SSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765793819; x=1766398619;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2Y/WOqyJ5LSKSoY9YadKQdhw288Q2WSk5PQ1H5e4WoQ=;
 b=jGchUrPhHzSOcomdYRXWe55Kcmr4skoQk5B7UXvFKYLTVJGqAMu/oBzeOrh70Nvnhh
 TYkkMAxx5oHcZIe0seu5btmwP4G1GqAtPAjSfCTPtsBWEna3+hCaMV/06ahHeXYoIcLm
 LuMOC+issEOoqbwoA8Y8H3FfRzLch2nL1hs2Uwj91gdm+twGZxSf3p4IEFyxLeaRQpH5
 5/1DD0OIiPSV2o/9LT+J84SVPvXInFklBaOgQhcy6d8yvRAMJH1iTtfsq5hfvaO3ho5W
 vMTlpwPCxFQGxVGqebGvqigXJ0YihZ7V4MxMiCzR+KOqoLbYuLNdiFTFzgqlyx3Sdgis
 DXKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMEpClcfTNSZiUwJfQZpXCNNsB3adMwPP7w7Kkq4yKGjYW3q41b6YomVcZuX2rCFPNa7bfCz07@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy7uKGrayMnGL6nyZRrtLIDV8N/OEzSQeiC0U4NsVEs3upo8CE2
 FrdHphXDt6i91aOtKXijlt9ENkVQQShu+LzTnG1ikFYL6XGVnz10Dxku
X-Gm-Gg: AY/fxX7hOTMB3xJp/z7hy/tfgSw1jQ9KuxaLWDWT9j+NXwbTndI3dvpl+sfNv34Xtr/
 bmiXTTFf0Y+OCYqW+2RgkLTpv2c3VtveN26rfi4XehQo4QxpBtC1G4ntR00/jyCtTo1aiTPLKD6
 aqqJ0o7lABRuDP65QAp40mVGr7hBG7+vPGbo166K2R3Kq87b116V8rxOT+wA6jrlaOrlV8/esOV
 y6aIhyggzRTIKu/g8op8fSiqgamSQf7zIEArFbVSFeYiPmRwY/4S6R9Gjyrhpy2LBIxHSuvK8eD
 OtS6Bk5oLV1Kn9YwDIFdmeMKr3RzKoYjzUYN8ayMI22VLkeSh+6miG2cllyNhu2OxI5gpkCZAJJ
 1DnLY8CcwaCR991I2fnAWylALnqoFiwamfUSHEmemYmdzCrrSh+ciP5vcLyr+mAxqFvOskba4A/
 2ww6I8HSd3hhiT9vEkUyuT11eeoTaUNz9ikPm4wTu1YAY=
X-Google-Smtp-Source: AGHT+IHymAbflQReVkucBGke/VlIR5PuLTF4YTxq7cUPSKC7dACXXXLKwX3gSrLCFC3URGPFXsEBug==
X-Received: by 2002:a05:620a:4510:b0:8b2:f308:d2ea with SMTP id
 af79cd13be357-8bb399d8f80mr1252328185a.2.1765793819134; 
 Mon, 15 Dec 2025 02:16:59 -0800 (PST)
Received: from [10.254.120.133] (mkmvpn.amd.com. [165.204.54.211])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8bab5c3bd62sm1083397385a.35.2025.12.15.02.16.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Dec 2025 02:16:58 -0800 (PST)
Message-ID: <29354cd3-fd51-483c-96bb-6e1994fb50b7@gmail.com>
Date: Mon, 15 Dec 2025 11:16:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] drm/amd/display: Ignore Coverity false positive
To: IVAN.LIPSKI@amd.com, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>,
 Taimur Hassan <Syed.Hassan@amd.com>
References: <20251112182212.559007-3-IVAN.LIPSKI@amd.com>
 <20251112182212.559007-16-IVAN.LIPSKI@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20251112182212.559007-16-IVAN.LIPSKI@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 11/12/25 19:20, IVAN.LIPSKI@amd.com wrote:
> From: Taimur Hassan <Syed.Hassan@amd.com>
> 
> [Why&How]
> Ignore Coverity false positive analysis in the dmub_cmd.h
> 
> Reviewed-by: Leo Li <sunpeng.li@amd.com>
> Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
> Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> index 815b4ec82c11..173bc2bdf50f 100644
> --- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> +++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> @@ -2647,6 +2647,7 @@ struct dmub_cmd_fams2_global_config {
>  
>  union dmub_cmd_fams2_config {
>  	struct dmub_cmd_fams2_global_config global;
> +// coverity[cert_dcl37_c_violation:FALSE]  errno.h, stddef.h, stdint.h not included in atombios.h

Absolutely clear NAK to that. Please see the kernel coding style rules.

In general I don't think we should clutter the source code with such stuff.

Regards,
Christian

>  	struct dmub_fams2_stream_static_state stream; //v0
>  	union {
>  		struct dmub_fams2_cmd_stream_static_base_state base;

