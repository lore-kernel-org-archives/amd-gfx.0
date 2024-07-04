Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A365C30653
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jul 2024 07:48:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ADFA10EA0A;
	Thu,  4 Jul 2024 07:48:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P7K9JOdQ";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 868B610EA0A
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jul 2024 07:48:29 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-36799a67d9cso328919f8f.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Jul 2024 00:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720079308; x=1720684108; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B7X/8r4zB78rlv5cBW5ixsM88qB8sSPZyN5x8G0Ut2k=;
 b=P7K9JOdQ4EwqmMSOojSYKXRiaVOcqAg90Wh69R8UqP72pnBk6uSVYYvOj+l7MH+OPk
 mB+vhbrT8Aj4Zce2keAg3yMABxmv9BGfqxLqwXC6G88s4Jm0MXdqtgoUpdv5b3XQiDt0
 Ir3+A+PC8k8QCBUzt5f7iaV/Dcdoq9WorGOpv1sTcFEw30H0WNuIM9f2mZ3fnoB7exCe
 MZtPIhqY+qeSW7s9I7k/mLf0OSZsZfbookmr8FLoZrJGSLgulkBmhng2a/GHyH79NCo2
 e8S31t+KLt/wpWUai172UYYXDBzcv6ZS6IFwwp6Uu3u+2F7DGHTuAlpqr50STo6QuBYh
 0BkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720079308; x=1720684108;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B7X/8r4zB78rlv5cBW5ixsM88qB8sSPZyN5x8G0Ut2k=;
 b=SkuGEnq42lmmx1ktIGwcY/lN+qgoK9wqrnRoE3Tnix4rGTrtuorgtYiVMcqw8Mt4ia
 REm/MLMmQJsam9FJxQsoMXdeuCRBWZ4xh/Q+4l9Gei6fiCjn0jec1oj2RfqCnwLCuZBA
 yDai5+gzMIyGYVSfJkE+YGUD7xYDLm1lWjSJjRhqM7hnkkJSJiIknDrkiRj2r33PV245
 tG2wyOZcrT44q7HXCFiOYFf7qt1IYjk/ule7+BD9ZIyR7wtqrApB1oa+V09biqg7BhWp
 9oclZFyFrXnuG1CuYr0PRJhbA/v4VIW7uuibY8QHMn9K/8Zs4ZELUsgTKtW0XPLEgnEi
 69dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVVko5RXh0NRXNqqMzfTWy0r+an0KKoQrDAKx1mVBsRRWDDIh3c8vht2pF7Qu2R+/jt4mz1Fx2I7vIb2ekzetdC0SSFjLpQCY9ITdp3A==
X-Gm-Message-State: AOJu0YwvIAP6IeYu6PHeR8lft7U3FDMHdsRreaI4x6Moob0WyKuToJtE
 +uXnMzx9cR/yZ16Gx4b8V59pmDbY5BwALYnNqUCH6WNys8nR/IF1
X-Google-Smtp-Source: AGHT+IF8xRy+eGSmFxbzW7EldA00Jto8QF8G21G/sYE6mp9mAVRMmLfktzmLc1W3EhZ4xsIqmLtmMQ==
X-Received: by 2002:a5d:4a45:0:b0:367:9114:4693 with SMTP id
 ffacd0b85a97d-3679dd31348mr730207f8f.31.1720079307431; 
 Thu, 04 Jul 2024 00:48:27 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36798a2bb09sm1855377f8f.55.2024.07.04.00.48.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 00:48:27 -0700 (PDT)
Message-ID: <ba1aa6ee-e0f1-472a-ac9b-c4a74216a16c@gmail.com>
Date: Thu, 4 Jul 2024 09:48:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] MAINTAINERS: update powerplay and swsmu
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kenneth Feng <kenneth.feng@amd.com>
References: <20240703193611.2002463-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240703193611.2002463-1-alexander.deucher@amd.com>
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

Am 03.07.24 um 21:36 schrieb Alex Deucher:
> Evan is no longer maintaining powerplay and swsmu.
> Add Kenneth Feng as his replacement.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Kenneth Feng <kenneth.feng@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 082483b40fac..3b7aac333d8e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1092,7 +1092,7 @@ F:	Documentation/ABI/testing/sysfs-amd-pmf
>   F:	drivers/platform/x86/amd/pmf/
>   
>   AMD POWERPLAY AND SWSMU
> -M:	Evan Quan <evan.quan@amd.com>
> +M:	Kenneth Feng <kenneth.feng@amd.com>
>   L:	amd-gfx@lists.freedesktop.org
>   S:	Supported
>   T:	git https://gitlab.freedesktop.org/agd5f/linux.git

