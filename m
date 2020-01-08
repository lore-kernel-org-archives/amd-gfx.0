Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1987C282DD
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 16:26:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C41192072A
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 16:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iivEBn9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41192072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70F7F6E2EA;
	Wed,  8 Jan 2020 16:26:59 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57EC96E2EA
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2020 16:26:58 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id q9so3127934wmj.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jan 2020 08:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NoL84zBnZWHl9JA4k603bEi+cUzTqGfk4NnMUlTYi+Q=;
 b=iivEBn9Z23MW4eFuORkbnOFo5bv4fVpn+AcMYEZCaC6xer/V0ec17ZX9XkecQhE4fV
 AM9oBBeJkiVzf9Lo7HyOi8wmeKCNHnrPsZd5iV3vjb1Byj/XU5y+gjXYdIlfFfW8moJC
 Ua5A4PhYC42WXRmy7T3+i21e4sKqFFz0MEuhDmSYfc3ErXbSXgQ+fkCOyWujQys3V3rf
 ARVOgEpAeiPoBNdP7WGRD4E7pltSZfUe4FR/mFpGM3HpsuCZXwOmCINJ2l35Qnm00eJ2
 CAyZffWUbk83aKgx0mgZwVlR23GTmPYMC3r2fCmTxTui5vo4qKC/7ItnRlDAaATojmyz
 WflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NoL84zBnZWHl9JA4k603bEi+cUzTqGfk4NnMUlTYi+Q=;
 b=ODgZQ/POICdL4RCrXOQDFpSg9TDbjmdhZ7E0TprmgZ0UETl7X7mfcOGrCElUSVyhzs
 I/LMNdjU9Q3EBCSdeRBMg/sEQMD6RUOUglPTjLirzZFWxkiwpiwXtL5EOtP1Y8TGAs1A
 zBdnbVToX3MVkfW+gCyoOqMBXtxBzX+qrgO7yZMBUztOoy16K2szZdeSrMiMeft72gJB
 0zBstHsd0QcUJyf/xbw0EMkxUAPGkBzixQHwmV0BnxjgFjtY2pDXXVnGUwSYRlhVBulm
 xFa14Y4daIWMjjbJvnj2CUgBlwMIvBW9RLO1QrtDhWgCe9hOEfTjyfA51sckz0M6xX+E
 /HdQ==
X-Gm-Message-State: APjAAAUkgdKJZt6GixrhpAAVCNgKnzm2l00v44K6i81YTVvFmj+c/MfJ
 prVBOJ55qsIrTjveNXywJ3G7ewGueUFeTA7worhBlb+1
X-Google-Smtp-Source: APXvYqwB/yCPO6AXnGSZEUrGsG0rpulZEiLSl8o9hbHyAPL6I8h5+f9lJ6lQqXVMSS8SqOZQ9Q/cXYuxtOWyijyxQ8w=
X-Received: by 2002:a1c:6404:: with SMTP id y4mr4880915wmb.143.1578500817070; 
 Wed, 08 Jan 2020 08:26:57 -0800 (PST)
MIME-Version: 1.0
References: <20200108161721.7727-1-Hawking.Zhang@amd.com>
 <20200108161721.7727-4-Hawking.Zhang@amd.com>
In-Reply-To: <20200108161721.7727-4-Hawking.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Jan 2020 11:26:44 -0500
Message-ID: <CADnq5_NZUQhwgwxDhXXe4qoBefMaDb6X6zKUjb_jwfNjZivo=A@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/amdgpu: add ras_late_init and ras_fini for sdma v4
To: Hawking Zhang <Hawking.Zhang@amd.com>
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
Cc: Gang Long <Gang.Long@amd.com>, Guchun Chen <Guchun.Chen@amd.com>,
 Tao Zhou <Tao.Zhou1@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Candice Li <Candice.Li@amd.com>,
 John Clements <John.Clements@amd.com>, Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 8, 2020 at 11:18 AM Hawking Zhang <Hawking.Zhang@amd.com> wrote:
>
> move ras_late_init and ras_fini to sdma_ras_funcs table
>
> Change-Id: If3a6c0defde4d23f81d2ff7ff79daa98a732efde
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 3 +++
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 6 ++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index 9e87a97f81fb..ee0ca996da0d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -51,6 +51,9 @@ struct amdgpu_sdma_instance {
>  };
>
>  struct amdgpu_sdma_ras_funcs {
> +       int (*ras_late_init)(struct amdgpu_device *adev,
> +                       void *ras_ih_info);
> +       void (*ras_fini)(struct amdgpu_device *adev);
>         int (*query_ras_error_count)(struct amdgpu_device *adev,
>                         uint32_t instance, void *ras_error_status);
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index a00b85934b04..fd20594b6d6e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -1803,7 +1803,7 @@ static int sdma_v4_0_late_init(void *handle)
>                 .cb = sdma_v4_0_process_ras_data_cb,
>         };
>
> -       return amdgpu_sdma_ras_late_init(adev, &ih_info);
> +       return adev->sdma.funcs->ras_late_init(adev, &ih_info);
>  }
>
>  static int sdma_v4_0_sw_init(void *handle)
> @@ -1875,7 +1875,7 @@ static int sdma_v4_0_sw_fini(void *handle)
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>         int i;
>
> -       amdgpu_sdma_ras_fini(adev);
> +       adev->sdma.funcs->ras_fini(adev);
>
>         for (i = 0; i < adev->sdma.num_instances; i++) {
>                 amdgpu_ring_fini(&adev->sdma.instance[i].ring);
> @@ -2565,6 +2565,8 @@ static int sdma_v4_0_query_ras_error_count(struct amdgpu_device *adev,
>  };
>
>  static const struct amdgpu_sdma_ras_funcs sdma_v4_0_ras_funcs = {
> +       .ras_late_init = amdgpu_sdma_ras_late_init,
> +       .ras_fini = amdgpu_sdma_ras_fini,
>         .query_ras_error_count = sdma_v4_0_query_ras_error_count,
>  };
>
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
