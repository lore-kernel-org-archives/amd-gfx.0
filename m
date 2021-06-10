Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B785EC4743D
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 07:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2395961364
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 07:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2395961364
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D77F06E1A7;
	Fri, 11 Jun 2021 07:14:57 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C29416EDC1;
 Thu, 10 Jun 2021 17:12:37 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 3A9A55C00F3;
 Thu, 10 Jun 2021 13:12:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Thu, 10 Jun 2021 13:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm3; bh=k4Xbq0MZeyr/siSHgjGs2zB3Mgm
 ZUFZ9ifle0Pu+Vug=; b=Lg/yHrNSHGkbmMF0w/0DOobwYzU5oRggsJnVdUKbZTh
 ElxLIMEkfq92WPmTfRzkJzu6wwDnWFtP+neuSEXBq7cGBkr49kjsWWqI2e3QFuWj
 IyxmRpHgLftdZpcf67fhhzsg/FnIVIkFs3MJeGhGjujNIXjPBWzDd+L1UAKiRkSI
 8s+f4t6MOld5We1ubHyJTevtZ4Z5YaqzmQGs6fzmugVUE+98/vhDVteeJgWlOkdG
 ok+M6dBIfuckODMnQVLLCMVUjoRhKrws+X5CLzMquWCXEuacm5UuTc/0L+lD77v7
 trJzYTwgyfomXqBlbqqgrGTpfzgV53JQNR9jrrjGFNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=k4Xbq0
 MZeyr/siSHgjGs2zB3MgmZUFZ9ifle0Pu+Vug=; b=DYOpe91EgMWtpXhgkwLvHl
 ND7k1PQngGt3IuNxeCehkj/Ygs1qaHV2toRCp/bAh7b5ncLtnUXvJIcI6n4dHWLI
 9WcRlVzu41ym0Nk8oSlviVe9FBKLo1tu2RE6eW2QF83NbZN/30HXixxCOqgTrZhp
 dLsp5XLJhglsg6h/T4sYbrtUUrYfSi+j6Iugw7EBQfnrI62zvYWBxK1QwS+sTBBb
 0jsoI7dpbvPM14kC/mgQuT/QFGTtjcEs8emJe5tS2lYMKzC8rAAXZJbDf7pYi+vr
 nr05ZC3LM+34r2fM3K7k9OxOcb7SoRUQPfNJeYkcNm4EJ8qEcQB8jRprLOWcGBWA
 ==
X-ME-Sender: <xms:AkjCYJoTH8V2cPpCZR1Q-k5tnHtP-sAzvEijCtEu65NmUZI-yrvzqg>
 <xme:AkjCYLrQxb92_TRQJJRQTziT4YnviWDfos4iVC-VMMFC68ioYV50mX71b8G3Uv-GY
 VjWZoNl8RjgHI3YKJA>
X-ME-Received: <xmr:AkjCYGNTmQ94AKF0e2fQFwLYLehqLP0mciNVH22rKNo1kCT0XNYCmL6v6Z5k9-cabeQxwLpttJ4TBJqgjeOQIgRoEuIb1AbCltvV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedufedguddtkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
 erredttddvnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegt
 vghrnhhordhtvggthheqnecuggftrfgrthhtvghrnhepleekgeehhfdutdeljefgleejff
 ehfffgieejhffgueefhfdtveetgeehieehgedunecuvehluhhsthgvrhfuihiivgeptden
 ucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:AkjCYE7fWmO3JB-WE0lIqyX8L__N-x1eg17_w6c3Cn-tCJLAFpSyew>
 <xmx:AkjCYI7sfK7y0fbZP8wusUmLpeXLxjpsV7OB9UGKNg_k1V-ITPaBBA>
 <xmx:AkjCYMjohj8UvwUrG91bgs0n0cIKyk3tpKDf_c6bz6AgdkjTZEhyKA>
 <xmx:A0jCYCSPe7z1NU9S_aIbMI79DFc4UaQToPAjg2RJho4JxiwPaieaPQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jun 2021 13:12:33 -0400 (EDT)
Date: Thu, 10 Jun 2021 19:12:31 +0200
From: Maxime Ripard <maxime@cerno.tech>
To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v2 1/7] drm/sysfs: introduce
 drm_sysfs_connector_hotplug_event
Message-ID: <20210610171231.ub2peqqotupamqwt@gilmour>
References: <I7ivMNimkOH0GJ5SVonqiNBfYEunXBeQpK7ehs64Bk@cp4-web-028.plabs.ch>
MIME-Version: 1.0
In-Reply-To: <I7ivMNimkOH0GJ5SVonqiNBfYEunXBeQpK7ehs64Bk@cp4-web-028.plabs.ch>
X-Mailman-Approved-At: Fri, 11 Jun 2021 07:14:56 +0000
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
Cc: pekka.paalanen@collabora.com, michel@daenzer.net,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 alexander.deucher@amd.com, intel-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============0936230167=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--===============0936230167==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ufyejact7gc2j5jl"
Content-Disposition: inline


--ufyejact7gc2j5jl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 09, 2021 at 09:23:27PM +0000, Simon Ser wrote:
> This function sends a hotplug uevent with a CONNECTOR property.
>=20
> Signed-off-by: Simon Ser <contact@emersion.fr>
> ---
>  drivers/gpu/drm/drm_sysfs.c | 25 +++++++++++++++++++++++++
>  include/drm/drm_sysfs.h     |  1 +
>  2 files changed, 26 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> index 968a9560b4aa..8423e44c3035 100644
> --- a/drivers/gpu/drm/drm_sysfs.c
> +++ b/drivers/gpu/drm/drm_sysfs.c
> @@ -343,6 +343,31 @@ void drm_sysfs_hotplug_event(struct drm_device *dev)
>  }
>  EXPORT_SYMBOL(drm_sysfs_hotplug_event);
> =20
> +/**
> + * drm_sysfs_connector_hotplug_event - generate a DRM uevent for any con=
nector
> + * change
> + * @connector: connector which has changed
> + *
> + * Send a uevent for the DRM connector specified by @connector. This wil=
l send
> + * a uevent with the properties HOTPLUG=3D1 and CONNECTOR.
> + */
> +void drm_sysfs_connector_hotplug_event(struct drm_connector *connector)
> +{
> +	struct drm_device *dev =3D connector->dev;
> +	char hotplug_str[] =3D "HOTPLUG=3D1", conn_id[21];
> +	char *envp[] =3D { hotplug_str, conn_id, NULL };
> +
> +	snprintf(conn_id, sizeof(conn_id),
> +		 "CONNECTOR=3D%u", connector->base.id);
> +
> +	drm_dbg_kms(connector->dev,
> +		    "[CONNECTOR:%d:%s] generating connector hotplug event\n",
> +		    connector->base.id, connector->name);
> +
> +	kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
> +}
> +EXPORT_SYMBOL(drm_sysfs_connector_hotplug_event);

Would it make sense to call sysfs_notify on the status file?

It would allow to call poll() on the status file in sysfs and skipping
udev in simple cases?

Maxime

--ufyejact7gc2j5jl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYMJH/gAKCRDj7w1vZxhR
xUtrAQDFUIur00mMdrxIVN6MOu4KsThQEweTCubJAJtwubTVLQEA4fPruqoGYmCk
yXhHF9nNWYOcSspUTdZl4LnNgqK9EQM=
=Gl6o
-----END PGP SIGNATURE-----

--ufyejact7gc2j5jl--

--===============0936230167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0936230167==--
