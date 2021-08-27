Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22023C4320A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9A5760E93
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D9A5760E93
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F15F6E9D9;
	Fri, 27 Aug 2021 20:45:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D61F6E9D9
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 20:45:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/XhKbJAfol0n+eThX7Wtlaq7Z8e/haMHATHDOPKeqsLT2m0y3x7kuBXyIcOEFn7oNpq1njf3Ja8RMkPb3yGK/XIxf+utFmIW2ffB/KgjuWLYLp51NS73APL4aNul/QcomWlkcYS0EYMdlpMw/+PdOz/k21uJD2C+zsS91LpPWiWwUISU1CxtABaeBnJdgWkFtYVkUeef0V2K/oA+ed849z1H7CNxYaBDuGrHLWgM9rOcvXiicIojZosMmX6qvAfQEidIa8bS0faG8gGsGVbSiA1qmKp4zH8UvvNnOM2An9+sreVs3/Lqt1b9EVOnlPurUyFa3bPmdLFvGBXMhcaBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VzdnYSC9J70fTyIWrzcIA8t6CYpC+1097xq/PmDWpg=;
 b=aoaQmuk+Y8s0+zf5yRW2Zaz2MhuZvWXBQj1Th9LiD67l5qOfLmo8jt31Vlt64bT8YoIzMw1ezEnvTlGCE2aPkPZ2z0OHRUtiTOhRhqKuAcxV+sbM4HVBbmZZd16EX07H/hNscHYDz8FjTBW6YW5BQmuPml3JkY68wYblyY1qhzPCFEoXCVghmoSn37idQEwv+x7i5p2XQRWnrSWKF0FJGoQhTDaapm6exO9Vwam8VP9RH6ECefvFtvr+hFtnhhITh1wg0u9UJTas0h3LLDBjlpHvnkc50YdXU2ywlXVzG8/NXWHUDOWeP5KUtNSgav1a6DrO9oYRViERdO4xN2gNpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VzdnYSC9J70fTyIWrzcIA8t6CYpC+1097xq/PmDWpg=;
 b=IDjAlZTGRWd1scskOujUwzUvzT+BWIexrT/Va1T5wZbJ4wqkrxEHTzrk+LWMGa6LfMPqrMnQCMNdekk3hzG96yEa0kaRvkwfbGVm9ytOL+GVc40TYThQboFRHtBc3FfskX8Md2x5bnOViQ6MBidhHC2+iJgdAqK+VIDA5DroTlk=
Received: from MWHPR15CA0070.namprd15.prod.outlook.com (2603:10b6:301:4c::32)
 by BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Fri, 27 Aug
 2021 20:29:45 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4c:cafe::85) by MWHPR15CA0070.outlook.office365.com
 (2603:10b6:301:4c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend
 Transport; Fri, 27 Aug 2021 20:29:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 20:29:44 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 27 Aug 2021 15:29:43 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <Anson.Jacob@amd.com>
Subject: [PATCH 18/19] drm/amd/display: Revert "Directly retrain link from
 debugfs"
Date: Fri, 27 Aug 2021 16:29:09 -0400
Message-ID: <20210827202910.20864-19-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210827202910.20864-1-mikita.lipski@amd.com>
References: <20210827202910.20864-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe0d59f2-12a0-497b-fc07-08d969996846
X-MS-TrafficTypeDiagnostic: BL1PR12MB5125:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5125548E4E5DE591DCF4BCDFE4C89@BL1PR12MB5125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:151;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8N4H9kh6TK87Um/hV34spT3PBqZelO+h/vKfcz7Y4gnISsMDpPZTRGkNXLmZL+BebayBGWJEJsBBF0k9iao5lxhSTtwz1ly8UuASSheqTTt0HDt9oOwOd5udqBxtbOzNG1Au5/piTUtdrrQNugALHz16WL6nr1euV/6nkvxSv1ivj7dLAAasOaHSJza6AStSMbwgK7oomrVNQz3lqaE1eSbtFwJvf0QY+mVe/xocp03TE4mN1PifVQtRE5cm4e8gmDH8tYFsFzscUam/Qvu6wqXqaQgk4DeGufUqcmfGTuFjtWMSXldF85rumGnbclibSPKpp8voZHrhBH6H2AycLmyfjzsuDdIVpx/g6EKtahhKBrzph96HlYpIoTKZuTLsnynPnbckLHoedlq5aUH+yJcWOu6KLrroqvKvk12ji4AGRjwMGcxV9d7IJI5ckKuNZT49FfW1CUzql1jb3sUxgGkrluhRRVuZX5zo6uRlB2tzQ/XxVT27o5vMvrCKnSrIU+ILLZkZsHt2LzEs0Lp2H77bxQPGlJub/CNUevdQxepjo7ZS9OFTkP+De3BF68dRe2YDj69g4LKUFoR6nW2IaxyQ8KR24mBBttIFIUwCpx+avlHyVRnzONBC33V2owK6IutqIY60DYS6QyphhTw5pmS4W6m/qQs7ZrwNw+E5qxBzd3W0qYQIAhEU5a1YeBvhRnZTuu6uksDZs4hWTfRUOwwIIRQyVK2wxDKfSd6ODqM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(46966006)(36840700001)(4326008)(70586007)(6666004)(478600001)(6916009)(8936002)(356005)(44832011)(5660300002)(70206006)(54906003)(8676002)(82310400003)(83380400001)(26005)(36860700001)(36756003)(316002)(86362001)(186003)(47076005)(16526019)(336012)(81166007)(2906002)(2616005)(1076003)(426003)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 20:29:44.8442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0d59f2-12a0-497b-fc07-08d969996846
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
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

From: Anson Jacob <Anson.Jacob@amd.com>

This reverts commit "drm/amd/display: Directly retrain link from debugfs".

This patch broke new settings from taking effect. Hotplug is
required for new settings to take effect.

Reviewed-by: Mikita Lipski <mikita.lipski@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 87daa78a32b8..f3ada9b6be5a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -247,6 +247,7 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
 {
 	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
 	struct dc_link *link = connector->dc_link;
+	struct dc *dc = (struct dc *)link->dc;
 	struct dc_link_settings prefer_link_settings;
 	char *wr_buf = NULL;
 	const uint32_t wr_buf_size = 40;
@@ -313,7 +314,7 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
 	prefer_link_settings.lane_count = param[0];
 	prefer_link_settings.link_rate = param[1];
 
-	dp_retrain_link_dp_test(link, &prefer_link_settings, false);
+	dc_link_set_preferred_training_settings(dc, &prefer_link_settings, NULL, link, true);
 
 	kfree(wr_buf);
 	return size;
-- 
2.25.1

