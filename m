Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DF2C433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 19:31:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 506B52075B
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 19:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HihQDMPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 506B52075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2855B6E527;
	Fri, 28 Aug 2020 19:31:00 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61CD66E527
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 19:30:59 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id z9so236750wmk.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 12:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iro67r8jKwNOd6LHchFy4u3IjTVBhn1DB6p0mxfeVPo=;
 b=HihQDMPqglNqDz/DIAs/cwhI1KmP/KKVGSmVXtthkHBnWzgnm3GO3ENMvqhx9fY4lo
 1AEfbVar7fa0zpc4ynnFEW8S4kWn+fnpTcpvlk1rDzg6BPie28287U23wW3s1YbtH4cd
 cYc/MvZ0WYY/FyGo7S6DvqZgTYcS12ShGUHcq/Prd4NyMnOMcV6Dc6a2kFjkZYcCkwB5
 4jwOAwT/ZxEtJs1s1n54rSZHcTGR61XUxZNx1aaWDW/HLzZ92ohWxXgZ0MvuQ/CYX+9N
 ywNc6SsJbiAJ7eGrVx1YPJaDNk1MA8sTQkqadXQIx3d6K/y1wYQRHhqUMM0zL3CVQWkJ
 DJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iro67r8jKwNOd6LHchFy4u3IjTVBhn1DB6p0mxfeVPo=;
 b=LZnbnP6gTas22/UoVZDouqPTRFZQXFtC+HgezscrrBWjwhqVXfOQczfRhGAU2xqURq
 eHxCEIi4KnCj4hrJAFTzzQgFhfsRxBuf/45q3O+SgTcGsbvNHJrX4qil0j+DifwIZpQo
 ceYZzyMcf7+4fY1+b6Ff2B4Mj2dxQJ8Z+C/PIEr0ELHtNUah5pcLt0KWxxEik1Q8Np9V
 qxlPg14SaplzfY9FQWDmxa5fM1mfQce4qp84vXIndWyGtzp5C3ujgotET4UUFaSN7VQj
 9Uw3noUBRrxUeEfIos8Tmf+S5pD4UnX9RTCNX9OXf2hoZLpQ80NEPk/kPFBdwpIA15Qy
 h5JQ==
X-Gm-Message-State: AOAM533FnLDdt4I7fDvWmFwOzuwUS3AEVV0r8MgVQzbfhYSvyHbvGYee
 PBmg9kmtN9hJrsPbHJ+oHwvBGTY7IIK98v0LJR0=
X-Google-Smtp-Source: ABdhPJypnQ7KW82s9otuGm769uJmQhsmvPMnbyGvdhU8P4lxFvujNcXPO/iFHmkwEWQu+mMAL/dV0JB9zChJIKKCOa4=
X-Received: by 2002:a7b:cb17:: with SMTP id u23mr187121wmj.79.1598643058119;
 Fri, 28 Aug 2020 12:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <1598630743-21155-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598630743-21155-8-git-send-email-andrey.grodzovsky@amd.com>
In-Reply-To: <1598630743-21155-8-git-send-email-andrey.grodzovsky@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 28 Aug 2020 15:30:47 -0400
Message-ID: <CADnq5_MCXDfGNz0FpHZfJ6G8a4eqDQDeSghBFNfCoL8aAP934Q@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] drm/amdgpu: Disable DPC for XGMI for now.
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, Nirmoy <nirmodas@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Aug 28, 2020 at 12:06 PM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> XGMI support is more complicated then single device support as
> questions synchronization between the device recovering from
> PCI error and other memebers of the hive is required.
> Leaving this for next round.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 429167b..47e16baf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4782,6 +4782,11 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
>
>         DRM_INFO("PCI error: detected callback, state(%d)!!\n", state);
>
> +       if (adev->gmc.xgmi.num_physical_nodes > 1) {
> +               DRM_WARN("No support for XGMI hive yet...");
> +               return PCI_ERS_RESULT_DISCONNECT;
> +       }
> +
>         switch (state) {
>         case pci_channel_io_normal:
>                 return PCI_ERS_RESULT_CAN_RECOVER;
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
