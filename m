Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8908C8303F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 18:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 629DB10E639;
	Tue,  1 Jul 2025 18:45:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yvLfCzhk";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3020710E636
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 18:45:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WaRL24VA2StmiREXYTsi0JWcdStjErCSogIQl4JvmdzhaLlanhtwU7xpjgxpiGs9oa3+LGY+PmAOD34hKs4x7f8ZtQl/hSzAK4miTSPYepeLu1dfzJOCjOWaYJ+87/VqsLQ1DCpb7+InkixKgTKsQ/thZNNulFawh80Ds7NapuSEBRk3bc87h78+foBTPmmnMKVfKwfv4tVVTyJzP/u+Zy/f1eIIK80RlKUPIdG2603UXiXO4Z/mhm4rM52WgYGvhwPXv36Wl9FIgwmhWO3BN/9izi0b1fOO86E/0oq08vEkqAJYUtoHn+5zC3/GWTVGtq9LaUk7aIkFz6vaOQrILg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuuxQp4wlhePGcrzezl89et6gR5vKyp1HWv0A8c8vkk=;
 b=ROGIZHetnUCbP6BjddWlBjT/qO50s9BOvSNpQPoYf+U+CwAEWsYlxXQUHHDWyv5uS+AYzsv86H103I9eDHwk07lrj8MTK1XrDgj6+Y0lzMOXaVUB0LnrSxCAnP9u8NlaXqAcI8UpXXbhguFvPWRtGeUvFW0WCdIuMM/HWVJpQXwb2i4fjU665rTeljFaM4uTpzx5C77aSe8BAlerO3g1nfRFNJZQezXA2U0MEPNZcg9vmCIfVzajfCBp2jWHAw1aWzQ9I/e89HnpaBU5aDMKPiBmkJ6y+TrL1Twf2xY0F/jpKhUatzMERi7qCA0x6yR/bv/RZpvOMFhXT19U9kULMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuuxQp4wlhePGcrzezl89et6gR5vKyp1HWv0A8c8vkk=;
 b=yvLfCzhkfsJTyRuwdewerrbvtbmLVQQOn576MtjFSOQY8d7VfrzLVAjceE1Mz5lMh5FjjWAnANx9THXMhxI0ypBYVJWhETykhHX872pnRuvlhJHCMGvdd4eoUyq54iJkixJ3MorgynkTWoOsCTaS6YWgIMR+G0mTkCIDZ171fzg=
Received: from SJ0PR03CA0135.namprd03.prod.outlook.com (2603:10b6:a03:33c::20)
 by LV8PR12MB9154.namprd12.prod.outlook.com (2603:10b6:408:190::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Tue, 1 Jul
 2025 18:45:22 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::f0) by SJ0PR03CA0135.outlook.office365.com
 (2603:10b6:a03:33c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.31 via Frontend Transport; Tue,
 1 Jul 2025 18:45:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 18:45:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 13:45:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 27/28] drm/amdgpu/vcn2.5: implement ring reset
