Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEC1C5B549
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D320010E802;
	Thu,  5 Jun 2025 01:46:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="obqY0FiH";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B374110E7C6
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/fW1OLvx+Cf1BbdREmRK284Mfwdmhii5RkDKl+86Un3tJ0gILKBbcT3iowJKHdx+nGk4q9vq0Bu3Gp7OoSYk4rawqI/SvubGBa35RHQ2d5ujmDZX2i4zamiHryng2ZwF62XECPIsHmuw561NNRwszDRiHEk4eRnbMAt3jf+7E23VOK7jBt9II9wPde3f/IS3JLU9vWdCxd2arO0xqz6tCNy2s91CvOcDNsC+iG+6Yo6gyxgyILfSifHKniJ4y+zZzrcaE4LPBqk0SpOiuom2svL9y9ucNjtqy1FJOoo9/ph1D/FmFdIEeXTTJP27nfhkThu2ggpbwZtx5dFvr9d9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGaH+O6mg2HZ9ro4cxp+kByD0QcRSzQiXkYr3cOLG+s=;
 b=Hbw7tbSYfXFJzduodmmOgqwand9cCJLHi//6bUWZIZd+7x3kptpTxF20H4DsDIVAETWEL03hFPDvt6hDfdfiLbYPNjPzu4jTKhb8rU2PGM/lfPsTiyBNzerAy0nkNYjUUe0j4cb9cFSBiW5fv/cVwTeL43lJvOMhUHRQctxTAZWf4Wej0+kwjwGmSaZdBiMeuZ/szdTUe75JedORNT1Wh7P9ZdghL6gAP+lh2g/SW3F6hX+pu2X4EeKgodntS/qPfHhTZAtZI7uhhPjvT9271Vw9S/IibUyXBcROr+6xBAjdnjLEMDtoKZPkQTsjx+kFJD7Aj7M9s2UVjYTje1lGWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGaH+O6mg2HZ9ro4cxp+kByD0QcRSzQiXkYr3cOLG+s=;
 b=obqY0FiH8wFtjGX/DvbfKIzCMj3h9g3vnHw83tGFwo6g/uG90GRxibhGeT6tZ3ndvAGLueJr3jAOpBm2g1pRNb5qNlpivIMOb7IPUSVIwQaJd3J51V/l/QgyK3INCRCHayPWwNnyCx8a85iDfSjmd3L8y1N8W3AilKdgj3r4bmM=
Received: from SJ0PR03CA0148.namprd03.prod.outlook.com (2603:10b6:a03:33c::33)
 by DS7PR12MB9503.namprd12.prod.outlook.com (2603:10b6:8:251::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 01:46:22 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::42) by SJ0PR03CA0148.outlook.office365.com
 (2603:10b6:a03:33c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Thu,
 5 Jun 2025 01:46:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/31] drm/amdgpu/gfx9: drop reset_kgq
