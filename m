Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE18CA0EDC
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 01:42:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A90E310E2C1;
	Thu, 21 Aug 2025 01:42:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZYtmbxeK";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C86F210E2C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 01:42:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idE4E70a66Jcc/IVcNaxUu5efYw4ysTAMEDEeeIbqzY5BhL6hN5iwG/0R6qQHnWAwQdO5SqwwiecN9kp4SkXIZxDJs+ku1xMsI1ld/q993XBra6JrZFPqQMfCgIgF7QvpfyBsJc/tgDbDwu4hhw+RAVjP18GjkwUmqLES+W78YgfcglAP1tbcV6j1choKmARR5EpPGSOShzv5OOJax69nWHHQvHI0IlpXbpjy5iEc3+ywF6v3aN83u61F7aP5rSWn3fTn9xb4KJD/P2BMfuEu5bgO+KWR1darHzClX9q3c+Dcx8Bn7Gs0/izwPDU1ajm1+QUjC7l+wthNmmy52jxDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGYlBhcFsIPeTEtvMhQcBjnoBR+5GP1Av64ziVrRl7s=;
 b=UUPGk8A3jlZIF9Z7wzv7UUx71CSkc5FxRXK5lAAyekl5ImhrdhNS4MHrslhpYnOITQ1DT2kdoOpyvPQn09/fTJ4oayEY7ChVmrHARs80Ac7ZFhjh/XhVsMncwLWcRL+GM1ZcHxO6dGH3FQfYr0A8n02rrNr5av4r43mvPcbWvgqMiO3sLc43MHGW5N5jZ25rXRZNx4NWQQet5bj3Rm1Gkd6vPP6Y13WHd9z0Dua++IY/1X+h+43cXRjkgLKqQhONimx3feqOXHBw5Ts/SfMNJGqULInIJN5fjqBCEioLsQSw9oTn/VCCJhN404rm15XQc9idc/F83IMGZZ9I2T/OyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGYlBhcFsIPeTEtvMhQcBjnoBR+5GP1Av64ziVrRl7s=;
 b=ZYtmbxeKM0IwfUMebF/8xSSZGPLB2JryBnPJv6fAuG25PN0/kicxltdI+nL346sWimVJo+JBqgWsyX8MbbrohA5eN8ZSNdaOuMJNpJ6yyjPId5nui+Tr1/bubd/mLaBaweomy+8YliKHlxJ8+vlZGawQVBFs8FtkNKzcJKdwd7c=
Received: from DS7P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::17) by
 IA0PPFAF883AE17.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be1)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 21 Aug
 2025 01:42:08 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:8:223:cafe::ce) by DS7P220CA0028.outlook.office365.com
 (2603:10b6:8:223::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Thu,
 21 Aug 2025 01:42:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 01:42:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 20:42:02 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 18:42:01 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 20:41:54 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v9 06/11] drm/amdgpu/mes12: implement detect and reset callback
