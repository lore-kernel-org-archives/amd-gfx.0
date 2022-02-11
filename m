Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52811C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 21:52:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4719A10EB3C;
	Fri, 11 Feb 2022 21:52:10 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2085.outbound.protection.outlook.com [40.107.96.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95A9E10EB3C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 21:52:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYCyPdh5/QsBjJlvSWMpqYL5HB4VKUwRCSaBGEwMUaIzPvtQBdBYbWxEf1UotJW6sAfPnzICYyRaqh73cGALMFGGhYRKmSEId6lspwDF2chs4iw18Qg7gzurag0Ge/rknINafsiyBzAUxMT2UPXzSo/uYjTzZ5yhctBVPmwYRux/mt/cZ2UpCKe+DxLQCdkaJUi8Ou8YW6EoLP9e1Quli5wISL7OdlYYfHKnBZTBeJezEWXBX8H64XeDWi6IknwwmhTY3l0CwP545TeK/bo1k09TG6oOYYLJwRuVk7DH+DbrlnfbIilXDOqrMtlvHB53uKiWo1fE8dXxeJZQ4GlqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deB6xxgpvGm9nrvyTYI1avSJWoin8xsk7klDoNGw76I=;
 b=gwnNNQa8bTyfhSRYFlD5Cw3eFyke4ATpfRoEaScLUKHjkJfKli42dlYiCY4JYi1frUQqW8JCsmCIluLo0udKtf+ifQVGn49rkOEmaiNWECOixysLdR5DMhi01oBlWcd/vu04v2PD2C8cIUi7dJRU8dOleThFX2w/kagDIMwBqtKSJyizZxI1OA5p5kgQSyJL5C9vgAG/UvOdTZxRFGHhucpmudlaI9PAPKR9XRb0K6lTWu/rVNx5E4oa/gcm+a1DUtLDjIIvEYn4NJK44mPn41Tiw9Ti8pVY1ZYRZrSPKqtVEj9+6AF+DzdFz7QjCkbD8etU4cYjr0tqXduffc6OYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deB6xxgpvGm9nrvyTYI1avSJWoin8xsk7klDoNGw76I=;
 b=PPbHcFyhMbc2IppYKeykgvpr0pqI8tM+5eEVJ6V5kACC4gX2sISBzyuKXt2Ibx6f6ufC4Ug+RmXg0NvCZDpmLJXUamfmeemLBGJ1wnmlf1vOipGHOM/LDMZ+d+VOLfMRjHJ0vfjWkfPWULFgkrIvap8smk6pPJcFT7gCPL1awCY=
Received: from MW4P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::17)
 by CH2PR12MB5546.namprd12.prod.outlook.com (2603:10b6:610:63::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 21:52:05 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::64) by MW4P223CA0012.outlook.office365.com
 (2603:10b6:303:80::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14 via Frontend
 Transport; Fri, 11 Feb 2022 21:52:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 21:52:05 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 11 Feb 2022 15:52:01 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/11] drm/amd/display: make sure pipe power gating reach
 requested hw state
Date: Fri, 11 Feb 2022 16:51:35 -0500
Message-ID: <20220211215142.94169-5-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211215142.94169-1-jdhillon@amd.com>
References: <20220211215142.94169-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1296c7f-b6ca-46b0-d1e8-08d9eda8be9c
X-MS-TrafficTypeDiagnostic: CH2PR12MB5546:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB5546CFB278287BFDEA0F2984FB309@CH2PR12MB5546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: roo/PpYk0OPf25WjFe84U6noFv9SYujiGZ0VGSBQO7XbvA4oGZXWuyu0LHvlvr2r7vLCXa5v0BRe1xzPS29/GZemYnn6ediVgCoKk+aObj5Bl6Tx8Al8MIZ4/rjy553cDYcH2LXllS11vp0mZfkM6CWLozbcKpDhLk5sv1lJI6nAW2+BuSq80PwkiWywYhxLOv1PizCGr435d/iSIP1OlNxWX9P1GJJC1dCKyolfmcYMnLKxsmiK7ZoyW8pl5nCbIu21xGtMHnBwCydW8DaEpWkbXLb4GJ+rzKZIaXshSVjZt+LCdVa8NxdRGXmVpffWW97cGo+O1HpEqtEUyNvEf08uqe4Z0DOrI1Nd6Xym5tzwhd7vPP/u5j9Vv5mDO1DL3JjBNhwnKy+U4IXofAZ3gs0xRfjmKDVRapTkt26wSCUyrNsRf7Ex58/NPCox1buXuPAoFp6mqQeEyX6Aj2kZ9fg9binr7jc6J1HSn6Cp8/G5WGoznGIBEpo8pVEfO6xDkGKeDt1ekJCrCCPVvheY4KuCxGXZhwjkxwMkPRzjQhotPJ+kfviB7Zn5X06pMjonQ4aDdQyHQR6vH13wZ4MmwWjXNr1wEeGKsVgk0jSA+LExLrL5GdZ/iIZ5rUw31/VpLwc4WIlRTd3k+Ld+1UBM5py9SmsxjJdWcr6lu6C1ETh8f7S8Glvlc2RhwP77u6cKimVl5diIWRg0wqBUOCOLxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(82310400004)(47076005)(2906002)(40460700003)(6916009)(54906003)(316002)(356005)(81166007)(70586007)(70206006)(8676002)(4326008)(83380400001)(8936002)(6666004)(5660300002)(2616005)(426003)(336012)(36756003)(26005)(16526019)(186003)(1076003)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 21:52:05.5841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1296c7f-b6ca-46b0-d1e8-08d9eda8be9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5546
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Sung joon Kim <Sungjoon.Kim@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
display mapping change will involved pipe power gating on and off.
when doing this too fase, sometimes usbc will have no display.
check HW status, it is still in pipe power gating.

