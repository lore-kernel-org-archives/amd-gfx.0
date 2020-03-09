Return-Path: <SRS0=uBoY=42=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABB0C10F27
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 15:36:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA7320578
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 15:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFzWllHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA7320578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2F6589A9A;
	Mon,  9 Mar 2020 15:36:49 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FCA289A9A
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2020 15:36:48 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id z15so11803910wrl.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Mar 2020 08:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lp/9tdwkkdmoeyrDWzqMRFD1zStYySUwTmGPZI6K3pQ=;
 b=OFzWllHyV9RPDmEi7aq3wm1qhRgJUaRVJbMadrfOE970P1Ro7nzZLpb98IiliINRVk
 I1p5nCV/tZca6GkZEe3f9bhPEF9NYi8IUSUVEMUPAZbY/7IuS7N4hJtSdZwD5IfMg2Pj
 2gfY7WsVC2FzvCZ/naOlUi3a/9rVi3glyXl+WvSuyzUtPshp7GpzJN8b1Rcd0X1mJWQd
 5vt37SPDmI2JLEn8OjlJ4X1XgYq0U3huU0Zvf7iZ2JKy2cUOjUCFb21isYYehWIIlnuM
 RR7Msc5ZMK1lFaPd3FkEmyGQw0O5+psegQPQGoQALA68sbgvidezhfpcH4Kh/rbLeicF
 czIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lp/9tdwkkdmoeyrDWzqMRFD1zStYySUwTmGPZI6K3pQ=;
 b=NQ/vYh0cO2Ps+Jnpm/xCjBBjWK/5a1fMGgT9TA0nputjve+UeRYRGJk+jazHjKezsz
 RgfKye2UYm8zUGqjAgvjUmpsaMOV6KmLNuOPwr4/aVUa/Yyp7Cz7KS7KekgpF3H4e1Wi
 iwUvhIZKePEdOc7zoriMWvjqzogJYKV3LGlqsKWKxH22sOlnL7M5HQw160AGTYg+0sAX
 2GDJ2qO6A5zwc85L6p/vOwO2E9I1JwzSrFt4uUJzYaXTqnNNopzW3wn28yh3cRcT1rLw
 xvBpoItWs+JUklkZZER9VgJUUuPegDsDq4COeP8fyvy4vuxk0CVVu9YlsL+hODSEGHre
 K0ow==
X-Gm-Message-State: ANhLgQ2vLhEKA3u/fiqasZ1uupGIQ61Q0ksSG1IxA5DiFkAjkzkF6vN3
 3FTFf2FFxHvlNrCNr3HMf/jK/7CUkCnYQI7Usd/kzQ==
X-Google-Smtp-Source: ADFU+vtF4hIcx/556GR6UMmMywiZpaFQYCbCkwHgSO5wo9ONXIslzcjzUjdLLclhIGuNC5oGvL5szishdc6N/x1Z0hE=
X-Received: by 2002:a5d:5446:: with SMTP id w6mr6442521wrv.419.1583768207327; 
 Mon, 09 Mar 2020 08:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200309091215.26768-1-Stanley.Yang@amd.com>
In-Reply-To: <20200309091215.26768-1-Stanley.Yang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Mar 2020 11:36:36 -0400
Message-ID: <CADnq5_OL6sy0FVn-VyPE0=E29Ydj465+3_iYKvgUs3401qGKbw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: add function to creat all ras debugfs node
To: "Stanley.Yang" <Stanley.Yang@amd.com>
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 John Clements <john.clements@amd.com>, Dennis Li <Dennis.Li@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 9, 2020 at 5:12 AM Stanley.Yang <Stanley.Yang@amd.com> wrote:
>
> From: Tao Zhou <tao.zhou1@amd.com>
>
> centralize all debugfs creation in one place for ras

Might want to note that this is required to fix ras when the driver
does not use the drm load and unload callbacks due to ordering issues
with the drm device node.  With that added:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> Change-Id: I7489ccb41dcf7a11ecc45313ad42940474999d81
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 29 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 ++
>  2 files changed, 31 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 492960e7d5f0..422cdd1ce3ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1117,6 +1117,35 @@ void amdgpu_ras_debugfs_create(struct amdgpu_device *adev,
>                                        &amdgpu_ras_debugfs_ops);
>  }
>
> +void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)
> +{
> +       struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> +       struct ras_manager *obj, *tmp;
> +       struct ras_fs_if fs_info;
> +
> +       /*
> +        * it won't be called in resume path, no need to check
> +        * suspend and gpu reset status
> +        */
> +       if (!con)
> +               return;
> +
> +       amdgpu_ras_debugfs_create_ctrl_node(adev);
> +
> +       list_for_each_entry_safe(obj, tmp, &con->head, node) {
> +               if (!obj)
> +                       continue;
> +
> +               if (amdgpu_ras_is_supported(adev, obj->head.block) &&
> +                       (obj->attr_inuse == 1)) {
> +                       sprintf(fs_info.debugfs_name, "%s_err_inject",
> +                                       ras_block_str(obj->head.block));
> +                       fs_info.head = obj->head;
> +                       amdgpu_ras_debugfs_create(adev, &fs_info);
> +               }
> +       }
> +}
> +
>  void amdgpu_ras_debugfs_remove(struct amdgpu_device *adev,
>                 struct ras_common_if *head)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index a5fe29a9373e..55c3eceb390d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -592,6 +592,8 @@ int amdgpu_ras_sysfs_remove(struct amdgpu_device *adev,
>  void amdgpu_ras_debugfs_create(struct amdgpu_device *adev,
>                 struct ras_fs_if *head);
>
> +void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev);
> +
>  void amdgpu_ras_debugfs_remove(struct amdgpu_device *adev,
>                 struct ras_common_if *head);
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
