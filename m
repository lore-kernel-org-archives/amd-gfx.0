Return-Path: <SRS0=8zgd=GH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C75C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 16:49:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D864224DE
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 16:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D864224DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A1CF89E33;
	Mon,  4 Jan 2021 16:49:54 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6A2589269
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Jan 2021 16:49:52 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id q25so26571444otn.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Jan 2021 08:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ADp4lEVraZTLeVKOMRDcoROWSOgJwyfYA2//fcjztG0=;
 b=jkGJ89KsT+l95hEx5OE9Og9EOzXja5RSCbOS2HY46N1SV0rg1j/OmsN/SNqtKzpvIL
 8Dbgt+qVBEsR7+AcAy1sFJuSqXMZ7a82BbgkWoZdX7DrEmcZR08SDiZU7qt60kmQHhGy
 D05vi5Tdgr1KI0GLNJdT/oFQ8xFwlVMCdrbSuEuahGUO42TXEFjT/HtQjp3vw6Lebvl9
 rPyVPWR3BFS/nzfGrErqnbv8jIkYps/GyQ6yTYc16WWVZFO0WDo5NTPBSKvjsIU6AR0y
 xvDRq0Xc8eeITBXfe0IRnS6DbQL1aLPQ2oPDdVHTV7WfYjkwepH3xnlZkVtRXzH0d2XN
 ztOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ADp4lEVraZTLeVKOMRDcoROWSOgJwyfYA2//fcjztG0=;
 b=JCxFE3odhfe2IxO90FSMqnI3QjLWaVxSsG2qKuJX4PCWPRxP6qv+HR4qJASVzBh6v7
 BIemHBNbbFvZRDL+2GI06bWGEz2vTZvm2eBSGvK/88spQbsCbNQbmB6JMI1Wble2mjam
 gKVCiJx1FGIKWHyE6m+QpD1F+qb2leARiIdCU0WQuYIwlXjK52hqzrFssXBMAZbJtxji
 TON6dqDG9MFsTd5drlb8swx9KgA+UY56PTnGt5w8G8sjuZsvWaeGTb5ORmJ9VT2xyTi4
 qnAfZOcioZRvcup6TIxoTafPwDPM9UPOk6CG1ng4BmczdHY84hSjjH16RWR20V3etain
 g8/Q==
X-Gm-Message-State: AOAM530r5EUuOKseAnecnuahoQdpEUrPZX8giiboBG8yTp2cF79BB30j
 YHXU6L5YAJNAJV1yg2iyyCDy7cYSQYK0mwFRS9Ev6azh
X-Google-Smtp-Source: ABdhPJzV9k6C8M7vEYpyCLYE9nMb4fdqyctt47FlcOYr5CacHgW2YBy7I+ExM4pWni4X8zxY9dOEDofqItLCWG8+dqY=
X-Received: by 2002:a05:6830:1d66:: with SMTP id
 l6mr52719910oti.23.1609778992291; 
 Mon, 04 Jan 2021 08:49:52 -0800 (PST)
MIME-Version: 1.0
References: <20201231090616.14908-1-Jiawei.Gu@amd.com>
In-Reply-To: <20201231090616.14908-1-Jiawei.Gu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Jan 2021 11:49:41 -0500
Message-ID: <CADnq5_PHnq2f0R-cf1XypnpZVPh190JC3ah+sg0RmPO88DshVg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix potential memory leak during navi12
 deinitialization
To: Jiawei Gu <Jiawei.Gu@amd.com>
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
Cc: Emily Deng <emily.deng@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Dec 31, 2020 at 4:06 AM Jiawei Gu <Jiawei.Gu@amd.com> wrote:
>
> Navi12 HDCP & DTM deinitialization needs continue to free bo if already
> created though initialized flag is not set.
>
> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index b44b46dd60f2..4956fbd512d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1316,8 +1316,12 @@ static int psp_hdcp_terminate(struct psp_context *psp)
>         if (amdgpu_sriov_vf(psp->adev))
>                 return 0;
>
> -       if (!psp->hdcp_context.hdcp_initialized)
> -               return 0;
> +       if (!psp->hdcp_context.hdcp_initialized) {
> +               if (psp->hdcp_context.hdcp_shared_buf)
> +                       goto out;
> +               else
> +                       return 0;
> +       }
>
>         ret = psp_hdcp_unload(psp);
>         if (ret)
> @@ -1325,6 +1329,7 @@ static int psp_hdcp_terminate(struct psp_context *psp)
>
>         psp->hdcp_context.hdcp_initialized = false;
>
> +out:
>         /* free hdcp shared memory */
>         amdgpu_bo_free_kernel(&psp->hdcp_context.hdcp_shared_bo,
>                               &psp->hdcp_context.hdcp_shared_mc_addr,
> @@ -1463,8 +1468,12 @@ static int psp_dtm_terminate(struct psp_context *psp)
>         if (amdgpu_sriov_vf(psp->adev))
>                 return 0;
>
> -       if (!psp->dtm_context.dtm_initialized)
> -               return 0;
> +       if (!psp->dtm_context.dtm_initialized) {
> +               if (psp->dtm_context.dtm_shared_buf)
> +                       goto out;
> +               else
> +                       return 0;
> +       }
>
>         ret = psp_dtm_unload(psp);
>         if (ret)
> @@ -1472,6 +1481,7 @@ static int psp_dtm_terminate(struct psp_context *psp)
>
>         psp->dtm_context.dtm_initialized = false;
>
> +out:
>         /* free hdcp shared memory */
>         amdgpu_bo_free_kernel(&psp->dtm_context.dtm_shared_bo,
>                               &psp->dtm_context.dtm_shared_mc_addr,
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
