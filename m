Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94785E7716E
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2024 17:36:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46A2210E5B5;
	Thu,  5 Dec 2024 17:36:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S3h3YRj3";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7156D10E5BF
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2024 17:36:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6ujc3QZ3qNZYWWq+HpZZymXRpkqKyFqTpbOBNyE56c+WweMEHksdct1UjA+vBGLZg8o57MzW4iVmIhEGOOcAUSoEp4ALuWzel3gRPgjCtXhxTra6KjSd1BKRoCE9adtg+dh4X5EhZ/NHJDJ3v+0VKXZzVQSVXGpUr8B1MA0owRBxIrf7YJvWqahMrmdPHONdPx+Oj4FCN7eJbpkCWNW7aRyMhg+kXDqHfCwp5pqAERPGNzuJ2gf+O6WNb67078diGKqDqEBvUn1RzWJ+BSsqO6sBN+XvumULj359BFtGQK16+EIjCDb1GqffNlC21pdMYkMy72bfzTaa3VtNGl/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYHfBpBvSpQyw/9SiU4MPDW8D5pqcm2Rs/CcmumNtOI=;
 b=xBgXqBjbL5mfBl8f4VhlQR6nfQVrGF7RQpO4hRxK8gsVtQz9ebzItaFsH9o8/bHUOCi+VKyulhdyDVp7fC+6cm/D0sBIg8nFG5OlLjTj2S0Kn255pOlVDsflK6rOJaFN/srBUfqKWOyJYZvsJI6JgaDAydwmvzs7laWiklboyQbeU+DIuBjMSl1W+KKxbgK5UUnD6Q3yIHjrvta9OJp6nhkSXfaTStihM5nFgJCCczjJjVIWIOKY3UMgUbnMu2Vu7CJQ8N5UxcJL/8/u4+SLM0Ay49nL0DE9AauP57pDlf1mvgmH2sdO944q1wYDCCDzjSSWStknLmI2aPzcdYTE4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYHfBpBvSpQyw/9SiU4MPDW8D5pqcm2Rs/CcmumNtOI=;
 b=S3h3YRj3KsG/qrwis8i9c+pZPf98SJRjiM7XebDKKlW2QvGdt1TTEkwa5J/7kLze5LTlW0W/PVOku62Fpqk7++T8HP5gf7yqm+zI3ARFvelBGYlEa/fpA74cw/rBXph0O/PPC/0eDyzVV2/w6LWuicuTN9Ei/mR4aVFua0oFW04=
Received: from BN9PR03CA0454.namprd03.prod.outlook.com (2603:10b6:408:139::9)
 by SA1PR12MB6824.namprd12.prod.outlook.com (2603:10b6:806:25f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 5 Dec
 2024 17:36:30 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:139:cafe::73) by BN9PR03CA0454.outlook.office365.com
 (2603:10b6:408:139::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Thu,
 5 Dec 2024 17:36:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 17:36:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 11:36:28 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sathishkumar S <sathishkumar.sundararaju@amd.com>, Sonny Jiang
 <sonny.jiang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/10] drm/amdgpu: enable JPEG5_0_1 ip block
