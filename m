Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3AEC32789
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Aug 2022 14:00:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4D70113ABC;
	Mon, 22 Aug 2022 14:00:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD9838F1CB
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Aug 2022 13:59:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zw3qKvmYTwRna/RcrHnvtkZn3JfePtRfAldMf9Hmi4owwj4rH5EL4t6tqvvbG28ssk3r/S+Mx5C9oIK9SMQNihb6RYA90Tkzc07QqMLqRMIz/K3VS3Q/0RYRpCMrrShcRl+iWWougXbGedtYgsnhpK8VG1JBiE744+BI0e/U4+KvIrFeagmGNjoARNZNsDWBSLVmX83nqFW6wez8Nsi6eMzcs/IBdOZsoR0OLpFN80zu9Lc1B29zWvO2QUOTNXlmWQNFBIeLz6l2DWjCoR3VBjqs/1TKsfBmYONTgeVwGPyNbOdRSmdV2Lp0ktrFLjIYFn9fJXqvVr7WNzsR+GKj1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YghlFqly5hoUUjHmBpYDrzKra7vgQYJ3dY+5R4/7g8Y=;
 b=nWke7+uSqrllZa071r4XYMWkudCAVa4WwmyVkqRH0ZLfX9NtmASi5rC2vjaO8wpILdIwQ79RRQ6K01dp6hQDS4N4HS0ImyngRP0+DkdfsA0LwV2F6YRt0QmUz7VLcsM2x0TVHJIsRxM65VfjjV+b4v3YbeR6+l1kl4fkb5fjvanwJDvRxWgCKsPYvyLp5+jY/kBLUdatHksC32O62fF15pgApKRg9/Pci/+jG/DQQzRMHtxSBK/2HezcE+RNxn6l+jX3CM2H7kkdavVyFC+ZfINnrqe5s9uUmOArtO/A/hATooJlhZH+m/SxL9uAXIjNxNSlRd5xHoBF8JCKjl+LZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YghlFqly5hoUUjHmBpYDrzKra7vgQYJ3dY+5R4/7g8Y=;
 b=xwvom9BSXgyBif93H6bXDb+vyskHJbfp6cWP3AEbcEVlWhg3HAXDdhHEZ5e24UWFevMcRyiNRD8AyuQLRvAMGIcDiZuMpfZT9N5xPJ2RijxIz41dieM7rbJ6u2PrXLj3w90aXTxenWkB2xGFHnWLd187PT2j9K/Ep0H/kEeTLIw=
