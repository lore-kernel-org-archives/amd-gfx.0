Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A36C27C75
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jun 2024 10:21:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FB7C10EA03;
	Thu, 13 Jun 2024 10:21:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RcqAsEPe";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D209D10EA03
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jun 2024 10:21:25 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-35f2266edd8so671842f8f.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jun 2024 03:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718274084; x=1718878884; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VhGA8tSx16/Pz9CHVyIKQjjrjm3Cen74sN6sW3leSAQ=;
 b=RcqAsEPeRshKvCS1FmxDML9N6hu+vWNGJjxtLkFBqo9g4YlbtYFNIQQszKCSOF4Sv6
 K5XEcCzVcE8N1gHQGlc42UW/AYSzCOCZpcgT/pt/t78hw9A9sPFGqsPq4hMd3Oftyo0O
 FN+O/JG2fjTREp+5uRqG1cPrVaVE6CNyImFTPc0tQAjgk7pm2LQbXjAp2nG07aMRMOz6
 jfEBTJgIoJ5WJDVvQgda23NImSnhoi4diE/uqq0UW2LE/VJRej49w8l2CH7EYogjOH7F
 d/5RPmQi0/dbKqxValPhC0Qrc5SK4Xsa2XQ2zse6e4RPeuPre1lvMuyJcgUNslPLco7r
 HpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718274084; x=1718878884;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VhGA8tSx16/Pz9CHVyIKQjjrjm3Cen74sN6sW3leSAQ=;
 b=t2g6YHZ0h1nlAhyB3BoelBF7lnCaC/TjWgfXxsV4TEm1cMUyVAxlBt6kHlFFeXyRo/
 fCBpYNgB1GSzJ02uvwfdRHFbvxf69I08TU2ywxI11n6Db1B0xW7PqdCrNpxOY6Cx2q7e
 duAGr65Qep5yeubxZ9qmEVvfU+cdbVks0E+P8iavNvgkjC+vXY/gEVfMlol7korlBobC
 jZ07Bv5CzJZF+YoBmlYD6NL2aptLvDSRVJXaMd6CkcFcNTNM1Dn1s0nj+Cxrx+K2vUt6
 qw4PdoSWbJW3tUQSYTLcr3A7nFGxPw2OpexyuamtxipUUEbW0TiCC+7UX1VRf4qRbCZI
 yPPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyoOHRH9hVm9SUPzcy8S8MMMA/FOok3yLTD+G7Vr2HAXdGGoVeD7kSzotHehAzuH4q37hDIaIvaXWDXEj+9QPX2Fqj4fhm1qkFquSvpg==
X-Gm-Message-State: AOJu0YwmhHeZWeyt1vvPoen9vt0tp05KwYk5+N9C14yxf3uWBzjnTy90
 Eya8r8tehAwNja4ELAOhEz5RMAxA9JqiOoMDY3qR4ymtrTACaLdzhPIVTg==
X-Google-Smtp-Source: AGHT+IHiQKMxYEQQz/b1mNH6YOAA1OMWkb4H31jznTfTl26C/Q1EViCx8Vx67N5OTZQUqTNO8NUcgA==
X-Received: by 2002:a5d:694c:0:b0:35f:d57:a698 with SMTP id
 ffacd0b85a97d-35fe88ca545mr3673061f8f.31.1718274083898; 
 Thu, 13 Jun 2024 03:21:23 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075104954sm1263809f8f.99.2024.06.13.03.21.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 03:21:23 -0700 (PDT)
Message-ID: <a60b1b4c-7acb-4380-880b-072b23010134@gmail.com>
Date: Thu, 13 Jun 2024 12:21:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] drm/amdgpu: add gpu reset check before page
 retirement thread runs
To: YiPeng Chai <YiPeng.Chai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Tao.Zhou1@amd.com, Candice.Li@amd.com,
 KevinYang.Wang@amd.com, Stanley.Yang@amd.com
References: <20240613022504.81787-1-YiPeng.Chai@amd.com>
 <20240613022504.81787-5-YiPeng.Chai@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240613022504.81787-5-YiPeng.Chai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



Am 13.06.24 um 04:25 schrieb YiPeng Chai:
> If gpu is recovering, clear all message reset flags
> in fifo and wait for gpu to complete recovery.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 341c9bd0d1a4..bf4f8d439ebe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2982,6 +2982,18 @@ static int amdgpu_ras_page_retirement_thread(void *param)
>   
>   		atomic_dec(&con->page_retirement_req_cnt);
>   
> +		reinit_completion(&con->gpu_reset_completion);
> +
> +		if (amdgpu_in_reset(adev) || atomic_read(&con->in_recovery)) {

It's illegal to call amdgpu_in_reset() from outside of the hw specific 
backends.

When you want to make the code mutual exclusive with GPU resets you need 
to grab the reset lock.

Regards,
Christian.

> +			uint32_t reset;
> +
> +			amdgpu_ras_clear_poison_fifo_msg_reset_flag(adev, &reset);
> +
> +			if (!wait_for_completion_timeout(&con->gpu_reset_completion,
> +				msecs_to_jiffies(MAX_GPU_RESET_COMPLETION_TIME)))
> +				dev_err(adev->dev, "Waiting for GPU to complete reset timeout!\n");
> +		}
> +
>   #ifdef HAVE_KFIFO_PUT_NON_POINTER
>   		if (!amdgpu_ras_get_poison_req(adev, &poison_msg))
>   			continue;

