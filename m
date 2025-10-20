Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC8BCCD193
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 13:52:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C5D110E43E;
	Mon, 20 Oct 2025 13:52:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IpkBsL7y";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3895610E43E
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 13:52:26 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-b6a42604093so97185a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 06:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760968346; x=1761573146; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9JYfCl0CLKJvJIXI8RMS6D41KQ0xG8RBKDwnGqAkmLs=;
 b=IpkBsL7y2xnPCpcFRcfzBbQuTg97JDW7fI6GIpYOEIzn5poJ5bQTh3Yf7q+S1RMfeT
 rxnSNqUj/LtMlGq6ipa6tlJz95orm7WO4Wl+GKUUtUi3vnMkVuooThyEL3im/zFpjJa/
 Q5CxUjQ9lm9g8xuqoxuQjXsPxPYylkeXeEM7Fr2+cRMnodYRyh8OMSUY/uynS83a5QQB
 7I9wPZ0nkENb9umdmilVOAxGa2hKdo7Rc42LkPGKYSawNSUkOUCCfhPR0wwGPOIEU+g6
 wVYNCDQNMpDb5wTn+INGSmdCtVqoh0pkiFf4ETxjEC3qrG/lK1/j0ENBMU2zfuyT1NdU
 Ck8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760968346; x=1761573146;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9JYfCl0CLKJvJIXI8RMS6D41KQ0xG8RBKDwnGqAkmLs=;
 b=pZTt8qEzkTT4had1Ck7MqO71daKsnmHZkdQ35PBE2ja/7W668uG/G/chaGgRrFfLDW
 03Xazu9+j8wqOwbLUI/uR17+/yVempgISY6ciqEo3eEyjLNrAZqzhuG/dQVmZeZTI7z7
 xAtZnMY/MH2h0jIK8FWpd6JJJ+AM4q1Qtste5REIdueqplKpuS/0NrtoUQYGZyiCxFRr
 D0yIioeMy/4jMSLeDwzMwJ3kKSXpwhmdxfKYhlzRCBhka+u1+zNl4KY8a+ZpXFc+5sW5
 WbxovNqLmonGKhZOaDprwIahcVCWd2onir7quX4nyTeoTCUr4ntHHigCbyl4byoiAsdt
 9cNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcaJdMlVJdqwUD1qGZnp1EEwz0UYnK3WUl246/LF8BYlRliS3cmnJ5EBOQs6M1kZ7PwQ/QXDjZ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YypiYBEyfGbqS4A9nTlAkEp6NqT7iSUviXVIXeDA6MchdsdE4Hu
 HT+jbG+H25llD1O9P4cnVJIwECdWjeSRZQxLEGEsnW3+Os/v8NnXYrSqogIeNX7OR5cdxuwplre
 MxlLTTWBwje8CJTSY4I8SUQNOdlWZ6Cg=
X-Gm-Gg: ASbGncsqBoyUZgocsPrJbquMPPlIay188fxIqYIe67UUmoZvHTB8aRtp5Pg6t7xmRxo
 w0y5lXCXnbRLvQ7IuLb3IAjmvzWTn2ykWl0sSoQNr7lCf2a3FbDjT2aIR9naz4b3kuyG9h4kZ6p
 SeBkhz3Bvz/cA8TgNIFuXY3lZtrHXPHyqKa2GeO2VdYNdueuRFHOhFWRI7Rsb7/9sMmqZwX6u7i
 l/aTeLhWpHP3papi0usGitHbywyyPyzWPkKhUQsrdAPdOW6bhAuljdG/5u1ZiXA2+tp4OI=
X-Google-Smtp-Source: AGHT+IHVevZPd7vgBRPFKSIHdUy9cmZF2rvzgtv5UruV8SMSZLC9JTB8M5H+5sUKN1X53awKNZYJ3nD33AGpDyaspRk=
X-Received: by 2002:a17:903:b8f:b0:290:c5c5:57e6 with SMTP id
 d9443c01a7336-290c9cff139mr91148835ad.3.1760968345662; Mon, 20 Oct 2025
 06:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20251017130401.3196276-1-kevinyang.wang@amd.com>
 <BL1PR12MB51442956BC5EA7E1562269A9F7F6A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <PH7PR12MB59979EC9DCF67E04DA0337FD82F6A@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB59979EC9DCF67E04DA0337FD82F6A@PH7PR12MB5997.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Oct 2025 09:52:13 -0400
X-Gm-Features: AS18NWC7Feu3E998Gvua4jtjIRt1SGq8Sm04w88OyBDq-xWMJc5Xq553lTd-vOU
Message-ID: <CADnq5_PNkFcrVLiHMTQacA2X+PTGLBDOSGjUuvZJZXU4F4wxuQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: pause the workload setting in dm
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>
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

On Fri, Oct 17, 2025 at 6:21=E2=80=AFPM Wang, Yang(Kevin)
<KevinYang.Wang@amd.com> wrote:
>
> [Public]
>
> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Friday, October 17, 2025 9:42 PM
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop=
.org
> Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
> Subject: RE: [PATCH] drm/amd/display: pause the workload setting in dm
>
> [Public]
>
> > -----Original Message-----
> > From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> > Sent: Friday, October 17, 2025 9:04 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>
> > Subject: [PATCH] drm/amd/display: pause the workload setting in dm
> >
> > From: Kenneth Feng <kenneth.feng@amd.com>
> >
> > v1:
> > Pause the workload setting in dm when doinn idle optimization
> >
> > v2:
> > Rebase patch to latest kernel code base (kernel 6.16)
> >
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
>
> Is the issue with that particular monitor resolved?  Do we know what caus=
ed it?
>
> Alex
>
> [kevin]:
> The issue has not been resolved. The DAL team believes this may be a spec=
ific issue on the 6k month and hopes to continue trying to resolve it based=
 on this patch.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Best Regards,
> Kevin
> > ---
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > index 1ec9d03ad747..f08121a2b838 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > @@ -248,6 +248,8 @@ static void
> > amdgpu_dm_crtc_vblank_control_worker(struct
> > work_struct *work)
> >       struct vblank_control_work *vblank_work =3D
> >               container_of(work, struct vblank_control_work, work);
> >       struct amdgpu_display_manager *dm =3D vblank_work->dm;
> > +     struct amdgpu_device *adev =3D drm_to_adev(dm->ddev);
> > +     int r;
> >
> >       mutex_lock(&dm->dc_lock);
> >
> > @@ -277,7 +279,16 @@ static void
> > amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
> >
> >       if (dm->active_vblank_irq_count =3D=3D 0) {
> >               dc_post_update_surfaces_to_stream(dm->dc);
> > +
> > +             r =3D amdgpu_dpm_pause_power_profile(adev, true);
> > +             if (r)
> > +                     dev_warn(adev->dev, "failed to set default power
> > + profile
> > mode\n");
> > +
> >               dc_allow_idle_optimizations(dm->dc, true);
> > +
> > +             r =3D amdgpu_dpm_pause_power_profile(adev, false);
> > +             if (r)
> > +                     dev_warn(adev->dev, "failed to restore the power
> > + profile
> > mode\n");
> >       }
> >
> >       mutex_unlock(&dm->dc_lock);
> > --
> > 2.34.1
>
>
