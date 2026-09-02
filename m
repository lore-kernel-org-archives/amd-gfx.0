Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1C6C61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 12:50:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02D4C889BE;
	Wed,  2 Sep 2026 12:50:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mtEPXLx2";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011068.outbound.protection.outlook.com [52.101.52.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E84F410F1B3
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 12:50:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imAVemH9IXfOBH7rihme4WMeIYuyJiRTZdSR8SOFBOdtGXu6ZDpPZUsK+SwOsYTSAQaDxresKXJEIW/lrDJyr0YLKpKhA/wz+H00+zJOfNrfQDL//i2Qr8bgz7MxWL58avHOwFJQrAz68dVhQZYR/r962yaAqP3f3WpGS8ep3hZUeOWcM5DeJGoLZbUGRgCIYrRvytu8KxqMBORRSxGux/BYYL4U84kqIakO1w670yOrmER1rM/gvu/yFTA5DRNiGruQypWTaPgiz9Kvfhg1LNIyrR9PZhrEMxKF1nylGz9i2OWnSv5vUCa7n9Md1ybMClYYtHVgtS7MJoU/iPzdOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4Hwl0rIBGDwsbzErTOWY3N3q/PYM7v75D1ELcTy7mU=;
 b=CMGqmxjCJWRakaRDHFoj3kqLMoN6f4N7Vnx5+dWBuvYJMfKoW/mX9gtAjNUwcOzrYm8mlEd916fxCIixEAeBT8kq5dQSAZCTuJWbRp1ZceZjBihyixrCxG9puv1zHRU+ognmi3MnkqAipckLpHE0q8k6/CaNEef1LJZNXORM6yNA1MLPHSgJMgml1XoTRaiFgcSLdT7XjyLz4ROpN8eWKq3X4IcfYayveeVprkM/LkaS3B0reMxvcCe8AHqBt0l1uoNAiSHxq3GF3SVv2u4fRP59jF/HDSw9Zb84Q3+8Up4lwimBEsWckltlq9JYCJJbzB6jxBa1O529amDscowa6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4Hwl0rIBGDwsbzErTOWY3N3q/PYM7v75D1ELcTy7mU=;
 b=mtEPXLx2dHFjaQBph4dSDNPvrXaFaFOoJjYZ6R2hE99e0cZrYs0UiC22nj44R0ImEVPSZ5Ot4N8T/OMhwU4X2qfmfFPRLmf2wU76yaBIKH+PQHgxW+hzl2Eituo8S3P901dWnJ5uDLMzmeUaEYBQzfL3EURpM4xe1c0RwPhaQyM=
Received: from MW4PR03CA0279.namprd03.prod.outlook.com (2603:10b6:303:b5::14)
 by PH7PR12MB9201.namprd12.prod.outlook.com (2603:10b6:510:2e8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 12:50:39 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:303:b5:cafe::59) by MW4PR03CA0279.outlook.office365.com
 (2603:10b6:303:b5::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 12:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 12:50:38 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 07:50:36 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 16/18] drm/amdgpu/mes: skip userq_notify_unmap during gpu reset
Date: Wed, 2 Sep 2026 20:49:59 +0800
Message-ID: <20260902125001.621629-16-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902125001.621629-1-Prike.Liang@amd.com>
References: <20260902125001.621629-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|PH7PR12MB9201:EE_
X-MS-Office365-Filtering-Correlation-Id: 850f4252-acb7-43a0-fd28-08df08f0ca65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SVIg9HZmJwF4R+OOpgYyPWFjlbJ7f0sLGwxdjfyyd2hFmDfngMsX26g3U9GTTmNMuEeMUD0gxlocwhsD8uMqoMDBvZlpk/0sWG1C2JGdb2NCS8jkfn/e32rDT3WhMRu6Kv47bHrI9/GLH1Ku3tuUl0Zbi0/FYoQ9q0T0YnkpU7Mp08Nk1CjMf/W2zOuI9m8hd91OJRl2v/6Kj668/j1SGTagEpDmke6GClWv4Xy15q6QRo4Qub4enXqlV4hzlTUr5jaB/XY+nsAjlezBuVYqONLGpb3QRKGqDJKyZGAXy7CJ7gQ5sH2D7Dz+hrJ0ZrP1CNzjg79YjBQGLKZj1v8zzhZlEIPMWl1Phu9zHqSISol+mb93+qcdXzfITAfAYke/iPPc3RMdy1Vc+2SkcjMjRoxjyn0EK/Rb25fnTPuOzSTe7wJVB/39tQZuaKRuxcIsz/TvZybfR9ac2HArE6CAhxyXYvi+XjHc8CygG9f94FRCFsn0NDu6iVA3X1S5r1p6Po148vrJwxILhYyUPCvf8kftIVSG7BF0hbS1AZR18j3Se2zXYlqCVZmhUHuUj5l3RyAyfl3MsN80Xzdg8RlAqEgjwV+aC4hcm2s5aLkBvvR0Tb/veydeYDNkgHrl+VMfguk9zsWnPEU3F3zMV/4MSOdb/Qhrc6Mc6MoBr8jveSsqgNLXURC3VqzNokiQPHjM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ijT6qAKzRfNG+A7fhOlVMqp4jXbLorTgoOvG4rwXt4W/3Ko97VimrpvGyX21THRYwTwuAhYQzyS+rblAoPZoHhwPsC53sjTORjn8S56zPqIkxZgB/mA2+xLHFkBd2vthL8Ea4NMnvc8wYWOL/jDH0H5W1WY/yGJTczM8YJp+VQP7zVl+CTHH9op1mzK5E/UeEWGu6UaEyVcmMXiKB0x4CFUpqhgKd24sDUPj+Muz4ne0FROb+43L63xjwPKTukV2hy+uowOAYvxhPbBs0vtvz4SqQgyxaZVOeFbrjs54laTnDpLmtQ+4mo8pM2O0MpiFQmFg8ATbAc1NoIMBJZUtkyv1Pp+5TEHIYvbf8DTe+baNxvJc74H+7CDnt9fIWXReup3rCLBD1qQeKZNTwYxvE3LwTeMdHYorP6JZHGu9RiEX4lVfa6HIK1uzdlH7hoiY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 12:50:38.9480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 850f4252-acb7-43a0-fd28-08df08f0ca65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9201
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

