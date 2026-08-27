Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8284EC61DBE
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 03:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77E1210E3AD;
	Thu, 27 Aug 2026 03:15:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j4ZRNylF";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBD4210E3AD
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 03:14:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oO+tBZulPalCoh0SNvGzBMWqI/qR4HROpVwTj/a5J7SatYCDZat4WUynfmKlTkw2NJvX/SS/89ZJ3BlfBeTKAmxVlI6a/uIYECHn5gyqKzfKuZJonzmrpy1VwZVFu55i42qHcdVn1QB3afzEVt8BILoS8CihIjVTJF9U0Cz4DWj2j5FUK9zCUcS5VSfgfr0WuBE1pqBGG+rc+UsagMMxxVccpXyTGee2TNlX6ba/sIQr1wUYedeeNGOy2WbhEGQW9v+TNWZYiyBVqA1UHhjn/kMsr13uBsPX466v+Fja/V7nkK6GmSB1IeuktsZSF6vuOg6PoG09c8CfsmH7O19XwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phn4IdxAwld4UVvhl1dHyHh7FHkCot8nN6yHHQNIkzY=;
 b=M640e/rxkS4c4KSADfhpRRS0PwFB15olXru9YcypF4GPGkho3iuD/AppLyXOxfHleLloXg6C8PYEJo+N4vLxMKp8SSShUh37Qo+OfJR+VaYc/YNR7cffEA7WO6lM9e2OND0scYmTYsOgxfLYup3WsTOICVjwzQewgfm/SeGfscXNwecUal+NiEcZDw1O8vwZH0Qh61pdxqaeLEV/NW4GK6vTQcnxVxDXXzBdZ/DMUqEiSs3WuJjheOUhLMLsbD2ktGpESbAewkm3QdfxNcrYj03hN86FbYyZJv9YlS3GeBvyGvS/e0G3jXDkUFKcYL9VGzUqMgiyvmQDIiqWUV/sLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phn4IdxAwld4UVvhl1dHyHh7FHkCot8nN6yHHQNIkzY=;
 b=j4ZRNylF7mrxI0/kd5/lu27EgXR7UrmH48ml58lFUQRZM4Az6qB231lBy2hjGvO7tcE/kQqCR8lzJxE+ONhhsmuoIaEnckc7w/z93CJVrOvHwjXk+GjwDJjFLBhOUsIk/n0tN1s5rXe2wng+AdA4eLdzb7pN8N9nSYSHoU+GKRY=
Received: from BYAPR12MB3192.namprd12.prod.outlook.com (2603:10b6:a03:139::14)
 by MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Thu, 27 Aug
 2026 03:14:56 +0000
Received: from BYAPR12MB3192.namprd12.prod.outlook.com
 ([fe80::b4a2:3223:31a2:ab7a]) by BYAPR12MB3192.namprd12.prod.outlook.com
 ([fe80::b4a2:3223:31a2:ab7a%4]) with mapi id 15.21.0339.010; Thu, 27 Aug 2026
 03:14:55 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, 
 "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/ras: take a log batch id only once there is
 something to log
Thread-Topic: [PATCH 2/2] drm/amd/ras: take a log batch id only once there is
 something to log
Thread-Index: AQHdNUWaX+rJXyX8D0KIuqCb8KVuEraxOdZQ
Date: Thu, 27 Aug 2026 03:14:55 +0000
Message-ID: <BYAPR12MB31928D417468144DF3C7CC97FCAD2@BYAPR12MB3192.namprd12.prod.outlook.com>
References: <20260826102737.575490-1-xiang.liu@amd.com>
 <20260826102737.575490-2-xiang.liu@amd.com>
