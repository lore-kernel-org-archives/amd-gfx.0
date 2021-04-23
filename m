Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8162C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DC8F613F5
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC8F613F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 000336EB2E;
	Fri, 23 Apr 2021 02:40:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71ED86EB2D
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 02:40:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEI7+/ktuwo8GAFFWFrxrp2FYnnRI/jWg9VUrnVXtRj0HXq8etHmF1jBP7A7AOWB34hB5u0T2w2BChz9b+w0l6QUCowZiHLNVXWMf0reJP4rQgpYGHWdHLYVNlBgHRVrUr/W6AefybLH4rpRgdoZmXLDIK/0KbtVYPWALToKXFvzokKsdY4YhG8iy1/ep/ZkBNVjNZI+V6e6zwYqkYqv6mrx35ijARRsJeAZtYd6clekXY1JT5bTDMnlfgUJiF2Cc34U21GZXshuBs8j6t8eX6ZMpQcS366x1tWxQ7HlZTuZ76nWSGImPMwIc85LcfpqnGH84glMLx2NYLLWWKwZmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwJhFYgntEm66jtcMNgGoWsdQLXlwvIudF0J7/+98Fc=;
 b=LY7O5VQP53J02zZ3yBqhkPOYkvBenNUblyBKd+c3aJQCxh5aRy8eLZYrC4uXbIg4P6llCit8XgbLIh8RSwiiqvro2xKCDm1ezDzj3hVlJ/pVYNgLfEo6Qbeno+Y+zcZpwBa0vk7PCd3fq5eg0QY/PIjlTllc2+897RSL0XBas0OAQE8QW5ywLNX7we4uyOkAzvNzWGmDcvua2JpXaeHjFGjWuhr2oAYo0Iwpqtr6uK6CFeQwWYUtPHaWtA8agZAbdyKYj5PsOUrJ5FvWubjcrwHV+eI5Zm26zvlaWYKjPJNEUS9Fr3IYrKsR0JI8TnagkkKv+rhNpXr4YbxsMPLcRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwJhFYgntEm66jtcMNgGoWsdQLXlwvIudF0J7/+98Fc=;
 b=FZYieotdXtA3fppIZWuMN0bVCAJSLB4Y0owwevMBRstcBEnq1o7M8XZMQBmyhePA+V7IUBtIzI+YNtZrEps/oBKeawKqXtuKRojxQoP2a5zxdoTNUKuO5MJFmcQrS6Hq9U3bAJYOt/pgPnKDcphZmqHhRNO13WTIc0i8vIGOTUM=
Received: from CO2PR04CA0203.namprd04.prod.outlook.com (2603:10b6:104:5::33)
 by DM5PR1201MB0059.namprd12.prod.outlook.com (2603:10b6:4:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Fri, 23 Apr
 2021 02:40:46 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:5:cafe::3b) by CO2PR04CA0203.outlook.office365.com
 (2603:10b6:104:5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Fri, 23 Apr 2021 02:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 02:40:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 21:40:42 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 22 Apr 2021 21:40:40 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/16] drm/amd/display: avoid to authentication when
 DEVICE_COUNT=0
Date: Fri, 23 Apr 2021 10:37:11 +0800
Message-ID: <20210423023714.22044-14-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423023714.22044-1-Wayne.Lin@amd.com>
References: <20210423023714.22044-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43acf03d-2096-46fb-bb27-08d9060132b4
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0059:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0059869065AEE79C1C7F1C3EFC459@DM5PR1201MB0059.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OWEshqRCg7qfBtBptHekYT6C4aTEim/bYJVBAwBbmwByTVQ7nJVNmABu22YNoIouEfyRY2Lcu6XmBmIM85A1mXV1vWs6npzKpyryGDkKs20GxSsZzZ6UiMR4XVrKrj4cmFs1PTRz8dH0NnoeAVXVEHBWX/RyFa056JJdAQgDek13k927z/5zix1gv8FrXR9GeRdkzczMvwBLrBzQO+wj+9sXQmb6S3TmoNPtcUyGR4e+KNllt86pHwteNtOF7cPCXTWLyfn/QgINIsZdwRTB9MHZUinOzXr9UAsIHozhB4zkpPXiylZ/U05tOI6rS7AO3uoTmRGjMDHYsFsP83wVY1g2eZ5noggASrLKVTl/A8082KnTZvnGaVYKFbg/49xT6ka/s9xI+ZtsEPQ6touIOeHeMJfF799yrE3GZeampKDnjdV7JDS8UNRSlzmlD14fgSn0gGmhx5eS33eNB6wk2DQbaVcuwwz1VAwkYPINoAVhqA+eN+qzEP1cP0DUHrD/aAddHp2pvSSE6vZhuFMoxpwlu5xHuxH/Tlo5yIE86aVBWpNqkprgsxdUWz6g4FdjQJz4k1Rs4GY7aqO0IZ0rU1VmIIL0bKlHUZTCRtL65nMr4ag7WzZUnGHtxfC2imRnd1o94w5L9jkuWSgjwZtescoKjiIKbc9daEtrAfkYybKSJ6G45F69e4EdUaazScxv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(46966006)(36840700001)(86362001)(336012)(316002)(36860700001)(36756003)(5660300002)(6916009)(70206006)(82310400003)(8936002)(1076003)(26005)(478600001)(47076005)(4326008)(81166007)(82740400003)(7696005)(70586007)(426003)(2906002)(54906003)(83380400001)(2616005)(6666004)(356005)(186003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 02:40:46.3515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43acf03d-2096-46fb-bb27-08d9060132b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0059
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
Cc: Eryk.Brol@amd.com, Yu-ting Shen <Yu-ting.Shen@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yu-ting Shen <Yu-ting.Shen@amd.com>

[why]
we don't support authentication with DEVICE_COUNT=0

[how]
check value DEVICE_COUNT before doing authentication

Signed-off-by: Yu-ting Shen <Yu-ting.Shen@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Wayne Lin <waynelin@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c | 5 +++++
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
index 2cbd931363bd..43e6f8b17e79 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
@@ -128,6 +128,11 @@ static inline uint8_t get_device_count(struct mod_hdcp *hdcp)
 
 static inline enum mod_hdcp_status check_device_count(struct mod_hdcp *hdcp)
 {
+	/* Avoid device count == 0 to do authentication */
+	if (0 == get_device_count(hdcp)) {
+		return MOD_HDCP_STATUS_HDCP1_DEVICE_COUNT_MISMATCH_FAILURE;
+	}
+
 	/* Some MST display may choose to report the internal panel as an HDCP RX.
 	 * To update this condition with 1(because the immediate repeater's internal
 	 * panel is possibly not included in DEVICE_COUNT) + get_device_count(hdcp).
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
index c1331facdcb4..117c6b45f718 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
@@ -207,6 +207,11 @@ static inline uint8_t get_device_count(struct mod_hdcp *hdcp)
 
 static enum mod_hdcp_status check_device_count(struct mod_hdcp *hdcp)
 {
+	/* Avoid device count == 0 to do authentication */
+	if (0 == get_device_count(hdcp)) {
+		return MOD_HDCP_STATUS_HDCP1_DEVICE_COUNT_MISMATCH_FAILURE;
+	}
+
 	/* Some MST display may choose to report the internal panel as an HDCP RX.   */
 	/* To update this condition with 1(because the immediate repeater's internal */
 	/* panel is possibly not included in DEVICE_COUNT) + get_device_count(hdcp). */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
