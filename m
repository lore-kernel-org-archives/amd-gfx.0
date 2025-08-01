Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07AB8C87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 06:26:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89FBF10E154;
	Fri,  1 Aug 2025 06:26:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2/bkGs3g";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEFCE10E154
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 06:26:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qlxd6gWGdaVZ38z1r0k6oPV7ixy2emqrKg8g/ohjcglj81HJC5KNXU2Yyt1SWW1f7h/3L3JOlIejJkAxQz1IALt54mAUgsrY4zpD9jM9fMzNkUM87SyYqa2+CWAk9XKC7ZrKXoP7pPv1R4rq0zHMRSTPUB5k/r+8ALKZCYls76q8xvcjcYn5bSS76eKCaXeJWexBczRkE6ofEt/ql0OykltQ9vS8OrVBgeCV+khteVp01vD9gY8Zx4+3j8G8xk1Gh3UPFE9ak/LHCYQg+q6+Ntx1PVkMBdakv16qXwGc5pIlbbQR5396cFA9jEIQRx7vB8EksJmzF8xh4xNIrAVhdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qyVCWlftDAdPIDu1Gk1I0z7PgskphbcEYfA6lIxgG0=;
 b=O/uWEke+QkLVK4UuKzlINTOqW9Yui3CIGAewNuQ1ANyz2SyIfzlzYRacOzZliDeeio2qZBiqTRpsX6/DBY4fVqTmk1jKdEIXNEygdqI/57l5tOqIuzeyrRhv60PlecisyYfc4BbppXSuZN9FA/wSke9cSofQ7s1y1Pocns4LIWdGK+figQhlSSE61YMt4xdF4PO+pqa+Wp0Vgki5Vj0HtKPf+2As+jipLgbkrK8SOqo1kl8Qusk4gzuMdZ+0oKhN+9MRtqdXaSBD8p2VJnO+AdNwPHmgUSMSk6eH9eVf8tffr40VBP1RabN8BmQUKV5T1PUDhgzSDrBFOqPu0eaDAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qyVCWlftDAdPIDu1Gk1I0z7PgskphbcEYfA6lIxgG0=;
 b=2/bkGs3ggl0QraG8ryv4+JKePzvvTazX7seO6yU6cYvP2kEQpOn65nRHPqxYEXSwUSld7FG9EdVus5VsJyIH3Q9OUwbC2ATRv8ymYLwrnhPCU1fFEaJahMfwn1mZgnt5q+UDw+h1zdPNWCC08SYJLxAqoA405PXN21Sxq4eJRw8=
