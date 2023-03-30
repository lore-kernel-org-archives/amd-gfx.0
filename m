Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCBEC77B62
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:43:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EDD110EFF7;
	Thu, 30 Mar 2023 19:43:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6003C10EFF4
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:43:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kf+REyQUk9vPUcQgzD8izkQZ4+4tFSm2/Q4zaEizJMV43ZsPzdKlwFQmQf7hWeIbnyixni9ulj3aW4q0wL8wUVnUtzU4yc/H0SlnPz9tBg/AlcZ1UbMyLsSa27hOAJ20/EgqXCWRB9gl9w9PTCQdBg0XzUd2rRKYBX4M0tJZ/xqByl0YfRuklLh4KkeMtLaxUJoKgdzEXLuc2PfiuWGK0TJQcR/ZqqHLkGa6GG22Y2gwDHx+lBubMa83qarReLopQsEidlHoeAdXuTlZZx+oHwRpuzLL/oh5AnkJWnugw+FcImt+WU/hh/HKdn584lU+oIbuunLisi1ntGEa6FNEGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96A8+4jeVsED9n1N1ECfUpx7bnmSXdtOYU7/Eh2cwCg=;
 b=WJwGARjfdmRr2iVVTv7LmyVgeS2/O0fNcsMO+ZdHA7rckGPYsnF6JUbFsOfZoGMA2wOZ8A4o/yXwCQXLxNc2XQPJg3ktD8JY7G3o5MOuj+//eGwlJT93rVovEVZnBU1DeWRLFkWlWS5uGGy+BPwWnFA54UdYj7Y7UeJCeocOL4yGQglPcANQXNzzDu9cI4NwPKy7Ic/vxuJzxrtb07LB9FnwZvjS9LuZ94KYQplSZ51EGlHMwx4b7zUdeaCZlDYRD2aL4U03ohdK9C/YWNZwVOi1kvw5yIiEPXn8lq/asmIpeNtsYCEi2xqHuAzOinhGSg6Odq1AiCij9bX6rMoTTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96A8+4jeVsED9n1N1ECfUpx7bnmSXdtOYU7/Eh2cwCg=;
 b=yOxKC5PRZGWBb1/c1q3IR/6P0PtiivWXNOhWPhm80HaVKUrdnV09d4ZrHjKEPLUK/xk4ab7xg1Cv62v2KMgaiWerxcVgDQ9MGAXVLerZjOvaFUjWqU9GyP1cHnK7T7EfaSngZj97btskHRNGPq2KdKLM4I8i5FtGV+dHm3qMp+M=
Received: from DM6PR03CA0078.namprd03.prod.outlook.com (2603:10b6:5:333::11)
 by MW3PR12MB4537.namprd12.prod.outlook.com (2603:10b6:303:5b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 19:43:00 +0000
Received: from DS1PEPF0000E63C.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::b) by DM6PR03CA0078.outlook.office365.com
 (2603:10b6:5:333::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:43:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63C.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:42:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:42:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/23] drm/amdgpu: increase MAX setting to hold more jpeg
 instances
