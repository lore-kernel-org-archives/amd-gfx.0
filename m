Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4086CC282C6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 18:52:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCC4410E334;
	Fri, 28 Feb 2025 18:52:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O13rVpxt";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 798E310E334
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 18:52:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYYJOkixe28shKsPchPms/x2cWGCnG3SOY2tFgARv6TO6eji9959/BEMGXcj9zRBe3OrRfYL/UAYL50biBv6cmL356rqqSi8FmkhbDQRC7k8TPqHEwLXxX6nGAxfZNOZh/B42wVbG9rsZ3YK9jSs3Xzh+p9nbgYJBhj6W4dt1VeiKW1kRANgR+87DHLzvl+F49S30AP9sfpJG+bdO67GNmrBQq3LymbR6X3nwNI4Dmcx46ajRRM8JidYvEurTNA8Vcf2VYjpJb31geclrXSW2HeGZPWmXpk4Mmp/3OiFiuqMjjnkyd0b55/YdqHCp6WFQKW+3br+ORdR5ZlZ1ZLgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dWX30Y8N8IqzGEvsDBV8l9XXCAOzqwsNq5ZM8U0/8U=;
 b=LerQBHNgKnTJ5wB8bqsPG1RItllAoygfLhfF+EwNk6Fn0K64VKwuVffm/zY9ZUIBEM/KCbPoDZpgjp/7cuHGQTF+KSvb1vWaDA1lneg9zn3T8+dplMiZKs42+K2v3zzBmkQxxtYt835+K4Ia5aK2s/8W2wvkTjdG8IXtzu33YSYlK3bWIEZTnICmkN0bt5m8mCNI+GiYmBOnydMS8YYHFZM6pLNG1ehfcZTt1Bty34iV9wEpRKs4dZ0/4Eog9R0U4d/dbRdmTbTnywbNVFomgFipZe8SHev7ZaQRJ236CA5IIghwlJ9wyv9p0l3OK8yRSlpEW2Mx0OsBSMS70R0u6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dWX30Y8N8IqzGEvsDBV8l9XXCAOzqwsNq5ZM8U0/8U=;
 b=O13rVpxt1hyufZPwd9zPix0jYLRzwJJWgSYymGr5u5P3AFPqQ8C30NqFn3c9OAOjVEG/yecrb6oMd3kI+I/Nw4LOtcgq/crx1phOOVY14wbQpoMoqmFd0hJja5i6cPRTInnE9TpYzX4wUEUy2q0l/X54GXvzMgLpIRFT/TGPF8U=
Received: from BN9P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::16)
 by SN7PR12MB8060.namprd12.prod.outlook.com (2603:10b6:806:343::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 18:52:02 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:10c:cafe::a1) by BN9P222CA0011.outlook.office365.com
 (2603:10b6:408:10c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Fri,
 28 Feb 2025 18:52:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 18:52:02 +0000
Received: from AUS-S16-AI-13.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 12:52:01 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 3/5] drm/amd/display: Avoid operating on copies of
 backlight caps
