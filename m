Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CD1C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 19:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBDF410E210;
	Wed, 15 Jul 2026 19:04:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SLjuOdrG";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 800DF10E210
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 19:04:24 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47122683cf3so3334888f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 12:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784142263; x=1784747063; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zkPJClNVWjZ8DFKGyOa09cF9n4TOZHuZZNZcPfZ4olo=;
 b=SLjuOdrGNgYWgjaTOA+WQx6+2BJZ3gWGi5Gb4fUGLjHPfrCoSCm3LxUxZngfjiku4C
 4g9IneGj/5E6JqeACNMkf3ZJdAuvR0Ijl1JM3rh+oE6kCRJtMEoqqI13FzN8aoNwh4/m
 IDOl7TYi7Q82Kq6uR60bvVv5u2P/eG2H4HTo2ta1PmUoz7KU+MKY0InkIeC5Mgk2ieEE
 YPCHImeprvvOJcrWGPVLZqxocZQwr+XubDUDJg1r8iMhvKjbQD+J9X6tv2gMD61sIl5D
 AVhrS8dztVI2ONG8xmTg/uexYm4U1rPd5A0pNeM2FuVfTkGyI/BGPQTs8iqJHjWWAZZC
 fZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784142263; x=1784747063;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zkPJClNVWjZ8DFKGyOa09cF9n4TOZHuZZNZcPfZ4olo=;
 b=Uh5YFz6PamSDwvLoUQSER/dmtldUyHK853QnCgYZQ7EPrTCglIxIttyLij8divopyK
 e+iTGhDBv7rSgsl/rc3x3ZW6vwytb22iG01gKp7DGrO8aldONL0QuXqwb8RPzef0+AsN
 aVsNX6jtneTAZNuw/nr6fD8oBpk4V+auP8IspOD5CIJ9Pi0L9z+I/uA2hsdCSw8yOGex
 njO8lnXPjfw729wNgkpp/MThzRrgRZd7ypa3aq21rNSB1pm3BSl4OZ7aag9SmOif4QZF
 HtbqPSXJZP1nZarpF/Fg/X2vcdNa966qqjMtwuuNEeynhWie8IqcoQi+OVa/skFZ7jAL
 jBaQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpkAz94Rfc3M8xRzgodSvUntsLIi20WcfLHQO9s+ztgqGnzhlZie14ryDv3puku1HFOvw8nXg8z@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzYJX/pa6hMWudXr+snXYm2zgEXsX2FRevT6k5rNn+4cPuWYLJz
 3KayHPP6u4QURtcabaVJOJ1INxmb895KFP8tpXt2P7Kob20Q5D11joH8
X-Gm-Gg: AfdE7cmMqgO3LJP5omVyNUt5c08uHzvH9RMGeH7tc+y5lC/tNoSMH0uq1lwAhvO0uhx
 oW7TmMwaKdAZ8kJ8y7f6ugvAgU+xFK4KS3UjO6YjdUJeQtFkDBWG2RtDzFnF+ekievWzSZUNaOK
 muLvcA/Wv8Vkb7gs/UyEZQy5fgJGe1q1869cmLRuno4yYpNFaCfmj5MR00DJCYfkaSHf8g3ngKy
 MCtEUZhyz8I9Ez5IhYfALlS3beFHK9hjOXRfHKfDn6nLwImmoc2Coo4vjLCZdpFqlXMbPX0fKNi
 ZIN54bFH3WcJuPv+SCNPvL9u2iP7DQjjHNxUyxK2UdRPX6kymEhKOFENEeA+SziWBlJIvL0GxY6
 0kW/dxPwNWVorBHe4brpK2gi3nhca0P4ZxFIwtJsbIFP3N/ReLOuirfzTE8a5h1w02/iw4ij4Ii
 JD5iJ7a+s76sUAJAZs7FyrGgq/5bG1OVpCh7Ggidym0OsJD+/fmciCN9iG3ELMtOYqCKDDTn/21
 8AYZjkxE0wew6l91PI=
X-Received: by 2002:a05:6000:4688:b0:475:f0f0:9eee with SMTP id
 ffacd0b85a97d-47f463988efmr10029042f8f.51.1784142262605; 
 Wed, 15 Jul 2026 12:04:22 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24CD7200F6BBA872344E1A32.dsl.pool.telekom.hu.
 [2001:4c4e:24cd:7200:f6bb:a872:344e:1a32])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4635c86csm18369588f8f.16.2026.07.15.12.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 12:04:22 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: "Zuo, Jerry" <Jerry.Zuo@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Natalie Vock <natalie.vock@gmx.de>,
 Melissa Wen <mwen@igalia.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "Hung, Alex" <Alex.Hung@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH 2/2] drm/amd/display: Check HDMI FRL support before
 creating polling workqueue
Date: Wed, 15 Jul 2026 21:04:20 +0200
Message-ID: <3270562.KVeVyVuyWN@timur-max>
In-Reply-To: <d7de2367-7b71-420c-88aa-807578ce5ddf@amd.com>
References: <20260711113009.26512-1-timur.kristof@gmail.com>
 <CHXPR12MB999220BD34392F514B0B5C948AE5F82@CHXPR12MB999220.namprd12.prod.outlook.com>
 <d7de2367-7b71-420c-88aa-807578ce5ddf@amd.com>
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

