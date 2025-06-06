Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1AEC61DB8
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4C9110E8DC;
	Fri,  6 Jun 2025 06:44:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2ZayDOsb";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 511AE10E810
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:44:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYx7WePLw5PfQ8Tkm9zoYYT1Wi0D7KCKUNNU3Sj41glajy8OF03gTVtQujqvgsABN5F2o9atpu3JBZpumOctZoRbjWgNnhVNvVkpFocbV1F9GIyPQsM2zJlDvpjn3nTnfaJB3LBBMrfkeTJI+R37FlJuntdw3Y8pbfIADpqaYsthdVqLAq/82KcWweBTAAUWfFsfg7qOnflkOFAVjkuijY5EADKtS7ypPM4fZUiTvHsxgtGY/w8iCc0C5KGlkcljSrEhKUY413hzxEPAzt5BMdX5OBRkj3YiTNb02zRyMFUrPVJ+vi/EqbFxmpA2vBu2MveiN7ID0YI4E+5uueyipQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGaH+O6mg2HZ9ro4cxp+kByD0QcRSzQiXkYr3cOLG+s=;
 b=MdstuJuL8idFfbrmIpqDSMxv4DEAa60uWLDQBTxV4DfOtQvYXgwx39KZB8EnmJ6aji96gS0WullFlDJdo5bkTLR2Ubtxqs2cKHRUzlo2xjjBHF7QXNcqcQITZEajykFArjsTNqg2N6QiQpVVFHWAfqg4UFjnaqhj4FJvA6JNTLgxsd7ZUVI/SLMA+LrmcIPrqWFLOQjiOqhjJl4auXBcrAwlLMLO403BLR/t+bonAv1hIEvYp49fCRDiYbfwI6Z/DWwsKg9boO2gqtq3Pm4jDPqZ1/ERFO9GqtBtBJrqW1Rc7GrMfhAyfgGMT+qVTOd7O8sGbwzHaaMvHqr8Lv8xRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGaH+O6mg2HZ9ro4cxp+kByD0QcRSzQiXkYr3cOLG+s=;
 b=2ZayDOsbaeUAzqp1ExJTd9Or3eiQXE8jydsW/qRjd5qAP2ptEihN6czI0dpYOepcO66shCdJ7xfoQ84+N3eGWhIj8Y6fvS4RD2cgVgJ5rThm38GjC7D6oLosw8mgAMo0ufYuMLcHFrAEwz7fTO6V+GAAmxhOq75+7AHRd5HwuI4=
Received: from SJ0PR05CA0081.namprd05.prod.outlook.com (2603:10b6:a03:332::26)
 by DM4PR12MB5817.namprd12.prod.outlook.com (2603:10b6:8:60::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 06:44:13 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::56) by SJ0PR05CA0081.outlook.office365.com
 (2603:10b6:a03:332::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.10 via Frontend Transport; Fri,
 6 Jun 2025 06:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:44:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:44:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/29] drm/amdgpu/gfx9: drop reset_kgq
