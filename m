Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD8CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 16:52:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BDC210E224;
	Thu, 10 Mar 2022 16:52:12 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C29D310E224
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 16:52:11 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id k2so6564891oia.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 08:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p4lL+64UW9fY82GN1xNc2pccbeun3DMqbfaCVfSdkSc=;
 b=EL1+VCiFrT3e/KiSP5v/nrP2KO6y9R/xLISn1TcofOR91XStd0lj0NfCQjLgP5vvub
 sl3fvdu/D5LaYCumYlu5A1fWENBkjvd9ipcXohD31lr3OeEoVoz9SYq1zeBFVxZFkl83
 QepWOaCbMHoE+jsIoZBq89qjjLRKs8MmY+caipdUikvYb2VVC/d/4aKsF8wy8Hn/q6nO
 GvlNeAGXxBIcroECkIj/jMd3UY5xj/g4gb7Sdyq5KfS/pCdf8sNIsSmoM213KIiEPUZT
 Dhaprf4Vph+T58h7MzuWnAE3E78QCtG/QFfDOlc7xWcUP6eozxGZc8tD8lbNljDq8AaF
 fSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p4lL+64UW9fY82GN1xNc2pccbeun3DMqbfaCVfSdkSc=;
 b=JvcsOJV/rB3eLjgrQzIqIsCTQeIAjNQK3TzNVK4GAn2oikYvZ5X4wjBUrq4yVEVZzn
 JLcrtZufZu+2DmCGJS66OUbh+Y8whpsBflqnVzcfrMsvssFQ6xQ+5UmKdMPZ6FcmVgZ0
 1h0UaRQAUXE+azFztF1uDRl9cNzWLEskcQJCauPME6mQPAxj4U3GTjB6cIYM8c3lmKv5
 o3Wjwf8Faf+CoBhDNxtP2CJCmWuOlID9e1ZjNmvVCN+5iYteFu2ebv3KfEaU5VeYlH76
 cK8ckwUuGzs5Zq2WQeiAjQ7BVqTk8V3vn5gVY598No28N6qDxywu+I7A5D3ZsX7c8crP
 13jQ==
X-Gm-Message-State: AOAM5300amZY0rSEaQq4RtHMFOkHhM3TLYRXSIq3WbkwiYexJ9rgColR
 oIBtnmwdtJ7nEkgk8qUCKu+1iSLP1LausxBbbCs=
X-Google-Smtp-Source: ABdhPJw+S03z6/OkKSn5nJ/gdkQiaQEGkFdPCVPpyo8EcSRb37Gw5TCAzP6pO0HoXUPFgRTXUEhTf574p9yMlTwRf90=
X-Received: by 2002:a05:6808:140a:b0:2da:8c3:c92d with SMTP id
 w10-20020a056808140a00b002da08c3c92dmr9504720oiv.200.1646931131039; Thu, 10
 Mar 2022 08:52:11 -0800 (PST)
MIME-Version: 1.0
References: <20220310140439.249268-1-tianci.yin@amd.com>
In-Reply-To: <20220310140439.249268-1-tianci.yin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Mar 2022 11:52:00 -0500
Message-ID: <CADnq5_O=taXukBJYMj=fffvZ37ZbpUjHi+70N02U7WNt5420pA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: fix gfx hang on renoir in IGT reload test
To: Tianci Yin <tianci.yin@amd.com>
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
Cc: Guchun Chen <guchun.chen@amd.com>, Zhuo Qingqing <qingqing.zhuo@amd.com>,
 Liu Wenjing <wenjing.liu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Wang Yu <yu.wang4@amd.com>,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 10, 2022 at 9:04 AM Tianci Yin <tianci.yin@amd.com> wrote:
>
> From: "Tianci.Yin" <tianci.yin@amd.com>
>
> [why]
> CP hangs in igt reloading test on renoir, more precisely, hangs on the
> second time insmod.
>
> [how]
> mode2 reset can make it recover, and mode2 reset only effects gfx core,
> dcn and the screen will not be impacted.
>
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 496c4a6e23ac..f0713c027ed5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -853,6 +853,11 @@ static bool soc15_need_reset_on_init(struct amdgpu_device *adev)
>  {
>         u32 sol_reg;
>
> +       /* CP hangs in IGT reloading test on RN, reset to WA */
> +       if(adev->asic_type == CHIP_RENOIR) {

Space between if and (.  Also, you can drop the { }.  With that fixed:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Alex


> +               return true;
> +       }
> +
>         /* Just return false for soc15 GPUs.  Reset does not seem to
>          * be necessary.
>          */
> --
> 2.25.1
>
