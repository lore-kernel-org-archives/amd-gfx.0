Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11541067030
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 14:11:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FBD010EA1D;
	Thu, 12 Mar 2026 14:11:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y3FZ5zPK";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011040.outbound.protection.outlook.com [52.101.57.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA9C610EA1D
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 14:11:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c34EhcKjz09U546apC15U1svkIy01+Lig/mQaqJu6fs7wiaINSBDbqsUusDblyaHq1PCCg6dgJRDdoJs4HmyhUpDBpJyud3NyfBxUX8D/+v32ePAMUknqeBrpj/Dm6qHlVkmMr5j1SIlHPpYeuXsGN42JoMRaK8KjkYH2ZJQpIQPTHJFuCbmO/3IFe6r57Eh8Okg7GI+3PxglTNaRN8m862/8EuwNrfp0Q2dXz9E9Zbr0zS2G5tnj1Vk6k6FEt8kQ7N0j5BvwpnFT/qPb48cOG1afE+W3J2vawsXo8QxW4sXc+rYo0BoCFoD5d9xGAO3gsny/m8t+Pddo4jHhEEoIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WeinCYAsYGq5mug6l8XcCurPDwpCyKkXMwyvh4GoBlU=;
 b=BpNj1s+Pdc21KEVOXDDLIJdFVOpeWTa68lDrph0Plaze/w+tu+i4wEXT1FPdxwDmExqD03H/V8EC7dZEfuLqNog4KiasQMdj0J6GSVGB4d0I8Mb2kiPiKMhCuqfafMnnV2YNQ23Kn5gqyA7Mat19erLTypcNqJ2FuHKvG54WGsSpeBl2ndS2E/JS9ReWtqjQhtBIDfy4yIwPF+iTExp70YxPa6Q93A27rKSSl7Pg13dnP1tivIjivn5EuKkI9Ee3Jv3mkIhLOZd/1U1cgDq32e6S6fsvVHSTRJsKCOCVTqKZXflAIZG2CT5aFJgOSbzmKsxFRLkYHpAI+rH7EF7VHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WeinCYAsYGq5mug6l8XcCurPDwpCyKkXMwyvh4GoBlU=;
 b=Y3FZ5zPK28MMueoPC9tBfaqm6y8SKjBvcJ0N4cIbLozVPviZUuIlibr38/CZGTK55IexQCXBrjkJjnGmZqxeJ9JMEXGTlJh73cdlEHexHHJsflKYGyI1BaAe/QfCDNaf2sa2YTt4NJEanUekigGV7YR66FgFQv8nEToBsSz3VaA=
Received: from CH0PR03CA0082.namprd03.prod.outlook.com (2603:10b6:610:cc::27)
 by LV8PR12MB9641.namprd12.prod.outlook.com (2603:10b6:408:295::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 14:11:20 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::10) by CH0PR03CA0082.outlook.office365.com
 (2603:10b6:610:cc::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.28 via Frontend Transport; Thu,
 12 Mar 2026 14:11:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 14:11:20 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 09:11:12 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 12 Mar 2026 07:03:39 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH] drm/amdgpu: Reject unknown digital connector IDs in DVI mode
 validation
