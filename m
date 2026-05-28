Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B24CD4F54
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 13:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A1A810F1A1;
	Thu, 28 May 2026 13:34:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TzTeLODU";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F35D810F1A1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 13:34:00 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2f5ae07e2b5so1064481eec.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 06:34:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779975240; cv=none;
 d=google.com; s=arc-20240605;
 b=XMJBSW/GwegMZ0JV705I2YxLA1zV9VPqmsIFJP92Q98Ec+f0k57y5hAbLdtZYGjQdA
 5uvc2/qf8gHwlsqoNUdUi4ZTECw8zTEMnjNGEa/laqrWixSrdnqHad/d1ozeRWIy5ToD
 ytiYzAv+vlk17pomoD2h26pqilwyq7UWQ82bpcpo0Kn7WnPxtWTbHfpsgBA9VlnWPjwS
 VXCYjxQDsKv01mo2GxHRe7v+ecooOJJzOsrh9u/+sXYb8iJF/kG0RfOvTOtD/oO3f/bZ
 h0d9wKYZHRmlnBDb+KM+jR31+9VMCetPI9/5cNfxjlgJV0qemZj/5VLpiNiNmKv7I+/M
 AhiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6OYf3QnxkYH1sKoBofKMD6en8CMb8tbG+Gm/leMdwFI=;
 fh=JhEcmjXq9HYu4HZw4rbX6bzs+kinZu2PaI8RTIjVGiQ=;
 b=j5akT6oLr07Cs+av9Gpjo1jh3Oc308Ks90f9QV5lW6yNlo+fmkgQm8eRw4iFCXN+Wg
 drfvIbBv1lzSPaic2Pl9sViMHjRV3G6NNjVZVCbhXUTYZJh/kIKVnYDmMyPf6CqBwcFa
 tgX52mC1+/8amlgFw4qA8RokfriJ1AVQDuPLoVqncG87lkY34eBgMeI1igw99DU6naBh
 /A2wV9it9nXde6KbJ/ODRhUWTrWMPG9t8PbjTOOEPbDTfCDiVvYlg85Bmhm0BsQUHQqt
 JCl/fgXVYJ8OOpfcimIAMnmETULv/NijhLxGjwrWovBvlrC6ADb9qXn6iOq4cB+oLpiP
 3TKA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779975240; x=1780580040; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6OYf3QnxkYH1sKoBofKMD6en8CMb8tbG+Gm/leMdwFI=;
 b=TzTeLODUHa2N77A4HOcUJrqamGx8pp/SpBpQgai4ww+117NNGj9GerjL0TeJ4SZtHK
 5dGLo/mGQRoX0avfzfUbgXDSDdVXAgg3r4ft7vg8KtwshUwTEpDZPAwnrKhsr26KGUul
 6qL+kHPNBhjHP4XbYXS9ShqHY0imONo6f0rpkOXzlMMAEsyCrSuIquUQz0rTZlYO52WN
 UXD1NBaDicVG7CoGhp8vM7/Kp2IduXAve4BEoReXye73pQ3KzWFQcZ79tV2HYa4dQGd1
 P+IQcFyp5Ghwi1+b/RRqsSb4g5ho4K21rLLDly0delZ6tDz02uVhsiLt2IC6nfSVELuo
 qqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779975240; x=1780580040;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6OYf3QnxkYH1sKoBofKMD6en8CMb8tbG+Gm/leMdwFI=;
 b=gE1v0mhV1bC9acrLo2BZEe8CJgXMP3B6Eg1TviepafqxgHH9o2AcMPtGmDRjMtr3y7
 9zYXrYS1uR1XGGM5iAK2QICAKL4tmTGdVKSze9pSm8xnvFMDFfdHduD2irG8m2oI4DvP
 mPNVcZWhxKzOS4JoQB8n79nYiIcM1+0wKjml6JboI3L6RlutY0fWl0Zff0EvRs2No6pV
 d8aeoCbjEr7+X8UcLrZCL4SF2RJ87CaD/fI0KueDqi77wSq618vB6lRBkSKd+49F/Mbg
 idd67V7O4v/FQmue1HPnLnaTEUIlGNxXGma/s7A+e0JPOQX1D2EmuadoZTZEeKYC0SzT
 BAvQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Bybw9uSEj2oJVhoQAcQ3h5fdC6AJMWmz52r5EKKideJDRC56EGsP4qddg9p5M+ArDEEFaVWxR@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz71Bo5mabizIHookmQzvjV/M9BfNFct7r2YcQh5t1qjs4hSB4q
 bIofMWaBdPbsxHToOji3Fz9mphlVB8jLE9uJ8cDq1JxlYoZJwajHX04uWNx5hoAPXieGDPY9S+y
 sc9cm+J8fPETcyFnlsaLZtawXhx8oqcA=
