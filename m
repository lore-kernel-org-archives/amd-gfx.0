Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDFEC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 22:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE0F610E245;
	Fri, 25 Mar 2022 22:56:52 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2046.outbound.protection.outlook.com [40.107.95.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C60710E20F
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 22:56:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJnnCoKvOQHGa86QhyIq+ffDICROcJ70fI/IolNwuvzDzQuwBDNNB+N493PyugotwJlaR29Cz/Z0gOkytW5RUjKWpHKLObc01EywWPr8t2esKQdqF1O5woMZsnUJ8gq9v3rnp5VisOo+IDCiXh+D1HjcDaf+oLcPz2mR7RSk0c8VDgtaTCHLipU6nPzZ1d9c4pCRAkhhcnHwBkuy4lx0fA/ynPjoed3QSt5AHLpXU0ogxd4vogZBVfqRfRWpwdf67sUPN+Z7LYXYVNWsuQ/eEhxvGqwIYwzmkGoPjXoi4lI28QOu8fJc/qbGeuxjbxaWWaN1vJwhNNZDOImDWdGReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByuxO9QR2OO9xRMh/F1Ti8EtLT15nSQeLSAXvxW99dI=;
 b=kbaSRdtyHjg1aouJqtURlEfMz0B79y0ANgtv4029/KWKfgquP+1A5ClFuCOnp9qzoRGT53LVrm7AW5rcF4JVKr73Q2UKI5XfPCVe7heF4eMIHaZq+4NDvy0gtbMtWzJYf/MuTSrKoAEoLqG5e2lIuFlnVr0FB4BaPxQzTvPyHlnHDezZkNTh0PG9WqFIPXzFXy1W7RMNdugPW79WYF26ojKVbwCG1dVRlgStfuEUCw2yko8KOyoIzteT7UuFiWpqyAFXcX1pVlyS4Gt1m/irv//1U2yxIe5KHfP87AleYajJmsirEb2WOGxItbQI6k9Q50OlcQ+Cqpeovxn3RK727Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByuxO9QR2OO9xRMh/F1Ti8EtLT15nSQeLSAXvxW99dI=;
 b=Y7axeUrFaN9axkfrpkFjLH4TGnCIl5ZWxebI2EQIzSQiy5RkCcclgFBnyOX0+Cn9D+YUnpWqrlmqYL5kTOnbnIh8ZNzEEIxrpcQPTPqCmHKrsDI6rykjeq8gKvm8eTNmX5n+6vpb9pbOlmqx6PwaeYwzFnKiredaNWmNidElZ4E=
Received: from MW4PR03CA0174.namprd03.prod.outlook.com (2603:10b6:303:8d::29)
 by MN2PR12MB3389.namprd12.prod.outlook.com (2603:10b6:208:ca::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Fri, 25 Mar
 2022 22:56:48 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::f8) by MW4PR03CA0174.outlook.office365.com
 (2603:10b6:303:8d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18 via Frontend
 Transport; Fri, 25 Mar 2022 22:56:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Fri, 25 Mar 2022 22:56:47 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 25 Mar
 2022 17:56:44 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/16] drm/amd/display: Clear optc false state when disable otg
Date: Fri, 25 Mar 2022 16:53:55 -0600
Message-ID: <20220325225402.469841-10-alex.hung@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325225402.469841-1-alex.hung@amd.com>
References: <20220325225402.469841-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 302b7cd2-f7c1-47ae-ce1a-08da0eb2bdb9
X-MS-TrafficTypeDiagnostic: MN2PR12MB3389:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB33894252EC08905086F5EEF0F71A9@MN2PR12MB3389.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G2fbMC7xdG8y3Apxwq0sOqx1fJAdoZ9BxOjk9yV80Wj5HOdUqoX37KmIBsU8NY9QjyKExCTrvSwcpxlyVuL6CO8uMLJUQq0FPJ7Ng1eho56o187W/ZA36RqwLrqvDXW+z8JcGIzWHu4q0D/MyN+LHHew9CsKAc/CryhKALmClcDYybd4t97p069QA4NEf7sL0zMHbJxj74VgBDxrqSSl7E+F1cWvChCOmT08kTri8DkAB91RHp4JnEprcWpYAxL7sdLhwPyHRhoAK7H0dFrBmkBhV1chEFJyq4mHH/bRVQRKB6p83uK/1W1/fQGLpaDw0x8CBiZUj3FMhK8UGsljE4lXz/vfkQuI6yW5pSSKI8Iz4G83F7NvIcMKBqFYi9tXF/2/lFGqRJ879e50wzFKvrRx35EMcR520+0w8itIdK3PLBaYDBzy5RfYZz409KnRbCQWC9UjY1VgNM8zLRea347GEQsg8BQjnhj9gVKjimmpqALZyOEr35nnCobonNSrguQQpq14WMLFuiSS6giJNkH3CDQ3a8+maZmFC3JKsEAqGVycq/PpmJ1E4Ah2hFg5+kk7xnyBmvu/uJtYEjfoGFLtZE581v3BMmflfLyBqnCkJD1hd++UK2BZdZ07ucqpV64pvQ4Ip1by01qru8Q6dr+Iv8l9sTz5H4WVFwXl3q60IPDcZi+lwyOd7YfI4SuLNfYZpG8fW5Hw3K0ZwEObXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8936002)(2616005)(8676002)(70206006)(4326008)(5660300002)(40460700003)(47076005)(2906002)(336012)(83380400001)(81166007)(86362001)(44832011)(1076003)(70586007)(82310400004)(508600001)(426003)(36756003)(316002)(16526019)(36860700001)(6666004)(356005)(6916009)(54906003)(26005)(186003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 22:56:47.4509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 302b7cd2-f7c1-47ae-ce1a-08da0eb2bdb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3389
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
 Chris Park <Chris.Park@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
when disable optc, need to clear the underflow status as well.

Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c | 14 +++++++-------
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c  |  5 ++++-
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 67c13654ab99..531dd2c65007 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -343,20 +343,20 @@ void dcn31_enable_power_gating_plane(
 	bool enable)
 {
 	bool force_on = true; /* disable power gating */
+	uint32_t org_ip_request_cntl = 0;
 
 	if (enable && !hws->ctx->dc->debug.disable_hubp_power_gate)
 		force_on = false;
 
+	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
+	if (org_ip_request_cntl == 0)
+		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);
 	/* DCHUBP0/1/2/3/4/5 */
 	REG_UPDATE(DOMAIN0_PG_CONFIG, DOMAIN_POWER_FORCEON, force_on);
-	REG_WAIT(DOMAIN0_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, force_on, 1, 1000);
 	REG_UPDATE(DOMAIN2_PG_CONFIG, DOMAIN_POWER_FORCEON, force_on);
-	REG_WAIT(DOMAIN2_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, force_on, 1, 1000);
 	/* DPP0/1/2/3/4/5 */
 	REG_UPDATE(DOMAIN1_PG_CONFIG, DOMAIN_POWER_FORCEON, force_on);
-	REG_WAIT(DOMAIN1_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, force_on, 1, 1000);
 	REG_UPDATE(DOMAIN3_PG_CONFIG, DOMAIN_POWER_FORCEON, force_on);
-	REG_WAIT(DOMAIN3_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, force_on, 1, 1000);
 
 	force_on = true; /* disable power gating */
 	if (enable && !hws->ctx->dc->debug.disable_dsc_power_gate)
@@ -364,11 +364,11 @@ void dcn31_enable_power_gating_plane(
 
 	/* DCS0/1/2/3/4/5 */
 	REG_UPDATE(DOMAIN16_PG_CONFIG, DOMAIN_POWER_FORCEON, force_on);
-	REG_WAIT(DOMAIN16_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, force_on, 1, 1000);
 	REG_UPDATE(DOMAIN17_PG_CONFIG, DOMAIN_POWER_FORCEON, force_on);
-	REG_WAIT(DOMAIN17_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, force_on, 1, 1000);
 	REG_UPDATE(DOMAIN18_PG_CONFIG, DOMAIN_POWER_FORCEON, force_on);
-	REG_WAIT(DOMAIN18_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, force_on, 1, 1000);
+
+	if (org_ip_request_cntl == 0)
+		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 0);
 }
 
 void dcn31_update_info_frame(struct pipe_ctx *pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
index 8afe2130d7c5..e05527a3a8ba 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
@@ -124,7 +124,6 @@ static bool optc31_enable_crtc(struct timing_generator *optc)
 static bool optc31_disable_crtc(struct timing_generator *optc)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
-
 	/* disable otg request until end of the first line
 	 * in the vertical blank region
 	 */
@@ -138,6 +137,7 @@ static bool optc31_disable_crtc(struct timing_generator *optc)
 	REG_WAIT(OTG_CLOCK_CONTROL,
 			OTG_BUSY, 0,
 			1, 100000);
+	optc1_clear_optc_underflow(optc);
 
 	return true;
 }
@@ -158,6 +158,9 @@ static bool optc31_immediate_disable_crtc(struct timing_generator *optc)
 			OTG_BUSY, 0,
 			1, 100000);
 
+	/* clear the false state */
+	optc1_clear_optc_underflow(optc);
+
 	return true;
 }
 
-- 
2.35.1

