Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EC8EA7940
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 19:21:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFC2210E758;
	Wed,  4 Feb 2026 19:21:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F5vLh8NW";
	dkim-atps=neutral
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E577D10E758
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 19:21:30 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2b700c7d3c2so1019eec.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Feb 2026 11:21:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770232890; cv=none;
 d=google.com; s=arc-20240605;
 b=H7YyfH5gSNzqTYBxY5BvGa6hIkdJtpgUW8XnW/Yv4PFy4/MFtM+08NGnrBb0zHrvD3
 hPiZhQfSpkfxW9lIZwfDOw8qGe0Fxeb/FAKxWbYduL6nfhVST4eG/WThWGC6U+Yl5Ee0
 pk/Aof1PatZcaveSwzEKOFVyETJjbuCjNop40Akz4Vvc++7IO0fNsnFAY0wKEoQ3yHpQ
 jl5cji+80Bpk0L7rMryBgtUYqAryOTC2Z9TmOC0ip5LzmNb9GAKfPft6igXrrg0bcNFK
 DS8orMfntGFugQdS0TgsWhZOs9DPWHgYdqYnbNOLRBUutErgeVbwNMfOl/vbiUxJzKAL
 Krhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VRs+6ib+pyZJCRELSvDQF8bopbek7tMEzD2GA9WtclY=;
 fh=cFVSG9QViS0DAdmrkqn6AOJFRUYWBKioKm2zCjnsYhM=;
 b=cTiidaO4w8lCryGd5Tt7PtlK4gprIiy47hUrQ3+q11T/8otpLqKr99WrlEh8yhlNm5
 ZTDGhL3NW/8gF39g7ebx3zwcVDNVozIrcrrPWNJ71pkWYjkPNd9no+uKt97xb4SjtZ+Z
 7IChSG6xLEUinkR2DAuV8+tEq4rpSouerK4Z8jJBBKnnrLjFSxF+0gTzAwn8pMRPA23l
 noiD65qP8kmG/vBHvwYGPzcyCs2VSHnjfL8MUKMvIjMZYZj1xdBBQhmgF9ZlNtOh5y8S
 fyEHQi66MJC4l/c0g/VUKjh5smgzm/jjuQzZkOFV8lJdVz4IsfCxWf0x4DFTQYrR8W17
 gCVA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770232890; x=1770837690; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VRs+6ib+pyZJCRELSvDQF8bopbek7tMEzD2GA9WtclY=;
 b=F5vLh8NWa2sDlNHlg2ZrMirkkJ2uexWSut6xzJIT2Q6hKVXa2iYGql+V4EpcCDfCwn
 ZXaScHrtgActf7ReMy97e/umIblsjn1DIXzXGIBYWR9CS9ONFKpQjSQ1Bol8LmiPuW97
 mZ28WwLH0w9M+DCeHP9+M6FM4DQc9/sYo8c2SxoR3si8g1kZ2HQqvQ8GQrRwY18WdBD6
 SR1YSd1HvS3+xf+m0oLqjJpxofHsywXWoihXZapyFu2rW3BjD33JCQ+jazHp4KGcw47Y
 Bh1QW659V3bCrTZi88XY/aaCRp6+YF/9OaqncBf7tJBZWZ/+rfIuhZZj4eJaCFX40dCR
 TeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770232890; x=1770837690;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VRs+6ib+pyZJCRELSvDQF8bopbek7tMEzD2GA9WtclY=;
 b=reNxu2CfLyjk8KlaHEc4l9z2hDdUblLBepErAUcS5mXA9OSDP27KVMlX+4aZuXY9qO
 o1bkQ1hHx0EnAVqp5DiqrYzphJKaZXThHqCyf6CdbeaIlvhlKIGaC7VMsde8VfJuQMvo
 RCwunU7Uzio9bvzKT3jWBgrj684YPNE4A8lvWQ6lX183hp4Cxu2Gz6Gx6I8MkvymSi/j
 cisS0JUBFXZmBX7B0ScNe5R83mIR+FAAoj+ooJCoJ1uYl9azzPnw0BCgPNLzvpB+Ljb1
 M9roeVH5ykMXDMXQd+hJSX/DCs1uCpR2+plMgdzCV69ZgDBIQbSPi0B1/6tIzrmYITjA
 k1KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXL7MJPsJhcerl1kV/LW5E5isMJ/k2rckEGlk0QFTzHL50i16bRQracuRUuo3WBB8lgmzmlySAs@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxcfkaE3qgw3JnTQ6By18sSBnuIeXGyxkHKbvAQqqK/lknSNsYd
 WAPaip7TrG2hBxxTdNOMhR9rIlnRmFs7JFaBlCAh3Dt0MBHcSavMSd89ntQ38A6t8DBM0EbYm+B
 agtCsykx37FKcJRFzAPe/AiAqNMJvuV67SyMA
