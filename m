Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FF5C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143C6610FD
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 143C6610FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1A8D6E20C;
	Fri, 24 Sep 2021 19:10:24 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A33E6E20C
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 19:10:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GALGcNhkNg+q50tih9fU2G/05rclcRgW3uOtHPnZ51lYb/M8Py82aDQitWGq6oym0GgmNUda4c4o1HvzpXIj4AAxXXCiT0m4Ie+AF4C75nVOeh02JIjj2f2K1YTsO1vPJlz0HJqpAWgO9rNt5gy5BCDhgzimp0EsDptZyIErkRUkM7sE6cHUxLTxO87aUcwsLeu8+zFyZbtA0WPNGMDCDJ/mRm4/9naCDbymoO2Lx6zmslWdRZ9FU8gwrMpPEBAVks/K7a1ltaS5UX6bAj4WT7NuGG09ONSg0mkAiMmP99IlUG4NLxmCTGbtiWPmos34/kzKaQJt8cJlaWCQi6kMNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=7lTGR6q8ObXbmRu2DsndGH2tYtsPQS+aqCjLVx9mOIg=;
 b=obF73p57+/FuzGUUWlggliAqG7r6zvaNIYLC42sLZPQ7wtw17PGnfSarAAh3qinMF0dQnm60podJwiypbqGOLEFb9H2/V7DQceSfT6xECOyr1VYc0ZhzAnZyZTL3mHbVvp01UlD1GwfJSAPqNAoi/+LYOUKnTip3hAcUChYVgiR7AvhQn/Vs25OEVBQo9TADOltmKhxPIVmaQXDJy6PbE1euiJb6FrfU28IfVdRat2NSiT5ala/FDYaa+SEOjLupSCFkqks6QtmPHAES2sxc95PcrvENoriUfQKc+o0Z6q0aGZFhj3th8b/b7PgOlrnIfPBYT8PyZo5ieuMyk5RQlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lTGR6q8ObXbmRu2DsndGH2tYtsPQS+aqCjLVx9mOIg=;
 b=xHoJ5uunvykxvCOI48RZ4PJqHCnpaNLx3w1qSE9G7XQIIMk48s+8rO6JwCHeKclG/4jyAFl5K5Ay2KI5U/bmTo5Y65oM35hG3RXKwocGUEVjfTRSvySdnzvb+5TaQ8nCdLev8jdhF/hTEuO3DznDN/8DxjQf6aCSND4jBOHV42A=
Received: from BN9PR03CA0927.namprd03.prod.outlook.com (2603:10b6:408:107::32)
 by BYAPR12MB3542.namprd12.prod.outlook.com (2603:10b6:a03:135::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Fri, 24 Sep
 2021 19:10:19 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::41) by BN9PR03CA0927.outlook.office365.com
 (2603:10b6:408:107::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Fri, 24 Sep 2021 19:10:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 19:10:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 14:10:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 14:10:17 -0500
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Fri, 24 Sep 2021 14:10:15 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Anthony Koo
 <Anthony.Koo@amd.com>
Subject: [PATCH 16/24] drm/amd/display: [FW Promotion] Release 0.0.86
Date: Fri, 24 Sep 2021 15:09:26 -0400
Message-ID: <20210924190934.1193379-17-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924190934.1193379-1-Anson.Jacob@amd.com>
References: <20210924190934.1193379-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83e8f8d6-cb1c-4b44-04e2-08d97f8ef2ee
X-MS-TrafficTypeDiagnostic: BYAPR12MB3542:
X-Microsoft-Antispam-PRVS: <BYAPR12MB354263461B593EEB308205ADEBA49@BYAPR12MB3542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1xj8EIcK1JPktS7FquruI+WDjIBGY8SDSd2p7oXaVWTZ94j1WBdsFPSo6WczMdT5BttKA5KFInJK6lRPIV1H3JP//mgMjf3aBXNiXLhZmadvs7Mmjlu8LDyHd6c2AVAXJzd3PW+cxHs9gXjQK4Xl0pRAMbw+4QpoTd42AMnoOakbrgyE31VSIfpJNi5Gjw+adRtUUfh/qgbX4St8QfVBv59UDPROznAHOMXEwwRBb+FgwA5w3RMXKF9Ol2LDvHwemP2D+4EDUouO+68JRHhHm2eYpceSxEXA9T9yty713eDUiP9Yl+gtxg49Z0IuEa1gBL18yLd8MonNsS8z22LXLqtr0fLdQWL9v2/ajHZfCvaU9lILgGCuvJ2BnBIKW9nSXMDGIIaY66QmZX1CXXNZfMwSRm1HUtDDiDDwErw37cD5q/KLy3S5OuIBlMm7fF3kJ/mYfne3EmJxDGP+Q3A63zP+r4quJpgiAbSOn00WhE1LVbO9gGXHvMUxmewmKWL61vrj5XChvv6cOOq4EcuD9nEYS78dXJgaNBVT13LR0oY8p4m0sk/+kO6agcPw5ncTQlDdzAqD3uC5gQO4bP6ft2L1KWZAmyz1uPNzD7D85iI2eOEJ/rQsnYLnZXXiL5h3QesL1n8rRK+lA1Jf206EKJv3KGJyQHYKQME5cvuCgEwZuSaSEmgPNvl5X9eSVje1QxfZTqrxZro+Gs4KBUwbqJ1bmW9fzXdE4Pq4Jw4WkWM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2616005)(86362001)(70206006)(4326008)(316002)(336012)(70586007)(36860700001)(54906003)(8936002)(8676002)(356005)(2906002)(83380400001)(5660300002)(81166007)(426003)(36756003)(508600001)(186003)(7696005)(4744005)(1076003)(26005)(6916009)(82310400003)(47076005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 19:10:18.6984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e8f8d6-cb1c-4b44-04e2-08d97f8ef2ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3542
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

From: Anthony Koo <Anthony.Koo@amd.com>

Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 4a41549109dd..f5974562aa23 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xeb0940cc
+#define DMUB_FW_VERSION_GIT_HASH 0x42c0e74b
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 85
+#define DMUB_FW_VERSION_REVISION 86
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

