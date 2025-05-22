Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19D2C54F2E
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 21:56:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D5AA10E2AD;
	Thu, 22 May 2025 21:56:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F2Ecf+UD";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEDA310E108
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 21:56:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Admn4uXlMvm8Ai1RVpRg9O3JZ4foieMg7V/3JdAlE0Qbvdq1IGuNmoyhjtgdPtUq6Kd+dPG2JiK2b/iEjmnl0/gLTBFmlduj0jn0NNURgrnjSaRfR38Y04Nk4Z8QavgCpK57459ifvpohi/nhLEm/diLob+SGjCpn71Z8aY4jbHPc0Ga0GvhclRXQHT2df33v4q0FL/ly6D3b/ZBubAFVA7XaxBvTodW/errzRN4qavDWan55UIuCo75hcfWg6IGj9o5Z/hcoF5/sd6ih98GgdOPXoSMSB5KE2v8B00SNzRuMDhSuq4PXy/Sbtc+sEmyMFhPtZlTi6E5vnamX1cH8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71bdOAM2gHVF1SMu96IAZ1FMVbGfbSfmZFMrRsS76YI=;
 b=JbkavZhtUKFk01T7uz7+Uw1vyS5MiiNzPjDu+UiVr01Gh1yeeoYlT3XBVJm+P+CKhOrJXAHsgGc79lwFCUApJBKtKFjHVhG10wKVgvXrvZOw4vts/Lk/PUkro+qpfs/QEZCiX3llaPp3PRFm0Rj5uiKeLgDsu3h3KlPGRrYMamC/OZFPFTTTPxRxnPBHUwl5zx4sSrrsQM6m9Qe8tNwsfp4EoeB+qnbStLar0JC+KDJrQg8AXI6Ct4cHPed+EI996PDHXEyulxIHj6qctIeiN2VUao8+oXUqnv/fyD1U5cZdnKbsEn+ds1xbtAKBQ+8Xw6pGHk547lwI2T6TGLHh7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71bdOAM2gHVF1SMu96IAZ1FMVbGfbSfmZFMrRsS76YI=;
 b=F2Ecf+UDzlN+eUy7akUaOdCKH5k0XkBaR0o/KqBMkseazwm/BJSenRv/xBb3gbsaT2s3Vb6tbTVMGjmHbJoEv8Gg4Rxur/3VoKOj4wtrlLTVCuqn51LNBwy17+zpQguEZmTwnjzaLw88rXawZzCoyqW5oVha3wE415xDAPMtRiI=
Received: from MN0PR02CA0030.namprd02.prod.outlook.com (2603:10b6:208:530::20)
 by MW6PR12MB8757.namprd12.prod.outlook.com (2603:10b6:303:239::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Thu, 22 May
 2025 21:56:20 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::e) by MN0PR02CA0030.outlook.office365.com
 (2603:10b6:208:530::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 22 May 2025 21:56:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 21:56:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 May
 2025 16:56:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/10] drm/amdgpu/gfx10: drop soft recovery
