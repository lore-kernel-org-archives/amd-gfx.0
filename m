Return-Path: <SRS0=0Udm=MU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B82C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 17:50:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECA7960BD3
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 17:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ECA7960BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9861B6E03F;
	Wed, 28 Jul 2021 17:50:07 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3C656E03F
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jul 2021 17:50:06 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 z6-20020a9d24860000b02904d14e47202cso2961828ota.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jul 2021 10:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xF039YlyuG7RxN8dseXWrLZl0aE7/lzt+sAud8gMGmg=;
 b=nvdYlK51MedB1Lp1aMAMuZNY4E+E1atkWdOaBHJv0v+SUfw1h+rEb3UlvxBIXg07ca
 ToEro0Rpit3jF2zubNc7jJTMllFmEgQmabiw/IsOaHgiNYDzWMA+IsmA6ZmbLXllNZRT
 ubk1dh7xJyQO4m9FV0lZkp6P/Ds6hXr207gABQ9v8/tJO+FigrxK3N7iKYR8DrBKbOCA
 3gYrx7/re0ze0n3alqVDFY1aFPk23HEO1Mj9/SljILblRdFA065uFKPdwVsYK/PcuF//
 E7TM/pcDhVUnAcnvwHverJ4nOLtKnS9oYB/ElDmIYY/eMXIMaAJ+SAQgjbjEyNXKAeCF
 ImRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xF039YlyuG7RxN8dseXWrLZl0aE7/lzt+sAud8gMGmg=;
 b=X2z3YzApySZ2MtZjAIPpbj+gSSZlibTqa0X41XB3ulyCz7vbK/eW1/f8Dg44NlDwGi
 tyBLDQQGmimOrYoEMCmJMZx4FbTuuOSd8DSn6bK7QpFBhXj7pk9gYY9O85pCOhTaoMOI
 RRy1HWG9v+7kkRcmtkgnxnq4jLBXJ8Os7CVp2vNjLPfd1vLhrVnNdeY+jJAn6VtapBXe
 vDbhIBowPovR6UXsXze2LDn5x6a/va5f41dm+zxUsqnal+imSrtg/nvcXIWo/AgnPdXE
 d8J8p2UaO0XkHx72QLyJ5hT3UaZpCLLVlE7Nd+R9Lc1JOgBhT0XD8/AHa2BKwSyz2hi/
 T0VQ==
X-Gm-Message-State: AOAM533J2twjZbBd3nkQRBNrZ0Os5PIwN4E/g7Zhp46KMmAr9BhtXPjF
 QUiNTkFxIOedXoe90+B8YbmDR7pjOnYp1GAcQHo=
X-Google-Smtp-Source: ABdhPJwt6QHI5pPKjhB1xSLXsl5YvhF1gPAhsGfM1jBAeLFlOtfTrEM0qLkpbxIRcmP1i4uOLxm+pnatuEDpp2qk1EI=
X-Received: by 2002:a9d:2072:: with SMTP id n105mr906188ota.132.1627494606080; 
 Wed, 28 Jul 2021 10:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210728151740.100794-1-luben.tuikov@amd.com>
In-Reply-To: <20210728151740.100794-1-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 28 Jul 2021 13:49:55 -0400
Message-ID: <CADnq5_Ne4SwDhcff7E7BmOULtq1qwO0yAH_umRSiCFHmusY8Ew@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Fix a bug in semaphore double-lock
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Changfeng Zhu <Changfeng.Zhu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 28, 2021 at 11:18 AM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Fix a bug in smu_cmn_send_msg_without_waiting() in
> that this function does not need to take the
> smu->message_lock mutex in order to send a message
> down to the SMU. The mutex is acquired by the
> caller of this function instead.
>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Changfeng Zhu <Changfeng.Zhu@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Fixes: e070ba49f3a764 ("drm/amd/pm: Fix a bug communicating with the SMU (v5)")

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index a0e2111eb7838c..415be74df28c7f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -259,7 +259,6 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>         if (smu->adev->no_hw_access)
>                 return 0;
>
> -       mutex_lock(&smu->message_lock);
>         reg = __smu_cmn_poll_stat(smu);
>         res = __smu_cmn_reg2errno(smu, reg);
>         if (reg == SMU_RESP_NONE ||
> @@ -269,7 +268,6 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>         __smu_cmn_send_msg(smu, msg_index, param);
>         res = 0;
>  Out:
> -       mutex_unlock(&smu->message_lock);
>         return res;
>  }
>
> --
> 2.32.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
