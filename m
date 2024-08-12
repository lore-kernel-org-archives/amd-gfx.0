Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77949C52D7C
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 05:47:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27AED10E0D5;
	Mon, 12 Aug 2024 05:47:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NaieGiZS";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04F8F10E0D4
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 05:46:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/W2FCHuX8BRVDFGmJ7nS1Kn+94qtV9HePvokA4o/F8QuTjkBDlAtElmdQ3pqM4gNExTg6H4eRg81mbgGcQAj2X2dTLAITmfmKEiA23afaJXqtxoiE6vKor0tg/ae5XqxW9zf+OfZ6oG9vTzBwrZvIJ9LeCrSBqahoSZfi/eSzKmopCgTGqhQYv40Ey76SyjEUFyfDCFjDSaLz/nJ4DKAr6BflsIFtK43I0AquhwDdPMjq/6ov65SrbOd6st1c6iqkRlXDSlc4PHUzmHbNB2nqZwZYWA1aYfSz4YeblXAcIQRy0Z6tt3l2UJbbjhQ3FtlJ9b4qmvVvQU0C/3fphS7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+O6aO0ux/Q0TDAA1Vp5zbDltrhnZfbt+sQosP4MaYss=;
 b=aBKByAwIdO9kawfMgJ5NsLay4phquh2Hxa/vrueURoEXNEq4JqKLh/XBrFfTwTOok8CjumNtmHOsHMiqX1OhoXWKuq1OZ29ZPf2dGh0Bk6sUPjV+D4Hxc1hfzKrEtrohtlZkt4PoiXKz7eSN1OcYOs0Lopy1Oa8iA53aHtONnaiWujAgpp+iHWtatVOSg2uPhyDCe8OX55uUStR/6NI1iBoMkn4GiHhGXDVVlvqFuMqYuO5HqpzsatdUetS3W/lCkaIcnt/5w3S8kn4uLaTySYR/gGDVd49AtXi09Wa6FMRVhlyEFJ3j7Yv6rzgoIzXJe+uC9uOKO0ZO92yMP2cF5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+O6aO0ux/Q0TDAA1Vp5zbDltrhnZfbt+sQosP4MaYss=;
 b=NaieGiZS4aw9aCZqm3CRnuknEfLZ2jc0U30g7js7N9a3X3jXds0bhVsOouIAprJcxh+FeM4YSVeDHE8sr7eNeDwCDs3FZuSJ4TQAapu5Lt7tLnSRcuCSrV7E5SWSBgAbL0TRs8a5pfNDmKtxEKEId9EBi343u2nu80kIGNuwj9Q=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS7PR12MB6215.namprd12.prod.outlook.com (2603:10b6:8:95::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.20; Mon, 12 Aug 2024 05:46:55 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 05:46:55 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add debug option to enable mode2 for poison
 recovery
Thread-Topic: [PATCH] drm/amdgpu: Add debug option to enable mode2 for poison
 recovery
Thread-Index: AQHa7GdXJzwaACGCUE2KIZ8zqrwtUbIi/TuAgAAdaSA=
Date: Mon, 12 Aug 2024 05:46:55 +0000
Message-ID: <BN9PR12MB5257CDB2528031982591522FFC852@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240812032546.8006-1-Hawking.Zhang@amd.com>
 <PH7PR12MB8796EB006F4E9D99DE041DF7B0852@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8796EB006F4E9D99DE041DF7B0852@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d20fced8-8c50-4f7a-9411-0003b6b43eed;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-12T03:50:55Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS7PR12MB6215:EE_
x-ms-office365-filtering-correlation-id: 005d7a6e-6132-4bb1-9a12-08dcba922cbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?hofu369/tlQtilEzilhxIKIDuy1LX7FV7Pr/WK7nr9k582xnTrdYAkoviZNP?=
 =?us-ascii?Q?3TcsOR+2/IK9ZQ8Ods5e5/Q75wIS/BQDbR2rISqi56s+TI1cYLpx8cHGUaOw?=
 =?us-ascii?Q?eKf+aVaxGjJbt0Ik+CO70mKNIyWtu8k4RoSUfvspOuvxdY+1zPBCr7WLwQve?=
 =?us-ascii?Q?SYgfyLhqILE0M1ped/wyQbuCco225wecyar2zVxDyknNLWgti8jMsibL/n7Z?=
 =?us-ascii?Q?HhA0uqp8Di4Akc/4DeWLO6oo4BhyMxMTecUaCpa8KqMkuM9dZcl5v+OXW4d7?=
 =?us-ascii?Q?9/vaR8H0ZB00XZNSWBXk8IWY38GauAeb9tr7fszrZ/ylxS7CCYZ/4OwhViBT?=
 =?us-ascii?Q?B97Nh00XEFZ5G8tLuITvefGqoH43EPxnh0r/AJblpjHLPuKsYqxwZYA0F4O9?=
 =?us-ascii?Q?cydCtSuYXL6Ej2OmFXZO4dyAiuT9jYsjQG2pFVYIt9oeLw32cFMDtt4cgXrl?=
 =?us-ascii?Q?g55T6dFndQtYQUtAZjnFoL97M00fjKkn21ZsPpDwlUns3UtJhz/kpesjiy79?=
 =?us-ascii?Q?aUAiFoLNSdNObxyuzpA9jbpXGtsoUGuLkEWkiodX8UHTNvg3AfDOfEoiZyQz?=
 =?us-ascii?Q?hcXXXioQAiRC211GsOzyYmAe0kJt2xsgAIZqrCYHaCbGTyndVpoGcqEPFOqg?=
 =?us-ascii?Q?lkemC/pHbkqJ7RkaNDy/4jKD/V9tF3iipfkx5DrdundTXlUlQP0Ol8aS1tRD?=
 =?us-ascii?Q?KCmTr/hWdXMprTvIzW8dxb5I6BBTPkxOF79EwTBYD7WRc6sLlPCVbpxBP5Hf?=
 =?us-ascii?Q?td+8qhUj/GJ6rig04OShI95hvWTsp4j6bdahG0LaVz42BC/p2jVqIb2C9AKf?=
 =?us-ascii?Q?YOxbJTkNzOU1JgdNpLByUQwVUom7201EY00UK3PM4v4mgtU5T/LR846kBLEE?=
 =?us-ascii?Q?i3xwPnQ607TnantRUiSNmfpVC/hASFxUVXofCsfkxZf8EcJY8kxIXHBVkhFq?=
 =?us-ascii?Q?Olipoyt1+W5zKgKVo0xF+omcUOuMf49aeJ4odo366MCabQQrYDIH+IBJickS?=
 =?us-ascii?Q?eJEQwF+cybDiUJm9PLaTiUaeuYh90F2V9JU6wvjct379qiRzH/7iINyO0mu2?=
 =?us-ascii?Q?2+sC9Kl1Oq8/giTgjdQOPjmw8KaZDnpCO+5JQ2j+Tc4PFyE3DgjX7/ThgFnM?=
 =?us-ascii?Q?iPztdvWZZZItL5GNOuXXiTl8z5jVlv/Rn8AAuohjBArxrVN+FiHR2QmHUw6C?=
 =?us-ascii?Q?3F9Owy6p9oIx5evwS0C6WMrWyLhyGcFpKMkDGBpYwuz++prV91WU510ebo1r?=
 =?us-ascii?Q?elRGrAJmxyf3o+v2IT9RYcOu97Foq613PFRvdQl48LLVg2a5FgxnxScqVSo9?=
 =?us-ascii?Q?LRBhA6hNNE78fkgotAt7yF1jpkpSSGJlamFw02i12TImKNjszADQ7lpL2Tqp?=
 =?us-ascii?Q?PiMkU1punBoN4ozwEa4Iy/sbKDxWPqrtjD1/h6WZZQe3eaCOgQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ijxQzqmWjZyQrhkxEioWpfLF19muuUZev//x5YnIPt+lWYCLNL/5qrQck6Xz?=
 =?us-ascii?Q?zJGxXQoVM52OryW5bDtVLZxKU8u28jITkCncRmGukmESC+j5WlpZ+VHgWNu+?=
 =?us-ascii?Q?L5Wj3nEI6ghYaIlUvmLxgsXN72fuctkUT9/dZTPoz3q78uLBW6jPYFgTesfz?=
 =?us-ascii?Q?yVsuLwiI5HahCiyZt8Y1HiUfoqN+/cnvGWZywbUHiyprIczyHVLNngv7Iv66?=
 =?us-ascii?Q?rpxlenGIbquCmSmDB+OhNdNdTRooIOFuqJ+dNaroQdU/jV9bKDEm9/m2KHWe?=
 =?us-ascii?Q?072cvcSITuAC7q0Wi5Z5jpjrRHfioqrZZ3xmgjLcrQ4p82FsRLWtc2f1FQ3p?=
 =?us-ascii?Q?M6LstWZn122vgE3OSkMdmlLcNf5WGM8fyw1UDFXJAeNVbqz7vROnDxWOHDcT?=
 =?us-ascii?Q?GsYjD7plHpZ6wSySsYdgdDmuyxsRbKMpLoN+3XrGSXX0pZBo0lLBVXiBXYqn?=
 =?us-ascii?Q?9zCN5BRsUiuDs96GwKIIZ9x+uCx8hZ/9qhfeEa4EE1Al6tM7exCPHT1rHBU1?=
 =?us-ascii?Q?gIK3aVBIfLvO/SKjwk40+XSjn7NHXThNnYJI5OnX4O2uV89MCkuFuY1D2sBc?=
 =?us-ascii?Q?yFbUnGyXf9y8UfgQUE5DILIQ9d6lJc2e7klH/kn8b0VBVZZqhFGE+fHiImRB?=
 =?us-ascii?Q?RwhK4HrGfQDmynuagR4wPYHCuRHy+pb9pf9+CzvtHUmtv/TeGkv/S6wW8ry/?=
 =?us-ascii?Q?tTjr4HEpvLUyvN5wLJMmqSmDLbOWWnf8R9UP3x9C6A1VLR4ImKTV6qJAoQlB?=
 =?us-ascii?Q?6kKMHJTQNvjwHM4ysfC6a18ta9k8UZ18IPlZtvxVwBsnveYxMCTAQdgVxEW/?=
 =?us-ascii?Q?wUOJQOdilxYNaNpuO6lvbeYJbnJGxgjuJxCMk8rcW2bAFmJxc3r6L0+otYii?=
 =?us-ascii?Q?5MZNsKqH5lAbbTtOgguuuppWxkmHDrikzNJiKaoWfSKK6ot/vn2f6Yf771KQ?=
 =?us-ascii?Q?2vcSyEx3P4pK9+TLzhYJQmSvjMCDtRT0oJUDQzdBLo4cycxVmIiPQ8+zuVBY?=
 =?us-ascii?Q?JO2HpWmYAtbaC1I0GeXKnVhyVhRHNle1g17Yg/gNVZhxz07UFOswKd5j8NKi?=
 =?us-ascii?Q?GmGiYGxyCKAvrr5glVw8z9sghOnU5WHi8NmG30ZkV8Io29nvu52W0jnaBgz5?=
 =?us-ascii?Q?arM0TTnkIRY9X2knBf2twJ0vvpgzFUR7okU3Qz3da0CX3zW3YJ5jCcNS0W/Q?=
 =?us-ascii?Q?DL6P6Do8p1Sa65JHXSjPEnTj2NcfaDfD5jgCmBXu4g6cMM4WirYhJOyCxHeq?=
 =?us-ascii?Q?ipDzDTJkvs8oRIwc9SJsHFM9N67hH2IFtLf9LG+Ohn+6rG3n/JG2QeFZHDSs?=
 =?us-ascii?Q?ebzYJdMQ2ZQgEHrJtRU6QW6s0gs2/DY1ZO2p2k/61I/1ehk9ifsHYpRCvT+V?=
 =?us-ascii?Q?F8o93fg9FBGeBGVJohQApnZ+yy1dzJxPu72yGjhBWeNeDjvjxRwLxl7izm/1?=
 =?us-ascii?Q?LMKE3kC/eChMEyXrzQ2U3clJVLqKfM4K4XNul40ohZLROT0emLKpuc9y9kGI?=
 =?us-ascii?Q?JOXXnPk4H5sEMr221DES8hHPUv2mpOoeMTaz2pr9gzMRkZ1JFfkRO/VN4g?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 005d7a6e-6132-4bb1-9a12-08dcba922cbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 05:46:55.8121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0zEw5lcX637oVGxPw3YxVj7vOxI3VqHn4C9CQ0nqibiBFwQwI6bSAZoqiFQzs4UwBj/1gFfAPQY24WTv22i4QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6215
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

Yes, it could be applied to ASICs. But only gfx 9.4.3 needs the option for =
now. the others we've identified the solution. Switching in-between might i=
ntroduce issues.

Then probably just keep the change in local for testing purposes.

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Monday, August 12, 2024 11:52
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add debug option to enable mode2 for poiso=
n recovery

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Hawking Zhang <Hawking.Zhang@amd.com>
> Sent: Monday, August 12, 2024 11:26 AM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Add debug option to enable mode2 for
> poison recovery
>
> Add debug option to enable mode2 for poison recovery for testing purpose =
only.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h             |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c         |  6 ++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 16 ++++++++++------
>  3 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index e6b641cb362a..c34819f947ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1201,6 +1201,7 @@ struct amdgpu_device {
>       bool                            debug_disable_soft_recovery;
>       bool                            debug_use_vram_fw_buf;
>       bool                            debug_enable_ras_aca;
> +     bool                            debug_mode2_for_poison_recovery;
>  };
>
>  static inline uint32_t amdgpu_ip_version(const struct amdgpu_device
> *adev, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index afe3b8bd35a1..be6b920933d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -133,6 +133,7 @@ enum AMDGPU_DEBUG_MASK {
>       AMDGPU_DEBUG_DISABLE_GPU_SOFT_RECOVERY =3D BIT(2),
>       AMDGPU_DEBUG_USE_VRAM_FW_BUF =3D BIT(3),
>       AMDGPU_DEBUG_ENABLE_RAS_ACA =3D BIT(4),
> +     AMDGPU_DEBUG_MODE2_FOR_POISON_RECOVERY =3D BIT(5),
>  };
>
>  unsigned int amdgpu_vram_limit =3D UINT_MAX; @@ -2229,6 +2230,11 @@
> static void amdgpu_init_debug_options(struct amdgpu_device *adev)
>               pr_info("debug: enable RAS ACA\n");
>               adev->debug_enable_ras_aca =3D true;
>       }
> +
> +     if (amdgpu_debug_mask &
> AMDGPU_DEBUG_MODE2_FOR_POISON_RECOVERY) {
> +             pr_info("debug: enable mode2 reset for poison
> + consumption
> recovery");
> +             adev->debug_mode2_for_poison_recovery =3D true;
> +     }
>  }
>
>  static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev,
> unsigned long
> flags) diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index 816800555f7f..a355b2bc2214 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -164,10 +164,12 @@ static void
> event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>       case SOC15_IH_CLIENTID_SE3SH:
>       case SOC15_IH_CLIENTID_UTCL2:
>               block =3D AMDGPU_RAS_BLOCK__GFX;
> -             if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) =3D=3D
> IP_VERSION(9, 4, 3))
> -                     reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
> -             else
> +             if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) =3D=3D
> IP_VERSION(9, 4, 3)) {
> +                     reset =3D ((dev->adev-
> >debug_mode2_for_poison_recovery) ?
> +                              AMDGPU_RAS_GPU_RESET_MODE2_RESET :
> AMDGPU_RAS_GPU_RESET_MODE1_RESET);

[Tao] can we apply the debug option for all ASICs?

> +             } else {
>                       reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
> +             }
>               break;
>       case SOC15_IH_CLIENTID_VMC:
>       case SOC15_IH_CLIENTID_VMC1:
> @@ -180,10 +182,12 @@ static void
> event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>       case SOC15_IH_CLIENTID_SDMA3:
>       case SOC15_IH_CLIENTID_SDMA4:
>               block =3D AMDGPU_RAS_BLOCK__SDMA;
> -             if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) =3D=3D
> IP_VERSION(9, 4, 3))
> -                     reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
> -             else
> +             if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) =3D=3D
> IP_VERSION(9, 4, 3)) {
> +                     reset =3D ((dev->adev-
> >debug_mode2_for_poison_recovery) ?
> +                              AMDGPU_RAS_GPU_RESET_MODE2_RESET :
> AMDGPU_RAS_GPU_RESET_MODE1_RESET);
> +             } else {
>                       reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
> +             }
>               break;
>       default:
>               dev_warn(dev->adev->dev,
> --
> 2.17.1


