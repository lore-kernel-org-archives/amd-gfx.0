Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9092EC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 16:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D656610E4EB;
	Wed,  2 Nov 2022 16:04:12 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EF03895C1
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 16:04:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFv6ecwgZkFKcO1PV17nZGozQaEoyNgaxgNAyOaSkZE/7pqjyKJNvjAmL/GQtN29Ki3Z/0dgRWF/R2/LTY/9ZNVCqQho0b2iUp11BK/g2j7Hu5Z6Iv/hEIgcnzjJ55LSmI97AGLp6U7fkNjxhfo2ovygx/bz3CWXr3O5On4GktkiRf7EDBnSkr94YrDSFtqU8Hd2aoDCOae3YXbpxg35rsrmoObk6A+ywdh2FHFLQt7aFrKXVRRg0vqr1kBjpQrI8eDIRyUnViVJS+dbBWaW1ydF8MZriu3YhtUSb0vB2o9F+rGiS/BexUMF9vmCsb+NogUe68rzFpyqeQsOZr4skQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4638sg6JTkhNFFH7nuS8zRWwqUucZGaE3Rpdm3exfk=;
 b=hJSyZSnbmF8OcHIEZhotUlKMUez8Y3OTWO1GrCOwILWBrevqhbnDXLg5zPKovwwF5yqvlrPhGoZIopLWzskPO3vLkltVGQ4vmVkBVTDv/+yN0i9bon2YH3Pkp2ZRDFELzC7m5RQa+jEDYVTbBe2GWlMGR70fy+H1US7qNHuzKkY6O5jxlC4zf77ZLX/Uf6sjtz1nk4pXUAZKaDP05rBo9/1GxTdWVv8z8bAvRKLbTTqyC1+BehDPTXaDLue/woLGmJAoxxD9Hg0+EqQdv8zhDlrb4WKFid+DKcsqabOtJZxghftlZxGhn9LyQV/BF8HoXiD/e7Eyq2osyfXhDBPGMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4638sg6JTkhNFFH7nuS8zRWwqUucZGaE3Rpdm3exfk=;
 b=iCK3ViPETcfZNOgDbLVhhrX3BMI9w+zOfZf3y0BeunD53ReG0fxKflsyTic/ii3R1nXqq0W/6dlvZJNH7YSVqqANbuSs3Yr5WxwGGAdHXbCMx8dfWpMstWWVnOD64+7PmFTtKzE7waNGDMet8cYzjTvh+h1pQa10iyvdllvxdFI=
