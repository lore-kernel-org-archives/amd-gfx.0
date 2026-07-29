Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12EBFC54F51
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 08:31:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61CAA10EAFF;
	Wed, 29 Jul 2026 08:31:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cwBnUFL6";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011001.outbound.protection.outlook.com [52.101.62.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8402E10EAF9
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 08:31:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vb9OBiL+vI+EW0gB/k9Opo0Ka835aQ750RqzIAb+9FwfywmzFXmsxO3MP1OX9U92Z1lyNTwNrkkNQnHm9pJIMDDGmRxooRlxSpbgy+t3WD5o8RM/f7oe2CSUwLqx/LU7jd8wNEn/3fVWPswiD5WFO62C3gP/ddJjK3JN7xl9a1+4H9f/CBLO0Hf2pCpcymup0P7j4hX6MKNgCOZ6aTS51GrUHF79qiE/FcjT0GT4Z/BsoFGGwzu6dhGavjvDEciK6I+Iwj2sXFOrSvkkYumVZfg+sT7vn7TvKUs+dR4Uzlu9sY+0BIbOaLe8bGClOwKF7+OLsAlEJ3Xj+Rd0DLQOSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCujIcpkwgrYqFtpmDmLWnkcAVnYjbO2EKa/x9rbMjk=;
 b=STvUa46mbJKFOdSqTkcak2/Y7GjX3bHraCsHoYubE7YGS5aznsjDC6urx5AdBFhBFR9//pWNU3qsppBHdjsbXEOrHfBl6zH/uze+ROg1JEo3WjMv1Sj/MNaV0TdakLGNEqBequ1UEIKhyrmiCllZ0Y38qWBLCs9/LCKL/m2bRX1ju0UIj/K8t0YlGScj3AH3s2TY7Tx4F4djSpOJHyYcB0OPK1Bop5iIS/Q3OgGk94bkj1wC0q82cX1z5cLtpSiLJUSGVN6CA+g2aR0ua+OkqAE+TKBP0zV4wUhn74eBXOjuVg/yrYVrBZ+CK2XuDt3yCu2CH8HfU1tU+j98eSBsMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCujIcpkwgrYqFtpmDmLWnkcAVnYjbO2EKa/x9rbMjk=;
 b=cwBnUFL62b4PFjSoMXQNA/Sq0eqZS5pYwQv5CxWuvBCWE0b8jm9IbqeFUtA0f38XBA+kI9Cl3qwmfF52t6geTCs3Nps6jwTyv8uxdPuerzMb93+E1rw2TcUhclxBNV5tAC4qvfGUg0hmUjbV30JhJzPSPaKRLIAdr5QGk0PQe+o=
