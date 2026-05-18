Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70A6CD4F3C
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 12:29:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FB7B10E318;
	Mon, 18 May 2026 12:29:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xGap1o0G";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B357A10E318
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 12:29:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9+eqgLQDYeSRM0kClrgvPa05zcUuzcYlcjQ0MZoO+mlesnArB5Fa+ZeboBwqoWkylDrQCUjLnhuBCaSOps+Kss8dWg7G5zQ6/SoISgCi3x/zpz9e11XnA51jRTavTfGQcM7ppEX6fXiLFJTWb5GMrrU2/EQ6134oUnicC/Hr10I6XeKCHI1mFPCLTxZUo8fMJVphLQXfFxEH4JVSysfrElDpT0e0lHQOjkwcd5xupLd2hzuOCGEccBnETn38SEWwDnHyZafr+RsCIrjX+fbBNoEZZgYC9EQRJPpuY/051N0Swzz4Hp/gpCn7w+cu8L+Wj6ZzDVqxqjEAG3SO/kvyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BissBLHW4Yp9rSjBv/FW+64IaQZjuG1iCGJecXw29U=;
 b=CoHrd9czULEbh39Px/awjKfUztf3FSocW3l7o/fVuXCXQszMTkGn9hTRyk9bthbO4qya5LaW0m6oJfHpvNy8UM8lfBxwX3NlYQdVU6vB1RYs6d2gggVG7dYoSt7dUEiGm1AoEfVRp7dN84KbYU25jR3h7gXuj/M9IEIhI5uVqi44FcxauRRgN41SJxnkAgS8tl6dQaw4t4T2M88pKXvmJZAvBYAhVDuv+QBHKzs0prgb2d0ITuSYeLnx+or8+avSoLRMDQgYJiipdfjNUL7tC/nZnOGFFtv5uH1+vzT+eMKX23RpvoDCksVzjoRnKmZZnZ7ibspfOHk5ixuLYwsAmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BissBLHW4Yp9rSjBv/FW+64IaQZjuG1iCGJecXw29U=;
 b=xGap1o0GVAT+FenPFs/ghqL/qfWnCYB1XTSAA0e/uukNMXgIWclfvPhlkvYRhydd1g17mB+jX+9hCbdn3nQPF/IGW8V87vUVRkR2XEXAGLeqzeEHfziS6SSolYOSvHHOWiUItdkMM783Xs12+q4z5K1RPUQwKKMFpVyfP5DmG3A=
Received: from MW4PR12MB7431.namprd12.prod.outlook.com (2603:10b6:303:225::22)
 by DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.24; Mon, 18 May 2026 12:29:15 +0000
