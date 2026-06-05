Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A52CD6E79
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 15:04:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3A07112B6D;
	Fri,  5 Jun 2026 15:04:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="chrUL/08";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25F4F112B6D
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 15:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3PIosQCwhAD3Elc532Zs2ySbG5vOXibfsy12ap7Jnyt0dikCFjh93jHTWoH9HHAyXjxE1/TW254z3hlGwhdCAWPGfgmrcXLPf5kneWG8SnCNY+O6Hng9IVDDy5/Dp85u/4kayFm16hEPvKD/1c4BHpMVB5wbqLvnsVbMIZoPRtSo4srvoO3h9jpxA8IetNX1/16RLPD6ZQzyvaskb+Ty5g5MZwT/qmgADMNc+ghs0vFhbV2pMzi7uq01Xv1bQAcMjH1cxyALCGAGXj/eVA31fbLOck5FTLbudMTuDR5jZbmTCGhITNmun1Bkqqw8dN8USPXH2oXdTqgDwzStN0tcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1f9bX46cUaZIKjul2l8wKtS99hVNQZk4y08PrN187s=;
 b=d1zoaQ77wRC3KBOs3pRRxAepMBoB5BbTxveYCao564hIjYbTdjHuoFOPjQeGux6GlCKNJfi9fy+ZMIhOSvW1St0o3UULnNpqzCOtG4h+RBI2t+rRAV6xnJAD0HX03rnH/zABFd1Ipu1tOdoOideXDyKgjXWcwhphlSYYN5l9DZmQwXFdqEN/B6GdnzURBZvFLV+wvk8ns+u4gtFUson3YYNl1Iz/dCy5q1tqGs52QGT9LF4VmNvBDw94ipkpNkIExdxyfLNcRfM72MoE/xuFGdfQKN+OuKmMDQt2EyFSCKzyIz07qV2t2ISowyoSj8pMmjRoLzkOls36FoteRkhr0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1f9bX46cUaZIKjul2l8wKtS99hVNQZk4y08PrN187s=;
 b=chrUL/08AFdW3+wuHtS77tp0cy2GaSTEaSRUT41U7MQgQQxnH2sjVW43Qt02lJmcC1aSMd/fzPuV2JcTjoRZTeH+Qha6xhgioUEwPIc+2elPZrkJZKCJXJvXB8XBhZQ17MXjcJxUB8g1Vnnp4N1jJsSP0vGyoZBh/zfXmPvM8Ck=
