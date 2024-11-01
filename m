Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2106DE6F06C
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2024 16:24:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6CE310E1F7;
	Fri,  1 Nov 2024 16:24:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pgqEJN/l";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF9A010E1F7
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2024 16:24:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qniUdTfCLute/ZeCNZ2OvPvMEYx6Wka8T21MISI4qXMduw7WHwwvGnceh89HXlw5jp9UKz8UFA2ukaD2OoGaguIs/NSDW8QDmFl+uOwvC9LAH1WF3oKEUnkYYtTVN2pcsvHBmw/xLxyeA4ULatQsdRjqUUBxl8zjyUKg9DvuboW6F36NYrprhhb3Kz/EpIPCVVcbwW7wGP3kHEFAdcYgnv2oNb+7ToNRHV3BnP7h70mVPcsZeesOr2ug0L+rYvHzqcH2cELBrAfYyYKPSJkX2fWKfFNCFnY0N0fZoW/pVeEVMUO52zUX1lB5vLvndiCLbu/KaWKZW5kmmosiJbCz3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7/0CDwZtlW8fjWNMcMVsJLFIKkg1sGY9e4z+p8mxyw=;
 b=jrsdHOb0N144fNfRsWEAILHRfDcILLDMNZ7HvIujQNVVih7bknEPS4MwLW2z5ppqolGivoHbz10WSAFWWs1we1bFEGkPPTjuHyix0TpyexgptqhWeEBzM6VvY6oPC0AfvG2drQz0x5R6RmCyNDbP2kkMvH+s0MYW6qirqsSdaTcGxrsRrZd6MCrLK6z9z4DhupVsKxksaWZmkyzlmCPJsZX1/cVmUMGBP42pCOO58sNhAYBg+usHH9YyrWNkB3LYtKm8SmZNtvB7IC5/fXEz9IKvzDuZRu2IzB3eCytsVfwxSQT5tbC48PW+AG5WIuAIYuCzNQCOvEM4iocrjHvvqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7/0CDwZtlW8fjWNMcMVsJLFIKkg1sGY9e4z+p8mxyw=;
 b=pgqEJN/lbrRiPbUns6Qx4QEF5Z45BJ9W9CWXjmDe1hfTCfR4NOdYHbriOBEdBbGDf9S+l6gX8RejCGPDNyUlv5uqxRExl/tiIgHJOsZeBOSqlIhm+uEQ3FerjLKBWVJnPJwVs6BAuiNf7eILpXqtSEy3ASzfTRxBpmw/e7qRzQ8=
