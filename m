Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E52AC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 26 May 2022 18:01:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C6AD10E3E0;
	Thu, 26 May 2022 18:01:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A89D10E3E0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 May 2022 18:01:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrH/Ra4HIJA7AH4kEV0ftGBOjpWx7zmX6e9kZ7glMPOZB9VR0pM9K4zh31rCAgOydHYuls/YIipLomRq24IY/zlHjVmv7FUDYkKHsOfEzsmyRmtn3P45i/MLfNyUzuOT28BTvpF1WT7V5faKWft65KTMaN55BZrQ0XQcxnK8LADS5ddE61/CkDdsLoF5qwjhCcsHePrDksUvW+cO5+O/8SLr1WXa/78y23JKK9i7Y7RZg+YbdEnGKo8m5CbjsaifFeWd+WWSrGJrwDKww/egCdcb57IZvIKFwWkgD+FYPj+zIZWPIcPLapgs6Pv4gdx7sJ7JAoS6tkH2/rMTcCxoNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qf43AAps0OpfVkDLk1UccH0GEU/2uM10il5DFS+s93o=;
 b=jfDLHTt0x/zHXEBVPRK/F7MW8jqksmrT/qaYPs2l5GNxGXSrw5g6CFaNreE1EqDFHD4I/x1c7n5VcZB7gkU7+7umxP7x0OsMVRa2zuEr4lzB5ja4UNJKZfk3o8L+W0CM8EAwEte1GpNFaa8d8fK+8PbYM67HIbKq1e0VIAk1gD5l/d5R3FU8KtI/eILrFH+AhJfQ+iJEMjj/nWsE8+gFM4Vr3RmLMK/edky5Vb32fF1sOdrEbnqNpci7DuLoqZu/+Dr72oYJdnf+unEu94J8DaIYSsZId17IHcveM+w1h6eAwJzXTMvCsCbVv0D9QQstI9T3DdKUrfrxHJpjCFq0XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qf43AAps0OpfVkDLk1UccH0GEU/2uM10il5DFS+s93o=;
 b=oGoYkApTBeTwTcBlTjCmqpqQENOOkVLPdXi2NOOIMdGmY9NQkLUBQRDoBAO1wDeIsK4AgNqZ9GyBv7iZ5WJFdLH72yLSl4jhc8jwFCPS0WXvHVc9JYHYm2dpB/CnIM51bC+k4jL02FUgBYek956DDrT9K1UraIUchLJp3IJeUr0=