Date: Thu, 22 May 2025 17:55:59 -0400
Message-ID: <20250522215559.14677-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522215559.14677-1-alexander.deucher@amd.com>
References: <20250522215559.14677-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|MW6PR12MB8757:EE_
X-MS-Office365-Filtering-Correlation-Id: fd86ba8f-fe98-47fd-80e8-08dd997b7c3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pnWSqFYczMA3WjgMCt/ixvGLGg+DFDTbfLaxaH1zD3v55syHAGLdcLHqM3bI?=
 =?us-ascii?Q?maR65bNRXT5S4LcQnmrnWB0ZSOV+SsCW6gJ4J2uEv2l37g8dxnHCalh6iX/V?=
 =?us-ascii?Q?EJGooK7X6XYP5loF796lQxgWKHnuRBdkM4V5gvfGBSFG6NyCOiBdW6OnPmcC?=
 =?us-ascii?Q?fKqEYRGHk6PHcgsCaCm7yA/u9NzvuWtKH0GcYrwEh23ScEc9JBFGfFFI9Gg2?=
 =?us-ascii?Q?++TMLC80V6zM/KPkhFxuE88btwQBt3yBNRhHDoK6brhWntY1HAeKJN47CmeK?=
 =?us-ascii?Q?sEGp/TKDQxbeNVpQucYFAZoPMw3Ps4brysd6m8en916E0tIRFu3fyV2fP8Vp?=
 =?us-ascii?Q?g3bkqoE1BMsU0NF0DA6S0lPCEQ5lIiLgJP/4RIj5QM6VuULt2HAio6/52N6u?=
 =?us-ascii?Q?OY4S7mK3EnnL0AHjulvc6bxlXoyFSD/AU0RTbJ6LtWgZ52+/e7Kd3yIpi4YE?=
 =?us-ascii?Q?T9BR6G4SQonYN19LCEMTJmF6D5H9KC4miceuYrRv/rrr1mZw1ZqVWqp6Hg+o?=
 =?us-ascii?Q?/LPC/gH65mZ4q2jH3tpCWMBLgKshK83NLxWNeTKd4/+1Q77q7L1iPpYnKsH6?=
 =?us-ascii?Q?ZdxcpAE/N8HLOFd60sGncW7fIDEb1FdWzC7fwbaKR3DaXi71YR3V5sZz0Ya0?=
 =?us-ascii?Q?BFPIk9vJN5rRMxtzGU3nhpiJRacO1LLmLQMNv1stGyJsmcn+rEmYCjwbuBPd?=
 =?us-ascii?Q?2PiJspZ5c+7iqD4jY9OqQC3OVIXU62cCDTebsUQRm5RdWuLlF/jkmTORwfvX?=
 =?us-ascii?Q?uHdIZPBJ8vXPr7eyzsq0yGNSMUdoq4DTdM2asvJELaDvaZTjFz8XqFnmaqHv?=
 =?us-ascii?Q?JZ58uqWBGmUHvd2FeHIh0X6AyMylamyA5EL6CbUxtQMpPXi/e+TguxHuMuBI?=
 =?us-ascii?Q?jhmEctpb09zRx2lU6Y9py6EwZYmfv462FaiJunpbcUBNrkRvOVZfmkYg6HVk?=
 =?us-ascii?Q?l52FZ0Jxf7dO2fm5Q0U6S+emmyWb0cqQjB4gnbdGHp7/xrVXe2angiEqvl7O?=
 =?us-ascii?Q?R4SoggPl6oxZF8teMg5PQy8zaVppKsZ/ZEFPPCwSwwVa7tHp3F4o0Cl2ZR7G?=
 =?us-ascii?Q?wNZBKfavLn1mFgK2sjmlN3IGHJOeFRQVtBp98gG5Q+GMS7oA46ONp9POJMg+?=
 =?us-ascii?Q?qVSn6tErekaFSUXuQOIrYXayA2jupgJwy5cKPXPNQxVrSyBB9E49tY5GfC3G?=
 =?us-ascii?Q?aUg7nS6K23r8IiyAdQuzgJ6GXE70Z2IiTChhQOJ/aTySRsvNRV6wcKVRzXVA?=
 =?us-ascii?Q?EnyRiQ7cV4LzEjdthjmvsT6olPQPbVe1igZiPIAKfFd6N6y4FyTm9nAagENA?=
 =?us-ascii?Q?KPA6/qBRWvnKFLsMP+eamo5vH+ha8XMu7lqwXrPZb1nhKyyAYtwkwHY1riIZ?=
 =?us-ascii?Q?II2HIvvv8EJavQtQs7hw6UGtuTkJIFyQDUTN6ZlFUgcf0IPauHPo32kXxqB+?=
 =?us-ascii?Q?olrMocA57Jkq47c0Pi4idR/6eLxxvUhtfBEAhx+H3eKsuRCYBExwS/pU9m1z?=
 =?us-ascii?Q?dOBUGiX1xRbNbjHlIayVnFABI6oe+BGTUJq/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:56:20.0625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd86ba8f-fe98-47fd-80e8-08dd997b7c3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8757
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

Drop wave vmid kill in favor of queue resets.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 3d2eab585b64e..4ae49e6c7254f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9048,21 +9048,6 @@ static void gfx_v10_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 							   ref, mask);
 }
 
-static void gfx_v10_0_ring_soft_recovery(struct amdgpu_ring *ring,
-					 unsigned int vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t value = 0;
-
-	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
-	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
-	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
-	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-	WREG32_SOC15(GC, 0, mmSQ_CMD, value);
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-}
-
 static void
 gfx_v10_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 				      uint32_t me, uint32_t pipe,
@@ -9882,7 +9867,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
@@ -9923,7 +9907,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
-- 
2.49.0