Date: Fri, 28 Feb 2025 12:51:43 -0600
Message-ID: <20250228185145.186319-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228185145.186319-1-mario.limonciello@amd.com>
References: <20250228185145.186319-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|SN7PR12MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: 40bb7ebc-befd-42b7-8de5-08dd5828fd06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?de/9p5ukJWYu3lhWNWNk+Up/jzZdBKc5oeOtoEbVYnmGil4FFR9ZNBhrJhQ9?=
 =?us-ascii?Q?ojoFWVnEslSHqGVR4FVJH6r1BeDqdKKUKgTmlqGLRjXYCAt91EEAPoevfgAP?=
 =?us-ascii?Q?woNhc58FQf14MIYmrFn6nf+npoDO2ke/f0NLJ9n4hnofHBGnFpPgQnQUpKNn?=
 =?us-ascii?Q?IZaRw4+xuPrWw7t6upgFjjCc8AH/LgODgd5v1NGA5Qy47PPU4P75/Fg+WbRB?=
 =?us-ascii?Q?HWWG3+TrjzQkDwVLgh67l5SRy/7Nc6TAT+4jOxhrtH3phImb4A/qUErWBgj0?=
 =?us-ascii?Q?r0x9WtoRxoj0sUlikTd+Q8TWLMJeB1dE2umKRaq7SkDlirb1bnqleAoF1X1y?=
 =?us-ascii?Q?gfjSYm0jxMPsByd7PqmFb+2s22kJHGq/yajBj9BZ8EUm894+c8I5yMSXsA8O?=
 =?us-ascii?Q?ve88Km77KdkvZOS2jIRZSJREz7UWJ+eHmIUmlPDw6VHHTz8bGuNrnLpqc0My?=
 =?us-ascii?Q?PEaK85lVgrShMabRYkO9p4SWh1ukXBbZ6/GJ+BfDEdLxT19Mw8RMbqF/fZDe?=
 =?us-ascii?Q?JpPS1J8TwW8wqdkL/7xM2FMHLnKuySJpHC1V3EH93bW/LVynRjzWzpZ+5m1c?=
 =?us-ascii?Q?JKgABAN9lt5b33q+Azu6AdY2fTEeEyJQHkTYrv8MOlRZ4wGKWotQ+dkzw6g/?=
 =?us-ascii?Q?vPdvYzThpSbDpyQ44cQRBwJcyKA4yb90tkzJhlxplsgLBjxO+TwfcD5OkRsZ?=
 =?us-ascii?Q?AMDfbsLDTH49vR7+rMYINSB2Nky5pn7vYFSNKvacwBngiWf0nzEKO/+TXG+E?=
 =?us-ascii?Q?XXceFp2HJ/fhzSgh0tzNuq/jOi8ZJwFDUFPumGqz9Bmf88RPOlkknrGoRstu?=
 =?us-ascii?Q?VlNzfMopLcJd+mOlGDBk052vOw10cBsYh6p5dmApVBaA2+yPgUINSn7omF2j?=
 =?us-ascii?Q?/PPVfg73YeyjcE+sULETmmsM0Wpa+gMMs/20V/PVkFZlTxylw+lnfsruJSDv?=
 =?us-ascii?Q?e31vmHTqsd/UEQuvLmuVCsv+dd4D7LqODrzrbRN1Kf/33f8O6N45RHlS3j0X?=
 =?us-ascii?Q?0qPyvaMYBn6XVCKlQ4kztRlR9SjXNC7feHzJd3zVBzcIq5niT55LXOBRugIm?=
 =?us-ascii?Q?wFULx07B7gK0aLKl3FADKNQLctS4uRKnCYaFm2979vtedoVALxePzxxH5J7H?=
 =?us-ascii?Q?ZTKdDAlCt3ExBTzZkGSfRhoky4jKY5NYCxiywontjbMooykIe2StthSroPEi?=
 =?us-ascii?Q?XZf9ZRXDfZoTPH2eJ3Qys6NDua2v2OFnb6I05+0tZjbjRZfuD/EFkbqzOWy7?=
 =?us-ascii?Q?z792GvMGmwngxaesR7ZrRq0T9WBzFsFuQq4OkU4nPhZDM3OLJ8YQNn+rXdHK?=
 =?us-ascii?Q?ltlGP4Vc8AsAO7YRKeNVO4P2MTAAElayK2Y3EmJHNE+hmMmWZzHagTiz4lp7?=
 =?us-ascii?Q?2WieOV7yhcq9g+3I93t8sEhfdlMes3mN9VbWLiYSmhZ98+903RQj2+Z8865Z?=
 =?us-ascii?Q?wXbYFxGUJY3jjvk/5pOELkj3Br9J2+4gU+wXieaUUi8q2NSaRNLhrbooqMDE?=
 =?us-ascii?Q?or//RMI1WZkShx0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 18:52:02.2854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40bb7ebc-befd-42b7-8de5-08dd5828fd06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8060
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

