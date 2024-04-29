Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81149C04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2D5C112CB3;
	Mon, 29 Apr 2024 14:34:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1YbZ3wfc";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1C0B112CA9
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:34:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdwyXSdEeO1Szz/0tiXSMA0UR3EHJYI89wYFM8UA8d1AGxuKFfH/7wwgozw+xAPge5g7s0gvWhHC+SFr7NY56+0aCdffifrt+yodziALZqCbKtBd7SLhYX/sUDpfW0EqK9IWzqE1gbEG2eNq/Eb6PKoBTxZNJc3Gh7qMpn7EopWHwazI5VrgS22hrUB9eb73MhjhbpmNB7h2NA9Aab7OK2uhMuR2Opjj5qp1nysfetikaGj5NEjeOFmpK/jePX89KNOU34Wtn4Onhr8jdYbjfZNR7fy9MCJ3NI6NrKBo88Bw8aHNTdoW/vF87LU4QwsRDWpy8zp0X4FeDJaOPusEFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MijxijX+XXbeXwPsc+j7LLYEkEyF+w4++3l7V2Z2DfY=;
 b=P4fhNJF2oUvfm929lSGbTWpySKVy5ejNya6tgk8qOO+fYXSYUFa7ZRavUQoHuLli+ZlMl7ktS4TLIaFSHfIc/EI/G97EmznEANAZdlITmjOtNo/LN1CXcVq3t1CwaCgoUKGHGBZMmOYYbVUdri2XH8GWERvA0p/1PRF+7yD7z8pGfBbtyaC1d2qiJCOUodpig7Xafk/3S3GBD4fZEDx4oKElqN3DRJy90dVNZK14+s0Ve44tLmGHVcVEkB4k1uV05+OA1bXlzLBBt0Cs3UtnbTr3F0HuNtaFP0/m9CkTFkirS+3J++voiIpawuUv46awBWKirdSle4JbMFbXW+2okw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MijxijX+XXbeXwPsc+j7LLYEkEyF+w4++3l7V2Z2DfY=;
 b=1YbZ3wfcICt0fAeTHWJbNnp10OcjOf0ffmz3rQ065HMhRACYpCASSYCTeuq4gDYMtoXTM2vUb0ZL5m1SnY59/YKGv+iTHonVNK3gTBhF179g/7Qc0Mvq5GfSirZLfUK4W5pTgzU3G6HF5+QmyDWW7yj9ll9b9colEmdvEQUURsE=
Received: from BY5PR20CA0027.namprd20.prod.outlook.com (2603:10b6:a03:1f4::40)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 14:34:22 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::20) by BY5PR20CA0027.outlook.office365.com
 (2603:10b6:a03:1f4::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Mon, 29 Apr 2024 14:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:34:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:34:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tom St Denis <tom.stdenis@amd.com>, Jonathan Kim <jonathan.kim@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 23/31] drm/amd/amdgpu: update GFX12 wave data registers