Date: Thu, 30 Mar 2023 15:42:34 -0400
Message-ID: <20230330194234.1135527-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194234.1135527-1-alexander.deucher@amd.com>
References: <20230330194234.1135527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63C:EE_|MW3PR12MB4537:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c557395-82a9-46aa-0f10-08db3156f7f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oQjQsOPsN9hGKuduKJw2mYhkiev0UySpMo1TOXljoMJG49Zr6na5XIit+pXcpesSm2lKMJzgr0miLF/EMw2lT3t/3jgV4/s/OnfM4C2Baq7hTAkTX7SMJMwvwZZRQ0yDb6h8XIP/r0sH5BuCIy1dUa/8dsgh6qz/dEvqYo8AQt/JQGGLo5WAK/yGp1bQOaaq9IUx7n9jkFxV847hPRxROWf1pdn8WoLTuF3FoYxSVjI+an5rvCM5fP/D2SJzhNEJSbK1FyPC50hFjhMhm5BQ9LStcmgEUFBKjmGZ4p+MOBatiDbyKSxZSCVwc9BUHNj3nEj2J+4l+WrBYDFXcgCpAH+Cls2CzjrQS/h8n0rsQdLEASyiXmD4v1xFP209+lGs66INW2KoTrk4b4CRXtbMy8E6clRVNtqIDg8UlUF5nJ0VGUA5lvFa/w0n4m5OPPyyki+TkJaV3e+A7tYcT0r0Q8zDnTFuTYquPAsirmlwT69UjjIqArqiBGoXW5AdjLFWgz8pd0IygcWtvEaDVJT2dlqQ0/WYYsmtd2FdDP786rgjBr16EAqt0SoJf0ER5g1BIC7tkROPSb+q/i0z74cyisi2R7kTPM5FT6f5EHAhMtYimjooHOOVDLjAeLazNCl209loVgQ/Qx2DLbdZa9+GfKI2oki/1/fGFSTQgYTrWLRDdxI7gdPxUm0BELjW4gNSYkqmtlJim3ItanV1LLO/sEU6FpdEAZlX5couCQ9DBuw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(478600001)(82740400003)(47076005)(36860700001)(426003)(7696005)(6666004)(1076003)(4326008)(6916009)(8676002)(70206006)(54906003)(70586007)(316002)(83380400001)(336012)(16526019)(186003)(26005)(41300700001)(81166007)(8936002)(2906002)(2616005)(5660300002)(82310400005)(356005)(36756003)(40480700001)(40460700003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:42:59.9387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c557395-82a9-46aa-0f10-08db3156f7f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4537
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

vcn_v4_0_3 increased jpeg instances,
need increasing MAX resources setting accordlingly.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Acked-by Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h     | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index 93cbb307db93..a8fd7797bc8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -320,14 +320,14 @@ typedef enum _AMDGPU_DOORBELL_ASSIGNMENT_LAYOUT1
 	AMDGPU_DOORBELL_LAYOUT1_sDMA_ENGINE_END         = 0x19F,
 	/* IH: 0x1A0 ~ 0x1AF */
 	AMDGPU_DOORBELL_LAYOUT1_IH                      = 0x1A0,
-	/* VCN: 0x1B0 ~ 0x1C2 */
+	/* VCN: 0x1B0 ~ 0x1D4 */
 	AMDGPU_DOORBELL_LAYOUT1_VCN_START               = 0x1B0,
-	AMDGPU_DOORBELL_LAYOUT1_VCN_END                 = 0x1C2,
+	AMDGPU_DOORBELL_LAYOUT1_VCN_END                 = 0x1D4,
 
 	AMDGPU_DOORBELL_LAYOUT1_FIRST_NON_CP            = AMDGPU_DOORBELL_LAYOUT1_sDMA_ENGINE_START,
 	AMDGPU_DOORBELL_LAYOUT1_LAST_NON_CP             = AMDGPU_DOORBELL_LAYOUT1_VCN_END,
 
-	AMDGPU_DOORBELL_LAYOUT1_MAX_ASSIGNMENT          = 0x1C2,
+	AMDGPU_DOORBELL_LAYOUT1_MAX_ASSIGNMENT          = 0x1D4,
 	AMDGPU_DOORBELL_LAYOUT1_INVALID                 = 0xFFFF
 } AMDGPU_DOORBELL_ASSIGNMENT_LAYOUT1;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index 5c200a508fa3..bb700a2b97c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -26,7 +26,7 @@
 
 #include "amdgpu_ras.h"
 
-#define AMDGPU_MAX_JPEG_INSTANCES	2
+#define AMDGPU_MAX_JPEG_INSTANCES	4
 #define AMDGPU_MAX_JPEG_RINGS		8
 
 #define AMDGPU_JPEG_HARVEST_JPEG0 (1 << 0)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index f4467e5cf882..1f40c0bfb33f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -36,7 +36,7 @@ struct amdgpu_job;
 struct amdgpu_vm;
 
 /* max number of rings */
-#define AMDGPU_MAX_RINGS		96
+#define AMDGPU_MAX_RINGS		102
 #define AMDGPU_MAX_HWIP_RINGS		32
 #define AMDGPU_MAX_GFX_RINGS		2
 #define AMDGPU_MAX_SW_GFX_RINGS         2
-- 
2.39.2

