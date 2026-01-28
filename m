Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867BBD35693
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 11:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D5FF10E658;
	Wed, 28 Jan 2026 11:00:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="49uGWVoO";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013027.outbound.protection.outlook.com
 [40.107.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5D2310E658
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 11:00:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+cxZaba3XnOnymqG18JImAWf4Qk0ujgApVoDd/5qnqUWU/aRcdewIXDxiKSp1pim6pjtMlJdSbvoxCSEgQjsYyq+/XmrhsOlAAWxBchUX5DEZLBM9N+cgSbc51tdCuxyUOS/16d9gZy8DK6PfSsxk+gCYUXwEPDqtTOje63uk2zKjLI2mxO+nk1iH4H6/b8oUT/6qdmMVr6gUTRQc0IwSd18Dd5I63z817mvf4NYEr/AY6RN2QOzsFQiCQOmoP9sqs5RVbYdY2uQ6WfCzYipNl0MA8uVLTNOcXqn4/+NOaeeo32H4FTfzoXAEyUjm/0ANKJE3Yb4z3RQiGC1xmgyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgc0Xt58k4MLxAXdO4nzbCsrwNIIEGLZ32lk7Xw093A=;
 b=SEX+gX56nVoSFypp6s6YNB3FudMTTD2KL9359WNI5ho1+tz9SX9pcTdL7s8oE1c/0tvWGXf9CdYpFeMaxmMXkMTELJsTDoAp9/HV8TUzGGtbUgw2xWhXytbfN3pAAdhFS21mqsCtxpyUnOeCQD8VG5OG4pHD+GVBD9HTJOb6OFk5ND98i+2WDqc4+eWeec/TqHAt/DZeqMYePeCXaQXweoL/q5754i5y8A2O5qZbY5XwbWrHNPFmN3gxd6thjqPhcKjHyHxVkUMXfE9QPF7piYf17L1GBCpBAl4cgSl8i81s0EaswuecGmKP6Ur7cD3Um8WimRM6Yqx3GE9oNFb5wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgc0Xt58k4MLxAXdO4nzbCsrwNIIEGLZ32lk7Xw093A=;
 b=49uGWVoOlWvDAXgCf0Bsop5zE2u0TvTEzPFKoagWj0JmEKlynBFBF+vbz+xAKLqelirzFsFSoKVGYnB14rffbBe/lut062K1CVXAojoBFmoeMZcIjFQG64yohzEvfTd8lOWQ3HE22zvR0nxVX6CuL663uCZAof/3FWR+aIiH5W0=
Received: from BN9PR03CA0540.namprd03.prod.outlook.com (2603:10b6:408:131::35)
 by LV2PR12MB5920.namprd12.prod.outlook.com (2603:10b6:408:172::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Wed, 28 Jan
 2026 11:00:53 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:131:cafe::c4) by BN9PR03CA0540.outlook.office365.com
 (2603:10b6:408:131::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 11:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 11:00:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 28 Jan
 2026 05:00:52 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Jan
 2026 05:00:52 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 28 Jan 2026 03:00:45 -0800
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: validate user queue size constraints
Date: Wed, 28 Jan 2026 19:00:33 +0800
Message-ID: <20260128110044.2898418-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|LV2PR12MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: f159bb5d-31a1-416e-4e98-08de5e5c8147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HGIRtOoocEHufG3qUsk9Fpn65Ya385B0yl63DdLSFMoE+0EzYtwee1diYNc3?=
 =?us-ascii?Q?dlFxqgDdVvFF7aIvN44lKtJBJe4lkE94m0ME4hF6mCdBXTxFDuyAVdq+A2ib?=
 =?us-ascii?Q?2IPE5piwfHasmaWil44QFgNcohvUEdzUn6AhTogn3yKMWJme/XS9plTAkfY1?=
 =?us-ascii?Q?QgY0EDGYuSGQlyM+aRwOFp/RHNOq8ixBPSbEnngVfH0oNZzydBwBeqPDqqe7?=
 =?us-ascii?Q?lBSD09DQeaSnWsLP7Cuih1R0o1JX6AraSocE4PyteD69+Ex40RchuxODMXLM?=
 =?us-ascii?Q?ivoGuqIiJGCPM7abOtHXrVi5b+J0T/Yi44UI9X+TkbKyGXtmuX+vYwaqI3CK?=
 =?us-ascii?Q?UDi2rViisqXOcnuxqc5MLBXkUR/i6v1zlYpxlDa9W/AlM+RO2SH7Y0mBrBm0?=
 =?us-ascii?Q?d1kGGt35+QsPtAFGPRgqvm2iJ35WEenUp1yGoi88G65DCFR/QO+gqy039St/?=
 =?us-ascii?Q?6pA1moCofuQ7X5ZMNOVP+jotdrelkg9GhT5vio8Fw6+ZaBhxFxtZ9S/PQkKS?=
 =?us-ascii?Q?oBlxCauTkdcsEhNqpMvyxO1Z6sKC3BpCk0r4K9fRgbCfaue8NXucbbMhNf0z?=
 =?us-ascii?Q?AQGi6mvWBKWGz/jdN+P4TBqTdfBo4BD7wgdDxlVkTb69h0gwC1vF04zPPe3d?=
 =?us-ascii?Q?mCHaulHtqTGlmz8S3n6iwYlVbl1P1lhn9DbCWs6bVhrMNidCeFmf+DemtGOW?=
 =?us-ascii?Q?TSpYDfi2yWKJwLiqh09wSPZL1LwP2pb85TbEZ5+3dUapT+uceQ3pUf0WovDW?=
 =?us-ascii?Q?Sa4ICbuCNfzIl8fOlyS/x4ZqJyr566kf5jDPRXkDZO+4PMZl8D1Cim3xglJz?=
 =?us-ascii?Q?zIprmQKS6CUzVCPBbaGVL3YUFiWXsbV6+ijvNjViWOKPpF6d8PyFDiQFzJdB?=
 =?us-ascii?Q?ENd3c4NfcRI6F3BygX4wNcz5bhfA0DOOYpqKZ1g0TnrlW1rjJbZTlOPdln1B?=
 =?us-ascii?Q?3WZPmtYuS2bH++HCtof6UEMfCIF2psTIdiIhJLjnOsaTd2aJEJhjvuB96G1Q?=
 =?us-ascii?Q?f/QhUCU0ISfIcIrC+14q4TiX16BspruD007Vy/9j0fh6Q+/PLCMtoIOPhpap?=
 =?us-ascii?Q?DzwlK0NJ7FvQDjKKdVod4aJ5lubmEqLFwBzJsquEWnuzTwSRMhI9qIBAWJKd?=
 =?us-ascii?Q?ACxBimx+x4/PJBZ7bm+wgTDILTFD0+Y6EDlxEGpXiW5qkKFUfhmExOrHjw1D?=
 =?us-ascii?Q?n+RevdXC5hqNGoPCEas/GecHzPdp57xFnm9OrRxxrSRwb4u+YcHRrCzkhH86?=
 =?us-ascii?Q?zn8hx0+l86yUXwONcdqdC1is2oB0OWrE8fM4S/nwmIu3/vE/xDM8kZ7UaySp?=
 =?us-ascii?Q?XRMxSpfHppoKctz3mot+bA6fBQ/qhu535cIt9bLisgd3chjy2a36KUjJit3h?=
 =?us-ascii?Q?8xOAj30ISn1GDASUogshSIM3lqox0qyY1bJ8SdCJAHFkivSuYSYLkyceY1S8?=
 =?us-ascii?Q?X8jH4UhNUBk0e+OHepSKpZ6imbLMpl1Tf//86I+dfHvRvbTJc8zEGHUTVZ/2?=
 =?us-ascii?Q?keSsqQtj5S66W86YvlIRGCUiix9VUpw4qnATfY8FlEHSBed6/avRhIgG3nWF?=
 =?us-ascii?Q?ppoBYikeoCX4gW5TVRacRXoW8lxLM4ZEHpE20byM3KHxcrAv2BVUury9x4hk?=
 =?us-ascii?Q?+7e4CpyNWB6a66kr8euJdSRLWDDB6JFfZtw95X1E1StzW29Yjtbb8k/RWjwF?=
 =?us-ascii?Q?x9q1FQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 11:00:53.1705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f159bb5d-31a1-416e-4e98-08de5e5c8147
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5920
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

Add validation to ensure user queue sizes meet hardware requirements:
- Size must be a power of two for efficient ring buffer wrapping
- Size must be at least AMDGPU_GPU_PAGE_SIZE to prevent undersized allocations

This prevents invalid configurations that could lead to GPU faults or
unexpected behavior.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3003aba22e1d..998e1fcc0034 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -864,6 +864,17 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 			drm_file_err(filp, "invalidate userq queue va or size\n");
 			return -EINVAL;
 		}
+
+		if (!is_power_of_2(args->in.queue_size)) {
+			drm_file_err(filp, "Queue size must be a power of 2\n");
+			return -EINVAL;
+		}
+
+		if (args->in.queue_size < AMDGPU_GPU_PAGE_SIZE) {
+			drm_file_err(filp, "Queue size smaller than AMDGPU_GPU_PAGE_SIZE\n");
+			return -EINVAL;
+		}
+
 		if (!args->in.wptr_va || !args->in.rptr_va) {
 			drm_file_err(filp, "invalidate userq queue rptr or wptr\n");
 			return -EINVAL;
-- 
2.49.0

