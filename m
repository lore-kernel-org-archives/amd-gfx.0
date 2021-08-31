Return-Path: <SRS0=0crs=NW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F98C432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 14:14:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F5DA60E98
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 14:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3F5DA60E98
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D82856E03E;
	Tue, 31 Aug 2021 14:14:35 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61A886E03E
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Aug 2021 14:14:35 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 a20-20020a0568300b9400b0051b8ca82dfcso22922778otv.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Aug 2021 07:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=S6jgX7fXruLHJZj12p4R/8PEDGXQrTwZvfickMsvKpw=;
 b=RBSk4jLhJGb9kJZq878OeeGh+6uMAN850YmM1Qlhrx+kIro7Fw67p8VLWDLf/O2JRo
 kZotcJOvW+53Liso77G6uXdFxjso4q4MvnMLqm1j/t1IWmYFF6psl6KIX3eGT13ttf7B
 yvW7mAvuNUjXFttw68HwvWhRo1+XbjUO+YtPSB6ftmU8pG7BrT2HVWif1hlo8WbWExTc
 JwOwiEOrG1zUHrIFv38Y/0POQHMkI7ItyJwZ0+6NLu9WGbIuXKRaG1BQdhIvox6KlDZ8
 PjbicN89utks5eG+fDC8NMe5PhO5dwZ8+7ugGqwviDb6Zma8O6chen9Ip6tIwhnHdoyK
 YaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=S6jgX7fXruLHJZj12p4R/8PEDGXQrTwZvfickMsvKpw=;
 b=Xk22v0F69u34JnkxOjpnWmPQFZ/N79AbbqTp+/20z63HK0OHsar72ry5jlMo28GL00
 tqN8KNAqhr1JtcVuiWWaZf2xvatFGk9TfDwuOMpmYXuGD8xfH0aAVQQTC/2mp7awYWwv
 2/lCVsMk/38cxCpediCgZlPuuGgJf/Qo1TaQF/CNnklbtl9nZZ4wWq0OYKGBGPEoskEq
 qfMQ9NVq+yWY0I5qVD5SnzCvbGDrIPUaqXrWf5mLtNw3+v7IBnBUPHTkge/Ybrl6LTN1
 wCCFFn7e/opp5hRKAOmpnTzBvhO3Cj7d/gzmsrGb3xQnheAD3FSTwBwzvxophKGEScYj
 BdkQ==
X-Gm-Message-State: AOAM531o3TX3ZrcM1ZUow4mEjPgUGThcUQLbJp5xX6bz79GPu0R3Ul7X
 hMMjM1T/y58GNHL5BhpTL5e2pYzL73CwKnqSNhY2q0CUXyA=
X-Google-Smtp-Source: ABdhPJxfr5A6VTC6Bue2Lvk8AGG22E1UUQy8C7Y80oeL5osC+NQBU0phXnbi04UajgTtNsD7fsrZQh16JxjnGVsMd2k=
X-Received: by 2002:a9d:4c15:: with SMTP id l21mr23901097otf.311.1630419274649; 
 Tue, 31 Aug 2021 07:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210830060855.12583-1-guchun.chen@amd.com>
In-Reply-To: <20210830060855.12583-1-guchun.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 Aug 2021 10:14:23 -0400
Message-ID: <CADnq5_Puy4-VQZshbJ94L7HaVd6SCx7eVLOyAdnKEwXg+0K+Mw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: stop scheduler when calling hw_fini (v2)
To: Guchun Chen <guchun.chen@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <Hawking.Zhang@amd.com>, 
 Christian Koenig <christian.koenig@amd.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>, 
 Mike Lothian <mike@fireburn.co.uk>, "Deucher,
 Alexander" <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Aug 30, 2021 at 2:24 AM Guchun Chen <guchun.chen@amd.com> wrote:
>
> This gurantees no more work on the ring can be submitted
> to hardware in suspend/resume case, otherwise a potential
> race will occur and the ring will get no chance to stay
> empty before suspend.
>
> v2: Call drm_sched_resubmit_job before drm_sched_start to
> restart jobs from the pending list.
>
> Suggested-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Maybe add:
Fixes: 067f44c8b459 ("drm/amdgpu: avoid over-handle of fence driver
fini in s3 test (v2)")
?

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_fence.c
> index b439eb7d4177..fd4ba076ff8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -552,6 +552,9 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device=
 *adev)
>                 if (!ring || !ring->fence_drv.initialized)
>                         continue;
>
> +               if (!ring->no_scheduler)
> +                       drm_sched_stop(&ring->sched, NULL);
> +
>                 /* You can't wait for HW to signal if it's gone */
>                 if (!drm_dev_is_unplugged(&adev->ddev))
>                         r =3D amdgpu_fence_wait_empty(ring);
> @@ -611,6 +614,11 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_devic=
e *adev)
>                 if (!ring || !ring->fence_drv.initialized)
>                         continue;
>
> +               if (!ring->no_scheduler) {
> +                       drm_sched_resubmit_jobs(&ring->sched);
> +                       drm_sched_start(&ring->sched, true);
> +               }
> +
>                 /* enable the interrupt */
>                 if (ring->fence_drv.irq_src)
>                         amdgpu_irq_get(adev, ring->fence_drv.irq_src,
> --
> 2.17.1
>
