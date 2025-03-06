Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2E8C282EC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 01:53:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AACC910E8B2;
	Thu,  6 Mar 2025 01:53:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D2/UL6Bo";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90B5010E8B2
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 01:53:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQwdbYp/JqOaxMF9Rgr94o1UaBtgtY9/LnW7MN9A4hmAlEUMwK7pB4hzJvxFyD+T3qiMFDMpng3Q1hnPU7dxqfbgjD8kJpbvc9SzNW6O0CFqrc9IYOgOwOFuH3/6qSdx91G9JwacpjP99vYOVOjWJeGvvv8urGrKM8wJW8YFWIuv0yk5m51I1y+b0cBYKT2/NQiEovwikczBgRLTAxo2iEIhhKJuI3VY30OFTkoHOeU2QaJwKNRfQRHMG9oLgYr3w5zkgW3m2Haohp2CBgLgazTkRqzy149trExbRVnqDuc56xXzZ+adV8kLp+qCwNIlKsv98bEjSajqiwhyl+4Giw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrHimiad/RGrfuqk3q3vx4iSJKUdwqHC4HKV8TSAHMA=;
 b=bd12uQ9khWSen141jKFRMdG37Ef0fv25cXjt2Xojfey+1SjE/kZ/8tWvKBIw8zSl7VQEbKDPW0QVulHXicIDtUl71pP+JgOiukz8O3N9JMySz78m06NAxIju4X383xmg9hRXcxIygvBejE4G0r2nmtxw6N+22pptnnqOrkoUHo2nLenMOwmUo68mmsj1JUcznBl9xs5LRT4+ITdCGLlryLkewNMoPt83qmYzQt2eVmigIQd5sBioGY4i/106/fI9FDB9fMQkru4XMBs6SAEAUQ4/pWt3aTVi8qzt3OG7R1EXRg+LHZ1VfEwkXqnHKp/EE28buNlXIA1N/plYFCHJ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrHimiad/RGrfuqk3q3vx4iSJKUdwqHC4HKV8TSAHMA=;
 b=D2/UL6Bo0cHQLilRVyBdBMZzQGZy53OBb/Y8m+mVv7AuZ0F/ngNoT3bUSt8sfcOpm2LS0gT4gvbgJNEs4bkw27dBVPnvT+zzMl+X6OyAIEtV+kfkgiMMzbQiwFQdQv3Mg8/p0nReuxNQkOsIBK+uCs0+KAlLMjXTud9nA1JlBAY=
Received: from MN0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:208:52f::16)
 by DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 01:53:06 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::d4) by MN0PR03CA0028.outlook.office365.com
 (2603:10b6:208:52f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Thu,
 6 Mar 2025 01:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 01:53:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 19:53:05 -0600
Received: from SYS-7048GR-TR.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 5 Mar 2025 19:53:04 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH v3] drm/amdgpu: Fix the race condition for draining retry fault
Date: Thu, 6 Mar 2025 09:53:03 +0800
Message-ID: <20250306015303.3221350-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Emily.Deng@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|DS0PR12MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: bdbfb8e1-8fc1-441a-ef2b-08dd5c51a37d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?URS7/0ep2XNVxW1xbvzg6DlFqkvlSrzr6VqgG+b42ZTbJjaYLyltHGIuCL31?=
 =?us-ascii?Q?Mc2PtGL4/uom+zYCcrMVgbkBwYJebiDTcphmI/nyMTc6T/orUj14rhUsZVPd?=
 =?us-ascii?Q?w94o5jMwryCpwWgVUVvQFQg6rRJyAM4080fXFXVwC38UUbuQLbxMRg8AEAnb?=
 =?us-ascii?Q?gKSMotqT8ea/YbylgZfL4uhvEX3RQzJv4eDJ6Vl3hKgLI7pGexMz4tANnS3S?=
 =?us-ascii?Q?N92IWuVYwLVJaaQsUcgvHFLu/ev7L/C+cw/hsW/mDE6UJC1K9DGfLrts4K7n?=
 =?us-ascii?Q?oRqTnoepJ/3gqCO7nL3DtiAULi5sdF1GvCFirPo9+yr09/OuC3ec9V0aJ+KB?=
 =?us-ascii?Q?ohyEbsNXYkY6PGtcwJ9TP6eiSUAZXAKf689d2anD8URnpv15doZir0KM1vu5?=
 =?us-ascii?Q?zWIGRWY2vUwzX3nudLu2UmLA4w2bkYLx860G5LeHpoNods6iLJtGttHMm5OD?=
 =?us-ascii?Q?cG3TR+h0m29Jt18dEjjokUorIvz3judLS5fCXSp8sWc/y2U0YfvepOgdB0S/?=
 =?us-ascii?Q?adR8Aep+aXVjGItuoAJJ33XmRWIUcylEz2NvXlcfjcIw1AJpvLrJdwqVkJZH?=
 =?us-ascii?Q?Ru5cEY1eAsCfW+ZoZaxaTeKkDfb2LjphaEv+coL9VMBXaQv9PqNkrHpO++mC?=
 =?us-ascii?Q?coL0w8UsX7zihxnSfrDka/WPybUVXvgMTVfkQ8WReEOHTJbp9yMHEbt48XXa?=
 =?us-ascii?Q?hI3peILx9T7RyIuID/WUxsYz6bZH/tpzDPKhaNTsG3lBEKl27EF1/jpxRUjO?=
 =?us-ascii?Q?fIrok6z6vTv2tb+w1UF3WBF806v60OWbnZ//2wqM2TzpzhjnJm6zAlwqnQe/?=
 =?us-ascii?Q?8hzKH57fAMk9k5MBo+7QNoaZVlYFBFP5Br+HHsbA5XsSNbRqzXAhVTScwjk1?=
 =?us-ascii?Q?YiZ1WMzABF+ycu1HwcMc++h4p5e0/zgr4m0FRQEBvdcL2D4cR3xzktw+G9YT?=
 =?us-ascii?Q?gkG5vDB3C+pqJaxLWkClL0ZckzO1QPgG+gUFTTI9L0fTjEnYQkn6ftM/vKuk?=
 =?us-ascii?Q?RBM+xlDVr8QFPWThYhuBkKUAb6y8c/6hSx5Wqo98VtHyjIiZDmXMIFsz2Cr3?=
 =?us-ascii?Q?i47umeVYRA4hLVQTg8cvJTr2LMDLRyFqVnvy1dJedwZ/hYC1ix1Ew4Cdfk6l?=
 =?us-ascii?Q?FIGEIfnu7mrzn6w3CPZs7n+6Lpjy2VmxuU/yNWkFMbvdiEY+g6SJqH/3DgZk?=
 =?us-ascii?Q?eWIH8vouh7PexXkpWmpf4sZirAMnnUkmpUx+kzbRrj25okbAAfuAcfmu18rc?=
 =?us-ascii?Q?MXF3WhiPACfHo3R6UTmz4Ng0tMGyGSKcKPaYY7ucSNKIBsM63g9yFJ0YgEv+?=
 =?us-ascii?Q?SutTJFK/IpL86+oIWCU3hXj5R2BKwWylpbITqpCIGl+teB7C99kghVPEVjaT?=
 =?us-ascii?Q?Ioc7sHe+LGh6cfBrknmKAvKgx2HwI4NPnmbMagH2A7CWes17I7rrLmHtZxw9?=
 =?us-ascii?Q?GA7HRt0yI0Zrjus3H48qMFXGvIuoVBN45+OYMU+zI+ZpfGJoz1k+Ch8aVNTh?=
 =?us-ascii?Q?mFpnxnrgZGMwsNg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 01:53:06.1055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdbfb8e1-8fc1-441a-ef2b-08dd5c51a37d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6560
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

