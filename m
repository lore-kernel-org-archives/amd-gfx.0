Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3272AF34C63
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 16:16:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C84AB10E4DC;
	Mon, 13 Apr 2026 16:16:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BqgfPMk8";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013035.outbound.protection.outlook.com
 [40.93.196.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87CD610E4DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 16:16:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJGJOPwtsIpq+9XvWkmTKe3Vc0kADmvpnhSSjTxeVJrRU4tGSB5C2cnc6YwG0l6q4uF22MnAt/8uHveUr7ZV80pvCHhRdxtYPbbOh6UVWK2qcGzkChdtKvGgWkphNZ0M/p7lsQD+i2q9ZRTFaVZCyuGrQllmR/LarD8RFMceCCoYkCVZCtPcV5NmiozUMw8mMvvN4I3N2y5Ye0QarjcuYzWJ0EdAo3ZWUEvr69L6v0aeGOuy71xpWWzdzMwZQ3ZG3mDtZZJdw78k37fhtIuk8Yfql4dij/VD+N8k2oGw5GE1evfPitp2P3i1LQaPkX4gGH4Wit4tNFoc9otV7UNPPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3CMJeTIqzqcjwYDPDDFG5ivrjU9o9QIH/ftpwJQGoo=;
 b=gyso9UAE4cexhUFjz9jFQKwnJecmMNYEo6YI/cXJRdRmezt05JMlgrEkQsdwvWd5cRSewu7PigNWDt0VmCITz7PSbvf3MFrbALF/zAiePcuuB1rAju//l9cUULx1dtKz/OMc1IaXgKWnvWfCAFJcimwzermJR9MaHVLLp0F/sZwGGnUx4XyMep9XPFM1ydz/kOJL7UkmVZECryuu6FPWZfA6cxr5J8UFuG6HGA8H3fmxniq7neF/ERDVWOHX+GsFkpZ1LT8z2fowFlcX/fwkn4rFB73Zsiiyel/14jT72T6WGRIhuDWYIv2PcctSd1LzgLLYIwGTxWjljiYQ7fqAbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3CMJeTIqzqcjwYDPDDFG5ivrjU9o9QIH/ftpwJQGoo=;
 b=BqgfPMk8wvSO/uq9jEY3ogm5aUhSmK4PfEp54/SLdVrTJaB/fwBNyM9Yut+bc7epFbMtZ+fx2yBzCx2XVj17TffeavnXNkcIqvztQq6Q6m/rxY+3gbW60V8INTNMi0m6qUv4Q1iN49LssskYs2LI7aoHJjOUmeqXPOS+G+KXis4=
Received: from BLAPR03CA0031.namprd03.prod.outlook.com (2603:10b6:208:32d::6)
 by DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 16:16:25 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::70) by BLAPR03CA0031.outlook.office365.com
 (2603:10b6:208:32d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.46 via Frontend Transport; Mon,
 13 Apr 2026 16:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 16:16:25 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 11:16:22 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 09:16:22 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 13 Apr 2026 11:16:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/sdma7.1: add support for disable_kq
Date: Mon, 13 Apr 2026 12:16:11 -0400
Message-ID: <20260413161612.455669-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413161612.455669-1-alexander.deucher@amd.com>
References: <20260413161612.455669-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: b8aaae1e-3fed-4fa4-152e-08de997802ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: PjY1UUbzliiqaFppAjaqixPeYOyAAjmQYTpqpUZIXHQdmXYBFbSFOrK5vIoCcWVTUgWKSQLJzYgklBBhjRMnuEy5zQGJ9JkD1UOYIUMIt7G4ch/RQSECMAWg/i6RaNkc2X7ZudszN4Mw6V67rpX2fYjFVe2emIkDtVbkXCBRKbgeg/oK34VNmqvleJM1T5RRPaWzCj2b3r8XorXwvrJRtXB6ON4/EPZublYYQHa8pHo1L/umXNYoWEwGE0k16VYKiZVokYcRQratbxOnjO40Kg+VmY+6MV/8x2GHymm4+A+D1FKmjb0PuvdAzn8X4twQ4BYIl8gbFy4g0Of4Zi7aOqRVps+iMKU0y7PgUzk8x14bMNCOUqrExfo9lbfbur9KjnZRjw1CeyQFoYNszJbvPumXrw3qJL8X17uWQS5AMUOucFLoIDYsuGFzjSYCocG3PrHEqeZGj8IKqVpfY4ltEWCVfbWSyIiYwdmDsVmZoJF4ASliXY6YDtN+XaBCcoy5Qf8om5mz1TQlTsPs4plHdQBt8U2BF+a8BOI145qTCklDNDB94U+7flaeH2Z+7mmSQgdiQ7LaU/XYeqsva/gH2SLTNZ8Jt2iyoOsRsPo3iWZ46DuD0dSaWWDkFeSO5bxS6Re/lD1Uwp2O+MCtMCUQum0NYv95W3Kh49K5pijnPJ5w4LEJLH4bVyniJfBmKNXW/CD5LvA/sWi88ejWHCl4gmEHoG5/XOv50I2WMcOF1U0a9+66+FGPJCt4RNJ1udkLE9G5k3TjEshMdvLmoV5yqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pvzflOG9UE8WKEQG9NTp5v3fzCrcxzA/DPOMyMbJ4F5uMcMQ/KRZ5U+Bi8DXjXxv1DVPjOkkKRTlQI5wWY+bpZDBVmAvKwVXnc3EFhjSmEJGUYzxkxvIbJZ1iOvCKbgYCiu2xITZuoiPIEqIm64huBSPjSUtDwe/vuf39Xxi5FnF2fted/B+Iv6zdVB/2xH7R8DYfBwV5IQGrkesptUZJ2zs2Q5cTTyJuSX/HvKqAHmjz4mODRJ9mrTv4NTyDvc3cmrmzf50wabCmSLR7JzmP3CnYIzJg1GhZ7XQMjmcmd3HJenMVKqGQQwkJsLb3i7MggerpI+ebfV2LWYZYNKvTBoe4ZyF63kQupR63aGyzaH/vkoQIO/6JjJOy2nkj5W/Gt8Hv0LqpUmyPtkTCMqq4gYIDg0lTUWYj9OGYSCbCxpGtWN6p7/Xe6Ajgg7Mop4a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 16:16:25.2832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8aaae1e-3fed-4fa4-152e-08de997802ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909
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

Plumb in support for disabling kernel queues and make it
the default.  For testing, kernel queues can be re-enabled
by setting amdgpu.user_queue=0.  Kernel queues are still
created for use by the kernel driver for memory management,
etc., just not user submissions.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index f20e0fc3fc743..061934a2e93a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -1268,6 +1268,18 @@ static int sdma_v7_1_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
+	switch (amdgpu_user_queue) {
+	case -1:
+	default:
+		adev->sdma.no_user_submission = true;
+		adev->sdma.disable_uq = true;
+		break;
+	case 0:
+		adev->sdma.no_user_submission = false;
+		adev->sdma.disable_uq = true;
+		break;
+	}
+
 	r = amdgpu_sdma_init_microcode(adev, 0, true);
 	if (r) {
 		DRM_ERROR("Failed to init sdma firmware!\n");
-- 
2.53.0

