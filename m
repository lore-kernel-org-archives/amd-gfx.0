Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05453C624D3
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 12:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A33E10F1BC;
	Wed,  2 Sep 2026 12:50:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gtt5I20m";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010054.outbound.protection.outlook.com
 [52.101.193.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D06A10F1BE
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 12:50:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zU5Y484m9/ErYohSSP51Yof85upVAmHyuQe9DyN4V/ainm//to1i3fdTuzB47xp3QwKaVikOoUVbyzmUdWXxZy+pnC7Jk8M2PY3lDA8IKDcxXptSVPDrDeuBi+NjWuLRU/q4r3wGC8XFBhpAg1Mu2t5UkFCDcuOUTqLxKKYZLUIceiTVDuYbVlxl7WkWmiITM9DJ0gp20V51QX5g25LCKEC14vltu3KXBjH0hW2zgyF6i568MGHomyt1gapAUtCv8fcFP0i2J8gCFPmEvhm2RFYBcl5CDgASJOMKcUwW43pttbhi5KKJV0ri0PxCzmGZkB94fcWxZuqEmlj5gp5CQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GSCNpwSaet31KMBiuco+TmzSewgbHV5TdszY+1nlto=;
 b=czywp4vAIJzyb3JUBobBq2P+7FwvN0DxutRjlq/+hUMLHtkVW1PaTm50d/QNi05ALdJZEs3NiTnXYX7VLtbaslBuQp4+Ok0dYmTkOta76L8p9bVKZk1zti74RilCa9aCD7/+9gb+SA5ZNtszno05hqa4R5V+YrEStLpzUFMvgEB2bdPbM6Ddtn6VMQZXS7refUQ1u4LvjFzWeL20y6vxa+AkyeVGKO3W2Ehsw8VEgM2PkIWtb6RBHoGFZqUxKwuiDwWcQHqQ/VNOH1ZRm4NzFz4rx8xOF3+ohXtcgbSTvAVMG0+mwB+xxOah7UA/Z/KUQhueEreDrEwKEE+9Ii8N3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GSCNpwSaet31KMBiuco+TmzSewgbHV5TdszY+1nlto=;
 b=gtt5I20mSkaQkcoZculdfWNIzd9bW7c+lVFVvB+OFhXbS+geCNrBsKPw9U5fhWkXhvyg99NKgX+5+HblWEdixFm8vX8V5Cgj9W6Io89wsL1IbvhkWxsHk4rWUhoaERUsQc2qWS8c4Wsm2D7axAohu0ue+HD06z7li5EHXmJtxyw=
Received: from MW4PR03CA0283.namprd03.prod.outlook.com (2603:10b6:303:b5::18)
 by SA3PR12MB7975.namprd12.prod.outlook.com (2603:10b6:806:320::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 12:50:37 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:303:b5:cafe::43) by MW4PR03CA0283.outlook.office365.com
 (2603:10b6:303:b5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 12:50:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 12:50:36 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 07:50:34 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 15/18] drm/amdgpu/jpeg: skip scheduling jpeg/vcn idle_work
 during GPU reset
Date: Wed, 2 Sep 2026 20:49:58 +0800
Message-ID: <20260902125001.621629-15-Prike.Liang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|SA3PR12MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: e02d866b-7a45-4c05-ef74-08df08f0c8f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AzPyfBxG99ESUTyi8nthZlUXzGEc8mdoL0teWVpIGEcwtCjaG/lZr5LS33O2DY2yiL4oPBiFu44msqJ88ZT8Q4+fSbis9sO/syy2XHC/hODf/erlCLYR1bVggiQKIteNUNJvGKJ8EacUp8OPyZWhnvBXfTdWNjyPX5TPQ6Cboz7aZyf3Sheo0dl0flO22GpW3D5P2FK3J224X8Rsf37r479VLUVA7hcfhLt4MZT04LITnb0238dCta/bKKLYX1TqwCZsOky2ep4atRm/WCc9T5WtDhKTHUbh4BbpHbA0IOYAAimAW1IeRukiPhhhpk3MIjcv+1c+QmTN8FpMinzhX4SF3GiBzVS32sSU3w8IUAeQIApLX4xOAOOJXIOQSnMDylEj/p/m03sudvGQ/WeEfl5vh2x0rQxTK8M2srrb9tL3/67D6yWXddvkLliN4xHhjDimXHh0eKioJmSHE1QUdciM+RgDd7MFek9E4wTyIMroG7BSGnoSIFMiVbvjgGrGKDx82860wQbR3GVT9diCChewAhlcRKJPI0KfCKkbyo3miBTYzNZEHjLyAZ2kzkirunYaJwE1vwyqclJiLK4ov2nRj8qbkwNS0r61Ssrdc4W0IQ39mjzaSb44xbY4N49Y8oC7tQjeBePw0VWmzwjZ/YBc0dN+CGr/WlyGtsOd5uLww2SQ+vOiglD4H++nYRr/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fjkg8+tWni9ZXV/QIcnAr1YDM3rqeHPYNCD0o9/KsTrDzOvlN3FDHc3k0gi5T+6ijIxkPwLSZDGgipTddNlvYFkW2tlhByQTdn7PZkK+KJnm5Iar1gmElSpL8FCOXEuOmNyGmP3ykGpf66ZpHX9zp4mv7d+VYzuaB9SIXrjGjo7qSCy0lBzxzF/1PDvKy9cYi1EafoTA+H7fry+HXlxOo6aNWazkqEuef+E1qqvmlSSbuptZkuUe2WRI4Rz6C+a58F5NLfsxW2wUcOU3/JCO+jpgve8Z/cHpT82C9xnpga2yqmkYPEu5AEFVoZrjyK5+f1fwq3eyLq9IOEipxKLZLUYYZisFupjguugp40rx2CnoTcSJG7oGWK+G0I//GvG9WqcE3k42Px2E1B/GSdEZdhzQIf122/fcVSwcj8CcNDn06A+j/pZRJVY6W8ni79io
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 12:50:36.5047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e02d866b-7a45-4c05-ef74-08df08f0c8f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7975
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

Scheduling jpeg idle_work for JPEG/VCN power gating during GPU reset can
trigger a register access assert before the GPU reset semaphore is
released, causing the following error during reset resume:

210] Workqueue: events amdgpu_jpeg_idle_work_handler [amdgpu]
[ 1576.787453] RIP: 0010:amdgpu_device_skip_hw_access+0x73/0x90 [amdgpu]
[ 1576.787656] Code: 85 c0 75 2a 8b 05 71 56 97 f0 85 c0 74 d3 48 8b bb d0 e7 07 00 be ff ff ff ff 48 81 c7 88 00 00 00 e8 f1 50 39 ef 85 c0 75 b7 <0f> 0b eb b3 48 8b bb d0 e7 07 00 48 83 c7 18 e8 39 fe 36 ee eb a1
[ 1576.787661] RSP: 0018:ffffccf700e6bcf0 EFLAGS: 00010246
[ 1576.787668] RAX: 0000000000000000 RBX: ffff89cf52d80000 RCX: 0000000000000002
[ 1576.787673] RDX: 0000000000000000 RSI: ffff89cf04f56bc8 RDI: ffff89cf02fe8f98
[ 1576.787677] RBP: ffffccf700e6bd00 R08: 0000000000000000 R09: 0000000000000001
[ 1576.787681] R10: ffffccf700e6bdb0 R11: ffffffffc1635c96 R12: 0000000000000000
[ 1576.787686] R13: 00000000000084d2 R14: 000000000003ff01 R15: 0000000000000000
[ 1576.787690] FS:  0000000000000000(0000) GS:ffff89d29a37d000(0000) knlGS:0000000000000000
[ 1576.787695] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1576.787700] CR2: 00007fea0cc1ca50 CR3: 00000002e6c42000 CR4: 0000000000350ef0
[ 1576.787704] Call Trace:
[ 1576.787709]  <TASK>
[ 1576.787717]  amdgpu_device_wreg+0x26/0x50 [amdgpu]
[ 1576.787925]  jpeg_v4_0_stop+0x47/0x140 [amdgpu]
[ 1576.788170]  jpeg_v4_0_set_powergating_state+0x53/0x70 [amdgpu]
[ 1576.788410]  amdgpu_device_ip_set_powergating_state+0x67/0xc0 [amdgpu]
[ 1576.788642]  amdgpu_jpeg_idle_work_handler+0x105/0x120 [amdgpu]
[ 1576.788887]  process_one_work+0x23e/0x6f0
[ 1576.788917]  worker_thread+0x1c4/0x380
[ 1576.788931]  kthread+0x10c/0x150
[ 1576.788937]  ? __pfx_worker_thread+0x10/0x10
[ 1576.788943]  ? __pfx_kthread+0x10/0x10
[ 1576.788954]  ret_from_fork+0x314/0x390
[ 1576.788960]  ? __pfx_kthread+0x10/0x10
[ 1576.788969]  ret_from_fork_asm+0x1a/0x30
[ 1576.789003]  </TASK>

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 208566ffe898..a66da05cc3f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -145,7 +145,10 @@ void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
 
 void amdgpu_jpeg_ring_end_use(struct amdgpu_ring *ring)
 {
-	if (atomic_dec_and_test(&ring->adev->jpeg.total_submission_cnt))
+	struct amdgpu_device *adev = ring->adev;
+
+	if (atomic_dec_and_test(&ring->adev->jpeg.total_submission_cnt) &&
+	   !amdgpu_in_reset(adev))
 		schedule_delayed_work(&ring->adev->jpeg.idle_work,
 				      JPEG_IDLE_TIMEOUT);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 17db7264269e..6cf08e35dc9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -549,7 +549,8 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
 	    !adev->vcn.inst[ring->me].using_unified_queue)
 		atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
 
-	if (atomic_dec_and_test(&ring->adev->vcn.inst[ring->me].total_submission_cnt))
+	if (atomic_dec_and_test(&ring->adev->vcn.inst[ring->me].total_submission_cnt) &&
+	    !amdgpu_in_reset(adev))
 		schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work,
 				      VCN_IDLE_TIMEOUT);
 }
-- 
2.34.1

