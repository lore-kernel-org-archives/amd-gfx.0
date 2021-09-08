Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B08C43217
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:54:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AFBA60E77
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2AFBA60E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13BF46E17F;
	Wed,  8 Sep 2021 14:54:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E51E06E17F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 14:54:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uc+7QKxNHJZmKXtSt7cftsLtISVoTTz4vqrD29seIH46GMuB/+ltBFkCGjUEcp+QztrD2jKqFqSwcQ3myfKlmwcIwyL97KCX/78PilYgPcf+alqrk2dRosTAT22f/X788CzcSkYj4MrZiWXZ7XTMW1F7EWUzIo6iCvWja1gP4uoxWYRCj0kCI0oG7IFZF6zgMibnl2K2twTmk1uH18jZobh1luR8qXs0M4iE/O5OOmuGa79j8Xx0dyue/C6nWQ00yu4RgTD1Z6+VbxsXOX71X3NEuMB2Z/jyFxn2ahWg25ve+eRZ99Xefp7oZ1NFx8AkQzeelzP/cOXxeY1lOCMVwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=AfudVVk3VNCZuhnhIwAa09AmQT//INqQ65NABs+JCiA=;
 b=eRtb9RdpHNqyo5u6ow2KfquhifmpY4avT/khRDuFeT0iHm+omUdfVDp/47F3cJ5jgCQoOoSRhwCfb4yNIupffcraUzi6ZfrY82WB5Y8HSHEAtTmkdqEKHJhDFljYK1V93I+7oEgMstmDCkRSG+2aBX2raRSSy4DqOL3TWBgjz287pz+vb940fn6FH7xHnuLRLjfcx+0Vnlv/TClvNirPEf3HnNwd/4h2F6z9Ce74qsp/53OXcTANd5EcAOrxXojbPKDkMEZiL/2Z8RyX6mJMdQAI2GxC9ef8jwN4VFijl9soBBaRhdp5OX4b8HXBmBRWevdQKI5wB9HQ6wuRYYNjzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfudVVk3VNCZuhnhIwAa09AmQT//INqQ65NABs+JCiA=;
 b=E/chnPra5HFKBNxJijS4Z6L2biUnhK7T6opF4nc4vggAIZ4CF9shLbDwDVR5Y+1aehW5pWqkvb441VVdAhgMhnIWio5E5WhykD6m4F+dwy3OVkKSwcmkPt5g/9mljOyifr1/ehDDFGfKhWbYcg7rzvrh1r+9EPGOBHPjxS8pCXY=
Received: from DM5PR07CA0113.namprd07.prod.outlook.com (2603:10b6:4:ae::42) by
 MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 8 Sep
 2021 14:54:36 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::12) by DM5PR07CA0113.outlook.office365.com
 (2603:10b6:4:ae::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 14:54:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:54:36 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 09:54:34 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, "Leo (Hanghong) Ma"
 <hanghong.ma@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 02/33] drm/amd/display: Fix system hang at boot
