Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5618C6FA82
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 18:10:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D76AA10E044;
	Tue, 27 Sep 2022 18:10:10 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEC9410E044
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 18:10:04 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1319cf91d8aso351126fac.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 11:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=eJS/uw1ZrpoZqH7yf1EXq4VeNO+vLn805coWvmg+iv4=;
 b=OkO72ASRx/8ouXgdUqklK+6sQBffTZkWdsIhLbhF/OYWgKutJdC+g6ZVtzcmmFAi2H
 spCzNwwhuLFXqfcCPcOUJiDXsMQvvia9vdWPL5jetcKl1UA4g0HfSzywDxi3SQ8+V2bi
 uGZdzmbmqsJqz0m8jg8RizPOPTWs/plfOyQm9l9P+YQewIy749WkD0wMKLmQcjxQ6cwu
 /W0Oe0hvq8n5sjBB5x/TnfjMmXLebdcRAuCsTeLiiUVGfwMWW0smoMoJvV2Se9ixVpdr
 XV4zS4rVihYg/2n49Z9d3QoixT/eMRohtSpxrFOt0ZDJb//b9a0OOirQNcKP/nyiAZTl
 1/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=eJS/uw1ZrpoZqH7yf1EXq4VeNO+vLn805coWvmg+iv4=;
 b=zHUJ42xtPjOT+qeQpZeNLHlMwzqVbRR7V2ETurIJzeCbBL4j/l6bCZgYRH01TAuOCw
 Wbi/Pj/tECussfEIjlycmBDieu20MU5f1GIHW9RrBySrDcpyCeMohO/MiXOmUQMUSIRu
 lygnVuls8wctfzXhcema9bqBkHJTGei4B9xLf14SEL8Ch/T1fA9FPOmf2t4eWWBzwOCX
 naJd/z2oV2/KuaaooDLyS4tQRKCwVp8dA+tPacul+rmz/5jk5zTQvkjgNfAi+D91YS7g
 wBe5Ui+X+ta7khbkxvE/flUeAPD1A9Vk3tWlUs6AEAUd+W1ciU6oIFBSBHgiDnsYeCzr
 cgMw==
X-Gm-Message-State: ACrzQf1hie+BqjGeAhdC8Vq6XPfY63OZVhqc3NcgYGtZ5KWjdD1yHXQU
 BJxH7V4RV9ZfBqKmh9vT/y+XJpgsJGECVZGMvsQ1cAM6
X-Google-Smtp-Source: AMsMyM6B5Qr7DYLfqIyKUDBUGdmEXngZVfLB0hcc0qgVhUx7gbPR0PzQ2dKo484W7342iXqRiKdZ0mA17dQlefn4alc=
X-Received: by 2002:a05:6870:c5a4:b0:131:6edd:3955 with SMTP id
 ba36-20020a056870c5a400b001316edd3955mr3043286oab.96.1664302203678; Tue, 27
 Sep 2022 11:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220927175702.7585-1-mario.limonciello@amd.com>
In-Reply-To: <20220927175702.7585-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 Sep 2022 14:09:52 -0400
Message-ID: <CADnq5_P5OR=qOhPD9hUjE+qWJSvN=jC2KBR45OTjvgqSvNdOdA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Add a new parameter that can force reset on
 suspend
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: kolAflash@kolahilft.de, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 27, 2022 at 1:57 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> We previously had in place some behavior that would cause APU or GPU
> to be reset during suspend entry.  This caused various problems, and
> eventually was reverted.  There are however users that preferred this
> behavior, so add an option that they can use to force it.

You should never need to reset on suspend unless the platform is not
actually going into a low power state.  The reason the reset was added
was as a workaround for aborted suspends so that we can put the GPU
into a known good state if we need to re-initialize the hardware with
the device not actually having been powered down.  In most cases I've
seen where a reset "helps" it's because the GPU was not actually
powered off during suspend.  Adding a workaround like this will just
hide actual bugs or users will read somewhere that they need to set it
and it will break suspend for them and then we'll get spurious bug
reports.

Alex


>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216516
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 8 ++++++++
>  3 files changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index ae9371b172e3a..85999f48e2835 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -230,6 +230,7 @@ extern bool pcie_p2p;
>
>  extern int amdgpu_tmz;
>  extern int amdgpu_reset_method;
> +extern int amdgpu_reset_on_suspend;
>
>  #ifdef CONFIG_DRM_AMDGPU_SI
>  extern int amdgpu_si_support;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index b14800ac179ee..17c0a0ec21bd6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1051,6 +1051,8 @@ bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
>   */
>  bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev)
>  {
> +       if (amdgpu_reset_on_suspend >= 0)
> +               return !!amdgpu_reset_on_suspend;
>         if (adev->flags & AMD_IS_APU)
>                 return false;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 16f6a313335e9..6a786dacf2c2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -179,6 +179,7 @@ int amdgpu_noretry = -1;
>  int amdgpu_force_asic_type = -1;
>  int amdgpu_tmz = -1; /* auto */
>  int amdgpu_reset_method = -1; /* auto */
> +int amdgpu_reset_on_suspend = -1; /* auto */
>  int amdgpu_num_kcq = -1;
>  int amdgpu_smartshift_bias;
>  int amdgpu_use_xgmi_p2p = 1;
> @@ -870,6 +871,13 @@ module_param_named(tmz, amdgpu_tmz, int, 0444);
>  MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco/bamaco)");
>  module_param_named(reset_method, amdgpu_reset_method, int, 0444);
>
> +/**
> + * DOC: reset_on_suspend (int)
> + * GPUs should be reset on suspend (-1 = auto (default), 0 = no, 1 = yes)
> + */
> +MODULE_PARM_DESC(reset_on_suspend, "GPUs should be reset on suspend (-1 = auto (default), 0 = no 1 = yes");
> +module_param_named(reset_on_suspend, amdgpu_reset_on_suspend, int, 0444);
> +
>  /**
>   * DOC: bad_page_threshold (int) Bad page threshold is specifies the
>   * threshold value of faulty pages detected by RAS ECC, which may
> --
> 2.25.1
>