X-Gm-Gg: Acq92OHWAAOHAcRrx75aNP56ExEi9e9XnTcdJHPOFoqQSyYrSW++3vjdDTsOUJ6rB57
 TYjAgRIAkDUBtlKjH+BeT3PYf4HjkaUeu5OLfM4moyRJ/OFju4pVYPr7MFxOmHfAKD7zHKgGaHs
 QJ8DAavusGwrRJBhXzUlsr7uQOUvyyjwMkDzzdJSHfVV/DSLABJN2joeZiQQ9KKpvVzO9WtEXEL
 8V3zb/FxY25v/35VpmmlZIek+WG5mivt6ug5LGUnIOLHe8bNedvshU7TU0IfXFETUwBYRrEtRQp
 jYB1hL90ZE00qXfF6FtPXxHbGNIujR74d6yLxserTt4PFuev5vEIPD2qwXrwHij6pmFFXwv049z
 NNqqwUc7iwC4AlM8=
X-Received: by 2002:a05:7300:1805:b0:2f3:3835:2005 with SMTP id
 5a478bee46e88-304d2ef2446mr653592eec.6.1779975240149; Thu, 28 May 2026
 06:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260528064206.12358-1-Pratik.Vishwakarma@amd.com>
 <20260528064206.12358-2-Pratik.Vishwakarma@amd.com>
In-Reply-To: <20260528064206.12358-2-Pratik.Vishwakarma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 May 2026 09:33:48 -0400
X-Gm-Features: AVHnY4Lr5KI03N0GcvlKMwLRo1iufVrqYdr8ADw2JntDhfzC3zj98-ULT5r6Rig
Message-ID: <CADnq5_Pgiqitj-+t50Forc0LtGnYtH=fAHnCDJHbhZpHLRsH_w@mail.gmail.com>
Subject: Re: [PATCH 2/8] drm/amdgpu: add support for SDMA IP version 6.4.0
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, May 28, 2026 at 3:59=E2=80=AFAM Pratik Vishwakarma
<Pratik.Vishwakarma@amd.com> wrote:
>
> This initializes SDMA IP version 6.4.0.
>
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        | 1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 5364b0540613..e23eda0c4ea5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2542,6 +2542,7 @@ static int amdgpu_discovery_set_sdma_ip_blocks(stru=
ct amdgpu_device *adev)
>         case IP_VERSION(6, 1, 2):
>         case IP_VERSION(6, 1, 3):
>         case IP_VERSION(6, 1, 4):
> +       case IP_VERSION(6, 4, 0):
>                 amdgpu_device_ip_block_add(adev, &sdma_v6_0_ip_block);
>                 break;
>         case IP_VERSION(7, 0, 0):
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v6_0.c
> index bf09ac841a68..d894b7599c18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -55,6 +55,7 @@ MODULE_FIRMWARE("amdgpu/sdma_6_1_1.bin");
>  MODULE_FIRMWARE("amdgpu/sdma_6_1_2.bin");
>  MODULE_FIRMWARE("amdgpu/sdma_6_1_3.bin");
>  MODULE_FIRMWARE("amdgpu/sdma_6_1_4.bin");
> +MODULE_FIRMWARE("amdgpu/sdma_6_4_0.bin");
>
>  #define SDMA1_REG_OFFSET 0x600
>  #define SDMA0_HYP_DEC_REG_START 0x5880
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_device.c
> index 69facc5a544a..57b40f4d035c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -106,6 +106,7 @@ static void kfd_device_info_set_sdma_info(struct kfd_=
dev *kfd)
>         case IP_VERSION(6, 1, 2):
>         case IP_VERSION(6, 1, 3):
>         case IP_VERSION(6, 1, 4):
> +       case IP_VERSION(6, 4, 0):
>         case IP_VERSION(7, 0, 0):
>         case IP_VERSION(7, 0, 1):
>         case IP_VERSION(7, 1, 0):
> --
> 2.43.0
>
