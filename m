Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50C2C282D1
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 16:15:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE7F810E21E;
	Mon,  3 Mar 2025 16:14:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TgLNHBX5";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EDAD10E21E
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 16:14:51 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2fd02536660so1031615a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Mar 2025 08:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741018491; x=1741623291; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1c5acoK/LXOesvLMfaza/50xavkWvIv1ZDYEijRMpTc=;
 b=TgLNHBX5S6C5NV19I7BrHQKT1qz5PtTlV5qj0GwXEt7cJ2OQc08LV0naN6cggxom4I
 F0BwzJc2mZ1LRACG/oHQZWAOSM8XHuoWNjlbB8RZRl/cdLZYT/1jDz9M9P2yavrf4FlG
 9DCuIfNrNnQqxja7fnieqglR9zR5qD6vU5EdFxOdwoXGfBcT2x/d24o0DpZFLppDSpXp
 VYvkbtBtwelEjcd37UHLSke/WqUPapiNf31aUMtcqYhrZ6bZJIsVB5ssKWhEMg9N5zDD
 CN8S0wqTm1fRLAKvAxaq0wwNpZq8BjGMfxHmnSMTx/ip/ariPNUnK1aQrp6lmbnuq1US
 PNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741018491; x=1741623291;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1c5acoK/LXOesvLMfaza/50xavkWvIv1ZDYEijRMpTc=;
 b=d+1x6D27abA9tam+z+VMTEqpLNBiDNIA9O2GHIaNsKaMIQe1jLYRpe2zRBIyolPo90
 xRhujb/P5YvMbvssfmIYiw5l9x50OURLZAJB1z1Phy0iBayj5YuHc5ClSJtvXwg592mr
 7ycfepA3Bz6x0B4HcF/kiFJZ5X7Z6QxR7MvSWtIl3qnD8+ybElxMmFgFlOWAsdv60MHF
 O7xyq5svbsLjR0J6j0NS2GhsXF995roCBi2IQ06aQTg6nDyMGBhT7OdL/cArRCHpKMRj
 /2SwyhACPP67kQRpDnpUaPanYAMH1PN2oBv7zyPvKab1hq5brRtDmAJ/vUzqkMXedK5O
 BqUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqWby1ujNAFaDIALnAiWqHfq2KKAMxBlr0JvC9b0oJNeVJMkOonR7696cM1TH78sF9LjZ43dYr@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywn7IjgDM8Dq6dwTLfyv8ai3yz0V69iEuR26PFkg/myGPLCO3aS
 Rou6GG+mkqEEwoZef99xxG8FxKp0YMwj+0PPoyrBhnlufgmRm8RtQv5RqyjmNfs5vLYvs0uaIIk
 NliLHF6pdT58UqzF4JIM1wNf8raV8GnwI
X-Gm-Gg: ASbGncs1a6C3AHVn9VLQo9TNqbEpw4gBOMsDMkEEDzFCLPnByWLQ/V6BzjnCGCkvjd1
 N2XO81P67g/TpHVayQ2PDh74eFhqYVc72yH+PHaRrDJWpQNw3Rq82q4B5lI92cl1VrwJypvp2IR
 z4L8zlmFBUZaRCpKPO0gNGJVAU3A==
X-Google-Smtp-Source: AGHT+IG4javMVO2VDSEuCI0DCrG2EdHNLTXyGMckVnw3wa4FLmCpHjn5LyXhNtcE1HqZBpd1jPL+Z9Y+EqWMv9PUNuk=
X-Received: by 2002:a17:90b:1a91:b0:2fe:a747:935a with SMTP id
 98e67ed59e1d1-2febabc3f2amr8145526a91.4.1741018490892; Mon, 03 Mar 2025
 08:14:50 -0800 (PST)
MIME-Version: 1.0
References: <20250228195411.2530147-1-alexander.deucher@amd.com>
 <20250228195411.2530147-5-alexander.deucher@amd.com>
 <DS7PR12MB6005AF0B4E9BC29C3D9E9E9BFBC92@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005AF0B4E9BC29C3D9E9E9BFBC92@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 3 Mar 2025 11:14:39 -0500
X-Gm-Features: AQ5f1JoL5k5qGUkrBsAjgHUF9iIYvGiz4vEbaFd6roZ9iXhJs8ApqOfvV4SkXyY
Message-ID: <CADnq5_MMQxNt11vQrL3UwbyUKeM-UAFDPb0+z=Aat6nMnR+H9w@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/amdgpu/userq: remove BROKEN from config
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Mon, Mar 3, 2025 at 7:09=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> w=
rote:
>
> [Public]
>
> Question: Why use the CONFIG_DRM_AMDGPU_NAVI3X_USERQ to guard all the var=
ious GFX user mode queue enablement paths? It seems more generic and reason=
able to use the config name CONFIG_DRM_AMDGPU_NAVI3X_USERQ.
>

I assume you mean something more generic like CONFIG_DRM_AMDGPU_USERQ?
 At this point it would make more sense, but at the time it was added
there was only gfx11 support.  We could change it, but at this point,
I'd be more inclined to just remove it.

> Except for that question, the series patch is Reviewed-by: Prike Liang <P=
rike.Liang@amd.com> .

Thanks.

Alex

>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> > Deucher
> > Sent: Saturday, March 1, 2025 3:54 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: [PATCH 5/5] drm/amdgpu/userq: remove BROKEN from config
> >
> > This can be enabled now.  We have the firmware checks in place.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig
> > b/drivers/gpu/drm/amd/amdgpu/Kconfig
> > index a614320114796..23c014da0f324 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> > +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> > @@ -98,7 +98,6 @@ config DRM_AMDGPU_WERROR  config
> > DRM_AMDGPU_NAVI3X_USERQ
> >       bool "Enable amdgpu usermode queues"
> >       depends on DRM_AMDGPU
> > -     depends on BROKEN
> >       default n
> >       help
> >         Choose this option to enable GFX usermode queue support for
> > GFX/SDMA/Compute
> > --
> > 2.48.1
>
