Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9DDCAC59A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 08:18:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE88910E668;
	Thu, 18 Sep 2025 08:18:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JX8CkC+Y";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72AA610E66A
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 08:18:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGCVwcw22u/+j9wiuSDLY5Yt2JVCWGFeGPHZ9zQrIq3XvlBqeM3bJjAfNh6phIsaW5EeZiUcxmUGn758aAwqgCR4jgBeLkhvNKbs+ZQmZSz5dL+z5DFt+9xY9wYIg3x2z4vwPjJ+rYvc2rhG315F/L4TzCqFvZm+XB7eKyLTK/+jZpkqnY9DYri04KFzRD2k33x4UFKEIBkL9jFpQBNHmIj1HzQBqDclyObXylmj1DGU7hK98eqKl18a0BMI7Tff7Qgs9mfCPSEMwpr5Tfi5AfJg1YRtbod1WrnSdxYpn8ICVVCMyyx/cDx+PzyvAZeM1g/3UYCieQyAIfWe/xB9EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqVx4hduXjTUUS/4zciMxIL+oHDnbmPiAg64oapsCwY=;
 b=oCHSNN05VhxKiOWJNyT5wWAZvoC/Lzb7b9rCuMBugUj8k3KL3zqxGwJpqM0pYtMz/jFIrQfXTxNSDRU2zEytp5eWXWo56XP9qnZzxi9gstWaLEWM34q4JVoN6bC1Bdh0MCQUJLinExm14DPh972xgh17YXlS+UJSmfvXchej44IA0H1vp3nBTxEBqtDZTaIzD41RO3TD/hOifaM00zemp2rUfijUaeTIxs6Lvr2SQOhmItfkNiXa67yG2tLdxuqnCnJqfkZaAE6zN/ck+15xyu0BF1aXoQ7+6Q/y92G6dItL+Dn6n3hPLco7kcNMXBDAi6rZL9mqQvDQCF+m0XWsBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqVx4hduXjTUUS/4zciMxIL+oHDnbmPiAg64oapsCwY=;
 b=JX8CkC+Y9FJvzmhk02Zt8Bb8SGklz8TxPmibzD7gaKBDvuEV/uczOunmxHU5BSqsELFtGtOzWKNbIxhhadhJeJQ83J/Vy9Ri/02q5o+u3KjcoZqwO0K7MpI3BhxA3RDUX8KdJ8c0iyVHBBEQdsCkSlwn1/iu7R8cpQGpUwZSNd4=
Received: from MW4PR03CA0253.namprd03.prod.outlook.com (2603:10b6:303:b4::18)
 by SJ5PPFC41ACEE7B.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 08:18:47 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::11) by MW4PR03CA0253.outlook.office365.com
 (2603:10b6:303:b4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Thu,
 18 Sep 2025 08:18:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 08:18:46 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 01:18:32 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v3 05/10] drm/amdgpu: add userq invalid VA query
