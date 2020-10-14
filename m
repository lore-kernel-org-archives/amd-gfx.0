Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20324C433E7
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 13:19:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98C6F2173E
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 13:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HP7gQ094"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C6F2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D86646EA98;
	Wed, 14 Oct 2020 13:19:38 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C2916EA98
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 13:19:38 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id d81so2278736wmc.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 06:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KM/WNSPSMxd/FuQ6XjIQxtY+elJtk1fXGagXUN7Xwns=;
 b=HP7gQ0942N5AN+EDjEd/9Uke+yHCNe98GkSFK0qZle/O/dsONx0rXSt2IiR8qXLyE7
 apOXCkHZN/cJrkQNC0kXa/dNPn6n3gRT9pIp2ymE4XVt/0RfZwEIFvgk7iu/m2SfOjaM
 H/xcTo75efICSwBOnGdcmvx1XelMIQ8uBqI+YSeiIMDWJiRfszUg0RnYtU7YlWVkOww/
 P/1q6L2I6sS2hAWRwwSl4Me0MoRhszVwg1+xygSwu6dPP62Os9Rcxtp6hnn6tG1c7P3E
 9pL3AWfYX+xunyVo2gFsY6KposcITN3hQ4yA0Z6dTLVDuPC/MPymZQ3jj3JNqr4erbmN
 JTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KM/WNSPSMxd/FuQ6XjIQxtY+elJtk1fXGagXUN7Xwns=;
 b=tHTk5F+pckkGtZqSptYg1nJ1Grtep+GAAm4Jw94gkhHkZJLB+BFQGfnvymZMhtW05A
 dKDgWgVJzwt2XvqNuEgKjpx2xuyPQZCQ8B51wW+4y1kjbE1enwYizuxgnBxwNvDPe0/F
 aIuDX8qsqmULQjThCnjHiWHm+n0jvcaAHLdKbACC8Io2pYg8hitM+JvjJ4FlI1tp5iJJ
 zmk8H6L7PJUTIaicBgim+lZXAnLRlYPCq/MeoyO0b3v/vf82eXMxJA06K2eJQtdLArPl
 3B1B3v1GqRt9zyEz1lJR4XkBZHfHaqwoHm0zhZ7Bu88Qbu4oht8S9HG8XGJgbrFZYYuV
 caOg==
X-Gm-Message-State: AOAM532h7/2rJa8dqvL2dFVBlkLEuyugNPqFVw1Dn8Dj5kVI1GlzVthH
 LMsjp17ncHt97rKhH8RBRs2Kim7R7N4xOKGgK3D+PEVt
X-Google-Smtp-Source: ABdhPJyzTZ9on6SOPlTeoSb+ZKp7H/45r8mD6ci6d+DCy5L6xMTMdvsVbki43otkGHvvr2Ba6STLCr/fXrm1rKOJ668=
X-Received: by 2002:a7b:c7d5:: with SMTP id z21mr3424466wmk.73.1602681577058; 
 Wed, 14 Oct 2020 06:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201014052023.7085-1-evan.quan@amd.com>
In-Reply-To: <20201014052023.7085-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Oct 2020 09:19:24 -0400
Message-ID: <CADnq5_NzUHFAUxyi+P7XGMhRzBeuo1W432WrvM1SCUnqrx8nHw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: populate the bootup LCLK frequency
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 14, 2020 at 1:20 AM Evan Quan <evan.quan@amd.com> wrote:
>
> As for other clock domains.
>
> Change-Id: I0a78c133f00cd11133bc755bf0443505088f024c
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h        | 1 +
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 5 +++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index fafa9c57e32f..9fa9473d418f 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -226,6 +226,7 @@ struct smu_bios_boot_up_values
>         uint32_t                        format_revision;
>         uint32_t                        content_revision;
>         uint32_t                        fclk;
> +       uint32_t                        lclk;
>  };
>
>  enum smu_table_id
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index a057d1d15087..fbf6d3e35173 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -603,6 +603,11 @@ int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu)
>                                                  (uint8_t)SMU11_SYSPLL1_2_ID,
>                                                  &smu->smu_table.boot_values.fclk);
>
> +       smu_v11_0_atom_get_smu_clockinfo(smu->adev,
> +                                        (uint8_t)SMU11_SYSPLL3_1_LCLK_ID,
> +                                        (uint8_t)SMU11_SYSPLL3_1_ID,
> +                                        &smu->smu_table.boot_values.lclk);
> +
>         return 0;
>  }
>
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
