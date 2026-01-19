Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFB4CCF2DE
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 19:06:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D10510E4EC;
	Mon, 19 Jan 2026 19:06:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AKYDyAd5";
	dkim-atps=neutral
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F4A110E4EC
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 19:06:16 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id
 a640c23a62f3a-b874c00a39fso814014466b.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 11:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768849574; x=1769454374; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NVf7l6jb7An3bkHhAtYLx+VYE2ou3D6SubtoY1Dd+fI=;
 b=AKYDyAd5wqFy3GDeo19lSFE8B1jd02Tcwlw8PwRE89z2ayvNhumuiX4iO+2qtXL+Bj
 XeDSftB6t7DRSENTgFhAZj3QFFnAj7LrkwbY0+5VZaLIFcesGdr2VFAlkSCa+VDtKKBa
 h8bab5qY1XtAasJ2Ka7P62hUiQIxv07nrIssGFVHZHrMB8Oh+G5rRm5hHY/EXO5kF6W4
 tDKP3ElYWA/4g99h3OzM/99WsmLKU4/Vx+kRt+bMwg2NQECTIeM92nXP0QKX+mPJRMMC
 T21YlqLdVPa5O92/tJun0c71/4DuEg4Xq6KWpD+d821NHDW2DQr/6hI9XnutFQziSdRJ
 xWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768849574; x=1769454374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NVf7l6jb7An3bkHhAtYLx+VYE2ou3D6SubtoY1Dd+fI=;
 b=Ms2a/Z4+bY9S7ZAKP3dS8xrjTzPTTBaXJoACy8sRhnSl7plFc9fFq+nJ2DdxJZ0/HB
 1u3XXcwIyE+QvgVo0J2AfaH/V8j0mUo+ulG2GZ4zu0k7H1JGkQZPNWa4JidX88ReeHUl
 6YtZQu5PknTC3dFUEwxiB0HVy5K1biqcVdQHk+0l9UC7Pwqtp0Q8XxmN2R+u6ihLTYQ+
 aAFzJmv0h4NSqq10nEecIbo1ccokv9dBE6DNM3iEXi197sK5tDbdXBYUPTVQVvBlN/dQ
 QO6gAukwowxCTOPcTzOycVM9ubuV7YA53aJ4ABmSrVlns43g8kAjx0sPqga92LsD8hV1
 FhCw==
X-Gm-Message-State: AOJu0YyzG72BmNKJhJjXgGjN2zmQhFTT9yaLro0aFO1bze7AJTnV6Omx
 MhCR5fti1KYUGneC9d4J7mce0pwyTc6ZLIUhAJioUOkMCFl/vaCmV7AiyRJ2iChv
X-Gm-Gg: AZuq6aJT3Ww/cwjR6eRszugVV8aHMH3qcrKV7RifacowA2/XSSQQ90mPTYC4yKrqOP1
 qotz5VqpMg+jBwErCjyamQZkq5YQhhWINqk+/GbMejU44zXFfGSFgv86M1KTGNyiy+ZaL7mM2IV
 qsioGoj3BxNVoo7oO6ks2vkxxR5SoWPvMRi4vczXj3wgirfeKYLs66ZaNMb8saRMFPZa8Oc3ky9
 qdpyJnzmd+Cv6JjHjaQ8WbKL+5MS4iA26BYKlIlLjSNGFJRzFmabMtY342MBN8YYSkgI76+T1AO
 ZfKaO4Pld8ipEX4uIayZU1pjuMsDPZ/nj5VJ1vZl2CmznNXUSrdM42GguaS4HrkqWukU/4TshPY
 yC63prZy7moPsNT2evMfJNBip9mfM1oGC85NyO7D5FlncKTqJKBS11sn1W5w5nLh8GoMFd9EIzV
 LY66AGkndQeawy6b0ZK3fRssGT+hsHCHVzUB/AHNZOItHUoVP7K1rF8b8AsQwxX41TRfVkZ2Z2B
 BmiPNxcy1JwXI0UnzJ7fxYm
X-Received: by 2002:a17:906:9557:b0:b76:d8cc:dfd9 with SMTP id
 a640c23a62f3a-b8777bc5e1fmr1235972366b.18.1768849574161; 
 Mon, 19 Jan 2026 11:06:14 -0800 (PST)
Received: from timur-hyperion.localnet
 (20014C4E24E47400AD77F2CC91C9A6FE.dsl.pool.telekom.hu.
 [2001:4c4e:24e4:7400:ad77:f2cc:91c9:a6fe])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795a2f1aesm1202127366b.61.2026.01.19.11.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 11:06:13 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Harry Wentland <harry.wentland@amd.com>
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: Re: [PATCH] drm/amd/display: Only poll analog connectors
Date: Mon, 19 Jan 2026 20:06:12 +0100
Message-ID: <5021716.OV4Wx5bFTl@timur-hyperion>
In-Reply-To: <47aaaa83-012c-45bb-8f51-8f09c0ad20ce@amd.com>
References: <20260118130345.43356-1-timur.kristof@gmail.com>
 <47aaaa83-012c-45bb-8f51-8f09c0ad20ce@amd.com>
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

On Monday, January 19, 2026 6:21:40=E2=80=AFPM Central European Standard Ti=
me Harry=20
Wentland wrote:
> On 2026-01-18 08:03, Timur Krist=C3=B3f wrote:
> > Analog connectors may be hot-plugged unlike other connector
> > types that don't support HPD.
> >=20
> > Stop DRM from polling other connector types that don't
> > support HPD, such as eDP, LVDS, etc. These were wrongly
> > polled when analog connector support was added,
> > causing issues with the seamless boot process.
> >=20
> > Fixes: c4f3f114e73c ("drm/amd/display: Poll analog connectors (v3)")
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > Reported-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> > ---
> >=20
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c index
> > 0a2a3f233a0e..e7b0928bd3db 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> > @@ -915,13 +915,19 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *ade=
v)
> >=20
> >  		struct amdgpu_dm_connector *amdgpu_dm_connector;
> >  		const struct dc_link *dc_link;
> >=20
> > -		use_polling |=3D connector->polled !=3D=20
DRM_CONNECTOR_POLL_HPD;
> > -
> >=20
> >  		if (connector->connector_type =3D=3D=20
DRM_MODE_CONNECTOR_WRITEBACK)
> >  	=09
> >  			continue;
> >  	=09
> >  		amdgpu_dm_connector =3D=20
to_amdgpu_dm_connector(connector);
> >=20
> > +		/*
> > +		 * Analog connectors may be hot-plugged unlike other=20
connector
> > +		 * types that don't support HPD. Only poll analog=20
connectors.
> > +		 */
> > +		use_polling |=3D
> > +			amdgpu_dm_connector->dc_link &&
> > +		=09
dc_connector_supports_analog(amdgpu_dm_connector->dc_link->link_id.id)
> > ;
>=20
> Why isn't the aconnector->base.polled assignment in
> amdgpu_dm_connector_init_helper doing the trick?
>=20
> Harry

Hi Harry,

The issue is that checking "connector->polled !=3D DRM_CONNECTOR_POLL_HPD" =
will=20
also match connectors that don't support hotplugging, such as eDP, LVDS etc.

amdgpu_dm_connector_init_helper is working correctly, it doesn't set the=20
DRM_CONNECTOR_POLL_HPD flag for neither analog connectors, nor eDP, LVDS, e=
tc.=20
which is correct. The problem is with this check in amdgpu_dm_hpd_init.

Best regards,
Timur

>=20
> > +
> >=20
> >  		dc_link =3D amdgpu_dm_connector->dc_link;
> >  	=09
> >  		/*




