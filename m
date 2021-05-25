Return-Path: <SRS0=WUpi=KU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A123DC47084
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 13:26:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D4B7610CB
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 13:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D4B7610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBB7C6EA26;
	Tue, 25 May 2021 13:26:04 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36B116EA3F
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 May 2021 13:25:26 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 d25-20020a0568300459b02902f886f7dd43so28565529otc.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 May 2021 06:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xn+RW2mevtL7gfBRUkGMsTsda3iCSpJqTPV3CgleP3I=;
 b=cP17c1Be5lTf48+5UsM4OOgEEBtynfbVmavLzpu7pBAbJRbrlCcfmZE7c22ySmtPaF
 wPNPqPHnuN/XcgZhpWwD2YUcuONn9fSpIKdWVBz6uva07GtUBfKlIc7A/8Wybd/+gtrD
 STGzkWh8T9JXwk8ifnm+pdCoxf6bBq118eyyqYPx6be/9nHIOHkWkT/dAb2Cj97OjzFr
 JPe5VmHnjNiy4k64FmSi4RDMQ3H44POz/o9KGEV9EILQ9oqdrVXquR8DCrb7nSnayFk4
 Nok9IcM5TfZj4HgMFeRXWHWmujjOvGYhVsgf9kAi8DQpfzuba2LnDXoFMKzgzrhIsEX6
 1VKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xn+RW2mevtL7gfBRUkGMsTsda3iCSpJqTPV3CgleP3I=;
 b=cB3ZGLsjCt1At4c4N1LNe7IYFIPJh1yXNUUmPuvysrkdh+EqH23k6JEDm45GGwoBFM
 18v2Cpklg8FrwHkjqYgdF7zS9IpcY+AgsntQJCVseRbGoDziQj/ZKd2QCi98Uyx4DgyZ
 AAzSGHvoi6h0cIpJBE2WSjkyURKnFOchO5HXgindkj9VI5h4EzObRiZ9ln45qub2rlVP
 8SZl6qXmuiWHVZjOcRJ6qJDQaHCDuql9wW2R+7rwe1ALWf+gJd1Ajd4OXD6z4CDzdBGM
 zhMHABouuxeYYr28b3pv8jqKOwb3gfndjTBPgIVRGISp3Ev11CX6q8QKCquDEMuDbWt1
 Q5/Q==
X-Gm-Message-State: AOAM532yuqQLr/L8IefY5OlkHqE7RFe87RA9NpgBzz6n1Bdw8HmokhP0
 02Kfd1zgEOSe+ffWZtraNJwNSAFpucCSIwgScZY=
X-Google-Smtp-Source: ABdhPJwsurmIhw843tG+ePGBCepk2opcB6Q0BQKrXp4IpivRMbfPz3VSukRwmftae3rVz/K+dbskxcAcZ8gv2Lz2DoA=
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr23654021otl.132.1621949125400; 
 Tue, 25 May 2021 06:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210525102852.2983-1-PengJu.Zhou@amd.com>
In-Reply-To: <20210525102852.2983-1-PengJu.Zhou@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 May 2021 09:25:14 -0400
Message-ID: <CADnq5_NezGXsZJNbi7Ebdc=4xR0Rm_jAY-hX2cqDM--VdRBSQA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Change IP init sequence to support PSP
 program IH_RB_CNTL on NV12 SRIOV
To: Peng Ju Zhou <PengJu.Zhou@amd.com>
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

On Tue, May 25, 2021 at 6:30 AM Peng Ju Zhou <PengJu.Zhou@amd.com> wrote:
>
> To enable PSP program IH_RB_CNTL,
> the PSP IP should be initialized before IH IP, otherwise,
> it will hit psp NULL pointer.
>
> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 437db0783b64..27ba0408a2aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -849,8 +849,13 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
>         case CHIP_NAVI12:
>                 amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
>                 amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
> -               amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
> -               amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
> +               if (!amdgpu_sriov_vf(adev)) {
> +                       amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
> +                       amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
> +               } else {
> +                       amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
> +                       amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
> +               }
>                 if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)
>                         amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
>                 if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
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
