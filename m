Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A62C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 08:50:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47A6710E133;
	Tue,  2 Jan 2024 08:50:23 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32A6D10E172
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 08:50:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbKkOmfKpoZvB7XvvybfHshwyjaW+0YSqrEuPCPJpYXRPta/9WeaOEwOGTwXdMhoaz9ZcMs/4pg1LQ3pIyU59CRCHBzSwznvEWCNAkSbPG5Zwa9Xuo057cTvuKjq6JQZmw9fXxP/CF8QXJCVIjph8kN2w0GioQ2k9goBHZzyY3nPrU9toPnVlEugWSZz+JWMOw3VF59qyZaHGSgGFFixciTqklLQW3NtAfDfCVksRLNdiCoZ2Xg5eAhwQmjE87e6GnSJpZRNdccgCOVJW8ehpDOd69dimN2Z0d46HIVyAbVBld96lUkVJ1xWJmQVjz9kl3j+fJQrq9XKkQ0nVDsEjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRipVS5whjv16PHHyJ+gRyRpVjDC0QaDVzbz0asabXE=;
 b=SqjKSCAEe92BbAhNXEcfYc83IKAknnqAf6Z7KhsJzdyDNT+AG1aU64rQxJUkbLA/A+CBBqMNl/8Kgt14cVibwhW+rGp5ghL5xOx9Caw03TPYaqs29iexRoFraBET0/HaTXO3p4VqpX7td35M05CBnUeTrH8IPZPY88bwN12sbo+L5u1R/x67+CIizlRlYD4nW9k22eyE6j48NsVu89IMIrbcnUsZOZlogMeQUmLizusf5vTVc5WrFx9Lu00rQkv/lrtKqXIO1HH2jV6PLSIGwIh1fSKz5lS2aKXPYObseMoWgE/cz7G0KfdnTcOBlAxt6YRJSt162ESVkMCBPJJhMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRipVS5whjv16PHHyJ+gRyRpVjDC0QaDVzbz0asabXE=;
 b=VIe8St1ZplItZL9DYU/Ltc6RXg5a/YCaJy/gTkfD4+P6sOcTFAf//bWfCuw85/NohPaFnho6vCfMSQ7z/1gO/l25hJCC/31kBX2adNEXOFfKDuIpB1azcx+eHP9PT5Az2r2FDY7iRSzdFlZdA5OgiVvIHpFaYbUs7iWSFsMb29A=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DM4PR12MB6614.namprd12.prod.outlook.com (2603:10b6:8:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 08:50:19 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5866:efa0:7f40:cd66]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5866:efa0:7f40:cd66%3]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 08:50:19 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: Centralize ras cap query to
 amdgpu_ras_check_supported
Thread-Topic: [PATCH 3/3] drm/amdgpu: Centralize ras cap query to
 amdgpu_ras_check_supported
Thread-Index: AQHaPS4VNmDrL80lpUag9ASgWZCIo7DGNvIg
Date: Tue, 2 Jan 2024 08:50:19 +0000
Message-ID: <PH7PR12MB87962AF7A5C6B7594F481A3EB061A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240102034440.16376-1-Hawking.Zhang@amd.com>
 <20240102034440.16376-4-Hawking.Zhang@amd.com>
