Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E691C982FC
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 20:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F221710EAB1;
	Mon, 21 Sep 2026 20:11:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UrZ9/RY4";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010070.outbound.protection.outlook.com [52.101.61.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E10A10EAB1
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 20:11:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGsZvxgToIvhmebi7f8Wplcb4+LM6i7Qr32HPIBO8aZ4pRKmPhQYkPd4UVtwwUv3VMbDdQLZBscdablM+3qjAjtiiXzdi9PxRQfTS9SBDRouQ8vDGyVesZfbC94H71yb5yoIXmZPHbB9riiETtN3OIZmFuM9I3wu4xVTEBO1QN82/bCm31P73ZhGCqyhrut+XGLMa/CQkwnc/ShlN0vKi6XeRV2zUux9z1cBM9HOnH7j+uJmeG0pj6Z+v6Td3Fy+CTSYu5IEcv+9XgQMbTExReTp62RK5ltl01NqMaRVd/STK5aDjZLX5CaW44b3Xh99JJhgaxeOaJ441LMRgXWJQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tebShJYISzWJse5RG9/rhw/YtFgaWQO+bhMzxrYAsuw=;
 b=uLpOJtJWDLrPK+2sS7jaESSL91PdUJAm30s6uegJpqDpCtOLiWR267sFk7aVxvXM9nySnPmMto7daRJCmwbwgSyuB4g90lBNy0JTudQNkcLP3yVWotXKpZST3R7RO7bjwmMNistEIYCQ2b7ko326IOQPTZKSBFmz97y5NE29Bk9/44YGieeRJVMKFefYaifLP7eeYQ9Qgg0THNJGVf203Q29GGIizI0+P5Fc/IxLYNKZQtM0NvmCdzqSPGUAdzuipadYPluKjuhc6XA4U0aXiHbruhfIDcMlqSZXNeNRRCiRqBtDLFHxg/e2zfe7B4TR/GOupK0laAFC11hAu7nw4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tebShJYISzWJse5RG9/rhw/YtFgaWQO+bhMzxrYAsuw=;
 b=UrZ9/RY4Dgnb8gVE3/0RGHQSoNxomQBJcNprbTYb9KUpwyL+kF1fhTJO2g6EpkraD2HgV9gmDpmmsurnyAkgwbFrSaWEnilow0EIr6s5RQsnuLAOpO7txwBpShmzXZ7VZZvLhqN+w8cUAcDUa0V13LRlqf+Mz+jyonPVlnP/7/g=
Received: from BN9PR03CA0094.namprd03.prod.outlook.com (2603:10b6:408:fd::9)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Mon, 21 Sep
 2026 20:10:40 +0000
Received: from BN3PEPF00022BD4.namprd03.prod.outlook.com
 (2603:10b6:408:fd:cafe::75) by BN9PR03CA0094.outlook.office365.com
 (2603:10b6:408:fd::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Mon,
 21 Sep 2026 20:10:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BD4.mail.protection.outlook.com (10.167.248.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 20:10:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:10:39 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:10:38 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 15:10:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Frank Min <Frank.Min@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add GDDR7 vram name
Date: Mon, 21 Sep 2026 16:10:20 -0400
Message-ID: <20260921201026.2019083-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD4:EE_|PH7PR12MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e1a88df-cf27-4588-baa8-08df181c6840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: fyZoIsgS+z08ZcYnnIoYp0ZjPzwpeqwMYaRljKf8XQPvDJTE/LhMZCK2s/Siy0/ZRpEICLV+zvXVErBl23psExsNLEOsDaseKhd9XfWQG3vEamQl6Pgj5Tz6OEqH1aj1jyrclxW2fyBJXIn8B6/KZDvz+YCBjJt/14JQ94uQQqjdjuNF4PbNVvk97DdjNDpLR9R6kpmU1+wzi//ruKAmCxbUI8CvObRKP3cODMd3QCJPYNb51stX7w/Vi3ivDhl6QhuVy0oDvGZZSje7yXhJd6zrXIncRUzK0qEsKQ4Oene/numzX2h7zTjAZpdXg8HTW6n8eIdun8UlWBK+/8wRABAcQN8zQNhg5OfDEfVFve2hbEgHC2+lUxsx/+hXDROV4zfAYDUY18JO2VEu88AXFvDMYPOfhMWNhk9qQ8PnhzyLQRocr3KQsbbNZuztvbYmFUKQYqhjL6yarbyLjJyWf/D5W442QXCv/3fgOe3wnVyMRbulNVk2Hq1MWZ4V3oqsLqplfzklyg1oxeNf6JPwKzhdD9Aa19/62Va/HnzUYs9KxGbTFJPavWu/u6quiximJoEDuIMeWVkAKTV+IivOiw/g6oPt9zSbyzY6ZzSlPUmmCDKb7Wu61fC1v/TqfiVJTnv8hVPx4w7qU58bZj86+9dfeIIqrVHxMWiMtUnQ7HyYJy6SrtVF/lgi6loCfvQ0Z95V+8hjjY1iSGDlnkQD9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a1w9ZWLdmsGU/NK70SOo0a/7sUsCXPzN2nguiixbhji0VZC/R4hmGksHQNSRJTRU5nzCtluKJCVrb3R9XVE+lL34waThs+INmrGFfhKddi4rG/aJfOVOFfFGuYCh/hsOaXKZI5/FRwoH/zMhiFgpqtHgyn/076JY0St1IkWN2nV79z5it1BAnpJuu7AKQlwINxPEPr2HOZVElifCtPgQaZaZwoPkY8skJT9Qe4GTOG+3saeXN3myOk2CKL920j5i7eKyQHUgMTK9jG1KHQpGlUt0E49mZeavldwWiUh4CjYsuD3/xuoSMoKr3TXkUFbaSQS2tfJK5kzM2aVcjMFJ40s9Vpi8ta70uCL58NG62TIjKvEK9vfJm5LNAfoul6ScQZFPy9hl5DKYMrgoCyHU+SwDsDVZlkfA4bg/pM3u/2Zd2tQzqOcm6VYwv2diIJme
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 20:10:39.6693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1a88df-cf27-4588-baa8-08df181c6840
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793
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

From: Frank Min <Frank.Min@amd.com>

Add GDDR7 vram name.

Signed-off-by: Frank Min <Frank.Min@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index d6d84ff110a0f..2a6a5bc01eb40 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1060,7 +1060,8 @@ static const char * const amdgpu_vram_names[] = {
 	"LPDDR4",
 	"LPDDR5",
 	"HBM3E",
-	"HBM4"
+	"HBM4",
+	"GDDR7"
 };
 
 /**
-- 
2.55.0

