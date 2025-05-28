Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8F3C5B549
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 17:28:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8571B10E6AF;
	Wed, 28 May 2025 17:28:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jd5m4EsT";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCEB710E693
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 17:28:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ebw6waDmI3AasmbS9CE2gy4SNAr+kqTv7scJOOaxfjQeLYUzoJf00eoKCcenmpdLOFIb3ZcYJ54q8xb7Cjc7mE1+qgPbMepSqY0pfUa/XTFBc00P2fnLzh0/5SLKvqsOS1qFLWfAr/5bqkH8tFK7ww++YGf4QpCR2yE+l5Oh1gzHhQHIi5ARyCprDIW3xPk6tr3JtB3l8GDqlvT+KtnHL6Kfy3wLqsyTkiRXsK/Jv0bJWAj0cZ6zYliBaEahmGkb6n10T74TtReE+cmkbfUiNiRXlaVYA2OD+cdLgqoOXD8f6CIWaFzFp+52gxnpzNAsfQU3lywz/4Y6iOtgcEMUbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGaH+O6mg2HZ9ro4cxp+kByD0QcRSzQiXkYr3cOLG+s=;
 b=lFJxRxysb2Mqj9l8iEor67O2aVW+5gv2n9ZttOwHd269Uxg4UMP4YDoe7LVtMHV+lR1tjuSSNgvQ1jWHKjAk2TDCOmllA0qHcYuBd9IJGnO2FmPXFifrBOgtp3rgxowV+bSBpn6DaTrW1/pRaGE1lk6w9RYL4zgHBs1+2mqiSXWQN9cxHwndvge3FG4YcfWj3BLwqE6C+2HByQxJkuoIGYnp84UJ10BvMqszEEWKW9vVTXpvUIaEsEDUsI8QbnRiKGbIFv5O2JdefHPKpIjCs2bGaWVArkFVQeX2oFbskQOgiItgd1sst58zbDzzXCD2jmWXk7QGy1nfXGOmMgLzCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGaH+O6mg2HZ9ro4cxp+kByD0QcRSzQiXkYr3cOLG+s=;
 b=jd5m4EsTWVy8VT/fxco4deY2Ax5kyGiRz5WcRs7wRNpuqophP/Zdhj6vrG9BJIHgAGBV6RpRcWE6EEawG5utOIfnumc4a9bIH88ozwnz6LVCVbMpHKDLHjBizJyHG5SPFcuKF+ldOQBxk2T7izyY6TSY/zX4rpdMzjcORd0TVSI=
Received: from BL1P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::34)
 by SJ2PR12MB9116.namprd12.prod.outlook.com (2603:10b6:a03:557::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 17:28:21 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::ab) by BL1P222CA0029.outlook.office365.com
 (2603:10b6:208:2c7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 28 May 2025 17:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 17:28:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 May
 2025 12:28:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/16] drm/amdgpu/gfx9: drop reset_kgq
