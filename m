Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F018606A335
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 22:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ssRSfXZS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A38B210E49B;
	Fri,  6 Nov 2026 22:44:13 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011057.outbound.protection.outlook.com
 [40.93.194.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1475E10E489
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 22:44:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rc31MQ9DmwJg8RMgqGUE6WL1ng3pPyaAwYvC1IkeadZNbjs80HyXbpokEe6q+HrUU17M5d+L1oSpDsRFQESUOP04N6Q+26JS9Lkox3veorrTlJq70hP5ufKlLr+1jpxg/RTfjAGdTmpZ9qk3CRmkd7L3Ksu2RBqndoLpXfhf/L7VA7s0MoPiV2lcPHOj5tVZehL7cv/6uDxXm9k+nX1GFDnHl7IvS41/rWp3C0gyXA63lagSGSYvfE2BeF1s3V/8Bcqf4TgXkVA2tfjPtKq2jPn3QtRfhcDC/E6DRZTadQLJBHNezdUoShS/9P9KAQP68YidQc2r8z1dtB9nRt6k/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdbWYM0v7xrNEK2xFmES9yOYMiOsOVsj1/qnCIMjVbQ=;
 b=vKrRUy5/O/E4pOxBLaB1EVviPhjHH+baScHyjQX+RhFFNz0RlCCmtN8sJobhJpExyswM74Y7HLfMyirHLc0c4zsvgx1q4Dq9Ytwh8URl/TOIxw0xD8AeGanmrfW2wHIbltsiNpygkc7xgDXo4sEDOCExXFBe0ckqKVS9u8QQW1ZT7hwju8zg8JEMh0wMGDUNc+GvnJmeZznUc+BzvwUC4bVyhk561o+VsgjKmoBjVIw2Ey311gVt6JDzaJqq5TtRR7vsPyH6IoWHQjlMMqc8jFBFkIFYGP0FVsQE4bbzYjtMQagQ5amPha3ws3Jo51wXTWJxjI0h3Do1A9Hpr9p0yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdbWYM0v7xrNEK2xFmES9yOYMiOsOVsj1/qnCIMjVbQ=;
 b=ssRSfXZS72kZasxc9jZ8x72m0YIlZoCac2vulMa3QpsFRmSrIohbCs4Y1lR3VXS0dVC1CuwsSZUGVpEimZM+jpB+nB1qVp9wnk1yxNlDNQzgfyF9CZH4ypoqhjWyj/SrD8WOHEok/Z0nIFsqNB1Am6rOOLs7P5uSL+i6RaM7bsc=
Received: from CH0PR08CA0023.namprd08.prod.outlook.com (2603:10b6:610:33::28)
 by CH3PR12MB9251.namprd12.prod.outlook.com (2603:10b6:610:1bd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 22:44:02 +0000
Received: from CH01EPF000BE941.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::77) by CH0PR08CA0023.outlook.office365.com
 (2603:10b6:610:33::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 22:44:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH01EPF000BE941.mail.protection.outlook.com (10.167.244.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 22:44:01 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 16:44:00 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 16:44:00 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 6 Nov 2026 16:43:59 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu/discovery: Add gmc v13_0 ip block
Date: Fri, 6 Nov 2026 17:43:50 -0500
Message-ID: <20261106224350.3568574-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106224350.3568574-1-alexander.deucher@amd.com>
References: <20261106224350.3568574-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE941:EE_|CH3PR12MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb1238d-3e97-4e59-efe1-08df3c577438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|18002099003|22082099003|10067099003|11063799006|261102123227099003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: yJHgGE/LXSHmLPYo3MGUEFp4elKJxsUGaRV6PgYBT0NIxA7WAcCAR0a52WRtynM+43ul3iQpI2inTterxRFnhMvg9PupcptXpsy/h/X/6VeS/v/MHb+z2zH4SDcBHaO4RHqCQAyWyp7yjXp4w3F+Dv0IX0JT+Jj+Eu47khC7JGtXhkla9os2RuabjEF2vzbN5hE9kygbuN0q/7AJpg5ePxE9bpT0lQk60RXsBSotf9kwYh2mNQZBf0pM5zFBZlUGaxWlyjy6PKcCECDQIZUyXUFmOhoTYNfhBozqfyKXNIbV7F4w4WPumfBgH7H/yY4z4OUw7fkZkp9rXr2fgMSipLvJGEWwnihZe0I2cEz+TosJdTs2MDnc5Hes/Zxq74uJoknmhuPIGR57Xemb4+kYWiuOlZGOZbJKONeFcZtWkoR/DFZH7yF+dRwTAn2ww5c8L4rVb4ublJO+kFmAJ4mbkraud0xZ3a9gZu+nqy6VWy69FGYaeYMADee0fzXX2fUtlB5tWNnGXml97tcqo+AOOuCxDtWbRGmFi0tHXG7JZQjtO/A2lEV0scNtM3GiIGWlGt0HVqcfAz0J5cEkS5Km+GvJL47eUXR+Bj67EvRW8uLeeq8pZ6vZOscswLGE89H3eS+NWjvyxK+u7oPogJn+l2JmWMw7M9KZIWNibtEcxjwfVf8KTi8iGvGg/l8XjbcW8ovZbQZg9nmpDsyZ4khiPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KiN+QzWtKCXjpnoQs4Z+h0F5BilkKJ0bcNha+kjCjGvHMkOxynygd2ZKIXIKvqNFnLOIJIeiwn7ncib2Y/n6FmVPjGaKDTN0cs7zMoAm10FH6n/gSJC3vXhny3u+U1gaypp2dFyaObANkCj2ONEHhuUalbZ8ZCULWnyVIgr12buXSPs+iZNFxckcNATLj3zNGzImtoFqflQWqN2SWrbW9G7VUwpiae3CMkNBaLsm51eqF9qpl+d9QgzIpweiRpIZXMCjFKE7uhm8pJLa+d+iQ9I2s8BJvD6nfIBGv+AedudDmgo02XHkQCJeCQwcATr09qig6IHEmfDjijbNA6yxSuMjwE/j90wZbkqm4zk3q1OJj7kfT4TFzrUVZUDpyKcIxTjfM+aG6uPChrMm7ZfiWuay7IX9InSZHbaHfYZEHXY8tZ2XQfiP4lRLU0MfRySP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 22:44:01.9053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb1238d-3e97-4e59-efe1-08df3c577438
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE941.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9251
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add gmc v13_0 ip block

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 351a1e61f525e..cd5e447d78e15 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -61,6 +61,7 @@
 #include "gmc_v10_0.h"
 #include "gmc_v11_0.h"
 #include "gmc_v12_0.h"
+#include "gmc_v13_0.h"
 #include "gfxhub_v2_0.h"
 #include "mmhub_v2_0.h"
 #include "nbio_v2_3.h"
@@ -2800,6 +2801,9 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(12, 1, 0):
 		amdgpu_device_ip_block_add(adev, &gmc_v12_0_ip_block);
 		break;
+	case IP_VERSION(13, 0, 1):
+		amdgpu_device_ip_block_add(adev, &gmc_v13_0_ip_block);
+		break;
 	default:
 		dev_err(adev->dev, "Failed to add gmc ip block(GC_HWIP:0x%x)\n",
 			amdgpu_ip_version(adev, GC_HWIP, 0));
-- 
2.56.0

