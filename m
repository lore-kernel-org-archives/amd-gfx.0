Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1887C0219A
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 18:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31FC210E3C4;
	Wed,  5 Feb 2025 18:41:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M/3xRfkt";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 063C310E387
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 18:41:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ic7FuXcPmbdNGG/ij5rFNu4ViuIOlyesCVokOiKwjN6MlZaIz3MK6MlhI0gb3/xGGrR/RdYZnIzLNWhZxTwY4+QvWBhUreL3Ha6R0aOlwIbkjpYEOoQYzpJMfGc7100FEI6NJmk///656f3ETfSMphIeA6GBn4chwZ7z0zw+YqGZkZ2zlvcQvx8VreOkLf/xajC49t1RqUZ0Tms5ScX5Fi6yTnH4IGQhUnlPG7Y/EQUC1d2Tj6k9hAtM7t76UosMDYzsOKGEvvKmI2V5RDJ9wWY2oYz6ENav/e8Z8U1lM0U/QoY2bXhS6ss63VEJVQhZXN09cV5dUBGSWijRqSg5Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ftx9QTIvUIQqXPSehnq6/M3/noMmzN4L1324zP9ter4=;
 b=r9n+ptTVTx8iiecnsF3f/++2Vor6nmRGZhoeAysjA7b7fCmqUtf72AM27FU6xEOV/sf8OlKHXRGnr2mNj070e3CA3mfXFH/CZPyoBo1SxUvSRi467a5lUo7noQ+1fcvaPJaii1yDHx/stSTeRbHCQrk3wDCwibp0FSu3HpNOZ0IW/b+3plYItKd7DIxdFerZclXs16Vc56mmsxhY1AOJDCVK3f4BN8/ju6n5Uupd7ixwfDiapawXn6sGERqt4omupWjJtBjbuzxCamLW+bNsD4EnKcwJlZHR9ZOs3FGlGjV8O4V74YmOuZryv/SHGW1KKJpGz7dxXtHCJPnOKub/tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ftx9QTIvUIQqXPSehnq6/M3/noMmzN4L1324zP9ter4=;
 b=M/3xRfktnlKQJQzwsNR1jans3bCZJPr4qD56cUReeAmiYqFJ5Hsg/wz+uDs9UZiExVlkaKKQDVGJ3sPtHBNLJtxpX/k8R/vyWaDqJcP2Aw6aKe9+5W/uOi8qVU+IjqzmBcS3r4W1Qumtc66DmlP3aCAK/ca5gu2sRXl4sg+wDsw=
