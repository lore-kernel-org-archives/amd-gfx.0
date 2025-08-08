Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366B3C87FD3
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 15:15:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D164810E963;
	Fri,  8 Aug 2025 15:15:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dco/S450";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 425D810E961
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 15:15:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGufS74MTwLfevAA8Ao5MRk/2FupmKh97rr8qHZ+cObojl3Cgm9r9xPYLexCWHmY+qAK2WKjqHkg7Ou2pA4JRdFLxcuBtu46s1aqW7JtRtAgM99AbrdObEkHuURZX8ySjFshAKI9lq8gHrF3uTxXiz4mqECWJJbbN73nnE45anvhdCydwX6kclcZ9MSBagJlwVWc25YV458y84Y3VdxOp6JAvpzte2+D3RFHuJ6AuuXd82amlt7aaGPck7pye4CorP7UDLpck2Hb7P3YzgsOH0/gRERm0xe2UKGOpNoAOqWowrps7VtHF+0+nRgktzL1EIyAh23S81OiVX7wWH/JqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8mkTXd1tkZr5gGl8xgJLhDd3Sc7aVhdp26qeaqXxus=;
 b=Q7ECZcLtApQ9mcDLFoY0rgy5WPmz7PzTKuoQswhijvmcG1A5rehTSdG5mfqM49VxmBjN4c5hGQXNeAzYybk6S+ilPluv9uCtXa3pj00D3GMvz9JWd5fKcq/IOX3Ytq2uSkzeTdekPhPCtkqd3TiA7zOONabLScTroiyWX4z/zegE+8gljZQCFrrbXYgIwLv+TFMjYruWRgK51I/XUSpp12/5pXgnhmb7sOfK/EbW0Et3llvaQ13Mn93BxxJ9XQlcgLuUnioiSD6WFE4bhEHkeIjak9lpvYcWq28rx9y8skA4grB5rnCrB8VY+pK5wTugQUvOPkP1hrorGF5c91C0XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8mkTXd1tkZr5gGl8xgJLhDd3Sc7aVhdp26qeaqXxus=;
 b=Dco/S450LHOvSv9fgLo4v4WJAn5k/PhEEGMiOr8uUeksp7lDYXwfcDUFRkfzGM3wvTitamocAszPTnA3bIRIe/+c0jtXsIo14Xb/Huzv24xNF04MDUNQabPxi++RQA9T8YkORTcT5h+Jl9LFk5UIexAFwYTnXZchFVr8i7hqsIo=
