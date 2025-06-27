Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610C6C7EE31
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F09F410E938;
	Fri, 27 Jun 2025 03:40:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aOx8y8uM";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FFA710E945
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anBguMVJTUqwkmKg+lCocF6+AeqCHRpXo4DrgfkoDyK5h54HqS9mOJKQXvTyZW8aVY4vmiOZrHx6gVS6Y91+cJWrRGdG1cOURumOzr/YLOwuhPLJhcJmU2PvAoPBxmRtJkEi97MblWIapFygQJsV0HbHEtqXgIiYTa5tlL9F5pukgF+a+IHo+3gPsx/FNdOCNVviH0b0rYNnGzbrSG/j2bPiOepc/ymmVTxd93dA8eA//HFwbjuIrYcobuA4pmvB2dMl/JwSybOwgnBnBsgd59lsoWvzPyBu1K9JzCNUJrsc8rDG1+T1OoUU/sKkTI8gLXxRfCI7sAadJKzuiP8qhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJQr3O1XrRhTErH+ycjps79272+j6UfM33GnB1s4WEk=;
 b=CGu5tX8grBJatNc536Qjwv++HtGg6PS2kNENxwMj3LRxsDJTsfF3reBKWhx9ECQ23RfnbVp68cZ4ZSwlDr7rIeJ3Uzk/ZOTqkbGmzLMqNbE+ItyuMyVkNL7kQcEfen1f5QaVEiHCxMZ8v3DDgbJ+JF8TV0GGAMooQl0+n532y0Z2tFHhqnFj9HnoBnFHj8NJitu9loVOuF92Ar8tVr/wjko9lpij6wDh1n5syzhJx1Qd5KVgKRbbJmC2+/tf4gBc6MAFXgDIjGjq3VZZSuTT6bUBSdJo9rllQ5J+IJfvIBGV5aGTrhW31u29GaNbV2J9bQ92Mta2vPiFg32nRSKgPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJQr3O1XrRhTErH+ycjps79272+j6UfM33GnB1s4WEk=;
 b=aOx8y8uMIHDhtNzvfn0tEAqRR/QwSLuK3OmixMhtCXflnaJRhQ9RsXykGN1mHseWMkpbzs9hiF7MJKMM6Dskc4crGQcAEEmrJACJrQSxS+SvBH84zQGwL5taowBEXgn3jlZuW5/XFM9LD/MT9kqthXa/+J8X50o+WqqgMpsPvT4=
Received: from BL1PR13CA0197.namprd13.prod.outlook.com (2603:10b6:208:2be::22)
 by SJ2PR12MB9209.namprd12.prod.outlook.com (2603:10b6:a03:558::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Fri, 27 Jun
 2025 03:40:42 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::ab) by BL1PR13CA0197.outlook.office365.com
 (2603:10b6:208:2be::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.9 via Frontend Transport; Fri,
 27 Jun 2025 03:40:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 31/33] drm/amdgpu/vcn2: implement ring reset
