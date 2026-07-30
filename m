Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF249C55160
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 17:03:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4926110E0E7;
	Thu, 30 Jul 2026 17:03:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j4Sai6gJ";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 753F410E0E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 17:02:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsHW3iUKsrhxMeYUQAymc8DgBDvX/NaEDRFmrgD9FAtEVuzv7FrotJZ2+jxYUrl9DdEL27YIIYsJunN7iJUQdOEDfX5fZd+e/QH69RaNwcjzLAtGviE7IB5br5Hnp6XR7NiuDVN8S3GcXBGY3X5j8Yzh+KOOmn/xSpzx/wv78QO4dlDb550h0govY0eGoKjHalwi8cTkCaePOB8ZlixzHqUyAzaELG7gEJ+7SLdrNxC647XaeBBRoP24SGDcmwvF8COgL6fQV98TwbWMjlpmY3/0UeBsgYpZmh9nXTvgIC3RmHBifVmJjxxXAf6ct3HHRDYnRZPiwh+3nPxvQjJH+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzMLbD2UBG9KL/AptoLlr6hOYUzgzhnE517C1rDn1sA=;
 b=ewoLzzzC+3GTJ8GBoXYPMDlR53TAOXoWQZf8Vefu1QVZuZzrqsUEUTEeLY/sK6lJwYvUXaJxaGquzxBq+HQQYm7ax2FC0ZKPNnvPCjVdaZaf98G3ojOhdfimcqQzsODL2bJpeP6mMq/HEk1ukFs2R0rpqf45CFWOY+IT6hL1uLNe9i7YwdbyaIJs/ZvfC7UwJUEjTYzV5+W3R30SG99IApp4YxdEA/7TuTkNz2Bk81w020EDwmiKNHJB8DITehSwvR4cSoTvzAa1pmY0CJ9OC15L95y7tL7t80RTkN7DVzh3fP9o9ElHcY4P8KOnCpNYmsDIAZaIKTREbuLh5FIzyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzMLbD2UBG9KL/AptoLlr6hOYUzgzhnE517C1rDn1sA=;
 b=j4Sai6gJK/PsfZhxv+SV/2wv23tHJNsEcB1VXY2ivTZOC0vMxuKE940i0QEeOwmPdhAM8bjA0ttXffDG2N9tW9buTUk4kxLqS3A0CbQgPC6BxV+f8HlrOWZ1eqmLZoD7J/3SgxGmQxa0CWnSdPUMDdyo/NDMdSKxPUWldXrduWc=
Received: from SJ0PR03CA0117.namprd03.prod.outlook.com (2603:10b6:a03:333::32)
 by CY5PR12MB6371.namprd12.prod.outlook.com (2603:10b6:930:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 17:02:54 +0000
Received: from CO1PEPF00012E62.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::a0) by SJ0PR03CA0117.outlook.office365.com
 (2603:10b6:a03:333::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Thu,
 30 Jul 2026 17:02:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E62.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 17:02:53 +0000
Received: from work.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 12:02:52 -0500
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Reject UVD message with dimensions above 4096
Date: Thu, 30 Jul 2026 19:02:28 +0200
Message-ID: <20260730170230.11930-2-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E62:EE_|CY5PR12MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f0a2eba-99b2-4655-79ef-08deee5c653f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: XGsjSRVKmz8GHBRAG5YdWWIRlKzKDBsWgHLSEOXHIGX5uui0z8AYdanvRzncG9UvlAsrmazS5CJnbRy7gPqC6ljn+4fqHc2bKS/u8lsyHGHap64bFhXF33Ce9bg30eVcMLwx+FspRYy2Z8tP75wktQpB0JonEknd6LpZ2qkBZbtl4pu5g8KcuS8OlBIunYW9OZO7W9E+nuhQeXhPmKspUEUj6OA68vKCdSXUzkoNuCOIYm7BQfYtRBvDdXyyBVMN+cdIPseGqMjcWfDMLFKD4/xBolhwO3mgMYCGdJugnfWN30lHPGZIH8gZkVnFgLQizDBmGx/dTYKpUrjy+lxa5sNYwWGx9BTXxhVxGjyDSVY/ebIYaauAnpqC5xy73dNg+laMA4Z/x8eoKW0NgcanTgvxkJHE0I64OOFNzOHjxY+X6vQP/17I47EdPcg3C/fzS8LbDA0rokAOwKu5VyrQFqsS6PmD4TFo2PJxTKCLUMIRVGPRmtOHZafKMa6QpDVXDCxs6aeCHan6WlmonNri3JZueYNKi/8Ls4L4cl0fV+aAiqqZYCpP/Ub1RBWh2mtKVHXkNOVdMnzoEN6i4iuM7bCnBZeTgbUeLyL14LKLbFbWWwOE0TghLV/Vnqh/mj3Yc7VoUZdNhZB9ofEjrAw4gfVjnXc5RWYIVlulldu09LlD5II3+396gyPCoidPgFdRO8yOkzAgvlwZlGshk6ldeQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a58iqTiBBy48+Yc4/IC2RI3v+Al29xZAMInt9ZICxhpXlQ1j8VKazlgt2cILEzwtpgs1yb+b8r+z3iDVWBHB8J2Kpoo25NG7GdWHdRYqSw1cuWFxOPzae7Rik49RhDlo3314/kE2KT6BzqceeMOEQOOyjch/Gu5dcbfSzIvi7TB9SgEhSCTrLY2DCaBGcPCUjrbBkIzotCyxc9h4rF3ALAPjk5//v/IHZ7OJXdmOq2C0FcIf/tz3weNyW+Go05wTlw7bc/YTboF325raj0JbhiNDtSkL1nL4KgwsWFWMKVQ4YqCb+Pyqopst8oVzP5blCUNw4CNza5Ncdv0NJ8XywdXSpraBAVPfRwoMxgjJyijrzhbricA/DOKkFxqCSCR/kl/cdahYjbDFvwVu2snvmNYmjqwBXOrP0iMaOzBmj5eROJh8ZEX/AV272UdNwdxM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 17:02:53.5492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0a2eba-99b2-4655-79ef-08deee5c653f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E62.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6371
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

Fixes potential overflow in DPB size calculations.

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index e8b0c62f72be..63561d1d7963 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -655,8 +655,8 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
 	unsigned int image_size, tmp, min_dpb_size, num_dpb_buffer;
 	unsigned int min_ctx_size = ~0;
 
-	/* Reject invalid dimensions to prevent division by zero */
-	if (width < 16 || height < 16) {
+	/* Reject invalid dimensions */
+	if (width < 16 || height < 16 || width > 4096 || height > 4096) {
 		dev_WARN_ONCE(adev->dev, 1,
 			      "Invalid UVD decoding dimensions (%dx%d)!\n",
 			      width, height);
-- 
2.43.0

