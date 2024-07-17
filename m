Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2A8C3DA5D
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 20:38:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7821C10E41A;
	Wed, 17 Jul 2024 20:38:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uFh7aSmH";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F387C10E41A
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 20:38:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhyUhxmD/sPFvwTf9WcRMbTV6k8g4bi1XoN7Rmg9FOXeEqKdDE56MtiaaciVJ8asywsLD2Dos8qYVlFMiK4feGoRgKALlg6em1VeQfyqH5E93Piz8MDC8kVpnrM74+5LBD5pZnnWHUvxvMKNGGwTs+dhjVsmr9mtpfqfowEduyoy26pRXRqVZpopFH6uLfgP0bzYpHgN3pOEmDb+hy//F9ZrEVk4hLFemAxVZOXOFJrzISO+xwIanGgPyXI8RaWoYChyvzQdNCJDSTEK1AEOzKkvcRxMNn2bfLqA49mAJ4NxQ2Rx1DihsJRmGhguAsMRJl/aBjMXfHhWwSVmjwjLxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3JWxSAwcJJqMrrmJdnnPztIhygrVvEpXPsqggMv2+0=;
 b=T4kAgAol4TEorEUCPJjniwC7NK9GROrTaPqHMgMhVgqPCH5/3Z5kk7nyTfa550jBKbwZKyxqQFmeaN99Q51BqY//QlbDXVsN8ZfH7loXh6UgUNxnjTlUk1kR0ZuhdNJU07eZhOliA0KwZa0HIIq90EKYEzbVdfeSmS4SmPpx40/MdlgVglnxaWTqzHmhC2trJ4EuYqi8uzeEOn4nXb3vDxt8cck0ELOhAmhiSmDKdUR5u39uWwpYcuhjTuudUH+1PNumDuLWfJmx+VbltI6QF0zwyeGe9BkSI2jgCuPxFWWl3ne3LhlurK8fUPXBozP+iTsV7I8XIKkMJejW8DHe7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3JWxSAwcJJqMrrmJdnnPztIhygrVvEpXPsqggMv2+0=;
 b=uFh7aSmHIvbpevskr2QO9E41/p6CpkiwurS2YM+gsMyVcuQJfSenNXs6Mr82iShtpgr59qQsyYIxSindKrGvbU07dMb9N8NE6RkIe6CPDqyHlWdU1Is2jVTQvNwCQwmMnbaFtVoI2TjGXqiBibpn7Aw1K5PiFnNprHoz3KkIEF0=
Received: from MN2PR18CA0004.namprd18.prod.outlook.com (2603:10b6:208:23c::9)
 by DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 20:37:57 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:208:23c:cafe::f7) by MN2PR18CA0004.outlook.office365.com
 (2603:10b6:208:23c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Wed, 17 Jul 2024 20:37:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Wed, 17 Jul 2024 20:37:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 15:37:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/7] drm/amdgpu/gfx9.4.3: implement wave kill for compute
 queues
