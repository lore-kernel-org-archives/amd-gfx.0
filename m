Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B143E78D44
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 08:41:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D536710E33D;
	Mon,  9 Feb 2026 08:41:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N7sTEL8G";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0B2F10E0DF
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 21:08:37 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-b8dd0168b90so33766266b.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Feb 2026 13:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770412116; x=1771016916; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding
 :disposition-notification-to:references:in-reply-to:date:cc:to:from
 :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=/+NJOFqSVdQV18UFk9RR7F7roLWkGvtxbswC+y4nQIM=;
 b=N7sTEL8GB4nTdWqDkpk/klNRzWo0BUwOO0WYnzxgfMKzGYi/OGYztt9PDtXzwi0F36
 9DnayoHVOJk4gRokROo3/GpA4jLaa3i/HrtM+vdH1O/+0Ldb7R0DYIAQHck1sAFDBp4q
 PvaSrLVuqmjx0Mdi4hsJsq5J2Nat9oC2zDpg7ea2cd5ay13u3k1/Pwpq8Q/aZnbKQmUp
 vbimm+q9WG10O2mJ5+AzfnJqzn+VWIrv/b72/3vpohZ3xSLNYQxj+BF4pHuoyyH4Of1w
 RW/tQSfAIVZK7nBKrYgdy5KvNqEtff/AfNDwqnpEnXjpsp8W7AUVJF9kqMcXeiqomGK4
 7hAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770412116; x=1771016916;
 h=mime-version:user-agent:content-transfer-encoding
 :disposition-notification-to:references:in-reply-to:date:cc:to:from
 :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/+NJOFqSVdQV18UFk9RR7F7roLWkGvtxbswC+y4nQIM=;
 b=WoJDOeV+denujw7TGDi6NKlFaVhBylUPU/+ZeJmEicxNPyK1ektGAOR48KgaRbitW1
 MAcUPczBC9AxooBEEnDnk04twJlRe6StY28fbi09OGgIefyd3mYAjcyGH43+5xHt6uKp
 ZMsC3XOlAqIzV9gEJXDaeGBc/DT5yRb9xHFJ6uztTHctK96CxmPiSXgUnLz8nNg6Awoo
 Pms8lJqjunQsQ+ZoZ8aYFU2ea0LTC5/DYgdA4m8lH+Htvrv/cOW1INGM/gSvWe77M7y2
 JC2JLrn31XSn/l5ESgAQZ1dDqkjZbujugZRDF127BO2fx2cmctfmhGTXMnvMSd1rfn0u
 NlBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeJAnOMJID+ehm0ZVgWg1BeYCpm8qyJoUOK8fbGIq7kuek2VcOv7Q9xSbY9L7NIrvVERbu254B@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4VrnAjNMQZE07JGEnQ5DL4pLkygYDjBKZ2sVmQTGD5P0f62+C
 k2CqmqaOh5dGXatjG6UNfn1/89pOJtnoop39ooPASqiNBJoGiR3oKbOe
X-Gm-Gg: AZuq6aJttduybkX5cDvyJ1fLigbZtR7HUWZ7Z+21+f1k7BloF8k/pnlRXsXL99bFCJj
 oGV3maagfHsikfM/cw4/zn2Enxu05F1tPYXbZxMKGbo7wVahN0aXfOY4mbGecdYSkxczLH2P+E0
 MX9eUEyTIaCMlt8UOZmhr/6JikCNlN516nI0/8mtoJjSe4ReBBcQZKqPy1elxCwmnMfY6aMmp2M
 +ekAgt0zYsMhdWbmojmhPlAgq7ognx6qmu+rcAM6+P8dzgNut7UU+KWAGEz4s7KvlaINK7R5WS5
 IhU+Ei2+1mMOKptihJtylKhuw+qLISA4Q+xm81+YNkFsRG30NuLwa0Uqtr0IZ7zSxNjGFGhWpEc
 X5dwWd2jeLXL9cO07rYq4z5xEBql6OU+Il10QuI2vDdpJrzG1KjD7ldshu9et/Wcv6kJQI2k60S
 QBLYxnQgPvVQKRfnT2ghTFp9JDveyYXvL+LxqkWMlhz5LjKvWvKuKMKCWSiJiBVcbdCb+mh8xq/
 2G418SHkg==
