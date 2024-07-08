Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C489C3271E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jul 2024 05:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CBE810E043;
	Mon,  8 Jul 2024 05:06:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IQS/oB5x";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D98710E043
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jul 2024 05:06:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwPJ9QynxNRL0DttvizbDkme4b1qlWFC7hnIrowiIn1dbCOC3A9QvRNP/dty6Dg3facHtclIxUHUVMNJ96+h1IP3H7NFDRF5nsYeX+tk/3oCvag0dYZl8cuU4x3JkRfAz241xqcIQuE8XG951MwqXvhx55cQKCTAmdKC2LjIFpecS1LdnVckDcmZ6KtCRxicde07uYnJ9++Ee+mSjbLCduPGOn9w7lgctWpEaDstNynM3tTdw+MMTBoZXmAxVNM3M+6HLa6bGdIOKhHrve/3zEwBE+e1jdW0NaGxIH83aTc8mM7havazovDlQHlqIUMAa/hmHQwKSEixstU39gE3bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gy+KfNc5VHi3R/NsMfjJ7+mk2+twVHVg8fYWJ1pXp4=;
 b=I7xh7LDpH4MVruKiOdSdK8q6+Lrh1uREGE28I8R2sJPJ0Ariypc1CxOhrp8kDy8Jak1yw28KZnN4fV90HUQBjfZpePZq5GbTLqf7mf9OUyOtZOBM/LA/EGHKG0DRkSAZ4ntg/rwMrouQafx7OFkbKTj01AbvSTb3bAaPb9Hkkr1Ku3BFSqkgOa7cH3XzHnRvtITJqR01WnqUBm/UfCGuK5hyauSHJoyBtnioO4QCqyTdqCLSkYkuZWnlACknMihF82reUmdt0cg/5RH6/fLsT3dvbs6P01FmZ+DYBESl9SRIw5Lwv7EaIoDEJnh7gK7XaM9bDFES3/cHcYa7hWzm5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gy+KfNc5VHi3R/NsMfjJ7+mk2+twVHVg8fYWJ1pXp4=;
 b=IQS/oB5xhneV+j1cTbFkOXb4JEmu7agwTf7WvT79vwRM6jhdeEMqE4fXYnYq4X8UC3IfuQF/ktnDK15/s6tjYVQRvGMV4AZ7jw3zAeGiUfWUKVJUWF0/BUoC1jvoVbcf0zYN7baYfvjm1RQusojNzyZHt7rZ8ux6ab+a6q1zQtk=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS0PR12MB8296.namprd12.prod.outlook.com (2603:10b6:8:f7::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.35; Mon, 8 Jul 2024 05:06:05 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 05:06:05 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH v4 3/4] drm/amdgpu: add ras POSION_CONSUMPTION event id
 support
Thread-Topic: [PATCH v4 3/4] drm/amdgpu: add ras POSION_CONSUMPTION event id
 support
Thread-Index: AQHa0OZnG/z2FJ/UGUKCg78gA9XJy7HsRtdg
Date: Mon, 8 Jul 2024 05:06:05 +0000
Message-ID: <BN9PR12MB525799F3C0D3342937C3F11AFCDA2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240708032439.2944714-1-kevinyang.wang@amd.com>
 <20240708032439.2944714-3-kevinyang.wang@amd.com>
