Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7F2D35664
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 02:21:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7166C10E607;
	Wed, 28 Jan 2026 02:21:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E2YqUsCI";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010061.outbound.protection.outlook.com [52.101.46.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99ED210E1E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 02:21:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8hWT4fU8vDo4rmL793xwHzsmhfhI6/0zYdH4ImNhyJSNmiVExmSVfcgP/zmhzsqcX5EXYkFGuWBWXFn/6gDrd8P55yGJtXznZxfJWPA+6CQd3UwDML1B0N0s+B6DMpQv9zmslcU+H6hmMUMycNLX9sQRA2rhvn59vRxhUjOnXEDt8FwVV5OINDWCGt3fbiVI0S46DsgCaEh3fkw63ODfBdXxfjnXs2o5Za4bKibC8R3o+689TH2nSq3V1WJzGZjJVtL+hlg+dMMMrycdXIhG4zQ1+NUmYFBmewP70IP7vyFX0hWWdaA/gsV3PJd8FCt6UV/0Qh8dVHsRH9aigxjug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MmYHMEN/9z+iqc/YQUmj8GQDZFXFsvMn9HNfRbduac=;
 b=jvS12DWo4pvkOQm6jASTSMIGZ9fjyTCCOktCe2d0f6a7E2BQ4svRaaI5LavYBY4ucZeFPo7G5Ro/KnrR/MvFcOYjgM85ADSKtzG0LyTam2FPyXlk+2JjQARiCdDneytP2QvFav3KskJVEY2KjAvfjN7vieWbWrGHt8igEopkaE4vmchDyVlJuIpe8hmubrzHbceoHuABGJCHtSOTRbREvjPj3zvNj/zK8uAzQDzpSdu6TDF+5gBEUxrsO0UuOQdQtxXolckY5t1guf5xJBOtWv/E/kIZ/axzsmSVS2cSJTM7gqIHts3zTP/EgaHkrRhmgNP0Sm74RUKA5Rqpyyxvpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MmYHMEN/9z+iqc/YQUmj8GQDZFXFsvMn9HNfRbduac=;
 b=E2YqUsCIvGXniyb7Y9NJ2AJsvR2cQ24l5e33cWGNaLwrIX493C0809us3D1xaQvyGCqhI07V5BNEKVBOigMYiVaRkyQS9kQ5l1+oMRlE6kGb/psWXQh8ndTttum5CQDw0acLwy4rW/76kMJ1qCoqi8ygm2EtmmOeRIvvIHYfzPY=
