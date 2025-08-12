Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1E1C87FCB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 12:34:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A800710E004;
	Tue, 12 Aug 2025 12:34:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CejvAtP+";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B573210E004
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 12:34:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veEvGPc04sDR3M+9zJ68r1Wxqq70ntoRGZn4MwJlagFZWORF+FfwHN91QcAwn0LYs65XGNSviAwPznN+L1u0I7ptUM7qZ1xlWLiRDkGniJVcPYI9k22DU9JDQraSXfnIqoxaIbxmCR2ZhHxYL8uDQ8TEvjDCCjRGtSzHJzzONr03h2vSNegM+IGBEYvAVopVIRgA5svg1TdY3FE5OFfLt2QUctWRmrrI7Qbrd3IOWZmX3mFxRnvD/4fiSzBMZ6wjjMaFObQhAFRe0o5ZI0PkHT5B0W4LhtU9hfCmNyvibgtEXbMVDkXgShgk5l8BZ8chFBQnC7eIwRhCFPH8KXNyiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBIukXi2rY+qNCzIJ5cVxWmX9o04qmK3yZVuZLoF1qQ=;
 b=HLTy46mQKEsi/MD2eFwSb0YR2dRm7zdy/PBoz6QCJ2KMioDgKQ5gUECY49nv6a6acFYIhxi22kE7aJk4GAWeH1zHGPrplYg+/vtl0DLxWLiz+kwYphd1wDOp11cCJCEAyC0W6CeCc3k6f87y39Uu7Kv56xS5RRkKIUehvLnBYAf2gyGx9b979oOv2w+XLWZEDHZUQxrPwvvHyvcN0Ml2hrJ+fIXP0xfVGwrZrY+XX7r0SYVSRJ9S34XfbEOEjB5oiYlv04oMf5inFoc9u6g1ryU7HwXQ52jK46R6DwOllOQgOi7i2rGfsCkrHlLhbZPyygEPF7t4DqBRqccE4+UIPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBIukXi2rY+qNCzIJ5cVxWmX9o04qmK3yZVuZLoF1qQ=;
 b=CejvAtP+fdGrPt63qJhWNsOUs7JbgwutYn7E2kIqozldbtljiuleDAgyNp4YMbIwVNnCPPL/zvw1uFZLc0zwzOctUt2bxLY8/5kj0Ro0nPuXGuLnBGMoU1cbOQ3jYOe4KvwoYNZlSXodvWUrsDP7R4dADh0AT/pRxKWeTU8Yc8Y=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 12:34:07 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.9009.021; Tue, 12 Aug 2025
 12:34:07 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Free SMUv13.0.6 resources on failure
