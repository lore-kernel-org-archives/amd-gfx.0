Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89EFCA5FE5
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 12:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D2A310E763;
	Fri,  2 Oct 2026 12:52:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mGYLK3R2";
	dkim-atps=neutral
Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com
 [74.125.229.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E08010E401
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 00:06:49 +0000 (UTC)
Received: by mail-dl2-f42.google.com with SMTP id
 a92af1059eb24-144df39b6cfso5562791c88.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Oct 2026 17:06:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790899608; cv=none;
 d=google.com; s=arc-20260327;
 b=NK86GmZDBjO3oTpV16Sg+pPsrxFc7ocdZZLh8p0rTpyE4ZihGHPIzNOhi8w5uZ5kVJ
 9eEhLew7XCBwnqnlLBrIbJILOlxyBq3n0MZ9yv6e/uriF3X1cgPK0VaPUBmYrxekdK6m
 z6v8jIh+o9xb+tvSvLn2HEJ/G5aFy6w2reAWDM//W1A5cIMFKoil0Ba7t64j88eXpfn7
 lzx94IYJJS9i6hS4BXii5xV7SCRl7BX5WmpQ79PhWx08xXmt+TUykq64ePaVqUpA8Dbl
 3T6YTwJFzNfeMJGRwOJz7bDcsElGBYTK0obmMmNBSFudvDz44h91MshI3xI9VkOKLtBz
 8ong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zGCTIMLzR0g5rrSlyGyDUUCtcO6sG738acE2Sfbugu4=;
 fh=jBuKbS+d9lePvfpNAeKCnvbv3i3cyzca7PcPVkZszeM=;
 b=pmmVgNKroMg1A/LBtFLDTYR9P7ur7oPjeyJrA+IZ0iWcJSGW+0ZxHwLoBTTf4NOdnS
 rTg8WrWCXVw8n6csmY0j0EmoUFqjdWBszol08QbprtTC2+6W3nd3iVtfWKiY2o1uMtlp
 m2hu3F+AjLb2ROwG0KgDujKObBtcPQnuq/ggbmZa4sFhwvOGhB8q7DyNRQ4zKjSxnEUA
 62n7hElseyMEN/5rauq4Wy4GKZ4QIsiyaCgx8DnoeBOrIEoG2y6YWN2ECn9g3F/ckLI+
 GiMxel3k2B6FiV+ASGkuWWxV9cXftRq/hukG6HNgIyY1ubOCBHozjF5swRVWbbk/nitl
 +F2Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790899608; x=1791504408; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zGCTIMLzR0g5rrSlyGyDUUCtcO6sG738acE2Sfbugu4=;
 b=mGYLK3R2OgA1srosUKfkDXLL5QJJa1vKA851HUsppQ5Lf8mnVU7S4uPhc8OMd8SW6L
 zzdXGs9BD8uuYwDLbjzpIB4GMIjeh96sxKbSZ+h5qcif0ZyGCOmmjf78uK2v8JqZTaD5
 TVIX2DjESF2ei5IXMiI2aTfFIZN4tF5gnfSKrcIoI/mNKiEYOnoLHo6migNL8ltw86Ep
 1KSAIygDH2oo5XQ+2MRm5eMNVI0Gyx0GuZa9HsMWdOBijIGb+nq58NAo7c8zAAqm00pd
 nqPbScYW2ruHf4bZIyqi8PoGUiDeO2D1hdglaMpYGGY+mw1G+H7EkNumzhfXUJQSA/q8
 YOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790899608; x=1791504408;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zGCTIMLzR0g5rrSlyGyDUUCtcO6sG738acE2Sfbugu4=;
 b=xXXv7cJ17mA/kXe4ygKGkm9aGBRI1pK8t0saOIhjalZwdCvIHv/fz0c9S/7unRAFQy
 cTa7pgaZbnxoUUHx9kGHQrAS7IUayQkkcsw8wKclloZLVxzjV0j9K0vb++Mzlrt7CliF
 jybD+cyrF4e+rdiksPnOSkiRjemSReyCTCQBiFlyScnMmAB7D639bM1npogyPrxO5bxy
 AsvFqtib4qvSAStB5iKqQ6gTAfKU/cRBMuCsa2HaGty8edq6/jyORlb2q3ZWXp9jP+Cu
 3HOa0fXDnRtZMQr773Iv8G9EFZGoZkP8/uTfksbFcvZcntniaMk1a2uR88OMkZOaB/w/
 yeJw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxIziAFeCXbxQXaT2MMIKmz4N08OFM+5P0c60TAtoW0y4Pp5/9i7ERkYf66Z0dTDPTPHOF9RP/i@lists.freedesktop.org
X-Gm-Message-State: AFuF++lHiwtlVUY5lFMQiTuDUMrMahN9nqseRWt5qDSqmptOa0VqlqXX
 K6UR08/PzBgBCCHK0gWR7yeBzE8DjXi/7IQL72fygZZM8nuOrKyoaNxJsMWSUcetIcMcpq2BHek
 W4Pu54yTfP74ZVpvquLcRZFBjYi+TAk0=
X-Gm-Gg: AYBFou08/FnIf/PXdOpg2MnzruuoqqkYZ049zB5I+8SjVMdXfOAHJq60k2hs/+d1loE
 H/S6AIjex5fjTciZpHJsm7OmI35VcwGK2zKoi7VMmbcogLqXi/L88FMbeQBEabGB0D+7bPOnztC
 EmXjRbrTAV9kGg99JZ3UjALSY/X1SShZhGlWj72lXApIhZrs2c6p9V24IeD4uKR30A8+PHTJ62d
 DiDZpyHVk7lXI+FOnX9Way5m4++lu0domzhl2N8M7Tq0OcYmDsCH5Rc7Dk0SRzfc3pOsM9Jb5pL
 IYe4u6+jp+SxjaAnCJy1CN4PEA+UbS/5YQvQs4FzVna4l3o6QemFUF77A6/kELb3X1Yo3A3AJP9
 EGIJg5zUdAdUgen45CFvfqirPsg==
X-Received: by 2002:a05:701b:4306:10b0:147:cd15:3eb with SMTP id
 a92af1059eb24-14f58de57admr838109c88.6.1790899608169; Thu, 01 Oct 2026
 17:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260930-amd-mst-teardown-v1-1-16a39ebdd4de@gmail.com>
 <96bababa-cf6d-472b-85a1-bafeef5fc474@amd.com>
In-Reply-To: <96bababa-cf6d-472b-85a1-bafeef5fc474@amd.com>
From: David Medina <b2amedina@gmail.com>
Date: Thu, 1 Oct 2026 20:06:21 -0400
X-Gm-Features: AclHuK-IQKG-NwL8I-2Z8nKQLu2bpmDAnbsNCVPk6aX1ly4aCkJjWaj0KijyvMc
Message-ID: <CAGTy6n_XJ=-MucZko7JrEUCg9oQZBVKVvtPunb4i6RFKV4QhnA@mail.gmail.com>
Subject: Re: [PATCH RFC] drm/amd/display: Disable CRTC on MST connector
 unregister
To: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 12:52:19 +0000
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

Hi Harry,

Thanks for the feedback =E2=80=94 that's a fair point. Userspace does contr=
ol
enablement, and the driver force-disabling a CRTC from
early_unregister() is the wrong layer.

The symptom I'm chasing: with a Thunderbolt 3 dock driving an LG
Ultrawide, unplugging the dock unregisters the MST connector, but the
CRTC that was driving it keeps its MST encoder assignment. On re-plug a
new connector is created and the re-commit fails in
drm_atomic_helper_check_modeset() with an encoder conflict
(handle_conflicting_encoders), so the display stays dark until a full
modeset (e.g. a session restart) tears everything down.

So my real question is where this is supposed to be handled: is there
something the driver should do during connector unregister to release
the stale CRTC/encoder assignment, or is this expected to be resolved
by userspace on the hotplug uevent? If the latter, is the compositor at
fault for leaving the CRTC active?

I only proposed the early_unregister() approach because it was the
minimal thing that fixed the failure in testing =E2=80=94 not because I'm
confident it's correct. Happy to dig in whichever direction you point
me.

Thanks,
David

On Thu, Oct 1, 2026 at 9:54=E2=80=AFAM Harry Wentland <harry.wentland@amd.c=
om> wrote:
>
>
>
> On 2026-09-30 22:13, David Medina via B4 Relay wrote:
> > From: David Medina <b2amedina@gmail.com>
> >
> > amdgpu_dm_mst_connector_early_unregister() releases the connector's
> > sink but leaves the CRTC it was driving active and its MST encoder
> > assigned. Because the connector is unregistered in the same step,
> > userspace has no chance to disable the CRTC before it is gone. When the
>
> Why does userspace have no chance to disable the CRTC? It's the connector
> that goes away, not the CRTC.
>
> Userspace controls enablement. The kernel driver shouldn't disable someth=
ing
> proactively based on a hotplug.
>
> Harry
>
> > same display is re-plugged a new MST connector is created, and the
> > re-commit fails in drm_atomic_helper_check_modeset() because the stale
> > connector still owns the encoder (handle_conflicting_encoders), leaving
> > the display dark until a full modeset (e.g. a session restart) tears
> > everything down.
> >
> > Disable the CRTC from the driver when the connector is torn down, so th=
e
> > MST encoder is released and the DC stream dropped. Reuse the
> > drm_atomic_helper_disable_all() pattern: deactivate the CRTC, clear the
> > mode, and disconnect the connector.
> >
> > Reproduced 100% of the time by unplugging and re-plugging the Thunderbo=
lt
> > dock driving the LG ULTRAWIDE: on re-plug the display stays dark and
> > dmesg shows drm_atomic_helper_check_modeset() failing with an encoder
> > conflict (handle_conflicting_encoders). Verified over four unplug/replu=
g
> > cycles with this patch applied.
> >
> > I am not certain that forcing a modeset from early_unregister() is the
> > right approach, and the disable here is intentionally minimal: it
> > deactivates the CRTC and disconnects the connector but does not
> > add/detach the CRTC's affected planes the way
> > drm_atomic_helper_disable_all() does. The minimal version resolves the
> > failure in testing; I would welcome guidance on whether the full
> > affected-planes teardown (or a different location) is required.
> >
> > Fixes: a1b27e99229a ("drm/amd/display: Implement MST Aux device registr=
ation")
> > Signed-off-by: David Medina <b2amedina@gmail.com>
> > ---
> >  .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 53 ++++++++++++++=
++++++++
> >  1 file changed, 53 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.=
c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> > index 045a7f88b754..24b146068739 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> > @@ -29,6 +29,7 @@
> >  #include <drm/display/drm_dp_mst_helper.h>
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> > +#include <drm/drm_atomic_uapi.h>
> >  #include <drm/drm_fixed.h>
> >  #include <drm/drm_edid.h>
> >  #include "dm_services.h"
> > @@ -227,6 +228,7 @@ amdgpu_dm_mst_connector_early_unregister(struct drm=
_connector *connector)
> >       struct amdgpu_dm_connector *root =3D aconnector->mst_root;
> >       struct dc_link *dc_link =3D aconnector->dc_link;
> >       struct dc_sink *dc_sink =3D aconnector->dc_sink;
> > +     struct drm_crtc *crtc =3D connector->state ? connector->state->cr=
tc : NULL;
> >
> >       drm_dp_mst_connector_early_unregister(connector, port);
> >
> > @@ -250,6 +252,57 @@ amdgpu_dm_mst_connector_early_unregister(struct dr=
m_connector *connector)
> >
> >       aconnector->mst_status =3D MST_STATUS_DEFAULT;
> >       drm_modeset_unlock(&root->mst_mgr.base.lock);
> > +
> > +     /*
> > +      * The connector is being removed from the MST topology. If a CRT=
C is
> > +      * still driving it, force a modeset that disables the CRTC so th=
at the
> > +      * MST encoder is released and the DC stream dropped. Otherwise, =
on a
> > +      * subsequent re-plug the stale CRTC/encoder assignment triggers =
an
> > +      * encoder conflict in drm_atomic_helper_check_modeset() and the =
display
> > +      * stays dark.
> > +      */
> > +     if (crtc) {
> > +             struct drm_atomic_commit *state;
> > +             struct drm_connector_state *conn_state;
> > +             struct drm_crtc_state *crtc_state;
> > +             struct drm_modeset_acquire_ctx ctx;
> > +             int ret;
> > +
> > +             drm_modeset_acquire_init(&ctx, 0);
> > +retry:
> > +             state =3D drm_atomic_commit_alloc(connector->dev);
> > +             if (!state)
> > +                     goto out;
> > +             state->acquire_ctx =3D &ctx;
> > +
> > +             crtc_state =3D drm_atomic_get_crtc_state(state, crtc);
> > +             ret =3D PTR_ERR_OR_ZERO(crtc_state);
> > +             if (!ret)
> > +                     crtc_state->active =3D false;
> > +             if (!ret)
> > +                     ret =3D drm_atomic_set_mode_prop_for_crtc(crtc_st=
ate, NULL);
> > +             if (!ret) {
> > +                     conn_state =3D drm_atomic_get_connector_state(sta=
te, connector);
> > +                     ret =3D PTR_ERR_OR_ZERO(conn_state);
> > +             }
> > +             if (!ret)
> > +                     ret =3D drm_atomic_set_crtc_for_connector(conn_st=
ate, NULL);
> > +             if (!ret)
> > +                     ret =3D drm_atomic_commit(state);
> > +
> > +             drm_atomic_commit_put(state);
> > +             if (ret =3D=3D -EDEADLK) {
> > +                     drm_modeset_backoff(&ctx);
> > +                     goto retry;
> > +             }
> > +             if (ret)
> > +                     drm_err(connector->dev,
> > +                             "DM_MST: failed to disable CRTC for remov=
ed connector %s (%d)\n",
> > +                             connector->name, ret);
> > +out:
> > +             drm_modeset_drop_locks(&ctx);
> > +             drm_modeset_acquire_fini(&ctx);
> > +     }
> >  }
> >
> >  static const struct drm_connector_funcs dm_dp_mst_connector_funcs =3D =
{
> >
> > ---
> > base-commit: 551c722f40809618230001baccf219193e22fc5a
> > change-id: 20260930-amd-mst-teardown-cab8a3731596
> >
> > Best regards,
> > --
> > David Medina <b2amedina@gmail.com>
>


--=20
David Medina
14901 SW 87th Ave
Palmetto Bay, FL 33176
786-280-0880
