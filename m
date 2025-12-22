Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AD2D711D5
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Dec 2025 03:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28B7710E4EA;
	Mon, 22 Dec 2025 03:45:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B6KXzQve";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010065.outbound.protection.outlook.com [52.101.85.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7D2610E4EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 03:45:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWH0FtlGOwYG0znJ22ImFmI1ihhscyzsvgpFfrmYQjha3/zS9Iv9C7IZ3xzIBuTaisMtMxzih2HgzuUfTDsLaJGDBz6mzkVPuDFTE008j6xPY/xQ0r2Xls4b5Ht5+vYes3xs2n+KXKlRmMejQ/jZyihPWvWHMt3Cm3tJ0BP32JHSo5kFVNH0Rx3tMpOLVB9ppMKrzjoIJHVLv6t1KEhGjsamoNQzbz29Yud2HOig7OQJmIl33fPMdYheT4gx39sZyCUvBtxqbCPMBaPmbdZPDp0NQvtlBbsqsuQRpDwoPkWTxRS6PdEeniWycWYi8xIR76N1ue6BfNbJlSO0RP0LMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqO/jQDDwCq4qz1ok0/yuzsKSelgxTOuqvqDVdh24BM=;
 b=Tsf6zxhwvOro0/X8AEyCEYa1bqEh/B+Pi1kKG945bTbNyjfe5u1yvP0tssarUbwfgWjAM/OhqhanuWsWPZZKlBShRn4Q0gVE704N2MOrvJCDYAQiYYfqF7Xn04puz8OKZ7ND4po+sQsgNmxcBzNmIco9AmOKcYF9ye+HM2ezDLoYs9vWwaL0eXLyryI9lZqMB13WV8kdBZzfml4ovKF+1g1+EjoMR2uA5b//bjUt3kiOxR0zV67kqmXQLXGrpSc4G62x39EjGyKCvQ6f6tevajpGsiaXGfjR4V32nWkZ3LeyiiyrHgTfr23uZQiSUyFMJI1JvAe5g2xEwDASXd9lKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqO/jQDDwCq4qz1ok0/yuzsKSelgxTOuqvqDVdh24BM=;
 b=B6KXzQved4XqC5Bf1I0TLFCiP7z/ZOXkAhhN6iqf1UnfRawh/yAG0AiWWSGtMuEg7kM6zL1j0mOoyTTa/3GDl0ILCyleNXz3qpYKB9X5iyOQ+LVLzhfaXWTXYQUghX1xwFtbARhnpxfh6nNFUKDk3DkYFFC6Q0BzxxTfYYOsavc=
