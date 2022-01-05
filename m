Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D61AC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jan 2022 17:07:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3CAC1123AE;
	Wed,  5 Jan 2022 17:07:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C00F71123AE
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jan 2022 17:07:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWJN7uNjatFtlZGJx2G5BWi8/QwdxVD9c//yYnU3l5/ZUmdsbACEhpxNeAZUzn3eQKvmtSriRNMRN8S24q3m8d7Z6rULKy4mOJzeU1BWgcwOtuCZMPtRQ6iDidL+6svnS/3d67wg0ynNFoDTZhBAFJTnOvBOjhPS8rzG6amvTald/mwdS4xEiRWJlyEil85J1fy33gOgIWRBce4nuPDJ6AIIm6PB6KK/S2+xL0j+6eNLu0atfNaxJc75w+QII0PQHyms+Y3F0qCRnMSlZqk/1/F7tuo89ugy9Y4gKSnPYkU22G1iibS7F9KuWiPlcSIeIJrioy1028kQGwFrwHpDrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLFitw3cdFi5cahAiNVLyMNqK552aTHsO0EBQ9e0JLU=;
 b=ILMvd4YR+w0o4DjdWrYHr8638cnD+1iDe0PKC7PQRmWFQb6K1qA3c6nIHo3NpcQ8eNx9bBeHfhzHhyrZcoFUxhKWTpIL9jQ/dFWmnxyjilqfJsI8KnBNaUIgLb7feNQqQPSaikFZiDjdVymkF7e0bT4XQqsrLuuKU2C1ohefTHqlX+7kJ9Z+il79jo2EDJ2P9tmED/vEE1Sd3SFXPwFdk1BGPvLP0DocS5Pyi0E59AAAbVyXjGQBoQkqplzaxEpN8ymR3/tpVMkkMgJIWSl7qQDFZSnqfuhd9F8cPRYVSGO0EAiyJYgxn+GwgtF/ndE5VXeAMLNJGpV+zdmK1F9raw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLFitw3cdFi5cahAiNVLyMNqK552aTHsO0EBQ9e0JLU=;
 b=nMrktA3UnsAphXaV+bDm2tcGo8/lQ6bhrWCEGAOgiK0CTHeB5GKoZylynz7O40bhy8GT8uSy/j+XmP+YqCzQ/i6AXcZSjisU/fVeXmx9/KqoPi61PFJDBd7bOfO7BdR4cuEqbk1vbwSgZf4vq25qfejShzM1X2CoR+Xb2Aznbhk=
