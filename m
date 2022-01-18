Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB54BC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 18:31:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5929310E1A6;
	Tue, 18 Jan 2022 18:31:12 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2088.outbound.protection.outlook.com [40.107.96.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A20E10E1A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 18:31:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBWHiqbIXGMCuf7BXlh7Kc9ny8RkwHRRsM7vqxd8hKRBgl8dg6g/UrB0XFucdGNCV1p6AtaPKl2ivpu4nxiM3d7+8jxQGBq2C50jUbADinXdN2m3kHS+Ixc91JzsweiFbeMu8ocDZjQsri64XIT1AcqxQDMn3AfUaotYJcRc6DNbEWUCgaWQYC2OvNH9GNq/qphfM75ORModZc0z0tVR12ieH/5IxmQ5fI3huHw4ZKJfVopAAZ/JsW4c8bPhIytCEeZsNi70fWqVDFyJl5Ttg9PmoJKxIFgEjWT6kRQaIZsuzvMDS3nSbQuATN9bXp9LiLQeqGe9M3WH+msmLR3z+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxBdxprCUwHdhvGEYYcfQ6f+hhudiBSRSAW9YFlXryA=;
 b=iPBmvx95VYg9KXkrzRsifLLUR8VIFaAjMb9GLMu44DmeNmBrlBdPoRqFrFuz1E2yfBlxAV0UDju09q10Ue4bP5uaL62fGmkCqyCWvSTv2/au7G9q6ZgQa0dviyM3SAp1Ajkf+vfhV1a/dRJnazzmgFl80NENmqgypl2SVGVl13+kow0SUPRgo5YKesU6xMB9ALaRiFkt9afca0tsKpjmAZtzRrVzIoyC2GvOMJYxxhS+XADkpsdmqhVWGBLrNJEWiqvbVWP1ln/9SDdltohuiNqKsunwXbL4HULMOZ0/GgKw85oud6jVLtErjiFeMevhBOexzGUCVPwbC2vnfyNRJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxBdxprCUwHdhvGEYYcfQ6f+hhudiBSRSAW9YFlXryA=;
 b=InGWdnp4z0H8aDZUU5qihoxBQzbsfGHYwxtv5JMAWkuh1Zp/JkTp8jZaMAj7UEGHnEvD2OZ5meAccOYjuNpTgGJ3C+Z2LN0KSRLJelpuiYGyMDu5ND8KuVHeykGejipi62SJVbJMbr/xw4pCgAFnXijeou4paMbK1XxU5QNVkJ8=
Received: from BN0PR03CA0044.namprd03.prod.outlook.com (2603:10b6:408:e7::19)
 by DM4PR12MB5376.namprd12.prod.outlook.com (2603:10b6:5:39a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 18:31:09 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::97) by BN0PR03CA0044.outlook.office365.com
 (2603:10b6:408:e7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Tue, 18 Jan 2022 18:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Tue, 18 Jan 2022 18:31:08 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 18 Jan
 2022 12:31:08 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amd: Warn users about potential s0ix problems
Date: Tue, 18 Jan 2022 12:31:02 -0600
Message-ID: <20220118183102.32482-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cef3b4e1-5b78-49e0-a6b2-08d9dab0b250
X-MS-TrafficTypeDiagnostic: DM4PR12MB5376:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5376CE9D50829012A6B87671E2589@DM4PR12MB5376.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fyq7+Um/PKY/aFbtGgqnlT2hTd3WFiUArbyRYkS1gxFI+N0fHsbXLn+k3QaYc2XLQ9u4MTQR7cAjnTYIfD6FV5J5cqm/MPKmrus5DLN+Jtczh2F95IzFguyIdxXZO8BXwlepn277u/0iwY1E72m/+wRHh80t/0XWLoUt9wzxi11MC361TxAL6CU/x/aQ5K7SLg80saCHGsl3uE0vG3vJYL1VnXaSnDUPnXQxLnvTIHU0T0F07r6T6mraZrx98eleItBEd9dKGg4qh7+8EQLS7IyseTudZuMFbezEvggy9VSgK0xOcES4HcWiw2fubsCfv6Fsp5+5YpbGMQ+fGD9NIZndtEO8X5bwSeFzRBEP0uh2wLweHr0u3ccuE2HuZHfYhLEzZ6II4UmTcYUh0vE4YduCJP6zpuxAruQIOI/7FudfWHSRTQtFAnlTSk6GYefFfhHgtnFiv81mO1t/h7XjnTc5Eh8FFb2MGv4iw2SWV5R2R01e2e/fmuBC9XA/J737VnrgUDPl+offLkH0Cp6aFm3QNbpxmlTmNeseKm22tCF2W3q38iaJE8OvwJ7jRUlTPARjia1d3bYLGCjf9WsExb2HniUbjzO7DZCZwMs4NZV2Vx81Pbowj46qzH5tMa+0crYF7a6smf4JlaLv+l164NJldgMFr2FU2QKBHYfU6+4iK/9bjOiXijd8GOCH5xrlcJf6H/kvvdWK+4i9yJzhHMdeB4OFqfGhLYj9qKN16azRWCzWx/4Ft1PWYP11IJM3uI77g3mxm2uIlzQlQjiSu0R3QQcVro0KDnSHj11R2u+m18RbB2+8VAxhwMVz6pjVGsb8QoUVCvsiz1T7xxIZgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(26005)(36860700001)(186003)(40460700001)(508600001)(4326008)(426003)(16526019)(316002)(8676002)(966005)(54906003)(70586007)(82310400004)(70206006)(36756003)(5660300002)(86362001)(2906002)(7696005)(356005)(6916009)(83380400001)(1076003)(336012)(6666004)(44832011)(8936002)(81166007)(2616005)(47076005)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 18:31:08.9896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cef3b4e1-5b78-49e0-a6b2-08d9dab0b250
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5376
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
Cc: Bjoren Dasse <bjoern.daase@gmail.com>, Liang Prike <Prike.Liang@amd.com>,
 Lazar Lijo <Lijo.Lazar@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
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

Cc: Liang Prike <Prike.Liang@amd.com>
Cc: Lazar Lijo <Lijo.Lazar@amd.com>
Reported-by: Bjoren Dasse <bjoern.daase@gmail.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1824
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Better direct users how to recover in the bad cases
v1->v2:
 * Only show messages in s2idle cases

 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 4811b0faafd9..1ad379a46883 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1040,11 +1040,16 @@ void amdgpu_acpi_detect(void)
  */
 bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
 {
-#if IS_ENABLED(CONFIG_AMD_PMC) && IS_ENABLED(CONFIG_SUSPEND)
-	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
-		if (adev->flags & AMD_IS_APU)
-			return pm_suspend_target_state == PM_SUSPEND_TO_IDLE;
-	}
+	if (!(adev->flags & AMD_IS_APU) ||
+	    pm_suspend_target_state != PM_SUSPEND_TO_IDLE)
+		return false;
+	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
+		dev_warn_once(adev->dev,
+			      "Power consumption will be higher as BIOS has not been configured for suspend-to-idle.\n"
+			      "To use suspend-to-idle change the sleep mode in BIOS setup.\n");
+#if !IS_ENABLED(CONFIG_AMD_PMC)
+	dev_warn_once(adev->dev,
+		      "Power consumption will be higher as the kernel has not been compiled with CONFIG_AMD_PMC.\n");
 #endif
-	return false;
+	return true;
 }
-- 
2.25.1

