Return-Path: <SRS0=ROs4=M4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA62C4338F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 19:41:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1592860E52
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 19:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1592860E52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C4446EB39;
	Thu,  5 Aug 2021 19:41:02 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE58C6EB39
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Aug 2021 19:41:01 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 v8-20020a0568301bc8b02904d5b4e5ca3aso6277467ota.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Aug 2021 12:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=l686f0aR6AZETBlltd1qDZRfWjVmSO5B176n1yPkOvQ=;
 b=HAKSzogBjHaGz/MmRtknrIukzojUmgTt4Rr5s5HqZchtgPstM/lth+D8ZYpKQZpzqb
 4DRFfpTDTAngj62j2qfwJ8vRvzz7Lh7R9BV/thjDZCbx5OG8xv5Yel1EuESASdqBu+6+
 X/F5pTULZeUXAYAMvZckWnAHIDA+sC2HLyroo0uDuABk0KgJmNfweerBS+i2IaoYC3cz
 433cM+fONuHf+lkEEH4UQnHLorG5rK2v2EBl1SN2EIfx7pO3L+uQgN+7/sPe6t4z5pQx
 YX7qWjK6E0TTHwz6Ou6CtZCZj2cVm0zQ27l+fQFaW0c3WbLuXb+kzbynx89cuybJanK+
 SX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=l686f0aR6AZETBlltd1qDZRfWjVmSO5B176n1yPkOvQ=;
 b=NrjZcV8CLj4+K3Sm5Xb4FuVvZf5SZmH4OwkaBG3ylcJoq8dIMYigLNmh8pfI/kuqmx
 jdwgkL0ZoXN5OGl4sRK75VpPy2qw+zJclTzsUXNCUQezt47Z+19KJmWPV5PDVv5FGPI8
 ShOKR+XTM2EWugp3lsNU9KTf8VfXNC38yPOHZtJm6DW0wSMlk3l7Wny9boCXKM0zuWsg
 eVzrZbYgnU85N/ttKM682CS5pLDVDHi/gr4KEstmQjqeYkjZuxq+9rQv11zbDePYXEEK
 lfu32Dr59TlaQIR4wICk+xEc8aqlFgyf8rPyCF9UjKYUD074IrYDiLpZsdUFGsTZYaMu
 Khdg==
X-Gm-Message-State: AOAM533yePy9izumiyLWhM848ktm0U+B0JQZGcb7cSNShoAHQ4W42dYg
 aUGlnMruwUgHEzF2nTdIDvAe2GOmejycGJ/Q+30=
X-Google-Smtp-Source: ABdhPJxgepyRnrfglhFIU+E6xqYtRxIaivQRZddDs3Oo6UOwC+2+tZQLEO5/Z7A9OsUhNU3TRK9GM9vKDw7B7OZes6E=
X-Received: by 2002:a9d:70c3:: with SMTP id w3mr4873883otj.311.1628192461066; 
 Thu, 05 Aug 2021 12:41:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210804112053.263887-1-sergio@lony.xyz>
 <296a3a38-2e9c-f3f2-66a8-70f52eaff2eb@gmail.com>
In-Reply-To: <296a3a38-2e9c-f3f2-66a8-70f52eaff2eb@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Aug 2021 15:40:50 -0400
Message-ID: <CADnq5_PcfoQijtu86BKDjGNEE3JxmsrvigMaO_mBrWQrBtmR3Q@mail.gmail.com>
Subject: Re: [PATCH] DRM: gpu: radeon: Fixed coding style issues
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: =?UTF-8?Q?Sergio_Migu=C3=A9ns_Iglesias?= <lonyelon@gmail.com>, 
 Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, 
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, 
 xinhui pan <Xinhui.Pan@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Sergio_Migu=C3=A9ns_Iglesias?= <sergio@lony.xyz>
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

Alex

On Thu, Aug 5, 2021 at 8:33 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 04.08.21 um 13:20 schrieb Sergio Migu=C3=A9ns Iglesias:
> > Fixed braces, an unnecessary if statement and added a missing space.
> >
> > Signed-off-by: Sergio Migu=C3=A9ns Iglesias <sergio@lony.xyz>
>
> Normally we see patches which just fixes coding style as unnecessary
> churn, but the "if (rbo) {}" is really ugly here.
>
> So Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>.
>
> Thanks,
> Christian.
>
> > ---
> >   drivers/gpu/drm/radeon/radeon_fb.c | 7 ++-----
> >   1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_fb.c b/drivers/gpu/drm/radeo=
n/radeon_fb.c
> > index 0b206b052972..6640b7c947fe 100644
> > --- a/drivers/gpu/drm/radeon/radeon_fb.c
> > +++ b/drivers/gpu/drm/radeon/radeon_fb.c
> > @@ -54,6 +54,7 @@ radeonfb_open(struct fb_info *info, int user)
> >       struct radeon_fbdev *rfbdev =3D info->par;
> >       struct radeon_device *rdev =3D rfbdev->rdev;
> >       int ret =3D pm_runtime_get_sync(rdev->ddev->dev);
> > +
> >       if (ret < 0 && ret !=3D -EACCES) {
> >               pm_runtime_mark_last_busy(rdev->ddev->dev);
> >               pm_runtime_put_autosuspend(rdev->ddev->dev);
> > @@ -196,9 +197,8 @@ static int radeonfb_create_pinned_object(struct rad=
eon_fbdev *rfbdev,
> >               radeon_bo_check_tiling(rbo, 0, 0);
> >       ret =3D radeon_bo_kmap(rbo, NULL);
> >       radeon_bo_unreserve(rbo);
> > -     if (ret) {
> > +     if (ret)
> >               goto out_unref;
> > -     }
> >
> >       *gobj_p =3D gobj;
> >       return 0;
> > @@ -294,9 +294,6 @@ static int radeonfb_create(struct drm_fb_helper *he=
lper,
> >       return 0;
> >
> >   out:
> > -     if (rbo) {
> > -
> > -     }
> >       if (fb && ret) {
> >               drm_gem_object_put(gobj);
> >               drm_framebuffer_unregister_private(fb);
>
