Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30266CF884E
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 15:57:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B784F10EA3B;
	Fri,  4 Oct 2024 15:57:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="43XoBfqu";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A21BF10EA3B
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 15:57:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vw0aY96vkL+6Xw3BF8VCGM4cLjSiFZ6QNQxwL+63op4LDEgNBkbsrG8RWBulp6/vGUxabac/sV0VICdyJG8D3adYR/NDBhwC0nysNOdk1o8/kiTo6uThgEV2u5bnfJyBYVV2C2tWPc38XSsczhvbg7iBSYEskjPYTMqWaLN/1FPTbyAX/z4h6qKBgl2ms7fKKzhDbMvD0orrFEoQadFVTVI2NOKBMISh+Fd01FBsFNu5Jpbk9696AqHSwAeILpPhlU2zsZC81ODDQw20KZGNV62eeM5XG0ByNCr0WPlvv5LnVBy7iOREsgftVJk+A7l3JGbkf2gFmTpA65xs+DGixA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOk7fxJE1sFPsRVw38DG/FjNQf3skImze0WMySm1lGA=;
 b=n79bik06Xm9twNPVVwOaow7LEByVuRk2wd7R8xjmWnIjOJdIOYiq73dVVJrWtVpzCSsXlFXleyXihIjmvC6/cK8MdALT3fVnsqRVL5UXfmFdFHkSXAzcuafMIjQ3GpLIYlAb1z1uQnsDuAvF+QvmgZDyuHFc0FkYuaXJRWMb83qYDPQ+dzAk7VglYbb+NUV/pZc0wPjHEn+cqyGktfqmlQafFSBlc7NF2jRcICarUH37UxOKpAHjMszFNKolSTVLzd4v/35a/uNNrFqQKO8AsPlIHQsdp/0K4/2RhvC2+fuiLuReIFU4vBq90JKbqk0iIRygD5oj8P5AGy2OLnBwqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOk7fxJE1sFPsRVw38DG/FjNQf3skImze0WMySm1lGA=;
 b=43XoBfqueX+N1GJZy722/l+HToxlRPOBQfEhFQR2fhcteBSkoqsEDziXIfzhiJpMs/xuFBXYv3k4yOuqDzohd3rswHHdrW//hrxrdPNjrouTez/k7a/AR70l9EDexQIkV2WP7Maz2GjbRRAjjwd2E0AeFEOvDZ+vSBxE6yrOLwY=
Received: from CH5P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::28)
 by SA3PR12MB8804.namprd12.prod.outlook.com (2603:10b6:806:31f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 15:57:53 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:1f3:cafe::8d) by CH5P223CA0023.outlook.office365.com
 (2603:10b6:610:1f3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19 via Frontend
 Transport; Fri, 4 Oct 2024 15:57:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.2 via Frontend Transport; Fri, 4 Oct 2024 15:57:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Oct
 2024 10:57:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/4] drm/amdgpu/smu13: always apply the powersave optimization
