Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7097C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 07:40:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69D4910E486;
	Wed,  8 Nov 2023 07:40:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A8D710E486
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 07:40:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrfI7CAsj20AZ7brX3fJ09CL88AKlbeVnsxlxKZITVs8lFZib0VTV2i+3Um9iIY8kkEQ6IUMmJ1d6xl2hMamJDOndJfuxuBLGmRtAibcMvHC3B9W5GnpQu5nNml91Z88I7h1H65RUAg2TtrUOBQp9DLTrbAQxUU8vfOBfpXCNMt+5xs3aa5XghKa5e3MHqUPCColxXFQdORZlrzczqukR9AA6/oH4w3tnmF9szG+EHochyf902+l4YJ6Wbdm9hpUEVKAnhl+YRAieBDqDjU5rEoeaI4tQL5wKMVYTws/p0F+9n556Pz2mAa3dqi4eA/GSF40+wEj7QTFlCDDERB+zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcBYaUhuExk3+nnjZe6Q1nzSenNhMgwyy7oP1lCja9I=;
 b=nGcFLsnpLR3EraqLqvP5Kg4/QbfqcsieDdkRYChLe1/1A7pKtLHTd+NH0oKKdGWs0fyEobPOMP+M/hIQ9uSwfowotYvdJTA4wmAsZDvMRYpcrbMOU5mSlp/30/jMI/F3Z1AztIc/2fbqg3CfyMFBA5pK3v6LE0ZNdHhXS99bl2jW4Tw/egdasCHP3ZdR+5USa0390GlUH0xjJ87RpvfDRifXxpgxvrPLFNTdrFYmSiNwHvJtOZKMoX/EAxrI8c9MwEd3l01zBrMHURCVDSb1HKhN3wVtv6TqBYhHJnD0UIGbfY/Jdcddv9KZdytR2y6Kwmi+nO+4nFWHyAiHRv+0hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcBYaUhuExk3+nnjZe6Q1nzSenNhMgwyy7oP1lCja9I=;
 b=EeDH8p28aTSJ0svehWiyjguqTduLq1x4eVDr1XzGd6OVJ6SOXSs7seQP0vXsXpBYO4/sT6gTKCGaGoeqOyXxYOQbCEjPiHbvs/1ZfLlDeXnaR5h88wolJGNzLQiuxk6Vpet11C0kSXm8Lg/TaCkmE31Erh4IQef+N+y8s0c6xcM=
