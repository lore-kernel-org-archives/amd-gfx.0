Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD0DFCE088
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 13:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC39E10E947;
	Thu, 26 Feb 2026 13:55:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ITf0aIxn";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58CC110E027
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 13:42:21 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-b936373a92fso6738966b.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 05:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772113340; x=1772718140; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding
 :disposition-notification-to:references:in-reply-to:date:cc:to:from
 :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=8Yew8OpH5AIziFpFPDFNxtnqOMKVJfhBoAbJ3Hh32Xo=;
 b=ITf0aIxnsoOZcSKhKss1fpqvM+D1kA4P+TO/K3atLjK1t0/uru0JSUcpXJZvF6hqYZ
 7qMqGS4aZYIJjFE8lkBIUtS0mr/k9lzuHaNV0Uh2D4Ddl5DBtXWPfs2FRSuJblU0Xrfj
 p+wNQ94nbcxzMtM/HBT1rnDVA16tUiYKCmFPugMvKwmvsCAzoDJdJsWvUP+bwib+sXAS
 7hPEg/KDNKh7e4DFbRvQph8eXOQqTO85Qm3U2BLiA/IujiU5CICf7/YeeblXWGpN2oOv
 GLoILj8Yh9ExcSY9QwsNqJ4hrHAk2ox6g2O1WeshSS653smSdShG72oVRCBCkzp3d43E
 l7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772113340; x=1772718140;
 h=mime-version:user-agent:content-transfer-encoding
 :disposition-notification-to:references:in-reply-to:date:cc:to:from
 :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8Yew8OpH5AIziFpFPDFNxtnqOMKVJfhBoAbJ3Hh32Xo=;
 b=p1bCOWKQMIaRpW/7h0TwrTfkU8vv6ateMP3LVaXenkx7riY3bcUWoq+h9Yv16t+vcj
 eX1ConCC5sPjG7KcU/5Pf0V1974Nuki5QtQiXlizKhi3XeqoBgImYagzCWp962AnNI9s
 IuPEMOP06PPatTPGeSgZLMWNYuNWBqai2YxW7oobXUUtHmGxg/fZomr/ChSVPXiSRuI3
 Iqn+Wx1bDG2LiBMG3939FAJqkvDCMGR5GY9x0R1pt3eubkhb+4S3mjxQJO7hTVv+L9Qo
 aKgdWnqka5KifLZ/64ehof5rJ42hHLFkupjIKRCnIxTCGALveNVennC4fN9PXlCFf9R4
 PEKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUssErd4IACjzl3gKjXh7j4dyQCewxfpyTEGsaIEG5gy4AdxudCzVsTNUNLCNWkYr7hLj0MeV0d@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyGzueTlr6uNeYr+2Ma1WzSQnJEFkTHuN0IjDDSWzcnuta5Fveo
 p048jOTocxL5OKROeSHZ2T94ZIzx3cQMulkEJxa9XDg9lJQHLlY6GJRn
X-Gm-Gg: ATEYQzyynARwg9OVQ5iHnvHyI8/BiR7ayzc3FxCZ38u5LG9h9EEWZtARc/x4j+zD8aH
 VxOIGKVvIO8rTDdU94OAs3YfXp1ZYMGvEIz2uLxQs59I+0iMtjYDMQ5bIW0TvfCRfzz1FmDFw71
 yJ1FURTNqO7TQ0vaQJCveMt1Nb8eIK7tVyWuMzVzmDo4CKDmEUEZTRIrjC6KhIQg+gZ90gpMVMU
 lequ73QiGKtQAO1lD2EVfkHRuwsUBBj7AGPUsEttRM0FoSZf6G5OysIXXDK+YGY6N3GLY9gI8aH
 mK6/Pt3xysPp5Kp4lTK9lqQy5lcdzc5DjLaYl3TQbmUUd6eYFgwKEJXugd8R55NmN6RzVKtIf8H
 M9JGB4KyweenDpyMXI9HsIYvNmnZKJLT8Ju7q3Dof3nowKKP7CbQUASEhCwXgmZebpCFIQk5jE/
 ZDbvWFy1TK/nW1OHoAbp9OosUjhZGdKr+RNxQwD0BbMvNCiDGD/Oz9/1XKZns3rt6zWWvF8nis6
 veB0NwkVUs=
X-Received: by 2002:a17:907:9494:b0:b73:99f7:8130 with SMTP id
 a640c23a62f3a-b9081b6dc66mr674893266b.6.1772113339377; 
 Thu, 26 Feb 2026 05:42:19 -0800 (PST)
