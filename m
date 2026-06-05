Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19FBCD6E7B
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 20:49:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CD0D10E6DE;
	Fri,  5 Jun 2026 20:49:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GiOzwy5X";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3410410E499
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 20:49:35 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-45ef616daf6so2022182f8f.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Jun 2026 13:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780692574; x=1781297374; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9THQQ4NwbqXYiGviE040R0PuJzCAd90R9vNSXh5WA7o=;
 b=GiOzwy5XykwWadlpPijyeT/02ZNB9J7oidwDbKBNpRZseHNcFA2bzmiLdezPeB911Y
 MDcsFkdVSTiEhcvMbnUJavtOhQg0TbBcuMyz9aIRd9DScSOfS48rxlooxtxCAv2s9nEX
 O40aCyWrgXQU1I8Or01nbeAxLLZzHPYVQd8nz6637vAflpG3CvEKAyY3wkHpYNh0K0c7
 YEbsLwRrsakjJtX3tTkSZ22uQ5MMFScq2tGllYp+ldHnVaATeJuXvyd54uLGeG4Fz36J
 O/MakYrWTmISxbFlJPbO5L0Pwti6iIjFqi+rYYpCIlP9JuooBKmFR4mbYd+wEHew1vb/
 mxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780692574; x=1781297374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9THQQ4NwbqXYiGviE040R0PuJzCAd90R9vNSXh5WA7o=;
 b=CT17pS4qC+rF/vfObuDircjsm6nzBb0Pj9IyJOEHrRVx2YYOKA/akHQ6l56Z/43U/B
 bTpatZiPrPvuFJGE0U3xQ4z/JDpdC7+waM0v35cZAAAGnGPKZooqvRisDWrstuN/K9N0
 C/rbemx5Sv9fwJqUpp7qhKULOOw8IyefxgQRyqXd3RXK2YVJptx5QvvVka8iJG8JHd7z
 ltrMs47weWp/AKS12F8hXigHKbvhCszcfvgjFCc9YY1onF/Dl9oTq7tGZqUOP5Y0KeWF
 MI7+r+BzGABXUCXQzVdF35hXaCyE4M5BhQsLRjwS7qs3k4FQrSP+3uerxaQ5pr4vQkqn
 hniA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8oezZxjmbjAGaUoZXbBhyekGW+9zeL1T6GV/RHZ0kgmvOZd9wImnF8rm4A1cnz7/EN963cywq6@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxKdCfspQsTRmicAGeFyxs44MAzz0v8pV8iTri+7EKYM6zL/Zmc
 IdJBNNpbF/E04qg3kNLeNdI+4H6nebrfElOIr6OqwwTHySCQEO4WDpQS
X-Gm-Gg: Acq92OHzTP8HXUcpmB3KavqEr+HpTGNVfwOAtVKqLP8QGmmfRHRF1d4LNEoK8ndR99y
 KG7l6LIX4r2gxKwN6x5CvCu1SaGwswkTDdO1PZKmr9eYkZosjNYmaM/ZdkZpz1C5k1FApPbNoMP
 pM5j0J7CW6kEa1NT6gddjOhhOIGwmlaY9zzZx9bmUK0bTlfklb90wsUOsaLXh4BvA3/vLXsmPoM
 KiGSfzM2+gnLo+X4xntlMEJIa0ovojfnJN4+qLnTBlWfkLEjUBv1JTZQ4jrdf4csU1SA0TtZDrv
 pfDHyxGc/w50ux7+OkF8iXwgwZj2pv84sfgown3fu23TXyYeqYmx4+fCpE+EK80DfVhjbAmZxJL
 crbA5PRo2vLqmJ7fV9ZdvwA/dPvwdSkUmjWQY64AT0tshXH6WvJpZsjUPNi0TudONmlc+wFPynk
 3gnjID9FujI7Caw+Ckl0U3yo+BhKHl56uW411j4vWopZFI9zEGETCjb0CS+rQS9UkMoBG2P43L6
 Mf/5tyq
X-Received: by 2002:a5d:6e84:0:b0:460:1a93:ee91 with SMTP id
 ffacd0b85a97d-46030501f8bmr5648021f8f.22.1780692573485; 
 Fri, 05 Jun 2026 13:49:33 -0700 (PDT)
