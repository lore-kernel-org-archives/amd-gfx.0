Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AD2C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 21:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7BD110F2DC;
	Wed,  8 Jul 2026 21:57:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Q7TCknvg";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB77A10F2DC
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 21:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783547857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=btjBlfn1gEh32xkLC16toOwaofpK3E2AbdoJxAP/F/4=;
 b=Q7TCknvg4uMWaH6juK6bQB2DUTn0TpXVzhpknxxlQewCKHF9Ctu+/GkDAZ0p0GqC5wPCP0
 iUzaSvakYU7TFCsw+o0YjQNhYtjn2uQLBb2Yc3rARg7CmCOaejo4ww7edWbzM/m4Gvc1HS
 C87+HRDMDjKksEG5wK372r0xo1hIpdA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-NEZjgN3-N4WIjja29oVcnw-1; Wed, 08 Jul 2026 17:56:28 -0400
X-MC-Unique: NEZjgN3-N4WIjja29oVcnw-1
X-Mimecast-MFC-AGG-ID: NEZjgN3-N4WIjja29oVcnw_1783547788
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e82060977so41865885a.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jul 2026 14:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783547788; x=1784152588;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=btjBlfn1gEh32xkLC16toOwaofpK3E2AbdoJxAP/F/4=;
 b=LVN1ceSphK6P9QSUOhSMr2e0MhdGO9X+uhVs0WbdUYoD2sBz317mh7oBHEOrUvGO6u
 9SkbDjP9CHtfCNEzdyvPQbxzKUsfJZs4KsbZRz6B9sgLVaJFNyS3Ai1f/2c/SmhXEvVn
 Ab2TMwOsqfs4LJqf1mrfklaTo0W4OToXiNgKzT0YzI5lOVBHZaBBLBVgPiZpLqt38Xds
 JBMKuNfVzzhJWL/kOAt7DXFCvyXZZWqG+bkeJzQtciJPjC8o5ghj81DJbT36/n/7dHCf
 S89ET16A3C6HVeFZfpyAIEwTDLqcAVW1fmXyFfJqi1Z3RaAbYlVPnb32Y8B0Sz0grCS+
 y19A==
X-Forwarded-Encrypted: i=1;
 AHgh+RocXfNfOkf7XaHr3Uvb6dMZ7DOl2TWsjf1k9219Q2/IdtvFrtPpXvP8Fw12GYNvivcJPbBQPFQL@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyzwBU5KlVjVyWfkwMRw0jbE/62RDOYNg3uhQvkx5UM3Dz26lUC
 LOp7OUZhatr6I1Q10FVVllR8SG5lKJAfo9eAAydwuYLB4EO8tYaqsQ/cwn87VSemOpDXRVtrRHd
 30xFRcpyeZ3xDND1R+LM2lXYI2VfrfpOjDu6Sqz8ksvacQ9XoFHLff9pMMcorfxww9+0=
X-Gm-Gg: AfdE7cl9nsObR7xgiRKhi9aV2qMcHxoZ6z6+hfYpPPhKcvi1QFUoH/qmw2yqZsHAVzW
 2H4YYvdY14OlWOq2mQd0qdOJDw0oaXZ4M+ezeL8q+xVLtKdU+tIveEs1pWJFzNDF4UKUdZ0J2BQ
 VD5+G1EZOqU1u1G0qjjAMssD1h8658qmN2hmmOoGS+hdYTU24UTmGJvbuC4ZBkEQOH3QnT6bUao
 KlLPEfhQwuc2VW9k482qIfm5xDfY2+qQaxsTbIuLn3WIandoNjl9TYWXf25s7nKr/PaCcQCSDgI
 DHW99ZRuBngX1Xfc0lPoeW3SfJxCSZbYipqbw3pmB+FOhXMwj5G6ZGcp4FSlcuPWzeAUWC7xtAk
 fONaH0iI=
X-Received: by 2002:a05:620a:444a:b0:911:e11e:dc0d with SMTP id
 af79cd13be357-92edac0d694mr13100285a.24.1783547788070; 
 Wed, 08 Jul 2026 14:56:28 -0700 (PDT)
X-Received: by 2002:a05:620a:444a:b0:911:e11e:dc0d with SMTP id
 af79cd13be357-92edac0d694mr13096985a.24.1783547787628; 
 Wed, 08 Jul 2026 14:56:27 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e90ca90a5sm1483479985a.32.2026.07.08.14.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 14:56:26 -0700 (PDT)