Date: Thu, 18 Sep 2025 16:18:10 +0800
Message-ID: <20250918081815.2755437-5-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918081815.2755437-1-Prike.Liang@amd.com>
References: <20250918081815.2755437-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|SJ5PPFC41ACEE7B:EE_
X-MS-Office365-Filtering-Correlation-Id: d0518e28-397f-478d-0764-08ddf68bfd85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HCOq3QumoTlcRZUlqhTohQLSgVMXNLI7fdwVjaGRjQUbi5W4SYPrXBjKOhqj?=
 =?us-ascii?Q?Ekp3DnHLHqnb3HdG8LL4dl9BzxSLSOJ0M6hgM0OfoFgRVv3k6izOg5didVru?=
 =?us-ascii?Q?cMABArGDuVGxyImVUYnjrx8rGYJPHAzP+EpSSDjnle40qR3nzXPvwtFJTg2I?=
 =?us-ascii?Q?qF3V80oZseGxLdj/AZO8wAJ3ScR1Nz6Hmgt+kCO0Mlm2y7vefYWQma68v7uQ?=
 =?us-ascii?Q?8WP+x/SGvK0DX067Y45iWCNjfikK4zh+KetZwWGSbinBjvAvPEKKbFniLhDA?=
 =?us-ascii?Q?nB9I7MFEki6k5i5ltT3ezveuAUygHGbA1JYyTsKp/NmRY++EfL85qj2HCwRT?=
 =?us-ascii?Q?tCDKpU7APttirjWKYKBYOJCAIv4+c7mJSYyqo1grN3eblJdbTM8D1RSxY3Wm?=
 =?us-ascii?Q?foA4WBU7QLDGC9pCxcfaTT/PWeW2wmYRocmcHldolap07pp8EJR76iCzafF1?=
 =?us-ascii?Q?FRjbE4hIlVd7GTjEVTZh0GrDCJrnU3nUpB1dB0RP1xJUOJazX0Pj8v6lWXqp?=
 =?us-ascii?Q?gL9SL9/9JLfu3xMVUDAUpVeZVibJFb7VD6+onb49TyzIZ7S5KIf7TD2KNGgZ?=
 =?us-ascii?Q?pS4BVdxHA/HfuE6icpXvl1SXJRUZVqUq8hV0bflXFHfxGLUl9d7d8t8iPjyg?=
 =?us-ascii?Q?ERUgNERW/nyhpewZLHm8xwL+vwPD9mBMMDydVA2yOGITSwWi5rSN14gr41L4?=
 =?us-ascii?Q?qX1EEwLh3dxdKvOa8C2JfSFPyokbwEI+t+8OgE0pR5YJzzdbH2+TuMiZcJ8+?=
 =?us-ascii?Q?+4RoDsvQWb9BY6OVlrTSh4lXjOwTEfl5MT9HWMuHaR9E0AmPYGg9higqTdEp?=
 =?us-ascii?Q?SjDGBdNWIhW1nvf/J/Ou0wLoYKCociQJ3798K2bR2GOvdT5vOpGiCcWYwmph?=
 =?us-ascii?Q?/pG2vtIb0oa2qXqg0oNaqHB64wxKDmmJiOzNHEzDx776v7tmExFKYTuri3/h?=
 =?us-ascii?Q?CgRofcN/PvZVvqpBuVSqZKUPmD6bQuXVgtXHmpFs+0zVFZGjWt08Ze1O8HcG?=
 =?us-ascii?Q?2hUjsDIvojreyNsrNmQnPhei5R3wuE666D8DKjeQZFOEZdpfWqKZU6ru7V+E?=
 =?us-ascii?Q?F0Wgq4Xaq+9nY/3vitxTDM3JAXcmeDT4uHgO1DFMyVVd/3qEK5zPXGTy91+M?=
 =?us-ascii?Q?vE43hPhLKJgpwcM5Bs1NtTVc07Kcno5pdsjsdY/7jrcETUTmNEZ/9Tj+H6j6?=
 =?us-ascii?Q?vZFcGT2Pks4NDNx2zAN10ZA6ILP/HQyUvqv6FUAievjzFjQVT520YE8FqKun?=
 =?us-ascii?Q?gtvWZ5duuLIi0CQpxpeLtMaaWJlgjb6ve5ltXYv4sZIrzsFDgX/Lit5BNLGD?=
 =?us-ascii?Q?lUcwoUcuofOQwoeFEtZLRdpcGvBZCZ+OcfbFUXmKXi7bi3Dhu0Qw60kMi3Fo?=
 =?us-ascii?Q?FsWF2W6Ok/rD8N+pC3TTb9qvxHI9bNowIkAD9dpuMitaCSJxrY1gGXej0VkN?=
 =?us-ascii?Q?ehZd9/DjHL+//sqsG0ei/zsSwwdk1GoRByMMXHhLQB1uPVgSTmo6jTXvnUHI?=
 =?us-ascii?Q?jST6LZ9xri9+czFPxtPKvgUxAl7T9HSZiaPF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 08:18:46.9385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0518e28-397f-478d-0764-08ddf68bfd85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC41ACEE7B
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

Add the userq invalid VA query interface.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 83f0ecdaa0b7..3b57352e523a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -577,6 +577,8 @@ amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
 	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
 
+	if (queue->state == AMDGPU_USERQ_STATE_INVALID_VA)
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA;
 	mutex_unlock(&uq_mgr->userq_mutex);
 
 	return 0;
-- 
2.34.1