Received: from SA0PR11CA0023.namprd11.prod.outlook.com (2603:10b6:806:d3::28)
 by LV3PR12MB9330.namprd12.prod.outlook.com (2603:10b6:408:217::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 03:45:40 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:806:d3:cafe::6a) by SA0PR11CA0023.outlook.office365.com
 (2603:10b6:806:d3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Mon,
 22 Dec 2025 03:45:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Mon, 22 Dec 2025 03:45:40 +0000
Received: from lang-cezanne.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 21 Dec
 2025 21:45:38 -0600
From: Lang Yu <lang.yu@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Lang Yu <lang.yu@amd.com>
Subject: [PATCH] drm/amdgpu/mes: Simplify hqd mask initialization
Date: Mon, 22 Dec 2025 11:45:24 +0800
Message-ID: <20251222034524.904628-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|LV3PR12MB9330:EE_
X-MS-Office365-Filtering-Correlation-Id: f9a475b6-3342-4670-ba84-08de410c935e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xv1+vBIZ5R+qsDY14W86Bdvrq1l2jsfdLhpj5hgbKZpJt9r943ZeL4MrMjQO?=
 =?us-ascii?Q?dxwsFZ7T5m9IZTbD1Dc2lT0uPX+W2jwNIk7b2JQZ1R+OYDf8qC4v7VsXZbZd?=
 =?us-ascii?Q?Wo+2yVYGtE+vd33l8g0EzoT31NsfzG121i7T2MnNdfIhbqfa3+LjycPOuYvI?=
 =?us-ascii?Q?UNRE9QMs6ynqkeG67EV8s7CGou7Ie88HxNT5OfHxiNs0MQWFzSpwyEJRVwPQ?=
 =?us-ascii?Q?N6IIxkE2Eh6OLHK1kBALpb+o1/UKp00rzwNxTk3y566ASh7ioED0zUNexgVN?=
 =?us-ascii?Q?RFGR61xuV9PBsn060HsO6PLe4ASAP0hhaVvxaYZF4NJfW42u8IvbbKaf8cG1?=
 =?us-ascii?Q?cZh7RtuZpFA2xa0kDHuvQZOOAr31BmM6HJe2IQRjTuHJgJQ/T/JOTqMXp6+x?=
 =?us-ascii?Q?OeH6Ya5s/wBZRkwtKyASifTplD/SMpSXKeEnV9LMBosmcXZjDCqm69ZxZPjh?=
 =?us-ascii?Q?2cvBLnAGMwNn1OLbm7yZSCO+F0Qio7lh2hbrpXSyPrCrm42jeLRCNsg+il0E?=
 =?us-ascii?Q?eJNM+jwFQCnjxZDV+ZwK3guDE2aLk3KiezZVaSL4OMjZBR7cir6PeNXqUFWC?=
 =?us-ascii?Q?8Frfjgzlbh3nOBF7utJICpcNna6w+dmQ2s2zCO9tV77W60e280kaN/lEC4vE?=
 =?us-ascii?Q?WLkmdzWGOiaPPewp3zPtr7cK2FI/uTeddvnn7UKqBWB603Jvf2ppLDFlW8y/?=
 =?us-ascii?Q?ZZQfwDCBFNdLW7MGtNRZ6x0nZELy2K8MC1jVm6YAj6P8jajtuhhcHXkDxwLF?=
 =?us-ascii?Q?aQmZHb9Y3duaUnhR/q8qDLtAK0sU4Taj4Ar/GiC13xy+q8MCWb5Z7MLMzbVW?=
 =?us-ascii?Q?I5dgDY5KLA+2y0v6V8rOxmvr1YfyNOEq/DPhR0KFAGr9MGgJ0W7dHEl/DhaS?=
 =?us-ascii?Q?6HZNcnLOuaQsJ95LmppC3cEYlH2SYVio4DrFCKIcNCyahzxIqs02VOmp80Zp?=
 =?us-ascii?Q?1WRIf19ie7S/2kqXYDU98EB66TV7VVnJE7FMWV3zC47sWKSbnYgJGJ83cDcZ?=
 =?us-ascii?Q?UBALTgDze0+VLOmWwy6bCYHu0GVatvom9OCkggNbvUgxzrrXwXu0YH+B2kWp?=
 =?us-ascii?Q?taYv63Eh1AG9sUdvkZXpux7eFBzfmy3IgV4NJbyFETZVcoaWA2rCi2zGTyb4?=
 =?us-ascii?Q?wtvZRUAHmCRBJmAvPJUDSYo+lmpUSoxbDC42Ph4GuXMvrucnI9XP6smg0MTH?=
 =?us-ascii?Q?HAMZ//MWh03UeB87SRCnW80f0NlNon/8T+QD1ndi8uZKQ23O87AZWKgd1tXz?=
 =?us-ascii?Q?apTX+TYWXhNSWi2gvMutHAq/R7dvnrG2ICwAq79zHT0+69TVQkY/FbZQ3VI+?=
 =?us-ascii?Q?wTbm5SAQ9wD6mF5/5xBzG/2kH5Oqxs7X/kWfLv8ePeRlg6YGiogQAA+3LQyg?=
 =?us-ascii?Q?RXzUGpyteSbW95TNu87U80yMP8llzzE6zqeDCwyK87dwsIGPUaCmaYtd0twc?=
 =?us-ascii?Q?SBNVF7WchMI6h3WlOdMjFqp4E5lejyXtOpSOo1tT4u3DogkcflyNajyhn8Q1?=
 =?us-ascii?Q?mFp9AR8nB7RiUix6WA3Pra8Z607XDwwhx5JZBJWKZ8QBhKrOd2haXDNjInla?=
 =?us-ascii?Q?64rJcqTPDT8DSqYYWRw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 03:45:40.0450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a475b6-3342-4670-ba84-08de410c935e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9330
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

Let's get rid of version check and hardcode,
calculate hqd mask with number of queues per pipe
and number of gfx/compute queues kernel used.

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 42 ++++++++++++-------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index dffa0f7276b7..5b5962a727f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -31,7 +31,6 @@
 
 #define AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS 1024
 #define AMDGPU_ONE_DOORBELL_SIZE 8
-#define AMDGPU_MES_RESERVED_QUEUES	2
 
 int amdgpu_mes_doorbell_process_slice(struct amdgpu_device *adev)
 {
@@ -115,8 +114,10 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	adev->mes.vmid_mask_mmhub = 0xFF00;
 	adev->mes.vmid_mask_gfxhub = total_vmid_mask & ~reserved_vmid_mask;
 
-	queue_mask = (u32)(1UL << adev->gfx.mec.num_queue_per_pipe) - 1;
-	reserved_queue_mask = (u32)(1UL << AMDGPU_MES_RESERVED_QUEUES) - 1;
+	queue_mask = (u32)(1UL << adev->gfx.me.num_queue_per_pipe) - 1;
+	reserved_queue_mask = (u32)(1UL << (ALIGN(adev->gfx.num_gfx_rings,
+					    adev->gfx.me.num_pipe_per_me) /
+					    adev->gfx.me.num_pipe_per_me)) - 1;
 
 	num_pipes = adev->gfx.me.num_pipe_per_me * adev->gfx.me.num_me;
 	if (num_pipes > AMDGPU_MES_MAX_GFX_PIPES)
@@ -126,34 +127,26 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++) {
 		if (i >= num_pipes)
 			break;
-		if (amdgpu_ip_version(adev, GC_HWIP, 0) >=
-		    IP_VERSION(12, 0, 0))
-			/*
-			 * GFX V12 has only one GFX pipe, but 8 queues in it.
-			 * GFX pipe 0 queue 0 is being used by Kernel queue.
-			 * Set GFX pipe 0 queue 1-7 for MES scheduling
-			 * mask = 1111 1110b
-			 */
-			adev->mes.gfx_hqd_mask[i] = adev->gfx.disable_kq ? 0xFF : 0xFE;
-		else
-			/*
-			 * GFX pipe 0 queue 0 is being used by Kernel queue.
-			 * Set GFX pipe 0 queue 1 for MES scheduling
-			 * mask = 10b
-			 */
-			adev->mes.gfx_hqd_mask[i] = adev->gfx.disable_kq ? 0x3 : 0x2;
+
+		adev->mes.gfx_hqd_mask[i] = (queue_mask & ~reserved_queue_mask);
 	}
 
+	queue_mask = (u32)(1UL << adev->gfx.mec.num_queue_per_pipe) - 1;
+	reserved_queue_mask = (u32)(1UL << (ALIGN(adev->gfx.num_compute_rings,
+					    adev->gfx.mec.num_pipe_per_mec) /
+					    adev->gfx.mec.num_pipe_per_mec)) - 1;
+
 	num_pipes = adev->gfx.mec.num_pipe_per_mec * adev->gfx.mec.num_mec;
 	if (num_pipes > AMDGPU_MES_MAX_COMPUTE_PIPES)
 		dev_warn(adev->dev, "more compute pipes than supported by MES! (%d vs %d)\n",
 			 num_pipes, AMDGPU_MES_MAX_COMPUTE_PIPES);
 
 	for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
-		if (i >= num_pipes)
+		/* skip MEC2, since only MEC1 is used */
+		if (i >= adev->gfx.mec.num_pipe_per_mec)
 			break;
-		adev->mes.compute_hqd_mask[i] =
-			adev->gfx.disable_kq ? 0xF : (queue_mask & ~reserved_queue_mask);
+
+		adev->mes.compute_hqd_mask[i] = (queue_mask & ~reserved_queue_mask);
 	}
 
 	num_pipes = adev->sdma.num_instances;
@@ -167,6 +160,11 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 		adev->mes.sdma_hqd_mask[i] = 0xfc;
 	}
 
+	dev_info(adev->dev, "MES: vmid_mask_mmhub 0x%08x, vmid_mask_gfxhub 0x%08x\n",
+		adev->mes.vmid_mask_mmhub, adev->mes.vmid_mask_gfxhub);
+	dev_info(adev->dev, "MES: gfx_hqd_mask 0x%08x, compute_hqd_mask 0x%08x, sdma_hqd_mask 0x%08x\n",
+		adev->mes.gfx_hqd_mask[0], adev->mes.compute_hqd_mask[0], adev->mes.sdma_hqd_mask[0]);
+
 	for (i = 0; i < AMDGPU_MAX_MES_PIPES * num_xcc; i++) {
 		r = amdgpu_device_wb_get(adev, &adev->mes.sch_ctx_offs[i]);
 		if (r) {
-- 
2.34.1