Received: from timur-hyperion.localnet (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f3444fesm30119218f8f.20.2026.06.05.13.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 13:49:32 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zuo, Jerry" <Jerry.Zuo@amd.com>
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Li, Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "Wheeler, Daniel" <Daniel.Wheeler@amd.com>, "Wu, Ray" <Ray.Wu@amd.com>,
 "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>,
 "Lin, Ping Lei" <PingLei.Lin@amd.com>, "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>
Subject: Re: [PATCH 21/24] drm/amd/display: Retry link detection on hotplug
Date: Fri, 05 Jun 2026 22:49:31 +0200
Message-ID: <4270260.lGaqSPkdTl@timur-hyperion>
In-Reply-To: <CHXPR12MB9992208F15221856A4264B5E97E5112@CHXPR12MB999220.namprd12.prod.outlook.com>
References: <20260604145428.809959-1-aurabindo.pillai@amd.com>
 <20260604145428.809959-22-aurabindo.pillai@amd.com>
 <CHXPR12MB9992208F15221856A4264B5E97E5112@CHXPR12MB999220.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Friday, June 5, 2026 6:10:28=E2=80=AFPM Central European Summer Time Zuo=
, Jerry=20
wrote:
> AMD General
>=20
> Hi Timur:
>=20
>      Please let me know whether you have validated the sequence by any SST
> and HDMI monitor. Basically it is to confirm the link retry workqueue is
> getting executed with hotplug and dpms use cases without introducing side
> effect. We've tested locally, but we don't see any link retry workqueue is
> getting executed by either SST or HDMI monitors. That makes us hard to
> validate the new error handling logic. It would be perfect that if you ha=
ve
> done that at your local setup to confirm the new logic is regression-free
> for SST and HDMI.

Hello Jerry,

Yes, it worked for me last I tried, but I can double-check to make sure.
How did you try to test it?
=20
>      Apart from that, we find a regression in MST. MST has its own detect=
ion
> logic and should be separated from SST and HDMI.

Can you say what the regression is and how to reproduce it?
I'd like to look into it and fix it.

By the way, how do you test MST in general? On my machine, MST doesn't work=
 at=20
with the DC display driver and is basically broken on every GPU generation=
=20
that I tried.

Thanks,
Timur


>=20
>=20
> > -----Original Message-----
> > From: Aurabindo Pillai <aurabindo.pillai@amd.com>
> > Sent: Thursday, June 4, 2026 10:52
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
> > <Sunpeng.Li@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li,
> > Roman <Roman.Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung,
> > ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; Zuo, Jerry
> > <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>; Wu,
> > Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.com>; Hung, Alex
> > <Alex.Hung@amd.com>; Lin, Ping Lei <PingLei.Lin@amd.com>; Chen, Chen-
> > Yu <Chen-Yu.Chen@amd.com>; Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > Subject: [PATCH 21/24] drm/amd/display: Retry link detection on hotplug
> >
> >
> >
> > From: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> >
> >
> >
> > When dc_link_detect_connection_type thinks that a display is connected,
> > but
 dc_link_detect failed, enqueue delayed work to retry the link
> > detection again.>
> >
> >
> > Useful when eg. HPD pin is high but the display isn't ready and didn't
> > respond
 to DDC.
> >
> >
> >
> > - The display is "slow to wake up", ie. DDC isn't ready,
> >=20
> >   for example we couldn't read EDID. Can happen with any
> >   connector type with certain "slow" displays.
> >   Some displays may take up to 15~20 sec or more to wake up.
> >
> >
> >
> > - On hotplug, the HPD pin may make contact before the DDC pins,
> >=20
> >   so we couldn't read the EDID. This most often happens with
> >   DVI connectors, rarely with HDMI. It is not impossible but
> >   extremely rare with other connector types.
> >
> >
> >
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> > Reviewed-by: Alex Hung <alex.hung@amd.com>
> > ---
> >=20
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 138
> >=20
> > ++++++++++++++++++  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> >=20
> > |  16 ++
> > =20
> >  2 files changed, 154 insertions(+)
> >
> >
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index d1b1eb67d937..40295a5edbec 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -161,6 +161,17 @@ MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB);
> >=20
> >  #define FIRMWARE_DCN_42B_DMUB "amdgpu/dcn_4_2_1_dmcub.bin"
> >  MODULE_FIRMWARE(FIRMWARE_DCN_42B_DMUB);
> >
> >
> >
> > +/**
> > + * define AMDGPU_DM_HPD_MAX_NUM_RETRIES - maximum amount of
> > retries for
> > +hotplug detection  */ #define AMDGPU_DM_HPD_MAX_NUM_RETRIES 5
> > +
> > +/**
> > + * define AMDGPU_DM_HPD_RETRY_DELAY_MSEC - millisecond delay
> > between
> > +hotplug detection retries  */ #define
> > AMDGPU_DM_HPD_RETRY_DELAY_MSEC
> > +1500
> > +
> > +
> >=20
> >  /**
> > =20
> >   * DOC: overview
> >   *
> >=20
> > @@ -959,6 +970,125 @@ static void dm_handle_hpd_work(struct
> > work_struct *work)
> >
> >
> >
> >  }
> >
> >
> >
> > +/**
> > + * dm_handle_delayed_hpd_work() - Handle delayed HPD (hotplug
> > +detection)
> > + *
> > + * @w: Base work item structure
> > + *
> > + * Used for retrying HPD after a delay. Just calls the normal HPD
> > helper.
> > + */
> > +static void dm_handle_delayed_hpd_work(struct work_struct *work) {
> > +     struct delayed_work *dw =3D container_of(work, struct delayed_wor=
k,
> > work);
> > +     struct delayed_hpd_work *w =3D container_of(dw, struct
> > delayed_hpd_work, work);
> > +     struct amdgpu_dm_connector *aconn =3D w->aconn;
> > +     enum dc_detect_reason reason =3D w->reason;
> > +
> > +     kfree(w);
> > +     handle_hpd_irq_helper(aconn, reason);
> > +}
> > +
> > +/**
> > + * dm_cancel_delayed_hpd_work() - Cancel pending hotplug detection work
> > +for a connector
> > + *
> > + * @aconnector: Connector on which the HPD event occurred  */ static
> > +void dm_cancel_delayed_hpd_work(struct amdgpu_dm_connector
> > *aconnector)
> > +{
> > +     if (!aconnector || !aconnector->delayed_hpd_work)
> > +             return;
> > +
> > +     cancel_delayed_work(&aconnector->delayed_hpd_work->work);
> > +     aconnector->delayed_hpd_work =3D NULL;
> > +}
> > +
> > +/**
> > + * dm_cancel_all_delayed_hpd_work() - Cancel all pending hotplug
> > +detection work on the device
> > + *
> > + * @dev: DRM device pointer
> > + */
> > +static void dm_cancel_all_delayed_hpd_work(struct drm_device *dev) {
> > +     struct drm_connector *connector;
> > +     struct drm_connector_list_iter iter;
> > +
> > +     drm_connector_list_iter_begin(dev, &iter);
> > +     drm_for_each_connector_iter(connector, &iter) {
> > +             if (connector->connector_type =3D=3D
> > DRM_MODE_CONNECTOR_WRITEBACK)
> > +                     continue;
> > +
> > +
> >=20
> >       dm_cancel_delayed_hpd_work(to_amdgpu_dm_connector(connecto
> >=20
> > r));
> > +     }
> > +     drm_connector_list_iter_end(&iter);
> > +}
> > +
> > +/**
> > + * dm_queue_delayed_hpd_work() - Enqueue delayed work to handle
> > hotplug
> > +detection
> > + *
> > + * @aconnector: Connector on which the HPD event occurred
> > + * @reason: Reason why we are attempting the HPD
> > + * @msecs: Millisecond delay after which the delayed work is going to
> > +happen
> > + *
> > + * When dc_link_detect_connection_type thinks that a display is
> > +connected,
> > + * but dc_link_detect failed, enqueue delayed work to retry the link
> > + * detection again.
> > + *
> > + * Useful when eg. HPD pin is high but the display isn't ready and
> > + * didn't respond to DDC.
> > + *
> > + * - On boot or suspend/resume, the display is "slow to wake up",
> > + *   ie. DDC isn't ready, for example we couldn't read DP link caps or
> > EDID.
 + *   Can happen to any connector with certain "slow" displays.
> > + *
> > + * - On hotplug, the HPD pin may make contact before the DDC pins,
> > + *   so we couldn't read the EDID. Can happen to any connector but
> > + *   most often to DVI and sometimes to HDMI (rarely to DP).
> > + *
> > + */
> > +static void dm_queue_delayed_hpd_work(struct amdgpu_dm_connector
> > *aconnector,
> > +                                   const enum dc_detect_reason reason,
> > +                                   const unsigned int msecs)
> > +{
> > +     struct drm_device *dev =3D aconnector->base.dev;
> > +     struct amdgpu_device *adev =3D drm_to_adev(dev);
> > +     struct delayed_hpd_work *w;
> > +
> > +     if (!aconnector || !aconnector->dc_link ||
> > +         aconnector->dc_link->type =3D=3D dc_connection_none)
> > +             return;
> > +
> > +     /* Don't retry polled connectors, the polling is going to detect =
it.
> > */
 +     if (aconnector->base.polled !=3D DRM_CONNECTOR_POLL_HPD)
> > +             return;
> > +
> > +     ++aconnector->num_hpd_retries;
> > +
> > +     drm_dbg(dev, "Can't detect link on %s on try %d\n",
> > +             aconnector->base.name, aconnector->num_hpd_retries);
> > +
> > +     if (aconnector->num_hpd_retries >
> > AMDGPU_DM_HPD_MAX_NUM_RETRIES) {
> > +             drm_warn(dev, "Too many retries on %s: %d, giving up\n",
> > +                      aconnector->base.name, aconnector-
> >=20
> > >num_hpd_retries);
> >=20
> > +             aconnector->num_hpd_retries =3D 0;
> > +             return;
> > +     }
> > +
> > +     w =3D kzalloc(sizeof(*w), GFP_ATOMIC);
> > +
> > +     if (!w)
> > +             return;
> > +
> > +     INIT_DELAYED_WORK(&w->work, dm_handle_delayed_hpd_work);
> > +     w->aconn =3D aconnector;
> > +     w->reason =3D reason;
> > +     aconnector->delayed_hpd_work =3D w;
> > +
> > +     drm_warn(dev, "Enqueueing next retry on %s\n",
> > +              aconnector->base.name);
> > +     queue_delayed_work(adev->dm.delayed_hpd_wq, &w->work,
> > +                        msecs_to_jiffies(msecs));
> > +}
> > +
> >=20
> >  static const char *dmub_notification_type_str(enum
> >  dmub_notification_type
> >=20
> > e)  {
> >=20
> >       switch (e) {
> >=20
> > @@ -3249,6 +3379,7 @@ static int dm_hw_fini(struct amdgpu_ip_block
> > *ip_block)  {
> >=20
> >       struct amdgpu_device *adev =3D ip_block->adev;
> >
> >
> >
> > +     dm_cancel_all_delayed_hpd_work(&adev->ddev);
> >=20
> >       amdgpu_dm_hpd_fini(adev);
> >
> >
> >
> >       amdgpu_dm_irq_fini(adev);
> >=20
> > @@ -3422,6 +3553,8 @@ static int dm_suspend(struct amdgpu_ip_block
> > *ip_block)
> >=20
> >       struct amdgpu_device *adev =3D ip_block->adev;
> >       struct amdgpu_display_manager *dm =3D &adev->dm;
> >
> >
> >
> > +     dm_cancel_all_delayed_hpd_work(&adev->ddev);
> > +
> >=20
> >       if (amdgpu_in_reset(adev)) {
> >      =20
> >               enum dc_status res;
> >
> >
> >
> > @@ -4451,6 +4584,9 @@ static void handle_hpd_irq_helper(struct
> > amdgpu_dm_connector *aconnector,
> >=20
> >                       if (aconnector->base.force =3D=3D
> >=20
> > DRM_FORCE_UNSPECIFIED ||
> >=20
> >                           reason =3D=3D DETECT_REASON_HPDRX)
> >
> >
> >
> >       drm_kms_helper_connector_hotplug_event(connector);
> >=20
> > +             } else {
>=20
>=20
>=20
> We need to return here if aconnector->mst_mgr.mst_state is set.
>=20
>=20
>=20
> > +                     dm_queue_delayed_hpd_work(aconnector, reason,
> > +
> > AMDGPU_DM_HPD_RETRY_DELAY_MSEC);
> >=20
> >               }
> >      =20
> >       }
> > =20
> >  }
> >=20
> > @@ -4459,6 +4595,8 @@ static void handle_hpd_irq(void *param)  {
> >=20
> >       struct amdgpu_dm_connector *aconnector =3D (struct
> >=20
> > amdgpu_dm_connector *)param;
> >
> >
> >
> > +     /* Cancel any pending work */
> > +     dm_cancel_delayed_hpd_work(aconnector);
> >=20
> >       handle_hpd_irq_helper(aconnector, DETECT_REASON_HPD);
> >
> >
> >
> >  }
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> > index 7d37c1612131..9a66c9e2b78d 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> > @@ -136,6 +136,18 @@ struct dmub_hpd_work {
> >=20
> >       struct amdgpu_device *adev;
> > =20
> >  };
> >
> >
> >
> > +/**
> > + * struct delayed_hpd_work - Handle delayed HPD (hot plug detection)
> > +work
> > + *
> > + * @work: Base structure, kernel work data for the work event
> > + * @aconn: Pointer to connector where the HPD event happened  */ struct
> > +delayed_hpd_work {
> > +     struct delayed_work work;
> > +     struct amdgpu_dm_connector *aconn;
> > +     enum dc_detect_reason reason;
> > +};
> > +
> >=20
> >  /**
> > =20
> >   * struct vblank_control_work - Work data for vblank control
> >   * @work: Kernel work data for the work event @@ -801,6 +813,10 @@
> >=20
> > struct amdgpu_dm_connector {
> >=20
> >       /* number of modes generated from EDID at 'dc_sink' */
> >       int num_modes;
> >
> >
> >
> > +     /* number of retries on hot plug detection */
> > +     int num_hpd_retries;
> > +     struct delayed_hpd_work *delayed_hpd_work;
> > +
> >=20
> >       /* The 'old' sink - before an HPD.
> >      =20
> >        * The 'current' sink is in dc_link->sink. */
> >      =20
> >       struct dc_sink *dc_sink;
> >=20
> > --
> > 2.54.0
>=20
>=20