[how]
insert polling HW status to make sure the required state reached.
also add dal registry key handling.

Reviewed-by: Sung joon Kim <Sungjoon.Kim@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index ef72d2b82d64..4be228680909 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -339,21 +339,31 @@ void dcn31_enable_power_gating_plane(
 {
 	bool force_on = true; /* disable power gating */
 
-	if (enable)
+	if (enable && !hws->ctx->dc->debug.disable_hubp_power_gate)
 		force_on = false;
 
 	/* DCHUBP0/1/2/3/4/5 */
 	REG_UPDATE(DOMAIN0_PG_CONFIG, DOMAIN_POWER_FORCEON, force_on);
+	REG_WAIT(DOMAIN0_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, force_on, 1, 1000);
 	REG_UPDATE(DOMAIN2_PG_CONFIG, DOMAIN_POWER_FORCEON, force_on);
-
+	REG_WAIT(DOMAIN2_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, force_on, 1, 1000);
 	/* DPP0/1/2/3/4/5 */
 	REG_UPDATE(DOMAIN1_PG_CONFIG, DOMAIN_POWER_FORCEON, force_on);
+	REG_WAIT(DOMAIN1_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, force_on, 1, 1000);
 	REG_UPDATE(DOMAIN3_PG_CONFIG, DOMAIN_POWER_FORCEON, force_on);
+	REG_WAIT(DOMAIN3_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, force_on, 1, 1000);
+
+	force_on = true; /* disable power gating */
+	if (enable && !hws->ctx->dc->debug.disable_dsc_power_gate)
+		force_on = false;
 
 	/* DCS0/1/2/3/4/5 */
 	REG_UPDATE(DOMAIN16_PG_CONFIG, DOMAIN_POWER_FORCEON, force_on);
+	REG_WAIT(DOMAIN16_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, force_on, 1, 1000);
 	REG_UPDATE(DOMAIN17_PG_CONFIG, DOMAIN_POWER_FORCEON, force_on);
+	REG_WAIT(DOMAIN17_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, force_on, 1, 1000);
 	REG_UPDATE(DOMAIN18_PG_CONFIG, DOMAIN_POWER_FORCEON, force_on);
+	REG_WAIT(DOMAIN18_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, force_on, 1, 1000);
 }
 
 void dcn31_update_info_frame(struct pipe_ctx *pipe_ctx)
@@ -419,12 +429,15 @@ void dcn31_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool p
 {
 	uint32_t power_gate = power_on ? 0 : 1;
 	uint32_t pwr_status = power_on ? 0 : 2;
-
+	uint32_t org_ip_request_cntl;
 	if (hws->ctx->dc->debug.disable_hubp_power_gate)
 		return;
 
 	if (REG(DOMAIN0_PG_CONFIG) == 0)
 		return;
+	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
+	if (org_ip_request_cntl == 0)
+		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);
 
 	switch (hubp_inst) {
 	case 0:
@@ -447,6 +460,8 @@ void dcn31_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool p
 		BREAK_TO_DEBUGGER();
 		break;
 	}
+	if (org_ip_request_cntl == 0)
+		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 0);
 }
 
 int dcn31_init_sys_ctx(struct dce_hwseq *hws, struct dc *dc, struct dc_phy_addr_space_config *pa_config)
-- 
2.25.1

