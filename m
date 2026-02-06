Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB326E78D40
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 08:41:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2995410E34C;
	Mon,  9 Feb 2026 08:41:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bNv5w/YY";
	dkim-atps=neutral
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 466C310E8FE
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 20:46:19 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-655b5094119so297398a12.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Feb 2026 12:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770410778; x=1771015578; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding
 :disposition-notification-to:references:in-reply-to:date:cc:to:from
 :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=x7vh3XFihkkC65Prx180SJ9Wn1uFrfJPS1GI8hrWqyQ=;
 b=bNv5w/YY+WI7xXWKj6AZCoUmKIdkbW9BDflwLyPlyclE0eGoVz3KMkp+8F89OnqGhw
 L6yfOTWR8/dKkN9v6OacYxQ7sVVpEdNWv1wLoYwGsXucz5X83AURDB2d8hY03pPm6Ma6
 1XDpFL7kX3kKifgjBSkt2tedcOtgIJ/xqgVf/PcKhCYJlmVk/0wrh7AN5g7a7Cw8ql86
 0CvZxBobKNqbV+MGj8QV3zNquRvRm6DWKlNOThLhGdHmygjOGvjOfJjVVBppp3ke5NK2
 yryGdoWpInaqA15HDw/9st5BDzLf4R2/Q6mnbJyTsJvWKAVC/8Wtt2B/lyc5QOgVupQl
 kpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770410778; x=1771015578;
 h=mime-version:user-agent:content-transfer-encoding
 :disposition-notification-to:references:in-reply-to:date:cc:to:from
 :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=x7vh3XFihkkC65Prx180SJ9Wn1uFrfJPS1GI8hrWqyQ=;
 b=m/M+fIH+3IT8wXQ3rd5wk4pjFHYgsltoYpW9PrRvV5Ct85e5RZbNxIk+/4TS+++L4X
 QS0gTqLMbVUydfzMQkinlcK9/ovniHYylWjoSYJtKSsZiD/C8ErClw1kiW7HHLvJID/w
 3jhLIRsOhhGkzax4mEge6ptK/3nCFqngOc5a+42GYidO7w+xoRQ33uD1qBILp/r8oFxS
 MfHDRANbMQ5/JnUJz2eD74Jznkyw4dqmIQVLYB6lDCYfLzRyG3FQVii6x7NWa+I6Ors+
 QVh9TnSdSyb4frFUU8B9J2ZbraXYWc33Gqixr35VPXpfEBWRf/IfGKECoK+lPHopWTS9
 9B4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9Ubvf9e+BTBceD1MCjQJ/Fp0zRDSJNbjaNAmn3D9kL9VZhD0E587px1C2uG6wFmQhe9jWo7Eg@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFDv8+yB/eU7/hv/pFpeeeQVSAwdRYZ+6BCFEnk8+ijLdmLTHV
 ErT/S5rxZiSLzG55yPIG9z/P1T2mTl7lFfsamQK+yVg+prIxrTuFaI6t
X-Gm-Gg: AZuq6aL5KfDs38QYJXyqCgAh5+KhhA2UWAk0HzrGmbG5ATXK8UhCXk+ynA1bhb60/iJ
 0qUPp2D91W0m/il2HuQ22b0+uLQo7GdhJ3dJSkmoTeDXaT2I2VHzqyCJsyk8dgclV8uZPbVMf/v
 tgCLyGAYp1qvf3F9j8A/fplrrNqurcsjAMafByll/91+ThQnF2FQBNrN5j/TK4jUVrdlFJmnRn1
 RItjsY1am46cajg6ZXpn/NwGLINPE3nGj5/grUxvMSrnvokEzD55MA1clTfqRBxalQ/Ck3HJUQG
 42l0QJKIiLRnUulEmWdxjEvNpZKIBMcf1JpfHpXJSBKwmzVCEF+7LAUi7g8wnkiDZkR+fzWUN4T
 AjwlQ3FOXO2Y5eTHy4FRN8lF3RI5YidO+VYpl9bgITUJQ2oWV5ljgd5FmIMgZzKNADvSqqu88Tr
 U8tED4ZbEqhXKYB7GOrybEfDoAZHsN7ND/H9trnAI0MidMJXtBmddBqYuo894jCVqMdx8fB+o=
X-Received: by 2002:a05:6402:4405:b0:659:3d99:4bee with SMTP id
 4fb4d7f45d1cf-65984164977mr1287822a12.3.1770410777480; 
 Fri, 06 Feb 2026 12:46:17 -0800 (PST)
