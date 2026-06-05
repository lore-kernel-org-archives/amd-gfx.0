Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D72CD6E74
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 06:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32F8211A48A;
	Fri,  5 Jun 2026 06:44:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0CWBY0L/";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 245D511A48A
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 06:44:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPIUacrnfpEH+Kx4ow9InJbePYakbDsH7A/3U2KCbRGSSlb52sDbhMLF2co4590dJy9HY3FULk54lhIAvj7coxzggIY7eHjzgObj9EDWxkHscPiKq2s0yM1db3xcnfrccdBXUY7Ip8CKWK8uSAU1oBsBIw4ybosZdv4WYckIcjWEAs+HcSJSiGdeIRcvaLNX/u08NcpONNPqKFYAZdVhGvGIV+RUcspSEnbDTT/ghZSPaALChaVSZKCii5A7xE4dg0htWxMwH07TIHbra04lORPzBg1sRdRfq87/PVLefFubPJc0HYfnNVT/AprC8uAWPbgCd3EA9F3bAjM9OPdndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbOgEzquk4mljQvwJ0vHUSu8FNH/3+zzKN4pxoYUrSY=;
 b=Sg/EgyzWgHpGu08qA1JoUpX4X4Y36Ch0QmNEin86XKYdljFkpRkQtly+m162+3T4YErY3ypH84qIfxnOUlkSqgCOqWUyrkqx1PF0saqQ64col7dawjL4whK80y0n4MJyWtgz4ny/RVwNo7y5No1dmQit4Dz9uWzMg/ME4bbgharxHS5Sg8IDeVI8HbxTS+HIvwezxfU5mRGOI1dxi5wwwyXivxbm0dSQjR8NjZiDTxcO5eM+/dD4HgAHd3tSYD5oXJNoLkAMP17zO2D2yHdNLtnCkPYAI9UV+AhTtSwtAmuuJ9s6SgMvuIFl5d8TKlDENJIiVDbYJgdLSplDEMiJbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbOgEzquk4mljQvwJ0vHUSu8FNH/3+zzKN4pxoYUrSY=;
 b=0CWBY0L/NQO6+3KDL+9hzwYAGYtGQt260dl53nbq+TwJl7fMag11qWGV62r5B3BrdszGy7vq63u8XJFfHyvYpPX8Y40Tl2Ipu/Ux9PHgz0fZKCEiiI14JwUhWjNW7Iq7OMt5af/S3tXPFMJ4fKHVOR3Y+apjzabfO3om99vahSQ=
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by DS0PR12MB8814.namprd12.prod.outlook.com (2603:10b6:8:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 06:44:21 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%5]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 06:44:21 +0000
From: "Zhu, Lingshan" <Lingshan.Zhu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Huang,
 Ray" <Ray.Huang@amd.com>