Date: Wed, 28 May 2025 13:27:51 -0400
Message-ID: <20250528172801.34424-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528172801.34424-1-alexander.deucher@amd.com>
References: <20250528172801.34424-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|SJ2PR12MB9116:EE_
X-MS-Office365-Filtering-Correlation-Id: ce5169c9-4631-415d-77ed-08dd9e0d0afd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qL01p7fsKJU++agWku7Vypp3HGvau8fzbbRYX7F6ln26MCBAAqaiIbfhJ3ti?=
 =?us-ascii?Q?guQQTqD9DmqIgwCpmCP2QKQivY1Vruc4xBrWWJWMJBVPNcR3mlcPya9Z7awl?=
 =?us-ascii?Q?i+8+f4ncKCeMCNrm8A2eilVAhWHnFHzspASb5/ybN2g4SijwDwlkzrNKY1wn?=
 =?us-ascii?Q?ESiJ2q9sEFcNQP8YC30LdNUbgsYcXbwlO+3ggMvw7APSV/7H/NsvQ0Hqq8Sa?=
 =?us-ascii?Q?XE4Tbkd/Ahhn2eRlJaI6sloWg0vAWWiKyHuOCfLvY0acXCm8Gk12oWbwyisY?=
 =?us-ascii?Q?p1igJFATOU6nJwhDn88qECpTA70kytJLF56aec3vYiaUMRE+iAXwpqbqHSXD?=
 =?us-ascii?Q?aytjO1nn/jeh9tKtSbAXLQg+8exCe2t2ywyE2e9MZnkhCEk4LktU7XPUXRYI?=
 =?us-ascii?Q?OcJe0CuXtRKeLLIq5pM/ZrJhpOhez11PljavfE0za+Qa7SyC0lMwYMvxmdQv?=
 =?us-ascii?Q?UrJrwMVMd3Z7AfCkJHpaX7PtIwY8FaBG3h32SWxOuu6k7u3UJWBuQSG1bX9I?=
 =?us-ascii?Q?rLkIn7VmoeJhu9qcJrNND+3nbynsPzm+W59IRGYTKAqhImczDLAgqtYOEWbA?=
 =?us-ascii?Q?tCGiB6GeG+SHrXFJkxcERYfHsk3Jd3nrc07SJ4IOKwWIENweV6B+6l3q8q9T?=
 =?us-ascii?Q?QTVm9EcHVJyJoQ43+ol7rZYklBjOUg8k9OVIQkQl+M9OnGdngjdfxez68MH6?=
 =?us-ascii?Q?YGgX9oVD99kK/nHFmChmZgP5cl7GtNYG/ofY8Y37ertEM3lAB4mOSyhEDmjl?=
 =?us-ascii?Q?7it8kK9JLFqHPwGPXpSWwy58VdWZcjf/GoAP/1H45rdwXe6WL4qwiQoZ5d88?=
 =?us-ascii?Q?AWTpUV9NPDORvABX+Er1APFwce9oFtc4375r8rHdV2IrMT8eAgR7OAp2uqkh?=
 =?us-ascii?Q?d8jAziQhjLjHIxz9Q5t9w+EWwq+LTroHfqdWw6mG7YS9EvN5kM7aq6u4UuyR?=
 =?us-ascii?Q?CgcsbQQ9eUqRDDC5SX0NhvpAXeH0uPlQIoIPDuIhUV0tPEHRe5t5owzatM8D?=
 =?us-ascii?Q?VDwk9yvh6VGOGzfXZT6/GJvF5Trau2enP3MfQZKELX71FyQMUs+KGE2xDENh?=
 =?us-ascii?Q?gsApz3fsqZv+ICIcoi+gsSIw7Oq3ZNh/JdK52AUq7oT46bumq1n00GA9sMHc?=
 =?us-ascii?Q?Tzb+RlwP9y7nCn+2RsJAEM3CDTdRtDCnNgHyA4PewAlVMCbaraoojMovypqk?=
 =?us-ascii?Q?mfaAy5jvPzvURmaw1UrluUmez62+BKn1pL3nB51ve9vcSkp8eRb4HuwZ70WE?=
 =?us-ascii?Q?Jbe05XdK0Ela6ctpg7nh+zRB+zPFKLV4fYUGOKSL7r9F1LeSZTWU+u61ifA6?=
 =?us-ascii?Q?P8OUiODvgeZOw92O2i6zcD12/SfDlXI8lnzPu2WU5YibH8j8vyB7kDqm7Lfc?=
 =?us-ascii?Q?Drh0oNr6+IGFgqQtazZ9zO3O+xGF00dMM0ZnNL5kBuGPgcnKZ45j1aQWVCeU?=
 =?us-ascii?Q?44YYbvwCjx7q6Rdb0+el6DkPCM4COePWGZzJ8DNkM+cRCVOipsjmarZIpTlB?=
 =?us-ascii?Q?8oElkB/am8VDZponKWCacNPagB14TE+ZTZdj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:28:21.2026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5169c9-4631-415d-77ed-08dd9e0d0afd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9116
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

It doesn't work reliably and we have soft recover and
full adapter reset so drop this.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 46 ---------------------------
 1 file changed, 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d377a7c57d5e1..d50e125fd3e0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7152,51 +7152,6 @@ static void gfx_v9_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
 	amdgpu_ring_insert_nop(ring, num_nop - 1);
 }
 
-static int gfx_v9_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
-	struct amdgpu_ring *kiq_ring = &kiq->ring;
-	unsigned long flags;
-	u32 tmp;
-	int r;
-
-	if (amdgpu_sriov_vf(adev))
-		return -EINVAL;
-
-	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
-		return -EINVAL;
-
-	spin_lock_irqsave(&kiq->ring_lock, flags);
-
-	if (amdgpu_ring_alloc(kiq_ring, 5)) {
-		spin_unlock_irqrestore(&kiq->ring_lock, flags);
-		return -ENOMEM;
-	}
-
-	tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
-	gfx_v9_0_ring_emit_wreg(kiq_ring,
-				 SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), tmp);
-	amdgpu_ring_commit(kiq_ring);
-
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
-	r = amdgpu_ring_test_ring(kiq_ring);
-	if (r)
-		return r;
-
-	if (amdgpu_ring_alloc(ring, 7 + 7 + 5))
-		return -ENOMEM;
-	gfx_v9_0_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
-				 ring->fence_drv.sync_seq, AMDGPU_FENCE_FLAG_EXEC);
-	gfx_v9_0_ring_emit_reg_wait(ring,
-				    SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0, 0xffff);
-	gfx_v9_0_ring_emit_wreg(ring,
-				SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0);
-
-	return amdgpu_ring_test_ring(ring);
-}
-
 static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 			      unsigned int vmid)
 {
@@ -7477,7 +7432,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
 	.soft_recovery = gfx_v9_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
-	.reset = gfx_v9_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v9_0_ring_emit_cleaner_shader,
 	.begin_use = amdgpu_gfx_enforce_isolation_ring_begin_use,
 	.end_use = amdgpu_gfx_enforce_isolation_ring_end_use,
-- 
2.49.0

