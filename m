Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1054C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 06:17:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A215110E582;
	Wed,  9 Nov 2022 06:17:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27B2710E581
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 06:17:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlHCqQCvF0QVQD/5K6Ilg3KsVGpjJ6908h5Q+mc7UCws/VegiVXcEBj1TIin5cV+V2ag/Yd+9lEVq7hYXLiBTsF4cvdpiQtjyFl4HHXUIaOBzSCDNvRUU0itsCkI2kZXCLfKoZAgBUKvjqXlmnErJ8D5ilCnBFJofoBcaqyQm+HM863SZXRyVWBQwyLdtVc+Gk1psbKzBnYALHrkMpiHsSb4okZuLX2P2zSq71FvlwSWNapgD0TE69rbNvkqGeBhi+O0+6TBXK1S+lXl6XkEKBGxC3Xj0DBvo060YYf7l0DZzTd7x77x8VrauaeVoUtRBZX6SjECa4TyoiQwNjIxhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUppW1TpcNB3niQbO2Lw+IghSB1alPdAEynXifXSmGE=;
 b=XoCMGSefuN9D5jRYSa/J/G1PnWeO9TJcKvuI23L2yQyZy3TV4/1rThTJT7wA++upZ5EaPfse/frsVN1DRxL5G0sNtp+KjkFBFt+kmhtqjv9MM9uwZSZatBzoP4yVrRl0K5aXb41DwyI5eSh2yrxMSkDtNLiG8QG+3LTe7bA0D12rQfHdCJTvWTXlN4FBKaDuZ9+J+8WCFuo0Anka7EksV9AhVxuC890HG0spDS4n68/3McGCfgpkDS+R/pbEcLjz5NKR8rbDzjN6s6gbVGQScRnZJ+ZDjmyayA9dqf8s/07v16xT8PEtk4g/w3rodVnaJlUsOmeGpxskrGoCLzSE0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUppW1TpcNB3niQbO2Lw+IghSB1alPdAEynXifXSmGE=;
 b=TEgY0ElMbW3PXnFBEJ+2VzuqjLqMOcmujdjzk3JRLkrtAP9scZ1WVkm9DEESqkE5QoJHYn6pjpzxVrfpC1BYbSt2PTVO6AmDh4V5un+/4V7SedZRVUKkRTk/LEsGuxEjw8bNNLkXAS8xP9Q0SDygypGnNn12naPR9WWRi9BtXaY=
Received: from MW4PR04CA0099.namprd04.prod.outlook.com (2603:10b6:303:83::14)
 by IA0PR12MB7773.namprd12.prod.outlook.com (2603:10b6:208:431::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 06:17:31 +0000
Received: from CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::39) by MW4PR04CA0099.outlook.office365.com
 (2603:10b6:303:83::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 06:17:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT112.mail.protection.outlook.com (10.13.174.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 06:17:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:17:29 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:16:47 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 00:16:42 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/29] drm/amd/display: Don't check output BPP for phantom
Date: Wed, 9 Nov 2022 14:13:08 +0800
Message-ID: <20221109061319.2870943-19-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
References: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT112:EE_|IA0PR12MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: a3fa33ad-40e1-40bd-1d32-08dac21a1542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JLVF1tDP8wGKYnjExDf1m5ofKQrln2arVeIUyuU3anx86Hvvj386Zb6YYmWbJO5mFWHXCpqIARqCB4LHcTwwKIgCM6MkewT9KqsfHU0BUk/S4BDPU9zInRE4kcUbqiTpb+N/+16iRUC63TgTZ4S9EcFlOhWa7BXFC2zEVpdRIBcGYkg46pJvszjRtVNvWNyvPDjZzHYLlQHEm5dCN00A+u65x7m0Jukp2SyzoEVFvhJG0mjk/9vxlA7Yxx1zbLXR8+KMWzyhL104Zh7H+icCl3R6pOLuC+E3O+cjLNa+/aZN8mTk8gJouX/dnQgOQ0MI70iSkXFQdhxQnw+BeDvOgvlwecdQRqGnawH9OfsIbfUXLdezKiofZuZiTxF5vDEDUSIVHKQVuEiHuzIjG1I/DgkNc4gOc2X3MdYjtDsSK6DrDoW5DDkz1Wy5WtC9lRuStdA87kMX2XC4nW5OyTG03YlMsb6FJROvLgehS35nXIx6raUnHbXbje3GB6rX/b3GvWSE3r9botC6EXZb8n6nHlnpRirJeBNVdVd4vEZpmwatAXioULUY4wg49qKCQgQTiagBAg1XnHNvpXIAJBBkZOa259ZypxTBDP261GE1jFF9VDujy0KGHW5Tdv7Wt0X+1m+xo45G7+zzpounnDvDASVLlPEepcJhTz4eMCd8xQowq9FuKmWNH5xG2t3eGUtRADAmqIK00IOrnnn9it9fNUS1J6ep3bkPJD65mT8lWNLmFOTXtNRVG51fdsX8TvNFfebZFuXWZWW62tPPMmMUpjygk3nV47odq2sFrs/7N7rCWVs2V+iBFZVi7DqpzHeZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199015)(46966006)(40470700004)(36840700001)(6916009)(316002)(54906003)(426003)(5660300002)(41300700001)(36756003)(4326008)(8676002)(8936002)(2616005)(36860700001)(40480700001)(70586007)(47076005)(82740400003)(356005)(81166007)(7696005)(478600001)(82310400005)(40460700003)(86362001)(6666004)(26005)(336012)(83380400001)(186003)(70206006)(1076003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:17:30.6532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fa33ad-40e1-40bd-1d32-08dac21a1542
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7773
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- If we're enabling phantom pipe for a high
  link rate display we could
  fail DML on the phantom pipe since it's
  set to virtual signal
- Therefore don't consider Output BPP for
  phantom pipe

Reviewed-by: Dillon Varone <Dillon.Varone@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 244fd15d24b4..7aaf67b464e0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -2284,7 +2284,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					&& (mode_lib->vba.Output[k] == dm_dp || mode_lib->vba.Output[k] == dm_dp2p0
 							|| mode_lib->vba.Output[k] == dm_edp
 							|| mode_lib->vba.Output[k] == dm_hdmi)
-					&& mode_lib->vba.OutputBppPerState[i][k] == 0) {
+					&& mode_lib->vba.OutputBppPerState[i][k] == 0 && (mode_lib->vba.UsesMALLForPStateChange[k] != dm_use_mall_pstate_change_phantom_pipe)) {
 				mode_lib->vba.LinkCapacitySupport[i] = false;
 			}
 		}
-- 
2.25.1

