Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B38C5B572
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8687D10F6E4;
	Fri, 14 Aug 2026 21:03:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PClaxr5A";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012066.outbound.protection.outlook.com [52.101.43.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E622810F6E2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJHybcFNWKgabL+Yn1wP9jjEr0zuElMrt/a/9dz+uMis6kRKVM1PmbY2jFA5rmyIESKanT69WnFYxMNPm0Ev1CEaNZ/i78A+Ycc/XjpSsQJ8eP/PDjLo1rmpGnsBvT7D0kOwwuuz2k/SbRnXMqXt1wJQQgUNcVLBm2ZeT3KMOWTBN59vL5F+dnfZgKFOOJcx39zemCnovg1cg9VhYSlw5QlYwaGwNW5fr12xNi7gXu0vkUSPHCSjbqcfDk/91suEPf7WddNHVWJQ8QplFEyGI+mPBcNyVZv5hpjA83Zr2BOZAbYVXjP0Y1pGV7HtfuC0Ztk/FqAhL30zEWZ3AzI9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKLZS2aVYx/DHE6UxLCtIcFuSCEv54YKw+HKRmUi204=;
 b=y7J1Cbjr//w5H2gleS87O6cM+CM3O5RYDg0HVivgS704BBvn3v3hNehzG/vlHPQ9LvqqLhibliFv6xt8JTIcRQRap0z0DWgX9iHJD1id9rn5UPjYxmbd0FUvAqGRKtlrqwn62/uM13c1hZRRwnbP3arfZoyuv+bldlanfMqz6L3OFqagG7Qo1aV98pDg2utktfTB7mFUP3Std2vKU9bKYAcMmfndB79lEZTGkWfTEt5bSuRBLwMsuHDzEjckRIQswbASroTmB1BNxogQSw5mptj8Ndm1jW/KXW3a2zIX+wcg0115o6ghcXkkIQQYCSbFwS7Y5Q4X3i8ojilOpWbMDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKLZS2aVYx/DHE6UxLCtIcFuSCEv54YKw+HKRmUi204=;
 b=PClaxr5AEoot56D0fwKyFd+GD0FG+PcNse3PKJqH+PwC3TqnqITRpG5nCO+jGxX32HoFZo7Ul2lmd0iEYm+MPMnLJ+5HbvwHlJsJ7y9+hORihKzA0jyXojrR8E11tFcJp8LRMhuHcicEY2cwvQwSPnUYimY7ZrWwu6/128ICKt4=
Received: from CH2PR10CA0010.namprd10.prod.outlook.com (2603:10b6:610:4c::20)
 by CY1PR12MB9626.namprd12.prod.outlook.com (2603:10b6:930:106::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:03:13 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:4c:cafe::8b) by CH2PR10CA0010.outlook.office365.com
 (2603:10b6:610:4c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Fri,
 14 Aug 2026 21:03:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:12 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:12 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 025/109] drm/amd/ras: Support poison consumption handling for
 A + A sriov guest
