Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958741093179
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 06:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25E6410EA89;
	Fri, 20 Mar 2026 06:39:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pNd7YOkA";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6E9210EA86
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 06:39:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6wJrlI/IblvlW+lxgDAM+41daS9sE28Lw6PVHj0kpWNi/uCjis8zBlG/gGcaRIvHQ0uJ1RhwmxYZ7adQjns+ghWMjNhlvzQTfjpI4k+3B6ay/4Ms/mDVNIQDd5Rmt39PPBRZPScFozlc1Dalq4r9wx2e7G9VWr2WjzvyKK05gcnqN6T69GFNVkg5tKD5Q1YyXvifyywWtJ5X6LyhzljFQG9SicTlUFxQ3F3mFnanVISvLKdAhBSnOB5ZoAuCLv/Dp21b+O6khnQgtgNSZ1BkFlHyeeCF0ZPs2TJcAjGCHtUrK7I3UZkHVDscgSm0UL7Yc71jOkBk5NliqdoIG7iVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLKqMtVL3y5A1kML8ASteew+xqoQvNog3+ZCKZq1+Gw=;
 b=AQpX4AY4zoNifrexjEz8KMypVt8BQeFxLykM3xcgpH4A9BQbqP8wV369mrjEEeEpnyEsbwPJZUhppFkXwUTMwq410n3CeI8okgGlBMA9CbUoJEhTnWiDMZj/h+9mS5SeARs1L8uImcLLU3ZtwqFy/OjrfvjWq1Z6NMaxil0OdGiGggdnlRGVm2aXt3Mi81v8jf8l6r0D+RFUtSRNMeOXKHIQKwDNtdI1wTfu9VRHm1t18avOmbjPXFQC6Uh5YM55EMwdElQreuh2I/RY9ho2SYa7EGEvmciH2r0d7X1qAwW3IcEhjb/Jm08Z6ObnOy+M2ef1toU2TylYmRATf6SSxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLKqMtVL3y5A1kML8ASteew+xqoQvNog3+ZCKZq1+Gw=;
 b=pNd7YOkAjvqxvHlUkne/DitapM+ncF3ASeDHd3M0ILErvMmUjidXY7HphqvGbuQAQcfwOsowY2iwYM/3oir2ga9I4SDm5GwaTgwmJpvo6IdWkln9Wz+zBz5biADBiDgUwfFmcicxOcTHDQ6TxtJfY45cMhBrBrCsCHbAoag15oI=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 DS0PR12MB7947.namprd12.prod.outlook.com (2603:10b6:8:150::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.9; Fri, 20 Mar 2026 06:39:06 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.20.9700.006; Fri, 20 Mar 2026
 06:39:06 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH 1/3] drm/amd/pm: Unify version check in SMUv11
