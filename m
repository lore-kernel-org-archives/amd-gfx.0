Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CE0C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 03:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0362860C3F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 03:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0362860C3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38AA06E233;
	Thu, 12 Aug 2021 03:36:22 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2089.outbound.protection.outlook.com [40.107.101.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FA56895C8
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 03:36:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfy3jdyolg/4VK52/8gpeSPtVehIULRuC9MGr0RXkfgbGlT9OkPIxjSTVQCuN1vnvhW8b8XWgNaTriLtyEeCWTSNnNm80UQpKpHMnD3QKrTlXqQ+ymNmyr2zjnClDP8lCx29SdytaEZyG/gVJ/L5p53A0fhEgYrV+flWAKkPVBM3tgprDKwDy6hBdr2DEsmXXJES2aV30scJnK0dZ61V2hKs/MUJI2C8VY/Nc7ICuxGXX52zdfrfUxg0UErjPjXUm3ytJqzkR5dTrwbzptrCqr1vNmaQZk4Q9T3B7ex4x+yQgKIwmzKJnCnaYgD/qpquySEVcqGv7HakiZEHvDIWdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwBv8FMciVJolwdIVp8dGCa04aOVBF+llVB4NZA/Uz4=;
 b=kJ6Tk3a2mBz52V6eTazsC0X/t29ufkXSRv1wPykioVztcOc53vfFl9u+Et2DendVwNacTwD6pWp29ExxvZCBPPBgSGjfg7U0hsdncIs29Umk5WynUB1kdMuC/7HXsUZF+Hsf+exPmzTGMJDxH+JZ08hH7PEOSWQ6yM1tZACRM2CCKYg0/DeE4oLdN0wcoMyR8A6cqa0fLuUweMWh65V4iBDflfcdgXT0CUyFgYSfRqFBO0EKlwZDu1HD/ncEXEXWYIqfyetAKVgkC/V2xKmTWNlawtZlOwXaDE7nLTJn4I0Qb7DPwNw9k6Ms2oJFQUUgKKkiu26+jcm1rfL0qN2ZEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwBv8FMciVJolwdIVp8dGCa04aOVBF+llVB4NZA/Uz4=;
 b=Ymi1M++pCBL/4m67NH89+WlUBV74YNt2gdgsTXgBOsqzwmN2N68kt86SsRv3lMN63w4wgyggonfy12oKJrk2Foq2SuThhPACLL/O+LJ+xTmR0Sqmufo+z0wLiZrnaMciNQ8lL2uisdChld1LTToAjACJWzdHPQxcTCiV6pWQ7fE=
Received: from BN9PR03CA0205.namprd03.prod.outlook.com (2603:10b6:408:f9::30)
 by CY4PR12MB1799.namprd12.prod.outlook.com (2603:10b6:903:11c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Thu, 12 Aug
 2021 03:36:15 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::8) by BN9PR03CA0205.outlook.office365.com
 (2603:10b6:408:f9::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend
 Transport; Thu, 12 Aug 2021 03:36:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Thu, 12 Aug 2021 03:36:15 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 22:36:13 -0500
From: Kevin Wang <kevin1.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <kenneth.feng@amd.com>, <frank.min@amd.com>,
 <hawking.zhang@amd.com>, Kevin Wang <kevin1.wang@amd.com>
Subject: [PATCH v2 2/2] drm/amd/pm: change return value in
 aldebaran_get_power_limit()
Date: Thu, 12 Aug 2021 11:36:27 +0800
Message-ID: <20210812033627.1241847-2-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210812033627.1241847-1-kevin1.wang@amd.com>
References: <20210812033627.1241847-1-kevin1.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27632006-2ec8-4441-100c-08d95d4256c4
X-MS-TrafficTypeDiagnostic: CY4PR12MB1799:
X-Microsoft-Antispam-PRVS: <CY4PR12MB179968FD10817DD370CAE325A2F99@CY4PR12MB1799.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WWJMJ/PZtBrR5okBa5pu+Dqct6Cfk293ybBWrtV0MNxNRMxsc84Pwtg3arxO4eXiOAscs6/ryUz2DdpFuqXjNG784Aik1+8xvs56TXl1Bg1GQ2n2O8x8nYfe6zwzTIbri/xmLN7BmhP7/68os3d/4OB/ZutqPYQHzh7C5QLL8i0C97RoDrp34A9tOW/b1j27Be5uvwcXA1NLqw5KcS2Ictmid8cUnH/sJp/JHB1nmQj9cVs1GjtJAu3T5ueKNftV+8iVN60MQxAZiZ1DQ87m+y16/aTyZRQYKDAaqyGiklQZMpe20dLvI/+bC/0FdDW7PRPndkuSDPTKmvc/xSu4ZwtUBD2PQpVZLa4CTeATshW4PBl1D48kimkZhf3vGeItdFrBg4EcTbJcrLeTRdHPLrvHOphdB+mL4x2122rLAXWKdJxhTPQixvndIiVPcKwPxKDSTI4N/kWmVeKoSbFW7zMbkm/s+qV+zISp1NMepGBmYygg83DuRpzNEAGrhGVvKfuPdNC8tix8R9m2Tk5YOT80Dwjek8lfq6d56/Tndil4/r3RRemNburRynGz9alhdjiXCWePdFDr0/abaDwasIIgwdJMzO0IrgEkM1CLzLgaxcEUjd8hRX/Tnhx2hVFDkup0grOLebMVCHTrHQAAVgpQVyCwI1tPGHOD20xzknGrkhVQ2826mDODTykL0TmjeZf4xZ4X6GjU9RAIyX5wAxPN9dhwffxwoqs7OItef+aBB5m+qbW4S76oDNLhBhy5DQYoP4Ye4xTmJgV1JgGk8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(46966006)(36840700001)(26005)(2616005)(70586007)(70206006)(478600001)(82310400003)(34020700004)(186003)(336012)(426003)(36756003)(6666004)(8936002)(16526019)(54906003)(1076003)(8676002)(5660300002)(316002)(4326008)(81166007)(86362001)(47076005)(82740400003)(6916009)(2906002)(7696005)(83380400001)(356005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 03:36:15.4120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27632006-2ec8-4441-100c-08d95d4256c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1799
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

v1:
1. change return value to avoid smu driver probe fails when FEATURE_PPT is
not enabled.
2. if FEATURE_PPT is not enabled, set power limit value to 0.

v2:
instead dev_err with dev_warn

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 97cc6fb9b22b..a9f1a2dfbb51 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1194,8 +1194,19 @@ static int aldebaran_get_power_limit(struct smu_context *smu,
 	uint32_t power_limit = 0;
 	int ret;
 
-	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT))
-		return -EINVAL;
+	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) {
+		if (current_power_limit)
+			*current_power_limit = 0;
+		if (default_power_limit)
+			*default_power_limit = 0;
+		if (max_power_limit)
+			*max_power_limit = 0;
+
+		dev_warn(smu->adev->dev,
+			"the PPT feature is not enabled, set power limit to 0");
+
+		return 0;
+	}
 
 	/* Valid power data is available only from primary die.
 	 * For secondary die show the value as 0.
-- 
2.25.1

