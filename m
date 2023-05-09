Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B86C1C77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 16:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3891410E3A4;
	Tue,  9 May 2023 16:54:18 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E29B10E3A2
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 16:54:16 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-50bc040c7b8so9510134a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 May 2023 09:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1683651254; x=1686243254;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wdv0Hvt23cBP3kgFwrDtJva8h58arVNJiVb7/RW+Ytc=;
 b=Vb36Lsakl8uSK/JBWleY9cf4JwpBICqLd9quOjO50HRqAdkSd8upjCqxUCF7EZL4U4
 Cy/7tPrnD5OK+ewFlX0jYfKaihTZgu1JVE1y0KKdeTxB3Q8TC3ZnGUwHMlbWBiDghHU2
 INgbq3x/xD6si3L/U7+dx0Sczd1/gItDj4uYiw6I7XsHDQ95RRZUYZzQcF17xX+iKfJK
 JsiIaU+cwORra45IwrwX85vYLuQ1tdUy7Bz/gYck7AAUE8YzqvrL7rZHC70a8i4aW19p
 72eTNtgWXKa2F1ET/WAkNR4Oox7FX5Rc+SbaNQ1G0Momga2HDG+tLdJVzinjEwkUNnpV
 irwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683651254; x=1686243254;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wdv0Hvt23cBP3kgFwrDtJva8h58arVNJiVb7/RW+Ytc=;
 b=U3W6aHg/lbH7ayN5JvUaNKvJcKDKkJhsCBtPEpVn5NxqyLlZDilRJyO3KGzPTz222M
 ZrKDAYR+fQPN6wHyEUkYS1LWxm39bhyHRVMsAS5VbMca56ooyKoXcu8uoTmS8KQu+PXT
 jqyU1hUJHKBVeCJZZhT5hy1wuDp5HnJPHCqb5n68SGtKf/x5ylUsiAHZnqr4FlDCXzDK
 LyU88xc99qFBIVn/Jz5krU/CFGbvr68LpCH/vI3Nmd8DJphtWmXPEM8eHbTRSg6vrnOO
 79IRgAPUmtYqz2HINI8lteBNBblZYhCTK11YDXhiA/lLgiAVLad2kEba40BIvafhnILN
 n4Lg==
X-Gm-Message-State: AC+VfDzpRF9uV/Vx5c+Z53BmPmrmTZWuK62EwmFvyXG996HG6NeICpaf
 OrdazhWlOHDQW/yT5nXkXbp1NeT2LYJlYzB/JN2cvA==
X-Google-Smtp-Source: ACHHUZ6jecIicj6C1JfaOhiAI5QVDr/zlRX0pmCFy1M0UUvG0VknNkJyOZ2qWaQPpIfcCCCIjBOr39cdjEXX4exPv8s=
X-Received: by 2002:a50:fe8c:0:b0:506:ba8d:c317 with SMTP id
 d12-20020a50fe8c000000b00506ba8dc317mr11015954edt.40.1683651254321; Tue, 09
 May 2023 09:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230423141051.702990-1-mwen@igalia.com>
 <20230423141051.702990-13-mwen@igalia.com>
 <5bbd49b6-ad09-607f-521d-96f9d8eb3b20@amd.com>
 <20230509163701.57lf22phumicqv37@mail.igalia.com>
In-Reply-To: <20230509163701.57lf22phumicqv37@mail.igalia.com>
From: Joshua Ashton <joshua@froggi.es>
Date: Tue, 9 May 2023 16:54:03 +0000
Message-ID: <CAEZNXZAfq_6EZHBhBXjMPwOuU10rwKe3SPJpz1hetux=HRF4CQ@mail.gmail.com>
Subject: Re: [RFC PATCH 12/40] drm/amd/display: add plane HDR multiplier
 driver-private property
