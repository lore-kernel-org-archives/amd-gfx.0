Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB98D0BB6E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 08:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63D4C10E8CC;
	Thu, 24 Oct 2024 08:22:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gM+n3fbu";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 383C110E8CC
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 08:22:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJmhzNF3MC8ZVPLsKdqq2BTTviu5EW9M7LxLqpQAlQ+dSNOYuKYc6chj+/okCIY4OLraC6LgqKC8fQrvAIgCkl7yBuUZVuefKj/G6LN3VRY1NWQ1vCH+j7fMvusGTJGmvMJOO/C8UFgu0ZmbrceySZW9HE/C0MFzgxaJo26IyiBt3lDcDflXXoVGaHoZEW2f0tWOh3zlDtehr5pvs0qh6ab2abeShfPtDEqTA3dpTeo1LPhlUTwFRIbOpv5fD2Pwz/xx79GafqWT6IJ20gm3G5PsBzJH8xeHwvsYOyTxd0RrX699/CQ7rngkewcnDOjPYCLB28Hxp04iw+YfbmRx4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vfxx5gXbT0MD+9ZiFzNodgyW4Sep3M2kCBFLSjiWKUs=;
 b=JfqBtb/zuv/U50LYnvWpx4kZI2gmh4coIvhhyiNhMr6QBDyD/A9Xg1P6LTuHOBPVRfxkUqED0e2bK9Fqz8dilPiVcxcU8YOiP2GgBq808BNVVDgtaJHPrDezma7S9rN8JmfyyL5C3Nn7AGj01Zawz85y4q9R8K3kq829kJPG5P4ODzQ7Fc8uIWGjq2mNGitwSKxlPMVOm3ztJDpQK+7iBcB64iZy0Gplow/2Xn7n6le+62uaw7qOR2QQTtSyFuK06ibY3M7bwGJXhGKKaa1WBWDVQ6BeDeGliRcaz/SjMIQoeRlanpFjlc+7kwfn3F41qU2IV43qk32cmrSInSEFwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vfxx5gXbT0MD+9ZiFzNodgyW4Sep3M2kCBFLSjiWKUs=;
 b=gM+n3fbuwuEtznXeJNwQ8O1+qT7bhfOwZ+d7lPiemnkgMZPKcm8wgpfQISl9embMXXN0HYumWdeLQ8PlFaAzQ2RiFYifuXHhDrSnHutNmxYTOxRCeqjuuWZchwuq8Ai4n2/W7FBfVniNasRJv/nRRZjBo8oyXv5I/Dm+q3cA/Vo=
Received: from SN1PR12CA0079.namprd12.prod.outlook.com (2603:10b6:802:21::14)
 by DM4PR12MB5987.namprd12.prod.outlook.com (2603:10b6:8:6a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Thu, 24 Oct
 2024 08:22:13 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:802:21:cafe::af) by SN1PR12CA0079.outlook.office365.com
 (2603:10b6:802:21::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Thu, 24 Oct 2024 08:22:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 08:22:12 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 03:22:08 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v3 1/2] drm/amdgpu: correct the S3 abort check condition
