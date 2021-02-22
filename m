Return-Path: <SRS0=DoF4=HY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FE1C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 18:25:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D41AC64DDA
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 18:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41AC64DDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6062D6E105;
	Mon, 22 Feb 2021 18:25:33 +0000 (UTC)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57C0D6E105
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Feb 2021 18:25:32 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id x10so3207859oor.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Feb 2021 10:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YxdS9pnfbCYZOigVQADRlyAGeYw73h+ZvoIeXH+2X+c=;
 b=Gp/tc4pLy6IrouVql+4OIii6Uti99A4uVDViYN3DcVYGO6sRoxjeYy5yH+LiuZCsDX
 AWi+KZdBupdw7/JI/doYqUErVI8ybs3Wc7Eg1NK8fIAlluxRKB4dtS85+1S34xofLEJf
 cxvvV14vdgLKdGs7daqRnfxrjMo0Uxcnf5iddtiFEZPjzEoWDMRt0xrsz3UT47fPTvl4
 wdNKjWWjZU6kTM+xBbr087moKap+Oea20rbyXMV1kxqpeOIx5hJ10vzqLKoIXyvmqZbc
 ZS8AOlWzSVuLg3LeVTuO1jA9QTM7F/unv/OPwOtNPjUOa8bOSP30PX4clMlYpmQz+1QM
 TMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YxdS9pnfbCYZOigVQADRlyAGeYw73h+ZvoIeXH+2X+c=;
 b=P3ZpVkAbSdXFlR/g6IvzLdE5CveCywir6/ZvHe5rO2mIQ0JF7RIP50mrwgL1PHpcYP
 5AUkRbXOgnZcxvxeqSPEf1v7P6xFhGOCackkUpt4pWeK82NqJ1neCGXJ69LMc/qn+cxq
 LyOau1r73NHoYyrZu0VCZclsCGmMpS0xw5ie7O1e1qXOlC7oYjEMyacKGpTQAoLUOyHZ
 fu0odCsi8ABRdq12Mrh7HjrQ9ce4KpDJerxm9K5pR58Ed2mSUHgtcQeada8uYYY5Revx
 KxYsn4cRRpZNnoNUmrTLUNa5OvxzJPa/4wVBj2qPHfO/UTaGT9ikVkKexD2uL7gmof9c
 8Y1g==
X-Gm-Message-State: AOAM531JvQ1+cxGRQklRX/OmMhsHWAqGYexHeE6OGRiIRM5/KQ+hf5ep
 CdaYaM+zZbmTkfTc9qr9Y0TgvRV2l+AvIULEpUw=
X-Google-Smtp-Source: ABdhPJxn9KQWql/UVlKieyrrPlNorXl9Dx1hirhwHSGZPBAHL0detWsz/bIOq2VGIO2Vs9qJ9DH0vxy363Vw0Q/rbMo=
X-Received: by 2002:a4a:9801:: with SMTP id y1mr1235273ooi.90.1614018331607;
 Mon, 22 Feb 2021 10:25:31 -0800 (PST)
MIME-Version: 1.0
References: <1613982242-23437-1-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1613982242-23437-1-git-send-email-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 Feb 2021 13:25:20 -0500
Message-ID: <CADnq5_O-KYkG49JnBCCrc5uYk7ha4RzDr=dKBQiVD+QPbJjy8w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix shutdown and poweroff process failed with
 s0ix
To: Prike Liang <Prike.Liang@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 22, 2021 at 3:25 AM Prike Liang <Prike.Liang@amd.com> wrote:
>
> In the shutdown and poweroff opt on the s0i3 system we still need
> un-gate the gfx clock gating and power gating before destory amdgpu device.
>
> Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1499&amp;data=04%7C01%7CPrike.Liang%40amd.com%7C24759f57e2644f26deaf08d8d4302cc3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637492650673813454%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=I0rH%2FFt2cs%2BdNwvNdqWKPE%2B3bOosUyBodViUsEwb6tE%3D&amp;reserved=0
> Fixes: 628c36d7b238e2 ("drm/amdgpu: update amdgpu device suspend/resume sequence for s0i3 support")
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 6 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 9 ++++++++-
>  3 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 9bf7f49..0035c91 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1007,6 +1007,12 @@ struct amdgpu_device {
>         bool                            in_suspend;
>         bool                            in_hibernate;
>
> +       /*
> +        * The combination flag in_poweroff_reboot_com used to identify the poweroff
> +        * and reboot opt in the s0i3 system-wide suspend.
> +        */
> +       bool                            in_poweroff_reboot_com;
> +
>         atomic_t                        in_gpu_reset;
>         enum pp_mp1_state               mp1_state;
>         struct rw_semaphore reset_sem;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2f9ad7e..f0f7ed4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2676,7 +2676,8 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
>  {
>         int i, r;
>
> -       if (!amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev)) {
> +       if (adev->in_poweroff_reboot_com ||
> +           !amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev)) {
>                 amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>                 amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>         }
> @@ -3739,7 +3740,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>
>         amdgpu_fence_driver_suspend(adev);
>
> -       if (!amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev))
> +       if (adev->in_poweroff_reboot_com ||
> +           !amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev))
>                 r = amdgpu_device_ip_suspend_phase2(adev);
>         else
>                 amdgpu_gfx_state_change_set(adev, sGpuChangeState_D3Entry);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index b7ee587..b539628 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1278,7 +1278,9 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
>          */
>         if (!amdgpu_passthrough(adev))
>                 adev->mp1_state = PP_MP1_STATE_UNLOAD;
> +       adev->in_poweroff_reboot_com = true;
>         amdgpu_device_ip_suspend(adev);
> +       adev->in_poweroff_reboot_com = false;
>         adev->mp1_state = PP_MP1_STATE_NONE;
>  }
>
> @@ -1320,8 +1322,13 @@ static int amdgpu_pmops_thaw(struct device *dev)
>  static int amdgpu_pmops_poweroff(struct device *dev)
>  {
>         struct drm_device *drm_dev = dev_get_drvdata(dev);
> +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
> +       int r;
>
> -       return amdgpu_device_suspend(drm_dev, true);
> +       adev->in_poweroff_reboot_com = true;
> +       r =  amdgpu_device_suspend(drm_dev, true);
> +       adev->in_poweroff_reboot_com = false;
> +       return r;
>  }
>
>  static int amdgpu_pmops_restore(struct device *dev)
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
