Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40B9C83F14
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jul 2025 20:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7818B10E85C;
	Wed,  9 Jul 2025 20:32:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M1xDlJBR";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D3F410E85C
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jul 2025 20:32:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXKm4pAl79gjIvMLC9AY1jWaVxI97lEexlAhXxsJ+G0tO/pbxKXOOy9NezNevx6Twqabl8AQpQKkNI7hl/qU73yPGRPD0zHnLtfk6jDQxhPNPHlejkwFtr3eW+F+j86p7q+cYLuOaQJq9SwZ684GFrSXN6zO2O3WKpXp6VL4qRPv07gvUR0X9vYwsycQ1e/dWMmOfdDECTfJkgnVRITW7sYZJHJxfe+2xuvNRza9JSWV/osxbItPEso23NlfboirF8Fi6rzS3TSX2to2FULxW9rPPrmlwXP0rpVgNzJZEfHGLRG59E8emB1Neuui7MJoaHdPPXb4T+3OOYHzFYYjKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtwdpnK0F/k3r+YEvBYsscO/scmiMXitbDyZIA74GTE=;
 b=QDds7Xev4inCY+sgAfryxbTJXeyLJ8INyFMImkU9C6ZE8fbvv5RLaVEoWYcwJRLnvb+RVOWBm0mioto9DeHh0kdedrxwFg0LRlEQjtz7Xa34bUTfFFuj1/7TM2us7A8L198IG8HfK3XJc8rrdMT5ArX7EI1+oxkC/p+AEBXWrs0YpzStXoCRH270BfNice1N82QZjhuY73L4ako9q+WJ2St9aZUnq5O/w+KkmF2YJerbVJwWvgg17q0bG9bc+Bw3jb0NuXyvx4XLdtvnuJxo097tSQIPhggRfiZdEelJsGLzVr+ocUiClySp+52vDussCCTYX8c3HJ9AdN8K9JZXdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtwdpnK0F/k3r+YEvBYsscO/scmiMXitbDyZIA74GTE=;
 b=M1xDlJBRfeADV+7B8i9u/RvXX2j3pGoK9LtAopyfe4sgzQZQPRzQDt0a6yXRijQmnkKUQiV76FWbcrZi1qdeb9eK2cOqobU0s4IQuvWgoTHK1TTa48+hgsh0lxEDRwAkcdvob1BIMvQhxOiUh/pNTpFrCkeNZMWgu4OtoBsKFnE=