Subject: RE: [PATCH V3] drm/amdgpu: implement per-process MES context
Thread-Topic: [PATCH V3] drm/amdgpu: implement per-process MES context
Thread-Index: AQHc8ZHcY1dIa/wBe02gFUHc4F6YhbYvigmA
Date: Fri, 5 Jun 2026 06:44:21 +0000
Message-ID: <CH2PR12MB9457A60825EC5F4F18489C3B8C112@CH2PR12MB9457.namprd12.prod.outlook.com>
References: <20260601064112.172432-1-lingshan.zhu@amd.com>
In-Reply-To: <20260601064112.172432-1-lingshan.zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-05T06:43:16.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB9457:EE_|DS0PR12MB8814:EE_
x-ms-office365-filtering-correlation-id: a96667f4-7b30-4f4f-570d-08dec2cddfb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: ZM7y0xH9Cq0vzzXYphcKNBr0v5lzpNHOjYuymfA+s+YUPd1a3BFnbJdz0bZ1zW836tRpvs9IYAj8BVgd3BC8AIr7f0ZflmnndQE0FWw8eJRaEYc9IK0ppA/znHHnIzR1BQHYT1+F5gtbEhs9iLB0nVB08tNan6wtXGwz8be8OtNBHM8VqrpvrdxMpBUOsNuijFJjcXsSOf3ctnIs1CHtaV/8Ecmcy8lWtdZ0N+A0yMcYGcY6BW5NcLNY6ppr16Rpp6JxyrzQLqxKfOlO5tNArGld0nOVK0PqmylLrvW+TWmqiyQXR04ukM6cmYhMKIcQX2eQdkYmYrBl/Azr0m2tbK36Xi7l0ECXZYGOR4bOrP2p+5aBmEB3vQ0+4UM8Fu4+2DhDKhgAxBK6CsUN5b3bWfbdctgB7yYNm/TyA3uT4v15DKTatuajHI3GgeVE4B1kN1y1/lu6b3669SOw5RbiTtpRRWOV7ZPrRPxIBPh6d0ItH0eSOEFS11hjJqir2TWBz8GjrgDmy4HV2ongJqxfUBp4riKf7DNSt34dYqWXXNBb/wi4x+AWUzeeuNWKFq7/VWBXSthvkXc0Ubr0ZYlJtPRJY+BZwXDhhXSRtFUO6bimV/EKN7iRk1Roca2C2svCvDoOjCwuJojov9BfZ0E0h5TOki708yeGjLM3cCPml5/BeZT5+7FYY2qrhSHHFjpmw0mqs02CU9r1BQHFULKTxSgIrk0ha8gTmmWuB0VTlQeU/8xWfr5BILJO7+NS+iiC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U8i0hRbDFufSQeKUr+nZ9F0R9MAKqux3/M4rDbYc8HPMP+G6JJOWYDmQxKps?=
 =?us-ascii?Q?DnnOyU2vYh1MPL9OQ905pHYf+No+OPSabnUPQAuHc7T6FAR5JtpxopimWO0t?=
 =?us-ascii?Q?MSw9/XfepHqEfRrUo3PCJfSdMm4JRjguAdjjObPh5KvZLZc5WEQYXEGv2DdD?=
 =?us-ascii?Q?eAxcdVAnmqUO1AnFJ8NhJ9AoqFkruT4klUlLqG2OOzsRF3QafJJGhGo78/12?=
 =?us-ascii?Q?8ZsO2RhlgkpBzfC+4ps1eZG0ap/d1vR9yqxNa/ORkHpbGrFjRF5aNxOw1JO3?=
 =?us-ascii?Q?liwKvVfdXJhFF0RGDBagvc5lC0JAgXd0XwQbM5+iulIlmFc2zEbtVARTdvuy?=
 =?us-ascii?Q?iQsrUFr7E4aa+rieI5fp9357ADx2bfoYCkFNrf4pVbvBdDau47hlcuncPzIT?=
 =?us-ascii?Q?/DvP4A4l9m467f6Ug7eHpz5XJQ3NYrzPdwE+vDGUewef9r3vmay2VVJAthR2?=
 =?us-ascii?Q?JND9s6o3P/tJOv6VPBZknCO/tt1likoh0Hb+Zkn5BqQw9Y+52nDEi051nQJO?=
 =?us-ascii?Q?Z0bewJeW2Mgurx9hecQqXJxPIXkdLOFYdtkhU5OBi1mnvdrRDBw8UmE+7Scd?=
 =?us-ascii?Q?tBXaTfHBXjyfMaf7c+TXlLy3ZnBZ18jFl3ZwER+Xm7g8vn9NtXeFG28nGn8E?=
 =?us-ascii?Q?Zcf4O58RdEd34wufjy9Qa7Kv5WR+IZ25GfIbbBe2h3hkY7LFfTl/laSQu/lm?=
 =?us-ascii?Q?626X642V9wlZPnckANz9kYkVLkaSrbrmK8KysHzfpcR+bGd0ATNbB09ahx1j?=
 =?us-ascii?Q?k0m1pM4FD1Np338ZliGDmddYQpUot5LJyHmDx3EBEl12kyrSZL9HgkaCQrZH?=
 =?us-ascii?Q?oyqtw5bYtl/6lEaIoopyKs0gcvE1P0pj3Xo/1ssGMa6/pIb9NWK3N6Qy/Q+0?=
 =?us-ascii?Q?oKKlBJBrWIapandg7gppJhWDNsW8RAiGdGglTv4nFNKC3ITIChmRD/7Js+Kj?=
 =?us-ascii?Q?8w4KbdzZEFqy2S4tkC4SC918xaXqZkWKOPLXZv2G10wOrBNNDku+VHMLDNc7?=
 =?us-ascii?Q?8bmedV0IIEsz8iMLpVtsY8nYkln1ICbKNyLZUVmsxljTwwTJfwUYBhPKB9xG?=
 =?us-ascii?Q?zHPCGe48jGPCLo54abisnYMY5HHIE7z1DdoWIlTfxR2GS1azPIydxJ/PV/Ra?=
 =?us-ascii?Q?aQYGE7F9ZsskHCfBUKnQKfAqyD+FR/WK3haTY3ah2LJa3sW3EOeqRWZDdhTE?=
 =?us-ascii?Q?fkh3a8JW6zL14e/ewumMjQv8iMCKptg06O6ea1L1CRlXpTNUD1NA6fs8q54T?=
 =?us-ascii?Q?n1COZHE3upnXsHVfIpoqoboNab7Bi5Ck3e0MTSDwDYOqSH3ccKCn7TO9fT0B?=
 =?us-ascii?Q?HqMCBVN8VJs2oeZALzcXjNvGWBCL0G/F82LiqA7KReBuvBT3bTAwJlG6sYix?=
 =?us-ascii?Q?9DWF69s/i9EclVKTabzOxIrnsgZTMUroSqfpiRDS13JjeeWDM0qNskTjIBdp?=
 =?us-ascii?Q?7rGAKhE25Z2bePtFE0vSO0SBhit3jp1Kr5DpL3sZa3vbA+WOP8Uoj93zZUi/?=
 =?us-ascii?Q?mLDZSs8aGAMreqgIThzWJ9vWznloHwXLlcZNXdr6ibamwh7qbN32F3YjDSzx?=
 =?us-ascii?Q?GQHO4TfBQg0ypPfErBSebXJN0dXV34IKEFJ96M2hQnS/KPPBsFZV0ZRMtjuT?=
 =?us-ascii?Q?Ww5u4B9Y3QV3hMGxtR4WejC31BvvD6xWioS3cqwTpk7OFTvbJuNPkBpir9oe?=
 =?us-ascii?Q?53VklaP2z2GrHrbsA6h5DQ4H/y9RiSG8U7RXW0XRhCptqmcu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a96667f4-7b30-4f4f-570d-08dec2cddfb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 06:44:21.0475 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p56+AY5hD+6cQfZkWPYWJtGsEly9e7G9U4O3v5xsN0D5IjkQX3mEpghvoesFFc7i8NtTfyNwhpT/Q+e9XCO87Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8814
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

