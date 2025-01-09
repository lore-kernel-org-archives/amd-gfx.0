Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBA5E77199
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 16:58:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED32C10EE3C;
	Thu,  9 Jan 2025 16:58:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rrTCLPJm";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83AB810EE3C
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 16:58:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r11MAyKnAC/vBpXjX9noJj3xnCDKsYgbKAsMq7g5YRSk3Grd+COBILG5fzNr0QoQMgysvpelC0tMK8DD0H8KkN10G9BEplPrio90EQTUk+YCSkgaJy9fe+sC0IzoVkiF3AkhP5YWCPzRW7JH7aTM67y9hoGtiaB7ArTRA8CydCbtzBMuqGUiIqjDxxFlRYAMIaMonOLhczkpd0T6j3mE9IZzY64SGRdRmPQt0fesgZVEl/5CUNde0ugPzWS+5I9RyUTqyI0I8QhFPzhde9i+EQaF61GzDHbSwQMR4120r7dZxFcULwyitzpBb7SlE8hueXRn5PO5w0gn6ltKWUQ/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bD0HYFDxFH2YEU//7ppCT5l1LFeGiqYrVk+JeDD4kDQ=;
 b=etyliP86FKh+2uC609PrvbTtaDNNg0Dr6hKxDsQ6lhQrCDutm5U3hqfRbvJc/E9vunf4kBy0y4Gdio17STUzPcRGJtn86JlDFvIK81Of406vTjVDldjmOmKoclVpknjcyPjaonMBlCDAwXWW6PrrnB1GzNuMc4XMLhoXHJ/YNrfvp1BE1xjcqJaBXCdloNzOaxm2gfdPg9SVrdOtYX2RIFmg3SaTTLDKKs3XSTVs+wV3zmGE3OLRENsnFArc2anx3ZDHMw4D7Z0pqKVULSQ8P7oT8f8x2SY23jtyw7hjIOSmMh6UOirH5xEETFtEZwmXj8GY/es8Qg4R4cd2trejUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bD0HYFDxFH2YEU//7ppCT5l1LFeGiqYrVk+JeDD4kDQ=;
 b=rrTCLPJmPPe5dDZjhH34714ASF3CPG3dRhgVNeTvPegp32FqHfq3o9u4yr6LdQxYdFlGaUBxYSelj2J13fraFy58K9JLTQudVOpf9X4IoFv/lmh74YIk/uTrni3TyJVBE/wDQmM+xtdhnaJnmixC3E/OvXw/Lx7WUhn39URTxW8=