Received: from MW4PR04CA0336.namprd04.prod.outlook.com (2603:10b6:303:8a::11)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 13:59:38 +0000
Received: from CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::4f) by MW4PR04CA0336.outlook.office365.com
 (2603:10b6:303:8a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22 via Frontend
 Transport; Mon, 22 Aug 2022 13:59:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT089.mail.protection.outlook.com (10.13.175.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Mon, 22 Aug 2022 13:59:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 08:59:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 08:59:09 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Mon, 22 Aug 2022 08:59:05
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/14] drm/amd/display: Change AUX NACK behavior
Date: Mon, 22 Aug 2022 17:57:43 +0800
Message-ID: <20220822095752.3750614-6-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220822095752.3750614-1-Brian.Chang@amd.com>
References: <20220822095752.3750614-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c166127-e200-4049-3060-08da84468d1c
X-MS-TrafficTypeDiagnostic: LV2PR12MB5918:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uiOWNYErON9ZOIX0LP/sF6eGDvgu2tZVn2awvhlPEyinLLHziE/DKacGaw5q/cT88DVgpgUeU9irHg0Pr4+bwQPTaXBqFGMuadboe8VGgum3k6cxAfrUdarVYiRxrzc/zoJLyLQMTMO5CdTjh49B5ngYU5M9/m1eG3kBJLIFVYiphURcjNZGIxUv3jOw/wevp5U7sLlM95dCdUROjvjDT6AgIcrGglTLy8ggD+vo1EZXKysyN8AP7qQpgkRGmkISpLno+Hp2PCuGGLXvpLJLO5Rjj0xDtI3UMmm4ZmCPTXpZiJi56Zrdx0V4qmv3hUcXQwkX2Nm+1L5qMMPJHtZmNyz5S3WFnet7yDobbWj1NC1SLAXB/uJod+dtAaQ8GzxFmXsKUFUyVS0wGYCmP3LtNqTPXCSyI4eQ6EDjg5GnkrdGJ9o+HwV39nxFp+1CdvTiPPlthin0dDezQY0XB5THMtpfSEb9bWj7aOgLixZLWsUHjW2PlICDWtC76LAoHnAdA7yJHf4XkxQ931ymKiT6iCjwrdUogDxQzNGK2qKy/rOYGOfcisnrYkopRRSm01YJrWsF0ePuD1P6WrJLaKFDuhd3NiFJBQ0sdBMBmwjLAsbdwpZHdHgBTcgr0iKYj4pqdsxk9NaCE4K9KtAG1DdaikwcPQaGr4E8AW80ZrXvlssdtOl9rBoiwAH1Hbm76MwxAaK+ch+Iv+0I/7bTNIzFuLugluE93HBP6oROmjqRNjHDENMnGSHishk0Oe1QIoRtseG3LrsVJ7x/zIxWcbl+021YZdh1/4L10pboUsZfEOaCV4jmsqMT87aOypTcpW6mduuQO2q09Tkk3Zbjzt+msQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(396003)(39860400002)(136003)(40470700004)(36840700001)(46966006)(4326008)(8676002)(316002)(6916009)(54906003)(70586007)(70206006)(82310400005)(40480700001)(40460700003)(5660300002)(8936002)(82740400003)(36860700001)(86362001)(36756003)(81166007)(356005)(2906002)(6666004)(41300700001)(7696005)(47076005)(336012)(1076003)(186003)(426003)(83380400001)(26005)(478600001)(2616005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 13:59:37.4483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c166127-e200-4049-3060-08da84468d1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918
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
Cc: stylon.wang@amd.com, Ilya Bakoulin <Ilya.Bakoulin@amd.com>,
 Aric Cyr <Aric.Cyr@amd.com>, Brian Chang <Brian.Chang@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why]
Retrying on receiving a NACK can result in long overall EDID read times
in some cases.

[How]
Retry only on DEFER and return immediately on NACK.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 919c2c2ba84b..32782ef9ef77 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -814,12 +814,6 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 								"dce_aux_transfer_with_retries: AUX_RET_SUCCESS: AUX_TRANSACTION_REPLY_I2C_OVER_AUX_DEFER");
 
 				retry_on_defer = true;
-				fallthrough;
-			case AUX_TRANSACTION_REPLY_I2C_OVER_AUX_NACK:
-				if (*payload->reply == AUX_TRANSACTION_REPLY_I2C_OVER_AUX_NACK)
-					DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
-								LOG_FLAG_I2cAux_DceAux,
-								"dce_aux_transfer_with_retries: AUX_RET_SUCCESS: AUX_TRANSACTION_REPLY_I2C_OVER_AUX_NACK");
 
 				if (aux_defer_retries >= AUX_MIN_DEFER_RETRIES
 						&& defer_time_in_ms >= AUX_MAX_DEFER_TIMEOUT_MS) {
@@ -848,7 +842,11 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 					}
 				}
 				break;
-
+			case AUX_TRANSACTION_REPLY_I2C_OVER_AUX_NACK:
+				DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
+							LOG_FLAG_I2cAux_DceAux,
+							"dce_aux_transfer_with_retries: FAILURE: AUX_TRANSACTION_REPLY_I2C_OVER_AUX_NACK");
+				goto fail;
 			case AUX_TRANSACTION_REPLY_I2C_DEFER:
 				DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
 							LOG_FLAG_I2cAux_DceAux,
-- 
2.25.1

