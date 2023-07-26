Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C916EC001DC
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 19:32:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8232710E4B0;
	Wed, 26 Jul 2023 19:32:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFB8910E4AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 19:32:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXUwZjyIUm25o963g/XDvvbJmgVj4VXpHuuBHUvhv4hVWvITxuqaK4yyUMjsR/e8iKMpqlxv57Iiu3jbnw/9L+fEX1HAVRkm6swdHlKOOLJvqfCOxHG8WKrbNDbR4pOQO/bFu6N4td03Z9gTwevqPR+HSGeKEMDiK6bJ06yrqwmK0m9q41F7oaZGjsZ2eJvflZuwhJFAc/eBErvUmjvxFEFnsRM50VwRPa0PD90e1QMblbFzJ/0a8BqzCDNKOURSzeFl+Q++5FVDg8/zmIM26mJ8TrdArmmuOAr0kjtcYJgMxO1hVDX82z7CDTc92qGFgXMli2h4pJ2ZBk2Gimgwrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JcLMpFfFLXqCOgvPONmIoiHdk/c58Q2Kl0W8JV5QJI=;
 b=NImkcNwlBHDiq8T/RvKzqjs98X/G42WfQ1IUF1o6bh+TRaWbaBmGwFTaKg6OaUCxTV9Jtv+z9i/slXeGEdnkP1X4+c7gOSZtGhTj6M0fAfsGnZshY2a7/Ik7wMjiQeLyEjYqBP/kxD/STV+0xoBSH+cu85QyMOeQhbo7dlS8F05j9e0J3PbYHPRksEoy421Uns46xve7RAFcFuvRWBEEuE3HsiHNP6Gld4qO6iRuURD2nCLICnxQLuTKM9ujRoMTLmsQaFXxk+SMHs7RwD+kOXjhlnHcxJ3G+O0U0mfYfPUky0JI669oHbq1thDF4rSMi6hxIbAO0YQRCBIK8rIb8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JcLMpFfFLXqCOgvPONmIoiHdk/c58Q2Kl0W8JV5QJI=;
 b=HnOCTXEcxlAvjfhuTGWjJyBmQk6NB2Y58Ep9rIj/EiZInQH7AdYz2QxpRBsJhLIDSX+RxVQBMfyAkCQtiR9nKzlsFWMbX7LAGawLGeMNEKlS/8pDB/cLfHPcQy4h6++5zPtnFV0SZ1hfVh7mte5Ph+dLB8Fq9Q7LAVTNCCG7iYA=