Thread-Topic: [PATCH] drm/amd/pm: Free SMUv13.0.6 resources on failure
Thread-Index: AQHcC18MfP80cJ3SgUSzarkde1sg6bRe8/LQ
Date: Tue, 12 Aug 2025 12:34:07 +0000
Message-ID: <BN9PR12MB5257C718F1B86921FA3B337EFC2BA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250812075915.1893393-1-lijo.lazar@amd.com>
In-Reply-To: <20250812075915.1893393-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-12T12:33:45.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CY8PR12MB8193:EE_
x-ms-office365-filtering-correlation-id: 90b0d96d-66af-400c-4ff5-08ddd99c8805
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?O8pRhMzsT5B6wwxDBnEW6QxXWxNzLhGdDhszkHN0Eok5lVK1MSb+eYEEo4sU?=
 =?us-ascii?Q?MqT3nunaOTxEV9ZiQ44GOnLVLmeGAomgNSy1b/o8+lzdtBbA5SfFATgUi2qC?=
 =?us-ascii?Q?NJyjyq4KHExa4pCeswosBfrRDdfmIfXagVLDarcOLBAS53V1aeOCSruu2hjQ?=
 =?us-ascii?Q?akb+eZiOSV8APSJd5BRfrD3XNJpgoCtiyR6nu/I4mDPDYtXE3Q2L78pH1G44?=
 =?us-ascii?Q?di8eMt759poiWiIIxWvrUiG5Nvy1Q4iiE/jFVaR5SPHmzdWyUdRJ66APBHxM?=
 =?us-ascii?Q?MrIyhy2rdDh04A1CMDIULa51zKgoSRee34+/HTVahdK7u5RK8q5GVlyH52Ev?=
 =?us-ascii?Q?EGWsfYLCq+a9Cfs3jVvBvJxx7OaeuWbsEQAHjWa69HT6aWLGnCApTlX0ooAR?=
 =?us-ascii?Q?YQxFnGdn6k65WDjiO3+3oGMWqbsWsaD9O/He4MCLgpyB+3CF7m9OpxJPVe0D?=
 =?us-ascii?Q?IyGzspdcLVjQdq9QqAZGm8O3xDsX1Ydl00xP3pRXHAlL8cR5jgT3UljoHbLF?=
 =?us-ascii?Q?RnQb0q+4A0sLqIbE3w55+XCX4SaoCnPtelOaDdq1/M0g0odDbIRawZKXyIZy?=
 =?us-ascii?Q?TJgkHU05UMmsLvFMjS05mDggrA4d9vkhWd2ZyefAf7PYm3JwBa3puv78g2vm?=
 =?us-ascii?Q?RtgiSUaY8shppRUlxRM2JR3zSPh9dEAv4Rs+y0cFiWZbznRqkGRz8h9l7zhl?=
 =?us-ascii?Q?U6UoI2iJ13MuNZIFvbyj7g6dYScm3oZhyUSXOWcV+sOl2JDHhvzMuAFdPMXv?=
 =?us-ascii?Q?sUD4RtAERKnCRWPNSzaL0Rs4jl4f0IXLconBki6Y/5LtL6MwGcs6hqvv6p8n?=
 =?us-ascii?Q?mRQ8eOsSZIYvlIuloGnfvdPFlK9tysMHBIuTu0gVV3fa3xgIuMJ1y4/NCiyE?=
 =?us-ascii?Q?NdNqWoZ3BXGYRcCRN4aTqCQGfw7+uhSfyrhhXodIVrZRwdjfFf1ARDWeOmPb?=
 =?us-ascii?Q?mkZneDwk9O2YcQMO8hl6v3S3o6PutO7hsXvWDEKxDgJXfn9jsbDxmhvYxAIG?=
 =?us-ascii?Q?rP0xHT59dSBR7aZX8cZdvZBS3m3v7dmCoDiawTPATMLEaamIGJuq/aKWxzYa?=
 =?us-ascii?Q?YIcSpuvMM2Rf8kdxIijmroa2G8c5f+b5jiQiQkfojXdzaW/V8b3P4BgejemI?=
 =?us-ascii?Q?XtvTfohJ5tXQwq+ooJRvO2tS3oQwvDBIhhCSNhzEb/MmIbP/zyyUwE/CBwPu?=
 =?us-ascii?Q?exI0/rDoXflQfgY2TIPkNvQDwjrMG73XO/a7wDo4sF1a6m1k6xdHhbW1xZE2?=
 =?us-ascii?Q?eoN3CEoPXtHQkHTUyeG1qiVn+MD1zMo+zo8nj1qVzL/2p8Fj65nLkusOYU3B?=
 =?us-ascii?Q?iXkf2uMy5vH+QYf4hLV+LD/fBgX7KO81gTS/vg+HyWKjZeRmb/svDQS6s2Nc?=
 =?us-ascii?Q?YlX8BM5juynsheibFOyXUY0OApGeIsrBw5kXq3PN3xi51dMz43h4Hr/qHJjC?=
 =?us-ascii?Q?jfye0ZWballFH9QKT+4kTin9+6/8lDzi0pYlTH+R1DkJn1fWzz0lVNfHWOky?=
 =?us-ascii?Q?ZqqWRuV0n+kyNX4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wQctARXQ7D4sASPO3pLKDW3PYt2aQTGhVqSkTCwpHb10JtdH5HaYx5FgbOnQ?=
 =?us-ascii?Q?hhzLizxtmzCYbPhE6fXFVmYNl3pq4zuvxkYu4l1xGrC5SpjSkybCzlfd//AB?=
 =?us-ascii?Q?shXhMK0WB1EQH81Ja48tCQ+C4SgW3eITAb2Kej2Fty0A6r5VG5udwDluZ3ET?=
 =?us-ascii?Q?d+TKyNipq9/PGBDaqWn+3aeirT9duv+SiHWm1QG1mDhGh1ww5upiERye6m4A?=
 =?us-ascii?Q?mlefUD8R+wjJ5CqgRcFXgHtsVgoAmebY009aZxhKcZ/pBQsuuScvyik+vLbx?=
 =?us-ascii?Q?lc1C0I+cNjMGIl0ydtUIJn+bynLTl2u9FLYiYxmH5+J3opd30I+T6+3+KfUg?=
 =?us-ascii?Q?yolo9rtKh02kXktk7CNcQwKhtNSIIBEm/RWyI05syauuPC83JgHw56z/hjlo?=
 =?us-ascii?Q?/eRc2RbfYVQeLEKudQp6rVVpmSvSKF6QB9yM61LUlgyynBsYqw6+tM0DcEYl?=
 =?us-ascii?Q?PtMQttYFAXKGQVdgtFMRJL4cRhVkcXGFBt7n1eO3dJxHQ5luqexJs37YulXh?=
 =?us-ascii?Q?i+PKVslEYoe06QoJnjMUVVBKJ/I8OiAcBW47yx9dRLYwTONw4LBgA++cDSOw?=
 =?us-ascii?Q?XfVxicjovKS4XFAch8iBVQM8uQqxyr5jiudYlGRpV58a17rlq6AZlzoM7yeQ?=
 =?us-ascii?Q?bV5ZTE5pwvD6MgHUGWY4REAGVv6Di3GLM/WtOwS4qZRvf3F4qw4BFFVOHljo?=
 =?us-ascii?Q?3TkO+6CSHRVhpKsrEkEjh6YiDZeok/HIPVxrKspAWZqvA2POYxYb1WWcL1tM?=
 =?us-ascii?Q?eZKAjGWbYaIXWt2u5GFk8diOilTqmfdCJy9pTo+UzmjdOka0kL6FEvwydElp?=
 =?us-ascii?Q?sbIICVyou069ezL2wSfBBHZP5D4CLe4Dl1aeT5PNDVYb+sTWXiexuNTBv3Ti?=
 =?us-ascii?Q?hA8U6hNrAWO52G+6bZoljkohCY0NIJw2uNjbM9Cv4IA7nf3kDVcuChaI8tyQ?=
 =?us-ascii?Q?W78UePVBto8MBn2yg5EWs8x345sIxGez7AyuYFE6xenbBtkYI89iCMpUEo2U?=
 =?us-ascii?Q?GyUTyBkIM8zYh3uo4EERht4vO6y7wyeW9dEa23vABLymMK4SwUCdZQ7OwtHd?=
 =?us-ascii?Q?7GPd1YH5DMzwvzDB56vt+2TavQuHUONFK7Uz6LadIzq+xFQCvKzj89pMkItw?=
 =?us-ascii?Q?i+VG5so/4UKlvpqh9K+kyufWCqTMIzzd6QGO43YsxzTPHZ1YdV4F2xkMfpXu?=
 =?us-ascii?Q?qG0u01Z4qqlTIb/KL1RJH3CSZ1EgipHsrhfr5zDZ2YOR2jdK1tZRlfbdARzJ?=
 =?us-ascii?Q?v+jdi9YfyOueMZ1NN7rVE8izpCyWpuoxAm9EtDM1sf9WQ/Q9zgyIDWgdrZCo?=
 =?us-ascii?Q?F7QvZnqcqyUmDvdvpfTOKqyyStC/mCidnOEHtDh8JqMcuCAnk1MCQWSmrJ+a?=
 =?us-ascii?Q?jmp6aR8rVkGjzPRE9GbGYCPmMsvHwJ3fG9vhZ5YPP/89eNSqA7SJdq4eGft3?=
 =?us-ascii?Q?d71eqYb9bTySjHXnvw8OaKt32fPurSJuC1NmMAXS/o/AflgITpUIw4CTxt46?=
 =?us-ascii?Q?CZhsTESh/iN4AARmq8rKpIPsHOcCszL1vBZeflsGtGEpsfwW4qLBCYvAMcMj?=
 =?us-ascii?Q?T2y0svbRd8sDzz8IkbA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b0d96d-66af-400c-4ff5-08ddd99c8805
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2025 12:34:07.6298 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zH9XqFAEgN3bEOhPF81DoRkPv78wjDmaQYtnUanmpgRfIQWmGYnagn16CXlgNZoELku2eRx86N/8buEvDjAwrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8193
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, August 12, 2025 15:59
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Free SMUv13.0.6 resources on failure

