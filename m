Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F9FC04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 20 May 2024 15:14:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5899910E76A;
	Mon, 20 May 2024 15:14:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KXrBWhy0";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE07410E76A
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 May 2024 15:14:13 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-1f2f566a7c7so46044965ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 May 2024 08:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716218053; x=1716822853; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mwnBqFZq8pMni0ohTdn+Aj2tz06YqqpkH061bIHW8AM=;
 b=KXrBWhy0i0gB7jKOMYjCBb9FlamEVSbf2BHycbyiYYeq83v9DaY3Z+vu8M7hpG4L1B
 ppZdRyq7WK7RmTMc9QcCTLLr7Smlgw1LQ838sw/XOJWA6enaeYrPawhn8gCKUNyeBx1s
 GhXohHWtzpaltydVxY3xbQMj+j3KKsiCj67QIMhMeQEobYSh/NM+uxOk/r5EzvbfmmdR
 v0vxLHaTEBYQUgjzSLUW6UFim0B2a3CjTW3BnV7dM2X90VI8kqjoenZdjyVlc7T3RjM7
 X4Uyf9z1biezz9Qw5isWsQzN/tSPe9lHW1sFhY1cXkCSaO5Tb5Gp+B2ByykwfOBR1Cc5
 VAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716218053; x=1716822853;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mwnBqFZq8pMni0ohTdn+Aj2tz06YqqpkH061bIHW8AM=;
 b=pNSK6EZ69l4HN4uKuNLeGle1TK57OohhIGBhP/S+iDZokdyjXCaUshU9L3OLHL4KHh
 7FpbXH1tbIQ5P0crIhhGJ0abEAu8T7kY82FQ7bNBNjHyW6T+bdlt4BdHD990/Y81uf0H
 u8phK4AC7F1Zcn4xG1XvRbOH3teJMKujHTXu5LEVpD0/bFWfmLCRjOWSxvtRdeGQgGtc
 ptg7y45EKXKeNKJ/eRJLDnwZcxie6lSL8maBZ9k26OUf1vp+4FxYt64SdqvrzX0aE53W
 4RoYobfSI5Fcihw7Q4mg0oPg0pGcS3bxesqLV3PYLdFwOKhkN7ms4MFeEzj+RMNG0ykw
 oZWw==
X-Gm-Message-State: AOJu0Yws5pz0Fqdj5XDmKBNEZHu2247kWVsayFGR3blVwnewObqKQwcG
 YuXV2m0c6YCG+TWl3EsFTMu65Ykq2U18C2jPl2q3w+qj+8ZFR4Cjj3JFiW1YOzmfvLQEOsLeZ3p
 1PvIZRlwThAhJ5LcABNDJ93eByTzrgA==
X-Google-Smtp-Source: AGHT+IFnhfuVel+urd33CataDDsQ1OyL6AE3sXNLPC/u0FQruSxYbc2Y6wo/ViPnzVUEvMGb1MyUt/Cq59MvbwM4JuA=
X-Received: by 2002:a17:90a:a50b:b0:2b2:7c42:bf6e with SMTP id
 98e67ed59e1d1-2b6cc758b9fmr25164782a91.12.1716218053197; Mon, 20 May 2024
 08:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240520081814.8363-1-tursulin@igalia.com>
In-Reply-To: <20240520081814.8363-1-tursulin@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 May 2024 11:14:00 -0400
Message-ID: <CADnq5_PzuddWopLQKQYpuP4F1uv8FCxk234LaiC4_8gsAA-cKQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix amdgpu_vm_is_bo_always_valid kerneldoc
To: Tvrtko Ursulin <tursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
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

Applied.  Thanks!

Alex

On Mon, May 20, 2024 at 4:18=E2=80=AFAM Tvrtko Ursulin <tursulin@igalia.com=
> wrote:
>
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> Align kerneldoc with the function argument name.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 26e20235ce00 ("drm/amdgpu: Add amdgpu_bo_is_vm_bo helper")
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index b9cca51356b1..3abfa66d72a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -3008,7 +3008,7 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_dev=
ice *adev,
>   * amdgpu_vm_is_bo_always_valid - check if the BO is VM always valid
>   *
>   * @vm: VM to test against.
> - * @abo: BO to be tested.
> + * @bo: BO to be tested.
>   *
>   * Returns true if the BO shares the dma_resv object with the root PD an=
d is
>   * always guaranteed to be valid inside the VM.
> --
> 2.44.0
>
