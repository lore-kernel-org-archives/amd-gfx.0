Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC040CAC5A0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 13:40:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63D8410E8A9;
	Thu, 18 Sep 2025 13:40:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EFIuORWb";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012032.outbound.protection.outlook.com
 [40.107.200.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D89FA10E8A9
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 13:40:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZhIx0yvov4/m4jJHxfbSCa54bQuzrE8sHi1KSHfXzvTA0fo5AC+NslvnrOru0sIVOQoDa020ir0BNe9Ar1X8mkF6OkOloBVct1cmxB2Xr7dNtJkKhd1BGzPDYlfipEKw7mDiUhLlzxDHOCP+iZuWchzEA1iu++MqJPVJTRh+jTt3nNdrvmHocdtjIJ8hCo1sxngSj1DCW/FcaQ/FribEpz24qLF7FH7dvXdwovudkAZqXArPLjlHEX2bdokKwchbH8ZV7h0s3MTN2q4/E2HVtt/UDZu73E1NXKLg2rfEURbbO/qO4iTOe4sRoNd3UbPYunISB1wE6wmj3uaWaGCkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYSEXelS+s/Kh2e4ZKTH2YAlNYKjcHTUFYogYwLjxuM=;
 b=M7j4CeK83akxSdenqediKLhyqhSNrPiGZy5KIQ2/I/u7PYEC6gPm6Qqm5yskIp6qfTXshiqIoBc5ZmpqmPQ7mVCU3x/NzAl54naRTK58eBH+9s2DMDhR9/2kHsWH1glSwTYHs6aFLtqE2+ESKpZQpgiQ8BbtMbiZgILYi/eaFpBswNprT0ebbS0j5j3xc40elhEdCGuzepIG5sY5+8bOEWl3Uh2hxs8MiJ0mgBkUX34oiREwuadwJGFG99K+oWCwV4ZhmDEFzIgxshHzp34BQkXsohs8KCX3UKOsWj+NaX+r11sS6P3PIXYU5E1ahqu8bh8rE2MPpzPRdn9bP8BXQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYSEXelS+s/Kh2e4ZKTH2YAlNYKjcHTUFYogYwLjxuM=;
 b=EFIuORWb95cPmnXmPFFaOMMvGLGjrzifTparYCJAfQHZRorRA9hFE7LWo3dyIaJXKqf4r0kqbEgH0mZ2azgHT3WLifGsJV5FrIT4g08qC2v7uDBTqiNGsbQJOCkY3Sl+P0p3boG8cPlBlW4X80XnH5YRfRf6L7RDmK4FR7S7K5E=
Received: from BN9PR03CA0319.namprd03.prod.outlook.com (2603:10b6:408:112::24)
 by SN7PR12MB8772.namprd12.prod.outlook.com (2603:10b6:806:341::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 13:40:23 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::d8) by BN9PR03CA0319.outlook.office365.com
 (2603:10b6:408:112::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Thu,
 18 Sep 2025 13:40:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 13:40:23 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 06:40:20 -0700
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>,
 <Philip.Yang@amd.com>, <Lijo.Lazar@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH v2 1/2] amd/amdkfd: resolve a race in
 amdgpu_amdkfd_device_fini_sw
Date: Thu, 18 Sep 2025 21:39:59 +0800
Message-ID: <20250918134000.948525-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|SN7PR12MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: 46e28fde-35ec-4338-18e7-08ddf6b8eae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R90SJUdeKDfgJUddfzGtDzDBh/PlJcRP3MWX6kisJkE6/8klGrdNeEndSFKP?=
 =?us-ascii?Q?XUIZy/xeGxF5yZ8dPPtZ0fEzGzZVZts5NH5XcpL82NjELK6p85tmi1XW0VrA?=
 =?us-ascii?Q?mV3iVNv4yCQYDFMzlUN2mboUb1mZ2LeBz2GXJW5VYEp9lrRpYG8weWsvwK2j?=
 =?us-ascii?Q?hxQ0SV/2Ch4j2CnGaCE0ELBP7K6d6gz/LYnLZvFA3eH6bBTPxAS9Ip+vZBHD?=
 =?us-ascii?Q?nhkevJeDcUxCMXrXkhURrAaYIRKsrbzYDQLgDHWIPW5f70qZn+1xXmtGCgFo?=
 =?us-ascii?Q?KbSLYwaNcQCgflEmUvvdQD+dDpT/0Sdi+UngXMJB/JkTGI6gewELK2upLHO/?=
 =?us-ascii?Q?ARtJPPxReqC36I/Idu2Htmlcngw2buVl4ISPehAmKEow9WhOQZUOqlj9bnca?=
 =?us-ascii?Q?M+/ldy7iYNwIELauRsFU8x+4YUrq2neRzazidYptJOH6p/Rn5/S26ME7XRmB?=
 =?us-ascii?Q?xqoufZGLxDDXxBPfK4NiqlrXedbqD1awFL0DoVzzQSnzKdL6ppPemM9h/pHo?=
 =?us-ascii?Q?8iZ9r81rigaIwU2Jh510GAPaFyr8TMmh//jsvYp/lYJnAQbpS17g54mbo3H0?=
 =?us-ascii?Q?z0karMrQ7YDT3vuvRnYU2yqJSQ/KgmOdqf2v7mDhC9RoUiCbt0Iicin4vKmz?=
 =?us-ascii?Q?rLdn2OX0FYszzL3lIQRGQAOpAY6SmZ0yz0f5Obq66Zj5uNBEu3jKW0NRetZD?=
 =?us-ascii?Q?SRiBrjhyE5BtsdIYjITVdQxxk+JmQg6Qdkl6qLW2cJwJ1fPuhj3bbXgalDHp?=
 =?us-ascii?Q?tmqwpseQcbQBiOJ0C/wXTajRbQw73tBP7eAVjEGl8pXDC9B7gDFImWJ6wA7f?=
 =?us-ascii?Q?JPn/UkE0R/qxG5dX+PG2nIVTfW6rwniPMMb99A2rxIEPT2aB0HyDmbpfM+NB?=
 =?us-ascii?Q?sI6IDwmjl67SzAAa+dw2ZjRXtwoYBDL9l0VwEzq63aeqRzaTUC//MiE3r55S?=
 =?us-ascii?Q?L1L8aj3dbRVfIe+xOwMyLmbmjUocrJDCNjmT0DQcxRkgk2QMxWW6kKEpY33K?=
 =?us-ascii?Q?MbROjw2juW8UVGKfO/KVAIqMQB3XJaiyGNp++woQjKnc7PhdV9iB+uj9EAIC?=
 =?us-ascii?Q?w5kSk6j+zc5DSLHSUMOS+7GY1pLXmUHA1I7SZS+Bc0ScZfZgdhQZhbLU8Tc8?=
 =?us-ascii?Q?5ycZssgM1P2l08cZEWRhj7H5XN+lwsgFvi1XkVebKsn3cmvqJmYVd/odb1fw?=
 =?us-ascii?Q?Erq5nYfyYe38cKRTlRwxrtWydbJLvHsO9d9MpGhmCeu7Li4FjU5aouHQD9db?=
 =?us-ascii?Q?bvy3puuslZ89BvDcVEFnTZLWrklqdoTcDrKcG0tOnsBOu5OehBCuhm0Vj4Zh?=
 =?us-ascii?Q?UQVI5J3CsRVXR+E1BKGFjzjLPo3jA4zBdcDZFUFgGQsxjqZ66JsWDzJwiMXJ?=
 =?us-ascii?Q?sMyF7vDGf+rwVWlVraLHwUvxvJZbEBxJMupj6gwfw5q6vhQz7Uz3n1mtSZaq?=
 =?us-ascii?Q?cayrr7lEtfHdm8MkZ4oyN6QZqy2el6S6Gnw2B3Qy3+abWkcT7zPfgCnF0pmM?=
 =?us-ascii?Q?uWdkO81uuPHXmlfmu9qa9x6jiOm4EZ3JmS8n?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 13:40:23.1480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e28fde-35ec-4338-18e7-08ddf6b8eae6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8772
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

There is race in amdgpu_amdkfd_device_fini_sw and interrupt.
if amdgpu_amdkfd_device_fini_sw run in b/w kfd_cleanup_nodes and
  kfree(kfd), and KGD interrupt generated.

kernel panic log:

BUG: kernel NULL pointer dereference, address: 0000000000000098
amdgpu 0000:c8:00.0: amdgpu: Requesting 4 partitions through PSP

PGD d78c68067 P4D d78c68067

kfd kfd: amdgpu: Allocated 3969056 bytes on gart

PUD 1465b8067 PMD @

Oops: @002 [#1] SMP NOPTI

kfd kfd: amdgpu: Total number of KFD nodes to be created: 4
CPU: 115 PID: @ Comm: swapper/115 Kdump: loaded Tainted: G S W OE K

RIP: 0010:_raw_spin_lock_irqsave+0x12/0x40

Code: 89 e@ 41 5c c3 cc cc cc cc 66 66 2e Of 1f 84 00 00 00 00 00 OF 1f 40 00 Of 1f 44% 00 00 41 54 9c 41 5c fa 31 cO ba 01 00 00 00 <fO> OF b1 17 75 Ba 4c 89 e@ 41 Sc

89 c6 e8 07 38 5d

RSP: 0018: ffffc90@1a6b0e28 EFLAGS: 00010046

RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000018
0000000000000001 RSI: ffff8883bb623e00 RDI: 0000000000000098
ffff8883bb000000 RO8: ffff888100055020 ROO: ffff888100055020
0000000000000000 R11: 0000000000000000 R12: 0900000000000002
ffff888F2b97da0@ R14: @000000000000098 R15: ffff8883babdfo00

CS: 010 DS: 0000 ES: 0000 CRO: 0000000080050033

CR2: 0000000000000098 CR3: 0000000e7cae2006 CR4: 0000000002770ce0
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
0000000000000000 DR6: 00000000fffeO7FO DR7: 0000000000000400

PKRU: 55555554

Call Trace:

<IRQ>

kgd2kfd_interrupt+@x6b/0x1f@ [amdgpu]

? amdgpu_fence_process+0xa4/0x150 [amdgpu]

kfd kfd: amdgpu: Node: 0, interrupt_bitmap: 3 YcpxFl Rant tErace

amdgpu_irq_dispatch+0x165/0x210 [amdgpu]

amdgpu_ih_process+0x80/0x100 [amdgpu]

amdgpu: Virtual CRAT table created for GPU

amdgpu_irq_handler+0x1f/@x60 [amdgpu]

__handle_irq_event_percpu+0x3d/0x170

amdgpu: Topology: Add dGPU node [0x74a2:0x1002]

handle_irq_event+0x5a/@xcO

handle_edge_irq+0x93/0x240

kfd kfd: amdgpu: KFD node 1 partition @ size 49148M

asm_call_irq_on_stack+0xf/@x20

</IRQ>

common_interrupt+0xb3/0x130

asm_common_interrupt+0x1le/0x40

5.10.134-010.a1i5000.a18.x86_64 #1

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 7e749f9b6d69..5649cdb3f9c2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1133,7 +1133,15 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
 	}
 
 	for (i = 0; i < kfd->num_nodes; i++) {
-		node = kfd->nodes[i];
+		/* Race if another thread in b/w
+		 * kfd_cleanup_nodes and kfree(kfd),
+		 * when kfd->nodes[i] = NULL
+		 */
+		if (kfd->nodes[i])
+			node = kfd->nodes[i];
+		else
+			return;
+
 		spin_lock_irqsave(&node->interrupt_lock, flags);
 
 		if (node->interrupts_active
-- 
2.43.0

