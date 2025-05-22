Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646C1C54E90
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 14:16:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C058D10E7D4;
	Thu, 22 May 2025 14:16:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hx4EuLmI";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F059610EB12
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 14:16:12 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-b270d7e0985so534596a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 07:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747923372; x=1748528172; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uz4PaAXf4GkXf5YkOJsSmy2fBPFZfe8dScdjNBZQEYQ=;
 b=hx4EuLmI2BIcObQe6UMlb7hd0M62vFmN00GF50JTMYv0pr4G4bqn9O1wawG9fcYfN0
 sfcm47QhxWKAbyiuTjr/ouo4k8d1wGYc939Mvy0BSYDxpizBPN9SoxHHQum1rnrTkM1Z
 J+iFHoDBMbyh4TJLAiM4ID4N7fKFG8IGPcWZrkHJIDhx7n6EEL8x3tbliIW07b5iMDmv
 +nmP9nw3nXJol3gtvckURNGn8XR19+sQeEvjKbPGKqHkPzRqVVsww3xkMyFBmcyWKsw4
 UCT+pDOpLZP3h6Bw9cwuythlMm7CBuj21MwWNz3P49hVpD5frvYYYcS+lKACGYuFLjmp
 xRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747923372; x=1748528172;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uz4PaAXf4GkXf5YkOJsSmy2fBPFZfe8dScdjNBZQEYQ=;
 b=bI59Mr8JjKtzjFjnTrbq08pxrUdGZBbt2mYwznr9Diy6Ko/Thf+I2IZm1YboUqbSlY
 33TVGdaig8SV3TTVxdr7L6G8syqlupvh66k9cAfud47YF+NmnMp8nZSLadxtkuBXZ+v0
 l+di7BMSqCgIqAdadzyCvISjeVXtnc1C1ejxC5H+VPmbzS7piA4oM9mSs30UROCwBdSZ
 47u5OvoLhsygTh/fR4a3aGMDQXiAADI0jWCu5Qz68BhkK63JrsVJNP1UYBfyFd6KOcq0
 L3lNCyvrU9udT91WoZjjvfgkcwSYibWtc9zGr6fdQN533/buMsgIYz8FgdPJ++xKuFRL
 /K3Q==
X-Gm-Message-State: AOJu0YynkYj19tdAlQPI0RmlLUI/3bEGFkFe0KdUNvbkoi+0KU/yqf6F
 cAkUCcObdkuoBZw4QTgIqy9WDJ1xrtbJ4Lb6S8/ye0hDcYS6sIkfx04O1RdjrRNT1H3wg43U78k
 SsworgDTZ+mB+qyrgaZg4k9/IFP/3aiA=
X-Gm-Gg: ASbGncvxXiVliI7eBONhqdKEmUMx4O76wCA9aPZCO5CAH2MMsBg2t0lsbWNbXwlxSJ5
 3FGehswsOYry2lMphJ1sk3WUrY2CvkuBvjywq2ZdrMWsrRImwsh2FWxqXj24KjCdprxB+ujlSQK
 +tcnQa1p/rfasUJosCca+dCn/Dkf/emvJCpA==
X-Google-Smtp-Source: AGHT+IGGl7XhRJ2tMu/q6BhorC1YE8pf6lX75zCNP86Bo8KMJgHLIMJtYDal+T5yCiNw2gWUoODadQI9UIIwCQuK8qo=
X-Received: by 2002:a17:902:c951:b0:21f:356:758f with SMTP id
 d9443c01a7336-231d438823amr136422405ad.3.1747923372218; Thu, 22 May 2025
 07:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250522141328.115095-1-mario.limonciello@amd.com>
In-Reply-To: <20250522141328.115095-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 May 2025 10:15:59 -0400
X-Gm-Features: AX0GCFtGFQDC5j8vnktig4uy9HHKvOCvvhdOLETZm-4zCoCqB_up90KqV2OW6dQ
Message-ID: <CADnq5_PHkzgq8NaAA0BcEs-_WBEq=GohZCB_MBLgDmB_yUguyg@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd: Keep display off while going into S4"
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Thu, May 22, 2025 at 10:13=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> commit 68bfdc8dc0a1a ("drm/amd: Keep display off while going into S4")
> attempted to keep displays off during the S4 sequence by not resuming
> display IP.  This however leads to hangs because DRM clients such as the
> console can try to access registers and cause a hang.
>
> Cc: stable@vger.kernel.org
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4155
> Fixes: 68bfdc8dc0a1a ("drm/amd: Keep display off while going into S4")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 7d0687695645..c876f78618cf 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3469,11 +3469,6 @@ static int dm_resume(struct amdgpu_ip_block *ip_bl=
ock)
>
>                 return 0;
>         }
> -
> -       /* leave display off for S4 sequence */
> -       if (adev->in_s4)
> -               return 0;
> -
>         /* Recreate dc_state - DC invalidates it when setting power state=
 to S3. */
>         dc_state_release(dm_state->context);
>         dm_state->context =3D dc_state_create(dm->dc, NULL);
> --
> 2.49.0
>