Received: from MN2PR16CA0054.namprd16.prod.outlook.com (2603:10b6:208:234::23)
 by DS0PR12MB9039.namprd12.prod.outlook.com (2603:10b6:8:de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Fri, 1 Aug
 2025 06:26:02 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:208:234:cafe::9f) by MN2PR16CA0054.outlook.office365.com
 (2603:10b6:208:234::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.14 via Frontend Transport; Fri,
 1 Aug 2025 06:26:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 06:26:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 01:26:01 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 1 Aug 2025 01:25:54 -0500
From: <Alexander.Deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v6 02/12] drm/amdgpu/mes11: implement detect and reset callback
Date: Fri, 1 Aug 2025 14:21:00 +0800
Message-ID: <20250801062547.4085580-2-Alexander.Deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250801062547.4085580-1-Alexander.Deucher@amd.com>
References: <20250801062547.4085580-1-Alexander.Deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Alexander.Deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|DS0PR12MB9039:EE_
X-MS-Office365-Filtering-Correlation-Id: 56af32a7-e505-4a4e-ae30-08ddd0c4493e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9Cf2Cr580Cp6UT489Zz6Lb7zvJwsVXSZFY/ynEetcAODrpQDcbxMBjFCWDjE?=
 =?us-ascii?Q?XyiOmRbKhdEdSKGdt7x6ibTxPIsxE2fAVjMdcvBDqHi0Fx/Z2ti+leUG6T26?=
 =?us-ascii?Q?EaRBx2p06AI0s5B2p0J+poBUeExT4bRw6zOnTUtcSTQojdcdsuypfe9sPQEr?=
 =?us-ascii?Q?TIZzLk13d5kkvJwHZUgYGyz1z3dxOuBZKm+T8d8PM/Xnk9GaqCJIcmFdgHIT?=
 =?us-ascii?Q?gj/ODIMHw2AbAVqmaWwsiUv//YzU51Ynw8QIAKpLlCJVsy8z/PNd3GBF/VLB?=
 =?us-ascii?Q?B4LO6l5GBm0At+Sv9fisxjvEgw1VlsSbCSjt9j+VrNjQGKyZt9gwGMW/iWc3?=
 =?us-ascii?Q?LuEENVob1AGffHiRaJ2BstwDrqqdLZGYMfcKnnZH1MC2C608atUXQDVx4kdM?=
 =?us-ascii?Q?BxW7b+lhm/61oNL7cLB4GA0UvNCcaMzoU+9McZcs6Ulv/FFp2MJjQF6gA+66?=
 =?us-ascii?Q?/+TqQnrfEzYOhOJVMY6gZ7yqH3/+EwvCE2Fz95He5Iun7KnJ3D8M8JPfokr4?=
 =?us-ascii?Q?XOoObasQntb6Hf/9rgpKd91xm3edMr2yHuMRM2c+7bVYvW4sAugqMJzNk2wM?=
 =?us-ascii?Q?Ir7CV/Tgl4Iu8SxCoxqOgBBg2RepNJof2w5BrRX60cXkvZ0833HnpBSWjs1/?=
 =?us-ascii?Q?qEqTJKnJ34BFumgsyGk0gUTJKA9khGOl6YjLj6tDehQDPc2a6Y3T3sBVpwSI?=
 =?us-ascii?Q?HvQ0V9Iprz5uP2LJ75fKJQZR199qF2HIHf7D7r1v4oulyr307485UbM94DKB?=
 =?us-ascii?Q?07ccKrJOSVMKj5Z7ssqe0owKXGXSgWsXqsFWF/wrbUr2UaDTeHnADGXDK+44?=
 =?us-ascii?Q?he1d+ojQvS4c5iRY2EYjyfGhyz7a536uIIVyj2daYBgnV4FuS2cam3/0nHPY?=
 =?us-ascii?Q?ivPai1Hi23oKbli1Bo3r5BlKX6W2smGKxdlUAQcDU4oVybGInlgd2MzBvu0O?=
 =?us-ascii?Q?tngv/r9Kd00alBlp2cSF0VkFDkb1qI8wE/Pf7wmVXiScmVOcMWiD/TyBP8UC?=
 =?us-ascii?Q?x9ti+dkrvXeFkMtV0UekZqbQyK6Boin2/2nglr6JD+u77d1L2aImC3ypCapK?=
 =?us-ascii?Q?AvilrilMH1ZZ+eMEBfBfS2HWBdN7fWWPT7cpsB8Ei8xdpZ4cM9ICIThfqwre?=
 =?us-ascii?Q?FuuBcrHCV4/bYxCVySdG3U90wDzisOh2wxhcg/A4GS7DPoZqieahuzILXFv1?=
 =?us-ascii?Q?KSQEsu2n9nQTfTJdbh+5SfzgADLMYl+2Y3qnj01HJAYHRLiTk4a/1nqtjBY9?=
 =?us-ascii?Q?C+u4VNRWf3VI0EUxNSz9x32S2tT3XicxmVJIFCumnlJmRWb73BdB5jfMWFbl?=
 =?us-ascii?Q?z5rkiOSguM8rbyBuaD1ZdkPwFWIBC35dfxwAlzrFFt1/MhgePH7+wK8Pvrj0?=
 =?us-ascii?Q?l4J/UJKKuVVE1XvOY6cT1GqGht5PzHmmUNVuE3V8EutVPIKN9JtpEZt8YUjN?=
 =?us-ascii?Q?+uyjTfOxRbjnLSsm0SEWjI840x9Ms0jrMO/+NvxjDUo0rKu60ZQAOQ3oDUZm?=
 =?us-ascii?Q?VUelVPzwE+4YmRY0ypOnVBAFYIFAU3QxKvMv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 06:26:01.7065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56af32a7-e505-4a4e-ae30-08ddd0c4493e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9039
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

From: Alex Deucher <alexander.deucher@amd.com>

Implement support for the hung queue detect and reset
functionality.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 28eb846280dd..ed6a7f8af544 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -66,6 +66,8 @@ static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev);
 #define GFX_MES_DRAM_SIZE	0x80000
 #define MES11_HW_RESOURCE_1_SIZE (128 * AMDGPU_GPU_PAGE_SIZE)
 
+#define MES11_HUNG_DB_OFFSET_ARRAY_SIZE 4
+
 static void mes_v11_0_ring_set_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -783,6 +785,32 @@ static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__RESET, api_status));
 }
 
+static int mes_v11_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
+						  struct mes_detect_and_reset_queue_input *input)
+{
+	union MESAPI__RESET mes_reset_queue_pkt;
+
+	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
+
+	mes_reset_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_reset_queue_pkt.header.opcode = MES_SCH_API_RESET;
+	mes_reset_queue_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_reset_queue_pkt.queue_type =
+		convert_to_mes_queue_type(input->queue_type);
+	mes_reset_queue_pkt.doorbell_offset_addr =
+		mes->hung_queue_db_array_gpu_addr;
+
+	if (input->detect_only)
+		mes_reset_queue_pkt.hang_detect_only = 1;
+	else
+		mes_reset_queue_pkt.hang_detect_then_reset = 1;
+
+	return mes_v11_0_submit_pkt_and_poll_completion(mes,
+			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
+			offsetof(union MESAPI__RESET, api_status));
+}
+
 static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.add_hw_queue = mes_v11_0_add_hw_queue,
 	.remove_hw_queue = mes_v11_0_remove_hw_queue,
@@ -792,6 +820,7 @@ static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.resume_gang = mes_v11_0_resume_gang,
 	.misc_op = mes_v11_0_misc_op,
 	.reset_hw_queue = mes_v11_0_reset_hw_queue,
+	.detect_and_reset_hung_queues = mes_v11_0_detect_and_reset_hung_queues,
 };
 
 static int mes_v11_0_allocate_ucode_buffer(struct amdgpu_device *adev,
@@ -1684,6 +1713,8 @@ static int mes_v11_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int pipe, r;
 
+	adev->mes.hung_queue_db_array_size =
+		MES11_HUNG_DB_OFFSET_ARRAY_SIZE;
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
 		if (!adev->enable_mes_kiq && pipe == AMDGPU_MES_KIQ_PIPE)
 			continue;
-- 
2.49.0

