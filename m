Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781AFC54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 20:43:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1156010E5B5;
	Mon, 18 Mar 2024 20:43:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WPX79eFS";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7822111209D
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 20:43:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLCtRtjaScsJU6H4iq65SDVI0NNo/gxv/SDYRl6a3Iz83Iz+uZqE/xECO1ugDI2uh9F3SmgY6vD4e1stn+1J+zTBz/sCkHUy8nrVUuoYgYcWEptWTHSY/MjXMWPc791WWC6ZnYl7NN5KHTTtrpZ3YAKyyzAx/bjYKJeqxc5FQREzfFg9K4KBoTM47XzHno5TOliIVeD202U8Ag2FlK9nYScDQL6gvVXNQcKoNyhygzg+LV9oW/IMPOngKxdUS0fQw1hPzMGCwovK2A7X+aF6IilCcZPhl1qH7cbNGeSVw+ASohLe2Y7da5ZgFeODhngnTZYtz1fn9Mbd33/3RL0OOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPjeb3UcD/0wSrLIiYtMZFFqP4VnKMQbCX1oZ+NsGIU=;
 b=OqzLzIIjcQu3SlSLLYbn0XAmpkRvKwWmsc6B0vTlsxOl2BGIVk9covMGht0qab7fRMjqbMQMUzcr24I18S1Q8BdGW5HK46KwFS/A3PYldrtX1L5p0BOBwnXndimAJW3ue9FL5l2K+HKd3NWao++EJcy8GpuyTYUaPelikUU/HFgyxSNEGFVJ+G7ECWTQYyVgf73m/LLVMi9L8DYD+tnnrN3xJ1/fKt3zHbH6BhJ8adHkbKvZd44BuybQgql5qEAO26Mhal6fbcNksUqTd7fcL9xL2wdWw3clNBl8zC0/13cSVdljnvDC4zqeKpuvWnDCOQK2HgjBYBW9tm5N3PAhzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPjeb3UcD/0wSrLIiYtMZFFqP4VnKMQbCX1oZ+NsGIU=;
 b=WPX79eFSGBihxxva22B0jX6KT6W8WWlX1+/aYVUN5ZEXKzoHu/nbRBEfUCJBjZGTZoqefUYl6D4qULI+PbOnRzRQRFUhAQMmLS1IudB5hkyPu2XtHEFA3XgYNtr36aubcfZgXnjSAeizjMw87mORZkS/mnsCNKsSYTZ+0c2SAeQ=
Received: from BN9PR03CA0229.namprd03.prod.outlook.com (2603:10b6:408:f8::24)
 by CY8PR12MB7610.namprd12.prod.outlook.com (2603:10b6:930:9a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 20:43:15 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:f8:cafe::ba) by BN9PR03CA0229.outlook.office365.com
 (2603:10b6:408:f8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 20:43:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 20:43:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Mar
 2024 15:43:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Enable smuio v14_0_2 callbacks
Date: Mon, 18 Mar 2024 16:42:52 -0400
Message-ID: <20240318204252.144624-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318204252.144624-1-alexander.deucher@amd.com>
References: <20240318204252.144624-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|CY8PR12MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e247f8a-e54b-48fc-9410-08dc478c0941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0zi9Wutk+ySDCeCPUUljZdahOvcXvGbWB0ULmj23Ei8MGVCZ69GFFa0Pz6N9OQpIMNUldDHOaQVBvuDijC5VoEQOJ6UAcdVOfTPSX0tE10xtoXrlTanacmEUw1Mo80FHRwoyK0M5VDP6VOP0HZsNmPX0jRb8J8pYEK9PaVFe+SEqgia362ufQzJf5q9uHknNvoFjXDfo0n7nlaiQ6Pk/Wkp372qHHpy0VkarIll9POOzcofF6PlT6pOlmJR2VSubxCZWCBxoRHjonsFtRW7ZsCbZQfAMmhpVCHjAogfX6KnsL8wPlz1+Eap1qfNFsiXTzBRfKUMm5TIkUh86JEuVSG/3q+rxLrvxfh+So7AwjyMT2asYfNO9Jeav0bOdSSmeCuA04bLbn1Uq3YtV2RkbLT6eqAheR2sOi2Cc4FUhh/edpx7CA7arUYbJhS2jjM1sMk6bSJlrX/SBql4ZrHTmENYmV4RF5K56LcHWCEzrA+rh/42f1CJf8YohnUMI7D9OT+Ut5j4R2YCCUXBLiFJB895j8ubmPvl87tf1uvJKnWBbrCZgIqag02eBdlK4tNtd6Ziw1760qSwJHMxSfCJCMEldSyzghxvArRCex8Na8+ZL+2g3u57pqCOSgw6M6tHs2X1USOazfvvoGLUoVU3jB0s06jvg4lkD27maeOSqxUOTnWPxJ3GYBDQv80N8GyeG4lN4MHwgZjOuGEK4X2wZmGTw7WfttxGPVxRhD1OEhtQSRU1xHEeJdHEVdyNTvW3J
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 20:43:15.4960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e247f8a-e54b-48fc-9410-08dc478c0941
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7610
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Enable smuio v14_0_2_callbacks

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 8d9d6b2e68e8..230412fc4d62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -97,6 +97,7 @@
 #include "smuio_v13_0.h"
 #include "smuio_v13_0_3.h"
 #include "smuio_v13_0_6.h"
+#include "smuio_v14_0_2.h"
 #include "vcn_v5_0_0.h"
 #include "jpeg_v5_0_0.h"
 
@@ -2684,6 +2685,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(14, 0, 1):
 		adev->smuio.funcs = &smuio_v13_0_6_funcs;
 		break;
+	case IP_VERSION(14, 0, 2):
+		adev->smuio.funcs = &smuio_v14_0_2_funcs;
+		break;
 	default:
 		break;
 	}
-- 
2.44.0

