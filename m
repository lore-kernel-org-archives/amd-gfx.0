Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF90CC3DA5D
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jul 2024 07:59:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56E7510E5AD;
	Tue, 16 Jul 2024 07:59:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JTl8H+16";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F8BA10E5A3
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jul 2024 07:59:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JR9I/0XJPXvZIMdFrQfsvqDVjFcrUSqG53bgs4UMRtzGUeXskqaBvZkHrqPx8T3XG8yrmnzW2eVc8jvT1j5+96OYgjFcBsFVXZ+g1oudA/A6GopZL3blBJIt5Gunau1R2Plqs9pCD1jGyqg92ZWths4RoSljs09ioSkiQJzVXNRn3IhZOz3LmZqOhSDAmE1JafgOXcwuQtkCLFxcVb9Ac/E93xBm95/yZUSR7Xeq/LnRW0r2iiNTFCVenF6uOUHrkdvoe6igNiZqtOM2K9NjRBLLAr9Bhmvg9PPkhSEPCrJG59uzuws+9S+ugiSIfQa46tuXS2AFqzkuO9TeXrozCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4meKNRLk3JwmqFbNpkhKAOx3YdwlhP05Kes+OegGEEo=;
 b=a2hI9okOOfVyrnOI8k4cpvz9KtnaR3t/G8LvLQlGfEz0fDorkM47TSaI1yrSIHJ5VHWyTVnOYkXI6GqsAlomYwP/MbnwaHcCzgxTwq3r8y9iwHuPbVscnkQ3nmv6Uz0xbhHppov1MOjCMmFXa53ugU2qRNv5Apy9edPhL02epgv3K5kHUS1EJ9mccNz6f0TaKlbyBJxdoPTP/GscNjV3kCq0ojujJkQqGJwq6jurm3Z5ZuQdYDqVHWHmdfhWFQBKXYvPy9wxfBIlH4tjA1Z3xn8YAL00pbIynwFYlqXjat5ujaFWJiNbmxT/AHkktbGN+DEIQrZGrB10OnbtiGJxrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4meKNRLk3JwmqFbNpkhKAOx3YdwlhP05Kes+OegGEEo=;
 b=JTl8H+16QWlBjcH/OT2IL2iTIqZ6zhlrC9ocEJ22UFpXS/RQjdmffwaiO2QiIS/hD+GT9KA482QablBU1+Fgz/fDLylMvPKZMQv2T5VD35KG/k6go65PaScHvXrEIs1s6MLQExbO0+W89leNtSdryHDNeqNK7qO7JWKOU9WTf0U=
