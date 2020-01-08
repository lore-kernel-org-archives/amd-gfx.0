Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4E5C3F68F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 16:25:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926BE2051A
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 16:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VC8CdyFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926BE2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 406C46E8B3;
	Wed,  8 Jan 2020 16:25:52 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 292FD6E2EA
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2020 16:25:50 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id q9so3124019wmj.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jan 2020 08:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MJXpahzjotHZvBj7TGvTvZHMrNMlvHkp3q10QLUjOUQ=;
 b=VC8CdyFT4DgvcOPI5plmWEyZPDpuVELYSU5cMz2qsvNhSPz1YfK4aVJNqtxOU2wGQf
 wyZFxV+FtD9mbzGrXp+LMVMIZ12ktvKpualYlQDryp83yOOL4yHDNKgWAkCbX5Rfpn+R
 AiVKj2upeSS+nxyBPXDRLBxnydVlNXpPXjvgnUjY2omi6psTRianIfZjqLWvynU4g+A4
 H7+6ZUzmKi3APY3JSNYnYE37wuEHTgchkb14W6RebRs+sWzx9yiVE7/M+OwylFeukU06
 DrLhdnzsd5bkd4umQarEQzieRVp3IBxlxyQdKI1odpaJlS0aCyVDvbXeHO2Vv8omL34y
 ux6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MJXpahzjotHZvBj7TGvTvZHMrNMlvHkp3q10QLUjOUQ=;
 b=XN42pOOvsnhNoHjR6U9MFjRnZpskin7yANcEE1gD2bcBPuvw9aZXtpCBWynYtP5aDN
 R4e7RZY603cz8w3H9fAQ4BrSs3/KlZ5gbKMeQ4gdBMFdRnBvoHOYDBA0s3J5DCzKXB+i
 v7F8e21TcDOafpSHfpxW1jQVokwsFUilvD9TWdyoYipJB7Y2ExNAspdXZa8TcsBjC6ya
 Vx5f2hxZb+b7qpYacGvIjqE5moEr7vLzwW3Eaj/Ch7Fv/ACWAvMHAEUl3+C+H+B7OpfL
 6ISoDVtJjMyUVdKON94CFjrxy+Xl5qTxOpchwfNlkmHa7I6iHNWGOFzNPEKWStQwsn+q
 970A==
X-Gm-Message-State: APjAAAXU6qwWF2uxfJPhk1Y2ExYsi6TuPNRZTlSa6TS17EYbCtAtFYH/
 RdYWuJ0y8LNbW1xDWegqk/JD2Gjur7zRvB/UPDk=
X-Google-Smtp-Source: APXvYqzz8A0QwsRFF1EaXze/FLB2D/UxWO1OdY9AGI7WXrW8vjzAFcCuGWqXf7ieUnvdhCuv/HCxoJtQrNxwQEAgAt0=
X-Received: by 2002:a05:600c:2406:: with SMTP id
 6mr5060725wmp.30.1578500748785; 
 Wed, 08 Jan 2020 08:25:48 -0800 (PST)
MIME-Version: 1.0
References: <20200108161721.7727-1-Hawking.Zhang@amd.com>
 <20200108161721.7727-3-Hawking.Zhang@amd.com>
In-Reply-To: <20200108161721.7727-3-Hawking.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Jan 2020 11:25:37 -0500
Message-ID: <CADnq5_PgYd28gDqLqw4a5C3P_hYVN3B6Wv9QJFEMkkbGkLm=_w@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/amdgpu: support error reporting for sdma ip block
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

On Wed, Jan 8, 2020 at 11:17 AM Hawking Zhang <Hawking.Zhang@amd.com> wrote:
>
> invoke sdma query_ras_error_count to get sdma single
> bit error count
>
> Change-Id: Iaaa86bb79dc28fe714937ca832da8a1cb5541930
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index c7cee9716bdb..ac9926b3f9fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -686,6 +686,7 @@ int amdgpu_ras_error_query(struct amdgpu_device *adev,
>  {
>         struct ras_manager *obj = amdgpu_ras_find_obj(adev, &info->head);
>         struct ras_err_data err_data = {0, 0, 0, NULL};
> +       int i;
>
>         if (!obj)
>                 return -EINVAL;
> @@ -700,6 +701,12 @@ int amdgpu_ras_error_query(struct amdgpu_device *adev,
>                 if (adev->umc.funcs->query_ras_error_address)
>                         adev->umc.funcs->query_ras_error_address(adev, &err_data);
>                 break;
> +       case AMDGPU_RAS_BLOCK__SDMA:
> +               if (adev->sdma.funcs->query_ras_error_count) {
> +                       for (i = 0; i < adev->sdma.num_instances; i++)
> +                       adev->sdma.funcs->query_ras_error_count(adev, i, &err_data);

Looks like the indentation is off here.  With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +               }
> +               break;
>         case AMDGPU_RAS_BLOCK__GFX:
>                 if (adev->gfx.funcs->query_ras_error_count)
>                         adev->gfx.funcs->query_ras_error_count(adev, &err_data);
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
