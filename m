Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781C1C83F17
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jul 2025 16:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2148610EA08;
	Fri, 18 Jul 2025 16:36:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LgFMIgUr";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E073E10EA08
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 16:36:14 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2369dd5839dso4544925ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 09:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752856574; x=1753461374; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v7jhr9KEkrEmzJVidZuDTsIZolpydddxqO6JnmAEKBU=;
 b=LgFMIgUrmtvbOiQfhP2zKFFdbLX6i+V5mT2N10T1C9JJyqw4X6th8gctmmZmZBIB9Z
 5ATw1Dvq5FubzlchezfqhrIMn2vwNQB9FFId75mpD1ocSrFw55GVl/SxAPaxZZF02KjV
 rXayN0AGUIl5IRhq4afXKh1BspVMFH7WY+RxFH2u+T7hu7VKDDzU6v5JKhTZxOmESZE2
 w4u9E7k7ikR4Iy3jNad3JTThVgGlXFCfOyHSl9qKtIc2FdHi+q6o9vBHPZf9b0sC/bbY
 TrGSZC2raItxWtScHuPtqodZuM2kbXIqL5X+ezE1FMtz4i+o68UCKf6fB2wpCY4HD9JB
 hHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752856574; x=1753461374;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v7jhr9KEkrEmzJVidZuDTsIZolpydddxqO6JnmAEKBU=;
 b=LGEhj9+HFuLrfOINEqCsX7uVKvYVi/vGucAlt5PDM+d+gjvX0C8LGVo0dIzpROOg6B
 VKxKW3+8Wudl7c6YwfQ3V8DkKoRCrpbmWHi5KIb4v/6C8sWt1iBbvrz/rqDJ20rQRBJD
 Bc0PuygpR6wCpqztLWRi+oQyO8otg9H5jtda9oY46abCpYw3kTa2MUdGatya1ZHOFBDG
 48LbaQetzj6KEFKtCV0+OUP/0szkYeBI2VZNKw/dd2dcuqY5E06Fp+zR2y8JewbmVmf+
 aNpYZz44Qhwuz4PmQOdNWkdZ71I4ejAT5uOdYkA6oubl3GmjxazOO5Ev1ZJJ7Cqt7O8+
 VZ0g==
X-Gm-Message-State: AOJu0YxahpE7yplGWVG+Hs7/uA8yIuxTog8oJ1tCFq2f2Wvqa59bH9L3
 5+Ve2afdoChCcWUkdDOhXkeDhijiPkItCBkFE683KLdR08+iGNURNQlj5kj09TsYBFUrU78Q4wO
 POtTTwsVjpmRNAXntJiXogw50/BWuup8=
X-Gm-Gg: ASbGnctqVbd6gQu0yzVlHg5U5mWG7vqFG31fKwOZbsANzVBnb2tCSISQbjOalk1uwAj
 Ep6Jb3bA+86P82vl/43f3TYinb8FPrWeO4Ngi88ESpHzmKqFYMSj2SNOBBcgh2Ihn03drfovEMf
 K9Bk2A1X/OYKA73oLHvxGkX32WtaF4uCa2ki9/rVelr6hYXOeNmD0bTa50E1sfELsU7SuIlvZq2
 Qj02dK94p0aKQuNKPo=
X-Google-Smtp-Source: AGHT+IH07nKLqgb5GI0e6+dYg4NFAW9DmQug2mgwvs6pSsPFZ3KzlxMnCa8V0imnyZeJZv53jVomA2FmnS6I6212SLU=
X-Received: by 2002:a17:902:ecce:b0:236:9302:bf11 with SMTP id
 d9443c01a7336-23e24fb217cmr65486035ad.13.1752856573875; Fri, 18 Jul 2025
 09:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250718154346.1565623-1-lijo.lazar@amd.com>
In-Reply-To: <20250718154346.1565623-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 18 Jul 2025 12:36:02 -0400
X-Gm-Features: Ac12FXwdW5oJ74EFGDcwzSefdaWl8pMZEVhspgNOFqnQGIHTJB9FiaIp350ucCU
Message-ID: <CADnq5_O1TKFs7u7jNJfFWsU-KCkhQ=CNnvHAX2+tJPjUmdctAQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Wait for bootloader after PSPv11 reset
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com
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

On Fri, Jul 18, 2025 at 12:23=E2=80=AFPM Lijo Lazar <lijo.lazar@amd.com> wr=
ote:
>
> Some PSPv11 SOCs take a longer time for PSP based mode-1 reset. Instead
> of checking for C2PMSG_33 status, add the callback wait_for_bootloader.
> Wait for bootloader to be back to steady state is already part of the
> generic mode-1 reset flow. Increase the retry count for bootloader wait
> and also fix the mask to prevent fake pass.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/psp_v11_0.c
> index 6cc05d36e359..64b240b51f1a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -149,12 +149,12 @@ static int psp_v11_0_wait_for_bootloader(struct psp=
_context *psp)
>         int ret;
>         int retry_loop;
>
> -       for (retry_loop =3D 0; retry_loop < 10; retry_loop++) {
> +       for (retry_loop =3D 0; retry_loop < 20; retry_loop++) {
>                 /* Wait for bootloader to signify that is
>                     ready having bit 31 of C2PMSG_35 set to 1 */
>                 ret =3D psp_wait_for(
>                         psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35=
),
> -                       0x80000000, 0x80000000, PSP_WAITREG_NOVERBOSE);
> +                       0x80000000, 0x8000FFFF, PSP_WAITREG_NOVERBOSE);
>
>                 if (ret =3D=3D 0)
>                         return 0;
> @@ -397,18 +397,6 @@ static int psp_v11_0_mode1_reset(struct psp_context =
*psp)
>
>         msleep(500);
>
> -       offset =3D SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_33);
> -
> -       ret =3D psp_wait_for(psp, offset, MBOX_TOS_RESP_FLAG, MBOX_TOS_RE=
SP_MASK,
> -                          0);
> -
> -       if (ret) {
> -               DRM_INFO("psp mode 1 reset failed!\n");
> -               return -EINVAL;
> -       }
> -
> -       DRM_INFO("psp mode1 reset succeed \n");
> -
>         return 0;
>  }
>
> @@ -665,7 +653,8 @@ static const struct psp_funcs psp_v11_0_funcs =3D {
>         .ring_get_wptr =3D psp_v11_0_ring_get_wptr,
>         .ring_set_wptr =3D psp_v11_0_ring_set_wptr,
>         .load_usbc_pd_fw =3D psp_v11_0_load_usbc_pd_fw,
> -       .read_usbc_pd_fw =3D psp_v11_0_read_usbc_pd_fw
> +       .read_usbc_pd_fw =3D psp_v11_0_read_usbc_pd_fw,
> +       .wait_for_bootloader =3D psp_v11_0_wait_for_bootloader
>  };
>
>  void psp_v11_0_set_psp_funcs(struct psp_context *psp)
> --
> 2.49.0
>
