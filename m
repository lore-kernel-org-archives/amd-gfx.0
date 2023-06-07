Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8395C7EE2F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 09:42:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F6A910E4A3;
	Wed,  7 Jun 2023 09:42:20 +0000 (UTC)
Received: from mail-41103.protonmail.ch (mail-41103.protonmail.ch
 [185.70.41.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A72910E4A3
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 09:42:18 +0000 (UTC)
Date: Wed, 07 Jun 2023 09:42:09 +0000
Authentication-Results: mail-41103.protonmail.ch;
 dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr
 header.b="n9FCFcjD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1686130930; x=1686390130;
 bh=x67qiGvM7KF/tVDJArPKY6A/o4dTYbNV/diGB4MoJZc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=n9FCFcjDZ7g+9sUCei3+ZvtWnyt067z3yEXebQyeXqzSWd9hQn6oUMYEHceS93AK0
 1ew03GwyLTCSHBxDcRnOEY+1Xo89r5QSuv0Kvkk/tQlnV88B6WISxlnMNN+kLBIQqk
 GSd/gSVac8Js+4VQ8MAq+02UgUZnAqSU2A4jruYcBj8oe9M/gVe7u2M/etoViDVWc7
 XEmCV+1xRuNsbVkCEVERbwSaVPnoYJP05u6rWsLkCDrYhhQOEM5MakmPSeSemA7Yw/
 ZtDd9xWYvp8IqCD7tv1zPLY71mqUjg75yWk2a8jbUNh7sgAKeJ+fto8p1grEDrvZaj
 qWcRsESgK2BqQ==
To: Harry Wentland <harry.wentland@amd.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v5 06/13] drm/connector: Allow drivers to pass list of
 supported colorspaces
Message-ID: <TKjxspHl8aKZqasklhnRL_RQzlhqrRD35JBIOw2HEBPECtg6OrM4wY6-wF1GStScWVtiur3N76vNTgr2cr1hWgxkVIW_o-WIpiIWN9IvH1s=@emersion.fr>
In-Reply-To: <20230606202607.122914-7-harry.wentland@amd.com>
References: <20230606202607.122914-1-harry.wentland@amd.com>
 <20230606202607.122914-7-harry.wentland@amd.com>
Feedback-ID: 1358184:user:proton
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
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Sebastian Wick <sebastian.wick@redhat.com>, amd-gfx@lists.freedesktop.org,
 Melissa Wen <mwen@igalia.com>, Pekka Paalanen <ppaalanen@gmail.com>,
 Uma Shankar <uma.shankar@intel.com>, dri-devel@lists.freedesktop.org,
 Joshua Ashton <joshua@froggi.es>,
 =?utf-8?Q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Vitaly.Prosyak@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tuesday, June 6th, 2023 at 22:26, Harry Wentland <harry.wentland@amd.com=
> wrote:

> -int drm_mode_create_hdmi_colorspace_property(struct drm_connector *conne=
ctor)
> +int drm_mode_create_hdmi_colorspace_property(struct drm_connector *conne=
ctor,
> +=09=09=09=09=09     u32 supported_colorspaces)
>  {
> -=09return drm_mode_create_colorspace_property(connector, hdmi_colorspace=
s);
> +=09u32 colorspaces =3D supported_colorspaces & hdmi_colorspaces;

This creates a potentially weird situation where the driver passes a
non-0 supported_colorspaces, but the intersection with hdmi_colorspaces
ends up being empty, and all colorspaces end up being advertised.
