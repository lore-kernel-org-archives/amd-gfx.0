Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4522CEDD9E
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 14:25:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4884910E741;
	Wed,  9 Oct 2024 14:25:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ICPi3cnz";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AB6710E741
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 14:25:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llna6hBcGU3KlPwI4ivq7o36YADGOm8ofUNUaWHx2NVUxTIXZDZIoPItdk6BxF11Z9YUlFyspH9dhXD5GZ6amEsXvjgmOgWpXQEuhrq49KOCyG2j3QA1HZbUPuiaMCeeQ3VXV52CQfidYJW/ks23H7n5ci/rg4WwGD/A18UP/0+x4q9kUaBvfaAFdqSdsXdzCvPNr67kL9bW7cT8XyVd+cgIB70O9UTJRwAL3uOCmhzI4qBsTE8iNryOcuJl/OZrirFGJ5dcG5Ej5SZNj+78k+xADCBpPaqKO2pipG55H2H2lKnsgnnwrl+5FL22Q5wcyhP2X2yBjDAWwJS9qP8aDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sR1RIJsWw++GA2glmPxZEFwrQulmCrH3Ue13VxoxzM=;
 b=pVkQqXI5aiDqXVyWsGMNGnrOQV0WKuCWBzVa6EXlhu8ijssjRmR/mYDVMpFxBDOv7VHMnvFQQp8BY++PtUvnN+Qq9OL4RNbhbHR338B1lOCIqsMqpQdB1/e0kU4feGHtTigOY5Jf8B9gjbFNmIiFW/qwv/P1gE4FV6Ra2HcQQ+uDrS3sFXcBYEBXkagWFzvbj9P6LLTnQNmY4LEf5wqMBy2eAMFJYxDrzbph/CbGDJSLczK+ytPk5W0h37It5n8ssfOlpL9cCEgrg54UZyyNUL07dQ0ZPWiuhiw0dVS33Ev549+jLhFwcEyxg5ZlKTECxpZH+57L5bnT+1ol2llc6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sR1RIJsWw++GA2glmPxZEFwrQulmCrH3Ue13VxoxzM=;
 b=ICPi3cnzPmOKCEnPB2g6taaOLMCwKWtMa3v4HSnIMzZLGKo+9fKBWLAt7a3vUghKdyfdDRQt6TAQPOZRbH+WwgxzLFq0FEk0nGVKkMmn6z6z2KvFGgCdDDq2YccHmihrZw0Da5EbWLoftRCZAzk9BGyLm+2jVSp+K6iVqUXSpkc=