Received: from MW4PR12MB7431.namprd12.prod.outlook.com
 ([fe80::34d1:4c70:8c65:ed21]) by MW4PR12MB7431.namprd12.prod.outlook.com
 ([fe80::34d1:4c70:8c65:ed21%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 12:29:13 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 3/3] drm/amd/ras: Fix UMC error address allocation leak
Thread-Topic: [PATCH 3/3] drm/amd/ras: Fix UMC error address allocation leak
Thread-Index: AQHc5pKyo5ycmF/rNEeTqrl/JB4AJrYTtm8g
Date: Mon, 18 May 2026 12:29:13 +0000
Message-ID: <MW4PR12MB74315200A1582D328758600D9A032@MW4PR12MB7431.namprd12.prod.outlook.com>
References: <20260518065030.2311-1-xiang.liu@amd.com>
 <20260518065030.2311-3-xiang.liu@amd.com>
In-Reply-To: <20260518065030.2311-3-xiang.liu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-18T12:28:11.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB7431:EE_|DS7PR12MB8252:EE_
x-ms-office365-filtering-correlation-id: 39fd8942-8e66-4a31-2071-08deb4d91220
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|38070700021|11063799003|4143699003;
x-microsoft-antispam-message-info: HbW7b1RPgtLnuuR7RekBDNU1K9ojAvMwZsNwrOHX40Y/k/pN5SYhKq2oxRwDX/W6Z/gv5q02grld5Dq6amhRHcvbEr3sc6IPn5UyBIxMmkSoyhWCm9gl5QVIb6wsZiS+g2Ylv7hvPcMOV0EXLicQABXcH/UR8nwQCVB4uCJn57Q0PRjJkmREGlf5ONTGkUeLrs0g07Q6H9x8YaGzffS1rm9BCt3D9l78o9jed6ptTv8MX/RpDAF+8GLlZAC6JJty9CZ2FzjDEpmJemSAFBf5LAZO6mkl5mAdsHB+GoclEI1oV7f/aQ+QnIvpr8yT1sC8urRQyl3eXklZk2AU/qhAhbliwuPepRxOxplcRncWyOBj4YvXVUq62OYP/AqYgkJpTtjAfuhoDMmwGjURst9iRxRdWxyXHBMYDbGH2p3SQAiosYfxKhvgtNE3gZrtkVUm+JvPSbojb8OuLnq08ZqcV9zW+pflG270ClJnhb0zMSTz3MB9xMalQZ4LYlEslGS2xnKU0HKTvnIo7AALdWDTc+8dMbG1aVD+KCEU62eymTbcrMnnW/e7ll+qByYH9DyQdoYx3uEwytPWvXguZbah2zEA1AFF/P8iviIDjctxEblheMaw05DIFivopC6E6GO+jeu6YYfX49ZbaNZb89bWo0Q/x4OMN2f6O8W6UY7/XdBkQDfzItyiy7W4TEfyreU2gUy/tVa55C3d5xtPTAmAfCG4L6dK5q+uftdgci5RllncvCCLXltOOnVM/qfln3fx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB7431.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021)(11063799003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yVmhJ812FSAlz2bkWSyfoszwOrb3Nmli/FQ7K6wZqjV1A60ssQIDVAhI+kZ4?=
 =?us-ascii?Q?3LaLBlvDG/IAfY6jPUvlnxKhEZO3Esfqun+GAShvKQ5Dq2uGFB+urAEmru04?=
 =?us-ascii?Q?qg95rJteWL7Q/PlTt4uvgxUXeaZOlCTVuoPNXS31qQlbODHT9AEjR1BSz5fS?=
 =?us-ascii?Q?a1Aq7Gpmi0+Kt8Z4hifUpGM8WPufkvA6SWBua3QFI4eKO6jaJNAH7qogc8jZ?=
 =?us-ascii?Q?4QUvgI5qMPakF6UE0Rt+LUCjDJ/Sf+i2nvYmogUxvblOWtctAkHwphzfeChf?=
 =?us-ascii?Q?1q9AS1ZmqpkRd8jxPb63auZ1HDrFoMvgx36S6npU8bO2bct3Rj6FVnEux5Zu?=
 =?us-ascii?Q?pMj7BZvEeh2A40QmjmdRLrHWmICdm8Sj1Tx2w2x8uIRUefg7U5+EYqwfrrMx?=
 =?us-ascii?Q?CYuJIVYb1EU2cfasbMWS7cwEoT3Yiq/sm6G60q20BRIA0z5C7dVn3lqh3SQQ?=
 =?us-ascii?Q?H58fVfw/qcuN5b9Op8QTdbtAMP51B5+nXa1zsJCbEGC2e5vjjjQ6a8RLzMmw?=
 =?us-ascii?Q?Ej12frK4pmn4LskxIjx5FGn6WDD2iRV61uLZb32oA+uLIPvFZkzefF0gACLa?=
 =?us-ascii?Q?7m4vytVmqo1Np6W45cGcmmS/y2qvIpxC2qliJRn0nGyTyjW4SrPHRbfk4nem?=
 =?us-ascii?Q?PyicyLUQtL/T21Z+Pqr4InaCSsMCM15mzktWl2fAZXARShBa9Rk+V0h4la1j?=
 =?us-ascii?Q?C09NJnVZrdRYABlx/8k9zvC0979csxRuivWCrXhxlqgo0ixXRfzRCQqTt1Gy?=
 =?us-ascii?Q?JJcBgiMQciGgHvJUJmUGwlD+wk9Hr0uJoIzOJnKJaqIupKPWCkkLgP+fdNZT?=
 =?us-ascii?Q?cma3hBTPpxPWeepIwhB1Oc/a7tO3r1O3IzCz/jFPJ9A9mvvxxgbxxFJXALvn?=
 =?us-ascii?Q?VghzQUBpMomvvqoYAPPitu4yiK6zeAGNAFczUt2gBzRpnzvHY85zLlLTbIOg?=
 =?us-ascii?Q?JPVziX+icfCPn/S8bca+z5iYYauhBe6gmk169ECNb53KBwYvu7/c+qpyfmIS?=
 =?us-ascii?Q?hFDFPeaIHAXyoEPic+Q6O8/CSUAW9LYZZbVRNdpgVBDbxyK9adY+T5bUkfcF?=
 =?us-ascii?Q?B57qekj2SXZ10776xRfXon7bqveiI8TdyQFk9tn+WntaVIzPG5gX5U9ILuBe?=
 =?us-ascii?Q?14I40zPcQ4r0CJ6nFC1WoBpy/ZAfY+MNaNRD6d3HkFbSkne2jmHE4oVHxCkt?=
 =?us-ascii?Q?dhAilpQUOkVAvK75quTGjeoVe43Rkp2jByoF2tvDk8xwXx6VafXkkluE8wO4?=
 =?us-ascii?Q?VJ0Z0o1Ngmr6JaHKw0gs5gZ4icd6rk8aj1q33WJWU2jgzui+oC1/uqVMCFgX?=
 =?us-ascii?Q?Q5URURFKOX2hRtAZwn7GsHOlxS54YQA1tQ0M6tELFtDoNMJJqXfUvse4zTY+?=
 =?us-ascii?Q?XpL5/K1sut1PuBT2Lk1eZkYuXjJWHOH608ylYwDtxwUJC+p7gnseGHmb6Pfe?=
 =?us-ascii?Q?JS51/BCjfSDY20T5Wx1ALi20lHiYnesX07CLC9R5ctWoKW9/6FBZa6HnNkwu?=
 =?us-ascii?Q?rzjHaKYRAzaV/GRrp+G5hQh5BvgQsCC8iKKaKRqig0hW68GhJ7SvN37YUwNP?=
 =?us-ascii?Q?zY1Ozt/skaY6ozY74NA0xHA6KDjnF34KQrsCYQ+rMmcaQG0oObjjT0cKjcQp?=
 =?us-ascii?Q?BC11NLNRXcbs7pJ2fChlRhPHW3Fk4mvBMSTa1GE+2L3o+DQS2ZYz4W0SIIKJ?=
 =?us-ascii?Q?nc+g5j8q8oFpQ0/IyNMM/AjT/KWcDtUDDkS4THsS9hg8ijgN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7431.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39fd8942-8e66-4a31-2071-08deb4d91220
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 12:29:13.8157 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: se5otzCt4QUv0WwoHWQWAxgl1xF0zobwMFYXEavW8afcyzwqW+WDHfa0d5999TI2UjhRDIvXIb2EPIbsFWdbqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8252
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

The series is Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>

Regards,
Stanley
> -----Original Message-----
> From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Sent: Monday, May 18, 2026 2:51 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Subject: [PATCH 3/3] drm/amd/ras: Fix UMC error address allocation leak
>
> amdgpu_umc_handle_bad_pages() allocates err_data->err_addr before
> querying UMC error information. In the direct and firmware query paths, t=
he
> pointer is reassigned to a fresh allocation before the original buffer is=
 released,
> so the initial allocation is leaked on each handled event.
>
> Free the existing buffer before replacing it in those query paths so the =
function
> exit cleanup only owns the active allocation.
>
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index 1be722ba6c9e..a250109edb63 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -130,6 +130,7 @@ void amdgpu_umc_handle_bad_pages(struct
> amdgpu_device *adev,
>                       if (adev->umc.ras && adev->umc.ras-
> >ras_block.hw_ops &&
>                           adev->umc.ras->ras_block.hw_ops-
> >query_ras_error_address &&
>                           adev->umc.max_ras_err_cnt_per_query) {
> +                             kfree(err_data->err_addr);
>                               err_data->err_addr =3D
>                                       kcalloc(adev-
> >umc.max_ras_err_cnt_per_query,
>                                               sizeof(struct
> eeprom_table_record), GFP_KERNEL); @@ -160,6 +161,7 @@ void
> amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
>                       if (adev->umc.ras &&
>                           adev->umc.ras->ecc_info_query_ras_error_address
> &&
>                           adev->umc.max_ras_err_cnt_per_query) {
> +                             kfree(err_data->err_addr);
>                               err_data->err_addr =3D
>                                       kcalloc(adev-
> >umc.max_ras_err_cnt_per_query,
>                                               sizeof(struct
> eeprom_table_record), GFP_KERNEL);
> --
> 2.54.0

