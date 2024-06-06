Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9CCC25B75
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 12:03:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1724E10E91B;
	Thu,  6 Jun 2024 12:03:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xCTYHl7h";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8582110E91B
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 12:03:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hp7reVTrQw6TBTC64yuB4to/rOhFy/L8X+6+rxD6X+5/GApPCu5cwpvjeFOnS5H3UqKudr9GilTse+ExyFL/frUf0MdSc3ysui2A5gtk/9HsT/Z1TQj5d8pDRqpVKebvIhv0ukapRQucF9q6k/j6Jtog3LjXSloqA1UBTRZxERM4J0YL9z5kE2qktZPNol0u6blb3KLqxnviG0+KPhi5kd5Jf1bbAi4xy58SF1fa/l36nOR81uxIkVpwRPVhOotxwIOlMkfy6PwCfh6CJ6o/umWyGSlyduZC/vsrGMt/GCEv13hOyrFh2iN5JIawyCgWzy5vmqDw2zgFGFX62shEOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQOWMIuTPDv1hBYgOsTLiV8dpi/Nv2CBH1vhP8EV+TQ=;
 b=Ol3cfpf2eD0ewS9bvhR4eOmo1aHvnKSheqBluUhZJprfSm7XJyNOxZ3gMu4rWtW9E7U5ASQ51b4ABG58op1suMWvfaUWANlPkqJnDUYqHrp6Dq+InXrYNBtQ7zSJobJlnrXn5vVa5Nxq1P1H30w0jM5oQdPoeFIg3ZUE5eaKxDNWW2N/izR4eiwDO2S7VDGaV40Nc/SnpxNl7BFbR/fVCuTNk3CDUs8zfIDR6z8cLLpR+bWaClz+z0exsT8nnJ66Cm7yqAy9PtYlIPcTU52SxO1Y389CpDfSO0MCfvQde7fu9qAfmP0nQtBMpx7RBSHgADvKOHxGrLvPUf/7I3ICeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQOWMIuTPDv1hBYgOsTLiV8dpi/Nv2CBH1vhP8EV+TQ=;
 b=xCTYHl7h+PPJXpPijTET/AoxaQQdLCSR9pHcurAZ+1pwdPK2tstNw52nNUkxKYM2LBp/0tVgii2gEbk/IrO40PzxuGY7AzG+9dS7NenwoAZAWMlTpVrzyBE1QLdJ9ytQe/l4DSgNHjAXr+sysvuE9VG6qL4Oy6cRBsgW5oEDACw=
Received: from SJ0P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::24)
 by PH8PR12MB6819.namprd12.prod.outlook.com (2603:10b6:510:1ca::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 12:03:51 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::38) by SJ0P220CA0012.outlook.office365.com
 (2603:10b6:a03:41b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.16 via Frontend
 Transport; Thu, 6 Jun 2024 12:03:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 12:03:50 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 6 Jun 2024 07:03:49 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH v2] drm/amdgpu: Indicate CU havest info to CP
