Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468A1CAC5A7
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 02:59:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C413F10E040;
	Tue, 23 Sep 2025 02:59:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sgJKOmpy";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010046.outbound.protection.outlook.com [52.101.56.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB5F10E040
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 02:59:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRvrUNgiOZV/RqNAAt0UdsTGxcPpVBDrRh70Q3CBlQoUVPOOOVS0oiY8lowsVnqNHkcWquAtR3ewJYUSSylGRq2ftWruTyjgAuVIrl3Z5cSgphfGgigW2ETK0FkjnpChbylYKtouNRgpk7/H1EyS/n4MOKCKTMqBqq7tuUnqQdEIY13lEjpk2ksqJGC88ixFvp/G8VCnUHG9Y5Byn3fd9d7DJn3SX0hu2z6YFm2LathEMWSZwhOyLkX4rab42spOTUbuuULq9LhtpOj1u8B9849LG+YFdVzN/3A8YpSKNWdJ1WIvEAXyg284PuoamSpKxyckUNpXRq5VUsnEFGqx4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOcr32wVxiqo98od+32Xi+z/0ZGaZDsO/mtNcZLhcOo=;
 b=Lv/UM5IqQb9rVJyFyADVTtkoF/QQmJQSwd4JFDR/TEBmey/8JLn17VhJc4+xPT/A9gEAu+ayvUjA2K7zgicuJEMVCPWtXLSbHbhHeRABnbCz+xmBfbrNO4Jd/t5grfWd5HgZ5GEcZeF479zdO+0KR6OBdHdZwzOtnZ5KADEm0w11JuXbU02jJfL3rYh5JoUdujk3plCLT5dtHp4hKWnof5MeMGUiLMrQCvdjIZpCcPoajZnRz33NMRk5o/DruqUlN+0FGtNbB/XX2HMRrE+eOWm3q07FJ1LVqHAlnSWEGicDoWi1+8JXHwIJDqrvdjv0Vwx8aM3oG+1N5SGJDdzIfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOcr32wVxiqo98od+32Xi+z/0ZGaZDsO/mtNcZLhcOo=;
 b=sgJKOmpyqq0ssdRv6fY1npiBCwdfXRh3Bgx61X/lBdLbx/yllgo7q5kc/dDtePvpuS6qyX5I6omJN7W/Xkqjqio8Sw05G8OWNtpOAOANy86hYkFPcjMQ+o96MzDka7ZAaTB8FubFfh82faANuio00cKDbzXGkyXMvQaucmUwn4Y=
Received: from DM6PR11CA0018.namprd11.prod.outlook.com (2603:10b6:5:190::31)
 by SA5PPF50009C446.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Tue, 23 Sep
 2025 02:59:12 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:5:190:cafe::2d) by DM6PR11CA0018.outlook.office365.com
 (2603:10b6:5:190::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 02:59:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 02:59:11 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 22 Sep
 2025 19:59:08 -0700
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>,
 <Philip.Yang@amd.com>, <Lijo.Lazar@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH v3 1/2] amd/amdkfd: resolve a race in
 amdgpu_amdkfd_device_fini_sw