Thread-Topic: [PATCH 1/3] drm/amd/pm: Unify version check in SMUv11
Thread-Index: AQHcuC9r+xOOfrl+c0Gd+9GZ7B/yabW28OGw
Date: Fri, 20 Mar 2026 06:39:05 +0000
Message-ID: <DM6PR12MB29727D5217CFA4B1590DACE1824CA@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260320060409.616702-1-lijo.lazar@amd.com>
In-Reply-To: <20260320060409.616702-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-20T06:13:10.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|DS0PR12MB7947:EE_
x-ms-office365-filtering-correlation-id: 5c8910fc-3e8a-450c-3a32-08de864b6232
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: Kzt7KlUWzIA2nE2Q66cANcNXat+ygq2y8B3hkAK/bj0gi6HgLBquvDQS+jsU1uRRTsR+9DyWXSRRZ0F1Qzi2znRBQe9URCEspLkrVntU0Jhk2ZEOWV/D1A8FMiaOtEFUvMCoUOAHLFuMFUNlyMm+WFaKBlVcdpt3EPWw9mNkGTqcCFs237z/V84/40EA3NyiYIE9eRmR3IiRox6+4sclRWGPRBe8P4j4x6qVTK3f4O0YD/q3cng4Borim0MIXuuOui7pe0aX1/AvWolcIRKEOMxJhP1l6lns0tjn1oKttvrrtbnV+Y+fwxNohRQ27dPSK7dthKDCYdOBYBGF8RbG8WCD6h3i1GO50aiKQpSU9RIZczvJiHkhJlfEGBkWbMCwN68/NL6fIsGsLMDQtjM66XMqLtloGg8JSZ1886mBceIZL4or3rBNjxu/AOLZxeX+vDY27114SJcL1i/udPpMULPgVhHvrKGGWg0bEGmx5BMDE8pWJctOY22mhePQQ5Jxh/Vq1hY3+4x/hYqHiwByE2db4scnsrAw7dIZeS7zD6Bg/lujhUHqFwU7ajEqAB6hQSUDO6QJE+qZeMIR5vapOlo1KTXb/unrsnEIkOul8jXS7oyaAMPzyjPhO39E3qkX8TGnDlE0JLfudsV01qUdL6NWnDYYufRykghGuBNmyvqqM+D6mRm9Lh6xICv5zQSilDEHGpKr8uxlIChRCHY2r2HeqKtEUIgYb5EwYlvcMU9AUb3JFgDAt2vVVVhTqWWPt8m2/p99L3ixm+GQZZ8CrCn3PAHHPIQ+AGgDQ3NH3kQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OTdeD/NSn9LQLYz/kFpivsWaB+b0SHNEgOP42FYeQHWXbvi9Um6MMoSq+N3k?=
 =?us-ascii?Q?zTNL3wRiUuZtHktx4CPITWnQbdE8tYPftmUQ8SKdGl1YMNRaAEixV5cmtsZD?=
 =?us-ascii?Q?LKI2ND6ychRg12xXDSd3MxTDtxlyIf+JfjDLRihokJ5l6h5OqXs6XX0VpeWQ?=
 =?us-ascii?Q?aHTpkoDz8lGiUQP+aouCUMqZVv0UHln3SbNWJ8JnAvKQkutQiQZYZFGhCFBU?=
 =?us-ascii?Q?DDUAtop55rFlbISBpaO5KXKOuqdiolT3vipAxyKtbKOPPdcqQWZMr7Wdsa/4?=
 =?us-ascii?Q?8bDhBUVgwc8Y3eOtaY0lprTXhcC1HH1TRkuH3uda9LKWcFCUO3S5RWGR0Vgq?=
 =?us-ascii?Q?5IkJQOT3vAD2OG28oWXL4NVlYEvSWoqvpHAdy/jJ1zVsBHW/5uUDCIFkxvXv?=
 =?us-ascii?Q?UfVP3f2G5yHgfkop7GhBRclx5mDxiMXsFUarJerE/BXXBKuEyxwDr4bqCnz4?=
 =?us-ascii?Q?RXsGT8WC5LZYJgbTgQp+QqrFJWXirVabOrE103SGdhbhvg9/Kbe/Z3ZlG7wa?=
 =?us-ascii?Q?LrTeCdjuUHxBGz2ZXSczptSke8xuaJ4ScpBmwhD/sq1n/BELhb0reeNWLtg2?=
 =?us-ascii?Q?SBbksLmsqKPRT35TlGvKhItWenUQr8LWG/0L5FWHsfGv2p/jSPHC617eSM/9?=
 =?us-ascii?Q?QqLNuzi7pmCxuntTym3TF5yutUIvgNvgFy4fC6Z2C97EheI1U23BgBHzciFc?=
 =?us-ascii?Q?7VJNGMlj77Z1BtaIJ9+zOELa5B9/414sir8r9KkujlCnsbc5tPhoCcamYMcj?=
 =?us-ascii?Q?mmwc/cGVlcdYGtZA6sHk5d0Q7EokM0Ma1oycs4HUwS+U7t8hSl7AoEatXIup?=
 =?us-ascii?Q?5Lj0LUtt7w1o2XffjFNf5T4eTYx5FamjxOkb27vyvyGklnI0jcefeWr3IllG?=
 =?us-ascii?Q?7NACECWDiahXVjk7J6UY8CxEKBn4ax9tWQZsg9zpc/2Nkn+md3imdpNVPMvA?=
 =?us-ascii?Q?Y8D0tJF5h4qfk0kjgqpsBUzpp2lFLi2LPDcFYBUmqcjypILzVxsbm5H4Yh9J?=
 =?us-ascii?Q?Lqabuj9XBD318pErxJlBqJ1f84VhNpZpvlD6zaG7IxZ/j8RMyDMEzne34Hwr?=
 =?us-ascii?Q?bSwbd3OP9sExL6n2q4fHKXhcKezh1A4lhUetlrfVsAHyzcDd5p3RmDK05UiV?=
 =?us-ascii?Q?LVLeYo5zTtgdC0av2D1yrRRTH0Qfp0ZhRlx1H9aZ91fUgQzWIRiqwYexqjPR?=
 =?us-ascii?Q?/raA029j1Qh3qUOt1Hc685gJy3gIYYaVKCg10ZtXTgz57SpSGAjHt7M66lWu?=
 =?us-ascii?Q?c/ofr2gi3Do9aPIbNe1L8Ayl5BroJFBvFa+Xkvpm7vTLYcSX8YUCo7a8Az+a?=
 =?us-ascii?Q?4ga/ZpW9jf20S4mkvAZk9s7IvkgaLtn2A29N+he9Yass2V2f8MIiIvjcZ3oT?=
 =?us-ascii?Q?KmFVLI0Eo6Kb7pADxH4HWv3f8cbOTeii/Cj1FeMlcFp1pb61bbSmLPSQ+Tbg?=
 =?us-ascii?Q?CkhQ025Y96jwxmg8j2gZIVOqZJOYzxO2QIrXdlIQzKXigzERw9V57mUk+jYB?=
 =?us-ascii?Q?XCSpSONEoyO++Tc5ccAv4aj74DBTB68BmaLdyctO2cOX6LyuMKRpITY5Jajo?=
 =?us-ascii?Q?lDx2US7YZHAqQJVJJ2v3uNQI5MMUiS2rwJyZYynwSKet0o27E9lsizaLOKaa?=
 =?us-ascii?Q?kxIxG4+V4j9LyCz5ktRn2OaHAH+4IbnUtEUo2mJnes+51FvbrmXEXGslUT9Q?=
 =?us-ascii?Q?FsSOZ1uEPgh7hpbPVUCoMjyRPqxbLdFBsocpX3dO518h0HJW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8910fc-3e8a-450c-3a32-08de864b6232
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 06:39:06.0846 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tTOuPHrILWy/KvDe011VQXPbaFcu/laKHbUC98+JyjwyX8KoMwxFCsmzy633nrth
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7947
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

