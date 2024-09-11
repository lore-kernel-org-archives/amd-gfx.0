Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7AEEE57C2
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 16:24:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E514A10EA55;
	Wed, 11 Sep 2024 16:24:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WiWK1h+3";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BC5610EA56
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 16:24:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f611mMjGHRgx4xYKrFStSzST6hnPNQ+mwVnukCdyhxwDcUVHMX+jsc0jv5ilLmlORi6cHWUlhvHGRyfAJi7l0BPuOMrbr1gdNvRi84UZstzv5rNa06w8UPc/9tp3SiP8jGlLkxjgfueSCGLATuZtourMsxYynML6IqfRjYevCAsETez8+nNVIMhf8owIvXUk4Or+sT2l3+1dFpTbEAgcsnSNTdHDcYksUo1mnSc/D/aKvo+rkaRHQ9HnC5TRUqiNuzHPw37gdnDp+qquhIyrBc4HkiedtLuDJVDAKg9dGOrCyLyJKr2CLVNyVY1z7JcOv1Ajpd/uV1/YIHU7jLVYRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjwVwItlAPaVmCsaXcbmjLVtJyEMfAXuFaEAn6AtBUU=;
 b=Pd6UXxYLupVBn26bsIMlk3zdKbj/AwaTziPWdgaN6c1RVcZ0bTWVHpwceBPOIqaD6VK7YXaLo/47tHasEKw3iYckfbMuY1kS0OxWnJV0worLjNOoveWL22D0mee3v4QKm/3YFQTficRsnQkWJxdr2gwzOGZRNJv16ssaXvhdhT4wIGMlo+QZ/OHHPbcC6d/9IEzp56rfv/56NxEk1QDw9Eu9M8ejL9V1WM8+bNZ/umzoMZ3bf0LXubkUnVh2JbhwS4IhMtTQGMS+JUCEyXYSAGVr/FbDzC7aZe1C6OGaQn/psCXmBE64EcVB6/Zn9Pt0p7hpuFYVU4Q66qPMsT1wWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjwVwItlAPaVmCsaXcbmjLVtJyEMfAXuFaEAn6AtBUU=;
 b=WiWK1h+3KYhENDD715lFjNN+9HGQ9SRNNOxjHTPT2EEUl+wAk+qa0+qYMgGu5ecr///dEZsnvl3cwD3tWbNhym8Ixyg2y+h7g87IynTBeceomwalI+ix3RO9ssGj5g/67HVWsRs0LXbLT1lZZvpEWtAdlUiRhySI/OnpWlR4k38=