Received: from MW2PR16CA0052.namprd16.prod.outlook.com (2603:10b6:907:1::29)
 by CY5PR12MB6382.namprd12.prod.outlook.com (2603:10b6:930:3e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 18:41:10 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:907:1:cafe::a0) by MW2PR16CA0052.outlook.office365.com
 (2603:10b6:907:1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend Transport; Wed,
 5 Feb 2025 18:41:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 18:41:09 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 12:41:08 -0600
From: Shaoyun Liu <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amd/include : Update MES v12 API for fence update
Date: Wed, 5 Feb 2025 13:40:55 -0500
Message-ID: <20250205184055.104040-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|CY5PR12MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 7553c78c-cd74-43a2-0ced-08dd4614a890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WTx0LU4aookT6yk0zL7K0FTL4/Iiklr9eMks4R53OizDco0u/Vzyaypf5r0A?=
 =?us-ascii?Q?GhFvWfUXpERhpqRiogQ9T61q5FsvgTDMqZLuoCNteWQ1GHOKWwaONPVV+n0a?=
 =?us-ascii?Q?jzTQbZbhb7OQynYAI7jYMKZpL/fR+DASpL1ZlNAnHs4n+m5fXjYzQmkeeDG0?=
 =?us-ascii?Q?RNEmuAhb7yi3A+ND6BaUb3XcixVIfLo/qWMTn5z3TouIx32gVOSCFibSanrx?=
 =?us-ascii?Q?Ep/Lufth9w0HPvafkNgPUbVQGpJBK5mZtItTr34HHVrop6iapob4xFCxiY3u?=
 =?us-ascii?Q?IdzWYWiONxN15VyTdMtGBP4VE9yRJ5a8CW1pb2SYfaNAKlbonutuA8BmqgSc?=
 =?us-ascii?Q?Ilt9wP2NMzcVg7VkZVYKOOG6dCRJNt/n7YtiAY2+ZF4MyJH1oGm9/c6wP63Z?=
 =?us-ascii?Q?aMxIspGzbJJqon/Hg8Xcja9sD2YFbUyeTVEUasFXicd7no5WF7zUEIa1lOmC?=
 =?us-ascii?Q?shcYqILgjoVIlACY6VLWQPZCxESYpR0mqib+9vOFAMcXmdS4dIT9Gp8s5Ihx?=
 =?us-ascii?Q?bj0dAW7UjTYKcip1aLMkF4uPQXqkK85QgXu1yp5lxI64GRoRnJJPtp8mUH1j?=
 =?us-ascii?Q?3HwlH62MXRXxqLW2zbqmodS37b4Upm0RC4vCLt8TIe4E7ufbPYAiJEDHJYHB?=
 =?us-ascii?Q?2l+2gGa9KAsZsjWtOf4bsvZaSUJnehErg36l37ZseMBCfYlnJcsNEYRDqXVG?=
 =?us-ascii?Q?X6pci8j0XMNoHXAK4ekiLyP5SGWJW+zJ+SXzVMWEUhYNFAFziBBQBnsZDZJT?=
 =?us-ascii?Q?0RUwYPhmjQ/xLYNIH2RSKZuaAQNk+lCleTeobxjwNxIEeMcTlxbUoKK3Xe/y?=
 =?us-ascii?Q?eknI0bZaE2TUJ+XvMg9UDeAjxiApJcMYfHkzz9OG5rgwrRjwySfK9smvU/Z3?=
 =?us-ascii?Q?fAewtAwS5FhnjbMbhMPbuoefgiRRy5JAZ3CcSi9Fi/NjAmiHA5MSXvt+qnO0?=
 =?us-ascii?Q?yAql4i/Duul7tflmhto+WgbMStQicQVerU2AeFoROF/HfeRJCa3Xd2NcvSqO?=
 =?us-ascii?Q?wh1otnlH0x5sNUNXfyv09d2D2omiWX+9DlkVBCc2adzROwFO2OA4gxpqfQw3?=
 =?us-ascii?Q?uSqk4DEU7l2QwWIstuRGsmtNgyXgrMeYjy1eaKR0foD+5MYZFfzuMQU0lWxU?=
 =?us-ascii?Q?NmKk/RNCGB3wp3hHourOlstmIlqL6Snd4eQFmGK2CEJouJFjp+qKuXlJjsC+?=
 =?us-ascii?Q?DLK47IXvayxTC21sIIxgoYXLSuw6nR7Qu2dbig+mu1WkKly6JfXMIBU1p+sj?=
 =?us-ascii?Q?Za8B+ftwMgiURRWBQ3W63hy9cdTS7QT21aAIp8eotj3mibgSHKFWa/BGy2cV?=
 =?us-ascii?Q?+Mk3uzzcbEGFm1k6f2ZBLn6F1mPKz2HgY8ZY2YUhb4g+M+vQXAvbYpmmJh2T?=
 =?us-ascii?Q?ixsCLQnqWyZoBN5mH7g9Q3MbUasHLqWyV7tqPhbY3hO790YyxdQe1eEV18fQ?=
 =?us-ascii?Q?ppyqn9YFPkiOJMHfRRLPWS3ma5OlTKaBP/lQtoDxAkoiATbRHw3Da8XYelbN?=
 =?us-ascii?Q?bzTBb4NK+nIf+Sc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 18:41:09.6219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7553c78c-cd74-43a2-0ced-08dd4614a890
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6382
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

MES fence_value will be updated in fence_addr if API success,
otherwise upper 32 bit will be used to indicate error code.
In any case, MES will trigger an EOP interrupt with 0xb1 as
context id in the interrupt cookie

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/include/mes_v12_api_def.h | 40 ++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
index 1938150a1943..fb918668ddae 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -105,6 +105,43 @@ struct MES_API_STATUS {
 	uint64_t api_completion_fence_value;
 };
 
+/*
+ * MES will set api_completion_fence_value in api_completion_fence_addr
+ * when it can successflly process the API. MES will also trigger
+ * following interrupt when it finish process the API no matter success
+ * or failed.
+ *     Interrupt source id 181 (EOP) with context ID (DW 6 in the int
+ *     cookie) set to 0xb1 and context type set to 8. Driver side need
+ *     to enable TIME_STAMP_INT_ENABLE in CPC_INT_CNTL for MES pipe to
+ *     catch this interrupt.
+ *     Driver side also need to set enable_mes_fence_int = 1 in
+ *     set_HW_resource package to enable this fence interrupt.
+ * when the API process failed.
+ *     lowre 32 bits set to 0.
+ *     higher 32 bits set as follows (bit shift within high 32)
+ *         bit 0  -  7    API specific error code.
+ *         bit 8  - 15    API OPCODE.
+ *         bit 16 - 23    MISC OPCODE if any
+ *         bit 24 - 30    ERROR category (API_ERROR_XXX)
+ *         bit 31         Set to 1 to indicate error status
+ *
+ */
+enum { MES_SCH_ERROR_CODE_HEADER_SHIFT_12 = 8 };
+enum { MES_SCH_ERROR_CODE_MISC_OP_SHIFT_12 = 16 };
+enum { MES_ERROR_CATEGORY_SHIFT_12 = 24 };
+enum { MES_API_STATUS_ERROR_SHIFT_12 = 31 };
+
+enum MES_ERROR_CATEGORY_CODE_12 {
+	MES_ERROR_API                = 1,
+	MES_ERROR_SCHEDULING         = 2,
+	MES_ERROR_UNKNOWN            = 3,
+};
+
+#define MES_ERR_CODE(api_err, opcode, misc_op, category) \
+			((uint64) (api_err | opcode << MES_SCH_ERROR_CODE_HEADER_SHIFT_12 | \
+			misc_op << MES_SCH_ERROR_CODE_MISC_OP_SHIFT_12 | \
+			category << MES_ERROR_CATEGORY_SHIFT_12 | \
+			1 << MES_API_STATUS_ERROR_SHIFT_12) << 32)
 
 enum { MAX_COMPUTE_PIPES = 8 };
 enum { MAX_GFX_PIPES	 = 2 };
@@ -248,7 +285,8 @@ union MESAPI_SET_HW_RESOURCES {
 				uint32_t enable_mes_sch_stb_log : 1;
 				uint32_t limit_single_process : 1;
 				uint32_t unmapped_doorbell_handling: 2;
-				uint32_t reserved : 11;
+				uint32_t enable_mes_fence_int: 1;
+				uint32_t reserved : 10;
 			};
 			uint32_t uint32_all;
 		};
-- 
2.34.1