Gentle ping, Christian and Alex

-----Original Message-----
From: Zhu, Lingshan <Lingshan.Zhu@amd.com>
Sent: Monday, June 1, 2026 2:41 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Huang, Ray <Ray.Huang@amd.com>; Zhu, Lin=
gshan <Lingshan.Zhu@amd.com>
Subject: [PATCH V3] drm/amdgpu: implement per-process MES context

MES process context is a process-level page where process specific context =
is saved for MES scheduler.

However, current user-queue code path assigns fw_obj of a queue to MES proc=
ess_context_addr when adding the queue to MES.

This means every new queue from the same process would replace the previous=
 process context address with that queue's fw_obj address.
What's worse is, when user space frees a queue, its fw_obj will be freed as=
 well, causing MES working on a NULL page pointer.

This issue leads to inconsistency and crash in the scheduler.

This commit allocates a process-level page for MES process contexts for a p=
rocess other than queue-level

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  6 +++  drivers/gpu/drm/amd/a=
mdgpu/amdgpu_userq.h  |  2 +  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | =
51 +++++++++++++++++-----
 3 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_userq.c
index 38e310a8694d..951d5da850be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1172,6 +1172,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *us=
erq_mgr, struct drm_file *f
        xa_init_flags(&userq_mgr->userq_xa, XA_FLAGS_ALLOC);
        userq_mgr->adev =3D adev;
        userq_mgr->file =3D file_priv;
+       mutex_init(&userq_mgr->proc_ctx_lock);

        INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_wor=
ker);
        INIT_WORK(&userq_mgr->reset_work, amdgpu_userq_mgr_reset_work); @@ =
-1225,6 +1226,11 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *use=
rq_mgr)
         */
        cancel_work_sync(&userq_mgr->reset_work);

