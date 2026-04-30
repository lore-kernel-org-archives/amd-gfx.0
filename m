Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E428FF8873
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 13:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A5AF10E457;
	Thu, 30 Apr 2026 13:19:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sGEaA1fb";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86C8C10E457
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 13:19:31 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-488ad135063so8208535e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 06:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777555170; x=1778159970; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6eDtjN3o4+/Zt6//CHXucMU8z/6josiPN69H3Kl7ntg=;
 b=sGEaA1fbMhEv+OXt2SAXo7o7wskPqo4o4p74BTgMGI1ZbY9SZu2x3k91jd0FGPWeGC
 XNOzWDYWbbXwpcBkG2ZDnBFO16ronkM+5RuINdDMFQWv9rL9BAYtgpyMLGqyAqM5I5mW
 v8q0Zvbj6gmym0Wqp3ElA0WboQc2TUyNqs3CUAqbkk+2S8kNz+aPx2q/9itgahBNidoV
 +ZHLiA9Jr95irMKtp1r1Nn7be3bigSPAvELzsT3zL4qcCSRjURXVol9iRbNB8m+UkkxO
 O7hM2J1uHfeeoxH7u7iMSwFXxd9FKQEByjjDRskbGcI96Fk58vF8nxIA5AsLTZzTzGeC
 z28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777555170; x=1778159970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6eDtjN3o4+/Zt6//CHXucMU8z/6josiPN69H3Kl7ntg=;
 b=Zb4/YH1Siq1qtXCyMPT/I1lmLe47PPWSDTEmGw7db6/lX33ciT9xFI+P9JF4RqW6NC
 DfGmF56F8jGj+h/ggBZ/wdJ0WNn9mPhC++sS8eqlCijE+OCD9uPVfrInXthgpj/4PYds
 gleTevgZqezGbO0L1Y0XDdJz7FsRocFOV7pfXIauc/6pwz0r/afZ+NsqLpy6LKAAEaBa
 jDWFY0XKhljoUDrBjjEOSklJyj3jn+Cxb65ZflQ4b/+RD4nncXRFn0QwIsqGCxAWbwUX
 /ZsnciVxsrow52T+1h3qKIUvfYWKdQZisYipiWBgCDC6/gu2izJwxKPjpJzaBSdY25uV
 0wiw==
X-Gm-Message-State: AOJu0Yxd/08JAfDbVPMb65WyHikh9bj60GeK59B/80zS3jx5HxXA22FY
 YN+Wt0ByH+uRoJCzj5Ov75IKb3tqmW3iFUnjCjCOeqKKh8DVvCPj8sj+u90j9qGO
X-Gm-Gg: AeBDiet7QWnBJahzQ4tld4/xSNWjlH48I+OUSpoy0ZXOEnKpajg30R5932pbvI6VqPR
 alypOO3WeFJurnGR8rbr07PggznoG6kfrfQ7nQUhJSTK6fYhV0JanrQ/ImTBrOfOKfoaCb2GAvm
 HMm0Cj7S6OO+Sr1Pd2yibs8q0sElpx+VuIK+eUjj1sfciO5DgkZFBsns6gg3TeGxvnPlD8pN5UB
 3jFFko8PstX3o1iJ2t6FuXYtI1+f8Ar+Ga2avCBQyULy6EcuQ/kdbhuNUgOo5NbcbBlPOQ2CByr
 /vWyFXku24enrb8HgmS87xHu2kx7a4dMfRKM1+n2wVqNNWEteBfGam/m1eSITxxUET2biFzxdBz
 KEYulhW749LnrOGAzkaEL0THAek2NbTqfqA/zjOxpT9QYuk5sCu9ZVzZyWIvoc+dc0ANB31oqAo
 NeeLWXHXR1h9oMay7szqsgtZe3BmyQGK98SGkCpkAjsRJMWGgrHJK8qEsiTYBtMc454iWaXj2HS
 Xl1G59kUkNXFWc=
X-Received: by 2002:a05:600c:64c7:b0:48a:7965:b92a with SMTP id
 5b1f17b1804b1-48a84465a63mr49176995e9.26.1777555169800; 
 Thu, 30 Apr 2026 06:19:29 -0700 (PDT)
