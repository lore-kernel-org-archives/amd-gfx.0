Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3900C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 18:24:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E22C10E629;
	Mon, 13 Jul 2026 18:24:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NUt13fii";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013026.outbound.protection.outlook.com
 [40.93.196.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AA5110E0FF
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 18:24:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qruSJD50K9AsZdz0KjZ6fqdDCvoDw/cueycBX+SPbDfBDFIvZT4GtnWuujd9CO3Jljib9xn3ozwmqKwfkrHTS9M5Gi0rjV5MtJwNXFpE94C7+uVfDslak6b362zPtAtQsZ7lj1FKDhH2D2qXIZnjILNBjpDzZqaszuLSeWb78lmVFvGcvMrlJ+7SrgikUDt5wLaUPY/DBzj0p4WKnBH0QlYvCO0J7JRyyT0G0V9OqVBxaJzN0jj/K0AA5OiNPQT/6mw5hhhzULefsnhWMnzxVDRAefmD1hUNLVioiQPEErejf9RkCbdgZjfjMgKQBE2sbtGzXYuRXt6l+VK9ahGkrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFL+zugvfBnr8BY41wMGkpLAvwIQWqj0+RZ9E+Phiuo=;
 b=Wp3E3QXwaWKweuyvGUG/QhKaE+Ky8sh+FeZFNwGWWDWB0toS0vEjRNRxSLWU9sl0ywnfi+hXPVl5Db4RK7M9rT9gzwpvO3HyYUYUMtUA9moRk9PsN5EKT901/OdJRYWEgwJnd+eY1TxDJK36urOcaVsJKoUEhO/QgQw7u7+5QowCMa9qk2XtglwY5jT0De8FuC10eM269k012H5ojib48mTstPH8asAuSMlj2fZ+lEFjPpZBHPo0MEvUk2Q6uV6hnZwnivij97Z69Dm8VlVwJKyb+vhrqhbTkfqb2p2M/nYskMQDPCelYczlFLcoTVYVFvElWs3BE+ukzTzhGpkKWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFL+zugvfBnr8BY41wMGkpLAvwIQWqj0+RZ9E+Phiuo=;
 b=NUt13fiiVyBBBML99IUC/feW9aoG1anG5+SHZx40ruI11DXYOszdiBoxgvVpWa84Eqrbw5HCS5ReVy5L5QdDKKklZz1EYWQKk8lvzvfeM03FOk/vVIa8UUNK2nk9aIXfyRwdxEvbIua3T8r9aD+cTkFjPMRVXL3SJ7FyY5JUGfM=
Received: from SN7PR04CA0229.namprd04.prod.outlook.com (2603:10b6:806:127::24)
 by SN7PR12MB7347.namprd12.prod.outlook.com (2603:10b6:806:29a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 18:24:38 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::a0) by SN7PR04CA0229.outlook.office365.com
 (2603:10b6:806:127::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 18:24:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 18:24:36 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 13:24:36 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 11:24:36 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 13 Jul 2026 13:24:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, <timur.kristof@gmail.com>,
 <christian.koenig@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: always emit the job vm fence
Date: Mon, 13 Jul 2026 14:24:12 -0400
Message-ID: <20260713182414.630372-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|SN7PR12MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 89fd675a-f78a-42d4-1cc4-08dee10bfeb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|6133799003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: dwv7YfO4Iz9f+oOp+2kz08TxcPyfnPZhbVYQhOeApFodIQUDbjDrwNrlD76PQ0h8M2/HtyQEpAi0lFtOcdoRvcFYzcQE6AYcaY5ST3S5UNyhNdMC15z3zY2AvhSbtvICybPX8yaCJLf8SDYnpcuhlIQxMNZrroJXw3MnTiaA42EKZp3LuTISETdHx4tI8T3FXWw0qZRfOXHLZoC+/PqbyfSMczvG+riipvXPdTwH1vbwuZ9qAXwOk4NDxi70HW40PaGcyMRbUCscri9Zr6FaYP0zYMVu5/OS327V/0vqbnUl03NMMuypdl94iT3r6DEKAZe6whhCXjCdmdBOI8VXgH2AZ69o7SNK+7E+qcox+bOk1UAQx5AgznuJqSbWOt7cLQYOVpLRwom43QXAwoWPCgNCDZTRWBhjuAlmKag4orR1xVOlAJ1vAsLmPiZhRhqADqXM4UxoqPXz6DkmPxRHWhETlgQpf7ohwszBcBOSX8Bk96d70qycsgzLGG3T5wXbp8wliiBXil/IwW9S1BhmEx+048WEFTYHHF6AzHPABE7EJiFruhx6blh4xQ2z2uOzjl1JN4IgMnKPBJXHXkE33BcKmtzFNp4OLbMVlWy2OwZ7ssor/ryIX06uhX8hqkjH3gUpsTP/bgYXum5OMmslS+wpM4HpHCF+e9bibBWaSgAmfjmZEVGloSx207CnMdW10nLgsq8DMpFEw2LypvwGGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(6133799003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /2B6cBnhlIhVwnUr9ugQOQAgXnA7yU5DPjc01EJIA3H+oa9KvDEVVD0R6xVVkIt1BgDNIB7vSEncjXu5V3qvYdKH7vjcIcCowFCfIvr5ATutEntUS3QoTI6VjoWmlM5L1Bi51yQ3TWy8JCKKIUlq+yJDhxay0Ftt5PkUhU+rluC3+6qnEY51NKUzph3z5YB+JlP0HRNtcYnO5I0irNGDC0NpI/oszZncRyIpBB2O9hWKatnnvQO8bRWGxIYDLVUy+Buok5JTkl2kuiBo0OhHxbGIyiuRwsS/IWI4NTh2HnylG8DkCodBSbsjrsg2Zqs0Byql4EYGqn3YwwdHg2ioeX8l9iGgV+OGxj5/J7SuTAYwvCB+o2A395/yhcG9OqAl7EITq3XmH80cgEAWG7feTVYesaLlzCmmyWAGk1MLhkQddPErD5zk52IuveSlQQhT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 18:24:36.6608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89fd675a-f78a-42d4-1cc4-08dee10bfeb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7347
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

We need the fence to reemit the gds switch or spm update
after a queue reset.

Fixes: a17ef941212b ("drm/amdgpu: rework ring reset backup and reemit v9")
Cc: timur.kristof@gmail.com
Cc: christian.koenig@amd.com
Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 180d694323e82..0affcb9e6d34e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -855,12 +855,10 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 					    job->oa_size);
 	}
 
-	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
-		amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
-		fence = &job->hw_vm_fence->base;
-		/* get a ref for the job */
-		dma_fence_get(fence);
-	}
+	amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
+	fence = &job->hw_vm_fence->base;
+	/* get a ref for the job */
+	dma_fence_get(fence);
 
 	if (vm_flush_needed) {
 		mutex_lock(&id_mgr->lock);
-- 
2.55.0

