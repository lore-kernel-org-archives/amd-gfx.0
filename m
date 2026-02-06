Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AF5E78D40
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 08:41:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C416A10E360;
	Mon,  9 Feb 2026 08:41:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="guwUpLJL";
	dkim-atps=neutral
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2469E10E915
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 20:53:11 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-b8845a47e39so40850766b.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Feb 2026 12:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770411189; x=1771015989; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding
 :disposition-notification-to:references:in-reply-to:date:cc:to:from
 :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=8nCuBzBCWXvAq1q08nO5/bP5KSwKUp+J/Q3o6/S7644=;
 b=guwUpLJLoPC5cTXaTRN5mOPKIl6vmjAoWmR8AFev3RtZO9shC12S6PK5V9JV5gmEsa
 o6aiKKmb7bbamNWkLK5yquq64Vlf4tCGi0DJshON9c/Qjxq6Ty1iE1nMeHww/SHUDGKB
 Bq63luMrZ8xROiwOtzuokTmqxzqt0TwXvoEAuSmz7WknNPKyV4jIU/vBxATGdeZg/2NO
 fKwGwWi5DJVr3zscbp3rdTWfcNae4yjY3JQV++sReZT8rg6IymZ1EZJ3RSL80jLix+uM
 +J2NNPnDndFW/iiSMz+u6s+3Vbnd0ZPVuZbzwlud5YmlR3dHyqZEvD7xnliE0iKCK81U
 pMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770411189; x=1771015989;
 h=mime-version:user-agent:content-transfer-encoding
 :disposition-notification-to:references:in-reply-to:date:cc:to:from
 :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8nCuBzBCWXvAq1q08nO5/bP5KSwKUp+J/Q3o6/S7644=;
 b=XFoGh8kh3wL04wltxQfOJU6H1GWEZ5eY+iTuwenDCjC9NEqWzuhamF3GJgISqinhD6
 TEnr91M93na1Lh7eF5DC9u4z7Fkb0QeVHX9CdjeJ/OK0GtiOih7MEr6avgQvGweQbAkv
 cZJNrpsriWEy997kKPd2fVQd5cidf9mq4WzvImRRfBqMG9uqS/dggC0N/fyEXOvclYuc
 Md2HC2PrTjB2GYRfdJN6/NF9Ga2XRFq+bTch/vqoy81ejWzTHEtDBznOh1WUrAqH8zHR
 wbno3Y5Cl9xdrGyVJ+w8uPkT8BE5LQR4g2NBO2WgmiKfbg1VOXH65EdNQBD8w03yQZXs
 qSCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqvNhYzLlCngy/Ciiy9O7eLB6p/z3UG8mgkMj04EPC8G//bfWU5RgtbS6uOiZmjjqMHzt9gU9N@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRPIl1+x7mga6vKF8LHyBAA9WQMTpqFlvPniTZnJu3nJIflrc0
 keLGcdGlLF/iBs2B9LxfDNDvju85gTIdkKnYzqHmFe7IJ4AcIQDSc4iz
X-Gm-Gg: AZuq6aKbLrDgURIep5YKDdTfAEezuSNEiBnNhUA+Nqa1y/88DnVhmiL+YqCDN3U1g5f
 wsLHbakMtaIfEGKs+Ems6I+/G0Ep4wGCX76r5cRaezLrwh7k8KLm7plogllsNhHextTuIU14sAV
 cGgQBoCmf67tgZ4DQvLcymcI/l1a5t4Ysb1EyNqDwJlYEtHGkzG57H0oVandW3fbjRL2Fxf4Shj
 xbdQ0PGGkCmlU1M4pE/H9Oh+QIVRE4ezVSQNvQSmCWRMg5pMId8O2rkyDge89pe7mjYnb8PuRKC
 Dmkny7Yex+1TxC1mFMO9PePYZuHLCGnPQwInnwosudin3GtJHchutpJuEav+pb+FublgI/DGpNn
 rDnuapHMCznh0ZQG8uSEBwKUsl3NKVuQz70lvCr3QaGH6PI57wlJvPTz6rGvjT4OlGiA9ocLmWO
 hEYtm7Y8X9op7FYc4OkMDTvQy99MNlHPexvoLDZ061UbgVbQKGOLKdHWPPAdCw21sU674etPM=
