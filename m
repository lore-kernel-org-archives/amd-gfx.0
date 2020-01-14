Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CFFC33CB1
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 14:39:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 543C22467D
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 14:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+vcukVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 543C22467D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08FE96E3F4;
	Tue, 14 Jan 2020 14:39:55 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69CE46E3F4
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 14:39:53 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id c14so12412088wrn.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 06:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hXmlHiAhI9T6fbWuV+7/OtdpaVR108QrAaZAGgfgtNw=;
 b=X+vcukVdqGRvX2nLK/vm4eS5zCxPOT+5ucU1UUtXpSQgfTQgT7O6iNVM9eF0AXaCa5
 cjnSSw7/1a+EHnv8iTI5Jo7zssXHrJNv2NN0AcZ8jPlb/4l09JHrij1RcwMZWp8hQOyg
 +n16d80/LzLMVjyEsOhrlbnt40OXxFh+E9A0JWSxSQtmOIoYzSu1SfcbDg97soEF5eni
 r62TSxCPi+LPRhMUbIxeLRTMMkqm75M0R3ejvHnS5vwPJaxnNVyImgB33ifC6dDbgbJ4
 E1tD+QusfoUbIAxcErCrl17LHs0FgFhvmWuleTrQj7yXKbcm7pwVhm5lX71TApyKOqPu
 w9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hXmlHiAhI9T6fbWuV+7/OtdpaVR108QrAaZAGgfgtNw=;
 b=NT/Bv0IbDXkxzfgr/aUqOJ3bBWeVMOPWvkfEYP9LrmDhsGPp+gd8HOxxUaoC3xUENW
 mfsFUWwqTH8qjMTwBeSfkFTF9NeIP+4hOy25JgO0KE+tgkpzFqdzJwx/IQDGaN+BHaCM
 yjDmElciJL1Z81cu3kTXmNidKkGg5wBcjwbQao7Zu+DTdZf3z/Xo6MptFxjHx+ubPldn
 2BVpzR+LsJd1O5ZqM5JSWfB4hK0Od3/yZA7KZYZXjDWfysI9VtNNyPPHEy89Sj01P+5W
 QaRL2dSvnzlow4sUv3Tt7sYueqmkxNSk1kVxNreyGsoWIfa1Xm3v5zoqArCmC3iCSiGR
 xdEg==
X-Gm-Message-State: APjAAAUpsTHobMiIP5GwwKKT/Zco56P9LvlO3ZlrMq5ipGqXNGu5nJpZ
 WES5GIoEh9tydQKRtf8Z7/QRlqsL5l4Slhj8rg48Jg==
X-Google-Smtp-Source: APXvYqzdy9OdWSWAPvNYBHtZ5nF0dkDcNtLDg6oEvhhd6KP0tbyTOXc4vh8Znrk+TuXYW0iot5YNeA/QVAjTjU5sFeo=
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr25340328wrs.11.1579012791948; 
 Tue, 14 Jan 2020 06:39:51 -0800 (PST)
MIME-Version: 1.0
References: <1579001495-20729-1-git-send-email-curry.gong@amd.com>
 <1579001495-20729-3-git-send-email-curry.gong@amd.com>
In-Reply-To: <1579001495-20729-3-git-send-email-curry.gong@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Jan 2020 09:39:39 -0500
Message-ID: <CADnq5_NxWS1i5b2E8PiKXUc_tB8DbgA2QunvUJvOiqM_w2qJbQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: reading register using RREG32_KIQ macro
To: chen gong <curry.gong@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

(On Tue, Jan 14, 2020 at 6:42 AM chen gong <curry.gong@amd.com> wrote:
>
> Reading CP_MEM_SLP_CNTL register with RREG32_SOC15 macro will lead to
> hang when GPU is in "gfxoff" state.
> I do a uniform substitution here.
>
> Signed-off-by: chen gong <curry.gong@amd.com>

Alternatively, we could wrap this function with amdgpu_gfx_off_ctrl()
like we do for the AMDGPU_INFO_READ_MMR_REG.  Maybe it would be better
to convert the amdgpu_asic_read_register() callbacks to use KIQ as
well?  That can be something to look at in the future.

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 425762a..cdafacc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4714,12 +4714,12 @@ static void gfx_v9_0_get_clockgating_state(void *handle, u32 *flags)
>                 *flags = 0;
>
>         /* AMD_CG_SUPPORT_GFX_MGCG */
> -       data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
> +       data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE));
>         if (!(data & RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK))
>                 *flags |= AMD_CG_SUPPORT_GFX_MGCG;
>
>         /* AMD_CG_SUPPORT_GFX_CGCG */
> -       data = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL);
> +       data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGCG_CGLS_CTRL));
>         if (data & RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK)
>                 *flags |= AMD_CG_SUPPORT_GFX_CGCG;
>
> @@ -4728,18 +4728,18 @@ static void gfx_v9_0_get_clockgating_state(void *handle, u32 *flags)
>                 *flags |= AMD_CG_SUPPORT_GFX_CGLS;
>
>         /* AMD_CG_SUPPORT_GFX_RLC_LS */
> -       data = RREG32_SOC15(GC, 0, mmRLC_MEM_SLP_CNTL);
> +       data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_MEM_SLP_CNTL));
>         if (data & RLC_MEM_SLP_CNTL__RLC_MEM_LS_EN_MASK)
>                 *flags |= AMD_CG_SUPPORT_GFX_RLC_LS | AMD_CG_SUPPORT_GFX_MGLS;
>
>         /* AMD_CG_SUPPORT_GFX_CP_LS */
> -       data = RREG32_SOC15(GC, 0, mmCP_MEM_SLP_CNTL);
> +       data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmCP_MEM_SLP_CNTL));
>         if (data & CP_MEM_SLP_CNTL__CP_MEM_LS_EN_MASK)
>                 *flags |= AMD_CG_SUPPORT_GFX_CP_LS | AMD_CG_SUPPORT_GFX_MGLS;
>
>         if (adev->asic_type != CHIP_ARCTURUS) {
>                 /* AMD_CG_SUPPORT_GFX_3D_CGCG */
> -               data = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D);
> +               data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D));
>                 if (data & RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK)
>                         *flags |= AMD_CG_SUPPORT_GFX_3D_CGCG;
>
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
