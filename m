Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38FBD36136
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 20:24:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AC9B10E60F;
	Tue,  5 Nov 2024 20:24:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bYbfuL9p";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0107F10E60A
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 20:24:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3WbE5PU/gpxYcTKgHh9ziE6dVKppv6Iexybvu9RXERhjtTdbMfAzyXK/yBa+K28WgHsFRL56FRpSX2yzPrvf85wmjAsSM+8ouJINlfI3BcWRv0DaR/od7uUIKvPlI+eWPpqklS9xJdSBOjL98dT1PF3GVXRtDtI7F/CitP2GxBO8lU0pdhUXmoZbB/99k4cpuW0HACEfoFzYaNjA74jHqct7gsXJ9iUOXuSFszq2rHCZXPtqhUlDvubBeBmlrKE1XjWC+XzLJTxz0Pe4taqQIVGs8M125kzKGnyeSXQ4m2vRsEPYj2VjlZI5MYx17tCfJnmSLdY6Mmule/LaG/yCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPEqnz2LfjpQOJmQGGgUzJvqfAkfXAB96xLp0ytqvi0=;
 b=lRLOD98BLLRI8Y4OChexaDY6O+w5DigXE5P+VF7h96dA8zob79w31F8udKbsF8JEcbIybblEsMrw+9OkPkLLmdw8RAMFQ1wnnt83rhC0EiDdyCsrfS6m3QvAAYT2WWNU8dydKAUZyn8jn+Qi+4oY/5V9ym38EeWjn9Kp9bIl+51lSFv6s62TNM9ivA3c05hztGai+Fp3gGJOox+YkhXjnMEFyaI9eAi4Txu/bg5OPb5jomx3UCK3kiBC5I4Fya8bMti5/1g+xpC9rmSjjgtdtBO8mLi9/9+CZq9BVgUGI68PS5lHgCLwR325hiT47HO1pgXtFqhm5jEUYRAIzlgXmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPEqnz2LfjpQOJmQGGgUzJvqfAkfXAB96xLp0ytqvi0=;
 b=bYbfuL9pLLglbwn//0eCNplJZnAql4c6RaFCmAVNztyJ1jQfuMAf4GN5wtLytAWv4DQ+IsYxPow1pwmpGhN3Bp18/LfXYNF2KCmkrFr/AeV68QrDTRfkf4f+L4qTHr7BJOE3wbB6etMcR6U/AHuzwI3696aBP50itoP22cyhNNU=
Received: from BL0PR05CA0012.namprd05.prod.outlook.com (2603:10b6:208:91::22)
 by PH8PR12MB7232.namprd12.prod.outlook.com (2603:10b6:510:224::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Tue, 5 Nov
 2024 20:24:37 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::43) by BL0PR05CA0012.outlook.office365.com
 (2603:10b6:208:91::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.16 via Frontend
 Transport; Tue, 5 Nov 2024 20:24:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:24:35 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 14:24:27 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Emily Nie <Emily.Nie@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 08/16] drm/amd/display: disabling p-state checks for DCN31 and
 DCN314
