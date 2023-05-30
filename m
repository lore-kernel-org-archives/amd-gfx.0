Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3472AC77B73
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 17:53:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B3E310E0BC;
	Tue, 30 May 2023 17:53:24 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACF2D10E0BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 17:53:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIDlWnQ92RMI5ksNbyjItf0mcXsxphDRPHBBgBGTVN68P/Rs7KoMar92XFjS6xNp6oClK9M940oxB3HPxHa8W+Jf64xoh12jc+zAo6iqlS5ZWJIETxPXefP1Dk6sZa4u3ln8MM7vnEc5qpSTZgBlWZ2Of+B4d5pT4aLqZB8nVqvmXot/oIwzTKZR+IpsyUs3pOHB3XYe0Dbgvf5XlvlpLGD/DBcjHq9oRHBlHwFZ2f1HF6SBsTcJCg73csXaUBDKFfkGEC1rV7EChXHNG59Miqx/Ie/+hN6xrcNVImEE//9MkBCaZ13PX3g3WkVmtdqfFy0o8Cq3n54QVJughz495g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtJFwQW0QFO5mWxKWqBfVUprRAUNHm2d6JdvVXtLCwQ=;
 b=M9blDRIYf0Ua3FtYunAj8ZZ1Ap3aGCUpujtBOSTjGeRO2+1OwD5STs/4sK8nvg8TdXd66gcNDbB7wfNTn1eOxkxX+6B8+AHMQ7YInjEgHMZBix0kGIm9so/qbiI86XRnyOKOT9GIz1jbW73m5hmFWuv1RFnPUUtndegutminw14g4eErZGr0MRZj3b0zJb4QqUI+hQPsKY+FtS+8zPc6rjKu0rV/1fxO2r5yuIdcsZoqNq0fT3J31xjF5xB8x1EL+SJYcIXUhOT2/KK40Vm8LYFEXiDDrTx+Q9ZVOuvWTnr7L0xR/awZl0j3pdRtVaD3ffocTtWGmvWTg4t1v96fcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtJFwQW0QFO5mWxKWqBfVUprRAUNHm2d6JdvVXtLCwQ=;
 b=lIRiI1mPjefNSEF8zC9Wvx+e08wfHgeqR5ZRbiCcEruXpANLq6CBachwzTTLUMhZhqA2MLH0vzVklukithLKMC8Wk2i0sDQZGaAsr643exJ+YEjbrlbZyteAJFYpN49fAgKgTBt/WchahKI72+mG7aERDG4fbJ+cUGcaLC7CSOg=
