Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BA7C47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E933C60FDA
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E933C60FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACD646E93A;
	Mon,  7 Jun 2021 16:48:47 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2049.outbound.protection.outlook.com [40.107.100.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1C846E941
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:48:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqjJr5/8/C3VQEq/CrO9d+xgnxRu6yn9MCcbIII1kaaQCqbuBqo+NhoTmY4MWfZ1xTqNVTogrG/Ajtu/T5g8woY2sL3MpeoXXThD8+WHJBoCZ/lIvsnL/5MJS1X8hxh7o90dFdsP49/l9YVn7zq7hI4JxSkLMX6VRz95fLW+IJSZ7rwOJe8kmYLG7KbloK42+es92MkWJ91HY+ByjfbBenHJEisJIdAFiiIlxe8IsoGs0mcfw1fG+RuiUC2W6v41JOXFXEGE0RXXFxCJFmttZhnLNFaNGesLonkCDvGTOiN40fKfK7zEaSjAt3K1qrXpWq3UMYn2GdmaZooMlA0G/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vo2tA6vo5mJ/5HBzen3vOCCek1w9VsbTPcKUqJqKVuY=;
 b=b8KhTyetVbonyGiU2gmU2UIeS1C44niUqhVNzUHQJG7E04XiawJ54yW3cDBpegqdo+kGP2esVl4tsEDDskGmq6QMjmONRB05LiNQKTnUuFy+3VkuNpZHt99/ou2Zl3o4/4I5Psxs6WjMbxVjPgXbahrF5B6+qELQo9dDoD+KCzcxS36GRlbgS19kx7Pub5Uq5xd/ExbNVYmfXtEXGMiuH2zy1y7z3PSVcjaewHc1zpPP4JF4I6CnsVEm3p5+j/sPeJ6VxQ99y4EPV4A9cgFoNKW/aNuE9TRQ/ZEDN103gpx4Rjgi9fkc8Id1Ya+ZO4S6aj5IIwXzShX6U7cO/iGS5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vo2tA6vo5mJ/5HBzen3vOCCek1w9VsbTPcKUqJqKVuY=;
 b=oDZoyALML0aycTYl9lVHwXKp+/1VncBNkBWMa0pSBMyeAfAogCWhQwjc58z6djd7XLXwyqIIUs/p5RSbPuKe/NhFw9WK2mEi8o+SKZqGsAiZxv5uxYGrFGsGra+s5OyyXpY6hRZFz4rvkoDuRb7hOvzTZViYAxxSZifFrvCFsf8=
Received: from BN9PR03CA0216.namprd03.prod.outlook.com (2603:10b6:408:f8::11)
 by DM6PR12MB3882.namprd12.prod.outlook.com (2603:10b6:5:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.26; Mon, 7 Jun
 2021 16:48:43 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::8) by BN9PR03CA0216.outlook.office365.com
 (2603:10b6:408:f8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23 via Frontend
 Transport; Mon, 7 Jun 2021 16:48:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:48:43 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 11:48:40 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/30] drm/amd/display: [FW Promotion] Release 0.0.68
Date: Tue, 8 Jun 2021 00:47:01 +0800
Message-ID: <20210607164714.311325-18-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607164714.311325-1-stylon.wang@amd.com>
References: <20210607164714.311325-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5488b466-8a2e-4862-ecde-08d929d41c6e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3882:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3882CA42C5625449D468324AFF389@DM6PR12MB3882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fAYmlvsn0gyuZVPism+4C3iqd3PFzy5DqAbop2hUC6zF3p7UWzYW3o96Lg/l5wsIve2fmVDjJiVo0TkNR2U4+yT1c0vz/LgL/KTCdt8F0ayELCrIq7tahkS+uV40+ApG7vLNpq9K07LDKV/NLlMTXrdaCWJCIXh1DJecVq11LpGxC6p81s5Obj2C2NnL4bDxICJVdomNuuX0j7Z/L1kGHXWfp+8ypGWowElboixMvPrkQ7uTK0TSsk1wI6A4bqHxIOPAejUZk/m6qVDCMGs4Df1Iv/ye8sL1vV8JjYbxTy655m5+Mr6Wsx0no0CR7AqVJGpYnZAKuqajmve75GqgsWir7HbvR6TwLYlUIJYo9utYE0EWXWpqkDk4Me6pcag1Yiwat/xqTG/UD3nQFhoEC2eiT46Z056e6AGcIEhPAvawONldtRYnMhALQweLQJq+ndMWBGDwZLyqZCZT7wS0vwegqw1J5RfYU6DYVcGQRcyQfQDg6+b0IbWETqftj1C3JEIUepYgYwDH4Zcj+FNSvsk9+ReuhsmeqsL8UXmiHnQZBOk0msNKsVNoldVyxPa8GplPkWho6R7R6k5xx9U+rWKul13YPwg8FOA4skBXG9PmjI1S4McHDcK3xvKdFm6O+hhXop2H192hrhygNoR6/bBp4pG96Ml0PaC+7DGwqbMQvNkPTa/SVwGezeW06x//
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39850400004)(346002)(136003)(396003)(376002)(36840700001)(46966006)(47076005)(478600001)(8936002)(36860700001)(356005)(426003)(2616005)(36756003)(6666004)(8676002)(82310400003)(4326008)(82740400003)(2906002)(5660300002)(6916009)(86362001)(83380400001)(44832011)(70206006)(54906003)(1076003)(186003)(7696005)(16526019)(26005)(70586007)(81166007)(316002)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:48:43.6043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5488b466-8a2e-4862-ecde-08d929d41c6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3882
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
Cc: Stylon Wang <stylon.wang@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 6eae16c27b1d..7c95d6eb930a 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x992f4893d
+#define DMUB_FW_VERSION_GIT_HASH 0xeb3203315
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 66
+#define DMUB_FW_VERSION_REVISION 68
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
@@ -117,8 +117,6 @@
 /* Maximum number of planes on any ASIC. */
 #define DMUB_MAX_PLANES 6
 
-#define DMUB_MAX_SUBVP_STREAMS 2
-
 /* Trace buffer offset for entry */
 #define TRACE_BUFFER_ENTRY_OFFSET  16
 
@@ -1355,7 +1353,7 @@ struct dmub_cmd_psr_set_level_data {
 	 * 16-bit value dicated by driver that will enable/disable different functionality.
 	 */
 	uint16_t psr_level;
-	/**
+		/**
 	 * PSR control version.
 	 */
 	uint8_t cmd_version;
@@ -1552,7 +1550,6 @@ enum hw_lock_client {
 	 * Driver is the client of HW Lock Manager.
 	 */
 	HW_LOCK_CLIENT_DRIVER = 0,
-	HW_LOCK_CLIENT_SUBVP = 3,
 	/**
 	 * Invalid client.
 	 */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