Received: from BN9PR03CA0954.namprd03.prod.outlook.com (2603:10b6:408:108::29)
 by CH2PR12MB4214.namprd12.prod.outlook.com (2603:10b6:610:aa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 16:58:26 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:408:108:cafe::ac) by BN9PR03CA0954.outlook.office365.com
 (2603:10b6:408:108::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Thu,
 9 Jan 2025 16:58:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 16:58:25 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Jan
 2025 10:58:24 -0600
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Pak Nin Lui
 <pak.lui@amd.com>, Simona Vetter <simona.vetter@ffwll.ch>
Subject: [PATCH] drm/amdgpu: allow pinning DMA-bufs into VRAM if all importers
 can do P2P
Date: Thu, 9 Jan 2025 11:57:56 -0500
Message-ID: <20250109165756.26401-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|CH2PR12MB4214:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b66c02-a427-4681-0888-08dd30ced577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aU4vTGpZRVlTOEhQTFMwL2swSmNOclJ6bjYwdU9rRTdsU1JFYTVSN3JnSWtQ?=
 =?utf-8?B?VFB3dTY1VnhPRTJHZzZ2N1NvSVdhWng5M2lGMXJ1WFlrQkZXak1DVHJXZU16?=
 =?utf-8?B?SXJmejZhS0J1VlREczMxcnpXY3BtSm1JQ0Q4Y0ZLLzlJelVxejJac0xacDhM?=
 =?utf-8?B?UXFZd2hTUktraHRDK25Wam5JakxEK3I0UHl5cml6N3BhOU9ZVW5XS0V6cXVw?=
 =?utf-8?B?MUsybzFwT1l3a3U4MFkrV1dOQ2pVZzVCYlJSVnpaS0lxaENEZWN5NHpoWEIw?=
 =?utf-8?B?STNFK3NvNlAxSWNlTnk5QzNuUy82SWFEa0htcEJWNitJWGxlL3ZkUHNXRnNN?=
 =?utf-8?B?S2E3clFTUzFoSklrVGQ5Vk1RS3cycW8wSmU3QjN6c3BtT3ZKT01ISGZRbitP?=
 =?utf-8?B?eURlbUF5cnQvaTNBLy9qODlTMlBSOWFGSTF4QThFRUJFbHVHK2p5M2pyY2dj?=
 =?utf-8?B?STd1SUVpUEFGYW1pY1kzaVVKUzNlUjJUWUtldDVMUkdUaW5HdVNqRXRua2dK?=
 =?utf-8?B?ZTRtZkJZMldLQUl3V0s1ODdNV0VtcW42NGNxVWYrRTQ5RlV4T0FTWktQeXcy?=
 =?utf-8?B?aE41cXczUHFUMm1jU00rdkduL3QrU2VVSEY1Rjc1bElyNDJBWE9vdmJQS1RP?=
 =?utf-8?B?QXVGaVo5Vk9PbUN2WmZJZ1lEV2FXeEhWbVlWY3N3dHZIeW5CQXZYWUlsYkxo?=
 =?utf-8?B?aGhlcERhVUd3WkJZQ0FVcDgwZWNpTEZqZjVtSXpVby9yZGdqVVBFalE1N0dD?=
 =?utf-8?B?aytSQ0Z1NkxpT3NObzhzQy8rSi96Y0l2TEpML0dlMXliSW5DaHR3UDBad2F0?=
 =?utf-8?B?dU5YUXE4ME92eHV2ZkRDK205Y0xhRStWZnhFa2RlUVhLTjM5Q2hFZEdEcUpw?=
 =?utf-8?B?V3lYd09aTXk3V21jY0l0WTRYZHpBSUlhallic205azZjVkxoMysyVm1oU2h0?=
 =?utf-8?B?NTZVYVB5emNzT2kxTDlIRnJiL3lkc1VwOWdGdXNqOERjeDFMK1JDSHU4WmZL?=
 =?utf-8?B?eER1c0hIMER1aEpoYzNiOUJXVUpwbEVKQVFLTjBuaFIxZzhEYWlmOVJwRTZF?=
 =?utf-8?B?N3ArMkVHQ1VQemU1M0RTZE5rSWZ2M25ZMUpZZ0tMb2V3V2ZxS0x6YjM0N1ZJ?=
 =?utf-8?B?dXhoZG40ZE5ERlArT1ZqUmorZzREU0dYbXlqWGdaOUxidlY2QnhXYkpReXpk?=
 =?utf-8?B?VlpDQ1VKdE1kelFjN1BQYzJOYWtIRElvNzk5M0IzWDErZGJwTjFyeVlCT21t?=
 =?utf-8?B?UWdIVnZSU1NGam13SHdkVHJ0Y2RwRFdpdE54S0Fka3dHMEZiMzBrMERpVzB1?=
 =?utf-8?B?TzlsUVRQVHhGZHN3TmRabjVwdUFES3BQdXR3VjlhZFRLYmZxc1ROYkJVWVE0?=
 =?utf-8?B?bWJBZDYrTTFUbWlKNGtjTGJCTzl4blpWNXNGT1phSW9tNGtUTE1YdCtCZlRS?=
 =?utf-8?B?R0xwN0NDaUpUcjEyTStpajM5UVZDaGJIdmxUSHVEa3U5QzlzSUxxZG9BSUky?=
 =?utf-8?B?ci9HKytOSy93MnpRN1kwclJzMTBKK1IwTmNFODRSTTY2ZHhURnZISmRoWVpJ?=
 =?utf-8?B?dGtyNDAxWHRWbG1md3Q3R3BWbWR5RVBFVUxQSFNlamVuWXFiL3Rmc0RQY3BE?=
 =?utf-8?B?RUsxK2paT3lxYkx6MkQ4eHBsa0V6Qm5PZFF2ai9qdEtIZFlpWWRRcDU1WXRR?=
 =?utf-8?B?RzM2SmlRTTFNa0QwdmVYM1ZtZjhLc3VXckM3WWltMTNjMXpDbWlWbkZ5VC9T?=
 =?utf-8?B?d0NYZyttc2thV0d0T0QxZmNSL1RqU2NzSzZTQzJZeG5aekVlR2JETTZXaXhI?=
 =?utf-8?B?cVdZM3lJWlVIZmxEaUdweDZEQmR6QWRhbkZObDdlcDJESnMxeCt0MytrRkt2?=
 =?utf-8?B?M0FsNmdpYWlRMHA1ZGp2azE5S3RRVHpsRzhzVVlCa0pNSjhwTEdxUUF5azhk?=
 =?utf-8?B?V2FyZGF1bVdkV3hjVlE1VWNwZ2d4V0wxSU1TSHNSLzVCQlNDeGE5cEJlemdJ?=
 =?utf-8?Q?dnJTSKggS37P8geqmOb43m611zUA3s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:58:25.8597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b66c02-a427-4681-0888-08dd30ced577
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4214
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

From: Christian König <christian.koenig@amd.com>

Try pinning into VRAM to allow P2P with RDMA NICs without ODP
support if all attachments can do P2P. If any attachment can't do
P2P just pin into GTT instead.

Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Tested-by: Pak Nin Lui <pak.lui@amd.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 25 +++++++++++++++------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 8e81a83d37d84..83390143c2e9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -72,11 +72,25 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
  */
 static int amdgpu_dma_buf_pin(struct dma_buf_attachment *attach)
 {
-	struct drm_gem_object *obj = attach->dmabuf->priv;
-	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
+	struct dma_buf *dmabuf = attach->dmabuf;
+	struct amdgpu_bo *bo = gem_to_amdgpu_bo(dmabuf->priv);
+	u32 domains = bo->preferred_domains;
 
-	/* pin buffer into GTT */
-	return amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
+	dma_resv_assert_held(dmabuf->resv);
+
+	/*
+	 * Try pinning into VRAM to allow P2P with RDMA NICs without ODP
+	 * support if all attachments can do P2P. If any attachment can't do
+	 * P2P just pin into GTT instead.
+	 */
+	list_for_each_entry(attach, &dmabuf->attachments, node)
+		if (!attach->peer2peer)
+			domains &= ~AMDGPU_GEM_DOMAIN_VRAM;
+
+	if (domains & AMDGPU_GEM_DOMAIN_VRAM)
+		bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
+
+	return amdgpu_bo_pin(bo, domains);
 }
 
 /**
@@ -131,9 +145,6 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 		r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 		if (r)
 			return ERR_PTR(r);
-
-	} else if (bo->tbo.resource->mem_type != TTM_PL_TT) {
-		return ERR_PTR(-EBUSY);
 	}
 
 	switch (bo->tbo.resource->mem_type) {
-- 
2.34.1

