Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E38C63798
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 14:11:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99CA6206D8
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 14:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Jr8detO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99CA6206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3074D6EDE9;
	Fri, 27 Nov 2020 14:11:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16FC26EDE7
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2020 14:11:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=al5VVfNfl3Nii1I+Vj5h3Ax7Os0q1JVGiP/qev2ZtBoC6sBiKdfQDawT58C9TBuObCwc+E7Zjl+zcMhN7B12qcYVM4o8DjpclsSs8wmqD+8uHPdpKpxPlkUNcZbOAq7huLrA01oGiW+0N78Jryy7KZm5nLow6m/Z9Veh1pKIM2esSR3uiZ3izkT3rqoLPQkOev8Sj0moo2TuCdo+wRcm5Ha0jTfzw+uxm3/2DjNeiFEuUYPly7uJuwmsY4GQkWtOilp2ChJZaaxYPSVxmkl6BF5qcMJTfoHBVkTfn7ZzjcHvR/F9TlDgngdQolHz9j5PxunDBc/ieM+a9EX3Uj4v4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mc22YOhxJA+FFWKgHnXsIqabTWg8vJ4/slWDLNcf73E=;
 b=FEgLl+5KhZL9ZP6ievqA+VllvVzeg19mmBPIoRnavEucIrtvYA5QeeD/v4UhHfoT3Gxjw+3XCDj3bWAw888BRRG/lbVWpLf54q1sO1liAkwuDbUMQafoqyuOgEnYehYasXNEm2zF6/lYua5w6xw5bSC50WZrn5jbjvBJTvTq6m02+ojRlHI0a2QSFcHgUfE15OaUfFMMnJTJ+iIObIdgtr30RkOuyflzHyFY7gKPeeBxrPxNvmCK/CbgsO1okkUlWNI/048QsmM5ly3fI79KoxIbf8wkHDDX3x4D4XRa0jJ1dXNV1aLqHhbBp3NTmodIjiaDMZuK+r8jZoct0q0DDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mc22YOhxJA+FFWKgHnXsIqabTWg8vJ4/slWDLNcf73E=;
 b=Jr8detO3vPdfhhxIAO57SGoDFb3TT0s7C/KGtjrj01pDpc+QmKnCaqwEQIkfvLpmcjirX/HPNP8fd9e9qWn33C4TwUP7NWyVUtuvhHu/8KJXKPMvWTrtmxTSXEI1rKEretjlxD+CxE9qONXVZTEbegsL2rVlpi/t4A061ZI+7BQ=
Received: from MWHPR2001CA0021.namprd20.prod.outlook.com
 (2603:10b6:301:15::31) by DM6PR12MB3897.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.21; Fri, 27 Nov
 2020 14:11:33 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::59) by MWHPR2001CA0021.outlook.office365.com
 (2603:10b6:301:15::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Fri, 27 Nov 2020 14:11:33 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.25 via Frontend Transport; Fri, 27 Nov 2020 14:11:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 27 Nov
 2020 08:11:31 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 27 Nov
 2020 08:11:31 -0600
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 27 Nov 2020 08:11:31 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/11] drm/amd/display: [FW Promotion] Release 0.0.44
Date: Fri, 27 Nov 2020 09:11:06 -0500
Message-ID: <20201127141107.7731-11-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201127141107.7731-1-aurabindo.pillai@amd.com>
References: <20201127141107.7731-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70952247-16c8-4801-49f6-08d892de5808
X-MS-TrafficTypeDiagnostic: DM6PR12MB3897:
X-Microsoft-Antispam-PRVS: <DM6PR12MB389761B71D49B59F289D88C38BF80@DM6PR12MB3897.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +f+/KVKBukWwGyvC/KNjV6vPnve4YHfYMKJuvl9VKn40mGqSlGeiN3sw1sMAlPz+H+XVaXip8lyR9iHMLm2u3DF7skX+5+5xED8yjMSf+/AfKWNc4bUqNt6WKI3bgthRWl2bMCNHPwOUJtjuCk4BsHXqCMpIpHJrAYsnknBABJNMyUOUyIY6gfN8jSGf+Xs0TvHztUTQ0YVHyMB0sMdg19pNb8H6xd+PsGvU47Z5vLmjRfFBwpGV2cyGjUWyJPHoJAA4m69WepQz2eHc+gWlE0zu+Yzshh+Gd86Xj0mLlxH1BGoQ7DSpB8teKi3R9lxzp+69xOsAIfK2TyL6jrD1mZrpc6ntRhrJcg1aH9IwFRJNjixdZhzGIojjdqUQiRO3ok8JpZcPpTws4ImdduIwbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(46966005)(336012)(47076004)(2906002)(8936002)(81166007)(8676002)(356005)(82740400003)(86362001)(6666004)(316002)(186003)(478600001)(7696005)(70206006)(54906003)(26005)(82310400003)(83380400001)(4326008)(2616005)(6916009)(5660300002)(36756003)(44832011)(1076003)(70586007)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 14:11:32.8599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70952247-16c8-4801-49f6-08d892de5808
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3897
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Add feature caps to allow way for driver to query what features
FW supports

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 54 ++++++++++++++-----
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index a8d93366fa03..4b7a1b8ad9e0 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,10 +36,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x52d68b82f
+#define DMUB_FW_VERSION_GIT_HASH 0x685065427
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 42
+#define DMUB_FW_VERSION_REVISION 44
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
@@ -104,12 +104,15 @@ union dmub_psr_debug_flags {
 	uint32_t u32All;
 };
 
+struct dmub_feature_caps {
+	uint8_t psr;
+	uint8_t reserved[7];
+};
+
 #if defined(__cplusplus)
 }
 #endif
 
