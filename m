Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD8FCAC5A5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 15:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3CE710E75E;
	Wed, 24 Sep 2025 15:29:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0afoI1G0";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012001.outbound.protection.outlook.com [52.101.43.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3868F10E75E
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 15:29:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MeiYs8Z+K/sDcEmnduXeQ/63rBxcyClGzKj3aQn/9TY3bfy1uDVArVXbI8Nn6PUAr7clocJmhV2Tk7UNgVaLjbweFWJezdSuOPCi7Q9gAuYp1eLGS+PAy05xqYS2WjGuPtloCuzqXZGJdaOdmOHzDKwNDrQHj66n48WWL8cVIoxXvOAbbH36BMY9KAyiEfZfO8mcTOISWQnKgcOnRZ0RXqY3pz+5gwaqFwKWf+DYrgimAl7FCHgifOV+Pu1uqIbF0ENfz2ByFeueF4291lbRAbjZ+SOIf/6u7btbWAz9sZisWAR9O6FzUMqWGbWX2gT+Q06JFwD2JRz6k9Ekrtfu4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOcr32wVxiqo98od+32Xi+z/0ZGaZDsO/mtNcZLhcOo=;
 b=tTpSc6HCGqbYdV+XzFtkLawsy4b4PKRRurBl2z7t+RhzSXmoTfFtKTx4NAuhkprhw2os39jveXQRRsHg50R+5fxTOEjoQK+1tJHfAfGIXorGo8nztIQKFo8vB4/MZxoZfxAUCYjSK4cGnGNOewCf6lUTxTbHQpXuIbBekPug7DmLl8um3M3hNEz96WTnWiOV2cIWnwMEr+mR8Iuji95uMrZETovHAqlu+aPbnWwXYggqjWBuZa/3k4n8ZCCuAgL8Yhr8MdH+HLs4aX2+6+O6m9p8hMFc8/xDfb/qdteNKfocoNNpjXZEdONTbAunnw1sd5ZKopu1zqnhO2oSgoYhcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOcr32wVxiqo98od+32Xi+z/0ZGaZDsO/mtNcZLhcOo=;
 b=0afoI1G0b0qunTm7vjTwbdeqznkQWmFE5C3Mp81nwm3n13wNkAj72dl7DBhdfyiXAvekB9O6OKT5E0rFrJtDpQNwMStQdcIpu4YbExygij4IUA8W3pUNTLYaAI6hrlSkcthndaJCzNn0fUBfAnsy3G8BM8DaJIv7Z1RkNF9ya8o=
Received: from DS7P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::12) by
 BL1PR12MB5923.namprd12.prod.outlook.com (2603:10b6:208:39a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 15:29:50 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:8:1ca:cafe::6c) by DS7P220CA0002.outlook.office365.com
 (2603:10b6:8:1ca::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Wed,
 24 Sep 2025 15:29:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 15:29:50 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 24 Sep
 2025 08:29:48 -0700
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Philip.Yang@amd.com>, <Lijo.Lazar@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH v4 1/2] amd/amdkfd: resolve a race in
 amdgpu_amdkfd_device_fini_sw
