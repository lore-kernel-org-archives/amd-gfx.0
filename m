Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47060C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 21:16:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EACB6124C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 21:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0EACB6124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C7BA6E430;
	Wed, 10 Nov 2021 21:16:21 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF6916E430
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 21:16:20 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id o83so7705623oif.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 13:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cxAWeN1hqqYTAC9qyV3JwX31UyGhIz/5JDDYFS48YUc=;
 b=Cj0mHSzJAYE7PsL9si/BMPVHYKs7Al0anEmmrW0vLQ2xQNSHuwfxsT28GX+7xt1hZR
 30VuBlZvtHmzBQQEF+YWZpPsYgu+QT/bRHwgp8K0NZJZc/pkp60xQDn5NySXgyr6Zgij
 oQv26CX8Q9YySvNpzouW7U/hINdkPqfeHOouJjn6Jnhc1y0N7hVADgb2odprCqCl9tFE
 +GP/DlOMnMIFUHAilMummZy7+ePZUF7kySamU47Ty4Es375HO8tmpXkTt3uMzZeYvtws
 BN5WNXoWqqjzY1RBoyLFbwPQ5/kY18IkEd2Lkj8wqIxGk/lzdJZB6/yg/gyKgF+j3/yh
 9ACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cxAWeN1hqqYTAC9qyV3JwX31UyGhIz/5JDDYFS48YUc=;
 b=uP0y6a42UOnSCQgVh8AJ3m7J1YUUMu9KoiHZgYhvWhbI58SJKlCtG6jU9GZY2iUmQN
 hzRRbv0JbGpb+/4usFQ+2h6AnxqjB3jVy0w58I/emE3wxuW7cdNAhib0t4ddvVIej4iF
 wI96ZDp8b4lS1zryuZDLAMesuNnHKedA8DjD3/mk1QqY97fo94REm5o/cJQqUqAwxpBG
 iqMNuvkZ440eM0qt+4AmAeIyRMk/lQrQWDcCw7Q3muZLX5ZhPtIldXxgwz5n8fclmF3E
 ubOB2DodD7LDCoK3NiIdOaABLYEILOEadpLfO25+bqqx1M9/zafl3DCinNBztf0db89t
 achg==
X-Gm-Message-State: AOAM531w8v4w6vQyWlQkoGZf71tFNZdWGao9dhzXYXPIYbCHctKAaloG
 2aR44c3mE8G9Oy+bs/b9wHyDi6Ms9W5cS8aOklI=
X-Google-Smtp-Source: ABdhPJyD7JQXJrMMBtxZCqNcIiNNa4CfwKFV8asK1OaooewU2lia+b/xA+jIDdUgAfG/W1MHdf/6BqXsCFIbgjU44cU=
X-Received: by 2002:aca:180f:: with SMTP id h15mr1885975oih.120.1636578979900; 
 Wed, 10 Nov 2021 13:16:19 -0800 (PST)
MIME-Version: 1.0
References: <20211110210221.125336-1-luben.tuikov@amd.com>
In-Reply-To: <20211110210221.125336-1-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 10 Nov 2021 16:16:08 -0500
Message-ID: <CADnq5_MJDLBehqB6Co-Byn5DsANMqmtBJJmcKdD-hUfOyhx+7A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Enhanced reporting also for a stuck command
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 10, 2021 at 4:02 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Also print the message index and parameter of the stuck command.
>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 843d2cbfc71d4c..ea6f50c08c5f3b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -139,9 +139,13 @@ static void __smu_cmn_reg_print_error(struct smu_context *smu,
>         const char *message = smu_get_message_name(smu, msg);
>
>         switch (reg_c2pmsg_90) {
> -       case SMU_RESP_NONE:
> +       case SMU_RESP_NONE: {
> +               u32 msg_idx = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66);
> +               u32 prm     = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
>                 dev_err_ratelimited(adev->dev,
> -                                   "SMU: I'm not done with your previous command!");
> +                                   "SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x%08X SMN_C2PMSG_82:0x%08X",
> +                                   msg_idx, prm);
> +       }
>                 break;
>         case SMU_RESP_OK:
>                 /* The SMU executed the command. It completed with a
>
> base-commit: 14271bc7f5e7ec276c58927ea87af9e81d97fdf3
> --
> 2.33.1.558.g2bd2f258f4
>
