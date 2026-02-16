Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A98EE8383A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 21:14:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4970C10E3EF;
	Mon, 16 Feb 2026 21:14:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EOgLcg6O";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010035.outbound.protection.outlook.com [52.101.46.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FA6810E1DE
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 21:13:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Az56Mea7BWR7y3k30B26p3x5l445dB6FNPSUASbDTPvBX12Xjym35YrJdzwdkdQU1SSgThcR+GEwpuT6Kr6gi1k6VUCWyhGxG0LzsDHQZ8k8R8PhsFaD0zVt1pmj1XpEu64G+YmxyjFuW7U1OV6cNDWr0HsR7jYkck6NS/Qb8uDsxGpnOKH3kYqoxKpQ3I2J9uN3Turl7irrasQULkDahBUgxajgq4m0zqYnVFTlMXzYpgzK5teS3TVDJPM8eSYbNsrgreKnlICoGtA/y3Sm8RhrC3gRpawDkgThi4XPzgyICxwJ/cd36i9Z3ACaDrYQUuvQPOSiyJEWWgYwpfkNVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmIoL8oRIQX62VmOmCTeeCV6OMx6ikf1g56Dva8jyaM=;
 b=IS865/ZvaTXdZRxhrpnvr/qat6708sAwPXyvsJjXJ3Qy6LAHWyMHXoRs+DW/YV09NGQsizZN+MHuGZvRZFXdsRcU+Mxbqt1H9xsuIC8GfLpdgY5doFIZpS7BeYRg/+UjsxfybvbNaIo23wmjROjvcIsMG8L0sdpSitHXCzMlnH3rKtrShVTyCdSQm2K4gRmT4QU7z7KE/gXSMrClpL+IveQ/RCKCME83IUi4d7BQ6Qx/EMFsu9PjzG3UNofO0q6WlVHRCbjRq5/+Bn92oPe8BpppkLSGcsDSf6f9WEysn/q/1E4+iUdIJFw9PesRiuszbAI99qFRLYAjgvOSWocS9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmIoL8oRIQX62VmOmCTeeCV6OMx6ikf1g56Dva8jyaM=;
 b=EOgLcg6ONVvKBL7cqdaiPhEpRZjXGSowhDL9jGzNlY6vd7huw0yCub4ngBAeojanFrmBvLO8J7UBYvDVjuwcLhVrC+bn+J7okrmMyxcPqlKkj5xvXG91bjvc84JF1nn/KIY88rza6OvIcxDbTOjrQ87n/bx4F1+5G8bYHpl6epo=
Received: from SJ0PR03CA0170.namprd03.prod.outlook.com (2603:10b6:a03:338::25)
 by DS0PR12MB8319.namprd12.prod.outlook.com (2603:10b6:8:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Mon, 16 Feb
 2026 21:13:54 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::c8) by SJ0PR03CA0170.outlook.office365.com
 (2603:10b6:a03:338::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 21:13:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 21:13:53 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Feb
 2026 15:13:52 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Feb 2026 15:13:51 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 6/8] drm/amdgpu: simplify VCN reset helper
