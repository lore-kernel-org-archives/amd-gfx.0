Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD10C3DA60
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 16:31:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A03F10E2DA;
	Wed, 17 Jul 2024 16:31:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="CBKbZK48";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DCCD10E2E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 16:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721233890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oaeJ8vGKpFgW+rB0iZCJbMqPHEGG4KWcz9Xv+Rv3aJM=;
 b=CBKbZK48GG+GOaR8AgrXQmDQBnsb5zl57xBWQ+kD3FjkSYcECQ1BYiagVBRHR5K4YMH86P
 48DbHsEbkDyCWdYgkxYCZtNL5jRlHV+06lNIQUBim9hWTWmdOzYY5BzWBXjwvEO1vEyPq3
 yEB0LVxesB3H+0xWSd1MLTfEcyunLVU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-_Bs5_BS2MOuj3crUmPHweQ-1; Wed, 17 Jul 2024 12:31:28 -0400
X-MC-Unique: _Bs5_BS2MOuj3crUmPHweQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5a0e93ebc78so79097a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 09:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721233887; x=1721838687;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oaeJ8vGKpFgW+rB0iZCJbMqPHEGG4KWcz9Xv+Rv3aJM=;
 b=qrYOiJqVcKGDl1HsK5jgNLUrPdXMvIpbwoqEwPQcO34mlGCFQJfeZ8Vv5lP9NDNdWB
 FbgaAjnCTppqicjkmUSzNwf2aHZFFUxxY5bJGpFA8Ty3hC7oKETZnBnve1EGS2T8M81V
 8RlMk6dEEEdUO4QwAwUe9MbmzHX+HUY9up6U782DwyoR9Ff9I7sMWNt1EhirIfoUPWxY
 pd6oDriqH3xP7SnVYgxHaB0txMJgxrRuSCxI97EOZYo9HG8pdW2PyVTWCyV8Yqhh1/yd
 Qk4Qqh0IaB3vDEZ6rl43d/F9J6kZEJ0C/KtGcfHwskN5xNaOyRstky+JSlf5Ysl/Rgkt
 Z+8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGtnEJxY/mh9adh1ha8RFz3952Ph8fZLcF/iId4mcH1HNQiLnntJsGk3oE6ZzpNuFwH4H16Ba+EcanXBZjYrJbU+9UzrMHqpKfLiHanA==
X-Gm-Message-State: AOJu0Yz5R+nmDGfdPnCBeWptWHqTxZmM1r7h1mP9ro9JDu+pTB4vNI4c
 oqQKpfH2ezryIlP8lMCek/Y3yotyBoCmy2RPISykmqNoWz2mN14SIl/j0QqFI/jQfBpBLVofjky
 7DsR/FHodviyxpII9fnMHfo/ss8/6sM1PVOldykcjggKL9kQToDd17uAsAmfct0BBX05Px58UWV
 3E0rJtbZxARPG15PL8qBdassDEXOwL+ikPIdgAKg==
X-Received: by 2002:a05:6402:c8f:b0:58b:e3b:c5de with SMTP id
 4fb4d7f45d1cf-5a05dc87267mr1138157a12.4.1721233887283; 
 Wed, 17 Jul 2024 09:31:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYvZbfrhao0m6W5xda7D2AzU3nhAWqgneX9Tdzq+5U3NhvUG41zIgjSFUaQNmFLwgodW6WpVdY8xB4nnf09fM=
X-Received: by 2002:a05:6402:c8f:b0:58b:e3b:c5de with SMTP id
 4fb4d7f45d1cf-5a05dc87267mr1138136a12.4.1721233886884; Wed, 17 Jul 2024
 09:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231101210037.130494-1-hamza.mahfooz@amd.com>
 <CADnq5_Nv0MnG+pPvRQO37OP8iYwz8oGvFLs2g-+U=URHWcqJGw@mail.gmail.com>
 <1eed6bfa-3e98-45d1-9908-2c5a0f3173c3@amd.com>
 <CADnq5_OUjbrVOmSr7vuK8h8rmg+q14ra1jiE+B0TRfZos-jn5w@mail.gmail.com>