Received: from BN0PR10CA0025.namprd10.prod.outlook.com (2603:10b6:408:143::22)
 by DS0PR12MB9424.namprd12.prod.outlook.com (2603:10b6:8:1b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 19:32:00 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::da) by BN0PR10CA0025.outlook.office365.com
 (2603:10b6:408:143::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Wed, 26 Jul 2023 19:32:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 19:32:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 14:31:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 14:31:59 -0500
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 26 Jul 2023 14:31:58 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/7] drm/amd/display: Clean up flip pending timeout handling
Date: Wed, 26 Jul 2023 15:27:42 -0400
Message-ID: <20230726193155.2525270-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726193155.2525270-1-aurabindo.pillai@amd.com>
References: <20230726193155.2525270-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT052:EE_|DS0PR12MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: a49171c2-1a96-4356-6c4d-08db8e0efb68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WZ70L3QI1CcAo9QocDhE4LRRT9R/umzoyA67lf+gBtrDGvEc+LdJsl3li+jxJP7mDb4e07RSj2c1n5W0mDkch2V1tFvWZGDnQ5ayrrnrVLT/9RMsRBHo/+dwgX+4Pn+FAnxzJ2OHtY8aO2cxh1XCtX/7azgEL8clST5lM6+V/LRVfz0G9GY3PgxPKwZwpyyoUMospatkPI4/7E940t/X4ifXWfsCSLghz05+aZHOoFQh5Mwoxe9IIE6gT3VzpVSz82HTC3Txeqnh/sRrrurT8+39TwoxFM57SJIUEOAw5ejYz4+Fp6XJ93IPQELoBdTDBO3ksxZ/Fnokqu4tCqqFEkspTZZwzfYknHAcd+pLpqLNMgGEjZ6FZCC3bo9S1pkicnNH4IQzFWIVbcMVjtSirfhC42qCFHryYvu05trdA4R4gWzFMkLC9QbqDbsly0qMYcFuYrl9iwNbFVnek84ZyMruU2N2D0W8zgllhKCFfIPXgP+ImPMkqYOT6kU+mUWHfKiRFZR7h1MHCu1rE0mngxHU185hRwAftS8+jPXAQ6YYfFG0dWO+/CU27MDvrKDKFki+XqT52Hh9FOK2srXB6jBkDszUuU0gI59tEQHC91MgKYbX9ntFqWmQ68jyRsnlCDNhM2F5WGNqm3qtkJh9p4Ee9jBoVcSLapWuVg5OdRL8yRuDusE+qC1XkWkHuUbjH0SaUKEeiSHiY7Dj+t/xQVZzD1Z8dqwO8r91/btb64IVuaFQSyNVfdGkjDHswR5y6hAFW67a3eO5SjKYJyvoWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(478600001)(54906003)(7696005)(6666004)(47076005)(186003)(1076003)(336012)(26005)(2906002)(2616005)(426003)(8676002)(8936002)(6916009)(4326008)(5660300002)(70586007)(44832011)(41300700001)(70206006)(316002)(82740400003)(81166007)(356005)(40460700003)(86362001)(36756003)(83380400001)(36860700001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 19:32:00.1199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a49171c2-1a96-4356-6c4d-08db8e0efb68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9424
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
Cc: stylon.wang@amd.com, Joshua Aberback <joshua.aberback@amd.com>,
 Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
Adjust timeout handling code for easier runtime manipulation
during debug. Change has no functional effect by default.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c  | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index e0a73d99b784..fc1af33dbe3c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1269,20 +1269,21 @@ void dcn20_pipe_control_lock(
 	}
 
 	if (flip_immediate && lock) {
-		const int TIMEOUT_FOR_FLIP_PENDING = 100000;
+		const int TIMEOUT_FOR_FLIP_PENDING_US = 100000;
+		unsigned int polling_interval_us = 1;
 		int i;
 
 		temp_pipe = pipe;
 		while (temp_pipe) {
 			if (temp_pipe->plane_state && temp_pipe->plane_state->flip_immediate) {
-				for (i = 0; i < TIMEOUT_FOR_FLIP_PENDING; ++i) {
+				for (i = 0; i < TIMEOUT_FOR_FLIP_PENDING_US / polling_interval_us; ++i) {
 					if (!temp_pipe->plane_res.hubp->funcs->hubp_is_flip_pending(temp_pipe->plane_res.hubp))
 						break;
-					udelay(1);
+					udelay(polling_interval_us);
 				}
 
 				/* no reason it should take this long for immediate flips */
-				ASSERT(i != TIMEOUT_FOR_FLIP_PENDING);
+				ASSERT(i != TIMEOUT_FOR_FLIP_PENDING_US);
 			}
 			temp_pipe = temp_pipe->bottom_pipe;
 		}
@@ -1952,7 +1953,8 @@ void dcn20_post_unlock_program_front_end(
 		struct dc_state *context)
 {
 	int i;
-	const unsigned int TIMEOUT_FOR_PIPE_ENABLE_MS = 100;
+	const unsigned int TIMEOUT_FOR_PIPE_ENABLE_US = 100000;
+	unsigned int polling_interval_us = 1;
 	struct dce_hwseq *hwseq = dc->hwseq;
 
 	DC_LOGGER_INIT(dc->ctx->logger);
@@ -1974,10 +1976,9 @@ void dcn20_post_unlock_program_front_end(
 				pipe->stream->mall_stream_config.type != SUBVP_PHANTOM) {
 			struct hubp *hubp = pipe->plane_res.hubp;
 			int j = 0;
-
-			for (j = 0; j < TIMEOUT_FOR_PIPE_ENABLE_MS*1000
+			for (j = 0; j < TIMEOUT_FOR_PIPE_ENABLE_US / polling_interval_us
 					&& hubp->funcs->hubp_is_flip_pending(hubp); j++)
-				udelay(1);
+				udelay(polling_interval_us);
 		}
 	}
 
-- 
2.41.0