Received: from timur-max.localnet (netacc-gpn-7-154-214.pool.yettel.hu.
 [176.77.154.214]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a822c832fsm110853405e9.10.2026.04.30.06.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 06:19:29 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>
Subject: Re: [PATCH 08/14] drm/amd/display: Delete dm_pp_clocks_state
Date: Thu, 30 Apr 2026 14:31:34 +0200
Message-ID: <4542162.UPlyArG6xL@timur-max>
In-Reply-To: <d271711c-0d8e-416d-9fa1-75e161ba82aa@igalia.com>
References: <20260423191519.73127-1-timur.kristof@gmail.com>
 <20260423191519.73127-9-timur.kristof@gmail.com>
 <d271711c-0d8e-416d-9fa1-75e161ba82aa@igalia.com>
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

On 2026. =C3=A1prilis 29., szerda 22:37:38 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=
=C3=A1ri id=C5=91 Melissa Wen=20
wrote:
> On 23/04/2026 16:15, Timur Krist=C3=B3f wrote:
> > It isn't used by anything anymore.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >   .../drm/amd/display/dc/dm_services_types.h    | 27 -------------------
> >   1 file changed, 27 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/dc/dm_services_types.h
> > b/drivers/gpu/drm/amd/display/dc/dm_services_types.h index
> > 44aa8d213d386..b3505d93503fd 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dm_services_types.h
> > +++ b/drivers/gpu/drm/amd/display/dc/dm_services_types.h
> > @@ -36,30 +36,7 @@ struct dm_pp_clock_range {
> >=20
> >   	int max_khz;
> >  =20
> >   };
> >=20
> > -enum dm_pp_clocks_state {
> > -	DM_PP_CLOCKS_STATE_INVALID,
> > -	DM_PP_CLOCKS_STATE_ULTRA_LOW,
> > -	DM_PP_CLOCKS_STATE_LOW,
> > -	DM_PP_CLOCKS_STATE_NOMINAL,
> > -	DM_PP_CLOCKS_STATE_PERFORMANCE,
> > -
> > -	/* Starting from DCE11, Max 8 levels of DPM state supported. */
> > -	DM_PP_CLOCKS_DPM_STATE_LEVEL_INVALID =3D DM_PP_CLOCKS_STATE_INVALID,
> > -	DM_PP_CLOCKS_DPM_STATE_LEVEL_0,
> > -	DM_PP_CLOCKS_DPM_STATE_LEVEL_1,
> > -	DM_PP_CLOCKS_DPM_STATE_LEVEL_2,
> > -	/* to be backward compatible */
> > -	DM_PP_CLOCKS_DPM_STATE_LEVEL_3,
> > -	DM_PP_CLOCKS_DPM_STATE_LEVEL_4,
> > -	DM_PP_CLOCKS_DPM_STATE_LEVEL_5,
> > -	DM_PP_CLOCKS_DPM_STATE_LEVEL_6,
> > -	DM_PP_CLOCKS_DPM_STATE_LEVEL_7,
> > -
> > -	DM_PP_CLOCKS_MAX_STATES
> > -};
> > -
> >=20
> >   struct dm_pp_gpu_clock_range {
> >=20
> > -	enum dm_pp_clocks_state clock_state;
> >=20
> >   	struct dm_pp_clock_range sclk;
> >   	struct dm_pp_clock_range mclk;
> >   	struct dm_pp_clock_range eclk;
> >=20
> > @@ -246,10 +223,6 @@ enum dm_acpi_display_type {
> >=20
> >   	AcpiDisplayType_DFP6 =3D 12
> >  =20
> >   };
> >=20
> > -struct dm_pp_power_level_change_request {
> > -	enum dm_pp_clocks_state power_level;
> > -};
>=20
> Ah, okay, here is the dm_pp_power_level_change_request removal.
> I think it should be removed earlier.

Thanks. In the next version of the series I will move it to earlier.

>=20
> Apart from that,
>=20
> Reviewed-by: Melissa Wen <mwen@igalia.com>
>=20
> > -
> >=20
> >   struct dm_pp_clock_for_voltage_req {
> >  =20
> >   	enum dm_pp_clock_type clk_type;
> >   	uint32_t clocks_in_khz;




