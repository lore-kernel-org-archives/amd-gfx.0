Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212F5C61DA4
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Feb 2023 14:11:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC3D010E4E8;
	Thu, 23 Feb 2023 14:11:19 +0000 (UTC)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F95910E4F0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Feb 2023 14:11:18 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1720433ba75so15721619fac.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Feb 2023 06:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ww/pEUKLptfo92seieie/JGpHVePI5k02dUXC8wNY/g=;
 b=oMAqrAAMmuVs43X6NoKaC//idiPqHIhDJ8R/uvsu5tIbDu31iasmYRgNQp3VGqM0Bc
 ESlg9chvEant4jAT40Ig3brx8rj4jUctUe3JJQB9jW/k4HSGDi3fSKqV29QFXZ7AIIJl
 y80vnQ8G7DnhYlT3dINzp7HUvFawCJcFft/FeVMC/AELOtOZdNUkPYafDFKQcYAUbSZG
 9yTNK/p0lERHfC86HVHA5VUhvJl4NRF+QMcWrymDIfhfuCZPPpN08QGWXHg3LuWJfDBH
 rDIk4ZyhbJJwPuRiCadnrWXNAoMR8bGaN0sfv46yKftxrXYhEQ8xEXD70UGZy0fJou46
 h0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ww/pEUKLptfo92seieie/JGpHVePI5k02dUXC8wNY/g=;
 b=rsvbdPbRBsRHmYId4gbuP3SW/CyA4fatJpBxaXzJn70khPDrQIYgmPAi7as64Juy3l
 nUUEnQtYLBNM9x3OpS/mqgmGw6sKZB4uBMdLJMsgIYkrQjUdmFsJI/OtoodDMKAmqHMh
 qJ4NbDnzeHhJdxZgSg5xbgkZBD79GoQdMRdsr3F2UuT2h9vqTsvI/tmMPCnE8L32yI4N
 i4J4MOCDWH5zO2lKujrxkEow/hpvLt+W79YLaIHl03CMpWT6C5a2j+AFgpBY+Kl2UcJv
 VdetEVbn9odVguUgDBRQz+5Cr0FYZ0J3Rwi04CbJe4FbxjUkUfDB4k9X9TNSALmGh4EQ
 EYIA==
X-Gm-Message-State: AO0yUKWAfzqamYHODYBk3G7ObzqmfDRhhTWFPlKbL/G4CWiHlFzYNKY4
 vEEaV6kC4tBgCM04ITyfb0i5QfAnyKUaHXJR1A0=
X-Google-Smtp-Source: AK7set++lStuPgEKMvVbeJX0a3aiRpG2Ugus7fR7dAiW9KxVE/wCu+2fHG+F3y3E1VN9gwT/ZBh620kEr1Fmnc7prxc=
X-Received: by 2002:a05:6871:6a0:b0:172:3bf5:2855 with SMTP id
 l32-20020a05687106a000b001723bf52855mr1120238oao.96.1677161477096; Thu, 23
 Feb 2023 06:11:17 -0800 (PST)
MIME-Version: 1.0
References: <CABT+NQHh6t1X6fKmy4A0ULyTD5tTXT-quyTfRyq8Q7c87T7cVQ@mail.gmail.com>
In-Reply-To: <CABT+NQHh6t1X6fKmy4A0ULyTD5tTXT-quyTfRyq8Q7c87T7cVQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 Feb 2023 09:11:05 -0500
Message-ID: <CADnq5_NEWH7oVV47g3BvfKRX6DBLcGiQR=VnNmfotfxQ=JZ3Gg@mail.gmail.com>
Subject: Re: Subject [PATCH] drm/radeon: Fix eDP for single-display iMac11,2
To: Mark Hawrylak <mark.hawrylak@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Xinhui <Xinhui.Pan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I've applied this manually.  Please use git to generate and email
patches in the future.

Thanks!

Alex

On Sun, Feb 19, 2023 at 12:02 AM Mark Hawrylak <mark.hawrylak@gmail.com> wr=
ote:
>
> From Mark Hawrylak <mark.hawrylak@gmail.com>
>
> Apple iMac11,2 (mid 2010) also with Radeon HD-4670 that has the same
> issue as iMac10,1 (late 2009) where the internal eDP panel stays dark on
> driver load.  This patch treats iMac11,2 the same as iMac10,1,
> so the eDP panel stays active.
>
> Additional steps:
> Kernel boot parameter radeon.nomodeset=3D0 required to keep the eDP
> panel active.
>
> This patch is an extension of the commit 564d8a2cf3abf16575af48bdc3e86e92=
ee8a617d
> Subject: [PATCH 3.16 100/192] drm/radeon: Fix eDP for single-display iMac=
10,1 (v2)
> Date: Mon, 09 Oct 2017 13:44:24 +0100 [thread overview]
> https://lore.kernel.org/all/lsq.1507553064.833262317@decadent.org.uk/
>
> By making a contribution to this project, I certify that:
>         The contribution was created in whole or in part by me and I have=
 the right to submit it under the open source license indicated in the file=
; or
>         The contribution is based upon previous work that, to the best of=
 my knowledge, is covered under an appropriate open source license and I ha=
ve the right under that license to submit that work with modifications, whe=
ther created in whole or in part by me, under the same open source license =
(unless I am permitted to submit under a different license), as indicated i=
n the file; or
>         The contribution was provided directly to me by some other person=
 who certified (a), (b) or (c) and I have not modified it.
>         I understand and agree that this project and the contribution are=
 public and that a record of the contribution (including all personal infor=
mation I submit with it, including my sign-off) is maintained indefinitely =
and may be redistributed consistent with this project or the open source li=
cense(s) involved.
>
> Signed-off-by: Mark Hawrylak <mark.hawrylak@gmail.com>
>
> ---
>
> --- linux/drivers/gpu/drm/radeon/atombios_encoders.c.orig       2023-02-1=
9 14:03:03.126499290 +1100
> +++ linux/drivers/gpu/drm/radeon/atombios_encoders.c    2023-02-19 14:04:=
15.449831506 +1100
> @@ -2122,11 +2122,11 @@ int radeon_atom_pick_dig_encoder(struct
>
>         /*
>          * On DCE32 any encoder can drive any block so usually just use c=
rtc id,
> -        * but Apple thinks different at least on iMac10,1, so there use =
linkb,
> +        * but Apple thinks different at least on iMac10,1 and iMac11,2, =
so there use linkb,
>          * otherwise the internal eDP panel will stay dark.
>          */
>         if (ASIC_IS_DCE32(rdev)) {
> -               if (dmi_match(DMI_PRODUCT_NAME, "iMac10,1"))
> +               if (dmi_match(DMI_PRODUCT_NAME, "iMac10,1") || dmi_match(=
DMI_PRODUCT_NAME, "iMac11,2"))
>                         enc_idx =3D (dig->linkb) ? 1 : 0;
>                 else
>                         enc_idx =3D radeon_crtc->crtc_id;
>
>
> --
>
> Regards
> Mark Hawrylak
> 0425 714 725
