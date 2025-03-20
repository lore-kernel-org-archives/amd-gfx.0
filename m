Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08888C35FFF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 14:23:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A88C710E625;
	Thu, 20 Mar 2025 14:23:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uRQV8+xB";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 704DB10E625
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 14:23:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJsKos3Ht/VngLq1z9yeoevAktCRWYwzYPBmcYZcAJSmhgCnA4d0utEavBTMN2F5rIpZwE1LItzf7UizjYRRqy7rUl+uKvKHcoPb9Z73qFp4QDX6giryvSfPZstCzYAZ/lmR54vom+9523iGIKwAvDNVPUuOZXaiTp8AKzFn3vCZatDh4mXfAUlKKAeKo2n1g0aC4FddUoGg+LymGJ96rIlOFz7qnZXWmbpd2l8wUQLuTXfbBs0ROKdB7+f45J0+JrWqXd9CaeTUvGDPpZjCP/59IfKhMTa1tpcARuMOdHhsqj4DkS4BAV6D/MeoVxAA7dEZ3/mQkRLfmC54DAm2MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2osVBAU3ZcpiApPcb++WEdQiTBZ4QcksEh2qJp+lw0w=;
 b=ZeJHRBGzj4UWa1ZGCjpSaIB8JJNnPExoc/Du/G1ZktxumXUW4BcdFQv98vDN2UYZjMO+ral7WvNk1Oe05SGFoPnuYBLMp7XvCpkHr7nRGZ5tUbx1hqdtMTQGCrghLvAqcNhZOWBkSWn1UQNOswVNXdXeo72b9pYqG+ctE08G9G2mknQBv9SsKG5j2CLNLGE5K3YTdcPIhD5xjTTh6QDL1XXH9n/ay2wq+CwRubhKT/QJ4hBGxDWKmXoNxS/uAAvBTpYmwMgSYp6X4hT5nQlu1RUlNpBlu4YZt/Xn6xzwgMbK6WKIOtVBLC4dO5la7FE6Eqbwq9OzSyniwST57FsshA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2osVBAU3ZcpiApPcb++WEdQiTBZ4QcksEh2qJp+lw0w=;
 b=uRQV8+xBHniPU7wk+jmsG9B0pjSZ5KMIxH19WileNWxrbhOCMxeS8Iz+Dszs6DVdk+8aBb5ZgvPrxEgOhEJAAa8ZejBheHvtu6Tg6gM8IkGAlTJvDgsTwEd1Q+1V3WBcu0+zRrR/PlxyR7OGNpHGp0fGxucJtGU6wrHQ1GWQigo=
