Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB174C7114A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 16:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF03A10EA28;
	Fri, 13 Jun 2025 16:05:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="d84t17wQ";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4CE310E29B
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jun 2025 21:31:13 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-23633a6ac50so19945255ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jun 2025 14:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1749763873; x=1750368673;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:from:to:cc:subject:date:message-id
 :reply-to; bh=kAiNH9B1y5rWcHog71i4hUznzWj+jJc4yS7lpSm9QgM=;
 b=d84t17wQUce23BG90h16kh9ux61+9XDB0ZAYgSQ0I2FlkJWoUNPlnfHPjeWbA205Ku
 Vt0qsAgb9rfaatt9WxWYRVmOILRabGD0xvkB7ik5hLyyqCMCyUKpGXKMgd+TEnVqIhyg
 6uCFwSB1H0NkgkbpobfYimSsubSEn7pQqb3yZT59DJ0kDvl2LD7++Kd2LWi00vu2u6CM
 U6SmnbMyHvAmy5eOImLLyzvykw5gYi9PjeQsiKe9FdNqwVFDQM5cJmGu3NEa0e+9iwZi
 Y0BVxKbkM+OR4ztcBmOgXtGe0eyBN3MlvcWguNezHVCZWslgY9+mDc6dqjvNkL3B6jMg
 NfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749763873; x=1750368673;
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kAiNH9B1y5rWcHog71i4hUznzWj+jJc4yS7lpSm9QgM=;
 b=gjJ/AoshOpRQqHD1f1GnGvNCEAzVDHVlgasWYTjw2q4UXpkN79kpR1YquT5WkYETkI
 TqtEAxcNyzu799XXqa12RPHKk+oAgqmNV39IfIBkgoR6+K8CcPC62MVuBVogPIzHMsZH
 dks1HgBs5VfiBTs9i1CjpMv7iYIR7Z/Dr2bmTo348lViLc+q5H4tllORCkDORTWXKmyN
 amrFxTxlb1zlr88gOobKSMR1mcwQb/fttvOUdumr4lf/JdHacc4FsBSS4WiLBsn8e++e
 Uh55dD92703W/bPlDKSq+eEWcrYVIbLgP7X1en5Odn9xSVGUoTJz4fuw9THsGFLLgsEs
 bo4Q==
X-Gm-Message-State: AOJu0Yx+OApEEjq+2DToKikLIJRqGN7TxNhEYzT+hSCYiPoDqrP3Y0DP
 yHt2hFqWEl7yER/CMP3b92wjeQ0GVRHYh4L8PPfvICGKq6hNgWkHHzUg9IJUrX03FQ1XsYI10X5
 YzOnZ
X-Gm-Gg: ASbGnctw/a8osFJG35s9pnjGOZ3vSmlrkoJK8sgXUyJf4qk8q1jNEe0QDKENYwaqcDd
 dAK69uK5bsbCPuVpHOaPlWl6OslslFvQmqB2I5UdEDA4QlhrkMt84j8nvXogkwwag8WHeIg7bmD
 WvAg2/sCp5ZGgEikrPDb0gac99SEhVP83OsvH370WGK6tHMBUzbAuzgD3IjngjObLKV6T+igZcg
 x4Q2Fmiquexbod3Xqn+LC+c1pQz6G9IGoGJq0ba1pSWTyn2efckp+tEJ5Pm3lc2K3QgTis9LZhB
 vU4zooqGr0Vzr+vjAiRCiM88gwYs58DZav4hhWCrZERIzUQjxMPV5pbaNmyFWO7OMSrTuXw=
X-Google-Smtp-Source: AGHT+IFDnejqr8oRFqr+54M6Q0Qk8od5uIXQThtywqkd6sZvggjsiSEKivHDUfWiTs7aGZTXil9lAQ==
X-Received: by 2002:a17:902:b185:b0:235:866:9fac with SMTP id
 d9443c01a7336-2365d8a28ecmr5983835ad.2.1749763869384; 
 Thu, 12 Jun 2025 14:31:09 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::7:116a])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-2365deca351sm1803855ad.207.2025.06.12.14.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 14:31:08 -0700 (PDT)