Date: Tue, 23 Sep 2025 10:58:51 +0800
Message-ID: <20250923025852.1679262-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|SA5PPF50009C446:EE_
X-MS-Office365-Filtering-Correlation-Id: 997cf0ae-71e9-47fc-3000-08ddfa4d2c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ctqPRIzPXf5hi0NwUtwFaUEi8VgW3tEvK9jrlkdfs6YeoT2T45EZPIAtH8Ri?=
 =?us-ascii?Q?SF6kDK4KRdrVErgJRdFv61scvq/gTMUstV9aTthLCWnhXnn9qF7N+cY8+Wk4?=
 =?us-ascii?Q?lP4Tx4MnfBf4GYu2kybFvioECNqFcgzBxnSsgfCrFYVulJApVVXLuY+qX4BC?=
 =?us-ascii?Q?AOG8mm5fZxZAZ4zbwtYzo9XoPEM8MC12ucbGpvpaTgxWFk/TRlL0CynqgsdG?=
 =?us-ascii?Q?TSyqk3fe1koyOpTQwh8AlkvIvB5krwnYYfz/Cslwr/bwgXBurT+XMRGhqa5z?=
 =?us-ascii?Q?G9nVi0iNgthqgBNu+SyzrYkTYPl7m1pYVpP++ojRA7lAeHQDOj9KO94jBF7C?=
 =?us-ascii?Q?/cdtkiYOJnOoofII58qUuOaIBDBcI6SkiXVDaA3nQ0qXedG8QDluuFHdedOg?=
 =?us-ascii?Q?4O2U/WOIv792vpVE/HaAzBNarx/wRgbkARH5DBge/+LCB5EkQ77IiJmdZlf0?=
 =?us-ascii?Q?ejw9L0d6WJdYxcgoSwe1N11qjY6VbxZaBMBuUYytqhg69hdCVqPzcORg7J8n?=
 =?us-ascii?Q?wnPbfrp+H3e+XVkc/gZyAIIAELsVDYauPiT9yd985XPaZmY0a/oZY0qWBdzx?=
 =?us-ascii?Q?zGq4CyQLefJTJ800WVnWCd4EXXnl58fN5npM7W1R58TMrDgCW0gv3W+SCtx0?=
 =?us-ascii?Q?jIN84xJfbKTj5YVn+kExVlV6eJ4fFCPuuc9eL4PrSGpSVUBtVARarKvpNkZu?=
 =?us-ascii?Q?wObb+L0HHFmwTqcAXtdWww/wQwgBSxnDJm779gmUm3fERLIA2biVzPv++y+v?=
 =?us-ascii?Q?lvZjqpkNCSKExL+Lg7JujxdR1tXrglh7jLOdl5tFT5DvvcCpdTRETHziDWnN?=
 =?us-ascii?Q?KDqndI/jQUE3+VnlShoHT1FNUALd3o8actHqGgolmV+a5sNvmVtepwMXHC0K?=
 =?us-ascii?Q?MSaauX1Eir0CcVJRweKpPEUlaOYl0swIsN06V7LwjHXiv34gS76cw+ecN9on?=
 =?us-ascii?Q?Gmy+ZqAWIOZFV0GYZOeQkxI+8SkUtF+atcGd/ttI4mwQgEWpTiFI0UMSq8w6?=
 =?us-ascii?Q?16Z69TgVj2ApQXASF/seLGsFbQhri/OP+VvCj1DJiZwQm0+SmCpEUVIyuZ9w?=
 =?us-ascii?Q?TPVA4z7p1uJlrbTwv6lNYscALrESCVt+pJqe42gFuqtVUvLioDxy+PLTLZwd?=
 =?us-ascii?Q?RVLh0EmDI9sVmOywO7aN2uWEvbphP0tfzgV9k52UqkKYSU2l9eaXT9BSkefQ?=
 =?us-ascii?Q?qhTZY22K4rX+qtYJ2aDYnj1JD29pL1/IPAEP5jMMgQw2ZMMcgkVh0nnYmExz?=
 =?us-ascii?Q?CFw9xcAVyH+NOCS7girD4yGNyRgTVoyz8QCQE50segQw0i/iI35fOJ8FVl/m?=
 =?us-ascii?Q?jx12qMxSOKlmc6JHfCdnk4ksIgonNEkVE/fv/xwM01V22P+hsY9ZNPmSLba1?=
 =?us-ascii?Q?dYbg7UxXD6qZ8lo31zR/NaZbLQLSwKkv6fZo/scH+3PaM9/ixWkLiP1sGL7a?=
 =?us-ascii?Q?VHIMOWj5uc2BHhOODIJrdDlhyBTuB9qEKhRBrfOLnqH5Jlhp+RL+e61OqihS?=
 =?us-ascii?Q?/OwuNiv0Vp9qJmFWzvw+pD2KVKgPkCE1KQJL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 02:59:11.4678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 997cf0ae-71e9-47fc-3000-08ddfa4d2c16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF50009C446
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
index 349c351e242b..051a00152b08 100644
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