Received: from CH2PR18CA0010.namprd18.prod.outlook.com (2603:10b6:610:4f::20)
 by DM4PR12MB5841.namprd12.prod.outlook.com (2603:10b6:8:64::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Wed, 11 Sep
 2024 16:24:11 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::72) by CH2PR18CA0010.outlook.office365.com
 (2603:10b6:610:4f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Wed, 11 Sep 2024 16:24:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 16:24:11 +0000
Received: from shire.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 11:24:08 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Sung Joon Kim <Sungjoon.Kim@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 11/23] drm/amd/display: Disable SYMCLK32_LE root clock gating
Date: Wed, 11 Sep 2024 10:20:53 -0600
Message-ID: <20240911162105.3567133-12-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911162105.3567133-1-alex.hung@amd.com>
References: <20240911162105.3567133-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|DM4PR12MB5841:EE_
X-MS-Office365-Filtering-Correlation-Id: 326d9611-afa2-47d8-8163-08dcd27e2b37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fLwcGH6Xw+vn+t7OYSLHrf6fWjKMHWJV1miMKKfv0ARLadqeNMiPyAP/Eg68?=
 =?us-ascii?Q?/yT+7OnJOXfXayUj3VA+U6zk/N/HGREOIFbowVJKot5prJWTs+kKZ6qQOAYK?=
 =?us-ascii?Q?M7AGRhCAKY14UHTysa+pAxLdXOIhgUCwhr2Gikb+2TxKU7KKx7pAj4en+WZg?=
 =?us-ascii?Q?mWS3Q8E+0dxObbtYN2ZFDEgeZ6D+OIncbiRF4Q2JBD1gkwUTTtRJ4Xn5XsNn?=
 =?us-ascii?Q?ur/TwWdTc6fNUjvs9lkd3FSck4x+6VgPHLSdwM0yZO0qFDFOYdR7AAm+IWtF?=
 =?us-ascii?Q?kekENaQdLxjPe9LsM7hjs8kaEA+j1U5aU/2EeqeuCo8U2V/KAJysIeDLW3qU?=
 =?us-ascii?Q?lyeEQfGqmMs55XpX2i6Y4dFtRHPX4a5zzgGhz4V3t/UsVQQvexy6h14nKjiL?=
 =?us-ascii?Q?a/EK8WWg9DzjwF+0gC63iRGUdSt6qR12+6Kt85QMmQFsEKh9Z88VutY2isRC?=
 =?us-ascii?Q?86mIz6iZAA+qEx1XHzkEi1XIN57UVpFa83L0BwhyAs/ff3FIqmrzIn6oy3Wm?=
 =?us-ascii?Q?KehRLU08OsCcXrkXNQka9nP1zA/dU97ARMaEbOz7+3cp7jM2hlRjWO3GiI7T?=
 =?us-ascii?Q?R4Rbrfbbc6McBj9LebPsWYGKFj3Mw4u1yIgRLjBjd1/ROGhzTSXj0mEDwxgf?=
 =?us-ascii?Q?E143WoChx/mizo8sGugG+I+Z90YZhwOKgyjWnQnQu1rPU3tFcOK/D1AOVdOk?=
 =?us-ascii?Q?kYNv4Tia8SgluXyWnPkLE+/wTZQzaVqqE9OXELgG99skmKL/RmuTphl8qqd9?=
 =?us-ascii?Q?p7Zni3qPvVdXdbLbey2j1QxOn4fqlqY5P/BzTaNWXoMlNgsD51XVkmkOqJKa?=
 =?us-ascii?Q?ZFuB2wVshIk6igByxgcBbbkOc9zds/iFtB4LTuYuG3tjHelC/yQytBnNwWvw?=
 =?us-ascii?Q?ukYU7OsnF52HlO1Hst8VxPpsgZwsGFU7CLq5wfyo94s2nxgKi8VT5HWUnszj?=
 =?us-ascii?Q?gggrX14TMqz02y5B3gOb+i4xhctmiO9EwYxTeRuliMPCXygtmumdqKZAICh1?=
 =?us-ascii?Q?5ROyM9hqwkvyMHfMCF5eY4Ww0N1rZLrxIs2wBQgyPmwWMTXpOgiAmsQsFp0l?=
 =?us-ascii?Q?rBHn/aBjo5KkH3CC1r4Y2OzYt46AC631pZCXQVOx9CZSMnvr6eHaKmPMAKJx?=
 =?us-ascii?Q?7nx7t/XFhA0xY24VsX8KpwfrNcatNOp4ngaugK0r4Lwm188Qvgi1LlM4Mk5n?=
 =?us-ascii?Q?OPZ2Cf8EFsLmGWv3mYa7N1oTyvp9/93eCox8E66SqCsBZIC06T7BokeG8TJB?=
 =?us-ascii?Q?kvhXlMZ+CP8FSlfefxNONmnlA20dOMZvB0CcSU7PZ8u6XQcMych8WZtJCZvZ?=
 =?us-ascii?Q?Vx0JoYCl7R+muebvuLfnVeN/zwCqABnm5DrSuIniiL4n6bWdC/HCieuvrOww?=
 =?us-ascii?Q?B8pkZVqNUYel/p0YhNKmdkG46sas4dMFix/SV9FO6CdvcpbqY2QxyIzTbMlQ?=
 =?us-ascii?Q?LpoZdDY1lxEuFftP/BBy1bI+mZN+UKSJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:24:11.1444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 326d9611-afa2-47d8-8163-08dcd27e2b37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5841
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

From: Sung Joon Kim <Sungjoon.Kim@amd.com>

[WHY & HOW]
On display on sequence, enabling SYMCLK32_LE root clock gating
causes issue in link training so disabling it is needed.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Sung Joon Kim <Sungjoon.Kim@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 514c6d56925d..da9101b83e8c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -736,7 +736,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 			.hdmichar = true,
 			.dpstream = true,
 			.symclk32_se = true,
-			.symclk32_le = true,
+			.symclk32_le = false,
 			.symclk_fe = true,
 			.physymclk = false,
 			.dpiasymclk = true,
-- 
2.34.1

