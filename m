Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175FF606A324
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 20:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=otNU27lw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A609610F80D;
	Tue,  3 Nov 2026 20:17:03 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B476A10F80D
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 20:16:57 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48afcfc4bf5so4707172f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2026 12:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793737016; x=1794341816; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Uagv2LJtbqUauQlqeN4VpSLxkoRl/chN9dgwOvucZbo=;
 b=otNU27lwX8cYQo0Y3vztfjyv9S6yYYqaqM7KBu2i0Aa6PD7rxvbjzuyxwcpf8o8ASJ
 dq009PB+r1W8g8eOWv8oOH1/JZ0C3ljvgUBJTw5J3dp8UlakImrFxAgXLNI1ycz0vMMg
 2EmsqWz9e12yj5ffUhvUjcSWLDhIgCwNnXnEKzB3qu8Vu+mYEVLXWSOM+dZ7AY3IW/0/
 3nGW/6lQcY1U3bQ7eDPIhb6aePucDRaqjzK6kSs7veffjUbl8RAqvdkGDly8jYCxmMqW
 WNKR7xRKQN9eszAbC8kUA3ac/6hLE2Kxg3mXmdKRnp0g6WgzA+IkGZnQQXQk2qwaWG46
 NO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793737016; x=1794341816;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Uagv2LJtbqUauQlqeN4VpSLxkoRl/chN9dgwOvucZbo=;
 b=19FNtFbo5+VscD5+IwLaMg6Jpvaef9JfAIjiF8agLHsVNvwOjma2JGP0ecbtmoKR6G
 aBsRSwhl6XIT4hLFnPcHQ39J7yC0wRuK1O0giOVVLwK1S2YomMrTXdOP38TLR72varbt
 4SyMnaGN24VUqQL72glk20ZlOiXblKYX+eoJjeTJ/pegrtWA+42Hifg9A5jaDGGqzQxy
 Q9saf0hGxht5Musb2bMmypf7RYPSAI+oJHoYvcfRhWDadACO1P4XLLveUw6Mf/gnNfHZ
 doEtmnBoaSTr9sou0Rlmw8hIaOdAz1s87Iogb3TS1i7KundD6TaDGOf8sRvmhn3GTcYF
 Tg5g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwi61uW8Nfiu+wlalpzc1hb8uXveLt7/dVdFSckTqCj6QjNI7lY6mb4gE6o9FJlP7B+HlWx3O/m@lists.freedesktop.org
X-Gm-Message-State: APuU4Z94ANPRrSi2RSW/Z0Zmg0VEVIpjyGqD177lmDCbYXpAcYw1YYeg
 6g3kxyfrSiOiJESIdFKJRLlC+se8+FnliCCfJI7JxMcW+DK05dCxgLHy
X-Gm-Gg: AYBFou3A/7pe/gXmRFQgQHgywZgQ8TYGRJ+v2WjkKJUWrU3/cJE9z0w5P2oXujI5BuH
 6RjkZHD2uPkOT9bQ5srMvMl4DXmTneotSuOFiYROoNPV/wSRi/YbjJxgR7pqKEHagfADeSYNtI8
 7kdqdCRp3sN3eZ0IdKelw/uqevYWfZkur+IEyIiYC33Hj4vvMMdhSuZINc/JYwk8XJbuFdu/1H+
 ZEccK9mhb+WBZER6c6IVSe7SINmogk9HyyHLhkd/Mmkjs4VOvb3Thq7wup36PIraGZHrFfH54ne
 JD9AWT5GSVQOvzHHiKu0w+E7Jp4m3MI3panUP3SeA91NIxTs86VHeSZ+98qPuXKVXB7C6DSdOV/
 jCyXrxxcVQMSOD6ELGuz2Yo2ZyZBr7059OzwYtNrC6iY0mTEEhDlGe1vJEE6D+eh4tN1CAyHWBa
 oQw0pnp8KW930z2luOvb4yXnWHKmOhAXeeCvaJCdARtOtSANWvD/55dz/jUcukFwaOeVLoQSiPc
 NOsZ0foO+djQbviMda4JofuZj3IPLAQvgpZkpwDvETjwhAja5mcyqHa4M5hFV6sq1ODOWnpykY4
 WcxGJO4iXrAyn0vRZU85HNtVZzMlcDrleZ5L2BmUT7PAEfi1qg15n0mLaOzxGfPfWTNYEEMSbT+
 LxPy6qcF76rnfD3ePnbcYAykxrYTuWg==
X-Received: by 2002:a5d:64c9:0:b0:48e:4e00:b737 with SMTP id
 ffacd0b85a97d-48e6e515ff2mr36150750f8f.54.1793737015886; 
 Tue, 03 Nov 2026 12:16:55 -0800 (PST)
Received: from [192.168.1.86] (240.red-79-154-229.dynamicip.rima-tde.net.
 [79.154.229.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fcd03d4b5sm333962f8f.50.2026.11.03.12.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 12:16:55 -0800 (PST)
Message-ID: <cb152c1a4427d6b9db60c776d3e2efd597573627.camel@gmail.com>
Subject: Re: [PATCH v3 04/15] drm/amdgpu/gfx: add a reset_engine callback
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>, 
 Lijo.Lazar@amd.com, Mario.Novales@amd.com, Manu.Rastogi@amd.com, 
 Jiongyu.Zhu@amd.com
Date: Tue, 03 Nov 2026 21:16:53 +0100
In-Reply-To: <20261028085736.3808569-4-Jesse.Zhang@amd.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
 <20261028085736.3808569-4-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-10-28 at 16:56 +0800, Jesse Zhang wrote:
> Some gfx hangs can't be recovered by a queue or a pipe reset, eg. a
> CP
> front-end stuck in the middle of a packet. They currently end in a
> full
> GPU reset, and VRAM is lost. Resetting only the graphics engine is
> enough for them, and the compute engine isn't reset.
>=20
> Add an optional reset_engine callback to amdgpu_gfx_funcs for the
> hardware part of such a reset: it resets the CP of one engine of the
> GFX
> IP and maps the kernel queues of that engine again. A later patch
> builds
> the soft_reset_engine() IP block callback of the gfx IPs around it.
>=20
> v3: Take enum amd_ip_engine, called by the soft_reset_engine() IP
> block
> =C2=A0=C2=A0=C2=A0 callback (Timur).
>=20
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 5939e1fb3b24..8d7bd7057666 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -35,6 +35,7 @@
> =C2=A0#include "amdgpu_ras.h"
> =C2=A0#include "amdgpu_ring_mux.h"
> =C2=A0#include "amdgpu_xcp.h"
> +#include "amd_shared.h"
> =C2=A0
> =C2=A0struct amdgpu_usermode_queue;
> =C2=A0
> @@ -376,6 +377,9 @@ struct amdgpu_gfx_funcs {
> =C2=A0	/* find the gfx HQD slot (me/pipe/queue) for a doorbell */
> =C2=A0	bool (*detect_hung_queue)(struct amdgpu_device *adev, u32
> doorbell_index,
> =C2=A0				=C2=A0 u32 *me, u32 *pipe, u32 *queue);
> +	/* reset the CP of one engine and map its kernel queues
> again */
> +	int (*reset_engine)(struct amdgpu_device *adev,
> +			=C2=A0=C2=A0=C2=A0 enum amd_ip_engine engine);

No need to add this.
The soft_reset_engine callback on the IP block is enough.

> =C2=A0};
> =C2=A0
> =C2=A0struct sq_work {
