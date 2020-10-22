Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A546C388F7
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 03:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7696C21534
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 03:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jMCyY+4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7696C21534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E25FA6E042;
	Thu, 22 Oct 2020 03:31:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C9BC6E042
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2020 03:31:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSQmVMY7skapGsaxJKq1RL+g16IdgzLS1EWD+0qrJwAn8KF8wQhrJjdcG/oi/g5U+VgtfE/S+HlwHAr/SFcJxuXxE+SxKzmoPDgb92SBs+Wac1Dbt5a6J7AdozG4uct5Xc965jUGx2heQEEaVGwv/DSqMGETr87RVlJzU++2CIAN1NwHxW+0kXPAo+xdEuwK8jwFHYoS1uQCBXbnO0W/xP9HHY9JbEJPSCCLnX6XD0sqEq4fkjtjNcf1MTVr3j9xhefOeEnIA8BoUVmKlSgXWv6aKwTNeeoy/4fEquYDrQCiVxI2vXs3uF01XzdW2PuDEeJUQnbmPkTqtgjSD6SO7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ri8JF/LBrzH2VuKvHR0nUYNYxggFf0bq1bnoRUJsJj4=;
 b=S1ZPGZXGh+b7JcqQ2D1TPYL7+ZOvw/KiWbC9HtfP+QPkgQjGJOZCdy2/tJdu4bSKIXtQUidJOiy6nlWLLz58ZNEpyaTUFRKLGJ4ImbXcjJml5pCS6REAyshDmbOHK/LYwHzowTRzq7GRogwJz3AUhtnt8ibmBAZar92BewoefkLf0Igk4K4FPbXBpoww6gxyofJBMG0V12acT9Zx542zuKuHZUf4BkqJEXnmjUIFFAr9g5ubhQpr47YNy58F355EIs1pA/cxIIb/Hm+WxMjojLdjoWgypuCEfXVlmy9HItJhHvzfosahb5OXGLdJoBkJwuJr3n0fmg2XMHmSytr32g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ri8JF/LBrzH2VuKvHR0nUYNYxggFf0bq1bnoRUJsJj4=;
 b=jMCyY+4aTQr3oynujwCbbCB71M9RodXZh/yQh78LqU5XV/2kXBYxrdH1nbpHiM+whICuCCgasKhfRo0ISXp6h8TtqbMpdJzNpyf9ggh5CamHFV0ToBufcYwkYWAzbw7ddkOCM7h8vlSJCDh4h5Va46fuPQYr4tLyK94ndUx+QCk=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (2603:10b6:4:8::23) by
 DM5PR12MB1433.namprd12.prod.outlook.com (2603:10b6:3:73::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Thu, 22 Oct 2020 03:31:01 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::9413:d975:ac8e:39d]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::9413:d975:ac8e:39d%7]) with mapi id 15.20.3499.018; Thu, 22 Oct 2020
 03:31:01 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: disable DCN for navi10 blockchain SKU
Thread-Topic: [PATCH 2/3] drm/amdgpu: disable DCN for navi10 blockchain SKU
Thread-Index: AQHWqCAXdZ+iNKqWi0SPpbGUCekYaKmi8zUAgAAC03E=
Date: Thu, 22 Oct 2020 03:31:01 +0000
Message-ID: <DM5PR12MB1546D100B19BA7E44725D37E951D0@DM5PR12MB1546.namprd12.prod.outlook.com>
References: <20201022030432.4011-1-tianci.yin@amd.com>
 <20201022030432.4011-2-tianci.yin@amd.com>,
 <CADnq5_PYoV2UmvjC4MJtr8tnREz7ZvsqvqfAKGogwok=MUOpGw@mail.gmail.com>
