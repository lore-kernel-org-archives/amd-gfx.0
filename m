Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F07F53D87
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 18:17:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D9D410E3C3;
	Mon, 16 Mar 2026 18:17:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LQ3O23rU";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013038.outbound.protection.outlook.com
 [40.93.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F236E10E364
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 18:17:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0Rjx77LTRSQXw9sHYBj0+6q1GjS4Em70usEw0WorT+FibMBkvui94d3DCuIY1JaHcjnNYZHsx6jGuHCAaLs8VFZs5/HsPtSr8lo2kdA3P4QEcVcMMVgITFoRc34pz7ayx+8NGrJv1OEF4471YvNvSeqH1jtsdlcJe0npXaoxERWu642GmLUfC5k16Ov8b7lmtpgyyH76P7PxijjIt/Ee+5cBxuCL4/d9WFbkg5drtSJIWTfBmayAUanyhcaYKByCSPeP815kioIPN4p9VnuOGAQmfQf8oZ81W+nSYlCNixoRCIykJXB+b4iO+0mn/3p6shH2J9/I0pmlC3ooAXU4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmIoL8oRIQX62VmOmCTeeCV6OMx6ikf1g56Dva8jyaM=;
 b=FSymnHixfgAmbG2g7MiYboWpQ7wDhLnWaAeCoYYiRnHtcXth+26NQk57TvuHbU0kvbZRN/q6yMCXDtYaHewFC7khSjnEQB546DMXjHbEyA7Qlxc7iM57g8G0NXjQzXSjWM3XtiRZ2EV4RhOgDtS3OYC/I6Sr17lsOeCYfm8GXzhqWOFBO+pBle3sJS5Cc9Inuyo4xjxRpThwjQGQ1Q/sQwyvH37jcupmB/osVvA1jbZUJS9HroLYBSqP9S0WnVE4Zjeh+7XZWIg9HD1WgVNGXlOimzQSdy6Nsyr8JwTmjua7bbqPiH/Z9k5TXL9YHLGQm8Hw1ATyt1CNObqlE0Z7nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmIoL8oRIQX62VmOmCTeeCV6OMx6ikf1g56Dva8jyaM=;
 b=LQ3O23rU1wA8s4Auy6DgqloQ/zS0vr6hglrCtong6ljtK8wIfc+RrgBlmoQZjEkdPfVCYiMivxHAUAxsSNcf9vShBWmfDj9doqS8QOsIzw57BG9jCpKuBAckjSVQl9EttYr3dllxxQGPBf/19OMElRsSPT907a7f62DBw7IWlHc=
Received: from CYXPR02CA0046.namprd02.prod.outlook.com (2603:10b6:930:cc::13)
 by BL3PR12MB6403.namprd12.prod.outlook.com (2603:10b6:208:3b3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Mon, 16 Mar
 2026 18:17:02 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:cc:cafe::ca) by CYXPR02CA0046.outlook.office365.com
 (2603:10b6:930:cc::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Mon,
 16 Mar 2026 18:16:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 18:17:02 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 13:16:58 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Mar 2026 13:16:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 5/7] drm/amdgpu: simplify VCN reset helper
Date: Mon, 16 Mar 2026 14:16:46 -0400
Message-ID: <20260316181648.2005897-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316181648.2005897-1-alexander.deucher@amd.com>
References: <20260316181648.2005897-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|BL3PR12MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: 135da76f-768d-43b0-c9bf-08de83883898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: l7VxffvN/ul9HoBnvdqVCvjrugF1l47vFVBh2vbUsI2ZOUuxlqz0le7DFURfa2UcA8e+GGzM8ZUf+Lxmc5wgZd/Q8sJZBPHIZRj8fdOfOHn/et6Gr7wwIxHLGBxskX18lkPvVAJLk3qZKVk8t06TqOyxa/BowCznUU+yIWzk1MBbdFqnBTND17dhSEzvYIkRbQxbayoGU4d9BU6JSZiBo62Dm7ajmu0MnIP21f2pEiScxX8C0SoS6SW695ntXYO1FwKM/2cLTBV+uDtlvfzsUGGTpi7xRxfR8f/27YuazbnBLRUMFFqJZrvDkabzpfFiu/ZyfDpwhjQeXX3wsHspa3ijfIwvVRq8dNOstvublhaNrnDSq2Ks4fbnh2+ivQ4tYc7TA9d9vC0QIbi5BOTS0gu8eV3JKT8MmBoHWjbiY63PHRYUdTaiYNgJ3LfSRPhQpGnlm03nEeYr1jnNMmOJbodXoN8az/nWx8+6FROicwNUqexbHkeJaehXdkd5cqFpOrXxZHr/cvBy/RWSXi5MUofvkzVC5/byCO919QhjQnRWBnCJfaBc6Ul2Yaq/rt2RqjnogLWk5h1eD8cFCz4xYUB1nmNr9+wuHzFH415pvQ9qQphCWnNzYey1MMbVETCK6P0JZ0orE6pLypzlNFYluE8uwhTquMnL6MlazRy3MpyO12QIXYDUnEM2NPQc/Fd9/Zyd9+lKAY+gYQYjOb46v7zmhCy7ThkGVymsU99m/VoZNDQKsGILGzY50NoT77+iRzTzu9nIjylIZt4B6HPXkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Xsrb9YJPAQkNkLWUuXd8KQX7X5fpc3afj7FLbYoDPm1yWTDrGHMNQ9Q4xIX27yIDlo7jIHUdYkvvUcM5FvQcJgO6MLvzM/DA3YAugiNf1FE4t7CM2gnKmCxiYGDBRrRSe+zMZiT4Da2jfrM3wA0EcDTi1jE9Fsj3vbPNXLhOzrSclglBwm2ZH1MhWWjvJpc7H8aj7cyfq1flCvXVhOpTOcLz5RsbywdsSmvXfnIqCOJ0MS/pqWV2is7/FrfSMJjE9YkD2MD/f8Lge0q4Fs7UFpnqiBAGJ+pa4k6v5g5RbRkMV14T6Id0pBYW6TnoKuEsXuaDNV/K4Hv4hKegzMExPGcLyGnmCkKfgQcACwPE8Nn75UzFAmiTXjp6GjZjq10VWTWKZaKxgKmHnkgYlxCRRLCHE297goY7MfIUyJ0O5pxOwuSBvLEpolFtVOu6o8f+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 18:17:02.0616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 135da76f-768d-43b0-c9bf-08de83883898
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6403
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

Remove the wrapper function.

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 41 ++++++++-----------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index d22c8980fa42b..4de5c8b9a4cc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1481,19 +1481,27 @@ int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
 }
 
 /**
- * amdgpu_vcn_reset_engine - Reset a specific VCN engine
- * @ring: Pointer to the VCN ring
- * @timedout_fence: fence that timed out
+ * amdgpu_vcn_ring_reset - Reset a VCN ring
+ * @ring: ring to reset
+ * @vmid: vmid of guilty job
+ * @timedout_fence: fence of timed out job
  *
+ * This helper is for VCN blocks without unified queues because
+ * resetting the engine resets all queues in that case.  With
+ * unified queues we have one queue per engine.
  * Returns: 0 on success, or a negative error code on failure.
  */
