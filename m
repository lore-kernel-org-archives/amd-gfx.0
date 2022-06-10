Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECEACCA47D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 20:53:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 431C4113FC1;
	Fri, 10 Jun 2022 20:53:13 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F1B6113FC0
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 20:53:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kO8kApibVfaIS3PhZu/hapEnsIIboIF9CW9HG7nei0VGV/R5ZHXVFAchBfBCu3z4d1YoroiF/mtCKQFAZeCRf9STTTBjRZ76SmFiROyPiCI5LSNFHOqhXJHnYOyAz6qVtyW8fUOQMWmA/ezwyQIiAGwRuVKSVbXXXW/V3YzxSa0m6PZFbPOzLaY87HdFpF9JkyDN3UyS/+rWdGD8aydzpvLeDpsM7ONYgaC/VWaMzHFok+QJCXHmaTA6rivab5hSq4hh3ar6PSfuNscH24YDi18/sQYqjiJiX4CAis0gPqM0mWHyZfKFmC3Na38fBzb5o/j/Q55/Ndc9d5FociViMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OGNDaHMXwvMwsQf9cr0u6WBJktSLNx3NA6FpDJbGCY=;
 b=keomS2300o/j/GCkXZSZ9ho7dAz3oti4fgYVVbwMAqvcapHIJanyxKiArU/78FEpfwJ+4K5oNJjos2U7G1MwPp2l9o4GFRdNHJSfvk7/VIQnA0nLWhsq3NHjk/od9nJI1xT1SVxP2wynRB6ONzS98wlaoBbMUm3M13M+w0S+dvhPEPljGPxfj5TT6kvSTRFSC+1bXDh95MD4ptPFu9ids6vP3fRdNDknfjpEmTA9srTFbIuYqxdmxBn58umFC2CSNQpmQ9k2FUXq4mwxv1Po3YwD7WYHGyLF7odFJgnGsqI6f1oRvSwsGQELOmEAACNFE/OQeo5xJddING1/1unUQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OGNDaHMXwvMwsQf9cr0u6WBJktSLNx3NA6FpDJbGCY=;
 b=GG9CRpWvyrsmTwDHozvACWY/TGUf0gNN7PYCaFFTuXY4W1sZ369n12RfrhW2g2nHbe21XoL1Oi6WKZZDrLHerCv8HESTNWpFR35V0llV5e6v+gekBHIihT8HEbTkQymqcB7r9wALObSzTXTM0GV5fIY4J/8gvwJa2vHZtYZF69Y=
Received: from MWHPR15CA0033.namprd15.prod.outlook.com (2603:10b6:300:ad::19)
 by PH7PR12MB6586.namprd12.prod.outlook.com (2603:10b6:510:212::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 20:53:10 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::5a) by MWHPR15CA0033.outlook.office365.com
 (2603:10b6:300:ad::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15 via Frontend
 Transport; Fri, 10 Jun 2022 20:53:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 20:53:09 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 15:53:04 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/23] drm/amd/display: Reduce frame size in the bouding box
 for DCN20
Date: Fri, 10 Jun 2022 16:52:26 -0400
Message-ID: <20220610205245.174802-5-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610205245.174802-1-hamza.mahfooz@amd.com>
References: <20220610205245.174802-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44510ad4-0a88-4037-0653-08da4b233a1d
X-MS-TrafficTypeDiagnostic: PH7PR12MB6586:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB658612F9250FD870716B72EDF4A69@PH7PR12MB6586.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZYfi1HTnnVOnFr5WJGrUsVNawJObD/fS+YDw2pOH2J/9a3eLWCnI95jfiQngNbr/LM/Xv9chrRidGSVXjMLpiLHLLbnBk51McDYHOCHu+zzSoaIf2p1lm1Rb+n4C5+WKt2JefpWlq3veNHqGQetpH3kxYLjpqaD4Cjm7Efooz096iU2ZxHk+A4Yan/izfypCIj8k3fYNPaLce5Wd5W/DDO5PjDd6QXH1HfjueaqteUWi533cub0nFzamSW71V52pKVnh8HBUBv6PeMetRoytWgmDWw6GwDdzvUwMYQ7yQ9sQ8P+imOOLI/qpx4X7sTjOuzveFm0hO+d+rfa5NkpxCl02k6At8/6vUJvXCnP0m/90ay+jAddYbd6wWCZzI7q5mFWlYN7ipfQoq1qHAXHWkatBSYaEoj+LuwyNkOObep8PTPHbPtlG7B6dWg/CXvHYiuFF4GDq/ZVkqGKIV4nwIT/isdUTcjxHrw7+TlloOSLT/NAx8TuV3rAycxaNpdstSjnwB9byGvH/asSxQT36RjWcDRcM2Q3WscPTiJW5B4+lXhvd1uivtK6AAn7eCZmKbbXgFWZM6O7lybfW8Hg+Pvs7yy0V0I1COFukhGiphGMCY3B7fNB212l4oRm+qmuaxEKsgkZjYfnGnC5ZBLf1tEHka4CHuSkuGwLJJckQj6UsQuxqnBcivEvgqFe0qyywReSIj8Xhj19azF9SaWPn2XMsojAjXFmSKgo3CSVhVWAwF7Vkt0adPi0lQdiHHTeu
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(356005)(316002)(81166007)(82310400005)(4326008)(8676002)(70586007)(86362001)(40460700003)(6916009)(54906003)(70206006)(44832011)(1076003)(36756003)(2616005)(16526019)(186003)(6666004)(7696005)(426003)(47076005)(336012)(83380400001)(2906002)(26005)(508600001)(8936002)(36860700001)(5660300002)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 20:53:09.3828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44510ad4-0a88-4037-0653-08da4b233a1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6586
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

