Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4A8C54EBE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 15:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49D4C10EA12;
	Fri, 13 Jan 2023 15:07:53 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C63510EA27
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 15:07:50 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-15eeec85280so1433828fac.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 07:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3squmkvf8+Hyo4sOkO0tbwQ+mJfb+vZx3IOuGl3coY8=;
 b=Q7A2tf6w3gi52IDlJV+0i5/KUmJ/Mo8eWOyKXlX7mmSGGCDYUhceXDF4vBtzS/HwIj
 DF2wfaKAp8Gmy9QVAtTlrNz1oT2Vz8V61OipirH40HnEQhcFBQiNUVMPsnCVODpNoNqN
 Ecep8w5svMt6dzKBrAvwwi2Ns9mCdzYrASk9zQg8p22jlFA+g2ZqREZvYS8fV6dddMSh
 K19k+Sw6eQUTUTj8Jxi4v5C0J0wx7G8C6Md1uKMpik5fWMYP36mUdqZIi52+SUNW+Y3N
 sbe07teVIX/ufomNOcqEvYMR/B943WRfI5SukdEe0W7fUqFpQyB9HI8w8dB0J4LdFqna
 33YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3squmkvf8+Hyo4sOkO0tbwQ+mJfb+vZx3IOuGl3coY8=;
 b=wrscJuR7EHmymJunChJ4ufOsiJzkB3HAHAncpxCPLGu3SmbzI2MBsx7ZPdaZ2yvjxV
 T8lF4/GZMPx72r8OQpp8Uc/DHmCJdyr01GvGO/4YBUv1I2xjfMEt4DZ1j9zG8Bo3ec5t
 8rKIlKR8zZYQ0iCRgYenXZWBX+LwbYLceaXQPiGF4K+wBgMSFZXHQCd/opB0828TOK8t
 Kvr/e4crHyGjl/JIKAW3t6OHrOF45MN6/xT2x5z6HH48ugzXylmwVUBLTqNT0m7NcscT
 xD+MgbctqO+Y1MxgnEMH7e7z5Vmj6mS/m5t+qM1tTtBrHPOsgJaXZ9f/xF3M3cpDCzHF
 xFSA==
X-Gm-Message-State: AFqh2kr8tBXgyOYRhJskFFZHr/kTFKDz9XD27Ryt9FBG3SdnDpO3+O1J
 k78DAL7uKuJdOz/Q38cjFAwPL0vrVnx7cfPCJi736oYI
X-Google-Smtp-Source: AMrXdXtsq8XabHAo4Dfy/VX2EaLmSZJs7TcfO9oJKDZbKTnYSE7iLuhbAP97U9Za3q3jFwKzjjPEfsqQ3uFQ3EZWnGY=
X-Received: by 2002:a05:6870:970e:b0:148:3c8f:15ab with SMTP id
 n14-20020a056870970e00b001483c8f15abmr6930876oaq.46.1673622469199; Fri, 13
 Jan 2023 07:07:49 -0800 (PST)
MIME-Version: 1.0
References: <20230113094445.5933-1-vitaly.prosyak@amd.com>
In-Reply-To: <20230113094445.5933-1-vitaly.prosyak@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Jan 2023 10:07:37 -0500
Message-ID: <CADnq5_N85j2NCem0-d0y3EBmyvR=ba0hF44+1DQrj982WgA-Zg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: revert part of a commit fac53471d0ea9
To: vitaly.prosyak@amd.com
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
Cc: alexander.deucher@amd.com, yipeng.chai@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 13, 2023 at 4:44 AM <vitaly.prosyak@amd.com> wrote:
>
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>
> Revert the following change: move drm_dev_unplug call after
> amdgpu_driver_unload_kms in amdgpu_pci_remove.
> The reason is following: amdgpu_pci_remove calls drm_dev_unregister
> and it should be called first to ensure userspace can't access the
> device instance anymore. If we call drm_dev_unplug after
> amdgpu_driver_unload_kms then we observe IGT PCI software unplug
> test failure (kernel hung) for all ASIC's. This is how this
> regression was found.

Maybe just revert the entire patch rather than a partial revert?  That
said, reverting the change will break
driver unload because we need to send certain messages to the PSP to
clean things up.  I'm not sure
what the best way around that is.

Alex

>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 06aba201d4db..8a1047224000 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2226,6 +2226,8 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>         struct drm_device *dev = pci_get_drvdata(pdev);
>         struct amdgpu_device *adev = drm_to_adev(dev);
>
> +       drm_dev_unplug(dev);
> +
>         if (adev->pm.rpm_mode != AMDGPU_RUNPM_NONE) {
>                 pm_runtime_get_sync(dev->dev);
>                 pm_runtime_forbid(dev->dev);
> @@ -2265,7 +2267,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>
>         amdgpu_driver_unload_kms(dev);
>
> -       drm_dev_unplug(dev);
> +
>
>         /*
>          * Flush any in flight DMA operations from device.
> --
> 2.25.1
>