X-Received: by 2002:a17:906:6a0f:b0:b88:5095:b740 with SMTP id
 a640c23a62f3a-b8edf4ead62mr117120066b.7.1770412116127; 
 Fri, 06 Feb 2026 13:08:36 -0800 (PST)
Received: from [192.168.1.239] (87-205-5-123.static.ip.netia.com.pl.
 [87.205.5.123]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8eda7a3004sm113593866b.15.2026.02.06.13.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 13:08:35 -0800 (PST)
Message-ID: <1f0ce7317fa941ef443c0d8c04aab00b78033cc1.camel@gmail.com>
Subject: Re: [PATCH v3 19/19] drm/amd/display: Add HDMI VRR desktop mode
From: Tomasz =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, alexander.deucher@amd.com, 
 sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, 	airlied@gmail.com, simona@ffwll.ch,
 siqueira@igalia.com, 	dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, 	linux-kernel@vger.kernel.org,
 bernhard.berger@gmail.com, 	michel.daenzer@mailbox.org,
 daniel@fooishbar.org, admin@ptr1337.dev
Date: Fri, 06 Feb 2026 22:08:33 +0100
In-Reply-To: <ee4a21fc-3625-4086-b2d0-9acf20b5d2ef@amd.com>
References: <20260203185626.55428-1-tomasz.pakula.oficjalny@gmail.com>
 <20260203185626.55428-20-tomasz.pakula.oficjalny@gmail.com>
 <ee4a21fc-3625-4086-b2d0-9acf20b5d2ef@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 09 Feb 2026 08:41:30 +0000
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

On Fri, 2026-02-06 at 13:58 -0500, Harry Wentland wrote:
> On 2026-02-03 13:56, Tomasz Paku=C5=82a wrote:
> > [Why]
> > Many TVs and other HDMI sinks suffer from blanking and possibly other
> > glitches when VRR is toggled. With FreeSync present on such sinks, they
> > behave like the signal is always variable, even in fixed refresh rate
> > situations.
> >=20
> > [How]
> > Keep HDMI VRR toggled if it's supported and not explicitly disabled.
> > Additionnally, add module parameter which allows users to configure HDM=
I
> > VRR triggering to only happen when the signal is truly asking for
> > variable state. This is useful if end user has a TV that automatically
> > toggles ALLM/Game mode when VRR is active and such user doesn't want
> > gaming mode in normal desktop usage.
> >=20
>=20
> Can't this already be done by the compositor by simply setting the
> VRR_ENABLED property on a crtc?
>=20
> I don't like doing behavior behind the backs of compositors that
> they might not be expecting.
>=20
> Harry

This actually mimics how FreeSync works on Windows. It keeps signaling
VRR or well, FreeSync mode, to the sink while keeping the signal fixed.=20
Overall behavior is the same as with VRR completely disabled. Signal is
only variable if the compositor sets VRR_ENABLED.

It's a bit similar to freesync video or VRR_STATE_ACTIVE_FIXED.

FreeSync infopacket contains separate FreeSync on Desktop, and FreeSync
active fields and in this change, the check for VRR with
hdmi_vrr_on_desktop is the same as for FreeSync on Desktop field.

I could better show this by uploading a video to youtube, especially
with a comparison to the Windows driver.

Sadly, VRR_ENABLED is just a bool whereas compositors could give drivers
info in three steps: Disabled, Inactive, Active. This way, we could
still completely disable VRR signaling though again, the desired
behavior is preset even in the Windows driver or maybe it's baked into
FreeSync specification? I don't know if it's public, I know I haven't
seen it but it would be nice.

The need for this is due to the fact that, contrary to VESA Adaptive
Sync, HDMI doesn't seem to enforce that VRR mode toggling shouldn't
cause a mode change this A LOT of TVs will blank.

This is especially egregious with Windows' Dynamic Refresh rate setting
where the desktop becomes absolutely unusable. With constant blanking.


> > Signed-off-by: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h                 |  1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c             | 13 +++++++++++++
> >  .../amd/display/modules/info_packet/info_packet.c   |  9 +++++++--
> >  3 files changed, 21 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> > index 312aa32064d5..d49cd55e0f35 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -269,6 +269,7 @@ extern int amdgpu_rebar;
> >  extern int amdgpu_wbrf;
> >  extern int amdgpu_user_queue;
> >  extern uint amdgpu_allm_mode;
> > +extern bool amdgpu_hdmi_vrr_desktop_mode;
> > =20
> >  extern uint amdgpu_hdmi_hpd_debounce_delay_ms;
> > =20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_drv.c
> > index 4b038c8bbf9f..f53c2ffeffa2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -249,6 +249,7 @@ int amdgpu_rebar =3D -1; /* auto */
> >  int amdgpu_user_queue =3D -1;
> >  uint amdgpu_hdmi_hpd_debounce_delay_ms;
> >  uint amdgpu_allm_mode =3D 1;
> > +bool amdgpu_hdmi_vrr_desktop_mode =3D true;
> > =20
> >  DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS=
, 0,
> >  			"DRM_UT_CORE",
> > @@ -1146,6 +1147,18 @@ module_param_named(hdmi_hpd_debounce_delay_ms, a=
mdgpu_hdmi_hpd_debounce_delay_ms
> >  MODULE_PARM_DESC(allm_mode, "Changes ALLM trigger mode (0 =3D disable,=
 1 =3D enable (default), 2 =3D force enable)");
> >  module_param_named(allm_mode, amdgpu_allm_mode, uint, 0644);
> > =20
> > +/**
> > + * DOC: hdmi_vrr_on_dekstop (bool)
> > + * Enables FreeSync behavior mimicking by keeping HDMI VRR signalling =
active in
> > + * fixed refresh rate conditions like normal desktop work/web browsing=
.
> > + * Possible values:
> > + *
> > + * - false =3D HDMI VRR is only enabled if refresh rate is truly varia=
ble
> > + * - true  =3D Mimics FreeSync behavior and keeps HDMI VRR always acti=
ve
> > + */
> > +MODULE_PARM_DESC(hdmi_vrr_desktop_mode, "Changes HDMI VRR desktop mode=
 (false =3D disable, true =3D enable (default))");
> > +module_param_named(hdmi_vrr_desktop_mode, amdgpu_hdmi_vrr_desktop_mode=
, bool, 0644);
> > +
> >  /* These devices are not supported by amdgpu.
> >   * They are supported by the mach64, r128, radeon drivers
> >   */
> > diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packe=
t.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> > index 5fd9e8aadc98..b41e2240e1ae 100644
> > --- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> > +++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> > @@ -654,8 +654,13 @@ static void build_vtem_infopacket_data(const struc=
t dc_stream_state *stream,
> >  	bool vrr_active =3D false;
> >  	bool rb =3D false;
> > =20
> > -	vrr_active =3D vrr->state =3D=3D VRR_STATE_ACTIVE_VARIABLE ||
> > -		     vrr->state =3D=3D VRR_STATE_ACTIVE_FIXED;
> > +	if (amdgpu_hdmi_vrr_desktop_mode) {
> > +		vrr_active =3D vrr->state !=3D VRR_STATE_UNSUPPORTED &&
> > +			     vrr->state !=3D VRR_STATE_DISABLED;
> > +	} else {
> > +		vrr_active =3D vrr->state =3D=3D VRR_STATE_ACTIVE_VARIABLE ||
> > +			     vrr->state =3D=3D VRR_STATE_ACTIVE_FIXED;
> > +	}
> > =20
> >  	infopacket->sb[VTEM_MD0] =3D VTEM_M_CONST << VTEM_M_CONST_BIT;
> >  	infopacket->sb[VTEM_MD0] |=3D VTEM_FVA_FACTOR << VTEM_FVA_BIT;