Received: from MN0P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::35)
 by SA1PR12MB7197.namprd12.prod.outlook.com (2603:10b6:806:2bd::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 14:25:39 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:531:cafe::c9) by MN0P222CA0027.outlook.office365.com
 (2603:10b6:208:531::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 14:25:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 14:25:38 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 09:25:35 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: Add hpd_source index out-of-bounds check for
 dcn3x link encoder creation
Date: Wed, 9 Oct 2024 19:55:18 +0530
Message-ID: <20241009142518.548229-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|SA1PR12MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: 732182f4-84e1-4ce7-ede0-08dce86e3f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AEfvwK6TNrS5h/LLnfraCR7V8UEdNP9N332YoBzsAyIlkje/mCiZDezLEgjq?=
 =?us-ascii?Q?DNQa0C/XtKBT8swMgm9I60YmCWUWBOrY/ujHyJ9V2Vxe7gLhYWTPl7H4Mtvp?=
 =?us-ascii?Q?cRWhJLnV4hTXWC+KZjNCq1tqiV1KaXnuOGiGCTtxJJcZBc1C9Ogp9ZP6n2on?=
 =?us-ascii?Q?1VIwMmiTsEt1EBZuAV2ZHXLIX6FQ2N3o/XJcNAULhArBQkMQdKpck/WgVmdR?=
 =?us-ascii?Q?wZlbXGwp/xBe1y+k4vp6KU8HCnivXfSIKMySrNO4m6YbKklqiOojNIK8i3rF?=
 =?us-ascii?Q?z2hCzryPk4+1pF3nz9WP8K/1OpUU7IJNaViIV2jDqDl/K5ecQQHr7zqdJB2C?=
 =?us-ascii?Q?Gts9PZaeD0759WwtPif3L341wAMYeuAuW3i7E0QbyMQFRxzK89SCB2Y1diE1?=
 =?us-ascii?Q?HGCeg57xCzltDsf5+P+MYZ1POBvUp/rw3fSj40A7xGLhV3xbEbeoH19Jv4jK?=
 =?us-ascii?Q?DBKhtDP4w3VHiUHRDqJWeh46J1HF7S427WoSb/GYOw/2PDvwKF/pxNW5f2e2?=
 =?us-ascii?Q?EBtiZF4vp06JlCqIhwvjeeGt+BK7oyrnIHmTi1htgNVVbwHbI3hMJaiYbSto?=
 =?us-ascii?Q?Cg7x4SxH2OvdPPYvaYI//GLPlS6lPL+0gjtcPKlmHpEE4R3DTdTYDP81BArx?=
 =?us-ascii?Q?MzhGwR0r0WmPhyX1f6HhP7tDz9JxpguSjZHsK4e4zgG9k99mW7YMaFxUcLYP?=
 =?us-ascii?Q?tWR0KGbdhtS/yIHp9vuCzER+xIbJx5kQcHoR4BYBTK2fxdR8DOFhqqLDnsnh?=
 =?us-ascii?Q?XfM1uPka1p4VYpNschbIWJTc6eyltHhbb7RTSjaniwGh18owkIVyYlYmsRUv?=
 =?us-ascii?Q?tUEtHyCfOs/jOzke9c1FcGKYN6lzmonvHpAqdQ5nixm9rQ/R7UyCFIeCXBph?=
 =?us-ascii?Q?WycefMKXxPzAww/M1huGspg2b/wsqfU28HgLpwLmWKapFsaJHkf2Gvuj2mF7?=
 =?us-ascii?Q?IVRhqqBf+wqAg+ZgPUu4vRByAb/J3EIE8aKmgZnmn7GfGCw181CeEz5A95f1?=
 =?us-ascii?Q?ZfyFkOgMbiJrw8+yBMSii/mJO4yRSQJo/REVxJgIdydjhChqxrIHNn3c/tsa?=
 =?us-ascii?Q?Or2z0gLFCi5Ikv1ul85hVkSwyXEcpuMZB9DVIdoUPoym5YhuojKvHivVR9GN?=
 =?us-ascii?Q?Y+la+3WcGQk9v0xrlfE+weTim1NXIw+Mw8FukIXu7AW+3zzZa6jM/3s/GKHl?=
 =?us-ascii?Q?8owJDAE9xSVtlON7eVoz+WS19PY+g+8RM10lG5Yp3EciFGFG6tV3FlUFWJeg?=
 =?us-ascii?Q?JdDlhmCfWR83FtsV6Ht5vOi0K1pFAs9LvM66Z3of818kWj29dE7dJmgndSnB?=
 =?us-ascii?Q?8St5jcmnl1V8BvN+xttyXofH5wKUdkdrUdfrQnDJpEMwrRYUVW+Z+5h0nBMk?=
 =?us-ascii?Q?F90eJuZX5nQtCGmBafzyT6eEQvQS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 14:25:38.8356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 732182f4-84e1-4ce7-ede0-08dce86e3f81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7197
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

This patch adds a boundary check for the hpd_source index during the
link encoder creation process for dcn3x IP's. The check ensures that the
index is within the valid range of the link_enc_hpd_regs array to
prevent out-of-bounds access.

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c  | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c    | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c    | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c    | 2 +-
 drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c  | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c    | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c    | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c    | 2 +-
 drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c  | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c    | 2 +-
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c  | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c    | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index 5040a4c6ed18..baa4e2647dad 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -927,7 +927,7 @@ static struct link_encoder *dcn30_link_encoder_create(
 	struct dcn20_link_encoder *enc20 =
 		kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
 
-	if (!enc20)
+	if (!enc20 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	dcn30_link_encoder_construct(enc20,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
index 7d04739c3ba1..d8a7c2cf05de 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
@@ -883,7 +883,7 @@ static struct link_encoder *dcn301_link_encoder_create(
 	struct dcn20_link_encoder *enc20 =
 		kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
 
-	if (!enc20)
+	if (!enc20 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	dcn301_link_encoder_construct(enc20,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
index 5791b5cc2875..40c20b04635a 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
@@ -893,7 +893,7 @@ static struct link_encoder *dcn302_link_encoder_create(
 {
 	struct dcn20_link_encoder *enc20 = kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
 
-	if (!enc20)
+	if (!enc20 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	dcn30_link_encoder_construct(enc20, enc_init_data, &link_enc_feature,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
index 63f0f882c861..daf1b65fd088 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
@@ -839,7 +839,7 @@ static struct link_encoder *dcn303_link_encoder_create(
 {
 	struct dcn20_link_encoder *enc20 = kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
 
-	if (!enc20)
+	if (!enc20 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	dcn30_link_encoder_construct(enc20, enc_init_data, &link_enc_feature,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index ac8cb20e2e3b..36bb26182e11 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -1093,7 +1093,7 @@ static struct link_encoder *dcn31_link_encoder_create(
 	struct dcn20_link_encoder *enc20 =
 		kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
 
-	if (!enc20)
+	if (!enc20 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	dcn31_link_encoder_construct(enc20,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index 169924d0a839..58a5fbcf22bf 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -1149,7 +1149,7 @@ static struct link_encoder *dcn31_link_encoder_create(
 	struct dcn20_link_encoder *enc20 =
 		kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
 
-	if (!enc20)
+	if (!enc20 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	dcn31_link_encoder_construct(enc20,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index f6b840f046a5..3acad708c31b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -1091,7 +1091,7 @@ static struct link_encoder *dcn31_link_encoder_create(
 	struct dcn20_link_encoder *enc20 =
 		kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
 
-	if (!enc20)
+	if (!enc20 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	dcn31_link_encoder_construct(enc20,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index 5fd52c5fcee4..ce56f5d162c0 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -1085,7 +1085,7 @@ static struct link_encoder *dcn31_link_encoder_create(
 	struct dcn20_link_encoder *enc20 =
 		kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
 
-	if (!enc20)
+	if (!enc20 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	dcn31_link_encoder_construct(enc20,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index a124ad9bd108..a1890df29f5c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1039,7 +1039,7 @@ static struct link_encoder *dcn32_link_encoder_create(
 	struct dcn20_link_encoder *enc20 =
 		kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
 
-	if (!enc20)
+	if (!enc20 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 #undef REG_STRUCT
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 827a94f84f10..35acc13cb5a9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1035,7 +1035,7 @@ static struct link_encoder *dcn321_link_encoder_create(
 	struct dcn20_link_encoder *enc20 =
 		kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
 
-	if (!enc20)
+	if (!enc20 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 #undef REG_STRUCT
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 893a9d9ee870..795f2c71c70f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1074,7 +1074,7 @@ static struct link_encoder *dcn35_link_encoder_create(
 	struct dcn20_link_encoder *enc20 =
 		kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
 
-	if (!enc20)
+	if (!enc20 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 #undef REG_STRUCT
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 70abd32ce2ad..0b8dc2eff596 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1054,7 +1054,7 @@ static struct link_encoder *dcn35_link_encoder_create(
 	struct dcn20_link_encoder *enc20 =
 		kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
 
-	if (!enc20)
+	if (!enc20 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 #undef REG_STRUCT
-- 
2.34.1

