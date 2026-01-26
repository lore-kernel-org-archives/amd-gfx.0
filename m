Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74B3D19519
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 20:49:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8393310E499;
	Mon, 26 Jan 2026 20:49:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fttVEuMg";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A52B110E497
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 20:49:10 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-1232de2e2c6so350844c88.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 12:49:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769460550; cv=none;
 d=google.com; s=arc-20240605;
 b=U73fGkaXhi6jnz1bXboIac+fk1agX0KRywT1QxZ8LDbcUsRdj7k9V2lqilkvKvBZ4u
 mR7Y3/H987xDnGYfRXX+mIvsJ7JfGZjeeLf9rwfX1p1+UOhLO9R/P0Z9QPwXLK62TzOV
 Eg8xmipsm3/wuaA53Kfm7iCgbhsT67bhWg04IZlQaBGytVa9nFIXJvlQaxc5JXpQ9Ifd
 dUUzW4dmuiy/t6SCL9uLxzy9q/vA/3UUgYRNZydU468X9KPRvGaTTzoYrJoMy5s8GanE
 d2GPh91VNZUGfP1NuhzOUCKkfKGqDVht9EqO9wBvxz0z0nA6U7wZ4OLWSDUfl50OuA6Q
 cIqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mlSiQsjBUkn1LmuPaTdTGefVpZqM9eTXpQgtTuU4iwc=;
 fh=r8edVz1Iohcd9y7mKMJRpuoGUat+E2AGo0dKv/LbKbc=;
 b=Laq7Kkzbcl+tm+UD4H/mnvKZBqLscKFNqdAGGbmUtC+W+ouE/E3H5UE8Zy38FOiU7Z
 InnplYM703pagE2v0F5/Lbsl7EXONSQS34WvY0/oHxgu7Brgszuejy7jAmd8LY3byOis
 5f95Q+5dMamKVK+5paNVIou3fmjhDIRqRP2XdV14kAGbtLa5OPDxudz6/yJXGxtgOWyf
 nZxZypIcXlrwVBDsd20hV4ZsKeFKDv99KGeP1r+dqDJswNWNcBSdQyCFsb/OsEQ/Mf/G
 lh7BiXq9NnPevy5F8KyJ/x26opM9a8F9jc89FVY5b/YDGKxouiex3vTRlP43wGD7Mlzx
 nopQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769460550; x=1770065350; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mlSiQsjBUkn1LmuPaTdTGefVpZqM9eTXpQgtTuU4iwc=;
 b=fttVEuMgz9OXfcXwS3mKuiDP8OcC8629m0OFiQm4pG1T/2Hw3rIlpR/8vym1ZuYjaS
 M1+5BaiuQZq5JGOVesM+jkdbhRAGEiBqXBoAx9ycP/9SmlLavAfCGN9VDbZFgiYb4eki
 K1hNJuxzodwu+4ymVGbk6sbzgATpIckOgizOKWZqYJYhVqIU1I/NJzXXxn2ECATK5ap2
 ierbP5F1MAvK+OnD6thJgW6cBXDEnMk7mA1yrTzEplFp3TvdG7s0ITTsxOe4XrwPrxlB
 MN/tUNcJOK1kzAWTu8S3U6UC5WX/mmafZMp+NoRGHiBQJV0LJBmb7BNi6myhj19MOLpX
 Ytfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769460550; x=1770065350;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mlSiQsjBUkn1LmuPaTdTGefVpZqM9eTXpQgtTuU4iwc=;
 b=U/fvROsv8xM0H4IhTBpkIXo+E2Sz1zo1XN/7v62uTlAckdukLp9U5LkNdwGPP2jfJB
 X9EGMbYg1WgdjHFMRDZSTTjtmcbdmbsUlVpg5ZiZzniCn0oZrJwgXS+WwLGYCDyt2hmM
 Ndty2LZuUdsLRmFhDYBG8AuvQjHwoTF7mJKB2FOVc/ACREmgp4zpxbHm6k9MVTxA4tz8
 QT3gT3IruNy85OQtM5/DUTf8WCnoZh2QOIsAUj2dTpjqg5zTX1s8ek/obT38kHuNO/jy
 31pPwH0kur2WQogVyhXoGJ3m8EUarrkGkIwEFYCH+Ikfx6+2aa7CYjWnyYX6AyA7opuq
 uOuw==
X-Gm-Message-State: AOJu0Yx4oUWkb5gitcL/3lilhCDNe49Vp3Pb7Kz4RuJo/undDQSo54nE
 LNBvo95SMdGGTXaEk7XiZMxRP8mU7tQ65PGKS/+phtRS0pqXmXWzHHWwaMfwEnsJL5yTpkrnl9F
 RSqFpjKDSD7ttdjNFrX6w5FkSwFynzLc=
X-Gm-Gg: AZuq6aJSM8H9f1kVog6DBajELgGIZaa0RatIGT4FUupQxrTyx+Co1WXGaYIXPaQ7c/V
 Z/SsvTmiYr5vnf6BvNUOVZBV5MGkV3N6AUwygZFwrSo26Hki2V/Vc57XKYz6Dp7Tihrh6qo4eH2
 OUX6ueid2liZxWqMVxiCM12hyx1+4lj0VG0IlkTzIqHw4NSaF10HnupP2Su+i+Wx5PHyoLGx4KH
 DqRaG5qGoMnB6G9BHmaf1o1Wa7uaaX0GfsQ5FkvTkdRFtCqtfK1jr4fXTMrXhkEzw7puzAj
X-Received: by 2002:a05:7022:670e:b0:11b:65e:f33 with SMTP id
 a92af1059eb24-1248ebe3ad3mr1357023c88.1.1769460549900; Mon, 26 Jan 2026
 12:49:09 -0800 (PST)
MIME-Version: 1.0
References: <20260126200747.13527-1-alexander.deucher@amd.com>
 <20260126200747.13527-4-alexander.deucher@amd.com>
In-Reply-To: <20260126200747.13527-4-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Jan 2026 15:48:57 -0500
X-Gm-Features: AZwV_QhPXH1Cf53nmS8sXiSmwYH5VINkNjM9CduCbBan4C6RzOeJng2ntAlD83Y
Message-ID: <CADnq5_O85fxWHXXcEqpJL9oE-QVLsbXNZkaP0TguBxom2zKpYw@mail.gmail.com>
Subject: Re: [PATCH 04/12] drm/amdgpu/gmc9: handle gfxoff in interrupt set
 functions
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Yifan Zhang <yifan1.zhang@amd.com>
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

On Mon, Jan 26, 2026 at 3:17=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>

Patch title should say gmc10.  Fixed locally.

Alex

> Need to make sure gfxoff is disallowed when we touch GC
> registers over MMIO.
>
> Cc: Yifan Zhang <yifan1.zhang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v10_0.c
> index 2568eeaae9454..7a8e86efdfe40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -64,6 +64,7 @@ gmc_v10_0_vm_fault_interrupt_state(struct amdgpu_device=
 *adev,
>                                    struct amdgpu_irq_src *src, unsigned i=
nt type,
>                                    enum amdgpu_interrupt_state state)
>  {
> +       amdgpu_gfx_off_ctrl(adev, false);
>         switch (state) {
>         case AMDGPU_IRQ_STATE_DISABLE:
>                 /* MM HUB */
> @@ -92,6 +93,7 @@ gmc_v10_0_vm_fault_interrupt_state(struct amdgpu_device=
 *adev,
>         default:
>                 break;
>         }
> +       amdgpu_gfx_off_ctrl(adev, true);
>
>         return 0;
>  }
> --
> 2.52.0
>
