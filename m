Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F35BC531C9
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2026 16:23:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A27A310E484;
	Mon, 27 Jul 2026 16:23:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BM3TIEu/";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2167010E484
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2026 16:23:41 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-38ecc48b3deso210080a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2026 09:23:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785169420; cv=none;
 d=google.com; s=arc-20260327;
 b=LBffvARapO4JYDO8Qu/VmnkEseje6sNoGDzj5x7sXF5SfIl+ANkfsNi/R33SHuut9j
 FdhXlwJBH8akco2DkITkZYQqPKVWb9M+uztE7UOe+6fi0aH+MaHMf5e5ebUx94rlX/WZ
 8W7WU6awnbLKs9wFMKTR3sPEGeIBmhwUK5GgPII5VsOtPINWcOj5r8MqjsK+63Buy6TP
 FhZFwgUZb7wU4CdVDGxlgC0oBfoLP3I2tWvVSBYe4ByUsd1A3PHlWWbf/PNotzZo1WA9
 twUc5Euk1t/ustKsXsg993Fh9Qz/dDa0CuEE6KBNPEWoQLh2a92pSBNudALdzgZArXEN
 e/XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+8fk2QTJvJSGqmmKBTq23zF4KxqUHDJhkuBClvUFFHs=;
 fh=qt2Jeam2aBIg9cw5W5yJM5RrGsLrjwspF9kOcqFxYSY=;
 b=K2zk4RmueUtn+S/TD+j6yjQch/vY768Zsx4f82pYsE+1/PQSoHoIwBphl90fanoZfT
 RpQhGnkqCt3uQaR3tMuBXW058DTn6exw0xDNtUb75jIbAphIYPpM3b7me3gR3ZpuW3P0
 rmOsykUI4VrXkHIZhem26e9KRzj7eBU+UuWIgP8xfmioMtw3CVUyEagmPP5NypdezSxg
 soSka6e4B2igy3pgt/yk3JG9wYhUKP4ENgiLR7aD+JHSTfau3urTIUleXv4QUdc0fz1T
 W3lhvsOg419Yuz9heqfejh1fKrhpG0GJRvqYORI1FjuM0x/ferEt5zRGWlxzHSq/+4Zu
 66Wg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785169420; x=1785774220; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+8fk2QTJvJSGqmmKBTq23zF4KxqUHDJhkuBClvUFFHs=;
 b=BM3TIEu/M8aguypqg7148X0z+EoI2viuoBYyde5WduLYTDcK/s2B701VqN9j59gNb2
 xRww+buSFs7qYCT34JWsDYXqcygOJuFQqv9i8gTfnC32p8+jUiSYdXxfhkJpGLCt1iOw
 M/p9yMDbLaq1oUiWsGlmsOKrQWDaw+EPCIX9ZxY2NcTClqbQOTCXpeMLJskMMTbFJTTh
 Mu+m9EpmIf0/+Dxwb4Lg0mzGwleOFkEq0lPML7tu71/uXWFm67x9smaRHTgov4o3g5Ob
 FHmamdG8tGx/4l7JcBdtrc3KJd7skBvguFbvktlAaawppV4iwzee/m8WIDn0ruDua4so
 zq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785169420; x=1785774220;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+8fk2QTJvJSGqmmKBTq23zF4KxqUHDJhkuBClvUFFHs=;
 b=SPRs9lLxquHw0T9AG6DxvleopJQCx81KD2Yt7D4rJHRn8TQ406TyqeJvYFBwmcV4fg
 DMY40IRLk0JieB3jBc0bA+yTzRpckqxZZNRQNC9H2+jN29k1Y3BqWQhKAz7RXnMqUImW
 b2pRzg4jIZ1PM62c+x0K9kJFPtx/fDpnO592ClbhEjaFg/eVPoZlLloaAycAvITJr4yJ
 TYuu2kaS1x/0Z2Iz8G6aNYt7edktRC11g+bLVc03DS+9OnNcyYFFG2PUK4ZATgrze2Ly
 nhzZ1e9+tVR170KWot0J09pRsOE9HRxI37SVCyXH7LfLGSo5p/P0f0RZg8vW3hozTIZB
 FMqw==
X-Gm-Message-State: AOJu0YyzHXX6hf+FgSC/00WDs22x/vzQoTS3wMialg07qngcadw/le9/
 iknID2ECeVAyDVxcHGziFQdlwNWcMKB72kfFdyl3sDhd/E5CIBM8kVhruRBi+dY/v2BVzth/2dB
 efTQFb/5yeDc92CFVAyS5DD82I0YOYSs=
