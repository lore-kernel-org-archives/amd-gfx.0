Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820E8CFC500
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Oct 2024 07:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F41E10E3AA;
	Mon, 14 Oct 2024 07:49:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DkBYasom";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F21310E3AA
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Oct 2024 07:49:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BF8cnZiL9h8Ij5CP9w0J4w8d4+7cNm9c02TUDCoJKakhN9usZCpt3KqHC4G9gRN0g+3xjuf/ShRXtTVnJZqvWJYdMq6P6cR6B0KcJLrR0A0RXhM61mcPyIPFd/OmfrDAPtfzN/C2igmJdofWWYI55xFhFo2W/vcoZxezE3jwZ0FZrY3bSWU+EFX6wQDPViHiNmHDKuACBaskas4XnAJRTZNwC6H4tWPUvKAKMr5SQG86XtYCogxjEOMuhGBKafVSeTBDm5mP6tepNDlIYRN1c9dvT9R7pAxPxAU56Y7UVRR27q2pUST9qqnYP6bhwY6Lx5qdhiLLi/O3TgsYCQOvjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vfxx5gXbT0MD+9ZiFzNodgyW4Sep3M2kCBFLSjiWKUs=;
 b=I7ZZy4JUXPXLaizSJL2d5kJ02U4tyofGzbk4X2kIYkg7DHzqKgpDUAk8pmup/tlwHd6zLUeqYDSdpjrgtdIlfUMhgt0BcBLBfdLioZbVw5crPrIpF8OmO2gC8/TKc1kk4fU5YNoS6kPqGZS5IycjlanKNYQYzcVHwScBaSmqODcj4JHAMVIZU4g/yZz3foO0iUAS8tqlNP6HhcXJEEuHhYRXzWq82s5adP9h2fwGwM7Tg6qPQHDFUWsq53cMeif+mHFg37ypV3sVxEj/Qzh7fgtZEp3XioJfXBsuOyYOiLAhtXefTragDM0BdyHIBDGP6rDARRuCOcdj4d2nIrF8mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vfxx5gXbT0MD+9ZiFzNodgyW4Sep3M2kCBFLSjiWKUs=;
 b=DkBYasomOVIuGcY+r+wx8lshbtIyB37h1MkMxLqTijcGNbHnRNlEKRK/4zSlPVDtbXxRr0x/litmUYwmkzUSNVNqGJCz0SPdGfmok+TkXD9W9zpdqPTedVimh6njA53AMxzH346HwB3rXWc0IU89xWlMEH+gHpYtyS7Qb1q01gw=
Received: from DM6PR11CA0037.namprd11.prod.outlook.com (2603:10b6:5:14c::14)
 by MW4PR12MB6997.namprd12.prod.outlook.com (2603:10b6:303:20a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 07:49:13 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:14c:cafe::45) by DM6PR11CA0037.outlook.office365.com
 (2603:10b6:5:14c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26 via Frontend
 Transport; Mon, 14 Oct 2024 07:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 14 Oct 2024 07:49:13 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Oct
 2024 02:49:11 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu: correct the S3 abort check condition
Date: Mon, 14 Oct 2024 15:49:01 +0800
Message-ID: <20241014074902.1837757-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|MW4PR12MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a0b636c-1aa6-4071-9f91-08dcec24b25c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kY8ssf8OaxAyNw68oq4YCVEzuV8p9ZQswKGpVxLpz0HaIMG1elNcBsiwdqm4?=
 =?us-ascii?Q?k6vX3QtkuO9KZcAFgcAs6JaKV016wTZ6yxaT7RaAACG9ULtxM88WH3y7cCp+?=
 =?us-ascii?Q?rHvvsFvVSJF59GEUaZrbQfu5pYXFR+WCxgPBi8NJ9Bt4+Lr6XGinV5Ig7M75?=
 =?us-ascii?Q?RzxEPQlCKDVkdNLM+2vRS7gBqsPjcg1E3q0r1+sr3RyUZXuj0INnlMnWv9EF?=
 =?us-ascii?Q?viWXtMrLLeDM7GuzRhpZ6OsUPg4MZtkbX8XlZqAxSDHEoUDlv/jEyTk6s5zU?=
 =?us-ascii?Q?c2o7BNs2iDYp4kBOKfQOJYEINOGQzji8qJGW5lVcvG+05Gs+bZkeZQWJgAwY?=
 =?us-ascii?Q?qAI5yB7Fduehnfmpg8m/w0WLLCxjGOZG0deNp7nppRuFdk8wGuCYz4/0j7sI?=
 =?us-ascii?Q?ivlqoWXEGovpH6NmViI1JyOgEqC1FRJqENYqqAhwPmixavNvBie2ppQmwN9c?=
 =?us-ascii?Q?ZPWGo1YXHFe0xKa55SXvnrUyaIPEA0uIenNFbVEdhpE/JYltsva8mPjNaKPi?=
 =?us-ascii?Q?qM6AHIX1Qc5AH7wuem47wjCtbaBMC4HoaT9NzP0tbJ5AKL1FwHRl/9HKzdNg?=
 =?us-ascii?Q?DcBddDrV59tifKu9DXnQp0mkU569LCejyvsyEy/mrOsiQVbdSVZZdv2g/GVT?=
 =?us-ascii?Q?4nFJwRNd/oogVePPPMXZFRnHJxIDdkdSrRJnyM1axls5GiXoiEHJfDHWajzv?=
 =?us-ascii?Q?ftqca4COCBtFh4OVfupvXHcsd/hoMqbvKHB1y9I6BzFjhLzL27p95cluFyvl?=
 =?us-ascii?Q?ieN/RepLJMuWdcCTiiq4l16CDFnFaYHOaO+hidMJfElesBa/rSJNEqxtaYDS?=
 =?us-ascii?Q?7+UUM5enfWyV1qHEe8KOg4CbZsuHtO57oQIg8Sodwwv0QBTyxd3hUbXvDPNf?=
 =?us-ascii?Q?0dFGueEtNfBgPaBZzHs/O4uISO6hejqTYXl8p+nKfZ8WgQJtdOtSmqPm0pWo?=
 =?us-ascii?Q?BlsH3EgEocxkndldqfdXsv/2Ut3yM56wfHavwbpuh+Uxjcb3vWXyFOhNoDDm?=
 =?us-ascii?Q?KMxsmRZ8zeyNNvwD2GLOsCxGM+368oSPLHPvrSxxgDRJKXa7uhWwJEjCka2g?=
 =?us-ascii?Q?rEp/IPdJTJhKNHiU/Q53QjnXfUAgmC1TXlELyyNQRF5jh//uOyh6dhfq6h3p?=
 =?us-ascii?Q?t/qzPGlvYA9xu8uTnVkh+OsQWE9Hl4p7JqMHBpY7VBOYgQjdMQFtcW7RWnFB?=
 =?us-ascii?Q?zm9eRp+MhwNT0tjKNhhPcSFAgf7sC7L5RRSUFe1/YigqdZjL6zL0oTDFbShA?=
 =?us-ascii?Q?xKQ2m8avtcxQz5kVrAfcLbkmIqjYGmbXUpq3bYmH88PdeNcGaW3oL1Z2Vxe9?=
 =?us-ascii?Q?yBnfPS4SePERsdoQXF8SJNevpDAd7QP2gC+prVFj/SJeYEdoAjlsf8sDfbUe?=
 =?us-ascii?Q?QzqhwXc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 07:49:13.4066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0b636c-1aa6-4071-9f91-08dcec24b25c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6997
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

