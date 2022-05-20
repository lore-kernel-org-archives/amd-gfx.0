Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC2CC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 14:39:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B45EF10E092;
	Fri, 20 May 2022 14:39:15 +0000 (UTC)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CB5010E092
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 14:39:15 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-f1d2ea701dso10507747fac.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 07:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3AATNQ/IdLv7D+IZQaJo6R0yqMY6O4deWWVsnQKrYJs=;
 b=fPEPwNR4QO06ts/eTnUsek4bIVrwDoYxJLDoR71u5qHdJiV8sbreebVmFGTuZ7jRor
 dHOnetfnplxqxtHKFp7nUVfO7t88ASJFCfU4oGBfsUcEhmwC/+MYzdt3P2hDTLu08ox2
 KC5MJ9CfkZy4Huv5jJFoa5wLQAtiQensckNYy7dcdyKwOTAoXqjWteozN5PET34Z4sjY
 R7Tu1GfIbm9Or9RuSkEgwcXi0p921MFClfnY2wNxFP8vRUIM0Bpu63vw92n7htx6jjwV
 yKMt1EHhU8VreAsaIXsbU97q/BfeWUQKaSbazcE9qXa9clYk/G3+k8/lrfrnT5IHEtwX
 0Bhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3AATNQ/IdLv7D+IZQaJo6R0yqMY6O4deWWVsnQKrYJs=;
 b=Lc2ZeS6y5JGRoEHZhGfU4GAbEGkbo7XBCiZvnR8zZDUEk3IWRk1R3bMd0zvY/HVG7t
 KSr/Y+YJI8Id9uieNiV2l0ACstEkHQjFbsoBXht+TBmsQvvKE8v9fBNGi0VFYycL9ysw
 uHcc7yck3hc3VLT7HVyW7GocQFe59IVgwaXo7Bsc9xdL53SjLeQpIYrdGokXp8fzV/2K
 U5k4VVcXrpIidxm0zJo6Nis862pyk1z7ieO4tBNWguJGP22DdhGRJwPzGRDLvJUM0Kvk
 e7Kp2GT6ssT/Me67fpftx6qVIsR8AgOfS+JgSInmtq2MeYKihg1qKTrzJIbF/+cUHQxP
 7tzA==
X-Gm-Message-State: AOAM531uzuscInBJ6l+iG2VGBHwpxq+ApxCntIIX3w0WZfb4M88P40C1
 Q+L/GeyvUVjOqCfUffN/oKJaIs2iATzUH1c+V0w=
X-Google-Smtp-Source: ABdhPJxXGBZos0xve04f14jjuTfOUmCA6aeT9fL+zJFXKckfadmgwVvr+8V/rC1CpwzLipEJQhU+Q+OW05mb1u4Ife8=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr5969606oaa.200.1653057553749; Fri, 20
 May 2022 07:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <YoH3zD7umruSyPms@kili>
 <b54971f1-e0d2-35a2-f3cf-0486569b63f5@amd.com>
In-Reply-To: <b54971f1-e0d2-35a2-f3cf-0486569b63f5@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 20 May 2022 10:39:02 -0400
Message-ID: <CADnq5_MwJ4YO+oZKEkZndu5dDRVyRSkT_dgK06v6m1Fm67k9xg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Off by one in dm_dmub_outbox1_low_irq()
To: Harry Wentland <harry.wentland@amd.com>
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
Cc: Wayne Lin <Wayne.Lin@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Jude Shih <shenshih@amd.com>, Qingqing Zhuo <qingqing.zhuo@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, kernel-janitors@vger.kernel.org,
 Roman Li <Roman.Li@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Simon Ser <contact@emersion.fr>, Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Thu, May 19, 2022 at 4:53 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2022-05-16 03:05, Dan Carpenter wrote:
> > The > ARRAY_SIZE() should be >= ARRAY_SIZE() to prevent an out of bounds
> > access.
> >
> > Fixes: e27c41d5b068 ("drm/amd/display: Support for DMUB HPD interrupt handling")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 6edfc0963dab..c4f122c6faec 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -770,7 +770,7 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
> >
> >               do {
> >                       dc_stat_get_dmub_notification(adev->dm.dc, &notify);
> > -                     if (notify.type > ARRAY_SIZE(dm->dmub_thread_offload)) {
> > +                     if (notify.type >= ARRAY_SIZE(dm->dmub_thread_offload)) {
> >                               DRM_ERROR("DM: notify type %d invalid!", notify.type);
> >                               continue;
> >                       }
>