In-Reply-To: <CADnq5_OUjbrVOmSr7vuK8h8rmg+q14ra1jiE+B0TRfZos-jn5w@mail.gmail.com>
From: Karol Herbst <kherbst@redhat.com>
Date: Wed, 17 Jul 2024 18:30:49 +0200
Message-ID: <CACO55ttEqAxMwXjVZFaLX3nQXbAuRf2qE1kr4PEAHqZuYDmBYA@mail.gmail.com>
Subject: Re: [PATCH] drm/edid: add a quirk for two 240Hz Samsung monitors
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>, Maxime Ripard <mripard@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Jerry Zuo <jerry.zuo@amd.com>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Deucher <alexander.deucher@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

On Thu, Nov 2, 2023 at 8:06=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> On Thu, Nov 2, 2023 at 3:00=E2=80=AFPM Hamza Mahfooz <hamza.mahfooz@amd.c=
om> wrote:
> >
> > On 11/1/23 17:36, Alex Deucher wrote:
> > > On Wed, Nov 1, 2023 at 5:01=E2=80=AFPM Hamza Mahfooz <hamza.mahfooz@a=
md.com> wrote:
> > >>
> > >> Without this fix the 5120x1440@240 timing of these monitors
> > >> leads to screen flickering.
> > >>
> > >> Cc: stable@vger.kernel.org # 6.1+
> > >> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1442
> > >> Co-developed-by: Harry Wentland <harry.wentland@amd.com>
> > >> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> > >> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> > >> ---
> > >>   drivers/gpu/drm/drm_edid.c | 47 ++++++++++++++++++++++++++++++++++=
+---
> > >>   1 file changed, 44 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> > >> index bca2af4fe1fc..3fdb8907f66b 100644
> > >> --- a/drivers/gpu/drm/drm_edid.c
> > >> +++ b/drivers/gpu/drm/drm_edid.c
> > >> @@ -89,6 +89,8 @@ static int oui(u8 first, u8 second, u8 third)
> > >>   #define EDID_QUIRK_NON_DESKTOP                 (1 << 12)
> > >>   /* Cap the DSC target bitrate to 15bpp */
> > >>   #define EDID_QUIRK_CAP_DSC_15BPP               (1 << 13)
> > >> +/* Fix up a particular 5120x1440@240Hz timing */
> > >> +#define EDID_QUIRK_FIXUP_5120_1440_240         (1 << 14)
> > >
> > > What is wrong with the original timing that needs to be fixed?
> >
> > Apparently, all of timing values for the 5120x1440@240 mode of these
> > monitors aren't set correctly (they are all lower than they should be)
> > in their EDIDs. For what it's worth, the windows driver has had a quirk
> > similar the one proposed in this patch for ~2 years.
>
> It would be good to at least include the original mode timings from
> the EDID and the new ones added by the quirk in the commit message and
> a description of why they are problematic and why the new ones work.
>
> Alex
>

I think this part what nvidia is doing in their driver is missing:
https://github.com/NVIDIA/open-gpu-kernel-modules/blob/main/src/common/mode=
set/timing/nvt_edidext_861.c#L342

A nouveau user hit this and I think the edid parser in the kernel is
just lacking whatever that "RID_MODE" stuff is all about.


