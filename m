Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CCDCA0FF2
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 07:28:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B68F10E6C4;
	Thu, 28 Aug 2025 07:28:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PIlt+Xc7";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECCBD10E6C4
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 07:28:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A29VLUhyeNgQtc5nHma90WjxPSlZ5CpMazWcwRLkkGjzcPwXJo0lR7mrmFdYTt52sLJDmKyNF5TwXCDZpFuVdgvjATvVQVBdaVjm8Avnjm4yJ05WFjVy6XpsiNzgc4zEMquDA/nL397asVPzenfrAA7hrPwaAps3boWLwBDIV3h7yEA37h/azy4x6f9M3rpkYirRO4X6r+Dy18S8iiPjxdcbHnaNIEkGvV1hBcK8M/HtWIb1aTkX1Tox9zBTqoJK5HnbU5ind/FEFmwGtNWx8dDWvJJ3LRdtZs36+zvActwKL8Jh594rtFIAnkDyoRd15qmquY574h8NjvEaVgXwbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wx4Uzv5gg3/xFlUaMh0KzjLr5e4NALJPHbCHwMSAF6A=;
 b=tVZuNMTXPyXCWpN7g/18G83K4jVKRAcmDZlg8szl0fNF23nk37vgEO0BhwEW+y+3GXgSvXqS1Mx6RxRx7fyU/tc6fKD6ZtfPYOfnqLIJenW3aglEaIqnLHIYvnxVYfmcbJ6mBAbuPAzF+qfTUQXVyk0Jefc1t6aK/7xutNd7X4dKLD41XtUNx2Zum4kbZxy/sJ0phFa71ZwKe+gkQB1bOURtXxUonOs28VSFSu7Pw91dNbriUgpNQQfwXd/0c8aESLVSRjKZCdZBExpMo6zkiewon4lR2iHSg+gZPYnKkHEEMlw+iYPpJ6XFgWgJIQynpGioCe4N5HW/b5qtHzGeqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wx4Uzv5gg3/xFlUaMh0KzjLr5e4NALJPHbCHwMSAF6A=;
 b=PIlt+Xc7JU1jsdeWref+Wk8Hq7djhubsqrXn+wQRWrUYj1hveaGZmJXLERP45mIbQP3lxU2AIS7Q/IDkkTFdeXB2JvNjoZMpmm7UwxGtUH2r2mCOTtFSjf60Jm5SfeM6rrlgqmNtTnfKQSTi6Q5FYOdK716Tk4G9fFS7XP0KwE0=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 MN0PR12MB5810.namprd12.prod.outlook.com (2603:10b6:208:376::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.15; Thu, 28 Aug 2025 07:28:29 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%5]) with mapi id 15.20.9073.016; Thu, 28 Aug 2025
 07:28:29 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Add caching for SystemMetrics table
