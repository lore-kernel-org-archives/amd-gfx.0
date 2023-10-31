Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD671C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 05:43:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 251D910E3FD;
	Tue, 31 Oct 2023 05:43:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::625])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D5B710E3FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 05:43:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T030y1Djpla1YmvLsXOoqDYVAAc1iyw3GYrVH49EZPZPdrdErrK6RCFeEB/0x2UQzVufHC7oUFWTn+hnsTVy8mvwZjm4gLa/N8W478S7YIcoIok3c8kckI4lesF+SUdpYsam6ewdwsWbVFuPm/77wRshyxdOp2tyXF6r8yO7u2aYLSrKISSlsU2ZGBEpgXI2zdSUoZgEnCx1lrzFO2lQ+EFTAE46epncMpqvk6uhgpL8hAfDgik8XBTFpPxesgH06b2RlApCzykiV7nl+/nov73tYXs79KXQUyMFUdJ8gSs+F8sXGshrMmq5YxF9PCgGqFlFyfbNubI6CXTYCIctRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnDUmSndfX5oLO+nvywCGvqY7cOvTTHTWZxIEA2IebE=;
 b=KnsdDg4WZ/kHja6vs9tvkYMs7QtsCzJNFCVRv0TBy395Mq6ZzQXoK365L0NbXinT/yzT2V3GiZy6DM40yGWh+HzPskuG0bgfvmT5r83y+2U8Bre9jtW0plkYIeWGk/+M3a2n9gVceh1r4Eg0yXw0XNDxRw3BIqgvjWct0LKGqzE0wbHO7eDNvXZf0PWox8Bj+xiD/SM2X42i2L5nAXLCSh/sLACqEJ3KKPO1F6kwG1QEqgKUSW30bfeBigISk6zhi/So0vozuLmaxEOFRPX2BxqQEhxJS2tUCDmeXhw9DZajA6J3IFmIdszsOHT55OIeYWTJ4VVf3ZTLH7y5rZrEVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnDUmSndfX5oLO+nvywCGvqY7cOvTTHTWZxIEA2IebE=;
 b=ILO67F+MMPqVLkJV6IcC0ydJZPRizSnoJkeJTsKINzZno3stnUj4AaMeCFpoFeRSF1E/EY+dxbc7RcAm7MQ1aj9g61eD4noYY0hsW54u/nPTR/22pjwArx3LWqtuESz9px1nFxmodttYWd6yPc0LYSQiStDouGug/GEWjgHZCbw=