Date: Thu, 26 Jun 2025 23:40:00 -0400
Message-ID: <20250627034002.5590-32-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627034002.5590-1-alexander.deucher@amd.com>
References: <20250627034002.5590-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|SJ2PR12MB9209:EE_
X-MS-Office365-Filtering-Correlation-Id: baaa98db-2d70-42f1-a172-08ddb52c6431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rTsdyzz+MwWE2wShChgrpvWicW0LvEb9VUlSEX1COhHNn/RMSoPetDfBnW0B?=
 =?us-ascii?Q?z1Yp7L1acy/ZzDCFCRd93Ljnxs7GOpqF3XG+yCiGgYIv8zxJsFSys3/Q2UXE?=
 =?us-ascii?Q?Fa1Afx7t7wijHrFkksjP37edTkzXPhOX0Mj2IdgVDb+oWYsMWqkCJs1pDOE5?=
 =?us-ascii?Q?uWdy/nmX2yCjelYBM4vgoq15VjjVd7Fa0ch+3UJVXX0F4UwMmhQCBMby7i1o?=
 =?us-ascii?Q?EM7Gb08VnEJZomg9Ob/NX1obdH2JlnId+FbSk2ZLTn1qknv+d747iZZaSR2c?=
 =?us-ascii?Q?MVyHrlaMomstAO7EoftpQb/cjTwNncj+jfGAImehY7yHkaEmQm/LACtMFSiS?=
 =?us-ascii?Q?NVmvb96aC/VjZB7/dQ5N+brEMCE6av9ikvgncoYM8jDG3AXC9N+zO0sJAObK?=
 =?us-ascii?Q?314BH/QL39ykgqlN76OVUE5xCYwjLhGkTdk0d/dpKwdMnHhgzbcESzcLNbuz?=
 =?us-ascii?Q?0G6/vkMh3LYQSX1wc/haWRY2LlPQ0rCWXqLPUbeFPlcetoXXsFmFMJ+u5s25?=
 =?us-ascii?Q?/BWhkj7QrgbXtM9Ll5mccoinY35q43AhSN2JD9mCVPI+YRCj6P/PF/J2620i?=
 =?us-ascii?Q?CkdRoLQQXxtdcovssUdQej7UyjWIlrWXC2RMk/KvcTUTmAmuFmETWvfwJnau?=
 =?us-ascii?Q?XWR5+irkkChhVpX0SZOoDZMvaFp90wZA08do6JgBjkmAfE1dODqw6i7az2qr?=
 =?us-ascii?Q?QCLjT9AunT9/YWUiJR8fGlesvm3Mkhg1k4GaeUawgNgnYXkVXfZ6t6fOIxVn?=
 =?us-ascii?Q?zIO19uVVTL3S2fA5sXhYBb5vVSULp4VgGTVjd0mAPaIi8rpPz73QftfL0e+Q?=
 =?us-ascii?Q?0YtvznarI9EI9an7uq7dlYWsWMRG9wS8ZkIPhXVG38L7qyWYHxgWxc6prySV?=
 =?us-ascii?Q?hiYNZB5hCJC3Er7uadOyDrEI6aDpL2SAKaMm1boC9LWCTj6EMtZQx6+pMXOM?=
 =?us-ascii?Q?xRCH9bdA2BZAcJSs2dD7j/bh9FEA71qtz6VuSwVFKI8nAJ0sMO6TiQXgGvWL?=
 =?us-ascii?Q?nBeh5VJFOnBI3FtGWyyAy8eB1M4XMr/XVbebqgNtbQFvjeP/kmsd7B9J19Vi?=
 =?us-ascii?Q?vsfiig13hoT1iwMhCDkBNaRX0rQAZCCEi45rCOg0mvhwTAHHhzi2EzD8ttHp?=
 =?us-ascii?Q?WtIAQWqs24hm9UvRZEWcKk0zPoRO4a6sjfIHz29ELOiRnTes7L3PTCJxBqN9?=
 =?us-ascii?Q?20x9a5/9Hx/aznmPE+u7ObFNqrEasoxtfuJt00puGywKXSE4d1428bwqnMV+?=
 =?us-ascii?Q?n9DEsH26eyoGkVaUfJH1xFFryygmXCF5LOelSAwMlydGxtEQmE7JFMBTJqml?=
 =?us-ascii?Q?SeF2y2DEi7FowU4XTIdAB4x3leL2bLoJmIdfKIzunEBDFhCYopbJiAX/eU3Y?=
 =?us-ascii?Q?povyOQQzX3CGXKie/wm6/DVbLVT72q6GUBWGkzwBeEzwFHIg1z6IvnKXlulm?=
 =?us-ascii?Q?qA+5Uuo8hagJ6kALewJCp5pJHVnlj+9jJ3J8H56QHsjBtN8aSsu/f20aIzX1?=
 =?us-ascii?Q?FgfFq5jf5zV+qVevuK4EBKOVtANtFFnnT7z5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:42.0151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baaa98db-2d70-42f1-a172-08ddb52c6431
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9209
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

Use the new helpers to handle engine resets for VCN.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 148b651be7ca7..33d210a61483f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -98,6 +98,8 @@ static int vcn_v2_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 static int vcn_v2_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				   struct dpg_pause_state *new_state);
 static int vcn_v2_0_start_sriov(struct amdgpu_device *adev);
+static int vcn_v2_0_reset(struct amdgpu_vcn_inst *vinst);
+
 /**
  * vcn_v2_0_early_init - set function pointers and load microcode
  *
@@ -213,6 +215,7 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	adev->vcn.inst[0].pause_dpg_mode = vcn_v2_0_pause_dpg_mode;
+	adev->vcn.inst[0].reset = vcn_v2_0_reset;
 
 	r = amdgpu_virt_alloc_mm_table(adev);
 	if (r)
@@ -1355,6 +1358,13 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	return 0;
 }
 
+static int vcn_v2_0_reset(struct amdgpu_vcn_inst *vinst)
+{
+	vcn_v2_0_stop(vinst);
+	vcn_v2_0_start(vinst);
+	return 0;
+}
+
 static bool vcn_v2_0_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -2176,6 +2186,7 @@ static const struct amdgpu_ring_funcs vcn_v2_0_dec_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 static const struct amdgpu_ring_funcs vcn_v2_0_enc_ring_vm_funcs = {
@@ -2205,6 +2216,7 @@ static const struct amdgpu_ring_funcs vcn_v2_0_enc_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 static void vcn_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.50.0