>
> >
> > >
> > > Alex
> > >
> > >
> > >>
> > >>   #define MICROSOFT_IEEE_OUI     0xca125c
> > >>
> > >> @@ -170,6 +172,12 @@ static const struct edid_quirk {
> > >>          EDID_QUIRK('S', 'A', 'M', 596, EDID_QUIRK_PREFER_LARGE_60),
> > >>          EDID_QUIRK('S', 'A', 'M', 638, EDID_QUIRK_PREFER_LARGE_60),
> > >>
> > >> +       /* Samsung C49G95T */
> > >> +       EDID_QUIRK('S', 'A', 'M', 0x7053, EDID_QUIRK_FIXUP_5120_1440=
_240),
> > >> +
> > >> +       /* Samsung S49AG95 */
> > >> +       EDID_QUIRK('S', 'A', 'M', 0x71ac, EDID_QUIRK_FIXUP_5120_1440=
_240),
> > >> +
> > >>          /* Sony PVM-2541A does up to 12 bpc, but only reports max 8=
 bpc */
> > >>          EDID_QUIRK('S', 'N', 'Y', 0x2541, EDID_QUIRK_FORCE_12BPC),
> > >>
> > >> @@ -6586,7 +6594,37 @@ static void update_display_info(struct drm_co=
nnector *connector,
> > >>          drm_edid_to_eld(connector, drm_edid);
> > >>   }
> > >>
> > >> -static struct drm_display_mode *drm_mode_displayid_detailed(struct =
drm_device *dev,
> > >> +static void drm_mode_displayid_detailed_edid_quirks(struct drm_conn=
ector *connector,
> > >> +                                                   struct drm_displ=
ay_mode *mode)
> > >> +{
> > >> +       unsigned int hsync_width;
> > >> +       unsigned int vsync_width;
> > >> +
> > >> +       if (connector->display_info.quirks & EDID_QUIRK_FIXUP_5120_1=
440_240) {
> > >> +               if (mode->hdisplay =3D=3D 5120 && mode->vdisplay =3D=
=3D 1440 &&
> > >> +                   mode->clock =3D=3D 1939490) {
> > >> +                       hsync_width =3D mode->hsync_end - mode->hsyn=
c_start;
> > >> +                       vsync_width =3D mode->vsync_end - mode->vsyn=
c_start;
> > >> +
> > >> +                       mode->clock =3D 2018490;
> > >> +                       mode->hdisplay =3D 5120;
> > >> +                       mode->hsync_start =3D 5120 + 8;
> > >> +                       mode->hsync_end =3D 5120 + 8 + hsync_width;
> > >> +                       mode->htotal =3D 5200;
> > >> +
> > >> +                       mode->vdisplay =3D 1440;
> > >> +                       mode->vsync_start =3D 1440 + 165;
> > >> +                       mode->vsync_end =3D 1440 + 165 + vsync_width=
;
> > >> +                       mode->vtotal =3D 1619;
> > >> +
> > >> +                       drm_dbg_kms(connector->dev,
> > >> +                                   "[CONNECTOR:%d:%s] Samsung 240Hz=
 mode quirk applied\n",
> > >> +                                   connector->base.id, connector->n=
ame);
> > >> +               }
> > >> +       }
> > >> +}
> > >> +
> > >> +static struct drm_display_mode *drm_mode_displayid_detailed(struct =
drm_connector *connector,
> > >>                                                              struct =
displayid_detailed_timings_1 *timings,
> > >>                                                              bool ty=
pe_7)
> > >>   {
> > >> @@ -6605,7 +6643,7 @@ static struct drm_display_mode *drm_mode_displ=
ayid_detailed(struct drm_device *d
> > >>          bool hsync_positive =3D (timings->hsync[1] >> 7) & 0x1;
> > >>          bool vsync_positive =3D (timings->vsync[1] >> 7) & 0x1;
> > >>
> > >> -       mode =3D drm_mode_create(dev);
> > >> +       mode =3D drm_mode_create(connector->dev);
> > >>          if (!mode)
> > >>                  return NULL;
> > >>
> > >> @@ -6628,6 +6666,9 @@ static struct drm_display_mode *drm_mode_displ=
ayid_detailed(struct drm_device *d
> > >>
> > >>          if (timings->flags & 0x80)
> > >>                  mode->type |=3D DRM_MODE_TYPE_PREFERRED;
> > >> +
> > >> +       drm_mode_displayid_detailed_edid_quirks(connector, mode);
> > >> +
> > >>          drm_mode_set_name(mode);
> > >>
> > >>          return mode;
> > >> @@ -6650,7 +6691,7 @@ static int add_displayid_detailed_1_modes(stru=
ct drm_connector *connector,
> > >>          for (i =3D 0; i < num_timings; i++) {
> > >>                  struct displayid_detailed_timings_1 *timings =3D &d=
et->timings[i];
> > >>
> > >> -               newmode =3D drm_mode_displayid_detailed(connector->d=
ev, timings, type_7);
> > >> +               newmode =3D drm_mode_displayid_detailed(connector, t=
imings, type_7);
> > >>                  if (!newmode)
> > >>                          continue;
> > >>
> > >> --
> > >> 2.42.0
> > >>
> > --
> > Hamza
> >
>