In-Reply-To: <CADnq5_PYoV2UmvjC4MJtr8tnREz7ZvsqvqfAKGogwok=MUOpGw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-22T03:31:00.507Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 19e19b0b-03d0-40b2-486d-08d8763ae626
x-ms-traffictypediagnostic: DM5PR12MB1433:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1433B3955054E4230C55550A951D0@DM5PR12MB1433.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rZqIJMqxyZh+nE8QW3l9uYQmK/nam+b6yuLUFhynbcfSXqPFTOQtYgFh92WwgS9vd1KRRLJgjR2XgwMLrtwulrkmPaFhzbzmkhf5yFGRP6ZilXklRuQDP/ix/0rCTjm6YxQae8wikYOO7pKSg3bqdFYGxz415hayvOxIc6t2eW1tlEJdVVLDCe5RfA1Iz6NQYOIZ1eSXsqApdtDsptXjXfpPZAopc3WBpb9LeLI4MFClRGlfiTgAyz7EjZfy/VQgm6l74+IuAgRSJGqiAR4032ygK7Yf00E9ETKHbmKIEE0YakhGzuctzxK4TkKfaFdBQQiYo1q73jmc2k2C8ptz7qzhC8FPJWhtBKoXDfSb1CY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1546.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(86362001)(6916009)(91956017)(9686003)(55016002)(66446008)(7696005)(45080400002)(8936002)(6506007)(4326008)(33656002)(53546011)(26005)(166002)(19627405001)(66946007)(66556008)(66476007)(64756008)(83380400001)(52536014)(5660300002)(966005)(8676002)(76116006)(478600001)(2906002)(54906003)(186003)(71200400001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: R4vcTqywn/ix/aEMk6nUlfx1qDx9pVkpRThB2K4wt6ndnU3IVQkexiDWMGC1Vknitz357ia/iT7UnC3qxo6h+YW0Mzd1niC6anbaXROed3tGjnwy4dynzTnlLTSMf1BGlznxZMHnuFey+fFwtV9ZJeMtkAFT1dJRrL8xIG4GQB6AKb7a7rziqmKfnA6JVEED5+OSin0zE9drwjtx90GIYv2mfdH9i9LaOaKHo1k3asLrgPJpIhaG8qgjz5NgaTKlHqWqfHShxBDmhRCQ4TC3Y7EupN2VsxFRjDlqCJAitK1rPCGf3DI0QBtZ/pmUpyhA/M3pkPm9OUfi61za78M2eApB5CaWWHV+ZkLsAp+GxRwL3InbK5IGr/2QgNgsftkoYuLGgJwuwy2XXB95ln1QxFYheAeH/1FSGNjL/BhcmRL1H1ulEY0tQJ6+RpXAIlLfn0lTMhjNp4UU3P43wrLWlyPVyG6LtymaJohkncQ/fobst3g8URCmAaH6WcGW7XjdI2GD7LyagaRNqjVzkJ37UhkjTMsvv1hSKiLu25A/bFVrJm5vjkIzWeJW0edlFjD/k3YuhhUb9CAVNvxVJOtL6OeewIARF6RfQh5cbUfvleHevjVxdeOUNKRUJWrfKYLE2hh3TZVv4ljkRvVjRfjY/w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1546.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e19b0b-03d0-40b2-486d-08d8763ae626
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2020 03:31:01.2415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IkWkjSVeoHxR7SkKSsBlOxVbg2BjCCeowlj9KxD/kW2IDe1zwrJzXjtxNw5Cw7648r0YFk6wBTxNAClhvh0fjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1433
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
 Feifei" <Feifei.Xu@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Cui, Flora" <Flora.Cui@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1832369381=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1832369381==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1546D100B19BA7E44725D37E951D0DM5PR12MB1546namp_"

--_000_DM5PR12MB1546D100B19BA7E44725D37E951D0DM5PR12MB1546namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi Alex,

Sorry, I misunderstand your meaning, I will refine it.

Thanks!
Rico
________________________________
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Thursday, October 22, 2020 11:16
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Long, Gang <Gang.Long@amd=
.com>; Chen, Guchun <Guchun.Chen@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; =
Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher=
@amd.com>; Cui, Flora <Flora.Cui@amd.com>; Zhang, Hawking <Hawking.Zhang@am=
d.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: disable DCN for navi10 blockchain SKU

On Wed, Oct 21, 2020 at 11:04 PM Tianci Yin <tianci.yin@amd.com> wrote:
>
> From: "Tianci.Yin" <tianci.yin@amd.com>
>
> The blockchain SKU has no display support, remove it.
>
> Change-Id: Ia83bef1499708dfd0113fe2dbb3eb4143452c1cd
> Reviewed-by: Guchun Chen <guchun.chen@amd.com>
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 28 +++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  2 +-
>  4 files changed, 30 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index f8f3e375c93e..3c63fb8904de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1051,7 +1051,8 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_de=
vice *adev,
>                                    u32 pcie_index, u32 pcie_data,
>                                    u32 reg_addr, u64 reg_data);
>
> -bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);
> +bool amdgpu_device_asic_is_blockchain_sku(struct pci_dev *pdev);
> +bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type, str=
uct pci_dev *pdev);
>  bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
>
>  int emu_soc_asic_init(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index c567f20b9d1f..5dd05e72ed9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2954,15 +2954,32 @@ static void amdgpu_device_detect_sriov_bios(struc=
t amdgpu_device *adev)
>         }
>  }
>
> +/**
> + * amdgpu_device_asic_is_blockchain_sku - determine if the asic is block=
chain
> + * SKU
> + *
> + * @pdev: pointer to pci_dev instance
> + *
> + * returns true if the asic is blockchain SKU, false if not.
> + */
> +bool amdgpu_device_asic_is_blockchain_sku(struct pci_dev *pdev)
> +{
> +       if (pdev->device =3D=3D 0x731E &&
> +           (pdev->revision =3D=3D 0xC6 || pdev->revision =3D=3D 0xC7))
> +               return true;
> +       return false;
> +}

