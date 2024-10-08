Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A98CEF173
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 13:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A648210E236;
	Tue,  8 Oct 2024 13:34:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1OVH81SC";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABDA310E148
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 13:34:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l0v/7ceS9tCz3U5+tJlyIdgRlOwAVyFKhe0yMu+BPuJbj4PBPUuatRhvHjgAIe4tfqjosOsmiC/Y60w696e6PEe8OTHbDD9Z0oiubVGd3DrQQhikVYCWp2MDL96thWwINyZXj+gvR63rK65M3eDqYLXFzohI2oJGT0P22rFvmkyShi/QvbBU++xQB7gpvvsBWhYFyCgj37PBf/5SjdGcE50y/ZlQPKXDVcguO4EA7LoGmuPz7j7fntppjS1qszp4yswly4EJsKvVFIp1l/JeH0x/xz+HQY0I0mQ1HaKwYPo+xGDH2+9MxGS5RgU4ADa/8tnP6nY0nwbvxcQ6eMHwaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SM2+bd2U3iX6j0v7Bm3tYQ5q8lvFf+Mpfx0Q8NlOLiI=;
 b=t3xJlXdjiygZ0iSITBz9Pm1WJBx718PbzZJIIT/8n4QYlsuBA/m/gaNAWX9WipEfxxh2sVXi5BsBeMl0upCJ9E1oxuWEkpxI2s+hEZHMqkTU8tWiu4OsiRmAgR16JtOmoszLnYpGThLcx9E6r1VJFwngVBzVkodQ1J5vUaejuefZXvpDr2Znn9166G9gA5dy7olZx38djAMGe1KvfEaDgUY1r4tMF/yVWjE/9I5XaPvYZ4ktwhCymVSZPd4AcifmZF3IxcY/lExExzn7a50EzwxYXwEGsFelAK+tBNa80MIMwGl+ACo0BcfsbOAUzaM3jSz8iBkO0fCDg/GjSH5I4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SM2+bd2U3iX6j0v7Bm3tYQ5q8lvFf+Mpfx0Q8NlOLiI=;
 b=1OVH81SC5SmXHEK2eE/vlRv1soZ8WdOql+vANoukYd7lAb9U2t1bGpaKvskuIgeS5QrGf4YPhTd2oapWVC/o3UKU1cw9CSXKAX8ER0LXlgWavNQWqywF3jGACniGKXybyOafvpmvg0cQYHQ+da3sqLg+FxufDuV2LpG4/y4ZTWA=
