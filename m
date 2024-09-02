Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBC1CD3427
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Sep 2024 07:34:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80DF310E217;
	Mon,  2 Sep 2024 07:34:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gGvIfAog";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D735B10E217
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Sep 2024 07:34:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVCqzslqocCAbnIJiIoBu+a9Ed/xEBsAcHr2xcfIpysk5T/nHjIQAb/DZ3VtpMCk0c7rlEhVhKKuFyX53rjjtoRDb9m0fLjfWduAQbjG9+olbl9VLvSFN+DxStPW++/RKe/GVQtxpfE3Dkyf18J03OX+seRrLkAchE58eQeR75vagW68fGB29pK+rILz6qHZ8vJhRfjSiZOuI+IR9y9qPuFE4rIQbxVMtQwrlbemQ1nQFz9ShOsveBEi0MmMRu/qMycv/q3C9Zj+gqdAIZZrfULQ4miaBjo1evGnVqZEi60PigjX9/XCr5aKBatP13dHCBXYlgiWpRjnPmT5SPF2uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZUAMifK8I43nVwyqUPplnepAw5hHGRA8bSMDjSlB80=;
 b=OfV5QagU4IxCogQ1zYQv+ktybOItAUxDRueiLZOPQWldYgYcWK9mScHKpJT4s1wrassS7a2+mKQAUaGUpTOYhUrh/A1I/LyAp9jD7HuhIBkVJtb/Hpz/aRuO0PebVqgJnHLOAXP0sYzU7kgDhWtIythX2RwXhNBje0jaQe76TKa3Fnd56b/+vo5SxIdR3yXeunml+YbCToGCDgZkcCWJFsEqUBCJer6e4vVNpRX/ehzPJTD/fQ8Ewd2KLLT7hyat3aiL3oaPRwSfxWyHBaWXirrG5jEYrVpL55VZydJoqULntvdBLqUK8x9eQXJrmfh69BsY9ltnGvFyDoNVpCns4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZUAMifK8I43nVwyqUPplnepAw5hHGRA8bSMDjSlB80=;
 b=gGvIfAogE0qVhDCh/D/Gy+GmWJjeHrpe/GR1B7XNWEueaez9KyrFRy1PQV5iXBZ1PEICjxkcL7YJYGeV1lvbd38YJF/p0Yi98F1UkvJ94gJbzZJLJl30N7U5J1vZQvn4CiEimEVf3pJRr1PaoOeFADMQ0+u6nESMA8vibnfU+iU=