-
-
 //==============================================================================
 //</DMUB_TYPES>=================================================================
 //==============================================================================
@@ -301,6 +304,7 @@ enum dmub_cmd_type {
 	DMUB_CMD__REG_SEQ_BURST_WRITE = 3,
 	DMUB_CMD__REG_REG_WAIT = 4,
 	DMUB_CMD__PLAT_54186_WA = 5,
+	DMUB_CMD__QUERY_FEATURE_CAPS = 6,
 	DMUB_CMD__PSR = 64,
 	DMUB_CMD__MALL = 65,
 	DMUB_CMD__ABM = 66,
@@ -321,7 +325,8 @@ enum dmub_out_cmd_type {
 struct dmub_cmd_header {
 	unsigned int type : 8;
 	unsigned int sub_type : 8;
-	unsigned int reserved0 : 8;
+	unsigned int ret_status : 1;
+	unsigned int reserved0 : 7;
 	unsigned int payload_bytes : 6;  /* up to 60 bytes */
 	unsigned int reserved1 : 2;
 };
@@ -603,8 +608,12 @@ struct dmub_cmd_psr_copy_settings_data {
 	union dmub_psr_debug_flags debug;
 	uint16_t psr_level;
 	uint8_t dpp_inst;
+	/* opp_inst and mpcc_inst will not be used in dmub fw,
+	 * dmub fw will get active opp by reading odm registers.
+	 */
 	uint8_t mpcc_inst;
 	uint8_t opp_inst;
+
 	uint8_t otg_inst;
 	uint8_t digfe_inst;
 	uint8_t digbe_inst;
@@ -792,7 +801,16 @@ struct dmub_rb_cmd_abm_init_config {
 	struct dmub_cmd_abm_init_config_data abm_init_config_data;
 };
 
-union dmub_rb_cmd {
+struct dmub_cmd_query_feature_caps_data {
+	 struct dmub_feature_caps feature_caps;
+};
+
+struct dmub_rb_cmd_query_feature_caps {
+	 struct dmub_cmd_header header;
+	 struct dmub_cmd_query_feature_caps_data query_feature_caps_data;
+};
+
+ union dmub_rb_cmd {
 	struct dmub_rb_cmd_lock_hw lock_hw;
 	struct dmub_rb_cmd_read_modify_write read_modify_write;
 	struct dmub_rb_cmd_reg_field_update_sequence reg_field_update_seq;
@@ -819,6 +837,7 @@ union dmub_rb_cmd {
 	struct dmub_rb_cmd_abm_init_config abm_init_config;
 	struct dmub_rb_cmd_dp_aux_access dp_aux_access;
 	struct dmub_rb_cmd_outbox1_enable outbox1_enable;
+	struct dmub_rb_cmd_query_feature_caps query_feature_caps;
 };
 
 union dmub_rb_out_cmd {
@@ -881,7 +900,7 @@ static inline bool dmub_rb_push_front(struct dmub_rb *rb,
 {
 	uint64_t volatile *dst = (uint64_t volatile *)(rb->base_address) + rb->wrpt / sizeof(uint64_t);
 	const uint64_t *src = (const uint64_t *)cmd;
-	int i;
+	uint8_t i;
 
 	if (dmub_rb_full(rb))
 		return false;
@@ -918,14 +937,14 @@ static inline bool dmub_rb_out_push_front(struct dmub_rb *rb,
 }
 
 static inline bool dmub_rb_front(struct dmub_rb *rb,
-				 union dmub_rb_cmd  *cmd)
+				 union dmub_rb_cmd  **cmd)
 {
-	uint8_t *rd_ptr = (uint8_t *)rb->base_address + rb->rptr;
+	uint8_t *rb_cmd = (uint8_t *)(rb->base_address) + rb->rptr;
 
 	if (dmub_rb_empty(rb))
 		return false;
 
-	dmub_memcpy(cmd, rd_ptr, DMUB_RB_CMD_SIZE);
+	*cmd = (union dmub_rb_cmd *)rb_cmd;
 
 	return true;
 }
@@ -935,7 +954,7 @@ static inline bool dmub_rb_out_front(struct dmub_rb *rb,
 {
 	const uint64_t volatile *src = (const uint64_t volatile *)(rb->base_address) + rb->rptr / sizeof(uint64_t);
 	uint64_t *dst = (uint64_t *)cmd;
-	int i;
+	uint8_t i;
 
 	if (dmub_rb_empty(rb))
 		return false;
@@ -967,7 +986,7 @@ static inline void dmub_rb_flush_pending(const struct dmub_rb *rb)
 
 	while (rptr != wptr) {
 		uint64_t volatile *data = (uint64_t volatile *)rb->base_address + rptr / sizeof(uint64_t);
-		int i;
+		uint8_t i;
 
 		for (i = 0; i < DMUB_RB_CMD_SIZE / sizeof(uint64_t); i++)
 			*data++;
@@ -987,6 +1006,17 @@ static inline void dmub_rb_init(struct dmub_rb *rb,
 	rb->wrpt = init_params->write_ptr;
 }
 
+static inline void dmub_rb_get_return_data(struct dmub_rb *rb,
+					   union dmub_rb_cmd *cmd)
+{
+	// Copy rb entry back into command
+	uint8_t *rd_ptr = (rb->rptr == 0) ?
+		(uint8_t *)rb->base_address + rb->capacity - DMUB_RB_CMD_SIZE :
+		(uint8_t *)rb->base_address + rb->rptr - DMUB_RB_CMD_SIZE;
+
+	dmub_memcpy(cmd, rd_ptr, DMUB_RB_CMD_SIZE);
+}
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
