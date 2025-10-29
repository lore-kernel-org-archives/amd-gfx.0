Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD12BCCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 22:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75B8A10E868;
	Wed, 29 Oct 2025 22:52:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gHcz1qyp";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9465610E868
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 22:52:52 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-b472842981fso60742466b.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 15:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761778371; x=1762383171; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=snslJBGmO4r1c0qnavVpO3ALw8mjodzwk3iu8NRupf4=;
 b=gHcz1qypHAkjQeHA9i1MiEA2GnmCdr4c/eAEy4DK6z5Miq/8dsUsUZh4pk0dkJHOw1
 d5W5QrHNct5phjmNZkHdI/zd5wk1Z/7zd64RNP0QSTF+efoitFQG5ip3Q3rHpkG2SYJF
 DmtqFK5EaB3F6I763AxsxcpDeEOiojzFhZJCBDia2HG73TIJDnfTcKvaIoppAGa7N7JJ
 qRp0Do7bRU2tOOattKbsnZvf3xaJOFAF63iZSs3tarsQ+LelKUKKu0xtKsyjnM1uW38a
 xaXT4iGyVgYc5ROjzNMs1npr2QDayoxjJ/4J0u5oUb5EPqNMTSL2mUwag358zXlwFa8l
 xHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761778371; x=1762383171;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=snslJBGmO4r1c0qnavVpO3ALw8mjodzwk3iu8NRupf4=;
 b=O0FlnN64VDWq918uoHMfqHk0Asqa+LKKGUVz2oe2v2UBPlk0kicnZAjL+C64oaf/XG
 uFmaRnMmXoeyr6WOzBBEe5/mWvln5cdykJX3vlFNzQutE5rfiHbAG81rdZJ8/LuxiiHX
 QCLZWEv/jeRWN4VKVk4yhShPIDduCSZNduzq4Dl8UT9MmoLnS2rU3z6Fex3YycVgJ+3J
 TZy/s4fWrzniaN6J8X3sP7VZQDIlrBTNzgK7xf8yaghr5HMu5bbcPbpWqxmTnnuI59pZ
 oa1Ea88KixXV/tRp+pe0SKzykbmkiET0BnPObzA9PUVH52OBBx3l+uhruNL5arLLT8GR
 UaHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxZxPMxPtK1aA5w8htuM/UG6ZQ1M8+ddp3nQiAiJqc5t4NBZkbpg580e7/D1kW3m9gmmTIe1vl@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyU2FtMiP3Bqodh74cJ/j4vLb/gJgqRASP02k37t0e0s00EgfA3
 LIA4unKDFzaVP/8np9gjXVFbTUMUV+xdsZkCIskZc5FSs1bKCnl5PwRP
X-Gm-Gg: ASbGncuqc+N/NTSnJg4ywwwNpyscGLLE1HLz/maBj1r+nc8rLcGW9AXG5tYKNndFMwN
 U0ji405lhCnTj8DFZwG5QoaU5MfcONVnT6jFCiFOhBVuCU9OtUzchwtQ7PKuTfeC8Qqh6zy9TXN
 TDkguQ0jof1gV1zwBrGJjhYlE38QenUveswo52W1kJss4Zgk2KehA4OTGtj8fzTmHiCKDt7YPq9
 rfcJXwMrnMNx8uAqXRhOLdAXElQUUzspfElEVk3YQJTgDx2HuOxPaN2moV/iL6866Y9133YPjOu
 e/U0HDQ4UkLQyEIhxMAE7RnrMCKrg/DZaW0MiUvmTrrcGkL9/yANEef/9pJe8412yygrjXfwexj
 YfBaR0SHqm1V7fT+S1vDoumxSa6l3wPs1CQS7YmJ1ZEHGZFT+w4b5fgo2z4OP7xREzbqk6NVUGy
 l3Zjd8O9rZK54/UJn8t58XRFYJ0t2Sh2iWFl4W7cx6b4RExrT3V+3UVejh8mFjSUHgrQ==
