Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5F5C38A24
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 16:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EA2620736
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 16:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HinHSty1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA2620736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C44F96E136;
	Thu,  7 May 2020 16:09:16 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8477B6E136
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2020 16:09:15 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id j5so7077293wrq.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 May 2020 09:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jK3xpc/g5eDFkhQiJlMugzUUbNU6pENQkvocbNmOhWw=;
 b=HinHSty1ynAQOtjiy7H6TlTrxq43jubAMW+6+gIlhsmONRKFX20GyJ3Z5+3ru0EnbQ
 SdbTF6+JGTtZAwWBtOlbnwjXi4aFidvlaPgczKVHPW8AeCqy6qS+z/hqDYrbx86dbKI9
 oRnUNjByytm4rtDKPHz50u9Uo3tKC7nMQ2VZ/WR609CDwv+9Xvwfv9zHX8g2PGFIZc1+
 IsMk8OBV/LGpFG0GtEgHrmWbkFMgZEfqinrFmnZDMiCHvAEveUaBQCtpCuJSSfKipl6f
 RRcHka0uy1WtyujOMcxfKfFiKeTzCrwHXoXBNoh5dr+twVDpWBhGa/FJL2KCHh8k0d41
 J1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jK3xpc/g5eDFkhQiJlMugzUUbNU6pENQkvocbNmOhWw=;
 b=sly/5rGBj74++hktUAfAafEpYmROdMJ+cEarfwUKMOPNrWjFzvK8sOQ49JDMJW68J6
 I+8vnEHSxLYDcELUJ/aQSGIjn3zhbXK5Me4Ob3T243GGwt4iyNwpAMfd22AYb9S5FopO
 3XAzm8n4LWsfL8Dc2HwMApBi15SHgTkBalrWVGedidPHO2WsO0+9F01pkhSR5fo0euxj
 njrnMUxIzNNn6m+nc/aQIGwkGpzXxCaxXk8WZH+JdoDr6UVSbAr9HU4KUY206iomHHY6
 AeivqXuKMZQZo4fyTAqZeE+0YxJgz5Us5ZtEXBLlCjnLeK+vSF8Ma/u72n9+zWXTkvy2
 7C8Q==
X-Gm-Message-State: AGi0Pubnla9HoLgAtxbGXjGEu47dHFuHMe5/0G4f6drwn0tsCbEOgp+d
 AGSQHCvPBCqyY6MhG17pdxbTzbH/U3lF2F5t2rwMXQ==
X-Google-Smtp-Source: APiQypIlR5CY8GwCF4VMQFZZfHdoMXzNUSF6k/1hN5xI9v7BhYhKF9ICUYS8kmUZRYdjLJBz5hRnPxkTdiYwaNFfLzQ=
X-Received: by 2002:adf:9264:: with SMTP id 91mr15969862wrj.362.1588867753617; 
 Thu, 07 May 2020 09:09:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200505164216.138189-1-alexander.deucher@amd.com>
In-Reply-To: <20200505164216.138189-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 May 2020 12:09:01 -0400
Message-ID: <CADnq5_M373_srFD2AYiV11LmM2ZGmCf=L+9E9Yu0+FB_jecmfg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: implement soft_recovery for gfx10
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Tue, May 5, 2020 at 12:42 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Same as gfx9.  This allows us to kill the waves for hung
> shaders.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index ddb485e1e963..27c63a8f698c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7690,6 +7690,19 @@ static void gfx_v10_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
>                                                            ref, mask);
>  }
>
> +static void gfx_v10_0_ring_soft_recovery(struct amdgpu_ring *ring,
> +                                        unsigned vmid)
> +{
> +       struct amdgpu_device *adev = ring->adev;
> +       uint32_t value = 0;
> +
> +       value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
> +       value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
> +       value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
> +       value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
> +       WREG32_SOC15(GC, 0, mmSQ_CMD, value);
> +}
> +
>  static void
>  gfx_v10_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
>                                       uint32_t me, uint32_t pipe,
> @@ -8105,6 +8118,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
>         .emit_wreg = gfx_v10_0_ring_emit_wreg,
>         .emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
> +       .soft_recovery = gfx_v10_0_ring_soft_recovery,
>         .emit_mem_sync = gfx_v10_0_emit_mem_sync,
>  };
>
> --
> 2.25.4
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
