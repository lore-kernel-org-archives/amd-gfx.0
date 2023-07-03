Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D59EB64DD
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jul 2023 09:28:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FA0210E1E9;
	Mon,  3 Jul 2023 09:28:42 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2438010E1E9
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jul 2023 09:28:40 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fbc0981756so39377595e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Jul 2023 02:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688376518; x=1690968518;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r0zi7jujsmpYb8l5KEe2tFlRYKR7zyiW/q6w2B1Js8g=;
 b=cu51hTkh3HFUVlRYLGuo5/sfb5K6bwTEiWyiPsa/cGDx5de38bVtEHJtPF2uXgojmQ
 rXmGpzdcKPvPbtdwbrA0B2wU5YMRULXzdG9WeIfUsgY+T1whKmRKm0zxySW9TTWjv/sC
 JLKyPCuVl7EVYTtH+Zl4RotuEz/4rX/6dRd8NL/5oMNI/eBpIzLQjv2nkzlFy4Pa4r14
 iZPGw4NGyPgolvE1L09bx0BlrBLfFfOw3Z0G5jCM3tW2byUTNEbigPpbDpY3sx97MFPR
 8WhU5XT7mAMzzBmzmkquISOVb2ACbVe8hGteycGc0fPWFFhFOWQQwM3yEsp0tnEY6gzl
 UnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688376518; x=1690968518;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r0zi7jujsmpYb8l5KEe2tFlRYKR7zyiW/q6w2B1Js8g=;
 b=lsBbcIFIb6tpaK5pEa4BjM33HChWqxVGdYIlv8JFWPm8Ljq1zys2JJC30XHlBg/W2r
 Z8HWZU/wdcEGxlgVZ5ZNbipDsxj/J+0Mk+PJ8UXlnDhXwxG18s1wNER3KcOxm/fpciKE
 oGZoIbHwQLhsI/zYQ0S52QLp5LQ9O/tLIN+36yjaoPmWNmzLnRUBOjq1DiIrYQNWHkaJ
 52m2WgXeVsdplTUmKeG+WQ+tRbt1QZFGi2juBBUuSYs6jT90xrvx6D6Xxno8JedOpiV4
 hBfQjtgFTY6460eYB2c8lY+cDqrHyQQCeI/TiFzZABYA6vHqlQ/g65koZRFvBx2lpIZ4
 SYmQ==
X-Gm-Message-State: AC+VfDyzEq1C9j6vDpFbxOhmDBhIxQVo7jk+ddMaocyYtYjiieAZgpU0
 qY1Ol4dB3myomU/LqNWDHXkfj8EbcPM=
X-Google-Smtp-Source: ACHHUZ6D2tBb6VgXgmetX00FXYU3Al0c9HA4CD4J4v8zABt2n/0Nt5FUorQ7T40NghQMWBsG3d3dlg==
X-Received: by 2002:a1c:7705:0:b0:3fa:8cd5:b64a with SMTP id
 t5-20020a1c7705000000b003fa8cd5b64amr7079335wmi.0.1688376517957; 
 Mon, 03 Jul 2023 02:28:37 -0700 (PDT)
Received: from ?IPV6:2a00:e180:15db:7000:52d4:e05:b365:ad25?
 ([2a00:e180:15db:7000:52d4:e05:b365:ad25])
 by smtp.gmail.com with ESMTPSA id
 c23-20020a05600c0ad700b003fbc9371193sm8306660wmr.13.2023.07.03.02.28.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 02:28:37 -0700 (PDT)
Message-ID: <97b4821b-a425-a376-503c-8a22212d323a@gmail.com>
Date: Mon, 3 Jul 2023 11:28:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/6] Clean up patches in amdgpu/gmc_*.c
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230630155603.3388617-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230630155603.3388617-1-srinivasan.shanmugam@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Christian König <christian.koenig@amd.com> for the entire series.

Am 30.06.23 um 17:55 schrieb Srinivasan Shanmugam:
> Srinivasan Shanmugam (6):
>    drm/amdgpu: Fix warnings in gmc_v10_0.c
>    drm/amdgpu: Fix warnings in gmc_v11_0.c
>    drm/amdgpu: Fix errors & warnings in gmc_ v6_0, v7_0.c
>    drm/amdgpu: Fix error & warnings in gmc_v8_0.c
>    drm/amdgpu: Remove else after return statement in
>      'gmc_v8_0_check_soft_reset'
>    drm/amdgpu: Fix error & warnings in gmc_v9_0.c
>
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 35 ++++-------
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 30 +++++----
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c  | 52 ++++++++--------
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c  | 53 ++++++++--------
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c  | 86 ++++++++++++--------------
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 37 +++++------
>   6 files changed, 132 insertions(+), 161 deletions(-)
>