Received: from DS7PR03CA0318.namprd03.prod.outlook.com (2603:10b6:8:2b::32) by
 SJ0PR12MB6902.namprd12.prod.outlook.com (2603:10b6:a03:484::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.21; Wed, 2 Nov 2022 16:04:06 +0000
Received: from DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::19) by DS7PR03CA0318.outlook.office365.com
 (2603:10b6:8:2b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Wed, 2 Nov 2022 16:04:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT103.mail.protection.outlook.com (10.13.172.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 16:04:06 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:04:05 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 09:04:05 -0700
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 2 Nov 2022 11:03:56 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/22] drm/amd/display: Fix reg timeout in enc314_enable_fifo
Date: Thu, 3 Nov 2022 00:01:10 +0800
Message-ID: <20221102160117.506511-16-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102160117.506511-1-HaoPing.Liu@amd.com>
References: <20221102160117.506511-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT103:EE_|SJ0PR12MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: bfa82867-26bc-46f8-30e4-08dabcebde89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HhF13B31qsX6V53GuwnFLbwilN8rFxDN37j+/omh96tDFBjfQSXvvqJGdtAd07VHEm4ahad0+zPYS+aNfD3Xm8fSCm7SZqHF6MbQ1nuEZ2XZ7lor+B9u+RcdafUVJON/B11m/RqgAmSemQr5AQ+42fD3YDlpT4Gb9XPLW4Q5NP0pBAQmchLT7wHuIuMuBSSql08T2zT+nBYwP6O14hePtAtdqib0IC6kmd4T+SDT5Tnjt4pEl3aeNiH1lcbWwnCwDeCV4lxteoOhKb7BI963EZ091ZEYGg7gD/QnCD9xxBUFjJ/sRTGuMQvIXARkZvLOL8P0kD4DlJsQZkHHjnfZl2voZiEOhnkXegWk+gGX+BwOcitOTtT8mLEqbuJRFwof751BBWUt+5lwBkSXL+FzJkWIwDUEL0pM5aRfIYHCtQQtIdiReU5WiqV8dto3QONPblnC/N4VpwQDx4DJosATllN3Fmgru21rrRFLrKAoNiwnl6+15xiuxrCFej1CZVKhDdURij1rDZuwoPIwz3RYxTWIXreG3T1OzYUdLhwxsa3b77qLu7hIVGZAj0YcvJvrKu8KHlFzhXHMtPyvOK6Msx1oD3RjB9ln/QcLT/VtDrku/5drCDnXTpvinm33kjJ+D8wSG54Eaql3BUcdz9ldPIoVyx6OdUOeHjYinzlcPz2IttiWwzu6isn7cMnBstpkZ3DqTb6BLGvEBcd9StZZNNfqiQLqYFhEubsdji1iHaNn37hSZFbjH0R3Qj0iTrAZ3XBaTrFwWvZRXaM53n4uX8muY0MmGZ6FXdALLhqf42Tx/Jxy+TmIuEPd+i94UVQ5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199015)(36840700001)(46966006)(40470700004)(36756003)(83380400001)(86362001)(82310400005)(82740400003)(40480700001)(40460700003)(36860700001)(6916009)(81166007)(356005)(6666004)(54906003)(316002)(478600001)(1076003)(186003)(2616005)(336012)(41300700001)(5660300002)(26005)(8676002)(4326008)(426003)(8936002)(7696005)(47076005)(70586007)(2906002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:04:06.2434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa82867-26bc-46f8-30e4-08dabcebde89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6902
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Roman Li <Roman.Li@amd.com>, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
The link enablement sequence can end up resetting the encoder while
the PHY symclk isn't yet on.

This means that waiting for symclk on will timeout, along with the reset
bit never asserting high.

This causes unnecessary delay when enabling the link and produces a
warning affecting multiple IGT tests.

[How]
Don't wait for the symclk to be on here because firmware already does.

Don't wait for reset if we know the symclk isn't on.

Split the reset into a helper function that checks the bit and decides
whether or not a delay is sufficient.

Reviewed-by: Roman Li <Roman.Li@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../dc/dcn314/dcn314_dio_stream_encoder.c     | 24 ++++++++++++++-----
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
index 7e773bf7b895..38842f938bed 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
@@ -49,18 +49,30 @@
 #define CTX \
 	enc1->base.ctx
 
+static void enc314_reset_fifo(struct stream_encoder *enc, bool reset)
+{
+	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
+	uint32_t reset_val = reset ? 1 : 0;
+	uint32_t is_symclk_on;
+
+	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_RESET, reset_val);
+	REG_GET(DIG_FE_CNTL, DIG_SYMCLK_FE_ON, &is_symclk_on);
+
+	if (is_symclk_on)
+		REG_WAIT(DIG_FIFO_CTRL0, DIG_FIFO_RESET_DONE, reset_val, 10, 5000);
+	else
+		udelay(10);
+}
 
 static void enc314_enable_fifo(struct stream_encoder *enc)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
-	/* TODO: Confirm if we need to wait for DIG_SYMCLK_FE_ON */
-	REG_WAIT(DIG_FE_CNTL, DIG_SYMCLK_FE_ON, 1, 10, 5000);
 	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_READ_START_LEVEL, 0x7);
-	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_RESET, 1);
-	REG_WAIT(DIG_FIFO_CTRL0, DIG_FIFO_RESET_DONE, 1, 10, 5000);
-	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_RESET, 0);
-	REG_WAIT(DIG_FIFO_CTRL0, DIG_FIFO_RESET_DONE, 0, 10, 5000);
+
+	enc314_reset_fifo(enc, true);
+	enc314_reset_fifo(enc, false);
+
 	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_ENABLE, 1);
 }
 
-- 
2.25.1

