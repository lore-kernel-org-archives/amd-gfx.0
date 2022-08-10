Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097BEC00140
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Aug 2022 16:39:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A770818A95E;
	Wed, 10 Aug 2022 16:37:01 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21BB214A8E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 16:35:13 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id w197so5297109oie.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 09:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=u8yHwcZjwogyUbRDEZ3azdOScbZUsGNDHdwbVyrRpUI=;
 b=VZmJh6/X+7lwEPCWOklKS8ZysHJh+x58bovk/TSCRcucKb9/BQ0UVrD65z3c4Td6p0
 Hk3/cuHAoRiKKq2dFILSPiVmCDYWgRmbBbbkVsk8tpszB8Z39oAjprfZmg8NOWRkwAbN
 VYHVW55nHsTZmHQpH6CAQfoc372URwz1+7qCpvUiIOF0DFq95ZVBNtgmx76N0iLwefkb
 FMcKK3uchNfA2e8tJdeWETHGvZBpsJcBdg1OZjJ0y2ZYGscjqYU3CCNhDfeO4iWjhWoZ
 raEBNBFZzoxsO/2JZu1S/7N7iDoo5WQNxdXOabKOp1k4SU41i9h0bwzJ9wYBssPa3hFW
 jOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=u8yHwcZjwogyUbRDEZ3azdOScbZUsGNDHdwbVyrRpUI=;
 b=QpDQtt4SUYUNl1NPBEVvwYmqB+D/C+nT/6epp7TvzWsieb8u0eWvq07itbEsHUg6Sq
 awuA8DgXlBZgdybKRYv8FP1V7WjJc82milKiP1Tb5L5QjurReZQaARGZyw5UJ6L2Qw7L
 QfXDeT9qki20wf2ejuCcetTOCCHL+5fFAr8l56fAs0BQWQa1FL+2DTy5lREULjt2ekkd
 Cu+MNgf1HbmWxIbDpRrwG+PjjZV//hzamMwkX1H5t9ybbCrcg7jy4GFtcCJujnE04ti7
 am6WFFuuE9XOD2tO1AFQXQS009YfYtPmX/5jvLZgBi9U+LxSFrJoeH9OnybhYVjEuT5m
 S83A==
X-Gm-Message-State: ACgBeo1jDE6A2e1BMti2S1X3b3qQctPofnGgpW5O6A5NQkyhWQDgO42L
 wQKBMkKD0qOayQgHoBBK4VYQn90a/Y3aGT94lVzU0nk7
X-Google-Smtp-Source: AA6agR6FS4CQNoWUIylU4OKtd1ZfJV7mePzCzxmpLEC22RobfxyZZuKCe79NlGr4pSj8CMNZQ0boSjcTCPR4oxkat/s=
X-Received: by 2002:a05:6808:19a3:b0:33e:1525:3fb4 with SMTP id
 bj35-20020a05680819a300b0033e15253fb4mr1777426oib.106.1660149311282; Wed, 10
 Aug 2022 09:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220805160930.13664-1-shaoyun.liu@amd.com>
In-Reply-To: <20220805160930.13664-1-shaoyun.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 10 Aug 2022 12:35:00 -0400
Message-ID: <CADnq5_N18cwfpxO-U7yhp2snY170_Y07f2xddCzdf4pjn-hwaQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: use sjt mec fw on aldebaran for sriov
To: shaoyunl <shaoyun.liu@amd.com>
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

On Fri, Aug 5, 2022 at 12:11 PM shaoyunl <shaoyun.liu@amd.com> wrote:
>
> The second jump table is required on live migration or mulitple VF
> configuration on Aldebaran. With this implemented, the first level
> jump table(hw used) will be same, mec fw internal will use the
> second level jump table jump to the real functionality implementation.
> so the different VF can load different version of MEC as long as
> they support sjt

You might want some sort of mechanism to determine if the sjt firmware
was loaded so you know whether live migration is possible, although I
guess it's probably only used in controlled environments so it would
be a known prerequisite.

Acked-by: Alex Deucher <alexander.deucher@amd.com>

Alex

>
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index c6e0f9313a7f..7f187558220e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -126,6 +126,8 @@ MODULE_FIRMWARE("amdgpu/green_sardine_rlc.bin");
>  MODULE_FIRMWARE("amdgpu/aldebaran_mec.bin");
>  MODULE_FIRMWARE("amdgpu/aldebaran_mec2.bin");
>  MODULE_FIRMWARE("amdgpu/aldebaran_rlc.bin");
> +MODULE_FIRMWARE("amdgpu/aldebaran_sjt_mec.bin");
> +MODULE_FIRMWARE("amdgpu/aldebaran_sjt_mec2.bin");
>
>  #define mmTCP_CHAN_STEER_0_ARCT                                                                0x0b03
>  #define mmTCP_CHAN_STEER_0_ARCT_BASE_IDX                                                       0
> @@ -1496,7 +1498,11 @@ static int gfx_v9_0_init_cp_compute_microcode(struct amdgpu_device *adev,
>         const struct common_firmware_header *header = NULL;
>         const struct gfx_firmware_header_v1_0 *cp_hdr;
>
> -       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
> +       if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_ALDEBARAN))
> +               snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sjt_mec.bin", chip_name);
> +       else
> +               snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
> +
>         err = request_firmware(&adev->gfx.mec_fw, fw_name, adev->dev);
>         if (err)
>                 goto out;
> @@ -1509,7 +1515,11 @@ static int gfx_v9_0_init_cp_compute_microcode(struct amdgpu_device *adev,
>
>
>         if (gfx_v9_0_load_mec2_fw_bin_support(adev)) {
> -               snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", chip_name);
> +               if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_ALDEBARAN))
> +                       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sjt_mec2.bin", chip_name);
> +               else
> +                       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", chip_name);
> +
>                 err = request_firmware(&adev->gfx.mec2_fw, fw_name, adev->dev);
>                 if (!err) {
>                         err = amdgpu_ucode_validate(adev->gfx.mec2_fw);
> --
> 2.17.1
>
