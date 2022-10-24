Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA08AECAAA1
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Oct 2022 15:13:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA28810E834;
	Mon, 24 Oct 2022 15:13:55 +0000 (UTC)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com
 [IPv6:2607:f8b0:4864:20::e33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6077610E834;
 Mon, 24 Oct 2022 15:13:52 +0000 (UTC)
Received: by mail-vs1-xe33.google.com with SMTP id 1so8162534vsx.1;
 Mon, 24 Oct 2022 08:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J1gk2ep4Ye/CjOaUbmreqC0qY89txiP3E/LghUXF5LA=;
 b=akGSaltVfsVhRbxG28WOW2X8gO+wU+EznxNMhIIAuSXlPw266pmcqTSPvphoFig+GK
 6AkDGxqzK1FJuKj+gGU8trve6h7F9gHybwYtN75fdc3LfBH7MtfTgz8qxq8CwCYlUKal
 qB0wtDVINyoNPBAV7ld9nZCkIhvnRXn7C3L1qTuA5XRKM2DxzDG/oeeQnzEj+6QNCTQd
 vNLfsqXPGOM4aOHEVG5gnpMP0+cf59pB02DgvrSrhyyfGzlSYzh7CVf3kW35Vm5Ogkv1
 SK6c+++qFxQAwPO234SxMhd1pNZ7S9ZL1CmXsT/zlHHQCq6UIhy7FTARmx1QlC57pCeM
 0thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J1gk2ep4Ye/CjOaUbmreqC0qY89txiP3E/LghUXF5LA=;
 b=fJ/Jz6S7+CEtlES0WS/q4Suze/yKKU0OvM4iqP1TFfDwdoHKSyG5kKJm4bJhsOIEXu
 vDYFSni26fdZBM6z+THz9RJ3cPw67hjfAdxjwOcC407hiw8PYBbeyRcfgQ/uuy/90MCJ
 sLVyE8X7dIrPyICXq+I9+m5khq/R5qP6bB+wq/cC59DTMqKqHIkbGuNfnXuf73mGiW8g
 giuFbfL7s6QQEpgLT0rg8r0kV2vX/MER89TpqtJkZKorCzjTNFMr3wnz+IYX2T5QMGqj
 LxaZW0VCLAY3nyrdSDfIFTCeidaqLlkGRdUd6xvkiL81A6dPH+t/uwjzKXziyAFDFWi2
 jT2A==
X-Gm-Message-State: ACrzQf0ntNlhkbmuV1wLlN1NNtTG9jU8REj3f7eZd1nCaPEOi5FAX/Sd
 uCBppjxHvArkE+vdToNCK/rXHjinNRCLFTtmpx3YqVEz
X-Google-Smtp-Source: AMsMyM4fNurfiqwrnpgoMx2P1f9YHXMbFRfipOkR+eGaYvPpVD3TyOfVsYBQuM/D/H05sOmqp3j6d2uvYxO3EKWY1CI=
X-Received: by 2002:a67:b046:0:b0:3a7:965c:65f1 with SMTP id
 q6-20020a67b046000000b003a7965c65f1mr15621937vsh.40.1666624420991; Mon, 24
 Oct 2022 08:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221022060155.52548-1-wangjianli@cdjrlc.com>
In-Reply-To: <20221022060155.52548-1-wangjianli@cdjrlc.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Oct 2022 11:13:29 -0400
Message-ID: <CADnq5_OjwUOMa6RAfqT6B50wHQARtdL7uARcDzc+iMCthSsLgA@mail.gmail.com>
Subject: Re: [PATCH] amd/amdgpu: fix repeated words in comments
To: wangjianli <wangjianli@cdjrlc.com>
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
Cc: airlied@linux.ie, Xinhui.Pan@amd.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 daniel@ffwll.ch, alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Oct 22, 2022 at 2:02 AM wangjianli <wangjianli@cdjrlc.com> wrote:
>
> Delete the redundant word 'the'.
>
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e9155dc1c30c..3de990bbbf2f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1565,7 +1565,7 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
>   * @pdev: pci dev pointer
>   * @state: vga_switcheroo state
>   *
> - * Callback for the switcheroo driver.  Suspends or resumes the
> + * Callback for the switcheroo driver.  Suspends or resumes
>   * the asics before or after it is powered up using ACPI methods.
>   */
>  static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
> --
> 2.36.1
>