Received: from SJ0PR03CA0354.namprd03.prod.outlook.com (2603:10b6:a03:39c::29)
 by SN7PR12MB6911.namprd12.prod.outlook.com (2603:10b6:806:261::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23; Fri, 1 Nov
 2024 16:24:07 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::91) by SJ0PR03CA0354.outlook.office365.com
 (2603:10b6:a03:39c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.22 via Frontend
 Transport; Fri, 1 Nov 2024 16:24:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 16:24:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 11:24:05 -0500
Received: from debian.net (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 1 Nov 2024 11:24:05 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, <rodrigo.siqueira@amd.com>,
 <sunpeng.li@amd.com>, <dillon.varone@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: Add a missing DCN401 reg definition
Date: Fri, 1 Nov 2024 16:24:04 +0000
Message-ID: <20241101162404.47741-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|SN7PR12MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc20d89-7667-435c-4a7f-08dcfa919bbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BWyQbd2t1jKhVcXso3PtUILLhAKNrIS8xfwhabPeARwI22qNgJEKxtOwDjNI?=
 =?us-ascii?Q?e6DsPyFfJkmBaFjc2DY6qQCTlNKSqtXmM6xc9v7Ne2+5osstj6RuMNfeeVt7?=
 =?us-ascii?Q?qpf3oP/xA899/RhuisWxVqpouYd9sqsY9RQJajJBD09pJxEMvjmSTzlcEG+R?=
 =?us-ascii?Q?xJwU0HkKHsaZ6AokeTUfub/wxbxIz2yaVheQdMgRm8c3qdPO+h3qLWI5JPeR?=
 =?us-ascii?Q?brH9tw3G6qwI1+2x/QNSrKCGsmSbq4jA0b2dvt0HV13O3Uv8defos6pcBv7X?=
 =?us-ascii?Q?NDlRSO5zlVMq019RCTf4wBPCsW/OlxBDdANzF78OMPwOGsWGS+NRersnOyiT?=
 =?us-ascii?Q?YeLTHVqG7nyZVAjwWoDMN6DWLh1Y048VB7J8nqIQdfYnj3NOl9K3C04hwbEJ?=
 =?us-ascii?Q?AWn9121ucTtF/bHTozP65+bPRolAKr5uazf6mCY08QRuE5qCOtgkm59fjxlc?=
 =?us-ascii?Q?a0xUOW/nvgkeqBcRIsECO06NJvqaXUBsgibI1/Fm5UKdXt4e+SZvPGP4+3Tj?=
 =?us-ascii?Q?APXzuTWa6NW3J3QH6CHAB5pE+NG1kBae8xGQ0OX9Bg9Um3dtnza5TosVX1LI?=
 =?us-ascii?Q?eQEGrrjScTLs5ja/+WsB6Jy84aFAo1zGiJvVZTlSpV/mWMFOd5Lz2o1w/pzy?=
 =?us-ascii?Q?TJuMaUS7fVSp0LJSV1BKZi4LGslBy+ZHbbURkyz6jgBNGrN8QG6vKgcCzVX7?=
 =?us-ascii?Q?tWAOi+Jhb7WGzB5n0y7FEb3yZFz/bCSlmoQRmQ2ksxUULvNAPjHi9AnRxhg2?=
 =?us-ascii?Q?sYTL6mpVwA0BLTVH+3E0k14S6Lob3VE+lyntCgiieznhmIoxLjsJq7O0YfnF?=
 =?us-ascii?Q?kknbUx5F2xaulYCZ0hW30nKU+tH1DwjYP35NBp3LFbO9vqE+do2klWRUWJk2?=
 =?us-ascii?Q?gPiFahL4qG1Pc/870EpfEGfMbFJ0p+zJ/M5An2utLmp4O6ptXSTBnMiX3lpR?=
 =?us-ascii?Q?aGXDCdkBdDarQrQQiWRnGSJt4Qv6EuXK+j7plV3fUtW+qfarLYqEtT36iPaz?=
 =?us-ascii?Q?qXO6zP5G6fImdPv8Yl8igcLfJExu8Ab6WlMTd51u1f8d7Y/KZibq/i6f33Ll?=
 =?us-ascii?Q?XGYo3V7EKBizgl/KC0SvPRDunXR3KMoaweza1/FM0+A4mcoKDaZ6lI/519EF?=
 =?us-ascii?Q?fdn9g0QTk4J1P3pACWBdihzVlx/ROiQOHCFJvLB9QWnug2so4DeGlA3AJwCF?=
 =?us-ascii?Q?V9Y03qH35SHOCtL3eJ8yygkXOk/j5wfpEyzkw+fKPERTACh2SZ8VGpOPwM2A?=
 =?us-ascii?Q?fMbtXkYS7M1W6CTJE1ybUe8t28zvlm4qopgydp3I++Wz3PTO5QOIdPR7NBGD?=
 =?us-ascii?Q?bpHVIK8xWlQfk6Rwgb65LYfDDIyKAecgi4JzvsUsIFVneLTDcx5SWP5NLxfK?=
 =?us-ascii?Q?iouOJgbPrR0AwgmmDypd0mCgvIFKIC+JKhn1OkPYYM6G1Etj9g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 16:24:06.8255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc20d89-7667-435c-4a7f-08dcfa919bbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6911
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

Add a mising reg field to the autogenerated header for future use

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_sh_mask.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_sh_mask.h
index f42a276499cd..5d9d5fea6e06 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_sh_mask.h
@@ -6199,10 +6199,12 @@
 #define DCHUBBUB_CTRL_STATUS__ROB_UNDERFLOW_STATUS__SHIFT                                                     0x1
 #define DCHUBBUB_CTRL_STATUS__ROB_OVERFLOW_STATUS__SHIFT                                                      0x2
 #define DCHUBBUB_CTRL_STATUS__ROB_OVERFLOW_CLEAR__SHIFT                                                       0x3
+#define DCHUBBUB_CTRL_STATUS__DCHUBBUB_HW_DEBUG__SHIFT                                                        0x4
 #define DCHUBBUB_CTRL_STATUS__CSTATE_SWATH_CHK_GOOD_MODE__SHIFT                                               0x1f
 #define DCHUBBUB_CTRL_STATUS__ROB_UNDERFLOW_STATUS_MASK                                                       0x00000002L
 #define DCHUBBUB_CTRL_STATUS__ROB_OVERFLOW_STATUS_MASK                                                        0x00000004L
 #define DCHUBBUB_CTRL_STATUS__ROB_OVERFLOW_CLEAR_MASK                                                         0x00000008L
+#define DCHUBBUB_CTRL_STATUS__DCHUBBUB_HW_DEBUG_MASK                                                          0x3FFFFFF0L
 #define DCHUBBUB_CTRL_STATUS__CSTATE_SWATH_CHK_GOOD_MODE_MASK                                                 0x80000000L
 //DCHUBBUB_TIMEOUT_DETECTION_CTRL1
 #define DCHUBBUB_TIMEOUT_DETECTION_CTRL1__DCHUBBUB_TIMEOUT_ERROR_STATUS__SHIFT                                0x0
-- 
2.39.5