I don't think this makes sense to have a navi specific function in
amdgpu_device.c.  Also, I said said previously, wouldn't it be easier
to just check in nv.c?  E.g.,

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c
index 1ce741a0c6a7..e661e796fb4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -483,8 +483,12 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
                if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
                        amdgpu_device_ip_block_add(adev, &dce_virtual_ip_bl=
ock);
 #if defined(CONFIG_DRM_AMD_DC)
-               else if (amdgpu_device_has_dc_support(adev))
-                       amdgpu_device_ip_block_add(adev, &dm_ip_block);
+               else if (amdgpu_device_has_dc_support(adev)) {
+                       if (adev->pdev->device !=3D 0x731E ||
+                           (adev->pdev->revision !=3D 0xC6 &&
+                            adev->pdev->revision !=3D 0xC7))
+                               amdgpu_device_ip_block_add(adev, &dm_ip_blo=
ck);
+               }
 #endif
                amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
                amdgpu_device_ip_block_add(adev, &sdma_v5_0_ip_block);


> +
>  /**
>   * amdgpu_device_asic_has_dc_support - determine if DC supports the asic
>   *
>   * @asic_type: AMD asic type
> + * @pdev: pointer to pci_dev instance
>   *
>   * Check if there is DC (new modesetting infrastructre) support for an a=
sic.
>   * returns true if DC has support, false if not.
>   */
> -bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
> +bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type, str=
uct pci_dev *pdev)
>  {
>         switch (asic_type) {
>  #if defined(CONFIG_DRM_AMD_DC)
> @@ -2999,6 +3016,13 @@ bool amdgpu_device_asic_has_dc_support(enum amd_as=
ic_type asic_type)
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>         case CHIP_RAVEN:
>         case CHIP_NAVI10:
> +               if (amdgpu_device_asic_is_blockchain_sku(pdev)) {
> +                       DRM_INFO("(%s 0x%04X:0x%04X 0x%04X:0x%04X 0x%02X)=
 has no dc support.\n",
> +                                amdgpu_asic_name[asic_type], pdev->vendo=
r, pdev->device,
> +                                pdev->subsystem_vendor, pdev->subsystem_=
device, pdev->revision);
> +                       return false;
> +               }
> +               return amdgpu_dc !=3D 0;
>         case CHIP_NAVI14:
>         case CHIP_NAVI12:
>         case CHIP_RENOIR:
> @@ -3031,7 +3055,7 @@ bool amdgpu_device_has_dc_support(struct amdgpu_dev=
ice *adev)
>         if (amdgpu_sriov_vf(adev) || adev->enable_virtual_display)
>                 return false;
>
> -       return amdgpu_device_asic_has_dc_support(adev->asic_type);
> +       return amdgpu_device_asic_has_dc_support(adev->asic_type, adev->p=
dev);
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
>          */
>         if ((bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
>             amdgpu_bo_support_uswc(bo_flags) &&
> -           amdgpu_device_asic_has_dc_support(adev->asic_type)) {
> +           amdgpu_device_asic_has_dc_support(adev->asic_type, adev->pdev=
)) {
>                 switch (adev->asic_type) {
>                 case CHIP_CARRIZO:
>                 case CHIP_STONEY:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 13723914fa9f..97fda825e0d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1109,7 +1109,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>         bool supports_atomic =3D false;
>
>         if (!amdgpu_virtual_display &&
> -           amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
> +           amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK, pdev=
))
>                 supports_atomic =3D true;
>
>         if ((flags & AMD_EXP_HW_SUPPORT) && !amdgpu_exp_hw_support) {
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Ctianci=
.yin%40amd.com%7C8677b036e861492f653808d87638e56d%7C3dd8961fe4884e608e11a82=
d994e183d%7C0%7C0%7C637389334030603034%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w=
LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DS=
naKO7Xvvtrgqn%2BxmqQDomL%2B1gUW3GmKiIFWGyUS3jI%3D&amp;reserved=3D0

--_000_DM5PR12MB1546D100B19BA7E44725D37E951D0DM5PR12MB1546namp_
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
Hi Alex,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Sorry, I misunderstand your meaning, I will refine it.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Rico<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher@gmail.com&gt;<br>
<b>Sent:</b> Thursday, October 22, 2020 11:16<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Long, Gang &=
lt;Gang.Long@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; Xu, Fei=
fei &lt;Feifei.Xu@amd.com&gt;; Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; =
Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Cui, Flora &lt;Flora.=
Cui@amd.com&gt;;
 Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 2/3] drm/amdgpu: disable DCN for navi10 blockcha=
in SKU</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Wed, Oct 21, 2020 at 11:04 PM Tianci Yin &lt;ti=
anci.yin@amd.com&gt; wrote:<br>
&gt;<br>
&gt; From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.com&gt;<br>
&gt;<br>
&gt; The blockchain SKU has no display support, remove it.<br>
&gt;<br>
&gt; Change-Id: Ia83bef1499708dfd0113fe2dbb3eb4143452c1cd<br>
&gt; Reviewed-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
&gt; Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; |&nbsp; 3 ++-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp; | 28 ++++++++++=
+++++++++--<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_display.c |&nbsp; 2 +-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp; 2 +-<br>
&gt;&nbsp; 4 files changed, 30 insertions(+), 5 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index f8f3e375c93e..3c63fb8904de 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -1051,7 +1051,8 @@ void amdgpu_device_indirect_wreg64(struct amdgpu=
_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 pcie_i=
ndex, u32 pcie_data,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 reg_ad=
dr, u64 reg_data);<br>
&gt;<br>
&gt; -bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);=
<br>
&gt; +bool amdgpu_device_asic_is_blockchain_sku(struct pci_dev *pdev);<br>
&gt; +bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type, =
struct pci_dev *pdev);<br>
&gt;&nbsp; bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);<b=
r>
&gt;<br>
&gt;&nbsp; int emu_soc_asic_init(struct amdgpu_device *adev);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index c567f20b9d1f..5dd05e72ed9e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -2954,15 +2954,32 @@ static void amdgpu_device_detect_sriov_bios(st=
ruct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; +/**<br>
&gt; + * amdgpu_device_asic_is_blockchain_sku - determine if the asic is bl=
ockchain<br>
&gt; + * SKU<br>
&gt; + *<br>
&gt; + * @pdev: pointer to pci_dev instance<br>
&gt; + *<br>
&gt; + * returns true if the asic is blockchain SKU, false if not.<br>
&gt; + */<br>
&gt; +bool amdgpu_device_asic_is_blockchain_sku(struct pci_dev *pdev)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pdev-&gt;device =3D=3D 0x731=
E &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (pdev-&g=
t;revision =3D=3D 0xC6 || pdev-&gt;revision =3D=3D 0xC7))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; +}<br>
<br>
I don't think this makes sense to have a navi specific function in<br>
amdgpu_device.c.&nbsp; Also, I said said previously, wouldn't it be easier<=
br>
to just check in nv.c?&nbsp; E.g.,<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c<br>
index 1ce741a0c6a7..e661e796fb4c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -483,8 +483,12 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (adev-&gt;enable_virtual_display || amdgpu_sriov_vf(adev=
))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_devi=
ce_ip_block_add(adev, &amp;dce_virtual_ip_block);<br>
&nbsp;#if defined(CONFIG_DRM_AMD_DC)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (amdgpu_device_has_dc_support(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_block_add(adev, &amp;dm_ip_block);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (amdgpu_device_has_dc_support(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pde=
v-&gt;device !=3D 0x731E ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (adev-&gt;pdev-&gt;revision !=3D 0xC6 &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; adev-&gt;pdev-&gt;revision !=3D 0xC7))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;dm_ip=
_block);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;gfx_v10_0_ip_block);<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;sdma_v5_0_ip_block);<=
br>
<br>
<br>
&gt; +<br>
&gt;&nbsp; /**<br>
&gt;&nbsp;&nbsp; * amdgpu_device_asic_has_dc_support - determine if DC supp=
orts the asic<br>
&gt;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp; * @asic_type: AMD asic type<br>
&gt; + * @pdev: pointer to pci_dev instance<br>
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
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (asic_type) {<b=
r>
&gt;&nbsp; #if defined(CONFIG_DRM_AMD_DC)<br>
&gt; @@ -2999,6 +3016,13 @@ bool amdgpu_device_asic_has_dc_support(enum amd=
_asic_type asic_type)<br>
&gt;&nbsp; #if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RAVEN:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI10:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (amdgpu_device_asic_is_blockchain_sku(pdev)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&q=
uot;(%s 0x%04X:0x%04X 0x%04X:0x%04X 0x%02X) has no dc support.\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_name[asic_type], pde=
v-&gt;vendor, pdev-&gt;device,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdev-&gt;subsystem_vendor, pdev-=
&gt;subsystem_device, pdev-&gt;revision);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return fals=
e;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return amdgpu_dc !=3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI14:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI12:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RENOIR:<br>
&gt; @@ -3031,7 +3055,7 @@ bool amdgpu_device_has_dc_support(struct amdgpu_=
device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(ad=
ev) || adev-&gt;enable_virtual_display)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_device_asic_has_dc=
_support(adev-&gt;asic_type);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_device_asic_has_dc=
_support(adev-&gt;asic_type, adev-&gt;pdev);<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_display.c<br>
&gt; index 9e92d2a070ac..97014458d7de 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
&gt; @@ -516,7 +516,7 @@ uint32_t amdgpu_display_supported_domains(struct a=
mdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((bo_flags &amp; AM=
DGPU_GEM_CREATE_CPU_GTT_USWC) &amp;&amp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; amdgpu_bo_support_uswc(bo_flags) &amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_d=
evice_asic_has_dc_support(adev-&gt;asic_type)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_d=
evice_asic_has_dc_support(adev-&gt;asic_type, adev-&gt;pdev)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_CARRIZO:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_STONEY:<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_drv.c<br>
&gt; index 13723914fa9f..97fda825e0d3 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; @@ -1109,7 +1109,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool supports_atomic =
=3D false;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_virtual_di=
splay &amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_d=
evice_asic_has_dc_support(flags &amp; AMD_ASIC_MASK))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_d=
evice_asic_has_dc_support(flags &amp; AMD_ASIC_MASK, pdev))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; supports_atomic =3D true;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((flags &amp; AMD_E=
XP_HW_SUPPORT) &amp;&amp; !amdgpu_exp_hw_support) {<br>
&gt; --<br>
&gt; 2.17.1<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx@lists.freedesktop.org<br>
&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Ctianci.yin%40amd.com%7C8677b036e861492f653808d87638e56d%7C3dd8=
961fe4884e608e11a82d994e183d%7C0%7C0%7C637389334030603034%7CUnknown%7CTWFpb=
GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7=
C1000&amp;amp;sdata=3DSnaKO7Xvvtrgqn%2BxmqQDomL%2B1gUW3GmKiIFWGyUS3jI%3D&am=
p;amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7C01%7Ctian=
ci.yin%40amd.com%7C8677b036e861492f653808d87638e56d%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637389334030603034%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sda=
ta=3DSnaKO7Xvvtrgqn%2BxmqQDomL%2B1gUW3GmKiIFWGyUS3jI%3D&amp;amp;reserved=3D=
0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB1546D100B19BA7E44725D37E951D0DM5PR12MB1546namp_--

--===============1832369381==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1832369381==--
