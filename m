Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E68F483E4
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 18:45:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71B4110E45A;
	Mon, 23 Mar 2026 18:45:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SrNOUn+H";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011030.outbound.protection.outlook.com [40.107.208.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E79C10E45A
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 18:45:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNRjZnD/GuWjV2Pr6Qvj8o1Es6yAz4B/cnKbo7xMwCEKDShhT+vsDOuk/wn7SEYdYpBpUcRjtrjSM2gxrIF1E9ScjfsG1nyiuaHkNO0YZ8Nw2bQVQaZBwhFKqfaDBy95GthbKDa4xBxmCZMsaXEb5mreZJGOC3xGpQhIXiB3FigyGju0zMAIu1HZ16x5FQhwTB8I6skLBLVYTZ+XkLu/namtqPFBu6riNeYrARQcHjCeqYABnb5mrlaWMtAD1VFEzQd8GdNEizCv+GVzCsf7UkS5BsPskGOXamMOwPe9MBSIxJT9UVktK5NLx9mPacwKYpBIKzRUwps5vBloLsT/nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAIMgUJ3V8VHt4aUoUZDcvG2jeN8igAPT4Fy1tikgU4=;
 b=F6H011h6yullhw1rg2ZhfpW+pxIHaTt1+x+rSxbFhg3TNpgPcF+4rlrRHbsUBWeTGcFvnG0Px9S/JXb+U9g1wNpi9VQ4nacCH9y8Po81DrQIdOFQcZJST4wDaLLwEYTucnKhOrsJ6aBTEBJ5cqK/oWKH+0+LdSmV9xpEFG0qx1bYYVytSb4IuFvFeS6NSfk7eZlTnZ3nldO6tR1+5SoW8SROxkYTOlUhbj5JZln2atBo/VSq0VLWO4PBeGfjXlM0mBfP2W7APNMKsNEoa/5R3+qJJltoEQUM/9NUf8j+tGqV4HzC8HVXy23wKTxT0xb7umzaxww0/kyRjFjIS+UUcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAIMgUJ3V8VHt4aUoUZDcvG2jeN8igAPT4Fy1tikgU4=;
 b=SrNOUn+HwUmu9aS5mh9B9OgnX9vs4e5kmlatcMpfPHJZO2u255+QmQqatifbDrYdgruN1F04kodzXgjJRGXZAfnR9HK8J7L0fm9meIR2udNSQPlVvFNdblQor5wwvvnUvFepihKoys4zCQ+5K23EU18Foz9DYW/Y1hbe5PTCYNc=
