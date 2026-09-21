Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F40C982FA
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 20:26:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 726CB10E4F2;
	Mon, 21 Sep 2026 20:26:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Evh0XzFa";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010070.outbound.protection.outlook.com
 [40.93.198.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B49C10E453
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 20:26:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKdYx/SCWxDIIgu7TjbFYMhBVZ6GHmIpqSrDM3Gj3NDO38rQbK4daJ1VUrUBgSxsjqlpsYOQxa/VaGNegE+Gce5Md76JZ9RngDSW5S7jVuCfUH5JCN6blUWA850i4QY0fr/othztR9D3nTPl/AfF0VT8ZrYEp5RtPGMKHSJ+uc2mHuehJLWRMxVzpprnl3kfDuXkSQ9x2TExNU7cU7uTCkOk8JyhTMidvuxrrIdhivNJbp7HpGlBcuAaZZInWcf77JQDziJWhfyDBS1d/dHQv+sVp1dITsnruMf92WPfnWKRmXILcuaHK2AflIe0KNXO2xs3FzQY3M3tlEzhe+vhiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvusIvc4awSRMXL9Nx1Dcdlg9Xavn/XH/8CeGaU2zYM=;
 b=FqEeWUrOd2WFy32hVZ9sDwFryCHIIlcFCHkY/lDDPn+SMl9Cy7QCAiQJ7ipQAX9rdOKBOBHbgxcuNS7Iw7P5b3OjEpenh4fAqrf6L8bSp3VrkBRUHE1SZiQnG/p8OipJdjSICkyuFkjOztwO8pWoFkKWnni1QgdljMtbzcVrnow8SyAxmjb8hCfAfW5vXsYqJOZwUfdR5Td+It+D04OkcGEfQRIYJP6fZgg3OggwLrMiGFpBw0pP6VY1NE2nHLUc3hSxj5+2bAECgn2S1pWIkdVT3YGcI3eSpL4TfHWs/YveBEWg+5jNWg9+UZkp9kdWrpMOO48hHMEA8k2GuSEk3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvusIvc4awSRMXL9Nx1Dcdlg9Xavn/XH/8CeGaU2zYM=;
 b=Evh0XzFabhG7Sp0tQhxdTqlzCt76QBXCcOjl1mybYNSHBTwlMXJUMxqRuKyWbEjtm9/elJEpm+qZmx4Hg+Er1X7UUx6mt2294CsYGf50hEMRpa3z7NsTzjgiNLNphcCuOwO0kOi81NK1BUjrB2vJQ38hFBrLbvjsYD64268tglg=
Received: from PH7P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::18)
 by CHAPR12MB999247.namprd12.prod.outlook.com (2603:10b6:610:2ff::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:26:45 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:510:32a:cafe::15) by PH7P221CA0010.outlook.office365.com
 (2603:10b6:510:32a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 20:26:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 20:26:45 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:26:37 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 15:26:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Frank Min <Frank.Min@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/discovery: Add ih v8_0 ip block
Date: Mon, 21 Sep 2026 16:26:27 -0400
Message-ID: <20260921202627.2038382-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921202627.2038382-1-alexander.deucher@amd.com>
References: <20260921202627.2038382-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|CHAPR12MB999247:EE_
X-MS-Office365-Filtering-Correlation-Id: 67cac1d0-64d8-4f23-2675-08df181ea7b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: M5WsC4eTKY1XsorJmA6nD6Ca8wTUl5TOVDdUqjZoePYSTL8W0r9QCbFHB1KUlyNqKcz7rNiKp57MmuyWrmFYyVNowt4MXlt/cinEsDE04n3T8abVb1i+CPQ3VRJvsNJkr8eJ6lPRmgZKcBkexSbfB8Cqys+UzKqvQrO+rBXB5XcssNmmBtG0nEHSpB8Bv6pH24w8U2ZUhLBf26OboLKqe144cFPAEAGcAB4JqMa16POAkAfi0jJxP4MCeeDBVZ5a/roIUPQSZz5h7VAb0tNFHvrN/D1c8micptCkp5xFRR/HOx1VVJrpAsRoscwZZil1Ez11M+S1Hk8erFAn+RqE5GNseblikWF2TQ+whKo6tAfcOW6A8km6M1kRAuyoZQsa0P+gT0WbQ3sFrpL7CrfYkPbLYjgUXVZmezYcflaUzwAvJlPkmQfMfWAv1udRBcaAQawHtS86ZHOVz8BgxvwUySdg/QxBi1xE3AMI8hkEw3UfwkK4ZgFtsRV8B2asseW5eDkjNcHtiCM2Pxp1D4pHNXHUsGF1JbRflFFHdAqOrqtlMnFtV1dk+JHJk5E0RHLNakKBWp0EO8tJgnx/tjG8vdQ5UpVuTj7u4Hf1QeiRjrcVepZ7x7UDePlEafXpYnfi1Vemr7Ye0uT0mH/flco+HgF/ElnwxrElK9pLFXM7WxONoB8nCisJmJL9VeVJ77Er6O1vAt2Rz/ROlIp83teezg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ehmxOPXvVx7UWoy7m1doKM8LWpsTzt+OAHwDjzk1vhjOVJ59RFYK9NG7/Gus9/4TTzTke5Z88fmZntD4Lzd8oJY3HIMMeARSSbBfcWmKyz3IZV8wr8sq3dIZlC56iPupe19FWDeI5KwAyrQiFjWyv+MpTznNYJo7Me1OtJxVlyMOCq3g2BMLpCZR5jRXaSbmjb4G2e3vv/ofEZOyMaoakyjI18LKpOKbPghwSdP/Ki6eTGVn+mRC4T0nOBdk167aFWFFFgaYEJxljR7LDzsD4/agsYsOSSCToKMoKFal7rldgP3tX7CKqLoTwO+wD1EWrBPaGpVM+AtkDrx3qxQYNvysF7qePd+c2AaoYewlSpm6ZCAuapC/XeQiImZWGPBRrj9E4Qh2Ovlx2z5okY0CwFftvE2ydY+ct4xdLrMW0hZjDaBN2Uvq8jvZQEoa5LNK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 20:26:45.0040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67cac1d0-64d8-4f23-2675-08df181ea7b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999247
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

Add ih v8_0 ip block

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 366588c2642d1..4eb852f2a3824 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -80,6 +80,7 @@
 #include "ih_v6_0.h"
 #include "ih_v6_1.h"
 #include "ih_v7_0.h"
+#include "ih_v8_0.h"
 #include "gfx_v10_0.h"
 #include "gfx_v11_0.h"
 #include "gfx_v12_0.h"
@@ -2772,6 +2773,9 @@ static int amdgpu_discovery_set_ih_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(7, 1, 0):
 		amdgpu_device_ip_block_add(adev, &ih_v7_0_ip_block);
 		break;
+	case IP_VERSION(8, 0, 1):
+		amdgpu_device_ip_block_add(adev, &ih_v8_0_ip_block);
+		break;
 	default:
 		dev_err(adev->dev,
 			"Failed to add ih ip block(OSSSYS_HWIP:0x%x)\n",
-- 
2.55.0

