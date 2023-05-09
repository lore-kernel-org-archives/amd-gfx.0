Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5002FC7EE23
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:07:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25DB610E3F8;
	Tue,  9 May 2023 22:07:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78EAC10E3F9
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:07:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OathvXsyO6syi828UkFZMJc2tc+FDwIxTYf2UyIdGndmQHdDEYfnBkTLLzdgA6PV0QoXq9+IUKInnVRkHHuhPMO7GhKxhyrfLEjJtF5b3w831ERC3v3bQ0V34NS3vufuIwVp+I/RCujil/m3fWEXvJkk5HrieM5lIgoty7OMw2anuNauK2mQj5GHe8DapswtFbVCnsS8QsL0mGVoXrSxkssr1p/jgqEURShiLIaRNTDoK/VSd8bNiXdjr0jzxeLR24bZnIM+0S+Qg2L6EVus/dQA491J+qdXC2ufYzirfU1JjwTG+CZDekFX7zGMdQIXHUp9PXjsBL/UkCs+UWAbBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfsAknS5AZeF1iEQOj7Db2z4XvGOaXtBMwB8bX+p55A=;
 b=R1jEJXSoltmYMOg+l67qH0fYzK8DFKS2wGRC0NEdicf0iV8zOyIRGIS1gPI6bet1tC5YjWhEXmoukvTufx2eX8BrZtqgfn0vM9twKwk46oWwfsSLRCS8iG8QI1KOpcFyUjMV1gA0JDtFX4n6NyCV9iydDNqVPV2aHsYenW5ue5A72hpX2dZvdh0eU11xUYjBKo1wJqQmysWyko1r/TfesuvVl8vY6Du7ys5pww8pPxx6GrDT0WxEJCqg12ZVAwuHxGWiORJ8fYXb6Dk+0AbkdtN4HritRznZzXV6Skwo4JY0incidKbfBv9x77RPlIINz1iOChexuTIz+sxgjZXaDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfsAknS5AZeF1iEQOj7Db2z4XvGOaXtBMwB8bX+p55A=;
 b=N98a3bq7/yqKYApUT2/S5e2uDe1zb8iPZHytZDu92ZZVfeA/8/7U0eN/IBMB6ps47Yj18VCD2wC4nQZY1H7uU9lb8te9M8I+HwPiDJ9FOX1YxDOT8ORm8yUrRZKg2GIrHOtFKhmXlvSoR/tesBE9rXeAJWQzatlBptjQblmQ0Ig=
Received: from BN9PR03CA0429.namprd03.prod.outlook.com (2603:10b6:408:113::14)
 by MN0PR12MB6104.namprd12.prod.outlook.com (2603:10b6:208:3c8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:07:30 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::7c) by BN9PR03CA0429.outlook.office365.com
 (2603:10b6:408:113::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:07:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:07:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:07:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/12] drm/amd/pm: Initialize power limit for SMU v13.0.6
Date: Tue, 9 May 2023 18:07:08 -0400
Message-ID: <20230509220714.475369-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509220714.475369-1-alexander.deucher@amd.com>
References: <20230509220714.475369-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|MN0PR12MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: aa381fac-4820-4dd9-5a8c-08db50d9c863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wzg1acF2ZDYqD5k9+800OlwwvPLFPkeVACR3aU4FHVroGvpABo9H5WwAgPgdxf1mXSPO4oOqvsZF5TZc73E8wFjEccA3gecd391TauKuOhwXNtRwp/aGctVzT8eaOgdy71DsZ0B531uygYiCuF+KGapxnQciZB977IbkxY9OJ/8oP+VdHI55iVMs0nPXvG2mvTS6dfe1A1oJ0fc86AjUxHIN2io/b+rIBkyjYPldNP6bJgoXFsA/UccjMJUvPxAhTR2Jie9JAi9SjNrXbdrJVpuXmEyRMzgr8mb7lMPJeX8aNSpCW/V2nO0DU5E5mW3g4Zi7Sx1hjomShpYb8w7C6x6eG326k6jO5nZgxn6rVKfskv8zcJ1L/RVnQYiAZA2Z2WkCVGzpTYxLriqReCQ4YjZYNmR0QPMHdD1bzpniF8PLxJOfmHaFqw2+QT5GLejltyhpa2cmIucq9Qfvj3r/mRaUr4xONQjGGBRgqsZDTl9AsutbbQ0b4KIj49FDTU1zdu3oS9bYbtDEzJV0aZ3JyWNdagBjTXGk1eo8G/AaTkv01TQETYfrcAMGGu0T+X2/EN9Goyyw4xb5AnjXyH5/CJdzPXsdZXderPMsYqngn2CJdpW/WrU1+73DCxp8YmTCFPrugpiREp5k2EVUn6tB/YToKTFTCMQ70nq7e3XbomcXI+KBi3KJZyvbR724lqq1FrPSRN8d60P+yo4W7xrUexP2V+ozRiU5c20xJCkh1Ek=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(4326008)(2906002)(8936002)(478600001)(316002)(5660300002)(8676002)(6916009)(54906003)(41300700001)(16526019)(6666004)(70586007)(70206006)(7696005)(1076003)(26005)(186003)(40460700003)(83380400001)(82740400003)(47076005)(36756003)(2616005)(336012)(426003)(40480700001)(36860700001)(82310400005)(86362001)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:07:30.2668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa381fac-4820-4dd9-5a8c-08db50d9c863
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6104
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Asad Kamal <asad.kamal@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

PMFW will initialize the power limit values even if PPT throttler
feature is disabled. Fetch the limit value from FW.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index b46e0414be60..7474d3ffab93 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1256,21 +1256,6 @@ static int smu_v13_0_6_get_power_limit(struct smu_context *smu,
 	uint32_t power_limit = 0;
 	int ret;
 
-	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) {
-		if (current_power_limit)
-			*current_power_limit = 0;
-		if (default_power_limit)
-			*default_power_limit = 0;
-		if (max_power_limit)
-			*max_power_limit = 0;
-
-		dev_warn(
-			smu->adev->dev,
-			"PPT feature is not enabled, power values can't be fetched.");
-
-		return 0;
-	}
-
 	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetPptLimit, &power_limit);
 
 	if (ret) {
-- 
2.40.1

