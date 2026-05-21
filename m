Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3769ECD4F3C
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 07:17:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA60C10F23A;
	Thu, 21 May 2026 07:17:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2f+2HmC1";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012021.outbound.protection.outlook.com [52.101.48.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 955B910F236
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 07:17:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lfiZpU5E1Bk77cE42a/r0vt0XQhND113FPcs9Fm9LBmqtvy2As+jR6LCPenl4FRrc8KM7KMCQBggKIisskQN9E2ea7KAA18Q8kWm4SbojglMBdduIv8krOlj0hrxfg0kV2ri+i7Vjk50IErZwbg14OHQuT4iS02/eEHImbaKwQHm0vN+dOj/oMPOjJY8zAREK2vw/OV6VueXuiPnev6pItYXayKoa1hbF8ZW5cYr6IJIMMcgHYIbSQzXeje+P1UUvZ/K96ssiVPBvNWI7harW+BIYGmYhuXS/OXCcrwNkNmiHoZjWdA24+72pUR1a4kaxn6SybyMgemd4dw0Ye4njQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5te1YJ4VloOnLB2ZCNBPHUqdcLahWNSnnezwus2EZQ=;
 b=mRxQMwSCcaadgUmve8I7PFbfCgbH0w09XH9V53kYcnB8AX6KxIwhlK1dzTMtoNsFq+lIxq2GFZQoUqHufS5oYwmQI34nQgo9eXv1MG6NBLzyXz6gBqbkQbNcY8TxF0eIHoKyRBShaeh8Rkf3N8AxN2mzy+q6yOrjwZxQ6kvYhliDr3Sx0Zz3KqPS6Fh+D7Jrn8GG/KX7WGwxhglZJ3m5q3+ytX1TyISKpM/yq0gypERk2xWIp5aA0QZl4DEwXIv0Ur4oeiBzlbJOksjBgBjZbTE+//pDl3acu39Kz21VXMjwXwge51n0nQuhu0pFkZojJJnHAL7KItwcsbbMqj5i4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5te1YJ4VloOnLB2ZCNBPHUqdcLahWNSnnezwus2EZQ=;
 b=2f+2HmC11ap6SprbmHiGtZ3xYdlgDfhwty2FADQxrqPljymx0qd9zVi4szMTqx7HUwOEolcq1Q0m5uYqkGDeKox/6zgRRgtj54G07oL2kI5T7zZB39oA+rV5mX9u7pZJ9eTrWzHqBxwRtipN5mYPeU9FnZSjcAiHgmqCv2ClnMw=
