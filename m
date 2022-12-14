Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688F2C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 20:22:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFF2510E478;
	Wed, 14 Dec 2022 20:22:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 608F110E475
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 20:21:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMnPHrUbM59TfMFFlx0BrKiL0e2ZC+oFHbZThA4oJR1ODcFaoykB+zZmBm6lY9wx0cEgiBx7cUGdXkEaMBJEeS+7185v1Bhb5Ibs59dSsSHn+RigkSAVM1H73j/+f8+CE21QpdhvwI8OC/IFtDX878EKQ1Wium5AaD5nA7nv2hvf0J1GDMTXPzjCImRikMUbRtQBQ2r0gS7uEIJ4UdDSia+j8FQ/lcZPf06lyq8KZ1GfNBF+9htLmT1NDifNuLH8n5NumsHLDdGQQHO07MRWpJpirQ3LB0znMnxR9yoanilc3TgwhuNASQq7GyDw9EzYqzaxoJN3zdp7Rs+9EfwSSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AELAVyzuXgpdiY+NqPJOjIO8lr7S5hsMN8S20RHT0MA=;
 b=RVQfcNPUh2wSJPoTGei26cTHnRntT2uZivJwKMHTHXeJF3O/W2pcteTdqkSY5kTqO3QEk0f375W9+G9OqVjA6yJSVvPuCcAhgvuugw6BsIW8WEQobHdLmc/cf6ECC1pD4/F2EjiH+go1/8wKNpQ5XNOMlEdGP0+lb7nyGZ//WwHBIj60Av3vANsqqyykVmFWopb7jzv4iTDl28/kXJhgnDXy0SLmNROstX1Ema2h7EJm7ug4XCmFyNUW0TxH78Phe23PXpIXTCIv+P7fubG5UQDOZut+tD50to0NMZcpEfQ/wKWuPRLpsd1LD+2X+4qHFWjwTgc5Xl4YCxzbdlHrWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AELAVyzuXgpdiY+NqPJOjIO8lr7S5hsMN8S20RHT0MA=;
 b=IHUZq9C4bB6yMGrIGJitkNssCr4XTHREXdv+3zeJm3xjUJUW+w21Xjh9XesAKuENCl672n45rYudPmQazg4D6RUJBzGrPTJC3yPJhT8TLqTb2NT8BcnPeNBjp1Lo1QSnpIwr8ThIP3ewk5qEY10jJeDcoUqiBXoCuVW0lUUBDa8=
Received: from MW4PR03CA0108.namprd03.prod.outlook.com (2603:10b6:303:b7::23)
 by SA1PR12MB7365.namprd12.prod.outlook.com (2603:10b6:806:2ba::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 20:21:57 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::96) by MW4PR03CA0108.outlook.office365.com
 (2603:10b6:303:b7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 14 Dec 2022 20:21:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 20:21:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 14:21:54 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 14:21:53 -0600
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 14 Dec 2022 14:21:53 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/18] drm/amd/display: Use mdelay to avoid crashes
Date: Wed, 14 Dec 2022 15:21:28 -0500
Message-ID: <20221214202141.1721178-6-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
References: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|SA1PR12MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: c9abc6b5-8b06-4def-aabf-08dade10d856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YDf8hUKRl1gAnsQky+IXFjN4OjEIwSZmUH0UEQwt4p5k+7Vjqe1hcy5lRWfaI+IjIqwq+YViG65Pfe58zpLeSF+G8qGSuxsyqwBTBSTKsCssAegpHSDZ0TTzQ3GOwTv/HBc8wC88h63PgDR1ec+pYqRrnGfYH4GhQ4VElCqQlqztc+PmeTxXuazfZ5AVxi/mxxOuDTTDc2/+ipRmXQPYfFPnHYkP+sDUUMoxGaHZxX4sQzxoeqMOwHyN2oE2LLEYboFRlj6PmiTLvCLuFSVpGpST+MV73ST4KbnH1gck9a3Vltwg+iGeQWMC7XADpVFV6bBgR4UAPppNSu2IinvzyX9A29ceK04DrM+lT4ARYsndoFnhPd2beu0eFD8yM6FjWI9A32CRX1l0dnSMZP9FHnS6PxJbFQjIevvUNBDSj1Q8HO9nPrgrELea1lbteZJBxg4lsob/PWYyDnaRuaHLStfV/grvOsjsJmNBXPp6zZejKYjLW/QUznIvv8R2duD6nBG+wDK2VsSfGUg8/OOR2PAArvgbOYwDl1W5fVjCt8IxwaZJQpmu5Do7QipPDn0KNJHmOYgaYVCLoucwnXFMnIMU8zyVD0Xwk8fH1AVXIgJaYUitqufQR/C5Q5Wp8eswim1reFJNgIvFgX3c2ciKEHOhcB3ivju4MjyKD1XoeIl5J5OjjdHQ5K/DnDUIlaXGGMsGm57CSl/7ew/1jafZppBatBPe/M466ayqvU/Wd98=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(1076003)(5660300002)(336012)(186003)(41300700001)(36756003)(426003)(36860700001)(40460700003)(44832011)(83380400001)(2906002)(82740400003)(356005)(81166007)(82310400005)(8936002)(47076005)(7696005)(6666004)(478600001)(54906003)(70206006)(6916009)(316002)(70586007)(2616005)(40480700001)(86362001)(26005)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 20:21:55.5185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9abc6b5-8b06-4def-aabf-08dade10d856
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7365
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

[Why]
When running IGT kms_bw test with DP monitor, some systems crash from
msleep no matter how long or short the time is.

[How]
To replace msleep with mdelay.

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 913a1fe6b3da..e6251ccadb70 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1215,7 +1215,7 @@ void dce110_blank_stream(struct pipe_ctx *pipe_ctx)
 			 * After output is idle pattern some sinks need time to recognize the stream
 			 * has changed or they enter protection state and hang.
 			 */
-			msleep(60);
+			mdelay(60);
 		} else if (pipe_ctx->stream->signal == SIGNAL_TYPE_EDP) {
 			if (!link->dc->config.edp_no_power_sequencing) {
 				/*
-- 
2.39.0