Date: Wed, 24 Sep 2025 23:29:28 +0800
Message-ID: <20250924152929.2234747-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|BL1PR12MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: be92c024-1dd2-4754-72c3-08ddfb7f33a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qQro0dyZpqwMSNdxbrIErbkeWdCPL0IpvlkrYVhflYHEFVBlJUvkUPhkhW31?=
 =?us-ascii?Q?HyLClypzUT5p7+ZdyCsEPKG1So3FdQ2NOFyghP3TA71zmvbUwPQM+bjdqHY5?=
 =?us-ascii?Q?gFyu3wZQ5kQbq4HP2ni4NOmeB1H+FtV0UKEQHAGXfEHZEzoOhJzag+HxfCK/?=
 =?us-ascii?Q?o6fnKHH2KB6z1ZVPKHXtYxRPWslb5lsIDcngYV07dN3U47jY6fLAFg6q4r8f?=
 =?us-ascii?Q?dV9bFQy5x/2e8oA9yy+nDUTbJyihlVjtSKTIhAmPXyDQXR6cmPA3RRpsDmDN?=
 =?us-ascii?Q?/wnwLnarB3OyBYQ0ok7sMdQJ+OXh8JPVbVb3Q6gwXGrsJf9F5L6+4vOLeJHa?=
 =?us-ascii?Q?jBRbTup7BRxvcelYPsvz3MonMkY3/6KycAB3VpnX2D1epovi5X15kWRl2t1Y?=
 =?us-ascii?Q?UazFfjK5rDXX4ZIUqCMNE/t88qY+9nWrIRkySEn+8TxMm/VNWxx05IdrpO+d?=
 =?us-ascii?Q?piX9dWRAcf1Kcj2Y9Z6UKMiOb4V2xVRgE+nNWP/kOxahxM7lKDimh9V1XeHn?=
 =?us-ascii?Q?1qRWE2xjMl1BAVJaLpdy2NuY9SNTFYidYFJy/k54nLSB9bQSGvhTliOjzjtz?=
 =?us-ascii?Q?4npIFI2du1AurEp1ib+hhP7alC15fMW1om6jdFjnKBnpZ4zQy9T/0g6QeEtr?=
 =?us-ascii?Q?7L/K4yrqRmfNh7MLSyaPvb1mbWzZJNjvJG3wJ9TyFajXu27oitu4LQ+U00rW?=
 =?us-ascii?Q?0LBBEXLSfvNpo/sdqt/fszHpHhbPWScrZRX56NuvLrUAL/tca5rC3bt81G2v?=
 =?us-ascii?Q?B+U/mBN4Xk16sOx/+5br1C3JatWSA9eOdE6dSZanwcoHiuW0ZB6WZIlqoCvu?=
 =?us-ascii?Q?gNKUy/p6BN1S462TG/RMQPA2X5z2m8+bsu398XhNMiENo5pPtdQhyfUwapt2?=
 =?us-ascii?Q?0RvI4Yfy27/XPdxv3zZHCzki6aQyRLrV+c35VdN5HAWkaaFe0PXLMfbj4D4j?=
 =?us-ascii?Q?HZj4tPYNQtluCvE8vLyPdrCnwZn41pWBOgxSUeMiFNgS54Jbqm+0O9hqCX2a?=
 =?us-ascii?Q?lavAG4Onvmx0qWF0i2dSRfDk9swLioWnbN3+wCc/7Wa/37CeIclKzSRA4mCc?=
 =?us-ascii?Q?Ztjk+4mwRrxTJzYt7+/qHI0gVXoDO1X3JzlZ3jjP3VN66n+ra9+POe9hYKvE?=
 =?us-ascii?Q?TLWRpAVvw0+zLOqAht4T4BKI4uhj46opjEZsLA8QCnnQncfbDq1bjJSrlWC5?=
 =?us-ascii?Q?V94OVAejhn7nQtwy+Pk9uS1mBWLuFWTn4YOcqarOxFkkuJRLlDEAV4ucnLWE?=
 =?us-ascii?Q?gO/c6l1cdEeIuWeMGQ1NOsryHoZwT8Lea1PUvLkcy3wfuQiPbPH0w4jxyhrc?=
 =?us-ascii?Q?Br2IUxijJtoG8tpyO6dB0BfVO/vWN6RThMV2wvb012Wll5jJF3e9w/9hB802?=
 =?us-ascii?Q?Z71XT+TTEBNgdVGhMIL1hs0aj1RIDyT6X5kTAtD3iH/Yipf779vT+cKuVMjB?=
 =?us-ascii?Q?TpgAfGX+b6SiQ7MVOvt7jzYotD9g6/Lq95lx4A/4JtaGGcQwUGFSGm/vloud?=
 =?us-ascii?Q?n2B1yOxMYHNhuDC480FX8b0h2ZbV5a5gXzjn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 15:29:50.1449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be92c024-1dd2-4754-72c3-08ddfb7f33a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923
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

