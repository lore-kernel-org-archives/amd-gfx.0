Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5156C9830E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 17:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 242B310F6D2;
	Thu, 24 Sep 2026 17:55:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="11JE8bUD";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011043.outbound.protection.outlook.com [40.107.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD97910F6D2
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 17:55:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mf5lX+Yz6pIT3oTv3qrxDdUCnRMjDt/FIsg2u31H1wuvCJ6JvKHHpVRuItDeLXiIfwbqAuC+tXbMBm8BOc1aGyigBWw4NfQiLW90jDQiYoEgfEX4qOA6X6fd2Fsw5uSpmhU76vLTiIS6fVulMdncqTS4xiJFlBR6sp8iySiIs6h/dQMsAA+s4nUpn0R7Gh7L/aGLDREBnrXwqW8uc8KRSQ9kRympBYIFcHQZIfSNbgknmzT1qC6++hIR1dMqe16I/MV0HK/7fUQgDftmeAR36VbzVycnGf8LDLLCKK/uEKFydvWjSvymmdusqh/9X/yXx2vKC+kXGPo8AdH7XhmAzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBAQhPBurI1XfphYG8NMjZ1Ur7h8QrcrSgTtGQF2Q9E=;
 b=r7V4WFbCKs+ziolB4Ea1F9XtFYv35XjS36rCQ0IZmm6iAhPxa7dJA1UvRBil4OgvkqWwbAwnUY/XcrYpCvYvaXMy2/Jns5A4EI7fwS1f29t1Wb63fsvYDva4u9C0ABhIMzPtmVmfYtS9H0DncQ0iseRQj5H5LvJ1KPWNoD/rXkrfbQ9fTDvW3Omwt/qrV4Dt3P85+xEKXjBAGBmAflv8BuafWZ0/YFTNvfA95zx93anwRcqv2eQ6r0UCouAA9Hy9eDDIPtZ1MPJ+87Wic9oBYW75Vw5f4vVIxSlE+DwjOzhvNKqsokbRfW1PcavNdN69o4nJrWUzOiKpL73eWZvWrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBAQhPBurI1XfphYG8NMjZ1Ur7h8QrcrSgTtGQF2Q9E=;
 b=11JE8bUDLbe0Jpy9m9zayUT8dTWccbX3kM53jQNJcnmd509MenImtZx9zYJJridbyWNQfd6Sd3UrO9wLhbnQ6p7vICQrVpc0ZBtqzqmhbXmVY8/Q9ObWXgKn9J7Haul80S1qLMismJJijG6lpY5Yp+XsRr6awZ0MIIRnjNVHDbM=
Received: from BY3PR04CA0021.namprd04.prod.outlook.com (2603:10b6:a03:217::26)
 by SJ0PR12MB8139.namprd12.prod.outlook.com (2603:10b6:a03:4e8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 17:55:07 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::19) by BY3PR04CA0021.outlook.office365.com
 (2603:10b6:a03:217::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 17:55:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 17:55:07 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:55:03 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 24 Sep 2026 12:55:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Gangliang Xie <ganglxie@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/ras: add support for smu v15_0_3
Date: Thu, 24 Sep 2026 13:54:40 -0400
Message-ID: <20260924175443.636193-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924175443.636193-1-alexander.deucher@amd.com>
References: <20260924175443.636193-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|SJ0PR12MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: 4afdccfa-03c1-4b48-8b30-08df1a64f824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: fLr150jHiAY+i2apYhl/z1Zz5wiGa52kc80K4W3TqyRTVQnCimIxZhD8qIKjRZNKzxQrOOxJzoLHNI2LWN+lep6K88/KHNIhdhqcTS7hC3Sm2qrJ6VL4jmFd7ptsiuXNErvtROh2C8cN8PAEonNXSRaoDu4jT1HoyqJiUrHzbIHrquu8+RaNkMsLQHuisfR6Y7dJmfMbtCE26MC0/tVosD+n/fGz3T1+J7ckcHg8EqJ5UMMvP1t8xj0L7jrvwbxUQupJL66Iw68GpXMXLogmFv8KGR/v0zsYtxtrnsR+dRyYPTvupfi+Kn3tUFKqZAYRU/tj4Ijkv5loL8mYYpD/FVGSfLp+ToQQy1hXTJozpdrvhwXarw7IPwyopO01++yCCsChQVcXXcdxief5IW8QgiiDYhPDD0GJrSH9z2SOZFZ94+7ZSNSZ6HKT+LRz+1vXsF3x0Cd95psapxGpJNFfbj2X5LJFb9LBhi6DMEoDyBQWm4ZgHzjZ3kubqGFzs5DrXABjw9UDL3ZzvMFvpUbjDbmEUlqANds8+cAOjYnpvYW24V8EceWNZ+29FRC7oLMg8WWLcbooUabsUdJw9cv+eub/mRzXP+VKQTWSKlvC4akp6R/8MYgJ38iEPGqmtikiXPCFAtjQMRN7xd8+OnpyTmuVAJ6yrissxhC8xsFH0gYVnJEoC8kirXFKBnaNv7xFzhWqtR7m6kACb4ZCj0rmuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uRLcaFQvWqAoC3lwcCsR6g3UEi8scaWEzW//OzhbUWPgZsnZPbBOIksOjLV4gfjyT447BTdLL3Rrh7/EXiR5ZNZ6uahd3ZH79D/BnKNzbOJFy4hLK9uIBeuIwKNUMS53+WqU8PQYl25gSRNKcmFjPGMjOhqbb2Ub3llO3lEk6zVeN+xmrCezzcCTcxr5pMDcysQOConzW1xyD0HTEk8Db0WlhR585cSiJzYavJc0m4vVWIdjzuZTSsW3g4UVpAgadl81M+quMMTYPbyjeqJqziAFrZTzZ2032vabBwB+X8xdpaEsebOHouhmABbI30kK4iDwC5KqbKmSa4IfJex3HzK4CvCHIRS+2eqzSNV0r6pr0bwA3ueJ2uR6EUBq0VMSDLvRtNV2CpKxxCajymTxLOIsduUowo8TzSGIb3ZiCtWqCV/86eHczQrNQggtiq4k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 17:55:07.1092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afdccfa-03c1-4b48-8b30-08df1a64f824
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8139
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

From: Gangliang Xie <ganglxie@amd.com>

add uniras support for smu_v15_0_3

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_mp1.c           | 1 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1.c b/drivers/gpu/drm/amd/ras/core/ras_mp1.c
index 4c180027850f4..87e93943b51f8 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_mp1.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_mp1.c
@@ -36,6 +36,7 @@ static const struct ras_mp1_ip_func *ras_mp1_get_ip_funcs(
 	case IP_VERSION(13, 0, 12):
 		return &mp1_ras_func_v13_0;
 	case IP_VERSION(15, 0, 8):
+	case IP_VERSION(15, 0, 3):
 		return &mp1_ras_func_v15_0;
 	default:
 		RAS_DEV_ERR(ras_core->dev,
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 2ae3e8c293167..8633bd56401d2 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -165,6 +165,7 @@ static int amdgpu_ras_mgr_init_mp1_config(struct amdgpu_device *adev,
 	case IP_VERSION(13, 0, 14):
 	case IP_VERSION(13, 0, 12):
 	case IP_VERSION(15, 0, 8):
+	case IP_VERSION(15, 0, 3):
 		mp1_cfg->mp1_sys_fn = &amdgpu_ras_mp1_sys_func;
 		break;
 	default:
-- 
2.55.0

