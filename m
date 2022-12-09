Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BAD7C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 21:58:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40C1410E58A;
	Fri,  9 Dec 2022 21:58:37 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A23E710E58A
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 21:58:34 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 y18-20020a0568301d9200b0067082cd4679so238653oti.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 09 Dec 2022 13:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YA8u60foL3aaJIIwfZkGtTRQNobqhGJeviYn93z3opY=;
 b=jtV+yRUQyLnpOfQNgS4ieBDsTu1lJYtPpZ7E++Ek2s4XaY21Za6mWtP+959P9dZSzV
 Y+NqLAo5+2WGRtG/COu2Sfy/IuFn3EYm/VAYx53TtyNw9NgVQx08X1BfP1Ly8iRg3BFt
 ++2x4Ls1/99UwegIqwJPbqR3gPSh80s+mNVy4hCWRhlDJWGGAutW3Qv43sl5juiefW0d
 ThV3I52bcBtJ/4lN4UXtBXkWsn5yV+Mu8CooRAFsPh1SVxrDCWc0qs9RHkUx+P4nzCjy
 kxjXCIJXxZnxht0htcT8AWA/l2MD1syr8hfAG2cH1zeh02bU//a1mFJZnjaZ6RWsktsh
 jVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YA8u60foL3aaJIIwfZkGtTRQNobqhGJeviYn93z3opY=;
 b=kelxjFOG1c+TnoyB004vb65+de4JGlS4RyL6eTzk8qNwmMlFVVuq6beBHtGL4InF/I
 PFRGgukQ7VWIlLLDU03EUIChaj7CRl3uhyjioRV3WTJ+hfsmuKj6kdXm6oT/dgB4oaU1
 pOsbhmfr22eJG5hu7cOTRyuBL1NBYY/zD3fFK5vYs1wgKEekQ/DFiDUL2NzfLzJn93Gy
 NKyRQXEPH3yYVIVvH9k1h1IL9iZH1mPq9IQ6FJXgaiF2+l1+HU1nSTtrc1N+usH/+a1y
 4hG/6aubCueuw+ULNJqOK9QAbGkJhPaIxZwYkeWsyceSwBihtkWf958UomhIAHs+Z9JL
 GxWw==
X-Gm-Message-State: ANoB5pmkev43SitIwhJlHAx8SQp64JxdgbNJaQqvL0pr35OzVAT7ciXs
 LA6qnRKpgf4X6EX6Laj8Dm9tyr4r5O19IiCxrqFSEmzq
X-Google-Smtp-Source: AA0mqf5RPyt+yBQ3WuqLgCvCXatCj7GezxjYAr6i7EKXg/EASrki+OoF51fW9mtT4UJn8+3a9RWJ+picA8rluMMwM2w=
X-Received: by 2002:a9d:628b:0:b0:66c:6afa:5006 with SMTP id
 x11-20020a9d628b000000b0066c6afa5006mr41636817otk.233.1670623113916; Fri, 09
 Dec 2022 13:58:33 -0800 (PST)
MIME-Version: 1.0
References: <20221209034813.2373727-1-evan.quan@amd.com>
 <20221209034813.2373727-9-evan.quan@amd.com>
In-Reply-To: <20221209034813.2373727-9-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 9 Dec 2022 16:58:22 -0500
Message-ID: <CADnq5_Pa73AjHe_fYS13uyqRyay_sdOycRW2CPs2i1cqp1k-YQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] drm/amdgpu: bump minor version number for DEV_INFO
 and SENSOR IOCTLs update
To: Evan Quan <evan.quan@amd.com>
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Dec 8, 2022 at 10:49 PM Evan Quan <evan.quan@amd.com> wrote:
>
> Update AMDGPU_INFO_DEV_INFO IOCTL for minimum engine and memory clock.
> And update AMDGPU_INFO_SENSOR IOCTL for PEAK_PSTATE engine and memory clock.
> User applications can better utilize these IOCTLs to get needed informations.
>
> Increase the minor version number to indicate that the new flags are
> available.

We need updated user space patches which use the IOCTL updates before
they can land.  Once we have those, the patches are:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I2fc85ed8046391555282c0629d88c875488c2b97
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 0826b0bca328..fb1720d171de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -102,10 +102,12 @@
>   * - 3.46.0 - To enable hot plug amdgpu tests in libdrm
>   * - 3.47.0 - Add AMDGPU_GEM_CREATE_DISCARDABLE and AMDGPU_VM_NOALLOC flags
>   * - 3.48.0 - Add IP discovery version info to HW INFO
> - *   3.49.0 - Add gang submit into CS IOCTL
> + * - 3.49.0 - Add gang submit into CS IOCTL
> + * - 3.50.0 - Update AMDGPU_INFO_DEV_INFO IOCTL for minimum engine and memory clock
> + *            Update AMDGPU_INFO_SENSOR IOCTL for PEAK_PSTATE engine and memory clock
>   */
>  #define KMS_DRIVER_MAJOR       3
> -#define KMS_DRIVER_MINOR       49
> +#define KMS_DRIVER_MINOR       50
>  #define KMS_DRIVER_PATCHLEVEL  0
>
>  int amdgpu_vram_limit;
> --
> 2.34.1
>
