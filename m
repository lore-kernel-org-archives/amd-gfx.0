Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB99C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 18:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9C3B10F8BB;
	Fri, 29 Apr 2022 18:03:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2437D10F8A4
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 18:03:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjvqgQeF6aOLKiy2bZxtljYuCi9Rikb+QQmMphwyV5Nz7hvQwvINYdQDj4mXfngacbWLSaFBuQdB43PIy9bYMcAQNA9BaDXvhbhCNPSTQNQ3Si4elguMonkIHbIEJdqED6HSxukgmZub/7fDjUOhjL1ELR7Oe0ofHliFxjE8B7no77uNdej27R/0gN4skbCshLDAUa+USGHCkqdUKuI4Hnz1d2DQ1/2iqEj8fq48yRMxxWL9ZKNo+wOwYc1P9gRF050/CxROx59CIumXSJx8MDt3RKnP/UJWo0gsr/MM8f1v0WvETc8Dtm8TLV7ABOiN0R8hpUoHmP3IxdcJwd/TpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OjZJD013shAHkETOdIPyg+YlhQD5puwUdSxgx7RcDE=;
 b=VuUUxupCJY+AymVBi0M2q52fqfTJbRHHupyUSvT89DmVNnoFMq2J/btkXS0OAfRrSq3yF/3MPvi96usC8wmxFpM20/Z+ZoYlBX8epo07BHkrOdbQj006lZYMmir1OgHWdUMztmCC4Y4jLapwfviB6vNlg514KJuDpTPM81lhO1EG592gD7aQ1s++nZ6MNxDgmof5vxbAO3Pd3/6g0ZQ67Ly/Xc2y5eqcKdDtOAj5qhOcqJ6MxV0cKmc9m0kDBV1jWR8qjfwzBADy7PEqGRF+i6Uwy24urTbuboMd35SB08UgP0o4GLqTqASIzByOCzB14kncqd7vlm6ESnAMCrR3fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OjZJD013shAHkETOdIPyg+YlhQD5puwUdSxgx7RcDE=;
 b=ZkE2FahixIA/xNdQLxzU7RH8NdnZ10j+0HzDTYZKPZj8vezbZRiu2gdSXlnCP0XzJx8Lxwq9IW3I4hLYKRZDuEskd8wgrd+dR7gzKGMgHv7Ionx/tlpvs95ACOQ2QOgL4ToKYJeLfi9KnoXDyvJy6R+xBVivmw34ItPHf9Wzywk=
Received: from MW3PR06CA0007.namprd06.prod.outlook.com (2603:10b6:303:2a::12)
 by MN2PR12MB3664.namprd12.prod.outlook.com (2603:10b6:208:159::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 18:02:58 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::72) by MW3PR06CA0007.outlook.office365.com
 (2603:10b6:303:2a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20 via Frontend
 Transport; Fri, 29 Apr 2022 18:02:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 18:02:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 13:02:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/29] drm/amdgpu/discovery: add GFX 11.0 Support
Date: Fri, 29 Apr 2022 14:02:25 -0400
Message-ID: <20220429180226.536084-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429180226.536084-1-alexander.deucher@amd.com>
References: <20220429180226.536084-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0df47d9c-b9fa-4874-75e0-08da2a0a7e25
X-MS-TrafficTypeDiagnostic: MN2PR12MB3664:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB36640BB80E965D4FD8C53971F7FC9@MN2PR12MB3664.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NrsaxeR+DScCAEYRtxz6uFyBWSyadnIyBBKeAyfhpKN0AeF8E7Vn/HP1/Jx6I+YCIRlQuihiH8emO2/uv4PRW+vrSExQVQBp8dUwAiJhioTfMlcTF45GwJdxQm6RR5GThZ891jf0Rsp9hC5KTM/ooC9WD2YhtRhzI5r3lIntKaCPI6reT+Y+ZDn9IGScL/saaN77CmYXViBHlciOsCh0s+9SjFoy3Eux8lAL95rjsVqoSFA2UxcUGLT+OVj7MldIgTtB2OiUplJz2LpmbpIrvNyxp0fXd3X5mBBpnwvhlaXmsqp7b0GMGACJTjizfK+2S+rQtJwMRZ8qtFmjgcIpu2jR51+uokqCmH1mcXW+iSerX3KHu24QnSxxv3sAYEDHhMI1pAY74gQLUCTdufwoekH9FC7IOuQIea0SPjupV/4h1ejDdD0aZnLpR2jOklfKMoHcgIFniISk4BIqCmfNEH3NHAVdkN6Vl6DWkPPazfqHiZ5/tTof/j3eW3KAqx0BXAmW/UD80GeJmNs0x5XV6OxVhvG+0Bam+k8k6d3kGA/895l5I1NOYkozXUqCo81XQj5JE3Zld3oaXbtVMx8kqo2ED/18Nlf5VXD/G449Jw3fA45HAoWzkEh06zHIUwK2OVcZ2qFgTOubz1YHdN0X1h6XjUFvdv3MDSuiTTKTzLblmtHVYWIQ5wWqQxUG7V9g6P04+uacQtTvCgrfyMHngw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(356005)(2616005)(40460700003)(1076003)(81166007)(336012)(47076005)(83380400001)(426003)(70586007)(54906003)(70206006)(8676002)(4326008)(36860700001)(316002)(36756003)(6916009)(82310400005)(26005)(7696005)(6666004)(2906002)(86362001)(508600001)(5660300002)(186003)(8936002)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 18:02:57.8895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df47d9c-b9fa-4874-75e0-08da2a0a7e25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3664
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Enable GFX 11.0 on asics where it is present.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 0adcbd38cf61..d3c9f07a43af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -60,6 +60,7 @@
 #include "navi10_ih.h"
 #include "ih_v6_0.h"
 #include "gfx_v10_0.h"
+#include "gfx_v11_0.h"
 #include "sdma_v5_0.h"
 #include "sdma_v5_2.h"
 #include "vcn_v2_0.h"
@@ -1732,6 +1733,9 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 7):
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		break;
+	case IP_VERSION(11, 0, 0):
+		amdgpu_device_ip_block_add(adev, &gfx_v11_0_ip_block);
+		break;
 	default:
 		dev_err(adev->dev,
 			"Failed to add gfx ip block(GC_HWIP:0x%x)\n",
-- 
2.35.1

