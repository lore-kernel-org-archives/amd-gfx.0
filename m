Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05066C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 18:29:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC9A911BFE2;
	Thu, 30 Jun 2022 18:28:53 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7483211AF5D
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 18:28:52 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id ay16so40647772ejb.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 11:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KqwriWH0oMHhzruT5vsHZAyNl4aDldbtEfHkuSXvH/E=;
 b=Ewy/GrpJoTBkfWJ8TzF1yXJAcj7zxoXcCzh3XONL3Vh3vcQihgQUgmLNfIRMMUzgqV
 hDzsISg9JdS6qAX3iwa0k7GKMZ2b1ZZnynVvRKXDM1yIPpfPLQOqem5K20z65uZ5sInx
 AJICRv57PF2UGojQv9R3MdP/2kAi9XWXAtITV2wYjgkDj8hLCrucndqamkQWTsc4R26W
 4PCzRoRw/Oj6d9KiKqCAB0pce2vQWzZyr0ui9ZEymfGZVkI7E2GTTWx/xZ7uDu0Jnx3P
 WUSGHcYkDZVEuB3R2Oc81dX6asuhCa0mSxCCM7/hY+LWbkYk7AFRzqLEYEuvPUuUBSin
 PxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KqwriWH0oMHhzruT5vsHZAyNl4aDldbtEfHkuSXvH/E=;
 b=MwewFdm0iR63gxq/ISm/FkrSq6DGQ0hcDil15uMSN0Ld/OQcm7j1VCq1JIo4/tFZeP
 GwO6ch0HtskMNS1smIHWJYu3hVSb1PokZnjOjs7dp8IkgoP81DALTDS238tPyCdwE+n8
 zFrsSgPsnzi+XY9gD6EprwFWGchzprTMXvpRIH46KQhToMqIuaLS2L4FlYt8pHK6RJ5B
 2jGLYvSPrRjY4STUk0BQ9GySSJWRz/z3thHApQFRRfiWsi6mDT0bihWTdXL/my1Xqz1i
 fFPeTblfG4PMNVR1ZI7h56lM+F9yNxNiA044kG8QnU/ZgT6S5HRmi7WNjTMMA+91VjyY
 K18Q==
X-Gm-Message-State: AJIora87+fx/85wmQWjM8AsiTj7juhp45Qi+OYTmImQrCTOtUk/oREpb
 cJCHsDRd+SX6+KGWYGnTtrjtNevRtk6l73oycMJwoKL8
X-Google-Smtp-Source: AGRyM1vISZcHXwUkm1qM5eKlPQ28aI720e7YVkGeyXxDkfU+4p+9Dq6ui9MsiuhV51pIrpkvX6wz3fJi/oxji4JLyPw=
X-Received: by 2002:a17:906:5d0b:b0:726:a043:fcb4 with SMTP id
 g11-20020a1709065d0b00b00726a043fcb4mr10459503ejt.508.1656613730971; Thu, 30
 Jun 2022 11:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220628212635.2263706-1-aurabindo.pillai@amd.com>
In-Reply-To: <20220628212635.2263706-1-aurabindo.pillai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Jun 2022 14:28:38 -0400
Message-ID: <CADnq5_ND=YHJ_gTx5VLOx7zJzRbaZmCQHA2uo5HZHBrjzvyDMw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Add debug mask for subviewport mclk switch
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
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
Cc: "Wentland, Harry" <harry.wentland@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 28, 2022 at 5:26 PM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
> [Why&How]
> Expose a new debugfs enum to force a subviewport memory clock switch
> to facilitate easy testing.
>

Is the debugfs support already plumbed in and this just enables you to
use it?  If it's in debugfs, do we really need a module parameter to
enable it or can it just be enabled by default and used via debugfs
when needed?

Alex

> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
>  drivers/gpu/drm/amd/include/amd_shared.h          | 1 +
>  2 files changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index c9145864ed2b..7a034ca95be2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1559,6 +1559,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>         if (amdgpu_dc_debug_mask & DC_DISABLE_CLOCK_GATING)
>                 adev->dm.dc->debug.disable_clock_gate = true;
>
> +       if (amdgpu_dc_debug_mask & DC_FORCE_SUBVP_MCLK_SWITCH)
> +               adev->dm.dc->debug.force_subvp_mclk_switch = true;
> +
>         r = dm_dmub_hw_init(adev);
>         if (r) {
>                 DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index bcdf7453a403..b1c55dd7b498 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -247,6 +247,7 @@ enum DC_DEBUG_MASK {
>         DC_DISABLE_DSC = 0x4,
>         DC_DISABLE_CLOCK_GATING = 0x8,
>         DC_DISABLE_PSR = 0x10,
> +       DC_FORCE_SUBVP_MCLK_SWITCH = 0x20,
>  };
>
>  enum amd_dpm_forced_level;
> --
> 2.36.1
>