Date: Mon, 29 Apr 2024 10:33:31 -0400
Message-ID: <20240429143339.3450256-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429143339.3450256-1-alexander.deucher@amd.com>
References: <20240429143339.3450256-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|SA0PR12MB4365:EE_
X-MS-Office365-Filtering-Correlation-Id: f594027b-c2fb-4856-dafc-08dc68597606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|82310400014|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+CiGhiOWHqUofmKyIFiyCkqcMPCMS8zhJfUouOpz+cJ8ro26Kr4ScT2DXaOy?=
 =?us-ascii?Q?eIMWI5M7BCub/xNOoITX+4KJm7yKcf5M8gnSJpWIuHxVxntTTe9jQzWP41OJ?=
 =?us-ascii?Q?Lhs/nrwfk+BpnninIOrfH7UVm1A+HgbZmWFodQ7qz2wP2rjyfeP8TyAWJiwL?=
 =?us-ascii?Q?mALDIQ/XaZhxkubWkDbw1jXFR7IQE+55mbkRUmv0UQ0rypJhYrf541ERMOPd?=
 =?us-ascii?Q?kPZPY+LP3mVMGylVTsLfSUnRXPvlQ1pjHI2GIeO3PyPlSa+/ROWqwXUq3U7N?=
 =?us-ascii?Q?9a/B7SNfXEyzS/4T9R7u3xPEtODOUHXa9ax+/NJYLcznGLFT4dMBZbkay/1n?=
 =?us-ascii?Q?W6YW01Hki8aDgbPLjwY6kFmzgbv4ktY0egGVL5V1ssjtaIfPwcogqgWwt37Q?=
 =?us-ascii?Q?4PFv2t4S4hgN7oZAY2YDZARA1VU73hXsw07oLKF3LYDBUqljncYS/YOfeZc6?=
 =?us-ascii?Q?wnpYJqN28tfnLkmBwU8yl3kHtPWD12jVpviEJZRIhq524WNaz2wvzFsHXUjG?=
 =?us-ascii?Q?M9yylqklfX01r7LWsLjChTB1BU+XSQy1pHNqkIWlEH96sbtKAK7dz1pYQSt3?=
 =?us-ascii?Q?v9QH6Zq8SYm5Og5eDSjFxc7w/ajybrqH5l1c288JOZSZgGCWkJ25Lc6+Y6XO?=
 =?us-ascii?Q?Wy9Dbk1FKwn7UOz5IdNywwldGW9C4WpRUZMjgQKU/3byOegaPO9h3OLoRd1r?=
 =?us-ascii?Q?E2SDX4cuzGZcm+kMyHq+os+j4ES77JioVm9YTpZrSRCpA0J8e3vfUmhMFy55?=
 =?us-ascii?Q?KmEtUIlbqLkVWkIdlLWYe7H8YNMx0CKSb1GNjIhdn9TYGH5i7jroULXwI9Vf?=
 =?us-ascii?Q?2dpNcr5Zjp1+1nWGrymrGPAGZBLYUps4jF72BjkEn19wRJCk0oB6V4I8YlTp?=
 =?us-ascii?Q?ZpIz/s9NidkX2cs2ldtEOGNLM+sVxUI6Ydyy1TEi1P827X69vATYb26BtTSU?=
 =?us-ascii?Q?iYVfW2GwdgRGXgCgIpDfgsGmRaD9HkIOGTeA0SgcN8lay+xGuCu4Ouct9feM?=
 =?us-ascii?Q?wfNBLJnZ9mHoa2RXieqOKOjMdjF4TbTAGXFLWZzzfYRF8xhWkuwMDdnwa8/k?=
 =?us-ascii?Q?sU862UcRrHRZPonF4WoQCZ06xIo1/Uxwzcqi1svTX5QpLCH+c8dyJ5miQIie?=
 =?us-ascii?Q?cxbbL5/ruo/SIWt7taaJIWd2wQQh/qlRFb3VzATGUP4/RApVfjTP+UAbRr9m?=
 =?us-ascii?Q?spSLldzzOv7r1Z6NnrfIhQ9arKFJ93rRKD3W63JReqNpaIZ739lUk6K2plRu?=
 =?us-ascii?Q?qMwZEzxYMEjsu1X8mroKKf/eEkQhd7mCORXi1K/xdg3grd0lvsgv+8neW7TC?=
 =?us-ascii?Q?EZUv3xvGs3UO9Hkrb25uBe6F+R4ZXK+4GHO0rO5fHcVn+XZPrH7C6+gbF0ro?=
 =?us-ascii?Q?X5nkydyy0jFXF1Q1VVj1z/Q2MH9q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:34:22.0056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f594027b-c2fb-4856-dafc-08dc68597606
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365
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

From: Tom St Denis <tom.stdenis@amd.com>

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 68a66ccb0100d..730d57a10077f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -659,8 +659,8 @@ static void gfx_v12_0_read_wave_data(struct amdgpu_device *adev,
 	 * zero here */
 	WARN_ON(simd != 0);
 
-	/* type 3 wave data */
-	dst[(*no_fields)++] = 3;
+	/* type 4 wave data */
+	dst[(*no_fields)++] = 4;
 	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_STATUS);
 	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_PC_LO);
 	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_PC_HI);
@@ -675,6 +675,15 @@ static void gfx_v12_0_read_wave_data(struct amdgpu_device *adev,
 	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_IB_DBG1);
 	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_M0);
 	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_MODE);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_STATE_PRIV);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_EXCP_FLAG_PRIV);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_EXCP_FLAG_USER);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_TRAP_CTRL);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_ACTIVE);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_VALID_AND_IDLE);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_DVGPR_ALLOC_LO);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_DVGPR_ALLOC_HI);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_SCHED_MODE);
 }
 
 static void gfx_v12_0_read_wave_sgprs(struct amdgpu_device *adev,
-- 
2.44.0

