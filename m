Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA07CF9C7C
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 18:21:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDA7310E7BB;
	Thu, 20 Nov 2025 18:21:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YbbONK81";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8A2310E7BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 18:20:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLUa8P/F9/xVtXbpp/bM4Ht2ds1blOftexnhEXKfin6Qude/bLdXdn1gXbzwdwbaeFg/5iH4KjuZQOkCaJrSHuNpvcam/BAoyvpoRiN8MjQeIOe/okI/8joyzba7lO2sWoPw44dYJMY+8LY2HYFs43/0I5RLuTXCsthmykHumqH7fIbQItlQUWMvtt848usccCukVJmWpI2imeTzSGTTvtyJNd5HRWXkzv80YqBp2FJTnUz2m+W2NWJ83tmirf5aSw67eECEcBuiGYWa4jI/8HgyzixvDodR/2Q3zp0EfJY+uYW8rzpbRDYUjkmI0qhjFN9KS41XKTeJHufGkg2+eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1V3jAyNNYxfN4b49htYz77MQhQoqBMAKJLIwz3g+ChE=;
 b=cUhvlmOtAg7ix8wD7bdcwG1+GJUR1SLWP0MBgCmOZk08YL0dmosAErHhTw1Y3AN9pNwCv5QFCSdGnjgwC0wUYqik7s0DpDcnIe3RVhvbqqTyCTbefi9dsgnAt85kGmEl6bJomYdbAHNYoNYDYVuCt7sAssoH2TJYQL6e6mMAh1p3OcLoEdQGmCYZzxtOIKGG8jPNumScYfTOZM2l7iuTC77DQN+3glUdm0NbEK+6inPD+roQBVzzrzotb7uADoX/p/q0A0lXDsMLIkUpWI3ocREpilDHDuB3lyipaGeOB900gP9yWoW8NIEAhbyX2eoLkyvIv6HQunOwQVsfZ5eROA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1V3jAyNNYxfN4b49htYz77MQhQoqBMAKJLIwz3g+ChE=;
 b=YbbONK81EXOFkrbs6YxZH9LUoWAUXOhV+d8aaGiHMm8dH3ktyUs8cJUeBxDPqw+9fCCdP6yD6/liPCoCZB3UmJmBaOdwI+7wyB16QK6gW1CRg6nXVrtCRqDUKUm9fczxg9HTAZ+4DH+40WcigZpY4Ggf2ObZcCAsTOyUG6psTR8=