X-Received: by 2002:a17:906:f5a1:b0:b8a:f5a1:32f0 with SMTP id
 a640c23a62f3a-b8edf4eac8bmr130916166b.3.1770411189198; 
 Fri, 06 Feb 2026 12:53:09 -0800 (PST)
Received: from [192.168.1.239] (87-205-5-123.static.ip.netia.com.pl.
 [87.205.5.123]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8eda748254sm109746166b.5.2026.02.06.12.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 12:52:59 -0800 (PST)
Message-ID: <79264ab170e48e1372b3b847d75f4635dcc57aa6.camel@gmail.com>
Subject: Re: [PATCH v3 16/19] drm/amd/display: Add parameter to control ALLM
 behavior
From: Tomasz =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, alexander.deucher@amd.com, 
 sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, 	airlied@gmail.com, simona@ffwll.ch,
 siqueira@igalia.com, 	dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, 	linux-kernel@vger.kernel.org,
 bernhard.berger@gmail.com, 	michel.daenzer@mailbox.org,
 daniel@fooishbar.org, admin@ptr1337.dev
Date: Fri, 06 Feb 2026 21:52:57 +0100
In-Reply-To: <f19af3c6-f865-4758-8c50-aba40ec1cf68@amd.com>
References: <20260203185626.55428-1-tomasz.pakula.oficjalny@gmail.com>
 <20260203185626.55428-17-tomasz.pakula.oficjalny@gmail.com>
 <f19af3c6-f865-4758-8c50-aba40ec1cf68@amd.com>
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

On Fri, 2026-02-06 at 13:52 -0500, Harry Wentland wrote:
> On 2026-02-03 13:56, Tomasz Paku=C5=82a wrote:
> > [Why]
> > Some users prefer to always manually control ALLM/Gaming mode while
> > others might want it permanently forced on.
> >=20
> > [How]
> > Since there isn't yet an API to control this, expose module parameter
> >=20
> > Changes in v3:
> > - Include a fix for possible NULL pointer dereference by Peter
> >=20
> > Closes: https://github.com/CachyOS/linux-cachyos/issues/680
> >=20
> > Co-developed-by: Peter Jung <admin@ptr1337.dev>
> > Signed-off-by: Peter Jung <admin@ptr1337.dev>
> > Signed-off-by: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 14 +++++-
> >  .../gpu/drm/amd/display/dc/core/dc_resource.c |  7 +--
> >  .../amd/display/modules/inc/mod_info_packet.h |  1 +
> >  .../display/modules/info_packet/info_packet.c | 46 ++++++++++++++++---
> >  5 files changed, 56 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> > index 447e734c362b..312aa32064d5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -268,6 +268,7 @@ extern int amdgpu_rebar;
> > =20
> >  extern int amdgpu_wbrf;
> >  extern int amdgpu_user_queue;
> > +extern uint amdgpu_allm_mode;
> > =20
> >  extern uint amdgpu_hdmi_hpd_debounce_delay_ms;
> > =20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_drv.c
> > index d6d0a6e34c6b..4b038c8bbf9f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -248,6 +248,7 @@ int amdgpu_umsch_mm_fwlog;
> >  int amdgpu_rebar =3D -1; /* auto */
> >  int amdgpu_user_queue =3D -1;
> >  uint amdgpu_hdmi_hpd_debounce_delay_ms;
> > +uint amdgpu_allm_mode =3D 1;
> > =20
> >  DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS=
, 0,
> >  			"DRM_UT_CORE",
> > @@ -1124,7 +1125,7 @@ module_param_named(rebar, amdgpu_rebar, int, 0444=
);
> >  MODULE_PARM_DESC(user_queue, "Enable user queues (-1 =3D auto (default=
), 0 =3D disable, 1 =3D enable, 2 =3D enable UQs and disable KQs)");
> >  module_param_named(user_queue, amdgpu_user_queue, int, 0444);
> > =20
> > -/*
> > +/**
> >   * DOC: hdmi_hpd_debounce_delay_ms (uint)
> >   * HDMI HPD disconnect debounce delay in milliseconds.
> >   *
> > @@ -1134,6 +1135,17 @@ module_param_named(user_queue, amdgpu_user_queue=
, int, 0444);
> >  MODULE_PARM_DESC(hdmi_hpd_debounce_delay_ms, "HDMI HPD disconnect debo=
unce delay in milliseconds (0 to disable (by default), 1500 is common)");
> >  module_param_named(hdmi_hpd_debounce_delay_ms, amdgpu_hdmi_hpd_debounc=
e_delay_ms, uint, 0644);
> > =20
> > +/**
> > + * DOC: allm_mode (int)
> > + * Changes ALLM triggering mode (if sink supports ALLM). Possible valu=
es:
> > + *
> > + * - 0 =3D ALLM disabled
> > + * - 1 =3D ALLM dynamically triggered based on VRR state / Game Conten=
t Type Hint
> > + * - 2 =3D ALLM forced always on
> > + */
> > +MODULE_PARM_DESC(allm_mode, "Changes ALLM trigger mode (0 =3D disable,=
 1 =3D enable (default), 2 =3D force enable)");
