Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F9BC76195
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 06:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7E2B10E4F5;
	Fri, 24 Mar 2023 06:52:58 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09ECD10E4F3
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 06:52:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCLbXGD/DhCebL6JKnru2LtgNbfxDgGbpwV9ZFTEIherHOmUftahLyPARhRT1nfWLmYk4RO1ouTwry0mn1yeO9G/I8MRHAQ6lh6ZNLgaLEEZ2UPXE+8DDIVuW2SvPG1hdIwobRj0dhJ85sUikcXHoCzVYoWNa5PiLvIWk+jvIGMXFB32Vwwk85krcltQp50uud5O9zDHdkYJU5/3c9didxs8IKq0vQvas351HALMBrVzhSn9gC8i4KNCZ7qLg2B760ccP8F2m67d6mMnx0f7JLHy6kSP+ldM6k7fKHHiC/UCwQUkpYjc/+C2VcbVCW8xgIcHYqTfs+GOb6NrI/r/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xd+8ymqzdcEGIbXG0jkyhlZ2sGW/oHQfQ4Sytj9DMbI=;
 b=AmckPe0eyOTtQCeKt0WPCpsDZiSb5A89RxSrVGLrTc3CesLFLEKPZ8ha2BU1vjes4rJPvgzc0BhZCB7lcUyh2bqxUZxlr2lHJjI6v2lRIEpCSFy3ctJ2s7cUtCWIT/eQnoaYp4BNNGeFbHwk1ZpTo5Bc6UA30hs2Cdt/W2BxPl1RgebzFCcBrMXBTx//l+TsaWc0XQsVNP11GvnzhyTO72CLzuAf+ezezzKu8N8t8zVBJWMSK5ZHQogEdqdaUiQ+GqSj/D6eTs+eTceVHTpStn/srDW7E1/BlZMAnVdrHN3tTYsXqdT/gRsTjOVsKAr3MlzzwN8Y9oOSaExHezXZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xd+8ymqzdcEGIbXG0jkyhlZ2sGW/oHQfQ4Sytj9DMbI=;
 b=NqK37TIchFo+TudO86bYxjns4HXGNqgiJjJwq3d0voNdLYrb3ohGovLC4bvw+xlKeIbEqmGG+eYsIcEYyG7l6UvmX0wrHdFJcQEJ6VxbGG5cA7UPIfhGewJkOMEWJpiVnEMHWruMA9S7GXWUX8GVag3mpbaMNYXsYLwP7QKtTpI=