Received: from CY8PR22CA0010.namprd22.prod.outlook.com (2603:10b6:930:45::11)
 by PH7PR12MB7427.namprd12.prod.outlook.com (2603:10b6:510:202::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 15:04:05 +0000
Received: from DM2PEPF00003FC6.namprd04.prod.outlook.com
 (2603:10b6:930:45:cafe::1d) by CY8PR22CA0010.outlook.office365.com
 (2603:10b6:930:45::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.10 via Frontend Transport; Fri, 5
 Jun 2026 15:04:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC6.mail.protection.outlook.com (10.167.23.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 15:04:04 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 10:03:43 -0500
Received: from yunxiali-dev (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 08:02:24 -0700
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>
CC: <Monk.Liu@amd.com>, <Emily.Deng@amd.com>, <Hawking.Zhang@amd.com>,
 <amd-gfx@lists.freedesktop.org>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH] drm/amdgpu: skip already suspended IP blocks in
 ip_suspend_phase2
Date: Fri, 5 Jun 2026 11:02:02 -0400
Message-ID: <20260605150202.2453971-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC6:EE_|PH7PR12MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: b810bf25-deb5-4fea-e521-08dec313af1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: iAiUvvPiEoZbQS4HY7f++A86BU1dbI6rnvQdX5oUBkDBIdJcXFDIy+95F2lDaejD7/T2ek2oNzVN53v4Z0xVGA8Z31/NtcVUSquHUIhnDLQzyklIP3B55UwRdlARZkvs1y5Hul655mKXpWO8gNyWyUFh5MYO5L/iU4rawl9kiadTfg6aSZUVKDQbfus/gB02REpVXNBUogtuqDnRwvs8Cpk0yGzhBn7Qs8R0I6TPrXogwrsHXU5Gs+0uEvB3FtqsLZrQ5B8DmMKEUUbxota91HpUocFPHt0Z6eIwcKy8KAC/7UOT9ZLzaBeQPS3cct2rdZINwaMPmITaVo6BYBdfyB6gnpGI1f8UA4Rp5SdxLQfcndQfE66q7tsxrGDJ0g3UdEGaqi0B5yPNH5W9SH+RQtq5LLLZxa1sh1rRlHbHhcFHVM15SuhDPoFbR/Y6Nfv+Jrgx0R/ykkJ/YmQjApTDqRBQRIGY4haXWjczpNTaYfmPe2ejirLkixELCD5anZ72LEg5ZQBzCivjZY8+TFTdDPoUVzy/FPEux51SEQgaN9BD4yR02bDxAN1d810lsHsK+2TaevOhnnqbSfXGX7iJz5bhcib3tBE19Bzk8Byzci5Z0CDEGzwZdZ39Ye9v9r9ohiquEnu1jhGHU3CfoNDQ+mkMkwHRdzUUsCVtGLZ55410xaAEVm1hETINFc2WGjTYModoXWNA2gDOHUQs6PELCFukIf0nyW7xs5XHXbKuXtw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(56012099006)(11063799006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6n5u3dzfup80UzEA9VbUiaxx0MRyym32dMvfr2+1T7V6+tFUaXPkT8nyNWiSk3G5MEIcfQef6/8H7RlnjHk+oejmuwT1q36cIBeGYoMbiRcoXOZBxRvVpu3BS/ulJGaixTUCAkXeHAri6COjo/xfZuRyOHnrmCmF8APW5hmv9TGqa2TtJ5C9jqWPAibIPRZLxlDizgWw1ysgni5yZYujLo+N6MKpX1+PSUrZ50PiGdBwCPlr4OLKqwLtTYAsXE3VeycxN6w83OWa/R73ZDgGOg684INsv7jQLOaibgAf4VRsIrh7aXle3OaZa3atQ5/1k8RSe+tpcpcqudJl4zNplQWFbt3tCHNUl3VX6oyx1XlyzrppAH1Nk05tnUfiqQxR3e5kwcOYIugz6X8SRWsyAhq3IRfG4xLTjwVAva608dTzK6yPGxLL7BvrLDsV6dCN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 15:04:04.2335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b810bf25-deb5-4fea-e521-08dec313af1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7427
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

The GPU reload test (S3 / mode1 reset / module reload) triggers a
WARN_ON in amdgpu_irq_put() on gfx10 when unloading amdgpu:

  WARNING: CPU: 0 PID: 2314 at amd/amdgpu/amdgpu_irq.c:676 amdgpu_irq_put+0xc3/0xe0 [amdgpu]
  Call Trace:
   gfx_v10_0_hw_fini+0x41/0x150 [amdgpu]
   amdgpu_ip_block_hw_fini+0x29/0xc0 [amdgpu]
   amdgpu_device_fini_hw+0x315/0x610 [amdgpu]
   amdgpu_driver_unload_kms+0x7c/0x90 [amdgpu]
   amdgpu_pci_remove+0x51/0x90 [amdgpu]

amdgpu_device_ip_resume_phase2() skips IP blocks whose status.hw is
already set, but amdgpu_device_ip_suspend_phase2() never had the
matching guard, so a block can be suspended twice (e.g. a reset or
recovery issued while the device is already suspended).  The second
suspend runs hw_fini again, which now releases the gfx fault IRQs
unconditionally, dropping a refcount that is already zero and tripping
the WARN_ON in amdgpu_irq_put().

The fault/EOP IRQ get/put were balanced through late_init/hw_fini
before, which masked the double-suspend; moving the get into hw_init
made the suspend/resume asymmetry visible as an IRQ refcount underflow.

Honor status.hw in ip_suspend_phase2() so suspend mirrors resume and a
block is only torn down once.

Fixes: 3402365f4ca8 ("drm/amdgpu/gfx: move fault and EOP IRQ get/put to hw_init/hw_fini")
Fixes: 482f0e538580 ("drm/amdgpu: fix double ucode load by PSP(v3)")
Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6608780ffef2f..dc8c650fc3416 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3044,7 +3044,7 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 		amdgpu_dpm_gfx_state_change(adev, sGpuChangeState_D3Entry);
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
-		if (!adev->ip_blocks[i].status.valid)
+		if (!adev->ip_blocks[i].status.valid || !adev->ip_blocks[i].status.hw)
 			continue;
 		/* displays are handled in phase1 */
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE)
-- 
2.51.2