In-Reply-To: <20260826102737.575490-2-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-27T03:14:36.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3192:EE_|MN0PR12MB6003:EE_
x-ms-office365-filtering-correlation-id: 55ed1500-d740-41f8-6667-08df03e95e24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|6133799003|4143699003|22082099003|18002099003|11063799006|5023799004|56012099006|38070700021;
x-microsoft-antispam-message-info: aVKTGMYs3H0UlqXHiARRYu+h30TGEvazrlPHL2ZcRpHD4UfyJEX14AMzn1/6U7eq291N6RVTpSE+v3cRWWhCNIDeQV70kgmLCYvmlf9UXtcoprOX7W9t0iEF8c2z/RBDyPSUJHfCIb8X4YdaBwy1I8tCg9YimU26gnU9NM36FXI06xOvmMM4qcfc5OtJ0v6ur2TdhWap7J+OlFSM+fTt44OGMBQ10VO1SRPD3xXiFCLBhNWO65iDGChaymL3uTpJvfubidBoFgkFxroXYPmzDVFJlyS2SQ350qBsY0Kt0cf0Hwih2SYv8TeOh0aAIs+w8p5DueZ6vYpArBuYhbKXT4UDGMOY7CfYDCv+djcR4pS1cDUPQhKiy9lUs7yobTEez+Vwj8PiHGPqOUIH7BHt+YzvPDR7d4R/Q2ICxZHI8uOKh0HzdRgTDfXmfqiMbK2GPYJRkXEbAzga4B8EyFgAyKJjF9z+2UtvW8UIADABf7URNZiDUEIQFjKrsgGZesDwCvy8zTrdfutf1Lw/LD/B0VdXO4PnyNtxgyWTIa/7QbLmWmb1hN7Xz9Wr0GKqzv/QSk4py426uE4YSf4x4o2s9XV3JZuu2OxvP0EaQfS3XPtjVWMr2eEWkVOp7qr3lttKC3jA339FVp4siNtcPdFX5p7pskuIHPX1mVh6D0M9l/SDl8Dgd8nLhfUXPyhU1UibgJWtHlo98nOejthGmRHEKx2hMcx71NqMZpgAi75VBeM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(6133799003)(4143699003)(22082099003)(18002099003)(11063799006)(5023799004)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5uNp9bHI3RT1Fw96Q8uMKbBiwm0QNZ1ZuRp2MMakylSs+zZ62y1xChopD209?=
 =?us-ascii?Q?lGPmX5pjo7yMSIW7HPLabgRJrj5ABjAGOrWPDmCaK9bXIGj64WxOOpXmBG8+?=
 =?us-ascii?Q?/bGTAvVSNG6nB6ytHYovv5tGkzuI24aJEBX1eD73yNlgZyvF2TE/QsNOEpbG?=
 =?us-ascii?Q?M5pR/rB6DLMY6d864Y9MZl7mCi8NuXXza5nGh5A/DOaH+C7Drwvh5rv0QegH?=
 =?us-ascii?Q?T5vvU+GIsPL96n44aQGBA0nUFpFVHfm8F5RkOe+P4PBLHCvr+4umjOOpnKy7?=
 =?us-ascii?Q?ITVATkkUxli7T0xKPRyvIOXKs/qkjQxRSnZSce6NApinBgpuenR2qwabWHL7?=
 =?us-ascii?Q?g/D0sVQPYLHjhfRsoJLpWeZUWsZK5L3aEMVqDIP0CPkXyJDhvYpohe4BjFP7?=
 =?us-ascii?Q?dK11+HjA5k40KMeIuiA25nktDiSvBLKI+A5/K9CMh1wEmpzmecyz7nEAbNp1?=
 =?us-ascii?Q?MhH7a76l6FP3TpzBsXHbMrf90FpWfI8nG8PWfWyg/BvjOMb4rCflGfZ+8Otd?=
 =?us-ascii?Q?QPWr2o4u4qtxUJFBxSWyyhvVMad+e93Qdolto5+RHquQErcsbTM7gymP2zPE?=
 =?us-ascii?Q?vsQzd0BZa83ernO20SuRRsGPCBlxgmwiffilNp+9lNTdVYNwECY7z6Z0UQFL?=
 =?us-ascii?Q?wyFehao2bIXP1/xkxhIGmvrz8gOzp0y9DJ2PDNo87U2zynta9M0lBgaGOwgR?=
 =?us-ascii?Q?Gpo5zZUMzGMQuHwn9Dozi4trBTeV0Fe2j0M+x3aBcsE89Oc8KBdCC13VFctN?=
 =?us-ascii?Q?l/ibOm7r9t2T/8a3RRRHuavM3UpYSEAQKbKcJeMGCL/plKKn6KI8zJ+ZSCKf?=
 =?us-ascii?Q?/GrAirQcNr0EzNyZszC7h2BSnr9NKhS1oOsvzWJJUj16OtpIWYczOuL31LXh?=
 =?us-ascii?Q?BMauYr/+fVM45+SMTIKKcficsTg3raP8rh6cxXopkIaE9MoXB2W0WUVN2wJq?=
 =?us-ascii?Q?o6uREL91QPbZ0G8YSabf54BhZbxlQ6H6KB02NnTw5VfqsY4vIfu7G5qZ3Fl/?=
 =?us-ascii?Q?JdLTOc2uaiKjGNQvmvca6bjQnZ1i87A/LYBluqjh2ilqMG4MEvRfW7gUlONr?=
 =?us-ascii?Q?zdkmepHn4uWA745E3jIwmGVVlBxLWl74Pf8NyvNYfv0QocL43JMIsSMBlnIY?=
 =?us-ascii?Q?c5imLjgYyBRYMcDwA27PHVHuwB0YdWuC8isuF9XN8PjCh2EkKjyHWNTAZi/2?=
 =?us-ascii?Q?3A3cQtqYET7unM4QpVnT5i3bYCVw+4nyQ0lNxgixG+WmrknQxiw7PRIdvI64?=
 =?us-ascii?Q?6hQ2kSIfiusJpC0F3tgNk56LeOR8PPzxuG2uBfT5J73JYiuHRDGwFVY7u2om?=
 =?us-ascii?Q?8ZbSe5pwVOIGqst5j4d8fQaVNTJMNMUCIBxu6RrmhzmiW17yw5f4Mi0PBAyc?=
 =?us-ascii?Q?tbf0OoB37LyeenZlrlBk+CIk7UJ62J2cwiqybGIzNX18cPq4E+7EDYtLH4ys?=
 =?us-ascii?Q?gy2oICRvRElbvPnh+cdN+MHNB989BNXTa/EDP/E2j26QdmVCzmTjPSMfoSsy?=
 =?us-ascii?Q?Y+9Y+vSCh3pWnVS9pJaMGZP9SZNNW5hU/yiIvfHadjjkKpCIDqESpCWAWvVl?=
 =?us-ascii?Q?GYKNalO0uepoXBj0zmsa4b+vXYbEZuZt8iYn8FzgUN5cw19gm/gtUWSwO87J?=
 =?us-ascii?Q?t0WptQAtiuOiar1V3ZHPcIcH8Vt/lrTs2fk24Ff9U7qe7P35cJ4AWMxHtxOF?=
 =?us-ascii?Q?MqHqnfYhgvOUhNaiJz9cM6DEq0iFTtC9UoEWQZBFzuNuS7Yo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ed1500-d740-41f8-6667-08df03e95e24
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 03:14:55.1590 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KV6OGPH4IwGWeAUEiPJtZssyvfU0fmrs4u0DPb6ZA/lnU9SKs6jmeEDzEcHPDxMyfT6RWN9ziY5vQ2V+u1zTQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Wednesday, August 26, 2026 6:28 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; =
Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH 2/2] drm/amd/ras: take a log batch id only once there is so=
mething to log