Date: Fri, 6 Jun 2025 02:43:29 -0400
Message-ID: <20250606064354.5858-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606064354.5858-1-alexander.deucher@amd.com>
References: <20250606064354.5858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|DM4PR12MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd9b3b1-3d8a-48ca-f15f-08dda4c58cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sodxNayGi0E8TyqCBHQ4gTDAVo9gnbEeqcLvx17RECzgfikLsUQZUfUIXiHF?=
 =?us-ascii?Q?iJ0/9E3xq51IK6TEN6TLK+Pr6Ehmyk6rrtfqbjjPUh+N2a5U73XRxy/SNAIZ?=
 =?us-ascii?Q?k2mrLH4wBokKYMvU9oH4F921BUs1hXSrmG3fD4ICo7+SbydePoyfkYHl18WB?=
 =?us-ascii?Q?lEdFghkUBMPB1Kf0BqDh56/bHLnzBevCkPWcsL8JdBXExiPpuYGfHn4tGZzd?=
 =?us-ascii?Q?MscylWdf4hSYoVBcHdyepR+L/8anUibwuJJWE5fD4myAjGjN3+X4gUKejn/P?=
 =?us-ascii?Q?o9PG1wnDo2QECXmhCXfN8jQnRIc2ixcEZjiYV0Mc7G80Huhip2uniGS3qnzO?=
 =?us-ascii?Q?XDjAXzFDmx5bkMqT2bPBFYjMZvnk+OJqNEfdvnsRAZAc65Z1VleBbxqljiXc?=
 =?us-ascii?Q?1J/8Pc+tD5H/oO7YvSTvNdR16GtwhiCm9OQKaj75B/ccKvFIx9nh1KyC3Ap0?=
 =?us-ascii?Q?ecd+C5WJOVZ/nl4HdhtUzuLUvd7FACUi8s1otBGmoLz5dzSwVYWV/fYlHCET?=
 =?us-ascii?Q?AyNZR3rNZlEVvjzlIO2aSKI0DG50BpX9C0Cdc/8G/M5pJ/hQuV0eP3ndbbEQ?=
 =?us-ascii?Q?X3cFRrjbGuknzUuYnNnLyNo33/b/QK3ZdQ8fagQJqoBdjihOWdDYTzb1FFsb?=
 =?us-ascii?Q?lTDn7pqTDRcmY4w+9DV2dHS5DMODaGaN0wsP3GoIiNc6w7fM6IGNdPafIInJ?=
 =?us-ascii?Q?P7KCB/L9dLLR1z4sQf+g//UBdxzlNUcBgnsQma8SfEQfGCg2rwulOm5gvNyI?=
 =?us-ascii?Q?ws0OqWY+6ui2vAJq0y6XYAz2UxsyguFCwCLI1Qq0yK+pgJ09Fld3lPvK9t3B?=
 =?us-ascii?Q?j8/RMcDeGNmT8GgwmGNzeBxs2KPqwmuJFsqFRoy/JSEnNwZejZcQSEZe6zHH?=
 =?us-ascii?Q?ra8XkyPs0f9s1T6RzvRj+G/HI0/1tww+prvh9d+a/qU7CqD5FEw9vbxqk93M?=
 =?us-ascii?Q?s/Zpu8FxDqOrvkGevX/M/dZjM9Nlfpj+PpxYzWwA0Oi+e/zj0xbo1+jb83+2?=
 =?us-ascii?Q?G8zTcQjCoWHDJ7Q3azGCGYUqB+kR+Zo393hBnr1fU0QMTOgCyOCF1SvaB0bz?=
 =?us-ascii?Q?skdjeJXfKRR2I5vZE5M5DiLsBf9w0NxnCOexyGoUbCg7ON+MDOjrdX/KyfEJ?=
 =?us-ascii?Q?QbieVdezEHnvSWYp19g9IiTy2RrjZQDkL9yNyixAvGv5lmX6i2pKkvf+vHjb?=
 =?us-ascii?Q?WtV3WNRwV46AbfWzOGtNQInsgSacglDT1zP1xX6VCpZq1GCbsPmz37IgvQfd?=
 =?us-ascii?Q?5okqAD8YdhpplPgNDiK/fAFR+SpG+FZrzAZKozI8iDtGXXu7wM8TPhcDINmB?=
 =?us-ascii?Q?ZujT3hYCwELB1DUncPpx3lMPfg8BXBMkONs2Ac6bSf5tVWX5wOhuTosQ8aU4?=
 =?us-ascii?Q?ooeNK02tRx0f4cxn1GIZ3cpQdnSqCX/hjYn4PCT8q/VffUlmWclHG1pZqp1h?=
 =?us-ascii?Q?zt+uTgaBH39/42DAvJDaBu/57vLpCq/6g4cz/x0034ckBT7ysVpQ3bXM8ZZt?=
 =?us-ascii?Q?3xcDLWK/7ZLiS6oc6tvWFcAH+NOscz+TgOEl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:44:13.2694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd9b3b1-3d8a-48ca-f15f-08dda4c58cc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5817
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