Received: from CY5PR15CA0228.namprd15.prod.outlook.com (2603:10b6:930:88::27)
 by MN0PR12MB5929.namprd12.prod.outlook.com (2603:10b6:208:37c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 05:43:23 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:88:cafe::a4) by CY5PR15CA0228.outlook.office365.com
 (2603:10b6:930:88::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29 via Frontend
 Transport; Tue, 31 Oct 2023 05:43:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Tue, 31 Oct 2023 05:43:22 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 31 Oct
 2023 00:43:20 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Kenneth.Feng@amd.com>,
 <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amd/pm: Fix error of MACO flag setting code
Date: Tue, 31 Oct 2023 13:42:54 +0800
Message-ID: <20231031054254.1912290-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|MN0PR12MB5929:EE_
X-MS-Office365-Filtering-Correlation-Id: 455ae3cb-40f9-42e8-7bd6-08dbd9d44b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wcfvl9BS7xEB5buiwOtyv8lS6AEvtCnHwjnTNgHVN1fNDfLa3ByIKSxCa8jWncI+g606+PgfTD8TbiyYnYgWfL+o8+urGoKoGsg5OMHevfEhcCtsKsxttqHzlG79Tan0+0le1Q+lfwVcI5XyfOZJkqwaqmC1UZAPNkUSn/nxSMMMiGlHaCnRtTOUrF3tpQyIcxOyW6OA7PUV/LzMQWijEUb7IJC5YZA7FUsOi2I+N/0hB7rx5f25fBW5576u/P0BWuhKTJuH56FBFrrUNmlguVUKBtstVFLXOps6EDYE5cJJ+Yj4vtj44tNzKdFmjqpO7+nSwbA/KImRWi4grgtO93BXaOJ71iydFdjpgcHOBUzSOd2FpjBtyzRvr5BI4VihDtbcYTU3SLk7qE+06qwt04RS5/Lh5FjONjwmHEmdXk98oTyVk3kCHGmAuSZdNekSA71tj4qknBLz7RZi1beSA3ZYWV1LZKdW3JFXG3Skopa/aWzGpzZ1qAtGGIggvJmYv74Tg59mwsDMz2CmYf315Cjz4s2pH3ncF2hTd+P8Eo4F7dczb57OGmILXK9y5HwbXsNgwjcsilL315kUDuhHr6w8iDzh/1z7XfU5Jtzx26y7KvKbbwmdhMTaI0geXijkNhCq+Yl6Kh19RO0xv9pZJUhEva9OoiFNanGVyf6EPv2+5W7vPb3bWpow1As1w2dt+3uMgvcD6ZqtdJKmIPslbmNb7Hp1CE6/NWSbso8VWPI2goF7kXyJbpc5uvylwCLY5Wx9J/o576oaeRepysmWgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(426003)(83380400001)(336012)(1076003)(70206006)(16526019)(26005)(2616005)(36860700001)(6666004)(47076005)(2906002)(70586007)(316002)(6636002)(5660300002)(41300700001)(8936002)(8676002)(4326008)(7696005)(110136005)(478600001)(36756003)(82740400003)(81166007)(356005)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 05:43:22.3224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 455ae3cb-40f9-42e8-7bd6-08dbd9d44b63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5929
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

MACO only works if BACO is supported

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 8 ++++----
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 9 +++++----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 2f3ffe9c0cf0..9f038e544270 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -355,12 +355,12 @@ static int smu_v13_0_0_check_powerplay_table(struct smu_context *smu)
 	if (powerplay_table->platform_caps & SMU_13_0_0_PP_PLATFORM_CAP_HARDWAREDC)
 		smu->dc_controlled_by_gpio = true;
 
-	if (powerplay_table->platform_caps & SMU_13_0_0_PP_PLATFORM_CAP_BACO ||
-	    powerplay_table->platform_caps & SMU_13_0_0_PP_PLATFORM_CAP_MACO)
+	if (powerplay_table->platform_caps & SMU_13_0_0_PP_PLATFORM_CAP_BACO) {
 		smu_baco->platform_support = true;
 
-	if (powerplay_table->platform_caps & SMU_13_0_0_PP_PLATFORM_CAP_MACO)
-		smu_baco->maco_support = true;
+		if (powerplay_table->platform_caps & SMU_13_0_0_PP_PLATFORM_CAP_MACO)
+			smu_baco->maco_support = true;
+	}
 
 	if (!overdrive_lowerlimits->FeatureCtrlMask ||
 	    !overdrive_upperlimits->FeatureCtrlMask)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index bc48347a4949..dc2316d8914c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -346,12 +346,13 @@ static int smu_v13_0_7_check_powerplay_table(struct smu_context *smu)
 	if (powerplay_table->platform_caps & SMU_13_0_7_PP_PLATFORM_CAP_HARDWAREDC)
 		smu->dc_controlled_by_gpio = true;
 
-	if (powerplay_table->platform_caps & SMU_13_0_7_PP_PLATFORM_CAP_BACO ||
-	    powerplay_table->platform_caps & SMU_13_0_7_PP_PLATFORM_CAP_MACO)
+	if (powerplay_table->platform_caps & SMU_13_0_7_PP_PLATFORM_CAP_BACO) {
 		smu_baco->platform_support = true;
 
-	if (smu_baco->platform_support && (BoardTable->HsrEnabled || BoardTable->VddqOffEnabled))
-		smu_baco->maco_support = true;
+		if ((powerplay_table->platform_caps & SMU_13_0_7_PP_PLATFORM_CAP_MACO)
+					&& (BoardTable->HsrEnabled || BoardTable->VddqOffEnabled))
+			smu_baco->maco_support = true;
+	}
 
 	if (!overdrive_lowerlimits->FeatureCtrlMask ||
 	    !overdrive_upperlimits->FeatureCtrlMask)
-- 
2.34.1

