Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A04EC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 03:07:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BF9F10E9FC;
	Thu, 27 Jan 2022 03:07:29 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BEAE10E9FC
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 03:07:27 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id bb37so3479456oib.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 19:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XXWrVx301HkRuKjqCT79ZnzYZDoF3v+HS4qHgBz1/Ug=;
 b=k/MWi7VBcoVEEZObrLlSJ9gWRP4DvCkknqHHCMJtI0x0GQnPf34OU/DRZvk77mdCiF
 M/WNPy+qAi3skikV0NkmjLHmRvq7Gx5JgfYQD0xtUvoNEvgBQQ/+cWw+vK4xoM0tKu+z
 OZ8qsnfzog6KkJ0EP5eGiRIJtgAv8xZ3xNhZ9GCsq9I1AU3G0PfDTdn+bj3vCU56tNuE
 conTE4PpIEJxcQ7DP2UMo2lexm1hO2pBcASQ8HPc+04E1hmAXUe9Ea/Ev6ClcZ2b2/k4
 juRsMJkYusbUxCOcldjBmO2bk2gBYlDViYd7JW437wejltW6A24+o6UG9mR5cEzkGlTi
 mFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XXWrVx301HkRuKjqCT79ZnzYZDoF3v+HS4qHgBz1/Ug=;
 b=4OJIvQ/4LNYHxM2IPiUHoiKX/e+LeS59PNleTGSG7IeZRS9ilj7kKFxDJBf280a2kS
 glfUeG+fYUmLhpbg2rg2pMR6s9XzSQoHhWJcuzuWsTtCmUXaYFhxqPPTykqz301j69of
 IVRU6tfquNWqgwLcyfiASkix6fMazdLU1KsxF5jM2a9P+sva1ylgrEieZMheATE8EGn8
 jy8SFdEwq6038pi/4Aq4kETR4M+yI9MkBz/e/rIvATEh9W3faP3VpTeuLhq407up4xoF
 JYv6EuDmUB9FW/VJRK0zL5+PwfzNfXN6J7Fynh1AbXd5fMYHeN6/iyL/ZnJ51HmU2eJ6
 yElw==
X-Gm-Message-State: AOAM532SOqZJ6iVrOPlLFRZhM4tt2QBBBrethGIs7D0nNgTiKOnsEv4A
 s19LC1gmCM7fB0YGZH/KAa0CMWhuGVMqJ6edYqCmGoqc
X-Google-Smtp-Source: ABdhPJwe0Ec276LSJaVJj0q94g7CSgPPJLik+wtFFeZ9pIu4Wc8xIXjd7mKYE/kPKUk2U4V3nBN+8YsNe01DGeqmhg8=
X-Received: by 2002:a54:4e94:: with SMTP id c20mr1061465oiy.132.1643252846835; 
 Wed, 26 Jan 2022 19:07:26 -0800 (PST)
MIME-Version: 1.0
References: <20220127014806.2592589-1-aaron.liu@amd.com>
 <20220127014806.2592589-2-aaron.liu@amd.com>
 <YfH+RLzLIXzPZXmp@amd.com>
In-Reply-To: <YfH+RLzLIXzPZXmp@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Jan 2022 22:07:15 -0500
Message-ID: <CADnq5_N3WrFUEXXjKRba6cgTxJee+wEYw7m2FcQV7dtD4Aiwsw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: add 1.3.1/2.4.0 athub CG support
To: Huang Rui <ray.huang@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Jan 26, 2022 at 9:07 PM Huang Rui <ray.huang@amd.com> wrote:
>
> On Thu, Jan 27, 2022 at 09:48:06AM +0800, Liu, Aaron wrote:
> > This patch adds 1.3.1/2.4.0 athub clock gating support.
> >
> > Signed-off-by: Aaron Liu <aaron.liu@amd.com>
>
> Series are Reviewed-by: Huang Rui <ray.huang@amd.com>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/athub_v2_0.c | 1 +
> >  drivers/gpu/drm/amd/amdgpu/athub_v2_1.c | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
> > index ab6a07e5e8c4..a720436857b4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
> > @@ -78,6 +78,7 @@ int athub_v2_0_set_clockgating(struct amdgpu_device *adev,
> >               return 0;
> >
> >       switch (adev->ip_versions[ATHUB_HWIP][0]) {
> > +     case IP_VERSION(1, 3, 1):
> >       case IP_VERSION(2, 0, 0):
> >       case IP_VERSION(2, 0, 2):
> >               athub_v2_0_update_medium_grain_clock_gating(adev,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
> > index 2edefd10e56c..ad8e87d3d2cb 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
> > @@ -74,6 +74,7 @@ int athub_v2_1_set_clockgating(struct amdgpu_device *adev,
> >       case IP_VERSION(2, 1, 0):
> >       case IP_VERSION(2, 1, 1):
> >       case IP_VERSION(2, 1, 2):
> > +     case IP_VERSION(2, 4, 0):
> >               athub_v2_1_update_medium_grain_clock_gating(adev, state == AMD_CG_STATE_GATE);
> >               athub_v2_1_update_medium_grain_light_sleep(adev, state == AMD_CG_STATE_GATE);
> >               break;
> > --
> > 2.25.1
> >
