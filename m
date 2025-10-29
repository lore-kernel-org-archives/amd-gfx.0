Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF7FCCD1BF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 07:47:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D4B210E172;
	Wed, 29 Oct 2025 07:47:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="grX1pj3C";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79AD810E172
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 07:47:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhzPDnfo9ETpYoKSyWTU/cVG30pB/dJY+RSTABR1pbBl50dEM7YZxqcUX8ur4KXJpaSTzeGEX+6j1vL46AYc/pX3ukPTFTNxKB/HwGB+8af9PhV9M04TnCs8wNS0O0pXWqjcuk1L+C2ACuFJLoBdiOlVUd3F18htFDS7zeu3vbWF17nkj4h/ralg6YYlh0hlYTBeKZMg52x9+tJGOHfLr53QjkVuqG2z7pkrKvzUL5KONu+xNPKVrweFtWiBDGKnj8r/PSUQrSw5q+4EjNP7+u5I5zyPSY6TNYAw45YtcgyIs61zYDx14i/itX+nIkm+WSeMiDZAIY97bi9ALj8Kpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Dp9npUhMIyIcaihFTbP6SMltenPVRBIAMFRYgnHjmU=;
 b=Lba2lO0syLn/UalZoPLIv3z7zBQnSHuGlOdN9uklB//SXVVbk3nskRNBuIhwWXzN26yGQyA1MB9zIbO3el/hjlhb4414qxHlIsCKxvy2IR2jwDvXLrUZlXbAFxp0TmPsew3Tt3OWoKzbOs5MxIcgH3b5lo1oF0TbXzlqmQpqgFxJm2Uls0RaEPi593dg/qLQkVvrGYAJk7JAsq40IZYSyNZ/G2UQz/TK3aLDMLS8Suk/8KFIe5+fVrN9gkBFhxsyS1xjQoXYOZfKLsQkZ2gfh2wc5z4nNmS5g610HR+NFj1IKQDRnAVHgsaGG+3k2BLOOw69O+GU0nZT7/CnlSUbgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Dp9npUhMIyIcaihFTbP6SMltenPVRBIAMFRYgnHjmU=;
 b=grX1pj3ColPExxjCh9p36RMEtYklVhpn4UtJ0VSF+TNAXrgPKA8feaY/zUIR72rPum4tlFj6PIrlLfgLGQHca4VC1PZewxFFB/ZsgcujA69l1L9FMkkiZ5fnz/EIRSEPaGZgr5G43Nglwx/k+CPYOMLx5X5GLo1cN8SE3S2j3v8=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by LV8PR12MB9081.namprd12.prod.outlook.com (2603:10b6:408:188::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 07:47:44 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%5]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 07:47:44 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>, "Su, Joe" <Jinzhou.Su@amd.com>, kernel test robot
 <lkp@intel.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amd/ras: Fix the error of undefined reference to
 `__udivdi3'
Thread-Topic: [PATCH] drm/amd/ras: Fix the error of undefined reference to
 `__udivdi3'