Date: Thu, 5 Dec 2024 12:36:08 -0500
Message-ID: <20241205173610.334358-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205173610.334358-1-alexander.deucher@amd.com>
References: <20241205173610.334358-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|SA1PR12MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e33ec1-ed0b-454f-74a8-08dd15535a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C5APBhXC2xhJcV79vU7fulmNN3EFw5KyBO+S1uUypPkf1+s3pFHZ6/rle1AK?=
 =?us-ascii?Q?DAjJ90R4Ts5SgFMnlt8f9Csrc7WNnmfG+Hk0mvcWhT9OMFDxJAer4NetqY7v?=
 =?us-ascii?Q?3myv6LJvdZsboiBGbWz7XKV8rVDDwahBBFxQbbDuV62dN74IMTjf3mrp5wTT?=
 =?us-ascii?Q?qN8hhxCGjN3TQfSU+OT/NLjWypQYjx81hWNqOy3K66aon9J7KrQ7JU68aecu?=
 =?us-ascii?Q?OLdsrr2Dtfpt/7jfKXH6OZ+Z9YCSnhVXyperELNbD+t9MThFD7P2J6go7yU2?=
 =?us-ascii?Q?/IcXKW5els4HF8/yRaJXYsbt6CvM/NahvD1yvvYGAv4B4mDU4U1PYxSB1rDt?=
 =?us-ascii?Q?vlBRvoI6zBwvB1nvGkOhpsBXBhQn0UdgW/mJ3iPg31s6+oHsXC/FSb4cxtZZ?=
 =?us-ascii?Q?LsfVff33ftJxCjJTqSd/y9tF9qQzTq+e4ay7RmmK++waHqNe3Mi5UC082xjl?=
 =?us-ascii?Q?JFvdleyqtEiI41wTHQlRM5e+6EPkvWSVBBGDdGdivdfkE6V25dcBCtJFt5H8?=
 =?us-ascii?Q?p4PEss01wlmazM+qu6HegAMlRMXAJxdJ3WAb5bhdBlv208WQmwqTiaBmifu1?=
 =?us-ascii?Q?ud73R85iOG/28R0iUdRzylymptGcGW5iHm/W1hFschocH7Nc6jlazjhNA1xl?=
 =?us-ascii?Q?/XEfLlN/85LwX7HhVv6aq5JZprfQwFQez8BYgvfxp9i4GzsX8SQS1WlQXoLa?=
 =?us-ascii?Q?kmoobCfFxGqgWinWLNSB/DAvkvH/gQVkysLTCvb3s8us4qumWLtSi6jqYKC8?=
 =?us-ascii?Q?b8fcdtUXUNjhNo461D2czwUlaKcYAPtdRQEeO1AKazV/d8vSwebfSbg8/0BO?=
 =?us-ascii?Q?ANsoNrQ7ubLRvX/v6ExPIZwV+y2ZmC+wo/f2r+1hnGIdJC1uoEPc5c70Wxt5?=
 =?us-ascii?Q?5rpvZ+CILhBNQSJkmeAaC+0qo3S2G029QazIzs6s5ZlGPmQA3JFN5Oqi9s7a?=
 =?us-ascii?Q?uWFUf6YiI5mBy5IG01oTfrTCfYrIvoQSO4z6ZNK0leV2Wpxle6OPpx6YP7Ne?=
 =?us-ascii?Q?N66WC+baBPMMVRRgOeNWMx2X7pVYmyUvQafyq5R3WBtsK8EK8Wf7NlAOe8yC?=
 =?us-ascii?Q?kXuj21gegTAWwmqg7tgloOqZuN6GUIJS3mC6x3DbHJUMOHAQJD3dkkcRF5eY?=
 =?us-ascii?Q?ClesO+VGkN54d1m3gJBqnL7bWqomuIiXXymfrw/Ovc7OMqwQU/H3Xq+ZCeNW?=
 =?us-ascii?Q?yZBQ5cRkGjXZ7zpYTDhYOmSVbj0wc6m3DA6aB+4AmwI/DecvcX4YRuYxnmaP?=
 =?us-ascii?Q?9ktj0MQBFFa7TWSFj0c9nG5qULNFbek2ypf6UCMJW987rflKvOYvB9ZziNT+?=
 =?us-ascii?Q?lPgx107q1c/QuOTLta8NMrIOcdaCJiLvw2vobap9w2pwxrIbVC5S+MfEC7o9?=
 =?us-ascii?Q?uCLTSx2/8PUb9MPm4LodOoXYkAZkfyX8bZmo0TVzgjzLIOkwyrZMrui//QIy?=
 =?us-ascii?Q?H9oByFpPjPPvwCmIRzwed9MEO6GY74Y4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 17:36:29.7741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e33ec1-ed0b-454f-74a8-08dd15535a53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6824
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

From: Sathishkumar S <sathishkumar.sundararaju@amd.com>

enable JPEG5_0_1 ip block

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Reviewed-by: Sonny Jiang <sonny.jiang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 37a55f6434828..60c36cc4adb12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -105,6 +105,7 @@
 #include "smuio_v14_0_2.h"
 #include "vcn_v5_0_0.h"
 #include "jpeg_v5_0_0.h"
+#include "jpeg_v5_0_1.h"
 
 #include "amdgpu_vpe.h"
 #if defined(CONFIG_DRM_AMD_ISP)
@@ -2366,6 +2367,9 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &vcn_v5_0_0_ip_block);
 			amdgpu_device_ip_block_add(adev, &jpeg_v5_0_0_ip_block);
 			break;
+		case IP_VERSION(5, 0, 1):
+			amdgpu_device_ip_block_add(adev, &jpeg_v5_0_1_ip_block);
+			break;
 		default:
 			dev_err(adev->dev,
 				"Failed to add vcn/jpeg ip block(UVD_HWIP:0x%x)\n",
-- 
2.47.0

