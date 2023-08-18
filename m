Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D64C05052
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Aug 2023 10:30:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 141B610E4BB;
	Fri, 18 Aug 2023 10:30:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E7310E4B4
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Aug 2023 10:30:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwSJGspuZOf3Jv2uBAJ/VRP6ftghaDk6XKKWn/fbvkn929mvNA7fLcmJez6fFaZ9d7+rNr4ZgQQtcw+W7qu0ios9LjLx4ifj/bSTyjXfttQ1Untgpkzz7qME94PUSLJpgoFX6y/yTmImJjgLri07dCn9FGPX4uBdapNvRlWSO6wYDrE+kO6B6J2yaiLqv4VXPa2NAQTkbAps8gSichFxf9oOlMlf+EWO3vkFWx9PcpuiBAdDuEI404RT7A7PnSvpWgwdqo6WqN9H6AyDHg1YGhbvBr7/BBREwmTkLUTZA+V45owtz2K8pAHqC7ttEC/mDY7AZNTZgdoqoRhSi6wPTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cnz5u4KqiYzKJ59J8zsl3r/WL2YOagGLBeNNBwpIQY=;
 b=fDxt04pEGxYqhMEW2mpL5gdOlFzApN0JlaAqo1WcFT/PoB2MUFVNEDz6+eLm2jRhcnWUCcnn/5U5n+7ZTMR9U+O8lgC+Vt5TfamVJuENkMbnNnmb34R+fUncyRfnmLaWFuWFE7pigJokhjabun+923k24cLlbfRZXJkwIfUQEXP95GKel4mvvB/CfrMALKbdNJaeEdeg1dViuL91vhxHBdED0CySnOTVNfaVRKvYKhJJ38RROBGrjpCqJg/3tnhBld6y6YVJyIwaqWUc/Xx2wh/dEwbKbBk1mLZ4R/QM8Tum8k85eV2CiFQ8CqBLIGc+TxWAWBg0CnfwQzzzgi93mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cnz5u4KqiYzKJ59J8zsl3r/WL2YOagGLBeNNBwpIQY=;
 b=rvKQiTsLHFS8qcNT4vxjZN8xKtnmVOLoksv88DIOIIMT5B6NuLiI9slvjWlQBu8Af4e6KJw4luyI0ISDtz+FWhtW2y2JWiyuTQg4SF0eZyG5an0sgBicz7H7jC1ODRZqqiVStH58Qpqp43RpPAiCw7z46rz4DA4NZNb8Id12Fow=
Received: from MW2PR16CA0023.namprd16.prod.outlook.com (2603:10b6:907::36) by
 LV8PR12MB9419.namprd12.prod.outlook.com (2603:10b6:408:206::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.31; Fri, 18 Aug 2023 10:30:00 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:907:0:cafe::4a) by MW2PR16CA0023.outlook.office365.com
 (2603:10b6:907::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 10:30:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 10:29:59 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 05:29:57 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Fix critical temp unit of SMU v13.0.6
Date: Fri, 18 Aug 2023 18:29:43 +0800
Message-ID: <20230818102943.1229872-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|LV8PR12MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: 31846556-4afb-43d9-9a5c-08db9fd6137a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WC1cLhX3nHIjXGCxrdNaAI62OZVMKZOuPEIzwiB1FY3NzXcLyEc+0TJketOSkc9/ChGrktaWVMoX5R5WFA2kIq0zPjhi4eIcY34Y6ZDEsSciD5ScE11yiJf8izw2Byp5YuWK+inXwma5jA/6KFZ0jD9wkXRQJy1JaCeVzrMXtuqN28Ya8ny36Ywy30Bn8W7e/l48quSQjU4ptsx2XZBOpfImR5TRb0iXk2EAjR6RL6paMKd28Sg1V8ZTqjmM7qyjj7g04qLQFynPUbAZgUaVRUcWpx6q+HGSgujLvjddUDJgv0DYhidzmaAq/mqO2/VpTPo/YRL2sg++XFefINnnHrfOEdeFVdxNZ9lswe7yqiYmFuW1FLUGlDXBMizKhcmNU1HCf/T9b3Elqyssx40Q03Cu/H7LUbYuwPouI65bW3vrjkDzb5NyuzctlEP60pgi0Gg917RXJB+QeFacndlxQlFulsMGf8l0l658bdUjmeB3msSKwjT0o0Om2pFgEVdb1SpJjX0yn5JuUFw43Bj/u2840I9ylhI28kWufWD+jAwdqzPVjnEckIrIQrPROp5voyB5wHmXryqHDUqPz9DxvRNLJgXNGJvY4mnyr4Eby2d6eqTVb8tQPsKpuWKWk58yNKclUG6AVWp66DBPV3P/59b4eapyePutUnUQR3jxOVFcyIaU8BGd/faC34vmeR3gLbZt+Kz4iDlmozQB5WKGeXrkJWE1+e86rjta9aofPZS5afP1DCvl5OFwNLb4h2AqXlcdXVQvvpTXTAjAPw4hoQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199024)(186009)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(86362001)(36756003)(40460700003)(40480700001)(83380400001)(8936002)(8676002)(4326008)(5660300002)(2906002)(41300700001)(26005)(336012)(16526019)(1076003)(6666004)(7696005)(44832011)(47076005)(36860700001)(426003)(2616005)(478600001)(81166007)(82740400003)(356005)(316002)(6916009)(70206006)(70586007)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 10:29:59.9958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31846556-4afb-43d9-9a5c-08db9fd6137a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9419
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
Cc: Lijo.Lazar@amd.com, asad.kamal@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 maisam.arif@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Critical Temperature needs to be reported in
millidegree Celsius.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 7d8af9b309b7..32da779dbd27 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2086,7 +2086,7 @@ static int smu_v13_0_6_get_thermal_temperature_range(struct smu_context *smu,
 						     struct smu_temperature_range *range)
 {
 	struct amdgpu_device *adev = smu->adev;
-	u32 aid_temp, xcd_temp;
+	u32 aid_temp, xcd_temp, mem_temp;
 	uint32_t smu_version;
 	u32 ccd_temp = 0;
 	int ret;
@@ -2119,9 +2119,11 @@ static int smu_v13_0_6_get_thermal_temperature_range(struct smu_context *smu,
 	if (ret)
 		goto failed;
 
-	range->hotspot_crit_max = max3(aid_temp, xcd_temp, ccd_temp);
+	range->hotspot_crit_max = max3(aid_temp, xcd_temp, ccd_temp) *
+				       SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetCTFLimit,
-					      PPSMC_HBM_THM_TYPE, &range->mem_crit_max);
+					      PPSMC_HBM_THM_TYPE, &mem_temp);
+	range->mem_crit_max = mem_temp * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	if (ret)
 		goto failed;
 
-- 
2.34.1

