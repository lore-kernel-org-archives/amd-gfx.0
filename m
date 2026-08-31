Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612FDC79F82
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18CF010EA88;
	Mon, 31 Aug 2026 18:29:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h4ljLc4v";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 418B710EA67
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2fZf05nmai/rgzQIEE3nh8xzmFZYtz1x+pD8QeeTAiI3ZXGKbLGWu19wZQHLJttWgZO7FH4iXlXtMc6Pfy6Bv/BiQohHs8vEKwxBnG2ju+GG6fCIE9cEFTCmWqI8mgH9gg4LvQ8BVYDJ1X5JoYtQ/8eGZc3AofUrbTeuSVcdLzoa+Kl4ZU7ggHwmLAsIl5FT752eu+eQdNgk+d5kgHs4f9Ofg7SP+u4jH5+K6cN2t9veLb6058R0hE0Yg4z6qe8RaLHTGFzikMvBGhDiOzzqBAyuypbNyb7rdyq8arvYlSH8gELbdVlOXRglAOiUQYyGo3dRX3dnlrncOkfLwtYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fShTebQUqJtOhrxpXfizAvOVDcQlwxx8Z4fezLtk8js=;
 b=k1eKEpWtkmvfT93MrZ8FSHI3CfTxtosiZGj3Ww5LMVBwpptVR+HaDN0/leriXWek0cyWbuGhMxFY1nVWy8RvPdh9374PuzJn88a7ybiyqRJ6ElTjqIALLwj8idjqq5ifDi7KGfC3F+0giGRSjC1H5VV5Bh71+asOODpj8hI+GCEqVDtgZUgpW08W0QNxcuBuhSaZZD+HPh6g95melq3POK46XAK6z5KkCwL0MH8HeKosRWxj3B7m58Bs4iGQlqUdtABR9sC+G28dvKNtqmEqvo5i4iFroZ4eSEz6sMtZ04YNnw0y6Ly/iOLKphayO99xahrTTbbEURT77MkJKRRS8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fShTebQUqJtOhrxpXfizAvOVDcQlwxx8Z4fezLtk8js=;
 b=h4ljLc4vtcKQOYRs+yXfyzNi9Cufba7/7sLZ57G05lRiBJS2lku9v4MrPVNClsrz63YLB7jnsQrsP3R/vQxKUpZS839NvzA4SZpB1tOv5RngUFScfSv5nlbHDDuQBQtCN1XRwt8o2kPKjTMjLOJVs8kYVlADXtxjMcp+yqThcbk=
Received: from CH0PR04CA0101.namprd04.prod.outlook.com (2603:10b6:610:75::16)
 by PH7PR12MB5709.namprd12.prod.outlook.com (2603:10b6:510:1e0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:07 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::2) by CH0PR04CA0101.outlook.office365.com
 (2603:10b6:610:75::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:29:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:07 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:46 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 63/95] drm/amdgpu: Prevent double-free of drm_exec
Date: Mon, 31 Aug 2026 14:27:22 -0400
Message-ID: <20260831182754.1089811-64-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|PH7PR12MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: e23e3d1d-a76e-4901-35eb-08df078dbe5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: tT2RxnnLg3riN9t5znAxHMyU/yNPgVZughXID/q11dt/PT8dfFXljtxD4T/6QKMuhJiWkDDX26AZc9mWQPKcB5jJoB6rdKslfPVZk7OMvH7Zn7Imhxi5b7r9WPV1Fli1soPh/hDavFExtCUbcQwX5xzrbFkLg5XuCnG1uCGyjijQ0N/62n/KQ77bQQ08dT47aiDNJz4nGtEFecONwWWGh88gr7dOoylyBNPGaaku81MMkRBYR08rivskLghWT5iP6AOD0tNo1rU6XhmGmsAhc5EAWDDld49MNTJDd7NGBBYcvX9QPUM0wJ5NHgdXEVDPRht4lXKHTKvu3fBgA5ZX7dOqUVODdZ3U530kLGo4x2RC2vZMlTzRxVak6n+1sX42baFTL99fQMYhK0laum9es++um2GfhqwFekNPC2Pdxvrs3GE4eVeHp8R+0MbZUuYaIMyjf3dYXosPzWJpLqyUizW7PLo3b7uGZXk0In9Ovn5cZ+HrpeskAxcUhwm9XvudW3vYpOw/neGwY5SETXnSbY9TJi92D/H3xJ4xbaHZIhIwXp8JwJUPQFxWi9PdSRhRL03bL22n3Gh5jLokiL7mvvNSLiqIBGeDN2FrSFiIazAtTz/5WcKkiYdGz6/45jh+mBq5qqtwwVgCz77IyXw2IX2RGzS7FCv+bPUH1xpKLxCsFBuDucP4b21c2Q97mBHQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WwdUpV70DkMmdV5T81yQ82I3xm4YDQdUGOSrq+WF1l5wtA8S2LwEXAf9xpooe+ZLJhZs0aYEdBLAUZDM+wSkQT8Bwue60AEsgQdGvLdCMXjDe85mef41k2AKlMQ/VZHnQwS5s21eC7ywqw6mwu3Ue4DnmvArl1wlrIkibzTHCkPRE/qi73e5oV5Fsiya1EcrWNHUkIOC9gwWU3VVA+Vx+a2ArN3fVwlSqL64L0KJsnVD4jtmOlf6yEPcg6bB3AsJaIfQB2uGrynR2c6zKGoQMcQJPTR93oAeAHgNC9JQZR1NE6zu3h8RyWNDUnV3ngiX9q/LbcxvoSPo3Zmiv9qGdf6GOer2DG/DxA8Dk7F7ilKQYlv2vN7ymQNObNACUmyZnO0C4HxobU/P67VpD6J4znaaZxY1AB0OFcdJw9fk+ChgzK931kp6NOdTt4ZRxFYi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:07.5081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e23e3d1d-a76e-4901-35eb-08df078dbe5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709
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

