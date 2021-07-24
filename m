Return-Path: <SRS0=oGIb=MQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C4CC4338F
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jul 2021 04:10:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FCE360EAF
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jul 2021 04:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3FCE360EAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4DFB6F3BE;
	Sat, 24 Jul 2021 04:10:38 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2087.outbound.protection.outlook.com [40.107.96.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5406E6F3BE
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Jul 2021 04:10:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYZktQf0yhZLSSBbFFVZYLFFYd74SparTILQTrqPJbykNe5WRQgb+foL9xCns0QB54jYAIooCSbOqp1Bmkq1JR4uOmLPnlmjo+b8yw3qG4aOL2By03cqiLaO4mpXLMwE0aGM2hsK80oc/TpgSG1iEzHf9E4UsZkoGh7YTVxnn3dE5HAr8nAwH7wRwaBHsfto9TfK1v4PuDjGIdecE2LXoiiTnEeJF0QJ2nFbmfud+lU5j+WtallSRmehOXDGDdZtlFi/17cixSOY8x94jJuN0CI1N6TIRKQ+RZNtWDWR2wCzF0qIJL7J0pgv+sIM7/OlB7mR/xYtUarlvB0qg8yZUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXhnO9zLYpcm8HEjcBDQNfdpHI8NE1PZHoObsRGevL4=;
 b=PPdvhTgwdtTtxuLQT3R6eRbKg5v+fvmssHOFaupE1Iih28EC1Tsm5M5fgbunkADYWMTqegBA+/vk8vO0EURkY8VSxnJ4mqinEZqwLOSiefEh8vV/Ker/pXrBQw8N0N33/6YDXpca1um6Bp9/pJXj1AKklY2/5z8XZMY13JdcHy5PU8bqrNWzASHds3AcoCBKC5H0dxmCw7hubqwXQx0DZm8hx7sP5czd0o5GYrgaq0PQBujfiVH6DsWsaNsYSfzOkYdhGu0Lq6bxEGsLD9Nz1cYZ10SRDpj9TqFhVKCoFwWTk1ofGu8uz6FkSPdOlyp68rYlrFb1UnLpXMHYYikDwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXhnO9zLYpcm8HEjcBDQNfdpHI8NE1PZHoObsRGevL4=;
 b=YutKzkDnJGy3GIVK9lK2DFNEhnFbRCNflVAbYoWGe1O2wIZSKqtZ41UDIsHG6sX15FsiEoo119yk72XeD6g7BuH5uIvx7ReL3e3M9CWMxg4E5UXZNpL/msyuYalgsvpRc8l0hWer5m1At0YPWUAfinS6pibEPjVIVRWlClEYTOc=
Received: from BN7PR06CA0037.namprd06.prod.outlook.com (2603:10b6:408:34::14)
 by DM6PR12MB4529.namprd12.prod.outlook.com (2603:10b6:5:2ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Sat, 24 Jul
 2021 04:10:35 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::cd) by BN7PR06CA0037.outlook.office365.com
 (2603:10b6:408:34::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend
 Transport; Sat, 24 Jul 2021 04:10:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Sat, 24 Jul 2021 04:10:34 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 23 Jul
 2021 23:10:31 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/14] drm/amd/display: Fix PSR command version
Date: Sat, 24 Jul 2021 12:09:50 +0800
Message-ID: <20210724041001.3875757-4-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f752e88-2c6a-4895-24ca-08d94e58fc82
X-MS-TrafficTypeDiagnostic: DM6PR12MB4529:
X-Microsoft-Antispam-PRVS: <DM6PR12MB45294EECE450306B1749F5F597E69@DM6PR12MB4529.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XsMNhHLy17f9gM23bst2+C2tgISduJlQioxI6w9WuM6lXKY+DEWhTBDtaUL5Lh9bHbS5w5JLK8I39v/cSyQfZgqObLLVDqobx33F/XdJXEWCywm8fY1D75BQlZQkXJq8/spEcv1DKPGu8WxLGTBlFOGqtlXrpn1wm6JreXRKTc611uYScUIl6wtCj1+dCJV55kYBarv1TgemA1NyA8SkFQuq4h7WLhRFltXxewUtsfoF8zUmYokqc6BCZih3mJ9YU5fFQiIsdj2X1GuBzy9sjvIc7sjAcmO83ONxNLbQgXYze8nNJcMH55vOIwEyhK3CW7uitSXa2mXw31xOWZLX1ofQvXKMA4GME+sCiub1hwazS86gbyyCDQukOlHsTlJ8Z117xitYhzFyDz7om36XUnd7kOvLWuIYUZkxLQokw9eFfHBBtH/4VTkQ2g/n//WEK9XlgbLKhLzjxbvl1vNwRyuTZ0rrG6LUNlYLbt9+wF5hkCdnyq9OaHO1SsbTt8l3jL3Ij83Eg6DeYkPqCFovz0E7enZ+WF793LO1Pi57b6OA0e8tdMrhwAuiPtuMFP3ChOQt3KCzuk2M5eZM6rD6cc9PuYMWpmdl6cBBSGjnk2pHaZJNzWdxf030apM9G/VaE+g3nu+3uZH8zJ91+MkLdAc8My25kHlNdgOmUZl8wgxMg6uyz/6yOTQ8cyhMY09z0jurUF1IpAb82CKw5g+RCaLxlKntkoKzYV//r5tbTB0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(36840700001)(46966006)(4326008)(478600001)(70206006)(1076003)(82310400003)(47076005)(7696005)(426003)(16526019)(186003)(36860700001)(70586007)(336012)(2616005)(6916009)(44832011)(5660300002)(86362001)(356005)(54906003)(36756003)(26005)(82740400003)(83380400001)(2906002)(8936002)(81166007)(6666004)(316002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2021 04:10:34.9572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f752e88-2c6a-4895-24ca-08d94e58fc82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4529
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
Cc: Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Wood Wyatt <Wyatt.Wood@amd.com>,
 Mikita Lipski <mikita.lipski@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mikita Lipski <mikita.lipski@amd.com>

[why]
For dual eDP when setting the new settings we need to set
command version to DMUB_CMD_PSR_CONTROL_VERSION_1, otherwise
DMUB will not read panel_inst parameter.
[how]
Instead of PSR_VERSION_1 pass DMUB_CMD_PSR_CONTROL_VERSION_1

Reviewed-by: Wood Wyatt <Wyatt.Wood@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 10d42ae0cffe..3428334c6c57 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -207,7 +207,7 @@ static void dmub_psr_set_level(struct dmub_psr *dmub, uint16_t psr_level, uint8_
 	cmd.psr_set_level.header.sub_type = DMUB_CMD__PSR_SET_LEVEL;
 	cmd.psr_set_level.header.payload_bytes = sizeof(struct dmub_cmd_psr_set_level_data);
 	cmd.psr_set_level.psr_set_level_data.psr_level = psr_level;
-	cmd.psr_set_level.psr_set_level_data.cmd_version = PSR_VERSION_1;
+	cmd.psr_set_level.psr_set_level_data.cmd_version = DMUB_CMD_PSR_CONTROL_VERSION_1;
 	cmd.psr_set_level.psr_set_level_data.panel_inst = panel_inst;
 	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
 	dc_dmub_srv_cmd_execute(dc->dmub_srv);
@@ -293,7 +293,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	copy_settings_data->debug.bitfields.use_hw_lock_mgr		= 1;
 	copy_settings_data->fec_enable_status = (link->fec_state == dc_link_fec_enabled);
 	copy_settings_data->fec_enable_delay_in100us = link->dc->debug.fec_enable_delay_in100us;
-	copy_settings_data->cmd_version =  PSR_VERSION_1;
+	copy_settings_data->cmd_version =  DMUB_CMD_PSR_CONTROL_VERSION_1;
 	copy_settings_data->panel_inst = panel_inst;
 
 	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
