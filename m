Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7A5EB64D9
	for <amd-gfx@archiver.kernel.org>; Sat, 17 Jun 2023 15:56:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1D3210E057;
	Sat, 17 Jun 2023 15:56:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41F2410E057
 for <amd-gfx@lists.freedesktop.org>; Sat, 17 Jun 2023 15:56:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FM+OAW+aPEgTvl6VsidNgRO9SfCHIC4CjSQYphwTfDH/htilx5dtTOrc+fz3LDz+s+AL50DmBF+WqYcleMcfvgqFNbTeIp6VB+qz+ko9q3c8nPn2ZvIUk7MYS3xLXaHUNXD1f8lHdHjgxj1z6ETEy15km3m0PBxS/AqBJBieNtfdFl23/G4X8GQ6K2feuQWiZKpewW35PWDQNuuzC2WPR9XdCLC69epY6g2GNG5GBhZCcaO5Q6kcoY+UowYJ9uT7KR1debjnCyZqjRFltqcIo53N2eSpsoBJWaeiz3U2gDx34Q429UhO9NSKZ4vxy/1z1neCaEuFw+4oK3d1Q9GnBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4h9QdrE7xyRdEL1FYZqlWWme66pMtQsXjU3k/nmPvsU=;
 b=PLQKe5KZWx4aHYyFhK403u6RX2rpjgMwmFh0LxzpYlPAi6T33WgnhBApe01xRybyhx9gld+KJWnjxpOu4LrcukeAG+f/3YEwzXfiAF/EKT+7j2Mz64S9Y9JKSliYkX1YWs+eFF2rTSuvU5JTjiT74PgypKGsM0dAUWPJ6qQJh+xhUOl94HpMoy1+KlPGH8k9gtYmnobPJyEzRlgT4KmN5l8hYK/rpwbq13j4BoI7AuEOalKvqj7EY7w1JFtXUbdubK4d22EgWG2/QX+4bX3qO3Vd7ZRO5E95qKoq65CjjTkQskDWU4EaHHaA/7HIvqBf4R02LAChSFCy7kW9NSbcfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4h9QdrE7xyRdEL1FYZqlWWme66pMtQsXjU3k/nmPvsU=;
 b=Zqqkd5HXPi5+gGK7a6p37G2W/qpLeAxQO7PJ8MqvHNGf6R7BSAe2eUfXn3CXTdCTwChRcwqL0esPQTKcu6vVNr+Ly4YQImNKEfbGTC7RGklcO12xbMOUiMiZ3g4BA6SKXhQKbSpKBjSxSpeBS2oc5ljv8aTXNPtjFxm6c6WRQJc=
