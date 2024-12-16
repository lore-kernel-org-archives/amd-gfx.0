Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC95E7717F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2024 21:30:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CBAF10E06D;
	Mon, 16 Dec 2024 21:30:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CjFnDM+H";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F98D10E06D
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2024 21:30:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngoC1DJZI3e1qXSmkgEwtK0Ojro4/AignKznv/p1aUxeamqmXPnmQmk+/F0kv8AdII7MS/R6w7aRRyRu+x3kvnTILmT5kWUo0IZkLFfKeoxpS0/LWBZ2fMGl+X0Cg72RFscjfQpxbEeNr6odbo9aMBW+1LTBUvBKhFabr7oL2A7sWMkKtLYWtbmpvjgFkkd+PO1+hj7qMoNu3jA8MhW4C5wB+fzYTpHDA//lLzPDBuBZfQ9MCgi+SgG5YydfX3JPY0enrO4Hb2I+4xG6vNPK5ozGEtZUiGsSGa2rHKq0wd+nCJmwh/sYe3iZ7UElxo0g/5Sy3+O3oJyxKqwjPIWdbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjijFBJOy+oPnF5phGo5SEeQeFzRb0dhWOCNtEq+icE=;
 b=Yy1ql3FPJoCCyMamRFhrJxeryzN6edFwrfIxCVhJRsHuBnSHqs9JJXnCIldVvWMRBsDt7iFAhmSKCVCUl8wo8Mb7SjlauTSEfDMY/jIHm7dcHxt1Ioqh2bBCHWMoIme/aegmjMoJFEOWKWcQiGC69YW4+Q+9g5N0Nz2FexEkeCjBJDB0NMdfc00KJaOgSjOf0KGkAP9ETpuZWIiljmCG5nJtwPniXyJsxd9sdkX2GKY0a7eEU1VSDT0VwClMWvUokdlfa7dbhhC1UuoPRcEx44O0bXknQHavYOnoBXfRYEC4MFbFqwLryNHJoadLfLqls3PBr83pR3ZGncktOVlkSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjijFBJOy+oPnF5phGo5SEeQeFzRb0dhWOCNtEq+icE=;
 b=CjFnDM+HUZO56AJSRbKArPg9T8mTZjPFO5HHJTg7aZHaHO5vhNr9lN0Bcp1io/niKu5CrcdAR2GszgXeKdwg2p+ojtU3rInscQK2ZZt9ujutOQToEBOhxgMf78ZTWIwxTGasGf0/Tcq3gSPlKHAp8xQUE1OZVGOBO/oSdIZ2H3s=