X-Google-Smtp-Source: AGHT+IF8gV/9gqBhFwhyamsKcBOcg6Oj0NnjRP2Yct9j7810eTjqY5VtqYCck87dDfF+2eHGX3PYAw==
X-Received: by 2002:a17:906:9c82:b0:b6d:8ce4:ff18 with SMTP id
 a640c23a62f3a-b703d2ccb4cmr424603466b.9.1761778370861; 
 Wed, 29 Oct 2025 15:52:50 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24cb:f700:23e8:3719:bda9:8268?
 ([2001:4c4e:24cb:f700:23e8:3719:bda9:8268])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7044d00de6sm291264666b.74.2025.10.29.15.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 15:52:50 -0700 (PDT)
Message-ID: <d8651e53ddabd3bea2cc74ba604a522c17958119.camel@gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix null pointer on analog detection
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Date: Wed, 29 Oct 2025 23:52:47 +0100
In-Reply-To: <e8d1205d-ed53-4fef-9075-2209a5718d8e@amd.com>
References: <20251029161607.401452-1-harry.wentland@amd.com>
 <4b4aabe98541494474296d6f2062482dcfd9c193.camel@gmail.com>
 <e8d1205d-ed53-4fef-9075-2209a5718d8e@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
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

On Wed, 2025-10-29 at 14:29 -0400, Harry Wentland wrote:
>=20
>=20
> On 2025-10-29 12:54, Timur Krist=C3=B3f wrote:
> > On Wed, 2025-10-29 at 12:16 -0400, Harry Wentland wrote:
> > > Check if we have an amdgpu_dm_connector->dc_sink first before
> > > adding common modes for analog outputs. If we don't have a
> > > sink yet we can safely skip this.
> >=20
> > Hi Harry, nice catch!
> >=20
> > Out of curiosity, how is it possible to reach this code when the
> > dc_sink is NULL?
> >=20
>=20
> Huh, that was a bit of a goose chase.
>=20
> amdgpu_dm_init
> > amdgpu_dm_initialize_drm_device
> > amdgpu_set_panel_orientation
> > amdgpu_dm_connector_get_modes
>=20
> This will run even on disconnected (i.e., without dc_sink)
> connectors.

Interesting. I hadn't encountered this code path during my testing, so
I'm a bit baffled how you could trigger that.

I'm sorry for the goose chase, but glad you found a solution.

>=20
> Maybe amdgpu_set_panel_orientation had better move into
> this hunk after the amdgpu_dm_update_connector_after_detect:
>=20
> 	ret =3D dc_link_detect(link, DETECT_REASON_BOOT);
> 	mutex_unlock(&dm->dc_lock);
> 	printk("hwhw: %s %d\n", __func__, __LINE__);
>=20
> 	if (ret) {
> 		amdgpu_dm_update_connector_after_detect(aconnector);
> 		printk("hwhw: %s %d\n", __func__, __LINE__);
>=20
> Either way, the NULL check is still prudent.

Yes, I agree with the NULL check. No argument there.
Also agree with the suggestion above.

Thanks & best regards,
Timur



> > The patch is:
> > Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> >=20
> > >=20
> > > Fixes: 0c9f9ca99238 ("drm/amd/display: Add common modes to analog
> > > displays without EDID")
> > > Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> > > ---
> > > =C2=A0drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
> > > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > index c621e50f636a..bc5a8b8442a2 100644
> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > @@ -8669,7 +8669,7 @@ static int
> > > amdgpu_dm_connector_get_modes(struct
> > > drm_connector *connector)
> > > =C2=A0			amdgpu_dm_connector->num_modes +=3D
> > > =C2=A0				drm_add_modes_noedid(connector,
> > > 1920, 1080);
> > > =C2=A0
> > > -		if (amdgpu_dm_connector->dc_sink-
> > > >edid_caps.analog)
> > > {
> > > +		if (amdgpu_dm_connector->dc_sink &&
> > > amdgpu_dm_connector->dc_sink->edid_caps.analog) {
> > > =C2=A0			/* Analog monitor connected by DAC load
> > > detection.
> > > =C2=A0			 * Add common modes. It will be up to
> > > the
> > > user to select one that works.
> > > =C2=A0			 */
