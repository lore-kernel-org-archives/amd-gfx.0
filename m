Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C073CC28CF5
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 04:09:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0708510E513;
	Wed, 26 Jan 2022 04:09:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D77389ADC
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 04:09:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnegJQCJef9XOYJhCmqYXpoeO6R0ruGDafhLMDiFtSLv7iIOr4o7RJxxlCZqY8NR6z3tf1+EVIv/Z6NgxuexE0c/MqgGVs39CUYvrQ8xUXYi3PxP5WEe21eY0tpfsBepsWxIjTEXN7CYGVr7IWmZK/MChoO+QH/jyVSiH+KcKEmcWfI+GG5gj6rmo+i6FSanDMfqiW9g1ogGmzT1vXLA26RN76MKXZSjgAZNNj2A9peHHZ7avgK9IzLxSrOqJRr5cjCgf4cIykL5bxJDl2VedEBK9hiTIvNaWepBzDU7G8aBtTdgCjor0xsWviu7Ogrx+8GtlYMkbwi6aujVnYbScg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZdhzK55BOKI3JR5GdlxRr+uU+MZkgVn/jeyEo5cBsw=;
 b=gkdyqI6FlUr91x5HXuQOAHAYOW1J1PU/Pbz/FBRFhgOAf4ePbhg7G52e312EkewlHShlwzyjKxP6FCcZj9Om4EFSurgsw90uANuPK361iWFE7XnG3RhN5iR1KjPGg+ZYKvDhtu173wWRgDPvw8munjrIRPB56IqN/WTn40KpbO3j3PJFlSFmUlZW2LEaHYiXjHqgHnxjfwMWkkcG6mQPGjn3GEuBpWQYAM63KYZrLFoeb4hyR0LR7y9sEIYipYBwhrxykso9ZTnbmAYgUagQugxMeNcnwoOFi3a+zCygUcinMX6uVElzG2jE2r5uPrWmpiQnEpigCUUH+jfnyQspKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZdhzK55BOKI3JR5GdlxRr+uU+MZkgVn/jeyEo5cBsw=;
 b=M9omLYdPg1ZgvZ8Q05MsOwTtMP45ZS2wLttCVOIOSAKlY32Vtm3Y/QDib+oBy/jxzvah2eMLepkr734JrgDxL3MbD0wsYW0KggxtdKxlDSl4w3nw9e495Jjkl0Tg5aWcmN98UOEziEEUSxXKdzB8u5eE/IQ8a8h/M8go05IEa0M=
Received: from DM6PR06CA0018.namprd06.prod.outlook.com (2603:10b6:5:120::31)
 by BYAPR12MB2904.namprd12.prod.outlook.com (2603:10b6:a03:137::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Wed, 26 Jan
 2022 04:09:41 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::a) by DM6PR06CA0018.outlook.office365.com
 (2603:10b6:5:120::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Wed, 26 Jan 2022 04:09:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Wed, 26 Jan 2022 04:09:40 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 25 Jan
 2022 22:09:39 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 1/4] drm/amd: Warn users about potential s0ix problems
Date: Tue, 25 Jan 2022 22:09:41 -0600
Message-ID: <20220126040944.4324-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f22f2e1b-f744-42d5-8c20-08d9e081ad30
X-MS-TrafficTypeDiagnostic: BYAPR12MB2904:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2904D6B4EF243728E2BB946DE2209@BYAPR12MB2904.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fAVqfqYHQP2og82frQ+H5uGq+Ms8wJGKvMjiMO0yxQVbNbxrIMtSkb/cTo59SiUyOORPM/ndtt5UfGibam5HTbk/iAPZ5334OgJ5jMMpdxxEAcyG8To/LS+WutmdZFtJKzRsVL+GRMQUm2njZfdsA3UQhdcv8YIp79G74kmM1vNkayffPcyu+Z8dZYXicV38rRUEctcsJnjntjbpQ02q+LZOfYj6guXO3H0vQ3QoRHSXmSmUzhlvFwgJwuba60IIBeo+vF56pkr6cUXf0ltLqo1K8j8uUUc2bsVjTbbMxFBX37khy5JanfmVK31wzJFpv8ZZXK9ItqJXK/eO8MMwaqdQMdMWNqV87YE1OE/k/hmPX+z0p1PlcrMplAYk/TOVYDwTQx6PB2RAiA3pu+k77v4d8n21soC926AbrlOvSfJCRZ+q0jD4ALHMx62t72e7SlAnEXM/B5q2j2bRwFpBF9ut7wEfAR6C+E5GSHD7Yk25HfknvNc99OwXGERdDEshHflfkp/+/wwGIy4vWmjc4pulNuXbPJQqu/zc+0/nfhdIBl5zhMTcwc4dh5r6cfArW5+uNWT2IjDvyXFlecYfONU9fPalUwCn3acgh2XYB02cO056Op7bWPjQ1WUghd50n6FkYMqro1RsI9BMcMzzqk9LQdSEss8QBgC11Rq4hgoIRm5FhKl2MYUdbLH/7EjWW3xb9cf/cS19/foOsS50swB2gVs4iSJTYURjjipjtV5X0ZC4sAryxP0H2RgTQR+OHbUepCWBwxY5KvLF2ORmFBEbwe0gmHrl0uEp/27qGkeYCiRR8SzDMxCJCwZ0SF9z
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700004)(8936002)(7696005)(26005)(70586007)(1076003)(70206006)(83380400001)(2906002)(336012)(44832011)(16526019)(186003)(316002)(6916009)(36756003)(86362001)(54906003)(508600001)(6666004)(4326008)(81166007)(40460700003)(5660300002)(2616005)(47076005)(966005)(82310400004)(36860700001)(426003)(8676002)(356005)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 04:09:40.9741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f22f2e1b-f744-42d5-8c20-08d9e081ad30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2904
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
Cc: Bjoren Dasse <bjoern.daase@gmail.com>, prike.liang@amd.com,
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

