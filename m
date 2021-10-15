Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7803AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:39:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BAE260BD3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3BAE260BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B68CD6E3AE;
	Fri, 15 Oct 2021 18:39:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A00166E3AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:39:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLYLski8V1N2Vh3gk3EfOdyTnNRFkQQP4P+SdjxeNi1Q9mOhmbcVKwZ99cH3IbpmGj/z23/aPNpp7bQyAbavgaQ0fl4ZSm+SAkYNHcgH9HLpggyeWY782JoPVIkx4gly/FNwELZcgP+x2Mr+w1rSeU1ubDM4Vc/kcVU06bB4y2qmtHvrDUH0NmSKFbV5p9ygY30v1GRYfmVaEQlMTTSHJZyuC/Uq8zL4emqjSvZBtkZVR+mhrG7AejikbVLQPmjUQzbTW73M0Ge22DJC2427CVUa6x4P+5dTVPvgm4YJPbhpOECGwHHA3MdA10UO9E6n2J9Y5zPWX+XLTLMhc1YtHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9f2dEIrRJ2IL+04lrkklGl9btWqSdGQIeOF4nfVdArY=;
 b=VfuMGxF8zschGBmmkRJQ25yga6AgDg+1rHyGdeh1He0nCu8TJsn0uT51vSPKZLXSi9TKRXyxIukJLxitW0CRu3xXqGp98RoNtRfDB4upC6Q5NvRJiDT86KfBpemdNAkQxsg4S3PHzWzKJkJrNI3r9T4cWqWMw1bBJE49UHyi/GleyJDrAp5Dk7dN9U4Lc9o+1Gas5FJUIMTMD50MavZ1Difs64MJcC4bamegrxOHwNcRQh7l4J3OD5yQN/vYKpKBIIpqk01M4Bn+L3GBXoglhLSrdIN9TMqTrjyTW04137Y4EvVUZZbTOJkMKzhY7qQa+YhKNCxIzudHkRZbw6aFHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9f2dEIrRJ2IL+04lrkklGl9btWqSdGQIeOF4nfVdArY=;
 b=a+KwFpMJWN3DmI5pVHK4yF1TGob81VO3L9/SVfH6CYZKMk8kT6AAmkkImihmVqDMgS0gEAW4cfJx9PtWOafSbHtNck02sWZ+XHL6+tds9T7qcKO8wz8yey+EWQGME4PHnMxw/X97r7aeZbMeyQtf7x3ami7UUQZ10z2ux/I7kdc=
