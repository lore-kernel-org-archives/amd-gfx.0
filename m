Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1515410A88FD
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 18:27:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4ADA10E2A8;
	Thu, 26 Mar 2026 18:27:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QMzgHmoT";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4D7C10E2A8
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:27:16 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-124a7216c9cso90846c88.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:27:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774549636; cv=none;
 d=google.com; s=arc-20240605;
 b=hyLXHtslZegrDtnUvpcPXZm9lXbXrrwfCgcTtk+OoLGXJATCfu7YlO14/a4rT+eawj
 TOsFirG8qJktL9DIfFHxYHrHfrfP3g0AQKj95DW5mFWULesZb6D8+9k8azVcEbAFFB+0
 IoDe4z/nba0jbR8DKa48mIlbRmj6No4lKfbalXvBkas/31sloTyfy+hgVd2qiqLgHBcQ
 tF8iAmu0aPs69sP4lNZgGiQ50DccAC+mQiuNZN4tFR1mUbrLc7GixduwCqoHs/Zy3s6f
 7jiovY2pquG6Kf4FIxP5KwNmRKCwLQOoHUwWxipR43l2jRn3fS12Qidz/PBAcpn1FRnX
 5d5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9TQk6ap5Hc+tKeTR0ha+wXs3t6SrGzgTezMtCH3YFnA=;
 fh=TjSDHDexhxAlozvahAqSjH/1kZYNEUCZM+OUwnm2QTM=;
 b=YsbUernN9DcAnQLgDVJOjJPd+8IyQ1Vit2GRcNwvHFT6FwntoA6iI/hLkXlMhZysFP
 CKnH8nh6jbpiVmyIAEGvdJ9UFzyjW9O0zLCGxysEUcihYEHIXio83MGT/xAL5S3T+1wP
 vyWeMQpmYjS3RjPegFcN9EPdsjesEzidyT7rvSuBnlk11n0iYNdBac6UgnpVxjREbU+c
 nhmMrg2F+qAv6SyZAlCheNeUZsgdXwvHECvjlfkihW6Ejup4LQ4WTGxuBDeGX984BFbg
 HLVCKW5cw4D3wAwTuOhWFzHs8YvZbADKoJcHA3PiQkXAxPnZgqu41fpXua84Hazc4UaG
 5E0w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774549636; x=1775154436; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9TQk6ap5Hc+tKeTR0ha+wXs3t6SrGzgTezMtCH3YFnA=;
 b=QMzgHmoTlKyIBXhaUYgaeU0Jg89LPNsp2qUh5kCHB19fSSx4mBJX/keEGGdsSUREeE
 //zZ0Zeag0hX+pQ0RouNR6K5kuDJJK/gm5/qVNa3PyaOrinI8dfmjmHOlFrjRwISYBnq
 rj092bCv1TsZCL9Q/1uPvMfEB2uVm9VOBigNCAZjIjy/voWgc78dsMUvl5Iu/41gANmE
 /Nh+iW09LHZmsgQnba5Gp64683Ep7aA7CrfAiNm9u4BuGzWBf9dkV+8POKcASv3n/b5S
 fDezSsVXwIo8AHwohgtgdW5rFs0rlLOvuulXqB9e1hSTTREO6QVqSZH9vhD2ov8KfKiN
 jD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774549636; x=1775154436;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9TQk6ap5Hc+tKeTR0ha+wXs3t6SrGzgTezMtCH3YFnA=;
 b=NipIyImsdIrVrRaSAs7lk1DW/RT2PLn5tp/peinI4XGq6YncychWchNrQyrZUK9OZJ
 5wrx2OuFz19WG64ekZxDPZ19VZ0qf6pMWefXBd2CeWjM03BuwKvX6bf3+JiR3gTw4DqH
 Ibpt3EFq5lRc0ynPHFPIiqmY28f7tA4rouMnX1IbEya3EVfrsHtMuBS+dZ02lBzGe6k1
 j8VVYbrpjc7dB/VK16hFEOrOfb8+uuYQ7mZqDF88QEkncfjRoPURaw3dCQ/CLOQCKOg9
 4HjRBF1UkDqEQi7xcPiEv9xvAjz8ro7tPwcxqslHjlHQJgp5mvNCj9QqZHFdx8i1kcJu
 zWlQ==
X-Gm-Message-State: AOJu0Ywjd4C2u6Rh6hxDX7GUSm53YsYdqQMglcs/Qr7dz72DcFEMrf5p
 icgejL6VwHdDZHrxAujJDIX969sxwB5iOWjJe1qt8eGc0DTeGulQfWEGYHUOI594xUv5fhdsFOc
 1thMnQum3f21gWIkHtvz3fNCnSf+5jIs=
X-Gm-Gg: ATEYQzxh664usCCLQjZCBv3biUMl+dBBhNmKwr0KiTi/k16pfJQFr4MWnrg8dhadGnR
 jTjsL8j0V3szVOB4zXc1p65+gdJthndx3BW0wUsiwOHRwVzmTBS2mZb/k6zfCmK0b3FLvGsybH/
 EEjJHCuKO3eX52wBIAunhwFd35urxuBbOczU5y6DuuR7NGjQdjfpXtM20ZRPFiNaBw3x+MlegG3
 GQADhSNCshWqyQ4CsF9Bw1aelpzWadJ/UFBMOGY+iaE2tORItMVggzNYOuOSpzda/RNce0ir1Is
 vnFOObT6HyMbbcgOub5FcIdm//rVjVhQBFpxuidOur9UKUndKPM18X11n1eH584GY7ntKw==
X-Received: by 2002:a05:7022:2207:b0:12a:6ab6:8a64 with SMTP id
 a92af1059eb24-12a96b85110mr2269682c88.0.1774549636096; Thu, 26 Mar 2026
 11:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260324175653.1325754-1-Amber.Lin@amd.com>
 <20260324175653.1325754-11-Amber.Lin@amd.com>
In-Reply-To: <20260324175653.1325754-11-Amber.Lin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Mar 2026 14:27:04 -0400
X-Gm-Features: AQROBzCKDdRiv6B7CZFsHBEd5tf7g-oHEuMgyTRxEyqd3fOJykitlQHQC8N9DEM
Message-ID: <CADnq5_OSYSSabpXvTbCR_7C4inTm33L2ZFFbengM+_zvK+tNLg@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] drm/amdkfd: Queue reset support in KFD topology
To: Amber Lin <Amber.Lin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Shaoyun.Liu@amd.com, Michael.Chen@amd.com, 
 Jesse.Zhang@amd.com
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

On Tue, Mar 24, 2026 at 1:58=E2=80=AFPM Amber Lin <Amber.Lin@amd.com> wrote=
:
>
> User mode compute queue/pipe reset was originally only supported in GC 9.
> It is now also supported in GC 12.1. Report it in KFD topology.
>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_topology.c
> index 1ccd4514d3ee..4c52819aef9e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -2027,6 +2027,7 @@ static void kfd_topology_set_capabilities(struct kf=
d_topology_device *dev)
>                 if (KFD_GC_VERSION(dev->gpu) >=3D IP_VERSION(12, 1, 0)) {
>                         dev->node_props.capability |=3D
>                                 HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATI=
ONS_SUPPORTED;
> +                       dev->node_props.capability |=3D HSA_CAP_PER_QUEUE=
_RESET_SUPPORTED;
>                         dev->node_props.capability2 |=3D
>                                 HSA_CAP2_TRAP_DEBUG_LDS_OUT_OF_ADDR_RANGE=
_SUPPORTED;
>                 }
> --
> 2.43.0
>