Received: from DM6PR07CA0074.namprd07.prod.outlook.com (2603:10b6:5:337::7) by
 MW4PR12MB7468.namprd12.prod.outlook.com (2603:10b6:303:212::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 20:32:12 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::8d) by DM6PR07CA0074.outlook.office365.com
 (2603:10b6:5:337::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Wed,
 9 Jul 2025 20:32:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 9 Jul 2025 20:32:11 +0000
Received: from Devmachine.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Jul
 2025 15:32:11 -0500
From: Gang Ba <Gang.Ba@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Philip.Yang@amd.com>
Subject: [PATCH v2] drm/amdgpu: Avoid extra evict-restore process.
Date: Wed, 9 Jul 2025 16:31:57 -0400
Message-ID: <20250709203157.404490-2-Gang.Ba@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709203157.404490-1-Gang.Ba@amd.com>
References: <20250709203157.404490-1-Gang.Ba@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|MW4PR12MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: 72798c03-cad3-4b27-dd73-08ddbf27aef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1ltpT7yVor71Yhyu52Tp6tvG+QoBzAlT33h5dMmCpe1i+lyqxIbRZ3I+ppwY?=
 =?us-ascii?Q?t6E1nHhK2c1PQThMaQyfJQhxmLyNmXs8kSVmncHNdB4EhE99EIsiMd5mlZZ1?=
 =?us-ascii?Q?6e5XYTyExEESNNjjiKAww80EL42a0bh7C7F90DZy+4pGZFlnBFiZ7d04qIMa?=
 =?us-ascii?Q?5d6qa20IuH4FdS4NKTUM/MNAbhQ9qSrb/uBU5Wi+JPbD8LGVQPfXFREeJbAr?=
 =?us-ascii?Q?HIxNyWE0EPZBAXvPPE0TGRwmPjpnZCsuimu2JMtZ+puAvgC6nXnm9lf2TrsA?=
 =?us-ascii?Q?SkFRaecKGUiU3Jm7NORNG39JnGa5e5v39Z9TbwEWjqAzOLJffG/pDFCZtx0B?=
 =?us-ascii?Q?F/BX9LxsPUDg2pfmPKTatTwkWoxL25mzk8J0vzA0sAOrL3LCBZ+QoqKelWJZ?=
 =?us-ascii?Q?QXzKx52Uol4bhzxRd8G0pr2eRkAwV3aPoVdYIL/5RAIVaqpBBBN7VXJ4AiNU?=
 =?us-ascii?Q?lEZR3aOFEM9PRmaVLDX/sKLNJLWgEwN98eT+BmME+m01WYGAj5K+BiP6Ovw4?=
 =?us-ascii?Q?vImvtT6MV8wa0EwbSEdZ3QumLQqioj4YNmzONW6aLgF4A3nm49z3lV579Vsw?=
 =?us-ascii?Q?3bGH7NjUdUykxW7ib6YXd+hiEGCUOzqD0FsylL8Zs0oDwvsXRL4NU44+KvUF?=
 =?us-ascii?Q?95iDYhel3mnYqX3vLrJKh71NIk9EogmNayoS7sy+yNpnpXXY3kFLfm869UNB?=
 =?us-ascii?Q?xArFwsFVLxyUEocIzO5I9f3AwLIAwHWVAxTGD9SgP33jJuCIuBJOWdTzFDNJ?=
 =?us-ascii?Q?LJQLhvHAATDehnbYFUW8xzGmdBfBXU4jEWeUazHOvG6tqL2umgLfcXUl6o2T?=
 =?us-ascii?Q?P0ehrR73NauXh+EGWa8bbe2jVOviTljV5ui5aZvtX5rRzp5DPDLuXk4uNZPl?=
 =?us-ascii?Q?ZdR3pnHAiFC2MnV1ZTFK96PpbVeuGtiRGdXAix+IBKAuQ5YmkjiJ1sWesAMR?=
 =?us-ascii?Q?XLxXe6cChFBHbqkw1I4mGbRNyZbJ6ruakIhJNRAliqB1bBEnJKPrgT4sua9X?=
 =?us-ascii?Q?vCsW2M2LK8KBogXJYqSvLsXzJ8akWyuz423up9CpnoeH5IEf+ZzrM1m2bSpS?=
 =?us-ascii?Q?+fNz56P+q2J4NCW0S3HHF0GLTg9xru9Mr+Pv2Vp7N4NvxPhju0/4a57dHRLl?=
 =?us-ascii?Q?7xSrVyIgLso/e4iMgZgKXRQdkwDSJutfUlCIffNTxB8nAw8oUADi2neTz4UX?=
 =?us-ascii?Q?sQHu6aYKSWX2NK53QQdB4DyYT/EcoSRnCyN0Ze7ZKDdey8wDC5OvcTaLg3Kg?=
 =?us-ascii?Q?x6u9rtUeUeassbgp6Yld9tVz4R9e5VrFIhDVNLkvp94jsDI6shcTjLEqH6Av?=
 =?us-ascii?Q?s77rejk8/6U3f+3foWVggwq5nwc8d9mzxCw9pccroSndRnuXvW6NUuCcww1z?=
 =?us-ascii?Q?86J/Nop3BikG6xxKa/TF/F3hXDDADf/0H10G19aTi8NZ7Nx9cAztxjDddPa3?=
 =?us-ascii?Q?h+nCUXi2i/7g2w+yGGy98o+WnKl/Vl6snSqOkiIS/etU7cEJLyCan7+7lLx+?=
 =?us-ascii?Q?QJIYTquv3Pm7p+2c6PXLpvJvSTcQ4Vx4XM44?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 20:32:11.5391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72798c03-cad3-4b27-dd73-08ddbf27aef1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7468
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

If vm belongs to another process, this is fclose after fork,
wait may enable signaling KFD eviction fence and cause parent process queue evicted.

Signed-off-by: Gang Ba <Gang.Ba@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f042372d9f2e..01e4f3ec22e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2410,6 +2410,13 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
  */
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
 {
+	/* If vm belongs to another process, this is fclose after fork,
+	 * wait may enable signaling KFD eviction fence and cause parent process queue evicted.
+	 */
+	if (vm->is_compute_context &&
+	    vm->task_info->tgid != current->group_leader->pid)
+	      return 0;
+
 	timeout = dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
 					DMA_RESV_USAGE_BOOKKEEP,
 					true, timeout);
-- 
2.34.1