In-Reply-To: <20240102034440.16376-4-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a6199345-de59-497e-816d-a15ecbdab916;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-02T08:49:53Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DM4PR12MB6614:EE_
x-ms-office365-filtering-correlation-id: c9e9a8cc-6ca9-4556-6200-08dc0b6fd960
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gK+JnPSY3epR3JYohJiKoVAg01ec2YY69BYuMpzSFpwXW9YUtCbW+bknbM92mX/JH1cXeqFLys+Zth7OjbzAoH3Kd/V35X5SH2AQz0of0brdf4IU1d7ZUmyFNyg7uTHip7ctuMBw1p446Y5oDVPwCCwSrapHyWQfm3+6MbhePHbbI+5zaQMLjgotHW4o+BOUpAysR4ooOJPcm+ByXyaWEdLNSUSkUt9tH75LIdz7bAKyKV4QH/gRIcZslfmyQwWSPFw3ybg8tiBVnLydKMfkGn3X/7cXJwNoOBF0SPyh7XcZFsbZWe7v+b8ytZw+uhSO8GKxkUWqNrA3nRDu/enlWKBLjdRhmlFAMQAGyIDCLqgrSxtIiCU0h1dxrvq6373wCc4Ljlsi8Dxo0vZyEdmJiMUf0XsaZNaqWnMQVoo/Wp70ldhbByaEfHpP+jk9K0mi87Gbbs9di4t/5DaDim/TjQ4Q1tUKUbys9O/hC12B7JtSS0JH93aXQrVd14cqcKmbCWRMAHTIelSfsqIVI7bPVI+ckduI5NgTBBGxjv5NnqJdNS5yA1mWzkaWuwUy9wtYrRYnpsIZQ4AgS3Mw6GmRaXFUpFuaGVuAEoISD2GjBYYvsIK4pCvTBCgb8/eGQ+6OFI5fofBQ2afU9INYX3lg7w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(396003)(136003)(376002)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(53546011)(41300700001)(6506007)(86362001)(7696005)(9686003)(4326008)(8676002)(8936002)(71200400001)(26005)(55016003)(38070700009)(33656002)(38100700002)(921011)(83380400001)(5660300002)(66476007)(66946007)(66556008)(66446008)(64756008)(54906003)(478600001)(2906002)(52536014)(122000001)(316002)(6636002)(76116006)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nu/5mwiUB45sZOQ41r+9Uxe4F/l5A75Q22o57zCBfWRO6I0K0ma5Cam+6bck?=
 =?us-ascii?Q?4Sax28I4mjiZso8aR4n0vdQyK4xv5HEq1nVJ1bGYGbIyvxoRLhfrPj18lS1G?=
 =?us-ascii?Q?StywOB2BUaQrHDgGozQap76q8uXYH41JIikvGGZBR1MQ6dG0NEghEWjEAqi4?=
 =?us-ascii?Q?dlH7M1gzA08yMa/ONolGQsVRhe1P35PevxIWeKZ598cFaqFs85GpOcOCF0GX?=
 =?us-ascii?Q?YlKyqCTZsSKcZw2XcTEO19ixsuqX0EryPDVWTeSBvUGKjs7vNrUoECTFT5eP?=
 =?us-ascii?Q?Hqmsr2RWqwnQDRY6sGFfidjTIax3TmA8sNgfDwpg9MmqzlX4EnnXPqjlsno9?=
 =?us-ascii?Q?sByNhk6VFEXWnYux7vMRf5zrcy7PDMCtWhVHkK6nGC+hCN4oYHh/iwHiM2Zq?=
 =?us-ascii?Q?cC/O5XhM3LHVcwWKi1doq8y2IWnsp95ZScRqZ6SPuqxmDZthWpTioqxRwcUj?=
 =?us-ascii?Q?jTc2h2H0/mrbiLFZhViSgsHf+dvYlGDkt55KGl3WO+g+pAchewbrrlwLcBt8?=
 =?us-ascii?Q?L8GCzgUw6qzkM7D/S6URNUtrY0nB5rYm7q9zMEF6fUSoY1CkrV3vsH7CtXBA?=
 =?us-ascii?Q?AnM/04VapKzsE9YxEP0rOaTwWr3obfAQYa4RkILH1Sc0x2Cir0cC86fc0NCV?=
 =?us-ascii?Q?3/AnReEhSzlXs/fLZ9BQCA62RXMngSk/aE7p2IxlGZosZGhpZmN6U31fKupz?=
 =?us-ascii?Q?J/v3OiTyIDsjXaKIRkDjddvUR1u2qckvkn0+gEi3VodOh/Qvzcc2/q1DR7GA?=
 =?us-ascii?Q?0aPWvi0hXBEDvos0I4/QsYtvsO3uQ2RkBX483lf0vWsrkGjVU99cS2rX8bZs?=
 =?us-ascii?Q?IPOtwHy9OnZAqxyuKfxiKwOnZeO/QuqXAQbAixmpcfI5FAt8pMAVSqcTXuXw?=
 =?us-ascii?Q?GY8eHJhbaiChR8G6mPvWe/sgL3qQkmVfv+5jGG1YifG/7qN3jiNRZ6t5RWmS?=
 =?us-ascii?Q?LLeDK0GH5IHN0Wo8Ir73No6AX2Zy3awK0GrGOPYjV66SO76UMuRUwyqWgHG0?=
 =?us-ascii?Q?kQ/HY6r/GBUjajypFiDcJ7pRNjx9KQURzmuqwzG6/8aC7z13y71VilWspz7P?=
 =?us-ascii?Q?v18DS7fQyGYaCZkJM7sYTI5SgcbAnZ0/vEwjPg4jgHI1QpyhY2jiuZY/+y/1?=
 =?us-ascii?Q?DihnZN0ttLu3MyBqw60NjDwOKhWRnTp236iz09pmuQayo/DhcaLELBx96lgn?=
 =?us-ascii?Q?RUd4AvNcI/suNl3KOgygqZwZjVIJu15J18R9y0O5pEYN6zfLx9Ta8aeMfYoV?=
 =?us-ascii?Q?0kRzW9Lr0VNnWCShyHMLPZTdPvpyG43fKi59mUPYxMev3cEjKssF4Mo9Pdjq?=
 =?us-ascii?Q?YSfK3v8iqREDNWFip2yeIWs69y3jKyZKuBTafTPnoJEARb3Dq/EMEQJt++eD?=
 =?us-ascii?Q?PiRDmAq9qzgPxER6wKBiNkiR6fYUphBAJt3mYfH3ulqA+4mZBD6QZx2iePOn?=
 =?us-ascii?Q?af0m0pUEZoVpnTPUKjcZw4deTg1snOl06hMBW48R+3q4K+th1ah5kkyhmlyb?=
 =?us-ascii?Q?+43/fmu5DUmv03xlhSgy9sbAxMxmwfG4CBxoM5mYweTUHQrQESORlpE8zCYq?=
 =?us-ascii?Q?mMlJU5naQcuSxotOhM4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e9a8cc-6ca9-4556-6200-08dc0b6fd960
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 08:50:19.5379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uXPIYrLuaD6nPSOW9J8fEGhf1ErEiJVB2SqvpkVokT+dhFhCidcV3XyYNgpOFu7t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6614
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hawkin=
g
> Zhang
> Sent: Tuesday, January 2, 2024 11:45 AM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Li,
> Candice <Candice.Li@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Ma, Le
> <Le.Ma@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu: Centralize ras cap query to
> amdgpu_ras_check_supported
>
> Move ras capablity check to amdgpu_ras_check_supported.
> Driver will query ras capablity through psp interace, or vbios interface,=
 or specific
