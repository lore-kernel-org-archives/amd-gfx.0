Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2439C83F26
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:40:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5306E10EAF1;
	Fri, 11 Jul 2025 22:40:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qnpk/9Zq";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C032E10EAEA
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:40:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SH3eNFQ+GCNAEBTFQmCkuJ3dMZPQbz9v+M7qCHgyi2uyG322qXmpgbxQaxZPqz4LSjv0zDqv3pXYYUgdUqPHYOd1qxaQc3G/H10x0nm1WTtUIdC57qh9+1NiuV7i7lyijMI7ZkC8UTUCsFOWvgeV10L65E3THyh1FrX5TNiCOv835oWhb11stS17M27vuoGiWgYqLxr9WEmj+Ci458K8v5gFMIQtVFWDzSVU4ywA4G8sj6a6TDI6PixbrxECq7Y9ZXrf885tXXlW5WepYS5+fpf1wtnO7lPStTliETgX2NuO/tJUnnvHBEILnzrXq5jRiyjvkC6PdMaEritLbqNyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77v7ugQj46fJuBrpyeQk7MLawIuarzc2mQaEjzfn9pM=;
 b=iK8bgQGGF9UfyBvdxQRQEWsGsdRXIk6/ZMrDD/xTanKB54CNE8R+cx+4BtwILWzeDLhKIueYXCvm4QWqdFxBgj0JqOx+Q/1dEN5WWSWaAZzshwt2sZA+su73X3dVsLULlL9Hgib+KX6TSIAyQvwtcg+LIYbVOg8pn/2RYVa2HkiKQVk/IdtV8fA+eQPfS+sjOvu+LGN1FcimGg07PEQDLvLHt8uxMB39GG3J5dDTAkA7apEW6XIcoiuZUnjbcXQicE/Iv2URl+m+LsF0F6SOSXI03C59xVxJOOe7oaMt9t7nrNl9xjCcNWo4anVWKNts7u9M/dnENmbFYnQxEQr/Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77v7ugQj46fJuBrpyeQk7MLawIuarzc2mQaEjzfn9pM=;
 b=qnpk/9ZqxoOVGv1mV96t+FmWV8pAGeTNZjHf4r4zFP6QP782k3KYrGc7vST0qbwAIVmbRaQm/uF480VYUfpwQEvVaVBw7QK2X+xwPQN8A+v7QJeiCdNcDD/he6qyCBhDNl0MTdEXYKJtgjrrpYBkeMK14XH8SL73NZ4Y/aIIa7A=
Received: from BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20) by
 MN0PR12MB6030.namprd12.prod.outlook.com (2603:10b6:208:3ce::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.29; Fri, 11 Jul 2025 22:40:49 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::bf) by BYAPR01CA0043.outlook.office365.com
 (2603:10b6:a03:94::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 22:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:40:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 16/33] drm/amdgpu/sdma6: re-emit unprocessed state on ring
 reset
