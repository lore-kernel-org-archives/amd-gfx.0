Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B802C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DD8860E77
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4DD8860E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3D236E1E6;
	Wed,  8 Sep 2021 14:55:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDF6F6E1D2
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 14:54:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3HSwO07LhfT5FDoJf5aFh4/8y2Sgq4HzQznAhvxOXDbtPYl5w3Na67XGXTWKb9dXavvQrlueTfyWCdmXH2gwbkU5u9CX/xcePMirQkY9kkSXQwrWYmEMJ6YwIhYGezgab14QlQjE4XgUJEe5pSBId4sfmFHyFHkd3/t1fqa3QKWIsQ/gQQAgxP/b4tU1+rHXnDaBRBge7z05Ip1O0O30DuKifekRihEu2wi0Id5jl7x+EvqXcx6HQUgJ1x11ZeZMpDfsxPlc51t3G3w7GpW35Tk+jXFeGyy7Kbl5hZc5eOfUAIE40H99LfeynGxTtGQOPSaitWQ5fSZiQD4RDS3og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=696TOs68HJTWuQq7KvnfOFXwfVd7iqBVK9t/LTduREs=;
 b=bLaZ4UyBpV/Dd9gv1c+XYxeVijJDk8yt1vhVRo7bDRW705JObXT5qCS0o46mRuWof6rJhQKdawPtlIh+DAZcupWs6soI4bVkCHPhxdFOe9KxySdD+/s0xdbTWsPlaFwarl026FxgV6MSh/1HV7gLtkycAiZ+y4wpXDynoBdOmKkK1C5IwJNrzoL9FrMrHqVLYFyX/7Wi1az2c8OKoSsOWeUmT5AjW3bC2PqDGI4iSIeScxt8i1npBCZ5xl5wYZ26Ij6UKwJ7cdSiXHG9KIPFIplT0HkGDDfr6Sm5xGMlIuMRgEa1nIVacJikMstqM2fCOFHsItX3anehpxufe3xyEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=696TOs68HJTWuQq7KvnfOFXwfVd7iqBVK9t/LTduREs=;
 b=wX2ApI6zZNUWTz7YuarUU1F8WDLJ51CyRbdWX4r19N8GqWJfbDyoRq3VqL8GgXG0PGWnJkCgKvWUsbnH1hN5xO7SM2HP8dqPaomaBqikJIR5cSw85KhXtSf6N8f5ZgUwC7gU98M7VVRNmLxyiznyCo4bo3fJlm/16y8U3qH5cmY=
Received: from DM6PR13CA0042.namprd13.prod.outlook.com (2603:10b6:5:134::19)
 by PH0PR12MB5465.namprd12.prod.outlook.com (2603:10b6:510:ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Wed, 8 Sep
 2021 14:54:57 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::d4) by DM6PR13CA0042.outlook.office365.com
 (2603:10b6:5:134::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.6 via Frontend
 Transport; Wed, 8 Sep 2021 14:54:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:54:57 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 09:54:55 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>
Subject: [PATCH 17/33] drm/amd/display: Revert "Directly retrain link from
 debugfs"
Date: Wed, 8 Sep 2021 10:54:08 -0400
Message-ID: <20210908145424.3311-18-mikita.lipski@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2cacbd57-c1be-4151-8f0d-08d972d8a031
X-MS-TrafficTypeDiagnostic: PH0PR12MB5465:
X-Microsoft-Antispam-PRVS: <PH0PR12MB54653BD2F881FB50C6959C9CE4D49@PH0PR12MB5465.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:151;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eYgDl3Spqa79WcqDU0HA6+qk77bbGaiuffEhbWd3UngVbQVnF3lPN2KJ0eiiU0sDb2N00tFDk7OskQslxX71q7vyHcVaRHMbxMcCcgMUQm5m0ilGcREA7HedhxPbLRXAXIRfBOSDl5OXk2523DeA0yd7YBrGs2U9RkUW7xONlhlnCyISH3Q3qoB6gvjmDTw0Ky5IlBn+tB1MtsG+TBbP7HbfSaV7a/qU3p3134grUZJ+VWac9QxGoaMqGXyIwcMgOsgSXLpmJtbf+DBrg/fzeixySYLhiAEK9rPkU9WPPfxzdzYv7WXT6omcluPHz2FfI1824UIwCu02RmV/5FEf0JcVvZ0OjbkbjvTQd86tOzh3dcz2S3qbyxFooI7Jy6hYSPFU25HuJFd75Qu4iN9fwl+wvW0Pk0rk+uSnHjQ+WXp99q16E/hO/FhCWBJ0QkMgQailp/ZtwF21WnpKFf86VHqg/U5lN4GZYrfwI1IBc5bCC8gIvQtuh5QtaENtbgVFvbNqtrG5vPWR91BOGjL0TNF1Lo1l6KS9Wk8i0KH8fg45umdBAQlk4F0mLGwmRX3uXHRJ5/uVceOQnyRB6+ngvBURhVcEGVGNdtrWDw7O7KTeahA9pAS8ignNt9DgqPOuM3WCqofipAHExtdmqRyci19WfRxQI+E+8aXs5BE1rlo41q4cbFOKlJgCLaM2E6QlEnv9Gv27A+1+2LEHNeeQqPgseasbko99m0zwgB1qThE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(36840700001)(46966006)(478600001)(6916009)(70206006)(36756003)(8936002)(86362001)(36860700001)(44832011)(356005)(82740400003)(81166007)(5660300002)(336012)(16526019)(70586007)(26005)(186003)(426003)(6666004)(2906002)(2616005)(316002)(54906003)(82310400003)(83380400001)(1076003)(8676002)(47076005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:54:57.4711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cacbd57-c1be-4151-8f0d-08d972d8a031
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5465
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

This reverts commit  f5b6a20c7ef40599095c796b0500d842ffdbc639.

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