Date: Wed, 8 Sep 2021 10:53:53 -0400
Message-ID: <20210908145424.3311-3-mikita.lipski@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: bab88178-3d6d-4f15-f74f-08d972d893a7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4128:
X-Microsoft-Antispam-PRVS: <MN2PR12MB41282E41AA853A136C1BDA93E4D49@MN2PR12MB4128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4NeI9xSCRk4RQSYp5mDJHojAopxb2yDhmTYTjERn5TylKCPX+dIzWYD9T+7J+YRN52TbP8w96Q/oFd3oCw8w7xJe/MhPxLLY/fDqHNXvMIihGDhzO2loBwW2e8fNYJNot2vfW+WuHQLFldLpErTQUon2++wBv+aALS25bxf3wFPh4fiepk+wX+xcgBkeJIkE02mDT4jV88qiR1hRdr2TZN2kPMbXBZQ9jeFcz08x54GFq640ZgRm/4ZgWbGrUBYCS7i4zRH2aQGkimngL8u9KMFydXc/3uqES8oF3G9YrU84VnmlneXTHbHOMymYLWRbVPJ8fjyIO68EqM3kDs18WweR5nyawYmnLxAisoz13IdThVFC9715M/qD4uyuaYU1/CnnTE3UzVNhhAq1QZiyqRa97bq3KYc1+++EnPFqDRCs2sfZK7c27ke9jquRBDOeSLIzI/CGNpwFvNz2/Xct1pkky8JCjaDTel1eMHGyacdSl8ih+ilzzRiqc/hjYSuyWKOFItVjR6HFd7WT07thb7hHDK+EU2o/PIl8QDh8OVzngMoeqOCmcj5rwmWQeSlRekEMy2zWQKSI5ofWRbkb62AUv3YSy5F9PE8sJABkGM/HAYNcPX4f7sPRwTzJsfDJDKL2RlnFUl7tL8nhH+9FT4J2MPq5S3KwzqB1jRudqqXmhFHoVQSCQ5z7Mo3YF21ZFuf+kqK8dG7o5/jv69rnWNo1Cw+pek6bd9uFsNN0H58=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6916009)(336012)(47076005)(70586007)(6666004)(2906002)(8936002)(508600001)(4326008)(70206006)(82310400003)(36860700001)(54906003)(16526019)(186003)(44832011)(1076003)(356005)(2616005)(36756003)(5660300002)(316002)(8676002)(86362001)(83380400001)(426003)(81166007)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:54:36.4457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bab88178-3d6d-4f15-f74f-08d972d893a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128
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

From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>

[Why]
During DQE's promotion test, system hang issue is found on linux
system;

[How]
1. Add NULL pointor check for the link in the sequence trace
   function;
2. Get the right link for the stream encoder before blank DP
   stream;

Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
---
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  2 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   | 27 ++++++++++++-------
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 58abfa5a7bac..b9570b7c557b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -64,7 +64,7 @@ void dp_receiver_power_ctrl(struct dc_link *link, bool on)
 
 void dp_source_sequence_trace(struct dc_link *link, uint8_t dp_test_mode)
 {
-	if (link->dc->debug.enable_driver_sequence_debug)
+	if (link != NULL && link->dc->debug.enable_driver_sequence_debug)
 		core_link_write_dpcd(link, DP_SOURCE_SEQUENCE,
 					&dp_test_mode, sizeof(dp_test_mode));
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index cf8fee721f30..2ce668a23fe8 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1638,23 +1638,30 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 
 static void power_down_encoders(struct dc *dc)
 {
-	int i;
-
-	/* do not know BIOS back-front mapping, simply blank all. It will not
-	 * hurt for non-DP
-	 */
-	for (i = 0; i < dc->res_pool->stream_enc_count; i++) {
-		dc->res_pool->stream_enc[i]->funcs->dp_blank(dc->links[i],
-					dc->res_pool->stream_enc[i]);
-	}
+	int i, j;
 
 	for (i = 0; i < dc->link_count; i++) {
 		enum signal_type signal = dc->links[i]->connector_signal;
 
 		if ((signal == SIGNAL_TYPE_EDP) ||
-			(signal == SIGNAL_TYPE_DISPLAY_PORT))
+			(signal == SIGNAL_TYPE_DISPLAY_PORT)) {
+			if (dc->links[i]->link_enc->funcs->get_dig_frontend &&
+				dc->links[i]->link_enc->funcs->is_dig_enabled(dc->links[i]->link_enc)) {
+				unsigned int fe = dc->links[i]->link_enc->funcs->get_dig_frontend(
+									dc->links[i]->link_enc);
+
+				for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
+					if (fe == dc->res_pool->stream_enc[j]->id) {
+						dc->res_pool->stream_enc[j]->funcs->dp_blank(dc->links[i],
+									dc->res_pool->stream_enc[j]);
+						break;
+					}
+				}
+			}
+
 			if (!dc->links[i]->wa_flags.dp_keep_receiver_powered)
 				dp_receiver_power_ctrl(dc->links[i], false);
+		}
 
 		if (signal != SIGNAL_TYPE_EDP)
 			signal = SIGNAL_TYPE_NONE;
-- 
2.25.1

