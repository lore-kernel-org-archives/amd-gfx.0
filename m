Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC779C55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 13:39:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B93F10EE75;
	Wed,  5 Aug 2026 13:39:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oatMD7Wf";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4535710EE72
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 13:39:24 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-84a32ff53fcso198482b3a.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Aug 2026 06:39:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785937163; cv=none;
 d=google.com; s=arc-20260327;
 b=QFMPcG+CTSKt8oU1NMyzEAfnQpJznPm5XnYenFoFb8W/0e7HYvb4ISYh+hCLZ8AQNI
 94fPKBWDibiacxRbPeRdrI7vD5SnM/dvDX5FkaXuXHXCBID8+MOhULe73DcGYf5o4A8J
 Pef/MJLEz0W7cf+/Ikv4Mv0AXTZM+h/UklBlJpIKv5TxfbzY68LzxU5GljwK7fZmgWbl
 pHJZx92rU3B6q6hjVoj8fapEj1j7E0L6bzORMPYFE3jPA0HIPNlnFetx3qMmPqOHMLAP
 UKW2CM7W9eE5GRC0q9HPxqHJ1nq/Y6A7l+yqR1gV/3W0uC/o1KTCHfxLpXP7bSlbJNKS
 5iNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ECIWABTBcOqFonFT5Wh5Ai/7Qs3x8/w4E/9Ac+O/Ce8=;
 fh=y/dhdUHUwAOfgnqgRhdz/n6FGkdFSsqHDZRKWFYuo9I=;
 b=rR3UfwIobVkY/lD4XYr3ObJ9HdgUjshB5sWULRZLb+A67DEbmVU7DTs5LKfKuldiR2
 R1l8VrmWPFpqsp66zALJL8ftHc+sUUClI7p2jjpJ+DmOjWD0BepO++h2IcjxoR8eCAEm
 Uy5XIGIbbBuIY2i3fBQupltWEdj/hXH2hl5C75Ev3IJdfa81rXfxDnLT4uXixsE+rdNK
 vXrxPHLIpQ4VdsrcHnc60YwWsSHh5hmDgQ+jk94lI9UjGHAcT/StlA+ZQM+XQ8LuEJAn
 h0Z8KYxn3CkQvX8V55BD6WzPF+AQw16rZTttzgpuAr/oqSKJoKZcEwJ1AvwP0JFYWesJ
 EclA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785937163; x=1786541963; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ECIWABTBcOqFonFT5Wh5Ai/7Qs3x8/w4E/9Ac+O/Ce8=;
 b=oatMD7WfUsMfXlH12sW7Y/VSAI2iOEQk8CEXj38tMicQpHn3FQJwLEQsX0E5m3cbcb
 xxYpOh+JPjWG9wK3OpxjA9IZtqeNe3ObnNPueT3oPgRTzhUrOUUAD/SNeZ5PSdrXoER/
 fcRtsw9xxOFdOsXlsDYt+ZxUnTv6FB7ciLQ38NHOxlaGEa0NFvkd4RZv/XWV68AMY9Uf
 LAYCmLxHKqsukJ7qY3l/gpPSI5Q16xI5NnIRPIS2gnckem4/u2XbjkG9s7BWzR5Evu62
 hey9bFQRMXoVgLj5pZ/MGt2Wn+SYa9pCOAg93LgTTKnh8KVk7F8o6rDNcEdKWfb1nV+g
 RgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785937163; x=1786541963;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ECIWABTBcOqFonFT5Wh5Ai/7Qs3x8/w4E/9Ac+O/Ce8=;
 b=FLJAXxPZfMeGfB9023WAHrJg/+yKJB/b+Mz+As+pcRwVKsXRm++YOTFwVKJz1vuy6c
 Kecg2J0WnKaZ/y7C6HKkDrEUVA41OMi4csp5fFsYLzs8Bl25365y/zMiDTNovCBHeJUZ
 X3sunm0g0UBF5fuEKpyQLfTeNESWNj4Y1s9EVbk0YuZXbwY3FwqOY9xjEDso53Pb1tdz
 t6iRg32b2LVJfynmXW+mNBtEC99x7EIMMY7zvGs2EIAeWJMgaC862GIOq9o8ZwaZMcsh
 vE1+B4VFe1W8WuqXDY5h07pp2CyNv1zfwDw66JUXTsN7nXh2rO7XR4fallY+UxF2uX8O
 s4nA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqkzI5NL/6sQK7d3LnJ3rpqE/0m/nJoJ5GLRc0+htK88bsqFfCr4smYJIbIdXJoVxZCC+m42Kzz@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx1F6HJYOgGngtbjLhw2Z6BNIG7qq4IHmKlELxqRzg4tlh/Juzm
 RmNYrwQ11WWyy0r/8OmRLGOonaewq8JFgiEZ47nDJ4emmE0QLeYX/xgEzMUKd/OKezldeyDN5q5
 uAEtKAXDSTHA2YtjSV3uaD/0+dCTOtZs=