-static int amdgpu_vcn_reset_engine(struct amdgpu_ring *ring,
-				   struct amdgpu_fence *timedout_fence)
+int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
+			  unsigned int vmid,
+			  struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
 	int r, i;
 
+	if (adev->vcn.inst[ring->me].using_unified_queue)
+		return -EINVAL;
+
 	mutex_lock(&vinst->engine_reset_mutex);
 	/* Stop the scheduler's work queue for the dec and enc rings if they are running.
 	 * This ensures that no new tasks are submitted to the queues while
@@ -1537,29 +1545,6 @@ static int amdgpu_vcn_reset_engine(struct amdgpu_ring *ring,
 	return r;
 }
 
-/**
- * amdgpu_vcn_ring_reset - Reset a VCN ring
- * @ring: ring to reset
- * @vmid: vmid of guilty job
- * @timedout_fence: fence of timed out job
- *
- * This helper is for VCN blocks without unified queues because
- * resetting the engine resets all queues in that case.  With
- * unified queues we have one queue per engine.
- * Returns: 0 on success, or a negative error code on failure.
- */
-int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
-			  unsigned int vmid,
-			  struct amdgpu_fence *timedout_fence)
-{
-	struct amdgpu_device *adev = ring->adev;
-
-	if (adev->vcn.inst[ring->me].using_unified_queue)
-		return -EINVAL;
-
-	return amdgpu_vcn_reset_engine(ring, timedout_fence);
-}
-
 int amdgpu_vcn_reg_dump_init(struct amdgpu_device *adev,
 			     const struct amdgpu_hwip_reg_entry *reg, u32 count)
 {
-- 
2.53.0

