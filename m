Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF033C369A2
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 16:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88E4810E70C;
	Tue,  8 Apr 2025 16:33:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=swemel.ru header.i=@swemel.ru header.b="BY4NRvtF";
	dkim-atps=neutral
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E09910E5FF;
 Tue,  8 Apr 2025 08:16:42 +0000 (UTC)
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1744100198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KycvnFWvB7WLb2FMk02JJRuq8Z8TQ1r5p1fwmK7UuQI=;
 b=BY4NRvtF8TGoqRIlOh7vqXec44FXLXMcGrQLgiSlHUoZiE1Bc9+uNECT0fDAo27IT+iXqD
 hOzTflwyN46+PtVNtVol6lKGo+7HladIctIV9TD8NXhvUHw4PRBDt9Nvt5wArpvnnpUnEY
 bdd8fzIFmrOyE69kfnvxNS7XwQ209IY=
To: alexdeucher@gmail.com
Cc: Jun.Ma2@amd.com, airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, arefev@swemel.ru, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, kenneth.feng@amd.com,
 kevinyang.wang@amd.com, lijo.lazar@amd.com, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, mario.limonciello@amd.com, simona@ffwll.ch,
 srinivasan.shanmugam@amd.com
Subject: Re: [PATCH] drm/amd/pm/smu11: Prevent division by zero
Date: Tue,  8 Apr 2025 11:16:38 +0300
Message-ID: <20250408081638.5295-1-arefev@swemel.ru>
In-Reply-To: <CADnq5_O+TMVD0B28Q6CgzhAi1aDR5ofjogE18HDXrJOJ1XwbDQ@mail.gmail.com>
References: <CADnq5_O+TMVD0B28Q6CgzhAi1aDR5ofjogE18HDXrJOJ1XwbDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Apr 2025 16:33:46 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 189c6a32b6bd..54229b991858 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1200,7 +1200,7 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
>         uint32_t crystal_clock_freq = 2500;
>         uint32_t tach_period;
>
> -       if (speed == 0)
> +       if (!speed || speed > UINT_MAX/8)
>                 return -EINVAL;
>         /*
>          * To prevent from possible overheat, some ASICs may have requirement
> --
> 2.43.0
>

Hi Alex.

The patch 'drm/amd/pm/smu11: Prevent division by zero' was sent 
separately, not part of the patch series, maybe that's why it wasn't
accepted. Should I resend it?

Regards, Denis.

