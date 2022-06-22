Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D718FC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jun 2022 19:28:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A5BD10EC34;
	Wed, 22 Jun 2022 19:28:32 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8531510EC34
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jun 2022 19:28:31 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id o10so25311372edi.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jun 2022 12:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=V4pZUiDBQaDy8cszvN67DgpVyp39WbWAzH3tK+Pb2xM=;
 b=XNIJ+DTeIVczniR6bPTYrmrxjzTCIzDXR+/kKUpaAJFHbdE/U5iN/XO1r8LvJV+zLQ
 YAUfXy+Ha00EknHCz5pEUDgyoXVGeyX6kWwd348UNKS3a14VfVbApP/Bvnc0lzMtoRif
 44GdnX1xJVxWhCldrPMFnGrtihvKW3SbuXaWqDA5aYOdNcgseTq2rkXi6hBbXxLMhRHy
 F8J5lHKtei2KB14LQubeIWG36IVIMDLMlzEAh4LmLhXJutPIotAsNvvqmsVUWD+rG9pj
 FWH0Awb/yhxz9/22YQv6IYGjqBwtOKDc04cw3FcBoprjqHfpUNjIEAgXKMafWsbElpWH
 W8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V4pZUiDBQaDy8cszvN67DgpVyp39WbWAzH3tK+Pb2xM=;
 b=xhvLo3uOU1bRkClZQCwsSfL6P71p4yIMNxmVweDN6KyVy0vO+BtPoH2fsj+pj0bpUC
 kjc3GhZ/n5Yfrj1Hs+o9FDj6P953gu5r5dcrf1JY2PRuiUguuXnJN6tY/RfjY3atf9CM
 s+gpaScj+qJwZRlPVXKFcBgCXQ0yp//EwptBqymkYTBrl4VOk0Wiefgbd5Ikvub115iK
 NeR/7VcPHjA33noeqhS0+9jnqqszt3WXQznbEbKCK3Vq1GwLVdtAqTCC6XB0/8te4iB8
 bJDZ5wUakxEacHVvNPEF03zccumnlCN5PAf9VYq5irP6aM4e07vw/qpkYATgtQYwjcEr
 d/Wg==
X-Gm-Message-State: AJIora9x3u502l76RK+hArt5ZfOCL+VmNNUpQ/JG9nk801qROXEdc93/
 kHZ4iMIJKz2wM9aROTXDD+O7k1Xgpgw6Ddn2nECbDGIP
X-Google-Smtp-Source: AGRyM1uoE+6CFMuWobWwwQD0QCDT4+Wque+7jriaYgF0Gu9FyLeKV+jDgnX9i4jruhfh0gl11CE0l/pOOc/RW8iMdNU=
X-Received: by 2002:a50:fe0c:0:b0:435:510a:9f1f with SMTP id
 f12-20020a50fe0c000000b00435510a9f1fmr5954155edt.297.1655926110053; Wed, 22
 Jun 2022 12:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220622142538.27843-1-ruijing.dong@amd.com>
In-Reply-To: <20220622142538.27843-1-ruijing.dong@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 22 Jun 2022 15:28:18 -0400
Message-ID: <CADnq5_NPjqQ+aHqTT-7VL0aiQO06WJ=Av==76R+M6JP4F=A8UQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vcn: fix no previous prototype warning
To: Ruijing Dong <ruijing.dong@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 kernel test robot <lkp@intel.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Jun 22, 2022 at 10:26 AM Ruijing Dong <ruijing.dong@amd.com> wrote:
>
> Declare 'static', as the function is not indended to be used
> outside of this translation unit.
>
> Fixes: 748483dbc215 ("drm/amdgpu/vcn: add unified queue ib test")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index fea436023351..1bfdfb9207ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -330,7 +330,7 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
>  }
>
>  /* from vcn4 and above, only unified queue is used */
> -bool amdgpu_vcn_using_unified_queue(struct amdgpu_ring *ring)
> +static bool amdgpu_vcn_using_unified_queue(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev = ring->adev;
>         bool ret = false;
> --
> 2.25.1
>
