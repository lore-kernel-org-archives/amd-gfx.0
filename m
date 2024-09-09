Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A29DECE588
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 20:31:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D83F410E69F;
	Mon,  9 Sep 2024 20:31:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IV77ly1A";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CDEB10E69F
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 20:31:37 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2db6b13c6a0so12558a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Sep 2024 13:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725913897; x=1726518697; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4EasDs5ORU3z8MkeuY6KJ6HiB/NquqreZVucPS3wsEM=;
 b=IV77ly1ADY1Ers37Z/eo3tqHhhBD9hJMi6obmSFO1qWjdJ8dzBcQRh7haUfIDITxvQ
 ZmYf7F9kCmrexlxYs/8mETLDabmSRs5F09NYpH2A/WBX5qtvk4TqxooTBJjLh8TQHpGU
 QzGBncQRNELYcl0f5u34DU2yewxbN5ZFq8YO0E/z8b8znr4OH0jaemlA7JJIF/bWMYHs
 mva9hdxKhMnaL/whrPvySGcyAyKsMe3/yvwcZnwJEKqYpaLSBzfTM77bMupzP9NsAAgX
 gR/b0jWQoa9f3ael/Orq8NuDDFSliWJFuV6kQn/4XhbTx/bJb3FUWyRTu9G+Nk73IWg4
 z9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725913897; x=1726518697;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4EasDs5ORU3z8MkeuY6KJ6HiB/NquqreZVucPS3wsEM=;
 b=ejI/0mZfHPt4dOhmiIFs7Dzk0mWSL6RJ3aOhsaCwvAF3rdagzV9Z4Hqf2GRZtqQfC8
 8aa8TtBqKoM03OelxA2jKFDSpnFg/HsnWCnygdm7ECRWsnaclSthuzy42Tc7N6lx0eDP
 +l+1CqnW4kD2cX68VgUcgCCz9QGRH+ZAEspiq7GyhQIbP6ucy1cJzeZxm8cUQzFwCymA
 OxA6u6SL8kigiaP8dE/m0OwY2oSglHNBDehuaSXQzRUgIZm7MFwMIS8mT4qwzQSQbtox
 BFO/dg0kOa7Onuiw3tXOCvHBc9xOKfNgVhCfAKkERdOej/6ZmcHTIUv1XSw2CyyCeQSt
 4GYQ==
X-Gm-Message-State: AOJu0YzbtTlTzi2GaaKULA8+ODBEwRVPKZzy9St1WVpoqaccyFxOVaUN
 y4yvxV+14vlzOQtqCwYtyeqqqqmX5dCCpOrmxDQwPYSrau4jCZCF0v9ksxfYBJcOweOINUhEcFU
 6vKYBs6KMUVM/1GLBVGOKH8GKvQ8=
X-Google-Smtp-Source: AGHT+IET/Ch4wWFGjXByEDUpKBGXSDc2PVjV5ZQMWMiAN7kxNTJWx66lSssl46PVej7okfZGrwusDQosRivvENpAEeo=
X-Received: by 2002:a17:902:f944:b0:205:9112:6c38 with SMTP id
 d9443c01a7336-206f068fbb7mr63191295ad.10.1725913896506; Mon, 09 Sep 2024
 13:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240909200614.481-1-shashank.sharma@amd.com>
 <20240909200614.481-23-shashank.sharma@amd.com>
In-Reply-To: <20240909200614.481-23-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Sep 2024 16:31:24 -0400
Message-ID: <CADnq5_Pwkn8SnJ75KsPQHTE4RhWtdP0=bQZD0u6HZSLXuMthEA@mail.gmail.com>
Subject: Re: [PATCH v11 27/28] Revert "drm/amdgpu/gfx11: only enable CP GFX
 shadowing on SR-IOV"
To: Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, 
 Shashank Sharma <contactshashanksharma@gmail.com>
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

On Mon, Sep 9, 2024 at 4:18=E2=80=AFPM Shashank Sharma <shashank.sharma@amd=
.com> wrote:
>
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
> This reverts commit 81af32520e7aaa337fe132f16c12ce54170187ea.
>
> This commit prevents a usermode queue client to get the shadow related
> information.
>
> Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index dbf3bcadee32..1f0f7ec0facc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -661,12 +661,8 @@ static void gfx_v11_0_check_fw_cp_gfx_shadow(struct =
amdgpu_device *adev)
>         case IP_VERSION(11, 0, 3):
>                 if ((adev->gfx.me_fw_version >=3D 1505) &&
>                     (adev->gfx.pfp_fw_version >=3D 1600) &&
> -                   (adev->gfx.mec_fw_version >=3D 512)) {
> -                       if (amdgpu_sriov_vf(adev))
> -                               adev->gfx.cp_gfx_shadow =3D true;
> -                       else
> -                               adev->gfx.cp_gfx_shadow =3D false;
> -               }
> +                   (adev->gfx.mec_fw_version >=3D 512))
> +                       adev->gfx.cp_gfx_shadow =3D true;

We need to be a bit more surgical about this.  Setting
adev->gfx.cp_gfx_shadow =3D true, will also enable
gfx_v11_0_ring_emit_gfx_shadow() to execute on kernel queues which we
don't want.  We just want to enable the query for the shadow and csa
sizes.  Probably easiest to just add a new INFO IOCTL query for that
so we don't break the old query.  I.e., userspace looks for non-0
shadow and csa sizes to determine whether or not to enable shadowing
with kernel queues.

Alex

>                 break;
>         default:
>                 adev->gfx.cp_gfx_shadow =3D false;
> --
> 2.45.1
>