Making a copy of the backlight caps structure between uses is unnecessary.
Refer to pointers to the same structure when using it.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Add fix for !CONFIG_ACPI
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 52 ++++++++-----------
 1 file changed, 22 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index badd8fa2099c..61d626914590 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4700,48 +4700,40 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
 static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
 					    int bl_idx)
 {
-#if defined(CONFIG_ACPI)
-	struct amdgpu_dm_backlight_caps caps;
+	struct amdgpu_dm_backlight_caps *caps = &dm->backlight_caps[bl_idx];
 
-	memset(&caps, 0, sizeof(caps));
-
-	if (dm->backlight_caps[bl_idx].caps_valid)
+	if (caps->caps_valid)
 		return;
 
-	amdgpu_acpi_get_backlight_caps(&caps);
+#if defined(CONFIG_ACPI)
+	amdgpu_acpi_get_backlight_caps(caps);
 
 	/* validate the firmware value is sane */
-	if (caps.caps_valid) {
-		int spread = caps.max_input_signal - caps.min_input_signal;
+	if (caps->caps_valid) {
+		int spread = caps->max_input_signal - caps->min_input_signal;
 
-		if (caps.max_input_signal > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
-		    caps.min_input_signal < 0 ||
+		if (caps->max_input_signal > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
+		    caps->min_input_signal < 0 ||
 		    spread > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
 		    spread < AMDGPU_DM_MIN_SPREAD) {
 			DRM_DEBUG_KMS("DM: Invalid backlight caps: min=%d, max=%d\n",
-				      caps.min_input_signal, caps.max_input_signal);
-			caps.caps_valid = false;
+				      caps->min_input_signal, caps->max_input_signal);
+			caps->caps_valid = false;
 		}
 	}
 
-	if (caps.caps_valid) {
-		dm->backlight_caps[bl_idx].caps_valid = true;
-		if (caps.aux_support)
-			return;
-		dm->backlight_caps[bl_idx].min_input_signal = caps.min_input_signal;
-		dm->backlight_caps[bl_idx].max_input_signal = caps.max_input_signal;
-	} else {
-		dm->backlight_caps[bl_idx].min_input_signal =
-				AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
-		dm->backlight_caps[bl_idx].max_input_signal =
-				AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
+	if (!caps->caps_valid) {
+		caps->min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
+		caps->max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
+		caps->caps_valid = true;
 	}
 #else
-	if (dm->backlight_caps[bl_idx].aux_support)
+	if (caps->aux_support)
 		return;
 
-	dm->backlight_caps[bl_idx].min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
-	dm->backlight_caps[bl_idx].max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
+	caps->min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
+	caps->max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
+	caps->caps_valid = true;
 #endif
 }
 
@@ -4795,19 +4787,19 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 					 int bl_idx,
 					 u32 user_brightness)
 {
-	struct amdgpu_dm_backlight_caps caps;
+	struct amdgpu_dm_backlight_caps *caps;
 	struct dc_link *link;
 	u32 brightness;
 	bool rc, reallow_idle = false;
 
 	amdgpu_dm_update_backlight_caps(dm, bl_idx);
-	caps = dm->backlight_caps[bl_idx];
+	caps = &dm->backlight_caps[bl_idx];
 
 	dm->brightness[bl_idx] = user_brightness;
 	/* update scratch register */
 	if (bl_idx == 0)
 		amdgpu_atombios_scratch_regs_set_backlight_level(dm->adev, dm->brightness[bl_idx]);
-	brightness = convert_brightness_from_user(&caps, dm->brightness[bl_idx]);
+	brightness = convert_brightness_from_user(caps, dm->brightness[bl_idx]);
 	link = (struct dc_link *)dm->backlight_link[bl_idx];
 
 	/* Change brightness based on AUX property */
@@ -4817,7 +4809,7 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 		reallow_idle = true;
 	}
 
-	if (caps.aux_support) {
+	if (caps->aux_support) {
 		rc = dc_link_set_backlight_level_nits(link, true, brightness,
 						      AUX_BL_DEFAULT_TRANSITION_TIME_MS);
 		if (!rc)
-- 
2.48.1

