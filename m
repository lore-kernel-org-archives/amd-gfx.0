Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C639C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 17:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F158210E1C2;
	Tue, 11 Jan 2022 17:29:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 750F610E1B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 17:29:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHcAX4Cv5yKOCgmr43dkROll3xEbRaqhXkgLpE3C+b9Vjs5wgqYkjUMjYQMAGYPBPQ58s57s9J5jeX56G0Aly+0vnasXsTn2yC2NwdnXtH29dp6Q0QoPqaTvfYKWipxwBLdsxYyIPpViwQhSN5JOGdeH4R7zXTozzG+VoNEzqatyKyjfq80gq3ARZcE8E9fbp+OZ7Bzx51yW6XPw+WTW66FGPl/Fn0BD0HC3xa8QYgKNEDWdoohdMt1M8HSoW55syL6yiyYl1gHt2XY2VjP2qkPpwIr2Eqt3bJtHuRXL2nPymOm4GEX8MKMXNh927a6eQKhAI3LSXBgvg5Vyx0oAkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+ECSOwhfKwK2KVWO23hydghPuU8P63iI88WBjYleag=;
 b=kr/4todKHRWMoawk+VBcM6z2YqyKMY/7vQuFcHatQYkkKRXg3bKKxu0EeVh85/F2Z5ZUx5giPtGur6I5IEJYT1EVRp5zDQ1yfa39UQyOKmURN/xmGJZ/LkLzf6nVsDad8ygUstdbpavc1SISho5vnExGeyvpvxUrwIacBnr/bjsJPcK2CkgpyVjediTE2KakhjB0CtuLnGJGhq/Jsjb2fbFLApmvtZgHxkouVLeFF9isZtBkWQ557bwJ7pJTOWt2FXEQj3RYrsJvZ4LVpbXq5I9V3TkVQ21XGSDGX32k9zZrH4+LeYnr+wtltoYXSRtmTc5WQXiQRvowY4Ubd1GbCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+ECSOwhfKwK2KVWO23hydghPuU8P63iI88WBjYleag=;
 b=tUvIk6KSq97zvHad8AUZ4yP0Lf8/MQf7qwagIr05xyZbPlXPy4fV+cDcSnxfEa+9Do2S8MpHQ1TLv6/xRStqo9OC1q/362T4dq3e+IO9OlpdIFIBJ2f8LvV5cAk3F3SEHQyPoAAIEk1hj6aYKyYkvCNkJdLBFsTPX7MpXgNjpRY=
Received: from DM6PR21CA0011.namprd21.prod.outlook.com (2603:10b6:5:174::21)
 by MWHPR12MB1661.namprd12.prod.outlook.com (2603:10b6:301:3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 17:29:45 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::53) by DM6PR21CA0011.outlook.office365.com
 (2603:10b6:5:174::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.6 via Frontend
 Transport; Tue, 11 Jan 2022 17:29:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.9 via Frontend Transport; Tue, 11 Jan 2022 17:29:44 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 11 Jan
 2022 11:29:43 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: apply s0ix codepath to more cases
Date: Tue, 11 Jan 2022 11:29:40 -0600
Message-ID: <20220111172940.2561-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f12be523-e2ae-4491-41b9-08d9d527f546
X-MS-TrafficTypeDiagnostic: MWHPR12MB1661:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB16610C0CFEDE205674CACDD5E2519@MWHPR12MB1661.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tOAFnx3n+NNig2Zq1bK2/m+gkUpjBeiztbiZTEAOpaUdbZCO4htaLGCIiS+VD53G1IUNj3ZA8tDFNAQOGqGFptnG7uubgrKhveoj/XTOuTSmFZSsB9pLIufJMYfDEuixVT6byujpIvKDn1WLzcMQJJIwZfBP0oQh6ASJdqDuI0vTVuP2DupptKzBh9mBRcEk+rdOQH3TGNSYUWIyVkRzkTg43xIpvISoZZcYAl5yIrGWzZGq0fWrW5RoQAavk1/3etIJxax0kkQqVkwgOrx/q65xd/N4r3TN3uRG7dI2iXZPSWGwiY/TG4J2PpNixcFkD2tH0Vr0U1RBEBSwXjOjEuvKjKTbDIRCfPbiMqKWKHKWKAxQLskZUe5W1+b/3TNW+myXYm0bq6QAoph24YN3oIfU7i/q8NUR6MjicrPS/2mApjlQytJBnMy7kic9VbrUg7RtBXdzZ0u4DLovhBzbsXATAUL5sloMxlzWsqv+xeb9BiXSpqG52/ezYi64mOJbueG/ZO7E5XzAeC9yutTR2FiCkC4N6jwDVSXOKsAwGAxdzI8OAu5nAdA7wzv7TdAiMfStpLcdCKoTfWaL/liBuzik6OPRfxYUXak8NSH0TZK2jjgYNb3emtkA3LjKrtByh39WiUCzm52X63O+1vnn9UKkbqptrfvd+H15CMoRc6IQxjL6EkCkmppJVgFaqc/sH91kplh31YMxScftOA/59nJ9Lp27+4K7F/Fle34rfd1gvVaL5qyvsSsvmhzviikV4SHodg/ydVFsCH5mz2hC1pH3yQNJ7lIcSubv9pHjjhqmd5CAzG5cqOeFKlKkc7zk3SObbL6CnZXtks6bYIEN7WLb0zGG547VJxSaZbEiTYANCq0V0YL4AmiNSg7cf8wpq76uFuEE/OECXFAutK21/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(26005)(40460700001)(82310400004)(336012)(54906003)(1076003)(86362001)(2906002)(83380400001)(966005)(36860700001)(316002)(16526019)(2616005)(70206006)(70586007)(426003)(8676002)(508600001)(186003)(81166007)(47076005)(36756003)(356005)(5660300002)(6916009)(4326008)(8936002)(44832011)(7696005)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 17:29:44.4317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f12be523-e2ae-4491-41b9-08d9d527f546
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1661
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
Cc: Bjoren Dasse <bjoern.daase@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On some OEM setups users can configure the BIOS for S3 or S2idle.
When configured to S3 users can still choose 's2idle' in the kernel
by using `/sys/power/mem_sleep`.  When configured this way, the system
will use more power but should still work for suspend and resume.

As such, remove the checks that put the GPU driver into the S3 codepaths
when the user has selected s2idle.

Reported-by: Bjoren Dasse <bjoern.daase@gmail.com>
BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1824
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215387
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 4811b0faafd9..a46bac8f79af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1040,11 +1040,14 @@ void amdgpu_acpi_detect(void)
  */
 bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
 {
-#if IS_ENABLED(CONFIG_AMD_PMC) && IS_ENABLED(CONFIG_SUSPEND)
-	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
-		if (adev->flags & AMD_IS_APU)
-			return pm_suspend_target_state == PM_SUSPEND_TO_IDLE;
-	}
+	if (!(adev->flags & AMD_IS_APU))
+		return false;
+	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
+		dev_warn_once(adev->dev,
+			      "BIOS is not configured for suspend-to-idle, power consumption will be higher\n");
+#if !IS_ENABLED(CONFIG_AMD_PMC)
+	dev_warn_once(adev->dev,
+		      "amd-pmc is not enabled in the kernel, power consumption will be higher\n");
 #endif
-	return false;
+	return pm_suspend_target_state == PM_SUSPEND_TO_IDLE;
 }
-- 
2.25.1

