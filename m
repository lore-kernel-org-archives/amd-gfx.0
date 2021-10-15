Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED14FC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:43:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B708360C4A
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B708360C4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDD576EDAA;
	Fri, 15 Oct 2021 18:43:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59FBD6EDA7
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:43:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdL2bJNv/hFtsCaUyukkwU17aoPsH5aqLyHMS0x6VfdeYY+YEOjUm/STCVJcozr9v6GoAgDqXWwh5tI8nC7fPUnsFonvJQkZU2374XZ9GsqV6OzGGFKxoXOTJx8NRAas001QdnwMTgmUKQgof46WRji63SnDxokzFV7mMHMuhihFv9DG26T6475lywneaNH9hOJihL9DRwcVlm6WajtVMMsCZywE/d5Wv8W2OfpqBl9NMyEvNQmSyB61zMt16306EHvxhqHjJ/0jkWTIh2XQwVqzr1ewrs/HT7t6Z5uyU4V3QqXreDXEFKtcLiUkyXKc8BPdQjyYX32rQRBHeLHx2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9f2dEIrRJ2IL+04lrkklGl9btWqSdGQIeOF4nfVdArY=;
 b=fHAWcPCAkrpZ9rsLOP3TFdfjjuZ41KliuJJQTzRpMLSk8qdIOwEPF3X2omL5S6mlOlyqxwSzgp2uCoLIIAyqwqJQwsEtKmSCPaVv9t+0980od2zgy/8jiz315jt0l1x8VyxUykd8u1k4WPRpox54YChQfeH6F7OsOP9c4tD6wR3ZCsuT9kSOWfawuHSo95gvlgUgssv5XpupY5HnJaO9jQpftAgAmDlKxRdyojss0Hh3m9yoPC+PVe1pZkgPRFM79dGYJQHJQaz6C98sifiQnthSPKtE0zSeYl4wA9KLvT26vAp7ZfFyeWoA5M/6m+QzWibcjGc6L37cAawj5qonGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9f2dEIrRJ2IL+04lrkklGl9btWqSdGQIeOF4nfVdArY=;
 b=RBVzahcA256v2Csk4Nt4ZmobJswFQe7u1ui6BhQjnuS5Mq2N1kmlJoHqB86/J9OBG2RBVDy8t6+jJAK5OECGP3FWBlwvPXZz0Urdy/iUH397LK+tI9Q3GmxoqR44ybcPaJjZJB22mM61Pm8/TYv3oBrEqCulGXmxIf4G0ssJxOI=
Received: from DM6PR08CA0018.namprd08.prod.outlook.com (2603:10b6:5:80::31) by
 MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.17; Fri, 15 Oct 2021 18:43:52 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::ab) by DM6PR08CA0018.outlook.office365.com
 (2603:10b6:5:80::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Fri, 15 Oct 2021 18:43:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:43:51 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:43:49 -0500
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
Date: Fri, 15 Oct 2021 14:43:08 -0400
Message-ID: <20211015184332.221091-4-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015184332.221091-1-agustin.gutierrez@amd.com>
References: <20211015184332.221091-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62bd5607-485d-4774-5481-08d9900bbbba
X-MS-TrafficTypeDiagnostic: MW3PR12MB4425:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4425449AC21561350FD27655F5B99@MW3PR12MB4425.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lC+adYTg2pmIV6pqXFA/mzzcRzZd6uxbdfs/uKiiD2InSfoklEvIqGnHmEEBroO374g5A8InFRQwObeOqXxKvd8LQLQSAEsSWaSlXWPPNPfXw2JSrQAVFrSXPIRaRshUTxKuVdyuO0ppT9MzXEjmX7NXXsu8U8fzX84qFkGaGsIDJcaP9ArRoIS6F6pnqknoxlEJh1V9h9fiukr/r3JIWWDhWtbLupg4I6sklMm6grJlnr0o2HFw+HuxZqx75PBx/4zPMog2nRPyDOz4qbTZM9ujfIyayfUt0Qw5eC1SlsW6qlTgmj1Kygg/gCK3IaD3nKNC6LMRO7NRf9yBBlrfg+asFCXxCMY1LXAx4i5TdkKZMrwmsCFJODEK/LvVDZcgzTQvaDhKmwS3QFmHVNv14OidfkWoiJlj12RKP8f6BH1mlhJqJtwgWiaF0iws01GjU/uiLayEPsVliF2WODZxK+OrnkRDMt3ES9302kZa9ECywt/m5BCeAbXD6buBq3TuUNmpvgH/LoiLFkEi3vkDg/AL/pCDVmKottvjXMWcTrGwhZvUoEXHMbBV6iMThk0IaL6ZQ9y1Y2KpL7nDT7bhekVeNQWNFrCWH0yw1zd6q+Sh24sl2dkIcK5V2TYiEnCNIyPmAZWvCkQCDq65b3mDYu3GnLTg59qwDWPZW4nQcapkpzSJJ+RTFayWyQ8ORnURQqJWyuEw15F60hWh1FTkxJ+f5Q/57ZqLzewgtlNSj7k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(47076005)(70206006)(70586007)(8936002)(6916009)(36860700001)(86362001)(8676002)(2616005)(4326008)(186003)(81166007)(6666004)(26005)(356005)(16526019)(36756003)(54906003)(2906002)(316002)(83380400001)(44832011)(426003)(82310400003)(336012)(5660300002)(508600001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:43:51.7447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bd5607-485d-4774-5481-08d9900bbbba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425
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

