Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EFCC4451C
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2026 18:32:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39EFC10EB0C;
	Tue, 21 Jul 2026 18:32:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Golzh6jm";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010041.outbound.protection.outlook.com [52.101.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37F4310EB0C
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 18:32:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAzxRzubBt1pcz6mjcGyc156BTA4QNho6a9qaQziy5pgnD7dAYC5JSFRNMbdhsPY1520Cudla8dAOMj+HmRFq15iKLWiEIqKtLyKFJ4uBE1by3YNWpAcG+miAfDJKMFQcI9cSZU+5bdEmBy+jMPWvcXXmLapWZKEHPlL9YbfYggo+2HfLHdh9vcFwI118PdvW1XTvJ00mOU5OXKvXvs5p//AGb519o4w8700lBRo1T9DgJT/VIvyIB8Fx1buUbsbe5u2hfHiTy+a7VirI+HlL/G8W9tqhvBwBR80a/iG4yThJ5dMDDONipdB9XYNFQIDew1KFdUnHVoHDgDCS4wJDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFoBiM4+L4tuFPW/3UHUbcViheBk6N0Vp5z0hJlKgkA=;
 b=ccciyh2yidEkn8oVVzCh/+ru9de8yc+PmVPNw+6CNYCiN7RkW7rbCrUmD4fMY9pLg+4SYpRqi8tKFWv6q0NVvDeYGmD91gog5UUaX7rJIC2xEjO3mcDXkeaeZJIvEvEPWJ3q9G9klqyXpNhQGGYlxQVIlYf7T/fJC8nTe8DUYNwwcoeGaQFGm6zfRsJD9cS/OZ1klM9uCSPmLnD2L7Ugs+Xi7gO3zHehpf6Ii6Yu0k2RR6abEpOoZVaCjXzgccRqXvIKYdH7Ytd4oDocqz2DnZPjQBsVzUx1oEoHTFzZWDlolSexmxkkQcjAWR5o3JSLWlWBj27P6u+0yq6y/7wm/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFoBiM4+L4tuFPW/3UHUbcViheBk6N0Vp5z0hJlKgkA=;
 b=Golzh6jm9v0ovLStV/JT9ilSL8FZU6kgXi0Fx2/kqE12TSxA+WLMEARgorpCCj2V+QU57aCkuLt4uNIgMb7YpBM5YhLs06T+CqW9nlnytumCokQnWhniw24/c66bIi4ypmZCQPDQdEW5b/0N+/eUKWO92/v+y541MhkWIZ3EE3M=
