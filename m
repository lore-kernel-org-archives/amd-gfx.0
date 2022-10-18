Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D95C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 16:02:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CF0D10ECE4;
	Tue, 18 Oct 2022 16:02:17 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A42B10ECE4
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 16:02:11 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 a16-20020a056830101000b006619dba7fd4so7863426otp.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 09:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8cfcNvMW2EpqGcY6ZImENXehZ3/0cOkmXALRFZ3ak1k=;
 b=BCrRRydnuT9cZknXcVaENyviLkXujFqb+X4cYRmQAfhV2Wev/EpBzKI3MhihVfyjZ3
 +UJVEuMuqL9nmFYD9eBXFE/Xa09oNcSwBo45BeIZTyc9jVx3l+SZkTY68KiecCzS+DeS
 g/+J/PZqK4F2JH3ySib81pVeAKwMe2z4R1tY44mpAVlloL/MXSdR+3pKgB1UQmN7S78b
 SIFierTINqmFS0iTELvbZSr+dei/kaPpcJbX3ZpH80tyEOyJDa8iJ48qWbmW9lS2REIn
 VeaRk5c9BKB5RD1bbKdIXrnOzolaA+P1zS7hu0DeMxF+B30C0IYb9sJf1L2/fLux0mPb
 9jrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8cfcNvMW2EpqGcY6ZImENXehZ3/0cOkmXALRFZ3ak1k=;
 b=dEWBvfHkOGjtukXH76Gn7mIU3opRUj/PsRRotX12l0IyznKWqVsJwdGUSMqA1UqTfI
 luKhLhq1hMyUoBRMCxCtg0a7dx3TMuGdIRRIrHtJCF8oIy897u3b1Ba0ICgb5/FxSHxs
 Jxl45RmazZsprpvWgWgLmHvg6ndCp9oNLF2hZtA89UynVzj8cjFRPCuJy3q98w4h+8mp
 MkgQl+miN1d33wBxknhkdzFIyVQYMvpVyOQJVUGW2Quf17fpq51j8XezXnr+sPDd37CY
 IfC1wKg0rrHlIV+yoeFghhQ8cFOZNAx/bY5HoBNb5MU7+n1BmTNwlsmHgx1RVBAEa8v6
 mhIA==
X-Gm-Message-State: ACrzQf2M/alru7p9SsVDFcjZ1qfbRGW4usWxz0j3nEZ+Rc9N/Df23t3u
 L5eI2RmQb+ykSHXQ+oYqTyUPx2lUDeNIGDV3yWGBOcyLt3E=
X-Google-Smtp-Source: AMsMyM5mndlZy/c3Nt9OWQSBA50H3DiQkZDYFNJQvLod5MVzCAnJT/VX2r/cGDfGtJzNbZd2eL66+3tWLKtxvFziy/w=
X-Received: by 2002:a05:6830:2475:b0:661:b91c:f32a with SMTP id
 x53-20020a056830247500b00661b91cf32amr1653701otr.123.1666108931210; Tue, 18
 Oct 2022 09:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221018091909.923288-1-yiqing.yao@amd.com>
In-Reply-To: <20221018091909.923288-1-yiqing.yao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Oct 2022 12:01:59 -0400
Message-ID: <CADnq5_N8+m3PfounwPYYcv_i+v5MfCHczhuoZdHDG4T06uMD=g@mail.gmail.com>
Subject: Re: [PATCH v2] Adjust MES polling timeout for sriov worst case
To: Yiqing Yao <yiqing.yao@amd.com>
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
Cc: alexander.deucher@amd.com, horace.chen@amd.com, haijun.chang@amd.com,
 amd-gfx@lists.freedesktop.org, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Oct 18, 2022 at 5:19 AM Yiqing Yao <yiqing.yao@amd.com> wrote:
>
> [why]
> MES response time in sriov may be longer than default value
> due to reset or init in other VF. A timeout value specific
> to sriov is needed.
>
> [how]
> When in sriov, adjust the timeout value to calculated
> worst case scenario.
>
> Signed-off-by: Yiqing Yao <yiqing.yao@amd.com>

Please prefix your patch subject with drm/amdgpu:.  E.g.,
drm/amdgpu: Adjust MES polling timeout for sriov worst case

With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 1174dcc88db5..8d265598d4b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -98,7 +98,14 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>         struct amdgpu_device *adev = mes->adev;
>         struct amdgpu_ring *ring = &mes->ring;
>         unsigned long flags;
> +       signed long timeout = adev->usec_timeout;
>
> +       if (amdgpu_emu_mode) {
> +               timeout *= 100;
> +       } else if (amdgpu_sriov_vf(adev)) {
> +               /* Worst case in sriov where all other 15 VF timeout, each VF needs about 600ms */
> +               timeout = 15 * 600 * 1000;
> +       }
>         BUG_ON(size % 4 != 0);
>
>         spin_lock_irqsave(&mes->ring_lock, flags);
> @@ -118,7 +125,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>         DRM_DEBUG("MES msg=%d was emitted\n", x_pkt->header.opcode);
>
>         r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
> -                     adev->usec_timeout * (amdgpu_emu_mode ? 100 : 1));
> +                     timeout);
>         if (r < 1) {
>                 DRM_ERROR("MES failed to response msg=%d\n",
>                           x_pkt->header.opcode);
> --
> 2.34.1
>