Date: Thu, 6 Jun 2024 08:03:37 -0400
Message-ID: <20240606120337.435058-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|PH8PR12MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d84670-876c-4ee3-485b-08dc8620babd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?teSz6aHfko0bEAykXHIGjA8zy/+0tjL0xPLEqY+/t0aozaYGWl76j45L7lcu?=
 =?us-ascii?Q?3lxDWu/gmYbIt41krqCMCGIb2yWwgnGNhAI0bnH2oyyeSsWN1sEOvYxF8rOr?=
 =?us-ascii?Q?nbonA47GyfTdVMS2ldYLJqsI5ys6oj9/gIVEPLfF+CzUlKgWLbPkAZIgPgSe?=
 =?us-ascii?Q?M3HHBuJK7T6YlSzRbK+zlXycVxbhZ9K/LDegoOfcUdQeIBPzEHF+2JFRFo7n?=
 =?us-ascii?Q?nt8bRbcwKaog+HiLtnjeXem84Ecwk3i3f86jcSqdnZXbKXUtH7u31cp+7Y3/?=
 =?us-ascii?Q?6KwpWjJAZ/lUF8N5S/SoYOz3yksPnlA2puz3Y0PLwfnakgyFQ8HUmxUsbmB9?=
 =?us-ascii?Q?jzzdSOUi00LchrdF8fK2dIlmhQi0xgKTOA/TBk8zXkao++RQ9rPpUYNbeMn1?=
 =?us-ascii?Q?raxCFEo0C+Q0xI0GS1a3BXVbSmb8xdlsWxpZj+zPTGQqtcHAJjSw6tFQFr0l?=
 =?us-ascii?Q?YXEj6/A3uLqUqXFJLRycKT3kinIYkq/MfOeCtFfSGJ1g8BGTuKTSYdnVzc3e?=
 =?us-ascii?Q?J3a0gZNnY0OWAtZDQDiTEOG6O1U/oZakDK2gadoMxKz4IayXSUY0LxpLxC+3?=
 =?us-ascii?Q?hXcMjkRNTubobQ8oIS4qc/ynvvk82dLdOOQRm+e9ZJu0fJTRk26k0KFpdXg1?=
 =?us-ascii?Q?CvyJOfj5wkcb1XQ97k7T2Ra4yHkvPo6AS+VcmPnLsixR36Bs6ojEioIehxtv?=
 =?us-ascii?Q?TKl1c474IFNVboeoJ1ES0TEhKA4HhfkNEJI0hMR1rYMg8LPPzpl9gPZ8GWto?=
 =?us-ascii?Q?L5C7z2iPwy2JBQ+b0Lsfxv+1xDr0s0N1fsnjWjc2CpNrlvGwMwbnGjilxvIP?=
 =?us-ascii?Q?T9zObmWhRnauvl+CDfAkS4izDtFUd3CF0WQOeKFkuP+V8T4UmyLHJyn9iXCy?=
 =?us-ascii?Q?0TDfOWPHy41lIDiIx3eUrDFnGeX/LWokiSqEuS1CTt/+qN4yUedfPkbY/7ti?=
 =?us-ascii?Q?xiW7jh7/rp4l0+X6HKlUcSWV2Rr9t2pLLqwoFULciKHVPsj4w+08QlpPXS4M?=
 =?us-ascii?Q?f0Bw78C10hNVlNTC0urwn7qlcAsVI61cLbkH8e9C8YRIyJ813EeWkEjOoO/W?=
 =?us-ascii?Q?IZhvIzv6RIF4s+LLIRBJV/I8FEevC7RJHErSeJzUJPpE55lJzUnPaEBp4X9F?=
 =?us-ascii?Q?ddFRY5qbl3zPvqnN1mTZEOeM0u8t4OpVkcxTUCxXvMOFLm8+yvKij6SNU1Lj?=
 =?us-ascii?Q?eW1x+V2bUFOvPT5nzV2X/bz22nYl/jU907szjj/+ImYUgDr0Gsvet9wm6P4O?=
 =?us-ascii?Q?mOyVZFrUDcoBN7gIGlj4YzVY0cdus65dcmDcwNHpuaQBVuuA7fFmYSx7YWxE?=
 =?us-ascii?Q?5BaH1F/ZBcE6pfakA5SGtZVTY7hChUJq1cXLwqGyNO56LHhkbhw3fe7yJ3D9?=
 =?us-ascii?Q?eerzK40/PRVJwUVB6KSXsQ+oPIZ5fNbpxd7qy4bdmZmC4b/EwQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 12:03:50.8247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d84670-876c-4ee3-485b-08dc8620babd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6819
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

To achieve full occupancy CP hardware needs to know if CUs in SE are
symmetrically or asymmetrically harvested

v2: Reset is_symmetric_cus for each loop

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index aecc2bcea145..d50dd6f4472a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4203,9 +4203,10 @@ static u32 gfx_v9_4_3_get_cu_active_bitmap(struct amdgpu_device *adev, int xcc_i
 static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
 				 struct amdgpu_cu_info *cu_info)
 {
-	int i, j, k, counter, xcc_id, active_cu_number = 0;
-	u32 mask, bitmap, ao_bitmap, ao_cu_mask = 0;
+	int i, j, k, prev_counter, counter, xcc_id, active_cu_number = 0;
+	u32 mask, bitmap, ao_bitmap, ao_cu_mask = 0, tmp;
 	unsigned disable_masks[4 * 4];
+	bool is_symmetric_cus;
 
 	if (!adev || !cu_info)
 		return -EINVAL;
@@ -4223,6 +4224,7 @@ static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (xcc_id = 0; xcc_id < NUM_XCC(adev->gfx.xcc_mask); xcc_id++) {
+		is_symmetric_cus = true;
 		for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
 			for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
 				mask = 1;
@@ -4250,6 +4252,15 @@ static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
 					ao_cu_mask |= (ao_bitmap << (i * 16 + j * 8));
 				cu_info->ao_cu_bitmap[i][j] = ao_bitmap;
 			}
+			if (i && is_symmetric_cus && prev_counter != counter)
+				is_symmetric_cus = false;
+			prev_counter = counter;
+		}
+		if (is_symmetric_cus) {
+			tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_DEBUG);
+			tmp = REG_SET_FIELD(tmp, CP_CPC_DEBUG, CPC_HARVESTING_RELAUNCH_DISABLE, 1);
+			tmp = REG_SET_FIELD(tmp, CP_CPC_DEBUG, CPC_HARVESTING_DISPATCH_DISABLE, 1);
+			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_DEBUG, tmp);
 		}
 		gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff,
 					    xcc_id);
-- 
2.34.1

