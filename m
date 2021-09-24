Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07A9C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:09:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 785FD610FD
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 785FD610FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D7B56E20A;
	Fri, 24 Sep 2021 19:09:53 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2075.outbound.protection.outlook.com [40.107.95.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB7C36E20A
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 19:09:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XD+vUrl0oR7YtVzQi87bnxa81/BuCL81VEjwQsI08u6DQeWq/i5jC1LnH/SgyXfgfPpa1Wyjry5SCYEJh/6xF8MZM/1Aku9jF2PBupXltwvSluaYRgxNzNRvkLe2uRFOojtqelzg/df5j67FCTnLrqrlnW3JSOquKirLN43JtJvygArBpqCMC27Zn/JzwD+SLoTnrMe3aBKIFgKHq/I1UlLRzMRqaqfXjuTmRjr1N9YqQcH7gNyehlO8Dc+hB/NkrHpND2yHBPHUJmUNTHSoEeVgioCAgGOCejIqXbbe3nzJOHy46bD5foKknAH+cQFELWLVEHjGAVPbBBSdfEIAtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=nGPP4wnDYl6DskzQmxLqIyzTdYgfEBHvLxcEuG2v0cE=;
 b=U0kQXUmm9tseJsv3m5WUqIfe356PBfv38wQqWkntIiEHsA8Tc+2jLBIq3sIOqrIxbAHhL2QFf4GbVIqAQpypx+bwTNx1Kee92hJtghSBsbSl+APZPUxY4QO9kx25AcNxnXs4EQ17d1UB5wo+D06BUmwb4G3estxqkOcfsjdL9U96cXxQxFujbMXqpV1669B7X882r0D9M1Limsp78cqGLPAuCyUGRQx3yin3yIeSnNtpUICekm06et29AxmONRBhn7WwJbxm0O6tsDpLIVp/wIxy26ElWbzyQrTMalKIewiCABLDXZ7mkUTeMqX8C+Zy/kl5+wTNWnMEqKe+H3Tu3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGPP4wnDYl6DskzQmxLqIyzTdYgfEBHvLxcEuG2v0cE=;
 b=jqQYTfQROIpKv4vEP95/DeMDDGqoeqyVCUO/xewx+ven1N6oGru8ekvYbE3/nJ+sZtRIVQOltLba/gGfbjO/9kibb54pufhV9KcLcXrEGbvbFInmjf2MEVquumb38hzbi7MTEIekq6DLjznuRzf/uKdkMK3fdzMdy9fe10eqdY8=
Received: from BN9PR03CA0623.namprd03.prod.outlook.com (2603:10b6:408:106::28)
 by DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 19:09:50 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::49) by BN9PR03CA0623.outlook.office365.com
 (2603:10b6:408:106::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Fri, 24 Sep 2021 19:09:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 19:09:49 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 14:09:48 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 12:09:48 -0700
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Fri, 24 Sep 2021 14:09:46 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Anthony Koo
 <Anthony.Koo@amd.com>
Subject: [PATCH 02/24] drm/amd/display: [FW Promotion] Release 0.0.85
Date: Fri, 24 Sep 2021 15:09:12 -0400
Message-ID: <20210924190934.1193379-3-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924190934.1193379-1-Anson.Jacob@amd.com>
References: <20210924190934.1193379-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 431768d3-700b-4a95-beab-08d97f8ee1a2
X-MS-TrafficTypeDiagnostic: DM4PR12MB5165:
X-Microsoft-Antispam-PRVS: <DM4PR12MB516524650BBB62248E937FE2EBA49@DM4PR12MB5165.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9qQ/FOW4f/lfHdu5xZf06x6wuErgebl/wXb5WuDfoX0jk2SAQZk/DA7nCAs7zoNXHmPChsVrPvB+rRaM08NAIdIVtkSzJZj5hanNDo7WzsHv3U/l9e4HZXZ/s6f7dR9fp3AAiPdruybXX4oUnptPmN8K+14GsHPCg5Wu1Lq5rGlo1AJm3TRFmb0aeMchOoQk/OPlrIOU7Cn89dzBvFPH2jWH7jQdr3X7Hgxv4jCFsqums/4wTeqkd18Db6QudIHKEmfJQAR3KFSl/zRI2bWJmGSSOpR1bPrXXei1f8++LkI7ZMyOwpey663dslv4EcyGqHg8Fq58SUkZP5vJmkwtGc6QA908nqZ0LZzZlTAJr6d9gpnoagt10PJ7ptO7D1ydr/FI+Tl1EDHoKHpxwDdowuZRkAXMzSsCZh6HLq24TLudZQM3nvpW07mflZooP0GKctZoSz82hSQunbS9Jkv7pfMlcM9Ywju63iUp55xMdFDq43Tu53cDrWSoOqnX+WyjcRA8zh0iYNszQFQaOqJ+dO1faijh9Tkj5dd1wv0AjGDz6tWBKfttTkIyUT0pF6d6NP2OQLsA0zTK6fXW6IFSUtk4IHm7kUXyBETGQgffAkKVMkIvX12ANiVrD+ofnw0zUXhRV2XMpyQX8g/0Bo9Y+hDEOcK5l6aq31+IoIOhlag3YbST6lntRvzWQ5QEKUPlym345mvocMUgU0v1CdGKNu2kL/foYLVvvsmWn/7uyBE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(508600001)(70206006)(6916009)(7696005)(356005)(6666004)(82310400003)(83380400001)(26005)(54906003)(70586007)(8936002)(81166007)(8676002)(4326008)(86362001)(316002)(2616005)(5660300002)(4744005)(1076003)(47076005)(426003)(2906002)(336012)(36860700001)(36756003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 19:09:49.6828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 431768d3-700b-4a95-beab-08d97f8ee1a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5165
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
index 359f091e37f1..03110f59b50d 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x607c9623
+#define DMUB_FW_VERSION_GIT_HASH 0xeb0940cc
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 84
+#define DMUB_FW_VERSION_REVISION 85
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

