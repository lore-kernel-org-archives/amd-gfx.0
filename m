Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7463C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 14:43:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B98810EB2F;
	Tue, 28 Jun 2022 14:43:53 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E721389AEB
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 14:43:51 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id sb34so26180769ejc.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 07:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zBHVxjL6bltdUhr4/7QXT/G8ejNWJTt5/MuXvmV+T08=;
 b=mYIvoui7wOQfHFKvGsBJMASUzQBEVlloPSReeezBHBtddHcRd56DXbXtIUqYGzJ+gz
 IsOlWRbARQaYp8RNcZn6uFh70P6rHBYn5vtlU4h9phUQwYRL8L0ef49J+T+hOqO3jYuZ
 bI8fL7UbVi44PvmnuZy7qVKqt7cj4YHymE9erWUd63GzRhiLXe9wDqqmc8lAnHnI2pWV
 mvp6G+424y0MDMZ1vR8kLAbAIfXE95kYwKOiqilpgX1F67+OoQcAUoDfjZtks1Cai6g4
 0zQL0X23UTMEkM8q9pnRxuvuFzYYCoaqget3xR6JwxLEVd4gqyvNMfw1AfFmzckV6IDE
 PjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zBHVxjL6bltdUhr4/7QXT/G8ejNWJTt5/MuXvmV+T08=;
 b=rdNE9ENbnT6JGf8yrtW74ybfM+WymukShgzURAjsAKWBKPhIYWlawh0VJ8/THt/lOF
 4oLPfklhP+oh74ZZYihKjGWJ1HawraXjZBAgHe04iPkodXl79kwKLx1+eMjl7dQGKjMx
 ToKEk5JSV+qUwQ8HiBp8ITEzwu5tKAbRAonhZvbm/y7WZF/BfvqzxtxRlmSgTtyGnM3b
 1OcEhMpwHj2LoHN8eCWOQqsyLB6Eo5MoqGqXlK+/QiN6VV9sck+sAOrYK7bZryu3Y+I/
 4LWWF/WqbUjs4Uk5oo33dVxfveyvS5Ol3PcDqbNzbYbuDZX/HFMSqNkm7gzjWujx4uwP
 HNig==
X-Gm-Message-State: AJIora+1LX9B8IXmTFEjYJFJVFWAoVsAcDLK7NaQzO87kDYgKM6rFTR/
 d8uqXr/r5759hdTygI6GyZ0YZqaYc9HBgqFh/LY=
X-Google-Smtp-Source: AGRyM1uCLKsS1YUoM5ZDMsh8fvtw1IrqtQEdxEs1hkZTd4Ycf+ebb6d+qVuxvm9ubpdL3Dk8IdRevd+oaCjpE/7yDKw=
X-Received: by 2002:a17:907:a40f:b0:726:a8f5:1031 with SMTP id
 sg15-20020a170907a40f00b00726a8f51031mr9341727ejc.185.1656427430466; Tue, 28
 Jun 2022 07:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220628144207.76106-1-kent.russell@amd.com>
In-Reply-To: <20220628144207.76106-1-kent.russell@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 28 Jun 2022 10:43:38 -0400
Message-ID: <CADnq5_Mq6V+J4Urw2rjqhyc22EUrS_LNMkOYKm8NvYM9tc4AsQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix typos in amdgpu_stop_pending_resets
To: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 28, 2022 at 10:42 AM Kent Russell <kent.russell@amd.com> wrote:
>
> Change amdggpu to amdgpu and pedning to pending
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a2c268d48edd..39a875494edb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5075,7 +5075,7 @@ static void amdgpu_device_recheck_guilty_jobs(
>         }
>  }
>
> -static inline void amdggpu_device_stop_pedning_resets(struct amdgpu_device *adev)
> +static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
>  {
>         struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>
> @@ -5256,7 +5256,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>                  * Drop all pending non scheduler resets. Scheduler resets
>                  * were already dropped during drm_sched_stop
>                  */
> -               amdggpu_device_stop_pedning_resets(tmp_adev);
> +               amdgpu_device_stop_pending_resets(tmp_adev);
>         }
>
>         tmp_vram_lost_counter = atomic_read(&((adev)->vram_lost_counter));
> --
> 2.25.1
>
