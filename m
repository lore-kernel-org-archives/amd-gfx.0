Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF331C5DF8E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:52:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4118110F444;
	Fri, 21 Aug 2026 19:52:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cz1apq6w";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010066.outbound.protection.outlook.com
 [52.101.193.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5120410F43B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:52:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3Ir4jkzioiTZgxT6tzfXM+jZOhlh6YgdAqThOhsSnhBDfERdV958MJ403oYOlwOJQESXXlUNyqPx1DmneIBy+vfmpgklvcYiG/t2LIYpv+UKZybsnMYvtBJUKgCdSfuPpUqBMXeEdWH9y1e8YwjFQ3ciZlPbMHTTyB5SeSA+dYtrOgkEM3wn/eVeBpxUp/NmCeW79G49BqSXJ23UobBiyDNPeGuX6/HjseoR9REZdStPbtzytjIULUZu568kz3WCR4SRedRz17wZWBXOKygkIoskCfjIJJUMQa25LtYs1swiq5MFM1KXCqWAABNgZLGu6FpA4TvLeOB/FW4H29eBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQ82I2jG7bib0VUJdvzYdgig9/FpEAiZA0W+TPtKebI=;
 b=fi+SPRlvLY8SiE6E3gKsHiEl22bN5A58BGb6I/ic19k8PYOtDNrH1WC6QL9fmygCJhCPtvD0nzkwPGvUozg1dNTd1HggV98ALvj41cC7i5ITJxOzDrjME5EpJ/jao3I566XJKa3AOLQ1wkocclkPl2pV11nNGsHa3H2qtOmlZAXPJvubGte4jm7UqZk3Xo5sCkZKsGeFhkzspLdBwVlClThChvw6EGA5qJzBKLNVmBZBxkQcYY7VfQ0sroMn6gCD0CtTjb1EsTHbpvbUM4uZbGARwOU9AjdWn+KIBP5YDJoOGBS0ctJlxkoEb9kZ/UjEsf/SgtIwKjIKaQmfdeeXvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ82I2jG7bib0VUJdvzYdgig9/FpEAiZA0W+TPtKebI=;
 b=cz1apq6wSuRJY4mttRjVBKseZQ57R79Nz+nQYoqgGhwAPBX9hX8BYc9y5cEvpd9PFc8HwYROD4iCwJ5+E4Y0XyTonBcXCzqIUWhsZ/N7h8UW4gEIkXC+QK2PWbyM5nAyPCZ3Wwcky2UzEWxpy1IMCyb5IhT3lgvbiY2K/8YB0gs=
Received: from CH5PR02CA0013.namprd02.prod.outlook.com (2603:10b6:610:1ed::27)
 by SN7PR12MB7912.namprd12.prod.outlook.com (2603:10b6:806:341::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:36:09 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::63) by CH5PR02CA0013.outlook.office365.com
 (2603:10b6:610:1ed::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:36:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:36:08 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:04 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:04 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:36:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 87/95] drm/amdgpu: Add name for ualink ip block
Date: Fri, 21 Aug 2026 15:34:50 -0400
Message-ID: <20260821193458.808626-88-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|SN7PR12MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: bc9c9e3b-9213-49b4-a448-08deffbb7333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: oQPZSowRBbR7NsW08xL8zncR2rcNGUgeKpwoXfAI4vaXHL8RsiUJjEjGRRhD8Dl0ACaI/ewBanTTeCK7zUCCsAlWZHnCz0IwKy1cfryYC4s9DlcalG2wddq9SSn3qAZvMk8gI/44VrSZwlNgBv78uH9NGzKEA0HnzAuI+X509rdp6TW8D2JQ75clbu8AO1VBJgPFh/6g1oMtHmX4zezlmO1eu5txsCiQAJhYORQUaD3qKsmc4L3oItywNtzj4JoK5/Gj+I98X+sHGUzhiWQPo8F79dASiRjFr6E+jU3iPNlGhcMyIG2Kg93zSr57Ag8zamTqELlzMdi/f/4mAVzieFlzp6al/mbF8iM8PQdZIWkNBAYCb92ZhagsrPVopfzVM/Fy/0y6ZUg/NNbJhZqGJE7MnhkQ1QYrB0dfbDAt5JegCkTA2vpuiMBIV6KHv7efe9YLTgbU8KI0T2RDj5xOR/vbG+mpw9dmoNugWAqfqxcqAQxsAU3tUhCiGuA57S4b+uacxpyIJLKd3qlSGyYQ6VNFgMjIFXUj6ngbVESJY1jSvwi+zo2uL027on5DDvq4zWSYqpw1YWVDrnet+vAqyorn2b9f2UskTdYjRMmmfnGdIglm4X27i8S5NCrERW29ImojP0ryeKLg3xif6ridxgyz8hErJ4+YwBoZX6koPGz1wu02owphgb0VktDeDQVQbdM8BmkGihUYVJHqsW8TVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9saXTPeN9gXMPUMqdnTRacu/4pAL/CiDa6A6nAaeJr/uXmaFIUC+QZNNWtpLfGT/fkebDxDYF6/YySI39BI294GCD/qrKPhuJykfQG29hIy3am3OWix0e09JXY/2rHG3jQyLndXvEImltZzRAqyAYfyxjYFspnKix6n2+cNoChSJgiW4O8pKfxVAQFol/x0uOQNxWgXl4wsvk+hmJv/sfIF4650GQgLj8Q+Fx3UEe0vTj/FlW3adWxVQirCrVviPF7hC8r2JsMnBuhoV4dm+KL1+wWEQAMTFpFcTyxfGVtw9cOSG691Tfccygc4P7cYsLH6Q4HaxFvEI/GH9ZF8k+7VLp5csn+a9EWyTvNGjHSz36t/RTIQhye2QdJcYQ5PyYmc4OXV1whrNPIoHrx1cTR0BDM2D7iHOyvI3blTn39VChPXVSGLWI21y1vli7Nn2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:36:08.9382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9c9e3b-9213-49b4-a448-08deffbb7333
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7912
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

From: Lijo Lazar <lijo.lazar@amd.com>

Add namestring for ualink

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
index 922f4b15619d5..a426327f21416 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
@@ -198,6 +198,7 @@ static const char *const ip_block_names[] = {
 	[AMD_IP_BLOCK_TYPE_UMSCH_MM] = "umsch_mm",
 	[AMD_IP_BLOCK_TYPE_ISP] = "isp",
 	[AMD_IP_BLOCK_TYPE_RAS] = "ras",
+	[AMD_IP_BLOCK_TYPE_UALINK] = "ualink",
 };
 
 static const char *ip_block_name(struct amdgpu_device *adev,
-- 
2.55.0

