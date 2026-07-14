Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91848C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 08:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F16810E035;
	Tue, 14 Jul 2026 08:51:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ivce7Pfl";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D33A10E035
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 08:51:07 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47c6e9a694bso2244165f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 01:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784019066; x=1784623866; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eods8RNnnl6LQ92d7KosEe1stA/ztFOQoc1YJZE1PxI=;
 b=Ivce7PflMKD3cz5oPrYrVqyyugQWsS/m7vGVmt0NbUts5MIzcmlfNou1RPTR1hRULR
 S+HHNab3O0rhNWywumgSN6FCvgGVp7l6b4GD2zM7j3QrHzoNJUQHb6d8Xf8tzulEl5pf
 NQiKMJ93oCEp0GWaHJ1UbxoiE1zY/R0bGhO5M+xXlV0GtePMxMPFa2/qbmgVrc69+PaS
 c74FaE3vRm5zel9QZvRwH4saQwfl+W5J/hEvEDObjMmATUDycCc1HIMihmjHPtIGYLqw
 7Klns1v6HT5sm0tyZTH02vGaAgWMihXZ8VcvGIFcWxqotrpMo4pSPe+y9U6ga26Jk4Fy
 g4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784019066; x=1784623866;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eods8RNnnl6LQ92d7KosEe1stA/ztFOQoc1YJZE1PxI=;
 b=pbrH7+5jE3p82aqkqJWVyUKnD2JO6kD+xLwvxOxQCF66m1AAQjlrLVYesgCsu7jP8G
 8kWlCJFk4Ug/gPDS0eoynlvP4jmWGloHUypWaVS9avjsLHmVNAIKNyw2ZWht3atVf+VW
 aNQY5pKFcK3HElNCHkJPZMLeP3gWNcFkO6MO0nwNpQ51u6QhNqBcAjNXtHzHe33FwkKP
 Ijyn+jeBbv6wKgoCJ9Fw0leUu5wcr3Knoq9UGU5solwARNXlLRWqk/0FIiOfafx1fwiv
 soVVJbBcQQwXByEhEzrT76TKAP0GbrX3lI6LTxZqI3VwM8BBgFd0eVvvRCGRhOx/d3aV
 IjfA==
X-Gm-Message-State: AOJu0YyLwzHWqsYJLN2X+KphxkAYDYWspdVnSTbpHI3WfuJupaCK3YzK
 WqzhINWsAGsa5NpdOBTZHi3ohSBHuP6Oe4/F4eL2n9P7r1Rwx8f+94ftsZNJOw==
X-Gm-Gg: AfdE7cmoGzPjuhlnibbv/Ohuo0Ih0KbeY0n1a2WOQt8Pk8AxeFYZScyHQCgfC5fOMRU
 sW2kNW2HFBPLkOk+IOPMG1IpnE8frEmmxklrtBmx4t55ocFNnQwGePa4uJJQHWvWc6Nf0QXjEN/
 hGeHaDNsc9qrneypKXCcqaTLNENaLWWW0UKM+1lzMORwOT7Axk+uyVN/tuRzjjDjhQEZODGtf5F
 OzwixQcazJSXsUuci1M909i6DZwGSR4ivvYPy7kcVyXGSvzPAsvenPDuPeFvPa2889PLO+4spez
 3SO/sKWU2M60/+aXwdbMG1QQjI9MStfcBKe746j8gv24NRNG9jSN35i+xj4F6mZZ0PKWylETOLw
 bo9D3jaqAjKzZ/pq2v815Wsk3vZKpqioGR8dvAYnFtGMaqd837Nyqs0XNbD77gxBxiPI7Vlj+ST
 90SxJBU3Ce3GHyMvdI05NV/e/80SOV1FjuIp9rHOlfkqzQ4rlydWJ4JfVZbdU=
X-Received: by 2002:a5d:588d:0:b0:47d:eedc:2f12 with SMTP id
 ffacd0b85a97d-47f2dcb6065mr13315787f8f.23.1784019065673; 
 Tue, 14 Jul 2026 01:51:05 -0700 (PDT)
Received: from timur-hyperion.localnet (54001386.dsl.pool.telekom.hu.
 [84.0.19.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c7c96sm6360273f8f.33.2026.07.14.01.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 01:51:05 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>,
 mario.limonciello@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH 1/2] drm/amd/display: Shorten name of FRL polling workqueue
Date: Tue, 14 Jul 2026 10:51:03 +0200
Message-ID: <aXo6J2_kQ_SXM08igon8Aw@gmail.com>
In-Reply-To: <c1d30a27-0fa2-442c-b2be-aac23137a08e@ursulin.net>
References: <20260711113009.26512-1-timur.kristof@gmail.com>
 <c1d30a27-0fa2-442c-b2be-aac23137a08e@ursulin.net>
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

On Monday, July 13, 2026 12:15:13=E2=80=AFPM Central European Summer Time T=
vrtko=20
Ursulin wrote:
> On 11/07/2026 12:30, Timur Krist=C3=B3f wrote:
> > The current name is too long and triggers a warning.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c index
> > b97ceabe6173..6299f0e384f1 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -829,9 +829,9 @@ static int amdgpu_dm_init(struct amdgpu_device *ade=
v)
> >=20
> >   	}
> >   	if (adev->dm.dc->caps.max_links > 0) {
> >   =09
> >   		adev->dm.hdmi_frl_status_polling_wq =3D
> >=20
> > -		=09
create_singlethread_workqueue("hdmi_frl_status_polling_workqueue");
> > +		=09
create_singlethread_workqueue("hdmi_frl_status_polling_wq");
> >=20
> >   		if (!adev->dm.hdmi_frl_status_polling_wq)
> >=20
> > -			drm_err(adev_to_drm(adev), "failed to=20
initialize
> > hdmi_frl_status_polling_workqueue\n"); +		=09
drm_err(adev_to_drm(adev),
> > "failed to initialize hdmi_frl_status_polling_wq\n");>=20
> >   	}
> >   	if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
> >   =09
> >   		init_completion(&adev->dm.dmub_aux_transfer_done);
>=20
> This one does not require display knowledge so I feel okay to review it:
>=20
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>=20
> Two nitpicks would be that the _wq suffix is even redundant since for
> the task name it will have the kworker/ prefix anyway.

Ok, what name do you suggest to use then?

> Second one is
> that while touching this it may make sense to replace the variable name
> from the error message with a human readable name like "failed to
> initialize HDMI FLR status polling".

Ok, can do.

> In fact, is this even an error or
> should be a warning given I do not see an immediate exit?

No idea, I just wanted to fix the warning that I saw.


Timur


