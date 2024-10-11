Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186BDD2447B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Oct 2024 06:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9C0510E2EE;
	Fri, 11 Oct 2024 06:01:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JQcyefpp";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A583710E2EE
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Oct 2024 06:01:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQpHr7L5tlUusQmXU4Gqg1FUpUMRucaiRgwMWZaiQB8Cik1Dn21293jQzsFc8tQidsJdjIyHoVE+CNchvr9xnFkTvrBV81Byz0lbE6LNdwpamkApGsqhSnHwYEJsmivW6+I3XTucio2mGF/w5tiWSt9M4JoTJjPNuwbcObIh0T4mFOVEzw3M/xR4tQUT3XwFcENJ3U1/HpIzi5460iEKmQ2hSAeHr7pfLVrImc0cfUN2J8h6u+uHx2EUG3UFDDIe0zTl+H9KHAiRwqKFrilI+S3wYv01S1PdA8VIPFjuukik1xDnrTQrs2xW+bM2VNPy5LpfuhCCq3mc+ezbBWrbsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+m3jPuV73v6/rKymGAF255mwPaNOiYLbSCxWineS2Y=;
 b=wtQh4AoRXs8LcB2ZToKa41VhEKhJoRdFVua3oNySH1iJj177iBGXDcH1y4aLsORPD7fZlILKCBi/779r6yj2KxaoOLTU/CJEX1zMo2h1jLcPP8tyzcwL+GZIOs4uWC0msH9sJe4Kd+yWln0f0b6PbGhv7IXvMlf1ZJE0/C69K5h5ikwQd1v8X6YJ+mPbbLm6U6P3YDr9VAA18upMRwL8IdKugbQK+smR3bufA4SSvYgORUETWKQzLEHZ2JPWG776rGo/apQ21BmaPTdP87A6OH1IGRhnPmRXETlMNHb23QAXYHHikm+pf3a+kh5X1x9HsTgOs+I8Wr+/m5y3hZ9+KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+m3jPuV73v6/rKymGAF255mwPaNOiYLbSCxWineS2Y=;
 b=JQcyefpp3+/pYQ1CvRUH8PwblkYXJPUwtMWdE5KwN2YACPe1xX5oer4aTinZv4NQMbP3JQvcFckDjXCxyQldlN39UdSS8p1JhaL7eWe9vtMegQ3ZPCG9anvuRAWCuRMdF2eKASRTpAAP2ZJhKLTkNPxRMo7+rpAO4CKUYvZrPPE=
