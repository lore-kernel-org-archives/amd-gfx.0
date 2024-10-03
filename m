Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBB9CF34A9
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 14:06:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 008D810E859;
	Thu,  3 Oct 2024 14:06:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="imqZt34G";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BADA10E859
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 14:06:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JsO8z9nkFWVwcqWr8A8d8ZbsmRedHvpDP3nYbqtktm6bG+tzufa7ppmJF6Sb6FG+F2oef3Q36DwWA1rFhXQstgb08ewHyHqoBDEofuosuo1RBLPwPb19kmqEwWejImBsdbGvXtPVhJKUA5VeoRqlu3ZBROunlVBk+RkKOgbowmjfLplyIuDcdjGpiIFkkG6b6MN3w+kCDxlXJXd2p55ZREmCBUrzjD42QsRIz2r6o/kuOi+SpgxqmUHusF0k2nsTFXy81KGph/tCj1ZVQYZKuwGC1eIS3wWJu7k7DoYtWLSSdO+xuT16ZCEbLiqMxx8SI6Y58PtNAblHtKUIqB+3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSWvv98Gal1F1tbIwD9R+T31BnKGtYeAmAM/bmabTZI=;
 b=LApP2t62brZ/KFkqz353NWNMW9mypQmM3UWe4AvWQ+M77PH2MfwCprDsa9Q2aXMoPaqrOsJmzFp0pWXNgUXHj6Hija3obEhxTmBbrmdRMBLsFBDHSUnl7JWwlcivLMqQX9K3+PM/rv80FndaRt1SDc6g7j+YSuR5kw8rQAdDOxmbGf1GhKHNuqm02u50WLeGqueRcAcGXA+NXMaeXNxb1E4uQDblQd6pJdmTNK6Qkwilf/l71BIdFwpkg1KnoRtwU24RHOFYx8fZfPhEpsFV/o4Wp8KYqAGktez5aCYFR2MYv4TNGkaneWuCQDZ0HSzjy7A+AHXw/ZqBndYjCPsvuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSWvv98Gal1F1tbIwD9R+T31BnKGtYeAmAM/bmabTZI=;
 b=imqZt34GrQbe0Ys8O2wo1RDcX/+XEXWQS7gg6BYbZ6pXHSBucnZtX5hX1mA7buOuV8hm8Ye9QYwlNyJhA6Uc3xPZkf+5mHp+UBWwIpc6rfwb3hPIWKihq+wDVAWzICbw8K4fKXAheToftYEo6xZ1eTQbBsFigVxVzYWGsB76uFk=