Thread-Topic: [PATCH] drm/amd/pm: Add caching for SystemMetrics table
Thread-Index: AQHcF9oWhffmqKHbOUayc6ajyeYH8bR3qtsg
Date: Thu, 28 Aug 2025 07:28:29 +0000
Message-ID: <DS7PR12MB6071637F3DC2D1FE7B7320EF8E3BA@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250828051006.2244176-1-lijo.lazar@amd.com>
In-Reply-To: <20250828051006.2244176-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-28T07:27:59.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|MN0PR12MB5810:EE_
x-ms-office365-filtering-correlation-id: c53d7855-8c3e-4c93-2571-08dde6047c53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?dGHQtFaGjQt6auds/vSLRDNS06p6ySdeD/PbMSrMjO1fa2Hagns4P9l943d9?=
 =?us-ascii?Q?KvJaPW6RJE4yVcjdVRqO/oWcHiqfdmWhTrGseJejX/YswZB/PYNqLp8Z9nDS?=
 =?us-ascii?Q?F38vnGf0gVlQlsPGrQLQcvuRntHL9JshET80YW6gwHLVX8h8Noah4HCKaEJd?=
 =?us-ascii?Q?KBoY8CAKbNWK6Oh3uoMEkeBJEUMtS2m2UDaZMA1LHC8YLpabek/BMbOG/Jjh?=
 =?us-ascii?Q?VwwfqMGenN4A9RlgQ9vj+WE8p3rOaP875T6wagu8qkxiIO/DLftEzzZ7X575?=
 =?us-ascii?Q?Kh+89zWVPu6deX1IQ8+JtJ5r1c2JQCpxAiIuTjjwSpjVflMGGAnoxbR6GNEq?=
 =?us-ascii?Q?0Q8kSsDoXMgaetbGn66RQ680cPNr69PD2/A70OqW8NJl3mJFPP5+od7SelhX?=
 =?us-ascii?Q?dY8vWiwleYffFa5DOAW4Lp8d98Lvt4ZuRqDUZluLcbDDS86wid071M8qE12a?=
 =?us-ascii?Q?zZaarlvH6Aon0+8q1GogIrllzqsQV7JXlDb5dBNM/VZfbc/Ea5F3+Dxi3jSY?=
 =?us-ascii?Q?uM7p8WncYXX0WcYaHvEgq8jZ2NO3xCV+danJAtreJ4g0RFrVp7ogl8IoGqML?=
 =?us-ascii?Q?uteknr9BYklTUGQqIJ2glsZ/Vusqa+okdZezrVcPFqvxEauemoMv4ef7d84m?=
 =?us-ascii?Q?jOcXTyUfFlQkjVVSpP3yP93aE71Xfdwyi2QgMZCoYM0DFHhTeCPn1gim7Mc5?=
 =?us-ascii?Q?gs5K00VBNAYMUrs8LwtdCdDsWqAOkrMvoiHOU9+isjfU4jloB19vr5dxumQs?=
 =?us-ascii?Q?zGJi+oGNgqnp+g10MCz2jTPu7qCrycg/l9fzZdOGyyo8Q8LI9/WCr9iRLuAZ?=
 =?us-ascii?Q?R1gAYgf/qlJg3AGeXc1fvo/fjsf/GCdSGnJsCyUzF8nxcZ8dzJNUtMXbkPCv?=
 =?us-ascii?Q?6pAUx8XuEsTbTG3ZMgTTOGqYxCpQ3e8f4OaMModCSv3nqZlvtEnwlt3YL1S6?=
 =?us-ascii?Q?iumDClMduICgc7cMBkISgqmeQKM2IDikJJ8vMBc9SurM+zFLCkhFy+X21wsh?=
 =?us-ascii?Q?F0GrfKkCEpwBTcobGPV781SaFD3FbE8f7WqhfYP/4RNb4HvgxyV+bWgt+pma?=
 =?us-ascii?Q?QMtS+mNUMKQ84QA2ZxY3XTVXBVQH697Qmd6vAA0iHU7ORWKxWcUyJhsl1nVr?=
 =?us-ascii?Q?gqWws4YXrE4FM7YsoxsDlKlFAxfERhgB0o33nkf+WODfNowBef0RGQrdY+jJ?=
 =?us-ascii?Q?qJlNJv0KE48RLY+mKER8axg62m/HjvsNmrNLVlqvo4V/tdBFuSEXTZeeldka?=
 =?us-ascii?Q?ixZF834vqMZLDcSc3u1xfNZP78GujL/aQ40xK68gx9y8NDADj5gjkAATaif7?=
 =?us-ascii?Q?Sc/7o/h/x5UTOrFG+VJmsHCZlJkxjU9sQSguPNimt/ESSivbzA0d1RN2zeAA?=
 =?us-ascii?Q?k9v9uKhUGM7MXZtrzudXhhf+DniVYUWi7ERibPwqS32TLTy5tjTWapnwzSQe?=
 =?us-ascii?Q?p2ry39/8JXUJl3r1pp2y9CCVBSTzSWZxMha5Vh64YzgLFqalCxuwgg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AGtFnF5ZYCye8UPLG7o5fpzuoyqhIwb7BpgNJxvwIOHFYjxCilQFIaAcidTj?=
 =?us-ascii?Q?WKPodjJnnGZKexT8ivAZnH/hcbj+s3EW3spPiuGBM0nBfY8QTArrbyeuNB8U?=
 =?us-ascii?Q?RCNzJfeyajDJBq1JOnB74d2ueRUr2wXZRChnmT0MIrqxHKDUhHLZspZ2BMfr?=
 =?us-ascii?Q?wiBE0CmNr3AP8R5KksWaxSIBcbEkiK7q8WNxDSxXSIfGX6KSEEmGqtyh7MQ/?=
 =?us-ascii?Q?Dlz7fmPW0N+bkKNCkL0zDKhr7mPsqcM3r50FUZM2YwW7sngIFBSVZ8hER1MV?=
 =?us-ascii?Q?7d97ue4xJd8az8rEKOqhcl/h2EsZ7JyzRKhvc3aVBBZuj9p18jXXhJ8GLo0+?=
 =?us-ascii?Q?GQawtZmcrspFq8CW+I7fng+3UE8eOcBtTqEBeL6lsjyu/H75RbEqOVOSQv8y?=
 =?us-ascii?Q?U5eBxnhQMlNcBiyrvBqmL1uGMJUVVnRv5JEiWu+YtGnLDMP5JRro3XIeWU2H?=
 =?us-ascii?Q?HnAS4j01vUPnqLMYm6GtlB+/8tMbpawdVdbgM9uaaqYxx0w1434utX4VdB/E?=
 =?us-ascii?Q?nVSwDSQxmHX9oac92gB+A4GbBA177CGNa5jtOMipziEkj4c1FK0vfBZx8/Jy?=
 =?us-ascii?Q?Qs/qsZ7ouk1Yf7xSACVkx2g2MUGr4L/dHSVus+k1SvblWTu3nU6OD9117GGW?=
 =?us-ascii?Q?l0BEnofGqY0AhHgjszbbeUVz26Caw2Vjm+CXrUZne+MslH36rXuHPKJGKFjh?=
 =?us-ascii?Q?kJwcOZzoHWwiRv9XJbd3pWjPScLxAVpwv9+UMxP4wxFFTK0+KFR2+ed+PKvg?=
 =?us-ascii?Q?7YUObdw5mO5EJDnlgP7kJzxVESLLhBJ+Wdr7J97cj1Hsj1oEfKm8gNOvN6HN?=
 =?us-ascii?Q?EZfHI8CXL7RrUNVgjj6s6A8KQhcNM+R8gijAdLqze6LOHnjfh4vSyRCrnnb6?=
 =?us-ascii?Q?9K1ZXfcQ+SiuhakAX2wuRn9KjoBs0FHP+AxmntsUD4XXJiCHs44dxsIPyP4W?=
 =?us-ascii?Q?zf7c36/4vP8BJr+ZPes7zUaW0Jh34ubIco25q4/oS7m/L29wIeNLBOg6fht4?=
 =?us-ascii?Q?3fmelFEtY99ULukUkvBGibmCTe8HYN3G9gildwEWUq72+5w/1u2FJIx37Nna?=
 =?us-ascii?Q?9M2O0QOuFX7L4IY3z2usE3Blg86QuQuorsKaoEe9pnT9ZSMYFG2icbAMBvtq?=
 =?us-ascii?Q?p4wEekiR/HcpX2omlP3DPmo8ALBN+2EvbXjII7EWMPOsXQXLWaLPb+iRTruZ?=
 =?us-ascii?Q?lruTOfOQj1EooVh1GZ8wUZnMHIOZUv7qWxnqBO2yxgyglVv2hyx4ER4lzRMy?=
 =?us-ascii?Q?dj0lg+nrr9k8OC72QAy0gmav5c27q64Kql7GI8isOkN+xyBKrhQuHvHjpBrC?=
 =?us-ascii?Q?c9BcvtTaoFxRx1al8ujx6wK4uk31G8LO9CRCbsfwt9emDBbUIRh4Jrl0eBsr?=
 =?us-ascii?Q?xaUJwB4kBq8hMBD9LbobywWPvjXodJ7P2rH6A/DxyQHlOY5T1g0xglTrTe4G?=
 =?us-ascii?Q?EKjK4rYZ1kH3773/GUGLIiJHie5U97O97VmvDvq/N+4sw7ms/qbYZo2AoTfa?=
 =?us-ascii?Q?xcniZVjYnl9XFbo2YFJ+/lZozIgi21loRKU/j3bM9vEWtdTDN3HXAP/2m9al?=
 =?us-ascii?Q?JcADYLT+OxTOZlKrwnM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c53d7855-8c3e-4c93-2571-08dde6047c53
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 07:28:29.6116 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: efpCsXP+zoPOrIRks8RDOhYmDUm5iZS0/NUSPOrBOj3ZtFsuvEkYh/yO3oKh/QtI3zKmogyJCGE6gLMvZi1x4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5810
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Thursday, August 28, 2025 10:40 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Add caching for SystemMetrics table

