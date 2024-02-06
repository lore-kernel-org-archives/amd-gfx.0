Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13E4C48297
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 20:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2B9A112DDD;
	Tue,  6 Feb 2024 20:18:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="itLDG148";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA462112DDA
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 20:18:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUXEU0SdGYeyq34lBG17VKN4Ptcuemf1AdZ/25CMuNsHlXzJXo9CAq30ewxUE0TdZYMkR2tRZNhnQuelx4JZ2mt1RM8HlPV8kHKiVDidQ6I4ANBZJ76m73XDfecDtpCyeBamSWHem8yR3lPvjd2obwZBveZCkRWS7RoEMKTtrCSLctI1Hl/SQpGGQTIjumPzgxNbyashz4rJaHsXaFddKdJs0OLTZIoNa9j2Zs/ryibBu0osjiXiWt5RRD3NzWOoAaSGphhLxEzNd8D2yk2YkhUgJIEDUkdC+U8agDaYw+PTgWriKBThf/yjZ/rdhldwe29aM5cm/2bRK8E5vEHOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tz+4x5zTT2zNmT/UtUvVJr7OT2MUDhOKGT778spYHTU=;
 b=RlB0fgU8VH/nx/M8wRzAJ+ud9D4Wmv5Q2nHR4h/6xdyzn4CE6p1yfe4y8vr9IVftwC37puFy5vNSAQhBL9gfblOgIDquMhQxFqPRVmh9fVWoBKMABUzpkmaI9Nwjy8pWxxEwzzsXgHQaPS66LMx3WY6b1QXPb8GcVV2tyNveBHPkCp7g9Chg7Q+FC0uaIQeiKwHt+3+IYCKAtKnW0/FD2aFJ/1Kenyo1QuTMN9O8TEJK3YHXrPYvjO9+E/j4SxHJn98SF8PJpob8qYpyyCr/EvbehJy4TxXVnSfBRTqiTeMSQ0oTsn/wFyvRIdk28rn7duPljZv4AFTyZWxzlKeiHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tz+4x5zTT2zNmT/UtUvVJr7OT2MUDhOKGT778spYHTU=;
 b=itLDG1481nSg0dvqPtE3zgw8owZjI4E3fsoLD0J9rlgsgGQIejsRWTH6jbJSGMJGsk4/4UOmKlQFWdchfkbNacraH8B0YcNJVHFaHSLZvyHmbTaN33s4SAw3DxRQGn2ba9W7FO0aQQFhwSJxviyIvG6TlDpxTY53NRDZCxKTnQs=
Received: from BY5PR20CA0003.namprd20.prod.outlook.com (2603:10b6:a03:1f4::16)
 by SA0PR12MB4528.namprd12.prod.outlook.com (2603:10b6:806:9e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Tue, 6 Feb
 2024 20:18:13 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::1) by BY5PR20CA0003.outlook.office365.com
 (2603:10b6:a03:1f4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 20:18:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 20:18:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 14:18:11 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/discovery: Add lsdma v7_0 ip block
Date: Tue, 6 Feb 2024 15:17:51 -0500
Message-ID: <20240206201751.1671125-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240206201751.1671125-1-alexander.deucher@amd.com>
References: <20240206201751.1671125-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|SA0PR12MB4528:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b1f2c3-1719-4619-4059-08dc2750bf0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X6NMHeWnPz/eeRcAURtGEkCUmBxTSRPKr0oMbX1QTSkmDUnDbIJ8Md5w2E+3ub/F0oOxV+qELsqz9dRA8n3XAXgxP5kAogmHygCf6s0nuH0MiDWLYQXK91ymW87uYMBQbIh11cnpLWAVbGUyyAgP3yC16+xaPs2h8skXYyitQ1NyyEaVY2GEzQwtHR7Gu/tI0nIiBkjJzknFP0Lemyy5nJQxkf3d8mTkA/wF0FV3q8Bk3zGVQ2D4+2Rf2KyeSfnSBxFF1yLHTFxYwkAFbHLJbIv/3FsbGzYJymfZDh4aBLFl5hLWA5Xyc8JfNcAICd4e+qivzmf2PlyV+OzKT8OiAlac+j0saPiDuhlsjzZkU4Wq1ZJBqTQQuLT6t2usYFsjT4DIP0yfAU4z7l4w5AROIQvOzi8HpK7+q3KDy0eAWVoaPTS/dZy62V0KAwQqrLGKoLtmzeIzzG75Yelial2yOz6lTx2ey4+NI3Iovtg/m3x5NKFKsLdHf/XgP39rYz+lF7UAkwat9vDrOZsD24/HXblC1K3/JoDpecl8vGQL55lue+k1kDuIQAHqcNwUckKHsn87S94qvhEQFf7Xm0jblWOlpWo3JVmo4jKV2zfgF29J1rkz1kxpUUvpkFGN+Az/dYpSnWOA42XJgCB4cBksrl82w213vCQfVRu9GenkB4jzcDGKwmdFjf64ZXAhgmSlPmvMnoI+2PsiWSiCfmIsu+Sr1qny85CWZLf9DSmtIUtL4I12tqzaD5fvedwa2hX+A+3ibkA8ybYSpZhzzznegw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(2616005)(1076003)(36860700001)(36756003)(478600001)(86362001)(82740400003)(41300700001)(426003)(6666004)(83380400001)(26005)(47076005)(336012)(16526019)(81166007)(7696005)(356005)(2906002)(54906003)(6916009)(5660300002)(8936002)(4326008)(316002)(8676002)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 20:18:13.4570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b1f2c3-1719-4619-4059-08dc2750bf0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4528
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

From: Likun Gao <Likun.Gao@amd.com>

Add lsdma v7_0 ip block.

v2: squash in updates (Alex)

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 93c84a1c1d3e..e941aeb6f16a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -75,6 +75,7 @@
 #include "sdma_v5_2.h"
 #include "sdma_v6_0.h"
 #include "lsdma_v6_0.h"
+#include "lsdma_v7_0.h"
 #include "vcn_v2_0.h"
 #include "jpeg_v2_0.h"
 #include "vcn_v3_0.h"
@@ -2641,6 +2642,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(6, 0, 3):
 		adev->lsdma.funcs = &lsdma_v6_0_funcs;
 		break;
+	case IP_VERSION(7, 0, 0):
+	case IP_VERSION(7, 0, 1):
+		adev->lsdma.funcs = &lsdma_v7_0_funcs;
+		break;
 	default:
 		break;
 	}
-- 
2.42.0