Date: Thu, 12 Jun 2025 14:31:08 -0700 (PDT)
X-Google-Original-Date: Thu, 12 Jun 2025 14:31:05 PDT (-0700)
Subject: Re: [PATCH] drm/amd/pm: Use pointer type for typecheck()
In-Reply-To: <20250612122321.801690-1-lijo.lazar@amd.com>
CC: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com,
 Alexander.Deucher@amd.com, Asad.Kamal@amd.com, kent.russell@amd.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: lijo.lazar@amd.com
Message-ID: <mhng-51EEFB4C-FC18-4BC2-81E7-094C20719C1A@palmerdabbelt-mac>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 13 Jun 2025 16:05:52 +0000
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

On Thu, 12 Jun 2025 05:23:21 PDT (-0700), lijo.lazar@amd.com wrote:
> typecheck creates local variables based on the type passed. That could
> result in stack frame size warnings like below in certain configs:
>
> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_6_ppt.c:2885:1: error: the frame size of 8304 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
>
> Checking against the pointer type is sufficient for the purpose of
> getting a diagnostic message during build time.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h | 41 +++++++++++++-------------
>  1 file changed, 21 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index 7473672abd2a..a608cdbdada4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -40,28 +40,29 @@
>  #define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
>  #define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
>
> -#define smu_cmn_init_soft_gpu_metrics(ptr, frev, crev)         \
> -	do {                                                   \
> -		typecheck(struct gpu_metrics_v##frev##_##crev, \
> -			  typeof(*(ptr)));                     \
> -		struct metrics_table_header *header =          \
> -			(struct metrics_table_header *)(ptr);  \
> -		memset(header, 0xFF, sizeof(*(ptr)));          \
> -		header->format_revision = frev;                \
> -		header->content_revision = crev;               \
> -		header->structure_size = sizeof(*(ptr));       \
> +#define smu_cmn_init_soft_gpu_metrics(ptr, frev, crev)                   \
> +	do {                                                             \
> +		typecheck(struct gpu_metrics_v##frev##_##crev *, (ptr)); \
> +		struct gpu_metrics_v##frev##_##crev *tmp = (ptr);        \
> +		struct metrics_table_header *header =                    \
> +			(struct metrics_table_header *)tmp;              \
> +		memset(header, 0xFF, sizeof(*tmp));                      \
> +		header->format_revision = frev;                          \
> +		header->content_revision = crev;                         \
> +		header->structure_size = sizeof(*tmp);                   \
>  	} while (0)
>
> -#define smu_cmn_init_partition_metrics(ptr, frev, crev)                     \
> -	do {                                                                \
> -		typecheck(struct amdgpu_partition_metrics_v##frev##_##crev, \
> -			  typeof(*(ptr)));                                  \
> -		struct metrics_table_header *header =                       \
> -			(struct metrics_table_header *)(ptr);               \
> -		memset(header, 0xFF, sizeof(*(ptr)));                       \
> -		header->format_revision = frev;                             \
> -		header->content_revision = crev;                            \
> -		header->structure_size = sizeof(*(ptr));                    \
> +#define smu_cmn_init_partition_metrics(ptr, fr, cr)                        \
> +	do {                                                               \
> +		typecheck(struct amdgpu_partition_metrics_v##fr##_##cr *,  \
> +			  (ptr));                                          \
> +		struct amdgpu_partition_metrics_v##fr##_##cr *tmp = (ptr); \
> +		struct metrics_table_header *header =                      \
> +			(struct metrics_table_header *)tmp;                \
> +		memset(header, 0xFF, sizeof(*tmp));                        \
> +		header->format_revision = fr;                              \
> +		header->content_revision = cr;                             \
> +		header->structure_size = sizeof(*tmp);                     \
>  	} while (0)
>
>  extern const int link_speed[];

This fixes my build isuses over at 
https://lore.kernel.org/r/20250610212141.19445-1-palmer@dabbelt.com .  

Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>
Tested-by: Palmer Dabbelt <palmer@dabbelt.com>

Thanks!

[I'm going to stash it on my tester branch until it land somewhere 
else.]
