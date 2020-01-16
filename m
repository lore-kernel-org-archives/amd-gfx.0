Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B693BC33CB1
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 15:26:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84B452072B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 15:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpdjrA71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B452072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AA726EB20;
	Thu, 16 Jan 2020 15:26:18 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E44726EB20
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 15:26:17 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id b6so19602697wrq.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 07:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=EvWhaEjUf4I7npzYBPYdqHPXveZyQpmSLHIdNYnO8h0=;
 b=KpdjrA71hKKZsSPiSMLOWcre9IaErVWngKBlnDiLBrgIshJfANPmwSqd1/jtJEAARS
 NIoMxCuX5zc84Uwsbr3utqqiB9XfKifHsoCXrkY06zCUgGYbjXoyXeflTJb7kiHa+uGa
 adReBC9ezGq0/QT7yPbxz+S5tAyivGhMSC5cvsTRB2wCaufzsMy4dk/FFiQK0YVc8fYm
 +IgHQC9scngbW9EQuuKnaMf/jxYB53IXcn95xGUzUr42ewCbkIyTcwzeCbFfYtbmzyJU
 8+eVQh9NBx76HNx1rlxhuJGDlL5c2uOUpwVrTNxoekT5KGm3bgGvxp4FvFb9wD4TlRhm
 fXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EvWhaEjUf4I7npzYBPYdqHPXveZyQpmSLHIdNYnO8h0=;
 b=ZviCx/ISFEAMsAjwzstYJ/ihZnljSZ77zy/4yvwhiJXXCVTqkbzgVv4nHbFBH2mPkC
 zavK7+MwdbYBeXrmJOVpedd6qadLtWkOTYCrpNNe7h3uVsJZHpuY29t2CHD9CMhj9dWJ
 L21B7eNVZQr8gPDPdGTVfpRJlceGFBtUltPzy6PPgIOw3v0Ag18f073IiI6I5YrKspt6
 wohwPGkzwn48rqh4kmNa3x1FCrHJRsOG4IsCW7zThdgHs+2+qvGRsKGOsOAaPQUNA2TH
 pQOyDxoH/GFtS6uNYW9JW+uJX5lM/3D/lIqQlIqZKboqkg0+AkY8KDxhyHXgW5gtmFAO
 ZJqw==
X-Gm-Message-State: APjAAAWenrRjf0sIjHbNgYaUNhSDGdX1gbU/Pe2k8HmyPfKkr3o6KffT
 2v9ieITnSyGdpylCd38Wi6RJwJw1ZYKSMkeODbk=
X-Google-Smtp-Source: APXvYqwq0d0D7LGGnmtd7pcQLvRV2Re35PgPU3tLr/0BiXCJrSIxpO4/82IeVuKwb05ASMKjE57pPVwbw4VzeQ6gkEw=
X-Received: by 2002:a5d:5091:: with SMTP id a17mr3877511wrt.362.1579188376559; 
 Thu, 16 Jan 2020 07:26:16 -0800 (PST)
MIME-Version: 1.0
References: <20200115173139.1392429-1-alexander.deucher@amd.com>
 <MN2PR12MB31672D3E94DEB4EBB91359CFED360@MN2PR12MB3167.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB31672D3E94DEB4EBB91359CFED360@MN2PR12MB3167.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Jan 2020 10:26:04 -0500
Message-ID: <CADnq5_Oes7UDa9oUnGY_vejccrO6yz+n_a5C1Uk-xsEb4U_ZuA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: attempt to enable gfxoff on more raven1 boards
To: "Li, Dennis" <Dennis.Li@amd.com>
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
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 15, 2020 at 8:51 PM Li, Dennis <Dennis.Li@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi, Alex,
>       it is better to refine the patch as a common function, not only used for raven.

I originally had the name as gfx_v9_0_check_disable_gfxoff(), but I
changed it to be raven specific because if we call this independent of
the other conditions in the CHIP_RAVEN case, we may end up disabling
gfxoff in cases where we don't want to (e.g., if a raven1 refresh uses
the same DID/SSID/RIDs as a non-kicker for example, and one works and
the other doesn't).  I guess we can revisit if we have to add cases
for other asics.  If you feel strongly I can change the name.

Alex

>
> Best Regards
> Dennis Li
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
> Sent: Thursday, January 16, 2020 1:32 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: attempt to enable gfxoff on more raven1 boards
>
> Switch to a blacklist so we can disable specific boards that are problematic.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 42 ++++++++++++++++++++++++---
>  1 file changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index e3d466bd5c4e..b48b07bcd0fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1031,6 +1031,37 @@ static void gfx_v9_0_check_fw_write_wait(struct amdgpu_device *adev)
>         }
>  }
>
> +struct amdgpu_gfxoff_quirk {
> +       u16 chip_vendor;
> +       u16 chip_device;
> +       u16 subsys_vendor;
> +       u16 subsys_device;
> +       u8 revision;
> +};
> +
> +static const struct amdgpu_gfxoff_quirk amdgpu_gfxoff_quirk_list[] = {
> +       /* https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D204689&amp;data=02%7C01%7CDennis.Li%40amd.com%7C33990b7157714a2f943a08d799e0cda3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637147063123345220&amp;sdata=2mT3Eug%2FEDKGGbI1bqymp2tnMqLX4x%2B2BAWnLUnq5m0%3D&amp;reserved=0 */
> +       { 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc8 },
> +       { 0, 0, 0, 0, 0 },
> +};
> +
> +static bool gfx_v9_0_raven_check_disable_gfxoff(struct pci_dev *pdev) {
> +       const struct amdgpu_gfxoff_quirk *p = amdgpu_gfxoff_quirk_list;
> +
> +       while (p && p->chip_device != 0) {
> +               if (pdev->vendor == p->chip_vendor &&
> +                   pdev->device == p->chip_device &&
> +                   pdev->subsystem_vendor == p->subsys_vendor &&
> +                   pdev->subsystem_device == p->subsys_device &&
> +                   pdev->revision == p->revision) {
> +                       return true;
> +               }
> +               ++p;
> +       }
> +       return false;
> +}
> +
>  static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)  {
>         switch (adev->asic_type) {
> @@ -1039,10 +1070,13 @@ static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
>         case CHIP_VEGA20:
>                 break;
>         case CHIP_RAVEN:
> -               if (!(adev->rev_id >= 0x8 ||
> -                     adev->pdev->device == 0x15d8) &&
> -                   (adev->pm.fw_version < 0x41e2b || /* not raven1 fresh */
> -                    !adev->gfx.rlc.is_rlc_v2_1)) /* without rlc save restore ucodes */
> +               if (!(adev->rev_id >= 0x8 || adev->pdev->device == 0x15d8) &&
> +                   ((adev->gfx.rlc_fw_version != 106 &&
> +                     adev->gfx.rlc_fw_version < 531) ||
> +                    (adev->gfx.rlc_fw_version == 53815) ||
> +                    (adev->gfx.rlc_feature_version < 1) ||
> +                    !adev->gfx.rlc.is_rlc_v2_1) &&
> +                   !gfx_v9_0_raven_check_disable_gfxoff(adev->pdev))
>                         adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
>
>                 if (adev->pm.pp_feature & PP_GFXOFF_MASK)
> --
> 2.24.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CDennis.Li%40amd.com%7C33990b7157714a2f943a08d799e0cda3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637147063123345220&amp;sdata=ON7UTCOhoCaW%2Bwp0KiMCjOQHt6QohngaFxx9hgfKS7o%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
