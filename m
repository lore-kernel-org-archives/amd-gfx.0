Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B55EC3600C
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Mar 2025 14:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EFD010E247;
	Sat, 29 Mar 2025 14:33:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="Ewx0gEgz";
	dkim-atps=neutral
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCBEB10E250
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Mar 2025 14:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1743258814; x=1743518014;
 bh=xDKh0SEYG2UAlozeNWGpbQBdJE/U5hxRytnarzkniLw=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=Ewx0gEgzTm/4skymrdCnUxvrMGoEmzhj9CRwDsgeBRDXFbFGBTC7iUgaY3iNq3Qec
 S/ek6UbYSoKT7b8vChXzeAYM8jIqvprVtTAGjAOg4xDaOL/bBQbeW4XsMb5FMyzhYl
 87kPpauFtR39a9a4BIABETmxLUcZ3VMZcEd87s7zdkBYADGiFhPqYyViuC7QpHRlVy
 xLAmXxOqboXMO49YdoFRch1F0qhvQcBoDvi4gB9YMjs06tYhD2ElhnFAV/v7VmdS3w
 b0lq0pj43oCV55ErVNL7rfMFl/BxCMiBKzWxsudlPUjD7ObHcmazy/7FJNtpSL7Bgx
 r2KCPxXQ8xanQ==
Date: Sat, 29 Mar 2025 14:33:27 +0000
To: Alex Hung <alex.hung@amd.com>
From: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 wayland-devel@lists.freedesktop.org, harry.wentland@amd.com, leo.liu@amd.com,
 ville.syrjala@linux.intel.com, pekka.paalanen@collabora.com, mwen@igalia.com,
 jadahl@redhat.com, sebastian.wick@redhat.com, shashank.sharma@amd.com,
 agoins@nvidia.com, joshua@froggi.es, mdaenzer@redhat.com, aleixpol@kde.org,
 xaver.hugl@gmail.com, victoria@system76.com, daniel@ffwll.ch,
 uma.shankar@intel.com, quic_naseer@quicinc.com, quic_cbraga@quicinc.com,
 quic_abhinavk@quicinc.com, marcan@marcan.st, Liviu.Dudau@arm.com,
 sashamcintosh@google.com, chaitanya.kumar.borah@intel.com,
 louis.chauvet@bootlin.com
Subject: Re: [PATCH V8 10/43] drm/plane: Add COLOR PIPELINE property
Message-ID: <5xGNnbC-7q5cgvaDZS7MUb2jT1VizZ1zjr2eGKwLwwfP9RbSCtzszBDBRsEC8-eRLXSPMbTWLfWkzkaEGw7TqzJDi_eYM2uWoyu_vKaGSOc=@emersion.fr>
In-Reply-To: <20250326234748.2982010-11-alex.hung@amd.com>
References: <20250326234748.2982010-1-alex.hung@amd.com>
 <20250326234748.2982010-11-alex.hung@amd.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: c30abc44cc5700c2516214c6859b7254d65ed0a0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Two nits below, regardless:

Reviewed-by: Simon Ser <contact@emersion.fr>

> +=09} else if (property =3D=3D plane->color_pipeline_property) {
> +=09=09/* find DRM colorop object */
> +=09=09struct drm_colorop *colorop =3D NULL;
> +
> +=09=09colorop =3D drm_colorop_find(dev, file_priv, val);
> +
> +=09=09if (val && !colorop)
> +=09=09=09return -EACCES;
> +
> +=09=09/* set it on drm_plane_state */
> +=09=09drm_atomic_set_colorop_for_plane(state, colorop);

Nit: I don't think these comments are especially useful, the names of the
functions are clear enough.

> +int drm_plane_create_color_pipeline_property(struct drm_plane *plane,
> +=09=09=09=09=09     const struct drm_prop_enum_list *pipelines,
> +=09=09=09=09=09     const int num_pipelines)

Nit: in general we don't mark non-pointer arguments as const: the function
cannot mutate the caller's value anyways.
