Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9817C27C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 16:20:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFF0110E967;
	Wed, 26 Jun 2024 16:20:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="B1ZEeTEm";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17B2C10E952
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 16:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719418834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q9PywJRmVRO51IecRdCJVp7jzEo8Dz719xyLPPSvHBI=;
 b=B1ZEeTEmu6Z2bzy+PRK+8tDnyixwWt7jvzQNxJqFnFMTmVZaHRQeqEPTgR2+DE6cKjgs2U
 Knbele4x2+hiRlBjocISWxvnbawocA4JymC/Wmi0M/XsJ1nsYLqkG7F3IlqUWGfNDC0bGo
 y53Rwj6fuy2j5PCX05wyoFTXxfrLnjI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-QQ6A-oFgMxqiMQk2HjG33Q-1; Wed, 26 Jun 2024 12:20:33 -0400
X-MC-Unique: QQ6A-oFgMxqiMQk2HjG33Q-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-440647edfeaso109262261cf.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 09:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719418832; x=1720023632;
 h=mime-version:user-agent:content-transfer-encoding:organization
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CyeK3GRLaHegaYbR5xPpklmA5OzN7TqqvirmtcOmEwo=;
 b=otiLdTYEMp4nYfcxcHuDr7fvzNfAnTZfR5H/aCzOwWEgKb+QoPZ61MLpdZWU1mpcDc
 AAeeFLkKpJ6EbANihMK19QDKCuFSJoF4d57InZxhfkGjax9jynXkoVpAKvwm92v9daTz
 Le4u4TUfjN8ud4pc6delBt3oowwcvLf11HMghXaiLTwSYnuxb+KZdYy3ll4pU/pMZGmI
 3F4f5EJb73cTcZcqY2e294as7OXz1Hvj/fpVl60eL3qA1UvfTmQG12Avtoe1r4izAz2Y
 //66xKsm3sZ4kBZBcLN/4I/jM0tp7/aE7ci/VKPZoTt81FQpmecsgLeAqnqLWmG8L8ik
 ckvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZafOqMDlDhTWccF01Q/AB1lZ7ILxpm3Ck9uUcfqEyIduXc5nArcdXJjIu+kjdkLB1+kU49ddtT8pJ3LOybRok803frM7Yt5Ozcaiu9w==
X-Gm-Message-State: AOJu0Yy2yXX4fY74leHJe26KzaM1+WP068SZHFL4aHJNHRM9wes5Fwn1
 tIzLxqMeI9kDkzk7JtlZ2SjfRzE7O9rOjt3oI5jZwEg+KbZCEv2PTYC/AquqGCeBjZvFDn+awTe
 KPpTUAgov9v3EnevdXbP4mg1lyQR6O3j4Ku/QLgHOO88/e3BoKnkpBSEfAlMRXKE=
X-Received: by 2002:a05:622a:1650:b0:43a:f8d3:f4c4 with SMTP id
 d75a77b69052e-444d91a95ebmr127274561cf.21.1719418832503; 
 Wed, 26 Jun 2024 09:20:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl/6pjwXh3eYxhUg1LhHOVVuXrCojU6GizTbxNkS/2KKtWyqteg6noR/crxypzcYyciERgnQ==
X-Received: by 2002:a05:622a:1650:b0:43a:f8d3:f4c4 with SMTP id
 d75a77b69052e-444d91a95ebmr127274311cf.21.1719418832193; 
 Wed, 26 Jun 2024 09:20:32 -0700 (PDT)
Received: from chopper.lyude.net ([2600:4040:5c4c:a000::789])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44504b1b0f7sm11151541cf.19.2024.06.26.09.20.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 09:20:31 -0700 (PDT)
Message-ID: <7da3ccf156a858c1a7d2691fbedfa7aa2ceccdf7.camel@redhat.com>
Subject: Re: [PATCH 2/3] drm/dp_mst: Skip CSN if topology probing is not
 done yet
