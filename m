Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BE3C2D0A3
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 03:07:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4FB12225F
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 03:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wYQxA6Fv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4FB12225F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 133696E041;
	Thu, 22 Oct 2020 03:07:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6441A6E041
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2020 03:07:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFWHRr/3Abq2cOX9+D2/hKPg6SdtVBFbyG8xUOiF77nXAFEex3EJyvhbwJCb8cdXI+PTHRO7288zeXRzXK3hjB+omOovpAAwLSETLr7XPAj3HUWYtGPfA95+LyumuqK8AeukH6DozN3aH4wY9P5ICeZahBO/Xuw9aruLS7OaBsA/ppwH7sme1/2wuOGPtNqxGlo06aUlael7gOAhQ0I8RzEaVd5SdOW8vM2jTpHsNEPuGr4gWkpkh1t9VEUNEl1RHZM/H2kj6D0+fh0mhpu0mC9zTqKRd4Cuq+uU/9qQKEQtbabNUa+mmeFNcV8pu0aDFuxBQAvHXbbKLUciom7nmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/3wkRfFVppArtyiVLA02ExqngjoAf8bVOtG/oxfMwo=;
 b=Gny7UKtLIqX+eJVul/w9OCUSRWcCjIfSJEGHlU+/oeVJRXSeYZaLdvGdBFuYpg2Fx0kbik7SzeMKJ8nAc5BBzg++3RlXq1ttc8bPJRrONpBIlr3XAirw8u4lINROzl9SFcyJR5dIvNR5KgITdZWBrnjAyeWwHByIG0bdQl/yZMjCnkkYL/8gxurJT/gghhHZI7afYcNZwOF0cQtRlJgNLUrf7KSzCMZwxIhb+Nk84IYlpyq27REdh+Y/0k9l+OeWGEW7oMouVveBJtu0IgU0v9mAXycbVZDt1yQa+HlmbZc9+SnbGrtm3GtX1+CYHdsx4eF9dSN19vXRzWw12oujTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/3wkRfFVppArtyiVLA02ExqngjoAf8bVOtG/oxfMwo=;
 b=wYQxA6Fv1zboFbUGl+jX1DFFCXbP9gLsN4o6mbD2DUYHAeEhAwLuZg2ADLZFUeXpNnKelXyB1zF2xVMD3yNqFko9uedFMRfcyFIbjM1eh7o1YA+b3wGduLFpeatN+rTY7FydlcG989aU4Fs0oXb56TarQtcUP4gyVIhVBjShhb8=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (2603:10b6:4:8::23) by
 DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.20; Thu, 22 Oct 2020 03:07:22 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::9413:d975:ac8e:39d]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::9413:d975:ac8e:39d%7]) with mapi id 15.20.3499.018; Thu, 22 Oct 2020
 03:07:22 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/3] drm/amdgpu: disable DCN for navi10 blockchain SKU
Thread-Topic: [PATCH 2/3] drm/amdgpu: disable DCN for navi10 blockchain SKU
Thread-Index: AQHWp3+o4fH9s6LmNEGlnIXmG7TxtamiU32AgACd3tI=
Date: Thu, 22 Oct 2020 03:07:22 +0000
Message-ID: <DM5PR12MB1546B69FBA4800E38DA1F3E3951D0@DM5PR12MB1546.namprd12.prod.outlook.com>
References: <20201021075608.16785-1-tianci.yin@amd.com>
 <20201021075608.16785-2-tianci.yin@amd.com>,
 <4df69b9a-f253-d2c1-74b7-a9c69cacb7c3@amd.com>