Received: from CY5PR15CA0102.namprd15.prod.outlook.com (2603:10b6:930:7::12)
 by DS7PR12MB8419.namprd12.prod.outlook.com (2603:10b6:8:e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 15:15:39 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:7:cafe::26) by CY5PR15CA0102.outlook.office365.com
 (2603:10b6:930:7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.18 via Frontend Transport; Fri,
 8 Aug 2025 15:15:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 15:15:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 10:15:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, <stable@vger.kernel.org>,
 oushixiong <oushixiong1025@163.com>
Subject: [PATCH] drm/amdgpu: drop hw access in non-DC audio fini
Date: Fri, 8 Aug 2025 11:15:17 -0400
Message-ID: <20250808151517.1596616-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|DS7PR12MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: 69bed0de-d877-4c9b-c2e5-08ddd68e6f1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XlEA0OcpfuoNc3KQo6EcHK5Xr6K3XawbeneUoxn34HSxY61aR1mZbWRk00V1?=
 =?us-ascii?Q?M2Lvn1pSSOHi8tw8u6Fpmw7/3YocOoGuAWLK1nEmGEif3KHZkt4x+q2IUokO?=
 =?us-ascii?Q?NNbIR0JzawCcgmqLEkphe0gzYtss2xRkvUlV9cd816hU/0cc9xQW7c31hQW5?=
 =?us-ascii?Q?tEHwF9KOHzyZvDD4Q4VcRL5P3nnSMX6/ICF462z5pLkx41p9DB3IQGNiomA6?=
 =?us-ascii?Q?sILDnSoL8H89pQmnXbb3dcF+4Kz5J2J9fHW+VCjrVXp5rblGw78Aymm1mzQD?=
 =?us-ascii?Q?vV87hwYEdMqDrcQi4F42okY7zH0wHWTTHRuFK23HPVd1PRid7bcpubA6eJ1v?=
 =?us-ascii?Q?xtZNyOPAUxAzyxpDVn7uxSH3k7Qe32RoJSezK8/T8W33oPczN1EShYQCj1aI?=
 =?us-ascii?Q?EMvCqS7tX/ccyiG8pHVizEYAD9ia0+2S5YQgUQgBxOTlayWCRfF8y5CzuEOO?=
 =?us-ascii?Q?1hVVZpJ/S3c31qPvw8f8RyMVKslhAAp7/diUYyRgZyRs81f4eMtTiC2wEocc?=
 =?us-ascii?Q?P82LEgcNJDLP97y6mDdkV6Tv3mRzHNZ/Ec5/adF/CRXiX7tchJ06ktDcREVi?=
 =?us-ascii?Q?+qq0ZOr5PSGPiKHbQL54+dM50fVuwGH1CiCs2ruCii/hWsySyMQ4sHDw2b3q?=
 =?us-ascii?Q?zLamadlKOObKZPGo1pTzBMYffZehonPkX/yiPa2wHaIgjxAT3jsJYnF2/x6G?=
 =?us-ascii?Q?pyI+dV7hgpq5hIrSinlc1tb3fi22QZ3MGcYcvay1g0pK0RLh/hOFCa/pyQJp?=
 =?us-ascii?Q?RDdXyGdG3sFcVN/ESa6cAgy1fmha4EH8wo0YAGHvn+vLk4HmXV1n12gf3154?=
 =?us-ascii?Q?+B5+oWAocqo+j+bJWGIY2Gz/ywWiwAzgSU0NmalN69AeTXma3jAs5L8+UCSn?=
 =?us-ascii?Q?JHaY5n+x/NiHTAolwm5yUm74e/2bfXIhVagoSMIULhbCrpcw9bIouva+4da+?=
 =?us-ascii?Q?t5LjpFBWouAnJ2IzJSGnJWv8j0VeLfS5eKdzO43XYpKViEz2SoiTkZTDktlg?=
 =?us-ascii?Q?NoaL8B4w8yzCfZqwY/aROhjFnVrTd34L1LAl85gKgzvqA/8mCLsV3S7apmyV?=
 =?us-ascii?Q?CirC+I23jK41+/ql4E1qUiJHbjmnUXvIOW4Ic4Yy2/SLPUYl/RVN5edFNAzD?=
 =?us-ascii?Q?ZCicRH27BLJtfJiF4Jvfj738PqYRO4kqUvKcIC/lG2ZzhBI2YiUiMn29Kmvl?=
 =?us-ascii?Q?tgS8AygXrU94yNGGzHfFEGd8YefQqZsb5l373S60XQt+0no5ut48U6A20urD?=
 =?us-ascii?Q?yOMlfJ8RHtc7KCqwRhwV9C0RMQNoKpMGWW8uom4pDiQHUfITy9OCTrZ3dVUv?=
 =?us-ascii?Q?REB9kV9Ok5qd7DIB9hoepMflSl3hg8vvC7Xi3wFrydqbQg9Ps/LGNViJCmwn?=
 =?us-ascii?Q?OVeHsCUIPMCmMIJg54qO04wY/2cOHXrplXRhgC2Yzsg5ML0ENjR7UEWkd8uJ?=
 =?us-ascii?Q?RhktSho5ycDgxiuBVGqn3mfHtQ9+5q1JHIiVsBeHOY/RvjYWv0i7mw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 15:15:39.3577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bed0de-d877-4c9b-c2e5-08ddd68e6f1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8419
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

We already disable the audio pins in hw_fini so
there is no need to do it again in sw_fini.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4481
Cc: stable@vger.kernel.org
Cc: oushixiong <oushixiong1025@163.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 5 -----
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c | 5 -----
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c  | 5 -----
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 5 -----
 4 files changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index bf7c22f81cda3..ba73518f5cdf3 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -1462,17 +1462,12 @@ static int dce_v10_0_audio_init(struct amdgpu_device *adev)
 
 static void dce_v10_0_audio_fini(struct amdgpu_device *adev)
 {
-	int i;
-
 	if (!amdgpu_audio)
 		return;
 
 	if (!adev->mode_info.audio.enabled)
 		return;
 
-	for (i = 0; i < adev->mode_info.audio.num_pins; i++)
-		dce_v10_0_audio_enable(adev, &adev->mode_info.audio.pin[i], false);
-
 	adev->mode_info.audio.enabled = false;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index 47e05783c4a0e..b01d88d078fa2 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -1511,17 +1511,12 @@ static int dce_v11_0_audio_init(struct amdgpu_device *adev)
 
 static void dce_v11_0_audio_fini(struct amdgpu_device *adev)
 {
-	int i;
-
 	if (!amdgpu_audio)
 		return;
 
 	if (!adev->mode_info.audio.enabled)
 		return;
 
-	for (i = 0; i < adev->mode_info.audio.num_pins; i++)
-		dce_v11_0_audio_enable(adev, &adev->mode_info.audio.pin[i], false);
-
 	adev->mode_info.audio.enabled = false;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 276c025c4c03d..81760a26f2ffc 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -1451,17 +1451,12 @@ static int dce_v6_0_audio_init(struct amdgpu_device *adev)
 
 static void dce_v6_0_audio_fini(struct amdgpu_device *adev)
 {
-	int i;
-
 	if (!amdgpu_audio)
 		return;
 
 	if (!adev->mode_info.audio.enabled)
 		return;
 
-	for (i = 0; i < adev->mode_info.audio.num_pins; i++)
-		dce_v6_0_audio_enable(adev, &adev->mode_info.audio.pin[i], false);
-
 	adev->mode_info.audio.enabled = false;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index e62ccf9eb73de..19a265bd4d196 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -1443,17 +1443,12 @@ static int dce_v8_0_audio_init(struct amdgpu_device *adev)
 
 static void dce_v8_0_audio_fini(struct amdgpu_device *adev)
 {
-	int i;
-
 	if (!amdgpu_audio)
 		return;
 
 	if (!adev->mode_info.audio.enabled)
 		return;
 
-	for (i = 0; i < adev->mode_info.audio.num_pins; i++)
-		dce_v8_0_audio_enable(adev, &adev->mode_info.audio.pin[i], false);
-
 	adev->mode_info.audio.enabled = false;
 }
 
-- 
2.50.1