Received: from DM6PR02CA0052.namprd02.prod.outlook.com (2603:10b6:5:177::29)
 by DM5PR12MB2424.namprd12.prod.outlook.com (2603:10b6:4:b7::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Wed, 5 Jan
 2022 17:07:15 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::24) by DM6PR02CA0052.outlook.office365.com
 (2603:10b6:5:177::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15 via Frontend
 Transport; Wed, 5 Jan 2022 17:07:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Wed, 5 Jan 2022 17:07:14 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 5 Jan
 2022 11:07:14 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/display: explicitly update clocks when DC is set
 to D3 in s0i3
Date: Wed, 5 Jan 2022 11:06:56 -0600
Message-ID: <20220105170656.2121-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e858eaca-da98-446a-3251-08d9d06dd26e
X-MS-TrafficTypeDiagnostic: DM5PR12MB2424:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB24247638E1AF86D4790362DDE24B9@DM5PR12MB2424.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zjZgNuV71dIknnNpxtq48JEhDMFswc/OuUdmTfm5NzyIQ3zGn527a5f3ALxLzzWbN+W5fOUr8jIWjNNqzOoYZHWasHc++w9TlPSSipP2DxvvNRfI6VnzRM24ljebYLRalcxV47azJVaMkgl4K6oESUgT+HaVcdOBEcf4mwM1jizLNs8btISqUfvHaTWYjVM+42GvLIEZR4tpIS8ZwV/VrliSnKGF5zkjYFq6PEMCOd9Zm5Be6nDp0/QCq7oxYlzb108rRU/MJfciaAXDLizXmN61fv5NFSOaQeXoxDDHN2YFzd3pF0NZdvLRWEdfBF0IvGY0R5LH1RCiP7VZzUxKvV+1GKYNqSAwpcGn86TRJqH3iNSRhGwbu9fvGWGo9hiJAil3Gjz0dxQw5ey2zXgit04xaM554CS9WoUeLRR2WTUyUmkj2hy0K1cVu9ek6VKhS6epx6jzcBr2cjbuwyqVZUgURP5SUJYTdD5jDFDbkhHMfVCw1WENnhXK+gKpW8iou4EkJXB0d1MnkDRspmBKa0bWxT55fuWxhihqd09c0IvPvAR47Tsonjvm9KcOK1uKcC+lh2PaXfHOKQJJ/W0zcl8A5H/Ooksa/x6X8c1YFsYwqsJtv1HM3Xb5ZxoYn4OaTHanlyBrVTAhKF5M/tZrQdHFO8fplGyyQVWkJx2WJi6a6FLyfzLl1O2yafSnS7/PNdTdLPWm3RWuFAoXisUFMJeiFCRO2DYNIuCqKsIW69ZD10sjMJc9ySjhJoqNxvxKCDD9synZyYj+z57hVgJhPY0JLbioj6WTWZinTzCae5GFeIL7MQllD2S8+KaxCwbY/Rni5Q7IUP4so6QukYLlWc+rSAORJ3rdPOGNbpBl5N1SzNiFPzqZ7C0HwwXeCswA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(15650500001)(8676002)(36756003)(7696005)(2616005)(86362001)(966005)(508600001)(8936002)(36860700001)(5660300002)(47076005)(2906002)(26005)(81166007)(6916009)(16526019)(70206006)(83380400001)(336012)(82310400004)(40460700001)(54906003)(4326008)(316002)(426003)(1076003)(186003)(44832011)(6666004)(70586007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 17:07:14.9304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e858eaca-da98-446a-3251-08d9d06dd26e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2424
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
Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>, Scott Bruce <smbruce@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Chris Hixon <linux-kernel-bugs@hixontech.com>, spasswolf@web.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The WA from commit 5965280abd30 ("drm/amd/display: Apply w/a for
hard hang on HPD") causes a regression in s0ix where the system will
fail to resume properly.  This may be because an HPD was active the last
time clocks were updated but clocks didn't get updated again during s0ix.

So add an extra call to update clocks as part of the suspend routine:
dm_suspend->dc_set_power_state->clk_mgr_optimize_pwr_state

In case HPD is set during this time, also check if the call happened during
suspend to allow overriding the WA.

Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
Reported-by: Scott Bruce <smbruce@gmail.com>
Reported-by: Chris Hixon <linux-kernel-bugs@hixontech.com>
Reported-by: spasswolf@web.de
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215436
BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1821
BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1852
Fixes: 5965280abd30 ("drm/amd/display: Apply w/a for hard hang on HPD")
Fixes: 1bd3bc745e7f ("drm/amd/display: Extend w/a for hard hang on HPD to dcn20")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
changes from v1->v2:
 * Add fallthrough statement
 * Extend case to check if call was explicitly in s0ix since #1852 showed hpd_state
   can be set at this time too
 * Adjust commit message and title
 * Add extra commit and bug fixed to metadata
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 5 ++++-
 drivers/gpu/drm/amd/display/dc/core/dc.c                  | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index fbda42313bfe..fa5efe10b779 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -23,6 +23,8 @@
  *
  */
 
+#include "amdgpu.h"
+
 #include "dccg.h"
 #include "clk_mgr_internal.h"
 
@@ -126,6 +128,7 @@ static void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 			bool safe_to_lower)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	struct amdgpu_device *adev = clk_mgr_base->ctx->driver_context;
 	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
 	struct dc *dc = clk_mgr_base->ctx->dc;
 	int display_count;
@@ -157,7 +160,7 @@ static void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 			}
 
 			/* if we can go lower, go lower */
-			if (display_count == 0 && !hpd_state) {
+			if (display_count == 0 && (adev->in_s0ix || !hpd_state)) {
 				rn_vbios_smu_set_dcn_low_power_state(clk_mgr, DCN_PWR_STATE_LOW_POWER);
 				/* update power state */
 				clk_mgr_base->clks.pwr_state = DCN_PWR_STATE_LOW_POWER;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 91c4874473d6..8e0c820f6892 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3299,6 +3299,9 @@ void dc_set_power_state(
 		}
 
 		break;
+	case DC_ACPI_CM_POWER_STATE_D3:
+		clk_mgr_optimize_pwr_state(dc, dc->clk_mgr);
+		fallthrough;
 	default:
 		ASSERT(dc->current_state->stream_count == 0);
 		/* Zero out the current context so that on resume we start with
-- 
2.25.1

