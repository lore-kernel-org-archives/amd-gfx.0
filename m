Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AA9C3F2CD
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 05:22:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF7C2072D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 05:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CysDEliH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF7C2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F9EA6E14B;
	Thu,  5 Mar 2020 05:22:38 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB346E14B
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 05:22:36 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id p9so4753679wmc.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Mar 2020 21:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KYpMU0kv9EaUAUU/bF8CenyvlizFkPUrWZ4XRi04Xg0=;
 b=CysDEliHgT8HEcFT9h/n/QiakPaf8Rbt4HScg4wiJxNGUMloSU0pj3A2BZA/8as8/4
 JurqYf8NKVVkkt0gT1ohAFfFeeODmRomZe80nHZF0RlGimz4LWCS0hzJxP8fTgMB64ZX
 n8t1lIFl3nACa0or/atfQoUFbXYWHxl8edDmD46n3B+aqHs7vRIjwOVA7eg9QZM8UvSD
 P/dsMHxqsT64v8C2GnPLWonzT/ftrOckpL3qOe45d7v2AQZVJvGSAZZ9P5SkwFxwB5hp
 ABrBWgPPLtO3F6uD9H/BZ3ONPEFakzoF+7ViUbkPnlDlOFBCI82uATQnuac8H0rjQOjc
 TTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KYpMU0kv9EaUAUU/bF8CenyvlizFkPUrWZ4XRi04Xg0=;
 b=CscLRC9OizZYKmq+ORaA4nH6PV5zHshS4/qXAjPPNck5Wt7hoEv8CQqw9PINNWxsO4
 XUP+RhcIFANFhdaD9Kgh+eKOjul2ooXDzhuWQUwn3mYR2AgI2ar5ERJvsLlc09/bRjpd
 nR5nG+Flcdv7LR7oO+41AMeMtXHEcIYvZxpuJYaRAs8Ma0Nf6LHm0MvV7ATlySeW5Eop
 2sjLpfiytWL0qUrNY3TpCs9YA8pjoBQkyFw34++pUndjtpr3Y4GjmCBiCr4nskPsoQkw
 4m/4TccT6Sov77h3AC3dQKH9F2ftgECAwEZGjzF4KwImCTswbFwv2vL89sYl5pArri/9
 D3gA==
X-Gm-Message-State: ANhLgQ05MeXxkjthQ2UFkZQFvUL6jI9oH4PQQg3flwTe2DHDOlpQ06+1
 gMpvVvLjZO10U95HZc4XTByYkFHGXKDgepYBamdynQ==
X-Google-Smtp-Source: ADFU+vtFG+Dxp2px7+QBtT4+uVj7M6GbS6B+hLpwboebYtf9VKknjKyFFbCUfL7wjBSJXy5hgtyZ3PG7mAD5fAGaSTo=
X-Received: by 2002:a1c:f009:: with SMTP id a9mr7241142wmb.73.1583385755187;
 Wed, 04 Mar 2020 21:22:35 -0800 (PST)
MIME-Version: 1.0
References: <20191216171834.217251-1-alexander.deucher@amd.com>
 <20191216171834.217251-3-alexander.deucher@amd.com>
 <CADnq5_M5JvZuH1_GHyMvvi6Xi6AwLsoBSXhg9=7tPO_KVB8mqg@mail.gmail.com>
In-Reply-To: <CADnq5_M5JvZuH1_GHyMvvi6Xi6AwLsoBSXhg9=7tPO_KVB8mqg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Mar 2020 00:22:23 -0500
Message-ID: <CADnq5_Pd+ienAP3ZkLPZaGVeN3OyRgkQeVws6twfm5HsnsVhPQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Enter low power state if CRTC active.
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Wed, Feb 19, 2020 at 11:25 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Mon, Dec 16, 2019 at 12:18 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> >
> > CRTC in DPMS state off calls for low power state entry.
> > Support both atomic mode setting and pre-atomic mode setting.
> >
> > v2: move comment
> >
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> Ping?
>
> Alex
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 45 +++++++++++++++++++++----
> >  1 file changed, 38 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index 61dc26515c7e..e7f7463a0cbe 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -1296,24 +1296,55 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
> >  {
> >         struct drm_device *drm_dev = dev_get_drvdata(dev);
> >         struct amdgpu_device *adev = drm_dev->dev_private;
> > -       struct drm_crtc *crtc;
> > +       /* we don't want the main rpm_idle to call suspend - we want to autosuspend */
> > +       int ret = 1;
> >
> >         if (!adev->runpm) {
> >                 pm_runtime_forbid(dev);
> >                 return -EBUSY;
> >         }
> >
> > -       list_for_each_entry(crtc, &drm_dev->mode_config.crtc_list, head) {
> > -               if (crtc->enabled) {
> > -                       DRM_DEBUG_DRIVER("failing to power off - crtc active\n");
> > -                       return -EBUSY;
> > +       if (amdgpu_device_has_dc_support(adev)) {
> > +               struct drm_crtc *crtc;
> > +
> > +               drm_modeset_lock_all(drm_dev);
> > +
> > +               drm_for_each_crtc(crtc, drm_dev) {
> > +                       if (crtc->state->active) {
> > +                               ret = -EBUSY;
> > +                               break;
> > +                       }
> >                 }
> > +
> > +               drm_modeset_unlock_all(drm_dev);
> > +
> > +       } else {
> > +               struct drm_connector *list_connector;
> > +               struct drm_connector_list_iter iter;
> > +
> > +               mutex_lock(&drm_dev->mode_config.mutex);
> > +               drm_modeset_lock(&drm_dev->mode_config.connection_mutex, NULL);
> > +
> > +               drm_connector_list_iter_begin(drm_dev, &iter);
> > +               drm_for_each_connector_iter(list_connector, &iter) {
> > +                       if (list_connector->dpms ==  DRM_MODE_DPMS_ON) {
> > +                               ret = -EBUSY;
> > +                               break;
> > +                       }
> > +               }
> > +
> > +               drm_connector_list_iter_end(&iter);
> > +
> > +               drm_modeset_unlock(&drm_dev->mode_config.connection_mutex);
> > +               mutex_unlock(&drm_dev->mode_config.mutex);
> >         }
> >
> > +       if (ret == -EBUSY)
> > +               DRM_DEBUG_DRIVER("failing to power off - crtc active\n");
> > +
> >         pm_runtime_mark_last_busy(dev);
> >         pm_runtime_autosuspend(dev);
> > -       /* we don't want the main rpm_idle to call suspend - we want to autosuspend */
> > -       return 1;
> > +       return ret;
> >  }
> >
> >  long amdgpu_drm_ioctl(struct file *filp,
> > --
> > 2.23.0
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
