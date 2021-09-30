Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41DBC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 15:16:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB786159A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 15:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6BB786159A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 640AF6E413;
	Thu, 30 Sep 2021 15:16:06 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48EF66E413
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 15:16:05 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id 24so7749419oix.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 08:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oUvGtjTdJrAapUBDHYvZQL+czluywvS4JY+/+JdYRtI=;
 b=D+wpeeNVLv+ad6o6X7/Yd1wS65DqospbcRY2EASNC2aiX/xSIb7p41ModkPKobhJrA
 Cy9Jtc+o+y74MY2xlqxXmZwNCFEtxDS0Fblyy/b664IwO5X7rXWy7P4jTt066ibJ9K+1
 oqVYYEE6kAdvK9uJp6LVoebxbLDlbglZo7//b9Wigb3hVH5Uibro5QJl8PZrzt3ivYXQ
 v4p8o5oDvYPfVuKLWIShRY54DOv3KdPY+whXykB/KeuLwQa4oQxwPrxMvHMsju9NZhb4
 Tj30K0G32a/YzXyXdMd0WXghwd0t9QSY29/TNlAaBYIoOeFTKqgfLvroVTcw/2dbjwC4
 Hqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oUvGtjTdJrAapUBDHYvZQL+czluywvS4JY+/+JdYRtI=;
 b=ugr8dNBq/zA7uV92DY3PdVnbuW4jShnhgKWz6ndbcNl3PVx2oD884nmowG89NToFK2
 nW1WJac0EKLVw+WwxaHogZs47zFzXRSi08T+4QhsLYn9cB1AJ+drLnWSaG1D+zY4CnCd
 otPRxViXg69DABIvOcAjC6HwOYoC4XeiSIL/zyyNSIU4yWLAHmu6byk1yF0Ak5P9s3Xl
 OtQNcCn8e3BHorHz55mS7MkZ5EN8NjFp8XpMD0j9RGIhoAWkUmp5aOvyQxXlFbdhQViF
 9QmtQs3dg+AvkjQA9ks0NYW28zn3sYrANFeefgrrgalOJVIfLygpoD1yHSxtjOy4PxtO
 9pHA==
X-Gm-Message-State: AOAM531xwkEVTsclpRLR4DPzGnVj05dJcfGSWw2YE+kOiWF5T6SyN85G
 fOXDZdjDcjv1XyXaSH0WtUpFkj87ZFBXyls1zwM=
X-Google-Smtp-Source: ABdhPJwy0DMWmVQoJep2SV2E7XkHa1ZXcF+AqXeD42ONIetHyNBMd8kQI5UpsdsObiHcClBH0sxvxxUOSBQm2jXhCaQ=
X-Received: by 2002:a05:6808:1141:: with SMTP id
 u1mr3236245oiu.123.1633014964581; 
 Thu, 30 Sep 2021 08:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210930131822.2194663-1-Anson.Jacob@amd.com>
In-Reply-To: <20210930131822.2194663-1-Anson.Jacob@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Sep 2021 11:15:53 -0400
Message-ID: <CADnq5_P74pEZ5oiY0uP8re0Rbrrafv4xA06R7kixvt4V74e32A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Fix dummy kgd2kfd_probe parameters
To: Anson Jacob <Anson.Jacob@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Sep 30, 2021 at 9:18 AM Anson Jacob <Anson.Jacob@amd.com> wrote:
>
> Commit 4d706ed6825f ("drm/amdkfd: clean up parameters in kgd2kfd_probe")
> updated paremeters for kgd2kfd_probe. Update the dummy function as well
> when CONFIG_HSA_AMD is not enabled.
>
> Fixes: 4d706ed6825f ("drm/amdkfd: clean up parameters in kgd2kfd_probe")
> Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>

Thanks!
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 38d883dffc20..69de31754907 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -346,8 +346,7 @@ static inline void kgd2kfd_exit(void)
>  }
>
>  static inline
> -struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, struct pci_dev *pdev,
> -                                       unsigned int asic_type, bool vf)
> +struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, bool vf)
>  {
>         return NULL;
>  }
> --
> 2.25.1
>