+       amdgpu_bo_free_kernel(&userq_mgr->proc_ctx_obj.obj,
+                             &userq_mgr->proc_ctx_obj.gpu_addr,
+                             &userq_mgr->proc_ctx_obj.cpu_ptr);
+
+       mutex_destroy(&userq_mgr->proc_ctx_lock);
        mutex_destroy(&userq_mgr->userq_mutex);
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_userq.h
index 28cfc6682333..a5867ffe6988 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -127,6 +127,8 @@ struct amdgpu_userq_mgr {
        struct amdgpu_device            *adev;
        struct delayed_work             resume_work;
        struct drm_file                 *file;
+       struct mutex                    proc_ctx_lock;
+       struct amdgpu_userq_obj         proc_ctx_obj;

        /**
         * @reset_work:
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/a=
md/amdgpu/mes_userqueue.c
index e9189f07c6dc..6c8a44cee34b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -133,8 +133,8 @@ static int mes_userq_map(struct amdgpu_usermode_queue *=
queue)
        queue_input.gang_quantum =3D 10000;
        queue_input.paging =3D false;

-       queue_input.process_context_addr =3D ctx->gpu_addr;
-       queue_input.gang_context_addr =3D ctx->gpu_addr + AMDGPU_USERQ_PROC=
_CTX_SZ;
+       queue_input.process_context_addr =3D uq_mgr->proc_ctx_obj.gpu_addr;
+       queue_input.gang_context_addr =3D ctx->gpu_addr;
        queue_input.inprocess_gang_priority =3D AMDGPU_MES_PRIORITY_LEVEL_N=
ORMAL;
        queue_input.gang_global_priority_level =3D convert_to_mes_priority(=
queue->priority);

@@ -169,7 +169,7 @@ static int mes_userq_unmap(struct amdgpu_usermode_queue=
 *queue)

        memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
        queue_input.doorbell_offset =3D queue->doorbell_index;
-       queue_input.gang_context_addr =3D ctx->gpu_addr + AMDGPU_USERQ_PROC=
_CTX_SZ;
+       queue_input.gang_context_addr =3D ctx->gpu_addr;

        amdgpu_mes_lock(&adev->mes);
        r =3D adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input); @=
@ -186,12 +186,8 @@ static int mes_userq_create_ctx_space(struct amdgpu_use=
rq_mgr *uq_mgr,
        struct amdgpu_userq_obj *ctx =3D &queue->fw_obj;
        int r, size;

-       /*
-        * The FW expects at least one page space allocated for
-        * process ctx and gang ctx each. Create an object
-        * for the same.
-        */
-       size =3D AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_GANG_CTX_SZ;
+       /* The FW expects at least one page space allocated for gang ctx. *=
/
+       size =3D AMDGPU_USERQ_GANG_CTX_SZ;
        r =3D amdgpu_bo_create_kernel(uq_mgr->adev, size, 0,
                                    AMDGPU_GEM_DOMAIN_GTT,
                                    &ctx->obj, &ctx->gpu_addr,
@@ -257,6 +253,30 @@ static int mes_userq_detect_and_reset(struct amdgpu_de=
vice *adev,
        return r;
 }

+static int mes_userq_create_proc_ctx_space(struct amdgpu_userq_mgr
+*uq_mgr) {
+       int r =3D 0;
+
+       mutex_lock(&uq_mgr->proc_ctx_lock);
+       /* This check is a necessary because amdgpu_bo_create_kernel()
+        * calls helpers like amdgpu_bo_pin() and memset() unconditionally
+        */
+       if (!uq_mgr->proc_ctx_obj.obj) {
+               r =3D amdgpu_bo_create_kernel(uq_mgr->adev, AMDGPU_USERQ_PR=
OC_CTX_SZ,
+                                           0, AMDGPU_GEM_DOMAIN_GTT,
+                                           &uq_mgr->proc_ctx_obj.obj,
+                                           &uq_mgr->proc_ctx_obj.gpu_addr,
+                                           &uq_mgr->proc_ctx_obj.cpu_ptr);
+
+               if (!r)
+                       memset(uq_mgr->proc_ctx_obj.cpu_ptr, 0, AMDGPU_USER=
Q_PROC_CTX_SZ);
+       }
+
+       mutex_unlock(&uq_mgr->proc_ctx_lock);
+
+       return r;
+}
+
 static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
                                struct drm_amdgpu_userq_in *args_in)  { @@ =
-429,7 +449,14 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_qu=
eue *queue,
                goto free_mqd;
        }

-       /* Create BO for FW operations */
+       /* Create per-process MES process context BO */
+       r =3D mes_userq_create_proc_ctx_space(uq_mgr);
+       if (r) {
+               DRM_ERROR("Failed to allocate MES process context space bo,=
 error: %d\n", r);
+               goto free_mqd;
+       }
+
+       /* Create BO of a gang for FW operations */
        r =3D mes_userq_create_ctx_space(uq_mgr, queue, mqd_user);
        if (r) {
                DRM_ERROR("Failed to allocate BO for userqueue (%d)", r); @=
@ -492,7 +519,7 @@ static int mes_userq_preempt(struct amdgpu_usermode_queu=
e *queue)
        *fence_ptr =3D 0;

        memset(&queue_input, 0x0, sizeof(struct mes_suspend_gang_input));
-       queue_input.gang_context_addr =3D ctx->gpu_addr + AMDGPU_USERQ_PROC=
_CTX_SZ;
+       queue_input.gang_context_addr =3D ctx->gpu_addr;
        queue_input.suspend_fence_addr =3D fence_gpu_addr;
        queue_input.suspend_fence_value =3D 1;
        amdgpu_mes_lock(&adev->mes);
@@ -529,7 +556,7 @@ static int mes_userq_restore(struct amdgpu_usermode_que=
ue *queue)
                return 0;

        memset(&queue_input, 0x0, sizeof(struct mes_resume_gang_input));
-       queue_input.gang_context_addr =3D ctx->gpu_addr + AMDGPU_USERQ_PROC=
_CTX_SZ;
+       queue_input.gang_context_addr =3D ctx->gpu_addr;

        amdgpu_mes_lock(&adev->mes);
        r =3D adev->mes.funcs->resume_gang(&adev->mes, &queue_input);
--
2.54.0