Received: from CY5PR17CA0060.namprd17.prod.outlook.com (2603:10b6:930:12::27)
 by DM4PR12MB7598.namprd12.prod.outlook.com (2603:10b6:8:10a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Sat, 17 Jun
 2023 15:56:25 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:12:cafe::82) by CY5PR17CA0060.outlook.office365.com
 (2603:10b6:930:12::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29 via Frontend
 Transport; Sat, 17 Jun 2023 15:56:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Sat, 17 Jun 2023 15:56:25 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 17 Jun
 2023 10:56:22 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Fix errors & warnings in amdgpu_dm.c
Date: Sat, 17 Jun 2023 21:26:08 +0530
Message-ID: <20230617155608.3689171-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|DM4PR12MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b4d305c-b83f-496f-f369-08db6f4b67c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7PUKp0Wkio+Y6YTmUh4Ioh8UEhXZq2hRS9W8dU6Fat01zTkuQQkHkbTHA5ngE6e03rt+gEuSkkAuUk9kpZEyq4UGIV7/690LzM3+UFuHRjDbIOEHH0pdaGJDIxJT+D/B9afgvFTGBMESd59BfLBWvzP3eRyqXITAn0gyUdw8OqbAks7wWT3VYdwBRmq5qawiICfA303OvCtgRYVuYNfkWKbz0WJdvwSmUoNT7BSi11gyCOj8QznAd2TAE+b7dqV8QaWBur1Srd2sqre0OFByir5VYjlWYuo/cmj1Vti9F4GqS15bE+Y+rC8VvzJN84A0xYS2jnWZMBodXftBn3I3ArHe/xKd+R+gZ6+lLcSttCgX56bIV40kTSRfEZg/xgprA4B7XOGBBOTiHpFKistFxYbS1R1kZax3BSKOcF293woYRyRlCiGHYSsDqsTfMbfwQcsWuzfOMcrgarkQvt2eMeSW+BetjYk5K50v8UEvI9wd53QEnQgJFU00CHjAmcPJPE/D8Vh4niNzt92Y3wVKNQZREkxI07tX0TjtWfeKrNcW+Xi3Ao2wbMyomTMvfVk7Whs91Gx1pq3dsfdFC2j6Bu3a9hNot2BuzzEqJCZL1uO5pcDX3R/lxgZrDNVtkW1ozWJHrWkeQKnhWja6/hF/l+rRsZ1Y5sDi5uA9Uo1eu5Llspen7YN2R1slJh76U2v8ypzPox18fYPnn8wSyp2+cgcTZ6EEAWlbp9F+DLB8gwblPtCXeSyro3WPcSOAnsyRN95P/bQsP4sKnZXqNdcfwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(83380400001)(26005)(82740400003)(5660300002)(81166007)(2616005)(336012)(1076003)(426003)(2906002)(186003)(356005)(16526019)(30864003)(44832011)(36860700001)(47076005)(478600001)(40480700001)(40460700003)(70206006)(316002)(8936002)(6666004)(7696005)(86362001)(41300700001)(8676002)(4326008)(36756003)(6636002)(70586007)(82310400005)(110136005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2023 15:56:25.5892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4d305c-b83f-496f-f369-08db6f4b67c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following errors & warnings reported by checkpatch:

ERROR: space required before the open brace '{'
ERROR: space required before the open parenthesis '('
ERROR: that open brace { should be on the previous line
ERROR: space prohibited before that ',' (ctx:WxW)
ERROR: else should follow close brace '}'
ERROR: open brace '{' following function definitions go on the next line
ERROR: code indent should use tabs where possible

WARNING: braces {} are not necessary for single statement blocks
WARNING: void function return statements are not generally useful
WARNING: Block comments use * on subsequent lines
WARNING: Block comments use a trailing */ on a separate line

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 133 +++++++++---------
 1 file changed, 65 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2446529c329a..5e28899bb167 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -424,12 +424,12 @@ static void dm_pflip_high_irq(void *interrupt_params)
 
 	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
 
-	if (amdgpu_crtc->pflip_status != AMDGPU_FLIP_SUBMITTED){
-		DC_LOG_PFLIP("amdgpu_crtc->pflip_status = %d !=AMDGPU_FLIP_SUBMITTED(%d) on crtc:%d[%p] \n",
-						 amdgpu_crtc->pflip_status,
-						 AMDGPU_FLIP_SUBMITTED,
-						 amdgpu_crtc->crtc_id,
-						 amdgpu_crtc);
+	if (amdgpu_crtc->pflip_status != AMDGPU_FLIP_SUBMITTED) {
+		DC_LOG_PFLIP("amdgpu_crtc->pflip_status = %d !=AMDGPU_FLIP_SUBMITTED(%d) on crtc:%d[%p]\n",
+			     amdgpu_crtc->pflip_status,
+			     AMDGPU_FLIP_SUBMITTED,
+			     amdgpu_crtc->crtc_id,
+			     amdgpu_crtc);
 		spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 		return;
 	}
@@ -883,7 +883,7 @@ static int dm_set_powergating_state(void *handle,
 }
 
 /* Prototypes of private functions */
-static int dm_early_init(void* handle);
+static int dm_early_init(void *handle);
 
 /* Allocate memory for FBC compressed data  */
 static void amdgpu_dm_fbc_init(struct drm_connector *connector)
@@ -1282,7 +1282,7 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 	pa_config->system_aperture.start_addr = (uint64_t)logical_addr_low << 18;
 	pa_config->system_aperture.end_addr = (uint64_t)logical_addr_high << 18;
 
-	pa_config->system_aperture.agp_base = (uint64_t)agp_base << 24 ;
+	pa_config->system_aperture.agp_base = (uint64_t)agp_base << 24;
 	pa_config->system_aperture.agp_bot = (uint64_t)agp_bot << 24;
 	pa_config->system_aperture.agp_top = (uint64_t)agp_top << 24;
 
@@ -1365,8 +1365,7 @@ static void dm_handle_hpd_rx_offload_work(struct work_struct *work)
 		DP_TEST_RESPONSE,
 		&test_response.raw,
 		sizeof(test_response));
-	}
-	else if ((dc_link->connector_signal != SIGNAL_TYPE_EDP) &&
+	} else if ((dc_link->connector_signal != SIGNAL_TYPE_EDP) &&
 			dc_link_check_link_loss_status(dc_link, &offload_work->data) &&
 			dc_link_dp_allow_hpd_rx_irq(dc_link)) {
 		/* offload_work->data is from handle_hpd_rx_irq->
@@ -1554,7 +1553,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	mutex_init(&adev->dm.dc_lock);
 	mutex_init(&adev->dm.audio_lock);
 
-	if(amdgpu_dm_irq_init(adev)) {
+	if (amdgpu_dm_irq_init(adev)) {
 		DRM_ERROR("amdgpu: failed to initialize DM IRQ support.\n");
 		goto error;
 	}
@@ -1696,9 +1695,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	if (amdgpu_dc_debug_mask & DC_DISABLE_STUTTER)
 		adev->dm.dc->debug.disable_stutter = true;
 
-	if (amdgpu_dc_debug_mask & DC_DISABLE_DSC) {
+	if (amdgpu_dc_debug_mask & DC_DISABLE_DSC)
 		adev->dm.dc->debug.disable_dsc = true;
-	}
 
 	if (amdgpu_dc_debug_mask & DC_DISABLE_CLOCK_GATING)
 		adev->dm.dc->debug.disable_clock_gate = true;
@@ -1942,8 +1940,6 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 	mutex_destroy(&adev->dm.audio_lock);
 	mutex_destroy(&adev->dm.dc_lock);
 	mutex_destroy(&adev->dm.dpia_aux_lock);
-
-	return;
 }
 
 static int load_dmcu_fw(struct amdgpu_device *adev)
@@ -1952,7 +1948,7 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 	int r;
 	const struct dmcu_firmware_header_v1_0 *hdr;
 
-	switch(adev->asic_type) {
+	switch (adev->asic_type) {
 #if defined(CONFIG_DRM_AMD_DC_SI)
 	case CHIP_TAHITI:
 	case CHIP_PITCAIRN:
@@ -2709,7 +2705,7 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 		struct dc_scaling_info scaling_infos[MAX_SURFACES];
 		struct dc_flip_addrs flip_addrs[MAX_SURFACES];
 		struct dc_stream_update stream_update;
-	} * bundle;
+	} *bundle;
 	int k, m;
 
 	bundle = kzalloc(sizeof(*bundle), GFP_KERNEL);
@@ -2739,8 +2735,6 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 
 cleanup:
 	kfree(bundle);
-
-	return;
 }
 
 static int dm_resume(void *handle)
@@ -2954,8 +2948,7 @@ static const struct amd_ip_funcs amdgpu_dm_funcs = {
 	.set_powergating_state = dm_set_powergating_state,
 };
 
-const struct amdgpu_ip_block_version dm_ip_block =
-{
+const struct amdgpu_ip_block_version dm_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_DCE,
 	.major = 1,
 	.minor = 0,
@@ -3000,9 +2993,12 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 	caps->ext_caps = &aconnector->dc_link->dpcd_sink_ext_caps;
 	caps->aux_support = false;
 
-	if (caps->ext_caps->bits.oled == 1 /*||
-	    caps->ext_caps->bits.sdr_aux_backlight_control == 1 ||
-	    caps->ext_caps->bits.hdr_aux_backlight_control == 1*/)
+	if (caps->ext_caps->bits.oled == 1
+	    /*
+	     * ||
+	     * caps->ext_caps->bits.sdr_aux_backlight_control == 1 ||
+	     * caps->ext_caps->bits.hdr_aux_backlight_control == 1
+	     */)
 		caps->aux_support = true;
 
 	if (amdgpu_backlight == 0)
@@ -3269,6 +3265,7 @@ static void dm_handle_mst_sideband_msg(struct amdgpu_dm_connector *aconnector)
 		process_count < max_process_count) {
 		u8 ack[DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI] = {};
 		u8 retry;
+
 		dret = 0;
 
 		process_count++;
@@ -3468,7 +3465,7 @@ static void register_hpd_handlers(struct amdgpu_device *adev)
 		aconnector = to_amdgpu_dm_connector(connector);
 		dc_link = aconnector->dc_link;
 
-		if (DC_IRQ_SOURCE_INVALID != dc_link->irq_source_hpd) {
+		if (dc_link->irq_source_hpd != DC_IRQ_SOURCE_INVALID) {
 			int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
 			int_params.irq_source = dc_link->irq_source_hpd;
 
@@ -3477,7 +3474,7 @@ static void register_hpd_handlers(struct amdgpu_device *adev)
 					(void *) aconnector);
 		}
 
-		if (DC_IRQ_SOURCE_INVALID != dc_link->irq_source_hpd_rx) {
+		if (dc_link->irq_source_hpd_rx != DC_IRQ_SOURCE_INVALID) {
 
 			/* Also register for DP short pulse (hpd_rx). */
 			int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
@@ -3503,7 +3500,7 @@ static int dce60_register_irq_handlers(struct amdgpu_device *adev)
 	struct dc_interrupt_params int_params = {0};
 	int r;
 	int i;
-	unsigned client_id = AMDGPU_IRQ_CLIENTID_LEGACY;
+	unsigned int client_id = AMDGPU_IRQ_CLIENTID_LEGACY;
 
 	int_params.requested_polarity = INTERRUPT_POLARITY_DEFAULT;
 	int_params.current_polarity = INTERRUPT_POLARITY_DEFAULT;
@@ -3517,11 +3514,12 @@ static int dce60_register_irq_handlers(struct amdgpu_device *adev)
 	 *    Base driver will call amdgpu_dm_irq_handler() for ALL interrupts
 	 *    coming from DC hardware.
 	 *    amdgpu_dm_irq_handler() will re-direct the interrupt to DC
-	 *    for acknowledging and handling. */
+	 *    for acknowledging and handling.
+	 */
 
 	/* Use VBLANK interrupt */
 	for (i = 0; i < adev->mode_info.num_crtc; i++) {
-		r = amdgpu_irq_add_id(adev, client_id, i+1 , &adev->crtc_irq);
+		r = amdgpu_irq_add_id(adev, client_id, i + 1, &adev->crtc_irq);
 		if (r) {
 			DRM_ERROR("Failed to add crtc irq id!\n");
 			return r;
@@ -3529,7 +3527,7 @@ static int dce60_register_irq_handlers(struct amdgpu_device *adev)
 
 		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
 		int_params.irq_source =
-			dc_interrupt_to_irq_source(dc, i+1 , 0);
+			dc_interrupt_to_irq_source(dc, i + 1, 0);
 
 		c_irq_params = &adev->dm.vblank_params[int_params.irq_source - DC_IRQ_SOURCE_VBLANK1];
 
@@ -3585,7 +3583,7 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 	struct dc_interrupt_params int_params = {0};
 	int r;
 	int i;
-	unsigned client_id = AMDGPU_IRQ_CLIENTID_LEGACY;
+	unsigned int client_id = AMDGPU_IRQ_CLIENTID_LEGACY;
 
 	if (adev->family >= AMDGPU_FAMILY_AI)
 		client_id = SOC15_IH_CLIENTID_DCE;
@@ -3602,7 +3600,8 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 	 *    Base driver will call amdgpu_dm_irq_handler() for ALL interrupts
 	 *    coming from DC hardware.
 	 *    amdgpu_dm_irq_handler() will re-direct the interrupt to DC
-	 *    for acknowledging and handling. */
+	 *    for acknowledging and handling.
+	 */
 
 	/* Use VBLANK interrupt */
 	for (i = VISLANDS30_IV_SRCID_D1_VERTICAL_INTERRUPT0; i <= VISLANDS30_IV_SRCID_D6_VERTICAL_INTERRUPT0; i++) {
@@ -4049,7 +4048,7 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
 }
 
 static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
-				unsigned *min, unsigned *max)
+				unsigned int *min, unsigned int *max)
 {
 	if (!caps)
 		return 0;
@@ -4069,7 +4068,7 @@ static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
 					uint32_t brightness)
 {
-	unsigned min, max;
+	unsigned int min, max;
 
 	if (!get_brightness_range(caps, &min, &max))
 		return brightness;
@@ -4082,7 +4081,7 @@ static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *c
 static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
 				      uint32_t brightness)
 {
-	unsigned min, max;
+	unsigned int min, max;
 
 	if (!get_brightness_range(caps, &min, &max))
 		return brightness;
@@ -4566,7 +4565,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 static void amdgpu_dm_destroy_drm_device(struct amdgpu_display_manager *dm)
 {
 	drm_atomic_private_obj_fini(&dm->atomic_obj);
-	return;
 }
 
 /******************************************************************************
@@ -5403,6 +5401,7 @@ static bool adjust_colour_depth_from_display_info(
 {
 	enum dc_color_depth depth = timing_out->display_color_depth;
 	int normalized_clk;
+
 	do {
 		normalized_clk = timing_out->pix_clk_100hz / 10;
 		/* YCbCr 4:2:0 requires additional adjustment of 1/2 */
@@ -5618,6 +5617,7 @@ create_fake_sink(struct amdgpu_dm_connector *aconnector)
 {
 	struct dc_sink_init_data sink_init_data = { 0 };
 	struct dc_sink *sink = NULL;
+
 	sink_init_data.link = aconnector->dc_link;
 	sink_init_data.sink_signal = aconnector->dc_link->connector_signal;
 
@@ -5741,7 +5741,7 @@ get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
 		return &aconnector->freesync_vid_base;
 
 	/* Find the preferred mode */
-	list_for_each_entry (m, list_head, head) {
+	list_for_each_entry(m, list_head, head) {
 		if (m->type & DRM_MODE_TYPE_PREFERRED) {
 			m_pref = m;
 			break;
@@ -5765,7 +5765,7 @@ get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
 	 * For some monitors, preferred mode is not the mode with highest
 	 * supported refresh rate.
 	 */
-	list_for_each_entry (m, list_head, head) {
+	list_for_each_entry(m, list_head, head) {
 		current_refresh  = drm_mode_vrefresh(m);
 
 		if (m->hdisplay == m_pref->hdisplay &&
@@ -6037,7 +6037,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 		 * This may not be an error, the use case is when we have no
 		 * usermode calls to reset and set mode upon hotplug. In this
 		 * case, we call set mode ourselves to restore the previous mode
-		 * and the modelist may not be filled in in time.
+		 * and the modelist may not be filled in time.
 		 */
 		DRM_DEBUG_DRIVER("No preferred mode found\n");
 	} else {
@@ -6060,9 +6060,9 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 		drm_mode_set_crtcinfo(&mode, 0);
 
 	/*
-	* If scaling is enabled and refresh rate didn't change
-	* we copy the vic and polarities of the old timings
-	*/
+	 * If scaling is enabled and refresh rate didn't change
+	 * we copy the vic and polarities of the old timings
+	 */
 	if (!scale || mode_refresh != preferred_refresh)
 		fill_stream_properties_from_drm_display_mode(
 			stream, &mode, &aconnector->base, con_state, NULL,
@@ -6826,6 +6826,7 @@ static int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
 
 	if (!state->duplicated) {
 		int max_bpc = conn_state->max_requested_bpc;
+
 		is_y420 = drm_mode_is_420_also(&connector->display_info, adjusted_mode) &&
 			  aconnector->force_yuv420_output;
 		color_depth = convert_color_depth_from_display_info(connector,
@@ -7144,7 +7145,7 @@ static bool is_duplicate_mode(struct amdgpu_dm_connector *aconnector,
 {
 	struct drm_display_mode *m;
 
-	list_for_each_entry (m, &aconnector->base.probed_modes, head) {
+	list_for_each_entry(m, &aconnector->base.probed_modes, head) {
 		if (drm_mode_equal(m, mode))
 			return true;
 	}
@@ -7469,7 +7470,6 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 
 	link->priv = aconnector;
 
-	DRM_DEBUG_DRIVER("%s()\n", __func__);
 
 	i2c = create_i2c(link->ddc, link->link_index, &res);
 	if (!i2c) {
@@ -8183,8 +8183,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			 * DRI3/Present extension with defined target_msc.
 			 */
 			last_flip_vblank = amdgpu_get_vblank_counter_kms(pcrtc);
-		}
-		else {
+		} else {
 			/* For variable refresh rate mode only:
 			 * Get vblank of last completed flip to avoid > 1 vrr
 			 * flips per video frame by use of throttling, but allow
@@ -8517,8 +8516,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		dc_resource_state_copy_construct_current(dm->dc, dc_state);
 	}
 
-	for_each_oldnew_crtc_in_state (state, crtc, old_crtc_state,
-				       new_crtc_state, i) {
+	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
+				      new_crtc_state, i) {
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
@@ -8541,9 +8540,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
 
 		drm_dbg_state(state->dev,
-			"amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, "
-			"planes_changed:%d, mode_changed:%d,active_changed:%d,"
-			"connectors_changed:%d\n",
+			"amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, planes_changed:%d, mode_changed:%d,active_changed:%d,connectors_changed:%d\n",
 			acrtc->crtc_id,
 			new_crtc_state->enable,
 			new_crtc_state->active,
@@ -9119,8 +9116,8 @@ static int do_aquire_global_lock(struct drm_device *dev,
 					&commit->flip_done, 10*HZ);
 
 		if (ret == 0)
-			DRM_ERROR("[CRTC:%d:%s] hw_done or flip_done "
-				  "timed out\n", crtc->base.id, crtc->name);
+			DRM_ERROR("[CRTC:%d:%s] hw_done or flip_done timed out\n",
+				  crtc->base.id, crtc->name);
 
 		drm_crtc_commit_put(commit);
 	}
@@ -9205,7 +9202,8 @@ is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
 	return false;
 }
 
-static void set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state) {
+static void set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state)
+{
 	u64 num, den, res;
 	struct drm_crtc_state *new_crtc_state = &dm_new_crtc_state->base;
 
@@ -9327,9 +9325,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		goto skip_modeset;
 
 	drm_dbg_state(state->dev,
-		"amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, "
-		"planes_changed:%d, mode_changed:%d,active_changed:%d,"
-		"connectors_changed:%d\n",
+		"amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, planes_changed:%d, mode_changed:%d,active_changed:%d,connectors_changed:%d\n",
 		acrtc->crtc_id,
 		new_crtc_state->enable,
 		new_crtc_state->active,
@@ -9358,8 +9354,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 						     old_crtc_state)) {
 			new_crtc_state->mode_changed = false;
 			DRM_DEBUG_DRIVER(
-				"Mode change not required for front porch change, "
-				"setting mode_changed to %d",
+				"Mode change not required for front porch change, setting mode_changed to %d",
 				new_crtc_state->mode_changed);
 
 			set_freesync_fixed_config(dm_new_crtc_state);
@@ -9371,9 +9366,8 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 			struct drm_display_mode *high_mode;
 
 			high_mode = get_highest_refresh_rate_mode(aconnector, false);
-			if (!drm_mode_equal(&new_crtc_state->mode, high_mode)) {
+			if (!drm_mode_equal(&new_crtc_state->mode, high_mode))
 				set_freesync_fixed_config(dm_new_crtc_state);
-			}
 		}
 
 		ret = dm_atomic_get_state(state, &dm_state);
@@ -9541,6 +9535,7 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 	 */
 	for_each_oldnew_plane_in_state(state, other, old_other_state, new_other_state, i) {
 		struct amdgpu_framebuffer *old_afb, *new_afb;
+
 		if (other->type == DRM_PLANE_TYPE_CURSOR)
 			continue;
 
@@ -9639,11 +9634,12 @@ static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
 	}
 
 	/* Core DRM takes care of checking FB modifiers, so we only need to
-	 * check tiling flags when the FB doesn't have a modifier. */
+	 * check tiling flags when the FB doesn't have a modifier.
+	 */
 	if (!(fb->flags & DRM_MODE_FB_MODIFIERS)) {
 		if (adev->family < AMDGPU_FAMILY_AI) {
 			linear = AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) != DC_ARRAY_2D_TILED_THIN1 &&
-			         AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) != DC_ARRAY_1D_TILED_THIN1 &&
+				 AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) != DC_ARRAY_1D_TILED_THIN1 &&
 				 AMDGPU_TILING_GET(afb->tiling_flags, MICRO_TILE_MODE) == 0;
 		} else {
 			linear = AMDGPU_TILING_GET(afb->tiling_flags, SWIZZLE_MODE) == 0;
@@ -9865,12 +9861,12 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
 	/* On DCE and DCN there is no dedicated hardware cursor plane. We get a
 	 * cursor per pipe but it's going to inherit the scaling and
 	 * positioning from the underlying pipe. Check the cursor plane's
-	 * blending properties match the underlying planes'. */
+	 * blending properties match the underlying planes'.
+	 */
 
 	new_cursor_state = drm_atomic_get_new_plane_state(state, cursor);
-	if (!new_cursor_state || !new_cursor_state->fb) {
+	if (!new_cursor_state || !new_cursor_state->fb)
 		return 0;
-	}
 
 	dm_get_oriented_plane_size(new_cursor_state, &cursor_src_w, &cursor_src_h);
 	cursor_scale_w = new_cursor_state->crtc_w * 1000 / cursor_src_w;
@@ -9915,6 +9911,7 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm
 	struct drm_connector_state *conn_state, *old_conn_state;
 	struct amdgpu_dm_connector *aconnector = NULL;
 	int i;
+
 	for_each_oldnew_connector_in_state(state, connector, old_conn_state, conn_state, i) {
 		if (!conn_state->crtc)
 			conn_state = old_conn_state;
@@ -10349,7 +10346,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	}
 
 	/* Store the overall update type for use later in atomic check. */
-	for_each_new_crtc_in_state (state, crtc, new_crtc_state, i) {
+	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
 		struct dm_crtc_state *dm_new_crtc_state =
 			to_dm_crtc_state(new_crtc_state);
 
@@ -10371,7 +10368,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	else if (ret == -EINTR || ret == -EAGAIN || ret == -ERESTARTSYS)
 		DRM_DEBUG_DRIVER("Atomic check stopped due to signal.\n");
 	else
-		DRM_DEBUG_DRIVER("Atomic check failed with err: %d \n", ret);
+		DRM_DEBUG_DRIVER("Atomic check failed with err: %d\n", ret);
 
 	trace_amdgpu_dm_atomic_check_finish(state, ret);
 
-- 
2.25.1

