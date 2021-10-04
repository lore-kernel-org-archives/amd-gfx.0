Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05298C4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C38A86113D
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C38A86113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CE396EA08;
	Mon,  4 Oct 2021 14:44:15 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2054.outbound.protection.outlook.com [40.107.102.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22E9A6EA07
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 14:44:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMUA1cJoBRqoyFOu+RMdj/NpDf6oozvRjh8eCCdvJICl5zFaVx5MTSrxvpGhejpzF9mxS7kqpv1lw4awUnjI4itZRuMeXdUN9s+Cht4/aRQiGTRyQ7uLqAlm5wOyDL7d0+hHPLB6lUGsDVUVAAEVoAGvGXk+IUwUJlzGbqmXEItL2l0iQBhxiZYNqf8qDEz0yjpGAEPnIN6drjSxcd3yz/NruPYufNAH0oTMof2o6V1AncD8Bx8VTtwTeoUquJL0i5Qx04FldIaHHTchejKAEeERbLJUhg0gjgsKnz+ql5PDV77xblH3T8W3Fpc3VkOsvi+CB2d0KKrC8TK1FHDt+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFccYn5otprhcT2/7XvMpftfOYRdoKxIz7oY9gzeQp0=;
 b=Eq0cLYmsI0uaspaWVY1cTKfRG0yxdmrLIxeARKLr34CJ4dQ1ud6l9JnK5owjyuXWzzy8PxdW1Q3LfTlQV3S++rLjVN7vZ3A3i/J+J6Lps8tn+LjoHpHWZD4gYwsJf2A9eqLloj0vneQt87Yxld+6tjmBVn51CG4TIfmj6aDGhS0HSxigTHVGgi+C0uPCMcbYX5nsVUgjEJlhbTA7h4Dz5+TcjDfwqRzG7PoirNVnWB1z/VL7kIQ7LkE/URmKtScEzC5E+c5GpdGf12u6aYZQsZN2zpYINPbJAm5fzqwQ4MC2gF/vTr6zeOSen1yD+NA2ghwg8Jv3L2g/LyiyehqZzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFccYn5otprhcT2/7XvMpftfOYRdoKxIz7oY9gzeQp0=;
 b=ANnwyfkHCHs254jQT6hJYgkM3pkX1ghJodjkJprx9kLoAvKtJbF1/2bPx4afOlWzo+OM7DDm4D8xr5FFKC+/c3G1xcTjFtmJ0/Et2OdH9kKy9Qp8aMwDPNjiA5CLMuvksrQ+nSTmcthA6gqolgp2dbCRcLYZXiPAaTLj5ZDi8bA=
Received: from MW4PR03CA0307.namprd03.prod.outlook.com (2603:10b6:303:dd::12)
 by DM6PR12MB3643.namprd12.prod.outlook.com (2603:10b6:5:3d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Mon, 4 Oct
 2021 14:44:12 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::76) by MW4PR03CA0307.outlook.office365.com
 (2603:10b6:303:dd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend
 Transport; Mon, 4 Oct 2021 14:44:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 14:44:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 09:44:09 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Mon, 4 Oct 2021 09:43:56 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Jun Lei <Jun.Lei@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH 13/23] drm/amd/display: Implement end of training for hop in
 DPIA display path
Date: Mon, 4 Oct 2021 22:40:40 +0800
Message-ID: <20211004144050.3425351-14-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004144050.3425351-1-Wayne.Lin@amd.com>
References: <20211004144050.3425351-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9866f2c6-ce5b-4d69-3026-08d987456d84
X-MS-TrafficTypeDiagnostic: DM6PR12MB3643:
X-Microsoft-Antispam-PRVS: <DM6PR12MB36438FE07844D0C066DF2EDAFCAE9@DM6PR12MB3643.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:110;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y6eLU4NoEBiPoE0aPZjQEJhiSd2d5vNdsHZ0+lfiYduv78UzUHL8opaBf39hSkeSVYwHHHPpG+j3icccCrhuw8e+7EUEm0bgfWoRoT3WiNtG7IpBlaCDRTB57QydbRTONZizmo4YJIyBSuxClt1XaxDEv5ygO/GR12WsZ5AvFD5Vjw1Sg3E1MipP5SkYiKvpQtDjn2iqwSBuiWSkA82j7nBTOWsEbogt+apxEtGr1wGWFQorqbp7eZavxPhfePqlLYRv4PmiO1ekYYUY6YW+9WUftN+W7Shyk+eNuLzGVTEihGwu05VHOQwH1YyGRQpYrkSBsLxaEtmSQGveTkCqvQ7p8g+HWf/crdnmm2X6IQOQsfg586WLI4lqFsHpDqVgxcPFyzLO1hpkZmGAqGDJUQXMmweqdolOkMYpk5pPy8tTc/Pom71Wqe4GPcUxanMfmJ9BVoOPa3/cHNCLFKRIxx7gcUmVikgDHpGFKyB+QG10CB8wk81as7aCoewebu14BzrJB3WlY0930k8Tx4h7pi2G3fU03fVbr1Cj7g/2KDNuzWpJve9sOANLyaDwQGojZ7IkJh0RIKJwV+ZmfgIIs70Fe7nreQ8BS4j0EvME7JXPB50XBl/ATfhWAi1F3LEtZN1drABGOpp+9h3Yx9qPkVgMMKgIdZQuA5QQEl5+Di9osdR9/77XRaUa/7nIZY7wFePvcqvoAohNLnqIxDJk8311vF8Tvu9aUZHA3j96yYM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36860700001)(83380400001)(26005)(82310400003)(336012)(47076005)(86362001)(8676002)(5660300002)(426003)(4326008)(186003)(2616005)(8936002)(81166007)(70586007)(70206006)(508600001)(7696005)(356005)(316002)(6916009)(1076003)(6666004)(2906002)(54906003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 14:44:10.8056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9866f2c6-ce5b-4d69-3026-08d987456d84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3643
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

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why & How]
Clear training pattern sequence for hop in display path once clock
recovery and equalization phases of DP tunnel link training completed.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 10 ++-
 .../drm/amd/display/dc/core/dc_link_dpia.c    | 77 ++++++++++++++++++-
 2 files changed, 82 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 7f6fd0a3bf18..bfba1d2c6a18 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2391,14 +2391,20 @@ bool perform_link_training_with_retries(
 			dc_link_dp_perform_link_training_skip_aux(link, &current_setting);
 			return true;
 		} else {
-			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
+			/** @todo Consolidate USB4 DP and DPx.x training. */
+			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) {
 				status = dc_link_dpia_perform_link_training(link,
 									    &current_setting,
 									    skip_video_pattern);
-			else
+
+				/* Transmit idle pattern once training successful. */
+				if (status == LINK_TRAINING_SUCCESS)
+					dp_set_hw_test_pattern(link, DP_TEST_PATTERN_VIDEO_MODE, NULL, 0);
+			} else {
 				status = dc_link_dp_perform_link_training(link,
 									  &current_setting,
 									  skip_video_pattern);
+			}
 
 			if (status == LINK_TRAINING_SUCCESS)
 				return true;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
