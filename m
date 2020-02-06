Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B229C352A3
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 19:27:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D09821775
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 19:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YItvg52s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D09821775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7BE36FB2F;
	Thu,  6 Feb 2020 19:27:31 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70B3F6E1F2
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 19:27:30 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id f129so1434495wmf.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Feb 2020 11:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JNG+gzJIgq1UTobw38YyUGDqVQ/Lt4xnjooDs7FbPMo=;
 b=YItvg52sh4XodhATEoHIu8CPATanmUWHl1C3QpZUKeAWVrIXWJSrF/t8VsT4m2Kop5
 gK2rqR3Bc6BIsq9xOLu/AgiMrrbNMQQ9J1/PIiGhG4XPJjU4uHERR7lj63Au/YVJEUEV
 uA30OGU4o6E8zwtQSSRt7GFM0tbLEci+yyVMbyyhbJxcWbbSv988RQafj45BoKNZBW36
 infkTj8OhBfDlr5tBYUnFKGLY8zZqJpEIAZkrGR36C2A1Hr7n0bxPvSTIOqdJI1LSIUu
 4LzSjCJEaiztv5vjOXgVJp4f+OdIqUmn3m+j3FOG+dHqQPdNtyrC+lUx62yo6VwdJ+UC
 WrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JNG+gzJIgq1UTobw38YyUGDqVQ/Lt4xnjooDs7FbPMo=;
 b=GNeslcwI33WXWAzH165jU2lMcXlVk5DL/ZpvnH6Bt1VVHqEZC429JAHqO/druX0RBb
 F8qn6K3T00rYDpDHryl5x3WchNhjUb4DptcQ+xPhRwxkrJA5ksQsxa32aNI0iDaJWoCT
 AGllTYQysn8h2XGsucVv2jLxpDv7tNj3UhiICwbkUnXB9NnX1aXMKmcJttiOZYrUgBXc
 GwmvsDnjxKFcFj8rMuRfpxh/41zvnvdHB5m+90BVWkyTPuU38AwqFMMWAqa52i8wH0p3
 EaXpqAhaNr0ZmmPI2t1KPwSGGGjvjwBwbYA5RqOdDri/+u52gs8p//6eSIrvnkslSX8s
 zSJw==
X-Gm-Message-State: APjAAAXfUwi5flinrq9Tl04vdT2ZJT2YImx/9IDJj34SkoYA3HUO73R2
 qUtcTIHpRmShdpQ+C9i3iYHRrBK85P8ANbeuTrohRA==
X-Google-Smtp-Source: APXvYqzjF4wptsg/+OkGXtgnuHMZ0gQr2kFtR4NTautyo9qvsyYR9r7WMUMV3j0BH5nSq2qcj4IK3vHBMdTIEs2BdvA=
X-Received: by 2002:adf:8b59:: with SMTP id v25mr5538058wra.419.1581017249137; 
 Thu, 06 Feb 2020 11:27:29 -0800 (PST)
MIME-Version: 1.0
References: <20200206191435.12715-1-daniel@octaforge.org>
In-Reply-To: <20200206191435.12715-1-daniel@octaforge.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Feb 2020 14:27:18 -0500
Message-ID: <CADnq5_Mc=P5WtGXRKnv_URZeF9YBaaT754ZzJE4O6pLeoqRgbw@mail.gmail.com>
Subject: Re: [PATCH] amdgpu: Prevent build errors regarding soft/hard-float FP
 ABI tags
To: Daniel Kolesa <daniel@octaforge.org>
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

On Thu, Feb 6, 2020 at 2:21 PM Daniel Kolesa <daniel@octaforge.org> wrote:
>
> On PowerPC, the compiler will tag object files with whether they
> use hard or soft float FP ABI and whether they use 64 or 128-bit
> long double ABI. On systems with 64-bit long double ABI, a tag
> will get emitted whenever a double is used, as on those systems
> a long double is the same as a double. This will prevent linkage
> as other files are being compiled with hard-float.
>
> On ppc64, this code will never actually get used for the time
> being, as the only currently existing hardware using it are the
> Renoir APUs. Therefore, until this is testable and can be fixed
> properly, at least make sure the build will not fail.
>
> Signed-off-by: Daniel Kolesa <daniel@octaforge.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> index b864869..6fa7422 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> @@ -91,6 +91,12 @@ ifdef CONFIG_DRM_AMD_DC_DCN2_1
>  ###############################################################################
>  CLK_MGR_DCN21 = rn_clk_mgr.o rn_clk_mgr_vbios_smu.o
>
> +# prevent build errors regarding soft-float vs hard-float FP ABI tags
> +# this code is currently unused on ppc64, as it applies to Renoir APUs only
> +ifdef CONFIG_PPC64
> +CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn21/rn_clk_mgr.o := $(call cc-option,-mno-gnu-attribute)
> +endif
> +
>  AMD_DAL_CLK_MGR_DCN21 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn21/,$(CLK_MGR_DCN21))
>
>  AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCN21)
> --
> 2.25.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
