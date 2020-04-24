Return-Path: <SRS0=W/Sk=6I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079D8C54FCB
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 13:54:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC8720700
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 13:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IX3BgBSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC8720700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 457EF6E04E;
	Fri, 24 Apr 2020 13:54:06 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70FBB6E04E
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 13:54:05 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id b11so10903592wrs.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 06:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=C5C6AXX9HpYIJ6hPxEZ/nbXaXBNFf9NwIuOiUVwGmtk=;
 b=IX3BgBSgTMqVSPrtJApngCeFlcbpwg0yG5mTjQbO+S5FG1xxv3RFm/UuF71fDsSL7L
 50V8S8ATTKF8M9QxbtUMPruGFXrUUte/dvCsaIevSeK5v3lZGJ2E7iv8z9Z8CBGTBy/X
 ztXmAGoj0ajl2oeIqBKZ5ROW08kdsz7pFYRWwkJMoUIPfk8cC7y0GSihjnn6lA/i/YPJ
 57zk8staQB+ZWusdO7g1HGsaxCKSdJFDCM0AbfyNHKPmHXPCZjO3yJL3fyD6HONsoxiw
 h16l/Q0Zc5edoiVtvKZYITbV8lo5fkFQ/MmShjB0gUDcN5OnUXO/XMcd8Q2tyl3KpKd+
 1EhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=C5C6AXX9HpYIJ6hPxEZ/nbXaXBNFf9NwIuOiUVwGmtk=;
 b=I+ejHXVhAzHCf0/KC7GDiDqSMnhQIdiahWv/MiB7Laa8c2VkEy9lChtqKJXsPglPUy
 FEjOkcxtrPsf1kVHDgP44t511igokVPwNytJ2OycsSbTTYUcXpK25UMEXDS1Goh3mRIf
 d7vNGaJHLMjjHlm7JFQwE2DfNAu3Y7pbWcSJ2grlyXQv+tUIv3oWzENcRy49OxBLmEYF
 TZK3uTLufYzNbdIa0/DCXG4tb0GbhyHgcEegSoEfVG2udNhsZJIvMQTe9cbmRO9DLztx
 zbbx/JHxtF8vO5r5fCTYr4/g3v2UTIdDhAOEEVfSo71z2MHpgNeSGGoi3/vUbrDNFlf6
 DWag==
X-Gm-Message-State: AGi0PuaBcGlM+hcixKcFkkZuyJgOpkQG2aIjQaJ4nNH9QzGSzHecq1Ow
 hnZsrH+WCy2Z52fj/4gq2j26PeVvZEyDfBhv7BU=
X-Google-Smtp-Source: APiQypKzf3lYAjPZ+jU/NPxb0u9hbPEQrCuBj7xLFAVLgCuE3lbRkneJNm3nbnIyxTfWKoACRmcyjJcL+KcPNJnkNf4=
X-Received: by 2002:a5d:5352:: with SMTP id t18mr11099591wrv.111.1587736444092; 
 Fri, 24 Apr 2020 06:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <1587726571-31294-1-git-send-email-curry.gong@amd.com>
In-Reply-To: <1587726571-31294-1-git-send-email-curry.gong@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 24 Apr 2020 09:53:52 -0400
Message-ID: <CADnq5_OnaD6bUWmTEoJyBO=PF3pccP02=9gNXdqP4iCFo78g=g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Need to power up SDMA for #34 sdma firmware
 after do mode2 reset on Renoir
To: chen gong <curry.gong@amd.com>
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

On Fri, Apr 24, 2020 at 7:09 AM chen gong <curry.gong@amd.com> wrote:
>
> [why]
> Previously I found that powering up SDMA after mode2 reset can cause
> ring-sdma0 test failed.
> Perhaps the mode2 reset does not reset the SDMA PG state, so SDMA is
> already powered up so there is no need to ask the SMU to power it up
> again and doing so causes some other problem.
> So I skipped function 'amdgpu_dpm_set_powergating_by_smu(adev,
> AMD_IP_BLOCK_TYPE_SDMA, false)' with '!adev->in_gpu_reset'.
>
> But now, for #34 sdma firmware, dmesg log show "ring-sdma0 test failed "
> after the mode2 reset, and scan data show SDMA does not have power.
> Then I re-enable function "amdgpu_dpm_set_powergating_by_smu(adev,
> AMD_IP_BLOCK_TYPE_SDMA, false)" during mode2 reset, The result is issue
> disappear.
>
> Besides, I did more experiments base on previous sdma firmware for this
> patch. Situation Normal.
>
> [how]
> Remove "!adev->in_gpu_reset"

Do we need a firmware version check?  How recent is the #34 firmware?
If there are older renoir SDMA firmwares out in the wild we may need
the check for them.  With that confirmed,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: chen gong <curry.gong@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index c0ca9a82..0ecab41 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -1914,7 +1914,7 @@ static int sdma_v4_0_hw_init(void *handle)
>
>         if ((adev->asic_type == CHIP_RAVEN && adev->powerplay.pp_funcs &&
>                         adev->powerplay.pp_funcs->set_powergating_by_smu) ||
> -                       (adev->asic_type == CHIP_RENOIR && !adev->in_gpu_reset))
> +                       adev->asic_type == CHIP_RENOIR)
>                 amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_SDMA, false);
>
>         if (!amdgpu_sriov_vf(adev))
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