Received: from BLAPR03CA0174.namprd03.prod.outlook.com (2603:10b6:208:32f::11)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 14:06:31 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::ed) by BLAPR03CA0174.outlook.office365.com
 (2603:10b6:208:32f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.17 via Frontend
 Transport; Thu, 3 Oct 2024 14:06:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 14:06:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 09:06:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: partially revert powerplay `__counted_by` changes
Date: Thu, 3 Oct 2024 10:06:14 -0400
Message-ID: <20241003140614.3976582-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|SA0PR12MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: c5ab6fba-8526-406a-672e-08dce3b494df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mBS3F6V726EFk5PHdDNySmADwzDjqqdFVbYUGdpJvDKRpOtFfRyrGZTBlY5T?=
 =?us-ascii?Q?F8EuHAU32vUwn6QmrGoh2cYtT0MtBl0jZKUzkSZg7dvxHdd+3MGYDnJBdBuE?=
 =?us-ascii?Q?IcX53y3m2940eIC8LnGbBHpDXXUBZUHQHpWFdmnmJLeDtNyg0korjiyKb4YU?=
 =?us-ascii?Q?vfpdKL9w4/jAH0w1hBITkxPWQeZ6icOX2AQF6VsmB5GtrvVq9JOvV+5vsIAm?=
 =?us-ascii?Q?Z6q1Ek4Dsytgs4zMBqK/whFpghO5pxxcLjl+4Q7ohfr7D0fQHlZfxrieJCyP?=
 =?us-ascii?Q?90wsNoxsMbhrNsWK0kV3JFBaADAe8WJaiGv5QtAjwKpPHW9Z3OKjxo30tFYY?=
 =?us-ascii?Q?QUpxhGzQwupH7av0n9aWDb2YIHqVN6RDbE1N/EnTEQltAOm2Zb49BO/pHdj9?=
 =?us-ascii?Q?X6XEiyWGz7jbz3vKr/McWgL1Fb8Vj542cvAoJom1FoA/VNiPRxKD8QF2OhWH?=
 =?us-ascii?Q?11vnQ9jiZGr8nSKFU7q57PsqiiBx0flifyp6qgxo77KOOCk5hTDXuuuq9Ydk?=
 =?us-ascii?Q?LoYwQxxXQrRIlkmynK2IlaRAr5Rpby8oPY2+19c/otXU3VQ8aNNW/I3CWThl?=
 =?us-ascii?Q?kR2I+bgKK1/Tf/RJsq4svBwK8t/+yar1MHWuYygqze27tVcrq3pf7JPzGTA1?=
 =?us-ascii?Q?DN55Hty9oSIMHRNU1JPNPOPVUYJJ2aZY18k+u3TiVHS1YPNGAulLVMnh2P2i?=
 =?us-ascii?Q?MfpwE8rZtiTWu7fDP5zTWU4WaXtO7QeBiL1CP/HaOAJPciapvTgSVb7MKgT3?=
 =?us-ascii?Q?nNwuOuD+T8CXdLsHHqw9DMJnN8sFMcZjzhEBK/PoTa5RR5yRpiEg7t4+Sclt?=
 =?us-ascii?Q?Iqe1BglVs05S/oPlnLrKav2OTJNZE8X7N5W+ZPsCA0i7/El3P/4zAQgqUfAB?=
 =?us-ascii?Q?clDrSAKa+dq9LpLv6SSoq9ne/CM3Y64iyL3spOqZnimGNaL6KFBgP8jI+KbR?=
 =?us-ascii?Q?QvoebkSZv3+LwF4gwoEBhw6F9OC1FVYLMl8uEREHLueHa41qpBizc4PaBFXL?=
 =?us-ascii?Q?D9YqRsz55HEjLGwq/fVJ7iAkKsBo5rlogqDkPwwY9BLPAdnl+PFE/FMbcvhM?=
 =?us-ascii?Q?dZoqgsWAqH8pbJl2NHPR+9wEzgA1nk5AEx4zZbyRBUE+S8L1MqeuZKy/pHrG?=
 =?us-ascii?Q?EhqTwws4ozaYU+G49P8OkpgeL1j9DIcgX/Nj5MxggqyXtDIHB15JxB/X2GV7?=
 =?us-ascii?Q?dUvTRFDmRI4eXiqrh/gCXhkOgCyYtLp/Iy1L2//W86mY0IVeTq6yfRatwhRY?=
 =?us-ascii?Q?Hf4Tr+u8U3nAfM9cnnwt04h784owLh1jfYYv1XPttv8n4lRN/of+hEYDLzKj?=
 =?us-ascii?Q?luF4ungbjSaxFdxWi9yowlBV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 14:06:31.0273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ab6fba-8526-406a-672e-08dce3b494df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
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

Partially revert
commit 0ca9f757a0e2 ("drm/amd/pm: powerplay: Add `__counted_by` attribute for flexible arrays")

The count attribute for these arrays does not get set until
after the arrays are allocated and populated leading to false
UBSAN warnings.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3662
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h | 26 ++++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
index 9118fcddbf11..227bf0e84a13 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -60,7 +60,7 @@ struct vi_dpm_level {
 
 struct vi_dpm_table {
 	uint32_t count;
-	struct vi_dpm_level dpm_level[] __counted_by(count);
+	struct vi_dpm_level dpm_level[];
 };
 
 #define PCIE_PERF_REQ_REMOVE_REGISTRY   0
@@ -91,7 +91,7 @@ struct phm_set_power_state_input {
 
 struct phm_clock_array {
 	uint32_t count;
-	uint32_t values[] __counted_by(count);
+	uint32_t values[];
 };
 
 struct phm_clock_voltage_dependency_record {
@@ -123,7 +123,7 @@ struct phm_acpclock_voltage_dependency_record {
 
 struct phm_clock_voltage_dependency_table {
 	uint32_t count;
-	struct phm_clock_voltage_dependency_record entries[] __counted_by(count);
+	struct phm_clock_voltage_dependency_record entries[];
 };
 
 struct phm_phase_shedding_limits_record {
@@ -140,7 +140,7 @@ struct phm_uvd_clock_voltage_dependency_record {
 
 struct phm_uvd_clock_voltage_dependency_table {
 	uint8_t count;
-	struct phm_uvd_clock_voltage_dependency_record entries[] __counted_by(count);
+	struct phm_uvd_clock_voltage_dependency_record entries[];
 };
 
 struct phm_acp_clock_voltage_dependency_record {
@@ -150,7 +150,7 @@ struct phm_acp_clock_voltage_dependency_record {
 
 struct phm_acp_clock_voltage_dependency_table {
 	uint32_t count;
-	struct phm_acp_clock_voltage_dependency_record entries[] __counted_by(count);
+	struct phm_acp_clock_voltage_dependency_record entries[];
 };
 
 struct phm_vce_clock_voltage_dependency_record {
@@ -161,32 +161,32 @@ struct phm_vce_clock_voltage_dependency_record {
 
 struct phm_phase_shedding_limits_table {
 	uint32_t count;
-	struct phm_phase_shedding_limits_record  entries[] __counted_by(count);
+	struct phm_phase_shedding_limits_record  entries[];
 };
 
 struct phm_vceclock_voltage_dependency_table {
 	uint8_t count;
-	struct phm_vceclock_voltage_dependency_record entries[] __counted_by(count);
+	struct phm_vceclock_voltage_dependency_record entries[];
 };
 
 struct phm_uvdclock_voltage_dependency_table {
 	uint8_t count;
-	struct phm_uvdclock_voltage_dependency_record entries[] __counted_by(count);
+	struct phm_uvdclock_voltage_dependency_record entries[];
 };
 
 struct phm_samuclock_voltage_dependency_table {
 	uint8_t count;
-	struct phm_samuclock_voltage_dependency_record entries[] __counted_by(count);
+	struct phm_samuclock_voltage_dependency_record entries[];
 };
 
 struct phm_acpclock_voltage_dependency_table {
 	uint32_t count;
-	struct phm_acpclock_voltage_dependency_record entries[] __counted_by(count);
+	struct phm_acpclock_voltage_dependency_record entries[];
 };
 
 struct phm_vce_clock_voltage_dependency_table {
 	uint8_t count;
-	struct phm_vce_clock_voltage_dependency_record entries[] __counted_by(count);
+	struct phm_vce_clock_voltage_dependency_record entries[];
 };
 
 
@@ -393,7 +393,7 @@ union phm_cac_leakage_record {
 
 struct phm_cac_leakage_table {
 	uint32_t count;
-	union phm_cac_leakage_record entries[] __counted_by(count);
+	union phm_cac_leakage_record entries[];
 };
 
 struct phm_samu_clock_voltage_dependency_record {
@@ -404,7 +404,7 @@ struct phm_samu_clock_voltage_dependency_record {
 
 struct phm_samu_clock_voltage_dependency_table {
 	uint8_t count;
-	struct phm_samu_clock_voltage_dependency_record entries[] __counted_by(count);
+	struct phm_samu_clock_voltage_dependency_record entries[];
 };
 
 struct phm_cac_tdp_table {
-- 
2.46.2

