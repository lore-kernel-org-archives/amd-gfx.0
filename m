Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58855C32771
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 22:05:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9499810E122;
	Mon, 26 Sep 2022 22:05:34 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A31F10E122
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 22:05:31 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 x23-20020a056830409700b00655c6dace73so5312706ott.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 15:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=UQoYX4F4Rf/6pBtXgwhhsGdSOM0ZYz1IyRnEzjQfiTo=;
 b=Djj4wMzWGxvra9TXPxAnvX9a38UfNOlpHjR1aB5BL1uDuYkKsj3U7pm5TLhsXBQldS
 yT+6P10U7ghgJ4XVxpUVsn8TtfnvjqCS8hJO8An8VH1aqVxnFtzkKEQTeKEZ8tLsmDEo
 eGynep1k61216+4mpR3+bzGStx+g/boEJuwqgyQzqzdgUfVMd5bHB0piv/o0s8fMKM+i
 ry7Rz70AsnklQxiCBWadlkeskQy1Pi2DL50pKcOV4VVfWFJsmgrzT72Cwh6g0GabnhLK
 ZncSNPuTnnF22WIv4QIqLjGRDcTNBeyYjYVajKTG372I4ZU6uQiYlkEXn2xEJrlLrwM3
 Mr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=UQoYX4F4Rf/6pBtXgwhhsGdSOM0ZYz1IyRnEzjQfiTo=;
 b=OA//utGna+c+Mce/OcRvRj12cv3KEfAB/8lxsy3XnqT/coBIa38j71/97g0uCwEKUF
 aeFC8AlZ5C9iuLpybZQPN0FSS5SbIvi7loZEtSvCUpFymQ8m6oe85Zkh7f2hbhlGp61j
 mVgtson1azvYhI9xVYfZ2Doqy4g5wxDNpE6T+OwSFbmEb/j6YfQsOTq8CEH6iOC9Mfxg
 dYGVUNR/L2Pc2NpRQWnef56J7zE6rQhXQsdG8M+I5bxSUrgTohKIY1D6Q8yWWAqoFGkH
 gRw4/z002oZbcFdlZqhb/0BR0t6xi+J+wYmEzD/PtMbLgMJgJPh2gtvqUSDR9lwjG0ZW
 entA==
X-Gm-Message-State: ACrzQf14YuZD/takzM5mE3+VsszvL66XN4G5ztDm3GZBNqV/XcfTsRpt
 xbNirCDOuDczf0jGL31gu6sYXL7JAT7+wK7RT/pjOd48
X-Google-Smtp-Source: AMsMyM6d7C9VcwYFl0gxTAY4577t9qx48/wxYbEkSlaUucqnbioVsYW7tmjIEqMgxhp22exhgsOnEJYkRu5Cdnh5VLA=
X-Received: by 2002:a9d:376:0:b0:655:b4bc:fd6e with SMTP id
 109-20020a9d0376000000b00655b4bcfd6emr10987943otv.233.1664229930709; Mon, 26
 Sep 2022 15:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220926202024.8216-1-Bokun.Zhang@amd.com>
In-Reply-To: <20220926202024.8216-1-Bokun.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Sep 2022 18:05:19 -0400
Message-ID: <CADnq5_OAWaC0HSCK0PV+42PNgbaA+yPyrkEe-uE-0+KvMCcAzw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add amdgpu suspend-resume code path under
 SRIOV
To: Bokun Zhang <Bokun.Zhang@amd.com>
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

On Mon, Sep 26, 2022 at 4:21 PM Bokun Zhang <Bokun.Zhang@amd.com> wrote:
>
> - Under SRIOV, we need to send REQ_GPU_FINI to the hypervisor
>   during the suspend time. Furthermore, we cannot request a
>   mode 1 reset under SRIOV as VF. Therefore, we will skip it
>   as it is called in suspend_noirq() function.
>
> - In the resume code path, we need to send REQ_GPU_INIT to the
>   hypervisor and also resume PSP IP block under SRIOV.
>
> Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c   |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 27 +++++++++++++++++++++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index c5fad52c649d..a5aee19ca30e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1057,6 +1057,10 @@ bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev)
>  {
>         if (adev->flags & AMD_IS_APU)
>                 return false;
> +
> +       if (amdgpu_sriov_vf(adev))
> +               return false;
> +
>  #ifdef HAVE_PM_SUSPEND_TARGET_STATE
>         return pm_suspend_target_state != PM_SUSPEND_TO_IDLE;
>  #else
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index fb09dc32b4c0..c5c94ebd3d57 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3176,7 +3176,8 @@ static int amdgpu_device_ip_resume_phase1(struct amdgpu_device *adev)
>                         continue;
>                 if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
>                     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
> -                   adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH) {
> +                   adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
> +                   (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP && amdgpu_sriov_vf(adev))) {
>
>                         r = adev->ip_blocks[i].version->funcs->resume(adev);
>                         if (r) {
> @@ -4120,12 +4121,20 @@ static void amdgpu_device_evict_resources(struct amdgpu_device *adev)
>  int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>  {
>         struct amdgpu_device *adev = drm_to_adev(dev);
> +       int r = 0;
>
>         if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>                 return 0;
>
>         adev->in_suspend = true;
>
> +       if (amdgpu_sriov_vf(adev)) {
> +               amdgpu_virt_fini_data_exchange(adev);
> +               r = amdgpu_virt_request_full_gpu(adev, false);
> +               if (r)
> +                       return r;
> +       }
> +
>         if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DEV_D3))
>                 DRM_WARN("smart shift update failed\n");
>
> @@ -4153,6 +4162,9 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>
>         amdgpu_device_ip_suspend_phase2(adev);
>
> +       if (amdgpu_sriov_vf(adev))
> +               amdgpu_virt_release_full_gpu(adev, false);
> +
>         return 0;
>  }
>
> @@ -4171,6 +4183,12 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
>         struct amdgpu_device *adev = drm_to_adev(dev);
>         int r = 0;
>
> +       if (amdgpu_sriov_vf(adev)) {
> +               r = amdgpu_virt_request_full_gpu(adev, true);
> +               if (r)
> +                       return r;
> +       }
> +
>         if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>                 return 0;
>
> @@ -4185,6 +4203,13 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
>         }
>
>         r = amdgpu_device_ip_resume(adev);
> +
> +       /* no matter what r is, always need to properly release full GPU */
> +       if (amdgpu_sriov_vf(adev)) {
> +               amdgpu_virt_init_data_exchange(adev);
> +               amdgpu_virt_release_full_gpu(adev, true);
> +       }
> +
>         if (r) {
>                 dev_err(adev->dev, "amdgpu_device_ip_resume failed (%d).\n", r);
>                 return r;
> --
> 2.25.1
>
