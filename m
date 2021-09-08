Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFE3C43217
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2AC660724
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F2AC660724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 368A16E1D8;
	Wed,  8 Sep 2021 14:55:00 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2058.outbound.protection.outlook.com [40.107.100.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 252756E1CF
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 14:54:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFtMOjm9bjdEJmKPP9Sep2ccD+R1fKRDM6iswjEikFohmKb/QMNLMbGub88M22wObfqao7xu9siWqWLE6hVr7lTDjSPHFh5FIl369R+ONU6Th7G/faU80vm32lhSx20vT1LgUiAeMaSKyNNnmxV6fMWV94y0A4t8W0lWdLO1bNhS1/4VHRc+14xYQtod2vJpJ0jNsghFZjtPlQGxgH8xzynhHgVneC137dQEqQIdUen7wBAPxDLJW+9Ex7rALp+9TTF85mTgAARfxqf/EqKdSd7/jcaKSGqKVb8Z6pz5pH3FYxSlaWyX34lBjggLaBA4hUirfFNeiYCZFqHB6vTueA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=r6wIxHyNAi/ZVIPsVC5869Veq2OFS80l4dN1d7ZwN2E=;
 b=chFZ+oXodnfiK8KtF7b0GpCQe1eMULT4hoICi4VqyO/VpFTN88kyf1OcnTPNosYxQTnEiCwDD4F/6MntnaEBffyoVfysAnldr20EThleZFMN+N0irxP9Dx0N7h7bLNql7YF1Y+9wPkpaHubxOdLZsNL9k0DHzVc+uhHPEXq2wErG9oAxSPbCaZyMYQdT2BgkahVKUk6W8f+Sz12O0IgbzZmw68ovLhB2ySf186omIO/UxGepbvglM/cTBS4osHkKnqaUmjJhaQjuyk9fhF1MXCOWK3vdKnBsBzezzeUaO9Ax9sPle11GiozLy8P+bkTntnw3S+caZw7zk19puf7U7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6wIxHyNAi/ZVIPsVC5869Veq2OFS80l4dN1d7ZwN2E=;
 b=Lg1mZWASsU0u2EBInbqB3MYwFQXq3Fehfxo9hwjMbOfRH+r3gtThMFw4FjSECPI/0saFzvlLcNRW2Kh9w23b8wN7DUULr4ahIsh9YGAml/OQHof4JV9p9Ipbf+5Dshj5XLPqpAH3RsMZuZCW+jmBTFQC3FqndUmztkhN/NDPCCg=
Received: from DM5PR13CA0014.namprd13.prod.outlook.com (2603:10b6:3:23::24) by
 BY5PR12MB3937.namprd12.prod.outlook.com (2603:10b6:a03:194::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Wed, 8 Sep
 2021 14:54:54 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::85) by DM5PR13CA0014.outlook.office365.com
 (2603:10b6:3:23::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend
 Transport; Wed, 8 Sep 2021 14:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:54:53 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 09:54:47 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito <jimmy.kizito@amd.com>
Subject: [PATCH 11/33] drm/amd/display: Fix for null pointer access for ddc
 pin and aux engine.
Date: Wed, 8 Sep 2021 10:54:02 -0400
Message-ID: <20210908145424.3311-12-mikita.lipski@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4594e1e3-8f9e-4ef5-2904-08d972d89de7
X-MS-TrafficTypeDiagnostic: BY5PR12MB3937:
X-Microsoft-Antispam-PRVS: <BY5PR12MB39370045AA49BB96B6DC2A6FE4D49@BY5PR12MB3937.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:425;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HUy8Onu0zZAD6NpU4/rdChwG2HgJmIj/v4gupCByKKFPgehRmlVIzk2K3teaXIaQ93rxJ/dZBRsIbTbc/sMTXw34HWJ5NWBJ711uKRMo6vJDFYM3loRoB3NbGt6wcHL1g/2yr51RHQG01XqbSRP584J+8Ui4v4C7Xi2Fg3sgTGU1vSE+QAz00wPECtYpLRjACGHK4l/sayvbyiX1a/l14wUC/PX/e/6Bn5Fl1lOOk8jdWgkiL7WKTxhhoYz18nuYvQ3/YhmowZBUeg4UCtq6JL04mcJv/yTVKN8g30Iu8/0DazCWeZ24X2G/Olvkk/lrkYWzc6n/QdDqQLxJBa1n5KQ4RrT7MokLsG4K5pLfxSZCljDLohEokKvfa2vKTu9t9Cy4ryT7/qsPSpfiZXjFzk7Y9nJwtZtt+Q7VbX64Bcobi2M3VjnbJ4vSJ98W65XqEXSQ06u3J7aq8d6k3M0cFCn8tR86A4s/5GWIbuLFNd4BkeHznTSS/qDpGZ+M8vp69XpOvgnpcp5YWdFP5RMSiAsrG6XzsECpdsIJrN7HOOroLLjUuREQnRHHTqmSSl+q4qzKLRcgSwIXgOPGthi4MviQSE+ZToD4O6ozWTcqvY3Dv/FAdw9cu6DX8FQ/++BD9omC/Fv5iqxErgfmO8TZ7ebFa2iMkKNVU3i2eZEvftr0voArbKe5fFgSTagH+E/BzSi+b2YdZYudJcF5YLEXvyR4RC282qsY1xiDJBckTu4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(36840700001)(46966006)(316002)(82740400003)(70206006)(2906002)(4326008)(54906003)(70586007)(36860700001)(6916009)(5660300002)(36756003)(478600001)(81166007)(86362001)(1076003)(8936002)(2616005)(82310400003)(8676002)(47076005)(426003)(336012)(44832011)(83380400001)(356005)(6666004)(26005)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:54:53.6410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4594e1e3-8f9e-4ef5-2904-08d972d89de7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3937
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

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
Need a check for NULL pointer access for ddc pin and aux engine.

[How]
Adding a check for ddc pin and aux engine accesses.

Reviewed-by: Jimmy Kizito <jimmy.kizito@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c   |  2 --
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c         | 12 +++++++++---
 drivers/gpu/drm/amd/display/include/dal_asic_id.h    |  2 +-
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index c5f61be1f6b5..5bfdc66b5867 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -449,9 +449,7 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	struct mod_hdcp_link *link = &hdcp_work[link_index].link;
 	struct drm_connector_state *conn_state;
 	struct dc_sink *sink = NULL;
-#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
 	bool link_is_hdcp14 = false;
-#endif
 
 	if (config->dpms_off) {
 		hdcp_remove_display(hdcp_work, link_index, aconnector);
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index e14f99b4b0c3..4a3b94fa3e40 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -689,8 +689,8 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 	enum aux_return_code_type operation_result;
 	bool retry_on_defer = false;
 	struct ddc *ddc_pin = ddc->ddc_pin;
-	struct dce_aux *aux_engine = ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en];
-	struct aux_engine_dce110 *aux110 = FROM_AUX_ENGINE(aux_engine);
+	struct dce_aux *aux_engine = NULL;
+	struct aux_engine_dce110 *aux110 = NULL;
 	uint32_t defer_time_in_ms = 0;
 
 	int aux_ack_retries = 0,
@@ -699,6 +699,11 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 		aux_timeout_retries = 0,
 		aux_invalid_reply_retries = 0;
 
+	if (ddc_pin) {
+		aux_engine = ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en];
+		aux110 = FROM_AUX_ENGINE(aux_engine);
+	}
+
 	if (!payload->reply) {
 		payload_reply = false;
 		payload->reply = &reply;
@@ -765,7 +770,8 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 							"dce_aux_transfer_with_retries: AUX_RET_SUCCESS: AUX_TRANSACTION_REPLY_AUX_DEFER");
 
 				/* polling_timeout_period is in us */
-				defer_time_in_ms += aux110->polling_timeout_period / 1000;
+				if (aux110)
+					defer_time_in_ms += aux110->polling_timeout_period / 1000;
 				++aux_defer_retries;
 				fallthrough;
 			case AUX_TRANSACTION_REPLY_I2C_OVER_AUX_DEFER:
diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index 381c17caace1..3d2f0817e40a 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -227,7 +227,7 @@ enum {
 #define FAMILY_YELLOW_CARP                     146
 
 #define YELLOW_CARP_A0 0x01
-#define YELLOW_CARP_B0 0x02		// TODO: DCN31 - update with correct B0 ID
+#define YELLOW_CARP_B0 0x20
 #define YELLOW_CARP_UNKNOWN 0xFF
 
 #ifndef ASICREV_IS_YELLOW_CARP
-- 
2.25.1