Received: from BN9PR03CA0590.namprd03.prod.outlook.com (2603:10b6:408:10d::25)
 by DM4PR12MB6541.namprd12.prod.outlook.com (2603:10b6:8:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 07:34:39 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::ee) by BN9PR03CA0590.outlook.office365.com
 (2603:10b6:408:10d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25 via Frontend
 Transport; Mon, 2 Sep 2024 07:34:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 2 Sep 2024 07:34:38 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 02:34:36 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>
Subject: [PATCH 02/10] drm/amdgpu: Use init level for pending_reset flag
Date: Mon, 2 Sep 2024 13:04:09 +0530
Message-ID: <20240902073417.2025971-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902073417.2025971-1-lijo.lazar@amd.com>
References: <20240902073417.2025971-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|DM4PR12MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: ea9edc0f-e835-409b-8188-08dccb21b3af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PMOk/hoYIFJIWX3KLSyywVGr/6xX4JhZzKJXLOJ7B+FipfYRB3GBGEChT3/c?=
 =?us-ascii?Q?26ZBRxc+0kziz/xbXOQx7tYLv0cJbtxZW2a6KilvXHLFbP2+gMfEvftqcifx?=
 =?us-ascii?Q?brGhUHheKg4V38kJzeBatw5vkbdQlq1u/dm8mt7Vgsf4FinEvNdH1EmXxr0y?=
 =?us-ascii?Q?JYqaUxiNxqAdC0tG6AoL7E5KMhazytkdSIRwHlCK/sABSxi658Yv5v8OSXS5?=
 =?us-ascii?Q?cgKYYcNGN1KeImkSreCr6XweJr4jTe/X2grw+4IQb0xFGw5Y9wifkgviicXi?=
 =?us-ascii?Q?PrOjVSh1A0Keec1mUWmIzb94WPT2oaDqS0YAJNUV3aM8g+D7jCvYENVUSnVp?=
 =?us-ascii?Q?dG309VQXWGLOuTtJ9+Ye1dv6jpC4fDVGE2lQUyTzxp2bCeN23Su0coMXNuc/?=
 =?us-ascii?Q?iGuj8YnAtvW/9dGROBt/46calVPn2nIDbk1wS0wUklsoFM9lBa8RqEJvSWMV?=
 =?us-ascii?Q?8KHI07uaZLm3GEbetQaR4Ql1GuuzxWFybwpQViApLcV1hNtT/ieZEclicVd0?=
 =?us-ascii?Q?VJ5VkXwpyws2toDP/ROTgQsq7OQP1l6i5sGtDQQIJixOafd8IKyCAWWu1eVW?=
 =?us-ascii?Q?QrpjkR9kZR0Yy5nkmRw5eYn/elL67iWGGAVjCV/xD03zTmrJp5FD5MOvPaCs?=
 =?us-ascii?Q?cF3Kv6qZlIc5RxNHcglDa7nWh6uwHeV9PJq5ZQy4cet6eJmu/euAULKYcevy?=
 =?us-ascii?Q?PjYJA/cyXhGed21zV7jTkfTAQRP+0YVG3oZLSJxQVjc2iUZryWZ9Eeisxzi/?=
 =?us-ascii?Q?UNrVuerE+Q7ydein8gAO8MmMkYVx70W9MfPbLMZDnArr8GDKzD19N2edd60f?=
 =?us-ascii?Q?7wRnAFQIq6bqq5DLgCIcQFqew/wHPZgtyauEFTST4XlsVN5SsuIBkCdnHqBy?=
 =?us-ascii?Q?R0SqMFw1Due4z6sWGxiwWqdQ7Id0uCQHULLzU2ttoGW6SPz9fBTAI1MXcJo7?=
 =?us-ascii?Q?xV2+QU6gr8EbMebgL9VoW5z3LDmlO/oek1bhWenSB1JBOKAKvbMEUwo8CFOV?=
 =?us-ascii?Q?AGgBR8t0kYx9U9VJdHvOpSbAMzsmkvf6ebOoXBOvpxDBTr3YqoFSDMpTieeR?=
 =?us-ascii?Q?Qg461yzhDyORzXIt12eTrcNR9vE4toMPo5tuf8yJlPNE+dnfwRHg+/tSn1yz?=
 =?us-ascii?Q?Razw5mZ/YjFh/fOueQQNOb2Mi7tW1gpaLp9GcBZ0wFby/nG2SyAva2MsXrGA?=
 =?us-ascii?Q?5gig7EPh3tgc06L+L/eu90oCuAmvUYtA2ZYpS18lF6lVRfUfxTCyN+pi4OMk?=
 =?us-ascii?Q?1hDHNSSASUyV3c7H1pPLmFxfvH6oRnkwwe1Gl1B564Gqz9Vt+l6XFPtjdN26?=
 =?us-ascii?Q?rb3Dzda+pcotcn1V3M5lQw63kNUecZHOMA+LeNm7zQfasWshnRhgi2NV8xNP?=
 =?us-ascii?Q?L5PGKWRd/AwJvU/3Cfsv3RwCUY8XX5dIXFIisWnmcgJrwg8dDc5QfUX+FzT7?=
 =?us-ascii?Q?UbQebqMEszcfFeoc+Vsg+oeeIr7Pdc4W?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 07:34:38.7969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea9edc0f-e835-409b-8188-08dccb21b3af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6541
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

Drop pending_reset flag in gmc block. Instead use init level to
determine which type of init is preferred - in this case MINIMAL.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 33 ++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |  6 ++--
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  3 +-
 6 files changed, 13 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4fb09c4fbf22..db5046e8b10d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1691,7 +1691,7 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 	}
 
 	/* Don't post if we need to reset whole hive on init */
-	if (adev->gmc.xgmi.pending_reset)
+	if (adev->init_lvl->level == AMDGPU_INIT_LEVEL_MINIMAL)
 		return false;
 
 	if (adev->has_hw_reset) {
@@ -2985,7 +2985,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 		amdgpu_ttm_set_buffer_funcs_status(adev, true);
 
 	/* Don't init kfd if whole hive need to be reset during init */
-	if (!adev->gmc.xgmi.pending_reset) {
+	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL) {
 		kgd2kfd_init_zone_device(adev);
 		amdgpu_amdkfd_device_init(adev);
 	}
@@ -3499,14 +3499,9 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 		}
 
 		/* skip unnecessary suspend if we do not initialize them yet */