Date: Tue, 1 Jul 2025 14:44:50 -0400
Message-ID: <20250701184451.11868-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701184451.11868-1-alexander.deucher@amd.com>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|LV8PR12MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: bd903259-fdb0-4250-3039-08ddb8cf6f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hJLtoy1JI5TdVcB0ZegO3IMu4Ug9iOdArEZ5kALVUhUpdTZdl7rmGNZGHDqu?=
 =?us-ascii?Q?KqFK79htx3GB2NjoUrnUhq05Ob9Nz7NOQSR8QXHpEDtSMVsl93GGv0zTDeiX?=
 =?us-ascii?Q?K8oGq8RFT7FvvmcNGJGKWBtOjqj0j1o3Vzl7hkiKOCrImVzPhaMBqR47KopC?=
 =?us-ascii?Q?TjHS35k52x3SVZc4OhdFc3UfHW9IIylaOqeBiqWLIJzOhKFC0m3DAyxKFSCL?=
 =?us-ascii?Q?hg3OBlPkMsViXoJjlbp1+9PaHz/XXr+Obk5Ka+IOvwm2Mbb2iF7bJPuQgNgo?=
 =?us-ascii?Q?uSs3i2feSHMrk24MdkbJjBXAG1FzmTiT9twyrp9WmkBG4c15PEqluQbGUJQf?=
 =?us-ascii?Q?G2n90IRowddFHpTmAby3dbt4oakDOObzVC9RTPYz/09CuQ3k6TXv2FHXzaVX?=
 =?us-ascii?Q?Sauef5HZEZz/ZXqVY+MDkMpOH0uYNUvlIPGZRk0auXfeWnj2NwSHTjEckrLh?=
 =?us-ascii?Q?e0FDdQ37TrahizUdUcW6mIcK5lx4MOTGR6N3g311aU+vWrX9y+HW3a3PUpz9?=
 =?us-ascii?Q?JmOK2Xt0SMLR7/d+2jqKgboH3mZW7Fo7OvVfwNy9GtKrrHSpbjLl/V2ZOwVt?=
 =?us-ascii?Q?BmyueuAS1pdO7bXrAIHJiQYVf/o338ElW8dak3bof21fufhuc3kDvpY2Alyo?=
 =?us-ascii?Q?zjrfdXjGg8uHv6VR8mQuG8MVdwkzVORuTF+sRK/JmrFK+Hr3ozOuqdm+LVOH?=
 =?us-ascii?Q?vFLtIZurFn7ZUZz20JkuWDxi1sTX9pGsLNkjRvXw/4KF3y9bmxN68tivaZMA?=
 =?us-ascii?Q?Bj4vYL9scxg/ht3tlxtVpEd0S19aOhSKmxUE9Q+ZUWjK/s3oDkM1in5MHvEp?=
 =?us-ascii?Q?ohFE+zUJ/zzfl40jtrg5d3DEji1qoXH5GsnhWDJcoeKAK0OWj31VeFTIQ54c?=
 =?us-ascii?Q?pX+iEZyPBwTxn2bInxOtFczIVbvbwTw20ygCkr4RHOJoVDFGwA21H+SH7Tks?=
 =?us-ascii?Q?29JBw9Cv5ljVwJOADUzkeaJvQen+HotOjCHWIKCIx1unabx4y5FnrLpq9DXx?=
 =?us-ascii?Q?/KLKxEmXx27b5eI5Csontp6cNV/AWhfd5Cncx6psGzvyOaZJx+EIOjoqIbBY?=
 =?us-ascii?Q?/l3kLvzXqnOMqd6RB/mpAyrVnYvqBQwvfsLdpXIpejwo2UAr0NjktV5lrCq3?=
 =?us-ascii?Q?rVaPQX85nY8SVywWTReA4anOCb7nlYpVLBsN6LJKKwwPiIVXUk/wO6s/RfbH?=
 =?us-ascii?Q?vCvmoAO6cDkcI4YdNa08lbdiisXL/zY0CzaWyMNstE0Px5Fi2WcE84Mpy42K?=
 =?us-ascii?Q?7MYMfMScgHp0+ZX3l4+og/ki32gaSICYu2/6K+X7edqSsvcdK4thK1xpeDD0?=
 =?us-ascii?Q?DJaAwJla5LXIxtzVJ026LCBn5MZXnyow6Io81SYKBtl56C+fStgG7hLa9omJ?=
 =?us-ascii?Q?nG2g1seorFqLfPVaauNSxEWUIciQbyHLRMnzGBEr+VHG2AAhqvtzv5MFh9cW?=
 =?us-ascii?Q?w+TAjMs9t7/bgy7YBrcQ6rVeG5YlYA7xxw1ncH5nLu6FkBXU/19O1M3xSQKo?=
 =?us-ascii?Q?DGK/0ijVWHqKTGNj0i+qnh1CIedG0wegwMyF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:45:22.0588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd903259-fdb0-4250-3039-08ddb8cf6f53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9154
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
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 58b527a6b795f..49ec4a7775f90 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -102,6 +102,7 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				   struct dpg_pause_state *new_state);
 static int vcn_v2_5_sriov_start(struct amdgpu_device *adev);
 static void vcn_v2_5_set_ras_funcs(struct amdgpu_device *adev);
+static int vcn_v2_5_reset(struct amdgpu_vcn_inst *vinst);
 
 static int amdgpu_ih_clientid_vcns[] = {
 	SOC15_IH_CLIENTID_VCN,
@@ -404,6 +405,7 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 			adev->vcn.inst[j].pause_dpg_mode = vcn_v2_5_pause_dpg_mode;
+		adev->vcn.inst[j].reset = vcn_v2_5_reset;
 	}
 
 	if (amdgpu_sriov_vf(adev)) {
@@ -1816,6 +1818,7 @@ static const struct amdgpu_ring_funcs vcn_v2_5_dec_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 /**
@@ -1914,6 +1917,7 @@ static const struct amdgpu_ring_funcs vcn_v2_5_enc_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev)
@@ -1942,6 +1946,13 @@ static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev)
 	}
 }
 
+static int vcn_v2_5_reset(struct amdgpu_vcn_inst *vinst)
+{
+	vcn_v2_5_stop(vinst);
+	vcn_v2_5_start(vinst);
+	return 0;
+}
+
 static bool vcn_v2_5_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-- 
2.50.0