index fa7539916c77..4b1ad057bd1f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
@@ -730,13 +730,84 @@ static enum link_training_result dpia_training_eq_phase(struct dc_link *link,
 }
 
 /* End training of specified hop in display path. */
+static enum dc_status dpcd_clear_lt_pattern(struct dc_link *link, uint32_t hop)
+{
+	union dpcd_training_pattern dpcd_pattern = { {0} };
+	uint32_t dpcd_tps_offset = DP_TRAINING_PATTERN_SET;
+	enum dc_status status;
+
+	if (hop != DPRX)
+		dpcd_tps_offset = DP_TRAINING_PATTERN_SET_PHY_REPEATER1 +
+			((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (hop - 1));
+
+	status = core_link_write_dpcd(link,
+			DP_TRAINING_PATTERN_SET,
+			&dpcd_pattern.raw,
+			sizeof(dpcd_pattern.raw));
+
+	return status;
+}
+
+/* End training of specified hop in display path.
+ *
+ * In transparent LTTPR mode:
+ * - driver clears training pattern for the specified hop in DPCD.
+ * In non-transparent LTTPR mode:
+ * - in addition to clearing training pattern, driver issues USB4 tunneling
+ * (SET_CONFIG) messages to notify DPOA when training is done for first hop
+ * (DPTX-to-DPIA) and last hop (DPRX).
+ *
+ * @param link DPIA link being trained.
+ * @param hop Hop in display path. DPRX = 0.
+ */
 static enum link_training_result dpia_training_end(struct dc_link *link,
 		uint32_t hop)
 {
-	enum link_training_result result;
+	enum link_training_result result = LINK_TRAINING_SUCCESS;
+	uint8_t repeater_cnt = 0; /* Number of hops/repeaters in display path. */
+	enum dc_status status;
 
-	/** @todo Fail until implemented. */
-	result = LINK_TRAINING_ABORT;
+	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) {
+		repeater_cnt = dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
+
+		if (hop == repeater_cnt) { /* DPTX-to-DPIA */
+			/* Send SET_CONFIG(SET_TRAINING:0xff) to notify DPOA that
+			 * DPTX-to-DPIA hop trained. No DPCD write needed for first hop.
+			 */
+			status = core_link_send_set_config(link,
+					DPIA_SET_CFG_SET_TRAINING,
+					DPIA_TS_UFP_DONE);
+			if (status != DC_OK)
+				result = LINK_TRAINING_ABORT;
+		} else { /* DPOA-to-x */
+			/* Write 0x0 to TRAINING_PATTERN_SET */
+			status = dpcd_clear_lt_pattern(link, hop);
+			if (status != DC_OK)
+				result = LINK_TRAINING_ABORT;
+		}
+
+		/* Notify DPOA that non-transparent link training of DPRX done. */
+		if (hop == DPRX && result != LINK_TRAINING_ABORT) {
+			status = core_link_send_set_config(link,
+					DPIA_SET_CFG_SET_TRAINING,
+					DPIA_TS_DPRX_DONE);
+			if (status != DC_OK)
+				result = LINK_TRAINING_ABORT;
+		}
+
+	} else { /* non-LTTPR or transparent LTTPR. */
+		/* Write 0x0 to TRAINING_PATTERN_SET */
+		status = dpcd_clear_lt_pattern(link, hop);
+		if (status != DC_OK)
+			result = LINK_TRAINING_ABORT;
+	}
+
+	DC_LOG_HW_LINK_TRAINING("%s\n DPIA(%d) end\n - hop(%d)\n - result(%d)\n - LTTPR mode(%d)\n",
+				__func__,
+				link->link_id.enum_id - ENUM_ID_1,
+				hop,
+				result,
+				link->lttpr_mode);
 
 	return result;
 }
-- 
2.25.1

