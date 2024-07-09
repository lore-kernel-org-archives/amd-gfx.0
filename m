Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A97AC3DA41
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jul 2024 05:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B96BC10E481;
	Tue,  9 Jul 2024 05:56:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eYFC4KUx";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB6AE10E47A
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jul 2024 05:56:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nxj+ImhX36hphUNdfhsllUQmhnhIouGWJ6q3EWUFMllF+PybnwMEY+VUv+Fi9bjlva25PUEjdL1T2wGGCWHVVXyrf1OTR8S8fPIu0zBIiTkh5sLf8Vu70x4RDDD/uWbN3/q0rGi+7Gjq6w9rDccUf79Kl4OdknpR1zHPMmpGI0bFeS6qqZcBHUJxBHECdh3g8wb73M9qvsM0MPpDzXhtWmn0i6Feukf3elJMXSGzlU5t3bQAPAnKiMhgj8zJFK+oo+TuRJddMCvu8mwgUyOnnvjsTvGHBCXb9ZqIB40bfUJQOrMDPWpmFojeOAxo8jIWFWVE5iuNkVLCfsn1qieGBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NanxKzUbUPVG+cBWcY+2W92a8uWp75CW92PGvfDAH98=;
 b=VEENkNL8uzwx2ukTRR1MHSVT+ITBecsF64PQUOTiS7MnKdqAeoDIPQxppCVljcNEKlI1AEsvagTk4PWbMRnmXHNZ3t926ZjtfiYgTChdlRF3aHseyfIlaFvPXSoQgGu0N5q6Y+0dqrNU+xbpzFjz89aA7kcFSFG2PWBEGUJGGaMfcHeDG2xySImDqHLvwG9DoeLkDrg97e6PirRnUYexbyEWCFKgfPExvW38U3N2JQCYku9kKAqcnZvZ/eGEHiFZNaJl3KdPNoihgpB7Qs27inHBIIb3FaHYW+VYDcCwuOyqNFKTDpTgoAHsIOOnNtm5T6EWdIoEYhUgNA3X2b8gvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NanxKzUbUPVG+cBWcY+2W92a8uWp75CW92PGvfDAH98=;
 b=eYFC4KUxSfx1rY+SuF1P2XCmnu5aNZGNZ79VxTiD1JhvRqfYUW+WLJU2u3w2U7T5RUIWqbXC3Ob+L0hbD8AeE+EeWnJy+m+jNcLTMqii575vzL+bKnZ09HCRffFWV8iEhA+zIxnJodAZoDTW7GIbBg+ASJi8F4JBsGUKtvrnxeM=
Received: from BL0PR01CA0029.prod.exchangelabs.com (2603:10b6:208:71::42) by
 DS0PR12MB6389.namprd12.prod.outlook.com (2603:10b6:8:cf::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.35; Tue, 9 Jul 2024 05:56:47 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:71:cafe::f8) by BL0PR01CA0029.outlook.office365.com
 (2603:10b6:208:71::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Tue, 9 Jul 2024 05:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Tue, 9 Jul 2024 05:56:46 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Jul
 2024 00:56:44 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH V2 2/2] drm/amdgpu: timely save bad pages to eeprom after gpu
 ras reset is completed