Date: Thu, 12 Mar 2026 19:33:31 +0530
Message-ID: <20260312140331.1850721-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|LV8PR12MB9641:EE_
X-MS-Office365-Filtering-Correlation-Id: 46109316-e5cb-44fe-c34d-08de80413c11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: dOTB2yaylUyz/dpOmarNS5WxYy1/IwSnXi706/8Bx/zPKb1K7Yrf3iGJIuIeIacsdBMURlvBBDO67cBQCyiQz7CHwn8Bg+Ifm8HTS2rCOX/Ks3LDzNA0B9uIKsDS9rDkrMXHi4oiz7O364Bj3hQ2RqZv02XowcGzs2Ln7fV9bveI64rp9/Sv8U1lTnrce9kQMltj9IP1bCcUb9x6LVZzieQA0QI/4Q8gp3lR2QwQa67GZI9NrccPGVUfFwn4hU32VAkjuOAI6asuhpKqFeEg+Zn8Msvz+8BptY3JC62/xHdJ43CnTsEwMB9Avm1YyqbYcCxM025i2vANA09ch0J30TIDCH+0LvgrH2U3t3INlXVEZZJyg28BU0OVmG76r1n3y8S8kYpXag3IOvnJKUc46zIb9KUUveyVxiY0EmNEg10D0PgtXYaClz2631vCDVcR6M5tVU9tZ2k0hCUUnKPoLUMF+xREhsEodBJEMiLJo1wCT7EQ/QySIDo4cMFQuv9bOdIW41IbLJnOifN3waUFipld2HbUEFML+UO3XjAQXbpaDdpo/JPr0b1V7NyThY9Kr6P1qMUPO3Uf2MFkni5Slj9ggJdd06EPXVfcVkRIAT2ncG+yrI5+hFJZ00tU4mahWTCYOQOhjMANyc2XHHIaVvHHjjRKTX/a/MfqYvOEDJQdTmp1Au7KGO0GvkIaJBG5du1o89fimwI4jVpMK+JjjRplbiHgKFavSZUhDTMA906cqW9/z6w4uCHkjrADnouMM3UC0+w5q5Af2fvo5jJB6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fALOz/QDtD20wu1hv1Ew2D7j/4OL1dcp5bF9Ir1TEw93GiDjBvPbeFRyW58eG/xNPs/jNDF5AyL0F67rMHf8ESDbPiv90lUIYfOC5iF668AMR6X0O0q/5onTXmFYCSIczhpua2eaxIKD572M7D3AlgGYEJPwdY2QtBgidgHAbyy0R4fpfMHAra4fSL8WHU0eASajLooKoZiru99BoaF6iPltcWXmXCfAZz1QnwqV1jEE1Ooc59yvkYGhp7ES88BhZ7wy4eZJjQ0inYkXI4t1As04xdDs6GE6sUIlWuej+kjUEHF4GChqncwWKpyfg3Po3fV8PJnrThNc4Xh4lhouzpSaokamefdVblIwSEsbPwVs1OR12UUt4lw3HuJWmtDegD62gMWRw0Cqtu9Vh+8qCZ1oyDLWAyi5NtAfSYHePG45G93z5VqtGXGHPkR9Oqu3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 14:11:20.1597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46109316-e5cb-44fe-c34d-08de80413c11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9641
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

amdgpu_connector_dvi_mode_valid() assigns max_digital_pixel_clock_khz
from a switch on connector_object_id, but the switch has no default
case.

Simply initializing the variable would silence the warning, but it would
also hide an unexpected connector_object_id and continue mode validation
with an arbitrary fallback limit. That makes the code less explicit and
can mask invalid hardware or BIOS data.

Handle this by rejecting unknown digital connector IDs with MODE_BAD.
This keeps the behavior explicit, avoids using an uninitialized value,
and preserves the intended validation logic for known connector types.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c:1243 amdgpu_connector_dvi_mode_valid() error: uninitialized symbol 'max_digital_pixel_clock_khz'.

Fixes: 585b2f685c56 ("drm/amdgpu: Respect max pixel clock for HDMI and DVI-D (v2)")
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 04842e3f1ccc..a8ccc1602eb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -1231,6 +1231,8 @@ static enum drm_mode_status amdgpu_connector_dvi_mode_valid(struct drm_connector
 		case CONNECTOR_OBJECT_ID_HDMI_TYPE_B:
 			max_digital_pixel_clock_khz = max_dvi_single_link_pixel_clock * 2;
 			break;
+		default:
+			return MODE_BAD;
 		}
 
 		/* When the display EDID claims that it's an HDMI display,
-- 
2.34.1