Date: Tue, 5 Nov 2024 15:22:09 -0500
Message-ID: <20241105202341.154036-9-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241105202341.154036-1-hamza.mahfooz@amd.com>
References: <20241105202341.154036-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|PH8PR12MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: d88914b8-4f47-41a7-93fb-08dcfdd7ddc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ONuepNGpLaFodeTQXkzvu/tGYK6hA7XwhvPRRkT7CvXSc52hjRfjdHMfUNxz?=
 =?us-ascii?Q?CqNg4yjycRuSqPVs84ZMEFe3AQtR6OebbWQJ8caaYnN934VUTmy8isOlppas?=
 =?us-ascii?Q?atamA8E+x5q8KYXSUTK23gGUM0BobZgFq0GSE0OnRzb3QucuBCv3cG+zT1UI?=
 =?us-ascii?Q?UrVlaUcPvkVfZPeaYPE3wx3scjDVkAdXK/GYdjYXruHHijqh5IIB5atYyYwY?=
 =?us-ascii?Q?LFHET48OkLu5ez10SCt6DHyfJ31ot9DHBfJSfjBxAMthJVBUGIE1ruHVgBt5?=
 =?us-ascii?Q?Z7BFtwWArD4Yal3Snz5NmUEvjpS/+a4kL9iDlrDoUzW3NW/+pTVhk6YmEqVJ?=
 =?us-ascii?Q?ovlM3E/Ne3w92qa7LbiiZZWSERVTTJWjAZVmNJEM4+ZVwmwQlIBDSRVHm3Qk?=
 =?us-ascii?Q?hB6zK3URgIDQrJ/NNB0FTipjHME2Ww3VsFFob/4Ov2D0JyBHZAYBKm7TScGl?=
 =?us-ascii?Q?d4IWdKO2DjO1Cl0XIUqliwRAUXwptU/JwaB7kPa+Wt70Y4y6RnISPi2VZ1p4?=
 =?us-ascii?Q?6gXYdPgmokXNhQKIvIC1V7EdO/pCoA8gK79Kw8dAofBRKEJ6B3IZs0fWrRdt?=
 =?us-ascii?Q?gmefEHUK3YPni2d7uc9ijRNCrjMc01QCFAoNp69QOHdJwqZmvN1mtDVp/PAt?=
 =?us-ascii?Q?dZjYgp2uJUK8X/GV75Zo3BHalU6IIwpwE443gbHYGxKjpdwUWxIIrkr94mZ9?=
 =?us-ascii?Q?NudKsF6pUQsB7wZFdhLHjOoBV5B4tN+0wW8D/qAxA2bLof4WlFv72Da9LzzS?=
 =?us-ascii?Q?ym6doGTIDvgvxzYI6nAB1TuZmqslrMtB5e4bEU5w1knKmF1r3U1zWxu6Fcrc?=
 =?us-ascii?Q?EIY37Tpvxj5aM6a6dmBAw1dj3qJViWcXCP8VKpY13t4iGkM9sxN3iFKrOOQj?=
 =?us-ascii?Q?Wm9uq463bkZElkIyPGk6l+m5OQ07xALltQomyX1eJRK9qRqHqDS76kZOaQyR?=
 =?us-ascii?Q?mWAINAqxO1Ja58VvWPGMnViQHaSSZQo1T6+/2d/dFwj0clDzO2L/ePIstPwh?=
 =?us-ascii?Q?gV8QFGUfGoAGG+q37WkCVfiUuz+FNAkCeojAU2jGWUrACA+9D1QavrRvVOsd?=
 =?us-ascii?Q?PnDC2hbmQCBqEmI4/p5Zm9RnuBD6vuBSKb9K9kV9iq98Q4cIyOBQU4epQ08J?=
 =?us-ascii?Q?wE2S/toUKV59cFJlVq9vuomvoRvFXSQAyTaeIFlpZJiwUqYqykCcTz4I0JbK?=
 =?us-ascii?Q?7Sg55CL9NDx75QvVE4KIRqIsysN38/eSsFaw1LMVdBEQTKcFVcXhyfC+TsoB?=
 =?us-ascii?Q?h3qHCQ6AVss/wUrOfu/3mA5roy4PoUotpuFGuvXoTM4RtAS6zM/4LZO9dM6z?=
 =?us-ascii?Q?mLlac0JvdLtqK5wB3hYU1AOyLZgYY+hV4Pf7/hRPLYpXfC02teI2cJZMzRtr?=
 =?us-ascii?Q?Yjolp4vfQuNFdSQV81JaaZJzWZSF/16uShH7TLUwB/NnBHlxJA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:24:35.9142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d88914b8-4f47-41a7-93fb-08dcfdd7ddc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7232
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

From: Emily Nie <Emily.Nie@amd.com>

[Why]
IGT displays Dmesg warnings which are likely false

[How]
Disabling p-state checks leading to this warning for DCN31 and DCN314

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Emily Nie <Emily.Nie@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 +++++++++++++++++++
 .../dc/resource/dcn31/dcn31_resource.c        |  2 +-
 .../dc/resource/dcn314/dcn314_resource.c      |  2 +-
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fdc1d2d1afd9..1d47719e7af1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1307,6 +1307,29 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	DRM_INFO("DMUB hardware initialized: version=0x%08X\n",
 		 adev->dm.dmcub_fw_version);
 
+	/* Keeping sanity checks off if
+	 * DCN31 >= 4.0.59.0
+	 * DCN314 >= 8.0.16.0
+	 * Otherwise, turn on sanity checks
+	 */
+	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
+	case IP_VERSION(3, 1, 2):
+	case IP_VERSION(3, 1, 3):
+		if (adev->dm.dmcub_fw_version &&
+			adev->dm.dmcub_fw_version >= DMUB_FW_VERSION(4, 0, 0) &&
+			adev->dm.dmcub_fw_version < DMUB_FW_VERSION(4, 0, 59))
+				adev->dm.dc->debug.sanity_checks = true;
+		break;
+	case IP_VERSION(3, 1, 4):
+		if (adev->dm.dmcub_fw_version &&
+			adev->dm.dmcub_fw_version >= DMUB_FW_VERSION(4, 0, 0) &&
+			adev->dm.dmcub_fw_version < DMUB_FW_VERSION(8, 0, 16))
+				adev->dm.dc->debug.sanity_checks = true;
+		break;
+	default:
+		break;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index f71a5b8286b2..c16cf1c8f7f9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -868,7 +868,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.max_downscale_src_width = 4096,/*upto true 4K*/
 	.disable_pplib_wm_range = false,
 	.scl_reset_length10 = true,
-	.sanity_checks = true,
+	.sanity_checks = false,
 	.underflow_assert_delay_us = 0xFFFFFFFF,
 	.dwb_fi_phase = -1, // -1 = disable,
 	.dmub_command_table = true,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index 8aa10da68432..c0f48c78e968 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -888,7 +888,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.max_downscale_src_width = 4096,/*upto true 4k*/
 	.disable_pplib_wm_range = false,
 	.scl_reset_length10 = true,
-	.sanity_checks = true,
+	.sanity_checks = false,
 	.underflow_assert_delay_us = 0xFFFFFFFF,
 	.dwb_fi_phase = -1, // -1 = disable,
 	.dmub_command_table = true,
-- 
2.46.1

