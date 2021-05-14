Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D1BC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 19:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A8461444
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 19:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A8461444
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 278606F447;
	Fri, 14 May 2021 19:53:26 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6D9E6F447
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 19:53:24 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 d3-20020a9d29030000b029027e8019067fso223840otb.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 12:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YRnJj0worV8il0sFs7SZQPcIFz2okG+iqXaZLlVLum0=;
 b=JJuwED+B85hIpQ1NVoZAczbPCiFx63/zsF36t7Xr1vLgQ054nsIfsqA412PwlY7XOJ
 Ct1THU1atLeKa90KK01at3RwET5q/yUEir2KMilyhC3OIydYurw9AkfbO45C3B2B1mTT
 pdcpjoh+D/hWNgK3ujiFLjZzTsx+cKNq+a6T8px8bgCF3moIurw+ty/ybfpbnHtfy33y
 0rBgmn8TMoZsk6PkjazuzAnzeVm7WVImssGS0HW+Z2loK+7M54KzjdqsdDixBnNwAwpM
 vbEPpqej5c3qXY+req378mgF5I7Hn4iZfVbjC8X+wi/bamiPE1xn3tbOP1GHmxavkbSZ
 cpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YRnJj0worV8il0sFs7SZQPcIFz2okG+iqXaZLlVLum0=;
 b=GWHZuVAY+wr6AmtQ5mlHRV8QBNa0tJlaXbfvXQCRZtPvk00+2dFJMVozN9qsDukeq7
 ZEv3lokXUX4vE0c6uOzJH3mF6V2LtniFl48KAuwve/J0Sts1iCojh+AhFbOzJqvyK8ro
 CNcb2E4Nkjell1E/bmgO3vQfjSN2i3ZsBE2a3lOQn5cEfx0FWfpLmUJAdlFXMiUIgk6X
 f97eQHi55Aqdrvs1JPlG9fE8HYcbe3ESmpZQCNOTS/hdZier0ZvL0HRRKURJgy3KE6US
 43ak4si1aCRDx8QjrIppswydPfRMO1b+OTkPo8fN0EC/Q0mA5yz7UvcRR1KdGwfnzvE2
 ojRg==
X-Gm-Message-State: AOAM5313YHiCR5LoHmLcowOg7yYUtwxK0fZXjJRklwRFrnfoi4HTEHC+
 YEvYS5Frf4YbYyKeSDVGPoJcFRcr9oviqFjB+cY=
X-Google-Smtp-Source: ABdhPJwshPnZ3p38KsA2UcZpwZXY96UQh+r9hG7pomEK80oVhDzrheA1bEOkaSQZMsQbf5KBcpOsKzIH2GRBkNPJkM4=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr10453869otl.311.1621022003439; 
 Fri, 14 May 2021 12:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210514072706.4264-1-PengJu.Zhou@amd.com>
 <20210514072706.4264-15-PengJu.Zhou@amd.com>
In-Reply-To: <20210514072706.4264-15-PengJu.Zhou@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 May 2021 15:53:12 -0400
Message-ID: <CADnq5_OyH6TiM-u36xLyMC=OUBRoZt57-1YYjMPvZSeiUfgwOQ@mail.gmail.com>
Subject: Re: [PATCH v4 15/16] drm/amdgpu: Refine the error report when flush
 tlb.
To: Peng Ju Zhou <PengJu.Zhou@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 14, 2021 at 3:27 AM Peng Ju Zhou <PengJu.Zhou@amd.com> wrote:
>
> there are 2 hubs to flush in the gmc, to make it easier
> to debug when hub flush failed, refine the logs.
>
> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index c25541112663..52eba885289d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -297,7 +297,7 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
>         if (i < adev->usec_timeout)
>                 return;
>
> -       DRM_ERROR("Timeout waiting for VM flush ACK!\n");
> +       DRM_ERROR("Timeout waiting for VM flush hub: %d!\n", vmhub);
>  }
>
>  /**
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
