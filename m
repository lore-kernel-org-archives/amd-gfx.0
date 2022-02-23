Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6641C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Feb 2022 18:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7487310E359;
	Wed, 23 Feb 2022 18:54:47 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CD0510E359
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 18:54:46 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 d134-20020a4a528c000000b00319244f4b04so23595173oob.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 10:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lBj6vreYxaRq3LMRB9rCDxDzQzeiXN4n4DuiHu+Q2ns=;
 b=WU9Rr0JqEYBvpYOf97saXnv4r8OkTRYUYvIlWUpiqpVC3JGfhR71qbQPuiJb2p8rcg
 SrmMNZBHnhliSIy0qYwvDp1Rj/QmfZc3C7Flh+kK8XABOsXib5B34c7ivQdUThlgDgBL
 4M2ypdAws81MEpxtmVlD8CTXhyierZVwHQCxjp/lpQOvK6CtOUMW59nsQ4RuFZW2Et6b
 D9w5DtmMOvMHvQ9V2YiU7oaYtWxzNuvraX1OAiXqqn/gxi56AAwJQ/+4WTlh+7Y/iJjP
 aRolPkALR8fy2n9u6uyhXEd58x2HxEETpVGmxNzlp9WzMGM+I+Eve1g0O2tH/uTn/5H1
 4rRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lBj6vreYxaRq3LMRB9rCDxDzQzeiXN4n4DuiHu+Q2ns=;
 b=l77bP7AH2XUQeoDDGqLF8OnpVZWYl+sEv7te2cxF+rDl6/e/7VK3pTkYzSMsgwu9oC
 zoEW/LXJmUJhxpSEDzUL6v1K5rpAQ3+KPSNL71eb8WtO3uq7NTzr3dLNtFyvpYQQqBH5
 BwRZWohYdRgiDNpmBxOG3J57VtOtq/dLwTyHwGSWg8zH3C7WEENXVFAuFZNZlpYgZl1l
 IUNKFMS9IoSS4cV62dUrG9b+D/CbkUL1ZQPXQ23q+jU4G3gtfOoJL4ZJpXpWbkcnk65i
 lFtGg/fwpEKGxRTnba+iiMQOL0Ti9Fdsx0+ZWFO8lb2dXpj+P7ipqCxlZ9ufcROm5afE
 mdOQ==
X-Gm-Message-State: AOAM530CCr327pc7e8UPC/SeKqiZfNLAGVxC29zevZKr688UeXHhn3SW
 cDb6KdRuw9OWpeXCu6b0vc+IQR39OHlYTyotieK0o5Ug
X-Google-Smtp-Source: ABdhPJzS8YiVL/F+46aftPHf2alsA5o7JgC8a6v5qA6iHWFcJeaumOXVKahNp4QoFmNXuPnzDLv5SoHYMYxoIH0L/pc=
X-Received: by 2002:a4a:db64:0:b0:2ea:37f4:d798 with SMTP id
 o4-20020a4adb64000000b002ea37f4d798mr377010ood.23.1645642485337; Wed, 23 Feb
 2022 10:54:45 -0800 (PST)
MIME-Version: 1.0
References: <20220218165349.7489-1-alex.sierra@amd.com>
 <20220223174756.759-1-alex.sierra@amd.com>
 <f55192e6-3f85-715e-6b5f-9b188a7ba949@amd.com>
In-Reply-To: <f55192e6-3f85-715e-6b5f-9b188a7ba949@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 23 Feb 2022 13:54:34 -0500
Message-ID: <CADnq5_NF1XN79t9xiG7hZA2w0ugHARGLKm-UAQ8kj5d8e2WTYA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add use_xgmi_p2p module parameter
To: Felix Kuehling <felix.kuehling@amd.com>
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
Cc: Alex Sierra <alex.sierra@amd.com>, "Kim, Jonathan" <jonathan.kim@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Tuikov,
 Luben" <luben.tuikov@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 23, 2022 at 1:47 PM Felix Kuehling <felix.kuehling@amd.com> wrote:
>
> On 2022-02-23 12:47, Alex Sierra wrote:
> > This parameter controls xGMI p2p communication, which is enabled by
> > default. However, it can be disabled by setting it to 0. In case xGMI
> > p2p is disabled in a dGPU, PCIe p2p interface will be used instead.
> > This parameter is ignored in GPUs that do not support xGMI
> > p2p configuration.
> >
> > Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> > Acked-by: Luben Tuikov <luben.tuikov@amd.com>
> > Acked-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 1 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 8 ++++++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h | 3 ++-
> >   3 files changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index f97848a0ed14..7e95d8bd2338 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -217,6 +217,7 @@ extern int amdgpu_mes;
> >   extern int amdgpu_noretry;
> >   extern int amdgpu_force_asic_type;
> >   extern int amdgpu_smartshift_bias;
> > +extern int amdgpu_use_xgmi_p2p;
> >   #ifdef CONFIG_HSA_AMD
> >   extern int sched_policy;
> >   extern bool debug_evictions;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index 2f8eafb6cf22..6156265f3178 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -181,6 +181,7 @@ int amdgpu_tmz = -1; /* auto */
> >   int amdgpu_reset_method = -1; /* auto */
> >   int amdgpu_num_kcq = -1;
> >   int amdgpu_smartshift_bias;
> > +int amdgpu_use_xgmi_p2p = -1;
>
> We usually use 1- as default if some logic is needed to figure out the
> actual default value. I don't think that's applicable for this option.
> Why not make the default 1?

If we want to make -1 the default we should document it as "auto" so
we can allow for different configurations in different situations.
That said, I don't really see a case where we would want to disable
xgmi by default unless there was some hardware limitation, and at that
point, we could just change the default to -1.

Alex

>
>
> >
> >   static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
> >
> > @@ -677,6 +678,13 @@ MODULE_PARM_DESC(force_asic_type,
> >       "A non negative value used to specify the asic type for all supported GPUs");
> >   module_param_named(force_asic_type, amdgpu_force_asic_type, int, 0444);
> >
> > +/**
> > + * DOC: use_xgmi_p2p (int)
> > + * Enables/disables XGMI P2P interface (0 = disable, 1 = enable). The Default is -1 (enabled).
>
> Same as above.
>
>
> > + */
> > +MODULE_PARM_DESC(use_xgmi_p2p,
> > +     "Disable XGMI P2P interface (0 = disable; 1 = enable; -1 default, enabled)");
>
> Same as above.
>
> With that fixed, the patch is
>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
>
> > +module_param_named(use_xgmi_p2p, amdgpu_use_xgmi_p2p, int, 0444);
> >
> >
> >   #ifdef CONFIG_HSA_AMD
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> > index 0afca51c3c0c..095921851fb5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> > @@ -66,7 +66,8 @@ uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
> >   static inline bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
> >               struct amdgpu_device *bo_adev)
> >   {
> > -     return (adev != bo_adev &&
> > +     return (amdgpu_use_xgmi_p2p &&
> > +             adev != bo_adev &&
> >               adev->gmc.xgmi.hive_id &&
> >               adev->gmc.xgmi.hive_id == bo_adev->gmc.xgmi.hive_id);
> >   }