Received: from DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) by
 SJ0PR12MB8137.namprd12.prod.outlook.com (2603:10b6:a03:4e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 07:17:29 +0000
Received: from DM4PR12MB5913.namprd12.prod.outlook.com
 ([fe80::e051:956:ca86:c594]) by DM4PR12MB5913.namprd12.prod.outlook.com
 ([fe80::e051:956:ca86:c594%6]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 07:17:29 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Xu, Feifei" <Feifei.Xu@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: fix shift-out-bounds warning of
 number_instance
Thread-Topic: [PATCH 2/2] drm/amdgpu: fix shift-out-bounds warning of
 number_instance
Thread-Index: AQHc5DgyYihP7/jtz0CbxsCW8VsHDbYYGzWg
Date: Thu, 21 May 2026 07:17:28 +0000
Message-ID: <DM4PR12MB59134CDBADC31B4A56294D83F60E2@DM4PR12MB5913.namprd12.prod.outlook.com>
References: <20260515065753.3488208-1-Feifei.Xu@amd.com>
 <20260515065753.3488208-2-Feifei.Xu@amd.com>
In-Reply-To: <20260515065753.3488208-2-Feifei.Xu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-21T07:17:03.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5913:EE_|SJ0PR12MB8137:EE_
x-ms-office365-filtering-correlation-id: 01478c59-a4b7-47b0-15ba-08deb709047f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|56012099003|11063799006|22082099003|18002099003|4143699003;
x-microsoft-antispam-message-info: sUPmwJN4eXxJ2C9uJAHiXes8lzNAqid1a6H7ydac9pF4Ao7D6xbbU5S95O+9/bgNblPCdpurCnr/7C6hefwIdIvSE6wbp2eKoNf6cvG8cIPN5+Xofa9xeHKnqbgB57ygbsWKLk6kA45JlTXItxcfe9gVDulfPoiDiI3IQy91RJ+3K3WTs+il7DcF99e8pSO+BCHB7e9FkvX3sD3NkNwWd+987b3JRlsxIhfbnAlE5BGizTZGGEtrzO96cwtEwL2PRvasNykGnkBdErhLY12n1CRbLiHTAaCu27H7rvM421cintG+JWMxCG/bo3S6HoB87zfwQlOZf76Bqsgdamj2nNW8p14hA3f72zvA/HobZyqfEUZKV1ny8/aaHjkyymQE472uqrfnv1jeVwrG4DolfwTnYxmkfORBNpho1/srnz5FPxhBTM4Th8T5oDnJLXzO+M68aapS+3WImObkIF2amSCTpeJNED/cFM4BzlAVZZlXcOZeWBmEebcvLu3yxYKiAU67qToKaI7bzI3PbHwumTpQQLKPLjveZkGDgjjB5gqIZgstPQfkkl5LFNGbN+llRNlWW+RjXajDqDH7xRwaf8HL6BsODjROgLgm3+7TIOvCNIL/Cqe9RQaxSqIWnvSpHBfNPQJBZJOvHetTOTHzmFSSEJXWXkCAQKmFc5eHZqnVSFXzZj+iKm8sxoQNpURHzZaVPu+cQIb2AnYFvtrU/9LicT5P8LoWv/5O1QsvrcQ1gOKR9uW65QRJG9EhIFvT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5913.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(11063799006)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jki9AKUHcFqb7UgvcYbhgyLmCD1bt/7l+yOlpp7i6oFFLXlMriUIWTX/EbPE?=
 =?us-ascii?Q?hR9d4zJ2cpMHOrKf1Nz8hu2rU/uO+IPJ19Ex/e2IGq/8Larnad3S9FCwJ2n9?=
 =?us-ascii?Q?aGWHLECE5YRNIacg4po3RTdVetPuDTdDGMOlxG0fNV0gd5F8x375SESaH1fx?=
 =?us-ascii?Q?gNlnj4LW+iXOiNRzkU69MLQrw8q6NXUkdiDTcsYcGe+hBhJKwkZGlqn2cCHl?=
 =?us-ascii?Q?yzK+++zDULEzqRkX2WFSHDH5Hhg/ps0QWzawgI02RJ9VkPQg/hqpJnIFWWRK?=
 =?us-ascii?Q?ufTf15eFd1VCMfZ+/a+HoTAElNKPuHZRC37UM4UHHExgl3ShIHRes2Qgs+os?=
 =?us-ascii?Q?op5YEfr57Sljsm5jhJNCOvQfc0ryBgS8ZOCmf7kHQy4rhl8pROYl5Dbin6ip?=
 =?us-ascii?Q?EMwMFjLED8pc61MLltgp8DgjXwR9F6Tv1EIh7TIbpWnnHh+MgRFXuUTMfXp1?=
 =?us-ascii?Q?R44gaeOJrRDluA1z+NUfuFTYF5pbSMGotgnmz6sisFFW+68kLNiAX5+fLR2f?=
 =?us-ascii?Q?5j8kg/Di5yv2na1YftSdDEi8FkSxBC9lJk1S9E826Mdg03FOgLXMtcB+GjCe?=
 =?us-ascii?Q?eyaJ5qgQ7QYpYlBPdLTQ1SDCcBYaCevMTPSyfNO4hldI+D8z64RwsdKutbNp?=
 =?us-ascii?Q?PEYiU3Eg/K4iWedjCsfQdQN/iuOmF5kLQyTuz8boXgYhbeT0GaLaYg2dXfge?=
 =?us-ascii?Q?Lhd1UiXjRxHhlQPWGqakCshhIMmEDVJuLxOW5Ip1T4Uvh+Z6g0pFfSIUTiEH?=
 =?us-ascii?Q?DXA1TZxB2IkaHSbMs6C9ljFOJV269ViCyno6NObQFUT/cEEGG0IojFQ3/4ft?=
 =?us-ascii?Q?1hP8cSIW3w6f5TLuCYsxz3aSWWS4kDxmKBVbmHbeL57AIfLIEVoQ7tbt20B5?=
 =?us-ascii?Q?jLhdXVJVIEvO1XgIOGrjs/4JkeIdslmQznlb2lalrsOn4rbSmgxc2R9XEj7u?=
 =?us-ascii?Q?n4kwB8ltn8mL33CeEJdZq/zlzvT+puJ+EFxZQxtKAFirPd074bmfajhve480?=
 =?us-ascii?Q?68Kv+/A8y07nEPKnP9bWVwkGzgg7KgxAeGFRIBwfwtnAnEUbhQ9wdyVEu96/?=
 =?us-ascii?Q?d2osGol9ik1uW+znnwN6+i8CEPnIZCoLsubbgwWXXyrHDbebC1yOKfRO7yZG?=
 =?us-ascii?Q?jTtnYU1xsKvLQg0E/oYYW22IPwWrfJ8GgGerbOhSSE8JGNWlL8UTtokePdbV?=
 =?us-ascii?Q?iBOaCKR1ZTpfk92AeKNo/jn/CMXuIWrRgP8lOSep1Y5j4vY5oif34vXtv4Sy?=
 =?us-ascii?Q?SE7HOrIybV8tFWZa5t9UEeYWmpPVIINKAgqVPUhJdo1Qr9v1qfu1c2vo1JIZ?=
 =?us-ascii?Q?vlm22Opr5KPSA/sGSqFsbpUq5xQACtlgf1HlSJqwOD5N4uPdjNyd4LERqH0/?=
 =?us-ascii?Q?KMl0lygNPfaVZBA4nIsJ245pmmkliCXp9+PpuS9FVL92H2cW+bmcl+kYRbx1?=
 =?us-ascii?Q?q2stkIt1dlSnGf1Exzj8QX1WvPuF2WoaW07ZjTY9o36NivzkDH5H4on9lv/7?=
 =?us-ascii?Q?bw1VXukqr5hoUmmHImSXDUGqXgcixYpN8zZ0vgLFBdPdIaXoDQLB1o011LqA?=
 =?us-ascii?Q?vU3ba/GqjS4GLEAwBpGvjFsewMnd1/xSM7tOnwwmNs532I+UN1IU08dN5guw?=
 =?us-ascii?Q?doqf0nghcITr+eMx5RCydPN+pqejNi2RIyqgZmzuWT9DAdv0ehQkFLkFMfQ1?=
 =?us-ascii?Q?b+/sapJaqLtX1rjJ9JbPIrk7fyU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5913.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01478c59-a4b7-47b0-15ba-08deb709047f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 07:17:28.5644 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WgaCbbviamkUXWK9By2l5V5Ny6CcS+6vFSiZjU+AmFhB4i2R7mEVjvxMIf7N/pmK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8137
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

AMD General

Series is Reviewed-by: Le Ma <le.ma@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Feifei
> Xu
> Sent: Friday, May 15, 2026 2:58 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Xu, Feifei <Feifei.Xu@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: fix shift-out-bounds warning of
> number_instance
>
> Clamp number_instance using BIT/BIT_ULL with the <32 check to avoid the
> shift-out-bounds warning.
>
> Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 40 ++++++++++---------
>  1 file changed, 21 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index c9073935e1a4..314fe4a00002 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -840,42 +840,44 @@ static void
> amdgpu_discovery_read_from_harvest_table(struct amdgpu_device *adev,
>       harvest_info =3D (struct harvest_table *)(discovery_bin + offset);
>
>       for (i =3D 0; i < 32; i++) {
> -             if (le16_to_cpu(harvest_info->list[i].hw_id) =3D=3D 0)
> +             u16 hw_id =3D le16_to_cpu(harvest_info->list[i].hw_id);
> +             u8 inst =3D harvest_info->list[i].number_instance;
> +
> +             if (hw_id =3D=3D 0)
>                       break;
>
> -             switch (le16_to_cpu(harvest_info->list[i].hw_id)) {
> +             if (inst >=3D 32) {
> +                     dev_warn(adev->dev,
> +                              "bogus harvest instance %u for hw_id %u\n"=
,
> +                              inst, hw_id);
> +                     continue;
> +             }
> +
> +             switch (hw_id) {
>               case VCN_HWID:
>                       (*vcn_harvest_count)++;
> -                     adev->vcn.harvest_config |=3D
> -                             (1 << harvest_info->list[i].number_instance=
);
> -                     adev->jpeg.harvest_config |=3D
> -                             (1 << harvest_info->list[i].number_instance=
);
> -
> -                     adev->vcn.inst_mask &=3D
> -                             ~(1U << harvest_info-
> >list[i].number_instance);
> -                     adev->jpeg.inst_mask &=3D
> -                             ~(1U << harvest_info-
> >list[i].number_instance);
> +                     adev->vcn.harvest_config |=3D BIT(inst);
> +                     adev->jpeg.harvest_config |=3D BIT(inst);
> +
> +                     adev->vcn.inst_mask &=3D ~BIT(inst);
> +                     adev->jpeg.inst_mask &=3D ~BIT(inst);
>                       break;
>               case DMU_HWID:
>                       adev->harvest_ip_mask |=3D
> AMD_HARVEST_IP_DMU_MASK;
>                       break;
>               case UMC_HWID:
> -                     umc_harvest_config |=3D
> -                             1 << (le16_to_cpu(harvest_info-
> >list[i].number_instance));
> +                     umc_harvest_config |=3D BIT_ULL(inst);
>                       (*umc_harvest_count)++;
>                       break;
>               case GC_HWID:
> -                     adev->gfx.xcc_mask &=3D
> -                             ~(1U << harvest_info-
> >list[i].number_instance);
> +                     adev->gfx.xcc_mask &=3D ~BIT(inst);
>                       break;
>               case SDMA0_HWID:
> -                     adev->sdma.sdma_mask &=3D
> -                             ~(1U << harvest_info-
> >list[i].number_instance);
> +                     adev->sdma.sdma_mask &=3D ~BIT(inst);
>                       break;
>  #if defined(CONFIG_DRM_AMD_ISP)
>               case ISP_HWID:
> -                     adev->isp.harvest_config |=3D
> -                             ~(1U << harvest_info-
> >list[i].number_instance);
> +                     adev->isp.harvest_config |=3D ~BIT(inst);
>                       break;
>  #endif
>               default:
> --
> 2.34.1

