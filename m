Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7587BC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Oct 2022 14:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 892A010E830;
	Tue, 11 Oct 2022 14:33:36 +0000 (UTC)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4AA810E830
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 14:33:33 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 r15-20020a4abf0f000000b004761c7e6be1so10148083oop.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 07:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RJIe0uuIzJc9xC5ZTW+XWgNeyFxa/pUr6SPekgwHWZU=;
 b=quCNcSrFoxDfVHO4O/OJLQzIrWpztunw6euTnmAaJIT9FYd7gsRFuPpn5xwqVUantB
 VdjJvoXvq2JtHkQTFr3LWA4t/AA++v3KsAgRNgLQREPrfTjflFccaq07NdCzxcVnms1q
 WXO10sEVrcQKUSLosrML5uHCKFk41n7knwejvODRkJ8GXv9km753Bd/owCY4WHA455xU
 v5j3GoQwjRMYe/xzr+SF/2GweTKGSzbL9F30vv8ZSGWXPy+s7S3FNN+gG7j1taVc+6AB
 I7HV03atoZhJ+XDEwKdKvYUWDNkgBXw4rNTmBB1+omebCFiC729f06w8JokXLw9bbjAd
 +PIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RJIe0uuIzJc9xC5ZTW+XWgNeyFxa/pUr6SPekgwHWZU=;
 b=32GLfcaRPyiDlpARxeiAogFJ+4JNgY21HurJDGwCliKOi/XS9B15LzdpSWwnqLlJ+D
 vh5NNm9TWWbN9R78pu2r42PBVFTGsQDU5RloXjeOaMgvmsIbB8C5kd78Aeg66vYMp8Q/
 /jVwCU4YALKESEnY5VKq2np0ttL57sDm7BEb3EOc2RVjwKtEUhS14UE+fuhwPuR8A9mh
 cM2mPe+sASgrJJNjcImqc9+pAQQbQp8/fuEmdu/W+h5znA0o6Iw1tv+99jFac+/GF9P+
 +3airYvAdwBqgC0GQz4rp19OoCrLu9qdSTOaPaAZElnKpFWCbt+Y3iEXpPfw2RJVXCQ/
 Z7lA==
X-Gm-Message-State: ACrzQf3dkpJWZ84ippsdZy2OWDqj3zhuTKau9uTVEn6GFXEXDeczEJzl
 y7++v6hV+V+bp7HLtnacU/PnL2fTvSRrzTJqjfw=
X-Google-Smtp-Source: AMsMyM7JCjmUEPRnUHUkCybly9irfiooqBKluNUXp5YgqiElwmpMJzI9GWP4NDLJB2WkMIjcht1UBrDpe1q9AJ9XtDA=
X-Received: by 2002:a05:6830:3708:b0:661:330:5837 with SMTP id
 bl8-20020a056830370800b0066103305837mr10717276otb.233.1665498813193; Tue, 11
 Oct 2022 07:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221006153215.450989-1-alexander.deucher@amd.com>
In-Reply-To: <20221006153215.450989-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 11 Oct 2022 10:33:21 -0400
Message-ID: <CADnq5_PtXxA3Zh4Fz5Lwyx-qzEr1qWrYneM7o4sgLK1mUwzOVQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix indentation in dc.c
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Thu, Oct 6, 2022 at 11:32 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> Fixes a warning in dc.c.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 40a34b600c8e..96bba1c8246f 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -3526,9 +3526,9 @@ static void commit_planes_for_stream(struct dc *dc,
>
>         if (update_type != UPDATE_TYPE_FAST)
>                 dc->hwss.post_unlock_program_front_end(dc, context);
> -               if (update_type != UPDATE_TYPE_FAST)
> -                       if (dc->hwss.commit_subvp_config)
> -                               dc->hwss.commit_subvp_config(dc, context);
> +       if (update_type != UPDATE_TYPE_FAST)
> +               if (dc->hwss.commit_subvp_config)
> +                       dc->hwss.commit_subvp_config(dc, context);
>
>         if (update_type != UPDATE_TYPE_FAST)
>                 if (dc->hwss.commit_subvp_config)
> --
> 2.37.3
>
