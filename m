Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1A7C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 15:30:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D84C410E62E;
	Thu, 17 Mar 2022 15:30:35 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2066.outbound.protection.outlook.com [40.107.96.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B55110E199
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 15:30:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b++YWdPuWgy2ZEFIbkShQXJb4vSCU8Qo8/4alBf7SsZfHXjhGw+oPufdX77M5RxcnWFGFfBflU9RwPyZqkS9Fa4LvyY259bpcONy/J0X90l2fHJ8aMZ+QSSaXeTGyWBVfV2mtmuIlmCVrXExIK+RAT9CTpyNRtg4qBbbymFxC0eU1syMFFmBnCdHCXBwbXh4KprNrCY1BrXCCnJNYj93JlvWaB7F4Rk/iPz1HuWUEKmPEj50MEMYP8MSc1gQPXWmKAwASV7ml85kAWZYBoKT9xXBkzXTYiWHFsX54y9btQomk+/T6hgsUVY3mJARgYC9oHgJobLnf4Tjr2nLIIR3Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAJEWBYaCKm2Vk+Act2+e7ATHvJfiYnXcI/tUJnp/iU=;
 b=ZC/rv7hJ24TyFB77HQiiynbDwF8l7/x+DqR2OXCMkIX7OWfAy2kS2g9uHQT27XH/sFVuS4le3ade1o4b+U3/U2alxj0EDZMjIybLR0LpkuC6oGOu6g7Po6SO+z0hcdK8vUzS4UG+ufNKn+nj7cj0k+GXrN0zRlQA22rmft6HKMnfyQUu80Y1Gh1UxUryzpR1hTBBL1T/Xi+k919qDSbAX4nrmd07Xi2PFn/fWYz9fh4KnFANA69sMf2DRAlqy6wmF3SH3uBNVhGMIkqL9kNKHYVJ1jf9gl0KRV7gCm0RnkmwrDoy51FjBkAHaacQdyCwSyL6Umj3thNRE/H0vZObjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAJEWBYaCKm2Vk+Act2+e7ATHvJfiYnXcI/tUJnp/iU=;
 b=ERQ59ld4r0T/OQ5sm2MhwBdthi0lCY3LcH04Ey55J431vFDNd3N0nCv/K+vRgnbWJzTg2ddtiYCZVs4Kyq/y9D3tA/VqPAaXphTf0fT2PwaxkbqFV0M5HB3s12MOAivYVgLXgn797pBV1Vty86KuUOq55n4aXVPeHQYSLxr9AIM=
Received: from MWHPR2001CA0007.namprd20.prod.outlook.com
 (2603:10b6:301:15::17) by DM5PR1201MB0107.namprd12.prod.outlook.com
 (2603:10b6:4:55::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 15:30:31 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::40) by MWHPR2001CA0007.outlook.office365.com
 (2603:10b6:301:15::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17 via Frontend
 Transport; Thu, 17 Mar 2022 15:30:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Thu, 17 Mar 2022 15:30:30 +0000
Received: from elenaKubuntuDevTest.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 17 Mar 2022 10:30:29 -0500
From: Elena Sakhnovitch <elena.sakhnovitch@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/pm: Disable fan control if not supported
Date: Thu, 17 Mar 2022 11:30:10 -0400
Message-ID: <20220317153010.1357426-1-elena.sakhnovitch@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a651460-f74e-4055-e115-08da082b121e
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0107:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01076A0ADF566A9D77BE9430E0129@DM5PR1201MB0107.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUTZbcyv7BNqynAUPujB9aowDmmo5UzIiDH64GkOcVRsFatmUEkZydJJ7TgjAtfqqgX/m2sPBJnHkblOWpLo2H66fJj1krRZjgtz2rRE6/va0/gS9TkB8JWvYluPro6AbKAP/V9ut5K9FKXaQ5sy/1lFvSz03tEd08UtU0xMQX6gFWEqfwD2PCdFrKKulyDshQyhGYaibI+4KH47hVVLfvhIZhrr5XxC1L1X20CNma549hEc/udljN98tfx2PX1BlDeR843qF7V04h8NxsIkOy7nIHDgmvWizMnbY9C2cB93BnIb8uNZ8ema8FC2oC2LZp/1Is1X41TF4VUxEI7giCGqNaYz94fDwgnXuUfTN9KO9q8Foga1RAXFm6c0iVIkllXnPBUqc2U0gIwjz6cV+m+3AbnPPaZltSa3RdTJh4R7jOnMEK2QCJOpOcYSGA5OoFau29FRCjh98M6R3fXVqkbedzzzgh/5l9+LrVA+ogR7bd9vkx/Xg+4gyQkQfo+BuJ5RihjgzVfMvrU2jujh9Vm+g1G/8L0o7gAfZiGbUupvMN7Upe3kqpDgSNE/XIz7YioOP6bRF29kNt4gYoCSWwiX6Nz+Ox1ydCwWaoPdOZile24R91itPlf3tMmlCiH2sYiQSGKqEhJBXeAr7afz04SIZcOanElUaxqMygJ0VfRsk4VGLT1dXCJ6I5iDKKfEhIdRYjtHO8+Mndmmiyir/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(82310400004)(40460700003)(5660300002)(336012)(83380400001)(6666004)(1076003)(8676002)(44832011)(70206006)(508600001)(70586007)(426003)(2616005)(4326008)(6916009)(356005)(26005)(81166007)(36860700001)(8936002)(2906002)(7696005)(86362001)(47076005)(316002)(16526019)(36756003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 15:30:30.5101 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a651460-f74e-4055-e115-08da082b121e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0107
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
Cc: elena.sakhnovitch@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sienna Cichild, not all platforms use PMFW based fan control. On such
ASICs fan control by PMFW will be disabled in PPTable. Disable hwmon
knobs for fan control also as it is not possible to report or control
fan speed on such platforms through driver.
v2: FEATURE_FAN_CONTROL_MASK is replaced with FEATURE_FAN_CONTROL_BIT

Signed-off-by: Elena Sakhnovitch  <elena.sakhnovitch@amd.com>
Change-Id: I42f9eb971a61a5ad63327607479fc7e9d9d6914d
---
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 38f04836c82f..23abb1d1f677 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -371,6 +371,18 @@ static void sienna_cichlid_check_bxco_support(struct smu_context *smu)
 	}
 }
 
+static void sienna_cichlid_check_fan_support(struct smu_context *smu)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	PPTable_t *pptable = table_context->driver_pptable;
+	/* No sort of fan control possible if PPTable has it disabled */
+	smu->adev->pm.no_fan =
+		!(pptable->FeaturesToRun[0] & FEATURE_FAN_CONTROL_MASK);
+	if (smu->adev->pm.no_fan)
+		dev_info_once(smu->adev->dev,
+			      "PMFW based fan control disabled");
+}
+
 static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
 {
 	struct smu_table_context *table_context = &smu->smu_table;
@@ -381,6 +393,7 @@ static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
 		smu->dc_controlled_by_gpio = true;
 
 	sienna_cichlid_check_bxco_support(smu);
+	sienna_cichlid_check_fan_support(smu);
 
 	table_context->thermal_controller_type =
 		powerplay_table->thermal_controller_type;
@@ -410,7 +423,7 @@ static int sienna_cichlid_append_powerplay_table(struct smu_context *smu)
 	GET_PPTABLE_MEMBER(I2cControllers, &table_member);
 	memcpy(table_member, smc_dpm_table->I2cControllers,
 			sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->table_header));
-	
+
 	return 0;
 }
 
-- 
2.25.1