GCC throw warnings for the function dcn20_update_bounding_box due to its
frame size that looks like this:

 error: the frame size of 1936 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

This commit fixes this issue by eliminating an intermediary variable
that creates a large array.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 38 +++++++++----------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index eeec40f6fd0a..d9cc178f6980 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -1456,21 +1456,20 @@ void dcn20_calculate_wm(
 void dcn20_update_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st *bb,
 		struct pp_smu_nv_clock_table *max_clocks, unsigned int *uclk_states, unsigned int num_states)
 {
-	struct _vcs_dpi_voltage_scaling_st calculated_states[DC__VOLTAGE_STATES];
-	int i;
 	int num_calculated_states = 0;
 	int min_dcfclk = 0;
+	int i;
 
 	dc_assert_fp_enabled();
 
 	if (num_states == 0)
 		return;
 
-	memset(calculated_states, 0, sizeof(calculated_states));
+	memset(bb->clock_limits, 0, sizeof(bb->clock_limits));
 
-	if (dc->bb_overrides.min_dcfclk_mhz > 0)
+	if (dc->bb_overrides.min_dcfclk_mhz > 0) {
 		min_dcfclk = dc->bb_overrides.min_dcfclk_mhz;
-	else {
+	} else {
 		if (ASICREV_IS_NAVI12_P(dc->ctx->asic_id.hw_internal_rev))
 			min_dcfclk = 310;
 		else
@@ -1481,36 +1480,35 @@ void dcn20_update_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_s
 
 	for (i = 0; i < num_states; i++) {
 		int min_fclk_required_by_uclk;
-		calculated_states[i].state = i;
-		calculated_states[i].dram_speed_mts = uclk_states[i] * 16 / 1000;
+		bb->clock_limits[i].state = i;
+		bb->clock_limits[i].dram_speed_mts = uclk_states[i] * 16 / 1000;
 
 		// FCLK:UCLK ratio is 1.08
 		min_fclk_required_by_uclk = div_u64(((unsigned long long)uclk_states[i]) * 1080,
 			1000000);
 
-		calculated_states[i].fabricclk_mhz = (min_fclk_required_by_uclk < min_dcfclk) ?
+		bb->clock_limits[i].fabricclk_mhz = (min_fclk_required_by_uclk < min_dcfclk) ?
 				min_dcfclk : min_fclk_required_by_uclk;
 
-		calculated_states[i].socclk_mhz = (calculated_states[i].fabricclk_mhz > max_clocks->socClockInKhz / 1000) ?
-				max_clocks->socClockInKhz / 1000 : calculated_states[i].fabricclk_mhz;
+		bb->clock_limits[i].socclk_mhz = (bb->clock_limits[i].fabricclk_mhz > max_clocks->socClockInKhz / 1000) ?
+				max_clocks->socClockInKhz / 1000 : bb->clock_limits[i].fabricclk_mhz;
 
-		calculated_states[i].dcfclk_mhz = (calculated_states[i].fabricclk_mhz > max_clocks->dcfClockInKhz / 1000) ?
-				max_clocks->dcfClockInKhz / 1000 : calculated_states[i].fabricclk_mhz;
+		bb->clock_limits[i].dcfclk_mhz = (bb->clock_limits[i].fabricclk_mhz > max_clocks->dcfClockInKhz / 1000) ?
+				max_clocks->dcfClockInKhz / 1000 : bb->clock_limits[i].fabricclk_mhz;
 
-		calculated_states[i].dispclk_mhz = max_clocks->displayClockInKhz / 1000;
-		calculated_states[i].dppclk_mhz = max_clocks->displayClockInKhz / 1000;
-		calculated_states[i].dscclk_mhz = max_clocks->displayClockInKhz / (1000 * 3);
+		bb->clock_limits[i].dispclk_mhz = max_clocks->displayClockInKhz / 1000;
+		bb->clock_limits[i].dppclk_mhz = max_clocks->displayClockInKhz / 1000;
+		bb->clock_limits[i].dscclk_mhz = max_clocks->displayClockInKhz / (1000 * 3);
 
-		calculated_states[i].phyclk_mhz = max_clocks->phyClockInKhz / 1000;
+		bb->clock_limits[i].phyclk_mhz = max_clocks->phyClockInKhz / 1000;
 
 		num_calculated_states++;
 	}
 
-	calculated_states[num_calculated_states - 1].socclk_mhz = max_clocks->socClockInKhz / 1000;
-	calculated_states[num_calculated_states - 1].fabricclk_mhz = max_clocks->socClockInKhz / 1000;
-	calculated_states[num_calculated_states - 1].dcfclk_mhz = max_clocks->dcfClockInKhz / 1000;
+	bb->clock_limits[num_calculated_states - 1].socclk_mhz = max_clocks->socClockInKhz / 1000;
+	bb->clock_limits[num_calculated_states - 1].fabricclk_mhz = max_clocks->socClockInKhz / 1000;
+	bb->clock_limits[num_calculated_states - 1].dcfclk_mhz = max_clocks->dcfClockInKhz / 1000;
 
-	memcpy(bb->clock_limits, calculated_states, sizeof(bb->clock_limits));
 	bb->num_states = num_calculated_states;
 
 	// Duplicate the last state, DML always an extra state identical to max state to work
-- 
2.36.1