Date: Fri, 4 Oct 2024 11:57:35 -0400
Message-ID: <20241004155738.488919-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|SA3PR12MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: 100584a7-a58b-4600-7ffe-08dce48d4e2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yRlz7dFBAKyd+io/TlvwOjPDJheODJnZdEShIC1n2N8/6SDWU5OvknFcrYX3?=
 =?us-ascii?Q?Ri07txSXDfSmvp1Zm7S04YQqMVGZVYAMGJOF8TCQu1T7a5NyCtETj8LHaMup?=
 =?us-ascii?Q?vjZPltBQyXiKCj1mKu/Ad2SgR19bXv3PaLBVJF1olyRZg3MLh27p90itRUJY?=
 =?us-ascii?Q?MbSVNpkHp2C7BDhmir/aL9kK8D9YAW0TtiyNb5Xb+oZJ2fpnj25/FfBBxrkK?=
 =?us-ascii?Q?zT4iu6SPXA62nD6hpbtilUPqkXnlEeaKqS7S8lIGNfZ0XjZyVWmFJjcwcNYW?=
 =?us-ascii?Q?45lZ9R1icMDgTXjfZABYt6uLieg2BGMQaopjRf4QogaF28MxcZvQvhtmxhCy?=
 =?us-ascii?Q?h9hFL8OpBy8C59s31a2vRbo5Mhp117A9QTUE+MwDk4W/ZlCHAcjVCxlCTAdK?=
 =?us-ascii?Q?J0NZT1T6jFVpX5V5ozVuRcTsNiAUjZMb5jrbDQY3FTWxZDK3l+75hR7cA98U?=
 =?us-ascii?Q?+EPa90UQkUnlRABimtqDy+8ZI82qUs2SNkfhcF0TszJN1gywVshUMcSwTb+t?=
 =?us-ascii?Q?4TRFEz4O7lbfxPEnERN1bnHKaI/QQzEx1DetJrUhekdkK45WVY3lxBSBzztS?=
 =?us-ascii?Q?ShBFJh37/IOuJ+iM3UXe7XYhp8fl73ZbB4cAj+I+Mzi8JRZLsUCaNGzODVbb?=
 =?us-ascii?Q?rkH9tcxyrJcOd9va2sMRfQxQdJFkj4tP7XVhQ6K7jj5V3KXWfQYZU//N5Smh?=
 =?us-ascii?Q?mPGINpIIbAUZNh/DrGUSnjUO+LoyUe7mYcxwjbXixunnF89OmlzbDmgZttyD?=
 =?us-ascii?Q?MmcO0iWU48/SwAQRgJi2TSevqASSbdjIoGk+/xP0kNCqjw5NcwJsBV1EZ/D7?=
 =?us-ascii?Q?/AATsEbzMug9dVqwD4G/PJgawUUgZPukWtitSFX66xVGBOSuGX+bWwCihYqJ?=
 =?us-ascii?Q?D25g2g/frqvyW+U5eXvQOuggzovA2ATOMgebgmSwmpBz16qN1t+955wdgAy9?=
 =?us-ascii?Q?zNt9mbz7EY8/pMdyWcVBxVlTHjN1JvYRYg+p/Tchw7+t+SWRZZuzH/aj3OVy?=
 =?us-ascii?Q?6PkeRUow6dgLDAIjpijYkeokSzC7L/kqHunZEtUt0cVhJc9QSMD03lXVAFCp?=
 =?us-ascii?Q?rMd1g6bqXDljdsm/ffO9osBwF92/nCxT68a6qyXUkRT/GBF4AOXC+o96B/pk?=
 =?us-ascii?Q?+wG0nnjBbR4fzvxCVOtikrtx9CDmobiiNi0QXyW7phEUa0vYhGeDCn69Vq7i?=
 =?us-ascii?Q?6VPZQoV9EM19+0/cZb2HqKGcgKkvpEiU2TNf0RF25Iif3UD2YwTLI+XOfgQ2?=
 =?us-ascii?Q?aJ63qH4NgayiSdGfKZSTkj69IrZeLJprR8YmmbKHZIV92jH4peyaBFKYZg9y?=
 =?us-ascii?Q?zz/GB5ewjp/cig05NvlqsALY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 15:57:53.1956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 100584a7-a58b-4600-7ffe-08dce48d4e2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8804
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

It can avoid margin issues in some very demanding applications.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3618
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3131
Fixes: c50fe289ed7207 ("drm/amdgpu/swsmu: always force a state reprogram on init")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 22 +++++++++----------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 866dc77d1005..4e658abe3a20 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2542,18 +2542,16 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 	workload_mask = 1 << workload_type;
 
 	/* Add optimizations for SMU13.0.0/10.  Reuse the power saving profile */
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE) {
-		if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0) &&
-			((smu->adev->pm.fw_version == 0x004e6601) ||
-			(smu->adev->pm.fw_version >= 0x004e7300))) ||
-			(amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 10) &&
-			 smu->adev->pm.fw_version >= 0x00504500)) {
-			workload_type = smu_cmn_to_asic_specific_index(smu,
-								CMN2ASIC_MAPPING_WORKLOAD,
-								PP_SMC_POWER_PROFILE_POWERSAVING);
-			if (workload_type >= 0)
-				workload_mask |= 1 << workload_type;
-		}
+	if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0) &&
+	     ((smu->adev->pm.fw_version == 0x004e6601) ||
+	      (smu->adev->pm.fw_version >= 0x004e7300))) ||
+	    (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 10) &&
+	     smu->adev->pm.fw_version >= 0x00504500)) {
+		workload_type = smu_cmn_to_asic_specific_index(smu,
+							       CMN2ASIC_MAPPING_WORKLOAD,
+							       PP_SMC_POWER_PROFILE_POWERSAVING);
+		if (workload_type >= 0)
+			workload_mask |= 1 << workload_type;
 	}
 
 	ret = smu_cmn_send_smc_msg_with_param(smu,
-- 
2.46.2