Message-ID: <b6b58477af57eb25e28eefb1a979a65aa250dc45.camel@redhat.com>
Subject: Re: [PATCH 00/10] vga_switcheroo, drm: Push fbcon handling into DRM
 clients
From: lyude@redhat.com
To: Thomas Zimmermann <tzimmermann@suse.de>, lukas@wunner.de, 
 jfalempe@redhat.com, alexander.deucher@amd.com, christian.koenig@amd.com, 
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, 	rodrigo.vivi@intel.com,
 tursulin@ursulin.net, dakr@kernel.org, deller@gmx.de
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, sashiko-reviews@lists.linux.dev
Date: Wed, 08 Jul 2026 17:56:25 -0400
In-Reply-To: <20260707135724.247562-1-tzimmermann@suse.de>
References: <20260707135724.247562-1-tzimmermann@suse.de>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kjOd6phrbvGU9uW69innokbGegK2eFLKh30no9gU4fg_1783547788
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

For both nouveau patches:

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Tue, 2026-07-07 at 15:38 +0200, Thomas Zimmermann wrote:
> Vga_switcheroo currently invokes fb_switch_outputs() to inform fbcon
> about switching of the physical outputs among framebuffer devices.
> But
> new DRM clients to not use fbdev/fbcon and might require their own
> vga_switcheroo support. Let's strictly separate them from each other.
>=20
> Remove fbdev/fbcon from vga_switcheroo. Introduce a pre_switch
> callback
> for vga_switcheroo clients to do the fbcon update. Allows for
> removing
> all direct interactions between vga_switcheroo and fbdev/fbcon.
>=20
> Also replace the existing reprobe hook with post_switch for symetry.
>=20
> At the same time, push the fbcon update into DRM's client for fbdev
> emulation. Do this with the new DRM client callback acquire_outputs,
> so that other clients can have their own handling of vga_switcheroo.
>=20
> There are only four drivers that support vga_switcheroo: amdgpu,
> radeon, i915 and nouveau. Update each of them with the new callbacks.
> When vga_switcheroo now invokes pre_switch, each DRM driver forwards
> to aquire_outputs and lets the DRM clients handle the new outputs.
>=20
> Tested with radeon on a notebook with Radeon HD 4225 and HD 5430.
>=20
> Thomas Zimmermann (10):
> =C2=A0 drm/edid: Include <linux/fb.h>
> =C2=A0 drm/client: Add acquire_outputs callback; implement for fbdev
> =C2=A0=C2=A0=C2=A0 emulation
> =C2=A0 vga_switcheroo: Add pre_switch callback to client ops
> =C2=A0 vga_switcheroo: Add post_switch callback to client ops
> =C2=A0 drm/amdgpu: Implement struct vga_switcheroo_client_ops.pre_switch
> =C2=A0 drm/i915: Implement vga_switcheroo_client_ops.pre_switch
> =C2=A0 drm/nouveau: Implement vga_switcheroo_client_ops.pre_switch
> =C2=A0 drm/nouveau: Implement vga_switcheroo_client_ops.post_switch
> =C2=A0 drm/radeon: Implement struct vga_switcheroo_client_ops.pre_switch
> =C2=A0 vga-switcheroo: Remove unused interfaces
>=20
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |=C2=A0 9 ++++-
> =C2=A0drivers/gpu/drm/clients/drm_fbdev_client.c | 23 ++++++++----
> =C2=A0drivers/gpu/drm/drm_client_event.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 18 ++++++++++
> =C2=A0drivers/gpu/drm/drm_edid.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0drivers/gpu/drm/i915/i915_switcheroo.c=C2=A0=C2=A0=C2=A0=C2=A0 | 11=
 +++++-
> =C2=A0drivers/gpu/drm/nouveau/nouveau_vga.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 28 +++++++++------
> =C2=A0drivers/gpu/drm/radeon/radeon_device.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 9 ++++-
> =C2=A0drivers/gpu/vga/vga_switcheroo.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 41 +++++---------------
> --
> =C2=A0drivers/video/fbdev/core/fbcon.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 -----
> =C2=A0include/drm/drm_client.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 14 +++=
+++++
> =C2=A0include/drm/drm_client_event.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++
> =C2=A0include/linux/vga_switcheroo.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 30 +++++++++-------
> =C2=A012 files changed, 122 insertions(+), 73 deletions(-)
>=20
>=20
> base-commit: cd8abe2554ec7eba16c1d48ab508732bf93534eb

