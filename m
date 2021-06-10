Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C72BC48BD1
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDF4961263
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF4961263
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B25B6EDA0;
	Thu, 10 Jun 2021 16:29:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 919876ED98
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 16:29:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PC8iTSg3cnuQJBIOotBS8TBl1qciVQ3JHoTFYcQleVNrhiyb2yr7adXdMfD7x30y/mFavZd+v10WX0S5EElxaJmkC/FBKgVsboalF1DZVU3y6HVp8ZHqHELsn4wuHaR6exCPWUg/VXAQ+wt7xwn4802JndYO72qiEkskTIKPfrjLRdZGmuFdPHI0effNwZwNAMZyV+FVx0ZJnh85i29U5AQVjCZULxCoUT1403s9TR21pT2O/dxugw6g6mW7yHTZuf8eRxqlbFGfLqHEWXHeghVG0for2+tc5iIRzYiF8U1t/iSxrU2jbbX+MfCzqFe8iUgZZS3A2WAnJpLH6coIRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qs3ydNEiXE/6lDcdpuc6jvr+Iuw4echQ1hJmytsJMe0=;
 b=VWSdvLLa6hIoGXK1e1t8JyFrZbP1miXP3ifoE4gZGCsnuBkaioCq3TozeJXpaK7rj9bgm21NDc6HKNGKdqWmYX7S3ki89QrI+IErmPM6T+WoqzS1q6J9ghSxwaFpqtVgYaaeNGcX2VeuGzFodZbgh6gcwGVEksui85dhZfSW1SBVTpuciO9kpRIHYYyuWGwvfxjhWTTVTXIAx2XgCFujinQcbTRR/efAxolAjbtWg2MfShSUc2OeTE2JgwHnEHKluKRZvPF0UfTYFJveQQA43BH/f2bn1Lc0llbYhEv6vguypISAG4UUNANXk76CqhYZRRwBoGmXBCx45pgD9SWlDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qs3ydNEiXE/6lDcdpuc6jvr+Iuw4echQ1hJmytsJMe0=;
 b=xkYFCIm2eO2Pa2xsMbxgnw07MIEpOb8Ktks1g+yAlkccV4Cxfor7zPScMbmYWuOkbGhJ9ivSmKHT7wjpTaVdLgMAly1Z5Zv/IZ88qJAGT3lAXlzFBn3XYLbFHJEZj1WQfj2SkftjAh+42K8eAsdPiiDS2crr2Mt3iuBSdbllXo4=
Received: from MWHPR22CA0005.namprd22.prod.outlook.com (2603:10b6:300:ef::15)
 by BL0PR12MB4881.namprd12.prod.outlook.com (2603:10b6:208:1c7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 16:29:39 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::6) by MWHPR22CA0005.outlook.office365.com
 (2603:10b6:300:ef::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Thu, 10 Jun 2021 16:29:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 16:29:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 11:29:37 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 10 Jun 2021 11:29:36 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/24] drm/amd/display: 7 retries + 50 ms timeout on AUX DEFER