Received: from SN7PR04CA0020.namprd04.prod.outlook.com (2603:10b6:806:f2::25)
 by BL4PR12MB9721.namprd12.prod.outlook.com (2603:10b6:208:4ed::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Wed, 28 Jan
 2026 02:21:24 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:f2:cafe::e7) by SN7PR04CA0020.outlook.office365.com
 (2603:10b6:806:f2::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 02:21:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 02:21:23 +0000
Received: from lang-cezanne.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 20:21:21 -0600
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, "David
 Belanger" <david.belanger@amd.com>, Lang Yu <lang.yu@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: Use AMDGPU_MQD_SIZE_ALIGN in KGD
Date: Wed, 28 Jan 2026 10:21:09 +0800
Message-ID: <20260128022111.281082-2-lang.yu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128022111.281082-1-lang.yu@amd.com>
References: <20260128022111.281082-1-lang.yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|BL4PR12MB9721:EE_
X-MS-Office365-Filtering-Correlation-Id: e18bd83a-6a50-49a6-73da-08de5e13eec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gv9/oQ8l7uNYzJS0ohXtX/xtDpvPJgExQQSsHKcVvu7we78s/41Bpd5S4CtG?=
 =?us-ascii?Q?i1A164FRZy3xvG5kFMcDdfao3qrGeXcKfkW5xKydaTLSRDn+NGPS9X7F1xNg?=
 =?us-ascii?Q?r0ooXTCwxd/u25v+KyV7o+AnnWG3bFv59tSQC27TCfSPg8LDj7Jf57eNMK3r?=
 =?us-ascii?Q?C1gtxWzRclwjpLacVESjSTbQ7Js+uTl07pXHnbhYVW9ssGvppPbMKQd84boX?=
 =?us-ascii?Q?LsQYosr3zoINDFXWhsaiEAaDu4PlDeHUo6Nf144xW1SFKzdcsq7PLzB7ZR03?=
 =?us-ascii?Q?50t6Rl7de6EiFiREULXgZVFZQ05JqNiMYfIy3uQFfxJFgZCi5zKbDB0w57zw?=
 =?us-ascii?Q?/WPGTEeq3+y6UTVCaQuDY6BiCdEEIY/ial9tJPlXCSPx/FOUBzyGlorU5FBX?=
 =?us-ascii?Q?v0kc0ce/t8OK1+g8+HvZGUXdLyyATbxbh88N47OVlLArH/dr+ucL4tkZRDyY?=
 =?us-ascii?Q?QTFlJmUBor5sP0yYv7LYr7WyZvexxecQRlPufhSyp3PcZfqhJ+KT0LKRr0r3?=
 =?us-ascii?Q?PVn1NSuDsxP4HGLB0SneX3NzL0xKaSn8ePhdgsBjnx0F2oWJ4VKbI581/4Kn?=
 =?us-ascii?Q?OlBDkr7Wt2S19LCc84I9/YUn8HoiB1iX8DO0Tv8/M/NMuRcAeDiKw1JPv1zA?=
 =?us-ascii?Q?tnylA+aD+z6efy9KcuhM2B6n+zi77e2tunVrkLX6BeE3VfqBfqd7AesErg6/?=
 =?us-ascii?Q?ySel87Lkivh+PqU6RJ2lpvcuLJDHR4JiaP/QgiTlQHwqdG2AihOFL006e6k1?=
 =?us-ascii?Q?MOoDQPW2AS7uhBiN6Z5RwwbZ5ujhCeVWa0cwS9jp4sbIe1nCGme0AuHvjVrN?=
 =?us-ascii?Q?yXdZowEUTWN8iypqSVfEHWDqMt+O5vYVTvuD27a7wDZVR3SszoQA1ThApYWZ?=
 =?us-ascii?Q?5M/wkNSuyX3BfgKhoROqty35ed23iiaWi8TIv04bSJSW3EGN+kWgh4cArUEy?=
 =?us-ascii?Q?TUAYwUg4aSMBEQvfoYyAqPa8mpcIVmgCQlxHanUOPvjr5XVGd1TlMmU/jGVd?=
 =?us-ascii?Q?cZU8WxVCmo6//19pmdR2AxheARZlu1M7pW+UcFfeKPJ9Fkaekljby/T4nlLE?=
 =?us-ascii?Q?TijzRfhbK5BaNCAQsjxPXeVtX5HxO/qdk6qD4cf6UviIW29IsnUL+WEd5UIn?=
 =?us-ascii?Q?EAfeULq53iVXuAoUgPTAYaPmYqZ7p32EWqyGZrloB6QsJ/dP8yqE2L08mqzT?=
 =?us-ascii?Q?aP2Z2cCC9cWhN39ffFW/x5we2h3Vmxb43zY6tQyb5tNCqa+SfXHhr5Ea6m/W?=
 =?us-ascii?Q?FZXtqwxPc128TegOyFVWVmSblhJhcluMI9C0Q/BojETbb8YMNBVtPlNkkDlo?=
 =?us-ascii?Q?prESWyAiFJUamlwnSz0axY9YMsAJx3z9WnzKaUuxekMrsm8tf+845XlK3wR3?=
 =?us-ascii?Q?LQHZUQM+SZ2Akisq2gpIG8+umP3aHrJh1BdqT5ofBGUWkcWy929COezDm6eR?=
 =?us-ascii?Q?E3yy2b74JrNr7YobCgQ2kYSn7AwWWhVTmlyKH1DOYTFSxVZaL076wK1rvp6g?=
 =?us-ascii?Q?fNl455BdX8ZlLVB3E03emJePweNAlSnozN4n24bg12z+yRI0+Yfy1oeBTyha?=
 =?us-ascii?Q?rO4MadheDDuRyNpyo0MUf/iQtUwGxidkgwPJKOea8xWpA+m09VKuNcjL1mO+?=
 =?us-ascii?Q?Uwq+F6ICIzSRMGiKi42bpxjmApNOZ93oFXmfyGeWEouEzPtV73bHDe0gcczL?=
 =?us-ascii?Q?02ksZg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 02:21:23.6100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e18bd83a-6a50-49a6-73da-08de5e13eec9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9721
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

Use AMDGPU_MQD_SIZE_ALIGN for both kernel and user queue.

Signed-off-by: Lang Yu <lang.yu@amd.com>
Reviewed-by: David Belanger <david.belanger@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 18 ++++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  2 +-
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 6abe5103a78d..4fede701beb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -385,6 +385,8 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 	struct amdgpu_ring *ring = &kiq->ring;
 	u32 domain = AMDGPU_GEM_DOMAIN_GTT;
+	u32 gfx_mqd_size = max(adev->mqds[AMDGPU_HW_IP_GFX].mqd_size, mqd_size);
+	u32 compute_mqd_size = max(adev->mqds[AMDGPU_HW_IP_COMPUTE].mqd_size, mqd_size);
 
 #if !defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
 	/* Only enable on gfx10 and 11 for now to avoid changing behavior on older chips */
@@ -424,17 +426,17 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
 			ring = &adev->gfx.gfx_ring[i];
 			if (!ring->mqd_obj) {
-				r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
-							    domain, &ring->mqd_obj,
+				r = amdgpu_bo_create_kernel(adev, AMDGPU_MQD_SIZE_ALIGN(gfx_mqd_size),
+								PAGE_SIZE, domain, &ring->mqd_obj,
 							    &ring->mqd_gpu_addr, &ring->mqd_ptr);
 				if (r) {
 					dev_warn(adev->dev, "failed to create ring mqd bo (%d)", r);
 					return r;
 				}
 
-				ring->mqd_size = mqd_size;
+				ring->mqd_size = gfx_mqd_size;
 				/* prepare MQD backup */
-				adev->gfx.me.mqd_backup[i] = kzalloc(mqd_size, GFP_KERNEL);
+				adev->gfx.me.mqd_backup[i] = kzalloc(gfx_mqd_size, GFP_KERNEL);
 				if (!adev->gfx.me.mqd_backup[i]) {
 					dev_warn(adev->dev, "no memory to create MQD backup for ring %s\n", ring->name);
 					return -ENOMEM;
@@ -448,17 +450,17 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 		j = i + xcc_id * adev->gfx.num_compute_rings;
 		ring = &adev->gfx.compute_ring[j];
 		if (!ring->mqd_obj) {
-			r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
-						    domain, &ring->mqd_obj,
+			r = amdgpu_bo_create_kernel(adev, AMDGPU_MQD_SIZE_ALIGN(compute_mqd_size),
+							PAGE_SIZE, domain, &ring->mqd_obj,
 						    &ring->mqd_gpu_addr, &ring->mqd_ptr);
 			if (r) {
 				dev_warn(adev->dev, "failed to create ring mqd bo (%d)", r);
 				return r;
 			}
 
-			ring->mqd_size = mqd_size;
+			ring->mqd_size = compute_mqd_size;
 			/* prepare MQD backup */
-			adev->gfx.mec.mqd_backup[j] = kzalloc(mqd_size, GFP_KERNEL);
+			adev->gfx.mec.mqd_backup[j] = kzalloc(compute_mqd_size, GFP_KERNEL);
 			if (!adev->gfx.mec.mqd_backup[j]) {
 				dev_warn(adev->dev, "no memory to create MQD backup for ring %s\n", ring->name);
 				return -ENOMEM;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 86cc90a66296..4dabcd7c9f5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2235,7 +2235,7 @@ static int gfx_v12_1_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_hqd_queue_priority = prop->hqd_queue_priority;
 
 	mqd->cp_mqd_stride_size = prop->mqd_stride_size ? prop->mqd_stride_size :
-		sizeof(struct v12_1_compute_mqd);
+		AMDGPU_MQD_SIZE_ALIGN(adev->mqds[AMDGPU_HW_IP_COMPUTE].mqd_size);
 
 	mqd->cp_hqd_active = prop->hqd_active;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index f2309d72bbe6..82bff8dc286d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -289,7 +289,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 		return -ENOMEM;
 	}
 
-	r = amdgpu_userq_create_object(uq_mgr, &queue->mqd, mqd_hw_default->mqd_size);
+	r = amdgpu_userq_create_object(uq_mgr, &queue->mqd, AMDGPU_MQD_SIZE_ALIGN(mqd_hw_default->mqd_size));
 	if (r) {
 		DRM_ERROR("Failed to create MQD object for userqueue\n");
 		goto free_props;
-- 
2.34.1

