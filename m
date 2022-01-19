Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64136C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 03:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF98F10E4BE;
	Wed, 19 Jan 2022 03:41:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 745AE10E4E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 03:41:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zt0+rS+cgwP2AGs15mTeVKC0DorQHzD36iruxAz1UQiE2byTXzLBLJW+HGIbXNb+lOjaFscSjwSvKZ3XEL4vyqp6Tg1WZv1dNYOsoCFCXFDqKx/BJ8SmcZzycnPqsyjQhdqQMi+yyRtYULTJy0z4M6KQnt1R3kP/bypNOgMvG7KakSVI0Lwl/DLhCxFvtA9uLjtWuFCyr9kgrsuOQXwYuxme1eT1wzKu85aSv1M5zu+vxzYnqpGrMeAzuhyvDaL2ZomS38vc6mjr+PsrfGt/iosn7VhjWaVdxv2CEzkcE2wLe0Ufq8Lnwlf9QaDcpDGovGOZQ+/0K5TCh1+uW4O2xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXnxSLQCfkd/DNL6UZlL1UGNeyhTMl6b+Y2WQOR/IYs=;
 b=PaRGYMXfTqkxHbHXBbDYXVRhMZDaJBZIL8Gapu2gvNtE444nM6oePw0deaz6qvssk6SvBeeXv9ajf0Jn2S0W3fzHIpwLdWLE1mDdXfyjz6w2istm3307V+yg5U4+7vuakKlXysebRhRMidcvxSudZqCYVJpic4myJzDdid+ib5zVLpagW8E1lMsm+rbXup6hNdM+JUU45sBLdya9UJzei11caWxhcw33YH0Cocm/vlHdA1qpy0dcVTCx8vT9F38uqRN509tHOMhs6PT5+0fsAcLuhGL9Ras+5Xi+flKx42NwG6hVYH2s8OQqLRsTAA3w+vAsSH6eH+k8HZ2IuWe/gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXnxSLQCfkd/DNL6UZlL1UGNeyhTMl6b+Y2WQOR/IYs=;
 b=WvpVILHh+udB9L/8Hio3z7FA/JjeQq9Pxu4kcnXfQl4beQH1FxVBCrexJHqKo+C2MBcJelNP9QTwqdPip+qtdq5oUMKnwLNEDxMWSkSpuQQi2EfKVYMDopMHoy3meUctmS9dgwSNMpwivRKLNbH2oE1YSKqRUp/JwUvT6ggq3oQ=
Received: from DS7PR06CA0025.namprd06.prod.outlook.com (2603:10b6:8:54::31) by
 MN2PR12MB3807.namprd12.prod.outlook.com (2603:10b6:208:16c::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 03:41:25 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::3c) by DS7PR06CA0025.outlook.office365.com
 (2603:10b6:8:54::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Wed, 19 Jan 2022 03:41:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 03:41:24 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 18 Jan
 2022 21:41:23 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4] drm/amd: Warn users about potential s0ix problems
Date: Tue, 18 Jan 2022 21:41:20 -0600
Message-ID: <20220119034120.28807-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17f988c6-c30a-4eed-7357-08d9dafd9138
X-MS-TrafficTypeDiagnostic: MN2PR12MB3807:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB38079BF81EFC6DCAAC9F76E3E2599@MN2PR12MB3807.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RC2Z3I1+dzcHaAnd+WMo6FQbijMEWq7+e/C27uvDLh8KIZ2A9KIpwmcNxYSsYunBVotaXC/17rCLvSb9ISpTivutvx5v3+OWIGJ3IKplor7YWi3hzwRJAW33SKn2DUYhx6W+ra4N9kPRQc1OPOujyq5gTv2QOpomt8GGo7lfNF9mXt1xrhE9f5/6C8uiFirseKtaE3TUJ5Wq38k6UcIwKm04sj+7NbXKFj/X4FShnrd+NhY4AUsGqFvkSVsV87zAjPPltpqijHUC5wWeRB6na9wFbo0wtBl96H33YAG/2hQ72Ih15p3TWEIH+f8RAwPjfqAMWzdyfUZebVeVRub7j7aSaRMaD+VU+cbxbpiL4AazCGvBq6iuLFHC4zyC9NfBw0DkpNfy/Cw84nP1ienchY1nD8vQp9t9qbsK5CneOjSmECGYoQK4jFSZvsoq2cy1lzSYCKkb0HhtfeQ31DsDE5B+qAD94rjLFrVWZyWcpGsYIn3RfdtgYSvIp8h4VINyrV2hjnK46t9NtaKjkzp9DiCc/et5x3ztcZQyYGItiXNJCXnT57DyrV75jgc8I7GZiu+DaCWWe0GX/vkv15RohhHONM9A6BROXOSOfdxFFRF2Kznc6NeZwE+A5ih3R+fBw/bmi4xqYuIPCT88sUqPGyDMo0nX28hFCvQMXc0sgniU9rnZ1pjmel4VKFP+ZgaryC3aGURdoiRc5ueNtHVFF37dL1wrjc1UYW0xUhnVyTVMfFPFlImPNYgVWJKGMkXTAyNrysn4xtFNFevJSGHgRqarhsCkz5lzaVKaWUAAeg42trhWP2z6NRnrECriArN4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(83380400001)(47076005)(7696005)(336012)(5660300002)(16526019)(6916009)(40460700001)(70206006)(70586007)(356005)(81166007)(82310400004)(36860700001)(8936002)(2616005)(86362001)(8676002)(508600001)(4326008)(2906002)(1076003)(186003)(966005)(316002)(26005)(54906003)(426003)(36756003)(44832011)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 03:41:24.6362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f988c6-c30a-4eed-7357-08d9dafd9138
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3807
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
When configured to S3 users can still choose 's2idle' in the kernel by
using `/sys/power/mem_sleep`.  Before commit 6dc8265f9803 ("drm/amdgpu:
always reset the asic in suspend (v2)"), the GPU would crash.  Now when
configured this way, the system should resume but will use more power.

As such, adjust the `amdpu_acpi_is_s0ix function` to warn users about
potential power consumption issues during their first attempt at
suspending.

Reported-by: Bjoren Dasse <bjoern.daase@gmail.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1824
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3->v4:
 * Add back in CONFIG_SUSPEND check
v2->v3:
 * Better direct users how to recover in the bad cases
v1->v2:
 * Only show messages in s2idle cases

 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 4811b0faafd9..2531da6cbec3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1040,11 +1040,20 @@ void amdgpu_acpi_detect(void)
  */
 bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
 {
-#if IS_ENABLED(CONFIG_AMD_PMC) && IS_ENABLED(CONFIG_SUSPEND)
-	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
-		if (adev->flags & AMD_IS_APU)
-			return pm_suspend_target_state == PM_SUSPEND_TO_IDLE;
-	}
-#endif
+#if IS_ENABLED(CONFIG_SUSPEND)
+	if (!(adev->flags & AMD_IS_APU) ||
+	    pm_suspend_target_state != PM_SUSPEND_TO_IDLE)
+		return false;
+#else
 	return false;
+#endif
+	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
+		dev_warn_once(adev->dev,
+			      "Power consumption will be higher as BIOS has not been configured for suspend-to-idle.\n"
+			      "To use suspend-to-idle change the sleep mode in BIOS setup.\n");
+#if !IS_ENABLED(CONFIG_AMD_PMC)
+	dev_warn_once(adev->dev,
+		      "Power consumption will be higher as the kernel has not been compiled with CONFIG_AMD_PMC.\n");
+#endif
+	return true;
 }
-- 
2.25.1

