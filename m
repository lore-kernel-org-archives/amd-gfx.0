Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462D8D0C5F4
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 09:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED2CF10EA58;
	Fri, 25 Oct 2024 09:45:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TckgSCcc";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 197E610EA53
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 09:45:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4Tl1hfqtkc9yPRKUa4b3XRMiHZu51in/I7nbGUEodG1s9P42v55kaIArnVosdM3824jK01fZZLvKYSzefBj1wDougZ588RLGbUQUgIFc8yzugpOAg2aJcZYISPnhMGMHHNMHmGKl3rmTN+pO7YDrnw/3/BdtRlJHc79d76vVzi5Dyisp0uwXphRai35qMgVQaUh/bP9F0eFFjbbzbRyYEX+FkLFUSsWV3hzNdoGxmy1F5cGFLwG+M13OAL+W8TNGcBpPcZocIgoeuLF+BbJVsxp6tx6+813/X3YIh+PJRQGtEcSx6NZqhVyd/xcIEqcZlikc28FtpzMt13ruH/zrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vfxx5gXbT0MD+9ZiFzNodgyW4Sep3M2kCBFLSjiWKUs=;
 b=BoaAnDHTVEECkO87CrdUVxbUWLX3i09ChSjUtSbv+Tm4wWY/7DaLSaZPF8cfpyS1Qe6ZDc8E5W2sxaxDye7L8C9FtD11IHz1CjOQ4ewgwQ9vXEn8WKx9k7r5KpKYLhu8xA1tjkm260zdqTFmoHZWOqjH6FQHPjcPrcH8B0UJt1k2xnxIxM3EwJTFcGuzJvkQXnJs+qkgS4uRFCbI2RRlEAf0/3D05J/9eY1JQDTm8O3Q68eBV3v/nEkOKZjzCwp76oflb4uwP1HnW01ymq72I31CzbdZZufKCP3Cgtc/5q1x8PNC6og/I6i/W/Dj0k/gXftNEpAqy660RTjP8U7dTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vfxx5gXbT0MD+9ZiFzNodgyW4Sep3M2kCBFLSjiWKUs=;
 b=TckgSCccvcfOkpoNVm9sEOCP0Wl/ivQSJIfpXAeryVybF4gXJHWo88fVfAfqqdgvDivSWxQ/gAadYcL+CgMvX89Aoeg9O/PtUYmnn+wkdeVFvQ7X7NDqPb9zbqo4H8qK4TW5/eMbpFXarO/eUPq4VlHNMc89VHyOptZJeQNUfHY=
Received: from MN0PR05CA0009.namprd05.prod.outlook.com (2603:10b6:208:52c::29)
 by PH7PR12MB7356.namprd12.prod.outlook.com (2603:10b6:510:20f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 09:45:32 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:52c:cafe::2e) by MN0PR05CA0009.outlook.office365.com
 (2603:10b6:208:52c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.9 via Frontend
 Transport; Fri, 25 Oct 2024 09:45:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 09:45:31 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 04:45:29 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v4 1/2] drm/amdgpu: correct the S3 abort check condition
Date: Fri, 25 Oct 2024 17:45:18 +0800
Message-ID: <20241025094519.55723-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|PH7PR12MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: e934c967-59ba-4430-a82b-08dcf4d9c3eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FAkdV3cMAcPfcDgpg0JWfumxNvRUKYqIZcjVtVm/WeTWs/VRj0m+UdjiNZ6/?=
 =?us-ascii?Q?5PtGbZfYsDQzv5s8q4sQrJfQ2N311teznsp07w0x2oZSWmSV043ckxFFeYl5?=
 =?us-ascii?Q?xughxjuL0JlDihfMWSa7U3LOiNpz6E40D+XRTHNsEyKLz5+SK0aMu4KrWEtB?=
 =?us-ascii?Q?VisAI31wIAMpeE2RND0JCiAZfU0jmAXnLPTWdOUP82T7LgoKG0lPJyDVq07I?=
 =?us-ascii?Q?/4pV0Hlq/0V4Gy+64B+p/gv/K7gmoXgczx+mKpgHzOMhs4p0lh4LEnxiLWmd?=
 =?us-ascii?Q?OuLnX5vw+Bljtyl4sXbltIBFtv4v7wp0TY1jSe+BEJ45bSWcziRg2PppjcLq?=
 =?us-ascii?Q?LQxgbrr5M9BirH6iDPPDrLNO5BAej60FRreHlu7NValwboy5Fw53s1RWs/0b?=
 =?us-ascii?Q?B1SIY8Eeyg+VyOiIlwqxgJ8OPeWva9CbWBr8IR1Qnkc1E5i8+bXAJ9pU8Ml6?=
 =?us-ascii?Q?NDtA9ZHKhcFDTiBoNXMRhbyKHYj+OJHNUG4YmflcIAKM/4w4QjjRYP7QoYCv?=
 =?us-ascii?Q?EyF1/Nh0+EyBgqQMt0ivbzQRKh2S68nsbAz5ct4+c2N30fE2+AWIsvct4VMj?=
 =?us-ascii?Q?g3KM5OArePsz6wvUO08/MSjuUVTBLsKvmzX07FRO0XA8X9mF6BZQpucuIZIu?=
 =?us-ascii?Q?V08Ha6YRJxi9ds54o9muz+Ap7Qb17imkn5dbF2pU24Ru3qYPPVTvu66GksS+?=
 =?us-ascii?Q?dO3VnYt+tCrwR7E58cir8DGQJl/06D+tnetsyRfw10gWFYvnAN/zGARRBU9S?=
 =?us-ascii?Q?01usv0Ly9BqeaF+4uo86Nggds8PDrJBR6FS3iC2OFVuBnpeVLX2FcRkIeV4P?=
 =?us-ascii?Q?Jjp1e/kOnAkA6clnxXkmmwPELYVuuNJ0GDWzuKnDJQaPaQC8FnMeZomOGeAr?=
 =?us-ascii?Q?zZr14AwSbs5L+p73bOuW7jatDpBr1TJXbhdm0mOhNq4ST2TgF8ZDTYtp0qJ+?=
 =?us-ascii?Q?WQJQKzmWSeMcwtxzE5Lizbzm56RsH7sA9WqXEqKPoZemfgdSwTqkW5VaGJQu?=
 =?us-ascii?Q?FnLOESbQjkqgcft7Kgb3/eu+9TpyNdPXpBVbu2obKIIIGZ3uncP7OzjkBtl6?=
 =?us-ascii?Q?hkdd9gJmTn6gS7eYtRcuCNJEEicuLkrVIqO2OMZ3P9ih7FF0LxdI2Q3L0bIR?=
 =?us-ascii?Q?Ry8tjy9rA6QTDWrMYndyp9Qe/hWF2H6Uv+TNH7/5IRm1OIKhlEBkosENgMLD?=
 =?us-ascii?Q?3zG2Rw4DIC190gGDPuZ7hyBxNyHzSM3K154CxlMnWoehtd38dWA1f8TT38KR?=
 =?us-ascii?Q?BHf1YIIYKGF7SDo+0T3lJG6fsRkxr12xvoItAusG1l7Rcczxd2l9285FnHcF?=
 =?us-ascii?Q?7pgYPtlvwnumUn9PxhDN3CbQ+yJFRf72k+LVdVo3k6QW8hagIBU6ObnwiRSP?=
 =?us-ascii?Q?yzslBeLwgkTCerMtVkrkYhME2/cHFd15nm0UkHZ5TZbINO6/vw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 09:45:31.1068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e934c967-59ba-4430-a82b-08dcf4d9c3eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7356
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

