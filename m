Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B88C4BA14
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 14:12:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64EC424683
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 14:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r024qCf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64EC424683
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B1116E2C8;
	Wed, 26 Feb 2020 14:12:27 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B5BF6E2C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 14:12:25 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id v4so3194563wrs.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 06:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Nade0rXrw/kkDRwVnp37g55O5r5I4aixfjxRTu0Sdfk=;
 b=r024qCf+nlNh7iSlXaYTyulxeSvxuXxDsbLNmjUpeNwI7iNFQ/miX/XZkoJ4DCSCGJ
 v6VsxdNmbpbWaoXiC5ZdohpOvCF/d1G3mAdRWkHZO/q5eV8wUz9gaRoaB5HL7tUqft1d
 c87X+MtsSJKJlezZoHPuAKeec1l3ZEe20khVBp0w4oNtdCQ6POrBX4eBp5IHHnpDkS/3
 ifgdwK1XeUwMIND0YS5HbSIaLb/c9BLV+cJRzxEOKDXMq1jlkJ0eEOvZ54Bkqr0JA1Ps
 QTPhpBXR1gBJekV87Lq9Gb9qO403BfDF1Hm5qeKuRbOf6rnNxMhBToIMX0ns7NY56pcF
 PYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Nade0rXrw/kkDRwVnp37g55O5r5I4aixfjxRTu0Sdfk=;
 b=CoWjaWOSzBPR3pK0vh0bXnvMDfsUKeNJ7ksFbK68ZZYvW30DHQUhX3c/cucM34J1RW
 h9I+qydl1K/XHsNymroxFW1wxRDKWn46AQAAugpWldQQzMI/ldQnIr//CcRDulCvPc6U
 QNwkajaUv2EwPn8PT3XmWQosesqaPyZNhtscS1LiN2abhhGqS+oS9H0CL5qytgbmrIpY
 VhS+idJq7+BH2EQeZfE6cmQfgGo7wSJ5mmyNoBnEZK5ctGCqTqDYRav8irQNhLr899xb
 3GNVABVqXWNxNn7Pro2amLkNKOAQ+hjGomYYE4DdqR5ikwYCfidOjg6T8yKMz8hAX1HX
 dJ9g==
X-Gm-Message-State: APjAAAXl/EhEXro+iwTkMsJL9jTFHDtxOTvAle+UXvpD/Pp6iiEE9CLM
 ILf8oubjTQHOj8ubSb2NhkgMEMKe5Mne7BUULBFwyQ==
X-Google-Smtp-Source: APXvYqwPDsluJyl9yB2wUl84V1YK/AGHrhxpLi6hAk/KI09jFoDuDGtqFzmA/VPOd2h5ivvQL3DrCrJhB1/Wh7S01ok=
X-Received: by 2002:a5d:5745:: with SMTP id q5mr5935997wrw.374.1582726343763; 
 Wed, 26 Feb 2020 06:12:23 -0800 (PST)
MIME-Version: 1.0
References: <20200226024526.16710-1-Rohit.Khaire@amd.com>
In-Reply-To: <20200226024526.16710-1-Rohit.Khaire@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Feb 2020 09:12:12 -0500
Message-ID: <CADnq5_NqD-mnwwiAeHRyfsYu0FrvW5JOVbXcADLv2zud=ePxsw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Write blocked CP registers using RLC on VF
To: Rohit Khaire <Rohit.Khaire@amd.com>
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

On Tue, Feb 25, 2020 at 9:46 PM Rohit Khaire <Rohit.Khaire@amd.com> wrote:
>
> This change programs CP_ME_CNTL and RLC_CSIB_* through RLC
>
> Signed-off-by: Rohit Khaire <Rohit.Khaire@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 44f00ecea322..8f99bc6163b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -1783,11 +1783,11 @@ static int gfx_v10_0_init_csb(struct amdgpu_device *adev)
>         adev->gfx.rlc.funcs->get_csb_buffer(adev, adev->gfx.rlc.cs_ptr);
>
>         /* csib */
> -       WREG32_SOC15(GC, 0, mmRLC_CSIB_ADDR_HI,
> +       WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_ADDR_HI,
>                      adev->gfx.rlc.clear_state_gpu_addr >> 32);
> -       WREG32_SOC15(GC, 0, mmRLC_CSIB_ADDR_LO,
> +       WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_ADDR_LO,
>                      adev->gfx.rlc.clear_state_gpu_addr & 0xfffffffc);
> -       WREG32_SOC15(GC, 0, mmRLC_CSIB_LENGTH, adev->gfx.rlc.clear_state_size);
> +       WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_LENGTH, adev->gfx.rlc.clear_state_size);
>
>         return 0;
>  }
> @@ -2395,7 +2395,7 @@ static int gfx_v10_0_cp_gfx_enable(struct amdgpu_device *adev, bool enable)
>                 for (i = 0; i < adev->gfx.num_gfx_rings; i++)
>                         adev->gfx.gfx_ring[i].sched.ready = false;
>         }
> -       WREG32_SOC15(GC, 0, mmCP_ME_CNTL, tmp);
> +       WREG32_SOC15_RLC(GC, 0, mmCP_ME_CNTL, tmp);
>
>         for (i = 0; i < adev->usec_timeout; i++) {
>                 if (RREG32_SOC15(GC, 0, mmCP_STAT) == 0)
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