The id is claimed before the banks are read, so a poll that ends up logging=
 nothing still burns one and leaves a gap that every reader of the log then=
 has to walk over. Claim it when the first record of the batch is about to =
go in.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/ras/core/aca.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/aca.c b/drivers/gpu/drm/amd/ras/c=
ore/aca.c
index 881681ea9f3f..4289e968d331 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.c
+++ b/drivers/gpu/drm/amd/ras/core/aca.c
@@ -394,10 +394,6 @@ static int aca_banks_update(struct ras_core_context *r=
as_core,
        if (!count)
                goto out;

-       /* Only one MCE error is logged for each batch */
-       if (ecc_type !=3D RAS_ERR_TYPE__MCE)
-               batch_tag =3D ras_log_ring_create_batch_tag(ras_core);
-
        for (i =3D 0; i < count; i++) {
                memset(&bank, 0, sizeof(bank));
                ret =3D aca_dump_bank(ras_core, ecc_type, i, &bank); @@ -42=
0,6 +416,10 @@ static int aca_banks_update(struct ras_core_context *ras_cor=
e,

                bank.seq_no =3D aca_get_bank_seqno(ras_core, ecc_type, aca_=
blk, &bank_ecc);

+               /* Only one MCE error is logged for each batch */
+               if (ecc_type !=3D RAS_ERR_TYPE__MCE && !batch_tag)
+                       batch_tag =3D ras_log_ring_create_batch_tag(ras_cor=
e);
+
                aca_log_bank_data(ras_core, &bank, &bank_ecc, batch_tag);
                aca_bank_log(ras_core, i, count, &bank, &bank_ecc);

--
2.34.1