Received: from BY3PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:39a::28)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 13:33:55 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::d) by BY3PR03CA0023.outlook.office365.com
 (2603:10b6:a03:39a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Tue, 8 Oct 2024 13:33:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 13:33:55 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 08:33:52 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, "Jack
 Xiao" <Jack.Xiao@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix double unlock in amdgpu_mes_add_ring
Date: Tue, 8 Oct 2024 19:03:37 +0530
Message-ID: <20241008133337.88085-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 878a8c42-7249-43f5-8a43-08dce79ddb36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVhkcS91bGxWVkcySDlNMXhXOVJJV2V1ekxNZzQ4WTE4TUZJWlhEL3B0a3E3?=
 =?utf-8?B?dXdmQjJnK0wzVFpibHpuVFhsQXRpZ0RNeTdNdkxrWE12M2lPU3lZdWhLRlIr?=
 =?utf-8?B?RGR4NjVEc014U1VXVjFjSEJBVGNpZXZTbENnUlF0bDI2VkM4OGU2Z2dWd3Rl?=
 =?utf-8?B?TkxmR3VoNEx4dmJCWGxhYzJ2V3R5T05JRForbWtKK0hvL0dQOGhodENDbXpW?=
 =?utf-8?B?VDY1cTFBbmppNVRQcVlZWGhGWVdWc0ljY09ERUhpb0phSEZodDdHVFUzVUNs?=
 =?utf-8?B?OUthUHd2VXJFOWc2SjVmTFFOckJXWERmUytlSENrTSsycGR5MG9WK2ZQZG8r?=
 =?utf-8?B?VGFOc2RvTVAwOHhoeDR3aHcxVStTeXM0QXdhektMUy9WVVF5amNFOUE4Y0RN?=
 =?utf-8?B?UVV0WkdMVGpqQVZ5R1VLOTlCU1g4dFlKTm8yM1ZwZU11L1JVem5TOVZ4ZHBm?=
 =?utf-8?B?bkprUU1wZlVPbmxKT1ZPeHliOWlRRzJiZksyckJSU3pySnFZeHNONUlzRUEz?=
 =?utf-8?B?VEpqcmlmUUlTYUNFN0cwaXNKaXVwZUplODFod1RFRHZtUVBDTmYxN2o0bXlG?=
 =?utf-8?B?WkxVdXNOY3VVVmVvbmlDT3ZPREhZVkF5aVFZNVdrUS82TVB3eWRoVzRMM2o1?=
 =?utf-8?B?dHNTc3JNemZ0VWpiU3pVZlkyM0ljZUlPVzBvVGVtU2Z2WE45M2xGV2NuMnhx?=
 =?utf-8?B?YURJeTVZZ0tuZ21uVjU4akVKMVBsb1ErRHR5RHEyMDhhL3lTMmtSeTRObkdZ?=
 =?utf-8?B?L3psTXpvcU55U2RoM3FTMHJoOTFiL3B4QTlpQzQxcjdBV2NRd1R2Tnord05Z?=
 =?utf-8?B?akVML0paM0VjTUpKb2hrTmF2MHQ4dFQ0Y2ZtU2hxWXhJck52SzdkKzBhUXVP?=
 =?utf-8?B?aXBpcEx5bEdHRkRLS2xRajRDUjVoL041L3RITVNQVHBva0tqNElEbWRYYnRh?=
 =?utf-8?B?UGxtVlFkNzJnWUoxeWwrWi95Nzh3WWg2Qm5IWHFRZDBYTFhPY2tSa0JLWFhl?=
 =?utf-8?B?SEhtQitYTFBUTnNDWWFVT0pBaFp0RDJlRDU1ZTc4aFROSUpHam5JVE9JSHB2?=
 =?utf-8?B?STNvVGxxSDFzYWY1cjdPS0RBdlp6Z2VqQnhEb0c4WHAxNklyUGcxRWhOZnh6?=
 =?utf-8?B?aGIzU0RudlNDeUNrellLUVhHSmtWaGdlUWEyQXJVeVhvaUM0MkZiMnZ5dFhx?=
 =?utf-8?B?eU5EaHVFWUE1NEM4ZmlUanV2eHNFbDdSOTRTWDNGU0hzZ0tHaE5TVGJnb0NE?=
 =?utf-8?B?MDFNaVdwSkZCY1YrY0t4QlVmcjFMeEFwRGM5OVppc2FUWEpNVitpaWdVOFNG?=
 =?utf-8?B?c2tvQ1BEQVlQdnlMN0ZUazBCN3NvOHFESVI1NS9Ua2RqNkN0WWpPdUQzZzRG?=
 =?utf-8?B?SVpEOHBwTmpaOW1icmF6ajA5RENUMXBsMmE0SmNBYnRjU1laSk9kY2RCRi9B?=
 =?utf-8?B?NGU5N09rUTJkdm1lQklCdjNwOEd5Nm5yQlhYN3RiaWYwOXZBbW5JUzJhZm52?=
 =?utf-8?B?UzlUcnpjc2sySHplcU03elFtdS9mN1E0cGJlTE0rS0owOGdNZHhvNzhucUZB?=
 =?utf-8?B?dXd4dkNhaktOTFJkQjZGcG9RRFFBWEJHWmdPTHlVMTV0OGtRUkZRT2dtRUh0?=
 =?utf-8?B?VGVCREJ5SFRnVE5aY2NvYnJhaXhMSmZDQTFOZEJCT3ZaTXNPeEJSUG94SVhz?=
 =?utf-8?B?aSsxNUovamZLQkxHVG1idmt1VVlpWFNiYkN3aEpnbkFGMWFyOXNnSC9vOUp1?=
 =?utf-8?B?cEVxVWtRaURheFo4clptUTJRTnM3Vlc1RVYzNTlScW5iVnd6aUVFS0xBQU1j?=
 =?utf-8?B?c2cvVmtlYk1OVzE0T3o2OURqL3BiS2xXdTEzcHhJYkpmbFJUbUt1Y0dJUlc0?=
 =?utf-8?Q?GRsuENEkt3Ih3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 13:33:55.2027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 878a8c42-7249-43f5-8a43-08dce79ddb36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326
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

This patch addresses a double unlock issue in the amdgpu_mes_add_ring
function. The mutex was being unlocked twice under certain error
conditions, which could lead to undefined behavior.

The fix ensures that the mutex is unlocked only once before jumping to
the clean_up_memory label. The unlock operation is moved to just before
the goto statement within the conditional block that checks the return
value of amdgpu_ring_init. This prevents the second unlock attempt after
the clean_up_memory label, which is no longer necessary as the mutex is
already unlocked by this point in the code flow.

This change resolves the potential double unlock and maintains the
correct mutex handling throughout the function.

Fixes below:
Commit d0c423b64765 ("drm/amdgpu/mes: use ring for kernel queue
submission"), leads to the following Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1240 amdgpu_mes_add_ring()
	warn: double unlock '&adev->mes.mutex_hidden' (orig line 1213)

drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
    1143 int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
    1144                         int queue_type, int idx,
    1145                         struct amdgpu_mes_ctx_data *ctx_data,
    1146                         struct amdgpu_ring **out)
    1147 {
    1148         struct amdgpu_ring *ring;
    1149         struct amdgpu_mes_gang *gang;
    1150         struct amdgpu_mes_queue_properties qprops = {0};
    1151         int r, queue_id, pasid;
    1152
    1153         /*
    1154          * Avoid taking any other locks under MES lock to avoid circular
    1155          * lock dependencies.
    1156          */
    1157         amdgpu_mes_lock(&adev->mes);
    1158         gang = idr_find(&adev->mes.gang_id_idr, gang_id);
    1159         if (!gang) {
    1160                 DRM_ERROR("gang id %d doesn't exist\n", gang_id);
    1161                 amdgpu_mes_unlock(&adev->mes);
    1162                 return -EINVAL;
    1163         }
    1164         pasid = gang->process->pasid;
    1165
    1166         ring = kzalloc(sizeof(struct amdgpu_ring), GFP_KERNEL);
    1167         if (!ring) {
    1168                 amdgpu_mes_unlock(&adev->mes);
    1169                 return -ENOMEM;
    1170         }
    1171
    1172         ring->ring_obj = NULL;
    1173         ring->use_doorbell = true;
    1174         ring->is_mes_queue = true;
    1175         ring->mes_ctx = ctx_data;
    1176         ring->idx = idx;
    1177         ring->no_scheduler = true;
    1178
    1179         if (queue_type == AMDGPU_RING_TYPE_COMPUTE) {
    1180                 int offset = offsetof(struct amdgpu_mes_ctx_meta_data,
    1181                                       compute[ring->idx].mec_hpd);
    1182                 ring->eop_gpu_addr =
    1183                         amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
    1184         }
    1185
    1186         switch (queue_type) {
    1187         case AMDGPU_RING_TYPE_GFX:
    1188                 ring->funcs = adev->gfx.gfx_ring[0].funcs;
    1189                 ring->me = adev->gfx.gfx_ring[0].me;
    1190                 ring->pipe = adev->gfx.gfx_ring[0].pipe;
    1191                 break;
    1192         case AMDGPU_RING_TYPE_COMPUTE:
    1193                 ring->funcs = adev->gfx.compute_ring[0].funcs;
    1194                 ring->me = adev->gfx.compute_ring[0].me;
    1195                 ring->pipe = adev->gfx.compute_ring[0].pipe;
    1196                 break;
    1197         case AMDGPU_RING_TYPE_SDMA:
    1198                 ring->funcs = adev->sdma.instance[0].ring.funcs;
    1199                 break;
    1200         default:
    1201                 BUG();
    1202         }
    1203
    1204         r = amdgpu_ring_init(adev, ring, 1024, NULL, 0,
    1205                              AMDGPU_RING_PRIO_DEFAULT, NULL);
    1206         if (r)
    1207                 goto clean_up_memory;
    1208
    1209         amdgpu_mes_ring_to_queue_props(adev, ring, &qprops);
    1210
    1211         dma_fence_wait(gang->process->vm->last_update, false);
    1212         dma_fence_wait(ctx_data->meta_data_va->last_pt_update, false);
    1213         amdgpu_mes_unlock(&adev->mes);
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    1214
    1215         r = amdgpu_mes_add_hw_queue(adev, gang_id, &qprops, &queue_id);
    1216         if (r)
    1217                 goto clean_up_ring;
                         ^^^^^^^^^^^^^^^^^^

    1218
    1219         ring->hw_queue_id = queue_id;
    1220         ring->doorbell_index = qprops.doorbell_off;
    1221
    1222         if (queue_type == AMDGPU_RING_TYPE_GFX)
    1223                 sprintf(ring->name, "gfx_%d.%d.%d", pasid, gang_id, queue_id);
    1224         else if (queue_type == AMDGPU_RING_TYPE_COMPUTE)
    1225                 sprintf(ring->name, "compute_%d.%d.%d", pasid, gang_id,
    1226                         queue_id);
    1227         else if (queue_type == AMDGPU_RING_TYPE_SDMA)
    1228                 sprintf(ring->name, "sdma_%d.%d.%d", pasid, gang_id,
    1229                         queue_id);
    1230         else
    1231                 BUG();
    1232
    1233         *out = ring;
    1234         return 0;
    1235
    1236 clean_up_ring:
    1237         amdgpu_ring_fini(ring);
    1238 clean_up_memory:
    1239         kfree(ring);
--> 1240         amdgpu_mes_unlock(&adev->mes);
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    1241         return r;
    1242 }

Fixes: d0c423b64765 ("drm/amdgpu/mes: use ring for kernel queue submission")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Suggested-by: Jack Xiao <Jack.Xiao@amd.com>
Reported by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 984bff25cfca..83d0f731fb65 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1200,8 +1200,10 @@ int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
 
 	r = amdgpu_ring_init(adev, ring, 1024, NULL, 0,
 			     AMDGPU_RING_PRIO_DEFAULT, NULL);
-	if (r)
+	if (r) {
+		amdgpu_mes_unlock(&adev->mes);
 		goto clean_up_memory;
+	}
 
 	amdgpu_mes_ring_to_queue_props(adev, ring, &qprops);
 
@@ -1234,7 +1236,6 @@ int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
 	amdgpu_ring_fini(ring);
 clean_up_memory:
 	kfree(ring);
-	amdgpu_mes_unlock(&adev->mes);
 	return r;
 }
 
-- 
2.34.1