Date: Thu, 24 Oct 2024 16:21:58 +0800
Message-ID: <20241024082159.45701-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|DM4PR12MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ed5697-9858-47b2-a7a5-08dcf404f660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hGMnrcCmgN1WtQMzBgImF4usbpz5mFpMoyrCsiZajRFejphjobFK44u4oNfT?=
 =?us-ascii?Q?m/UPFvrCyJFldn69I5/GCzxRGGrV/V5z1Ncw9fFsoDW3uQqTkPzgOmE8CutP?=
 =?us-ascii?Q?fQ4paWs6uV8n0Y1Qohn6veuinMsvZQUcYk/T0a1XZ5h9VjS10vD36lwtghXx?=
 =?us-ascii?Q?w0LfUYvS36qJWmj5nL1xN0NtVr2Q1lIc4BpROEZjxxVTD0Batv1eS/ufT1Jd?=
 =?us-ascii?Q?iJRCGh6EwvfsMIBn5/JauR2o9l2hvE+ZATx/L2Li9JD9QSGJmQwrmgCXMh6F?=
 =?us-ascii?Q?kMhN/Kj0j30s/cVtyx6PRA/0lbfNqioO497ByRWYYVKkxtv8CQvxOfByAWsg?=
 =?us-ascii?Q?ydN9MBQHrhcroVLj8eVAyW66bS1SLAKcUACMx027koWqybaRTvRSrc7CPlBq?=
 =?us-ascii?Q?7jQZZxN3Ed+CGy0jSaDRpZdA6ZNk1pejNlvPLvc5pGrmg5ZzdiG1oVq37l/1?=
 =?us-ascii?Q?rjHlVOF2uLCikvUeCjdc7PPQH+SxjlGg/Cf+nUM3Aa6cV3hhPQw6qNGVDBem?=
 =?us-ascii?Q?pF/uSHSIWFvK0vhcOIVPyKEqzMIwkyYEjinsXvaW5j5S5mZRlYYZwRJ+Rbu5?=
 =?us-ascii?Q?s//pVKSobnx699/pHRNw1o9jJbmFIIPp5HlGq0CtoR54UBdt+R1pPkhtWgZD?=
 =?us-ascii?Q?y60xGB6EdAmtWm3cm/m2MYY5Gaz4VMV9kXyWXIcKBM0frjZiS4uYO2zYxjm6?=
 =?us-ascii?Q?RtFpJDofc1kLUZjbCw1sYqGoPWZxpPzyDDHGeo+BuXm4xve46LbUBXVfjOTq?=
 =?us-ascii?Q?gns5lYstU30tSJenIEYtiu+OG01RXFoaCAPw7+1ZIQ8W5gBto/PX2ngaKo7c?=
 =?us-ascii?Q?YNB5GYh2YkJ9KNi7jG32xzi5P4HdkS9lxAt/OwlUbM2+d+tczVAdt+kaS2UY?=
 =?us-ascii?Q?/Qs2XjT9cOCSHGulwi7x41oLJYsgTccOIor9/UapMxw+3JicdZ34ZcgLDyJU?=
 =?us-ascii?Q?wTMcNVaVRBV+RpyycFkoazbLMvtegQMrMQX+HNlvxhQp4g4ZUWNavqeksw2U?=
 =?us-ascii?Q?rauM09NRKWDnt6VGrZj0tGqKIbpDH4YP6ndHdgarPhMiGtyWEvXgT/mTiIKi?=
 =?us-ascii?Q?wxPKaJnTvpelh1TiZJ7/WfNShctkZmvd7AjwxBB9+vOcUIAj9Qb6SiMMMAvW?=
 =?us-ascii?Q?FpAjgOVAEV1dnB/V6aywQHf+OHFVqvH2iQ1wlhTWRGRilJ7z1YmpJLzh87qO?=
 =?us-ascii?Q?t7A4ud7ufQqxK2rwBcAF6Yy5188GR5atmyiw9BUVitNuO3qZFftfPgjIReg2?=
 =?us-ascii?Q?SQ7ycrTIfeGEaixOe0fL1/xxfQxa1cPI0AYdseC2/JZgyhy+NCTBGFiO/MG6?=
 =?us-ascii?Q?Pn1w5OYekvNutMIt7JVnN56lXHnbclC9DU0AwAp19J2Q9Fj361LOycpJZ27A?=
 =?us-ascii?Q?+H/W8gboTzljzcP9m3z68nKls+7imSAzN2IJcO3iTCS3F8Apjg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 08:22:12.9562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ed5697-9858-47b2-a7a5-08dcf404f660
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5987
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

In the normal S3 entry, the TOS cycle counter is not
reset during BIOS execution the _S3 method, so it doesn't
determine whether the _S3 method is executed exactly.
Howerver, the PM core performs the S3 suspend will set the
PM_SUSPEND_FLAG_FW_RESUME bit if all the devices suspend
successfully. Therefore, drivers can check the
pm_suspend_global_flags bit(1) to detect the S3 suspend
abort event.

Fixes: 4d58c599df75 ("drm/amdgpu: update suspend status
for aborting from deeper suspend")
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index dd1c1aacdd8e..12ff6cf568dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -578,16 +578,13 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 
 static bool soc15_need_reset_on_resume(struct amdgpu_device *adev)
 {
-	u32 sol_reg;
-
-	sol_reg = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
-
 	/* Will reset for the following suspend abort cases.
-	 * 1) Only reset limit on APU side, dGPU hasn't checked yet.
-	 * 2) S3 suspend abort and TOS already launched.
+	 * 1) Only reset on APU side, dGPU hasn't checked yet.
+	 * 2) S3 suspend aborted in the normal S3 suspend or
+	 *    performing pm core test.
 	 */
 	if (adev->flags & AMD_IS_APU && adev->in_s3 &&
-			sol_reg) {
+			!pm_resume_via_firmware()) {
 		adev->suspend_complete = false;
 		return true;
 	} else {
@@ -603,11 +600,17 @@ static int soc15_asic_reset(struct amdgpu_device *adev)
 	 * successfully. So now, temporarily enable it for the
 	 * S3 suspend abort case.
 	 */
-	if (((adev->apu_flags & AMD_APU_IS_RAVEN) ||
-	    (adev->apu_flags & AMD_APU_IS_RAVEN2)) &&
-		!soc15_need_reset_on_resume(adev))
+
+	if ((adev->apu_flags & AMD_APU_IS_PICASSO ||
+			!(adev->apu_flags & AMD_APU_IS_RAVEN)) &&
+			soc15_need_reset_on_resume(adev))
+		goto asic_reset;
+
+	if ((adev->apu_flags & AMD_APU_IS_RAVEN) ||
+			(adev->apu_flags & AMD_APU_IS_RAVEN2))
 		return 0;
 
+asic_reset:
 	switch (soc15_asic_reset_method(adev)) {
 	case AMD_RESET_METHOD_PCI:
 		dev_info(adev->dev, "PCI reset\n");
-- 
2.34.1

