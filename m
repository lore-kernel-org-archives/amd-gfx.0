Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F1EC433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 21:07:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCEBF206DB
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 21:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtzfzn4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCEBF206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FE2E6EB35;
	Wed, 16 Sep 2020 21:07:54 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 277FF6EB35
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 21:07:53 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id z1so8321178wrt.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 14:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6HYZ9LdaDf/wyIeY+l8BBTYnW8FxFAu3z+hCVpAL7Ro=;
 b=mtzfzn4GX6NMpnql2Q48/P3QYySKFF71FoZZ34MmT+VS9b0AT0u2ztxWvl6JeyJVw+
 ZD2uOIhOnHHEbz/9VQpv9FIPPZqpaQnonjllMxHhx7NGZ1Xa91BuWD5dk7jbGhay+ZAw
 PMVdgOxgeH5VqzMb/zMxM+sEtKo5VnHP6YUcKMI5iwKKV2vihgbrVuJiezCsN3YPs1JB
 TO0Ni53ut8EZgXLQshjz6jRjiwq8d68xoKegXlqLG48liImAgwuFVDlp7rZDMDRsCy1L
 LQOz625YXnPbdTsyWKBsgiXkAfgB08EXmnFIwmd0TGyX1ZEleV4MAxvOKGyt+B73CYR4
 RkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6HYZ9LdaDf/wyIeY+l8BBTYnW8FxFAu3z+hCVpAL7Ro=;
 b=hm3uW1vqR17rE8+Hk3bgpA/hxqHKmiSzJI7Vj7Npr6Tx+80XQWQjTKmDd33yOSE/P8
 RdAkRfy2Oiv0FS8sq5ZbeFZOcNtf8vDhEkIeLSMo0U6b9Jj+BoZYsNzvlIgevGS0ZPfg
 EeR4Os74Zyj2TnkMM2An5XtdL/gHHFJ/4Arlb1sVJGUA1SrCQLIJ0+y91H4OGABbqsrg
 JeX2TQFu9pFrwU8ozMQ2LxkMVowOYvnzRYm1bNcquIt4TzeVK+KeYo/JvpBxGSx1VdUs
 E8j3HlRK8yx6XOeY2DjW3GhHg0wScJXU/HtoPorq2vBFeuDXQuWbCURqXFqBGlBBFCnW
 /VJg==
X-Gm-Message-State: AOAM5335yIR+4Xo0lD+izy/uN8XLWGdtbcfHGLMXBBxoElB+CWkm/OVs
 mE2i16/SWLAP6LfdCqlQsGK+NSolxXYiCrKFWQcvpJ5l5V8=
X-Google-Smtp-Source: ABdhPJyMMEd364UDLCc3X9yizQqJuDruUBoUcGFcdMAUdUXX7fe/TkOjMtTTOtT9m7BGtBLdHKpQMtBn7uqb+QSm42k=
X-Received: by 2002:adf:fc0a:: with SMTP id i10mr28226925wrr.111.1600290471824; 
 Wed, 16 Sep 2020 14:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200916145712.18964-1-Bokun.Zhang@amd.com>
In-Reply-To: <20200916145712.18964-1-Bokun.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Sep 2020 17:07:40 -0400
Message-ID: <CADnq5_NLu904rCPH9TapMXVrCh8ps9Gegbx86mJe+m2VBPxOSw@mail.gmail.com>
Subject: Re: [PATCH 3/3] SWDEV-247673 - stop data_exchange work thread before
 reset
To: Bokun Zhang <Bokun.Zhang@amd.com>
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
Cc: Tiecheng Zhou <Tiecheng.Zhou@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 16, 2020 at 11:05 AM Bokun Zhang <Bokun.Zhang@amd.com> wrote:
>
> From: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
>
> In FLR routine, init_data_exchange is called at reset_sriov
> while fini_data_exchange is not. This will duplicating work
> thread.
>
> So call fini_data_exchange before reset for SRIOV
>
> Change-Id: I974c6a3c5de86736eebefc386c03fe0e18e1fae3
> Signed-off-by: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
> Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>

Please drop the SWDEV reference from the subject and prefix the patch
with drm/amdgpu:

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 483ec0136332..e71cf3b34e15 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4080,6 +4080,11 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>
>         amdgpu_debugfs_wait_dump(adev);
>
> +       if (amdgpu_sriov_vf(adev)) {
> +               /* stop the data exchange thread */
> +               amdgpu_virt_fini_data_exchange(adev);
> +       }
> +
>         /* block all schedulers and reset given job's ring */
>         for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>                 struct amdgpu_ring *ring = adev->rings[i];
> --
> 2.20.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
