Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7072C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 03:26:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5671010E3E7;
	Tue, 31 Oct 2023 03:26:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1B6710E3E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 03:26:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/EEDIvhLupzY6lkF2mZRxrA4ku2NIgQK7rJqEkquZ46gkHe4uGfZLDYNWtiRod5aBUp228hjeUfYT+lt0r6yYKO0j2HLVmLw0wyPiLIRpZpbw8ofdnR/QkAbmNBEOR9+5KhIDU0ebjM6iN9ovDRFI+cd90f3Pxj1pMd2s9pkmONhwLFnn5/RegyhSn6YE+oOQeDE59BjJQJFe2xJESPWBSUus+9RqqSZYyZfr6b82KbmSYTS9g81sAMjdawILtWw92oaFRR2tPDZgIPHuu8FUuPdxCWWKaq4y6YgZqWzBSnd1dYf9vJDD53xldrQoN3aKGhnGpSGgqrUKQuCLXmag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGMbe3fFgTVVZ2swgNu7QqEde1RXRpmBbxOx21JRQpU=;
 b=gnuZUpS/BCaEPOsUGw16coigZzKZgg/NZMbz1Y3ladOsGdT5f39edKj4HhXUu0vkcEe6IG0hgbOMUOVzoOOrGW5nzLwQr9pgjZma1AlfGqw3CenFg06KUKE5QYrx+UvCY4pwq16R9rkwY+BdEkgzJEK6Qv/5t1Z0Wm+DPeR4jcKQquGTsv2wP7zkheAyFUiiDFGDjdUOsdvxne99xAJxZ/M/dN9UUGkrVR/J3jM2ip5LQqEAiwEeVYJzPw3Vdd3Pxf4emyUfZMpMaAYVBH7T8t+hEJRd1Ould0BfuTNTdSbb8prL4b94Yg1E7pb4JSQBzL5DKBqM+GPzAlUsUuqaOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGMbe3fFgTVVZ2swgNu7QqEde1RXRpmBbxOx21JRQpU=;
 b=AV7tKTjQNuck1/gpZ38l1UyjQAUzkMuUKB9rdhckbQtTauoniy8/moM78GzE6d2jfGNjttepcaVtny+OtpbGNOqb9r7ifaSi1XZV4oEStpFBBKDssAsOtoC6Iqy3+SkwKh6v5JoU6JgOQRLfR1h8+sw1LxF12+Gteko/UOgXGGM=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by PH7PR12MB7137.namprd12.prod.outlook.com (2603:10b6:510:1ed::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 03:26:23 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e%4]) with mapi id 15.20.6933.025; Tue, 31 Oct 2023
 03:26:22 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Ma, Li" <Li.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/swsmu: remove fw version check in sw_init.