In-Reply-To: <4df69b9a-f253-d2c1-74b7-a9c69cacb7c3@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-22T03:07:22.099Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8ccdfb86-dd5a-4124-fefc-08d8763798a8
x-ms-traffictypediagnostic: DM6PR12MB4041:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB404178010F61AA990AA8EBD0951D0@DM6PR12MB4041.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FbfPuaGABLbcQcQJ8YQrIBRsME711cAbmtvlruuD4XqRKPsKP4ge9aDI+ONX+atofRgIYUclzdBAhxbKKMGjy+EvpP9uayxhVwi7WBfw1jFLq2lfAAMc76IDB9wu1PzFNZQ/qX8XdGPq73JPYOr12InMyVmQCGNma0Abg8S38+63go02JIt2r8YklvmMx7uxt4GwzjJwuhFuVciwIc1CsxnU7jTXvSpx9VN3PfB+BL/BNTG1D/+8va30PbyjRXZxwg+Dneel53bFsjKr2HjPXyq+UV/nnqIoa9YZ3BJm+1dg2XXVBYys7qkMzL95x1jjkZIyFWDY6tO5xaFaQ86wwQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1546.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(71200400001)(33656002)(9686003)(19627405001)(6506007)(52536014)(53546011)(55016002)(83380400001)(4326008)(8676002)(478600001)(26005)(7696005)(316002)(2906002)(5660300002)(66446008)(110136005)(64756008)(66556008)(66476007)(76116006)(91956017)(4001150100001)(186003)(54906003)(66946007)(86362001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: l6KSLocbkngF4krtLQiKhr0yuN6otnqLv+oJnUa9EYnxnWa7zp/jdxFnDcEXaoqjJ898T8fuvI/4lhfbWXsM+bdr0xvvuoxdJTTcDVrEBY+nRf+WqWohwxpJpsUJSVbRzOuc2rnV1GjgV9d2GygvX7il5Am9UWONwDnK3cXYKrGDiP569oxVfsbwkQNe3Mtqwt+jv7wqjdmYAU/7oTAQwTJ4lJ3sE+OIQtmrqijvyZpQOcbuY201gG0GnrvoaypLYCcLmOHIDswvQ6Bgwvp0X9EDguuY6t+6uVmSCHntcH7oeypW3zgNGKQ+z9FQg1cTOONmhNmUQTpl3hNI86/vH017H3Q5OvKrLY0Yzj4pjg520wMAnC2tRX9kxZ6ynrnuMo+GlhXeSB2ew5oC9vnDqNjH/wmLUaVpI+eQPM2FSbyFaweiNwV4zsCipBpKumpoohf7CPj9GfhfZ3YocXjQxT771vLjQlm7viLW4RI9qAfzxgR0gPRuSPThjVY1ehrLH0xqCwwla7CCuOi3K5sO29h/tG9shqzmf5Iz80cwxnZJzO8DMgf/K0ORuYmni9bTa8i5nBaTzb4DdH7Uxcdmrni4EXxfx49wt6P15hSNyHC9ED7h6zlj6BFf/TVGEWyaKcJBlWcLhuImyoqydB/IMQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1546.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ccdfb86-dd5a-4124-fefc-08d8763798a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2020 03:07:22.7407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LtzK4H7btM+lw7yAHQtnsuXeD5gkJ37WK188i/HDjpNH/PyyAX8IjdYtWcIt9c8xUyF2NavvrLLtACj2JrvazQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Cui, Flora" <Flora.Cui@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1854554051=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1854554051==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1546B69FBA4800E38DA1F3E3951D0DM5PR12MB1546namp_"

--_000_DM5PR12MB1546B69FBA4800E38DA1F3E3951D0DM5PR12MB1546namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Thanks very much Alex and Luben!
I refine the patches, please review again.

Rico
________________________________
From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Thursday, October 22, 2020 1:40
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Cui, Flora <Flora.Cui@=
amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Long, Gang <Gang.Long@amd.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: disable DCN for navi10 blockchain SKU

On 2020-10-21 03:56, Tianci Yin wrote:
> From: "Tianci.Yin" <tianci.yin@amd.com>
>
> The blockchain SKU has no display support, so the DCN ip

"DCN IP" to stand for Intellectual Property.

> block should be disabled. Add DID/RID as display
> supporting dependence, it potentially disable DCN block.
>
> Change-Id: Ia83bef1499708dfd0113fe2dbb3eb4143452c1cd
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 20 +++++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  2 +-
>  4 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index f8f3e375c93e..04e906386b5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1051,7 +1051,7 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_de=
vice *adev,
>                                   u32 pcie_index, u32 pcie_data,
>                                   u32 reg_addr, u64 reg_data);
>
> -bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);
> +bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type, str=
uct pci_dev *pdev);
>  bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
>
>  int emu_soc_asic_init(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index c567f20b9d1f..fa522cffdd64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2958,11 +2958,12 @@ static void amdgpu_device_detect_sriov_bios(struc=
t amdgpu_device *adev)
>   * amdgpu_device_asic_has_dc_support - determine if DC supports the asic
>   *
>   * @asic_type: AMD asic type
> + * @pdev: pointer of pci_dev instance

"pointer to ... instance", or,
"pointer of ... type".

>   *
>   * Check if there is DC (new modesetting infrastructre) support for an a=
sic.
>   * returns true if DC has support, false if not.
>   */
> -bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
> +bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type, str=
uct pci_dev *pdev)
>  {
>        switch (asic_type) {
>  #if defined(CONFIG_DRM_AMD_DC)
> @@ -2998,7 +2999,6 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asi=
c_type asic_type)
>        case CHIP_VEGA20:
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>        case CHIP_RAVEN:
> -     case CHIP_NAVI10:
>        case CHIP_NAVI14:
>        case CHIP_NAVI12:
>        case CHIP_RENOIR:
> @@ -3011,6 +3011,20 @@ bool amdgpu_device_asic_has_dc_support(enum amd_as=
ic_type asic_type)
>  #endif
>                return amdgpu_dc !=3D 0;
>  #endif
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +     case CHIP_NAVI10:
> +             if (pdev->device =3D=3D 0x731E &&
> +                 (pdev->revision =3D=3D 0xC6 ||
> +                  pdev->revision =3D=3D 0xC7)) {
> +                     DRM_INFO("(%s 0x%04X:0x%04X 0x%04X:0x%04X 0x%02X) h=
as no dc support.\n",
> +                              amdgpu_asic_name[asic_type], pdev->vendor,=
 pdev->device,
> +                              pdev->subsystem_vendor, pdev->subsystem_de=
vice, pdev->revision);
> +                     return false;
> +             } else {
> +                     return amdgpu_dc !=3D 0;
> +             }
> +#endif
> +

Why not leave the placing of the original CHIP_NAVI10 label,
and add the if () under it, and drop the "else { ..."?

Regards,
Luben


>        default:
>                if (amdgpu_dc > 0)
>                        DRM_INFO("Display Core has been requested via kern=
el parameter "
> @@ -3031,7 +3045,7 @@ bool amdgpu_device_has_dc_support(struct amdgpu_dev=
ice *adev)
>        if (amdgpu_sriov_vf(adev) || adev->enable_virtual_display)
>                return false;
>
> -     return amdgpu_device_asic_has_dc_support(adev->asic_type);
> +     return amdgpu_device_asic_has_dc_support(adev->asic_type, adev->pde=
v);
>  }
>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_display.c
> index 9e92d2a070ac..97014458d7de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -516,7 +516,7 @@ uint32_t amdgpu_display_supported_domains(struct amdg=
pu_device *adev,
>         */
>        if ((bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
>            amdgpu_bo_support_uswc(bo_flags) &&
> -         amdgpu_device_asic_has_dc_support(adev->asic_type)) {
> +         amdgpu_device_asic_has_dc_support(adev->asic_type, adev->pdev))=
 {
>                switch (adev->asic_type) {
>                case CHIP_CARRIZO:
>                case CHIP_STONEY:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 13723914fa9f..97fda825e0d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1109,7 +1109,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>        bool supports_atomic =3D false;
>
>        if (!amdgpu_virtual_display &&
> -         amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
> +         amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK, pdev))
>                supports_atomic =3D true;
>
>        if ((flags & AMD_EXP_HW_SUPPORT) && !amdgpu_exp_hw_support) {
>


--_000_DM5PR12MB1546B69FBA4800E38DA1F3E3951D0DM5PR12MB1546namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks very much Alex and Luben!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I refine the patches, please review again.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Rico<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Tuikov, Luben &lt;Lub=
en.Tuikov@amd.com&gt;<br>
<b>Sent:</b> Thursday, October 22, 2020 1:40<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Haw=
king &lt;Hawking.Zhang@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt=
;; Cui, Flora &lt;Flora.Cui@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&g=
t;; Long, Gang &lt;Gang.Long@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 2/3] drm/amdgpu: disable DCN for navi10 blockcha=
in SKU</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2020-10-21 03:56, Tianci Yin wrote:<br>
&gt; From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.com&gt;<br>
&gt; <br>
&gt; The blockchain SKU has no display support, so the DCN ip<br>
<br>
&quot;DCN IP&quot; to stand for Intellectual Property.<br>
<br>
&gt; block should be disabled. Add DID/RID as display<br>
&gt; supporting dependence, it potentially disable DCN block.<br>
&gt; <br>
&gt; Change-Id: Ia83bef1499708dfd0113fe2dbb3eb4143452c1cd<br>
&gt; Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp; | 20 ++++++++++=
+++++++---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_display.c |&nbsp; 2 +-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp; 2 +-<br>
&gt;&nbsp; 4 files changed, 20 insertions(+), 6 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index f8f3e375c93e..04e906386b5b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -1051,7 +1051,7 @@ void amdgpu_device_indirect_wreg64(struct amdgpu=
_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 pcie_index, =
u32 pcie_data,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 reg_addr, u6=
4 reg_data);<br>
&gt;&nbsp; <br>
&gt; -bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);=
<br>
&gt; +bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type, =
struct pci_dev *pdev);<br>
&gt;&nbsp; bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);<b=
r>
&gt;&nbsp; <br>
&gt;&nbsp; int emu_soc_asic_init(struct amdgpu_device *adev);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index c567f20b9d1f..fa522cffdd64 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -2958,11 +2958,12 @@ static void amdgpu_device_detect_sriov_bios(st=
ruct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp; * amdgpu_device_asic_has_dc_support - determine if DC supp=
orts the asic<br>
&gt;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp; * @asic_type: AMD asic type<br>
&gt; + * @pdev: pointer of pci_dev instance<br>
<br>
&quot;pointer to ... instance&quot;, or,<br>
&quot;pointer of ... type&quot;.<br>
<br>
&gt;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp; * Check if there is DC (new modesetting infrastructre) sup=
port for an asic.<br>
&gt;&nbsp;&nbsp; * returns true if DC has support, false if not.<br>
&gt;&nbsp;&nbsp; */<br>
&gt; -bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)<=
br>
&gt; +bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type, =
struct pci_dev *pdev)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (asic_type) {<br>
&gt;&nbsp; #if defined(CONFIG_DRM_AMD_DC)<br>
&gt; @@ -2998,7 +2999,6 @@ bool amdgpu_device_asic_has_dc_support(enum amd_=
asic_type asic_type)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA20:<br>
&gt;&nbsp; #if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RAVEN:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI10:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI14:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI12:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RENOIR:<br>
&gt; @@ -3011,6 +3011,20 @@ bool amdgpu_device_asic_has_dc_support(enum amd=
_asic_type asic_type)<br>
&gt;&nbsp; #endif<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return amdgpu_dc !=3D 0;<br>
&gt;&nbsp; #endif<br>
&gt; +#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI10:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (pdev-&gt;device =3D=3D 0x731E &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; (pdev-&gt;revision =3D=3D 0xC6 ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdev-&gt;revision =3D=3D 0xC7)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;(%s 0x%0=
4X:0x%04X 0x%04X:0x%04X 0x%02X) has no dc support.\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_name[asic_type], pdev-&gt;vendor=
, pdev-&gt;device,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdev-&gt;subsystem_vendor, pdev-&gt;subsyste=
m_device, pdev-&gt;revision);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_dc !=3D 0=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +#endif<br>
&gt; +<br>
<br>
Why not leave the placing of the original CHIP_NAVI10 label,<br>
and add the if () under it, and drop the &quot;else { ...&quot;?<br>
<br>
Regards,<br>
Luben<br>
<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (amdgpu_dc &gt; 0)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INF=
O(&quot;Display Core has been requested via kernel parameter &quot;<br>
&gt; @@ -3031,7 +3045,7 @@ bool amdgpu_device_has_dc_support(struct amdgpu_=
device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) ||=
 adev-&gt;enable_virtual_display)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return false;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_device_asic_has_dc_support(ade=
v-&gt;asic_type);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_device_asic_has_dc_support(ade=
v-&gt;asic_type, adev-&gt;pdev);<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_display.c<br>
&gt; index 9e92d2a070ac..97014458d7de 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
&gt; @@ -516,7 +516,7 @@ uint32_t amdgpu_display_supported_domains(struct a=
mdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((bo_flags &amp; AMDGPU_G=
EM_CREATE_CPU_GTT_USWC) &amp;&amp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdg=
pu_bo_support_uswc(bo_flags) &amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_asic_h=
as_dc_support(adev-&gt;asic_type)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_asic_h=
as_dc_support(adev-&gt;asic_type, adev-&gt;pdev)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case CHIP_CARRIZO:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case CHIP_STONEY:<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_drv.c<br>
&gt; index 13723914fa9f..97fda825e0d3 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; @@ -1109,7 +1109,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool supports_atomic =3D fal=
se;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_virtual_display =
&amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_asic_h=
as_dc_support(flags &amp; AMD_ASIC_MASK))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_asic_h=
as_dc_support(flags &amp; AMD_ASIC_MASK, pdev))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; supports_atomic =3D true;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((flags &amp; AMD_EXP_HW_=
SUPPORT) &amp;&amp; !amdgpu_exp_hw_support) {<br>
&gt; <br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB1546B69FBA4800E38DA1F3E3951D0DM5PR12MB1546namp_--

--===============1854554051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1854554051==--