Thread-Index: AQHcSH37lvkrYAKMjUGk/FCqcWHL1LTYvf5w
Date: Wed, 29 Oct 2025 07:47:44 +0000
Message-ID: <PH7PR12MB599755319EC4B65B9B68C58E82FAA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20251029024328.2068340-1-YiPeng.Chai@amd.com>
In-Reply-To: <20251029024328.2068340-1-YiPeng.Chai@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-29T07:41:51.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|LV8PR12MB9081:EE_
x-ms-office365-filtering-correlation-id: d67ad170-4c09-4d72-f704-08de16bf7221
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?9ydod3QAvAG9t4x4EXv499te24vQs5CyqJ0fbl6KlKT5+4GFduodVfRR/gXo?=
 =?us-ascii?Q?3amo8WkU6OG860KGEZ09FKq2FsUVWpwXEZ5PVZniH72vpWcdW8Ey5dndZHYi?=
 =?us-ascii?Q?w4Npitu3NcX+WlHRbKN2/neb5lZcXNltvqcDuJB9SxwvmM0dl1YWpHQh5zb+?=
 =?us-ascii?Q?YP11TFgAJPFtxjKr4U9AiRk+mTh/9SVHnrAJVY/Da+O8dIoYrfo3/bVH7APV?=
 =?us-ascii?Q?OgSJ/5JPXxHicrgxwlBUHMqGc6mYtDI92GOjqCuRZeUlzw4IvhTsUDv2oNW+?=
 =?us-ascii?Q?C1dVK44cxECX4IG2WLh6f9Xhqmo132y3KVl0xMvQht8RolE8YXfCT965cLH4?=
 =?us-ascii?Q?XuxZXFHsGMt0sJDs25xdoieGMPM4i+pmsyxw3CY8/+wXDH5+2wFld00BKqwd?=
 =?us-ascii?Q?tV1NYJY/fPOm0cL3Q3OdVXmhahjlVGkGaWwuXcU0OnhnRPoGbzPWnG4JDnmT?=
 =?us-ascii?Q?UrsFGXbqGffkeUJxnS6NuCTkNEhe+fUY0crs4gcayt3lOTKy6d7Y9IP4j2gW?=
 =?us-ascii?Q?l6b1T+fAqriH87yeJYtFfev/5bLbWbjixnrva1oCozYwvugcSsE5bDmTMv3n?=
 =?us-ascii?Q?hDbZ/uwRE7BEodGm06fhcKj8YvnJN+YY/6UB7VV3IR2MKtNvUfOAeAGoEbtL?=
 =?us-ascii?Q?riL4UDe6A3lUYWWoJxXzAdILWgaJtxueVwkJHvRFvCl5ppkADPIF/mIhZxUx?=
 =?us-ascii?Q?DwcwFZ6jEMlgwZYJCeZB6wuWPsph7XynjqWefl/flcUMmhDGzx/g/0qjtH6s?=
 =?us-ascii?Q?kVqVBLo6ZChbvFC+t0ckfoX2qI/owTID6EIJV7uQPjZ5LpSf1xTToXZ+eb3E?=
 =?us-ascii?Q?MJUj9coPjNoYSCcif3JFFTXO4/5W1hFZ78VTMXp8QIb0pNv/Lh0UVUcHYXt1?=
 =?us-ascii?Q?ZJtwBLG2NxgWFMXaTDZ6RVmqCK3wTDZ8BGV0iLn1gAOqKhAxyXZtxbjUB8Wd?=
 =?us-ascii?Q?GjgYDY/wPtXl2eyeSCGp/ijlARjJ0qEjF6ML2AS+uuGtWpNLuQEMjpGPuLvV?=
 =?us-ascii?Q?e8weyZr2eFF4CzdqlKWgaDHH6QZCXlQUuGwUyMn3ZDbTRbxJJpUzaTgXAnV3?=
 =?us-ascii?Q?Y9CcSARMpqyjvaYjum7ezXYTz6XIJTKM546MwLdA7J/3HntDFZP20oLAVDod?=
 =?us-ascii?Q?YLhgFD9NXdhVV91CNKPIF0tLRaJtodCXaPwhiRPahOHDdjDfoqQM57QqGUI7?=
 =?us-ascii?Q?keuXLHVdWebnfsjYgWhwNewZhDrbgsL6yDY4f5j//S5psLlCumf5DcCko+7A?=
 =?us-ascii?Q?ksfU7HUal8gtiLLcTSigzXSLA/prUqaUcHi4Q5IRKikEvECEpQgNgkX74kDk?=
 =?us-ascii?Q?zYqrg8DaXyKu5Mjpp5Gaz8qteWF8zzGKeVGEmFKsS7w7spRQ6Q5IV07L7ZSD?=
 =?us-ascii?Q?cW3Cc4UwtPtOacwdjizCeCqt/eqdElwduMZu3PYvM5zWj29U1k2uxCoyardN?=
 =?us-ascii?Q?XzF/OJPFt4gJO7XXN/+qbGMhIIwiskt0ncY7EUxga7tQFSkYg9kONU9qlcWj?=
 =?us-ascii?Q?REYBfQrCRZveDflQuMMn8X2W7FGwHbY+4KMQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QS73YTzKBr+F4BqJPh1tM62ivTSt0yTYnqWU/olFaeFRMfleQRlHrVby/UFn?=
 =?us-ascii?Q?sQfCqYqTKyui/e9e8gsVEvk+61ShuhBlCd0jhHW+ND6xDAPg6GUCT4oMiZQ0?=
 =?us-ascii?Q?2Cg7b3A0Dc4Deko5xvY1fw1EbGnpAMb6yGUSOLnGAPbDeUJii1OMMKAcwZGf?=
 =?us-ascii?Q?elKGtd59xzeXppW6478Tox/2fxYPdJdNfGfNia45bB0hZ8rkKls8c23F85mn?=
 =?us-ascii?Q?n9sV83aQyMziQjjh1ss+LOPtwl0Ck0v2wNnfgRB23t6RjsIb2QldvmB50kDf?=
 =?us-ascii?Q?3MrQcmgX0B9HhTr5uCIN73m9IG9hZWHY8UHXeknd6O8dHphslIxH8QeE+/0v?=
 =?us-ascii?Q?5Oklf2eILFvKCq0FqabEhNxYwPG9wNYdWvAgtJYhQ4MrwethHwSu2AQoZH1J?=
 =?us-ascii?Q?Jw0y0QuWgfSFngqWksj9Dj/0oXI8WxAcIRGzBBKU7IEjKf6VWKjDh90Zc5pA?=
 =?us-ascii?Q?JXYNEf5SOXwu0OX0KfNg65j41MJ1EPvWQxgNlIIVBnJg32tlI+f8ZkfPAjEe?=
 =?us-ascii?Q?PXcNRljeXEyJAoQuwbdrs0VJwT4oHRaXpqTKekTPaZNQbUZD69lOxofwi1DB?=
 =?us-ascii?Q?tLZNdt3gV5QIxr9riOXY23KynaV+yrIZj2o2lcFKV9/M822iFTH5wNFsfg4S?=
 =?us-ascii?Q?s/N/G01jSAYr6cB6oIJp8zTbis6ex80RSS4nLLoOLP0vq2QeaXmkzlGGGtVZ?=
 =?us-ascii?Q?cqcaMpFkszRp/jRjNTiuLBLR/98nu9M4qjpy4SuEqA+QeAOumwljHP0mI6wy?=
 =?us-ascii?Q?b00FephSomGPqG4LoP3CVT968bNusMVZL9ozhHQda2oCQOltuyMG5l1GzgU5?=
 =?us-ascii?Q?gYyRaHeYeFBD+tMe8RTAEvzUL9ktBU2qwHVFuZXpImTVsZFQFzOY/RQY+0w/?=
 =?us-ascii?Q?3myM1oIUsDWdZoh5O79/e9VSmlk8mqjwttGjXDyVAK+G0fy1M7fzEzrVOLRm?=
 =?us-ascii?Q?HMAQaFC41kZ0w5dYlNSPsBJ+Zb7+5+aAWtjgxbViGgrMit8zX6gtqJEjj5sh?=
 =?us-ascii?Q?BKJyF4MH8dupRLKZcZ8YYyG4bqjwt0CJkqpzCGpfG/HWtdr915taYCsvWvgw?=
 =?us-ascii?Q?jsJpiAniS6rDENfw1myDRFsNyUUSfVKPHKOFkYf/zjK/+ofYRfjwBDc7TJGA?=
 =?us-ascii?Q?Z82QRaem4QkOwWIMER50jEL8IpF0FIpHPFnZIPR4ciyV47N+4NHxt/aIU73T?=
 =?us-ascii?Q?+w1QNyTVsCyWRbRwpRYguKUfWgJfZAydNAD/1iAccWjQW0hZpQI2RZ2hV7yh?=
 =?us-ascii?Q?0fYo767jWczBAD+VN+I6JU0Xp1GdnAGitRPWFl5rEgnwVNln4HG96oJV5TzJ?=
 =?us-ascii?Q?r/hnn/v5RvaL6x8md90K/Vwp+oa41v6n1BguyzkhTYy4/JHuaEVxoUyXvBfP?=
 =?us-ascii?Q?eO+6bqdggaMKyuZuMdQe1GuDG+UcMVQpTZe/iVw6z36b3n6AR9zGzixUG+cM?=
 =?us-ascii?Q?gRg3pfU8we3YTHfgi63APS6l4phMnV+cnvq+StleFrKZtV6ox4z+FyVqsIJN?=
 =?us-ascii?Q?fsEbc6aE0P2aFqus6KLIoX9HVs7BRxbAb+ypkfJPsHJQCnlBZ0FOCaOYdsTp?=
 =?us-ascii?Q?axlnZ2wGmUUc71v07D8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d67ad170-4c09-4d72-f704-08de16bf7221
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 07:47:44.2026 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ch19wa7Px0OVvRAK0RtqePjVwUA4v5cmH9rs/WF7wB5yI+Ns3/Xf5GlezTksjYG4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9081
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

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Wednesday, October 29, 2025 10:43 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.co=
m>; Yang, Stanley <Stanley.Yang@amd.com>; Su, Joe <Jinzhou.Su@amd.com>; Cha=
i, Thomas <YiPeng.Chai@amd.com>; kernel test robot <lkp@intel.com>; Zhou1, =
Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amd/ras: Fix the error of undefined reference to `__ud=
ivdi3'

Fix the error:
drivers/gpu/drm/amd/amdgpu/../ras/ras_mgr/amdgpu_ras_mgr.c:132:undefined re=
ference to `__udivdi3'

