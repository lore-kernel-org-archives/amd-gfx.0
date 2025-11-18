Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9EFCF2560
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 22:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72B8810E20B;
	Tue, 18 Nov 2025 22:55:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kIpkhsc4";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011067.outbound.protection.outlook.com
 [40.93.194.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 655C510E20B
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 22:55:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g65pIS+mtoYfvlUdnjO/ZOZqjDDbJTMOMzpdnLZq9RJKwHVXBYeYFOucgSaCDMHNuvrl+yu8PxcHZ6GQYBbIKPYlu8FeMHEYO0tyPPGip+TONVkKQ6ptoZz/6sZN8VGCH/OmBT78aBW8BEd3hajfE5a1S/xp9wsGFAELhldyP3sawDhVzJZkPAXVkBkJFC71z3wL8RFecSVBUIe6GDxBDNANoeMA34yddAJzSFc6uJ61JjKDnNuWxHj6/HEbj/bqWuVRCdQ1J/p+KFmZd55SMUShvv1IkHgSvtoltylzl3b8VfvmJHTf+7k7/o41N3RWZF1dnYl2sIl7qdgC97BZfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GECePgLxAfXGGRp0gnDcb7HNl82M7CT7THED9SwpDPw=;
 b=aATP0t5h9WGBa8WjYGwBEP0FuJWcSivDcQ0ptZpUY+F142bbWQ5Qh8NxYhvSreQZ/P4d+xCBamRv/d+ME1blqZaYQ7bF00Vw1dG3lmOg0c8RyaVKaAHxDzJUm4yBGbE/7Muh3riuf7bRf/kzk8lo3h6BRp9WBl+PZuo1Wn2taTbFju064K6liAu2UBA2tp5W6n2TjECU2x2OLxamDVft5nfjp0pqsa2xokPz+zznxRU2yWg2zetKEh9knHS0XIXNSu7q9ahnWWZoHTcoEJUgX1+9y/iGcTsA0vMlG+ikSZWgsUq9A28bBj7C8wtRT3uctoW2Sn5lO2VmByga1qLQZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GECePgLxAfXGGRp0gnDcb7HNl82M7CT7THED9SwpDPw=;
 b=kIpkhsc4GkBuwK/Ab75GKK53bCiBc3bZi8pP1CEmVYffZKQmHMGkmytHcRStdZC+7DF1zGIjz+Np7SkcEeGk4dmJGK4evx6obnbXHZLENG7uw9BMoSJIsfbJxlQJZwizvCRhlUY6pgGIZDqs6z6B2J7qvMmAjnXpFK2ez90RnVM=
Received: from CH2PR14CA0048.namprd14.prod.outlook.com (2603:10b6:610:56::28)
 by CH8PR12MB9765.namprd12.prod.outlook.com (2603:10b6:610:264::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 22:54:57 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::70) by CH2PR14CA0048.outlook.office365.com
 (2603:10b6:610:56::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 22:54:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 22:54:57 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 14:54:56 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Feifei Xu <Feifei.Xu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: update psp_get_fw_type() function
Date: Tue, 18 Nov 2025 17:54:40 -0500
Message-ID: <20251118225440.3613071-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118225440.3613071-1-alexander.deucher@amd.com>
References: <20251118225440.3613071-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|CH8PR12MB9765:EE_
X-MS-Office365-Filtering-Correlation-Id: 0077b802-9605-4c99-f68b-08de26f57f0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cvJPcjQM1A0kbP3lYWYVUFM1koAn81FgvvfZteg40o6SnbPBaR14VmSsL718?=
 =?us-ascii?Q?MNDX+tm/gspNgbmzWNmxYhCjX016mlHtrlFuX3VKWxQKVy+V6A+onmL++dpc?=
 =?us-ascii?Q?oWteRMzbz38M6hFruUgq4I5BKjys8p3YukCEKgZE120jBJMBVgO+96uUryrE?=
 =?us-ascii?Q?W1a65w/nEVZEZ5KKKjMsV3rqW03DHDodLy/s4xV95dspyzwnGGRSkZKFwJEN?=
 =?us-ascii?Q?UwvbQgOmpvVv7LkJmCzQ11BWp48koXRyAx/x59gMTBHpgbpd0EUA3jPPd8vs?=
 =?us-ascii?Q?e36dX1DVVDj4jclxB0FzAHPm1FCfN7A+7WDuSj8ce3TEGgS81+9VKjhCwoXh?=
 =?us-ascii?Q?HnU6cK0mqrjaqNJM3vEUfU1alU94kQahaE7XDQ+hHiBK6vG+DmgsKZhG6yDQ?=
 =?us-ascii?Q?Io5fa18mEfyN56+X2PzY0y6tBCRg5XWN1JQmx9z7KiZW/90YOIL8/+Bh5I+F?=
 =?us-ascii?Q?OIPzrHCjLAG0Zinmhi911Gj1mxSbm6YWBlYjP2DrtyUPZyxkqqsSAOo8Re2P?=
 =?us-ascii?Q?Ottp7fYfX+DSFzgbHbapSv8fH4YZ6SBZCCXyRlgno+VAchTDo96PP+iJsl6q?=
 =?us-ascii?Q?4cjzw1zgSGTDUPDKjm4E9BZibc7/HOPCZXYUHX9l3mHYAgwh+yPVTwmEuE42?=
 =?us-ascii?Q?vKkMfweb0jnUTZQT/hH0XBxWnmcR2x1ebXXhwzBtJM2AI2o6BS9I7iPSdA1g?=
 =?us-ascii?Q?A/yYjI9IiaN67DB9NsnNyHpyzfcHso/Gr3rEoCGUuo6drI0sSKppJd8XuLBe?=
 =?us-ascii?Q?hoMS47fCQ8zQoIyPc7gT+lLUpWc410jx2F33aEHe3P3GM9UrWaU7b7ODT6lw?=
 =?us-ascii?Q?5/aCd2NLGEb0foDaw/rs2++s2poZVbVhQ1jhQBv0WmMbCqXhzT6jtsJXJtAB?=
 =?us-ascii?Q?sRc9n+08NKeULUfAuePCUhZHgZruOFex7g8ApdpxkL+m+Wy8EFynk0VImOU2?=
 =?us-ascii?Q?rFRsmDF/vBUI7WBEq/8tdpmK9s5vZURksuS70pQ4WjBJNH3ScxMKRzVx8Xdf?=
 =?us-ascii?Q?Ri09VFcTmnLNPNfpHrIxTf6oSEWKlweQsqCx4HdYTsAqVQkUr8J4THDL1Zw4?=
 =?us-ascii?Q?GzqiYr2gvlSESwRMR5atd8JfAf4DYO+tZtfUQD5dfWNEZ7C2McOOkeFDMdiS?=
 =?us-ascii?Q?14F4JFRiNFo5OOJPtnb2pcHqKOYo5ii5xDG7ZmqYql2hH7WJz726r4a/d6OP?=
 =?us-ascii?Q?3mZg3la1Fs7JPFFRLwHspB2+0jQhvPJIYk42gJXymOpQ9KHoDDoI0IZywmWx?=
 =?us-ascii?Q?PtqubHANRP1VO/VjlVx3n7noJmGamOGHmU/3tqsn+vcZjEB70XxeUzo8FhXQ?=
 =?us-ascii?Q?JOlS2ugh8dVw3u8hjeDuEPlUFmv+dB35weXP5mlTtPNnMbyHZsIZ6c4UdDj/?=
 =?us-ascii?Q?G7Llz4OEP9lJCyaCN0rgEu6XCN1omqPsN/N0p0xhk/WPn7QnBkb9ronUEumI?=
 =?us-ascii?Q?s7Wf1zDjp/anD8airVfPCGsXs9rU5McSz5sO+0uB9AWJmr1686jP9UHVC7IN?=
 =?us-ascii?Q?WsTsFkGIE4WZFzpS/N4EJKgKfKPZdEtLOXv/dTHbMOEoRYlR+gUKaofpV0rr?=
 =?us-ascii?Q?dLp4oDJ92GL4w+nZkRU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 22:54:57.3250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0077b802-9605-4c99-f68b-08de26f57f0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9765
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

From: Feifei Xu <Feifei.Xu@amd.com>

In psp 14.0.7, mes and sdma GFX_FW_TYPE have been changed.

Define a psp common function: psp_get_fw_type().
Hide the GFX_FW_TYPE Changes in each ip's psp->funcs_get_fw_type callback.
(like psp_v14_0_7_get_fw_type()).
If no GFX_FW_TYPE change, reuse the amdgpu_psp_get_fw_type().

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 8 ++++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 0c32d27cf2b34..480a3c6ae13b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2631,7 +2631,7 @@ static int psp_hw_start(struct psp_context *psp)
 	return 0;
 }
 
-static int psp_get_fw_type(struct amdgpu_firmware_info *ucode,
+int amdgpu_psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 			   enum psp_gfx_fw_type *type)
 {
 	switch (ucode->ucode_id) {
@@ -2919,10 +2919,9 @@ static int psp_prep_load_ip_fw_cmd_buf(struct psp_context *psp,
 	cmd->cmd.cmd_load_ip_fw.fw_phy_addr_hi = upper_32_bits(fw_mem_mc_addr);
 	cmd->cmd.cmd_load_ip_fw.fw_size = ucode->ucode_size;
 
-	ret = psp_get_fw_type(ucode, &cmd->cmd.cmd_load_ip_fw.fw_type);
+	ret = psp_get_fw_type(psp, ucode, &cmd->cmd.cmd_load_ip_fw.fw_type);
 	if (ret)
 		dev_err(psp->adev->dev, "Unknown firmware type\n");
-
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 237b624aa51ca..8f8578054191b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -172,6 +172,8 @@ struct psp_funcs {
 	bool (*is_reload_needed)(struct psp_context *psp);
 	int (*reg_program_no_ring)(struct psp_context *psp, uint32_t val,
 				   enum psp_reg_prog_id id);
+	int (*get_fw_type)(struct amdgpu_firmware_info *ucode,
+			enum psp_gfx_fw_type *type);
 };
 
 struct ta_funcs {
@@ -524,6 +526,10 @@ struct amdgpu_psp_funcs {
 	((psp)->funcs->reg_program_no_ring ? \
 	(psp)->funcs->reg_program_no_ring((psp), val, id) : -EINVAL)
 
+#define psp_get_fw_type(psp, ucode, type) \
+	((psp)->funcs->get_fw_type ? \
+	(psp)->funcs->get_fw_type(ucode, type):amdgpu_psp_get_fw_type(ucode, type))
+
 extern const struct amd_ip_funcs psp_ip_funcs;
 
 extern const struct amdgpu_ip_block_version psp_v3_1_ip_block;
@@ -621,6 +627,8 @@ bool amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev);
 int amdgpu_psp_reg_program_no_ring(struct psp_context *psp, uint32_t val,
 				   enum psp_reg_prog_id id);
 void amdgpu_psp_debugfs_init(struct amdgpu_device *adev);
+int amdgpu_psp_get_fw_type(struct amdgpu_firmware_info *ucode,
+			   enum psp_gfx_fw_type *type);
 
 
 #endif
-- 
2.51.1

