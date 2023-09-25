Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BFDCE7AA5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 17:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8351C10E2AE;
	Mon, 25 Sep 2023 17:04:50 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA49810E2AE
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 17:04:48 +0000 (UTC)
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2bff776fe0bso114692351fa.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 10:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695661485; x=1696266285;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7kX39Ca8A6vbWsrSc61cEoyakqRV/gh0/WoLN88Nm/E=;
 b=V/ugE3V35NNpTZJPiCS089pguyfOk6aiaqtruAuzxWfZPNkq2Kxd1cYeb12vYNUOQK
 hRIPx7Xo9uCQnL4DVhIh7ByzVZm/dlDjoB6spoPm6czG2Zv2nBoU2XvfC+7hFH5nyA0z
 tcEkre+EBBqN35Ecbp72dVlwLVu1gEEgPvLRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695661485; x=1696266285;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7kX39Ca8A6vbWsrSc61cEoyakqRV/gh0/WoLN88Nm/E=;
 b=IENpOatq95pA6r+4l5WZNUCPxfny7yAvF680mSddXgOGROxkuw1WUXQPFApNsn9tAT
 4iiqrvt0v8hFVr2QFrW8nuQziCrDnaQfQ7enH2hKPJlJKIOXm3V29ivPyBbWATOAJYKj
 FpLepmTuFTyVISG66tGX7rvoyr+SvP3TckBwXQsPPAG/G/iRMMPMyLi4VvnZEONxCmTo
 g47r7/fpsHzQX6G59qQsNKrcusIDrRdBwQaJdPc5hzYpMTylmVknm/z74LlnvkF/U57d
 CWQDUCHNCiAbZlYvqmAA4evENoeJmkrXcPtvSVe6KcT+XumbzpwzJt+TGRDrX3Xuu5dr
 glNA==
X-Gm-Message-State: AOJu0YyM9Np4c4UuHEPwIrl1aqLjYd6otLu6jVx3EriFBHpjpjwcs74r
 dv40OU2O4EZUKT/YySaCDOAMltJVNXNEveEkz7oomeCJ
X-Google-Smtp-Source: AGHT+IGgRnrQryfGPQj5y+5TRAVFFf7Nk58bFY2x9vlJxnuepdZu8uJfShkGcAgXdB/GFUkdVbKvTg==
X-Received: by 2002:a05:651c:88:b0:2bd:1f83:8d4 with SMTP id
 8-20020a05651c008800b002bd1f8308d4mr6573881ljq.22.1695661484622; 
 Mon, 25 Sep 2023 10:04:44 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com.
 [209.85.208.50]) by smtp.gmail.com with ESMTPSA id
 i13-20020a1709061ccd00b00991faf3810esm6635578ejh.146.2023.09.25.10.04.43
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Sep 2023 10:04:44 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-53368df6093so547a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 10:04:43 -0700 (PDT)
X-Received: by 2002:a50:a699:0:b0:525:573c:6444 with SMTP id
 e25-20020a50a699000000b00525573c6444mr6897edc.1.1695661483259; Mon, 25 Sep
 2023 10:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230921192749.1542462-1-dianders@chromium.org>
 <20230921122641.RFT.v2.7.I27914059cc822b52db9bf72b4013b525b60e06fd@changeid>
 <BL1PR12MB514407EE7F9B23BC58E40A6CF7FCA@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB514407EE7F9B23BC58E40A6CF7FCA@BL1PR12MB5144.namprd12.prod.outlook.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 25 Sep 2023 10:04:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UK_tWO7Vr2FJiaVX11DwfS7+VhrUoGZa989U7y_vtKOg@mail.gmail.com>
Message-ID: <CAD=FV=UK_tWO7Vr2FJiaVX11DwfS7+VhrUoGZa989U7y_vtKOg@mail.gmail.com>
Subject: Re: [RFT PATCH v2 07/12] drm/amdgpu: Call drm_atomic_helper_shutdown()
 at shutdown time
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
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
Cc: "Zhao, Victor" <Victor.Zhao@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "mdaenzer@redhat.com" <mdaenzer@redhat.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "airlied@gmail.com" <airlied@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "SHANMUGAM,
 SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>, "Zhang, Bokun" <Bokun.Zhang@amd.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, "Ma, Le" <Le.Ma@amd.com>, "Zhang,
 Morris" <Shiwu.Zhang@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "jim.cromie@gmail.com" <jim.cromie@gmail.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On Mon, Sep 25, 2023 at 8:57=E2=80=AFAM Deucher, Alexander