Received: from BN9PR03CA0367.namprd03.prod.outlook.com (2603:10b6:408:f7::12)
 by BN7PR12MB2644.namprd12.prod.outlook.com (2603:10b6:408:2d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Thu, 26 May
 2022 18:00:43 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::7) by BN9PR03CA0367.outlook.office365.com
 (2603:10b6:408:f7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 26 May 2022 18:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Thu, 26 May 2022 18:00:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 26 May
 2022 13:00:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu/swsmu: use new register offsets for smu_cmn.c
Date: Thu, 26 May 2022 14:00:27 -0400
Message-ID: <20220526180027.3044740-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220526180027.3044740-1-alexander.deucher@amd.com>
References: <20220526180027.3044740-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bbd9516-51a8-4a1f-3785-08da3f41a6cf
X-MS-TrafficTypeDiagnostic: BN7PR12MB2644:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB2644818CF7B3346DCEF261ACF7D99@BN7PR12MB2644.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5IcIYAn9i5DLEQFjQFj4whdNHPXnMg7d73BrD6sQ9wClwmrrK42yk497QeGCDwgOtDvQRB7n4y0AuOxG5ifKGRbIlzDtJ/eLdAjF5yuMWZ8GgVPeScV2cNTbQubbPowH1PB1raQ/hvp0+54t5/gwYPbVoL/PIuzkeuhy91bcFR/x0IOClxZ37+3WIVe2NmQeiiBZpTqs3U/xreLfVxRnoi/YyycoCrVJfdMFP1IP6q1rHVXbwKrOCReuxCYo36glDnRWnRVyYV9moV7POlGTBggORAhK1xcPZNAkOy96vm5amMU9gATu0WgmsBZO8HFTeFReDAAep7MVfCJ83yrho20Rx1v5xijP/Vd5cqLYE5/oOwVj3nA7IINKLzG9kImSWZmDfSjhrIqtjNgrPNqk2XPOBxjlZe4ayZhk0pArf8QKrL1UfwkwxF3XKRXodEI6rsHXaj07ZhbJICBIvo62xerz4HBMYPTx6ozN5wNdlyudb4nSc01He/bMeV3qamFnHD/ZyIcKTg7iqaRrKwSRtEP8/8WKsvTUsRQQdQtJC1gejpN4xQ1laVVaaQo3LC+XZZd+dWx0E0I6SPqm9huWRvkWjazuZFFH9GGhXRkjOl+e+T2DgGsEVTtinQhBEfOaf0+Vswut5HFl3jWlIgJ+L5RK/HyXt/O4p2AgVcIrUgNQpxSSkG9qTch+V/aj6wBVjYjmVkjiqG4MH/RmuB3m7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(83380400001)(1076003)(2616005)(16526019)(36860700001)(426003)(336012)(47076005)(186003)(26005)(8676002)(4326008)(70586007)(8936002)(6916009)(86362001)(6666004)(70206006)(2906002)(5660300002)(82310400005)(81166007)(40460700003)(7696005)(356005)(36756003)(508600001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 18:00:42.9587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbd9516-51a8-4a1f-3785-08da3f41a6cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2644
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use the per asic offsets so the we don't have to have
asic specific logic in the common code.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 77 +++-----------------------
 1 file changed, 7 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 5215ead4978f..53cd62ccab5d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -37,40 +37,6 @@
 #undef pr_info
 #undef pr_debug
 
-/*
- * Although these are defined in each ASIC's specific header file.
- * They share the same definitions and values. That makes common
- * APIs for SMC messages issuing for all ASICs possible.
- */
-#define mmMP1_SMN_C2PMSG_66                                                                            0x0282
-#define mmMP1_SMN_C2PMSG_66_BASE_IDX                                                                   0
-
-#define mmMP1_SMN_C2PMSG_82                                                                            0x0292
-#define mmMP1_SMN_C2PMSG_82_BASE_IDX                                                                   0
-
-#define mmMP1_SMN_C2PMSG_90                                                                            0x029a
-#define mmMP1_SMN_C2PMSG_90_BASE_IDX                                                                   0
-
-#define mmMP1_SMN_C2PMSG_66_V13_0_4			0x0282
-#define mmMP1_SMN_C2PMSG_66_V13_0_4_BASE_IDX            1
-
-#define mmMP1_SMN_C2PMSG_82_V13_0_4			0x0292
-#define mmMP1_SMN_C2PMSG_82_V13_0_4_BASE_IDX            1
-
-#define mmMP1_SMN_C2PMSG_90_V13_0_4			0x029a
-#define mmMP1_SMN_C2PMSG_90_V13_0_4_BASE_IDX		1
-
-/* SMU 13.0.5 has its specific mailbox messaging registers */
-
-#define mmMP1_C2PMSG_2                                                                            (0xbee142 + 0xb00000 / 4)
-#define mmMP1_C2PMSG_2_BASE_IDX                                                                   0
-
-#define mmMP1_C2PMSG_34                                                                           (0xbee262 + 0xb00000 / 4)
-#define mmMP1_C2PMSG_34_BASE_IDX                                                                   0
-
-#define mmMP1_C2PMSG_33                                                                                (0xbee261 + 0xb00000 / 4)
-#define mmMP1_C2PMSG_33_BASE_IDX                                                                   0
-
 #define MP1_C2PMSG_90__CONTENT_MASK                                                                    0xFFFFFFFFL
 
 #undef __SMU_DUMMY_MAP
@@ -99,12 +65,7 @@ static void smu_cmn_read_arg(struct smu_context *smu,
 {
 	struct amdgpu_device *adev = smu->adev;
 
-	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 5))
-		*arg = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_34);
-	else if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 4))
-		*arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82_V13_0_4);
-	else
-		*arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
+	*arg = RREG32(smu->param_reg);
 }
 
 /* Redefine the SMU error codes here.
@@ -150,12 +111,7 @@ static u32 __smu_cmn_poll_stat(struct smu_context *smu)
 	u32 reg;
 
 	for ( ; timeout > 0; timeout--) {
-		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 5))
-			reg = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_33);
-		else if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 4))
-			reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90_V13_0_4);
-		else
-			reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
+		reg = RREG32(smu->resp_reg);
 		if ((reg & MP1_C2PMSG_90__CONTENT_MASK) != 0)
 			break;
 
@@ -177,16 +133,8 @@ static void __smu_cmn_reg_print_error(struct smu_context *smu,
 
 	switch (reg_c2pmsg_90) {
 	case SMU_RESP_NONE: {
-		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 5)) {
-			msg_idx = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_2);
-			prm     = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_34);
-		} else if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 4)) {
-			msg_idx = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66_V13_0_4);
-			prm     = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82_V13_0_4);
-		} else {
-			msg_idx = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66);
-			prm     = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
-		}
+		msg_idx = RREG32(smu->msg_reg);
+		prm     = RREG32(smu->param_reg);
 		dev_err_ratelimited(adev->dev,
 				    "SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x%08X SMN_C2PMSG_82:0x%08X",
 				    msg_idx, prm);
@@ -280,20 +228,9 @@ static void __smu_cmn_send_msg(struct smu_context *smu,
 {
 	struct amdgpu_device *adev = smu->adev;
 
-	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 5)) {
-		WREG32_SOC15(MP1, 0, mmMP1_C2PMSG_33, 0);
-		WREG32_SOC15(MP1, 0, mmMP1_C2PMSG_34, param);
-		WREG32_SOC15(MP1, 0, mmMP1_C2PMSG_2, msg);
-	} else if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 4)) {
-		WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90_V13_0_4, 0);
-		WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82_V13_0_4, param);
-		WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66_V13_0_4, msg);
-	} else {
-		WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
-		WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
-		WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
-	}
-
+	WREG32(smu->resp_reg, 0);
+	WREG32(smu->param_reg, param);
+	WREG32(smu->msg_reg, msg);
 }
 
 /**
-- 
2.35.3

