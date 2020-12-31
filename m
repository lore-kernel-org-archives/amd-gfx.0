Return-Path: <SRS0=M3Em=GD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A272AC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Dec 2020 06:35:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CAD0207A3
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Dec 2020 06:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CAD0207A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD6FC8914F;
	Thu, 31 Dec 2020 06:35:16 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16F048914F
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Dec 2020 06:35:15 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id r9so17335895otk.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Dec 2020 22:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JMov9HGSkQrL5k36f7DSwCGAF0Qzu+5pZPMfFh3HyTo=;
 b=f6BbxCN7R1cZ1WvFo5pfDW/oO7XFggUa9JkTy2/JcpCgl9pytlPTF5HVp8fLg0RsGK
 lTFk7dr5X4H0JmheATZ2cm/Lmq84Wx7Pr24/dFJYEl5DUCr1f9oNIiIJ0eZPoPo7CVac
 wgJtfLdILbQ3/64ge4tfqylU6sStixkOPyYj94CK5h5ttE8/NRVQwO46D+OBjWnZuD3T
 GEw2yZ5vlu6eI6afBo4NNMrIz0b8EZTIpZEMJ7EvarBihbPf2j5hAShKiCGlYM/G1dDV
 bQeEQpks7YckPuGwJMOCnqvKOoGgaD5UHuAnPcfy4OvYVsn666NaXA4couLftFEkX3A9
 SVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JMov9HGSkQrL5k36f7DSwCGAF0Qzu+5pZPMfFh3HyTo=;
 b=OkKnbOaHMmRxBt7+fKx+G6z+gEYXzLnhbltJBfOjokye019pF0RJcJabQl7K1oPMBF
 bWhnADpHzCIfJWL0b88VWhJ/vHVMKFBYL+N/r3veYvOWvWWZDzMy/opAi2+6hk2DWWsi
 T+2AOIj42p1w8VQ3ybpFR6n83l8uW3N452U2pMOBe0K+IWYPEDv6Qs4kX09ahxD6E75i
 dBSD0TVkmIoik33f3C18bpp4bWLnoRDeMAjQTMev/60HU9xLEy8eLlNI/mwiA8puTb4I
 navddbltuPQHmg3Ojczt32oV9Ka12soKshCNhJon+yT2yhJcS5t6PRRSkLMFi/QUr3xx
 K9qw==
X-Gm-Message-State: AOAM532RhyW994j9qkB19wrL6gkKf3XN9DvBdlrmzM1d3Su7Wtx0pKHW
 Ib6Ki4WHg8cD6nCch1naUY0iz4/I7pGw3f/h84Y=
X-Google-Smtp-Source: ABdhPJxtN2/XvVCPZ8Qe89yCyaJcm2dQvynPMr2wgQaw5BttIrz+2j+xUNkXloLI9110mzjFsP94r9UY5b2PYx9nN7A=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id
 d27mr42476339ote.132.1609396514310; 
 Wed, 30 Dec 2020 22:35:14 -0800 (PST)
MIME-Version: 1.0
References: <20201231050841.12297-1-Hawking.Zhang@amd.com>
In-Reply-To: <20201231050841.12297-1-Hawking.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 31 Dec 2020 01:35:03 -0500
Message-ID: <CADnq5_MN4bKhd2QjtpKtQBKXvCyb+9e46kKYgdYQ6K=g+PHAVA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: switched to cached noretry setting for vangogh
To: Hawking Zhang <Hawking.Zhang@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Dec 31, 2020 at 12:08 AM Hawking Zhang <Hawking.Zhang@amd.com> wrote:
>
> global noretry setting is cached to gmc.noretry
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> index b72c8e4ca36b..07104a1de308 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> @@ -310,7 +310,7 @@ static void mmhub_v2_3_setup_vmid_config(struct amdgpu_device *adev)
>                 /* Send no-retry XNACK on fault to suppress VM fault storm. */
>                 tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
>                                     RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
> -                                   !amdgpu_noretry);
> +                                   !adev->gmc.noretry);
>                 WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL,
>                                     i * hub->ctx_distance, tmp);
>                 WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
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
