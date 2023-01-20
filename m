Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3FCC05027
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Jan 2023 16:35:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06DBD10E118;
	Fri, 20 Jan 2023 16:35:43 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F09C910EAB0
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jan 2023 16:35:40 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 f5-20020a9d5f05000000b00684c0c2eb3fso3374051oti.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jan 2023 08:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dYHsqHZGYFfLiwY8FT9a5G0PUkcGvheglYNFCwW9raY=;
 b=TksECH8GQJfc/+DSaMyiYoQoW2nmVjGc48SjLzRwnNoM9aKNpLjPAs0HgjIymjHukm
 VLzET+XQWiNT1BRmFVt15bo8nqG2mqZ7Rjdr0qIQVeWPWLoTWInBuhCiN1gJ7xLcc/qV
 yH4VqRjXzQt3KrTChqQ1O1aEEqpR+jFmZM8/Ul7gnmHjHt9MH35rc0DqnNf64jVHm5G8
 Q3xXgwAnZYOm/c/JfoHcaU/BGiLJpJhk4SVyp+c4/zqPSdM9anAlweXqDNCBzgJT0Ci3
 I6ZRvYZn6coWtPqWe6aRIwkuLoFBu7xQzaeQxD2NA/i0tVDQfVIzn4pyifQlygUXXkhr
 QO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dYHsqHZGYFfLiwY8FT9a5G0PUkcGvheglYNFCwW9raY=;
 b=SvQ4m7gsxLyUtwvjTb0Ei8YJs1lhhUR1tt8cFgbJcJQU82rpT0qBO+VnYGuw4QAFxY
 JyPZU5vGCA3FX/g8lbwTowxVrh8n8tm3voqWhAhf/bFv7k+HDiUmWSK1fybepXil1NbW
 ALHJG35BhBbIbhJFO2GsnriwPSIXBKQk3PTzQdxbdjdnOxCPJ8MVkANZP9BXeulHPbsP
 ofHhtv/V0Aq1fNJ63SOTr0l7NHzwPcobRAHTm/KKmwtN7yQR23j3/9jrNJSi+bLRKZqG
 BHhr2jxsFZm+JZrG6wkCMqTDps7GsU5I5LSGJxP2bJQMGoxPzcMkM3/dMG1/XA5dU1+9
 7a5Q==
X-Gm-Message-State: AFqh2kpy101YqIcnDhKEgb6IOeeiq71LTOR1L41oaZ4yeVWiIQV+73b0
 G0KljpGHO8bi/zA3sI4YjCPlIZOv5DaoMCtVUJM=
X-Google-Smtp-Source: AMrXdXvJgCVf9AKtNB0GuCcpRpsk2Taj9giWfaHgRbMiyr54kAmjyk/ujHvIgIOfjQzsEzedxXGpMqwLn6lrsRPROw4=
X-Received: by 2002:a05:6830:26d9:b0:686:9219:3704 with SMTP id
 m25-20020a05683026d900b0068692193704mr219857otu.123.1674232540024; Fri, 20
 Jan 2023 08:35:40 -0800 (PST)
MIME-Version: 1.0
References: <20230120162858.1580755-1-tim.huang@amd.com>
 <20230120162858.1580755-2-tim.huang@amd.com>
In-Reply-To: <20230120162858.1580755-2-tim.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 20 Jan 2023 11:35:28 -0500
Message-ID: <CADnq5_NVrpgb-Em2is8kUyysrGD-ZiJrU=HhBVzsSwumj=aAng@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: drop unneeded dpm features disablement
 for SMU 13.0.4/11
To: Tim Huang <tim.huang@amd.com>
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
Cc: Yifan1.zhang@amd.com, Xiaojian.Du@amd.com, amd-gfx@lists.freedesktop.org,
 mario.limonciello@amd.com, Alexander.Deucher@amd.com, li.ma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Jan 20, 2023 at 11:29 AM Tim Huang <tim.huang@amd.com> wrote:
>
> PMFW will handle that properly. Driver involvement may cause some
> unexpected issues.
>
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index ec52830dde24..800eb5ad1dcb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1448,6 +1448,8 @@ static int smu_disable_dpms(struct smu_context *smu)
>         case IP_VERSION(13, 0, 0):
>         case IP_VERSION(13, 0, 7):
>         case IP_VERSION(13, 0, 10):
> +       case IP_VERSION(13, 0, 4):
> +       case IP_VERSION(13, 0, 11):
>                 return 0;
>         default:
>                 break;
> --
> 2.25.1
>