Issue:
In the scenario where svm_range_restore_pages is called, but svm->checkpoint_ts
 has not been set and the retry fault has not been drained, svm_range_unmap_from_cpu
is triggered and calls svm_range_free. Meanwhile, svm_range_restore_pages
continues execution and reaches svm_range_from_addr. This results in
a "failed to find prange..." error, causing the page recovery to fail.

How to fix:
Move the timestamp check code under the protection of svm->lock.

v2:
Make sure all right locks are released before go out.

v3:
Directly goto out_unlock_svms, and return -EAGAIN.


Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 34 ++++++++++++++++------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index d04725583f19..42ee49d19ee9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2917,10 +2917,13 @@ static bool svm_range_skip_recover(struct svm_range *prange)
 
 static void
 svm_range_count_fault(struct kfd_node *node, struct kfd_process *p,
-		      int32_t gpuidx)
+		      int32_t gpuidx, int r)
 {
 	struct kfd_process_device *pdd;
 
+	if (r == -EAGAIN)
+		return;
+
 	/* fault is on different page of same range
 	 * or fault is skipped to recover later
 	 * or fault is on invalid virtual address
@@ -3008,19 +3011,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out;
 	}
 
-	/* check if this page fault time stamp is before svms->checkpoint_ts */
-	if (svms->checkpoint_ts[gpuidx] != 0) {
-		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
-			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
-			r = 0;
-			goto out;
-		} else
-			/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
-			 * to zero to avoid following ts wrap around give wrong comparing
-			 */
-			svms->checkpoint_ts[gpuidx] = 0;
-	}
-
 	if (!p->xnack_enabled) {
 		pr_debug("XNACK not enabled for pasid 0x%x\n", pasid);
 		r = -EFAULT;
@@ -3040,6 +3030,20 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	mmap_read_lock(mm);
 retry_write_locked:
 	mutex_lock(&svms->lock);
+
+	/* check if this page fault time stamp is before svms->checkpoint_ts */
+	if (svms->checkpoint_ts[gpuidx] != 0) {
+		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
+			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
+			r = -EAGAIN;
+			goto out_unlock_svms;
+		} else
+			/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
+			 * to zero to avoid following ts wrap around give wrong comparing
+			 */
+			svms->checkpoint_ts[gpuidx] = 0;
+	}
+
 	prange = svm_range_from_addr(svms, addr, NULL);
 	if (!prange) {
 		pr_debug("failed to find prange svms 0x%p address [0x%llx]\n",
@@ -3165,7 +3169,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	mutex_unlock(&svms->lock);
 	mmap_read_unlock(mm);
 
-	svm_range_count_fault(node, p, gpuidx);
+	svm_range_count_fault(node, p, gpuidx, r);
 
 	mmput(mm);
 out:
-- 
2.34.1