Received: from BYAPR04CA0036.namprd04.prod.outlook.com (2603:10b6:a03:40::49)
 by SA0PR12MB4541.namprd12.prod.outlook.com (2603:10b6:806:9e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 17:53:19 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:40:cafe::37) by BYAPR04CA0036.outlook.office365.com
 (2603:10b6:a03:40::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Tue, 30 May 2023 17:53:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 17:53:18 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 12:53:17 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd: Disallow s0ix without BIOS support again
Date: Tue, 30 May 2023 12:53:00 -0500
Message-ID: <20230530175301.231070-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT019:EE_|SA0PR12MB4541:EE_
X-MS-Office365-Filtering-Correlation-Id: e51fdb2b-ccfe-452a-a9fd-08db6136c066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3xtO/1s2KAXiP6CUOP47m1JpJo8I48+MfZPv94T/nkQZTK9guKechWkF+7c8ysHd6irqN0EM8fWWTV6oFn+pnyVdbQfjpfUioRrF9dvOWoY3te5nnmo6ZElcQfCVbEzJ2hHX5BCGzhJ/X/mfrT+vRZkhUj/XP0cxNHBY1z/NgsaTj5ZpVNOWBVzUa9b2kU63Vh7us+cpPUyLY1qGZvna0aIiK/LEavWLvEghUjDDV8ecPLe0cVybqjEah8mq+vC2XEfbNJDETcgesyRpuNf8txrg++GvkGg6pePNPAIBIPK42s0tRLvD1KhiiNWSmqf2+9ltf3NXTq3Lr4E7e0RC/DhMNWJuuOJkN/yQHlKZl0dgJyiulCjg2pWEtd5x/DCZyYMRdC5w2XEKNLXBr84V0nCBTtxLO9inuMRBoLOutYBEus+N3WF0BLd8Bodle66+ZVbqhtVjWqdNM3EaYbGuLzccGrEoXhNAiL0HclgAICxvfMJJ+93StYKiJ7D2o7bButbh3LbY4UJFu0l/XNTXbrwUvIYJiESvT6CyHOnsbHo+7kVSVsMuPn2xdqrqwfGsdidnCgibG/eTFSHbaqyEqe6ZLRgayYcmEpOn+LY8/aCgHJLg9caOrkTsbI7DDDFUzfFJmyxhDoZfOQ7efvdLE51y4MXXmpGt5c9U6SD8rf0nYM7LGYJvIqxnYv7YbkLG5L3Vb4rRKpSpU7MjthTuP91V/9q+idQdOXuiXb/kJi1gqbCLltc4z8O1djqFTaDM3M+fej0yoMcFTHNGUAwJ0cTC5ImI/I9q0F5W3rHs+uA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(36840700001)(46966006)(40470700004)(86362001)(36756003)(54906003)(478600001)(6916009)(4326008)(966005)(70586007)(70206006)(316002)(7696005)(6666004)(47076005)(82310400005)(40480700001)(8936002)(8676002)(41300700001)(5660300002)(2906002)(44832011)(82740400003)(2616005)(356005)(81166007)(426003)(336012)(1076003)(26005)(16526019)(186003)(83380400001)(66574015)(36860700001)(66899021)(40460700003)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 17:53:18.6357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e51fdb2b-ccfe-452a-a9fd-08db6136c066
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4541
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
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?Rafael=20=C3=81vila=20de=20Esp=C3=ADndola?= <rafael@espindo.la>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

commit cf488dcd0ab7 ("drm/amd: Allow s0ix without BIOS support") showed
improvements to power consumption over suspend when s0ix wasn't enabled in
BIOS and the system didn't support S3.

This patch however was misguided because the reason the system didn't
support S3 was because SMT was disabled in OEM BIOS setup.
This prevented the BIOS from allowing S3.

Also allowing GPUs to use the s2idle path actually causes problems if
they're invoked on systems that may not support s2idle in the platform
firmware. `systemd` has a tendency to try to use `s2idle` if `deep` fails
for any reason, which could lead to unexpected flows.

To make this the behavior discoverable and expected, revert commit
cf488dcd0ab7 ("drm/amd: Allow s0ix without BIOS support") and offer
a message if SMT appears to be disabled.

Cc: Rafael Ávila de Espíndola <rafael@espindo.la>
Link: https://github.com/torvalds/linux/blob/v6.1/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c#L1060
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2599
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 3a6b2e2089f6..a3523d03d769 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -28,6 +28,7 @@
 #include <linux/xarray.h>
 #include <linux/power_supply.h>
 #include <linux/pm_runtime.h>
+#include <linux/sched/smt.h>
 #include <linux/suspend.h>
 #include <acpi/video.h>
 #include <acpi/actbl.h>
@@ -1473,6 +1474,13 @@ void amdgpu_acpi_release(void)
  */
 bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
 {
+#ifdef CONFIG_X86
+	if (!sched_smt_active()) {
+		dev_warn_once(adev->dev,
+			      "SMT is disabled by the BIOS.\n"
+			      "To use suspend-to-ram enable SMT in BIOS setup.\n");
+	}
+#endif
 	return !(adev->flags & AMD_IS_APU) ||
 		(pm_suspend_target_state == PM_SUSPEND_MEM);
 }
@@ -1499,16 +1507,20 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
 	 * S0ix even though the system is suspending to idle, so return false
 	 * in that case.
 	 */
-	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
+	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
 		dev_warn_once(adev->dev,
 			      "Power consumption will be higher as BIOS has not been configured for suspend-to-idle.\n"
 			      "To use suspend-to-idle change the sleep mode in BIOS setup.\n");
+		return false;
+	}
 
 #if !IS_ENABLED(CONFIG_AMD_PMC)
 	dev_warn_once(adev->dev,
 		      "Power consumption will be higher as the kernel has not been compiled with CONFIG_AMD_PMC.\n");
-#endif /* CONFIG_AMD_PMC */
+	return false;
+#else
 	return true;
+#endif /* CONFIG_AMD_PMC */
 }
 
 #endif /* CONFIG_SUSPEND */
-- 
2.34.1

