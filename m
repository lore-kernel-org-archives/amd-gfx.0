Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCF3606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=z3elDI0l
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56C6510F2DC;
	Mon, 16 Nov 2026 16:39:49 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7579910F2DC
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 16:39:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/vhItOmJ9briJqo92IeRoAwkXulWqWIUGmV+NL/ogg4ak/MTnypzUgQL+vCCEPDGWZQIRGkRS/rIv6QyGwN1tILj8aitjz8XrR+jQgf5Y7c3vUfB5QdtMopE+V3mfGG5pKj4Jr0BRxWOHHyGFataGVhhIvqFZKd/fOOsRoDAvURNAySSwLIZTqtoIuAISZWYas9Tj4Ky2iHVeEIblkqLhlMk4hQr45Rlz/hNhJOGzgt3FseUcD9+MUu0phTFCJbAulDalMzkM6yDLpMiFLkD8sHpU7BU0A4c20i4EIbvdLIkgsp4PapNAWdneB2+ifazFkcOk8qMgnXAAM02vIBPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQxLzCMZQKf7n/8I8UW9WZD30+HNOSIXEi3lxbGxAOA=;
 b=ycO0dIwwngmFhkcwYUlItTxSa38MKdh0n7j1LbfSEKKbBiMCGMfgIgZo7ZLLchdfrOZNDMHT1RV2rg/wvPqDMrJG1U70uOA1071hQnhOSTklmmh5rVjAZNbZEAKMboGurcU0c1EDAIT8gKDqnrLF/92kQ1Ji7nDfWYoVS7cPARqZvXediDe0UCcDsHB1sBLX7bq+HqoJHYjSMzOS9+rbjLvxtuONOLdaEvT1QQAW0+mo5+9mmatHRlekSKlbb4mBJRWiV21u8B4lBHqmsFFxKnjoYEIhsCWXNRClU4pOiZHzo/YbvCL3Q6KsW9Y25ynOoM96yofnKAhVOPEqmOmI+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQxLzCMZQKf7n/8I8UW9WZD30+HNOSIXEi3lxbGxAOA=;
 b=z3elDI0llb4kGtF/gL7koUTSkem6zMC0fd0VEtoImjiag7genREAoOl7rNVz78gjcSy9oAQgBTfKZZ5rBfeKeHq63R9ZoajaY5lfZzu3N4P6WlHpoZ2QzpwEsPSnf9Ydta4Uo8kw48dMrDPs959Iuf00vNewIiZRIMMjSNl4+uc=
