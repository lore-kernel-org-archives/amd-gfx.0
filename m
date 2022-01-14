Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553FFC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 01:38:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D65B810EB09;
	Fri, 14 Jan 2022 01:38:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD39310EB09
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 01:38:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hp1yJ89fsPS/8NLK7D2WD3z4IrloaFQBhqsZ23ted94vV5swpZQF+vJYC08mgAls8+G2+5GeXb7bOiVBtXx3EINijHaRaJyjmvbAP7z6qn1i6YcxF/s2gHNbAYDVoO+z65pBxlZm6KPdaWSQzzq+Knu/sl4BuNnrCfq/SewKZhRvvCyI3IH9FvEXEgcBal1GbG8F1tFB28s0OXD9HyD1UmTQzjQqu7qFW5yVFZ6E2ZkRYJN9V3Kop3NBvzvbvWHuMAdSip9BwBOFQpUwieJyZtGUJJvsVVksoQF4n58oi7Krio8rEUaELGctOr/HeVODpHULrJ3GJaxrlFB/X8euyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjMPDMf6nUHAyefTPOtdWXssbBrbeBgPydLcW3gNAdM=;
 b=VZAjPLnJ0Cwmf7qYnTrVGDz+2LCbTXwCWJs1flUdNd9Wef3LoJFPnyyGpEotM49OEIuz2cxxTkU0mHy3OEtLW4wExxpn78THVeYx1yi2q24hz32d55PYzyJT9xTZiJaJeMnUGjD7mmrZP0agB+9tKGbRvckYqcO7/SswMr8KcLLVb48084nn57K5HPgGVtJy4x9/vug08HrSkdJrERju2RxHUinn6vQ8YSRXtM/So/c76F5lhnOvKxu7VskPhYAoZs4ONGZXL1L5wOajDSKcuYMs3z1jSjQ77LZv7Xv6RdHKtdry4DFCaCerWJGZxOkYw8gXka3tRiS+KQ1nV2hDqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjMPDMf6nUHAyefTPOtdWXssbBrbeBgPydLcW3gNAdM=;
 b=ilWR8QALvtKids9KFfCOK8MlUJRswCmirUS0ol52QRYA2VthwZWYWP/uT43bUbZy+Z6+Cx1Uc6zrev2gOBEa31Pc9JARsFIj0HLqeoGcaMC3kGE36jfQEnfu5EH47dDtujHQTjvmXGgtSedwUYuxtXZu/rJI3UgN4w7lYuuX9vA=
Received: from BN9PR03CA0859.namprd03.prod.outlook.com (2603:10b6:408:13d::24)
 by BN8PR12MB3107.namprd12.prod.outlook.com (2603:10b6:408:46::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Fri, 14 Jan
 2022 01:38:16 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::10) by BN9PR03CA0859.outlook.office365.com
 (2603:10b6:408:13d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Fri, 14 Jan 2022 01:38:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 01:38:16 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 19:38:16 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 19:38:15 -0600
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17
 via Frontend Transport; Thu, 13 Jan 2022 19:38:11 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/13] drm/amd/display: [FW Promotion] Release 0.0.100.0
Date: Fri, 14 Jan 2022 09:36:56 +0800
Message-ID: <20220114013657.3119627-13-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114013657.3119627-1-Wayne.Lin@amd.com>
References: <20220114013657.3119627-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd88eb59-3970-40b8-176f-08d9d6fe8973
X-MS-TrafficTypeDiagnostic: BN8PR12MB3107:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3107AF0169009E24BEA8DAEEFC549@BN8PR12MB3107.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NLxoK+oYRAZijXK+/mvffOZLdV/qqIu5qtyTkgOnLYuH8Qor3EJotWmanrY5Tjc0LYDLVZxVxx8qFPZLEGM9/5nXG3O4+7cFPtteyAicebGMUgZJbbZN9vaGp9NoGfmwwL7o2qi+zM9Jk0kueGx7aBFZJyMzTn2ZqAU4rGFAMVfcoG0c3I3HLDD7DW6QEyvrBM5GOqOWKew587oGNoQMh48C863tU2uDAZJQ0gxvGlsKbOt2uKbdfJa9V3frW/s7V12Hn85TrPG1kBoXD/t7CvDwvp1J+lBOmGXXNArv2ACSQaHpBNaJffADVN7mZRNNY+Xglsm3z5gm9hjhL488ssLWVMLLRC4svyVv8p/zwB2yWRReZ/wChrroZ75KSE3s1h0qu9QoG11LM4V9c/LXt/qjEULIsFQzwc9jdcgIUbqthOkzP/SSu9Ser4HD9D2a5RJOCxvSVLFsVXs0gj7rKn3gkGVNlFkactm7SpS08hIOKLi0/+ntHM/yz9a0tbRK09XpIN9vwgX5SSWgejWwdmN21AmofHRTzGCCompD096uGL1haCEeBlGEqdgEedMBPgFZX1VMzZ0F6VlnyGet0Pbt8bDcJk3e04NaCD951wuaUz7XffyaG1U6kNled0rIai1quqT6gixH5/w1Lh9+E2irvpiSjS+WalH5NCByy2PLCU/79WKthKXfBUEZIWOgFFhKVWXtkSOG5sM/VDI0UdjQg5jQ8dv6IdNMSyxEIi2piTQfRVhvgidJ77tLyHdIisFYUALQp7SOrcKlSJM6xgNHvkHApggm7LXTxmDdWvI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(86362001)(336012)(81166007)(186003)(8936002)(36860700001)(4326008)(508600001)(26005)(5660300002)(4744005)(47076005)(70206006)(2906002)(1076003)(356005)(54906003)(70586007)(6666004)(40460700001)(2616005)(83380400001)(8676002)(82310400004)(6916009)(36756003)(426003)(7696005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 01:38:16.5225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd88eb59-3970-40b8-176f-08d9d6fe8973
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3107
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index d18762e02509..eb152f5e3ec3 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xbaf06b95
+#define DMUB_FW_VERSION_GIT_HASH 0x56a29f36
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 98
+#define DMUB_FW_VERSION_REVISION 100
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