From: Felix Kuehling <felix.kuehling@amd.com>

Always check the return value of amdgpu_ualink_reserve_npa_vm_and_bos.
It's not expected to fail when used in non-interruptible mode. But if it
fails anyway it calls drm_exec_fini. The caller must not call
amdgpu_ualink_unreserve_npa_vm_and_bos in this case to avoid a
double-free.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 26 +++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 69cc35c24a2e8..c5fbc9776c3d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1494,7 +1494,11 @@ static int amdgpu_ualink_unmap_npa_addr(struct amdgpu_device *adev,
 	struct drm_exec exec;
 	int r;
 
-	amdgpu_ualink_reserve_npa_vm_and_bos(adev, bos, ARRAY_SIZE(bos), &exec, false);
+	r = amdgpu_ualink_reserve_npa_vm_and_bos(adev, bos, ARRAY_SIZE(bos), &exec, false);
+	if (unlikely(r)) {
+		dev_err(adev->dev, "Failed to reserve VM and BO in unmap_npa_addr\n");
+		return r;
+	}
 
 	r = amdgpu_vm_update_range(adev, &adev->ualink.npa_vm, false, false, true,
 				false, NULL, npa_addr, npa_addr + size - 1,
@@ -1538,7 +1542,11 @@ static int amdgpu_ualink_map_npa_addr(struct amdgpu_device *adev, u64 npa_addr,
 	struct drm_exec exec;
 	int r;
 
-	amdgpu_ualink_reserve_npa_vm_and_bos(adev, bos, ARRAY_SIZE(bos), &exec, false);
+	r = amdgpu_ualink_reserve_npa_vm_and_bos(adev, bos, ARRAY_SIZE(bos), &exec, false);
+	if (unlikely(r)) {
+		dev_err(adev->dev, "Failed to reserve VM and BO in map_npa_addr\n");
+		return r;
+	}
 
 	r = amdgpu_vm_update_range(adev, vm, false, false, true,
 				false, NULL, npa_addr, npa_addr + size - 1,
@@ -2002,7 +2010,11 @@ static void amdgpu_ualink_force_retry_rpcs(struct amdgpu_device *adev,
 	bo = exp_xa_node->bo;
 	size = amdgpu_bo_ngpu_pages(bo);
 
-	amdgpu_ualink_reserve_npa_vm_and_bos(adev, &bo, 1, &exec, false);
+	r = amdgpu_ualink_reserve_npa_vm_and_bos(adev, &bo, 1, &exec, false);
+	if (unlikely(r)) {
+		dev_err(adev->dev, "Failed to reserve VM and BO in force_retry_rpcs\n");
+		return;
+	}
 
 	for_each_set_bit(remote_acc_id, exp_xa_node->importers_bitmap,
 			 AMDGPU_UALINK_ACCEL_MAX) {
@@ -2128,8 +2140,12 @@ static void amdgpu_ualink_unmap_all_npa_addr(struct amdgpu_device *adev,
 
 	size = amdgpu_bo_ngpu_pages(exp_xa_node->bo);
 
-	amdgpu_ualink_reserve_npa_vm_and_bos(adev, &exp_xa_node->bo, 1,
-					     &exec, false);
+	r = amdgpu_ualink_reserve_npa_vm_and_bos(adev, &exp_xa_node->bo, 1,
+						 &exec, false);
+	if (unlikely(r)) {
+		dev_err(adev->dev, "Failed to reserve VM and BO in unmap_all_npa_addr\n");
+		return;
+	}
 
 	for_each_set_bit(remote_acc_id, exp_xa_node->importers_bitmap,
 			 AMDGPU_UALINK_ACCEL_MAX) {
-- 
2.55.0