Date: Thu, 10 Jun 2021 12:28:33 -0400
Message-ID: <20210610162838.287723-20-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610162838.287723-1-Anson.Jacob@amd.com>
References: <20210610162838.287723-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5eff6434-fac8-4366-5a94-08d92c2cf13a
X-MS-TrafficTypeDiagnostic: BL0PR12MB4881:
X-Microsoft-Antispam-PRVS: <BL0PR12MB48818CD1EC4391CCAFA862BBEB359@BL0PR12MB4881.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fDazZfac4JdQaZ2Ii1N8Plu0cgdIMwrRgj8mjefpfIhARstuf8GsJ/+mZNfQcw5fqy001H4NsuL9EOTkAcNSWJfrzyMZZZABkth1OfIiI37asRng4/bA7j8p40C3nGGXSmLmJ5m4NE/IZE5mJBBZOv5k7MpNH1Q5lMX4qj7p7Pd2J/vRzjk/orfC9p3quizvw618EVUTxxK1nbtPqLBNNdjh2zhvPRW0Mirupph1rMs4Po48SEQEWfTXFDA28UYj+jqwcYssk1EiT0Ge8/LOIN8GAUiGrPnFQVgfnZJhddI5ZBFh50J3rYkIQqdI61WGiIGZRh1VF0RC0tZfZLjVl1iqQeCIZUIlp/yjzcpW5Jc0UJEOqzdRTT/kNMhxgZlT1HtMgjJt3l3W9ovUjvA99Xl9wB9OfK+syz455KiwtwlSs73qDlKWZB0fzIrSIopaIWLAeLVY2PVn/zgfHDx2KxzviCQ+7MaWy33U2cJWA/z238mbR7X7f/ZwuSqP1lzYiBUziIet2Xr8w0tsgaczRUNL6D8J9zWRQAecAjgPr1F9+zwuwjXM3DwXCRr51YqhRYOpuCvK9/GE7CWZUPM7aLKqB0f24xWxivO5yKpYyC6YB7bG2F0EH8/YBnXYPzdCs8dmlQkA7CNQh1LGPJ3YtOWDUEGbYQ8j0YjG9USl6Q6IKfTeIWAyKpQzB5VbDlmc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(46966006)(36840700001)(1076003)(356005)(26005)(54906003)(8676002)(6916009)(83380400001)(82740400003)(81166007)(7696005)(36756003)(186003)(6666004)(70206006)(70586007)(86362001)(336012)(36860700001)(82310400003)(478600001)(5660300002)(8936002)(47076005)(426003)(4326008)(2906002)(2616005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 16:29:38.5303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eff6434-fac8-4366-5a94-08d92c2cf13a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4881
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
DP 2.0 SCR specifies that TX devices must retry at least 7 times when
receiving an AUX DEFER reply from RX. In addition, the specification
states that the TX shall not retry indefinitely, and gives a suggestive
timeout interval of 50ms.

[HOW]
Keep retrying until both 7 or more retries have been made, and the 50ms
interval has passed.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 9d5e09b188c2..49cb4e6d6411 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -616,6 +616,7 @@ int dce_aux_transfer_dmub_raw(struct ddc_service *ddc,
 
 #define AUX_MAX_RETRIES 7
 #define AUX_MIN_DEFER_RETRIES 7
+#define AUX_MAX_DEFER_TIMEOUT_MS 50
 #define AUX_MAX_I2C_DEFER_RETRIES 7
 #define AUX_MAX_INVALID_REPLY_RETRIES 2
 #define AUX_MAX_TIMEOUT_RETRIES 3
@@ -628,6 +629,10 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 	bool payload_reply = true;
 	enum aux_return_code_type operation_result;
 	bool retry_on_defer = false;
+	struct ddc *ddc_pin = ddc->ddc_pin;
+	struct dce_aux *aux_engine = ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en];
+	struct aux_engine_dce110 *aux110 = FROM_AUX_ENGINE(aux_engine);
+	uint32_t defer_time_in_ms = 0;
 
 	int aux_ack_retries = 0,
 		aux_defer_retries = 0,
@@ -660,19 +665,26 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 			break;
 
 			case AUX_TRANSACTION_REPLY_AUX_DEFER:
+				/* polling_timeout_period is in us */
+				defer_time_in_ms += aux110->polling_timeout_period / 1000;
+				/* fall through */
 			case AUX_TRANSACTION_REPLY_I2C_OVER_AUX_DEFER:
 				retry_on_defer = true;
 				fallthrough;
 			case AUX_TRANSACTION_REPLY_I2C_OVER_AUX_NACK:
-				if (++aux_defer_retries >= AUX_MIN_DEFER_RETRIES) {
+				if (++aux_defer_retries >= AUX_MIN_DEFER_RETRIES
+						&& defer_time_in_ms >= AUX_MAX_DEFER_TIMEOUT_MS) {
 					goto fail;
 				} else {
 					if ((*payload->reply == AUX_TRANSACTION_REPLY_AUX_DEFER) ||
 						(*payload->reply == AUX_TRANSACTION_REPLY_I2C_OVER_AUX_DEFER)) {
-						if (payload->defer_delay > 1)
+						if (payload->defer_delay > 1) {
 							msleep(payload->defer_delay);
-						else if (payload->defer_delay <= 1)
+							defer_time_in_ms += payload->defer_delay;
+						} else if (payload->defer_delay <= 1) {
 							udelay(payload->defer_delay * 1000);
+							defer_time_in_ms += payload->defer_delay;
+						}
 					}
 				}
 				break;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