To: Melissa Wen <mwen@igalia.com>
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
Cc: Sebastian Wick <sebastian.wick@redhat.com>,
 Shashank Sharma <Shashank.Sharma@amd.com>, sunpeng.li@amd.com,
 airlied@gmail.com, Xinhui.Pan@amd.com,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Xaver Hugl <xaver.hugl@gmail.com>,
 dri-devel@lists.freedesktop.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Alex Hung <alex.hung@amd.com>, amd-gfx@lists.freedesktop.org, daniel@ffwll.ch,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, christian.koenig@amd.com,
 linux-kernel@vger.kernel.org, sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We currently do not have a use for this as we settled on per-plane 3D
LUT + Shaper, but we might end up wanting to use in our scRGB stack
someday so I would like to keep it.

On Tue, 9 May 2023 at 16:37, Melissa Wen <mwen@igalia.com> wrote:
>
> On 05/08, Harry Wentland wrote:
> >
> >
> > On 4/23/23 10:10, Melissa Wen wrote:
> > > From: Joshua Ashton <joshua@froggi.es>
> > >
> > > Multiplier to 'gain' the plane. When PQ is decoded using the fixed func
> > > transfer function to the internal FP16 fb, 1.0 -> 80 nits (on AMD at
> > > least) When sRGB is decoded, 1.0 -> 1.0.  Therefore, 1.0 multiplier = 80
> > > nits for SDR content. So if you want, 203 nits for SDR content, pass in
> > > (203.0 / 80.0).
> > >
> >
> > Is gamescope intending to use this?
>
> I don't think so. Again, I'll double check and drop it accordingly.
>
> Melissa
>
> >
> > Harry
> >
> > > Co-developed-by: Melissa Wen <mwen@igalia.com>
> > > Signed-off-by: Melissa Wen <mwen@igalia.com>
> > > Signed-off-by: Joshua Ashton <joshua@froggi.es>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  6 +++++
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  4 +++
> > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 12 +++++++++
> > >  .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 25 ++++++++++++++-----
> > >  4 files changed, 41 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > > index 24595906dab1..dd658f162f6f 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > > @@ -1326,6 +1326,12 @@ amdgpu_display_create_color_properties(struct amdgpu_device *adev)
> > >             return -ENOMEM;
> > >     adev->mode_info.plane_degamma_tf_property = prop;
> > >
> > > +   prop = drm_property_create_range(adev_to_drm(adev),
> > > +                                    0, "AMD_PLANE_HDR_MULT", 0, UINT_MAX);
> > > +   if (!prop)
> > > +           return -ENOMEM;
> > > +   adev->mode_info.plane_hdr_mult_property = prop;
> > > +
> > >     return 0;
> > >  }
> > >  #endif
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> > > index ab9ce6f26c90..65a9d62ffbe4 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> > > @@ -387,6 +387,10 @@ struct amdgpu_mode_info {
> > >      * linearize content with or without LUT.
> > >      */
> > >     struct drm_property *plane_degamma_tf_property;
> > > +   /**
> > > +    * @plane_hdr_mult_property:
> > > +    */
> > > +   struct drm_property *plane_hdr_mult_property;
> > >  #endif
> > >  };
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> > > index 005632c1c9ec..bb7307b9cfd5 100644
> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> > > @@ -51,6 +51,7 @@
> > >
> > >  #define AMDGPU_DMUB_NOTIFICATION_MAX 5
> > >
> > > +#define AMDGPU_HDR_MULT_DEFAULT (0x100000000LL)
> > >  /*
> > >  #include "include/amdgpu_dal_power_if.h"
> > >  #include "amdgpu_dm_irq.h"
> > > @@ -736,6 +737,17 @@ struct dm_plane_state {
> > >      * linearize.
> > >      */
> > >     enum drm_transfer_function degamma_tf;
> > > +   /**
> > > +    * @hdr_mult:
> > > +    *
> > > +    * Multiplier to 'gain' the plane.  When PQ is decoded using the fixed
> > > +    * func transfer function to the internal FP16 fb, 1.0 -> 80 nits (on
> > > +    * AMD at least). When sRGB is decoded, 1.0 -> 1.0, obviously.
> > > +    * Therefore, 1.0 multiplier = 80 nits for SDR content.  So if you
> > > +    * want, 203 nits for SDR content, pass in (203.0 / 80.0).  Format is
> > > +    * S31.32 sign-magnitude.
> > > +    */
> > > +   __u64 hdr_mult;
> > >  #endif
> > >  };
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> > > index 5b458cc0781c..57169dae8b3d 100644
> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> > > @@ -1321,8 +1321,10 @@ static void dm_drm_plane_reset(struct drm_plane *plane)
> > >             __drm_atomic_helper_plane_reset(plane, &amdgpu_state->base);
> > >
> > >  #ifdef CONFIG_STEAM_DECK
> > > -   if (amdgpu_state)
> > > +   if (amdgpu_state) {
> > >             amdgpu_state->degamma_tf = DRM_TRANSFER_FUNCTION_DEFAULT;
> > > +           amdgpu_state->hdr_mult = AMDGPU_HDR_MULT_DEFAULT;
> > > +   }
> > >  #endif
> > >  }
> > >
> > > @@ -1424,11 +1426,11 @@ static void dm_drm_plane_destroy_state(struct drm_plane *plane,
> > >  #ifdef CONFIG_STEAM_DECK
> > >  int
> > >  amdgpu_dm_replace_property_blob_from_id(struct drm_device *dev,
> > > -                                          struct drm_property_blob **blob,
> > > -                                          uint64_t blob_id,
> > > -                                          ssize_t expected_size,
> > > -                                          ssize_t expected_elem_size,
> > > -                                          bool *replaced)
> > > +                                   struct drm_property_blob **blob,
> > > +                                   uint64_t blob_id,
> > > +                                   ssize_t expected_size,
> > > +                                   ssize_t expected_elem_size,
> > > +                                   bool *replaced)
> > >  {
> > >     struct drm_property_blob *new_blob = NULL;
> > >
> > > @@ -1482,6 +1484,10 @@ dm_plane_attach_color_mgmt_properties(struct amdgpu_display_manager *dm,
> > >                                        dm->adev->mode_info.plane_degamma_tf_property,
> > >                                        DRM_TRANSFER_FUNCTION_DEFAULT);
> > >     }
> > > +   /* HDR MULT is always available */
> > > +   drm_object_attach_property(&plane->base,
> > > +                              dm->adev->mode_info.plane_hdr_mult_property,
> > > +                              AMDGPU_HDR_MULT_DEFAULT);
> > >  }
> > >
> > >  static int
> > > @@ -1507,6 +1513,11 @@ dm_atomic_plane_set_property(struct drm_plane *plane,
> > >                     dm_plane_state->degamma_tf = val;
> > >                     dm_plane_state->base.color_mgmt_changed = 1;
> > >             }
> > > +   } else if (property == adev->mode_info.plane_hdr_mult_property) {
> > > +           if (dm_plane_state->hdr_mult != val) {
> > > +                   dm_plane_state->hdr_mult = val;
> > > +                   dm_plane_state->base.color_mgmt_changed = 1;
> > > +           }
> > >     } else {
> > >             drm_dbg_atomic(plane->dev,
> > >                            "[PLANE:%d:%s] unknown property [PROP:%d:%s]]\n",
> > > @@ -1533,6 +1544,8 @@ dm_atomic_plane_get_property(struct drm_plane *plane,
> > >                     dm_plane_state->degamma_lut->base.id : 0;
> > >     } else if (property == adev->mode_info.plane_degamma_tf_property) {
> > >             *val = dm_plane_state->degamma_tf;
> > > +   } else if (property == adev->mode_info.plane_hdr_mult_property) {
> > > +           *val = dm_plane_state->hdr_mult;
> > >     } else {
> > >             return -EINVAL;
> > >     }
> >
> >
