Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF6EC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 15:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEA9564E04
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 15:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA9564E04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4539289E86;
	Mon, 15 Mar 2021 15:05:33 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9695C89E86
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 15:05:32 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 g8-20020a9d6c480000b02901b65ca2432cso5281762otq.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 08:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pZQnZyrqFY28jgPfI3hD0i2MzFBu70J581ahh1orOdQ=;
 b=DXvFhFSNldlg/sHML4WNqrrUZ8LKgUCpPS9WBc6E/U2NWuBcrI0im0Gk3ZgJTo9FFS
 EyjWMNrn7ReCbLGft0UB7ffBYnoi9j6ZbUuFOT8hzIfYrUML66tFyf036ggfGfiI3Vz2
 1i9cIJHRxxDtio3ilHRIlNOFCP7miYFOA/Rh8YKODEBEjkNuK8m9zf5mZPUO5UAu5RFB
 yAAAYtJ3nX5LCkpIiXV6ZKEsiyyE0MnO76wWLJ3Ntdj8FdFnhyEy38dXQudw7LhwyEGn
 u+IQxz1lA5M2VjqCyqgHwm2marD4Mk9IMVnwnRWHjqKkOUSV77Y3btQ+nZtMVRodLWLq
 xO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pZQnZyrqFY28jgPfI3hD0i2MzFBu70J581ahh1orOdQ=;
 b=bh4tJd7hOyNZ0Lnfh7ap0o3ldSRt9r1BSZ3x2TL8d6thfWr2vp44Frf4/VZrEwNeJ2
 ElpJvgZjlGbCfff//xvVlRGs+CDTVm8nvrYrmFnn0ufx/JN9u2/mD3phDLWea5o7Q1m/
 Njqs8/ogiwzKFHGSIGxiEjzOL52WGEhSLEfOFAwXWl8ufFNFSpeR7toUrJsPubb9/7sZ
 susU7+ruYCEXkIK0DIBX8D/UBY1q4SpbyG2tASfaIh6JSjIWlcbwXOhoMcv0hvHinslO
 d2P6H7+xZmfcrwJgzKwsXkWff7IfNGoF2IlgQ8s8t4gPfaV7R3n66wCYHoAwtqvKebpb
 h5vg==
X-Gm-Message-State: AOAM533hVdaJDEdYHmwfxQT0XQctS9V3D1prCrs+ASJwm2fUICaICVTr
 WIp5/AVkAK9ctSYQuzsvGygY8SWTyKzmPtTNLik=
X-Google-Smtp-Source: ABdhPJzrAEFT2o/9swfVF2swMUJVSSF3V+yAn05NjTJHsCllNpTc0GxkZW4A+DZd5St5/YDiV2jKRtTrkndE3Sm9L0A=
X-Received: by 2002:a9d:20c3:: with SMTP id x61mr14343647ota.311.1615820731926; 
 Mon, 15 Mar 2021 08:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <PSXP216MB0438E23D0F4C2DFF2D9B8686806D9@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB0438E23D0F4C2DFF2D9B8686806D9@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Mar 2021 11:05:21 -0400
Message-ID: <CADnq5_Mqc3H07BtJbaGpt8XGnpXgaZvxDsS_e0cnZ++kWdQR-g@mail.gmail.com>
Subject: Re: [PATCH 1/1] amdgpu: use MMIO to init atombios if device is
 Thunderbolt / USB4 attached
To: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 15, 2021 at 4:04 AM Nicholas Johnson
<nicholas.johnson-opensource@outlook.com.au> wrote:
>
> When using some Thunderbolt hosts using BIOS-assisted PCI enumeration
> with IO BAR assigned, we get an atombios timeout, such as:
>
> [drm:atom_op_jump [amdgpu]] *ERROR* atombios stuck in loop for more than 20secs aborting
> [drm:amdgpu_atom_execute_table_locked [amdgpu]] *ERROR* atombios stuck executing B456 (len 304, WS 4, PS 0) @ 0xB51B
> [drm:amdgpu_atom_execute_table_locked [amdgpu]] *ERROR* atombios stuck executing B104 (len 183, WS 0, PS 8) @ 0xB17E
> amdgpu 0000:08:00.0: amdgpu: gpu post error!
> amdgpu 0000:08:00.0: amdgpu: Fatal error during GPU init
> amdgpu: probe of 0000:08:00.0 failed with error -22
>
> A workaround is to use MMIO to access ATOMBIOS when device is
> Thunderbolt / USB4 attached.

Missing your signed-off-by.  Also, we can just remove the legacy IO
callbacks altogether.  They are leftover from radeon and not required
at all on amdgpu.

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> index 86add0f4e..5d16ec10d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> @@ -1999,11 +1999,15 @@ int amdgpu_atombios_init(struct amdgpu_device *adev)
>         atom_card_info->reg_read = cail_reg_read;
>         atom_card_info->reg_write = cail_reg_write;
>         /* needed for iio ops */
> -       if (adev->rio_mem) {
> +       if (adev->rio_mem && !pci_is_thunderbolt_attached(adev->pdev)) {
>                 atom_card_info->ioreg_read = cail_ioreg_read;
>                 atom_card_info->ioreg_write = cail_ioreg_write;
>         } else {
> -               DRM_DEBUG("PCI I/O BAR is not found. Using MMIO to access ATOM BIOS\n");
> +               if (pci_is_thunderbolt_attached(adev->pdev))
> +                       DRM_DEBUG("Device is attached via Thunderbolt / USB4. Using MMIO to access ATOM BIOS\n");
> +               else
> +                       DRM_DEBUG("PCI I/O BAR is not found. Using MMIO to access ATOM BIOS\n");
> +
>                 atom_card_info->ioreg_read = cail_reg_read;
>                 atom_card_info->ioreg_write = cail_reg_write;
>         }
> --
> 2.30.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
