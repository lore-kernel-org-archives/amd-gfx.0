Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3531C3ABC0
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 09:34:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 916D110E37F;
	Thu,  8 May 2025 09:34:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rCBTrNFa";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A205110E37F
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 09:34:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dww4lM2D2mYLAc5q7VKwvNjasx4oMBt3zY1gJZwGJmwvl5gyfVZSVbXG34xCOeJzg+DA4hQNvlTXMYJilDStc85eEFBhrJR6RSb+zxEhozVGLzBKweeyFusqPJd64f50Psiy4436VUu8B/knYNflB1rydiK5KQAKPIEla24ClcyC95iYMzR0qJNJMkcoGVvc4icdVGZY4oNZCOhKUk1y7fkdO3QNfXOtVM5uwEUJcIzrTW2Ojwsr002f+nGn5HFKx43YVHSVdq4EMiiW1jEnz3PKoUE0yCRWhk1HRlG/ZBlQyryMvcJhdE4E/HtWY8yyP5FGypFREiE4bsC4xfvyhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMjnIY0ed/yAqhY5pC48cn72dMEhYDP8kGxEPMziwLQ=;
 b=XP37Z1BgCGawAm8Hi7WfkxfcPH3NQKaoAL7SM+BmF3M5pdWMK/G7PwYmn///Ej/JvS7l2VIJrxy39QykkCQadBPi5h63+lujnqp5VYyHw5omlTNanvzPAC1KC9s4Qn+6xTYkziarP9lIwWJ3ee4x4jEL+MJM2F70C3SiupWGKEcu6Qb/MjN/tUGL6ooSgvkAazuAi90Ix0vQXcKf89NtsM71lIf+6p5HaCOXoxt4HMW7NLLo1CvgiiuoSOflmWw5K5OEem/4BwIYhHIIUTgm0GVMHuT2d2zAGHkRPn35e45W+SIszOSls9ruICBf4S26/woj4xjH9zsXwj+tO4AH8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMjnIY0ed/yAqhY5pC48cn72dMEhYDP8kGxEPMziwLQ=;
 b=rCBTrNFaPZWlohUGsKCnUpLvgtAdGKAz3vU4QqWSwWC4wNMugI3u6JTSz/fouWwuxXt4lKks3l20Rd2vXVYxfv920EtF7EIEtD4N4uNoe/0u+nBi3XlIfjfyj+QLDRFQ9SFk/szBcwwmg4CGW3QWKa0AxtNrEHnoGOj5r3+NMxc=
