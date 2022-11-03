Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69070C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 04:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BBFA10E21E;
	Thu,  3 Nov 2022 04:23:16 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FBE610E21E
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 04:23:11 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 a13-20020a9d6e8d000000b00668d65fc44fso371460otr.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Nov 2022 21:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KP5nEUCZ+SjthhssopD/8LLKgcDLzkhaM1AKH7cZVCw=;
 b=MVOpRr3ziXGyJ+/9Xi9PGSIdhQKxrA70nlqYd/IX7R67/XuavKu7rYEUVQyGlsQ472
 RQfVupzNSePmEr2uNJ4L+VaTcRLHPSR2ZNY7K3s3bpSuRSdFa6a/6xl1GEl4VFKlU+Fo
 l5G/akXTXNj70dCHN5xeXLQGXxOiBkMk4vN3BSmrDK/Fpc8ZzfC19Bq+c30eU74ZxbIg
 Qj10tNvypzyrCZfzEhVrMBGe8BRRNUYFaxLKar1ea3uRq6TflGg67w3kXQ7xb/H90rBB
 A6fvKm1e8G3eixLEj4ViJpaXp2Ik/mshxiVR1Ku9VhcpOWNgsbu+VCZOoRKOiP/elvn5
 ENsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KP5nEUCZ+SjthhssopD/8LLKgcDLzkhaM1AKH7cZVCw=;
 b=rdnQdkfc2yV91rb9hE5KvKzsH1XwVawe2DuOXPZGpeGxqUdWvqgm+I/m5wIlUjd4ce
 LWkNb5ZfpVRUVXsEGDTxJ3/KVm5QuMvewXIGqkO0C/bXeXqy7h+c19WC4WqCXW9lWatE
 NSr8W19qtIP/IiGF1MfmAJ5pdz6aJE62m5BIxySRdS9dXI51tpJc+BtqaxI1zMIVpjF7
 L3HJOHuYyVb3BdnNh3k0H+YlwsBzF0WBbZgRQra29R8G9DnygX3cVDZxhnrQiryPeZ0M
 42rUgNPF0TISvsDiIgZwq9i05kXNlwlrV0+zKR7ryrWje/9GSd/huRPaBAXM/f61YUfY
 6Vcg==
X-Gm-Message-State: ACrzQf0XdW6i98WuJoC4s2voQzB/bLrffqyhBUbir+Wmp2dsNFjXIC7q
 VeaTI5x222Vy/owbYSLHbFLnB6Uz+yccxbzXjWw=
X-Google-Smtp-Source: AMsMyM4/cFLaSWtAKV6+qrpnINJp23R30VLO6cJwpBho5S1YZ2w4OiLkeorCAWurorE6Iy8yEY9E9BxQMRY97CUKl8w=
X-Received: by 2002:a9d:4592:0:b0:66c:6922:8629 with SMTP id
 x18-20020a9d4592000000b0066c69228629mr6544733ote.233.1667449390156; Wed, 02
 Nov 2022 21:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <20221103040605.796752-1-Victor.Zhao@amd.com>
In-Reply-To: <20221103040605.796752-1-Victor.Zhao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 3 Nov 2022 00:22:58 -0400
Message-ID: <CADnq5_ONV3pi3OPwVFApZZZaeBjGYgGLK7a4ePCD3WMKucBaqA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix for suspend/resume sequence under sriov
To: Victor Zhao <Victor.Zhao@amd.com>
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Nov 3, 2022 at 12:06 AM Victor Zhao <Victor.Zhao@amd.com> wrote:
>
> - clear kiq ring after suspend/resume under sriov to aviod kiq ring
> test failure
> - update irq after resume to fix kiq interrput loss
>
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 522820eeaa59..5b9f992e4607 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4197,6 +4197,8 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
>         }
>
>         /* Make sure IB tests flushed */
> +       if (amdgpu_sriov_vf(adev))
> +               amdgpu_irq_gpu_reset_resume_helper(adev);
>         flush_delayed_work(&adev->delayed_init_work);
>
>         if (adev->in_s0ix) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 7853d3ca58cf..49d34c7bbf20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -6909,6 +6909,8 @@ static int gfx_v10_0_kiq_init_queue(struct amdgpu_ring *ring)
>                 mutex_unlock(&adev->srbm_mutex);
>         } else {
>                 memset((void *)mqd, 0, sizeof(*mqd));
> +               if (amdgpu_sriov_vf(adev) && adev->in_suspend)
> +                       amdgpu_ring_clear_ring(ring);

gfx_v8_0.c, gfx_v9_0.c, and gfx_v11_0.c need a similar fix.  With
those fixed as well, the patch is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Alex


>                 mutex_lock(&adev->srbm_mutex);
>                 nv_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
>                 amdgpu_ring_init_mqd(ring);
> --
> 2.25.1
>