Implement caching separately for SystemMetrics table from PMFW. The same ta=
ble could be used for multiple interfaces. Hence, cache it internally to av=
oid multiple queries to the firmware. For SystemMetrics table, 5ms cache in=
terval is sufficient.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +  .../drm/amd/pm/swsmu=
/smu13/smu_v13_0_12_ppt.c | 43 +++++++++++++------  .../drm/amd/pm/swsmu/sm=
u13/smu_v13_0_6_ppt.c  |  4 ++  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.=
h  |  1 +
 4 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index 5dd49eca598d..5976eda80035 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -333,6 +333,7 @@ enum smu_table_id {
        SMU_TABLE_WIFIBAND,
        SMU_TABLE_GPUBOARD_TEMP_METRICS,
        SMU_TABLE_BASEBOARD_TEMP_METRICS,
+       SMU_TABLE_PMFW_SYSTEM_METRICS,
        SMU_TABLE_COUNT,
 };

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/driver=
s/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 32fd0be05cff..0bec12b348ce 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -149,6 +149,12 @@ int smu_v13_0_12_tables_init(struct smu_context *smu)
        struct smu_table_cache *cache;
        int ret;

+       ret =3D smu_table_cache_init(smu, SMU_TABLE_PMFW_SYSTEM_METRICS,
+                                  smu_v13_0_12_get_system_metrics_size(), =
5);
+
+       if (ret)
+               return ret;
+
        ret =3D smu_table_cache_init(smu, SMU_TABLE_BASEBOARD_TEMP_METRICS,
                                   sizeof(*baseboard_temp_metrics), 50);
        if (ret)
