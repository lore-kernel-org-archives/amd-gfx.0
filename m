Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF26EC77B7A
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 22:34:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B55710E432;
	Tue, 30 May 2023 22:34:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4522110E432
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 22:34:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOocy/93v1/PWDTkajEzY6RP896E92b2+lPVGEvUXjIfVJibIaQULjr6zDq1mRZNIk+aCEyHFcVo0Pr1qBwqT2u+Ecnrvs5cDnq355DtZ7nwt8gKO14T5aLw3A3xV1CWWF8Bo2CcP7kuXwMg2208a/ggqhVGSiP/8fDfBMfFyqBwxiwZPMlZuREGRaZvDq7bQpSXy2z7qxkRhDru75HRPIh/aSwTaik5w7/knq2mT2T25aA6P556oB2YCfdr9h4nr5NwobuRhCmEW4YzUlJ9BQSASFL9LXVlmRJMMgOjaFj1pj8BhRkHKOJcLm4iyQp2pFIrUqx/popjmuaCSS7sgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2/TiP90wbMl+77BTawL4DxhAsHb14kWekNJM+hdyyM=;
 b=UnYBl7yZkG2DiB1WE61Cou4LN4HNsjcPFfi3QlGPlHujzzFHGnntWpsLI5sTu3JNHu4XC9pph85AbwvMYZRr2TSU/H//PPbaTV4WybJT7pB6adah9AdRrA01FOfic3kL4iWNMy3vAcoKdQA1Mrb6xfIhH0TytIfeNuKV2bIGwVdgP6ExX+Nzcp+0TbWswxFjTonSSvxWU+h/e3U6bcrlHnz3F+5ucgQmC27ZjqojAz0DtVTlwRYTgWXr66d3nSHAAXdMYUnHzcRn3zZJQcUqVmyoQF8YuTF9rljBJRJxLWuqR+XUevxG9HB11xHXqjC4PSiLBf4ok5bPo09JoMVHIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2/TiP90wbMl+77BTawL4DxhAsHb14kWekNJM+hdyyM=;
 b=JXfBksF4tEMwQoigg3WpX+WikznrdvfNc1cA8rOVXkFmFY+OiSxmrq4OuRfe+Z0KwvIv33c5ZiePUjD7shBsF84ceb1ktCnVKXxA7JqiYlSUJZ72ttshW0FnfI4UeawZjSNYA8MQi6OGoUfGnznV+3KVj7Ew+lTcVsFyx/LBbmA=
Received: from BN0PR04CA0184.namprd04.prod.outlook.com (2603:10b6:408:e9::9)
 by BN9PR12MB5050.namprd12.prod.outlook.com (2603:10b6:408:133::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 22:34:47 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::c3) by BN0PR04CA0184.outlook.office365.com
 (2603:10b6:408:e9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 22:34:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 22:34:47 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 17:34:46 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] drm/amd: Disallow s0ix without BIOS support again
Date: Tue, 30 May 2023 15:48:47 -0500
Message-ID: <20230530204848.231842-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT054:EE_|BN9PR12MB5050:EE_
X-MS-Office365-Filtering-Correlation-Id: ebca7edf-cb3e-4ac9-63ae-08db615e12ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oFoRJ6x4xPdIICc4/uM3m7AnIwO99u+/HZYjFcCIk+zHnKdJd+dgmHgiVXL4asQ5xRWtj219gwRlBRtvBC1WIsWY5leaWVO0xkeyRZiVlXvKRgbL14+H/M1eEgfNMqNOWce4ryQTpk+3006MUDMzIlfaIMJ1xq9vAYmKx4eTTvb4bKALVGHKM7VTFWtrZaAOOAl3o7aaj4dKrnu/G6buluwtRsxGdXZCP13+di8s2+3YXia6oahdRaWkfHIeZAZMlasa4ksVlWWgZD8oCy9d8E1Z6TxQf9tm66GwuE17Um2i/zBi9DQINjrWED7NpoD3TzrzA1bM47e3Epa1yOeFbr+0wD2yAelJZN+OX8X72xHzhKt/EXsbgjSHDi17whd+/YjICr/Dm6PYETBsO15QWrHFMljTN1Kwp6vek2eJoNSrJv+CA8f95hYsJJQ8TO8Pq2i9zojCE6Yzu9Dih+pKTdqBJaNo7r6+zHaTAMPy5pZI8i8h2uyC2fFWxKkb5mmJ2OI1ncSXnpEOAKXgcM1lee8rbqs7jgE5tqYIcairW0pHrm5bVyr/qDk29iOkvnw4lPAre6i5VJEi7Pz/aP0mNbAY/UHytwuNqSHs2fa76ss+2uAxL9SdMgUAmfR2GKVi00TRmkZddBw9Ii51+umXaBYFoaIyZqHKhL1O6kjqLFYYYvWob47Vuo5XcwO9inUFeHbI4VlkWDJqXeBDuxM7c7b1DCb+l0grlDjsdh7IaDmQ59t8vBD8UaeVvknEZ19TLEZ3JD4voANrzkA6ZpWDQGKFrVjIfYNgFrlZbZeoEMA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(1076003)(40460700003)(36860700001)(66574015)(83380400001)(47076005)(86362001)(36756003)(70586007)(5660300002)(316002)(70206006)(4326008)(6916009)(82310400005)(82740400003)(8936002)(81166007)(8676002)(356005)(966005)(41300700001)(7696005)(40480700001)(54906003)(2906002)(2616005)(186003)(44832011)(478600001)(426003)(336012)(16526019)(26005)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 22:34:47.6291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebca7edf-cb3e-4ac9-63ae-08db615e12ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5050
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

The original commit also fixed a problem during resume from suspend to idle
without hardware support, but this is no longer necessary with commit
ca4751866397 ("drm/amd: Don't allow s0ix on APUs older than Raven")

Revert commit cf488dcd0ab7 ("drm/amd: Allow s0ix without BIOS support")
to make it match the expected behavior again.

Cc: Rafael Ávila de Espíndola <rafael@espindo.la>
Link: https://github.com/torvalds/linux/blob/v6.1/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c#L1060
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2599
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index aeeec211861c..e1b01554e323 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1092,16 +1092,20 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
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