+       smu->smc_driver_if_version =3D SMU13_DRIVER_IF_VERSION;

wrong ? in smu v11

+       case IP_VERSION(11, 0, 13):
+               smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_Beig=
e_Goby;
+               break;
+       }

Please add a default case to handle invalid values, this is required for ke=
rnel robustness

btw,
if your intention is to replace all check_fw_version callbacks, you might a=
s well remove this entry from pptable_funcs entirely.
long term, these callbacks are redundant, so a cleanup is necessary.


Best Regards,
Kevin

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, March 20, 2026 14:04
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang, Yang(Kevin) <Kevin=
Yang.Wang@amd.com>
Subject: [PATCH 1/3] drm/amd/pm: Unify version check in SMUv11

Use common helper function for firmware version check and logging in
SMUv11

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h  | 14 ----  .../gpu/drm/amd/p=
m/swsmu/smu11/arcturus_ppt.c |  5 +-
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  3 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 21 +++++-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 25 ++++++-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 75 -------------------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  3 +-
 7 files changed, 52 insertions(+), 94 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_v11_0.h
index 7c1701ed3e11..dd94e8a9e218 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
@@ -25,18 +25,6 @@

 #include "amdgpu_smu.h"

-#define SMU11_DRIVER_IF_VERSION_INV 0xFFFFFFFF -#define SMU11_DRIVER_IF_VE=
RSION_ARCT 0x17 -#define SMU11_DRIVER_IF_VERSION_NV10 0x37 -#define SMU11_D=
RIVER_IF_VERSION_NV12 0x38 -#define SMU11_DRIVER_IF_VERSION_NV14 0x38 -#def=
ine SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x40 -#define SMU11_DRIVER_IF_VE=
RSION_Navy_Flounder 0xE -#define SMU11_DRIVER_IF_VERSION_VANGOGH 0x03 -#def=
ine SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xF -#define SMU11_DRIVER_IF_V=
ERSION_Beige_Goby 0xD -#define SMU11_DRIVER_IF_VERSION_Cyan_Skillfish 0x8
-
 /* MP Apertures */
 #define MP0_Public                     0x03800000
 #define MP0_SRAM                       0x03900000
