Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7B4C77B73
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 20:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE60110E550;
	Thu, 18 May 2023 20:31:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4974F10E550
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 20:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684441879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P47akq7ZT7Pn5w2xHGuZHnmybcYZqlS0WNbHxIryrp0=;
 b=NzHBzcg7ngS4fjLvcYJoxzl5hIs9p6DtpU6xg5+ZBwuUqswkiThPhEth7qn6IdeibMpJA7
 4IpNHFKpG3DbGonKoTzuss9zGC5s/bGzQL6namdK4mNYnQzHvRG69+I0CDukumfVD7p/SZ
 j0oa2i+teIzHLjOXps16Lttv0FMmK6w=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-DC2KlQVpPtWlyGUK7rhpMg-1; Thu, 18 May 2023 16:31:17 -0400
X-MC-Unique: DC2KlQVpPtWlyGUK7rhpMg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-62391209acdso9270796d6.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 13:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684441877; x=1687033877;
 h=mime-version:user-agent:content-transfer-encoding:organization
 :references:in-reply-to:date:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SGCbI3feKrV5y0C9Vz0t2l4w3d1XI35n5yHGkz/CWCo=;
 b=NRINNmHkkKUfR+RCwG3aXjfzr9t2RGaPdo8JqlRz4lvKpoHPFH+iXXC6VqS8MRiyFQ
 g0elRl3oqNsHA0jGlS5gcxWCA8Ffn0Vl8pmWXFEpqxICNaengQ/GbJuxO+h5r/DfhanX
 k2kFRsB/lNWRcqNYqbecjbEzLQjJBWNpkJA4E0e3feCK+xJT4ljvqnBrE3XqVVTP80FO
 9A+/wG2ZMirtvbzczdya2axoK/d7Sl7Tv7Hb9DmhFssuy2+/baAKzWwsNXJIH5ZjSyNf
 psJGw8SlD3f8OmAzU+HinpeIHGR2wmT4Amn+JBxpD4u12ojsFOzm+DdPoTqRWRmLo7y4
 KuJQ==
X-Gm-Message-State: AC+VfDyr452V1DqntXhToptBca96SNdsIfRbHjaR8J+nBc6/b+/85dph
 MS+b/wQeW0DSMHGgcoKxAhB4ZsrzBleUTm3Odu+Vaaa0RacS+uivi338ClJIhXE+ocdJRmwGdJd
 55LlOxdpj/paxVtt3DIs+oFcNQDZnRQqD4w==
X-Received: by 2002:a05:6214:1ccd:b0:621:1b73:52c9 with SMTP id
 g13-20020a0562141ccd00b006211b7352c9mr319056qvd.10.1684441877275; 
 Thu, 18 May 2023 13:31:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5CES7hnIggC0LE8BJbYOWn5BC2s2m2vLZDwZes1j+6TMDsTt+v6nZcQFBip/qrHexTE3/kCQ==
X-Received: by 2002:a05:6214:1ccd:b0:621:1b73:52c9 with SMTP id
 g13-20020a0562141ccd00b006211b7352c9mr319044qvd.10.1684441876964; 
 Thu, 18 May 2023 13:31:16 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c62:8200::feb? ([2600:4040:5c62:8200::feb])
 by smtp.gmail.com with ESMTPSA id
 m11-20020ad4448b000000b0061b7f6b5e15sm754517qvt.140.2023.05.18.13.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 13:31:16 -0700 (PDT)
Message-ID: <de5a5ca3cba4396e22fc517a84c968608644f215.camel@redhat.com>
Subject: Re: [PATCH] drm/radeon: reintroduce radeon_dp_work_func content
From: Lyude Paul <lyude@redhat.com>
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Date: Thu, 18 May 2023 16:31:16 -0400
In-Reply-To: <20230518164811.1956522-1-alexander.deucher@amd.com>
References: <20230518164811.1956522-1-alexander.deucher@amd.com>
Organization: Red Hat Inc.
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36)
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

Whoops, sorry about that!

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Thu, 2023-05-18 at 12:48 -0400, Alex Deucher wrote:
> Put back the radeon_dp_work_func logic.  It seems that
> handling DP RX interrupts is necessary to make some
> panels work.  This was removed with the MST support,
> but it regresses some systems so add it back.  While
> we are here, add the proper mutex locking.
>=20
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2567
> Fixes: 01ad1d9c2888 ("drm/radeon: Drop legacy MST support")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/radeon/radeon_irq_kms.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/radeon/radeon_irq_kms.c b/drivers/gpu/drm/ra=
deon/radeon_irq_kms.c
> index 3377fbc71f65..c4dda908666c 100644
> --- a/drivers/gpu/drm/radeon/radeon_irq_kms.c
> +++ b/drivers/gpu/drm/radeon/radeon_irq_kms.c
> @@ -99,6 +99,16 @@ static void radeon_hotplug_work_func(struct work_struc=
t *work)
> =20
>  static void radeon_dp_work_func(struct work_struct *work)
>  {
> +=09struct radeon_device *rdev =3D container_of(work, struct radeon_devic=
e,
> +=09=09=09=09=09=09  dp_work);
> +=09struct drm_device *dev =3D rdev->ddev;
> +=09struct drm_mode_config *mode_config =3D &dev->mode_config;
> +=09struct drm_connector *connector;
> +
> +=09mutex_lock(&mode_config->mutex);
> +=09list_for_each_entry(connector, &mode_config->connector_list, head)
> +=09=09radeon_connector_hotplug(connector);
> +=09mutex_unlock(&mode_config->mutex);
>  }
> =20
>  /**

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