In-Reply-To: <20240708032439.2944714-3-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7e95d093-f3ee-4575-b231-0cc6dd436361;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-08T05:04:33Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS0PR12MB8296:EE_
x-ms-office365-filtering-correlation-id: 3a3342fd-877b-44b1-1a1e-08dc9f0babad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?6H+DQTpL7g2cTJ4dwYFXVlH5MrJjk6EKZVMlI6zGICRae/+vATGGWRtTgRJI?=
 =?us-ascii?Q?BVkBpX7cbXfOuAxEC8ceRqIFB2UymsbdHFcTIKiH6xIO2uPjr04pivOeHsZw?=
 =?us-ascii?Q?aY27cDbIrlDXpRr+32HD1dlPeDJ0cIbj6jYr7q06zNgoWW7XVLF4EBUN5Kh4?=
 =?us-ascii?Q?EeaexxJk5AdPA/JiDAmAa2w01uSyk3uuWzw2z5ZnIgtROuZsTDHVkaQUviWV?=
 =?us-ascii?Q?wSxX5WNWvMtLGLgEvr7y31TTL+YPuU18Y1l6ciCLyx4ROTVlBCMeDnAWq7kX?=
 =?us-ascii?Q?wuOt4z475xwtj7cUluDCLmQJ81HMbv5zykam9PwjH12VykHbHl1uS2pHQzY6?=
 =?us-ascii?Q?/crqJvIxbmFgyslByzU+Z9S3lx7FSQSk7OQs1/sacw5Lwh3pVIFhFGxxGIY6?=
 =?us-ascii?Q?4PLzmhR7yz3da7ZmKOH3mVKUpA+E1sRxAJbhFaa03evdTbwKmicA976irNlv?=
 =?us-ascii?Q?+UJEPLtAXrQJpccmMScgAJ5hoboQ0taYvODPJBmssXcQYu2Z3HmAkedpq4AK?=
 =?us-ascii?Q?BK3iz+MME6Us7wvDZpS3IlAR0xToVPGUlJ3qZ3swMI7ZyyGPOYK94v3JiwDI?=
 =?us-ascii?Q?bdUkEu2CLzaSHntybobqlGyUkzkLDYF6fcrSEanPoCwoGeqNLVEvWmccBNhu?=
 =?us-ascii?Q?LofWL4vw7cHW+Fy7vh8EqaCvSPcyBVH/aoHajNspJDEFesy6HngKitZI2KtA?=
 =?us-ascii?Q?GXDeE9EdbbHmVQiKlgqSQWb58oLUmMG1TGu3P+SJOjRY4WE3uavR8Uhre1PE?=
 =?us-ascii?Q?kGsVw8aFdsdpRm5VdySAURG7NJ7WkyI1LrBOqlR7Et7zAF2TND+vGjrOWPYE?=
 =?us-ascii?Q?u+pjAnI1vhmsmxLX0OyDyr1fbEaQAGpaevvwOWQBtbXiygl1cp5UtYrMakFr?=
 =?us-ascii?Q?ro1SKGWlPm+SA2nFYLJLBD9J6Zp1rAw3P9iwCIcdaA8CaYFTrVTicfVL2n1A?=
 =?us-ascii?Q?aQd5b4UIXlbjYO85D5vopwt0blaFSjvcIqlLxvZkBlYom7kK3DRsstgf+Pj9?=
 =?us-ascii?Q?MiMt7zylJgulcysDCBTpHdCmCdbTvOh2VuZNhv9Ct7HJdMi9sGvFBdKmALfV?=
 =?us-ascii?Q?puC8V7q50uNEBOj6IDJ9m6NfhlMP3SFOE92y3WaGfR0yyqdD21toX+nfCQkf?=
 =?us-ascii?Q?p0+KAJutNeXC/xeLAkMvmNa7cC8BEF4xsZNqwZKBGLuSwtQlhDfeEhZv7Y51?=
 =?us-ascii?Q?5IXjDW9YBtBhG9b8HhZ4WmJ5zkhP45/dxSs3aC8i+t3FcvVD1EE2jMGcHu2E?=
 =?us-ascii?Q?1mi4+J5NQGcLef7jkdguvrbsTxMeP28AmKumk27Bq0QnSS1T5GdmmekkTY+d?=
 =?us-ascii?Q?DdKkhHGtxMn7YTYYYrgJ1/OelM8TuL6h2zBmOzHKtwRe8rWnB414rXZziCPU?=
 =?us-ascii?Q?ae6IoUdlOc/0t3ADuwoDew6pNPCy1NMtggx1wcD6Je3u8Mm/sg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d1xndR2venj563AR/vgbXf/PhkScz7bZVAEeh84uT3T7tGwddcwz7T/07guu?=
 =?us-ascii?Q?t56E3xKCXK8BgqHMD2nkxDQPbxf0Lnoh0z/AYLvasJXkd+/JjKrb2vkyUTb6?=
 =?us-ascii?Q?U7XtuYwNck6l1rE5NLUdlBz8Kks3ngFM/Ed9c4ElfaQhif4/zu/kTZreAv/T?=
 =?us-ascii?Q?DHbhRHLkvLW943Nhd7iR70uBywh3kC9hB/nl5T/bopCO72hS5DBHzMOkOCOy?=
 =?us-ascii?Q?jdpKdJDZe8jQttenKCNZ5ivIKVdMGAfVLciaCX594yilOpdCM3kTm30lORbL?=
 =?us-ascii?Q?E4/2EDKcl/BqazXB4adk7VritOFyq8JgBartJRQiiFq7gMe+1r8fwfgER1gY?=
 =?us-ascii?Q?WRbIyMhjbuO7DRqCVWcn+WWqz8av0WfpBtt75B8DZ1HbWWRkTmWsLO0fLLEj?=
 =?us-ascii?Q?XFu1ufECFszkr5Njc4XbsfJTmMfKCr0Ot5RwhO71rZfzVKwkxoAWSKBpbhDb?=
 =?us-ascii?Q?g8v4v/djHmIbEcRRRgxkP909Vmh45qmfXl103l/u449dOCwKq/3zusd0MXaL?=
 =?us-ascii?Q?aRfucLAzb2PI/Jwob4/hfEy/FNbd7pceUF+z6f9JKEz4hj94VSb8wXtaCZZe?=
 =?us-ascii?Q?oDFyezpumCBqOIj8osiR7TkpVoP4ppAougSfhfqpT6zq2V1Z/A2u5TTU0LWm?=
 =?us-ascii?Q?Vov3ZdR7E1DWTlP1olDvRreacVmpwFTM8+6qCZzSO8qkwZWJvI2eoj3uohG0?=
 =?us-ascii?Q?X0FewJib6MuyBAr0gkM3TO6YJFlGyHL1SI9JvhV+QEQXJiMSYun9l8lNff+x?=
 =?us-ascii?Q?mHXp2nuyrLq33/WsHnmBoEeChYIwQ5av0nSbcKRm97sfncWU25edGy9BI0v2?=
 =?us-ascii?Q?GU+HiOhrJKmSqyTpeZJz4wNsoCbv51j7XJQv3GccMl8MzJ4VMozCmbbOizw5?=
 =?us-ascii?Q?4bxE/cPmhtLkftHOzb+KrN7mquIklERVTDiY39dHilGmZMBSZ1p6P8gQLWmR?=
 =?us-ascii?Q?iVLBbDgxnM5X7OkThfgVgcheTyK95DE7jGzR0E7XC+YtGFs4P2djqENJUIua?=
 =?us-ascii?Q?NAfVeQ1/nuHi9gM99YZMSWcXLHq2I9bhzNwnttfV2tVDPTs3M8EHOwPr+UZq?=
 =?us-ascii?Q?LLoMr9A4eboihxquS9O4Bu8Fa4jKwkLaF0ip7tc7X5WYx7+RjWWYKFPifPo+?=
 =?us-ascii?Q?26DvPw6wilnjjAf6wpCYPbKrj89AkaWYT2GaUWXkk/filjxj/GrilywZVGqn?=
 =?us-ascii?Q?BNkHbUFhbFH9e0LZk90QTv/kSCzSvKncjzfoKi2TYL3PIN+93Hj6qi8a5/sN?=
 =?us-ascii?Q?QTIFfGncXmrNOmoTAE/TXvtGgaHVXf2wI9NB+vuXsmQAWrXlA6vTaZ9cyDIQ?=
 =?us-ascii?Q?Wc96KWKpvig81yljzrQKjNVBc5a+P7j3cvpIeWmWsVlN0Osyv7QWMDTSQt9F?=
 =?us-ascii?Q?1ALlFw5dks9ZjZa0N/03ucvKsWX7uUL5rsT5sNt6Jeuwdbm724yCn8NP/AxP?=
 =?us-ascii?Q?FGDx4vlWhZzf2ElAW3ucELLzYd1q6yVwWwEjqn58s67OT3E7vD9dN/fbRrDB?=
 =?us-ascii?Q?Jf5Dz/b60BYMD0wUwyU7/odzIFFjxctr1HO0ihyfTdWpEHR/LKmBcKsajqRK?=
 =?us-ascii?Q?pQ8OX6kz0GnK87tiUZs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3342fd-877b-44b1-1a1e-08dc9f0babad
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 05:06:05.3229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xASOPAi7vKt3rZ5XO4Yz0veMP3gBZKpBOsg+w7/kaxd1PzwIoa9I1P5CkWJ9UoT2t4msmIjfeLRaJqVjPPRm5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296
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