Received: from DS7PR03CA0102.namprd03.prod.outlook.com (2603:10b6:5:3b7::17)
 by MW6PR12MB8952.namprd12.prod.outlook.com (2603:10b6:303:246::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 18:20:53 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::3c) by DS7PR03CA0102.outlook.office365.com
 (2603:10b6:5:3b7::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 18:20:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 18:20:53 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 10:20:51 -0800
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Austin Zheng <austin.zheng@amd.com>
Subject: [PATCH 16/26] drm/amd/display: Rename dml2_wrapper.c to
 dml2_wrapper_fpu.c
Date: Thu, 20 Nov 2025 11:03:12 -0700
Message-ID: <20251120181527.317107-17-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120181527.317107-1-alex.hung@amd.com>
References: <20251120181527.317107-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|MW6PR12MB8952:EE_
X-MS-Office365-Filtering-Correlation-Id: 66dcf0db-7781-46b7-5b3b-08de28618a70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I2HLgVDRG6mi/WT9jU5+eiAL1QDvXJwru/jHZSn06P/fxefWV8wqzZoV33VO?=
 =?us-ascii?Q?LHWP1QUbsugtzV4MX1JuOkopDsS7tDGbuGPN6qEa2+YCt3FcWf8+UbZVE16R?=
 =?us-ascii?Q?rBp+exS/ZtfNkPMzSRLgzVGNtCU62qbNBQt/gpUcdACKNQNQwWQGx/p628Pz?=
 =?us-ascii?Q?Aa2Kc3gRzDRadTn2uKh7IwUvkfh6Pf0Uag3/0BE3FJnuLscdKkAPPWZguFDj?=
 =?us-ascii?Q?mgFGOE+J7R2Op+F4dsMPv9w7U074gMtk0j+mgWkNA3jWSJF1SLmozYT+Gbs5?=
 =?us-ascii?Q?GmTxrWGLVJgb23PFtlgdHBIH9f28hu8iwXMvm4h1fYkzCtM/wKJ6BezuhKJi?=
 =?us-ascii?Q?EHsyT6l0syJQZRMiLwZpapeHPnypW9kRCVL6LHwrNmpAmDCTpXKQs+Mf7YTE?=
 =?us-ascii?Q?DvoX30QtucICopBr1obPpbbRSQkhl2vUMLEHMNsbqfzqHe2cDskWBdlQGMb5?=
 =?us-ascii?Q?ec6H4FcLr855eXDRQVlAya4WTX7Skj6fL1WkToxTBljiHKrEPNiWwfuFXFDt?=
 =?us-ascii?Q?2vGFlUv2PUWY55iF1W8MqgPjhs7f4wAbDl+niJoW2XcxWTG7zsqrcpoKTnKe?=
 =?us-ascii?Q?piHEjn/1sILdFOZu3qECfEUPzFyD+C3aSOFjUoHQ/PC01jhWtybn1v4ijTVW?=
 =?us-ascii?Q?Vl0GT/24gZYORwktsuLeiKOEuRheZF0Qgec9Dzyr8/Wme5DMBB63tGFqpucM?=
 =?us-ascii?Q?8InMpbC3qh44AU4MVSetQNdXDLUEaUdlwvOjZKYB7Z4rZR3a/ABMAUXtCFHe?=
 =?us-ascii?Q?TdCE+eYZuWYTagp1ExFh25qHp6FPhj1lc33xzIBXyLdDHbyUvtJPhXi4Y1nl?=
 =?us-ascii?Q?FbomSaACJde1/jbWemkGz76usxMdrx1sQQxU/5hbt9RH4tDeDzsm6OJIQg0G?=
 =?us-ascii?Q?zXhwc/gnKFcWxGNYhdd74HoedRBuuSKA7fIgchJ++kdv8IeqLNJIKA87q9Ax?=
 =?us-ascii?Q?d9ylB0z5OTBSjUWhwpf1hk4Bbyj5aujMIvOSoO7zpiFokZqquxaP9GyPZFBH?=
 =?us-ascii?Q?IDsRhWDOikR5wVbv4wfKOgbfJ48fAyjtoqmw4eJojQOct0ko3WwZSkIXkUiq?=
 =?us-ascii?Q?DkSQgVTM3FfkZ6ABq9IBKujnwd4ARy+gYv1/HSDJeQCmcYwUW9A9g4nLDqG8?=
 =?us-ascii?Q?vQEvmW4tZYr+NnGEOypWL5vQNXTM/9l1c/fkG3IdpDqFxf4zMM8cCPnSU42t?=
 =?us-ascii?Q?qVDprNKAR7Z8x4TF3X6YCypq4HevP18EsNJ+c1FOIqqlDwg1oigauzEkYYJi?=
 =?us-ascii?Q?RQbXPgVtcjBEo4FoviGdZeTdqh+SgU/LCp7biSkEPQBLrLtJSvR77QegkWst?=
 =?us-ascii?Q?kQKmNJ8yq25uCofUDe4gsQzxjjPp7asuch+mRa/ETeduOKvm8UdvjuiVdJ21?=
 =?us-ascii?Q?y7YrHBwlMtKWFSgup21EeLFjPFN/fIcNnwyN4YDEY4Y4pJqlliNgfOzBOrTL?=
 =?us-ascii?Q?AGQDRgQ9OuwK8wkb4HpN7ufCLaN2AY3kgFfNprDYAj2rcetuGDrth1KPELqy?=
 =?us-ascii?Q?OcXWHmp6WwjkkxwjphEg0kC456uTLmOAldpXDSVR71I3N2wrAxHXWU3V2sB+?=
 =?us-ascii?Q?fpEsqo6i3cP0gvsKKOg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:20:53.1926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66dcf0db-7781-46b7-5b3b-08de28618a70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8952
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

From: Harry Wentland <harry.wentland@amd.com>

[WHAT]
This function is an FPU compilation unit. Therefore it's not
allowed to call DC_FP_START/END functions. It currently does
so and we'll need to move those functions out. Therefore
rename the existing compilation unit so we can introduce a
non-FPU dml2_wrapper.c.

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile              | 6 +++---
 .../dc/dml2_0/{dml2_wrapper.c => dml2_wrapper_fpu.c}        | 0
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/dml2_0/{dml2_wrapper.c => dml2_wrapper_fpu.c} (100%)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
index 97e068b6bf6b..a112931007b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
@@ -55,7 +55,7 @@ subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dml2_0/dml21/
 
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/display_mode_core.o := $(dml2_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/display_mode_util.o := $(dml2_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml2_wrapper.o := $(dml2_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml2_wrapper_fpu.o := $(dml2_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml2_utils.o := $(dml2_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml2_policy.o := $(dml2_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml2_translation_helper.o := $(dml2_ccflags)
@@ -65,7 +65,7 @@ CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml2_dc_resource_mgmt.o := $(dml2_ccflags)
 
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/display_mode_core.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/display_mode_util.o := $(dml2_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml2_wrapper.o := $(dml2_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml2_wrapper_fpu.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml2_utils.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml2_policy.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml2_translation_helper.o := $(dml2_rcflags)
@@ -73,7 +73,7 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml2_mall_phantom.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml_display_rq_dlg_calc.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml2_dc_resource_mgmt.o := $(dml2_rcflags)
 
-DML2 = display_mode_core.o display_mode_util.o dml2_wrapper.o \
+DML2 = display_mode_core.o display_mode_util.o dml2_wrapper_fpu.o \
 		dml2_utils.o dml2_policy.o dml2_translation_helper.o dml2_dc_resource_mgmt.o dml2_mall_phantom.o \
 		dml_display_rq_dlg_calc.o
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
rename to drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c
-- 
2.43.0

