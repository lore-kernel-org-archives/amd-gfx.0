Return-Path: <SRS0=LN+i=D3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBC0C433E7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 12:27:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD8722265
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 12:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t1NAZQQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD8722265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33F496EC87;
	Tue, 20 Oct 2020 12:27:16 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E0ED6EC87
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2020 12:27:15 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id a72so1582284wme.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2020 05:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=q3v97x5tvYaj3Rj4VmKumvFQESxkFr0wARUu/8grPHE=;
 b=t1NAZQQKrX2I5dzMkwmu9pDhWyTlvZl9+u0f1XCvAcv5frLVkkuPWXR50jwJ1tNXQ2
 VD6BhZ7AChHe4YUnRhD7AuS0Dszour55HLAH+wbH8iUKQQT0MILHTpawCRi4sCVEuGnp
 p27KMGWKm37sHJqN3ESfLyLykHhGHEoRXiwabhWlKd97wII3X6+3DrHQxd7I+paZ9ZoE
 5ZkEmw+BJzYCy/Acckd/oQCeEEtKoyP7oyxT/1K4Pgk9LPgwlUZgGWf+63z0UplUinga
 MPzUDcj3jjN40NMxfqA2yFTjmWEDfWHQoC9XvG7W5rruB3bVEQGu4xRpVgyOeVqT9K+X
 AEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q3v97x5tvYaj3Rj4VmKumvFQESxkFr0wARUu/8grPHE=;
 b=uVcfw1BnvC8aSWXbu/wfE7idfw04YIQX5GgfjPno4QRjNzOdJrvXKCG3SfxmflAe+i
 3K1afnZ0XmCrayl9Bt377N4hNHt1uSpVTdasSoN+5kjjZCv4pTpj15IujCWyKZKj4HUZ
 wrwQSamNugvgWRCD4QWgw7Z+3zQRQHqrP86mEb8FtmYeScJkXazJmyQLRKf6XcLAwAYz
 3m/AWjApQF/L1TIR32Xv7ZuHfwXgx2A85BDLIJKPPfsJGIzFq+WU7OyS9069CAeD6wnp
 Qq1Fh1PzpM3tmk7sjP8qkiGr2QZBEZtE25Ci8jE8uNgEsEkA58lTVG8nSXtLKsf4aY9i
 MIjQ==
X-Gm-Message-State: AOAM530BdgRPvHr8m3Crw2EZxgehbTGeWT9ljWlb2SRZHyNoYAFJUInp
 uZkSR2KJL3YpEpIP08Qnd1NcVRNlmEbYcPSLZJ0=
X-Google-Smtp-Source: ABdhPJxc6W7WQ0H0v1tCnbA/0OJOdopQvC8MbR81MowdFmOKQgowxkgqVhLTkesVj7D7GP7nsB7qsn6QZC9AneNyGp8=
X-Received: by 2002:a7b:c7d5:: with SMTP id z21mr2676920wmk.73.1603196834053; 
 Tue, 20 Oct 2020 05:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20201020064846.3155-1-yifan1.zhang@amd.com>
In-Reply-To: <20201020064846.3155-1-yifan1.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 Oct 2020 08:27:02 -0400
Message-ID: <CADnq5_NFy2G_=UGrTXUtdq43EWQ+=LHD0CU7vUvn2v51Mk-ocQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix the display corruption issue on
 Navi10
To: Yifan Zhang <yifan1.zhang@amd.com>
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
Cc: "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Oct 20, 2020 at 2:49 AM Yifan Zhang <yifan1.zhang@amd.com> wrote:
>
> [Why]
> Screen corruption on Navi10 card
>
> [How]
> Set system context in DCN only on Renoir and Cezanne
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 3d534a4da20b..6855aad7f312 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1061,10 +1061,12 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>
>         dc_hardware_init(adev->dm.dc);
>
> -       mmhub_read_system_context(adev, &pa_config);
> +       if (adev->asic_type == CHIP_RENOIR) {
> +               mmhub_read_system_context(adev, &pa_config);
>
> -       // Call the DC init_memory func
> -       dc_setup_system_context(adev->dm.dc, &pa_config);
> +               // Call the DC init_memory func
> +               dc_setup_system_context(adev->dm.dc, &pa_config);
> +       }
>
>         adev->dm.freesync_module = mod_freesync_create(adev->dm.dc);
>         if (!adev->dm.freesync_module) {
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