Date: Tue, 9 Jul 2024 13:56:06 +0800
Message-ID: <20240709055606.53567-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709055606.53567-1-YiPeng.Chai@amd.com>
References: <20240709055606.53567-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|DS0PR12MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc47000-71f0-48e8-f3fc-08dc9fdbeaef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CiyOkASqkBCzxYV5nqAPNCrZh2/cQU+psdDFRpzgQ9qZj9HaZ101+bskKslK?=
 =?us-ascii?Q?uh1DgbgI+fjNmJyhAXChY7+2mBzKtE1k4+u/eov2sqJDg7L+ZiGCHPjTyuC3?=
 =?us-ascii?Q?pBuLNtJ4y2Qpuej2CX6mnwKQuDy9Y3tvUxLETCR2LW7ddOw3PAClISWiHSIZ?=
 =?us-ascii?Q?CWV3MBN/70cn9lOkvp5yp0G8t0MAG4N6B7L9dQJ4bu/SQTOXS2t04N8DB3bA?=
 =?us-ascii?Q?VihMBzRPt02bzs0BocuhYkBJ2i2USI9NCej0I+2rlhqOrypnD5XrnTAS3Za9?=
 =?us-ascii?Q?PWSTq6T7/sNkJYYTrDIQv+5e57sDqvcjHxgf4CrjETPCMJF8I6hzLh9HxN6F?=
 =?us-ascii?Q?/xuN/8AlVBeadrxCYdng7zwy+1+yNaiRNWiVuIC8ni1LDSBc60ZSzdk+3Bjm?=
 =?us-ascii?Q?XowDP51Kb1+0t3bZu5ZD4wy/82Tb5DCdfi489wlCGOaA2aklQdlV634C0gHd?=
 =?us-ascii?Q?LkD7sv3inB6DkwoJ8jQeKYR1c87Tot4uKdKYHB76eKbUFS//EYp/tuqdtL/Y?=
 =?us-ascii?Q?gFd7E4fuywWlFwnJz2KKTojmr5pECbQK2hxDjgNVdCA428CWFeu8oAbSTw+b?=
 =?us-ascii?Q?vgWTxcNPEJeWMIilhwS5+Kt5f+63T6dQHYjQen5WXV51wy1xtYGT377ib+Ro?=
 =?us-ascii?Q?aEqry8yUyD4vTWfSalrspMskwFTTO+4YjtAxTRULXpGSP102xupwZPt7Vgbe?=
 =?us-ascii?Q?CBrLAKcO/aBqrRf68bW1WwNnfI8TZcCqm5J77o2ya2x60O2ci6o341QzQBQC?=
 =?us-ascii?Q?lArQOUaQVpj0PE3nyyF3vtFb/iSfzbPoF4ibnMqOmXSj8udlnQbolM46BuqL?=
 =?us-ascii?Q?o4rDqicXse5bG8TdCn4E9PazaPWWSpwj489xLX12wxzGm+t0pTJkJPiVeuBC?=
 =?us-ascii?Q?dUwIZeOT8Taz7M7BQFlQqy2MrbDo6NmkIZoRlLV2Avomc7YryDeiVagRsILz?=
 =?us-ascii?Q?Hhfc8OnghxQ5YS2cmgrRwkoEINty3PGaBdsBizQiJXWAEh1yQ4ScLOx+gyzz?=
 =?us-ascii?Q?ls+YA+4gvZmpu7aiRRDQvru7kQum4QHuduXrA4eYg7lHxEOP4xk/hATBXx52?=
 =?us-ascii?Q?3tJliqsoKJBjGYncIMPE1Jx8meNi8ILEJtF24YyptsmsGaFai/IorDFKU01I?=
 =?us-ascii?Q?eX8J3yXisQ7UcXi4HV0TeFwW+kT/55wMTpHcvXKdzN3oRYyThEq8hclViV6p?=
 =?us-ascii?Q?m7oYrf3+SHy99yid8C6TowAqKaGgpCHvgkVGdHBTFGjVhiuJK0L5vmaWy/ks?=
 =?us-ascii?Q?5a3uxws4rv0dTC9Cu/qCbjD0Lj8WC847QnbAC+DXSAONdWE8lLBDFm+0Ad83?=
 =?us-ascii?Q?g9mO7OCbjmSxM6b9UtR7V4Q9/nnb3/W5uyVUpsBTZpmy+4pmv2QHUrgPUfe6?=
 =?us-ascii?Q?LpJlA4CQ2BBRTh0Ivgl6Gwq0VnH9M9BL7vTw0qBfMRCbYb9nGXWgUsUenfV/?=
 =?us-ascii?Q?AuWkKY5TzbHcji8hlluP/EI9jWy5Ai47?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 05:56:46.7235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc47000-71f0-48e8-f3fc-08dc9fdbeaef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6389
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

The problem case is as follows:
1. GPU A triggers a gpu ras reset, and GPU A drives
   GPU B to also perform a gpu ras reset.
2. After gpu B ras reset started, gpu B queried a DE
   data. Since the DE data was queried in the ras reset
   thread instead of the page retirement thread, bad
   page retirement work would not be triggered. Then
   even if all gpu resets are completed, the bad pages
   will be cached in RAM until GPU B's bad page retirement
   work is triggered again and then saved to eeprom.

This patch can save the bad pages to eeprom in time after gpu
ras reset is completed.

v2:
  1. Add the above description to code comments.
  2. Reuse existing function.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index d923151af752..34226ae010c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2864,8 +2864,12 @@ static void amdgpu_ras_do_page_retirement(struct work_struct *work)
 	struct ras_err_data err_data;
 	unsigned long err_cnt;
 
-	if (amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev))
+	/* If gpu reset is ongoing, delay retiring the bad pages */
+	if (amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev)) {
+		amdgpu_ras_schedule_retirement_dwork(con,
+				AMDGPU_RAS_RETIRE_PAGE_INTERVAL * 3);
 		return;
+	}
 
 	amdgpu_ras_error_data_init(&err_data);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 0faa21d8a7b4..9dbb13adb661 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -29,6 +29,7 @@
 #include "mp/mp_13_0_6_sh_mask.h"
 
 #define MAX_ECC_NUM_PER_RETIREMENT  32
+#define DELAYED_TIME_FOR_GPU_RESET  1000  //ms
 
 static inline uint64_t get_umc_v12_0_reg_offset(struct amdgpu_device *adev,
 					    uint32_t node_inst,
@@ -568,6 +569,23 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 
 	con->umc_ecc_log.de_queried_count++;
 
+	/* The problem case is as follows:
+	 * 1. GPU A triggers a gpu ras reset, and GPU A drives
+	 *    GPU B to also perform a gpu ras reset.
+	 * 2. After gpu B ras reset started, gpu B queried a DE
+	 *    data. Since the DE data was queried in the ras reset
+	 *    thread instead of the page retirement thread, bad
+	 *    page retirement work would not be triggered. Then
+	 *    even if all gpu resets are completed, the bad pages
+	 *    will be cached in RAM until GPU B's bad page retirement
+	 *    work is triggered again and then saved to eeprom.
+	 * Trigger delayed work to save the bad pages to eeprom in time
+	 * after gpu ras reset is completed.
+	 */
+	if (amdgpu_ras_in_recovery(adev))
+		schedule_delayed_work(&con->page_retirement_dwork,
+			msecs_to_jiffies(DELAYED_TIME_FOR_GPU_RESET));
+
 	return 0;
 }
 
-- 
2.34.1

