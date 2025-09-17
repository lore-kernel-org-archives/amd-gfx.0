Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE23CA0EE8
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 03:39:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11FF610E030;
	Wed, 17 Sep 2025 03:39:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LIYzdW/Y";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010052.outbound.protection.outlook.com
 [52.101.193.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4FEA10E030
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 03:39:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZ+jBntJ+zv9PLHrAxHYCdtB0A13rS6BdhXyd92NKEtwBNz79bqEoEL8ZD8rIwQHOae7vSOEZDRm6uJ25LLSB8g4k+3f6PZSAeOhsxIlYW6WiTS4ZZeM4XXulJ3sMtEA5+oXDm2wQI9dppy2ZwwLANFgsJD24I16kK1KoF9aJfmG0DwaLTqxoiKZwsrGm9RWBsMHRk3/oO1GVFsp/3oiF4KyF+T06m/atGK0tPqBzmMywL38n8ObbnwrrZK9oxJzvdnO9tw3/C71haZwW0c1YeslALohHTlRcugWz94G9qkmEb9R77xg/CxWEKFkU0sVySpXBN2C3HhcjIHvJFTrwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYSEXelS+s/Kh2e4ZKTH2YAlNYKjcHTUFYogYwLjxuM=;
 b=Q48bMfbq/MCdG1vpFnDgB2vKuettcPPwgZp6+QGy8O+dNLbhH18bq9GVNEcuOWPKY//9aU30V6YUwZ1zS94vcWcYw08PiDnzkhmGUU3X12PDk92uW3sfWajVnYvWgCwAmSO1deysfZ3FzZbukSO4IC7Tz51Z1bXTZbd0qf7z9DasJka+6ugPtfcjEMnpms8a5MroGKKp3im7TJPxGTiIcS7sXntEHFVWcQHBkWE+IqUGIuqfPTss+rxwRk2hmsdDfwKYbiX4/8vBSZAi0Hh100Gr2bug58AGywTqnuDW1/G+AIxRFiu8jCaGTG1k0jaxh7/AgDHY0dTY2Heutyjhwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYSEXelS+s/Kh2e4ZKTH2YAlNYKjcHTUFYogYwLjxuM=;
 b=LIYzdW/YBCYF3GKK6J0UQYNxPSdEpCQ2qko2uN2XImo6dOOIlQ6MPgthoRCBWw4A/uEQft65zu+uz3G/josK4UwqM8VOrH/DWDMtvQVjVtiErUu+VajOai5NeQa1md7VRXvvcVKCzYkfv42pqXfB38jlTpXTbc3g0R6ml84ey9o=
Received: from BYAPR04CA0023.namprd04.prod.outlook.com (2603:10b6:a03:40::36)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 03:39:47 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::ea) by BYAPR04CA0023.outlook.office365.com
 (2603:10b6:a03:40::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via Frontend Transport; Wed,
 17 Sep 2025 03:39:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 03:39:46 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 20:39:43 -0700
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Philip.Yang@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH 1/2] amd/amdkfd: resolve a race in amdgpu_amdkfd_device_fini_sw
Date: Wed, 17 Sep 2025 11:39:17 +0800
Message-ID: <20250917033918.904142-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|MN2PR12MB4046:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d167b90-7d59-4566-6ddb-08ddf59bd909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ap9WLgGt7R0ovSsOChLRuCJxghMko7CJ9qia2AXbEI9GU05XWW/jCyEOQjQ8?=
 =?us-ascii?Q?2NyNgLmF/bX8l01jurvxAMlFqsxRdD9zpt9QHPP2h5B+o717k6e9HBlsWKXd?=
 =?us-ascii?Q?PFj+95oCXjC4eVlCLSfHYtwm3/ctCb/dADXEVZwBVVp+umkENiwKSqcmpQv8?=
 =?us-ascii?Q?Z1R6AU0tWx8QbkM+VzuYw3RCHuVqyJI32vgjZ75h52uETnSIObj0ZVfcL5S4?=
 =?us-ascii?Q?rn3wInQKtK/AnCdrWUfmIDC4D3RkTsLQw4l96/yJIFh9BdyFidFy2sZJAm6n?=
 =?us-ascii?Q?FhmzPAkzy2MB7f3kzwophGU+RNJS0IU4nOwdnSHItrcj/Av0xiOkxucafaA3?=
 =?us-ascii?Q?+AJFJQ/KOeHSZMJqkLaJrn2TUfHw/q/7vPITz0SMXDd1wDsg4kBsgXjAvQIz?=
 =?us-ascii?Q?dFwclLG28Y077EM+y1WOuduaQ8TTPFQ8ijA4wUUIYvMOeK1VBjdKiVAKDg32?=
 =?us-ascii?Q?NF8d1z6onG8cdpfxVetKDytOXA1WpinrLMRt+cv43FdWBlOK0BJ1rRhqQO/z?=
 =?us-ascii?Q?XzDqiM6c1y4B1s1hdPgzEEGOX4SSi2ulV3Yy4mmdoOsW8rHdO5WCjyqHoPdk?=
 =?us-ascii?Q?KgUxDF9kGFv7le6FEonRpd5ZQYaMTx51IdsSgiJNtRStjiELNRLiABbodkgc?=
 =?us-ascii?Q?nllnGIjHZmjTby2oJZfIFb4mLNZttAd9w+I1ni8qs1h4oq0atmZL7T/l+M8a?=
 =?us-ascii?Q?q2GMCr2sQLiGJ6pc7sA7MvGxsx2JlNwiAu4UWCHn96YGA1EI0jS+4mrYeocN?=
 =?us-ascii?Q?VDoIG7taMdlbKPkL4xCuvEKDlGTAlm0awlumVTpUiC2c7ou9oFuClxE7tURJ?=
 =?us-ascii?Q?c8EVujMextuyK2EiOT4tTIBar9iQ1I+BJdhimNI6pBoZfGcydJ8vnXVyZQB9?=
 =?us-ascii?Q?c3/lbkKUOy+vO5/OtBkBEYZtwAazM1FMdbQvzrzlyd4ilAGn0bi5ywguXSVz?=
 =?us-ascii?Q?RAfy/klhdSRCJwvcfPFsrBLZy3TziEPFEYfZWU6sJQ/NPpFh8mrsytqDvLNQ?=
 =?us-ascii?Q?UCR2XxuMPF9MQsvyOkPWjpKg9imxH9BgAc9kKD+PkHoFxLupGHCsV+WG3F2e?=
 =?us-ascii?Q?AzM7Ja+659T/ZxGn+qp4OJKgZJO9jUBcyacoy7mchB5RoRi0H1Rwoht5fYXg?=
 =?us-ascii?Q?MzFp8lWJISDl5vxLIk0ru6bZ56KalMUGzdOi/WUa+WpJ2+3Jo+xjybTXYcOh?=
 =?us-ascii?Q?rvK76XqSWizA7aySnRwBQBhLWXApk8Zdrm5voJowhxaXn7z5ZtT92bLySEFC?=
 =?us-ascii?Q?5z89VEO80NTcVzQNwDv8uBF8eQsljIVVhlpFDhqxQbyBvo7mkhTiTstoQlyJ?=
 =?us-ascii?Q?NyDBf+nNzI2bisbH9dfjGfwubauMF8eQFaZAB0BnA5NbvVwfIzO/795Wdc8J?=
 =?us-ascii?Q?b1P4bLSmCK+LNBLX5Oj8sSuLSrfvq3/7OEnubrp/6Fe/HdGD0hUId+SI7skB?=
 =?us-ascii?Q?wF43nNu2CLboM0tMSHl2P0LZSVtGgpBKoxXlnffBeRfAl2876uajeu/uFuy7?=
 =?us-ascii?Q?g1KrBI/MfghOOJBRdTA4eUg8Twpl6QZ9hbIk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 03:39:46.5500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d167b90-7d59-4566-6ddb-08ddf59bd909
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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

