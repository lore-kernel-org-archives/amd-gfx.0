Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81848C04FDF
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Aug 2023 08:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 592FA10E1C8;
	Sat, 12 Aug 2023 08:23:17 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B579810E1C8
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Aug 2023 08:23:14 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5230df1ce4fso3513146a12.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Aug 2023 01:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691828593; x=1692433393;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4jEiR5PtZsvsQ9QxU0hWagaUEzyTpFBhCpdo9R5zh68=;
 b=QTqveUvMbL5xLmH+5XTVIv5cy1TmNcVspuAu/6FlMejCCwga2KlZLGp6osLAupBLzG
 w8CkaG6v832Yjzn2AqGhnNScGwnCcUQOkI2cOk6MCSuB0WvHvB/lowYnIJX4TXHN5L1U
 n4mc4vhy2F2xCvFXiireI5MpMOxkTVSUd/t2/D5GkT79R2Z1G2pahmXCfDorRybzCHEy
 x6uFMCW0fqmaCTdYlS/AV+94/1zuhze+XbrAkEbYiU1TCa34ib6ueXOYAAV6fhR5FvQQ
 nPGr3j71VjO/lVYsx/0znr0E0eq0N23bdgMaaKRRDKkG01TBF0YhTNlXgMLvejwQbejx
 vUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691828593; x=1692433393;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4jEiR5PtZsvsQ9QxU0hWagaUEzyTpFBhCpdo9R5zh68=;
 b=BiLRMWHXpHglPTT61AjnklHWCVzBWqnvfEu1NG2MYpDivS/FPbkZIdlMb99ZH4Coog
 5LblOG3LecCGAW/n2ldD/cJ+PPToK8OW7AJE2mIlUATQb7GPRbbilGNtCZPVrgPm8ZI9
 SFYSe/d5oTmC2Gj8SZIT39QMSYBqGuxheIW8Er0LBvmA4t1JYNk5jRybZiK4S4UTacpw
 u5YaBSgeGYYpMdOhnXFQOjJKEIGzV4IqM4U0NI7CsZbVq3xpoT8iSNuez6lPX/vHEBDu
 Fnym+dClcW3TY/l+/4G0VV08qKBuanKybL3AmV5o/I50xaPBFtscwjB4TzLGbdy0ub/s
 zVjA==
X-Gm-Message-State: AOJu0YwpvBP+imPdyEwmC0v0hG7x0HgbYJNSwMrTuB0XZ0nxWbM078j2
 vesgYsocyAl70pi+3kKuhKA=
X-Google-Smtp-Source: AGHT+IHjdeHbOhuzStdYrAK+c2cataNPyhXp2u4IwkAcSJEnHAMVmJGA7AOombVNyZ5+o+Y7pQXkbw==
X-Received: by 2002:a17:906:7491:b0:992:c8d7:b66f with SMTP id
 e17-20020a170906749100b00992c8d7b66fmr3567651ejl.75.1691828592902; 
 Sat, 12 Aug 2023 01:23:12 -0700 (PDT)
Received: from ?IPV6:2a00:e180:15c8:4900:545c:98e9:36c5:6d84?
 ([2a00:e180:15c8:4900:545c:98e9:36c5:6d84])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a170906244a00b00992d70f8078sm3168082ejb.106.2023.08.12.01.23.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Aug 2023 01:23:12 -0700 (PDT)
Message-ID: <f01ee061-ba70-ce2b-e52e-79ba273234c2@gmail.com>
Date: Sat, 12 Aug 2023 10:23:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/5] Add work pool to reset domain
Content-Language: en-US
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230811060234.663789-1-lijo.lazar@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230811060234.663789-1-lijo.lazar@amd.com>
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
Cc: Alexander.Deucher@amd.com, Asad.Kamal@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 11.08.23 um 08:02 schrieb Lijo Lazar:
> Presently, there are multiple clients of reset like RAS, job timeout, KFD hang
> detection and debug method. Instead of each client maintaining a work item,
> reset work pool is moved to reset domain. When a client makes a recovery request,
> a work item is allocated by the reset domain and queued for execution. For the
> case of job timeout, each ring has its own TDR queue to which tdr work is
> scheduled. From there, it's further queued to a reset domain based on the device
> configuration.
>
> This allows flexibility to have multiple reset domains. For example, when
> there are partitions, each partition can maintain its own reset domain and a job
> timeout on one partition doesn't affect jobs on the other partition (when the
> jobs don't have any interdependency). The reset logic will select the
> appropriate reset domain based on the current device configuration.

Well completely NAK to that design.

We intentionally added the workqueue to serialize *all* reset work and I 
absolutely don't see any reason to change that.

Regards,
Christian.

>
> Lijo Lazar (5):
>    drm/amdgpu: Add work pool to reset domain
>    drm/amdgpu: Move to reset_schedule_work
>    drm/amdgpu: Set flags to cancel all pending resets
>    drm/amdgpu: Add API to queue and do reset work
>    drm/amdgpu: Add TDR queue for ring
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   2 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  32 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |   1 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  24 +---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  |  40 +++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  16 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    |  71 ++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 122 ++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  |  32 +++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |   5 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |   1 -
>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  38 +++----
>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  44 ++++----
>   drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      |  33 +++---
>   15 files changed, 285 insertions(+), 177 deletions(-)
>