@@ -148,8 +136,6 @@ int smu_v11_0_setup_pptable(struct smu_context *smu);

 int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu);

-int smu_v11_0_check_fw_version(struct smu_context *smu);
-
 int smu_v11_0_set_driver_table_location(struct smu_context *smu);

 int smu_v11_0_set_tool_table_location(struct smu_context *smu); diff --git=
 a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/=
pm/swsmu/smu11/arcturus_ppt.c
index 0c4afd1e1aab..d73c3c191e9c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -65,6 +65,8 @@
 #define SMU_FEATURES_HIGH_MASK       0xFFFFFFFF00000000
 #define SMU_FEATURES_HIGH_SHIFT      32

+#define SMU11_DRIVER_IF_VERSION_ARCT 0x17
+
 static const struct smu_feature_bits arcturus_dpm_features =3D {
        .bits =3D { SMU_FEATURE_BIT_INIT(FEATURE_DPM_PREFETCHER_BIT),
                  SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
@@ -1906,7 +1908,7 @@ static const struct pptable_funcs arcturus_ppt_funcs =
=3D {
        /* pptable related */
        .setup_pptable =3D arcturus_setup_pptable,
        .get_vbios_bootup_values =3D smu_v11_0_get_vbios_bootup_values,
-       .check_fw_version =3D smu_v11_0_check_fw_version,
+       .check_fw_version =3D smu_cmn_check_fw_version,
        .write_pptable =3D smu_cmn_write_pptable,
        .set_driver_table_location =3D smu_v11_0_set_driver_table_location,
        .set_tool_table_location =3D smu_v11_0_set_tool_table_location,
@@ -1959,5 +1961,6 @@ void arcturus_set_ppt_funcs(struct smu_context *smu)
        smu->table_map =3D arcturus_table_map;
        smu->pwr_src_map =3D arcturus_pwr_src_map;
        smu->workload_map =3D arcturus_workload_map;
+       smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_ARCT;
        smu_v11_0_init_msg_ctl(smu, arcturus_message_map);  } diff --git a/=
drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/a=
md/pm/swsmu/smu11/cyan_skillfish_ppt.c
index 87953a4d0a43..1cc26cc79454 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -582,7 +582,7 @@ cyan_skillfish_get_enabled_mask(struct smu_context *smu=
,  static const struct pptable_funcs cyan_skillfish_ppt_funcs =3D {

        .check_fw_status =3D smu_v11_0_check_fw_status,
-       .check_fw_version =3D smu_v11_0_check_fw_version,
+       .check_fw_version =3D smu_cmn_check_fw_version,
        .init_power =3D smu_v11_0_init_power,
        .fini_power =3D smu_v11_0_fini_power,
        .init_smc_tables =3D cyan_skillfish_init_smc_tables, @@ -605,5 +605=
,6 @@ void cyan_skillfish_set_ppt_funcs(struct smu_context *smu)
        smu->ppt_funcs =3D &cyan_skillfish_ppt_funcs;
        smu->table_map =3D cyan_skillfish_table_map;
        smu->is_apu =3D true;
+       smu->smc_driver_if_version =3D MP1_DRIVER_IF_VERSION;
        smu_v11_0_init_msg_ctl(smu, cyan_skillfish_message_map);  } diff --=
git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd=
/pm/swsmu/smu11/navi10_ppt.c
index 737bfdfb814c..f2ce8de58cb9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -73,6 +73,10 @@ static const struct smu_feature_bits navi10_dpm_features=
 =3D {

 #define SMU_11_0_GFX_BUSY_THRESHOLD 15

+#define SMU11_DRIVER_IF_VERSION_NV10  0x37 #define
+SMU11_DRIVER_IF_VERSION_NV12  0x38 #define SMU11_DRIVER_IF_VERSION_NV14
+0x38
+
 static struct cmn2asic_msg_mapping navi10_message_map[SMU_MSG_MAX_COUNT] =
=3D {
        MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,     =
             1),
        MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,   =
             1),
@@ -3310,7 +3314,7 @@ static const struct pptable_funcs navi10_ppt_funcs =
=3D {
        .check_fw_status =3D smu_v11_0_check_fw_status,
        .setup_pptable =3D navi10_setup_pptable,
        .get_vbios_bootup_values =3D smu_v11_0_get_vbios_bootup_values,
-       .check_fw_version =3D smu_v11_0_check_fw_version,
+       .check_fw_version =3D smu_cmn_check_fw_version,
        .write_pptable =3D smu_cmn_write_pptable,
        .set_driver_table_location =3D smu_v11_0_set_driver_table_location,
        .set_tool_table_location =3D smu_v11_0_set_tool_table_location,
@@ -3363,11 +3367,26 @@ static const struct pptable_funcs navi10_ppt_funcs =
=3D {

 void navi10_set_ppt_funcs(struct smu_context *smu)  {
+       struct amdgpu_device *adev =3D smu->adev;
+
        smu->ppt_funcs =3D &navi10_ppt_funcs;
        smu->clock_map =3D navi10_clk_map;
        smu->feature_map =3D navi10_feature_mask_map;
        smu->table_map =3D navi10_table_map;
        smu->pwr_src_map =3D navi10_pwr_src_map;
        smu->workload_map =3D navi10_workload_map;
+
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
+       case IP_VERSION(11, 0, 0):
+               smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_NV10=
;
+               break;
+       case IP_VERSION(11, 0, 9):
+               smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_NV12=
;
+               break;
+       case IP_VERSION(11, 0, 5):
+               smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_NV14=
;
+               break;
+       }
+
        smu_v11_0_init_msg_ctl(smu, navi10_message_map);  } diff --git a/dr=
ivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd=
/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 6268bc5ed3e6..68255cfcb04d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3120,7 +3120,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_=
funcs =3D {
        .check_fw_status =3D smu_v11_0_check_fw_status,
        .setup_pptable =3D sienna_cichlid_setup_pptable,
        .get_vbios_bootup_values =3D smu_v11_0_get_vbios_bootup_values,
-       .check_fw_version =3D smu_v11_0_check_fw_version,
+       .check_fw_version =3D smu_cmn_check_fw_version,
        .write_pptable =3D smu_cmn_write_pptable,
        .set_driver_table_location =3D smu_v11_0_set_driver_table_location,
        .set_tool_table_location =3D smu_v11_0_set_tool_table_location,
@@ -3177,13 +3177,36 @@ static const struct pptable_funcs sienna_cichlid_pp=
t_funcs =3D {
        .mode2_reset =3D sienna_cichlid_mode2_reset,  };

+#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid  0x40
+#define SMU11_DRIVER_IF_VERSION_Navy_Flounder   0xE
+#define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xF
+#define SMU11_DRIVER_IF_VERSION_Beige_Goby      0xD
+
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)  {
+       struct amdgpu_device *adev =3D smu->adev;
+
        smu->ppt_funcs =3D &sienna_cichlid_ppt_funcs;
        smu->clock_map =3D sienna_cichlid_clk_map;
        smu->feature_map =3D sienna_cichlid_feature_mask_map;
        smu->table_map =3D sienna_cichlid_table_map;
        smu->pwr_src_map =3D sienna_cichlid_pwr_src_map;
        smu->workload_map =3D sienna_cichlid_workload_map;
+
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
+       case IP_VERSION(11, 0, 7):
+               smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_Sien=
na_Cichlid;
+               break;
+       case IP_VERSION(11, 0, 11):
+               smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_Navy=
_Flounder;
+               break;
+       case IP_VERSION(11, 0, 12):
+               smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_Dimg=
rey_Cavefish;
+               break;
+       case IP_VERSION(11, 0, 13):
+               smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_Beig=
e_Goby;
+               break;
+       }
+
        smu_v11_0_init_msg_ctl(smu, sienna_cichlid_message_map);  } diff --=
git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/=
pm/swsmu/smu11/smu_v11_0.c
index 1eec1a88e05f..98e7109bbc95 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -192,81 +192,6 @@ int smu_v11_0_check_fw_status(struct smu_context *smu)
        return -EIO;
 }

-int smu_v11_0_check_fw_version(struct smu_context *smu) -{
-       struct amdgpu_device *adev =3D smu->adev;
-       uint32_t if_version =3D 0xff, smu_version =3D 0xff;
-       uint8_t smu_program, smu_major, smu_minor, smu_debug;
-       int ret =3D 0;
-
-       ret =3D smu_cmn_get_smc_version(smu, &if_version, &smu_version);
-       if (ret)
-               return ret;
-
-       smu_program =3D (smu_version >> 24) & 0xff;
-       smu_major =3D (smu_version >> 16) & 0xff;
-       smu_minor =3D (smu_version >> 8) & 0xff;
-       smu_debug =3D (smu_version >> 0) & 0xff;
-       if (smu->is_apu)
-               adev->pm.fw_version =3D smu_version;
-
-       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
-       case IP_VERSION(11, 0, 0):
-               smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_NV10=
;
-               break;
-       case IP_VERSION(11, 0, 9):
-               smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_NV12=
;
-               break;
-       case IP_VERSION(11, 0, 5):
-               smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_NV14=
;
-               break;
-       case IP_VERSION(11, 0, 7):
-               smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_Sien=
na_Cichlid;
-               break;
-       case IP_VERSION(11, 0, 11):
-               smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_Navy=
_Flounder;
-               break;
-       case IP_VERSION(11, 5, 0):
-       case IP_VERSION(11, 5, 2):
-               smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_VANG=
OGH;
-               break;
-       case IP_VERSION(11, 0, 12):
-               smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_Dimg=
rey_Cavefish;
-               break;
-       case IP_VERSION(11, 0, 13):
-               smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_Beig=
e_Goby;
-               break;
-       case IP_VERSION(11, 0, 8):
-               smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_Cyan=
_Skillfish;
-               break;
-       case IP_VERSION(11, 0, 2):
-               smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_ARCT=
;
-               break;
-       default:
-               dev_err(smu->adev->dev, "smu unsupported IP version: 0x%x.\=
n",
-                       amdgpu_ip_version(adev, MP1_HWIP, 0));
-               smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_INV;
-               break;
-       }
-
-       /*
-        * 1. if_version mismatch is not critical as our fw is designed
-        * to be backward compatible.
-        * 2. New fw usually brings some optimizations. But that's visible
-        * only on the paired driver.
-        * Considering above, we just leave user a verbal message instead
-        * of halt driver loading.
-        */
-       if (if_version !=3D smu->smc_driver_if_version) {
-               dev_info(smu->adev->dev, "smu driver if version =3D 0x%08x,=
 smu fw if version =3D 0x%08x, "
-                       "smu fw program =3D %d, version =3D 0x%08x (%d.%d.%=
d)\n",
-                       smu->smc_driver_if_version, if_version,
-                       smu_program, smu_version, smu_major, smu_minor, smu=
_debug);
-       }
-
-       return ret;
-}
-
 static int smu_v11_0_set_pptable_v2_0(struct smu_context *smu, void **tabl=
e, uint32_t *size)  {
        struct amdgpu_device *adev =3D smu->adev; diff --git a/drivers/gpu/=
drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/v=
angogh_ppt.c
index 08179840697e..0349c73eb000 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2512,7 +2512,7 @@ static u32 vangogh_get_gfxoff_entrycount(struct smu_c=
ontext *smu, uint64_t *entr  static const struct pptable_funcs vangogh_ppt_=
funcs =3D {

        .check_fw_status =3D smu_v11_0_check_fw_status,
-       .check_fw_version =3D smu_v11_0_check_fw_version,
+       .check_fw_version =3D smu_cmn_check_fw_version,
        .init_smc_tables =3D vangogh_init_smc_tables,
        .fini_smc_tables =3D smu_v11_0_fini_smc_tables,
        .init_power =3D smu_v11_0_init_power,
@@ -2562,5 +2562,6 @@ void vangogh_set_ppt_funcs(struct smu_context *smu)
        smu->table_map =3D vangogh_table_map;
        smu->workload_map =3D vangogh_workload_map;
        smu->is_apu =3D true;
+       smu->smc_driver_if_version =3D SMU13_DRIVER_IF_VERSION;
        smu_v11_0_init_msg_ctl(smu, vangogh_message_map);  }
--
2.49.0