Thread-Topic: [PATCH] drm/amd/swsmu: remove fw version check in sw_init.
Thread-Index: AQHaC6mpRqwH/RorYE2RmXTXBE4ssLBjPJ+g
Date: Tue, 31 Oct 2023 03:26:22 +0000
Message-ID: <PH7PR12MB5997DA82F04B2364B4DD859282A0A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231031032305.2055080-1-li.ma@amd.com>
In-Reply-To: <20231031032305.2055080-1-li.ma@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a9c094a3-eb0f-4869-a33e-f111193ee06f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-31T03:26:02Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|PH7PR12MB7137:EE_
x-ms-office365-filtering-correlation-id: c89c9220-f422-4910-0164-08dbd9c127ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /TaZoc/f7tSKKmaITEgO4t6RYoqHW+kjF2yv1Do0CvM/XHcJqwOSdu/VGqwDbMAo3iack25773y7HIr4Xod1PQYAweHZctFft1BbKzE2kHKM5ToZ/TQ8t0KE2wZQoaKRfW0ZrjQj9Pw6cNfEjo7cafs2D2vhspjT/UiO4Ir63dxjztlYfP14mfT0rLF+aLicYxjKMkHuxMgMSbYAvlZR90Dha8jOgBKJdcEyvHSP3MG6dos+OW8V0NP/MwuUxqEJYPLRKho8gOAPSJ8unMzl4yxUnxoMY9wf4qf4xTRdR70rLAQBrh6CmalAyjNcMzf4+9wzvYhRGiE9klkMolwdjhcOm9m+mJ9wwxHmZak56U8Q4jw+6zGBfBzkOZWh7NOKTGJXp6SPuAMxb18mOwFeIMQSYHQ9i4b/tuMbWEzY5JnDynxHoKXio15V4p8jdeoNtz0fqLc1HsDjIQnl2ocbkFqw68FKakrasrb/fFUx8KPnoMlIe9jppn3YT9Krj28zPkqY91YmFhx7y5ZjN0E4MXssCX6ccN9U46aZ1dZE5mDEg02uBQc+eqBuGSMDxhNWXMDfUxpWrgcXQMLeD1vMEXTNIlpr3CirhQiCYbuAmsBt5armq1rwQLxmUvt6Kray
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(136003)(346002)(366004)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(26005)(9686003)(122000001)(38070700009)(2906002)(86362001)(83380400001)(38100700002)(7696005)(55016003)(53546011)(478600001)(6506007)(71200400001)(66946007)(64756008)(66556008)(54906003)(8936002)(66446008)(66476007)(76116006)(316002)(4326008)(8676002)(52536014)(110136005)(41300700001)(5660300002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pnDF5PkUNfJTZm+1c0bXgeHjHw1a/hKmLwmsw5sprwJWVDI1Ma0TQQm75sUR?=
 =?us-ascii?Q?wy8q4C5kwY2mZWYtZb5C5Op1SHH7mdbGZGeDA0KlFbktlLwq2T7JoKqnZ7Ke?=
 =?us-ascii?Q?rZZL8AkxH8OBXJARViU3H2Pi9sxgXEz8gHvTKiyfP+CTy/dygcV1UzTpj6Ez?=
 =?us-ascii?Q?VH8Y46FqsSkjtbSouAT2emyPbLKQRvWJW6aNYokXWrlhi3pESe+oISviOQj+?=
 =?us-ascii?Q?GxYBTgijMLeE1m+GnholDbvzDiQpOXxt2YluLXLt6IInmc1ISmUjkPH5csPC?=
 =?us-ascii?Q?lKrDIowSqhJ4TlT8mJ80QfmW67skUG8U59+wQLWmDGZYs7fqcCDMBwd4AnKd?=
 =?us-ascii?Q?SSwVxvd5Kdgvar9/a5jGQA9ZGQBetpNJQS2NJ3Dma2zdTKmhechYo6lEDRjX?=
 =?us-ascii?Q?fL0DTxVAj9HuqGJO9tde9K5XDNiADBHiWj9PjYWHrzIdJXNdvnLubU1G9ZUq?=
 =?us-ascii?Q?uewqct9RqtmYnGhhkTJ8eCUWuF1iqTCcLeoZFEjlCKkOaJFxlyBcyyrLNYbj?=
 =?us-ascii?Q?xsOW6OWGtbkJ0iAnRf/LAQ0F0XOhQsIdbrWG1ZjGJTVHytgU6hgCzZZhTETu?=
 =?us-ascii?Q?CVXigPIrvX4tvAfIGuw5MQ4ZJ4qE9/fFcNsXazq+iBUdDkA9r48fB1ZArHbv?=
 =?us-ascii?Q?am1Gea0UCusEeRlQYQRRE+QwKPEO/bzarhvngSY7lP/DVV3rTUsRbP7T9/N/?=
 =?us-ascii?Q?5sVJdwl5kG5lRwETr8ad53ZmkOZpxGduOhkPQBbCOg3ufcMrW0+iRLm/wj3k?=
 =?us-ascii?Q?4alvkgbPoQ/R3iWV4virDQbjAfv5fYGJNr0mm/gIQ8bv/PuViFsMnjqh63T/?=
 =?us-ascii?Q?Ea1/V5Mz2EFg7wX5LROJgvWrQ24zTUgdzZz2ShOD3XlI8g7iVhHHE4iC7bhN?=
 =?us-ascii?Q?vTqTWOA9WCUIgX/Xsdt85/ygdqsz8Yy8oAciPEIdw7+dE8YOXKPmBUB091BT?=
 =?us-ascii?Q?AlsaR5grYE6Dj4o/unHkMFDfGRCI5fCt/FCIXWjY3itQwxrTad9b7POSkyAr?=
 =?us-ascii?Q?OjVHTbgs/cSvTDQT4a797jxuz10Y0mnNiF/w+2oAlipb1g9f93PB5/v8wItj?=
 =?us-ascii?Q?i27Z9X33/R2RzoRwYPe9DA7tbtPJILInoos14V5skZi8SbdyEkAfqo2qlS7r?=
 =?us-ascii?Q?1afEynU4vt+EvbgIZmhamhWfVbB/7NjtdzFfB0fARcbDUWV0/XPK68sZQuW2?=
 =?us-ascii?Q?OCCtf/EmSqsvxzgGls4u/eA0rDRvXy9EkwsKGMCrOYv6OfIO+8Mb1lOJbJVZ?=
 =?us-ascii?Q?ZoDNiWt8FBiwNKDaKzBsKTTjo4WoID5CKzJdpXdSZtlckmnkv3bpBuqcAfWi?=
 =?us-ascii?Q?dhHaQW3m90EQKR36rZC/GoaPbHdaIu105MFhKwa3mO5vwQ75Gx5xKMut443g?=
 =?us-ascii?Q?6s0IadDA8RKwZBwqQNMtAgWvly1voDq2/4ur/tRLkgFMsA78I8zSpQNxiQFL?=
 =?us-ascii?Q?jRT5/1ZrAvy/4p6gar+RYgrsEyj6uUIa2riLKr/Y30yheXnOnyX0I4h7YZtz?=
 =?us-ascii?Q?kNyuHAuKLaR8xYCpS+tX8snYmjqUfcMQGdA62IzZIX/czIbYvtm56klmxhGO?=
 =?us-ascii?Q?LIGp90oI/5WmzztJEZI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89c9220-f422-4910-0164-08dbd9c127ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 03:26:22.5862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z1ksLsIl2CdyLyxudfGoNIhywZwl4s3g7JvWGdb/RyyV/pHI1++8W6MS7pgUXDo+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7137
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Ma, Li" <Li.Ma@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Li Ma
Sent: Tuesday, October 31, 2023 11:23 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Yifan <Yifan1.Zhang@amd.com>; Ma, Li <Li.Ma@amd.com>; Du, Xiaoji=
an <Xiaojian.Du@amd.com>
Subject: [PATCH] drm/amd/swsmu: remove fw version check in sw_init.

dorp fw version check and using max table size to init table.

Signed-off-by: Li Ma <li.ma@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c    | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 3efc6aed28f1..762b31455a0b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -234,24 +234,15 @@ static int vangogh_tables_init(struct smu_context *sm=
u)
                       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
        SMU_TABLE_INIT(tables, SMU_TABLE_ACTIVITY_MONITOR_COEFF, sizeof(Dpm=
ActivityMonitorCoeffExt_t),
                       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+       SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, max(sizeof(SmuMetrics=
_t), sizeof(SmuMetrics_legacy_t)),
+                      PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);

-       if (smu->smc_fw_if_version < 0x3) {
-               SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMet=
rics_legacy_t),
-                               PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
-               smu_table->metrics_table =3D kzalloc(sizeof(SmuMetrics_lega=
cy_t), GFP_KERNEL);
-       } else {
-               SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMet=
rics_t),
-                               PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
-               smu_table->metrics_table =3D kzalloc(sizeof(SmuMetrics_t), =
GFP_KERNEL);
-       }
+       smu_table->metrics_table =3D kzalloc(max(sizeof(SmuMetrics_t), size=
of(SmuMetrics_legacy_t)), GFP_KERNEL);
        if (!smu_table->metrics_table)
                goto err0_out;
        smu_table->metrics_time =3D 0;

-       if (smu->smc_fw_version >=3D 0x043F3E00)
-               smu_table->gpu_metrics_table_size =3D sizeof(struct gpu_met=
rics_v2_3);
-       else
-               smu_table->gpu_metrics_table_size =3D sizeof(struct gpu_met=
rics_v2_2);
+       smu_table->gpu_metrics_table_size =3D max(sizeof(struct gpu_metrics=
_v2_3), sizeof(struct gpu_metrics_v2_2));
        smu_table->gpu_metrics_table =3D kzalloc(smu_table->gpu_metrics_tab=
le_size, GFP_KERNEL);
        if (!smu_table->gpu_metrics_table)
                goto err1_out;
--
2.25.1