Date: Wed, 4 Jun 2025 21:45:34 -0400
Message-ID: <20250605014602.5915-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605014602.5915-1-alexander.deucher@amd.com>
References: <20250605014602.5915-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|DS7PR12MB9503:EE_
X-MS-Office365-Filtering-Correlation-Id: 3907e669-5b6e-4a62-2631-08dda3d2c661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OSinnnyf5OWvefxwCZAG/i1gC7gNvRploF7IzhcaZulw07Ftd3RaCNSAAAO/?=
 =?us-ascii?Q?8HUJlgNyGmgPacesnlU5IyJdnzrkRD9JdRXwfccxS84apg/nmfHmv0tAWvKU?=
 =?us-ascii?Q?2Pgt9IM+V6WYih9gJVx7z9io853yG6AmBxl1S99Z85NdQr9uno3NBlSaBsju?=
 =?us-ascii?Q?IDaNTPPuS1nMgE4RCVqAdubOS2CD5ziyrjqYWW1uc81OxTm4DL/Kia/PkPtO?=
 =?us-ascii?Q?pZ4IaqxFtwk6ofx30pRxOohsdS2OcNis6/KGbSKQbQhgfZHfYh3Eqg8AOApo?=
 =?us-ascii?Q?+14piCoaNAVqO/+d3ZIwIsXwHsUEaCzriUwkaZFx3jFWjP1XSXNSoOCHbwm5?=
 =?us-ascii?Q?pzRuuYbnjS3ZP36ruUn0YPnLbb4MX2TnoWAEPXMqUer/oE7kP2bxKJ/tac7Q?=
 =?us-ascii?Q?9L2bCqszLYeUnG72qdcC+po/LdpZRKvk7AuHvN6H8GeaGNpv3Ig+dnsoEY9y?=
 =?us-ascii?Q?ABLLqpC1YOLbRKlDJWREKS6ztrsQsvCtHXx+GXOG2f5+yMW/7NbqPclS1fYQ?=
 =?us-ascii?Q?PMVMioJchtOKSewZjJQbopRjjfBtOyqQKbVkN+Jd6YPjzq+o8K7EkU3YH+2i?=
 =?us-ascii?Q?mkF9v2BPAR5YhrJeP1dUHrgwwAckc3yR/Jo2sz9azmTatqc/vsEijOhBHNzi?=
 =?us-ascii?Q?WnNy8/nT1MVweGEr8xj2rCJ8gSyXLZSFBAKej8tiYLLbdJeKjgcyrm+QJtQ7?=
 =?us-ascii?Q?PtIH9+hcgvSyHEroH+oczvPSbxYa5cVwtCgv9Ixn6ct3lsJPSEk3J8i/QgpH?=
 =?us-ascii?Q?iihvp8n5KBD2vH7onJJiGb3rFX5JPgPgkCi4OXGyQpHr5Q9ldFL50LV9Ouf+?=
 =?us-ascii?Q?zbLd3EscsWFfLTyAhx0kZQ012q38OTObfE7Fv/KTlsJiwQ37C3f2h9Z2tpG8?=
 =?us-ascii?Q?vTSA1Uf+70hhOjSqXCXqdHozQIXvo8b2c983qsm3iIXq3H5KleXYrOeDYHN8?=
 =?us-ascii?Q?3RjtRLD6KVRr2jIl9LLwRnnddeFrpVS70A4MqFb0cNZXxxnnw5Wktc4hUwpw?=
 =?us-ascii?Q?aeKQ/Gx32UPT6dfQuE3fkbGSEsIaG70olbKivuQudViU+VTzf6C83ua6K2Bt?=
 =?us-ascii?Q?PiFkuqmV0mYMudQjh/wjgNq2rMFstXaYcfwSQKnYjiHGBxbLD62FYT2gbk56?=
 =?us-ascii?Q?Yi9sIi50LLDoYGymkOGTqYTf+6a9oGS67RHOLyFflo6ZJCbiyIILxxtfaYv2?=
 =?us-ascii?Q?lXnjdnbxXjUMHp7p+H3pkkln13lCDXXMyVvwHHUaYkJyfux5kazCsKcXpoeL?=
 =?us-ascii?Q?BAUf/D4Wd9WGDOoiB7RStz8K3UYPJetg7X70z/zvMUSeMFiBdSo4oluAaI7r?=
 =?us-ascii?Q?dJesChFl8EKT1WlZ6DKcOmhtD39KvQmF2BOFByEyeWhv3PQrPZdaKhni2pHm?=
 =?us-ascii?Q?v/cKXBexuSx6rHXuZe3P3P8yAx75y8El2mwUsuNZ3hY3mQ74SBNTy+4XzbJF?=
 =?us-ascii?Q?W4ocTqnJcoHPbrPs+XaQVvd57fV3WMehBtVwE8dqApA7hCs0Fw4ntNeZPFUT?=
 =?us-ascii?Q?IrWALCLAeJm6LP7edIogTZqDIvZqJMJSMbsr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:22.2463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3907e669-5b6e-4a62-2631-08dda3d2c661
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9503
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

