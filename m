Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800AEC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 16:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E76410E4E9;
	Wed,  2 Nov 2022 16:04:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 023B4895C1
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 16:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdnO5afcuUZUvxswNoPX5P4bb5P2nGpV7EYZWG7MJEi1CA6jaGKNQtRP3417GBxi7C43MUPCOxnVYrD+s8vKJ42vvTQRYR68S/BXdWHVjC/H7zJNfdzHaJm36KgN6KJ19CnY+erVB+TSsNPw0UGxUmIJTgo5QG5WTL9t0A8uIrboLgJZR7F4KcNUTa746BppbkgAWewyx+CAm9xUm24RAC2gDe76Ok+0LSGUcHpE4TuG47pBB7gm1fji2hiNRMJPDPPnJi0nMNTnzwcqHoKvNCzccXZMNOMuXojF4DDo6VfIKoeYk1cMt3dOMInLUeeOTBoog+sL5z5QcEnmsNkrow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnWrM9EpC+9FQDDqhlx1TS9r6vx+4R+DsyzfyYmeNVk=;
 b=M9v6Mz5EcY0Xxk00XfTSmGnh0GNcNUul7nmQA5pvztklyR0FPq7P0RN9O+M7cWOdSmSwJcYLZO6vQaIzywiHHJFjATvudUVZRlNYcxzWQgUZuDCITMZbsE7WCRojO14+7pbTq/HJ/zyB/BSd2rdrFuNw86CoBO7Jpa36Yr39GcMF0nb3+BlGZmjhok2sWi5rywuR2uqVRqmOPcl8nYQa74cJrWB5f5jr5IazsnpL0A2Q9boxwHzCYNLMJ4ln00rRDbUXu53Q3aT/XGBZzrftsNm2aXoNGtdJROuTr1bTnvas8mUpLqAlQd8+5WDVZY1BlEEWCszUoxq2S5lJz6Kp2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnWrM9EpC+9FQDDqhlx1TS9r6vx+4R+DsyzfyYmeNVk=;
 b=5UvyYP3dYeaSIH7MJ/QIinShuoKZsQiyXz6Ht9QslCwzf9DPM40f3QY9MeDC5/wgspDdA/Ar02p74ciu9vbJrZ1Zeox1w5Sj3SH3ClD6HszsTkf9uZ3DecLHqgLB2ZhlYnRQqFHuyIgE3Q89s4eCZh3jgK/p6jq5+c1xIeXcxzg=
Received: from DM6PR11CA0018.namprd11.prod.outlook.com (2603:10b6:5:190::31)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Wed, 2 Nov
 2022 16:04:14 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::a4) by DM6PR11CA0018.outlook.office365.com
 (2603:10b6:5:190::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Wed, 2 Nov 2022 16:04:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 16:04:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:04:13 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 2 Nov 2022 11:04:09 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/22] drm/amd/display: Only update link settings after
 successful MST link train