From: Lyude Paul <lyude@redhat.com>
To: Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Cc: jani.nikula@intel.com, imre.deak@intel.com, daniel@ffwll.ch, 
 Harry.Wentland@amd.com, jerry.zuo@amd.com, Harry Wentland
 <hwentlan@amd.com>,  stable@vger.kernel.org
Date: Wed, 26 Jun 2024 12:20:30 -0400
In-Reply-To: <20240626084825.878565-3-Wayne.Lin@amd.com>
References: <20240626084825.878565-1-Wayne.Lin@amd.com>
 <20240626084825.878565-3-Wayne.Lin@amd.com>
Organization: Red Hat Inc.
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

Some comments down below:

On Wed, 2024-06-26 at 16:48 +0800, Wayne Lin wrote:
> [Why]
> During resume, observe that we receive CSN event before we start
> topology
> probing. Handling CSN at this moment based on uncertain topology is
> unnecessary.
>=20
> [How]
> Add checking condition in drm_dp_mst_handle_up_req() to skip handling
> CSN
> if the topology is yet to be probed.
>=20
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: stable@vger.kernel.org
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> ---
> =C2=A0drivers/gpu/drm/display/drm_dp_mst_topology.c | 11 +++++++++++
> =C2=A01 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index 68831f4e502a..fc2ceae61db2 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -4069,6 +4069,7 @@ static int drm_dp_mst_handle_up_req(struct
> drm_dp_mst_topology_mgr *mgr)
> =C2=A0=09if (up_req->msg.req_type =3D=3D DP_CONNECTION_STATUS_NOTIFY) {
> =C2=A0=09=09const struct drm_dp_connection_status_notify
> *conn_stat =3D
> =C2=A0=09=09=09&up_req->msg.u.conn_stat;
> +=09=09bool handle_csn;
> =C2=A0
> =C2=A0=09=09drm_dbg_kms(mgr->dev, "Got CSN: pn: %d ldps:%d ddps:
> %d mcs: %d ip: %d pdt: %d\n",
> =C2=A0=09=09=09=C2=A0=C2=A0=C2=A0 conn_stat->port_number,
> @@ -4077,6 +4078,16 @@ static int drm_dp_mst_handle_up_req(struct
> drm_dp_mst_topology_mgr *mgr)
> =C2=A0=09=09=09=C2=A0=C2=A0=C2=A0 conn_stat->message_capability_status,
> =C2=A0=09=09=09=C2=A0=C2=A0=C2=A0 conn_stat->input_port,
> =C2=A0=09=09=09=C2=A0=C2=A0=C2=A0 conn_stat->peer_device_type);
> +
> +=09=09mutex_lock(&mgr->probe_lock);
> +=09=09handle_csn =3D mgr->mst_primary->link_address_sent;
> +=09=09mutex_unlock(&mgr->probe_lock);
> +
> +=09=09if (!handle_csn) {
> +=09=09=09drm_dbg_kms(mgr->dev, "Got CSN before finish
> topology probing. Skip it.");
> +=09=09=09kfree(up_req);
> +=09=09=09goto out;
> +=09=09}

Hm. I think you're definitely on the right track here with not handling
CSNs immediately after resume. My one question though is whether
dropping the event entirely here is a good idea? In theory, we could
receive a CSN at any time during the probe - including receiving a CSN
for a connector that we've already probed in the initial post-resume
process, which could result in us missing CSNs coming out of resume and
still having an outdated topology layout.

I'm not totally sure about the solution I'm going to suggest but it
seems like it would certainly be worth trying: what if we added a flag
to drm_dp_mst_topology_mgr called something like "csn_during_resume"
and simply set it to true in response to getting a CSN before we've
finished reprobing? Then we at the end of the reprobe, we can simply
restart the reprobing process if csn_during_resume gets set - which
should still ensure we're up to date with reality.

> =C2=A0=09} else if (up_req->msg.req_type =3D=3D
> DP_RESOURCE_STATUS_NOTIFY) {
> =C2=A0=09=09const struct drm_dp_resource_status_notify *res_stat
> =3D
> =C2=A0=09=09=09&up_req->msg.u.resource_stat;

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

