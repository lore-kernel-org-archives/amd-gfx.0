Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA69EB2700
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 21:48:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C5B910E08C;
	Tue, 10 Feb 2026 21:48:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sRKtdRdi";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012037.outbound.protection.outlook.com
 [40.93.195.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50C5310E08C
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 21:48:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ey7Bjt3u7Sy3xkwbi2GUhhNFEjFN8CCimk+JoY4rvG4J9TFUScTK3vvnJSC95KLSuKPcwsYKK+Rl8kaB4h3RjDaE/93tnKEklgsImrR2I2ZPYuS0E2QH3lfDQaN5QYJqjX5KFru+7zOSFcP1QbsHVSvsUrI27AvVURr3FHqB+3bT1rYpPC7nK5VBPaIk4qgt6yW0KwvrVfMvv/1Jiq/LC68BBXu3gFwaVGJUrx5I1mNpq+kalfyic4LVWuW39426jurqUTt7KNYnny9ZnQFhkzjLEJP9bQYvkKwLfvs5Qtf2pD7r1g2A98tHpwLvp7+Yg3fIDwP8sTvlWuFWmzCs/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFqMzqt4OBwDR9JmYdYHSNgwZQ28ztD6UKtd5VMP4U4=;
 b=PYtXrKndeZcPEd1mqV0Ca5fy8yIzp41itw3hKWwAz7Vxm7Rg/6H0LHnaaWHb8rDCVPvFsyxcNANqGC5NalQRGk1olfOgvb4UYxfVfR8DHj3wwKIO/sCMXZQJieVuvLrLuOIFwBeJ6r0wNuqI5YTgqSVwW1OB/27eJiytzvejfD0EdfvV33k0SeQ1jH17GKkMbyBDn8hBMZ15WBz141Td6o/Q/QJ2qUGj5BEyC3xUgs9w54K9CfNM2jOJyC7WQMIP4SFTghgeNXTUcQEOL3FCReKOhxQ0+7ZQNl7+4OMk8hSRgaQPigSeiYpIl3CWf80DDuLc4rXmmnB8bHUn6Q2N2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFqMzqt4OBwDR9JmYdYHSNgwZQ28ztD6UKtd5VMP4U4=;
 b=sRKtdRdioeLtNrNWi/G7AObxJU7pXk5vuSHweVrnURNTNP7cVsXaL9Haadv1J/fIc5RwYzWBcPL5+Iv53bFvoz2nvy8AZ5Bia1YqvBDIDrHKfqCK08ulVfG9JXftRtufhQOZ/WBbRxa3D0YVpRhNv/4qGXeEOh9D76froMvQIRs=
Received: from SJ2PR07CA0015.namprd07.prod.outlook.com (2603:10b6:a03:505::28)
 by MN0PR12MB6317.namprd12.prod.outlook.com (2603:10b6:208:3c2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 21:47:59 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::3d) by SJ2PR07CA0015.outlook.office365.com
 (2603:10b6:a03:505::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 21:47:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 21:47:59 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 10 Feb 2026 15:47:57 -0600
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>,
 <alexander.deucher@amd.com>
CC: <leo.liu@amd.com>, <Boyuan.Zhang@amd.com>, <David.Wu3@amd.com>
Subject: [PATCH 01/14] amdgpu: add global aggregated doorbell bo
Date: Tue, 10 Feb 2026 16:47:16 -0500
Message-ID: <20260210214729.80964-2-David.Wu3@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210214729.80964-1-David.Wu3@amd.com>
References: <20260210214729.80964-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|MN0PR12MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: 77863aa9-1dd4-484d-0e1b-08de68ee0f08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wf+YyRFxkyZIEHHO1dOum6jvFBBIPoo6P3rNvurOpgxo/BcUbRpn7cl8KEuK?=
 =?us-ascii?Q?TiUeHxKLRVY6y2VCT8WsEqec53KyEthja/Sg56TV6kjE3KBeTxnuHiMHKOlu?=
 =?us-ascii?Q?hk+NbTUPSlFL9eckcaTrbgT5cLLzHNPKJdg0LOnn0DaiIvvZl74SUVmvmicj?=
 =?us-ascii?Q?baTnqvl46fto1L6PJUK8ywa9bkhq3InfKC/gJNQ6WnGN1S+r+vqzkz2yL60q?=
 =?us-ascii?Q?1iwflV75NWYpNzGyTc/ONR9yHBoqlU95jkOUY9NFy+6th6JlXSUDRFRIiskG?=
 =?us-ascii?Q?zpJSWN+jVcnWXqrv/e726dutzw5Q0WO9ba2LndJI8AdMwN2kyNu7Qav15DFt?=
 =?us-ascii?Q?1dtFi58zshTSn0+kjuPiunpcDhrf2VaHxE7mkrU1zST57IGiv9mWrBgCyeSB?=
 =?us-ascii?Q?dgAzj8+M29gVX+e8TEHuqy13XoqrTgGnfbCQqJ6+HhOIjaJX2ntrq/BwEMH3?=
 =?us-ascii?Q?K+0/5y+e4lPucMkCZtURAfnECA+OMredygQXbmCPoa04sWZjsPQIjc/Ijgpp?=
 =?us-ascii?Q?9nwzLNTXQXAGqRYeyMWAUa6OLp1ZjHvt/5IfaY2O1qtgoxLrkC+7oWDYAZn2?=
 =?us-ascii?Q?imvxxNcQg2PPcnon8KMtiOVh5d7AMzHCCg0p6yY3mcYCsG5O97gKA/Y1bD9W?=
 =?us-ascii?Q?AyV9/dwjsqWOKPP0aWflMUx1yTqq30bjjH0svsJI1+8fDbioxtqUn3IUUthr?=
 =?us-ascii?Q?NMi4lGFbj3apQ4jWi49B05LvAZ8EbVZKTSakIIbfWM2RItz+F2HU9ZqUhvSb?=
 =?us-ascii?Q?5aNtQGnqFVPiE8iFQ0Ujh0jXJ+Ln4deeHy/YcBLQcOFc0FnGrViKaaKYQrML?=
 =?us-ascii?Q?7mL0uKfCA5H1irbhKShWMLs7c7XLEbnX+UO0RIYEAnNYokOCyltKUlxkSpOL?=
 =?us-ascii?Q?JdtfI3BNYa3PPRKnyg8GYvZrhk5eN3Qhbe8hr7dq/bcdTMWs6tbfWQt/gUlP?=
 =?us-ascii?Q?DcP3UyvhTABVX6Gio0VRbvTNFHwBvXGvBihMlGJYPFJTIC01WairqwmjVrU9?=
 =?us-ascii?Q?8Ys/BuIARynRNt83JW7pHASOD4q0T2QmhetBxrRkIt5tnosWkuNDv7gfzjjG?=
 =?us-ascii?Q?G+6Sm3AlktSGOjffh2/M+qn3Qq+GP9s5vS/iUCQDEheszk3rRoAWdx092/hJ?=
 =?us-ascii?Q?2iML19NjmUm9xOHtQ5YamDAfA3thv2qXk6oag3fbe2+1lIfkjjvw9Bl/A1dt?=
 =?us-ascii?Q?OuJy/M7IV61HoMrmbQEbR1+AasoIFg9NtQ/NJmvwtKNYTYswunVSomli4JkB?=
 =?us-ascii?Q?hUz0+xXBfeXQvKctXoAVL91ytKIkMCum1dVLaUUm2gUDJq8QIlYED5VQo8qa?=
 =?us-ascii?Q?nl+YwljKkN43oFZ64z4ptuKPtncwpm47HjIQRk85HydKi5Yqo8kw/0Gg57Al?=
 =?us-ascii?Q?I4NLDOxaUS4neM3gGPrw/u6qHUfRJXoDDudb6wx8CivsgjlkMl0OhFB1rfJE?=
 =?us-ascii?Q?ZHEsYwFtubcewb0mEXxOJwlRR3zINsFfZWubnRkMJiVf5UNsC/zOUWD9m76q?=
 =?us-ascii?Q?TH/23ESeBdQCAGVLiIC09BKS+uIqJ5KWfXzvCrRE5NwZYy4u+ySMQNYVbtRw?=
 =?us-ascii?Q?AvKinPv0OWXBaP49DnBDjGOJVcSM131PpPrjR4WeL0zpIzd785ZKOxrEDw1v?=
 =?us-ascii?Q?5Kx1tDXRtrMxtX8sgWXA9uSmcKqw4CBaxKmoRlYnOoS2bjfVHvJk3MYoCkrw?=
 =?us-ascii?Q?k8Izlw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2vWRKfJ1lhY/baeiJU8tKuW/naXimC4afiJfTzCp54xb8JAAmWfVmsb9Y5nK7rz/JraoHlkuqQAzj5xfPOarr8fRvtTS+2mJtALseXDVLPo/UfGYp23xnJ1E7OKZ2BiT884ZYJ38+yWFbmz1AEbdfIk7Tvf/az5ydrjy2P5uMxN3qkHVPtUVGNEXwptbW7Jb84EBmhcZwOSdx3yNxgGNITs1pDc2PpxiZmwjo73RCF840zdlyubS1EspgTAWjg6zCwiVnisznm291WY17DoNhMRDdB8k8uVL6NyoRMfk5I/8uh7Ip2MkB1Zx0s2DuWY6FZwfpxllFG3IRrgdr1rm0jQdQ3W9TCRzaOEpbBayZcAy2nBSNFCmSXEHAnBlVXbtw69e7TjShAe9aqOBxuHVmqCJ+/N3l+VjDdqgBeWsfnhY/jn05J8NTumGgneuOGXB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 21:47:59.5526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77863aa9-1dd4-484d-0e1b-08de68ee0f08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6317
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

Allocate aggregated doorbell bo at device level so it can be
used for multiple IPs

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h              |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 0f6e9cdbe7d8..aeefc13fd36b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1245,6 +1245,9 @@ struct amdgpu_device {
 	 * Must be last --ends in a flexible-array member.
 	 */
 	struct amdgpu_kfd_dev		kfd;
+
+	/* aggregated doorbell */
+	struct amdgpu_bo		*agdb_bo;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
index bc7858567321..2b0d123bc984 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
@@ -148,6 +148,7 @@ uint32_t amdgpu_doorbell_index_on_bar(struct amdgpu_device *adev,
  */
 int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device *adev)
 {
+	struct amdgpu_bo_param bp;
 	int r;
 	int size;
 
@@ -176,6 +177,19 @@ int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device *adev)
 	}
 
 	adev->doorbell.num_kernel_doorbells = size / sizeof(u32);
+
+	/* allocate aggregated doorbell bo at device level */
+	if (!adev->agdb_bo) {
+		memset(&bp, 0, sizeof(bp));
+		bp.type        = ttm_bo_type_device;
+		bp.size        = AMDGPU_GPU_PAGE_SIZE;
+		bp.byte_align  = AMDGPU_GPU_PAGE_SIZE;
+		bp.domain      = AMDGPU_GEM_DOMAIN_DOORBELL;
+		bp.bo_ptr_size = sizeof(struct amdgpu_bo);
+
+		return amdgpu_bo_create(adev, &bp, &adev->agdb_bo);
+	}
+
 	return 0;
 }
 
@@ -241,4 +255,6 @@ void amdgpu_doorbell_fini(struct amdgpu_device *adev)
 	amdgpu_bo_free_kernel(&adev->doorbell.kernel_doorbells,
 			      NULL,
 			      (void **)&adev->doorbell.cpu_addr);
+	if (adev->agdb_bo)
+		amdgpu_bo_unref(&adev->agdb_bo);
 }
-- 
2.43.0

