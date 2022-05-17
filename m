Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B85EC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 19:02:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DF631137AA;
	Tue, 17 May 2022 19:02:42 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACDDE1137AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 19:02:41 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 m15-20020a9d608f000000b00606a788887aso12811998otj.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 12:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pw6JxeUCm4UZ5tehKrG7FBOQz+k2KReU2xhduTDebVE=;
 b=itZfOZXRppg5X9/TOqKiYngY1ig6ubKwWkAuDYgrBptG2C1eNB2ZesyvhsTwn4aIG1
 d/Wn+q7rfpU3dJ4VvWULBL1wCI6rPtn/l6lew3svWStPMi6wRHSn+GEAInSENBOo9cZX
 uuQSE+2DbvOUPNYWpckl312GFvcRKaQcK33i1lWRV4EHCdItIQS+HG46EqPxuhyXxgEJ
 mJ7Lei4CKTWoHGUgK3BOAJ0t55l5piCLMLLl8D6n+jk9EM1AK5qftCIjsDP25DmxXbdL
 WvEJGuh+G+Lv54Fj5o/d5QwAfwZEopadOKHyQmjLA/R3h7PckCml5AxGZYLl7q7ubh+p
 G76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pw6JxeUCm4UZ5tehKrG7FBOQz+k2KReU2xhduTDebVE=;
 b=0aKTQKqwHEBkcGkx95Myv0X686dwsU6hVKpCllIlU939/M0RoHNDgO3xAtpt+J194x
 uce0zcXzfQIXntoijCFzW5T1UJqfGjsdkZOZpFZo8YJ2TZVsfKNCLXgFOjUWc6rt3Lnp
 wryYjKAo6AYh2FqivJhYGrjUIzluKdnnt5elpHbnxg3WnUwC2r73Kq+Aer8CDR+334w8
 J07zL/dPpEAt8s6U0NA6OcmZ+Y5RG77+2Ws7kXaEK1lysmbvyCHv4fcS+9oWwgBSjm5X
 xYSNrUn2DZF1yKHcctEi7s6ZZFhlPcw9CupeH22i/WHL+ztXBctsTSt0bAOo/K1fIhCc
 XQEA==
X-Gm-Message-State: AOAM532GPousT6iaPh9cAVJOxadSh/IMDW2p//80E8Xt/kTHab9XBJSP
 FSsHreagdbttPD+yQTIYrAxB5nwWa9h8A8Pyg65wSVyU
X-Google-Smtp-Source: ABdhPJyhJh/ff+RFZLDw2T5/JTE1eSYGqtBeQlDtnVYVEV0SLIc1onlkE/cEFN3dmC2zYdWJuq4SUb9ux5IT6Rxt+Ww=
X-Received: by 2002:a9d:6543:0:b0:605:e789:271e with SMTP id
 q3-20020a9d6543000000b00605e789271emr8879472otl.200.1652814160789; Tue, 17
 May 2022 12:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220517060635.30481-1-ricetons@gmail.com>
In-Reply-To: <20220517060635.30481-1-ricetons@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 May 2022 15:02:29 -0400
Message-ID: <CADnq5_Myn9S=mEGoiwpUU9GFiNfr6LE65W_QNFh1FhqN93jz6A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Set CP_HQD_PQ_CONTROL_RPTR_BLOCK_SIZE
 correctly in gfx_v8-v11.
To: Haohui Mai <ricetons@gmail.com>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 17, 2022 at 2:06 AM <ricetons@gmail.com> wrote:
>
> From: Haohui Mai <ricetons@gmail.com>
>
> Remove the accidental shifts on the values of RPTR_BLOCK_SIZE in gfx_v8-v11.
> The bug essentially always programs the corresponding fields to zero
> instead of the correct value.

The hardware clamps values below 5 to 5.  Updated that in the commit
message and applied.

Thanks,

Alex


>
> Signed-off-by: Haohui Mai <ricetons@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c  | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 12f63d6aab12..dd8f4344eeb8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -6898,7 +6898,7 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
>         tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
>                             (order_base_2(prop->queue_size / 4) - 1));
>         tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
> -                           ((order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1) << 8));
> +                           (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
>  #ifdef __BIG_ENDIAN
>         tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 8a1bec70c719..82c98e59a13e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4082,7 +4082,7 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
>         tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
>                             (order_base_2(prop->queue_size / 4) - 1));
>         tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
> -                           ((order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1) << 8));
> +                           (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
>         tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
>         tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
>         tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 90f64219d291..fb9302910742 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -4490,7 +4490,7 @@ static int gfx_v8_0_mqd_init(struct amdgpu_ring *ring)
>         tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
>                             (order_base_2(ring->ring_size / 4) - 1));
>         tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
> -                       ((order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1) << 8));
> +                       (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
>  #ifdef __BIG_ENDIAN
>         tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index f49a2dd89ee7..f12ae6e2359a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3514,7 +3514,7 @@ static int gfx_v9_0_mqd_init(struct amdgpu_ring *ring)
>         tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
>                             (order_base_2(ring->ring_size / 4) - 1));
>         tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
> -                       ((order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1) << 8));
> +                       (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
>  #ifdef __BIG_ENDIAN
>         tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
>  #endif
> --
> 2.25.1
>