Received: from [192.168.1.239] (87-205-5-123.static.ip.netia.com.pl.
 [87.205.5.123]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-659840199f9sm894800a12.23.2026.02.06.12.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 12:46:16 -0800 (PST)
Message-ID: <1272fea64aa41a4c73a26fd0a51309a9acc03a8f.camel@gmail.com>
Subject: Re: [PATCH v3 02/19] drm/amd/display: Refactor
 amdgpu_dm_update_freesync_caps()
From: Tomasz =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, alexander.deucher@amd.com, 
 sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, 	airlied@gmail.com, simona@ffwll.ch,
 siqueira@igalia.com, 	dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, 	linux-kernel@vger.kernel.org,
 bernhard.berger@gmail.com, 	michel.daenzer@mailbox.org,
 daniel@fooishbar.org, admin@ptr1337.dev
Date: Fri, 06 Feb 2026 21:46:14 +0100
In-Reply-To: <0d0cd4fb-0bce-4c11-bc70-2e232993ee73@amd.com>
References: <20260203185626.55428-1-tomasz.pakula.oficjalny@gmail.com>
 <20260203185626.55428-3-tomasz.pakula.oficjalny@gmail.com>
 <0d0cd4fb-0bce-4c11-bc70-2e232993ee73@amd.com>
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

On Fri, 2026-02-06 at 13:22 -0500, Harry Wentland wrote:
>=20
> On 2026-02-03 13:56, Tomasz Paku=C5=82a wrote:
> > [Why]
> > This function started to get very messy and hard to follow.
> >=20
> > [How]
> > Eject some functionality to separate functions and simplify greatly.
> >=20
> > Changes in v3:
> > - Less struct traversal in helper functions
> >=20
> > Signed-off-by: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>
> > ---
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 123 +++++++++++-------
> >  1 file changed, 73 insertions(+), 50 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 29e4a047b455..2c5877ed5f32 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -13119,8 +13119,8 @@ static void parse_edid_displayid_vrr(struct drm=
_connector *connector,
> >  	}
> >  }
> > =20
> > -static int parse_amd_vsdb(struct amdgpu_dm_connector *aconnector,
> > -			  const struct edid *edid, struct amdgpu_hdmi_vsdb_info *vsdb_info)
> > +static int parse_amd_vsdb_did(struct amdgpu_dm_connector *aconnector,
> > +			      const struct edid *edid, struct amdgpu_hdmi_vsdb_info *vsdb_i=
nfo)
> >  {
> >  	u8 *edid_ext =3D NULL;
> >  	int i;
> > @@ -13172,13 +13172,13 @@ static int parse_amd_vsdb(struct amdgpu_dm_co=
nnector *aconnector,
> >  	return false;
> >  }
> > =20
> > -static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
> > -			       const struct edid *edid,
> > -			       struct amdgpu_hdmi_vsdb_info *vsdb_info)
> > +static int parse_amd_vsdb_cea(struct amdgpu_dm_connector *aconnector,
> > +			      const struct edid *edid,
> > +			      struct amdgpu_hdmi_vsdb_info *vsdb_info)
> >  {
> > +	struct amdgpu_hdmi_vsdb_info vsdb_local =3D {0};
> >  	u8 *edid_ext =3D NULL;
> >  	int i;
> > -	bool valid_vsdb_found =3D false;
> > =20
> >  	/*----- drm_find_cea_extension() -----*/
> >  	/* No EDID or EDID extensions */
> > @@ -13199,9 +13199,47 @@ static int parse_hdmi_amd_vsdb(struct amdgpu_d=
m_connector *aconnector,
> >  	if (edid_ext[0] !=3D CEA_EXT)
> >  		return -ENODEV;
> > =20
> > -	valid_vsdb_found =3D parse_edid_cea(aconnector, edid_ext, EDID_LENGTH=
, vsdb_info);
> > +	if (!parse_edid_cea(aconnector, edid_ext, EDID_LENGTH, &vsdb_local))
> > +		return -ENODEV;
> > =20
> > -	return valid_vsdb_found ? i : -ENODEV;
> > +	*vsdb_info =3D vsdb_local;
> > +	return i;
> > +}
> > +
> > +static bool is_monitor_range_invalid(const struct drm_connector *conn)
> > +{
> > +	return conn->display_info.monitor_range.min_vfreq =3D=3D 0 ||
> > +	       conn->display_info.monitor_range.max_vfreq =3D=3D 0;
> > +}
> > +
> > +/*
> > + * Returns true if (max_vfreq - min_vfreq) > 10
> > + */
> > +static bool is_freesync_capable(const struct drm_monitor_range_info *r=
ange)
> > +{
> > +	return (range->max_vfreq - range->min_vfreq) > 10;
> > +}
> > +
> > +static void monitor_range_from_vsdb(struct drm_display_info *display,
> > +				    const struct amdgpu_hdmi_vsdb_info *vsdb)
> > +{
> > +	display->monitor_range.min_vfreq =3D vsdb->min_refresh_rate_hz;
> > +	display->monitor_range.max_vfreq =3D vsdb->max_refresh_rate_hz;
> > +}
> > +
> > +/*
> > + * Returns true if connector is capable of freesync
> > + * Optionally, can fetch the range from AMD vsdb
> > + */
> > +static bool copy_range_to_amdgpu_connector(struct drm_connector *conn)
> > +{
> > +	struct amdgpu_dm_connector *aconn =3D to_amdgpu_dm_connector(conn);
> > +	struct drm_monitor_range_info *range =3D &conn->display_info.monitor_=
range;
> > +
> > +	aconn->min_vfreq =3D range->min_vfreq;
> > +	aconn->max_vfreq =3D range->max_vfreq;
> > +
> > +	return is_freesync_capable(range);
> >  }
> > =20
> >  /**
> > @@ -13218,13 +13256,14 @@ static int parse_hdmi_amd_vsdb(struct amdgpu_=
dm_connector *aconnector,
> >  void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
> >  				    const struct drm_edid *drm_edid)
> >  {
> > -	int i =3D 0;
> >  	struct amdgpu_dm_connector *amdgpu_dm_connector =3D
> >  			to_amdgpu_dm_connector(connector);
> >  	struct dm_connector_state *dm_con_state =3D NULL;
> >  	struct dc_sink *sink;
> >  	struct amdgpu_device *adev =3D drm_to_adev(connector->dev);
> >  	struct amdgpu_hdmi_vsdb_info vsdb_info =3D {0};
> > +	struct amdgpu_hdmi_vsdb_info vsdb_did =3D {0};
> > +	struct dpcd_caps dpcd_caps =3D {0};
> >  	const struct edid *edid;
> >  	bool freesync_capable =3D false;
> >  	enum adaptive_sync_type as_type =3D ADAPTIVE_SYNC_TYPE_NONE;
> > @@ -13256,62 +13295,46 @@ void amdgpu_dm_update_freesync_caps(struct dr=
m_connector *connector,
> >  		goto update;
> > =20
> >  	edid =3D drm_edid_raw(drm_edid); // FIXME: Get rid of drm_edid_raw()
> > +	parse_amd_vsdb_cea(amdgpu_dm_connector, edid, &vsdb_info);
>=20
> This change says it's a refactor, which in my book should
> never include a (subtle) functional change. But we're now
> calling this function for all sink_signal types, whereas
> before it was only called for HDMI_TYPE_A.

Got it. I'll explain it better in the next version. I think the edid
check was there only to guard against parsing it in parse_amd_vsdb(). I
must say the code there was not the clearest but I can't think of a
reason to check for edid in case of DP. If it's missing, the
display_info won't have a valid range.

The parsing functions check for edid as well so this check is actually
redundant and could be entirely removed. vsdb structs are initialized to
0 either way so nothing will break and nothing will get enabled by
mistake.

Quite honestly, looking at (before changes) parse_edid_displayid_vrr(),
parse_amd_vsdb(), parse_hdmi_amd_vsdb() there's quite a bit of code
duplication and especially the former two are almost the same.

> > +
> > +	if (amdgpu_dm_connector->dc_link)
> > +		dpcd_caps =3D amdgpu_dm_connector->dc_link->dpcd_caps;
> > =20
> >  	/* Some eDP panels only have the refresh rate range info in DisplayID=
 */
> > -	if ((connector->display_info.monitor_range.min_vfreq =3D=3D 0 ||
> > -	     connector->display_info.monitor_range.max_vfreq =3D=3D 0))
> > +	if (is_monitor_range_invalid(connector))
> >  		parse_edid_displayid_vrr(connector, edid);
> > =20
> > -	if (edid && (sink->sink_signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT ||
> > -		     sink->sink_signal =3D=3D SIGNAL_TYPE_EDP)) {
> > -		if (amdgpu_dm_connector->dc_link &&
> > -		    amdgpu_dm_connector->dc_link->dpcd_caps.allow_invalid_MSA_timing=
_param) {
> > -			amdgpu_dm_connector->min_vfreq =3D connector->display_info.monitor_=
range.min_vfreq;
> > -			amdgpu_dm_connector->max_vfreq =3D connector->display_info.monitor_=
range.max_vfreq;
> > -			if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq=
 > 10)
> > -				freesync_capable =3D true;
> > -		}
> > +	if (sink->sink_signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT ||
> > +	    sink->sink_signal =3D=3D SIGNAL_TYPE_EDP) {
> > =20
> > -		parse_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
> > +		if (dpcd_caps.allow_invalid_MSA_timing_param)
> > +			freesync_capable =3D copy_range_to_amdgpu_connector(connector);
> > =20
> > -		if (vsdb_info.replay_mode) {
> > -			amdgpu_dm_connector->vsdb_info.replay_mode =3D vsdb_info.replay_mod=
e;
> > -			amdgpu_dm_connector->vsdb_info.amd_vsdb_version =3D vsdb_info.amd_v=
sdb_version;
> > +		/* eDP */
> > +		if (edid)
>=20
> Same here, I'm not entirely sure whether moving the edid
> check down here won't have a subtle behavior change.
>=20
> I'd like to be either convinced that these things cannot
> change behavior, or I'd like to see this broken out into
> two patches, (1) a true refactor patch, without possible
> behavior changes, and (2) another patch that might affect
> behavior.

Will do. Now that I'm looking at this with a clear head, it's too much
in one go even for me :) I think this will end up as 3-4 patches to
clean up the vsdb parsing functions as well.

>=20
> Overall I'm in favor of the changes and thank you for
> cleaning this up. I'm just worried about subtle bugs.
>=20
> Harry
>=20
> > +			parse_amd_vsdb_did(amdgpu_dm_connector, edid, &vsdb_did);
> > +
> > +		if (vsdb_did.replay_mode) {
> > +			amdgpu_dm_connector->vsdb_info.replay_mode =3D vsdb_did.replay_mode=
;
> > +			amdgpu_dm_connector->vsdb_info.amd_vsdb_version =3D vsdb_did.amd_vs=
db_version;
> >  			amdgpu_dm_connector->as_type =3D ADAPTIVE_SYNC_TYPE_EDP;
> >  		}
> > =20
> > -	} else if (drm_edid && sink->sink_signal =3D=3D SIGNAL_TYPE_HDMI_TYPE=
_A) {
> > -		i =3D parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
> > -		if (i >=3D 0 && vsdb_info.freesync_supported) {
> > -			amdgpu_dm_connector->min_vfreq =3D vsdb_info.min_refresh_rate_hz;
> > -			amdgpu_dm_connector->max_vfreq =3D vsdb_info.max_refresh_rate_hz;
> > -			if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq=
 > 10)
> > -				freesync_capable =3D true;
> > -
> > -			connector->display_info.monitor_range.min_vfreq =3D vsdb_info.min_r=
efresh_rate_hz;
> > -			connector->display_info.monitor_range.max_vfreq =3D vsdb_info.max_r=
efresh_rate_hz;
> > -		}
> > +	} else if (sink->sink_signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A && vsdb_i=
nfo.freesync_supported) {
> > +		monitor_range_from_vsdb(&connector->display_info, &vsdb_info);
> > +		freesync_capable =3D copy_range_to_amdgpu_connector(connector);
> >  	}
> > =20
> >  	if (amdgpu_dm_connector->dc_link)
> >  		as_type =3D dm_get_adaptive_sync_support_type(amdgpu_dm_connector->d=
c_link);
> > =20
> > -	if (as_type =3D=3D FREESYNC_TYPE_PCON_IN_WHITELIST) {
> > -		i =3D parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
> > -		if (i >=3D 0 && vsdb_info.freesync_supported && vsdb_info.amd_vsdb_v=
ersion > 0) {
> > +	if (as_type =3D=3D FREESYNC_TYPE_PCON_IN_WHITELIST && vsdb_info.frees=
ync_supported) {
> > +		amdgpu_dm_connector->pack_sdp_v1_3 =3D true;
> > +		amdgpu_dm_connector->as_type =3D as_type;
> > +		amdgpu_dm_connector->vsdb_info =3D vsdb_info;
> > =20
> > -			amdgpu_dm_connector->pack_sdp_v1_3 =3D true;
> > -			amdgpu_dm_connector->as_type =3D as_type;
> > -			amdgpu_dm_connector->vsdb_info =3D vsdb_info;
> > -
> > -			amdgpu_dm_connector->min_vfreq =3D vsdb_info.min_refresh_rate_hz;
> > -			amdgpu_dm_connector->max_vfreq =3D vsdb_info.max_refresh_rate_hz;
> > -			if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq=
 > 10)
> > -				freesync_capable =3D true;
> > -
> > -			connector->display_info.monitor_range.min_vfreq =3D vsdb_info.min_r=
efresh_rate_hz;
> > -			connector->display_info.monitor_range.max_vfreq =3D vsdb_info.max_r=
efresh_rate_hz;
> > -		}
> > +		monitor_range_from_vsdb(&connector->display_info, &vsdb_info);
> > +		freesync_capable =3D copy_range_to_amdgpu_connector(connector);
> >  	}
> > =20
> >  update:
>=20