Date: Mon, 16 Feb 2026 16:13:38 -0500
Message-ID: <20260216211340.16364-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216211340.16364-1-alexander.deucher@amd.com>
References: <20260216211340.16364-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|DS0PR12MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: 77731096-96de-431b-9718-08de6da04a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+qZB04AKdJjDpgFlZVlO62IMLBVbXrqiodIG1VaT/ApthgfUqQBRidOnsTJY?=
 =?us-ascii?Q?j3BccIWCWJUCUjz+eNlNt64l68oOHaNBpzfrm+TdtJwdAlenp8rTUkxSLzBZ?=
 =?us-ascii?Q?bHCIChHzmYqey+07t7M2gHVxaiFEdzOGDZrvgixLOXaLSDlgkYfLXcNf6SwQ?=
 =?us-ascii?Q?S+4oAcpF0bN5JCxwFTmW8MioRf6TCRhSzJBSsN1JxRMz29DK17OFif8j5R/9?=
 =?us-ascii?Q?GYbPD5kIAI9W/TgUmgGtAdwJy2oEIP9JsThbakvI3C92o6I/CDxzPkKn0h2c?=
 =?us-ascii?Q?JQjJHx4mQYcdKygnN2f4o/dUTnNm6snX7ecQrCz2KT++MLrKm7hQMaFhNsNz?=
 =?us-ascii?Q?nepyrQhFgtOnx//2ZH6UaUNZxJVhEri7PKbjX3v8mV4Xny6YTQJblPSc7wxI?=
 =?us-ascii?Q?t1AQpAHNNQXBkl5hAHIOxPiBhSnEyw+79gIFGNAiGEscVmDQond1q/dvBf0S?=
 =?us-ascii?Q?gtjkfAMp+6wnPAmqrfqkR7Z9OeIWQ8+FU2BIo1q+gsNrovHqvcgLAYBUJaem?=
 =?us-ascii?Q?1lzii6F8lB6IIpZcWrkblNiQ/nzgFGwh367D4UEs8+8vzKgxuQJCJ5ccMX40?=
 =?us-ascii?Q?Wp0j3zfyq1HnXM+xLi0MYUpBW0WzNVLbX22+DI3TW8tZEfSCzVHZqWUknot0?=
 =?us-ascii?Q?HvMt8CVYtWjD2SSAbqlw0N26e7dCoq+RHRLzfMHff1htYmswAcedc96AnqNZ?=
 =?us-ascii?Q?zqIUgLQV97xiMbf4M2UB+9D2XFRhqEiYBsKnrmkhgaLGtRTiUCloEVPEiigt?=
 =?us-ascii?Q?tyDp0G/AU7YO70ARaGBZkeQJmbN6nvhYySaDDpBAMjiBu28OIT5YfDRqTfM+?=
 =?us-ascii?Q?x6eg3+7OLEBCW8dEqyXHO/cRAk/RLkTP9FUzoAwWqmfyKVseLOJI+fM33JFy?=
 =?us-ascii?Q?x2kI2vjDQPb2tM+qo4RidJkkAK6iOAJpfy2nK0effLIVV+KHqNMNxZRq1VnA?=
 =?us-ascii?Q?OUu7W4eWsnfSFzdlG3TqAq8thTpN6vPhaxuAEYzuFQaOuXfpqfBx77DipEJ3?=
 =?us-ascii?Q?8c6F2uih/vM4wYvPMI8wy/IIWVeFw3eiA9gtKsQFDABfmgVKJTHkSopVf53I?=
 =?us-ascii?Q?IlpS/InPSlwKCOxE3VDxi0O2APSJmUba9kMSLKvfLZCkvuFbVytfEb5zs+yF?=
 =?us-ascii?Q?UPfMfMO3YcoO0SlKbrlnZkmlDX9C2b0C8eHrZ225uCsRfvewGll7wdPI0dNg?=
 =?us-ascii?Q?3h3xubOOR7GsbLjL4EzvP3/30mqxq2f64DFc0koe/2wM2tpylX/oR4uNGaMD?=
 =?us-ascii?Q?fWgTNVbWCBxXS1YAa4pPmReOOHyH2S4captum5/9Xv5vAQwknfNOd4Ymt8wz?=
 =?us-ascii?Q?jrDE7UssnpYFPNjgQ+vPuG1x43MYMBznYlMbu59WKvMJTBmHFDlZqTFpgAg5?=
 =?us-ascii?Q?WQeVvSzxGqc8EnXhX5XUUTHHPz/IJqdaISnovKqqAPuq3e8MXhGoF72qfl2j?=
 =?us-ascii?Q?W5XtRSnl6mSYSMJ1KPs0I+SPhQMdCsDD52T7R6nbOp2OT5Gk+y2QGL7q4Nf8?=
 =?us-ascii?Q?OtCztybYL9AXYIXqYlXTKReEqTWgnWaw71ZVDYQvF5xOlDwyo5qs7hXWF55H?=
 =?us-ascii?Q?QPbxZ00AC2t2viLgRSeR4Cu9e/0PgvRPVKW2gTd8VWm3L3iEfg6/1eleCl29?=
 =?us-ascii?Q?EeKbiC1oKGkUtkrpK5nVChhbhG7LmKDYIohcsh+Rm9+A?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lDqCw4UmzYZal0ORg4R7xtFfS7Lj0ELQXWg3HazFDWxpUlHmRQA8DvJvr8jPHCAoZm9Re13oGxLqGLPO0f9pHCYdvoh/Njh+di3pbPMtFwTsZqeG9jwy1F6BDpJgWpeIJSgjEWEwaeorv/cVwYI5Jjipl9oE09NsICWLd71uB19XnhvLfv7NNzmIvA94ilgIEXoSrNm8trXDNawHkshuOfdJ1NXSs8N9zd0NlRo+kOaqHBzobVsSSpUa3X3wZSISNJLm1mL8OtFgu9+0UQ2/MIee7ER0snJib1at1TsR4H9/guGWyv+Y9bwgNjGj+dIK2CPzPnrCq+6Yizzne7+yCYKKInu+esRKrYOWApHKKTS9FD2L3dm5bUm5rhv3OcKkUT2DC/U3mr17t6pqf4IzUFYJUWT3kTrFZxnMu2O1hOQWzJgdcxFNr4iRBfWiGQli
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 21:13:53.6179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77731096-96de-431b-9718-08de6da04a09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8319
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