@@ -162,6 +168,7 @@ int smu_v13_0_12_tables_init(struct smu_context *smu)
        ret =3D smu_table_cache_init(smu, SMU_TABLE_GPUBOARD_TEMP_METRICS,
                                   sizeof(*gpuboard_temp_metrics), 50);
        if (ret) {
+               smu_table_cache_fini(smu, SMU_TABLE_PMFW_SYSTEM_METRICS);
                smu_table_cache_fini(smu, SMU_TABLE_BASEBOARD_TEMP_METRICS)=
;
                return ret;
        }
@@ -176,6 +183,7 @@ void smu_v13_0_12_tables_fini(struct smu_context *smu) =
 {
        smu_table_cache_fini(smu, SMU_TABLE_BASEBOARD_TEMP_METRICS);
        smu_table_cache_fini(smu, SMU_TABLE_GPUBOARD_TEMP_METRICS);
+       smu_table_cache_fini(smu, SMU_TABLE_PMFW_SYSTEM_METRICS);
 }

 static int smu_v13_0_12_get_enabled_mask(struct smu_context *smu, @@ -222,=
8 +230,12 @@ static int smu_v13_0_12_fru_get_product_info(struct smu_contex=
t *smu,

 int smu_v13_0_12_get_max_metrics_size(void)
 {
-       return max3(sizeof(StaticMetricsTable_t), sizeof(MetricsTable_t),
-                  sizeof(SystemMetricsTable_t));
+       return max(sizeof(StaticMetricsTable_t), sizeof(MetricsTable_t)); }
+
+size_t smu_v13_0_12_get_system_metrics_size(void)
+{
+       return sizeof(SystemMetricsTable_t);
 }

 static void smu_v13_0_12_init_xgmi_data(struct smu_context *smu, @@ -414,1=
4 +426,18 @@ int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
        return 0;
 }

-static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu,
-                                                void *metrics_table)
+static int smu_v13_0_12_get_system_metrics_table(struct smu_context
+*smu)
 {
        struct smu_table_context *smu_table =3D &smu->smu_table;
-       uint32_t table_size =3D smu_table->tables[SMU_TABLE_SMU_METRICS].si=
ze;
        struct smu_table *table =3D &smu_table->driver_table;
+       struct smu_table *tables =3D smu_table->tables;
+       struct smu_table *sys_table;
        int ret;

+       sys_table =3D &tables[SMU_TABLE_PMFW_SYSTEM_METRICS];
+       if (smu_table_cache_is_valid(sys_table))
+               return 0;
+
        ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GetSystemMetricsTable, NU=
LL);
        if (ret) {
                dev_info(smu->adev->dev,
@@ -430,10 +446,9 @@ static int smu_v13_0_12_get_system_metrics_table(struc=
t smu_context *smu,
        }

        amdgpu_asic_invalidate_hdp(smu->adev, NULL);
-       memcpy(smu_table->metrics_table, table->cpu_addr, table_size);
-
-       if (metrics_table)
-               memcpy(metrics_table, smu_table->metrics_table, sizeof(Syst=
emMetricsTable_t));
+       smu_table_cache_update_time(sys_table, jiffies);
+       memcpy(sys_table->cache.buffer, table->cpu_addr,
+              smu_v13_0_12_get_system_metrics_size());

        return 0;
 }
@@ -571,10 +586,10 @@ static ssize_t smu_v13_0_12_get_temp_metrics(struct s=
mu_context *smu,
        struct amdgpu_baseboard_temp_metrics_v1_0 *baseboard_temp_metrics;
        struct amdgpu_gpuboard_temp_metrics_v1_0 *gpuboard_temp_metrics;
        struct smu_table_context *smu_table =3D &smu->smu_table;
-       SystemMetricsTable_t *metrics =3D
-               (SystemMetricsTable_t *)smu_table->metrics_table;
-
+       struct smu_table *tables =3D smu_table->tables;
+       SystemMetricsTable_t *metrics;
        struct smu_table *data_table;
+       struct smu_table *sys_table;
        int ret, sensor_type;
        u32 idx, sensors;
        ssize_t size;
@@ -596,10 +611,12 @@ static ssize_t smu_v13_0_12_get_temp_metrics(struct s=
mu_context *smu,
                size =3D sizeof(*baseboard_temp_metrics);
        }

-       ret =3D smu_v13_0_12_get_system_metrics_table(smu, NULL);
+       ret =3D smu_v13_0_12_get_system_metrics_table(smu);
        if (ret)
                return ret;

+       sys_table =3D &tables[SMU_TABLE_PMFW_SYSTEM_METRICS];
+       metrics =3D (SystemMetricsTable_t *)sys_table->cache.buffer;
        smu_table_cache_update_time(data_table, jiffies);

        if (type =3D=3D SMU_TEMP_METRIC_GPUBOARD) { diff --git a/drivers/gp=
u/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/s=
mu13/smu_v13_0_6_ppt.c
index e37b7b5358ea..ebee659f8a1c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -559,6 +559,10 @@ static int smu_v13_0_6_tables_init(struct smu_context =
*smu)
                       PAGE_SIZE,
                       AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT);

+       SMU_TABLE_INIT(tables, SMU_TABLE_PMFW_SYSTEM_METRICS,
+                      smu_v13_0_12_get_system_metrics_size(), PAGE_SIZE,
+                      AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT);
+
        metrics_table =3D kzalloc(METRICS_TABLE_SIZE, GFP_KERNEL);
        if (!metrics_table)
                return -ENOMEM;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index bcb8246c0804..aae9a546a67e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -82,6 +82,7 @@ int smu_v13_0_6_get_metrics_table(struct smu_context *smu=
, void *metrics_table,

 bool smu_v13_0_12_is_dpm_running(struct smu_context *smu);  int smu_v13_0_=
12_get_max_metrics_size(void);
+size_t smu_v13_0_12_get_system_metrics_size(void);
 int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu);  int smu_v=
13_0_12_get_smu_metrics_data(struct smu_context *smu,
                                      MetricsMember_t member, uint32_t *val=
ue);
--
2.49.0

