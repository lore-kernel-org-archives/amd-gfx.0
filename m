Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C24BC43334
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 15:02:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 204F110E47C;
	Tue,  7 Jun 2022 15:02:35 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F07CE10E47C
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 15:02:33 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 w19-20020a9d6393000000b0060aeb359ca8so13090137otk.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jun 2022 08:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VJMgyNWcUjGAHmVol+l7FddvWy4HcKG7aNWkdNNBDVU=;
 b=TqTe+4uI9QLQkO4k/Lk6CYAW+/Yfnj8GqkiD2T0MVJEKgxHE8hmG4XJf1CKrBegIQY
 SCd2n8azjUHvU1AdJwOI9KhYZjNwVs07EX4dfkUQYaxhV6tqMUNeu0U7iLfJaJH7RH4q
 AIwUxVVUmt2iMM89BcmYmUQ16gemAiYwjFtmjUdj3hCFIPVvJ71M+RhDENmKhCPO+pvS
 Q77i9M+Ao4AxS3uJ+obseMWP5bxNe3TxI+J5Tf0Ht9vTrci838UtfK7MA5ssncnP+Znc
 CzKnQGz5oVf6FbWan7QAW1pUZT5l5BevnxMWBNFYOr9MvBtE90kKQBDrGRVyIqrFiAn4
 bKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VJMgyNWcUjGAHmVol+l7FddvWy4HcKG7aNWkdNNBDVU=;
 b=uMcOhDDwo461lL7Xbs9CBilX1eq/cvai8wm/+WDS1M8rFPWLeSHRFonE2AVVFo8+9w
 9jyZu0u9zSrBXmNsgUwlQeDPBmDZ41EL9vwdXOX0CNXM8rqYfdtUvUO2NCySk775wG0I
 bgf5qDd81yX+B2O7WvmNScY3FErI7g9hw1s+yyOQG5TN+YNIem1VGqMnX7L5iwCt+tev
 KlPhCydITKY8fdEAYn68cjGSSEc14cYIufQRoEh48HxLl10gsjxFHho44t7iVzoG8gIT
 NIY38AmfmVQFU6GFIMwX0oCU6cHl9nSqq2P3D79VckHYnQU2ZauBKbwE5H8pYT1pwPFe
 qy+Q==
X-Gm-Message-State: AOAM530hqoeMe5YRR+dGmfOFamkVh5FwG924qhfhuau+E+GYk8/p97Ut
 0D9ogf77MA3P0jpu3UMcuRwV7v/wAiuJlehJ/Y+fNZZH
X-Google-Smtp-Source: ABdhPJxnuaPOqMFo+am1UPUp7Bo2rEvsD1DZ9wSCjPJIF41ZyNVmP1vy7g/9k24X/+Ro/GVoqu5SfJbnF8NyeOEMWCo=
X-Received: by 2002:a9d:7853:0:b0:60c:2ab:624d with SMTP id
 c19-20020a9d7853000000b0060c02ab624dmr2986084otm.357.1654614153196; Tue, 07
 Jun 2022 08:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220606023845.3439931-1-zhenguo.yin@amd.com>
In-Reply-To: <20220606023845.3439931-1-zhenguo.yin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Jun 2022 11:02:22 -0400
Message-ID: <CADnq5_PXFZM0vkZ+8sj1Hs3QYnAy5_jX7XnxF47pTDMq1TBG1w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix scratch register access method in SRIOV
To: ZhenGuo Yin <zhenguo.yin@amd.com>
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
Cc: Jingwen Chen <jingwen.chen2@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Jun 5, 2022 at 10:39 PM ZhenGuo Yin <zhenguo.yin@amd.com> wrote:
>
> The scratch register should be accessed through MMIO instead of RLCG
> in SRIOV, since it being used in RLCG register access function.
>
> Fixes: 0e1314781b9c("drm/amdgpu: nuke dynamic gfx scratch reg allocation")
> Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>

Won't gfx9 and gfx11 need similar fixes?

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index c5f46d264b23..ecbaf92759b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3780,11 +3780,12 @@ static void gfx_v10_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
>  static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev = ring->adev;
> +       uint32_t scratch = SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG0);
>         uint32_t tmp = 0;
>         unsigned i;
>         int r;
>
> -       WREG32_SOC15(GC, 0, mmSCRATCH_REG0, 0xCAFEDEAD);
> +       WREG32(scratch, 0xCAFEDEAD);
>         r = amdgpu_ring_alloc(ring, 3);
>         if (r) {
>                 DRM_ERROR("amdgpu: cp failed to lock ring %d (%d).\n",
> @@ -3793,13 +3794,13 @@ static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
>         }
>
>         amdgpu_ring_write(ring, PACKET3(PACKET3_SET_UCONFIG_REG, 1));
> -       amdgpu_ring_write(ring, SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG0) -
> +       amdgpu_ring_write(ring, scratch -
>                           PACKET3_SET_UCONFIG_REG_START);
>         amdgpu_ring_write(ring, 0xDEADBEEF);
>         amdgpu_ring_commit(ring);
>
>         for (i = 0; i < adev->usec_timeout; i++) {
> -               tmp = RREG32_SOC15(GC, 0, mmSCRATCH_REG0);
> +               tmp = RREG32(scratch);
>                 if (tmp == 0xDEADBEEF)
>                         break;
>                 if (amdgpu_emu_mode == 1)
> --
> 2.35.1
>