Received: from MW4PR03CA0302.namprd03.prod.outlook.com (2603:10b6:303:dd::7)
 by SJ2PR12MB9242.namprd12.prod.outlook.com (2603:10b6:a03:56f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 14:23:25 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:303:dd:cafe::5f) by MW4PR03CA0302.outlook.office365.com
 (2603:10b6:303:dd::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.26 via Frontend Transport; Thu,
 20 Mar 2025 14:23:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 14:23:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 09:23:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/mes: warn on unexpected pipe numbers
Date: Thu, 20 Mar 2025 10:23:06 -0400
Message-ID: <20250320142306.1135063-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320142306.1135063-1-alexander.deucher@amd.com>
References: <20250320142306.1135063-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|SJ2PR12MB9242:EE_
X-MS-Office365-Filtering-Correlation-Id: d7898a67-2302-459d-3ccc-08dd67bac636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9Hzl8GNYUKG7gxG/lzsdEyCneg1XE9nMzy5mYkIxaafpzwsKreb+EDd2UVXx?=
 =?us-ascii?Q?L9Lxnp2lrZgaerb3aOGw3iuyzpDkFpXuZu7+XItj2Y68CZ2w8Pqlujt+LMeI?=
 =?us-ascii?Q?vksB5Cdsr3ln9HeFlKS/8kgRL6n2Dt0nN0mwWyIIO061E7nXpS8Fhn0mmJ2Y?=
 =?us-ascii?Q?OpclqT1utDXtNSm3h3t1HXPzTNdNCrDJ3yqE+7vBxr3vMSIZ9PDaHq+Ph+Pl?=
 =?us-ascii?Q?/LMR2h7kqNa3yuYWIc94sM9DQb9VsPI8TShBl3bB2yn6Db1ajjMDlLEwjGFt?=
 =?us-ascii?Q?HzE2Y/KiPqM6/sxaI4g/DwIpxVvoIVuu+PYISv2od9zP+ksimGaeeSeJs+KS?=
 =?us-ascii?Q?XL7a4EmXQ7i9cKZZySmTrNB0ByvnVBwJiHe1vf2t0gthlYHG3Sa+YaQbRctQ?=
 =?us-ascii?Q?Gobq4u1qB+OKw2Td9fQt+i5MV49at49FJT9ZyuU3FVk4QNaH80HaA7wqRfqD?=
 =?us-ascii?Q?XWwJDqWiZ5g+UfEaoRM3GY6L8aj7eRFF9uyFS9ncqFk0LIKJBuIV6kSHplEf?=
 =?us-ascii?Q?YS22xHdpcKCTDrfWN8HonIm8UdMrmp9pzdvGnCP/Ow72QKAJwR7SY01iUs8L?=
 =?us-ascii?Q?2LtLlvN6EZlSLW4RdhvCjx++R/lasaG+7vo20GKnpSFS24i6gR5TEQbAEOPc?=
 =?us-ascii?Q?uel3Ogl4Olh9QjVp1rEjfQ7cq7brZ3aH5f8BeDG67fhIWRKwBa/Rt4eNLZzV?=
 =?us-ascii?Q?sOzTAL42CsaGA2/4I6tUrXQbblkBNGN9YA7Wy9hZCldATvvAKiOgSnmnEqqo?=
 =?us-ascii?Q?iyOvkBmpWopRm21U8XezkfV08ySeUx+3s0DrxEh9sSrQ4xcu4lSJ/hQLHXA7?=
 =?us-ascii?Q?s0kZmBaqx8ck3EsLoQ5EMm9AZ0H010bWKYsagTga6Ja1iJy/4EyqQMzWIjnm?=
 =?us-ascii?Q?qm+o5J1bpra+6ligmRylIlec7GrrweWUH9+KkcjK6LXG4Lzm4d4Y8ewppAR1?=
 =?us-ascii?Q?Pr0VvAXJ3VwEgnW54jX1fH2b4Dr+viLKjNJRWrVQKFuzmNaHw/BitFqBV2bk?=
 =?us-ascii?Q?eejIXjcYiWuAASGBKLtuOyEeicG92vdtztMu6Hj5MWczCy/3vgUhe1onMO7P?=
 =?us-ascii?Q?/W8dVoRGr0Ii91kZvMPEaoMQYtZ4cW+ptK2KrUgxo9PZtwdW2MohFVA7ICwo?=
 =?us-ascii?Q?KxMRMu+BDWGnXZZRyUX9NoN/KVu6XUhVHj3xgLNbyvmws6ft1aDWTqYMNyGv?=
 =?us-ascii?Q?9l7IysKvOh+J7RO0/C5DJ2MoLMBloN0UA0KPVvj6T/swKlqAUaRd+FGHplw2?=
 =?us-ascii?Q?/jNi/n4TVvo7YPBt1uS8ZHrvYLAkNLklaNssu6kUfLYV5bbYK+3ywKZa+V8f?=
 =?us-ascii?Q?bq3XkqphAk5oN/x73FAy7fIIXcmkgzwkBKVDkiQEZJSY1hajvrc9Cq2XEQGl?=
 =?us-ascii?Q?wOlmzl/Au2400moSfZz1cCAlVE74P8o5b0Pa/zE6qiZS8aCyKywNZKKQAS32?=
 =?us-ascii?Q?rB1mBmMw0znNKQxTGOBWTEMZ3uGleCSQsigCT7O3pzfG16CLaB0ByQfdohh7?=
 =?us-ascii?Q?7E8VA01B83mTNAo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 14:23:24.2249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7898a67-2302-459d-3ccc-08dd67bac636
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9242
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

Warn if the number of pipes exceeds what the MES supports.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 016af4e9c35fa..c52071841226f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -90,7 +90,7 @@ static void amdgpu_mes_doorbell_free(struct amdgpu_device *adev)
 
 int amdgpu_mes_init(struct amdgpu_device *adev)
 {
-	int i, r;
+	int i, r, num_pipes;
 
 	adev->mes.adev = adev;
 
@@ -108,8 +108,13 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	adev->mes.vmid_mask_mmhub = 0xffffff00;
 	adev->mes.vmid_mask_gfxhub = 0xffffff00;
 
+	num_pipes = adev->gfx.me.num_pipe_per_me * adev->gfx.me.num_me;
+	if (num_pipes > AMDGPU_MES_MAX_GFX_PIPES)
+		dev_warn(adev->dev, "more gfx pipes than supported by MES! (%d vs %d)\n",
+			 num_pipes, AMDGPU_MES_MAX_GFX_PIPES);
+
 	for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++) {
-		if (i >= adev->gfx.me.num_pipe_per_me * adev->gfx.me.num_me)
+		if (i >= num_pipes)
 			break;
 		if (amdgpu_ip_version(adev, GC_HWIP, 0) >=
 		    IP_VERSION(12, 0, 0))
@@ -129,14 +134,24 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 			adev->mes.gfx_hqd_mask[i] = 0x2;
 	}
 
+	num_pipes = adev->gfx.mec.num_pipe_per_mec * adev->gfx.mec.num_mec;
+	if (num_pipes > AMDGPU_MES_MAX_COMPUTE_PIPES)
+		dev_warn(adev->dev, "more compute pipes than supported by MES! (%d vs %d)\n",
+			 num_pipes, AMDGPU_MES_MAX_COMPUTE_PIPES);
+
 	for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
-		if (i >= (adev->gfx.mec.num_pipe_per_mec * adev->gfx.mec.num_mec))
+		if (i >= num_pipes)
 			break;
 		adev->mes.compute_hqd_mask[i] = 0xc;
 	}
 
+	num_pipes = adev->sdma.num_instances;
+	if (num_pipes > AMDGPU_MES_MAX_SDMA_PIPES)
+		dev_warn(adev->dev, "more SDMA pipes than supported by MES! (%d vs %d)\n",
+			 num_pipes, AMDGPU_MES_MAX_SDMA_PIPES);
+
 	for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
-		if (i >= adev->sdma.num_instances)
+		if (i >= num_pipes)
 			break;
 		adev->mes.sdma_hqd_mask[i] = 0xfc;
 	}
-- 
2.49.0

