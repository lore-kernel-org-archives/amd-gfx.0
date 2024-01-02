Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E6EC47073
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 05:38:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ADBE10E0FF;
	Tue,  2 Jan 2024 05:38:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D4E310E0FF
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 05:38:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCY4VdO09aeERittxmMM9Q1Im/W7WZYlYxLNWfzZmxJ50LKAjjhAju/fnb33AhJea0NpqNNFy6emNkOFf+Xh7xPA9evzvDz97zV3cpQv/oI5crA8vcJCSpG/hqv879h20Iz4boSwTWax/BVDfYOMZUcPuDngLnWDhc60pgIjCQh3i0KwWLL+Viw8M5/VBO1ZweCX3N6YzaCYkA6kuZRie2/cphb2s/rqR7e/5fjqZCYyctqeBv1QofciTnIRDeus+FK4CPeeMRygHUq9KKe/ZgAhYht/xHEXbbVKhHIxpnJMbTDMBGTHcBKPmWYhTu2uWeN9h8TVcrOhso7Bh56yeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87qduAZjVqqUK4DoAEQPmMXbJIJFiyMz8VxQLz2t8zQ=;
 b=nZgCr/d6rVIDHp/20bLqXvnNiymmc6IandfuPPxdPgzoztfSibumxO8Xum5zjw2DHBqDQyX1lLSboeXxh8diweSOQ5eZLoCk5cZ8iGZg63WbEgaDdfLY4YQWFYw2tmU7h79sxhoiPoc89WcAWl/V5pbu2Th5Pl7ZSOA4TOy6fc1CzBJcrVJlEg68Wi3M4J94PvbedufsyFRq7ku5WSU5aJklXhhBqQE0P2WZLOucSv/9LmSIS0ds7xVByTQVduKbnT95OUea3QnqwTiAWms/i9gy3FRWdgdxXJQbBAXqymDylsGBy4WgjLgRndWnSwFX7WzEJ5431vkNrvLipDQAfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87qduAZjVqqUK4DoAEQPmMXbJIJFiyMz8VxQLz2t8zQ=;
 b=L60jYJDiDTZ61n2E/7cNXBJwBrKVjGeQx2YB0vBRYEQxwGfzxwHOPfjD0vAy1iEkgt/f8xUMXC8W9abR5MTX7iepqk2+R0wq4X8hu2Yhq8LAgEnr/Q96ajOak70HNWZ2RJzXnjZX5TiQAD4oDBlVPAUIgvDYWIu2JBXvhjfgB1w=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by LV3PR12MB9268.namprd12.prod.outlook.com (2603:10b6:408:216::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Tue, 2 Jan
 2024 05:38:23 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 05:38:23 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: Query ras capablity from psp
Thread-Topic: [PATCH 2/3] drm/amdgpu: Query ras capablity from psp
Thread-Index: AQHaPS4QIi4Qa0f0FUmRRU1KzHjfMrDF++UAgAAEmHA=
Date: Tue, 2 Jan 2024 05:38:23 +0000
Message-ID: <BN9PR12MB525740D2D819B6626AB2393CFC61A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240102034440.16376-1-Hawking.Zhang@amd.com>
 <20240102034440.16376-3-Hawking.Zhang@amd.com>
 <PH7PR12MB599727B1E79936287A6FD4F38261A@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB599727B1E79936287A6FD4F38261A@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ceb12e59-4c5f-4e48-abfe-0ce66c0726ba;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-02T05:10:03Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|LV3PR12MB9268:EE_
x-ms-office365-filtering-correlation-id: 83646279-5d2a-4b65-ea8b-08dc0b5508fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qngHqLmj/k5T6n5xUC9YWC20D7uzOJz36RGOKgYDvEL9TZCNO8grDOltM/xXjALvaN39lC02gaX1/7F8Jpdb+lpqzto4bykIwdaIgYbQdKaQZZ2vOyMvrJU551bqVMmsclyF1YK+3jfuwiMUzB2c46QXC7R4J+o8kRIwd7EpZutrXC9eXQlBtG6oBOpZIuaTN4XnULVCXl0qp7Q3GXoahYqblHMDkJNwY4VKnXfy2DiB9eUei4W9y2/F1Ev4ngunOJOFgd8UuaR6NntiPZyF9IdMonTxaBAwyNo37YYZyA/isK5i/qmrHrhky+bejQvb0XGisFvptfB+HoIN7nON9qqnR5f2k2BpN4ZvBN2E5vy6IxLPmzo9R7EvwdLCg8TYfTuJkIO+i6ITvnHUI2+Cz6X1dXdLp3uKnRPexM0UxcnYJ5TM0XvxgSb3khoggySNReT/KfREEh7vnhnVAiIUucT+3Uh42xUWZrLRLqiXGaQcwBXfgVT8+zh/MmAVM4p3NEdhdhthZzFxSL16z4XS7OuDocHnm62YAjOBr3XmYYHqEjBhFVJ6awnef92/Sv7s77puX6OlgrTMWl+RQ3J0hEzzcmBWPh7aPc5g9lNgZyfvfLpEcGONY19t5cbF1SvoHKcx8E5EkWTgHz/tak/EsA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(921011)(83380400001)(26005)(86362001)(38070700009)(38100700002)(71200400001)(33656002)(5660300002)(4326008)(52536014)(53546011)(9686003)(7696005)(6506007)(8676002)(8936002)(54906003)(76116006)(316002)(6636002)(66946007)(64756008)(66556008)(66476007)(66446008)(41300700001)(478600001)(110136005)(2906002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dRbNqfANC+9Ub7LrTyKQkXrV6nNoPjkisbBnKSSmxEl+3VlIFcnILbwqcja3?=
 =?us-ascii?Q?1pCjeOjttY7OGC/Za29O2U5WbWl3DOtL5azxCNWbKdK6QFlFLP7Avn+PlBLh?=
 =?us-ascii?Q?QWtch2wi+KWabt2IPDhjE/DdTdaFzXaXSEKvf72ECYG6PrCUpv58OgnmPOq4?=
 =?us-ascii?Q?xaJuhhpTJyb0d6G9T0gCGwaK1iWnnjubs3PdB9bKAnBBmoK4RvG3mBlifn7B?=
 =?us-ascii?Q?ETGZqExh7nOfUXEhkpZ4+/wTEn4qoRO5Wq87xveOOnFLo+Uoets1pwG9seQu?=
 =?us-ascii?Q?0e/OJfrDSFGcehKQXdDWXwNHutScLqrwPpoemB0tsM1aDLiV+xZ5WZtq1KL1?=
 =?us-ascii?Q?SXKRBT9WXkeYfO2h19CN2zYePTjQs4BLsQLeCn4aRZMwqjtUSTeVpegyUG8V?=
 =?us-ascii?Q?bN0Lr/uKxW2iYVbQ4RQvZNzx4jPori1IzJ+acR3UfaLp1u8z/kvWyQf5AhCx?=
 =?us-ascii?Q?GJEckzxHtTji0AcJ+3ggx6W5da0XNGiWA43fma35R2sVqKJMkR0AEn+U7HZe?=
 =?us-ascii?Q?RVTY5MmZ2b4Ey3NUOfRnSCkQHs6BIO3GfHYGrhCt8gDB9u3ty7/IckH6w9TU?=
 =?us-ascii?Q?jXJI0XXhncNqL/u/WoUCRj10OqImzPreiOYHM5eKV1P7MOtQQgTU/hBrsDJm?=
 =?us-ascii?Q?kTc4ZEK5LPxQd+OmszFo0+zj2uiJzh3SbUdzivImf7B1yZ4F9JsvIZDO0r0X?=
 =?us-ascii?Q?KhMgYoR9SfVU30lpMc/jx+DK/pw1H9MoYfakW2EycFJZBh/eaSxqT3bzJDVG?=
 =?us-ascii?Q?/7/5nHUKBg41YyQD/A3FvB594lfngQ7kHLWRhIx/8XOwukjoAe3k0F0oi1q4?=
 =?us-ascii?Q?tsKFqOKQIdGvy+cr3OWn73DjrQQUzXfsnW9EsbpYKcYqMKbocYicru7jxCVQ?=
 =?us-ascii?Q?RNGVRegAN8Vn5C5jIdIqkf+6yLeOS3DEOD80cufsRYMSW3wrQfqUGNMgevUm?=
 =?us-ascii?Q?BwtiFpXv8/0JhJvFI/Nir5ty06fsJnO0DV6s1scDXgfxU0QwroS3JwbPmO3U?=
 =?us-ascii?Q?+36y7el7AGBt4LmeKvtbd1mfmzLFzJTA8H3jZZjWMnuIbJmmOohPyRupnk94?=
 =?us-ascii?Q?Ai0xCyxmi/0YirZy5HqeYY53DwQrgirz+M4uLRnxwcXFahgbOhZe+jPsrlAn?=
 =?us-ascii?Q?IQtRyMFP0saeMmGw6sAflnhYPSxI04ApaQciIyTezm1Q8Gmhi0/79BSg1nWw?=
 =?us-ascii?Q?czQ+7hPV21eo1/UgsSC2+lsA5CnEErkz/u+hrgWRQK7bqsQHZ+Ooj7SCbrzo?=
 =?us-ascii?Q?1q/PK+2EJ8ELKvI80y3RaBz667HUo70G6R/u+pGGdsAq1AIWXBUeh6OQaVPa?=
 =?us-ascii?Q?MI8TQzP3+uju65MQA0vf8/AW2fvMay+pRDHz+DelMGczpGSALhKXn0VuX7WJ?=
 =?us-ascii?Q?D8jXsY3cbzA78B59rM/0sTMR39fxyL+5PGUmyvmdWu9A50qyHMcIbT8P1wio?=
 =?us-ascii?Q?07V92pkBPJsTo9TqayANALbb6EF+qDHXfjycBLnPvJITHsawmzYBMH63rwED?=
 =?us-ascii?Q?SDb9j1sLDcQ+QIE0tYB82EvDNno7iTNStwyU3lpiEKHt8hVnO6PBJIwoQ+rI?=
 =?us-ascii?Q?pyNJWSTR33h8oL2MJUA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83646279-5d2a-4b65-ea8b-08dc0b5508fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 05:38:23.0402 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KlOIKABuasnDAhe3oC4VQ1PuVfgJP7JAGctZ5oIhgbOat1C5pqw0w023HrbXHvqexnwW1lo76pkOHl0XFnpWUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9268
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
 "Lazar, Lijo" <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

The ret gives us a chance to fallback to legacy query approach (from vbios)=
.


You might want to see patch #3 of the series for more details, go to the fo=
llowing lines in patch #3

+       /* query ras capability from psp */
+       if (amdgpu_psp_get_ras_capability(&adev->psp))
+               goto init_ras_enabled_flag;


Regards,
Hawking

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Tuesday, January 2, 2024 13:19
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; =
Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,=
 Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: Query ras capablity from psp

[AMD Official Use Only - General]

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com>
Sent: Tuesday, January 2, 2024 11:45 AM
To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, St=
anley <Stanley.Yang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; C=
hai, Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Query ras capablity from psp

Instead of traditional atomfirmware interfaces for RAS capability, host dri=
ver can query ras capability from psp starting from psp v13_0_6.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 13 +++++++++++++  drivers/gpu/dr=
m/amd/amdgpu/amdgpu_psp.h |  2 ++  drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  =
| 26 +++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 94b536e3cada..8a3847d3041f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2125,6 +2125,19 @@ int amdgpu_psp_wait_for_bootloader(struct amdgpu_dev=
ice *adev)
        return ret;
 }

+bool amdgpu_psp_get_ras_capability(struct psp_context *psp) {
+       bool ret;
+
+       if (psp->funcs &&
+           psp->funcs->get_ras_capability) {
+               ret =3D psp->funcs->get_ras_capability(psp);
+               return ret;
[kevin]:
This variable 'ret' seems to have no other purpose, can we remove it and re=
turn directly ?

Best Regards,
Kevin
+       } else {
+               return false;
+       }
+}
+
 static int psp_hw_start(struct psp_context *psp)  {
        struct amdgpu_device *adev =3D psp->adev; diff --git a/drivers/gpu/=
drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 09d1f8f72a9c..652b0a01854a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -134,6 +134,7 @@ struct psp_funcs {
        int (*update_spirom)(struct psp_context *psp, uint64_t fw_pri_mc_ad=
dr);
        int (*vbflash_stat)(struct psp_context *psp);
        int (*fatal_error_recovery_quirk)(struct psp_context *psp);
+       bool (*get_ras_capability)(struct psp_context *psp);
 };

 struct ta_funcs {
@@ -537,4 +538,5 @@ int psp_spatial_partition(struct psp_context *psp, int =
mode);  int is_psp_fw_valid(struct psp_bin_desc bin);

 int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev);
+bool amdgpu_psp_get_ras_capability(struct psp_context *psp);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c
index 676bec2cc157..722b6066ce07 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -27,6 +27,7 @@
 #include "amdgpu_ucode.h"
 #include "soc15_common.h"
 #include "psp_v13_0.h"
+#include "amdgpu_ras.h"

 #include "mp/mp_13_0_2_offset.h"
 #include "mp/mp_13_0_2_sh_mask.h"
@@ -770,6 +771,30 @@ static int psp_v13_0_fatal_error_recovery_quirk(struct=
 psp_context *psp)
        return 0;
 }

+static bool psp_v13_0_get_ras_capability(struct psp_context *psp) {
+       struct amdgpu_device *adev =3D psp->adev;
+       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+       u32 reg_data;
+
+       /* query ras cap should be done from host side */
+       if (amdgpu_sriov_vf(adev))
+               return false;
+
+       if (!con)
+               return false;
+
+       if ((amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, =
6)) &&
+           (!(adev->flags & AMD_IS_APU))) {
+               reg_data =3D RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_127);
+               adev->ras_hw_enabled =3D (reg_data & GENMASK_ULL(23, 0));
+               con->poison_supported =3D ((reg_data & GENMASK_ULL(24, 24))=
 >> 24) ? true : false;
+               return true;
+       } else {
+               return false;
+       }
+}
+
 static const struct psp_funcs psp_v13_0_funcs =3D {
        .init_microcode =3D psp_v13_0_init_microcode,
        .wait_for_bootloader =3D psp_v13_0_wait_for_bootloader_steady_state=
,
@@ -792,6 +817,7 @@ static const struct psp_funcs psp_v13_0_funcs =3D {
        .update_spirom =3D psp_v13_0_update_spirom,
        .vbflash_stat =3D psp_v13_0_vbflash_status,
        .fatal_error_recovery_quirk =3D psp_v13_0_fatal_error_recovery_quir=
k,
+       .get_ras_capability =3D psp_v13_0_get_ras_capability,
 };

 void psp_v13_0_set_psp_funcs(struct psp_context *psp)
--
2.17.1