To avoid the following issue, it requires skipping
userq_notify_unmap during gpu reset.

[  356.185682] CPU: 13 UID: 0 PID: 599 Comm: kworker/13:2 Tainted: G        W  OE       7.1.0-custom #40 PREEMPT(lazy)
[  356.185690] Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[  356.185694] Hardware name: AMD Majolica-RN/Majolica-RN, BIOS RMJ1009A 06/13/2021
[  356.185699] Workqueue: events amdgpu_mes_userq_notify_unmap_work_handler [amdgpu]
[  356.185952] RIP: 0010:amdgpu_device_skip_hw_access+0x73/0x90 [amdgpu]
[  356.186156] Code: 85 c0 75 2a 8b 05 71 56 d7 dc 85 c0 74 d3 48 8b bb d0 e7 07 00 be ff ff ff ff 48 81 c7 88 00 00 00 e8 f1 50 79 db 85 c0 75 b7 <0f> 0b eb b3 48 8b bb d0 e7 07 00 48 83 c7 18 e8 39 fe 76 da eb a1
[  356.186161] RSP: 0018:ffffd39142dbfa58 EFLAGS: 00010046
[  356.186168] RAX: 0000000000000000 RBX: ffff8bfc09d00000 RCX: 0000000000000003
[  356.186172] RDX: 0000000000000000 RSI: ffff8bfc04e00c88 RDI: ffff8bfc0b93df50
[  356.186176] RBP: ffffd39142dbfa68 R08: 0000000000000000 R09: 0000000000000000
[  356.186180] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  356.186184] R13: 0000000000000680 R14: ffff8bfc09d67288 R15: 0000000000000000
[  356.186188] FS:  0000000000000000(0000) GS:ffff8bffb057d000(0000) knlGS:0000000000000000
[  356.186192] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  356.186197] CR2: 00007fbd3797c000 CR3: 0000000150642000 CR4: 0000000000350ef0
[  356.186201] Call Trace:
[  356.186205]  <TASK>
[  356.186214]  amdgpu_mm_wdoorbell64+0x20/0x70 [amdgpu]
[  356.186425]  mes_v11_0_ring_set_wptr+0x71/0x80 [amdgpu]
[  356.186670]  amdgpu_ring_commit+0x5b/0xa0 [amdgpu]
[  356.186885]  mes_v11_0_submit_pkt_and_poll_completion.constprop.0+0x207/0x4a0 [amdgpu]
[  356.187181]  mes_v11_0_misc_op+0x8b/0x240 [amdgpu]
[  356.187462]  amdgpu_mes_notify_unmap_queue+0xa3/0x110 [amdgpu]
[  356.187713]  amdgpu_mes_userq_notify_unmap_work_handler+0x24/0x70 [amdgpu]
[  356.187954]  process_one_work+0x23e/0x6f0
[  356.187984]  worker_thread+0x1c4/0x380
[  356.187998]  kthread+0x10c/0x150
[  356.188004]  ? __pfx_worker_thread+0x10/0x10
[  356.188010]  ? __pfx_kthread+0x10/0x10
[  356.188021]  ret_from_fork+0x314/0x390
[  356.188027]  ? __pfx_kthread+0x10/0x10
[  356.188036]  ret_from_fork_asm+0x1a/0x30
[  356.188069]  </TASK>

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index e0e38d6bcafc..dbf535adb1b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1192,6 +1192,9 @@ static void amdgpu_mes_userq_notify_unmap_work_handler(struct work_struct *work)
 					       userq_notify_unmap_work.work);
 	struct amdgpu_device *adev = mes->adev;
 
+	if (amdgpu_in_reset(adev))
+		return;
+
 	amdgpu_mes_notify_unmap_queue(adev);
 
 	/* Re-arm if still oversubscribed */
-- 
2.34.1