<Alexander.Deucher@amd.com> wrote:
>
> [Public]
>
> > -----Original Message-----
> > From: Douglas Anderson <dianders@chromium.org>
> > Sent: Thursday, September 21, 2023 3:27 PM
> > To: dri-devel@lists.freedesktop.org; Maxime Ripard <mripard@kernel.org>
> > Cc: Douglas Anderson <dianders@chromium.org>; Zhang, Bokun
> > <Bokun.Zhang@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;
> > Zhu, James <James.Zhu@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>;
> > Pan, Xinhui <Xinhui.Pan@amd.com>; airlied@gmail.com; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org; Koenig,
> > Christian <Christian.Koenig@amd.com>; daniel@ffwll.ch; Kuehling, Felix
> > <Felix.Kuehling@amd.com>; jim.cromie@gmail.com; Ma, Le
> > <Le.Ma@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; linux-
> > kernel@vger.kernel.org; maarten.lankhorst@linux.intel.com; Limonciello,
> > Mario <Mario.Limonciello@amd.com>; mdaenzer@redhat.com; Zhang,
> > Morris <Shiwu.Zhang@amd.com>; SHANMUGAM, SRINIVASAN
> > <SRINIVASAN.SHANMUGAM@amd.com>; tzimmermann@suse.de
> > Subject: [RFT PATCH v2 07/12] drm/amdgpu: Call
> > drm_atomic_helper_shutdown() at shutdown time
> >
> > Based on grepping through the source code this driver appears to be mis=
sing a
> > call to drm_atomic_helper_shutdown() at system shutdown time. Among
> > other things, this means that if a panel is in use that it won't be cle=
anly
> > powered off at system shutdown time.
> >
> > The fact that we should call drm_atomic_helper_shutdown() in the case o=
f OS
> > shutdown/restart comes straight out of the kernel doc "driver instance
> > overview" in drm_drv.c.
> >
> > Suggested-by: Maxime Ripard <mripard@kernel.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > This commit is only compile-time tested.
> >
> > ...and further, I'd say that this patch is more of a plea for help than=
 a patch I
> > think is actually right. I'm _fairly_ certain that drm/amdgpu needs thi=
s call at
> > shutdown time but the logic is a bit hard for me to follow. I'd appreci=
ate if
> > anyone who actually knows what this should look like could illuminate m=
e, or
> > perhaps even just post a patch themselves!
> >
> > (no changes since v1)
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 ++
> >  3 files changed, 13 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index 8f2255b3a38a..cfcff0b37466 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -1104,6 +1104,7 @@ static inline struct amdgpu_device
> > *amdgpu_ttm_adev(struct ttm_device *bdev)  int amdgpu_device_init(struc=
t
> > amdgpu_device *adev,
> >                      uint32_t flags);
> >  void amdgpu_device_fini_hw(struct amdgpu_device *adev);
> > +void amdgpu_device_shutdown_hw(struct amdgpu_device *adev);
> >  void amdgpu_device_fini_sw(struct amdgpu_device *adev);
> >
> >  int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev); diff --git
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index a2cdde0ca0a7..fa5925c2092d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -4247,6 +4247,16 @@ void amdgpu_device_fini_hw(struct
> > amdgpu_device *adev)
> >
> >  }
> >
> > +void amdgpu_device_shutdown_hw(struct amdgpu_device *adev) {
>
> This needs a better name since its only for displays.  Also maybe move it=
 into amdgpu_display.c since it's really about turning off the displays.  T=
hat said is this really even needed?  The driver already calls its suspend =
functionality to turn off all of the hardware and put it into a quiescent s=
tate before shutdown.  Basically shares the same code we use for suspend.

As per my comment above, for this driver, my patch was a "plea for
help". I have no idea if it's really needed or if suspend handles it.

My main concerns are:

a) If it's possible that someone out there is using this DRM driver
with a "drm_panel" then we need to make sure the panel gets disabled /
unprepared properly at shutdown time. The goal is to remove the
special logic in some panel drivers that disables the panel at
shutdown time. The guidance I got from Maxime is that we should be
relying on the DRM driver to disable panels at shutdown time and not
have extra per-panel code for it.

b) It is documented that DRM driers call drm_atomic_helper_shutdown()
at shutdown time. Even if things are working today, it's always
possible that something will change later and break for drivers that
aren't doing this.


If you're confident that everything is great for the "amdgpu" driver
then I'm happy to drop this patch and not consider it a blocker for
the eventual removal of the code in the individual panels drivers.

If, after reading this, you conclude that some sort of patch is
needed, I'd love it if you could test/post a patch yourself and then
I'll drop this patch from my series.


-Doug
