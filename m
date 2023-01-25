Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7912AC54E94
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jan 2023 18:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0353710E0E0;
	Wed, 25 Jan 2023 18:33:41 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2483610E0E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jan 2023 18:33:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRjkOrbTIGu99VKxOzvfqdkCzJ73RMfdW67xsjzV9fftCMKlR7diNBhOOZmMNm7POuRHgbHEtDqW3xU1ZdLW3wABR1BWdwuPHB24LiLpqA2dZwLj/R9AfydCVa2SL5uNL5TcxZJIk/MeE8cTALhK4xNjy8KqZULRsgUG0NlDJoKoLQ7ThqPJEiP4GMHnB/TpbVCItJVxwGc7Rv5EOuT/9WOv38CBHftLSxvMoNSWOWNmrXEbhCQ6Q2te3SaReMz6lZ1Gz3cowToAJ1dYWFO0CvLrO2Utpu8GBn1fjgxST/u+S2Ca93BOzXrxHsBscSEutJhMSkaV0BNFk5ou/h1uDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Xw6puB22y9d2iJu6DB7XLMHlKbx06xbt+n/96rXwjc=;
 b=iF+gqHPspBzLeB7zzcf+iAPiNNF+TBS2E97E4cHJyIZQNDdGVuPjxTh5M9gk2l5NjmDLXrA4qkabmq6CADceZaUeianf7GhKMsuj3rsidrhOKk4VV2/0Qm5iZA5nG5r4CPZofDVUAQBLHHmtJyEoyW+FDJ3eKQDCvRHSy3AWBw2ioHbquOTgKrTaVuK8XNIGN1GLKSX3qkt8jutnijAD2UOWMdDGaaH2peM6ep275H6WHWR3wvCC56mivrVeKgDgfnvT11UPgjilSD07UmHE1I1oN6/xRI36VKQS5OcmIc3/90/DqJUhuy5cIPgFi7DC01cACkBLFg6VzsvoyVhNZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Xw6puB22y9d2iJu6DB7XLMHlKbx06xbt+n/96rXwjc=;
 b=YcRH2/cycwE6a5EnHQsNgRoRnDoii4G+ScTb25G3fMo8hs8+JOwcItSsLmENw/wNUg3cL3TXTi4eVULsNlMMvgCpV5ABsaeVqZcn28gIJ97zL/PmGBfPDnVqHsI+nGqtZ88pj8f0pc3ISYHx/kGm1CU29ObZ3c0MufdmnxCHS98=
Received: from BN8PR04CA0057.namprd04.prod.outlook.com (2603:10b6:408:d4::31)
 by CH2PR12MB4940.namprd12.prod.outlook.com (2603:10b6:610:65::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Wed, 25 Jan
 2023 18:33:37 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::ac) by BN8PR04CA0057.outlook.office365.com
 (2603:10b6:408:d4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Wed, 25 Jan 2023 18:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.17 via Frontend Transport; Wed, 25 Jan 2023 18:33:37 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 25 Jan
 2023 12:33:36 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Allow s0ix without BIOS support
Date: Wed, 25 Jan 2023 12:33:39 -0600
Message-ID: <20230125183339.15664-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT064:EE_|CH2PR12MB4940:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fe0921c-0799-4da6-e859-08daff02ac3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uf9EzOFGATu60XhQt5VYgj2uwJFfIQs0faKJp7sxIlmmAZNexho54Kq4nZLqvDfjX2uVC78JNE1av8koxQ2GlyqZLvcXpizaOJxDAgxO0fv02Q/2fO2sQckwvxSatWnwcJ/9k1oQhjR/zUK0RScuayfJoWqMQd5et20pIlpQpuFFZ4stoY3e3bJgjPu+FijpkteKD7WdlAYZgjLCv4rAon4RrC8+XCUhgESmsSGiYqOJCtqqNxVnMdxfnHSHbA/p7QTYEZFofC78RuACTAel06xdIUtDdnZStDdL8w7uhVc2TvikXRC5T8wn3j1Gi9HzWL03YXO4SE7SOG2EsVkq3H8C6okAmmqR/1PPKPKMFjFd4ZyuaL3mhRGMIhbNVa6K2uALVyxEqcIT+J/Gdfg1rvxbewYKyik6vcBRUg3u7gqEqYOkN9pSpIzghmKtw6Oa/rLXB1FzCyKS6RYTzTFOpJ2sww7rSiGL8McpZBQy3aXaJdwTOvbP5Z1NntE7tiL2/Pv9m3X75wAnIFvn/WU8EUHEyNipyDBWuckblkjMxF1xXcCV7IJv1SuPqBteWgy2BKl6li19SSzGCQB0qKiq6MJUHiMAbna6l/rYMG/dnthfH2RPc4cD3loMWpU6Ha00+1rQYd4Av2+uMUZRzO4FHObOMGfcntBCWhssWqa1SjX4uwxC4tM+cVbjp94Wo1yStqoLGXM1UmjmEdHwtERPKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199018)(40470700004)(36840700001)(46966006)(47076005)(66574015)(82310400005)(86362001)(40460700003)(40480700001)(36756003)(81166007)(356005)(36860700001)(54906003)(82740400003)(44832011)(2906002)(66899018)(41300700001)(4326008)(8936002)(70586007)(70206006)(6916009)(8676002)(5660300002)(16526019)(186003)(26005)(1076003)(2616005)(316002)(7696005)(426003)(83380400001)(478600001)(966005)(336012)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 18:33:37.0764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe0921c-0799-4da6-e859-08daff02ac3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4940
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

We guard the suspend entry code from running unless we have proper
BIOS support for either S3 mode or s0ix mode.

If a user's system doesn't support either of these modes the kernel
still does offer s2idle in `/sys/power/mem_sleep` so there is an
expectation from users that it works even if the power consumption
remains very high.

Rafael Ávila de Espíndola reports that a system of his has a
non-functional graphics stack after resuming.  That system doesn't
support S3 and the FADT doesn't indicate support for low power idle.

Through some experimentation it was concluded that even without the
hardware s0i3 support provided by the amd_pmc driver the power
consumption over suspend is decreased by running amdgpu's s0ix
suspend routine.

The numbers over suspend showed:
* No patch: 9.2W
* Skip amdgpu suspend entirely: 10.5W
* Run amdgpu s0ix routine: 7.7W

As this does improve the power, remove some of the guard rails in
`amdgpu_acpi.c` for only running s0ix suspend routines in the right
circumstances.

However if this turns out to cause regressions for anyone, we should
revert this change and instead opt for skipping suspend/resume routines
entirely or try to fix the underlying behavior that makes graphics fail
after resume without underlying platform support.

Reported-by: Rafael Ávila de Espíndola <rafael@espindo.la>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2364
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 57b5e11446c65..fa7375b97fd47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1079,20 +1079,16 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
 	 * S0ix even though the system is suspending to idle, so return false
 	 * in that case.
 	 */
-	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
+	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
 		dev_warn_once(adev->dev,
 			      "Power consumption will be higher as BIOS has not been configured for suspend-to-idle.\n"
 			      "To use suspend-to-idle change the sleep mode in BIOS setup.\n");
-		return false;
-	}
 
 #if !IS_ENABLED(CONFIG_AMD_PMC)
 	dev_warn_once(adev->dev,
 		      "Power consumption will be higher as the kernel has not been compiled with CONFIG_AMD_PMC.\n");
-	return false;
-#else
-	return true;
 #endif /* CONFIG_AMD_PMC */
+	return true;
 }
 
 #endif /* CONFIG_SUSPEND */
-- 
2.25.1

