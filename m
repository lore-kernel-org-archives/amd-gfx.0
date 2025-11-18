Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E91CCF2562
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 22:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED60410E207;
	Tue, 18 Nov 2025 22:55:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LMnf/lKt";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012069.outbound.protection.outlook.com
 [40.107.200.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56C2A10E207
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 22:55:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7W6k9wbfHNYBXK3mX1g/oqbLODgm15ICChjvUBdHC5c4xy02qNOm0gi2uWT8oP4xErJ1M0dG9cIHF/4rLkNoEr18RgQTo8332TTH5msE5t0ZcMUTcrs+4R7t6fGLQEjioggSz85ezN3aP0h6IEEn60DRN6v1CrHcJevGPlW+TISlIoWAVgR99FMhFXJvsdNl9luGEXXlderHZdi51bzHzMXsdv+s2xfVFA+sxwcbbsFglM87IpoULOv88hvXYh4dKZNi4XsxQzhD4LhCWHp+YDraJ79vUhBTBI7po7h1xSKHlW3w0NTFQ5/U6GVsfv/aA3ksnS63fMjLz1XjXaQOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaOqJbqLXb1UdjaOdzwxL54DtcOV3N8bo8LLfijzvQw=;
 b=fhZBG9s/694WvHVhmQbZZ52D95C+ds/1hKRmnfbQIudEjGpqZzGTuxRxvi4y68DxfWSS0Sam/Pvf+FK6u8pn/0eTnb0lwAtREXV2QZbXqvUAS8P2PcaEMpUVKxBaHXQtksxJu3xEmP+e+lcm/kw1PYB6KdywjGpOCX5brl8Z5f8qyHWOIedAsYOKBqGfwCU+eIxZ4IF4gJjCTCF+BaG3BO+Jb+5z5XjStEXSr1Cx4Y5QpQ5Ee4zoREi1PWL0UIPszx/EqVF57Ybuz2pHyj92hsE7kn+jmIlgTA/Ji3IebfXooZsbN3Z9jnzaBnYX0zP5bHtDKGSfpQAJpoHHleB4Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaOqJbqLXb1UdjaOdzwxL54DtcOV3N8bo8LLfijzvQw=;
 b=LMnf/lKtgQ9wApHRHfeJB4eiInCCnufbwaVtD4XCAyF72ti7oI3uqX3IYpn0ga4ujG8nOXMdISQm1XqhERybjGmVbcv1Fwn0JcOrY4piMW0YWZPWXl2DeLAw6KF5DT7yZs+wic4XOCAFPshjQ8aRyQLfBfeN7k/fToAqgmzQBRg=
Received: from CH2PR14CA0060.namprd14.prod.outlook.com (2603:10b6:610:56::40)
 by LV8PR12MB9133.namprd12.prod.outlook.com (2603:10b6:408:188::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Tue, 18 Nov
 2025 22:54:56 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::be) by CH2PR14CA0060.outlook.office365.com
 (2603:10b6:610:56::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 22:54:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 22:54:56 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 14:54:55 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Yang Wang" <kevinyang.wang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: Initialize smuio functions for smuio v15_0_8
Date: Tue, 18 Nov 2025 17:54:38 -0500
Message-ID: <20251118225440.3613071-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118225440.3613071-1-alexander.deucher@amd.com>
References: <20251118225440.3613071-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|LV8PR12MB9133:EE_
X-MS-Office365-Filtering-Correlation-Id: c53216f9-cfd4-475e-bbec-08de26f57e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VBN1qjuxjsmcq9eOZRgrYW+dQm+WaWd7zGVBPuIOFw1OzcOjm5VQG85rckHf?=
 =?us-ascii?Q?eFHh0eUm8MzDNGEk79rQpjS1ZionRehZU1irVLhqfeLab1bnevpQVDgvD44n?=
 =?us-ascii?Q?re6IQJeYvdWwaYABxl60V3TYhAAtc0WKtcXNnPLyvxBrc6Vd1gsT+6SLNGor?=
 =?us-ascii?Q?lIB/ZvQscQEDee4zOR1F+8UBuRJRnDdKdkcsY4hfTndBbs8opw5gIN2uRSZz?=
 =?us-ascii?Q?sj9xhpi/4bcKfQwzqAcJcP2ohML17eR9/+bUfczwLkTDV6NOgvh1Nm6HfXOx?=
 =?us-ascii?Q?VKpfslmzN9oz0xKqLTxogy+AT1rsa8uqsCU1o4ZIUWyF2LlWDwb0viedWSiP?=
 =?us-ascii?Q?ynqeqjmjEAylcYOBTPXIDJY6NTAToJ+JwLc6E30OQlXdLTsY1S2LygMt+/rU?=
 =?us-ascii?Q?u2uLDoNS1tr0Mv4hqxeqtojK9R2TR6sfEIK5m1moq65n2dNs5LOvWxJoVzT0?=
 =?us-ascii?Q?/uDSu4lMizPDiPP8JWgUIg6nzQyYcp0bbJrf/5+8wDQG1/vkqtUuSclX47qd?=
 =?us-ascii?Q?ptA2Ws/WUkVv8AYZBr7t1q6KxmVYkqNtgM5u0gt08IHXOi/2nDDT+4e9jIqz?=
 =?us-ascii?Q?YjMfA8juAy4SumDDhol031LL/tI4rEx2cGcenve16xQHF+6FVxDIceumXgFr?=
 =?us-ascii?Q?1UijiD33dsuR7ru4qW2Q9TL9YVIop0/zme2/zA4O4q5JcFwA/JSeI9kOb2DG?=
 =?us-ascii?Q?fXsHNE1wtxa7LSXF+FsrA8twdxN/CDi6fJx45NcarB06wlwevnjKKMzJxyd1?=
 =?us-ascii?Q?8sZ+JG91CM9z5zYeyi01cLDX6qWcwZxHhlFsr9/XGOvcJy6qmksECzFgGx9I?=
 =?us-ascii?Q?tb2DDqKJ9Hj/Ov8USqhl4qmoFGNXiLkAibRuSm5oi1Zq+4P9ghuYn3IhhofU?=
 =?us-ascii?Q?GlrEFpeuZOPl7FthNUH2SwkXo7zsPY1cExz0xiClIITQE3Xn+27zx0kGH2q9?=
 =?us-ascii?Q?R5FgfYlQeLDV0Kx91mkH55IJn+kaWYozyh5C83bYH8DFsjJjFdBQHAo5gJNh?=
 =?us-ascii?Q?ddH6WVGMSgTQRzof5TtW1M9k75x90QptN/C6rd/zp3P5FEQm0vggIfv1FcQP?=
 =?us-ascii?Q?3br23GLIFustICo0WLSSJ8ZhV4Zs77UBLcjAMz3JFt38vT1owkWbMBoTAl28?=
 =?us-ascii?Q?3RimTa/rYRpGgAhOiB4gLeQIa53Vbb9n1i+JiuByxhrWJlgIV4j0CM0q/S/2?=
 =?us-ascii?Q?txAKbtqgu18X/0TE1oZ2suJ2OHImVgQ3ifGZi0ueHsLMG9FWPyU7a6PJ/I0F?=
 =?us-ascii?Q?qceAiCUxA0l5oVXODJSvr11tcP0EsU7pPFqgc1qWe656Z+bYamhmrHuZuDK2?=
 =?us-ascii?Q?Z1Z0TWVHYYmIZ6KMZdsZ8Q/bPJN3xIPwROZ6EEfdcDD/ZlvLa0DAJO9sdtEz?=
 =?us-ascii?Q?VgRCedPUqILJqJ7MSrXrBgo4iueY494iWkdGliD6QMZdC6uIMOz6GBWkyZ/d?=
 =?us-ascii?Q?hfgVTePpFakzNnXJjiXHKh2+7LN+iPp8Rnrekgztpa7VT4+XU/97N8Epab7E?=
 =?us-ascii?Q?k6OsYwX65GZep1n/KW4p35NuNVqkmVhK8beCJrtXHDjH/0Ub/7Rr603SCcRp?=
 =?us-ascii?Q?390/DcKWpBX8Y0OdMgI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 22:54:56.1830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c53216f9-cfd4-475e-bbec-08de26f57e61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9133
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

Add initialization for smuio funcs specific to v15.0.8

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 9799e645b6bcc..959136c163ffb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -103,6 +103,7 @@
 #include "smuio_v13_0_3.h"
 #include "smuio_v13_0_6.h"
 #include "smuio_v14_0_2.h"
+#include "smuio_v15_0_8.h"
 #include "vcn_v5_0_0.h"
 #include "vcn_v5_0_1.h"
 #include "jpeg_v5_0_0.h"
@@ -3143,6 +3144,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(14, 0, 2):
 		adev->smuio.funcs = &smuio_v14_0_2_funcs;
 		break;
+	case IP_VERSION(15, 0, 8):
+		adev->smuio.funcs = &smuio_v15_0_8_funcs;
+		break;
 	default:
 		break;
 	}
-- 
2.51.1

