Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1CBC433C1
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 18:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C57436196F
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 18:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57436196F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78ED16EA7E;
	Fri, 19 Mar 2021 18:27:45 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 937B16EA7E
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 18:27:44 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id n8so5742206oie.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 11:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jvOfLvIWpEDy8Z57VbXp8q7Ib1tyFsp/iOwm7CiSinY=;
 b=OXIn6NJHmWisYfN/XZZzFU62H2b7qJ+QH9pwww2MFMOl13TmFB///OBZTmu0Pi4Ybw
 GJFCvANVky7msQPvZz6hs8o96gi0Bf5CegeHNUIl+yBoCVk6csSgv0pSOXnzXpsuIBDv
 QI1ngNGHgQ3glkUEuckgwr8UqXUgJ7DbTIkm1oxLiKbYIS6qaYdWDsGV1VLTDpKbIjJO
 +LmPQ8G8GswJp7uCOgVNjrv8bc76aXLj1KnLRxxMRpb7yTZB1w/xe94mzhg52T7Tv3l7
 ZW8GcmQKI7KWwFL6jrJK5LIK7XYs+nU+lA7wEziuaSlTdJaTpenfHeHI27qF7ZOkvMjK
 THhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jvOfLvIWpEDy8Z57VbXp8q7Ib1tyFsp/iOwm7CiSinY=;
 b=XXQZvOl8AAXVyYpMt9nqtHYfmkpXHtj2d8xZ42y0+LyM23HjTFCa+SScpPO7AoFT2g
 m5U2ZU7TsuCFbCHxWDPN5XF6ki7A6MxRHkEs3BJGa84CGJMci4ZkNoJMJd0gO38TiUuY
 5u7gXEoLOFF/WnUbZ9MC7z/6119wG5Kl5Qo2Cs2NYlLIkFoGWZ4hlDMy0cF7OVo1Nxtm
 LbqozdLlU0vVVd7cmqodfFqBHwlCUSCnwZh5mKJlNXoe3tdeT2VdrgfM26nnXl3lhTN1
 qu2f9a7x9EM3bJRUptTszva+o0zrjQ9d4ELxq2P8xnnSFEi7ibBmZDHCldEt7OVkoKf9
 MFfA==
X-Gm-Message-State: AOAM532r+jb00BkPnQjpO9PujHAzT/bzca737kK2kW1pl7LsSt6FprbJ
 Sy9CJDg2eMJFjP9UpP1eS53VoLNUsbW4hhjmK40++4Dw
X-Google-Smtp-Source: ABdhPJwVaWI4ijs2sdLVEkiz+zI8JUlFGUbmizUC5Z8+PwpHF7SlWzCKah+OIm0xRg5SK/BvxCwJdBr/C6wfrJ2ZzPU=
X-Received: by 2002:aca:4284:: with SMTP id p126mr1940654oia.123.1616178463898; 
 Fri, 19 Mar 2021 11:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210319070415.27873-1-shirish.s@amd.com>
In-Reply-To: <20210319070415.27873-1-shirish.s@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Mar 2021 14:27:33 -0400
Message-ID: <CADnq5_OUqm3DYpFkpKtZGTpezpx7r25byOkxDe=M31CAiW3r5A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/powerplay/smu10: refactor
 AMDGPU_PP_SENSOR_GPU_LOAD
To: Shirish S <shirish.s@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Mar 19, 2021 at 3:04 AM Shirish S <shirish.s@amd.com> wrote:
>
> refactor AMDGPU_PP_SENSOR_GPU_LOAD to ensure code consistency with other
> commands
>
> Signed-off-by: Shirish S <shirish.s@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c    | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index f5d59fa3a030..f5fe540cd536 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -1297,19 +1297,18 @@ static int smu10_read_sensor(struct pp_hwmgr *hwmgr, int idx,
>                 *size = 4;
>                 break;
>         case AMDGPU_PP_SENSOR_GPU_LOAD:
> -               if (has_gfx_busy) {
> +               if (!has_gfx_busy)
> +                       ret = -EOPNOTSUPP;
> +               else {
>                         ret = smum_send_msg_to_smc(hwmgr,
>                                                    PPSMC_MSG_GetGfxBusy,
>                                                    &activity_percent);
>                         if (!ret)
> -                               activity_percent = activity_percent > 100 ? 100 : activity_percent;
> +                               *((uint32_t *)value) = min(activity_percent, (u32)100);
>                         else
> -                               return -EIO;
> -                       *((uint32_t *)value) = activity_percent;
> -                       return 0;
> -               } else {
> -                       return -EOPNOTSUPP;
> +                               ret = -EIO;
>                 }
> +               break;
>         default:
>                 ret = -EOPNOTSUPP;
>                 break;
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