X-Gm-Gg: AR+sD11Ezoj5DkxQhUSB1DQSVGTZRhHx5xNPPfO1lbng3t+Hb/daoclBLZ10DIx1L//
 u7wQz2EHfOKHoDg9fQB68FVX/VE1mo3feqImmJtk2ANu6xf5/mElGdW+UYEHckDsZAd5u6EEcEh
 pm3vN98AmjQSzrRj2UQMjid76TaStwx0wKOMljM4CDd0bmp8qmpEdJqhvB7wVuH+PQEO5oBHo7e
 YYX3lr4sf87RmuYSfZR3MuFk+0ZeIZ5b6Hpe6mraAeJOJQAQUS9ezh8dS8h7zdflQT9Xp9H+iTD
 OslgDwZBW05qfixSi2G0YzcbM9pwqUKoX6vPEF8ctAoE04w4uTRHDbGEVFU=
X-Received: by 2002:a17:90b:4d91:b0:38f:57cc:6a75 with SMTP id
 98e67ed59e1d1-38f6288f301mr526418a91.5.1785169420216; Mon, 27 Jul 2026
 09:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260721140131.10797-1-dev@deq.rocks>
In-Reply-To: <20260721140131.10797-1-dev@deq.rocks>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Jul 2026 12:23:27 -0400
X-Gm-Features: AUfX_myR_tMMkc8Mp04aSGWuKAiaTBCV-XlUavhJPbNrb8ejcyIca6YbNyPETYg
Message-ID: <CADnq5_PYT9GCRK-Yb8urua4Diknh5e+SRJOs6F4fEfPsc88gxg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: reset VI ASIC on MacBookPro15,1
To: Andre Eikmeyer <dev@deq.rocks>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 christian.koenig@amd.com, me@freddy.us
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

On Thu, Jul 23, 2026 at 4:24=E2=80=AFAM Andre Eikmeyer <dev@deq.rocks> wrot=
e:
>
> After S3, reloading amdgpu on MacBookPro15,1 systems with a Radeon Pro
> 555X or 560X fails while loading the SMU firmware. The existing SMC
> register check does not request a reset because the registers do not
> reliably reflect the stale SMU state on these machines.
>
> Frederick Morlock found that forcing a VI ASIC reset allows the driver to
> initialize again. This patch limits his workaround to the exact PCI
> device, Apple subsystem device and revision combinations used by these
> two GPUs, leaving other VI hardware unchanged.
>
> Suggested-by: Frederick Morlock <me@freddy.us>
> Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
> ---
>  drivers/gpu/drm/amd/amdgpu/vi.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu=
/vi.c
> index a256320b92f3..320c43143e5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -1407,10 +1407,30 @@ static uint64_t vi_get_pcie_replay_count(struct a=
mdgpu_device *adev)
>         return (nak_r + nak_g);
>  }
>
> +struct vi_reset_quirk {
> +       u16 device;
> +       u16 subsystem_vendor;
> +       u16 subsystem_device;
> +       u8 revision;
> +};
> +
> +static const struct vi_reset_quirk vi_reset_quirks[] =3D {
> +       { 0x67ef, PCI_VENDOR_ID_APPLE, 0x0190, 0xe3 }, /* Radeon Pro 555X=
 */
> +       { 0x67ef, PCI_VENDOR_ID_APPLE, 0x018f, 0xc2 }, /* Radeon Pro 560X=
 */
> +};
> +
>  static bool vi_need_reset_on_init(struct amdgpu_device *adev)
>  {
> +       unsigned int i;
>         u32 clock_cntl, pc;
>
> +       for (i =3D 0; i < ARRAY_SIZE(vi_reset_quirks); i++)
> +               if (adev->pdev->device =3D=3D vi_reset_quirks[i].device &=
&
> +                   adev->pdev->subsystem_vendor =3D=3D vi_reset_quirks[i=
].subsystem_vendor &&
> +                   adev->pdev->subsystem_device =3D=3D vi_reset_quirks[i=
].subsystem_device &&
> +                   adev->pdev->revision =3D=3D vi_reset_quirks[i].revisi=
on)
> +                       return true;
> +
>         if (adev->flags & AMD_IS_APU)
>                 return false;
>
> --
> 2.55.0
>
