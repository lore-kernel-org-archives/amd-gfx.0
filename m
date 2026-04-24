Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEC1FED3D6
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2026 14:35:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C08410F5D4;
	Fri, 24 Apr 2026 14:35:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fi2+pTVh";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AFFF10F5D4
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 14:35:55 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-12736a0147cso535124c88.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 07:35:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777041355; cv=none;
 d=google.com; s=arc-20240605;
 b=JszRXBFj+AqxoHoLZovSg9WtbT/sNVS1Zf91vhDn7f5ZiOgt6y3j26MLbKu2QynW0I
 RnUNtqcKqY7NlgiJxuqVECefe725fWk6PHPA0Wk2sPu6rduiNkOoitNJiMIPxU9UobgX
 XLPrIOWxNjaCHUb+Q9G42xOXEPfeBIrL7qTycEL94PnSTs0+bxfilzv5rIhNkxqH9IZa
 CtIhbVR2Smab3ePJ5j2J95LpQIsK1xAnkn/2HiigZAsAozQqK3tMWInd753mO2mt1p1P
 88LqLpkzXVN1CSdlLu+nV7GERzjuKxzqVgmx6Xk2pocdopB5GrhFjFjICpRzwM5GuCcH
 sW7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cajcnwfU92lMTp9xFina6lZRBTJ8PyLL8/WwHmKLwWs=;
 fh=mfQLJlQ1hC0n2Ib9V6AWRWUCc8qDOp0nhOZ+b5bi1x0=;
 b=IZ9zCOc51yM1ZrtmRDyJLzqnj18MmdTk+BVDZAqi1LnaufIV1RqInBYGTzlX833dPU
 GsbdUL3WZxOsfPcQlOk7jS/A3k29Gt+euZ/eoXSMAtyl9IbFCUXit2PfWej2gpbNdw4M
 iWBRkKj8xpVHpvcyxIauGKg6h+DWeBo/l3ot3Kuh6sgFppycyc+SJ+hL6hBtABKhnu8j
 GEUG94ZvODb4xfpYXvuFKKipfLw8gRVlzXKA0zq/z2jXXLfS/mUsKtaCmE9CCs080YFR
 gPbMOyez0xPld3BNH8O4Gvvt/c4F7fgvPypk8j15rUjOnBdDKwtNcMOxa/P44ReyWIdQ
 zBzg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777041355; x=1777646155; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cajcnwfU92lMTp9xFina6lZRBTJ8PyLL8/WwHmKLwWs=;
 b=fi2+pTVhlza5TqV32OinfHt05p1nDOH4JZucLLpJQOhQ33hfoc/Z7Bwh/EiJBRsAy+
 16jPMsQfzMk3q56xbiFLXj76kqnnIdD3lkNjSHqmfrTPu6a0ML+wUgjOBD7ockAUsRQ2
 KJWO5ku5HIkNVPugNtULnBo/bpg78oW/Sl+HhYXnx1OW37hS1Ttc3ru9DleLKF7JVMnL
 SK6EHCbooh5fUY/meP2ON5XRBewWmIkWIEKzzxJZjxUIxTVRz6eHVTQONqALxiP9p06j
 MNAd3zRjA34XgGuYdoIChk6aFulCkgCIyt1KqYAn81TRqu1GGIdiwj6S0UM43KfBRboE
 JyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777041355; x=1777646155;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cajcnwfU92lMTp9xFina6lZRBTJ8PyLL8/WwHmKLwWs=;
 b=Xelz75rl5VmXv/JYb7CIAyIiuxQVebJplbfK8+B3Gw2JiR8fS59SS1bWb6Ov4PlX+U
 hWfQDR3/NZJHWrIv3BF3v90GCPwy/wQof9C0KNJvaCJ89BK9teLhBxTdHI6w8RZ0DDKO
 XCWzNj7rymqIxMlrpDq0cF3U09+8NYXF+C3O51Kbi0CVHqXPDAJlJOP6TSnU3JtFpSKF
 2xKRSNM7BnRdGJfJ+EJVluc8MvCQs1hQDbEGr29qCZobjnE8+ZqgM1sQ5ioewhfGs5WV
 rzYAhLdhVnU9wkTp/IEG/Rko24TPpDA4lKsnXsiMHwmsOddxqiAl8u7IGF2Iof1f+mIi
 fTxA==