Received: from SJ0PR03CA0024.namprd03.prod.outlook.com (2603:10b6:a03:33a::29)
 by PH0PR12MB7816.namprd12.prod.outlook.com (2603:10b6:510:28c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Tue, 16 Jul
 2024 07:59:32 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::e2) by SJ0PR03CA0024.outlook.office365.com
 (2603:10b6:a03:33a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Tue, 16 Jul 2024 07:59:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 16 Jul 2024 07:59:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Jul
 2024 02:59:27 -0500
Received: from jane-sm-stand.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 16 Jul 2024 02:59:20 -0500
From: Jane Jian <Jane.Jian@amd.com>
To: <Lijo.Lazar@amd.com>, <Haijun.Chang@amd.com>, <Victor.Zhao@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Lijo Lazar <lijo.lazar@amd.com>, "Jane
 Jian" <Jane.Jian@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Add empty HDP flush function to VCN v4.0.3
Date: Tue, 16 Jul 2024 15:59:11 +0800
Message-ID: <20240716075912.193722-2-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716075912.193722-1-Jane.Jian@amd.com>
References: <20240716075912.193722-1-Jane.Jian@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jane.Jian@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|PH0PR12MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: c148aed3-f4da-4285-e0fc-08dca56d3a02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CfixgX56cgeXONwtMc0kil0JyoHkKc6FVGjiE4lgcfX7X93Ik8uS+W5VT7e2?=
 =?us-ascii?Q?2ridbYTXutTd0SN+PiY7xE6fEJNJf6GUbokYH3xF7XEmcwKJynKN+OeFdd/f?=
 =?us-ascii?Q?eBhewGEkbllidBHOJ381I3P0a16y04TXxAyxCWfcAEm40kZ4B/eKmzL5xTgl?=
 =?us-ascii?Q?rVmpBgQ2N5Uhry+shL3WLoQ557bbMOPZkN6Jaq41PUodYoFO1YNEqLbhhNBI?=
 =?us-ascii?Q?yVbZ61mLLtby6deNT++pOTPWeywn+3muRG5xLaZFabM9wleTx3+VJ/ObdsKv?=
 =?us-ascii?Q?Siov5BfAXXBeJJOpCJKugSdNMetE+obkAIVNMn/tsk4YSF9ygyLB1W8fGZ59?=
 =?us-ascii?Q?GGyyfAb9uCRd+v9JT3l4IzEN+4+LJCRwepT/9U/ofs/qbX1LLocUDhGEK0Sw?=
 =?us-ascii?Q?vmZbiibBc+G2rinFFnIwxSHNI4SM5hJgflYTBtyfDMszF5WWoGT5LbWFzyxn?=
 =?us-ascii?Q?NwGdvqQjV1QRwad2x5e9EF2lmgpdxogeGgoCEY4a5IGjuAd47PpIbwwvuZmS?=
 =?us-ascii?Q?7OJ93V8K8B1cicDqtdamCMIkWfdW2bfXWgHqi7u8cV+18n/JfOKWV+dtccVm?=
 =?us-ascii?Q?lyj7de3MeGf8mZI7NOLuD1gpWBi4XEJTIA86qmj9cLIQAzCDiV//lqyGyWoL?=
 =?us-ascii?Q?m3dP1fluTtNqLiAHEzFKhEbz1X/UevX5K27DjZDt7r2sLOrcXf8yOydpvJqg?=
 =?us-ascii?Q?3/QbjOU5PN6LtAk9ZTHuF/tObjYVCQfswRHeZVbUH39oFsp1reLPFE7KQybt?=
 =?us-ascii?Q?npWcdy92XIuUG/AIcJRXGUaADxind6qrnRn2mKQRwQ7SG7B+7G/eAh4LRi1T?=
 =?us-ascii?Q?g/fcCcnVXfE0BSf7q8kfAYJvWKy7T37OryYbVIbAFzIToH+7/sGyFLcxELnV?=
 =?us-ascii?Q?YSCka3EmK8noTCkbUIhoi4LMTOfiD3LuMa6IUzsSmfG5OlYa0dbm5CL3j3Rv?=
 =?us-ascii?Q?Wa8ZH2I88vbknFVy1MyZIg0JtHdWnOmfCGW515XeCYcLlDfyTIWF/UGRQb37?=
 =?us-ascii?Q?e+J2JaGo4L5C7G0iiEIKauIGv6pf56Scju5NWKmWZGIpFOt+URIeVXrDrYw6?=
 =?us-ascii?Q?pBHqoETnOHdF3pCgGwJrXAanwRZy/ipM5k0jW13YmlmcURiNqXj6OoE3pfzz?=
 =?us-ascii?Q?5lii1Kiy48iCR52fkDgyv4hJrPvEQ5bTHJy2vpbQIfGV/PBRJPdl1qH7fvRY?=
 =?us-ascii?Q?WPDbo4gpnJFo2AC3Mx/m8KtjnUt3UkxgkiEwDpS6lV3ZbSUa3NGGVtgZE6lu?=
 =?us-ascii?Q?QjNRIZvBOV3wF0VvLKRXfWiYlKypc4gwTPpc0na4DTiC2thSG1/A4QqVOiyq?=
 =?us-ascii?Q?rR5mdOX6XTYIRdBpNU2f9CIUIyuWT94CfwICXaWCRVPUrXmvpRdlASlMRYjk?=
 =?us-ascii?Q?AgAtW2qQV0EgLmghY9NtBE15CuMEiftNMXibH9HOa//kdr493OfVZvcpYjIg?=
 =?us-ascii?Q?zpFlgP8NM7+gjmkdmdEh3o2OnpHMNjHM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 07:59:32.1178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c148aed3-f4da-4285-e0fc-08dca56d3a02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7816
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

From: Lijo Lazar <lijo.lazar@amd.com>

VCN 4.0.3 does not HDP flush with RRMT enabled. Instead, mmsch
will do the HDP flush.

This change is necessary for VCN v4.0.3, no need for backward compatibility

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index f53054e39ebb..101b120f6fbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1375,6 +1375,13 @@ static uint64_t vcn_v4_0_3_unified_ring_get_wptr(struct amdgpu_ring *ring)
 				    regUVD_RB_WPTR);
 }
 
+static void vcn_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
+{
+	/* VCN engine access for HDP flush doesn't work when RRMT is enabled.
+	 * This is a workaround to avoid any HDP flush through VCN ring.
+	 */
+}
+
 /**
  * vcn_v4_0_3_unified_ring_set_wptr - set enc write pointer
  *
@@ -1415,6 +1422,7 @@ static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
 	.emit_ib = vcn_v2_0_enc_ring_emit_ib,
 	.emit_fence = vcn_v2_0_enc_ring_emit_fence,
 	.emit_vm_flush = vcn_v2_0_enc_ring_emit_vm_flush,
+	.emit_hdp_flush = vcn_v4_0_3_ring_emit_hdp_flush,
 	.test_ring = amdgpu_vcn_enc_ring_test_ring,
 	.test_ib = amdgpu_vcn_unified_ring_test_ib,
 	.insert_nop = amdgpu_ring_insert_nop,
-- 
2.34.1