Date: Fri, 14 Aug 2026 17:01:22 -0400
Message-ID: <20260814210246.3067612-26-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|CY1PR12MB9626:EE_
X-MS-Office365-Filtering-Correlation-Id: 633054ac-598a-4719-222f-08defa477419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3X/D+nNUqgie5OTGR1/MbopxMU/L128n1WPaIGAJsBezxVpN/eDphmBTQUtrLtUzIBHQYHURFzwXlg5o4APJjMu6g9c2d3bqqzlhG2W/n4ChxEZHxh+d0ctcplnOkAImS2UDc8x6eurh0kfxOH060swr3/8QdGl4ibKzJ+WDfPwLzmvQUes0L4Eiw9jqUP/YJ/tegUXYlSwDzeUr8CJ9uZz60fE9Nl326mLU3qys/ZJwHsyzSB1InMX3oOp/hxkwiuPPY1NrRTrEZtwbW4VLgPU+OV2eWafcVgP9GRnbdfVJfkKVNgZ8Y8CzuOlSoRwvvkuiuOMTdaONySlsjenlINXxYrkcOdzG+mYys6/C1CpbgY6T9EUWWHuw+oaNWXi3ix3eg00EWvyvOW7b5kYGMOXX0lE8vB1IZ4o36NiR+G4yTBFAq9HThZLL49iNMJxH/px2J1ZwpurwSH2D/1emYxcX78MdAhoTTZsd9foYmqOnGFvfRMZINL+pu7KsF38tYLSNYZqrWYojKZa/pI10we90Z1s76xJhjhfB8/2eU/ZvGQMT8tN/PRhWJCMWhOn1Hrudl3SLEapkeMWdAlZqCDuJ9yR3IDmQM9wKcU66QGckex9iuUTHmwIUMcpDr0NBvmaDzadCXGKpqEPSFuagtC6I5IJ1QElA4PN8ezVatiM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zGzKRVbKq7Y6VqsDYJJwEbSMl3c+sVgl8qO2eYSs/DQq3WPHGYGB/Se0mTMi4+5tJbQrwJww/65vVViMgm/11mOhr81IjsRHOyznay+SqL68sJa61cpL8o2HqYMQe7k07MKaMzc6wuhfHdmp7OqxWg8YUQzd2ga7zcZSNk6MWDy60wChfdHR0oEwEq8pJ/rRCflWU6wwfsix9ifuYfyFWe30Iklv10PYaftOOv5BZPBEXmIqee8X3Lt6rUH+GTYswnLVGjCs0dRQnWLGEm6yrdKOdTsieO4bC4hXm9MZoyo3M7A6l4BeCACnJ9jgbjorpvtfz1gdCBibuu9Funa6ZyA2z0lCJx3tc6y4RwgoiiaWQQzQewv8C+64dcXk8dQfa6QzbRAbCwqpXKHHPBOLzUfo4vJHsFg41VUuIZLPBUtq1Zrp0jea7KjsfGjCP+OJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:13.0293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 633054ac-598a-4719-222f-08defa477419
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9626
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Support poison consumption handling for A + A sriov guest.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       | 21 +++++++++++--------
 .../drm/amd/ras/ras_mgr/amdgpu_ras_process.c  |  8 ++++++-
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index a98a6cfd4fba8..986f307630f61 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -230,6 +230,13 @@ int amdgpu_umc_pasid_poison_handler(struct amdgpu_device *adev,
 			pasid_notify pasid_fn, void *data, uint32_t reset)
 {
 	int ret = AMDGPU_RAS_SUCCESS;
+	struct ras_ih_info ih_info = {
+		.block = block,
+		.pasid = pasid,
+		.reset = reset,
+		.pasid_fn = pasid_fn,
+		.data = data,
+	};
 
 	if (adev->gmc.xgmi.connected_to_cpu ||
 		adev->gmc.is_app_apu) {
@@ -264,17 +271,13 @@ int amdgpu_umc_pasid_poison_handler(struct amdgpu_device *adev,
 
 			amdgpu_ras_error_data_fini(&err_data);
 		} else {
-			struct ras_ih_info ih_info = {0};
-
-			ih_info.block = block;
-			ih_info.pasid = pasid;
-			ih_info.reset = reset;
-			ih_info.pasid_fn = pasid_fn;
-			ih_info.data = data;
-			amdgpu_ras_mgr_handle_consumer_interrupt(adev, &ih_info);
+			amdgpu_ras_mgr_dispatch_interrupt(adev, &ih_info);
 		}
 	} else {
-		if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
+		if (amdgpu_uniras_enabled(adev) &&
+		    (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(12, 1, 0)))
+			amdgpu_ras_mgr_dispatch_interrupt(adev, &ih_info);
+		else if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
 			adev->virt.ops->ras_poison_handler(adev, block);
 		else
 			dev_warn(adev->dev,
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c
index 285d81a85a99d..39452a9006155 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c
@@ -99,11 +99,17 @@ int amdgpu_ras_process_handle_consumption_interrupt(struct amdgpu_device *adev,
 	struct ras_ih_info *ih_info = (struct ras_ih_info *)data;
 	struct ras_event_req req;
 	uint64_t seqno;
+	uint32_t gfx_ip_version;
 
 	if (!ih_info)
 		return -EINVAL;
 
-	if (amdgpu_sriov_vf(adev)) {
+	if (ras_core_get_ip_version(ras_mgr->ras_core,
+				RAS_UNIT_ID_GFX, &gfx_ip_version))
+		return -EPERM;
+
+	if (amdgpu_sriov_vf(adev) &&
+		gfx_ip_version < IP_VERSION(12, 1, 0)) {
 		if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
 			adev->virt.ops->ras_poison_handler(adev, ih_info->block);
 		else
-- 
2.55.0