X-Gm-Message-State: AOJu0YxdTkKSlgfvotmGlNJWW75SrGDMRnfX3n5TxJb9eUn4Tr00ybmt
 YRa2glX7idPrs+f4701nFa0w3Pa5HAtuxUaEFyJHNetFpgCv0r1wMG3RAJs1VWB2UlhcrpsoSjZ
 z9s+fH5IZDxlK7CRxVGyhg93M/7BAGo73WA==
X-Gm-Gg: AeBDiesRohRNY/CR+rttF4OYWKqo0UUPONQLbveDHhzI0IeUa4hZeRIYmk+FnMXwUNi
 A4Yg/D8FoLzT4z/bOVl2JBnnLnd3IkBBNTkdOa9OgIpZtAhoWbqhBU6TjJIo9NyFNr25fOpoGLO
 QfKarANtPcSXzhc2q8LRhepBHjD2xf+3mPss92FIFsPyAA8w2EGrJfU95Hpz3TefPF/P/aghulS
 hUMH26aGVdhjbGnygdZGDY+EL9OvQPf43LnqgPPZqDBeSyHUwVMt2X1435/KQ+Ee3r7aP8Pl08w
 8ltodMF8SlpsWy34Ys0Sct6k+Y5vF5tsSePbTTOiGN/bUgvVzUS9FepgNbRkSSrmJ8clUrIsq3/
 +Gklv
X-Received: by 2002:a05:7022:6289:b0:12a:6cff:2e7e with SMTP id
 a92af1059eb24-12c73fa64efmr6383710c88.7.1777041354878; Fri, 24 Apr 2026
 07:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260424140755.2500419-1-IVAN.LIPSKI@amd.com>
In-Reply-To: <20260424140755.2500419-1-IVAN.LIPSKI@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 24 Apr 2026 10:35:43 -0400
X-Gm-Features: AQROBzAXwRQnF0bd8MX8hzSg-qn3dCSQuWdHXaECyh0MFPRnUs-34ZQ_z4aN36Y
Message-ID: <CADnq5_O=Q173PuDjWb2VaFciftMToqFvqW8XfRTCxjG9HeaSeA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove dead init_mcm_addr_lut call in soc_v1_0
To: IVAN.LIPSKI@amd.com
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Shiwu Zhang <shiwu.zhang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Mario Limonciello <superm1@kernel.org>
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

This is already fixed.  Sorry for the noise.

Alex

On Fri, Apr 24, 2026 at 10:34=E2=80=AFAM <IVAN.LIPSKI@amd.com> wrote:
>
> From: Ivan Lipski <ivan.lipski@amd.com>
>
> [Why&How]
> init_mcm_addr_lut() definition was reverted from amdgpu_imu_funcs , so th=
is
> function call causes build failure.
>
> Thus, remove it.
>
> Fixes: 21bd78c821c9 ("Revert "drm/amdgpu: Init mcm_addr look up table"")
>
> Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc_v1_0.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/soc_v1_0.c
> index d06953c237ed..f09d21738400 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> @@ -744,10 +744,6 @@ static int soc_v1_0_switch_partition_mode(struct amd=
gpu_xcp_mgr *xcp_mgr,
>                 if (ret)
>                         goto out;
>         }
> -       if (adev->gfx.imu.funcs &&
> -           adev->gfx.imu.funcs->init_mcm_addr_lut &&
> -           amdgpu_emu_mode)
> -               adev->gfx.imu.funcs->init_mcm_addr_lut(adev);
>
>         /* Init info about new xcps */
>         *num_xcps =3D num_xcc / num_xcc_per_xcp;
> --
> 2.43.0
>
