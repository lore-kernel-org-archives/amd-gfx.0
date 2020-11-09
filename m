Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360F7C388F7
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 18:58:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2101206D8
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 18:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cX+Wtg0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2101206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12F9289496;
	Mon,  9 Nov 2020 18:58:04 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12D33893BC
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 18:58:03 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id r17so6003392wrw.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Nov 2020 10:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A0B0HovzxKvYdgXWCRwRQdz6dTz370psposbGAAQASM=;
 b=cX+Wtg0ItnI0i7aTIyd1/sC1d6KReCNpE30Fagzfe7g4iMx5Zpbqi2FUEHqjveNzLO
 LJb8phKdfOL9AVBo2ln1Vr29f1UnSe+qQn0bEA1LmlXQutStKuOAuaMWVFbecKl9o0f5
 MlkwKGVvHtXl+m3wh7DUW2Cr2iY83OGo+W5UBUPVe8z7PCQH4gy40kanW6x4J5LyYz7T
 4ULHyQoChH0L0Ws1vBOkby0/5NB2XzstBwD66yaT0h4mu5GwzWZI9hEP7oH2nHe2aXy4
 Myvz2pL1ODXMiFLPyKpb7kyYVP0UUYKzBAZBBeIerlAImPeFo2i/Jlj3o6UdecYlTi6U
 KVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A0B0HovzxKvYdgXWCRwRQdz6dTz370psposbGAAQASM=;
 b=dD/A3KVovh6+yE+4/KMbpz0nUmtZ7lEqF6CFZ/QABZ+dVGAa/bfevFxv8fyHSiz2iD
 jFJzkTjfIdGtMXRvBs7ZLWwo1uE+hkdG6IP/WEQI8R/eCgVsON8deppPBIgT8KwqC1EV
 NIUJDXKyJaiYnp5cxLqlVVDO6onMQPpXRHtzZsY4dfwsBso9ayQd51WGjawPbadh3qF/
 1w8FhiXhfs4PIA/nMHj6p7/THKVL+2qzSZssaoMST8B2mBsCrLjjvUw1FX8/mz+t6dV8
 86EzTW3ezU3RcWBi9WXXm1r3BQJpNnmF6xM/vMAuH9/GGPWi/IAQjqjGy/4lNI7nPLFl
 YPBA==
X-Gm-Message-State: AOAM532XserlPZ1/LLwFvxSwUbcnTRqZPhFOvKWiL37I6JI9A+K6Vprq
 NAMoLdAvdkybUGMvs724R7NSuhSLgcSjKapIB3s=
X-Google-Smtp-Source: ABdhPJxIfih6+o5ueT/5ft24+gDE5BjRzUo/rOz19O8lejbDh/eLvT8FQho6m0WO7smGH64q7DLfDdLELT3I/o4bNPA=
X-Received: by 2002:adf:e9c9:: with SMTP id l9mr20779080wrn.124.1604948281796; 
 Mon, 09 Nov 2020 10:58:01 -0800 (PST)
MIME-Version: 1.0
References: <20201109181214.35540-1-nirmoy.das@amd.com>
 <20201109181214.35540-3-nirmoy.das@amd.com>
In-Reply-To: <20201109181214.35540-3-nirmoy.das@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Nov 2020 13:57:50 -0500
Message-ID: <CADnq5_MPHDA-SQoFcFMuuODDB39J=jEuq4pUGhC1cD2SAv7RsA@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: enable only one compute queue for raven
To: Nirmoy Das <nirmoy.das@amd.com>
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>, "Kuehling,
 Felix" <felix.kuehling@amd.com>, Aaron Liu <Aaron.Liu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Nov 9, 2020 at 1:12 PM Nirmoy Das <nirmoy.das@amd.com> wrote:
>
> Because of firmware bug, Raven asics can't handle jobs
> scheduled to multiple compute queues. So enable only one
> compute queue till we have a firmware fix.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 97a8f786cf85..9352fcb77fe9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -812,6 +812,13 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
>  int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev)
>  {
>         if (amdgpu_num_kcq == -1) {
> +               /* raven firmware currently can not load balance jobs
> +                * among multiple compute queues. Enable only one
> +                * compute queue till we have a firmware fix.
> +                */
> +               if (adev->asic_type == CHIP_RAVEN)
> +                       return 1;
> +

I think this is fine as a workaround for now, but it would be worth
checking is the issues are only between queues on the same pipe or
pipes on an MEC.  E.g., can we safely enable one queue per MEC?  What
about one queue per pipe?

Alex


>                 return 8;
>         } else if (amdgpu_num_kcq > 8 || amdgpu_num_kcq < 0) {
>                 dev_warn(adev->dev, "set kernel compute queue number to 8 due to invalid parameter provided by user\n");
> --
> 2.29.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
