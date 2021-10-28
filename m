Return-Path: <SRS0=JMr/=PQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B17C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Oct 2021 14:47:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15D3160E8C
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Oct 2021 14:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 15D3160E8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A39106E991;
	Thu, 28 Oct 2021 14:47:11 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8E116E991
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Oct 2021 14:47:10 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 o10-20020a9d718a000000b00554a0fe7ba0so3050411otj.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Oct 2021 07:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qtHJtKwnsjwUXhc4WAITYXnHmD4vneQ9UOSDUwwuSjI=;
 b=NTmzUpcYGgHkcRsRpf2K4PQEiBsCcd5pyde6GgbSwchx3GNZ4KLzekyEy19u54bE8m
 fKn2pNC374n1bdozLDVytFWHnGcaPIrtDYaiAnDSNeZAM55pjy6BlGtzW2plXhROlPEY
 O/25OE2093B1v3aTeESFBBdTmEktlVOkwV7vZRhGcGwZkXsi93BY9tkQrTs+7y/oVGeK
 f/C8WUYGrJfAQ/5yQpKWzPVYMGTJaGn+6fX3fwHZLmi4El9sviJr5b9w14Fa7sGTSg6s
 NdPj72sUF/ZwW4D0nytbJOtUXKGEiUBBO2YLvggpFWcKqQOeX0liMfZVHK5HEQDlgd2N
 PtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qtHJtKwnsjwUXhc4WAITYXnHmD4vneQ9UOSDUwwuSjI=;
 b=TRKB28Y6jK0nhx0mqXztHnUBJuR8OemMI3F2jSDQr2sDABy2xNA52gbLS+YJnVqqLW
 zi1eLBFhTWo4JYdOlZ8j/ygr2IRs7OfRXKF2doMP6xG+kWE5Za+pdtHmnxvASgxhlqEe
 Wk3yZIvnzAtb2/lkIV0gABe9/S4kS+QISDIyM5NYHSFVBCH7y/nprM7K9audgG7pQsY8
 I83Fv0SZSC+g9EPQHp2q1TK3JuCDyhIeGRd3SvOJd1hZNPRh8VpaQp3zUSPziSokTpJM
 X6kjJP6jtJ39tfboHvfjsg28B5/So/4zSWeZ2Kha+6Lg79c8x/JtuYfZYePIyAKq3/z5
 8PBA==
X-Gm-Message-State: AOAM531ORn3aWWi002UVLRETDXRykLr3DQIuNf5r3zEJWP/+gS6/jsw8
 Tg/A//fb259lD6MDxKuQEQUi3B+K6g+AzVHeLt2ZYkWhwGc=
X-Google-Smtp-Source: ABdhPJw4y/gzFBkiVZX8pwuPaN8ZbawU3q3XqO2IJOfcqBIpKcQPArWUTQBzMDnpoIGQ2CSpMZxTFqok4fD/SWHZLm0=
X-Received: by 2002:a9d:718e:: with SMTP id o14mr3855406otj.299.1635432430174; 
 Thu, 28 Oct 2021 07:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20211027223953.1776162-1-alexander.deucher@amd.com>
 <20211027223953.1776162-2-alexander.deucher@amd.com>
In-Reply-To: <20211027223953.1776162-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 Oct 2021 10:46:59 -0400
Message-ID: <CADnq5_OjdSuwdA2LM-ikM5rs4_AjrqsVa=t8i0Rdw6pr1sKrPA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: fix build when CONFIG_DRM_AMD_DC_DCN
 is not set
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ping

On Wed, Oct 27, 2021 at 6:40 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> Need to guard some things with CONFIG_DRM_AMD_DC_DCN.
>
> Fixes: 707021dc0e16f6 ("drm/amd/display: Enable dpia in dmub only for DCN31 B0")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 3f36dbb2c663..6dd6262f2769 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1108,7 +1108,9 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
>         case CHIP_YELLOW_CARP:
>                 if (dc->ctx->asic_id.hw_internal_rev != YELLOW_CARP_A0) {
>                         hw_params.dpia_supported = true;
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>                         hw_params.disable_dpia = dc->debug.dpia_debug.bits.disable_dpia;
> +#endif
>                 }
>                 break;
>         default:
> --
> 2.31.1
>