Date: Fri, 11 Jul 2025 18:40:07 -0400
Message-ID: <20250711224024.410506-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711224024.410506-1-alexander.deucher@amd.com>
References: <20250711224024.410506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|MN0PR12MB6030:EE_
X-MS-Office365-Filtering-Correlation-Id: 393ba5c0-04db-4fb1-e2ec-08ddc0cbfb8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qHta5SttZbynjbaXr2x8IRQmTPCOGrFimXfMiTnAcARLzTJto9rmuSrYMabh?=
 =?us-ascii?Q?dQX2C6+ayMyLfE9111LAbnBxMtyRghnaXiaQJVY7aVnn7SGy0L24Gc6+p0ZR?=
 =?us-ascii?Q?btA/sSagKJG5KgFqJxm8iJMaRo88aGCe78lmxzftl4gkKdKDGobAxa/7tzyg?=
 =?us-ascii?Q?6Vbmv3kwKCop/NZQNooSil1KUUXmJmgfGdhbhmuXClCIyA94lFCxBgpNySKK?=
 =?us-ascii?Q?8hZFrPjCXd7Zpc4RYwmiDcQa8j21+PGKrZyqFo3+XKDwbzVSw8uCKpabjQU8?=
 =?us-ascii?Q?53Yj8fThbybqnOtZ7xMpBYaP8svg1BOD7hMGsLr+nOeWHdGbZviAPFMqa1Lr?=
 =?us-ascii?Q?O2HVjOu9tZQ7QJ4MjyQ/qxpvQxPsa+2YABeyIVJ5B4AjjCdUAs7Ji0/Hb8op?=
 =?us-ascii?Q?LsDZM8JGyOAw+DVDKNc/DX+T74ODj2ME0hmx4Fvx2TI74BR8rCSGZybVWaAy?=
 =?us-ascii?Q?CqtHDCKvBF7y/dGZLPo91qkDJ6qu8YWqYFBms/hoP+ir4sLbT8aBKhKPplch?=
 =?us-ascii?Q?TXa4XxFnINbL9HfUYWe0DsY2jaBeg8nrovdk7TwUsLfBKxk1xhhtYJrjww8B?=
 =?us-ascii?Q?k9IbaVZqtrsQTGrnUZee54XrlkGmRYhWO7ySh8+6agYNq5FQ4nkBjI8b0lhf?=
 =?us-ascii?Q?IXHqHgSQgyf3y7nAcDagdoNDibpZb77LAzgYuA+43rfAsRrRYP6OlbXFm4WN?=
 =?us-ascii?Q?t3rs5KjtXT8NW4S5fU8QBaF7H2+t/zu8gjzY6mFDhnPJGbcvYmc8da5J5o5e?=
 =?us-ascii?Q?ePIwgc3+/44eLf1zBHqax+0d1u+nxR8txcwD/w4RgeCU/yUSUTXBaEq/eppy?=
 =?us-ascii?Q?rC1V0cwA5hm3srDU6SGtleZKMpjw0mXx5+tDCYsKdB4DMEClxz+mv9s+ap/q?=
 =?us-ascii?Q?Sziq0b/7TAvPtg8epUVCyO9QDc+ZFK4wyAKtZLkRoFeaXyRMOgZHLo5yxnAZ?=
 =?us-ascii?Q?F3Pa1xOvMxGwgAgrGVb1KAVwie92AXBwfN0hGylNn/kYFrWz3jRiIfTnptMI?=
 =?us-ascii?Q?/I46RI6igjgDWwFSQnFiZe7s/ne8lDhQL2b5mM1vWgK+lSxnc2yWbndoHhmD?=
 =?us-ascii?Q?cXqWTfzp2H7VSGI6soRq3XLObUt6ojfwMuJlWDUChSIJZUExB6nFZTnHd2iv?=
 =?us-ascii?Q?G5Uf41iAFCJo/QF3zsX73C978HWGKFAnjA0lcMiVZL8mvghCpM06aihHOsuL?=
 =?us-ascii?Q?1m8ZLwIS39dS0Xj+ZW2Iw6zX+nWPJqjUnuKNCDnxfGO8cTpMGzRSWBLwLIBC?=
 =?us-ascii?Q?D3ZDEM5qiJ/UH8jJVZ5W43kx81m/5p+duTSd6ED3QN3YZe/xp6/eLDlxiLP6?=
 =?us-ascii?Q?6C3iD4mZPnEN58EN2hYt2/MSAPys2aohvtRhfWAMkqmNtWNJT1OV2KIzpSvq?=
 =?us-ascii?Q?J2c0bG+++GFHv0vfu9N5xjo+Iio2edYQuSX67tMx4GdaYBN38dguSFKy7fLh?=
 =?us-ascii?Q?h9ApM+vQHCKsIjU6gWMpOGqZTUHmHdkrGFbqNSDH1b5GMDBezmCdxEcVlVL9?=
 =?us-ascii?Q?0Fw0d30XhlAnjQtC2i+Z5aNyJHqjgVScmybq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:40:48.6727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 393ba5c0-04db-4fb1-e2ec-08ddc0cbfb8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6030
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

Re-emit the unprocessed state after resetting the queue.

Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index c08e9a6cf6827..5d31f318cb3c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1586,7 +1586,7 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 		return -EINVAL;
 	}
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
 	if (r)
@@ -1595,9 +1595,8 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 	r = sdma_v6_0_gfx_resume_instance(adev, ring->me, true);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static int sdma_v6_0_set_trap_irq_state(struct amdgpu_device *adev,
-- 
2.50.0

