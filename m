Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BA9C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CE6360724
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1CE6360724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74A786E1F6;
	Wed,  8 Sep 2021 14:55:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DA7F6E1F4
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 14:55:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpza+b+1O9H2ol5qSKqY1glczPtx73y1WiQM2cksG3zzvfT+99nMqjf3UYK93juBwBa2TQQkSg22Nw51qKom3t9G6o5hTESS5eWlguZBp7j1CAUcGnp6zSgsxoAKbYDHB+nKr0DsTounXSbALUq25dsQoixIm0OXs41Clify8wN1U169ICcFz1ps/crMPRYiXSc0RHLOR35aHoWZOb9mEQEAca/yixNXEZM/xLJ8kA4tFOuXtdBUZzE1l1tFKavfJxdGGLwOm/1A/GMAHh8PRmkvYFqzDvjYa5pTf9UpJsF4emcopsyePIBFTlAMmUcJj02VOLZVQPUd2G/d8df5zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=L364K4El2yfK8xh1ZHOWCS7x4Q/3l8/cXH4Ym8p06q4=;
 b=OC5js58OCJy3+DRRwpjt59DRJtW+nV9cdGKNa82+f2e/eXRx4IlcPL3E3eZgXZfDu8TvulMsdwmkZOBEW90nKjmkZ+xiLit0iIezs/9O4MN+Yi5TTuhjbZDGMERpyOTr3wnd77qjx71vEQZrtcHPygUk1H9E55jqvEqI0c++P/zktmOFzMh288+XIui7qty7ncE5dhIAA3kEYJin4oLalzOGwPUD+//3/859Lf7jAZd3MkrKsKSJ7JY+W5VUUnNvNznZJcOM9wTZSxphY+Mik+PHJ3ZN1G7An34Kcv9uhgZ8PFzUZEUeBnbzhGqkv2yPR2n4SOPuvzrhu0VfFRajSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L364K4El2yfK8xh1ZHOWCS7x4Q/3l8/cXH4Ym8p06q4=;
 b=QM9jU3LSJGxB2MWNbtu3AQznyVjnZYMTslyC06EFIafDH5Lni0rVfFM/FpX3UMl0khJW4nQtMFhXsEOcwtEqiNu1PMWW2uPonf3fYY/d933OxezfRM7w8aueF+ep7mxP6WHhhX6qA/aVd1O70Z3vLVa38bCVM/r0wI+k6gUGkHY=
Received: from DM6PR13CA0014.namprd13.prod.outlook.com (2603:10b6:5:bc::27) by
 CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.22; Wed, 8 Sep 2021 14:55:06 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::df) by DM6PR13CA0014.outlook.office365.com
 (2603:10b6:5:bc::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend
 Transport; Wed, 8 Sep 2021 14:55:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:55:06 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 09:55:04 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Anthony Koo
 <Anthony.Koo@amd.com>
Subject: [PATCH 25/33] drm/amd/display: [FW Promotion] Release 0.0.82
Date: Wed, 8 Sep 2021 10:54:16 -0400
Message-ID: <20210908145424.3311-26-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908145424.3311-1-mikita.lipski@amd.com>
References: <20210908145424.3311-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b429bb7a-d80d-40fc-22dd-08d972d8a585
X-MS-TrafficTypeDiagnostic: CH2PR12MB4149:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4149081FB255D273E7517FE4E4D49@CH2PR12MB4149.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /n73ue8faVB6HfLJqHXLaduxGKHro1y6COQ9quq0tNnyepsLvqC2emIXm+q5vaikDXpVT/ILE6cXt/MDxff6VDCaWlmJXiDOpbnMnrMkBcWUAAnAS9HyCiqqnzIsJL6jkdvK7N57tGWC8G9Ym3LlfLyqeG+lTx7imSaMS2mO9BmmnCK5MrOmWL+X1ZUXgZyVkfOGkTUrsNrVQMTOTO0lysthpS4fKJd1pyIcV2MAAjqW4Hv/jas7NJSr5zlkM9pNsAl6xOEZWT/nVxDOkN+0aGcwvepSnHlAwbZf73oShKha77Hzl9RigOkZIGn+NzoMOntvCRopqDrmsymvYXLoBBQ0A77zu5RsQqQcBUdwQSxVqeN/6FY1v6ICIHCeUSRo0m1zd0KG4KTYbeRH8oFSZ4aTpcipWjPznptc9fAP4Ow1Dc2KJL37OvoTWvw1NybWQ0i5YMvWxfk7/Xlq+u6YMB72xymkxOBS7SH8a9NCn1axQqkIdLsbJoxdnoc52awL+E1pfbV+gy2/WFCtjGsU6uc1/2e3ukiqcnpvfzYCnPwFjqKnDcpgf2L3acJ6UFs5jqsz7EW+dIYIrFwBWxxDKG9fsJMyymor/Tiz6MC1X6prxPhdlFV9+vS7FB3oF8ElLPNZOLfpTVxyAuXOcDNscH/agPkIWxK9etyzhjVackFE8JxIw58+1pef/jXFbD3HBxsp2RuLvi/PdMOwg5/7XTCDciuCTX05JPuTDB89a3Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(46966006)(36840700001)(2906002)(36860700001)(186003)(83380400001)(6916009)(47076005)(54906003)(336012)(1076003)(81166007)(82310400003)(16526019)(5660300002)(426003)(356005)(316002)(6666004)(2616005)(478600001)(82740400003)(86362001)(70206006)(44832011)(36756003)(4326008)(8936002)(70586007)(8676002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:55:06.4134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b429bb7a-d80d-40fc-22dd-08d972d8a585
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149
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

* PSR SMU optimizations
* MST dock fixes

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 8cf86f7cda41..2c4ec3cac70e 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x8ebc06e16
+#define DMUB_FW_VERSION_GIT_HASH 0x3f002dea8
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 81
+#define DMUB_FW_VERSION_REVISION 82
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