-		if (adev->gmc.xgmi.pending_reset &&
-		    !(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
-		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC ||
-		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
-		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH)) {
-			adev->ip_blocks[i].status.hw = false;
+		if (!amdgpu_ip_member_of_hwini(
+			    adev, adev->ip_blocks[i].version->type))
 			continue;
-		}
 
 		/* skip suspend of gfx/mes and psp for S0ix
 		 * gfx is in gfxoff state, so on resume it will exit gfxoff just
@@ -4320,20 +4315,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (!amdgpu_sriov_vf(adev) && amdgpu_asic_need_reset_on_init(adev)) {
 		if (adev->gmc.xgmi.num_physical_nodes) {
 			dev_info(adev->dev, "Pending hive reset.\n");
-			adev->gmc.xgmi.pending_reset = true;
-			/* Only need to init necessary block for SMU to handle the reset */
-			for (i = 0; i < adev->num_ip_blocks; i++) {
-				if (!adev->ip_blocks[i].status.valid)
-					continue;
-				if (!(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
-				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
-				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
-				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC)) {
-					DRM_DEBUG("IP %s disabled for hw_init.\n",
-						adev->ip_blocks[i].version->funcs->name);
-					adev->ip_blocks[i].status.hw = true;
-				}
-			}
+			amdgpu_set_init_level(adev, AMDGPU_INIT_LEVEL_MINIMAL);
 		} else if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 10) &&
 				   !amdgpu_device_has_display_hardware(adev)) {
 					r = psp_gpu_reset(adev);
@@ -4441,7 +4423,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* enable clockgating, etc. after ib tests, etc. since some blocks require
 	 * explicit gating rather than handling it automatically.
 	 */
-	if (!adev->gmc.xgmi.pending_reset) {
+	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL) {
 		r = amdgpu_device_ip_late_init(adev);
 		if (r) {
 			dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
@@ -4518,7 +4500,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (px)
 		vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_domain);
 
-	if (adev->gmc.xgmi.pending_reset)
+	if (adev->init_lvl->level == AMDGPU_INIT_LEVEL_MINIMAL)
 		queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
 				   msecs_to_jiffies(AMDGPU_RESUME_MS));
 
@@ -5490,7 +5472,6 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
 			/* For XGMI run all resets in parallel to speed up the process */
 			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
-				tmp_adev->gmc.xgmi.pending_reset = false;
 				if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
 					r = -EALREADY;
 			} else
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 82bde5132dc6..3dece2e69608 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2495,7 +2495,6 @@ static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work)
 	for (i = 0; i < mgpu_info.num_dgpu; i++) {
 		adev = mgpu_info.gpu_ins[i].adev;
 		flush_work(&adev->xgmi_reset_work);
-		adev->gmc.xgmi.pending_reset = false;
 	}
 
 	/* reset function will rebuild the xgmi hive info , clear it now */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 4d951a1baefa..33b2adffd58b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -182,7 +182,6 @@ struct amdgpu_xgmi {
 	bool supported;
 	struct ras_common_if *ras_if;
 	bool connected_to_cpu;
-	bool pending_reset;
 	struct amdgpu_xgmi_ras *ras;
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 61a2f386d9fb..2076f157cb6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3185,7 +3185,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	 * when the GPU is pending on XGMI reset during probe time
 	 * (Mostly after second bus reset), skip it now
 	 */
-	if (adev->gmc.xgmi.pending_reset)
+	if (adev->init_lvl->level == AMDGPU_INIT_LEVEL_MINIMAL)
 		return 0;
 	ret = amdgpu_ras_eeprom_init(&con->eeprom_control);
 	/*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 7de449fae1e3..a7a892512cb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -860,7 +860,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 	if (!adev->gmc.xgmi.supported)
 		return 0;
 
-	if (!adev->gmc.xgmi.pending_reset &&
+	if ((adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL) &&
 	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
 		ret = psp_xgmi_initialize(&adev->psp, false, true);
 		if (ret) {
@@ -907,7 +907,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 
 	task_barrier_add_task(&hive->tb);
 
-	if (!adev->gmc.xgmi.pending_reset &&
+	if ((adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL) &&
 	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
 		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
 			/* update node list for other device in the hive */
@@ -985,7 +985,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 		}
 	}
 
-	if (!ret && !adev->gmc.xgmi.pending_reset)
+	if (!ret && (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL))
 		ret = amdgpu_xgmi_sysfs_add_dev_info(adev, hive);
 
 exit_unlock:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 16fcd9dcd202..7225f63c26b4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1616,7 +1616,8 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 			break;
 		default:
 			if (!ras || !adev->ras_enabled ||
-			    adev->gmc.xgmi.pending_reset) {
+			    (adev->init_lvl->level !=
+			     AMDGPU_INIT_LEVEL_MINIMAL)) {
 				if (amdgpu_ip_version(adev, MP1_HWIP, 0) ==
 				    IP_VERSION(11, 0, 2)) {
 					data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL_ARCT);
-- 
2.25.1