Free the resources allocated if smu_v13_0_12_tables_init fails.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Fixes: 22ef8851997f ("drm/amd/pm: Add caching to SMUv13.0.12 temp metric")
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c    |  4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 12 ++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/driver=
s/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index ea2682f9d579..32fd0be05cff 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -161,8 +161,10 @@ int smu_v13_0_12_tables_init(struct smu_context *smu)
        /* Initialize GPU board temperature metrics */
        ret =3D smu_table_cache_init(smu, SMU_TABLE_GPUBOARD_TEMP_METRICS,
                                   sizeof(*gpuboard_temp_metrics), 50);
-       if (ret)
+       if (ret) {
+               smu_table_cache_fini(smu, SMU_TABLE_BASEBOARD_TEMP_METRICS)=
;
                return ret;
+       }
        cache =3D &(tables[SMU_TABLE_GPUBOARD_TEMP_METRICS].cache);
        gpuboard_temp_metrics =3D (struct amdgpu_gpuboard_temp_metrics_v1_0=
 *)cache->buffer;
        smu_cmn_init_gpuboard_temp_metrics(gpuboard_temp_metrics, 1, 0); di=
ff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 3b4bd7a34d04..bb242ac60758 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -534,6 +534,7 @@ static int smu_v13_0_6_tables_init(struct smu_context *=
smu)
        struct smu_table *tables =3D smu_table->tables;
        struct amdgpu_device *adev =3D smu->adev;
        int gpu_metrcs_size =3D METRICS_TABLE_SIZE;
+       int ret;

        if (!(adev->flags & AMD_IS_APU))
                SMU_TABLE_INIT(tables, SMU_TABLE_PMSTATUSLOG, SMU13_TOOL_SI=
ZE, @@ -570,8 +571,15 @@ static int smu_v13_0_6_tables_init(struct smu_cont=
ext *smu)
                return -ENOMEM;
        }

-       if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13,=
 0, 12))
-               return smu_v13_0_12_tables_init(smu);
+       if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D
+           IP_VERSION(13, 0, 12)) {
+               ret =3D smu_v13_0_12_tables_init(smu);
+               if (ret) {
+                       kfree(smu_table->metrics_table);
+                       kfree(smu_table->gpu_metrics_table);
+                       return ret;
+               }
+       }

        return 0;
 }
--
2.49.0

