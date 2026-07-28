Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5D1C54F54
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2026 18:26:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4EE310E9B2;
	Tue, 28 Jul 2026 18:26:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zChaMbVv";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013024.outbound.protection.outlook.com
 [40.93.196.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE24510E9B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 18:26:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yq5FoRPyN52+hEGKhXNH2WW6Zg87XoHjkNGhoEwHYi/acppPRofg5Y0sd9QMWtelvmc+5yKXNyCuFTySbXhPQclB7MV9p8cOwcLDVDFOa2+yVe/vAVkATTw4GnM//Y3zQpTtQZFVFGwTO6fA7/2TR+6VmWky7zYcfQ9RPL28x55e4Penh9x2f03F9De9Aswv2J8wq5YXqntdsXKp9mvtudSS7RTuTCT6nKRHsRxquS2+s+mYNFSKyuMc6KQdZlJqtc4KVy3H9QGAilRtR8BC8nf2plexhgYvcjcXaEQg1vHXl/PXih+VZrcULGlA20F5HzLmBujB3aqDooz5EXhong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJbNHwxhrEpg/+hcWc4A+vf6r6QFHRL4cGmlLFxRAaU=;
 b=QC0PMAwfMWhqIKLRz/f0APL9xaQFMgtBMPRcLlTglxUsuEVMC5hG8tV2kfVnAQxUHCgPdWy4PaFSiMc2jhNyvrcvTyUFzGIXxnSgerZJ9169M1uXUgvN5SFU8SMGA44BCu3OexJ702+wpWJ8kXl7V2+okXrrqEjUlejlnVxa9pxcSbHdsBYMpYKVCo3AISmLOuWOZHj7Gj79IsgPNFeQskFshXFrK+Y3QKq2i2DWzYFLj892Qe00fIn0LsHTOdakNVhDhcfi+h8HxDBg2EGhJTrIVg2DznoqroRMLYozrrtAT6+UnVZvzkvklThDowkGgtbLbTTcEJWyOeSMTe9duQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJbNHwxhrEpg/+hcWc4A+vf6r6QFHRL4cGmlLFxRAaU=;
 b=zChaMbVvV+4T4Czkh5zC8UpO6qbf7eR1ROPm4QPo60KcG+DUU+xVncFgaxqroYJ380yp5izrNev0+RZtu88TBFKffNdPRtAo7K03gfHlHrImLOo1zpFlHvOtjRilRJmG8ZC0e9l3kmyRcG111MD9Uj8/LxpVO2aZCUqS+h2CY4Q=
Received: from CH0PR03CA0312.namprd03.prod.outlook.com (2603:10b6:610:118::21)
 by BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 18:26:26 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::54) by CH0PR03CA0312.outlook.office365.com
 (2603:10b6:610:118::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 18:26:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 18:26:25 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 13:26:25 -0500
From: Amber Lin <amber.lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <david.yatsin@amd.com>,
 <jinhuieric.huang@amd.com>
CC: Amber Lin <amber.lin@amd.com>
Subject: [PATCH] drm/amdkfd: Fix signal reset event
Date: Tue, 28 Jul 2026 14:26:09 -0400
Message-ID: <20260728182609.672822-1-amber.lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|BL3PR12MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: 824e621e-d9d9-40e0-ecc6-08deecd5bc06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: z7PlJpVn1BmbzTYUWvUH16m91Sdyw8lxhQEwYRBvibXc6W0VUXMeZvhwA1OOTVsO3bZG/aZpeLIQv3FttJhCrtRStb6FbzD3fBTAG+nogsbKdgJbh+2N0pm+aP4PE84Oz0vJJY/6ZwG9AmxkWWEDgY967lxKGvGg8Q5qskBBPtOzxXsOHCimBa+pN9lGyCsKngnEfnmdMWCFwgSd1RuBLj0EJBX8YZTEehzGgPccT0IYM+L7crWl93wRftLZgwPWbYuKD/vz3aSkt0ZrVXvHigMxHjgFD3c7EXRqzChnrlDPrOI6jv92rFGwwwH9Ldf3bvsZewP/p2YNUmm2t/wcZOZbnbkvIG5R+y6ja8G3aRR27NfTqd9zXU3vgycZ/EdIbhdZ7KaioZFHoiIWidQMtcOf7FmgVdDnDk3gB+CYiC1AtF7sB4suh8EETizJMIN8HxDPCQ8CZYzEPebITLdDrvoJo1bVa4CrbIBsxFnY9FzqE092bbh/eKV3uF4Oj3NX7zuGp2gVnqCvxzvpI/TvZ9h8ikzgnHMGdSaU/7zfkEXw/2cJeAhoW07Q/6e9VMK+hCyvtQgbgiGTKTOw41VoQwN1UqJtltfY8tBg6BPym8ieKY2mHlYqnDMs/10kDQu4XQVx9jEE45ti7idThjQr5KN0nPw6V4SIon+UTlvF3HVSWzPJ5YNjOirky/n1Ho2OZtqdu6CVYfYVIYVrTY9GCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(11063799006)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7dSz+1T9C1sTkBQ5liGgBvHYvTda9OymkSC8ehjaQxvjtpCN6bANDECFiTIv1USk95m1zqYtGqHlgzTAW5p3K1u0Ksoc/dcU/1sEsorngQKCsc3pHHQ1mR3RzbL+XuKtZG5BvBC2uxxG8PXIYX4G1lQOfATTVZbgdsu+s1RhPkOf51lxEdram0FbINraHxDKwkZKHuf5o+XklSWldNvLQPdD8wOAEizOIepwcpreBRg2fIrXxKOLANc6YeSm/Ag1TWiuuALitWKcRQ9/i3n/Gvndk4dArp5f35cnxcchPZVDrgi6PqrqlI2qRgg4DnR0zxpXJjr8D0G473pAxEmTLW29rSId7Mg5vyEjMTMZNO61HrdXJES50JrKuKdjpLuGfhWziHk5EBS69Zfxp0DwgnQXKZhPd+WVNVR64Ud4xY3F/CrzFirWiRku09L6jube
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 18:26:25.9390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 824e621e-d9d9-40e0-ecc6-08deecd5bc06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049
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

When a mode reset happens, driver needs to notify the process on that
GPU a reset event is happening. The existing code assumes the process is
using the GPU that is getting mode reset, which is not always true. For
example, on a 8G system, the process may be only using GPU 0~4 but a
mode 2 reset is resetting the all 8 GPUs connected by XGMI. Trying to
find a process on GPU 5~7 will fail, which is fine and should skip the
event signal.

Signed-off-by: Amber Lin <amber.lin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 5fa156e89a73..6e32a892d56f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1164,6 +1164,8 @@ void kfd_signal_reset_event(struct kfd_node *dev)
 	struct kfd_event *ev;
 	unsigned int temp;
 	uint32_t id, idx;
+	int user_gpu_id;
+	struct kfd_process_device *pdd;
 	int reset_cause = atomic_read(&dev->sram_ecc_flag) ?
 			KFD_HW_EXCEPTION_ECC :
 			KFD_HW_EXCEPTION_GPU_HANG;
@@ -1179,17 +1181,14 @@ void kfd_signal_reset_event(struct kfd_node *dev)
 
 	idx = srcu_read_lock(&kfd_processes_srcu);
 	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
-		int user_gpu_id = kfd_process_get_user_gpu_id(p, dev->id);
-		struct kfd_process_device *pdd = kfd_get_process_device_data(dev, p);
-
-		if (unlikely(user_gpu_id == -EINVAL)) {
-			WARN_ONCE(1, "Could not get user_gpu_id from dev->id:%x\n", dev->id);
+		pdd = kfd_get_process_device_data(dev, p);
+		if (!pdd)
+			/* no process is using this device */
 			continue;
-		}
+		user_gpu_id = kfd_process_get_user_gpu_id(p, dev->id);
 
-		if (unlikely(!pdd)) {
-			WARN_ONCE(1, "Could not get device data from process pid:%d\n",
-				  p->lead_thread->pid);
+		if (unlikely(user_gpu_id == -EINVAL)) {
+			WARN_ONCE(1, "Could not get user_gpu_id from dev->id:%d\n", dev->id);
 			continue;
 		}
 
-- 
2.43.0