> > +module_param_named(allm_mode, amdgpu_allm_mode, uint, 0644);
> > +
> >  /* These devices are not supported by amdgpu.
> >   * They are supported by the mach64, r128, radeon drivers
> >   */
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/driver=
s/gpu/drm/amd/display/dc/core/dc_resource.c
> > index 4a7c9f810e35..b779aac28dfa 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > @@ -44,6 +44,7 @@
> >  #include "clk_mgr.h"
> >  #include "dc_state_priv.h"
> >  #include "dc_stream_priv.h"
> > +#include "modules/inc/mod_info_packet.h"
>=20
> Architecturally DC can't have a dependency on modules.
> Is there a different way we can handle this?
>=20
> Could we do the determination in amdgpu_dm (with help of
> the module) and then set a flag on the stream?
>=20
> Harry

Sure. I don't have any opinion on how it should be done. I think I only
did this like that because I wanted it to be easily changeable at
runtime, but the value of having this RW is next to none.

>=20
> > =20
> >  #include "virtual/virtual_link_hwss.h"
> >  #include "link/hwss/link_hwss_dio.h"
> > @@ -4503,8 +4504,6 @@ static void set_avi_info_frame(
> >  	unsigned int vic =3D pipe_ctx->stream->timing.vic;
> >  	unsigned int rid =3D pipe_ctx->stream->timing.rid;
> >  	unsigned int fr_ind =3D pipe_ctx->stream->timing.fr_index;
> > -	enum dc_timing_3d_format format;
> > -	bool allm;
> > =20
> >  	if (stream->avi_infopacket.valid) {
> >  		*info_packet =3D stream->avi_infopacket;
> > @@ -4658,10 +4657,8 @@ static void set_avi_info_frame(
> >  	///VIC
> >  	if (pipe_ctx->stream->timing.hdmi_vic !=3D 0)
> >  		vic =3D 0;
> > -	format =3D stream->timing.timing_3d_format;
> > -	allm =3D stream->link->local_sink->edid_caps.allm;
> >  	/*todo, add 3DStereo support*/
> > -	if ((format !=3D TIMING_3D_FORMAT_NONE) || allm) {
> > +	if (!is_hdmi_vic_mode(pipe_ctx->stream)) {
> >  		// Based on HDMI specs hdmi vic needs to be converted to cea vic whe=
n 3D is enabled
> >  		switch (pipe_ctx->stream->timing.hdmi_vic) {
> >  		case 1:
> > diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h =
b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
> > index 306eb7355c25..9ec123ecc7c4 100644
> > --- a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
> > +++ b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
> > @@ -41,6 +41,7 @@ void set_vsc_packet_colorimetry_data(
> >  		enum dc_color_space cs,
> >  		enum color_transfer_func tf);
> > =20
> > +bool is_hdmi_vic_mode(const struct dc_stream_state *stream);
> >  void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
> >  		struct dc_info_packet *info_packet,
> >  		enum dc_color_space cs,
> > diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packe=
t.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> > index 53e488fdb4ea..829cce9455db 100644
> > --- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> > +++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> > @@ -23,12 +23,13 @@
> >   *
> >   */
> > =20
> > -#include "mod_info_packet.h"
> > +#include "amdgpu.h"
> >  #include "core_types.h"
> > -#include "dc_types.h"
> > -#include "mod_shared.h"
> > -#include "mod_freesync.h"
> >  #include "dc.h"
> > +#include "dc_types.h"
> > +#include "mod_freesync.h"
> > +#include "mod_info_packet.h"
> > +#include "mod_shared.h"
> > =20
> >  enum vsc_packet_revision {
> >  	vsc_packet_undefined =3D 0,
> > @@ -54,6 +55,12 @@ enum vsc_packet_revision {
> >  #define HF_VSIF_3D_BIT   0
> >  #define HF_VSIF_ALLM_BIT 1
> > =20
> > +enum allm_trigger_mode {
> > +	ALLM_MODE_DISABLED        =3D 0,
> > +	ALLM_MODE_ENABLED_DYNAMIC =3D 1,
> > +	ALLM_MODE_ENABLED_FORCED  =3D 2,
> > +};
> > +
> >  // VTEM Byte Offset
> >  #define VTEM_PB0		0
> >  #define VTEM_PB1		1
> > @@ -499,7 +506,32 @@ void mod_build_vsc_infopacket(const struct dc_stre=
am_state *stream,
> >  	}
> >  }
> > =20
> > -static bool is_hdmi_vic_mode(const struct dc_stream_state *stream)
> > +static bool is_hdmi_allm_mode(const struct dc_stream_state *stream)
> > +{
> > +	/* No local sink */
> > +	if (!stream->link->local_sink)
> > +		return false;
> > +
> > +	/* Sink doesn't expose ALLM support in edid */
> > +	if (!stream->link->local_sink->edid_caps.allm)
> > +		return false;
> > +
> > +	switch (amdgpu_allm_mode) {
> > +	case ALLM_MODE_DISABLED:
> > +		return false;
> > +
> > +	case ALLM_MODE_ENABLED_DYNAMIC:
> > +		break;
> > +
> > +	case ALLM_MODE_ENABLED_FORCED:
> > +		return true;
> > +	}
> > +
> > +	return stream->content_type =3D=3D DISPLAY_CONTENT_TYPE_GAME ||
> > +	       stream->vrr_active_variable;
> > +}
> > +
> > +bool is_hdmi_vic_mode(const struct dc_stream_state *stream)
> >  {
> >  	if (stream->timing.hdmi_vic =3D=3D 0)
> >  		return false;
> > @@ -512,7 +544,7 @@ static bool is_hdmi_vic_mode(const struct dc_stream=
_state *stream)
> >  	if (stream->view_format !=3D VIEW_3D_FORMAT_NONE)
> >  		return false;
> > =20
> > -	if (stream->link->local_sink->edid_caps.allm)
> > +	if (is_hdmi_allm_mode(stream))
> >  		return false;
> > =20
> >  	return true;
> > @@ -541,7 +573,7 @@ void mod_build_hf_vsif_infopacket(const struct dc_s=
tream_state *stream,
> > =20
> >  		info_packet->valid =3D false;
> > =20
> > -		allm =3D stream->link->local_sink->edid_caps.allm;
> > +		allm =3D is_hdmi_allm_mode(stream);
> >  		format =3D stream->view_format =3D=3D VIEW_3D_FORMAT_NONE ?
> >  			 TIMING_3D_FORMAT_NONE :
> >  			 stream->timing.timing_3d_format;