Received: from MN0PR05CA0004.namprd05.prod.outlook.com (2603:10b6:208:52c::10)
 by DM4PR12MB6470.namprd12.prod.outlook.com (2603:10b6:8:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 06:01:18 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:52c:cafe::7f) by MN0PR05CA0004.outlook.office365.com
 (2603:10b6:208:52c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.9 via Frontend
 Transport; Fri, 11 Oct 2024 06:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.0 via Frontend Transport; Fri, 11 Oct 2024 06:01:17 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Oct
 2024 01:01:16 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: correct the S3 abort check condition
Date: Fri, 11 Oct 2024 14:01:05 +0800
Message-ID: <20241011060106.1745314-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|DM4PR12MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: 30cdd5df-5f92-4b83-59b4-08dce9ba1f50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f3WOpSh3XL4S6QlO4U5jQjH00ZvE8hkVnOdia7k0iGhpWBgSZ1YyYmSYKt6r?=
 =?us-ascii?Q?Es4IecKqkbhqAJONcQfJXkOxsV/Zm3rf6P5p88O+fxavCFXOCG6q56sdqovY?=
 =?us-ascii?Q?VwM4BD+Wfftpq5ne9WWN8L+9SY//xHt9E992K71AoX5W4Qr4ISee9sLibZGU?=
 =?us-ascii?Q?2V/7c9sG9l9gf9U3uM0RAm4FFHQPXplUoUxr0x7DBnGP0Nh7sUE/FYQo3umc?=
 =?us-ascii?Q?55JCYwE1mibPzNHahLmwLsRvGj1kdlxb+54Zc+e9jUE6QSrazXxJ1ZAynKxq?=
 =?us-ascii?Q?m8hMBMTLOWSg9tboBZuNgt9TfF+LbCmGmVQWStUXnCvrbie2tl3h2J9A8nMu?=
 =?us-ascii?Q?6LLLxCuyj3v0wDG2M1j2tFGNN7X+eYj5CRaWtyuP4Yq77kr3/beCTwdKPfok?=
 =?us-ascii?Q?hH7hmM3LeD8kfhSjnGXytQZVUQ6vJKS9HXfRA8TDaojWbGpbrCrgQxObgOWV?=
 =?us-ascii?Q?FDLw2rv2iDvH6k01wROwJxp0zvER4JcUz1fnc6NfTMvPeWz3dpMa+oaIv0wG?=
 =?us-ascii?Q?RuzwT5KuJRqB0unRNV51PCk2lFZwgqWibw3PjVdgHskT3L7b+MynQ5bgi7ZD?=
 =?us-ascii?Q?IkRKrvm8wRwSVVbNpNpNGhZzY25/6OpEVvZ9IOc3vfo4bipXvQvKMu+PBULv?=
 =?us-ascii?Q?tIFizslK9l82Bv6vf3pYVsXhCa4Hwj0oE/Yyb7CBwpAf9NagXkkbX8WPdI/M?=
 =?us-ascii?Q?zRo9IJsdOkzRyAPPptD+B8xhjK67P+zQmNEe24lI44bcIDf6t7N2ixfFTJKo?=
 =?us-ascii?Q?uUV3oNqdPXZD8/wQfK45uXB+afF4Frv3GVdRylJ9f+s1xfYdcPqXL9J+ZJ39?=
 =?us-ascii?Q?3RRn30kGYJOMsGlOYGmoI0O2mzLVWeDEf9fqHeggeQ8c+FmkTp8+1TxiBkcL?=
 =?us-ascii?Q?pUfnqZ/bzHZKjRucYn1m4InCuX5kuJmAnPNcEN471MQlmoap+VfhBLvNjuBb?=
 =?us-ascii?Q?nlaxTiUMDV4jsUjl8a1IfHwOrRu8KgFuBnl12DWpVNMxG6NHLKgAsVZyhfyJ?=
 =?us-ascii?Q?MAAZUqq+9nTXPhX/0f+0YswtXckz9InezTnpa9T2OxF3Lvm1WBmf3kYujfN6?=
 =?us-ascii?Q?c0xTlOcvJ7fHAbIZswvCgpuqpLmumU/MkXaa1RtRPg2hLCQtLaB8o+0OkKTa?=
 =?us-ascii?Q?H/3j6gnOFEE6XEwSNhp4nV6kb+PBO1sCzzzjWfCRbd+MtgHRhBHITcfQxUJZ?=
 =?us-ascii?Q?4tMG06ceWU6pfiPGKXPOU4q+pxPM7voNCOhAbH8mSdDwoX4uarSWqMV8gHF1?=
 =?us-ascii?Q?3vgXRTsD5cUFRkz9j6Z+/+PQXOtWcAQH5KLn14AG4bpvcpeasQnbjswnYXOr?=
 =?us-ascii?Q?kcoW6qavgw7jCprBZPP3jUETJ3vkjouqteyhdirVG8tXZNM7z7tzbeXS7LfE?=
 =?us-ascii?Q?cpVRF9w=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 06:01:17.7691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30cdd5df-5f92-4b83-59b4-08dce9ba1f50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6470
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
 drivers/gpu/drm/amd/amdgpu/soc15.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 619933f252aa..d07cf8137bd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -578,16 +578,18 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 
 static bool soc15_need_reset_on_resume(struct amdgpu_device *adev)
 {
-	u32 sol_reg;
-
-	sol_reg = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
+	bool suspend_complete;
 
 	/* Will reset for the following suspend abort cases.
-	 * 1) Only reset limit on APU side, dGPU hasn't checked yet.
-	 * 2) S3 suspend abort and TOS already launched.
+	 * 1) Only reset on APU side, dGPU hasn't checked yet.
+	 * 2) S3 suspend aborted in the normal S3 suspend or
+	 *    performing pm core test.
 	 */
+	suspend_complete = !!(pm_suspend_global_flags &
+				PM_SUSPEND_FLAG_FW_RESUME);
+
 	if (adev->flags & AMD_IS_APU && adev->in_s3 &&
-			sol_reg) {
+			!suspend_complete) {
 		adev->suspend_complete = false;
 		return true;
 	} else {
@@ -603,11 +605,17 @@ static int soc15_asic_reset(struct amdgpu_device *adev)
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