Date: Wed, 17 Jul 2024 16:37:37 -0400
Message-ID: <20240717203740.14059-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717203740.14059-1-alexander.deucher@amd.com>
References: <20240717203740.14059-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: dca25cdb-aabe-4625-31f7-08dca6a057be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cRAwkzZxK2koB+dy3TIGJ6xAMbWNwDC/AhB4j1MQNeM3c5WrB0yidLAWObtK?=
 =?us-ascii?Q?YkdPjg5iMCrIaOsjtKgyfHNvobMD/j++QS2ta53zqg57bVHJzyFoq8wwjgOw?=
 =?us-ascii?Q?cZjSHv8QFPHDrUz80weLk4zk32PqbAL59ZEOWgM4wCrrVlsyRkS/YmgBRIgv?=
 =?us-ascii?Q?umeU8hO0Rp1eAkqnnm1R1wdULSGayeibtuVpkVKph3i/Y3ilNFG+wWeZhdox?=
 =?us-ascii?Q?tqxAaz5iQGDKOO5lXPOvq9xXUbKgiNhgAfKEVMsfJQj/EDCt1SqYkoK3tYiG?=
 =?us-ascii?Q?43ULzTqW+SglM2Ol5tJ2k1fYRslbLitw41RIh5gU88jLMvnumulFvv8JCre/?=
 =?us-ascii?Q?8sTN/YHc7MWKqKy0Bw/tC7iWujPdWfHPado+vNYp4oiey4EnhRhcQYI3SB1Y?=
 =?us-ascii?Q?2HHiFiLBOjlr85eiygTVPaGYCmmp7AeeWXcP55f/h9y6k7unxMZZeAa7rMbw?=
 =?us-ascii?Q?eVauo9627fYF76B2pdyOl4+qbRNk3shcDwhPhhOEw9bKJEjuw2joZRkq+wmK?=
 =?us-ascii?Q?T9jwqidKtDWl4o2eK8QuwGg8yH2uQ/jhqTs0fV4RpgQgrGXDqn/z1RRRQ+Jq?=
 =?us-ascii?Q?sCz76XAXWIuEhAknNbLjAP1rHjQrMU0Oqu9uawnxG44pQyKMF7upxCg64wa+?=
 =?us-ascii?Q?9TSNhV+tOEoRb7DsunhDZfbsKNEEfAERxicxhhl+SKhau48qaj0ZzgKBpJ0O?=
 =?us-ascii?Q?3p6NVAjxDnHXF+Smi7TDHt1yHnLZhJWvkcX8wlOhD5ltcmxTnnihHrtejq3v?=
 =?us-ascii?Q?V9bDwDIoTUNCZxBJQMMP9JIWZTUkVaBF84Ug6ZFWhDIw2WQLEreeRsFEJxxE?=
 =?us-ascii?Q?NFKZfdgL86bEWht6ZQ3KJ7FmJpgt/zSqRJF5GNk/Cz4ZGQu14hTPDisCJXpx?=
 =?us-ascii?Q?etYc5dV6ccgMba2vS+BfXgG2U3rAg94QNwMotU6SxSZ+q5QRdXvIpX3uwO9R?=
 =?us-ascii?Q?6l6enPLwEyuzb7SwdRDVF30IH69hHe7RHAp8GXBSAP26LBoja3600jK5CElI?=
 =?us-ascii?Q?NydiIOXkfLKryPvwh1jTjljsS/0HQVAFN0DeGQCLbpbLQTo1h0uQPWbsPA6k?=
 =?us-ascii?Q?3jeuAQC81wv0aKUmiX+KaQd8V5rNeMC11ANidM2OYgexlyO1+LA0lyqxLiw7?=
 =?us-ascii?Q?b5eoMM0nMcUZmk97oy6JR/qEjysl/+Ix/nVKdCi8M69YkzlsELPpRg+Npk+/?=
 =?us-ascii?Q?OEkmjuj3kkcFPg7yAxflD/AvGLhm5clZ0BcAVLIJNMBNgD/ZsepSQiETqFls?=
 =?us-ascii?Q?li6jXEre1uj6fkNyC7HHiOEId+8JKHPrQoVwicEU8S9bBWn5rAgp2SDaaKEh?=
 =?us-ascii?Q?IbYXdxKXHkaz9JTE0JqSWc+8V5uJuBhiVJbWM8G8o89CD8GPTTyab7DXwlO8?=
 =?us-ascii?Q?nIq6ezZwawpxGtSzBOz19rXQ7KiqM44eCt/mZ/UfTyy9jgVYuLnanF8Sw64X?=
 =?us-ascii?Q?3BvuSXpSlwSr7WeROwr/nfxUkQ92Frr+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:37:57.6047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dca25cdb-aabe-4625-31f7-08dca6a057be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656
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

Based on gfx9.0 implementation.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 20ea6cb01edf..2ac398184e12 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2833,6 +2833,19 @@ static void gfx_v9_4_3_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 						   ref, mask);
 }
 
+static void gfx_v9_4_3_ring_soft_recovery(struct amdgpu_ring *ring,
+					  unsigned vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t value = 0;
+
+	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
+	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
+	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
+	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
+	WREG32_SOC15(GC, GET_INST(GC, ring->xcc_id), regSQ_CMD, value);
+}
+
 static void gfx_v9_4_3_xcc_set_compute_eop_interrupt_state(
 	struct amdgpu_device *adev, int me, int pipe,
 	enum amdgpu_interrupt_state state, int xcc_id)
@@ -4116,6 +4129,7 @@ static const struct amdgpu_ring_funcs gfx_v9_4_3_ring_funcs_compute = {
 	.emit_wreg = gfx_v9_4_3_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_4_3_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_4_3_ring_emit_reg_write_reg_wait,
+	.soft_recovery = gfx_v9_4_3_ring_soft_recovery,
 	.emit_mem_sync = gfx_v9_4_3_emit_mem_sync,
 	.emit_wave_limit = gfx_v9_4_3_emit_wave_limit,
 };
-- 
2.45.2