Received: from CH0PR13CA0030.namprd13.prod.outlook.com (2603:10b6:610:b1::35)
 by PH0PR12MB8821.namprd12.prod.outlook.com (2603:10b6:510:28d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 18:32:08 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::60) by CH0PR13CA0030.outlook.office365.com
 (2603:10b6:610:b1::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 18:32:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 18:32:07 +0000
Received: from sclement-ThinkStation-P8.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 21 Jul 2026 13:32:06 -0500
From: Sunday Clement <Sunday.Clement@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kent.Russell@amd.com>, <Harish.Kasiviswanathan@amd.com>, Sunday Clement
 <Sunday.Clement@amd.com>, Sunday Clement <sunday.clement@amd.com>
Subject: [PATCH] drm/amdgpu: drain SDMA before process eviction during GPU
 reset
Date: Tue, 21 Jul 2026 14:31:50 -0400
Message-ID: <20260721183150.303360-1-Sunday.Clement@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|PH0PR12MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dcc812d-9d4d-4fe3-6948-08dee7565e7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|6133799003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1UPHLMOSTZB+/I39m6SWfk1aT1/pMlUKA03gn55ZBxmm1T35djXNwqxXEMRbH6gb2B6163rCLIz9sqEBT43o/sXR/JseNgc+/fhKOhEJWFnxS8mtvBjKtsXlmX8eUGez1x4zdZURQHCORHp0ARhhJLwi7Q4QEVQvUM9GJanMcY9gpxAaTml9JDJtzHRQ8Y+mEcXO9BhnGYn2CGXMp1GyR6+PzEvzokwdF6FZZnnqrTh4qUo1oTwk/0Yh+kGt029mDaFTebr+i4DnHtLvNJxHbzDlbQ55YLzKPfAE65uSEJWl1sjoXySAF0JfySiCO2jhazZ3WBO+4+cpOXIt954JqwBZLpNelDq/dGaqXQSllXRu0OrVR7ySWEeTgHnSUiy2NRzZj9HVpa4OxagtcGvhnCNQsHQjgVbxQirGkn+yG/j2hOW4dIZA/5IRk4RmP2Dpm2nnpFFkpXMAHlySCrcgYXrzxmSGN331OnNq4raS/fhyIxPRlfnOiACTKEM2NeTcUPQw1ILjqtCB+Ar9QxodkjS3LVXAOod4W/fgfepdzdDURekHHywKxV7Y+JxcSt8ZjIsQ7X0Zyr/TESHyHmA7kNowjjlL+0c5sZLLnIuK6kUTWJAfObgbpUeFl2tXiaSgB1RGzXBEBRVDauYayJ1GK+MYy+ShHxoATN2/7wDSikOY4zx2SK/v7V+5jQR/d7gnut3tBEieGJ3FgtbzMTcD3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kPb2gOmvBfq9bs9TS3jF6+lY5G5dJ0UdFalXalStwqcSdn39dPo0OKPAwbHItsJc01Mv4idsEnAFdEkLckURrVuUNDP3N4vhP0tSQlVdvGTq5Bj+9cUwopn3fMDw78Fis2ot93k0ePQ3wb8cRpFIPk6yf8y1JYtpG72VWSdlyFEyhUnrqsy8qHpR8XayMCP3O6f5WFzlCRuJa9l67FkjPsfBj5hUWISgfJ/hzRDsnwIK+vZYVvxz19eEUzWftRc085TiJQNvTo1Xac9SB9G7cY7rKCyA17Kj4Vv7cEiXSEOlnSyraghC8JDFReY+JyET2+huqzOPiRd7qlOySbOgm8Lce//Sf4UKEl3qgLNbH5Hpxgbad2bpREQI3oePdpyrZs/whEyK+qkxAAdsj0vyxKbeHDXvajeOnvji3uiKz7kMrkczOdcwdDPjBIxZvDV+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 18:32:07.1206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dcc812d-9d4d-4fe3-6948-08dee7565e7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8821
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

Host kernel panics (Oops in free_swap_cache) when GPU reset is
triggered under multi-process load. The crash is caused by SDMA engines
writing to memory while munmap clears page table entries during process
eviction.

The race condition:
amdgpu_device_halt_activities() loops over all devices in the reset
list and calls amdgpu_amdkfd_pre_reset() on each device. The first call
to amdgpu_amdkfd_pre_reset() triggers global process eviction across
all GPUs via kgd2kfd_suspend_process(), which starts munmap clearing
PTEs. However, SDMA engines on other devices in the reset list still
have in-flight DMA transactions that have not been drained.

Fix by draining ALL SDMA rings on ALL devices in the reset list BEFORE
calling amdgpu_amdkfd_pre_reset() on any device. Also flush the HDP
write cache to ensure SDMA writes reach system memory before PTEs are
cleared. This guarantees no in-flight DMAs exist when process eviction
begins.

Signed-off-by: Sunday Clement <sunday.clement@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 31 +++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 472e96ae884e..0cd3dc4cffb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5340,7 +5340,36 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
 					  bool need_emergency_restart)
 {
 	struct amdgpu_device *tmp_adev = NULL;
-	int i;
+	int i, r;
+	struct amdgpu_ring *ring;
+
+    /*
+     * Drain all SDMA on all devices before any KFD pre_reset.
+     *
+     * amdgpu_amdkfd_pre_reset() triggers global process eviction across
+     * all GPUs, which starts munmap clearing PTEs. We must ensure no
+     * in-flight SDMA DMAs on any device when eviction begins, otherwise
+     * SDMA writes race with munmap, corrupting PTEs.
+     */
+	list_for_each_entry(tmp_adev, device_list, reset_list) {
+		for (i = 0; i < tmp_adev->sdma.num_instances; i++) {
+			ring = &tmp_adev->sdma.instance[i].ring;
+			if (ring->sched.timeout == MAX_SCHEDULE_TIMEOUT)
+				continue;
+
+			r = amdgpu_fence_wait_empty(ring);
+			if (r)
+				dev_warn(tmp_adev->dev,
+					"SDMA%d ring drain timeout before reset, proceeding\n", i);
+		}
+
+		/*
+		 * Flush HDP write cache to ensure SDMA writes reach system
+		 * memory before munmap. Prevents cached writes from arriving
+		 * after pages are freed.
+		 */
+		amdgpu_device_flush_hdp(tmp_adev, NULL);
+	}
 
 	/* block all schedulers and reset given job's ring */
 	list_for_each_entry(tmp_adev, device_list, reset_list) {
-- 
2.43.0

