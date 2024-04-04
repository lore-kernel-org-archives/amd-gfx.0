Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22258CD1292
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Apr 2024 12:19:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7075210E703;
	Thu,  4 Apr 2024 12:19:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eY7o2nWQ";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DB0E10E703
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Apr 2024 12:19:01 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4155819f710so6700635e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Apr 2024 05:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712233139; x=1712837939; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dv4Xn4Vjg/JRg8HjtEdPuYFR8hLkbT20nM0P57wSYQ4=;
 b=eY7o2nWQ48aoxeEv8bjbptYQDLQ8MqOSk8hejv0oOxGwdNh+iGgW7OAuuhcgnG9Ata
 uPhorH/YtLZh57GIIACPyDZn/yAQVzfKdzM8jafbG70KkWQAEddF6XzUtaf94J5Cap4E
 6CTMVHWEa+gkacsNksYAfA7/yBvecv6PcszNUy2IDhDbfkEoKFhvEfplZZ2rLrV7LcmH
 jKltziIi/2qiZP8OKWtxKCQjl/qCIKkc5Y7nA4NsVxuxXAJzs+npgr/tFDeMYWlLQL/t
 M2LJrrKQJEmrh7AWeD6sGjc42a0H0M/qdvDXoAL02e74SlnwtKL9s4nYtp/9wdt1t90O
 J1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712233139; x=1712837939;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dv4Xn4Vjg/JRg8HjtEdPuYFR8hLkbT20nM0P57wSYQ4=;
 b=w3lymnJhts7pEpFNo4tVeOJJFpS6KkacYPG63m/5ZtUMEtecUBAaDUgCAyfcdtJi7d
 z/VI6yPTDnrHU9RiMgbj/0Rb3yb6h6FEgzMzEjIgF0EwswzxVi2ZCZd/CLN+4NaCVAN4
 /Zp2KbqJhn3OIKgZN/EAHhjLrHSudm4vpzOs5waeDws1UbSbbNACBu8BTcT/Jtlsu/ZM
 vv4j7NDPChgMv/GpFoHfupJec549OTuQKslxZZJo0cgTuUwVmIjynm50koTtNO9lp6Vl
 AbHfzKEIVuwIaFpA4OkxU526cGzN+5v3f8ECWuoL1RvKg2gSHznCzaDRFjAuZq/HXL1H
 hN6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEufEwiT2xoeRFN8IiyrjaG2cmDT+eicOIeMZkJzXDA7ZaTca2D/2V450vuXI6Z7qzQo7KtkWBE4cYeJLQN/m28ES2FyRJxUjnNsmj0Q==
X-Gm-Message-State: AOJu0YxShrVD8MtckW5U6keeYLfLHX5jPKZ78YrItLXnpnXAb67INS5K
 4swcSeRXBFzdSscqEPUZHifvoDCKznAoXaw8rachAurvktngB9522tKlF4sxAFc=
X-Google-Smtp-Source: AGHT+IFfjqE8fCIQM0gxJgkcPu9adLJuyWLVz+sRAQAmM10k/8DxfaP4yO/e9ptYNJS8lOOXG6YFcQ==
X-Received: by 2002:a05:600c:4188:b0:414:726:87d9 with SMTP id
 p8-20020a05600c418800b00414072687d9mr2067650wmh.12.1712233139451; 
 Thu, 04 Apr 2024 05:18:59 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 fc7-20020a05600c524700b004156b689edfsm2540040wmb.33.2024.04.04.05.18.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Apr 2024 05:18:59 -0700 (PDT)
Message-ID: <971bc7db-dec4-420c-bcf8-3c2bd8287d1f@gmail.com>
Date: Thu, 4 Apr 2024 14:18:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/radeon: silence UBSAN warning
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240323213901.2638700-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240323213901.2638700-1-alexander.deucher@amd.com>
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

Am 23.03.24 um 22:39 schrieb Alex Deucher:
> Convert a variable sized array from [1] to [].
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/radeon/pptable.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/pptable.h b/drivers/gpu/drm/radeon/pptable.h
> index 94947229888b..a7f9553b648b 100644
> --- a/drivers/gpu/drm/radeon/pptable.h
> +++ b/drivers/gpu/drm/radeon/pptable.h
> @@ -432,7 +432,7 @@ typedef struct _ATOM_PPLIB_STATE_V2
>         /**
>         * Driver will read the first ucNumDPMLevels in this array
>         */
> -      UCHAR clockInfoIndex[1];
> +      UCHAR clockInfoIndex[];
>   } ATOM_PPLIB_STATE_V2;
>   
>   typedef struct _StateArray{