Received: from MWHPR04CA0051.namprd04.prod.outlook.com (2603:10b6:300:6c::13)
 by DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Fri, 15 Oct
 2021 18:39:12 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::c4) by MWHPR04CA0051.outlook.office365.com
 (2603:10b6:300:6c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Fri, 15 Oct 2021 18:39:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:39:11 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:39:09 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Jimmy Kizito <Jimmy.Kizito@amd.com>,
 Meenakshikumar Somasundaram <Meenakshikumar.Somasundaram@amd.com>, Jun Lei
 <Jun.Lei@amd.com>
Subject: [PATCH 03/27] drm/amd/display: Do not skip link training on DP quick
 hot plug
Date: Fri, 15 Oct 2021 14:38:21 -0400
Message-ID: <20211015183845.220831-4-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015183845.220831-1-agustin.gutierrez@amd.com>
References: <20211015183845.220831-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01567983-3c31-4e1b-da48-08d9900b14c8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4156:
X-Microsoft-Antispam-PRVS: <DM6PR12MB41565B99AED723EDBA2D906BF5B99@DM6PR12MB4156.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M2C+FrKU+L88Ers8NYPXR08qV45j+Ykf1Hb0Ewcflo/Pj2zwxyy1wbbVT1K+xsLS2vkBxZ4gz6ZLRiD4IJ4BnyLrAj1Zo5x6e1iMA2JS9ixXSNv2rb9GmXMl+G3nmErALfAHkYmKxiPs2/k0y/M8Nu/0pQ9G9RSkwxZ82V4+M4Y7IMxHx8BFKWrBD2pRYhgkHLF5q0qoI95XMKmTnNFZS0wYtq25pPTzOTLFSvAX9onrqCwaKrgNiGnLrtholBA1/TXpcr3+XfO6srT5qxUNChTPmi9GnDSEZic2R5W5DXH4znL0rczA9tVj5CHOVYItZDPtPi5g3EfOBf8gApWGi2K6wzJ07ursrfnp7FSwT9rNVBdJJMIAu+4e2kgRD4U1EL0fBZ3m/vID5M79ylqlN7uYjUryuZUuxohFPL/aS491RFSaLR5DWbAtjhhr1UdV5RdZShW1XThBdd2DtjjxF/bNpatpNYgoT7tQufOzFNAuEQBW2E10IYitMPYkXdF3cIZ11Si6zE8CqgUyNzMxF4Og3tAFJAu4f6vYnG45a4WdSygkb1lbVXDQsUYMxT3+DJ0WKUUGVyZ4qLD04FpqTAk1TzPp9t/PloNVtr30u3MMVJedLMRt7Vy0/okenvDUhciIzQlAKBMuQfx9Yy7ghRca2OOVessXMx3ORW8TnXB7DuMdjfI9umE+RgVEnQYTpDbiJLnwv5QRtbNvhuimsSCHU5oHeAUrnAuLe6ybqSE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70586007)(44832011)(70206006)(8936002)(83380400001)(356005)(336012)(82310400003)(508600001)(54906003)(8676002)(316002)(5660300002)(6916009)(81166007)(426003)(6666004)(16526019)(2906002)(186003)(86362001)(1076003)(26005)(2616005)(4326008)(36860700001)(47076005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:39:11.5934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01567983-3c31-4e1b-da48-08d9900b14c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156
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

[Why]
When rapidly plugging and unplugging a DP sink, detection link
training can be mistakenly skipped.

This is due to the hotplug processing occurring before the
encoder assignment logic has had a chance to process the removal
of a stream. The encoder that would be used for detection link
training is then erroneously reported as already in use and
detection link training is skipped.

[How]
During hot plug processing, only determine a link encoder to be
unavailable for a particular link if it has been assigned to a
different link.

Reviewed-by: Meenakshikumar Somasundaram <Meenakshikumar.Somasundaram@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c      | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c | 9 ++++++---
 drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h     | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 54662d74c65a..8e0b40c7a1ee 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2863,7 +2863,7 @@ bool dp_verify_link_cap(
 		link->verified_link_cap = *known_limit_link_setting;
 		return true;
 	} else if (link->link_enc && link->dc->res_pool->funcs->link_encs_assign &&
-			!link_enc_cfg_is_link_enc_avail(link->ctx->dc, link->link_enc->preferred_engine)) {
+			!link_enc_cfg_is_link_enc_avail(link->ctx->dc, link->link_enc->preferred_engine, link)) {
 		link->verified_link_cap = initial_link_settings;
 		return true;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index 1cab4bf06abe..72b0f8594b4a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -488,16 +488,19 @@ struct link_encoder *link_enc_cfg_get_link_enc_used_by_stream(
 	return link_enc;
 }
 
-bool link_enc_cfg_is_link_enc_avail(struct dc *dc, enum engine_id eng_id)
+bool link_enc_cfg_is_link_enc_avail(struct dc *dc, enum engine_id eng_id, struct dc_link *link)
 {
 	bool is_avail = true;
 	int i;
 
-	/* Add assigned encoders to list. */
+	/* An encoder is not available if it has already been assigned to a different endpoint. */
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct link_enc_assignment assignment = get_assignment(dc, i);
+		struct display_endpoint_id ep_id = (struct display_endpoint_id) {
+				.link_id = link->link_id,
+				.ep_type = link->ep_type};
 
-		if (assignment.valid && assignment.eng_id == eng_id) {
+		if (assignment.valid && assignment.eng_id == eng_id && !are_ep_ids_equal(&ep_id, &assignment.ep_id)) {
 			is_avail = false;
 			break;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h b/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
index 83b2199b2c83..10dcf6a5e9b1 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
@@ -97,7 +97,7 @@ struct link_encoder *link_enc_cfg_get_link_enc_used_by_stream(
 		const struct dc_stream_state *stream);
 
 /* Return true if encoder available to use. */
-bool link_enc_cfg_is_link_enc_avail(struct dc *dc, enum engine_id eng_id);
+bool link_enc_cfg_is_link_enc_avail(struct dc *dc, enum engine_id eng_id, struct dc_link *link);
 
 /* Returns true if encoder assignments in supplied state pass validity checks. */
 bool link_enc_cfg_validate(struct dc *dc, struct dc_state *state);
-- 
2.25.1

