Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AD9C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72774604E9
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 72774604E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E6E66EE77;
	Fri, 17 Sep 2021 19:25:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B0E46EE76
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 19:25:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q79JVNR6deM4kRcom5hxCmDxotRgp/ee2m5LjQorbfqUDSeXkmo/+dky4cryZJNxn3VqsMR9coydBGIHN4Fxyafk3zDpwnHAmyH4mUhSeP+E18TJXi34/KyTtNA3R5+23NYulaORbPSzt7svi5m5A9nJI8hIGdM8/5iSrqgGxTJacEtV9xzc4iZeE1S+cBR0un0sXWwF+jt0B412WvrNEK3TKSgXyqCVf1XvtBYf1fW9AIxktqlvdMUoehMnjcPfHdpewZCA1x1gUwKD3HsB6ek82prvkl/4R6ufw70dw8hAg47RDqVvrP6u/l9uhjMUJ2Dvbnn0ZuVGgxm5K7LMtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ZLjmmIODfDlyEwhBGU2tutb34MUO8/t1aqmLrvJ8oaE=;
 b=M7yyIeb3r+XA1goYnVIAa5rmIKWh50QppD354r0+Q2DkqzQ8A4FaT+CSfLN3ysvCPdxO2AK1FwKJJNoNVkxbQ9MjrRqX4f1mHHxf90pyMm0kM+8MI/GrHJerCYr0IlA35XDw0/W0aNat/+qg0dAUjzjxlrwsYd6i0F48TFzkHgoU5pKOto6evuv9NDj8hSkvSk7MxymLkIVFU6mlWzWgeNQ49/zLMRDThG43YwryzOongpAmu/sP3NEwNSXINH0Ne74J7a5QdIhGJc1/NLgXHr5SvLnd8NA3tPBE3cyrab6MaWd5FVGcHUIA+Kt/7RIQh9L81PGtP7x+F4+wYJbX6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLjmmIODfDlyEwhBGU2tutb34MUO8/t1aqmLrvJ8oaE=;
 b=tMIi5E/sL9a2eZQEJbXDTNDZZsAmApRTyrZTJiofFf8yXMB25Ppj3a63uhi4hKJC1N0jLsXEK9leHfy8g7BvJ0Jx4KFB936qE73bp5StHnj+ZEV42Z6NhwEKYcW6vkOc0lPAgaFRfpAsDVEX19DCik48x121Nj7MV2fUm/TkPnI=
Received: from BN9PR03CA0920.namprd03.prod.outlook.com (2603:10b6:408:107::25)
 by CH2PR12MB3656.namprd12.prod.outlook.com (2603:10b6:610:15::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 19:25:48 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::bf) by BN9PR03CA0920.outlook.office365.com
 (2603:10b6:408:107::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 19:25:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 19:25:47 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 17 Sep
 2021 14:25:46 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Anthony Koo
 <Anthony.Koo@amd.com>
Subject: [PATCH 02/18] drm/amd/display: [FW Promotion] Release 0.0.83
Date: Fri, 17 Sep 2021 15:25:08 -0400
Message-ID: <20210917192524.3020276-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
References: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e68f86a-4e73-44a9-474f-08d97a10f3ee
X-MS-TrafficTypeDiagnostic: CH2PR12MB3656:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3656BA7A7397C9442400E25A98DD9@CH2PR12MB3656.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XGQ64rpuA3IJUuOzUlyd9aiEfpgcClCoPAmCQjl8AUN87t4ZCUiUadOl99MjkUitbY3ffBhD7nhWzGvUXwxRDsEOvervaFLj5XTKrqSRlEciAl7o1pzxdmQyyoISQspG1yjx6t2DtlKpvsCJpTcuMSoyx0zzMIvAfiaGwxiRarxgghjQBm+0qvLGLPFZxSCNlhWqx37S4DZmarjUN3sE6r+E24I7dNPNT7RgUFHoWou9ItF6wqDrpGkvVncHWHl3YMdChIVJNYNpBY8sClLKZXcLMYzhWX4tXR5Z83u8VFpOyFwXsxGCONiR+ZHXaycY1KDaCt8bt9T5h+cGWrRsZVCa7OSvn/vLqWMt7DUwj1u8eWno1pBYBPf1lRGJpvLI+s0ACInX+tBdXhJNtyyyEr++MfoC7VvADnJtjda1KcDrRT8hFFNXONc5D4Rfi3PfROLDbOsinWx3iAIJV6E17GuCKi+18x9SnFYeDPKn4IddgQs5J1zbfNcfe7bHw6DslCHRgVaZd530TaDBbVDYH6HHvcUAqo90I/bHTfH1+tgSujyj6gLYSw5tX/9GCvsdJa/+eYdItJxPU92qaou8kAmKfMUW9Z9+tbElZ3nRPPVhxdmxRFhoWNa9ah1rkgyl6+mXpy4jj4TTf6ZtKDUThvU3iDKvnzJjfCEjtBFWh5bPykYB9gUbuNL1NQqgzS3+ZwggjJ/OIpKHxNfHNQbgG0ksVxzKgUtIUSKiqHv9LW8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(36840700001)(46966006)(6666004)(82740400003)(2906002)(4326008)(1076003)(54906003)(82310400003)(8936002)(8676002)(478600001)(426003)(186003)(16526019)(2616005)(336012)(36860700001)(26005)(316002)(86362001)(36756003)(81166007)(83380400001)(47076005)(356005)(6916009)(4744005)(5660300002)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 19:25:47.9746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e68f86a-4e73-44a9-474f-08d97a10f3ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3656
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

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 2c4ec3cac70e..1edc5bb4d668 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x3f002dea8
+#define DMUB_FW_VERSION_GIT_HASH 0xb24cbe3d
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 82
+#define DMUB_FW_VERSION_REVISION 83
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

