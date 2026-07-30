Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84E4C55162
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 17:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E92C10E1A3;
	Thu, 30 Jul 2026 17:03:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EwKw30MJ";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011039.outbound.protection.outlook.com [52.101.57.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3251C10E1A3
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 17:03:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSX3n+dPHwos+Fz5bV2eQIzHuMZ/EDnGjjHAqZlHjVkwVkvLT7WsmsbsMYNtGfVVukd+b4nk6Uir+Nw59QRuMW0oDxJYUqvCKAcuxg8fIEgDBppcbYnnqpsLh3Ty0K6iDXYy2tqdw/jkGBJDooeH3x/yBdveePwIKCx30FWjIKLL63wqmGHLhOYIavcpBzOkqBCJ0ExzLOOEX5eqHSiyT+qvFuwuxhF5Wav3ad2IyUa1zNYFZqKzIoJBfjA6wF3IaX3bNw4vI3k631b9U8l+hzyR/ar/y7y0Q2njg1mNL1Wbf5TU/Vcf18no1Wa1sJlDvQnzTBRnF9KbhHb+q0Xlqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cp4veNivOTMMBwbIe/RL4saqFudD1ml4OG6Zbi+hBOo=;
 b=dclp14hA5NeaMaQ1oFmMtY+ELcogLlCdMy371pDsO1gRBj1uUvBBVVPObj8I24hd5N+zyZAsED8rcf7mKh52BqnV0mS6q80dm94PuQA6dvnWFLB2dqBZP9RQfDC8wVuLsUsRlBn4Rit+Abp/Y50694gAznVag67bS7TSvUFqk0xDKii06ERS3zI7w61o7PjjP1k/JX2/MAB5S1/BSdJwR/pYKQlgSWMQVqtf66Yyi2LFYYZ5i9rNfSnZK7B8pu2xigj7Q06b1whPd42Wg8HnTBZBFpObvyJ+hWtqUjlUd9D0TD+uYsnnTUtowh/vRhAECZXlvV14aVHXJIRoAAyCXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cp4veNivOTMMBwbIe/RL4saqFudD1ml4OG6Zbi+hBOo=;
 b=EwKw30MJBCRU3a8rSAx3dsrpuEJJzLMjgdr+UCKGZlvRsXZY5iVn+vZIEDyN4djgFPCIu5qSizr49PmhXeBIrD1Bw7htTo2hQn2mlg9OxT8mcMjm1wEB6Sd06401fyXR8arm3OcrH3+P21d9P/9fa9Aqb2yLOxDJT9ENMo4gRbY=
Received: from MW4PR04CA0287.namprd04.prod.outlook.com (2603:10b6:303:89::22)
 by MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 17:03:02 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:303:89:cafe::b) by MW4PR04CA0287.outlook.office365.com
 (2603:10b6:303:89::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Thu,
 30 Jul 2026 17:03:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 17:03:02 +0000
Received: from work.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 12:03:01 -0500
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: Fix UVD decode image min size calculation
Date: Thu, 30 Jul 2026 19:02:30 +0200
Message-ID: <20260730170230.11930-4-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730170230.11930-2-david.rosca@amd.com>
References: <20260730170230.11930-2-david.rosca@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|MW6PR12MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: c0149781-bbc0-4138-dbda-08deee5c6a51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: tyYusWQpOeuK0mni3bXPa5BtQC+cYZ6QASWlzyGO+zVXTXail7ceyI+f+OBRi3gMgym7s/3pgzhFlEmaLZGaodIfRQHPSZsQbN586PU0UKGNfnRaHPMq7wuyLbOw6a02g04tJRKcFZQfRwoVVcDVcnBaq762TwhPqElhd4S5GlxBe9A8TODsWLPCEy4YL9Le0F7BEdRynPuQlEbeHu2HJyHDgnfAtyF3mmFd3Qqyooq0LMbWepZpy75ZTQ18IG5rGxJETI5BowHslZFN51Z9CSjinMuu5lTh66lCZBDIHMu++6QR6q3kXhpsvCeGTEbOWNaENzIY5JMQ2E22kJAEkS8RDw2YYQJgXag6y7TFAjT0PEFe5LDPTdXF+4HZudkseo2Km4kFbApKbotLFpUs08KBt2FpRDy/ZWIPwgvqJ//gCN5LZ1VJ8sx4b+shLVqOtiVnJWNbRVHL2r0346y2IWYk7tIzxkmY14q2Xxy6UcXEMSw8ZdyztLxfsUaGO83OTKxyFZbvUlyz6AUwTejnuq6p+uwN48scksuWGQeFP/yX+SgEVAFYMtrACJKYED1eu/OMmNkGYycIGX4yRLNrivAbpDkYkUpNkKkEV5zAUR/DD+/YJGW6ke3zq+CJ4bR9OjOXUcOSVSzr6L3aRdDa7pKa5lg1CRw4mVfdSwVnIJ8IXTu4zPpVVOfh3gzbMPd2+ebPNoGd86TA/CNzEFURFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dUSXnD/Udv7xzviKpnCvHQRZmpgsjZzYTRFzJj3Ly/ZorvSydYNhpbH6F2KZZqd9gapa3gRH+mMXNnDqykgNI/Ff2/n7J4y3auvmZ8iu6G/rBe8t0MqoXedm0de8HVtE98cWxCjnzFE4Ij6fudSSeiytp9cwcCZ33FPD1QVRoL/jTWrq926SojSyi0MjAk7rxFX8eguHFRRJ2xXo7h4Xy78hZs2ok6ZxyQt7hTE8IlEdmQk3qntTdhGhVLvyJJVITLG1kTVofWjeFKx2pRelNfhbvL7m7U0UtmM3Cs0l4nvWHHPWG7IQWCDetW0nlyEEXtjV4+GiARKt8WzzEcyTaJX8KLyekWqy9IENQlw9nHO8OtODHT2RFAXP5FTg9i7Un7Ql4UEJjWs4TB0hHgnegLjm2TSsfCJEuvCy3Ea5rJ6F/TR3MDixutOXKHygQe2p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 17:03:02.0237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0149781-bbc0-4138-dbda-08deee5c6a51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8897
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

This needs to use pitch instead of width. Also reject pitch
over 4096 to avoid overflow.

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index fa899e321f48..947a6cd45881 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -759,7 +759,7 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
 		return -EINVAL;
 	}
 
-	if (width > pitch) {
+	if (width > pitch || pitch > 4096) {
 		DRM_ERROR("Invalid UVD decoding target pitch!\n");
 		return -EINVAL;
 	}
@@ -771,7 +771,7 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
 	}
 
 	buf_sizes[0x1] = dpb_size;
-	buf_sizes[0x2] = image_size;
+	buf_sizes[0x2] = (pitch * height) * 3 / 2;
 	buf_sizes[0x4] = min_ctx_size;
 	/* store image width to adjust nb memory pstate */
 	adev->uvd.decode_image_width = width;
-- 
2.43.0

