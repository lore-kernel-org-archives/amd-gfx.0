Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7CEC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 15:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D93610F582;
	Wed, 27 Apr 2022 15:20:52 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2078.outbound.protection.outlook.com [40.107.102.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 522E710F584
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 15:20:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjGlLmAyKK/M+T0rNV3vpiBB52gDgrDTcDMjytx0W+LTuiz9vl+5ntWqvyX8FdQr4sHtjBTcDwrZZ2rtursdEWbC8WLRf4ktVHqoZ5TN8XqQmF3C+hj7J3unxcoYCgZi4l0JTFZKXrFeAnrWOfd8SABNXw3pgyv9oGCHyji8eye8+0Rp6mMia5BUxjYV4z78D4fb/V1NBmLrjWiUP6DlI6SV9og/EnxUz5hfrwsGy7fULK67hDZPYbqB/Hq9mfOpxC6nsEZj+l8i0z3I1odD5tcNDTXDdzsJICQ/JsqDYM6NHDqfc3SZY/P18NOAPlfolmp9B2xUq9ybyP0HFk0M+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2EZfGUuDGmxVZMFgec+/Slsgv7SCxhhxbrljRXcAhs=;
 b=bi1fV62IWXy66r6DXcq481FFw2wwBbrYHxlTW6DIuiSdwBO4gp1zbwp+Vrv0qlvYSZIOMh9JLRqGIUYApLYOEXK0eOKnba8mqCkIBsA5lPTLW7F3bGzDuGwhJ+VvorTeO/wlh0+5Gq9L9iZssZwytBRMRfvfV+QFqk7rdGAkAJ67Vt94kDWGdQCmYatDTMJPcUrGAAwtunRD/eYJZi22HlyibiA4Nx25QHtx6x95JXuvJIAFodh0kxqX4USWkYTcN3C4Ib3C4/mSy/Xp9htgolDA89Xy0P6L1ygMtPt+2nPse6RpJRSDtrdm6LsNnM0mwLe85jEjpePsw9G7QImzuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2EZfGUuDGmxVZMFgec+/Slsgv7SCxhhxbrljRXcAhs=;
 b=mXmVXor5GeR0L72hlezP+cMCuSeZijdjZ+b+s1TjSX8C4CJnmDQH9Qc2Er5Za/ViXiNLhEBrIfemt9CcOCf0ynHR2eJ7AtMWA0CxiDNTZ5/4Xo+WLP1WunYrZjKwj5FuV8F2sAsVHe6e3ZIpArj5BkFsl53gEKvLXeqBRHNGyVU=
Received: from BN9PR03CA0622.namprd03.prod.outlook.com (2603:10b6:408:106::27)
 by BYAPR12MB2981.namprd12.prod.outlook.com (2603:10b6:a03:de::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 15:20:46 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::e5) by BN9PR03CA0622.outlook.office365.com
 (2603:10b6:408:106::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Wed, 27 Apr 2022 15:20:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 15:20:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 10:20:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu/discovery: add IH v6
Date: Wed, 27 Apr 2022 11:20:29 -0400
Message-ID: <20220427152029.3105101-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220427152029.3105101-1-alexander.deucher@amd.com>
References: <20220427152029.3105101-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9f399e9-5779-48a0-93c2-08da286180f4
X-MS-TrafficTypeDiagnostic: BYAPR12MB2981:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2981EDCA148135CB0C50573CF7FA9@BYAPR12MB2981.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k9RGm1nTeMXjdhuac8fmw1PPxoXCcMffLcIVe/GvJbpQkqq8MGQBVxT/I9FG98UgX3hw1iG7wg1TVNnlcCf4n7lVKs8qAxCCx949hro9Xifx0JU3KLIeQ4bokElrRbluNzcv7tUluFf9saKgr7HupqfR+tRdsMladLYkXkv1kQr1efy5rYBHxhulNI8u2zovv6RSOzm8wDqOu9/QCZqoBPr6Gun4o2EMwObeVmrY+Jzxx5fNzAKiLDB9dmfCvFJSsx7d4Wt37zBLKSnG+ZDt7K1yPXjZVweEJ/XPg6EDfvcoYQaTOg60Z527kP/d/C0dB5H29UtbZlsHl0aWiJw+8DmSsZPpTpmcBLg73fIy6SG9n3575v5VlMi+VBvymn2+woaeu6UEqZ6nkVb9s4tWpiIiRKP3C+yDcMnWcT8wiVBy0r/v3pe2Uj8RfXJGaU8ZVDuJLTzqsoTwoSj+n4CUamxXww5uF2zXPSm9SVeNFmRv2uaIElyfcEF1Kh50Gz0xIg9wB6R7pc1dw8W9qshfOImHCu1/SM/YvaiKaLn3NvurUaOieus3aKMFX+NCSsMZjog34uIjZhjISpQa6ukx2/K8IG2KjnVbVpxtRUCE93wa7NYTE+WviuTVOPaQPfJb5PFUPWrPqEpK7uTVraEeP6ZcfloCPBrZkmFRk32/956vFkuMqG9w66p6lUnl/uz3s7ZQyidfKFz7fZ3ikxZgaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(508600001)(82310400005)(316002)(36756003)(81166007)(5660300002)(1076003)(40460700003)(8936002)(8676002)(36860700001)(47076005)(70206006)(336012)(426003)(70586007)(6916009)(54906003)(186003)(16526019)(86362001)(4326008)(2616005)(2906002)(356005)(83380400001)(7696005)(26005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 15:20:46.5860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f399e9-5779-48a0-93c2-08da286180f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2981
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

Enable IH v6 on asics where it is present.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index f11c01982cd4..8c89e02ee1ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -56,6 +56,7 @@
 #include "nv.h"
 #include "soc21.h"
 #include "navi10_ih.h"
+#include "ih_v6_0.h"
 #include "gfx_v10_0.h"
 #include "sdma_v5_0.h"
 #include "sdma_v5_2.h"
@@ -1542,6 +1543,9 @@ static int amdgpu_discovery_set_ih_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(5, 2, 1):
 		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 		break;
+	case IP_VERSION(6, 0, 0):
+		amdgpu_device_ip_block_add(adev, &ih_v6_0_ip_block);
+		break;
 	default:
 		dev_err(adev->dev,
 			"Failed to add ih ip block(OSSSYS_HWIP:0x%x)\n",
-- 
2.35.1