Date: Thu, 21 Aug 2025 09:36:08 +0800
Message-ID: <20250821014115.566598-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250821014115.566598-1-Jesse.Zhang@amd.com>
References: <20250821014115.566598-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|IA0PPFAF883AE17:EE_
X-MS-Office365-Filtering-Correlation-Id: 700097b3-1918-486d-668e-08dde053f0a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kNjZMZCHFAe5SjbFM83uWBs9KJtLalFdG6HV2EXp/Slp8nFHmvzR8oKUYI7Q?=
 =?us-ascii?Q?vJdY7H57BtFopOVQdyoR4KnL57smsGeSCcWPk4Ie8uKFIwmx8UaE/KSzg6Ze?=
 =?us-ascii?Q?c58Zd2NikhR889qGGS9DXTVaUdoDWCbBI7LZWQ4gtWCm4pQbjhPXvq8qwWBc?=
 =?us-ascii?Q?q+I5jAER/1NKrqJIN7NuaGlcR9yJGNXALtfm76a8XB0gLUWxB5iMAel/eKbk?=
 =?us-ascii?Q?EYh7aoztviHuWfobA8o4IybtzpH6iGxfBsA0we31LGLwIwQ1NCT/0e78Wmss?=
 =?us-ascii?Q?kpqfkHgSU0ldm1hh+7WCugMNGAuLYhasfuIff8bbHcFoJvqx1VA+dUpTut7X?=
 =?us-ascii?Q?z4msWyLjxNqTK4O4SMCA2LmbFDLEdCPBofqxvrvXfkOggRa4HWP4oohtOveX?=
 =?us-ascii?Q?NLOIfSqzzsITqAWcP2heBVAce2cmvyW9c1p8BdoNsNid18eYqgSSnSCQ5/s7?=
 =?us-ascii?Q?DzAvZabTDRM3tQlDFZShlFnMTrqsfYwYQLY2QLc+saC/XynVavDOgWyKwfBk?=
 =?us-ascii?Q?xZivY4tnRZ1zhscYqgDQ/S2++qsp/KrdOhByh2A33BqPTH6JMl793AL7pRFY?=
 =?us-ascii?Q?eXf/XcJVyFNSJUFJ9iK7GP94C5kE3Gd+C9Hvck9Bi8x6VkPZjab1w9xunLWG?=
 =?us-ascii?Q?QEAcB97yb/kDaApFP1fONngAwN2LAHttq3nHphJqsPpp/HKjPhwfbtxWFHdr?=
 =?us-ascii?Q?Xjs2V5amyvos+YYcaDTFuH0vKe4w9YgmAveUwjMvDIZLlBjc2kGg7URxQik1?=
 =?us-ascii?Q?eg9AVxHcM0d+xwtdU54zFxePlRyHu1Haa31US/HAG9p9FRPYYSCMPypBGfm4?=
 =?us-ascii?Q?xgAKTxlwb9alrhApLTkjeUkMT16ZEyM0alT0ni48q775JV+7DM+rkcbJCPIc?=
 =?us-ascii?Q?5872VpMYXcIHBrcjVuBlbxOGN/PQ/kHwd5+6DU59w9K5oQXKS16J7sdaS3yo?=
 =?us-ascii?Q?fwQjWqMetrOI/dsUCWzkuPK9q8aqHQ90jDyRl9l/S0GtzB3SfklnRif2CRBN?=
 =?us-ascii?Q?qgH2E7mJK+Y+xGJd4PVrBThpuIaXCWSB5o2XGKFyQfx7PgE6TJ/tZ9+EXGCO?=
 =?us-ascii?Q?J5EJ9K47yiy/fU+iLzkc/OeFqG+XKCBqP9gDcjqZxu7R/V92KvReBQlfSyGG?=
 =?us-ascii?Q?zVabbELypJ+dCAh9MNBsegvaS7a8QRk2WSyunDw9yN3iQ7kMhQUj3E+MrEGW?=
 =?us-ascii?Q?bDLMaUd4VCXx8WYJ2RvGBZdalnaSOxPLJdgwk1oMjcmERHSgw/pROqxrJ6WO?=
 =?us-ascii?Q?quD05lWdL7qFhSA/u8/kkFqSv+4HesLR27XK1lMESdOfBtiJ/am4bcWK/GFg?=
 =?us-ascii?Q?FI+lYhpf7cG7cSFO0UCLWhyRkTGSlUWTK+0kiQNpNwgLq9zevArybkLXaNQL?=
 =?us-ascii?Q?PiDpOwNNZWvbBQ817i3CT/bZ9huqipC3xLOiCtysWpcoM3S/B4R8CpRh0ss0?=
 =?us-ascii?Q?Vz+tqnX8/KvQxwtEfbY/BZxcmC3570VdySf/Lo9D5Hi2so3rWq9jeQmzkOS0?=
 =?us-ascii?Q?xg9VwDy7ApFX1ZHH4+GWwA3jD/KqAul07i+v?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 01:42:07.9937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 700097b3-1918-486d-668e-08dde053f0a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFAF883AE17
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

Implement support for the hung queue detect and reset
functionality.

v2: Always use AMDGPU_MES_SCHED_PIPE

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 24c61239b25d..ca06046c5d68 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -47,6 +47,8 @@ static int mes_v12_0_kiq_hw_fini(struct amdgpu_device *adev);
 
 #define MES_EOP_SIZE   2048
 
+#define MES12_HUNG_DB_OFFSET_ARRAY_SIZE 4
+
 static void mes_v12_0_ring_set_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -907,6 +909,32 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__RESET, api_status));
 }
 
+static int mes_v12_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
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
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_SCHED_PIPE,
+			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
+			offsetof(union MESAPI__RESET, api_status));
+}
+
 static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.add_hw_queue = mes_v12_0_add_hw_queue,
 	.remove_hw_queue = mes_v12_0_remove_hw_queue,
@@ -916,6 +944,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.resume_gang = mes_v12_0_resume_gang,
 	.misc_op = mes_v12_0_misc_op,
 	.reset_hw_queue = mes_v12_0_reset_hw_queue,
+	.detect_and_reset_hung_queues = mes_v12_0_detect_and_reset_hung_queues,
 };
 
 static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
@@ -1821,6 +1850,8 @@ static int mes_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int pipe, r;
 
+	adev->mes.hung_queue_db_array_size =
+		MES12_HUNG_DB_OFFSET_ARRAY_SIZE;
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
 		r = amdgpu_mes_init_microcode(adev, pipe);
 		if (r)
-- 
2.49.0