amdgpu_ras_get_fatal_error_event(struct amdgpu_device
        if (amdgpu_ras_intr_triggered())
                return RAS_EVENT_TYPE_FATAL;
        else
-               return RAS_EVENT_TYPE_INVALID;
+               return RAS_EVENT_TYPE_POISON_CONSUMPTION;
 }

Keep in mind that this is temp solution to treat poison as fatal. Moving fo=
rward, we will need to check poison handling option to determine return poi=
son consumption or invalid event here.

The series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Monday, July 8, 2024 11:25
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH v4 3/4] drm/amdgpu: add ras POSION_CONSUMPTION event id sup=
port

add amdgpu ras POSION_CONSUMPTION event id support.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c         | 16 +++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h         |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 15 ++++++++++++---
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index c7e68c5e90cd..ca09316fbb6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2076,10 +2076,17 @@ static void amdgpu_ras_interrupt_poison_consumption=
_handler(struct ras_manager *
        struct amdgpu_ras_block_object *block_obj =3D
                amdgpu_ras_get_ras_block(adev, obj->head.block, 0);
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+       enum ras_event_type type =3D RAS_EVENT_TYPE_POISON_CONSUMPTION;
+       u64 event_id;
+       int ret;

        if (!block_obj || !con)
                return;

+       ret =3D amdgpu_ras_mark_ras_event(adev, type);
+       if (ret)
+               return;
+
        /* both query_poison_status and handle_poison_consumption are optio=
nal,
         * but at least one of them should be implemented if we need poison
         * consumption handler
@@ -2104,8 +2111,10 @@ static void amdgpu_ras_interrupt_poison_consumption_=
handler(struct ras_manager *
         * For RMA case, amdgpu_umc_poison_handler will handle gpu reset.
         */
        if (poison_stat && !con->is_rma) {
-               dev_info(adev->dev, "GPU reset for %s RAS poison consumptio=
n is issued!\n",
-                               block_obj->ras_comm.name);
+               event_id =3D amdgpu_ras_acquire_event_id(adev, type);
+               RAS_EVENT_LOG(adev, event_id,
+                             "GPU reset for %s RAS poison consumption is i=
ssued!\n",
+                             block_obj->ras_comm.name);
                amdgpu_ras_reset_gpu(adev);
        }

@@ -2498,7 +2507,7 @@ static enum ras_event_type amdgpu_ras_get_fatal_error=
_event(struct amdgpu_device
        if (amdgpu_ras_intr_triggered())
                return RAS_EVENT_TYPE_FATAL;
        else
-               return RAS_EVENT_TYPE_INVALID;
+               return RAS_EVENT_TYPE_POISON_CONSUMPTION;
 }

 static void amdgpu_ras_do_recovery(struct work_struct *work) @@ -3985,6 +3=
994,7 @@ u64 amdgpu_ras_acquire_event_id(struct amdgpu_device *adev, enum r=
as_event_type
        switch (type) {
        case RAS_EVENT_TYPE_FATAL:
        case RAS_EVENT_TYPE_POISON_CREATION:
+       case RAS_EVENT_TYPE_POISON_CONSUMPTION:
                event_mgr =3D __get_ras_event_mgr(adev);
                if (!event_mgr)
                        return RAS_EVENT_INVALID_ID;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 69eb5fd4640f..49ec8edcbe39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -436,6 +436,7 @@ enum ras_event_type {
        RAS_EVENT_TYPE_INVALID =3D 0,
        RAS_EVENT_TYPE_FATAL,
        RAS_EVENT_TYPE_POISON_CREATION,
+       RAS_EVENT_TYPE_POISON_CONSUMPTION,
        RAS_EVENT_TYPE_COUNT,
 };

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_int_process_v9.c
index 816800555f7f..8a10a0e42846 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -27,6 +27,7 @@
 #include "soc15_int.h"
 #include "kfd_device_queue_manager.h"
 #include "kfd_smi_events.h"
+#include "amdgpu_ras.h"

 /*
  * GFX9 SQ Interrupts
@@ -144,9 +145,11 @@ static void event_interrupt_poison_consumption_v9(stru=
ct kfd_node *dev,
                                uint16_t pasid, uint16_t client_id)  {
        enum amdgpu_ras_block block =3D 0;
-       int old_poison;
        uint32_t reset =3D 0;
        struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid);
+       enum ras_event_type type =3D RAS_EVENT_TYPE_POISON_CONSUMPTION;
+       u64 event_id;
+       int old_poison, ret;

        if (!p)
                return;
@@ -191,10 +194,16 @@ static void event_interrupt_poison_consumption_v9(str=
uct kfd_node *dev,
                return;
        }

+       ret =3D amdgpu_ras_mark_ras_event(dev->adev, type);
+       if (ret)
+               return;
+
        kfd_signal_poison_consumed_event(dev, pasid);

-       dev_warn(dev->adev->dev,
-                "poison is consumed by client %d, kick off gpu reset flow\=
n", client_id);
+       event_id =3D amdgpu_ras_acquire_event_id(dev->adev, type);
+
+       RAS_EVENT_LOG(dev->adev, event_id,
+                     "poison is consumed by client %d, kick off gpu reset =
flow\n",
+client_id);

        amdgpu_amdkfd_ras_pasid_poison_consumption_handler(dev->adev,
                block, pasid, NULL, NULL, reset);
--
2.34.1