Received: from BL1P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::16)
 by DS0PR12MB7850.namprd12.prod.outlook.com (2603:10b6:8:146::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 07:39:57 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::d5) by BL1P222CA0011.outlook.office365.com
 (2603:10b6:208:2c7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.30 via Frontend
 Transport; Wed, 8 Nov 2023 07:39:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 07:39:57 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 01:39:55 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Kenneth.Feng@amd.com>,
 <Alexander.Deucher@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amd/pm: Check amdgpu_runtime_pm when setting maco_support
 flag
Date: Wed, 8 Nov 2023 15:39:32 +0800
Message-ID: <20231108073932.4034692-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|DS0PR12MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a241ec-4cfc-4298-3154-08dbe02de7fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nRohGmY3rf6wi2ki/cgoj35lxRy58qK/KBlVELYD6GdONZ+LwvEDiUn8ZcHnE60djAF/eTw0jPbV+GmnXJMJUOuJw5VuooP/hotjlbPNVeVL+NhxhHXA9ChQNGqArJ/7aPvXKwxJxMvUJ6o6mIFjD5WMgJt0/cHnkmpEObqJa5jbyEvzPr/DO2Zi3Og/jhoxr3OjdZSeVktG39pjWxN4DhW9ixCOqzjb1bxy9WgoT4gAgF/wzfkpAr1M1Q916737QP++kU6TJILfn/+M15c1RbffmCi3xWc3ids8C9mT8kDJF1dkUUkqdrwEfEOCxEkiDW58s3WId43rf4jzFQuUDDFxPb1Ejqw5gr/rftWFZ9Ol8jQ60ejhT9OaGbdhA98hHulWkydwWAicIsY6/O8lRB6Kn8Tj5kDdi6/SXIaDyjApIopm0YcKpsbppCsTkJkYZN7mZkN4JfKVGsR8bXSmRZWrU1/8qUtt0/FWDTRPnTJTQU35sAZXxxxGEY8JUMqlGJnV7dwL7SYt/dugQP9T6BNM7x5RsKRY6USxiyf4/6T3kw7E3hLFdyfda9N/EURTKFkeit1/EhgT3huYlS99shkrtECGgDhzp5OT0B3nCNw2+6b2cXKC3XDUXz0j/zsff6oN5o4IYy0MhlcUj3kB+q96PWGkaTcb5306/dO2BUK5FnvrY+h7Rpy555z3sVyhzg1g/iXt6ubJ5Krujx55cWFskJ7AHA6l4cINMQfIVeT5cT3zuhYaQWdVVpQjGTOKbWSgQ6BbOn9zRie0KFN2VQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(2616005)(2906002)(426003)(41300700001)(36860700001)(5660300002)(4326008)(8936002)(8676002)(47076005)(86362001)(82740400003)(81166007)(356005)(336012)(1076003)(16526019)(70206006)(26005)(110136005)(70586007)(6636002)(316002)(83380400001)(478600001)(40480700001)(36756003)(40460700003)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 07:39:57.2868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a241ec-4cfc-4298-3154-08dbe02de7fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7850
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
Cc: Ma Jun <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check amdgpu_runtime_pm when setting maco_support flag so that we
only check maco_support flag when use it later instead of checking
amdgpu_runtime_pm every time.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 15 +++++----------
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  7 +++++--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  7 +++++--
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index fdcfbe5a0789..891c3fddd7b9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2238,15 +2238,11 @@ static int smu_v13_0_baco_set_state(struct smu_context *smu,
 		return 0;
 
 	if (state == SMU_BACO_STATE_ENTER) {
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_EnterBaco,
-						      (smu_baco->maco_support && amdgpu_runtime_pm != 1) ?
-						      BACO_SEQ_BAMACO : BACO_SEQ_BACO,
-						      NULL);
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco,
+					smu_baco->maco_support ? BACO_SEQ_BAMACO : BACO_SEQ_BACO,
+					NULL);
 	} else {
-		ret = smu_cmn_send_smc_msg(smu,
-					   SMU_MSG_ExitBaco,
-					   NULL);
+		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_ExitBaco, NULL);
 		if (ret)
 			return ret;
 
@@ -2287,8 +2283,7 @@ int smu_v13_0_baco_enter(struct smu_context *smu)
 
 	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
 		return smu_v13_0_baco_set_armd3_sequence(smu,
-				(smu_baco->maco_support && amdgpu_runtime_pm != 1) ?
-					BACO_SEQ_BAMACO : BACO_SEQ_BACO);
+				smu_baco->maco_support ? BACO_SEQ_BAMACO : BACO_SEQ_BACO);
 	} else {
 		ret = smu_v13_0_baco_set_state(smu, SMU_BACO_STATE_ENTER);
 		if (!ret)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index cd7dc18bc71c..dff69713cb5f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -357,8 +357,11 @@ static int smu_v13_0_0_check_powerplay_table(struct smu_context *smu)
 	if (powerplay_table->platform_caps & SMU_13_0_0_PP_PLATFORM_CAP_BACO) {
 		smu_baco->platform_support = true;
 
-		if (powerplay_table->platform_caps & SMU_13_0_0_PP_PLATFORM_CAP_MACO)
-			smu_baco->maco_support = true;
+		/* allow user to force baco */
+		if (amdgpu_runtime_pm != 1) {
+			if (powerplay_table->platform_caps & SMU_13_0_0_PP_PLATFORM_CAP_MACO)
+				smu_baco->maco_support = true;
+		}
 	}
 
 	if (!overdrive_lowerlimits->FeatureCtrlMask ||
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 2909ec06b1cb..0a403091b5f4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -349,9 +349,12 @@ static int smu_v13_0_7_check_powerplay_table(struct smu_context *smu)
 	if (powerplay_table->platform_caps & SMU_13_0_7_PP_PLATFORM_CAP_BACO) {
 		smu_baco->platform_support = true;
 
-		if ((powerplay_table->platform_caps & SMU_13_0_7_PP_PLATFORM_CAP_MACO)
+		/* allow user to force baco */
+		if (amdgpu_runtime_pm != 1) {
+			if ((powerplay_table->platform_caps & SMU_13_0_7_PP_PLATFORM_CAP_MACO)
 					&& (BoardTable->HsrEnabled || BoardTable->VddqOffEnabled))
-			smu_baco->maco_support = true;
+				smu_baco->maco_support = true;
+		}
 	}
 
 	if (!overdrive_lowerlimits->FeatureCtrlMask ||
-- 
2.34.1