Fixs:b5bae0f01786d("drm/amd/ras: Add amdgpu ras management function")
Reported-by: kernel test robot <lkp@intel.com> Closes:https://lore.kernel.o=
rg/oe-kbuild-all/202510272144.6SUHUoWx-lkp@intel.com/
Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 8007e49951d8..d09c4a75a7f4 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -37,7 +37,7 @@
 #define MAX_XCD_NUM_PER_AID                    2

 /* typical ECC bad page rate is 1 bad page per 100MB VRAM */
-#define ESTIMATE_BAD_PAGE_THRESHOLD(size)         ((size)/(100 * 1024 * 10=
24ULL))
+#define TYPICAL_ECC_BAD_PAGE_RATE (100 * 1024 * 1024ULL)

[kevin]:
Please use Linux SZ_* macros instead of hardcoded value to make code more r=
eadable.
e.g: 100ULL * SZ_1M

The patch is Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

 #define COUNT_BAD_PAGE_THRESHOLD(size) (((size) >> 21) << 4)

@@ -129,7 +129,7 @@ static int amdgpu_ras_mgr_init_eeprom_config(struct amd=
gpu_device *adev,
         */
        if (amdgpu_bad_page_threshold =3D=3D NONSTOP_OVER_THRESHOLD)
                eeprom_cfg->eeprom_record_threshold_count =3D
-                               ESTIMATE_BAD_PAGE_THRESHOLD(adev->gmc.mc_vr=
am_size);
+                       div64_u64(adev->gmc.mc_vram_size, TYPICAL_ECC_BAD_P=
AGE_RATE);
        else if (amdgpu_bad_page_threshold =3D=3D WARN_NONSTOP_OVER_THRESHO=
LD)
                eeprom_cfg->eeprom_record_threshold_count =3D
                                COUNT_BAD_PAGE_THRESHOLD(RAS_RESERVED_VRAM_=
SIZE_DEFAULT);
--
2.34.1