Received: from PH7P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::19)
 by PH7PR12MB7427.namprd12.prod.outlook.com (2603:10b6:510:202::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 21:30:35 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:33a:cafe::e6) by PH7P222CA0025.outlook.office365.com
 (2603:10b6:510:33a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Mon,
 16 Dec 2024 21:30:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 21:30:34 +0000
Received: from elenaOnsiteDevTest.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Dec 2024 15:30:34 -0600
From: Elena Sakhnovitch <Elena.Sakhnovitch@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <elena.sakhnovitch@amd.com>, Elena Sakhnovitch <Elena.Sakhovitch@amd.com>, 
 Elena Sakhnovitch <Elena.Sakhnovitch@amd.com>
Subject: [PATCH] drm/amd: decrease CP queue sleep time
Date: Mon, 16 Dec 2024 16:30:19 -0500
Message-ID: <20241216213019.3926329-1-Elena.Sakhnovitch@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|PH7PR12MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a87f25-20a6-47ba-be3b-08dd1e18e050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RrxpWlGt+pnMoiItp6BkNecneW/apYPsHnOLt4iefS6QhYvZAkxDK644H4I/?=
 =?us-ascii?Q?zo7StaeD9GPGBuVKJIT+a+hFizVpCHmUBtAx8FHjiZ5noRbBgJK7ZpOr6ot1?=
 =?us-ascii?Q?a02jnGcvo+u5ZvC9CJAJTOg64l/+yQzybQb61yRtQEmCVYRdW4lzW17R0XbK?=
 =?us-ascii?Q?pvx0DjspU2XIY7r2VWxgxxdDIXc5YcB8xBs6bmM+vOqz+vLnsnrz8dMOzjxR?=
 =?us-ascii?Q?k5BGHBVJCJqBDRJESVBC1Hy5wA3nQ5NrwQeX2RS1JNkR/XOkOgTdAZ8tmAwe?=
 =?us-ascii?Q?mVVAx+0jl4rg4WYMAgsRArrUeIenYFahQftw3tkxEKsl/rgSN6S2P8OMkfOs?=
 =?us-ascii?Q?QQHw8OqozWrU7K6t17Qve6MhIUHknQpmjyIa5KAm/SFDCQ/d0bF9N8SnHssj?=
 =?us-ascii?Q?X7HLhQgWCU7jBUiEcxhHaRvoM8Pgrb+8hZYMVZXOJmnayZxWZpAHrlSK1XAs?=
 =?us-ascii?Q?POdpCEyqDgt9zFhs/HXwilIKGqkAXf119ftCgDwUyNxYO3mDhp+dO6sE42+d?=
 =?us-ascii?Q?FagktXu8THE2uYsVNRzw3/oLW6VnjdWjAnozTJCI6dWv58hNPQzfBSiW1qob?=
 =?us-ascii?Q?GIVFgKuujpKl41yswnf7Z26kre9rbWyd0BpvZlDJTKy4ev808+bOvweBpJ6Z?=
 =?us-ascii?Q?z6Tr7ouLhNhHMQVP6E/L4DYa1MELeRHAPFnXM5vOwibnRr8g7rHoCBCbbeYo?=
 =?us-ascii?Q?XBD5D5OrOehBNFEcaD2JSpQ8SGh1u5/gz2ZpIBi0Smws62el88gXN4YyDx0a?=
 =?us-ascii?Q?3s6mE6/z/5OnJH+ObB/OrHTZakPBVCPTJhsVdFXTE6zI6ecHuzCRRf3kFttc?=
 =?us-ascii?Q?q/YlEzLybbfUAlRNOKsgCRD2F0PVIgtuEDroSsDtjYaew9QJ86M3tjgFFiaL?=
 =?us-ascii?Q?PZuzZCdXmzH33fTYa9WWzKGoo0JyKZDrVg6DJkwwC10E3q5KamfM3fGZdzNd?=
 =?us-ascii?Q?UXOWoE61eHq4vv83d7+zWD8T786vL72ft96CqxuJo4n+r2Z6oWBkJ5FJRWyr?=
 =?us-ascii?Q?F0JOeoLffQUAQKqCeT710O33xj5auVb51+doZKlL0NM/gvPfsPffXoYqMh3V?=
 =?us-ascii?Q?gYBkq6W/u+QEvPqCY8zjscJYYbZVYTNCO6gMtqVLRqhVjL/gSAzr2FgA7rg5?=
 =?us-ascii?Q?HZVzZ+R1BKm5hqjqIYQGuhm0CGtgOVjDru8EljxdrX2UrA/LozXexWG8Tt9y?=
 =?us-ascii?Q?Y520AFGD3V9TV0mr/zX8sdV1yT/jO5PIzgA29ItLIcb5D5XowNfW/Rm5QnGT?=
 =?us-ascii?Q?zuqp7lUMWSNZ1nhs2w8w40z1YRwSOXkWMkKzr+AtJxnJn/liVvx0U4huBShP?=
 =?us-ascii?Q?wNJ7Y+xAKcFJ1RfpTAMBnnphvoSg/jztx1FJMA1ZhJaY9k8R54svq+X6wo3O?=
 =?us-ascii?Q?T6Dcbb8PCQXCuUn9sq+x4TvBrR6O3Mjy2KNDZwQQSGJO5lZEZx3KA7dze9bO?=
 =?us-ascii?Q?zof60r+fbCg+UFhhctJE5SHWutNtoCRuC0LPo9OgC09dO4EzKfCB6A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 21:30:34.7133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a87f25-20a6-47ba-be3b-08dd1e18e050
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7427
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

From: Elena Sakhnovitch <Elena.Sakhovitch@amd.com>

CP_IQ_WAIT_TIME2.QUE_SLEEP hardware default is 0x40, i.e.
 64, so we put the queue to sleep for 64,000 clock cycles.
This is too long, and setting it to 0x1 shoul be enough to
load date out of memory during queue connect.
Signed-off-by: Elena Sakhnovitch <Elena.Sakhnovitch@amd.com>
---
 drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_default.h | 2 +-
 drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_default.h | 2 +-
 drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_default.h    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_default.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_default.h
index 320e1ee5df1a..da6762309c3c 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_default.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_default.h
@@ -2479,7 +2479,7 @@
 #define mmCP_CONTEXT_CNTL_DEFAULT                                                0x00750075
 #define mmCP_MAX_CONTEXT_DEFAULT                                                 0x00000007
 #define mmCP_IQ_WAIT_TIME1_DEFAULT                                               0x40404040
-#define mmCP_IQ_WAIT_TIME2_DEFAULT                                               0x40404040
+#define mmCP_IQ_WAIT_TIME2_DEFAULT                                               0x10404040
 #define mmCP_RB0_BASE_HI_DEFAULT                                                 0x00000000
 #define mmCP_RB1_BASE_HI_DEFAULT                                                 0x00000000
 #define mmCP_VMID_RESET_DEFAULT                                                  0x00000000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_default.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_default.h
index 21d2f7d1debc..07b112b11a3f 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_default.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_default.h
@@ -2320,7 +2320,7 @@
 #define mmCP_CONTEXT_CNTL_DEFAULT                                                0x00750075
 #define mmCP_MAX_CONTEXT_DEFAULT                                                 0x00000007
 #define mmCP_IQ_WAIT_TIME1_DEFAULT                                               0x40404040
-#define mmCP_IQ_WAIT_TIME2_DEFAULT                                               0x40404040
+#define mmCP_IQ_WAIT_TIME2_DEFAULT                                               0x10404040
 #define mmCP_RB0_BASE_HI_DEFAULT                                                 0x00000000
 #define mmCP_RB1_BASE_HI_DEFAULT                                                 0x00000000
 #define mmCP_VMID_RESET_DEFAULT                                                  0x00000000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_default.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_default.h
index 5bf84c6d0ec3..64183c888fd4 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_default.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_default.h
@@ -1295,7 +1295,7 @@
 #define mmCP_CONTEXT_CNTL_DEFAULT                                                0x00750075
 #define mmCP_MAX_CONTEXT_DEFAULT                                                 0x00000007
 #define mmCP_IQ_WAIT_TIME1_DEFAULT                                               0x40404040
-#define mmCP_IQ_WAIT_TIME2_DEFAULT                                               0x40404040
+#define mmCP_IQ_WAIT_TIME2_DEFAULT                                               0x10404040
 #define mmCP_RB0_BASE_HI_DEFAULT                                                 0x00000000
 #define mmCP_RB1_BASE_HI_DEFAULT                                                 0x00000000
 #define mmCP_VMID_RESET_DEFAULT                                                  0x00000000
-- 
2.34.1