Date: Thu, 3 Nov 2022 00:01:12 +0800
Message-ID: <20221102160117.506511-18-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102160117.506511-1-HaoPing.Liu@amd.com>
References: <20221102160117.506511-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT006:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cdb8f4b-fe5e-498b-68d8-08dabcebe31a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qcVj4QoEQSe2widCURnGTb3boH4n1ZRxYzc9e4/9OErH1nwOgQNa/N2oot44klHIT6He0DB4mLl18uhnPMa+URkqcE+j805HOjl7iXkU1PwTfby4OMTdy1RA1UDFh3Idb2564xIDJhY0gM32hinUhcfnSOSWC+duxlzniH+sxstl2pDlcthhd+EMvQLby9i8xOaAOYz90H4f+ZiC8zILcLxMGwcFZtMOo8ibz1R4H6uokB0X+GT0wpaA2jADTC1klfcBa71BvibvyJcf2xPNpy11+xU+AM0KwC6tbN28WSoztyH6KCCrxX3o77JOTbKM8XAYmcb9t2tdLNnYwxW9Z4PJH8QB9XtFVWVJYTpNomY5ittrVASkY5jmaQlN/YJg//N+Hm6VOGGyTyAJ+k6lver4MSg9dX3l06yPyJimKDiTrOrrEgBnyRZxoUoUoMbdxHVOLWJhjKuiIlpFvAf+R7Ae1Mc0TM9/DDTpEy1tDhmI/SY4nGTQ72pg5XxOGOcK7Jf9UVMfQhIcvJ6rdtPITy8XY/3R8D7QdAVnJ782kAP4BKokDPWlbzlrkaa/B5rU+wC1hvEhUVCUzFiHz0JnvNGDG2HGIXsbpMSrzMEWIPnCAgMjzuHmZd9zPI2Xbrot6pg+bH9pzXbbfpddcPKwtpZsNoBHmUu1IloUASIE4wFWO6JBe64W93uaWpnPLPjTPPyH2k8aQTUV9SjbpqcGK7GkoY5ZRHT/uKJx8PShUTjbj4P1VYtxYCYpkLkSqJs98zqlgrAL+Ypk5IAErkufG/lNzsPf70kvzqh7MIRXXv+c4fF1imbjcTD/SpnxVCE7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199015)(36840700001)(46966006)(40470700004)(82310400005)(2906002)(36860700001)(6916009)(83380400001)(41300700001)(81166007)(356005)(478600001)(36756003)(316002)(8936002)(2616005)(54906003)(70586007)(15650500001)(70206006)(40480700001)(8676002)(4326008)(5660300002)(186003)(336012)(40460700003)(47076005)(426003)(82740400003)(7696005)(6666004)(86362001)(26005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:04:13.9060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cdb8f4b-fe5e-498b-68d8-08dabcebe31a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954
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
Cc: stylon.wang@amd.com, Alan
 Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Michael Strauss <michael.strauss@amd.com>, wayne.lin@amd.com,
 Mustapha Ghaddar <Mustapha.Ghaddar@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Currently driver reduces verified link caps on DPIA devices if a link is
trained at a link rate below the max rate verified during link detection.
This blocks high bandwidth modes after setting a low bandwidth mode.

[HOW]
Only update link rate after a successful link train if link is MST.

Reviewed-by: Mustapha Ghaddar <Mustapha.Ghaddar@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 8 ++++++++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c             | 4 ++++
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c          | 7 +++++--
 drivers/gpu/drm/amd/display/dc/dm_helpers.h               | 5 +++++
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index a21e2ba77ddb..b433fab57670 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1009,3 +1009,11 @@ void dm_helpers_enable_periodic_detection(struct dc_context *ctx, bool enable)
 {
 	/* TODO: add periodic detection implementation */
 }
+
+void dm_helpers_dp_mst_update_branch_bandwidth(
+		struct dc_context *ctx,
+		struct dc_link *link)
+{
+	// TODO
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 6990b64c0211..945e9ae4e630 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -4663,6 +4663,10 @@ void dc_link_set_preferred_training_settings(struct dc *dc,
 		link->preferred_link_setting.link_rate = LINK_RATE_UNKNOWN;
 	}
 
+	if (link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT &&
+			link->type == dc_connection_mst_branch)
+		dm_helpers_dp_mst_update_branch_bandwidth(dc->ctx, link);
+
 	/* Retrain now, or wait until next stream update to apply */
 	if (skip_immediate_retrain == false)
 		dc_link_set_preferred_link_settings(dc, &link->preferred_link_setting, link);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index cf9191053365..24e1164b1bee 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2771,8 +2771,11 @@ bool perform_link_training_with_retries(
 					/* Update verified link settings to current one
 					 * Because DPIA LT might fallback to lower link setting.
 					 */
-					link->verified_link_cap.link_rate = link->cur_link_settings.link_rate;
-					link->verified_link_cap.lane_count = link->cur_link_settings.lane_count;
+					if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
+						link->verified_link_cap.link_rate = link->cur_link_settings.link_rate;
+						link->verified_link_cap.lane_count = link->cur_link_settings.lane_count;
+						dm_helpers_dp_mst_update_branch_bandwidth(link->ctx, link);
+					}
 				}
 			} else {
 				status = dc_link_dp_perform_link_training(link,
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index 6abbed22bb20..59ab4f392fc9 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -116,6 +116,11 @@ bool dm_helpers_dp_mst_start_top_mgr(
 bool dm_helpers_dp_mst_stop_top_mgr(
 		struct dc_context *ctx,
 		struct dc_link *link);
+
+void dm_helpers_dp_mst_update_branch_bandwidth(
+		struct dc_context *ctx,
+		struct dc_link *link);
+
 /**
  * OS specific aux read callback.
  */
-- 
2.25.1

