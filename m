Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEF8C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jul 2024 13:24:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CBE510E1AC;
	Tue, 16 Jul 2024 13:24:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GL5GQdxT";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0763710E1AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jul 2024 13:24:50 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-70cdc91b227so265335b3a.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jul 2024 06:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721136289; x=1721741089; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5YP16GQ0s/xzt7rpqspOIjVtwGxQbWoqsFqHwjZxEB8=;
 b=GL5GQdxT3X3QjteH55gfcrmYiGlqfGh+McGDi/6e3RoEknwrH2nSo9hfFFS+Qa5kwk
 fB4OKsfLe1HYNh3SpU6nnlihpUMFGHkAHbsd4qNPKmg+1Nz3G8/lvRaw4rtbCzktyvKC
 c1mhf++M4ydHv63ghtcqj8WACSvqxDpadKMIz+ftJ0dlsEfeJPJbEPRWQap/QOyuhMH0
 t9QwRbToDPCYRLC/Or5ahYzkvsqTvy8GYlG+M9cwP8LS8KolhJjFDPopzqUp/3h8aIT/
 x7sNN8OJVS/iDGG61fJVG6A0BYBkWSDSjM1fDhY+IFx5a7rZlQf1Fr5JDbsRrTbiGNds
 cUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721136289; x=1721741089;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5YP16GQ0s/xzt7rpqspOIjVtwGxQbWoqsFqHwjZxEB8=;
 b=FvNcmNc6NznoDUl1pvYl0uSQ63DZIIJPsR+D1MDZPlm0+wtAbgah9F4dJTTEE94VVB
 S4AixoQ2aYk1F5CsgYyGC64qI/ZO09TIsfE2RyktC8Q7isJDdapxt27mi35U0Ahk7t7q
 O/gyDAX5UWAbRWr/Y1CEdjb8ZLRGIa5Iv16xkDs9LFfYEB4GshrbPCd4ywFKLJLORGdm
 g7lfXNvh4cMzjtf9lK40OYxAfLTj3EdTrcpg0HHKhSGvt6ZXs7AiYOQGrTQ+ua/i4Clv
 45zSF01uLxQD2U/O9JSvr30QrnA0jRc9606TzmGsjSHJeto8YtVncDnh0W61Z9NquF/P
 mUhQ==
X-Gm-Message-State: AOJu0YxYulCPbfYgLqmfLWsq0i7qEMB528lwUtn4hPNPhYhea3sUZV5V
 XAsqWjrO8JBZWCATwl9WRpxDrKVXWbNsHlq0TkBnq/m1bP3Z/UpbCI6VM6k5I3lnc0vKBZY3xn3
 iYduK8UJQ9ikgpX/25COq9zXaciE=
X-Google-Smtp-Source: AGHT+IGHBpKYncUu2AwdkLrvXmAgWpBJNNdrmcy+7LjMelTqG/q9fHeMnTOfpnka62iFF9k9jBhxiXimvWeJWmf9iEQ=
X-Received: by 2002:a05:6a20:8416:b0:1c3:a411:dc45 with SMTP id
 adf61e73a8af0-1c3f1274bbcmr2593848637.39.1721136289417; Tue, 16 Jul 2024
 06:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240716023022.100811-3-Rodrigo.Siqueira@amd.com>
 <20240716023022.100811-9-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20240716023022.100811-9-Rodrigo.Siqueira@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Jul 2024 09:24:37 -0400
Message-ID: <CADnq5_MNm4C0VxKnqBqHOArEDAVOWBY2aKvURRZ=v-xiSdA_xw@mail.gmail.com>
Subject: Re: [PATCH 6/6] Documentation/amdgpu: Fix duplicate declaration
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Roman Li <Roman.Li@amd.com>, Alex.Hung@amd.com, 
 Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
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

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Mon, Jul 15, 2024 at 10:50=E2=80=AFPM Rodrigo Siqueira
<Rodrigo.Siqueira@amd.com> wrote:
>
> Address the below kernel doc warning:
>
> Documentation/gpu/amdgpu/display/display-manager:134:
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:3: WARNING: Duplicate C
> declaration, also defined at gpu/amdgpu/display/dcn-blocks:101.
> Declaration is '.. c:struct:: mpcc_blnd_cfg'.
> Documentation/gpu/amdgpu/display/display-manager:146:
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:3: WARNING: Duplicate C
> declaration, also defined at gpu/amdgpu/display/dcn-blocks:3.
> Declaration is '.. c:enum:: mpcc_alpha_blend_mode'.
>
> To address the above warnings, this commit uses the 'no-identifiers'
> option in the dcn-blocks to avoid duplication with the previous use of
> this function doc in the display-manager file. Finally, replaces the
> deprecated ':function:' in favor of ':identifiers:'.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>  Documentation/gpu/amdgpu/display/dcn-blocks.rst      | 1 +
>  Documentation/gpu/amdgpu/display/display-manager.rst | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/gpu/amdgpu/display/dcn-blocks.rst b/Documentat=
ion/gpu/amdgpu/display/dcn-blocks.rst
> index f80df596ef5c..5e34366f6dbe 100644
> --- a/Documentation/gpu/amdgpu/display/dcn-blocks.rst
> +++ b/Documentation/gpu/amdgpu/display/dcn-blocks.rst
> @@ -34,6 +34,7 @@ MPC
>
>  .. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
>     :internal:
> +   :no-identifiers: mpcc_blnd_cfg mpcc_alpha_blend_mode
>
>  OPP
>  ---
> diff --git a/Documentation/gpu/amdgpu/display/display-manager.rst b/Docum=
entation/gpu/amdgpu/display/display-manager.rst
> index 67a811e6891f..b269ff3f7a54 100644
> --- a/Documentation/gpu/amdgpu/display/display-manager.rst
> +++ b/Documentation/gpu/amdgpu/display/display-manager.rst
> @@ -132,7 +132,7 @@ The DRM blend mode and its elements are then mapped b=
y AMDGPU display manager
>  (MPC), as follows:
>
>  .. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
> -   :functions: mpcc_blnd_cfg
> +   :identifiers: mpcc_blnd_cfg
>
>  Therefore, the blending configuration for a single MPCC instance on the =
MPC
>  tree is defined by :c:type:`mpcc_blnd_cfg`, where
> @@ -144,7 +144,7 @@ alpha and plane alpha values. It sets one of the thre=
e modes for
>  :c:type:`MPCC_ALPHA_BLND_MODE`, as described below.
>
>  .. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
> -   :functions: mpcc_alpha_blend_mode
> +   :identifiers: mpcc_alpha_blend_mode
>
>  DM then maps the elements of `enum mpcc_alpha_blend_mode` to those in th=
e DRM
>  blend formula, as follows:
> --
> 2.43.0
>