Received: from SJ2PR07CA0020.namprd07.prod.outlook.com (2603:10b6:a03:505::19)
 by MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 18:45:13 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:505:cafe::46) by SJ2PR07CA0020.outlook.office365.com
 (2603:10b6:a03:505::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 18:45:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 18:45:12 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 13:45:10 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Michael.Chen@amd.com>, <Shaoyun.Liu@amd.com>, Amber Lin
 <Amber.Lin@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Support MES suspend_all_sdma_gangs
Date: Mon, 23 Mar 2026 14:44:56 -0400
Message-ID: <20260323184457.1244422-2-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323184457.1244422-1-Amber.Lin@amd.com>
References: <20260323184457.1244422-1-Amber.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|MN0PR12MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: bc7d2c04-54f7-4a7c-6abb-08de890c5103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: /CmhRt89pqlnVFs96t2B6XU9W4nCdalmOIABKNPSPmr3dsAxn57Fon9374karsddApu8bw9IzQTqALdLk5zTh116xxjtBFj+A95g2cigTZ1SIz8ofrRPA99iQYjE0T7xsN/ei1HyeOtliFDZKm2HgctW8GoocpbvCnqmE/cOijfE8Lg9rB0pt/O3aYdf8KbHaSfQxmqSjqygHNcSY3OcIdCUlOe71/1rTLkHgIngcAdBm/NItX6H3yWf49eMrhqtPpHPW1H57Uvd3FgVdFKCO+jvNU/N4ULV0855ggpUop22QzSRY68obPHOnWyMkejMh1/I2hmuNhpy41QDXhNuylyMBXsDxdwzn1kHKHHIBuQr5bCc97SU0yFAJYUN7LbZ2iWg1FQjnopPTYqgTjrD21zfroI2m5b7gKdTi/APrNabdl5jTsPVv+/yCwko7VRwIlK21twzfuiRHQMtMCXZ6g4P8xhd1iAx1XxGvHErMNJhJqlMGUWR+adh3SK+CLDrd1k38pZ4ROMxqjlT9wKgwJTpVaAsmxXg0a0SkLWfh8NE/b8pYwH2Xb3zV5zEGA8Lx/6odeWcDuWR+54BOWUw6vxf07oZCoI4F1MhJeGW31r3Et3e+JdfHaaXs3sdrKcAJ6n1x8noTyDYCxR6xpoDDCtl3dh3F44iARYS/IOelrByFuBvqPVSakiJ3C0IueKvY3Khf5D6E6MlRDcnLIZc5fpi33QtZ3XbxosvFO8mW6jqS/gOdxRAfQWEOdqryNm5lfS3OApB4Qy5jPmjk9HZ0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I7BRxAvKOJwwb/20pktd56wJmb969ZkQT9nYgqGaDaFY84VCkOdRQfcUd/k4lU/pHSayt5USsIU+TGM7TCZB85f2HBSnTr3v9GpdIqJmo+ePYh4ic1qC8uMz2E2VTsXzMPlH5uXGOzLUEvRQPM7kLTScZMEdjZn5VOjDI6zWwtFF3iCaR4UkA4AhkFgypwZJqi84i/S4POc/JLXHloS17S5jFqgH91UXbuTEVCPojsDrfV+528qLpl0RYAkw77uh4VyINmikXdXqGCLtVDKs0CV93Sz3IDMl/+9XWEOdxNbj4ujR+NY0NNsxtP09T4iOCbe60nc1i0OO5PrqlkipVxVqVEAfjFFCkMkcUrYn5MrcvX4NJc1GSc9ZS85jpYwrgNy+NBC0O9zJ2eIpMjlBJ6PmTfBpi39ZxgREzK3NhErrm8lL0fxZALFDvx+OxtN9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 18:45:12.3600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7d2c04-54f7-4a7c-6abb-08de890c5103
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200
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

suspend_all_sdma_gangs is supported in new MES firmware for gfx 12.1

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 1 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c  | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index fd6b40d9da58..dfe18f0a3501 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -311,6 +311,9 @@ int amdgpu_mes_suspend(struct amdgpu_device *adev, uint32_t xcc_id)
 	memset(&input, 0x0, sizeof(struct mes_suspend_gang_input));
 	input.suspend_all_gangs = 1;
 	input.xcc_id = xcc_id;
+	if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0)) &&
+		((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x71))
+		input.suspend_all_sdma_gangs = 1;
 
 	/*
 	 * Avoid taking any other locks under MES lock to avoid circular
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 44fa4d73bce8..2d08e33eb1e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -298,6 +298,7 @@ struct mes_unmap_legacy_queue_input {
 struct mes_suspend_gang_input {
 	uint32_t        xcc_id;
 	bool		suspend_all_gangs;
+	bool		suspend_all_sdma_gangs;
 	uint64_t	gang_context_addr;
 	uint64_t	suspend_fence_addr;
 	uint32_t	suspend_fence_value;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index ac9e26b8bb52..8a0c3dc0ecb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -479,6 +479,7 @@ static int mes_v12_1_suspend_gang(struct amdgpu_mes *mes,
 	mes_suspend_gang_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
 
 	mes_suspend_gang_pkt.suspend_all_gangs = input->suspend_all_gangs;
+	mes_suspend_gang_pkt.suspend_all_sdma_gangs = input->suspend_all_sdma_gangs;
 	mes_suspend_gang_pkt.gang_context_addr = input->gang_context_addr;
 	mes_suspend_gang_pkt.suspend_fence_addr = input->suspend_fence_addr;
 	mes_suspend_gang_pkt.suspend_fence_value = input->suspend_fence_value;
-- 
2.43.0

