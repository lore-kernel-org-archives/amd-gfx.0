Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C994FCD1284
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Apr 2024 10:15:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 657BD10FC01;
	Tue,  2 Apr 2024 10:15:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OZ+3E8+r";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2083.outbound.protection.outlook.com [40.107.100.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6058D10FC01
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Apr 2024 10:15:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrm7qoRKENlb2oF5WbT1tkkFHNju/VbjPf60pI2HPtD2e8+bbIU6vm+ajQ6ouAysIE8XMNZ0hh/HPl3H7i4Dca0PPef+lec+obtbuqJY28cJA17quqHoaIwkClIvaBrBtjYaPgwHFFHProoyDDPYWorbJbObv4Ih3mHhw0rBXygtN/BsYmtq2sGGZLioxbzSbf2uIVgszCDAYsKlgp2Q+bJYGfjydOGWc06W8UrbpRVF3p/Y7C6+KAD7Lenrk4SVC3OaAvxzv2siLwaVOLElo2Emd1l17pmokwIrIuWHdX6ixoTD3dmHv5LQ0Tu0nJXAM6FQfME2QaKmNA4wd0I0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Md7TaD8waX7ZZWy9YgukRSByNqOTMbxPm7d924ZYTw=;
 b=L5yrcnNWF7CwJyjQToxtNjHKdMydgY/F62+bFo7ckiWNoZHrzEZ4K4X34aojWrtc3kfPlWKCeSQ1DqK3NmExCtXZPtH4S0H2OiC6m3FyoE3F6fDpJXxLmImdVUHPbIuelEYo0clvqDrJ4fDejyHh0jI86uFMNgSa6N7kUgj8nqPDfmWsWEPb1Px9j+TJBM7x41y1mOrpM7vjYrbfJyELpdbz8rEkUPGN9Rc+dGdp4aXSL9QN+k7HbWPHaZR7i0m0lnYCxxJFw5KRFAHU+85xOh16RPMxXvepUZhXR6cMNhByRJenoZHj3ieVWCMcmMX8soUB9L7xd0feMbycuIBhyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Md7TaD8waX7ZZWy9YgukRSByNqOTMbxPm7d924ZYTw=;
 b=OZ+3E8+rPStt/EHDOYL1H77dZ0JHXY/exkj1wcPnNTo/y6pgDxWzRYcgtGgikn1Jp6K6ReQPDYvtVfMaK1+PIZS27D4Lp2f1bmBHDizDcWktwSdHWyimFhsu/xWLwOuvtFDgURausEZrq5WRg0j1P1+o2QbiHIL/T31fg5pnycE=
Received: from BL1PR13CA0334.namprd13.prod.outlook.com (2603:10b6:208:2c6::9)
 by PH7PR12MB6737.namprd12.prod.outlook.com (2603:10b6:510:1a8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 10:15:32 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2c6:cafe::b2) by BL1PR13CA0334.outlook.office365.com
 (2603:10b6:208:2c6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25 via Frontend
 Transport; Tue, 2 Apr 2024 10:15:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 10:15:31 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 2 Apr
 2024 05:15:28 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <asad.kamal@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>, <charis.poag@amd.com>,
 <Shuzhou.Liu@amd.com>
Subject: [PATCH] drm/amd/pm: Report uclk and sclk limit
Date: Tue, 2 Apr 2024 18:15:16 +0800
Message-ID: <20240402101517.3373466-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|PH7PR12MB6737:EE_
X-MS-Office365-Filtering-Correlation-Id: 243ca57b-d2fc-495b-7b4f-08dc52fdd425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5MrFWmdNns1OED/UHRDL6f1yTkdcx2VDogZ6Qp1bTdylGx2O+dpNtT9SZ1eZAjzsPNQ0eXb1Bb936KYJ8ezmFVSJf5fCFrxL4Drd7z+Y4m7wHIXXOahyxIbTIFH5udoZugcdYVfz8tMpbuuoLt2vugDcyNATIqx9gApxfIJukvq0AP2M/5hZ02JmfmCK0y4uB45PRct7qKSnwsdxt+O6FGp1acGPqZZRPovzotn1ddIuwkQF0aYKhUak6Jwv7YdnPxvEuEcJStPybxuTNhAJuE8BTPS9VCOu8ib1o6EyfYVkTn+d8CuOJyuPM6tFQWs6Dqy43sSy4Kw1q3s+a94Fi5bvgUaP6NELjQZJN7iTTWHJ9WlhrzWFo2gb1+muJkIOx/HyssZ+zrzidPlCjBt1bNkRklq+c8sqKtX5Pt7WDK+mE2f0AFIAeYizP8BkQOwMgJxhejSSd05EKu7oQ2TVc0dssviMiyqdCyYTeUlJ3+k2EVG9V+v7vbHfoK+0AlQDVa26Zos7M6lTEggoVN8xuHF4lr1WsJ2CdBU9UHTHaIspEdG0gheapdMaveZ3FcDmyem44mRQbaHfJ5Qn/Q3GyjRuNjBkos6Om1eBbu1F9Pp82sAJoSz7CIfuBuhBBvnNArnSRE2pqViKCD9Ofx6y/oam0hJbDWZtPR+Cyx+gBCPwC4x3tqbXTlQmD57IZTdCfI+ZT2lAbTfJ6n+6qsIEFRsUPuwlCrbv64irc5cR3nFJ8IHknNtt+Ie/jJjOCHr1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 10:15:31.8884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 243ca57b-d2fc-495b-7b4f-08dc52fdd425
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6737
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

Report max set uclk and sclk for smu_v_13_0_6

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 575292314f57..f81096bfbf2c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1010,8 +1010,11 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 
 	switch (type) {
 	case SMU_OD_SCLK:
-		size += sysfs_emit_at(buf, size, "%s:\n", "GFXCLK");
-		fallthrough;
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
+		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
+				      pstate_table->gfxclk_pstate.curr.min,
+				      pstate_table->gfxclk_pstate.curr.max);
+		break;
 	case SMU_SCLK:
 		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_GFXCLK,
 								&now);
@@ -1052,8 +1055,11 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 		break;
 
 	case SMU_OD_MCLK:
-		size += sysfs_emit_at(buf, size, "%s:\n", "MCLK");
-		fallthrough;
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_MCLK");
+		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
+				      pstate_table->uclk_pstate.curr.min,
+				      pstate_table->uclk_pstate.curr.max);
+		break;
 	case SMU_MCLK:
 		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_UCLK,
 								&now);
-- 
2.42.0

