Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498C4C27C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 16:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E4E710E941;
	Wed, 26 Jun 2024 16:23:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Qko8VvZX";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F14710E941
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 16:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719418985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q7qfR7R4wqV/FoH9GarzUSCtfbCbX7/C78uXUxoeHNc=;
 b=Qko8VvZXu08igAcVTlmuXQadukPqDllZ/3OZW8EC+SGYI8Ii7Ki3l1ItnObnJQXKJJmedr
 qenvRu84hD+0FBHG8zKg9l45ivcgLPBL30l4dRAW2w6CLSVBtdXGP/6iZT/7sRB9ei4hWP
 s5Gkn2DPWwzg0T2cH0tq5cqY+WKcIuI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-kK_SxHXTN9u0XQDHYMToog-1; Wed, 26 Jun 2024 12:23:02 -0400
X-MC-Unique: kK_SxHXTN9u0XQDHYMToog-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6ab80cb23beso99432946d6.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 09:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719418980; x=1720023780;
 h=mime-version:user-agent:content-transfer-encoding:organization
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JuoTJ79gACgiKUQpe7k7Io37YwVqSEgfRMaeyg7Zvos=;
 b=JSldjjit6ozl4AIEPya/Qkhe4oJ5L58ubrNL1JwxCQjsCghgMRbldmAth5xrxQHife
 52SwuKnEaY6ASiPd5RaU+m2R8d8/yx74YJdvwUjD4QyLFYbQRyhGutRon5SU2AmGgOKV
 qSV+26cHLvEFdTioa7jlYRlzxopiBZtpKqF6bAqM0AKkGIEDydaKYvqs4lFSuWJB0AVi
 n2b38MAnqk/fRXa4VcK5/PYkqkMnKCALci1eki+ESQ/rwr5Fem2d9dfizMuNVWiAreo+
 I/S+TkYBoccIFVUbTGP542jBwyjlI8KxqUzE/+ABwYJYrg+LFQGiiD4zmUHSJgSGt66h
 u9HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXfB2LntzU2jqCj4Y93yJ3h9rns0UnSusebYadPvSJ0v//wia23zCl5W+pP2h39yPnMbBwFFNBBilQyV41Qb+QeNf7UptSMlmsHCDmVg==
X-Gm-Message-State: AOJu0YxO5iQ62ivqjJzEDLFw+d8BU4/9zGAISUvH2wCYEoybH3kjT8Q2
 0ZU1NXV9OacOD4jliHbovPDxl6VYCF9ZaDQs2Jg0eW7EMcUZr6wk5+C6U8ke5/bg/JD9ABJN9NX
 d8nnyiaN/qAamPF7G/kKURuRsa9mUvz8wgoRZ8dAobc3mxFWySspJqL5//8kihxg=
X-Received: by 2002:a0c:f64d:0:b0:6b2:a2bb:df2d with SMTP id
 6a1803df08f44-6b58d706835mr1509726d6.48.1719418980500; 
 Wed, 26 Jun 2024 09:23:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEndPS6fn5RzMS1/6Ml0GKhbz5cKUSuQGVRP877/iF2ldPCLzprf0ZZqKl5nq4TqTtPQjLg/g==
X-Received: by 2002:a0c:f64d:0:b0:6b2:a2bb:df2d with SMTP id
 6a1803df08f44-6b58d706835mr1509486d6.48.1719418980212; 
 Wed, 26 Jun 2024 09:23:00 -0700 (PDT)
Received: from chopper.lyude.net ([2600:4040:5c4c:a000::789])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b51ef5c3c1sm55634406d6.120.2024.06.26.09.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 09:22:59 -0700 (PDT)
Message-ID: <61bab346f145a529a61e5366fb39f424512e5a5c.camel@redhat.com>
Subject: Re: [PATCH 1/3] drm/dp_mst: Fix all mstb marked as not probed after
 suspend/resume
From: Lyude Paul <lyude@redhat.com>
To: Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Cc: jani.nikula@intel.com, imre.deak@intel.com, daniel@ffwll.ch, 
 Harry.Wentland@amd.com, jerry.zuo@amd.com, Harry Wentland
 <hwentlan@amd.com>,  stable@vger.kernel.org
Date: Wed, 26 Jun 2024 12:22:58 -0400
In-Reply-To: <20240626084825.878565-2-Wayne.Lin@amd.com>
References: <20240626084825.878565-1-Wayne.Lin@amd.com>
 <20240626084825.878565-2-Wayne.Lin@amd.com>
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

Thanks!

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Wed, 2024-06-26 at 16:48 +0800, Wayne Lin wrote:
> [Why]
> After supend/resume, with topology unchanged, observe that
> link_address_sent of all mstb are marked as false even the topology
> probing
> is done without any error.
>=20
> It is caused by wrongly also include "ret =3D=3D 0" case as a probing
> failure
> case.
>=20
> [How]
> Remove inappropriate checking conditions.
>=20
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: stable@vger.kernel.org
> Fixes: 37dfdc55ffeb ("drm/dp_mst: Cleanup drm_dp_send_link_address()
> a bit")
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> ---
> =C2=A0drivers/gpu/drm/display/drm_dp_mst_topology.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index 7f8e1cfbe19d..68831f4e502a 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -2929,7 +2929,7 @@ static int drm_dp_send_link_address(struct
> drm_dp_mst_topology_mgr *mgr,
> =C2=A0
> =C2=A0=09/* FIXME: Actually do some real error handling here */
> =C2=A0=09ret =3D drm_dp_mst_wait_tx_reply(mstb, txmsg);
> -=09if (ret <=3D 0) {
> +=09if (ret < 0) {
> =C2=A0=09=09drm_err(mgr->dev, "Sending link address failed with
> %d\n", ret);
> =C2=A0=09=09goto out;
> =C2=A0=09}
> @@ -2981,7 +2981,7 @@ static int drm_dp_send_link_address(struct
> drm_dp_mst_topology_mgr *mgr,
> =C2=A0=09mutex_unlock(&mgr->lock);
> =C2=A0
> =C2=A0out:
> -=09if (ret <=3D 0)
> +=09if (ret < 0)
> =C2=A0=09=09mstb->link_address_sent =3D false;
> =C2=A0=09kfree(txmsg);
> =C2=A0=09return ret < 0 ? ret : changed;

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