On 2026. j=C3=BAlius 15., szerda 20:10:37 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=
=C3=A1ri id=C5=91 Harry Wentland=20
wrote:
> On 2026-07-15 11:46, Zuo, Jerry wrote:
> > AMD General
> >=20
> > It may not be necessary to identify whether it is FRL when creating the
> > queue. FRL is not determined until link detection. Whether make the que=
ue
> > active or not is dynamically determined by whether an active FRL stream
> > presents.
> This checks whether the HW has any FRL capable encoders and only
> creates the workqueue if it does. The workqueue is still created
> regardless whether or not an FRL-capable device is plugged in.
>=20
> Harry

Exactly as Harry says.
The workqueue should not be created when there is no FRL capable connector.
=46or example DCE6-12 (and older DCN) never need this workqueue at all.

>=20
> >> -----Original Message-----
> >> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tim=
ur
> >> Krist=C3=B3f
> >> Sent: Saturday, July 11, 2026 07:30
> >> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> >> <Alexander.Deucher@amd.com>; Tvrtko Ursulin <tursulin@ursulin.net>;
> >> Natalie Vock <natalie.vock@gmx.de>; Melissa Wen <mwen@igalia.com>;
> >> Limonciello, Mario <Mario.Limonciello@amd.com>; Hung, Alex
> >> <Alex.Hung@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>
> >> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> >> Subject: [PATCH 2/2] drm/amd/display: Check HDMI FRL support before
> >> creating polling workqueue
> >>=20
> >> The workqueue is not necessary when FRL is not supported or when it's
> >> disabled. Add a helper to tell when the current board has any HDMI FRL
> >> capable connectors and call that before creating the workqueue.
> >>=20
> >> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> >> ---
> >>=20
> >>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
> >>  drivers/gpu/drm/amd/display/dc/core/dc.c      | 26 +++++++++++++++++++
> >>  drivers/gpu/drm/amd/display/dc/dc.h           |  2 ++
> >>  3 files changed, 29 insertions(+), 1 deletion(-)
> >>=20
> >> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> index 6299f0e384f1..87d7b60ceb3f 100644
> >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> @@ -827,7 +827,7 @@ static int amdgpu_dm_init(struct amdgpu_device
> >> *adev)
> >>=20
> >>               dc_init_callbacks(adev->dm.dc, &init_params);
> >>      =20
> >>       }
> >>=20
> >> -     if (adev->dm.dc->caps.max_links > 0) {
> >> +     if (dc_is_hdmi_frl_supported(adev->dm.dc)) {
> >>=20
> >>               adev->dm.hdmi_frl_status_polling_wq =3D
> >>      =20
> >>       create_singlethread_workqueue("hdmi_frl_status_polling_wq");
> >>      =20
> >>               if (!adev->dm.hdmi_frl_status_polling_wq)
> >>=20
> >> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c
> >> b/drivers/gpu/drm/amd/display/dc/core/dc.c
> >> index 1b6627a92d24..1a7073abb8ba 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> >> @@ -6592,6 +6592,32 @@ void
> >> dc_mclk_switch_using_fw_based_vblank_stretch_shut_down(struct dc *dc)
> >>=20
> >>               dc->current_state-
> >>>=20
> >>> bw_ctx.bw.dcn.clk.fw_based_mclk_switching_shut_down =3D true;  }
> >>=20
> >> +/**
> >> + * dc_is_hdmi_frl_supported() - Check HDMI FRL support
> >> + *
> >> + * @dc: [in] dc structure
> >> + *
> >> + * Return:
> >> + * True if the current board has any HDMI FRL capable connectors,
> >> + * False otherwise.
> >> + */
> >> +bool dc_is_hdmi_frl_supported(struct dc *dc) {
> >> +     int i;
> >> +
> >> +     if (!dc->config.enable_frl)
> >> +             return false;
> >> +
> >> +     for (i =3D 0; i < dc->link_count; ++i) {
> >> +             if (dc->links[i] &&
> >> +                 dc->links[i]->link_enc &&
> >> +                 dc->links[i]->link_enc-
> >>=20
> >>> features.flags.bits.IS_HDMI_FRL_CAPABLE)
> >>=20
> >> +                     return true;
> >> +     }
> >> +
> >> +     return false;
> >> +}
> >> +
> >>=20
> >>  /**
> >> =20
> >>   * dc_is_dmub_outbox_supported - Check if DMUB firmware support outbox
> >>=20
> >> notification
> >>=20
> >>   *
> >>=20
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h
> >> b/drivers/gpu/drm/amd/display/dc/dc.h
> >> index 13c1f7cd9d7d..d27c7437ee7a 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> >> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> >> @@ -3056,6 +3056,8 @@ bool dc_set_ips_disable(struct dc *dc, unsigned =
int
> >> disable_ips);  void dc_z10_restore(const struct dc *dc);  void
> >> dc_z10_save_init(struct dc *dc);
> >>=20
> >> +bool dc_is_hdmi_frl_supported(struct dc *dc);
> >> +
> >>=20
> >>  bool dc_is_dmub_outbox_supported(struct dc *dc);  bool
> >>=20
> >> dc_enable_dmub_notifications(struct dc *dc);
> >>=20
> >> --
> >> 2.55.0




