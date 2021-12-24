Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA98FC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Dec 2021 06:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6963A10E3DE;
	Fri, 24 Dec 2021 06:16:10 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05A2510E3DE
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Dec 2021 06:16:08 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 s21-20020a05683004d500b0058f585672efso5039670otd.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Dec 2021 22:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ni22sztcJ75DQAOkpwUluwAUoovnN51lmCqseKIAA0s=;
 b=NvbT8lebUaFqjQup3aOTRz1DitXQq4hWUFFqKlooQxVgTLCI2rPFYA20Su8RniSO9b
 WnbTxaHAKigXTAWFPpHGm3tRCdPtQ6ezfthZLA9bcbDfzI02i03zDy1QhE1KLw9ong6Z
 NEfmzR2WpkAUKZEZsrcO3KB63iAkgjFJuuQqvyrlBkBCvRO6R0d5r2Dh7ZKA5gTmKAke
 pEtKtDBdETs0MKomyoU20b5PG349m9XNw16PkQdZF59dfGKqim1/cgSS+x+KxhC2oN5u
 MBEy0avFFkqgVHzqisGSr9NE0Y00E0J9Mcu3KKbb81xV1z1cTZzk5aQlSvA6K4W7aWq2
 D4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ni22sztcJ75DQAOkpwUluwAUoovnN51lmCqseKIAA0s=;
 b=26sjsNuDEqmb9fl8Cg13HUk0GLZxeMpd8WzAK9hFk0tOcq25+BiYt49hC/4oHZpwaT
 NvaZKdEMs3bOXbM1/5Fo11/OIIfwkw/qFMTBU0mWma8TPR0Ml1O3Ze0YIsTsNTHLv43z
 5Z55qioAz8WkaGwKCtz0uNhTbTNgBC3UrO2VSBLpJMji2ddDsIyOgO/gK78FslZeSXSO
 TH3czYcsRK0rDtLdRa6/7TYxkXeSM+1s5F7w3Ep49mpo872ohminQ1r+aY2ZFXDgYUuV
 jByDq6Bpgs8sZDRICSpiDaphpBv4ahKPSItwm8QfZKz2O02aFfi0KEhPwZcFlGjF9uie
 VWSQ==
X-Gm-Message-State: AOAM533wBAR6/+WChWemkCTYfgvtjy6kyUPUe5y8BUcL+yOUNvTGZ2V7
 dds6rhDWv8ZS+lxy2UEyvfV03TLNwvbU+r8wAjE=
X-Google-Smtp-Source: ABdhPJx3fQo5AQdN3Tulzmt3+aP8QK5PPrSLMdJTcZn4EGLCzCUfeh6VQXYV7pVE8pnmg3OuwlXKbdmLr/D2UsQ7UR0=
X-Received: by 2002:a9d:67c1:: with SMTP id c1mr3826505otn.299.1640326568286; 
 Thu, 23 Dec 2021 22:16:08 -0800 (PST)
MIME-Version: 1.0
References: <20211223191934.1269698-1-alexander.deucher@amd.com>
 <DM5PR12MB2469BFC66394EFEA7625B131F17F9@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469BFC66394EFEA7625B131F17F9@DM5PR12MB2469.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 24 Dec 2021 01:15:57 -0500
Message-ID: <CADnq5_M1uVqbdJyRyW0zZzKy3rF8FmRQseggr2g3arREKQQk2Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: no DC support for headless chips
To: "Chen, Guchun" <Guchun.Chen@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "tarequemd.hanif@yahoo.com" <tarequemd.hanif@yahoo.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Dec 23, 2021 at 9:54 PM Chen, Guchun <Guchun.Chen@amd.com> wrote:
>
> [Public]
>
> For the first two CHIP_HAINAN and CHIP_TOPAZ, using asic_type is fine. Bu=
t for CHIP_ARCTURUS and CHIP_ALDEBARAN, I wonder if there is any dc hardwar=
e harvesting info carried by harvest table in VBIOS. If that's the case, I =
think we can drop these two, as we can promise it by checking AMD_HARVEST_I=
P_DMU_MASK in amdgpu_device_has_dc_support.

There is no IP discovery table for these chips, but they don't have
any display IPs in the hardcoded IP discovery info in the driver.  I
don't think this should affect them, but I wasn't sure..

Alex


>
> Regards,
> Guchun
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex D=
eucher
> Sent: Friday, December 24, 2021 3:20 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; tarequemd.hanif@yahoo=
.com
> Subject: [PATCH] drm/amdgpu: no DC support for headless chips
>
> Chips with no display hardware should return false for DC support.
>
> Fixes: f7f12b25823c0d ("drm/amdgpu: default to true in amdgpu_device_asic=
_has_dc_support")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 9dc86c5a1cad..58e2034984de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3166,6 +3166,14 @@ static void amdgpu_device_detect_sriov_bios(struct=
 amdgpu_device *adev)  bool amdgpu_device_asic_has_dc_support(enum amd_asic=
_type asic_type)  {
>         switch (asic_type) {
> +#ifdef CONFIG_DRM_AMDGPU_SI
> +       case CHIP_HAINAN:
> +#endif
> +       case CHIP_TOPAZ:
> +       case CHIP_ARCTURUS:
> +       case CHIP_ALDEBARAN:
> +               /* chips with no display hardware */
> +               return false;
>  #if defined(CONFIG_DRM_AMD_DC)
>         case CHIP_TAHITI:
>         case CHIP_PITCAIRN:
> --
> 2.33.1
