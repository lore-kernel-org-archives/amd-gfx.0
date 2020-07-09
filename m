Return-Path: <SRS0=lnB5=AU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF579C433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 20:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D6D9206DF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 20:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQIx0FDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6D9206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39C076EB2E;
	Thu,  9 Jul 2020 20:33:33 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E4686EB2E
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2020 20:33:31 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id o2so3256408wmh.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jul 2020 13:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=r/Pg2yo91/3VguoHf8QaXmjeWW1MYxzI/hvb+L//e6U=;
 b=FQIx0FDJcBrm8kBxx3+u5rnHuWZZQgsuvKdaf+EUVg1NoUTuJo0zt3LNCOMFeeCkot
 c9lasL1obfufbpBMy4w6cAEZ/sVLcZs7Y+mVWKbvQYRYgyXgEiuT+16h6lb4G9YpbkMz
 6GoM8UJmElbqXjlUNmNVWgCTEtAzIZrVSADR2jWs4AKzem2qSX/iW07P/YgXX8c2yT11
 xiadE7lO9piZofeucLVUO6b62BDEBPhFm9yYGoW5ospJPbZPIZSgTpNVA0IDc6Tc7w77
 /5XtRq3GD9w5c0ihxUF/uvfBr5ycnsORQDCoaK1p3kfAWg/bt7d6ZQZJjVoAe+Xg32dj
 mBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=r/Pg2yo91/3VguoHf8QaXmjeWW1MYxzI/hvb+L//e6U=;
 b=CYCqsTbFnH317bhHNTBSLbvf27CSe3WdKiPDEYr1aMoAC/U25hbg89WSLByjZ/pX7j
 gV59MSnUErH+Srs/sg2pQRMAD7Z2lPH8FQHjhmlTga4wm84ovzTAbr/zUf0A+HFFK38P
 bYhERSrM4IzyXUZwY2weUB2HTpvEFh/TdTf63sybXt0cktS4LMR/nAYxe+Bd8GulinsZ
 U/zE/n33XZ/1JcIGmgrZsAly9NDlPmu0YLLZLIQ10RpjW1PCMceuwBRqDrmSjxbsyRY4
 Y7pynECy30Ar6FaQXT1yCpDoYJyxevf+IB5gJbhswKKO3tAUByN3B1ro8B1nFw8xMbet
 5Dfw==
X-Gm-Message-State: AOAM530uerwEzaLujFCCQonbdOACwXpGTyy+z2bHSz/QbqZs+YmEPKpG
 /9FhohYujXa1kxznBZnYFWvBQsgSfh8CeGjxAnA=
X-Google-Smtp-Source: ABdhPJzxlzZmk7jlMS7g27sCb7FO1x3QtADSvWbtv7p4Dk87jHcOup1XuMjZoO2spwXNCQVspFHTgaNtRFfIdVoWqbE=
X-Received: by 2002:a1c:32c4:: with SMTP id y187mr1711905wmy.79.1594326810318; 
 Thu, 09 Jul 2020 13:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200703085353.7429-1-evan.quan@amd.com>
In-Reply-To: <20200703085353.7429-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Jul 2020 16:33:19 -0400
Message-ID: <CADnq5_MRqqern6s-ZPDXmOaHBX--9XpjW9PgA_Qqc4MarHBVzQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: correct the .get_workload_type()
 pointer
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jul 3, 2020 at 4:54 AM Evan Quan <evan.quan@amd.com> wrote:
>
> This seemed a typo.
>
> Change-Id: I1e4da590829395617e90d0d43562f934a1ae0234
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/smu_internal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> index 8c5cf3860e38..afb3ef874fc5 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
> +++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> @@ -73,7 +73,7 @@
>  #define smu_feature_get_index(smu, fea)                                        smu_ppt_funcs(get_smu_feature_index, -EINVAL, smu, fea)
>  #define smu_table_get_index(smu, tab)                                  smu_ppt_funcs(get_smu_table_index, -EINVAL, smu, tab)
>  #define smu_power_get_index(smu, src)                                  smu_ppt_funcs(get_smu_power_index, -EINVAL, smu, src)
> -#define smu_workload_get_type(smu, type)                               smu_ppt_funcs(get_smu_power_index, -EINVAL, smu, type)
> +#define smu_workload_get_type(smu, type)                               smu_ppt_funcs(get_workload_type, -EINVAL, smu, type)
>  #define smu_run_btc(smu)                                               smu_ppt_funcs(run_btc, 0, smu)
>  #define smu_get_allowed_feature_mask(smu, feature_mask, num)           smu_ppt_funcs(get_allowed_feature_mask, 0, smu, feature_mask, num)
>  #define smu_store_cc6_data(smu, st, cc6_dis, pst_dis, pst_sw_dis)      smu_ppt_funcs(store_cc6_data, 0, smu, st, cc6_dis, pst_dis, pst_sw_dis)
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
