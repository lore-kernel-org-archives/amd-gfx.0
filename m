Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C14CCF9F8
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 16:55:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E289A10E95F;
	Thu,  6 Nov 2025 16:55:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fHENjGxm";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012044.outbound.protection.outlook.com
 [40.93.195.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C19010E964
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 16:55:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWn8DLxFINB/ljfHxeA0oeTq1Iwb+T5Cc0zcv2IG8xbcwmo9SsQMXb3sk/HHKHNskfUUzZn4hJSMk53J5aIgg5SMjRw0FRBj0r02P99cp3Rr3iPBL9L5sRVWrbXBy2Jyq6TCl9E9HOEx1X4Ibphs1IQ3OD1eTaoKPDku+ErgOeeLaNPhowA7J2sDLfL5NSAY/PixIt8RuO77tvaCXq1zcb6wzsGGeuzvEeutGxJoLx6ZCG6x36ERJFJDR6mhE9XWFWe/lAPUR+RHAj87UJPKSA1CjT32Gs2ywZD8ZiXIVha6ChLAatuw/VKDxB5FBJ9zWpSgdd3VRcUy6V4VcEo9OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AaX/ktLnOONdJeBcnfPFP+iG4ZsuE8a4zqv34dT1jpQ=;
 b=aAyx+phZDvwd9983tDyTmLe/X46Bqcw1TjekRVyQb61Nywm6MrFAA9+MDfHsAx7aMTNQUh9QOsJ9GI5DsHqExiR+6f6josjt8pQxISkhsW5rTUpdbrJAby3ecMDqaRxZNySPdrLfa61zMCrHAXH7zOoL4zNO87NUv4c5SOD287hg2xfqBO8iPXH1NPLMSUyZUuLP3w6BUFmkiZ/aFf3xewODBJbP9Lb82Z/9wyM5cp8bee+ue9Azp8W2YuATy9H6QEmPe6YRnp0MzAE637jgCyVsw4ObJhnWQ61gJSZgjT1iSv0V1oA3AwjObes9zMMCiuW/UEQR4WOr/NzYmDQTjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaX/ktLnOONdJeBcnfPFP+iG4ZsuE8a4zqv34dT1jpQ=;
 b=fHENjGxm3X6jkrDLtVRv41B1iWKZDHaly+JFHzChIs0s6xQbgl0Qttk22SgnO1pnmLnpfdp+4M8PhGxAhGgJVq04M9dKdNk8KTHawo1BAMU9sWgv7vOc51HaO3AjTTh26MGlh0TRhZQQtIw7eEIHfcST60up7f00nGDpF5NLia8=
Received: from SJ0PR03CA0247.namprd03.prod.outlook.com (2603:10b6:a03:3a0::12)
 by PH8PR12MB6988.namprd12.prod.outlook.com (2603:10b6:510:1bf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Thu, 6 Nov
 2025 16:55:26 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::ed) by SJ0PR03CA0247.outlook.office365.com
 (2603:10b6:a03:3a0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 16:55:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 16:55:26 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 08:55:21 -0800
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <asad.kamal@amd.com>,
 <KevinYang.Wang@amd.com>
Subject: [PATCH v4 1/4] drm/amd/pm: Update pmfw headers for smuv_13_0_12
Date: Fri, 7 Nov 2025 00:55:05 +0800
Message-ID: <20251106165508.3785924-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|PH8PR12MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ac632a-9d04-49d5-ba3d-08de1d5548ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ufhoOSLN3K/Y/FNohvSEg8i/9PoweYhUOIzJO3pUbjTtXFu20hmewxhCFiQW?=
 =?us-ascii?Q?QkT0Gv3PYOUImuNVbQ/CAVgu31QyOqUzqdgT7a4XBdHaPFSdM4PNUco6jwft?=
 =?us-ascii?Q?+LNDLe3zFTy3sKT/7XGqzUDIYD6g07vHsKyOcg9J5igmPHtx5wJqW6DMwgGe?=
 =?us-ascii?Q?POQtcA12wPDcwuiqcWeI1S3HPPS5JptjDeHGhTErlFg8Dj6pfWJJMuWdVMrA?=
 =?us-ascii?Q?i+dm+9YqfM9bmnOXru6jTtET1WSv+4PRDlMbQsQO01DJndxFoKV/V6mMtqQG?=
 =?us-ascii?Q?VV55KJDfPaMtn1c2WrHqEoXLa+nv5qbe4K3oL8lnTIFPhxC1R3hcn5+ijTt7?=
 =?us-ascii?Q?QHx7GIIm5iRvYnacVxYHZE9PZxupjWDBtYUdXDPfaSmBdBkLGuBSoX4SY1wc?=
 =?us-ascii?Q?KDJ0oqVzY/VlfiDJr+pCCNpL1I10Qi7qtJhVJc5mTeOBybDPCkeQfJe/V4dH?=
 =?us-ascii?Q?PWV/sPg0JjR6XR3JskSX9F61l8VdSCV+dfaZSxd8tViszajU/r3AlQexUXcL?=
 =?us-ascii?Q?r/4F14Wo7IWv9rf8jb7wD9Sv4FJBgwXtB8q8JEk5NBjwxQpFoq+87zNGyoWF?=
 =?us-ascii?Q?UkTe4oaqbJ2v6zDnnaviRn1XpAzDcFKktoU8cf8YZ0IhstIw7eai5nJb+pGl?=
 =?us-ascii?Q?ZzJQcBZg1ISAAxsZMmNx21SglwT3tGKRrJMcOlp+stvcueGoUvzsOk9V2Jt6?=
 =?us-ascii?Q?4/m9oeOJnwa4VznCr5LzVnH3mjXuPuvnactFwXhyaVdVuJxJkCy3DEc1uuwW?=
 =?us-ascii?Q?eINE34QhXEeDKq7Z3kNB4qGDgvGUPoC1FQ9X0vEG5LqSScGcHJ1ynysu+5sE?=
 =?us-ascii?Q?bahAtK45yro1htJZC1wOv6a2nHddBVRw+qKjZC5eJAb7SKAx3CqllYYNPqvp?=
 =?us-ascii?Q?XXV8Z/t6aXvZKkl3Eb4cSXUU65ipCCHOpZ+aePgMYWJE6KodnhbGND4GP5/d?=
 =?us-ascii?Q?S82vChqFrUtsyoxDF2h5pWraSapXQswgS/QRBG4WdIYS8/VN0eXvI/fpTPFT?=
 =?us-ascii?Q?/kC2xeNSPwSnhvEM8VTr5EjiwQ2yO5vZmx8I2wMEJmeofj8WxcBShiMYQPxV?=
 =?us-ascii?Q?ODdbsK3++SmkNXQHtjUBiIsZcN3x6Df1b9mUS7D3+RVNXhrwpc9Q0Tzf6dZI?=
 =?us-ascii?Q?aYT9oFZnaa7shMsZPhtcF3fxcPUOrWXAelaYQH3oFjLuH3GlOQJ4sUAr0Out?=
 =?us-ascii?Q?Gzv6fDASNpecP1iYh6fhc2ZSoe79MuqQ9zPCK7ylOnULfiSYtiUiIWkMyLHN?=
 =?us-ascii?Q?Hxz0UCbhf2F+XuWjM3rc1DIovheespr2wQ38uxVOF23r6hdI2ex5aT0v/A+y?=
 =?us-ascii?Q?+OYSpkY5V5pwlKTN3lq/YnJ/eapfAIj6rMyqnp0JLoqUdqforOrvCv0ouSEd?=
 =?us-ascii?Q?xUL607QuV2wqC9hSazwFZ1CaWXzy3dMPPD6bMrP5hX1AZERiIJJoCLjDOKfh?=
 =?us-ascii?Q?8fL0PdoMpxX9dQTpp7guDtze4ML1nclvYKScwZ93stw2ZWuFabNl1cD8dKYT?=
 =?us-ascii?Q?tssHJyhJUO/080il7hsn+1augoOz8tziE8qETqfeXRk+jnrZpk66/u/h55Z9?=
 =?us-ascii?Q?H2YgsxIkmWiD4oOLahI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 16:55:26.0617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ac632a-9d04-49d5-ba3d-08de1d5548ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6988
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

Update pmfw headers for smmu_v13_0_12 to include ppt1 messages and
static parameters

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h   | 7 ++++++-
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h  | 4 +++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
index fa43d2e229a0..dd30d96e1ca2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
@@ -189,7 +189,7 @@ typedef enum {
   SVI_MAX_TEMP_ENTRIES,   // 13
 } SVI_TEMP_e;
 
-#define SMU_METRICS_TABLE_VERSION 0x14
+#define SMU_METRICS_TABLE_VERSION 0x15
 
 #define SMU_SYSTEM_METRICS_TABLE_VERSION 0x1
 
@@ -367,6 +367,11 @@ typedef struct {
 
   //Node Power Limit
   uint32_t MaxNodePowerLimit;
+
+  // PPT1 Configuration
+  uint32_t PPT1Max;
+  uint32_t PPT1Min;
+  uint32_t PPT1Default;
 } StaticMetricsTable_t;
 #pragma pack(pop)
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
index fe1b3ac50a75..d09b6ae9827e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
@@ -117,7 +117,9 @@
 #define PPSMC_MSG_GetSystemMetricsTable             0x5C
 #define PPSMC_MSG_GetSystemMetricsVersion           0x5D
 #define PPSMC_MSG_ResetVCN                          0x5E
-#define PPSMC_Message_Count                         0x5F
+#define PPSMC_MSG_SetFastPptLimit                   0x5F
+#define PPSMC_MSG_GetFastPptLimit                   0x60
+#define PPSMC_Message_Count                         0x61
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
-- 
2.46.0