Received: from MW4PR03CA0120.namprd03.prod.outlook.com (2603:10b6:303:b7::35)
 by PH7PR12MB6933.namprd12.prod.outlook.com (2603:10b6:510:1b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 06:52:55 +0000
Received: from CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::7e) by MW4PR03CA0120.outlook.office365.com
 (2603:10b6:303:b7::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Fri, 24 Mar 2023 06:52:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT101.mail.protection.outlook.com (10.13.175.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Fri, 24 Mar 2023 06:52:54 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 01:52:48 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/19] drm/amd/display: Add support for 6.75 GBps link rate
Date: Fri, 24 Mar 2023 02:51:04 -0400
Message-ID: <20230324065111.2782-13-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324065111.2782-1-qingqing.zhuo@amd.com>
References: <20230324065111.2782-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT101:EE_|PH7PR12MB6933:EE_
X-MS-Office365-Filtering-Correlation-Id: bac24a22-faf2-4e84-79d2-08db2c3464f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CAnF8TFs2TYBgqiPxmPiF391sKvjRpGpfvIkU7DSGKK4hUYaNWj9zpwk1EDB0XTVyClYXF5K4uOHIo5MehA7K7dx4hiVmZhx7XMjhz/hplnx+8lqgVcMd9WNmSSmTj8QtIqIo2CjXo4H5XYJWngQuJ3YOppfnioay7c8spMvWINLDWvn+4Lo89fnKF6JYgcKTAPf0aF7HYw7BmHepY41y+xlScVUjcsLpKs2o2moVAC8Z29irSMPCTRBD8Haw0UEFEP1x5UxIDK6A3dxScNRpX8mfvKAfOWjZMITvosBrXOMlmnqgQ1o/ZFGEgo6PwYM+binRV9P4d0Nac1APVNzbKwrkf0IUBTBzMH5TAMzt6+F7wMJz/mGp8N6sOf7jTZMrzNFkIEA3Fd3LIR5XMDndXfwzrDjYU0ha5fdpX0gll2Ox2wrmpi4yPHPfH/2SAzG8is5XPIsuHSDl0Y2m7vJM5ndSrBNIxVmpZz2od8C/pPJyMjpFFlWvwV9GZZ99IL09w9CSkcjL4iYej90IqBIrWHlqPVQNrgrAYsbdJr3rJACSGdcv1+a5CmH+cgBQZmJ6m0GfZk+Ng3Pdwij7OtjOH1IiXp+KToNeIFih964F5Fyj7jrXn/w4jgZrQgsqdDAZoQCLQl4Ai9qz4zvUug3zCreJrerquMgJG0cLN9xPOlcgG5ldXfWFkG6LqOt9lPUhnswCaS1z2FDhn93T5avTFBEviXvOwPNRa6iJg9ol2Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(40480700001)(356005)(2906002)(40460700003)(36756003)(83380400001)(2616005)(336012)(186003)(16526019)(478600001)(86362001)(82310400005)(36860700001)(70586007)(6916009)(8676002)(4326008)(70206006)(54906003)(426003)(47076005)(316002)(6666004)(1076003)(8936002)(26005)(81166007)(41300700001)(5660300002)(44832011)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 06:52:54.5053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bac24a22-faf2-4e84-79d2-08db2c3464f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6933
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
Cc: stylon.wang@amd.com, Artem Grishin <Artem.Grishin@amd.com>,
 Charlene Liu <Charlene.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Artem Grishin <Artem.Grishin@amd.com>

[Why]
The latest eDP spec version 1.5 defines a new generic link
rate of 6.75 Gbps/Lane, which needs to be supported in the driver.

[How]
Added new element to the dc_link_rate enum

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Artem Grishin <Artem.Grishin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h    | 17 +++++++++--------
 .../dc/link/protocols/link_dp_capability.c      |  5 ++++-
 .../dc/link/protocols/link_dp_training.c        |  3 +++
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index af53278662ec..49aab1924665 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -47,14 +47,15 @@ enum dc_lane_count {
  */
 enum dc_link_rate {
 	LINK_RATE_UNKNOWN = 0,
-	LINK_RATE_LOW = 0x06,		// Rate_1 (RBR)	- 1.62 Gbps/Lane
-	LINK_RATE_RATE_2 = 0x08,	// Rate_2		- 2.16 Gbps/Lane
-	LINK_RATE_RATE_3 = 0x09,	// Rate_3		- 2.43 Gbps/Lane
-	LINK_RATE_HIGH = 0x0A,		// Rate_4 (HBR)	- 2.70 Gbps/Lane
-	LINK_RATE_RBR2 = 0x0C,		// Rate_5 (RBR2)- 3.24 Gbps/Lane
-	LINK_RATE_RATE_6 = 0x10,	// Rate_6		- 4.32 Gbps/Lane
-	LINK_RATE_HIGH2 = 0x14,		// Rate_7 (HBR2)- 5.40 Gbps/Lane
-	LINK_RATE_HIGH3 = 0x1E,		// Rate_8 (HBR3)- 8.10 Gbps/Lane
+	LINK_RATE_LOW = 0x06,		// Rate_1 (RBR)  - 1.62 Gbps/Lane
+	LINK_RATE_RATE_2 = 0x08,	// Rate_2        - 2.16 Gbps/Lane
+	LINK_RATE_RATE_3 = 0x09,	// Rate_3        - 2.43 Gbps/Lane
+	LINK_RATE_HIGH = 0x0A,		// Rate_4 (HBR)  - 2.70 Gbps/Lane
+	LINK_RATE_RBR2 = 0x0C,		// Rate_5 (RBR2) - 3.24 Gbps/Lane
+	LINK_RATE_RATE_6 = 0x10,	// Rate_6        - 4.32 Gbps/Lane
+	LINK_RATE_HIGH2 = 0x14,		// Rate_7 (HBR2) - 5.40 Gbps/Lane
+	LINK_RATE_RATE_8 = 0x19,	// Rate_8        - 6.75 Gbps/Lane
+	LINK_RATE_HIGH3 = 0x1E,		// Rate_9 (HBR3) - 8.10 Gbps/Lane
 	/* Starting from DP2.0 link rate enum directly represents actual
 	 * link rate value in unit of 10 mbps
 	 */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 2a2443535b67..7d7edbb2cf52 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -203,8 +203,11 @@ static enum dc_link_rate linkRateInKHzToLinkRateMultiplier(uint32_t link_rate_in
 	case 5400000:
 		link_rate = LINK_RATE_HIGH2;	// Rate_7 (HBR2)- 5.40 Gbps/Lane
 		break;
+	case 6750000:
+		link_rate = LINK_RATE_RATE_8;	// Rate_8	- 6.75 Gbps/Lane
+		break;
 	case 8100000:
-		link_rate = LINK_RATE_HIGH3;	// Rate_8 (HBR3)- 8.10 Gbps/Lane
+		link_rate = LINK_RATE_HIGH3;	// Rate_9 (HBR3)- 8.10 Gbps/Lane
 		break;
 	default:
 		link_rate = LINK_RATE_UNKNOWN;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 10261764a0ce..f301c9eaf2f9 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -86,6 +86,9 @@ void dp_log_training_result(
 	case LINK_RATE_HIGH2:
 		link_rate = "HBR2";
 		break;
+	case LINK_RATE_RATE_8:
+		link_rate = "R8";
+		break;
 	case LINK_RATE_HIGH3:
 		link_rate = "HBR3";
 		break;
-- 
2.34.1

