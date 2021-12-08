Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A17C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 20:25:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C72E56E8A7;
	Wed,  8 Dec 2021 20:25:58 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D16F6E8A7
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 20:25:57 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 x19-20020a9d7053000000b0055c8b39420bso3972890otj.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Dec 2021 12:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Hc43Yh2gqhcwu0RpuUv5FNqrvAa+gw1CxdOu6cT2CcY=;
 b=H+t+V6kKxy4cJQX117FYX+cKOKNHmr1BKdFAAGvDH+rQoq5r5AHj3LGCx9Ax1IyZYh
 w3qomOXJkR1imF/KGB2fF0VpOE/mNW1awvuDe7NFituLyttoQKgE35aBAfZWoourlJZF
 uTDRATwpKDjrL7Qfxd7FhOTi209g8UiOkvOnoGulGYnZRofbMdU7Q8n1MSM2LX+ch7q0
 6TjoI1ci3BNhwcsg5wDu/MJbTwEqWClAzoaSs2js3N7/ROy1yp1AOC9gI2JxneVDNwe3
 WcMQTmTjYL9wklGsRb6Ga2icVI10K60WaCy1GgREILANfReNRStLowemGwD6B4i+ysPd
 CMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Hc43Yh2gqhcwu0RpuUv5FNqrvAa+gw1CxdOu6cT2CcY=;
 b=HlC9iC4WTGHSE9JIWWNOUtNqalbWntmOlnwMSRBfR5yskeGNB3FwrQrc0RJ8P/1gsU
 TUJhuNyIZS6P9NbZ4X17M8NUmbrBKOOhfa7/6I/Zsdwj9rQ4uyApe3WvlmGnx+NiNzqm
 wOd/vdJkFNeXDiig72tPQ526gANJtmXfGsWaFlXMbOfXC59FiMFCauW4klRZWv+85PZ+
 CCIeQApwHYDQcJsq1KXOsgyMnLAby53oigdH0gx51kkRk30M4Htc++yeWrUM9BQbI8ow
 an35ukzVt1g9AJXw3VyRl6+dKmk/azMnGR7nQFONFJ92bjkF1EegXWo5+Fyfuz/6MghQ
 nUyw==
X-Gm-Message-State: AOAM532kY+4DoFHxpdoMaW31vBOKzXJ7ssyj32wzWho+0IlmDXQNBgKT
 AKAg8vnYNv9Ph9zUqO6+08uPx4fK6+OGzOL/wXLYbDma
X-Google-Smtp-Source: ABdhPJx3p9OzJOfvZ0ejE0mnxzQQkbgYMzxnt0/q1Rjv4CDyQl16N+ssK8jH9cWS/2np7OIQnw99Hx69c9k0Syk+/6Q=
X-Received: by 2002:a05:6830:1bcf:: with SMTP id
 v15mr1618788ota.200.1638995156773; 
 Wed, 08 Dec 2021 12:25:56 -0800 (PST)
MIME-Version: 1.0
References: <20211208201618.10551-1-Philip.Yang@amd.com>
In-Reply-To: <20211208201618.10551-1-Philip.Yang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Dec 2021 15:25:45 -0500
Message-ID: <CADnq5_NmfbXL9jzBZxZJOjT_+zpatk+M4Zm_czNsG9VMdcweBg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Handle fault with same timestamp
To: Philip Yang <Philip.Yang@amd.com>
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 8, 2021 at 3:17 PM Philip Yang <Philip.Yang@amd.com> wrote:
>
> Remove not unique timestamp WARNING as same timestamp interrupt happens
> on some chips,
>
> Drain fault need to wait for the processed_timestamp to be truly greater
> than the checkpoint or the ring to be empty to be sure no stale faults
> are handled.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Maybe add the link to the bug when you push this?

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c  | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 3 ---
>  2 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> index 8050f7ba93ad..3df146579ad9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> @@ -188,8 +188,8 @@ int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
>         checkpoint_ts = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
>
>         return wait_event_interruptible_timeout(ih->wait_process,
> -                   !amdgpu_ih_ts_after(ih->processed_timestamp, checkpoint_ts),
> -                   timeout);
> +                   amdgpu_ih_ts_after(checkpoint_ts, ih->processed_timestamp) ||
> +                   ih->rptr == amdgpu_ih_get_wptr(adev, ih), timeout);
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index e031f0cf93a2..571b11117992 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -522,9 +522,6 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
>         if (!handled)
>                 amdgpu_amdkfd_interrupt(adev, entry.iv_entry);
>
> -       dev_WARN_ONCE(adev->dev, ih->processed_timestamp == entry.timestamp,
> -                     "IH timestamps are not unique");
> -
>         if (amdgpu_ih_ts_after(ih->processed_timestamp, entry.timestamp))
>                 ih->processed_timestamp = entry.timestamp;
>  }
> --
> 2.17.1
>