> ip callbacks.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 170 +++++++++++++-----------
>  1 file changed, 93 insertions(+), 77 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 5f302b7693b3..72b6e41329b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -39,6 +39,7 @@
>  #include "nbio_v7_9.h"
>  #include "atom.h"
>  #include "amdgpu_reset.h"
> +#include "amdgpu_psp.h"
>
>  #ifdef CONFIG_X86_MCE_AMD
>  #include <asm/mce.h>
> @@ -2680,6 +2681,87 @@ static void amdgpu_ras_get_quirks(struct
> amdgpu_device *adev)
>               adev->ras_hw_enabled |=3D (1 << AMDGPU_RAS_BLOCK__GFX);  }
>
> +/* Query ras capablity via atomfirmware interface */ static void
> +amdgpu_ras_query_ras_capablity_from_vbios(struct amdgpu_device *adev) {
> +     /* mem_ecc cap */
> +     if (amdgpu_atomfirmware_mem_ecc_supported(adev)) {
> +             dev_info(adev->dev, "MEM ECC is active.\n");
> +             adev->ras_hw_enabled |=3D (1 << AMDGPU_RAS_BLOCK__UMC |
> +                                      1 << AMDGPU_RAS_BLOCK__DF);
> +     } else {
> +             dev_info(adev->dev, "MEM ECC is not presented.\n");
> +     }
> +
> +     /* sram_ecc cap */
> +     if (amdgpu_atomfirmware_sram_ecc_supported(adev)) {
> +             dev_info(adev->dev, "SRAM ECC is active.\n");
> +             if (!amdgpu_sriov_vf(adev))
> +                     adev->ras_hw_enabled |=3D ~(1 <<
> AMDGPU_RAS_BLOCK__UMC |
> +                                               1 <<
> AMDGPU_RAS_BLOCK__DF);
> +             else
> +                     adev->ras_hw_enabled |=3D (1 <<
> AMDGPU_RAS_BLOCK__PCIE_BIF |
> +                                              1 <<
> AMDGPU_RAS_BLOCK__SDMA |
> +                                              1 <<
> AMDGPU_RAS_BLOCK__GFX);
> +
> +             /*
> +              * VCN/JPEG RAS can be supported on both bare metal and
> +              * SRIOV environment
> +              */
> +             if (amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D IP_VERSION(=
2, 6,
> 0) ||
> +                 amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D IP_VERSION(=
4, 0,
> 0) ||
> +                 amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D IP_VERSION(=
4, 0,
> 3))
> +                     adev->ras_hw_enabled |=3D (1 <<
> AMDGPU_RAS_BLOCK__VCN |
> +                                              1 <<
> AMDGPU_RAS_BLOCK__JPEG);
> +             else
> +                     adev->ras_hw_enabled &=3D ~(1 <<
> AMDGPU_RAS_BLOCK__VCN |
> +                                               1 <<
> AMDGPU_RAS_BLOCK__JPEG);
> +
> +             /*
> +              * XGMI RAS is not supported if xgmi num physical nodes
> +              * is zero
> +              */
> +             if (!adev->gmc.xgmi.num_physical_nodes)
> +                     adev->ras_hw_enabled &=3D ~(1 <<
> AMDGPU_RAS_BLOCK__XGMI_WAFL);
> +     } else {
> +             dev_info(adev->dev, "SRAM ECC is not presented.\n");
> +     }
> +}
> +
> +/* Query poison mode from umc/df IP callbacks */ static void
> +amdgpu_ras_query_poison_mode(struct amdgpu_device *adev) {
> +     struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +     bool df_poison, umc_poison;
> +
> +     /* poison setting is useless on SRIOV guest */
> +     if (amdgpu_sriov_vf(adev) || !con)
> +             return;
> +
> +     /* Init poison supported flag, the default value is false */
> +     if (adev->gmc.xgmi.connected_to_cpu ||
> +         adev->gmc.is_app_apu) {
> +             /* enabled by default when GPU is connected to CPU */
> +             con->poison_supported =3D true;
> +     } else if (adev->df.funcs &&
> +         adev->df.funcs->query_ras_poison_mode &&
> +         adev->umc.ras &&
> +         adev->umc.ras->query_ras_poison_mode) {
> +             df_poison =3D
> +                     adev->df.funcs->query_ras_poison_mode(adev);
> +             umc_poison =3D
> +                     adev->umc.ras->query_ras_poison_mode(adev);
> +
> +             /* Only poison is set in both DF and UMC, we can support it=
 */
> +             if (df_poison && umc_poison)
> +                     con->poison_supported =3D true;
> +             else if (df_poison !=3D umc_poison)
> +                     dev_warn(adev->dev,
> +                             "Poison setting is inconsistent in
> DF/UMC(%d:%d)!\n",
> +                             df_poison, umc_poison);
> +     }
> +}
> +
>  /*
>   * check hardware's ras ability which will be saved in hw_supported.
>   * if hardware does not support ras, we can skip some ras initializtion =
and @@ -
> 2696,49 +2778,13 @@ static void amdgpu_ras_check_supported(struct
> amdgpu_device *adev)
>       if (!amdgpu_ras_asic_supported(adev))
>               return;
>
> -     if (!adev->gmc.xgmi.connected_to_cpu && !adev-
> >gmc.is_app_apu) {
> -             if (amdgpu_atomfirmware_mem_ecc_supported(adev)) {
> -                     dev_info(adev->dev, "MEM ECC is active.\n");
> -                     adev->ras_hw_enabled |=3D (1 <<
> AMDGPU_RAS_BLOCK__UMC |
> -                                                1 <<
> AMDGPU_RAS_BLOCK__DF);
> -             } else {
> -                     dev_info(adev->dev, "MEM ECC is not presented.\n");
> -             }
> -
> -             if (amdgpu_atomfirmware_sram_ecc_supported(adev)) {
> -                     dev_info(adev->dev, "SRAM ECC is active.\n");
> -                     if (!amdgpu_sriov_vf(adev))
> -                             adev->ras_hw_enabled |=3D ~(1 <<
> AMDGPU_RAS_BLOCK__UMC |
> -                                                         1 <<
> AMDGPU_RAS_BLOCK__DF);
> -                     else
> -                             adev->ras_hw_enabled |=3D (1 <<
> AMDGPU_RAS_BLOCK__PCIE_BIF |
> -                                                             1 <<
> AMDGPU_RAS_BLOCK__SDMA |
> -                                                             1 <<
> AMDGPU_RAS_BLOCK__GFX);
> -
> -                     /* VCN/JPEG RAS can be supported on both bare metal
> and
> -                      * SRIOV environment
> -                      */
> -                     if (amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D
> -                                 IP_VERSION(2, 6, 0) ||
> -                         amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D
> -                                 IP_VERSION(4, 0, 0) ||
> -                         amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D
> -                                 IP_VERSION(4, 0, 3))
> -                             adev->ras_hw_enabled |=3D (1 <<
> AMDGPU_RAS_BLOCK__VCN |
> -                                                     1 <<
> AMDGPU_RAS_BLOCK__JPEG);
> -                     else
> -                             adev->ras_hw_enabled &=3D ~(1 <<
> AMDGPU_RAS_BLOCK__VCN |
> -                                                     1 <<
> AMDGPU_RAS_BLOCK__JPEG);
> +     /* query ras capability from psp */
> +     if (amdgpu_psp_get_ras_capability(&adev->psp))
> +             goto init_ras_enabled_flag;
>
> -                     /*
> -                      * XGMI RAS is not supported if xgmi num physical n=
odes
> -                      * is zero
> -                      */
> -                     if (!adev->gmc.xgmi.num_physical_nodes)
> -                             adev->ras_hw_enabled &=3D ~(1 <<
> AMDGPU_RAS_BLOCK__XGMI_WAFL);
> -             } else {
> -                     dev_info(adev->dev, "SRAM ECC is not presented.\n")=
;
> -             }
> +     /* query ras capablity from bios */
> +     if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu) {
> +             amdgpu_ras_query_ras_capablity_from_vbios(adev);
>       } else {
>               /* driver only manages a few IP blocks RAS feature
>                * when GPU is connected cpu through XGMI */ @@ -2747,8
> +2793,13 @@ static void amdgpu_ras_check_supported(struct amdgpu_device
> *adev)
>                                          1 <<
> AMDGPU_RAS_BLOCK__MMHUB);
>       }
>
> +     /* apply asic specific settings (vega20 only for now) */
>       amdgpu_ras_get_quirks(adev);
>
> +     /* query poison mode from umc/df ip callback */
> +     amdgpu_ras_query_poison_mode(adev);
> +
> +init_ras_enabled_flag:
>       /* hw_supported needs to be aligned with RAS block mask. */
>       adev->ras_hw_enabled &=3D AMDGPU_RAS_BLOCK_MASK;
>
> @@ -2781,39 +2832,6 @@ static void amdgpu_ras_counte_dw(struct
> work_struct *work)
>       pm_runtime_put_autosuspend(dev->dev);
>  }
>
> -static void amdgpu_ras_query_poison_mode(struct amdgpu_device *adev) -{
> -     struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> -     bool df_poison, umc_poison;
> -
> -     /* poison setting is useless on SRIOV guest */
> -     if (amdgpu_sriov_vf(adev) || !con)
> -             return;
> -
> -     /* Init poison supported flag, the default value is false */
> -     if (adev->gmc.xgmi.connected_to_cpu ||
> -         adev->gmc.is_app_apu) {
> -             /* enabled by default when GPU is connected to CPU */
> -             con->poison_supported =3D true;
> -     } else if (adev->df.funcs &&
> -         adev->df.funcs->query_ras_poison_mode &&
> -         adev->umc.ras &&
> -         adev->umc.ras->query_ras_poison_mode) {
> -             df_poison =3D
> -                     adev->df.funcs->query_ras_poison_mode(adev);
> -             umc_poison =3D
> -                     adev->umc.ras->query_ras_poison_mode(adev);
> -
> -             /* Only poison is set in both DF and UMC, we can support it=
 */
> -             if (df_poison && umc_poison)
> -                     con->poison_supported =3D true;
> -             else if (df_poison !=3D umc_poison)
> -                     dev_warn(adev->dev,
> -                             "Poison setting is inconsistent in
> DF/UMC(%d:%d)!\n",
> -                             df_poison, umc_poison);
> -     }
> -}
> -
>  static int amdgpu_get_ras_schema(struct amdgpu_device *adev)  {
>       return  amdgpu_ras_is_poison_mode_supported(adev) ?
> AMDGPU_RAS_ERROR__POISON : 0 | @@ -2918,8 +2936,6 @@ int
> amdgpu_ras_init(struct amdgpu_device *adev)
>                       goto release_con;
>       }
>
> -     amdgpu_ras_query_poison_mode(adev);
> -
>       /* Get RAS schema for particular SOC */
>       con->schema =3D amdgpu_get_ras_schema(adev);
>
> --
> 2.17.1