Received: from [192.168.1.239] (87-205-5-123.static.ip.netia.com.pl.
 [87.205.5.123]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935aeee867sm57475266b.66.2026.02.26.05.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 05:42:18 -0800 (PST)
Message-ID: <ab713383e6651c50902f3f77aae02ab3c276a78b.camel@gmail.com>
Subject: Re: [PATCH v4 07/27] drm/amd/display: Use bigger VRR range if found
 in AMD vsdb
From: Tomasz =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>, alexander.deucher@amd.com, 
 harry.wentland@amd.com, sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, 	airlied@gmail.com, simona@ffwll.ch,
 siqueira@igalia.com, 	dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, 	linux-kernel@vger.kernel.org,
 bernhard.berger@gmail.com, 	michel.daenzer@mailbox.org, daniel@fooishbar.org
Date: Thu, 26 Feb 2026 14:42:15 +0100
In-Reply-To: <7da80c4be3e20c126017646f783b80136bb0700e@intel.com>
References: <20260216164516.36803-1-tomasz.pakula.oficjalny@gmail.com>
 <20260216164516.36803-8-tomasz.pakula.oficjalny@gmail.com>
 <7da80c4be3e20c126017646f783b80136bb0700e@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 26 Feb 2026 13:55:07 +0000
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

On Thu, 2026-02-26 at 14:36 +0200, Jani Nikula wrote:
> On Mon, 16 Feb 2026, Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.co=
m> wrote:
> > [Why]
> > Some monitors only expose their full VRR range in AMD vsdb for some
> > reason.
> >=20
> > [How]
> > Compare exposed ranges and use the bigger one.
> > Only adjust lower limit if it doesn't support LFC
> >=20
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4177
> > Signed-off-by: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>
> > ---
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 31 +++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index b3bf5e0c19a5..f36059bb0324 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -13269,6 +13269,34 @@ static bool copy_range_to_amdgpu_connector(str=
uct drm_connector *conn)
> >  	return is_freesync_capable(range);
> >  }
> > =20
> > +static void extend_range_from_vsdb(struct drm_display_info *display,
> > +				   const struct amdgpu_hdmi_vsdb_info *vsdb)
> > +{
> > +	u16 vrr_min =3D display->monitor_range.min_vfreq;
> > +	u16 vrr_max =3D display->monitor_range.max_vfreq;
> > +
> > +	/* Always extend upper limit */
> > +	if (vsdb->max_refresh_rate_hz > vrr_max)
> > +		vrr_max =3D vsdb->max_refresh_rate_hz;
> > +
> > +	/*
> > +	 * Only extend lower limit if current one disables LFC.
> > +
> > +	 * During widespread testing, we found that some manufacturers probab=
ly
> > +	 * had issues with their monitors' lower VRR boundaries and adjusted
> > +	 * them up (Gigabyte X34GS with official range 48 - 180, AMD vsdb 48 =
-
> > +	 * 180 yet Monitor Ranges 55 - 180). After setting the lower boundary
> > +	 * from AMD vsdb, such monitors start having blanking issues.
> > +	 *
> > +	 * Work around that by not touching VRR min if it still supports LFC.
> > +	 */
> > +	if (vsdb->min_refresh_rate_hz < vrr_min && (vrr_min * 2 >=3D vrr_max)=
)
> > +		vrr_min =3D vsdb->min_refresh_rate_hz;
> > +
> > +	display->monitor_range.min_vfreq =3D vrr_min;
> > +	display->monitor_range.max_vfreq =3D vrr_max;
>=20
> Random driver code should *not* modify struct drm_display_info,
> especially the fields that drm_edid.c parses. Drivers should cease to
> parse EDID and DisplayID altogether.
>=20
> I'm on the verge of NAKing, to the extent that I have control over this,
> any further improvements on driver EDID/DisplayID parsing, with the
> expectation that everything's moved to shared EDID parser in drm_edid.c
> first, and improved there.
>=20
> BR,
> Jani.

I completely agree with you, and I too am saddened by how selective AMD
can be when contributing to open source, BUT I'm just a guy who figured
out some fixes neglected by them. Not being an AMD employee, I don't
have access to their plans or what has been their idea behind modifying
drm_display_info (probably just a lack of understanding, like in my
case).

If maybe I could get OK from Alex or Harry to completely rip out
drm_display_info modifications from amdgpu_dm_update_freesync_caps, then
sure, but currently, I'm not in a position to do so. Still, it seems
like amdgpu already relies purely on it's internal structs from there on
out, so it should be pretty straightforward.

Moreover, moving all DisplayID and CTA extension parsing would be
amazing, BUT AMD vsdb specification isn't public. Here, amdgpu even uses
firmware to parse it, which is bonkers IMO, but they want to keep their
secrets (for some reason). There always will be some VRR meddling in the
drivers based on hardware features, though I do think AMD should release
their whole Freesync vsdb to the public as other drivers could parse
this info as well, because we can already see it's needed to properly
support all monitors.

Hell, even some of my fixes could be moved to general drm code to
facilitate proper VRR range detection.

Going back to the issue at hand, if I could get OK from AMD to rip out
all drm_display_info modifications from amdgpu_dm_update_freesync_caps
then it won't be a problem, but until then, I'm dealing with what I've
been given, doing as little functional, changes as possible. We already
know amdgpu code is... unoptimal, and I wouldn't want to add to that :D

Tomasz

>=20
>=20
> > +}
> > +
> >  /**
> >   * amdgpu_dm_update_freesync_caps - Update Freesync capabilities
> >   *
> > @@ -13339,6 +13367,9 @@ void amdgpu_dm_update_freesync_caps(struct drm_=
connector *connector,
> >  		if (is_monitor_range_invalid(connector))
> >  			monitor_range_from_vsdb(&connector->display_info, &vsdb_info);
> > =20
> > +		/* Try extending range if found in AMD vsdb */
> > +		extend_range_from_vsdb(&connector->display_info, &vsdb_info);
> > +
> >  		if (dpcd_caps.allow_invalid_MSA_timing_param)
> >  			freesync_capable =3D copy_range_to_amdgpu_connector(connector);