X-Gm-Gg: AZuq6aL2Ck9A+KZHMgyc+4PoRkEk/cCdVO/Z4CQcgceutqGl/wD+fJU8E1zfnL75ISD
 2oUmRW9/CreHgZreHfz0YqaYpf+rnprj0/sk9HCz8AdTBH1xpv8wpBzMmtiFC6bdT8PBaCxVPnL
 htCBh01acbf2qpmoGAn6Lfw9BOtTGxoy4Tsc+GZEM+qYjJ5NvcX4QnGFLdYXJwiiyl648jmSMjI
 F9mqfaR6GZTh5MuW/G/OrW9zVy9aUdlotPBp5USsw4fKDRLyOOm+YSJ/DvoqN5QqIUCrzKu
X-Received: by 2002:a05:7301:290d:b0:2b0:4a1a:657 with SMTP id
 5a478bee46e88-2b8329ad9c4mr830520eec.8.1770232890089; Wed, 04 Feb 2026
 11:21:30 -0800 (PST)
MIME-Version: 1.0
References: <20260204044338.96093-1-Pratik.Vishwakarma@amd.com>
 <20260204044338.96093-8-Pratik.Vishwakarma@amd.com>
In-Reply-To: <20260204044338.96093-8-Pratik.Vishwakarma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Feb 2026 14:21:18 -0500
X-Gm-Features: AZwV_QjOFPdFH_o-xc0i6bphB38jMjGb2Y0o8kcESzL4wYXBmbMwNWAQ1GYPuPw
Message-ID: <CADnq5_NMM+Gc=EVeOShDDmzOZNSgkx06962y=aOSzfSPipvKvg@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] drm/amd: Drop MALL
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
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

On Tue, Feb 3, 2026 at 11:52=E2=80=AFPM Pratik Vishwakarma
<Pratik.Vishwakarma@amd.com> wrote:
>
> Not supported on SMU 15_0_0
>
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c    | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> index 7331c7559454..140e5b8c0489 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> @@ -58,19 +58,6 @@
>  #define mmMP1_SMN_C2PMSG_34                   0x0062
>  #define mmMP1_SMN_C2PMSG_34_BASE_IDX                  1
>
> -/* MALLPowerController message arguments (Defines for the Cache mode con=
trol) */
> -#define SMU_MALL_PMFW_CONTROL 0
> -#define SMU_MALL_DRIVER_CONTROL 1
> -
> -/*
> - * MALLPowerState message arguments
> - * (Defines for the Allocate/Release Cache mode if in driver mode)
> - */
> -#define SMU_MALL_EXIT_PG 0
> -#define SMU_MALL_ENTER_PG 1
> -
> -#define SMU_MALL_PG_CONFIG_DEFAULT SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALW=
AYS_ON
> -
>  #define SMU_15_0_UMD_PSTATE_GFXCLK 700
>  #define SMU_15_0_UMD_PSTATE_SOCCLK 678
>  #define SMU_15_0_UMD_PSTATE_FCLK 1800
> --
> 2.43.0
>