Received: from CY3PR12MB9631.namprd12.prod.outlook.com (2603:10b6:930:ff::6)
 by LV5PR12MB9825.namprd12.prod.outlook.com (2603:10b6:408:2ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 16:39:37 +0000
Received: from CY3PR12MB9631.namprd12.prod.outlook.com
 ([fe80::3595:9a8c:8f99:4e55]) by CY3PR12MB9631.namprd12.prod.outlook.com
 ([fe80::3595:9a8c:8f99:4e55%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 16:39:37 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Chen, Michael" <Michael.Chen@amd.com>
Subject: RE: [PATCH 3/6] drm/amdkfd: fix the MES gang context slot error paths
Thread-Topic: [PATCH 3/6] drm/amdkfd: fix the MES gang context slot error paths
Thread-Index: AQHdcRQc7ByDTabAOEaxvk5t/xbJ9Lcw76TA
Date: Mon, 16 Nov 2026 16:39:37 +0000
Message-ID: <CY3PR12MB9631928D45E802CC50B793A9F47C2@CY3PR12MB9631.namprd12.prod.outlook.com>
References: <20261110130440.474374-1-Prike.Liang@amd.com>
 <20261110130440.474374-3-Prike.Liang@amd.com>
In-Reply-To: <20261110130440.474374-3-Prike.Liang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-16T16:38:24.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY3PR12MB9631:EE_|LV5PR12MB9825:EE_
x-ms-office365-filtering-correlation-id: 49f32786-16e7-4d14-5cfe-08df4400342e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|6133799003|261009223027099003|11063799006|4143699003|56012099006|261028144727099003|261102123227099003|261026121527099003|261021123027099003|261026140227099003|261022105027099003|261021121427099003|38070700021|10067099003;
x-microsoft-antispam-message-info: mVVXA1hb3MqQWlHslly0aSMY4GKwjopx1Y+VoSuk5nfGdJYU1lav0NrpMX8VtHHElxHxKUT+YwOobvjHP0k5ZKNpA8SR97SYwDwbkdMREht2qHGNdWiEBbacDureeAyTdJL7d0dMOgJ13eOYzEE9DvBvu01uLMDO4+o0sZ6fvnoVwaIFbmFbUdy2+Hvd9NoUu6WvpH9CCTgpyH4ignY2Mr1Mp6R5pVAVepDHQKxNprxYuqEwM1qnQTUF/cE+bBOFNA/A6MRIiYXr/7/Aq49MojhV4ttFNfIiqsMTXS+pm7930n1VoMfypmV3WGRi8M9XhjwBkJ5Vl9HwXR9LSa66xQ0sY32Cn4nlvoXn6ZwrJ7d97WrruEO/eb0L3LGvSEdESeh6vuKrDIaeBebYBAUwhSww6MLXPQuOFspyAhAn96My8fjs6lpSoAayFVCD2JMtFXeSBM9K0Ae7nhfeQr0iOTV3o8b2oVbW5RHIu5sPUwYxX8jfMEGtwXBLLJGPfTLlQU+ssc+w2gSfWD35lZ2aGmHTEvShJvQ/PVkSKVBbB8FgUCbrtyS84h33x3A3rgUoVvMuFx5zrBybJvbjdJNfvxasCZLnH4ePBpt8l1MtX5j9h0YteYHdUwXaU8lgt9NNE/0pl4gd12Cg5D6t/WkdgEZlU5v7iKTAvurtLX9ikCLPYMZcDrEdo/2Yoeu9Ba5kpwPeHZV9meAHGwN0076sjGBEaMCecj6ePz4fcDPif+U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9631.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(261009223027099003)(11063799006)(4143699003)(56012099006)(261028144727099003)(261102123227099003)(261026121527099003)(261021123027099003)(261026140227099003)(261022105027099003)(261021121427099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7flsSn6/q/J9UWbQjJvgUCdAcRGXX8tgrUY8nJTJ+/kP1tBfiQgwb3Ghze09?=
 =?us-ascii?Q?OXLanqNscRjdUr7J8ReEeBGlJ9JjdZ+GOubP1af/aBfa2YReI9I5AA+uoSOa?=
 =?us-ascii?Q?kx3zhdEQWZTkxRrC2uXF8jpOyLB23UKLLw7PBIwygTtwFo140VtDkLfssffh?=
 =?us-ascii?Q?KkdZj7PvZ1AWZYzjHX1Y/PzK9bEsgOZBvI71LWR1b0pGwxDZkpoenSG/Ed39?=
 =?us-ascii?Q?L4zBZCxVVLAuIbVzjWOCfqS+SBKg03QHASiIZp0r9yTPGIAft08kNakNNtgY?=
 =?us-ascii?Q?aSGBpB/j3iG5LN7rsAUNw9k6W8Tdc+L1tcouRt0HGg5dUkoO1Jb9oTcupoFT?=
 =?us-ascii?Q?05snUeMLkfvRwBmaO0loG9Z821jqrA4rDJod7vedO4o3XIkvlRpWvs/lBQW1?=
 =?us-ascii?Q?Y50euGudjyo5HqQe9RDOf4EVC3O1lpljtsxN3cUJIXThohyevBNmi9bFUamA?=
 =?us-ascii?Q?/7zYcWJJujSAs5Mug6n5KdFIDaZQHikI16nx1lGisCqImAcxYp+bZRBQNGc/?=
 =?us-ascii?Q?j5iMORouBwZAYbk0kWM6OcdI7z/xPzOOMF80IhCOyTsZQQivNopkMuqfvnKG?=
 =?us-ascii?Q?1ytiOxNo/MWlCXjQurbdG95Y5UNYdyhazFfSo9xf3TOPqAY85dr5y95O7TIr?=
 =?us-ascii?Q?agA3fcRXDRMLeS+Ui/jAVUUToXpJWVBwkHxGvyxrhy5R3/bPIuj6Z5oYnvwE?=
 =?us-ascii?Q?8KfzBQlNvuwJ030CNFNqN7NtPbdi1U5C3lWuDTCwT5Wn4M+piyyDOUNkcy/x?=
 =?us-ascii?Q?UZgPTSbGXQBzi3RZd1Zt7eBm1uEu5R5r3lnOsVFzfDt9AfUBBAKDyxJNlV1c?=
 =?us-ascii?Q?yN6tyCmW0bjOX6a17YZb6YXv+kxHuyyoS+D8MctTjsd0s047O2xmAmyI/INx?=
 =?us-ascii?Q?ZCl81NJM5/wGzSVOcUksdYaGeBx3zrxyIxFmKHR/A/i8xuiy5kqDI4aaEDMU?=
 =?us-ascii?Q?g0BiuM+BJwndhgewCnCZd+2NCZlEZ15TDyX7oD7KhY4hon4d0X8a9bdvM0Nv?=
 =?us-ascii?Q?sRYU/IqwVDcCUp35Ry4GlAFImla8kjwjwFxYOfUOWHquNoNvbgTzU9TvQXTt?=
 =?us-ascii?Q?/50wn9qs7JAYn4epO0ztpdP7HyZJTTM/nd+WMIT7+OQE/JKiDvo2bIbCONBr?=
 =?us-ascii?Q?y+EmeR0e9KLD1bFxdaymyvVAQ7BJMPu9QmH/bO72pW9FUpCGq2f0rC18884o?=
 =?us-ascii?Q?ySJw3kJZe2kE39UbzH302D0BEw1nF4D/1EyZpEoBts7O6es4FLLFpslmZX0+?=
 =?us-ascii?Q?AR7JizJr628pgIZbxN9DiuNGFDroE5gl1/NGPHIEzWjLJJpTZ8+/sL8Lty54?=
 =?us-ascii?Q?ovma9eJd8t3/0DzD9b8D4obGagVB6cmCHyj9tPnbDQX3LaI+3oF89gOHMbB7?=
 =?us-ascii?Q?ylzu7OYgIH3C09oxqPh3nuh70I2L5qsGt9kiTMVQXz5EBBoN60FjXKi8W0sd?=
 =?us-ascii?Q?XVrBxXN7i9edXFTYtG2iAmxwPq00pY3iw9wIngwcCgohIKSvtL6ifJRPtilN?=
 =?us-ascii?Q?SGJqKjVmpI/GtG7JEhrTOAGQ8fSSamVt58a1kin9ICSCUHHwX+XG1kl1qxDw?=
 =?us-ascii?Q?MtDYVruLOqxVHbYnC3w/uP83P9iHuK1etaSNfSc8/Xv9GBVWBuMmtzrSmayL?=
 =?us-ascii?Q?YcTkfy9gj3Cr1gyQ1GqpcRC2Tico+TwwbyzvN6QTBevFebSzRpqAqlXH/vAx?=
 =?us-ascii?Q?WEvXWhNi47MaVqt9k8uQuYMF5TBw1inDYiP70JuUJp8tQ3WB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9631.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f32786-16e7-4d14-5cfe-08df4400342e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 16:39:37.5433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bogj+cmSyiyxr8n17l8hoYfomNbOYoKtUZhovYgmz52xVp5/Z3NUtRy8AEnk0rjs532hfqVstp9+y64MXhWWxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9825
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

For Patch 3,4,5,6 .  You can added me as acked-by :

Regards
Shaoyun.liu

-----Original Message-----
From: Liang, Prike <Prike.Liang@amd.com>
Sent: Tuesday, November 10, 2026 8:05 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Chen, Michael <Michael.Chen@amd.com>; Liu, Shaoyun <=
Shaoyun.Liu@amd.com>; Liang, Prike <Prike.Liang@amd.com>
Subject: [PATCH 3/6] drm/amdkfd: fix the MES gang context slot error paths

In MES RS64 mode, init_user_queue() allocates a gang context slot for each =
queue after its gang context buffer, but two error paths don't release what=
 has been allocated:
 - If no slot is available, init_user_queue() returns without freeing
   the gang context buffer.
 - If init_user_queue() succeeds but the DQM fails to create the queue,
   pqm_create_queue() only frees the queue struct. That leaks the slot,
   and also the gang context buffer and the wptr BO's GART mapping,
   which already leaked there before RS64.

Fixes: e32b68c6b135 ("drm/amdkfd: enable rs64mem for kfd queue")
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 .../amd/amdkfd/kfd_process_queue_manager.c    | 28 ++++++++++++-------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drive=
rs/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 4646dfbabe75..6cc0365e9b11 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -187,6 +187,13 @@ int pqm_init(struct process_queue_manager *pqm, struct=
 kfd_process *p)
        return 0;
 }

+static void pqm_free_mes_queue_res(struct kfd_node *dev, struct queue
+*q) {
+       amdgpu_mes_free_gang_ctx_index(&dev->adev->mes, q->gang_ctx_array_i=
ndex);
+       amdgpu_amdkfd_free_kernel_mem(dev->adev, &q->gang_ctx_bo);
+       amdgpu_amdkfd_free_kernel_mem(dev->adev, (void **)&q->wptr_bo_gart)=
; }
+
 static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
                                     struct process_queue_node *pqn)  { @@ =
-211,11 +218,8 @@ static void pqm_clean_queue_resource(struct process_queue=
_manager *pqm,
                pdd->qpd.num_gws =3D 0;
        }

-       if (dev->kfd->shared_resources.enable_mes) {
-               amdgpu_mes_free_gang_ctx_index(&dev->adev->mes, pqn->q->gan=
g_ctx_array_index);
-               amdgpu_amdkfd_free_kernel_mem(dev->adev, &pqn->q->gang_ctx_=
bo);
-               amdgpu_amdkfd_free_kernel_mem(dev->adev, (void **)&pqn->q->=
wptr_bo_gart);
-       }
+       if (dev->kfd->shared_resources.enable_mes)
+               pqm_free_mes_queue_res(dev, pqn->q);
 }

 void pqm_uninit(struct process_queue_manager *pqm) @@ -270,7 +274,8 @@ sta=
tic int init_user_queue(struct process_queue_manager *pqm,
        if (dev->kfd->shared_resources.enable_mes) {
                if (!q_properties->wptr_bo) {
                        pr_debug("Queue initialization with shared MES requ=
ires queue buffers to be initialized\n");
-                       return -EINVAL;
+                       retval =3D -EINVAL;
+                       goto cleanup;
                }

                retval =3D amdgpu_amdkfd_alloc_kernel_mem(dev->adev,
@@ -291,7 +296,7 @@ static int init_user_queue(struct process_queue_manager=
 *pqm,
                                                &(*q)->gang_ctx_array_index=
);
                        if (retval) {
                                pr_err("failed to allocate gang context ind=
ex slot\n");
-                               goto cleanup;
+                               goto free_gang_ctx_bo;
                        }
                }
                /* Starting with GFX11, wptr BOs must be mapped to GART for=
 MES to determine work @@ -300,7 +305,7 @@ static int init_user_queue(struc=
t process_queue_manager *pqm,
                if (dev->adev !=3D amdgpu_ttm_adev(q_properties->wptr_bo->t=
bo.bdev)) {
                        pr_err("Queue memory allocated to wrong device\n");
                        retval =3D -EINVAL;
-                       goto free_gang_ctx_bo;
+                       goto free_gang_ctx_index;
                }

                retval =3D amdgpu_amdkfd_map_gtt_bo_to_gart(q_properties->w=
ptr_bo,
@@ -308,15 +313,16 @@ static int init_user_queue(struct process_queue_manag=
er *pqm,
                                                          pqm->process->kgd=
_process_info);
                if (retval) {
                        pr_err("Failed to map wptr bo to GART\n");
-                       goto free_gang_ctx_bo;
+                       goto free_gang_ctx_index;
                }
        }

        pr_debug("PQM After init queue");
        return 0;

-free_gang_ctx_bo:
+free_gang_ctx_index:
        amdgpu_mes_free_gang_ctx_index(&dev->adev->mes, (*q)->gang_ctx_arra=
y_index);
+free_gang_ctx_bo:
        amdgpu_amdkfd_free_kernel_mem(dev->adev, &(*q)->gang_ctx_bo);
 cleanup:
        uninit_queue(*q);
@@ -486,6 +492,8 @@ int pqm_create_queue(struct process_queue_manager *pqm,
        return retval;

 err_create_queue:
+       if (q && dev->kfd->shared_resources.enable_mes)
+               pqm_free_mes_queue_res(dev, q);
        uninit_queue(q);
        if (kq)
                kernel_queue_uninit(kq);
--
2.34.1