X-Gm-Gg: AR+sD10Rr+cD7JnyxuhTxSW4AUOTl+gUPnrplcpW4wjjyo/T4WD+oWHTLvZpCdG0F5e
 TKdFIfrsWUuNEQQnWdqYA8/v5RZilT+U6giNTui/Pmr2OJDnN/6DtNYOLVNaMz8HgZ26o4qzvQm
 e3yxmfSMdaqsyApV1Xpg1SW3+m6+tYrGQ+mQxsddYlb+TI5hIz03QJ7gyu+LP77Q8+AXV7QW4sV
 Qq0HuMp3HQ/IDtmRrWsTF2XB3eeh9yWf6KrJKIaucEPBz9j0cp0aUQfbWxuj2zVKwFA9hmUEfAb
 J/JskX9e8f7UOaL80U7bmns4eXr7DbtVJRB75spCRg3e7LnGXdvzMHmOrHVRp2SUDWBqyWiP1+r
 Xmcq5fc9Y+YjdE5plIeaxWM0P83s1qv0=
X-Received: by 2002:a17:90b:3803:b0:38e:55ec:e436 with SMTP id
 98e67ed59e1d1-3903b9c95aamr5354563a91.0.1785937163422; Wed, 05 Aug 2026
 06:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_BB2A7CAE632BA0AC08D9296E78A15786200A@qq.com>
 <baa434d9-e0a9-482d-a071-42d204b82126@amd.com>
In-Reply-To: <baa434d9-e0a9-482d-a071-42d204b82126@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 Aug 2026 09:39:11 -0400
X-Gm-Features: AUfX_mwCMrINTWDajJUvcp2l7VES5zI87cc7gtPBOxTJCBpr0mmv9h6RdFUpFMw
Message-ID: <CADnq5_Ny144v_gZZWOpr+YngTEJnyc80q=NVgy=53k1g6rk-Lw@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: restore hardware polling in fence_is_signaled
 to fix performance regression
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: 2564278112@qq.com, alexander.deucher@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Wang Jiang <jiangwang@kylinos.cn>, Philipp Stanner <phasta@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Applied.  Thanks!

On Wed, Aug 5, 2026 at 4:53=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 7/29/26 12:26, 2564278112@qq.com wrote:
> > From: Wang Jiang <jiangwang@kylinos.cn>
> >
> > Commit 9eb00b5f5697b ("drm/radeon: delete radeon_fence_process in
> > is_signaled, no deadlock") removed the hardware polling from
> > radeon_fence_is_signaled() to fix a self-deadlock caused by
> > wake_up_all(&rdev->fence_queue) being called with the fence queue
> > lock held.
> >
> > However, removing the polling entirely causes significant performance
> > regression (e.g. glxgears FPS drop) because the fence signaled check
> > becomes purely passive =E2=80=94 it only reads the cached last_seq with=
out
> > probing the GPU, so completed GPU work is not detected in time,
> > causing unnecessary CPU stalls in sync-heavy workloads.
> >
> > Fix this by calling radeon_fence_activity() directly instead of
> > radeon_fence_process(). radeon_fence_activity() reads the hardware
> > fence counter and updates last_seq via atomic ops without calling
> > wake_up_all(), thus avoiding the deadlock while restoring timely
> > fence detection.
>
> Yeah I already feared that removing this in commit 9eb00b5f5697b could ca=
use issues.
>
> Adding Philip and Danilo since we recently had a discussion about the nec=
essity of this.
> > Fixes: 9eb00b5f5697b ("drm/radeon: delete radeon_fence_process in is_si=
gnaled, no deadlock")
> > Signed-off-by: Wang Jiang <jiangwang@kylinos.cn>
>
> As far as I remember the radeon code the solution should work, but I don'=
t have time to double check.
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Thanks,
> Christian.
>
> > ---
> >  drivers/gpu/drm/radeon/radeon_fence.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/ra=
deon/radeon_fence.c
> > index 02a40e4750c7..299865569252 100644
> > --- a/drivers/gpu/drm/radeon/radeon_fence.c
> > +++ b/drivers/gpu/drm/radeon/radeon_fence.c
> > @@ -360,6 +360,13 @@ static bool radeon_fence_is_signaled(struct dma_fe=
nce *f)
> >         if (atomic64_read(&rdev->fence_drv[ring].last_seq) >=3D seq)
> >                 return true;
> >
> > +       if (down_read_trylock(&rdev->exclusive_lock)) {
> > +               radeon_fence_activity(rdev, ring);
> > +               up_read(&rdev->exclusive_lock);
> > +
> > +               if (atomic64_read(&rdev->fence_drv[ring].last_seq) >=3D=
 seq)
> > +                       return true;
> > +       }
> >         return false;
> >  }
> >
> > --
> > 2.25.1
> >
>
