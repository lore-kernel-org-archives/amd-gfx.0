Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAC5C7EE30
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 15:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5988110E2CD;
	Tue,  1 Jul 2025 15:26:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kKzTnhrq";
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1B8210E2CD
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 15:26:02 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6070293103cso5981127a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Jul 2025 08:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751383561; x=1751988361; darn=lists.freedesktop.org;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=sDNq/xk9SROyoh/dJoggHUO1ih9f+1C9S881i83f7ss=;
 b=kKzTnhrq4KlqTKU8sIk6SXB95dRy/s1Wnd2G8uAOhGAlXSFef5oxWZzJL2u/uqSN8C
 vYr9ZP1lMKpsDJ6j37Ykf24LCBJKsHtrdgIRa07OrWIhZ2GmxVxQrxR8zQGnfBTm/vPH
 /4xNB2tyTqDJ/6Voous7f6z0C1TRoohWUCXjmkCsvXHVh9SOpIUNNzJwH7Sgn/KB/LzN
 wHF07Wrsm3uQWIROGl4mRIjz3HApcQOcna5tpdjERYpJtCCMp7faLmdlGxLCUJt6CYio
 SMOqqNk0e/c4/IcMWChH4QAvp9wLidhhqyQcLT+PIrHwkSm3k/YjfGtCskEEMf3kTT7A
 6FPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751383561; x=1751988361;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=sDNq/xk9SROyoh/dJoggHUO1ih9f+1C9S881i83f7ss=;
 b=I2688Refmft1G2vIoIMQx2AOU3iA+EgllirLsxp5TWR9oGGKw+M3chioyN7C2gLVh5
 JvIyEA1l2QwB7KlqCrYlYmeDsDXEmd9V69UNS7kszbOjiUw23FRpuOC6Q8t+9tDtOPNq
 wo0nGMv0IF7vrSn7umNfCf1+sdIqdeZUeTbn1v73DTC/Nl9oAh/0DA+bOHyKlLHdWc05
 0jlSJLYvqwnBSvDXOyg8kbjg69jI4I2uujJJLUSzqXKGoZXxkWlqydDsDs6jyZUe6/uL
 67wtLZl3cOrSIM75FiFkAuHbGUWwSk/qvhUkkuDkQy+vlyO8cKuQkRBc1COKc64kwiCg
 ZI/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0yiV4jezZAhhGJGNCo07NE9sjZWqHRxUqefTKLbEOkbPtTscsRBz7OmJOyaQofw7fQiDXVHq6@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx1iGBWCH3sJjvoRzMWvyeqSIdZxqAbAxv55AmV7TVLBtZfOAeh
 IH+klQa/Afh291n4tQkN1lSZuPT+J3fvSXR4/dOUM+OikD+wOPj5L0+x
X-Gm-Gg: ASbGnct7QmONK7P2cEDHj/mLfsKLlMNV8ptek+uaC1NFyEQXtLvvmtkaG87mVF4xzeZ
 ytrnJ2Gu0yjiBhqEVOL39+F6iIrwTrOLnCG8uZPJYo9A1JbBg3MVX/60lG702UaeiIeAOUtQFBA
 /lapmj3Jvk5H0E3Qpo8EoiYu0yVzq9bfxY+3ygnEllY7nwK+FZ4SKmkd6lO+uPvoalP2r0iLhe4
 Y33lM6dWln8J05Ynz7lMFxlYzk6SDqZy1Q9t34/S9ZK0gEi865wdcurPYiN+s++OS/yRjTZcoDU
 d/GtLt1X8vp3FV2DBGCknTV4B03Zzh9FV9W2m73/qvLCmfIkxGTwACJf/owkZasvTAw7OK+fMPP
 XwZRxEc8bCeDLlvRGpGWcRg==
X-Google-Smtp-Source: AGHT+IEM/kp+TDy55NAUJAi7REggIxaW15vzcMatu3Dbx5UeM3ODAVFHFJ78o+S3tmMehezNuFd8Yw==
X-Received: by 2002:a17:907:1c27:b0:ae3:7b53:31bd with SMTP id
 a640c23a62f3a-ae37b53e38fmr1135197966b.28.1751383560582; 
 Tue, 01 Jul 2025 08:26:00 -0700 (PDT)
Received: from [192.168.1.3] (c156-158.icpnet.pl. [85.221.156.158])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae35363b24fsm889779866b.34.2025.07.01.08.26.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 08:26:00 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------EozGWur7o48JmMVNlynHCWMz"
Message-ID: <df174d51-e008-425a-b952-b3fdd12faf36@gmail.com>
Date: Tue, 1 Jul 2025 17:25:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V12 00/33] Reset improvements
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, sasundar@amd.com
References: <20250627034002.5590-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>
In-Reply-To: <20250627034002.5590-1-alexander.deucher@amd.com>
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

This is a multi-part message in MIME format.
--------------EozGWur7o48JmMVNlynHCWMz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Alex, I'm having trouble applying this patchset for testing. 
Applying the first patch errors in 
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:9579 I tried changing the base to 
commit: (6.14) 38fec10eb60d687e30c8c6b5420d86e8149f7557 since it's what 
git merge-base gives me between Linus's master and your kq_resets 
branch, but no good. Would you please rebase your changes onto whichever 
Linus's version tag you see as appropriate? Thanks, Chris

--------------EozGWur7o48JmMVNlynHCWMz
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><span style="white-space: pre-wrap">Hello Alex,

I'm having trouble applying this patchset for testing.

Applying the first patch errors in
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:9579

I tried changing the base to commit: (6.14) 38fec10eb60d687e30c8c6b5420d86e8149f7557
since it's what git merge-base gives me between Linus's master and your
kq_resets branch, but no good.

Would you please rebase your changes onto whichever Linus's version tag you see as appropriate?

Thanks,
Chris</span></p>
  </body>
</html>

--------------EozGWur7o48JmMVNlynHCWMz--