Received: from PH0PR12MB8773.namprd12.prod.outlook.com (2603:10b6:510:28d::18)
 by MW5PR12MB5621.namprd12.prod.outlook.com (2603:10b6:303:193::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Thu, 8 May
 2025 09:33:56 +0000
Received: from PH0PR12MB8773.namprd12.prod.outlook.com
 ([fe80::47a4:8efb:3dca:c296]) by PH0PR12MB8773.namprd12.prod.outlook.com
 ([fe80::47a4:8efb:3dca:c296%2]) with mapi id 15.20.8699.026; Thu, 8 May 2025
 09:33:56 +0000
From: "Zhang, Morris" <Shiwu.Zhang@amd.com>
To: "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add debugfs for spirom IFWI dump
Thread-Topic: [PATCH] drm/amdgpu: add debugfs for spirom IFWI dump
Thread-Index: AQHbvwp3+7tl5Bq+w0qYOyfDvO+3+bPIea6g
Date: Thu, 8 May 2025 09:33:55 +0000
Message-ID: <PH0PR12MB8773D3ADD8CD6D40D46D7127F98BA@PH0PR12MB8773.namprd12.prod.outlook.com>
References: <20250507044159.1006093-1-shiwu.zhang@amd.com>
In-Reply-To: <20250507044159.1006093-1-shiwu.zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1edc1c76-3d9b-40da-b3cd-3400b86ebdb6;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-08T09:30:48Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB8773:EE_|MW5PR12MB5621:EE_
x-ms-office365-filtering-correlation-id: 9c47d30e-eaed-4e3f-cae4-08dd8e137418
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?FjWH+v9+Wv3P1yHSkIyeU9fiOXEZvC1Yew4P+JKFMwLy3wpJV5F+q8pJI6IB?=
 =?us-ascii?Q?yKs2G0NrdMdIWdpq1krm0uIQuMsFKy5XiNPqXvLxRYKAcABiEYtmEyb1w6AJ?=
 =?us-ascii?Q?6ci/XbsjfJDLhlVeHm4sagplRcLEyghYygaE/qd3i7R0zinrdxRAcnQWasUV?=
 =?us-ascii?Q?iKVSchhfIw61F7hCL7FguhbxcbmUOQz+qQLXLT6gFB/wM9MwLFU/jtXSW9q/?=
 =?us-ascii?Q?7z5d4ddSfySbAbPiyWC9Yl1Zy42BLiSgoXJLqz/SdadKlbUma6wgzd9dosho?=
 =?us-ascii?Q?4pEuVz3HMKmOyYAEjBac/gLm8N/TwSRk7jMm4vYqa/iKybhAo+FRcifl/0Z/?=
 =?us-ascii?Q?+ylu4ooEfz4MXSDFm4+gVc91d7LzZzc4e04wfewkr9yCjmFlOZQ4pNIgrYke?=
 =?us-ascii?Q?wllsDkcBWqPqfXme2u2oN6DNkSnQJChj//nxnZq+rB8/2Jg/PU1dpxdziXN4?=
 =?us-ascii?Q?X9jZL93MTpv6JxC9gkY+cZBWxEf7qhVMDdtMj0k4XbYfzGRuTFdHiYpzgAbS?=
 =?us-ascii?Q?szTdpRWmVAMo9H7DhGVq5mM7VcNaA5IxxRBPPN9uTOaU2fC+J99Y8W+/UpLi?=
 =?us-ascii?Q?6yCb7lC3NAb/2x0OmodPkIBr2ALc8644TitpRJWVPIcoa1JBKRlgRbK0cuZB?=
 =?us-ascii?Q?GnzxWTQAnrzHP1z/U1jUMtf0jAzb9Wd/970OIiMgcvJzgu0OA9m9Wdrd5imQ?=
 =?us-ascii?Q?ZVRlcAq80HIJjPGUWsZoPVumn6yj7PUaBMwf5UvmglPCRC/cxiNAcl/ciJWS?=
 =?us-ascii?Q?pfRUbbcH6Y3V0A6GzJsr/7IWeAoJSFSFzqDJX1mBLQ/HeCF7dxRAsYLjP0UW?=
 =?us-ascii?Q?8NjPPq1TOmrYd2Hxil3hX2Wik76q6TdGDVZjgkDh5/ih6U7ux0BZxAZvufrK?=
 =?us-ascii?Q?n8uabOzjLAOp8oH2cs4c2cXnFtZwgI5GV/X8xWzuTHwz0/b+jmxy9lQSIMQL?=
 =?us-ascii?Q?MUhI2jXkojScZqo6+P4eFeWckzFaRKaz82obthhKqb4+SuvAiJ8NpsAH/CPN?=
 =?us-ascii?Q?bpz4KwLyMuPT5VWAgGRsv9t6Xkoq5BicRDBQqZJyOHffCLBEhahGmVPVLwKZ?=
 =?us-ascii?Q?0Z1FcGJbfzA70gTCN0MGtV7LrMhXmvD8Gxw80a6R5looRuw+kR1BsuSoOMYD?=
 =?us-ascii?Q?siQ4wDgzcPK3DD3UMwgxDTjSAdRtktHDyyNoSsJuG893djjT1ntZcIQjQtG3?=
 =?us-ascii?Q?Y1JuOzJez4i1QlxpuRRVzLKp3IINk2Z1fZj5ltdazx9sCrn0ekOqquDBKs8t?=
 =?us-ascii?Q?YoDBaSHiaaV0TDwc1qg3kKwZvSq8lWkkFjhDSl/2CZfDMVwkKnNFsVBPZdI8?=
 =?us-ascii?Q?EIhaz7oLfB71qd3FrnLVhDPbup1sxAhJlTBJnXW2arE+EljoXoXojsaT39AM?=
 =?us-ascii?Q?SZp/eoH2fLUm260jc3fizae+lK4Vt8+iE3VWeGZiwA9HKAYAWZpoTTehFf3x?=
 =?us-ascii?Q?4dX2YQmGuG/gJxw3EhvJ3CsZn41Hz+DyAek656pNwUO/kTmfLT6bEw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB8773.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DqfkJf3AUu9lcSua5UdjwKVNOo3OwiObsEbk54WofIv4faODZYtuaXBtADeD?=
 =?us-ascii?Q?oahKZNKx3RpA5qb7FNUwDChSYkBqJmHELDagZld503n5S1Q/ZZ5OmV+2wTi9?=
 =?us-ascii?Q?sgx4qJEmhB3RFm36Z1Ws6hqdslVdifg5/2OWwLC0DmpTtw1fT1sgGWSc/JWF?=
 =?us-ascii?Q?LumgtfOietL25UGqoznH48njyRF3me35/6pTwdUaIyHwbsB7N1pAcWC3Ej8o?=
 =?us-ascii?Q?k7PV/SAJSuaAODIgtxWsb4+QxWzESTkN9j6zEvi8nus1a6dIsRIl0z+rrEmn?=
 =?us-ascii?Q?h3jQTb5m64x8s2tTNwun1NDNFW63emin2kFcqoYCktvn++i699RXZ/LWOcBG?=
 =?us-ascii?Q?vbhDjkwryw1W5G6OSGlskV+3rBtvCEMl6/DAykVPc+OFUCwojrpGBYDah5xL?=
 =?us-ascii?Q?NzFyp0SALjOyFL1w8NUzI4MWGj0oISmpDGZRxnum7dyYZ2f/QJat93ahpHDn?=
 =?us-ascii?Q?xJOEpvuIHhke8rFXJeZ3V23BExT4/vBx4mvQ2CqXuD5n9XUG4MpNq4yiJ1HO?=
 =?us-ascii?Q?BsenJL+g5zKCVlftQA4w7yKn1UwHarxcIxhYlM+CHjqWTBwlunHXmkkasSt6?=
 =?us-ascii?Q?LhE8BJXDtSYfWMVNjvd2qu1HmQQbkMjf7fs5XXn/M+OypeAWSflxLsae1vmZ?=
 =?us-ascii?Q?7bdczpcosFjaB/W27zawydoblRUUJTKmYQAA3OjwuRiX0Z34+5R3gtaers9/?=
 =?us-ascii?Q?5XJKoCEvQscdmg2kPhLQNNTNg2GeXFiej3rJJaaR2cNeaYzzgV5zLJT/kgpC?=
 =?us-ascii?Q?VsrH6BAyLyRzCYGNyo7aMYOp4l6vxGh2iPFABXALQCGtoKqGOrTbwnZX4FbS?=
 =?us-ascii?Q?dRjeps+C4oeF5J6ZEL05B8mFp/nf11Cgrhf+0s7xS0B3wljqk1Xg/r31UqTO?=
 =?us-ascii?Q?P/w40qQsKDS1/MC43MdluE/jngaTfZvk/FRiRacoVq8y6kyD6me2F5tRxTDp?=
 =?us-ascii?Q?aaToJNYInB59CLV9cyvs+oogx5DRD19k/0TRk2D23IKH7RAdb8sDC0q0cjsU?=
 =?us-ascii?Q?5UNmNYa7B9U6nCiNKFqOuy+Fqk+2YUBvxXp+PJ0KUJvUKPbtl4VOkjHWfazo?=
 =?us-ascii?Q?q4lSEjnmUDrSO2Jcs3Fu9A0cfwKBjdULDPvGXYE5BgE0f/+WqALxoRHUuwCg?=
 =?us-ascii?Q?inSmw1DQ05LCve8M8ZyK+tC3E/vdx6d00ILhGCl671QpZRaAevOriWZWcJgk?=
 =?us-ascii?Q?7ww04kORTQ0wTP1A48xB392RYgSSIVwcws2/RN7w1a6dn4gWgRKL3+WHF5FV?=
 =?us-ascii?Q?RINiFzCryRzf7XA2FvHoVSFWztFbE+8RwgMDRxROKAZ3JPGs2FgVKF5btk9g?=
 =?us-ascii?Q?1d9hP8B2AnsoZsbu1hOt6O9X1jaUaakeOL0RHC5Od5JHyj5HydpjUcAubmSm?=
 =?us-ascii?Q?24fLrSE5IVPnHDtV0AcQBSXshpgku8IvXnpOC67bfTxM50zQ0e7DFXkxd6yw?=
 =?us-ascii?Q?7Nh0c4XOd2swAlNdUNP3ZZ/DzL/vuaX+3wLjyohUYRfwTXq6+Ph6DhgRmnYQ?=
 =?us-ascii?Q?WOOGGG7V6U0pLzd32bCu0/rzKBfKWBWPBgwKQAh56O56C033Ali7iv0BlPvo?=
 =?us-ascii?Q?UVAZOyV18qe52PdZwek=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8773.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c47d30e-eaed-4e3f-cae4-08dd8e137418
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 09:33:55.9243 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IwtlhWe88K5z+fGAGY31dnsQ1c+Ej/SPC4PCo15xZ69V5Pfn2UrkgvnoQweKslKk3JLnG7StlF9ViHFZz9IOeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5621
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

[AMD Official Use Only - AMD Internal Distribution Only]

Ping. Thanks!

--Brs,
Morris Zhang
MLSE Linux  ML SRDC
Ext. 25147

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Shiwu
> Zhang
> Sent: Wednesday, May 7, 2025 12:42 PM
> To: Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun
> <Likun.Gao@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: [PATCH] drm/amdgpu: add debugfs for spirom IFWI dump
>
> Expose the debugfs file node for user space to dump the IFWI image on spi=
rom.
>
> For one transaction between PSP and host, it will read out the images on =
both active
> and inactive partitions so a buffer with two times the size of maximum IF=
WI image
> (currently 16MByte) is needed.
>
> Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c     | 104 ++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h     |  17 ++++
>  drivers/gpu/drm/amd/amdgpu/psp_v13_0.c      |  40 +++++++-
>  4 files changed, 161 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 4835123c99f3..bfa3b1519d4c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -2113,6 +2113,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>       amdgpu_rap_debugfs_init(adev);
>       amdgpu_securedisplay_debugfs_init(adev);
>       amdgpu_fw_attestation_debugfs_init(adev);
> +     amdgpu_psp_debugfs_init(adev);
>
>       debugfs_create_file("amdgpu_evict_vram", 0400, root, adev,
>                           &amdgpu_evict_vram_fops);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 6f9bcffda875..210a7bdda332 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -4185,6 +4185,110 @@ const struct attribute_group amdgpu_flash_attr_gr=
oup
> =3D {
>       .is_visible =3D amdgpu_flash_attr_is_visible,  };
>
> +#if defined(CONFIG_DEBUG_FS)
> +static int psp_read_spirom_debugfs_open(struct inode *inode, struct
> +file *filp) {
> +     struct amdgpu_device *adev =3D filp->f_inode->i_private;
> +     struct bo_address_triplet *bo_triplet;
> +     int ret;
> +
> +     /* serialize the open() file calling */
> +     if (!mutex_trylock(&adev->psp.mutex))
> +             return -EBUSY;
> +
> +     /*
> +      * make sure only one userpace process is alive for dumping so that
> +      * only one memory buffer of AMD_VBIOS_FILE_MAX_SIZE * 2 is
> consumed.
> +      * let's say the case where one process try opening the file while
> +      * another one has proceeded to read or release. In this way, elimi=
nate
> +      * the use of mutex for read() or release() callback as well.
> +      */
> +     if (adev->psp.spirom_dump_trip) {
> +             mutex_unlock(&adev->psp.mutex);
> +             return -EBUSY;
> +     }
> +
> +     bo_triplet =3D kzalloc(sizeof(struct bo_address_triplet), GFP_KERNE=
L);
> +     if (!bo_triplet) {
> +             mutex_unlock(&adev->psp.mutex);
> +             return -ENOMEM;
> +     }
> +
> +     ret =3D amdgpu_bo_create_kernel(adev, AMD_VBIOS_FILE_MAX_SIZE_B * 2=
,
> +                                     AMDGPU_GPU_PAGE_SIZE,
> +                                     AMDGPU_GEM_DOMAIN_GTT,
> +                                     &bo_triplet->bo,
> +                                     &bo_triplet->mc_addr,
> +                                     &bo_triplet->cpu_addr);
> +     if (ret)
> +             goto rel_trip;
> +
> +     ret =3D psp_dump_spirom(&adev->psp, bo_triplet->mc_addr);
> +     if (ret)
> +             goto rel_bo;
> +
> +     adev->psp.spirom_dump_trip =3D bo_triplet;
> +     mutex_unlock(&adev->psp.mutex);
> +     return 0;
> +rel_bo:
> +     amdgpu_bo_free_kernel(&bo_triplet->bo, &bo_triplet->mc_addr,
> +                           &bo_triplet->cpu_addr);
> +rel_trip:
> +     kfree(bo_triplet);
> +     mutex_unlock(&adev->psp.mutex);
> +     dev_err(adev->dev, "Trying IFWI dump fails, err =3D %d\n", ret);
> +     return ret;
> +}
> +
> +static ssize_t psp_read_spirom_debugfs_read(struct file *filp, char __us=
er *buf,
> size_t size,
> +                             loff_t *pos)
> +{
> +     struct amdgpu_device *adev =3D filp->f_inode->i_private;
> +     struct bo_address_triplet *bo_triplet =3D adev->psp.spirom_dump_tri=
p;
> +
> +     if (!bo_triplet)
> +             return -EINVAL;
> +
> +     return simple_read_from_buffer(buf,
> +                                    size,
> +                                    pos, bo_triplet->cpu_addr,
> +                                    AMD_VBIOS_FILE_MAX_SIZE_B * 2); }
> +
> +static int psp_read_spirom_debugfs_release(struct inode *inode, struct
> +file *filp) {
> +     struct amdgpu_device *adev =3D filp->f_inode->i_private;
> +     struct bo_address_triplet *bo_triplet =3D adev->psp.spirom_dump_tri=
p;
> +
> +     if (bo_triplet) {
> +             amdgpu_bo_free_kernel(&bo_triplet->bo, &bo_triplet->mc_addr=
,
> +                                   &bo_triplet->cpu_addr);
> +             kfree(bo_triplet);
> +     }
> +
> +     adev->psp.spirom_dump_trip =3D NULL;
> +     return 0;
> +}
> +
> +static const struct file_operations psp_dump_spirom_debugfs_ops =3D {
> +     .owner =3D THIS_MODULE,
> +     .open =3D psp_read_spirom_debugfs_open,
> +     .read =3D psp_read_spirom_debugfs_read,
> +     .release =3D psp_read_spirom_debugfs_release,
> +     .llseek =3D default_llseek,
> +};
> +#endif
> +
> +void amdgpu_psp_debugfs_init(struct amdgpu_device *adev) { #if
> +defined(CONFIG_DEBUG_FS)
> +     struct drm_minor *minor =3D adev_to_drm(adev)->primary;
> +
> +     debugfs_create_file_size("psp_spirom_dump", 0444, minor->debugfs_ro=
ot,
> +                             adev, &psp_dump_spirom_debugfs_ops,
> AMD_VBIOS_FILE_MAX_SIZE_B * 2);
> +#endif }
> +
>  const struct amd_ip_funcs psp_ip_funcs =3D {
>       .name =3D "psp",
>       .early_init =3D psp_early_init,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index 3876ac57ce62..8fc4a7bb865e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -138,6 +138,7 @@ struct psp_funcs {
>       int (*load_usbc_pd_fw)(struct psp_context *psp, uint64_t fw_pri_mc_=
addr);
>       int (*read_usbc_pd_fw)(struct psp_context *psp, uint32_t *fw_ver);
>       int (*update_spirom)(struct psp_context *psp, uint64_t fw_pri_mc_ad=
dr);
> +     int (*dump_spirom)(struct psp_context *psp, uint64_t fw_pri_mc_addr=
);
>       int (*vbflash_stat)(struct psp_context *psp);
>       int (*fatal_error_recovery_quirk)(struct psp_context *psp);
>       bool (*get_ras_capability)(struct psp_context *psp); @@ -322,6 +323=
,14 @@
> struct psp_runtime_scpm_entry {
>       enum psp_runtime_scpm_authentication scpm_status;  };
>
> +#if defined(CONFIG_DEBUG_FS)
> +struct bo_address_triplet {
> +     struct amdgpu_bo *bo;
> +     uint64_t mc_addr;
> +     void *cpu_addr;
> +};
> +#endif
> +
>  struct psp_context {
>       struct amdgpu_device            *adev;
>       struct psp_ring                 km_ring;
> @@ -409,6 +418,9 @@ struct psp_context {
>       char                            *vbflash_tmp_buf;
>       size_t                          vbflash_image_size;
>       bool                            vbflash_done;
> +#if defined(CONFIG_DEBUG_FS)
> +     struct bo_address_triplet       *spirom_dump_trip;
> +#endif
>  };
>
>  struct amdgpu_psp_funcs {
> @@ -467,6 +479,10 @@ struct amdgpu_psp_funcs {
>       ((psp)->funcs->update_spirom ? \
>       (psp)->funcs->update_spirom((psp), fw_pri_mc_addr) : -EINVAL)
>
> +#define psp_dump_spirom(psp, fw_pri_mc_addr) \
> +     ((psp)->funcs->dump_spirom ? \
> +     (psp)->funcs->dump_spirom((psp), fw_pri_mc_addr) : -EINVAL)
> +
>  #define psp_vbflash_status(psp) \
>       ((psp)->funcs->vbflash_stat ? \
>       (psp)->funcs->vbflash_stat((psp)) : -EINVAL) @@ -578,6 +594,7 @@ in=
t
> psp_config_sq_perfmon(struct psp_context *psp, uint32_t xcc_id,  bool
> amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev);  int
> amdgpu_psp_reg_program_no_ring(struct psp_context *psp, uint32_t val,
>                                  enum psp_reg_prog_id id);
> +void amdgpu_psp_debugfs_init(struct amdgpu_device *adev);
>
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> index 17f1ccd8bd53..78f434f84c22 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> @@ -79,6 +79,9 @@ MODULE_FIRMWARE("amdgpu/psp_14_0_4_ta.bin");
>  #define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_LO 0x2  #define
> C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_HI 0x3  #define
> C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE 0x4
> +#define C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_LO 0xf #define
> +C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_HI 0x10 #define
> +C2PMSG_CMD_SPI_GET_FLASH_IMAGE 0x11
>
>  /* memory training timeout define */
>  #define MEM_TRAIN_SEND_MSG_TIMEOUT_US        3000000
> @@ -710,7 +713,8 @@ static int psp_v13_0_exec_spi_cmd(struct psp_context
> *psp, int cmd)
>       /* Ring the doorbell */
>       WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_73, 1);
>
> -     if (cmd =3D=3D C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE)
> +     if (cmd =3D=3D C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE ||
> +         cmd =3D=3D C2PMSG_CMD_SPI_GET_FLASH_IMAGE)
>               ret =3D psp_wait_for_spirom_update(psp, SOC15_REG_OFFSET(MP=
0,
> 0, regMP0_SMN_C2PMSG_115),
>                                                MBOX_READY_FLAG,
> MBOX_READY_MASK, PSP_SPIROM_UPDATE_TIMEOUT);
>       else
> @@ -766,6 +770,39 @@ static int psp_v13_0_update_spirom(struct psp_contex=
t
> *psp,
>       return 0;
>  }
>
> +static int psp_v13_0_dump_spirom(struct psp_context *psp,
> +                                uint64_t fw_pri_mc_addr)
> +{
> +     struct amdgpu_device *adev =3D psp->adev;
> +     int ret;
> +
> +     /* Confirm PSP is ready to start */
> +     ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> regMP0_SMN_C2PMSG_115),
> +                        MBOX_READY_FLAG, MBOX_READY_MASK, false);
> +     if (ret) {
> +             dev_err(adev->dev, "PSP Not ready to start processing, ret =
=3D %d",
> ret);
> +             return ret;
> +     }
> +
> +     WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_116,
> +lower_32_bits(fw_pri_mc_addr));
> +
> +     ret =3D psp_v13_0_exec_spi_cmd(psp,
> C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_LO);
> +     if (ret)
> +             return ret;
> +
> +     WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_116,
> +upper_32_bits(fw_pri_mc_addr));
> +
> +     ret =3D psp_v13_0_exec_spi_cmd(psp,
> C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_HI);
> +     if (ret)
> +             return ret;
> +
> +     ret =3D psp_v13_0_exec_spi_cmd(psp,
> C2PMSG_CMD_SPI_GET_FLASH_IMAGE);
> +     if (ret)
> +             return ret;
> +
> +     return 0;
> +}
> +
>  static int psp_v13_0_vbflash_status(struct psp_context *psp)  {
>       struct amdgpu_device *adev =3D psp->adev; @@ -898,6 +935,7 @@ stati=
c
> const struct psp_funcs psp_v13_0_funcs =3D {
>       .load_usbc_pd_fw =3D psp_v13_0_load_usbc_pd_fw,
>       .read_usbc_pd_fw =3D psp_v13_0_read_usbc_pd_fw,
>       .update_spirom =3D psp_v13_0_update_spirom,
> +     .dump_spirom =3D psp_v13_0_dump_spirom,
>       .vbflash_stat =3D psp_v13_0_vbflash_status,
>       .fatal_error_recovery_quirk =3D psp_v13_0_fatal_error_recovery_quir=
k,
>       .get_ras_capability =3D psp_v13_0_get_ras_capability,
> --
> 2.34.1