Received: from CH0PR04CA0068.namprd04.prod.outlook.com (2603:10b6:610:74::13)
 by CY8PR12MB7314.namprd12.prod.outlook.com (2603:10b6:930:52::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 08:31:40 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::10) by CH0PR04CA0068.outlook.office365.com
 (2603:10b6:610:74::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 08:31:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 08:31:39 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 03:31:30 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: hide pp_table sysfs on APUs
Date: Wed, 29 Jul 2026 16:31:18 +0800
Message-ID: <20260729083118.3658560-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|CY8PR12MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: e13d0778-7134-4303-5416-08deed4bcfb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|6133799003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0J3S7ngfsTPiyouao65gLAIVOMQ44vrD7FnZnImhgDKIVs6aDBxNJsk0y5C/qBVk3E1Cxfpwsn6S3s6SlLnwkDCgS1RoAVnzPUwhdDYu65LfhKEKARf4UKfy6ezlR70naGTY5+mTvpL1iX50OyV8+o7VgBofyF9OliS+Vw+R7qlt9XQhbvMfA2jclRnTIMzO2zWsXxT4ZC0cvv9zTe45olJJADkhwkR2cCbU97pb7If2STI4Dy+mBGQ2y+aPa/3k8SBlHsXW7f70Hgv/18DwcGhuhDt7s317pFLmkKODRgbZe+u0gbCsP/nEIZdzo8zp0Vk+MI0DOzS4Li7WNIqqFG8oAsvQAyysuCOkDi1X7Hk/vbdNv5IvKH1BnlLU5tpnVxqYo5WSu6my5LAorqttOrVWLFJgAOPfuoWC5pYwGorACyW9j5+OPyVjdMbZrELy9xYmIU8gcm3DG1fHhsyZDucsBnubmTvUxXKDVTa8O15KS4gxjhd4IrubFbmOJr2GFpKP3ptOwR2yHAeoTqWtk2GvT2hyNA3wQVFhlexLj45sqWlx9ClTMwkEFC3yd5iaN32ZhaETTnErScvhdx/6Iu1qsyA81xo3so/fyw2V9hOjQyqP1euW6KgYUiygNcP/ZgjTvy/FnVs3XkHDMUy2JHhwN09Z/1oZ+mzsHdpL3y8ul4PlTYQYzg6eMZ5eB0jnMTZWA+QerkidRwo9QcdpNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f8hBDJMzKcCxPxLKEa0TgbshjxUOJbR7dVwz2S0oSwQmRrmKbGpYpbi1aVTEt5rOwW/8P630wWpQIKBMRjU6dUM7ByIRCtJ/YrsEfgLvzk0axCim3bDuPpEX1w3tbHVhhdP9Ys6Z0W+XIxr4H/2Qqt54ZsyJwFpMV6s3mBnJsiPnEZPB+MHvfXy/UZOqea8qMFobHlx3b026jCD3GRbZyyE0INiePcVZfhO0QgySLQnDQlBrwA+xYTQa07SGy1i1y7T/KW2ZmOavCHuaSyG9kkYd/Wh+hgolKat0ir/sSDBULjxu9NzPE8pZgNY4P8NoBKZ1a68gPMy9OeZrppItst8g5/3JOjcYEicLGLAWMvsM/kTNFwl65spIz78aiwE3meP5x9Uqn6kOKjxXKKDodqt+iRaWICT0o3CMad18YbHycNCdLjnbJWKZf7B8UaI/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 08:31:39.6165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e13d0778-7134-4303-5416-08deed4bcfb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7314
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

APUs use firmware-owned DPM tables and do not support replacement through
pp_table. Generic callbacks can nevertheless expose the sysfs file and
accept an upload before resetting the power management stack.

Treat pp_table as unsupported on APUs. Use the same platform check in the
get and set paths to hide the file and reject uploads.

Fixes: 289921b03fe5 ("drm/amd/powerplay: implement sysfs of pp_table for smu11 (v2)")
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 8f59ea12fe0e..c3688b3b12cc 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1183,6 +1183,13 @@ int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev,
 	return ret;
 }
 
+static bool amdgpu_dpm_is_pp_table_allowed(struct amdgpu_device *adev)
+{
+	return !amdgpu_sriov_vf(adev) &&
+	       !(adev->flags & AMD_IS_APU) &&
+	       !adev->scpm_enabled;
+}
+
 int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char *table,
 			    size_t size)
 {
@@ -1193,7 +1200,8 @@ int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char *table,
 	if ((!table && size) || (table && !size))
 		return -EINVAL;
 
-	if (amdgpu_sriov_vf(adev) || !pp_funcs->get_pp_table || adev->scpm_enabled)
+	if (!amdgpu_dpm_is_pp_table_allowed(adev) ||
+	    !pp_funcs->get_pp_table)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&adev->pm.mutex);
@@ -1717,7 +1725,8 @@ int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
 	if (!buf || !size)
 		return -EINVAL;
 
-	if (amdgpu_sriov_vf(adev) || !pp_funcs->set_pp_table || adev->scpm_enabled)
+	if (!amdgpu_dpm_is_pp_table_allowed(adev) ||
+	    !pp_funcs->set_pp_table)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&adev->pm.mutex);
-- 
2.54.0

