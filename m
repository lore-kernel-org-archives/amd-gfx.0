Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A988C369AB
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Apr 2025 14:05:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E227810E038;
	Mon, 21 Apr 2025 14:05:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R29RigPG";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDB9010E038
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Apr 2025 14:05:16 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-b0b229639e3so366017a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Apr 2025 07:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745244316; x=1745849116; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NySWxw8BSHoAHserl8IWoiyPc8iBvFJJ/HuWA2ZYEtM=;
 b=R29RigPGP07kdPrPvjEYh1THzDhxBvLjuq35pC6NJ7g2JTCbffz6f5A8LcTDY9ljFy
 M8moiVdFvRAevVJZtCIAjq+hou03kMDpN4FjF3dsuqNxSw9dzsDKSM58sQlSLhMM6iYK
 uCojuLXMcHHGKOmrngVhld01HXgOekk6v58KNOs1F/Yt2etJFBU9EG7MAgpnw+DEiVD3
 hIlSkHhrUfo0vDFWaWNEeaXxCBnvD1fqg7KNJe4/kkS8m8VmXogcdT2KoSFytYySxEUc
 taTAXStnW6WVpzXP9MaJKEl8EUCTSR0idDbaPcl6+k4St7PZsHNRek9nc4suFQzeew9z
 IYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745244316; x=1745849116;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NySWxw8BSHoAHserl8IWoiyPc8iBvFJJ/HuWA2ZYEtM=;
 b=K5+YJQevONElDHrL4x/2dABc9JLu845d4SOFXUoyuvRqfbi1EUoXuicpaYVyTUBo9g
 OAczEkCMMI5suRrSANnjRF8vOA8x42xMlhi9HA7cDA9CxZKqdXFcil+PEIICGEbrVf4l
 hEmyKumpty21YEBU3uadWcylotcW/ORXHLsmHZqtXd4papBqGcgPXfzkxSkod+T5EVt4
 tkxebTbE002gn0CeD6gN6VZpq80y9lHienN0xTk5XIFzLdcyHBbDAbHT/9DkodRTLlIA
 h/qHqkZgIxd1xAsJKE4itC8gO0WsPz2jON6JU2710uS7yQvE3Qs4IS55W8C279IuA806
 kCFw==
X-Gm-Message-State: AOJu0YyVnbOy5N7f3cAhfVrHmjB4Zq66bMpCRD0MAqWKBSBAaps7pjid
 4omJqks+YmWdsYeGr5jw+wS/DlkArLLh9DtNc5QTi4pBvASgamXXwwnJLXBrxqQUBgI7ea/Gr8u
 UQ0MJ4l0R2nU1Y0RNBOOHP2B2pOrqwULp
X-Gm-Gg: ASbGncttM+PFQ0d7lzwxX1Zs15nV9gs7zOrmfFGBejWFJpb2g5uGoz423weTHIRQm4A
 vLiIsSppIF+e9/LVMPiInW663P9A5zc9ki16/S/GMFPLmDv4bewqkAVyNCLbNAFvwXqxw9J9EKD
 mELzEDWpkuXiF/09pH/U2vPA==
X-Google-Smtp-Source: AGHT+IFXQxnMV161zqJ3sMKH+Kzij4I8Qwcu7sdyIeI5yRGZuttcdfdL6xYLJ4W3uGhjcuwHX6gHZNX7koUxU2P2U50=
X-Received: by 2002:a17:90b:1a8e:b0:308:7a70:2be9 with SMTP id
 98e67ed59e1d1-3087bccec8cmr6297347a91.8.1745244316305; Mon, 21 Apr 2025
 07:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <63d93ed2-1ace-430f-980d-27199ffc5b3e@tnxip.de>
In-Reply-To: <63d93ed2-1ace-430f-980d-27199ffc5b3e@tnxip.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Apr 2025 10:05:04 -0400
X-Gm-Features: ATxdqUH2gTWoeCiaUoqsuFouJDf-cCOcWkRQyW_hGMpZ3dGCwc1TXJoCPiDqfPI
Message-ID: <CADnq5_Min768rhwer=NaJrjocwu9_SVwEEUdbDfV1AjTiL5kiw@mail.gmail.com>
Subject: Re: possible bug with RDNA4 and AMS
To: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>
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

On Mon, Apr 21, 2025 at 5:43=E2=80=AFAM Malte Schr=C3=B6der <malte.schroede=
r@tnxip.de> wrote:
>
> Hi,
>
> finally found this list, I hope it's the right place for this. I
> recently swapped my trusty RX 6900 XT with a shiny new RX 9070 XT (aka
> RDNA2 to 4). Now, when I start kwin_wayland my desktop is a flickering
> mess. As a workaround I can set KWIN_DRM_NO_AMS, it is working with
> this. Afaik this disables the use of atomic mode setting. So I guess
> there is a bug in either amdgpu kernel side, libdrm or mesa.
>
> Versions are kernel 6.15-rc2 + drm-fixes-6.15, libdrm is from git
> (2.4.124 fdf384d4), mesa is 25.1-rc and kwin is 6.3.4.
>
> I am happy to provide debug, but I need some guidance to it.

Please file a bug here:
https://gitlab.freedesktop.org/drm/amd/-/issues/
and attach your dmesg output.

Alex

>
>
> Regards
>
> Malte
>
