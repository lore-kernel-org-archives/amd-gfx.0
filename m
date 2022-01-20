Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA5AC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 17:35:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B49B310E7D0;
	Thu, 20 Jan 2022 17:35:39 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E14B10E818
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 17:35:38 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 c3-20020a9d6c83000000b00590b9c8819aso8481556otr.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 09:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iUYLgJUNSAphT+CFow7albXWs0o8oSpM+f+TFTju46I=;
 b=iWY8XdAFtwViC7sPmfEjtHRw5TILOkcSfhRPcf3IYuDF26v/3+08G0YbnB83X78/Nr
 LLCcd7qqy/6o8f7dzXomKgYXStafF9mLgtxEiQjde9j+pLh8L6shhImJh1ChyifOYgcO
 ftuW/cjqqGTUn+5zbubmJAfcvqV2tu7DS8qCmYXdy8/ul4JU3LiLLGYhMZBPBPrMDS+z
 ccyEziYLJ/rdRtcKD0LueD0Zkf6GJciKzz5A6ybtGvvmCkrABk7l6uc1WbQnFVB59YVc
 cxp7Sck/LPfeZrBYvk3zuZ7xB26L73xYHIfJaDeqEov2Dd395k0OQfek4hVXSLNTq2AZ
 gVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iUYLgJUNSAphT+CFow7albXWs0o8oSpM+f+TFTju46I=;
 b=K19x1KbrmkkxT6bHTbr14Xq1hkvkwjanS6PD/8Y60hs+D98ShjTwS+3aMfDuA/qBRQ
 rYs77Ro3ZKDSAdN6J94Vxtc9tmRkySlAEZCXKMhmRx5vYSra24tRmSP7csgdJnQW0I9H
 g8RD4S0Jx1YhZPRFIBwRZprNhHh2TK+NEXQmCnHraWeqHEJigPBqCJMh/qjajokU4TFp
 tXRxydBIxgksVbKS4QxmK0HIwADp0hIIA4EAJUiX+s6sVTQe7be24EYV1xGjTkjnHzQV
 ytijrXI3EqBVAINC9QnetGlczUI2gyUaCRvrq+aEFa6uUrutkYX7SQCpezLSPVjoWMoI
 JCmA==
X-Gm-Message-State: AOAM531wV4QsF92L+wsMyZkeAQ1zo5vuDL3VZ2gVqIAS4lFXhQcNrXYw
 EdSDlknz3NQ29vgYgRhlOUSB/yb9bN+tnhVhkoU=
X-Google-Smtp-Source: ABdhPJzu7vPj3gUmOQJfK/EH7SS/iAxVYodF2ZbWCqw1NiZ6YMuQ6U+ebxUwAf9KjZl7Pj99w0Zcsah1BLP2RbUqop0=
X-Received: by 2002:a05:6830:19e6:: with SMTP id
 t6mr27390985ott.357.1642700137947; 
 Thu, 20 Jan 2022 09:35:37 -0800 (PST)
MIME-Version: 1.0
References: <20220120062504.565239-1-Lang.Yu@amd.com>
In-Reply-To: <20220120062504.565239-1-Lang.Yu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Jan 2022 12:35:27 -0500
Message-ID: <CADnq5_McP3zr6A+Ke8Uu=MZUAftT7qJeZM60H7vF0Ys+ieXYtA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: enable amdgpu_dc module parameter
To: Lang Yu <Lang.Yu@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 20, 2022 at 1:25 AM Lang Yu <Lang.Yu@amd.com> wrote:
>
> It doesn't work under IP discovery mode. Make it work!
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 07965ac6381b..1ad137499e38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -846,8 +846,14 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
>  {
>         if (adev->enable_virtual_display || amdgpu_sriov_vf(adev)) {
>                 amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
> +               return 0;
> +       }
> +
> +       if (!amdgpu_device_has_dc_support(adev))
> +               return 0;
> +
>  #if defined(CONFIG_DRM_AMD_DC)
> -       } else if (adev->ip_versions[DCE_HWIP][0]) {
> +       if (adev->ip_versions[DCE_HWIP][0]) {
>                 switch (adev->ip_versions[DCE_HWIP][0]) {
>                 case IP_VERSION(1, 0, 0):
>                 case IP_VERSION(1, 0, 1):
> @@ -882,9 +888,9 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
>                                 adev->ip_versions[DCI_HWIP][0]);
>                         return -EINVAL;
>                 }
> -#endif
>         }
>         return 0;
> +#endif

I think the compiler will complain about this.  If you move the #endif
before the return, the patch is:
Reviewed-by: Alex Deucher <aleander.deucher@amd.com>

>  }
>
>  static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
> --
> 2.25.1
>
