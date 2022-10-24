Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4D0C38A2D
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Oct 2022 19:52:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87DE310E790;
	Mon, 24 Oct 2022 19:52:49 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CBC210E790
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Oct 2022 19:52:44 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id l5so11949308oif.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Oct 2022 12:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=181rRmE5WHWAIdMIU0NuwIhflf8G+tqJfIgmWW3vvAI=;
 b=aDv+zmEIFmMc7nagLbe/NPwehjMGFPbLjQQYtn/VzYHeGbR32v4h91JbNlHW2Gc/vM
 UGMR7mus7g9nqxTRz3RJT1GIXxaLM6J95AHYm3Ojq1ourpXGL3l/aPUUiWXMiE7JeF+h
 YDgUIYL3TCfRUYI1qeYYkXAW9scuEHJLjXs9XTzLr7t0MM/9zqShXIRIpTZfqIVszRGw
 VMSAtAH0LdHKz7X7NDA36shqM5K/rf2E07qBWdQVB/+WiWse+DCWYjIGuYm7mWS3F8pv
 pdKn844p4Y37yVA3jXB0Xrq6NUxJuzZJMw4sEdTY8cbxjuD8d8oaiuBmfeZLevgEkXJD
 AAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=181rRmE5WHWAIdMIU0NuwIhflf8G+tqJfIgmWW3vvAI=;
 b=yP3z1YaRb99t+BoCEVXkFJdBVeVTZxiHcAZgeFc3vlGcU183a5WpUooMmoZTbGUgq3
 JwBFTd+MWwh8r7VZgI2si6qxnZnVeTXex3YtLL5Wpc5OHRghmuiFzCm87Xms48YZmGtt
 ZhWpayntyEjcalTHQHkPKa6/AykOihICX1YmJrhGYT3rvpyS6CzOVMk4tRPxiUjCIS6J
 v/YMlGFEYRCNui2Cmzd/ocxSLCqYEprEpDMZteh1lfacU8mXzMCpT4hCx1r2eO2Lt7sZ
 j9lsYNkFkANbwMIawdR8KMv+YDUlNSOzUaJ7lxoR40eP/y7FrK3DrhWsnHef9kO3HGJg
 7b0g==
X-Gm-Message-State: ACrzQf3msTqc897ljzoqlRaory5FwB/JorLgSpMyUdpGFLZ9YGElHxs9
 YYqQaLFC0/rNoYFynsJwVoRDzm5LoUxAEcDhQkc=
X-Google-Smtp-Source: AMsMyM68O8XiN4Yc+8Vi+CXh3ApqjxQTXdBOHIo/B2U0ZbwhC60//Gl7KpiEL3eB3HAh/QHxTOwERbrTvbHs0KzgQ8s=
X-Received: by 2002:a05:6808:14d2:b0:354:c733:abd3 with SMTP id
 f18-20020a05680814d200b00354c733abd3mr17291564oiw.96.1666641163728; Mon, 24
 Oct 2022 12:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <20221024194515.7545-1-Gavin.Wan@amd.com>
In-Reply-To: <20221024194515.7545-1-Gavin.Wan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Oct 2022 15:52:32 -0400
Message-ID: <CADnq5_PCug_SafLpH0-=CoBCTVAbf=6aWcMdX1Db-_L0Yk_zHA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Disable GPU reset on SRIOV before remove pci.
To: Gavin Wan <Gavin.Wan@amd.com>
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

On Mon, Oct 24, 2022 at 3:45 PM Gavin Wan <Gavin.Wan@amd.com> wrote:
>
>   The change "Adjust removal control flow for smu v13_0_2"

commit f5c7e7797060 ("drm/amdgpu: Adjust removal control flow for smu v13_0_2")

>   brought a bug on SRIOV envrionment. It caused unloading
>   amdgpu failed on Guest VM. The reason is that the VF FLR was
>   requested while unloading amdgpu driver, but VF FLR of SRIOV
>   sequence is wrong while removing PCI device.
>
> Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>

Please add:
Fixes: f5c7e7797060 ("drm/amdgpu: Adjust removal control flow for smu v13_0_2")

With that,
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> Change-Id: I1ff8dcbffd85d7f3d8267d660fd8292423d2f70f
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 16f6a313335e..ab0c856c13b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2187,7 +2187,8 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>                 pm_runtime_forbid(dev->dev);
>         }
>
> -       if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 2)) {
> +       if ((adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 2)) &&
> +                       !amdgpu_sriov_vf(adev)) {
>                 bool need_to_reset_gpu = false;
>
>                 if (adev->gmc.xgmi.num_physical_nodes > 1) {
> --
> 2.34.1
>
