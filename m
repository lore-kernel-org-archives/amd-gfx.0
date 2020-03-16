Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBF4C0044D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84CF52051A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FIc4cR83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84CF52051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30AA66E483;
	Mon, 16 Mar 2020 13:50:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A63E26E479
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 13:50:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajW4gra42kTmS3WdjjFDxAB34JgRgvjLzxjs+NPk7M15U/Y3kZ8aOvPpuhJVFugrCkPieJWzDteEOofOHc7W3rwdIIK/HHvERUEnTwnMmVllvHX20R7Uog4zeLyyKzGLVqASUhC8UAAB8+7zDYsVtMYPA9yhLXuZHRXY28hgBMCfVXVL2wsIM7iUo/jnbVjLkn2Ayk5XsltbeSKrcp7nAbpamroJcD0zkelpeBIJr+DZmc9R/SItbxDDeJKR6CR9K4Ckk7pAUmKq/f/Zi+8SxCpiPmOKExnBMiyxejQb08dp+HEVDK7DN2PVi7FXTd+VmAzgR5zoP8GCyOi3T03Q8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmvQyQgQX1yJk+7hKBkc2aLI0miU4zTbGvVsPvVSIGk=;
 b=YDHrlIgvqRyLessh0yJYFBtwBIvR0/vwLZijKJOrCbBL5zS736VaMoVq5Z0En5w0o3a6JIWR6lXQZjOnYJw5XejHWXqDgKXBgRM+og54JwumvPt3IIUEca/bNOVpxyCZBH+mOb0cmW4ZSJ47wobFUxetx6VKjIOv3n1MEKwZdh4RLCiUBjVaKnQonFJXUY+qSqu//3xS5vbCVVVRbRa8DCVK2G572Y5gwBnBO8bzT83VkjISYWD+R2f8dxmYmKxSxObQwYAp7dJLkYTgs284OtJhn85hOlhZICgvN3ZLAjDGBMw34io+/PQClts5Ba34gncnxVcx4o6P1TtU7OGGXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmvQyQgQX1yJk+7hKBkc2aLI0miU4zTbGvVsPvVSIGk=;
 b=FIc4cR83puj2hCK/hXF46OPA5Q+fTv738X3ORcu6sB1fnx4oqbAB00Pn+j2MpOnY9Yhv0VepjlVRQP0w9/YpqDyS27x98FZXqvBbyVvjI0DVIZ2I21crk6RrHDIoINLYxqzdWxAPRf7iq6V7i+alpSxA79SljKTUqp8qaOXZQDA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2396.namprd12.prod.outlook.com (2603:10b6:907:9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Mon, 16 Mar
 2020 13:50:12 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 13:50:12 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 18/19] drm/amd/display: Allocate scratch space for DMUB CW7
Date: Mon, 16 Mar 2020 09:49:19 -0400
Message-Id: <20200316134920.2526155-19-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
References: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Mon, 16 Mar 2020 13:50:11 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3acfdc3f-cb8f-4fde-2121-08d7c9b0f2dc
X-MS-TrafficTypeDiagnostic: MW2PR12MB2396:|MW2PR12MB2396:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB23963E42D1DEE3160ED59DD098F90@MW2PR12MB2396.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(199004)(7696005)(6916009)(5660300002)(54906003)(26005)(36756003)(52116002)(1076003)(86362001)(66556008)(66946007)(66476007)(8936002)(81166006)(81156014)(316002)(478600001)(2616005)(16526019)(2906002)(956004)(4326008)(8676002)(186003)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2396;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IM8bYPcfgCYHpsJv1EUHkVlV4/VL0Z6eI9c2WVI5W3F+/2WHA0BLqYUS3P4sgzfTejGpOyN5MhVTwRtVniDT7tF57YRLmcHk3nXaseci4JpKvmeHsumiI8v1XCnOB4liOWbn5whSZxSXY1jyia0lNeA6XIm/tihYDYrDvUPbmyRhmsUqYdG6J7rohgKw9Eh6QlRmfZrkI2PkiG5dR+FXXXnFUaJcbF02qAK6POFIyEdJ77GUsE2Dyazr/ISkA11ot9eGkgADAGx2xwi7wEjwtN5G7b6V5XHFdPpOhimC4pYrwAB6VXPZUjMirRcfqsGMP72T25D12R+39SHI/E+VrBFpNXMguSwziKONZbFHIIXThBriXt3yRBXgqWMlwJONcCtFTEAUifOY+1o0wDMraaL6wMwIxwApO5Pf6oZ/CgdiGONUzZP7QB0012bFA7Ey
X-MS-Exchange-AntiSpam-MessageData: Yi6+0kL7qxJAckGwmu7vR9RvqzoYHttuMCpoId/rtGFJJvt9tqoDxpIc4D0zD2pOXv/LB3S6JQPuD8HQjtCBqxIinbt7LZ2B30V8w0Eh149kSYYiYShY1UZrUWtYoghlu5WuZeoIX2cAEsI8uJcbGw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3acfdc3f-cb8f-4fde-2121-08d7c9b0f2dc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 13:50:12.5222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGuKZQej6J/5HXCtHJBtwHb3QJ34lP11A+svvKIRhnrVmxBWXB60YyThhqtDZBFzr9EYcqw+sqYGFlvXSvR/nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2396
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Wyatt Wood <wyatt.wood@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
The scratch space can be used to pass data between x86 and DMCUB.  DMCUB
will manage the actually mapping of CW7 internally, driver does not
program the window.

[How]
Allocate extra space within the DMUB service's framebuffer for this
scratch space and expose them from the service for use in DC.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h |  3 ++-
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 17 ++++++++++++++---
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
index e619fa9cf53a..c2671f2616c8 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
@@ -104,7 +104,7 @@ enum dmub_window_id {
 	DMUB_WINDOW_4_MAILBOX,
 	DMUB_WINDOW_5_TRACEBUFF,
 	DMUB_WINDOW_6_FW_STATE,
-	DMUB_WINDOW_7_RESERVED,
+	DMUB_WINDOW_7_SCRATCH_MEM,
 	DMUB_WINDOW_TOTAL,
 };
 
@@ -316,6 +316,7 @@ struct dmub_srv {
 	enum dmub_asic asic;
 	void *user_ctx;
 	bool is_virtual;
+	struct dmub_fb scratch_mem_fb;
 	volatile const struct dmub_fw_state *fw_state;
 
 	/* private: internal use only */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 45be185ef312..ce32cc7933c4 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -52,8 +52,11 @@
 /* Default tracebuffer size if meta is absent. */
 #define DMUB_TRACE_BUFFER_SIZE (1024)
 
+/* Default scratch mem size. */
+#define DMUB_SCRATCH_MEM_SIZE (256)
+
 /* Number of windows in use. */
-#define DMUB_NUM_WINDOWS (DMUB_WINDOW_6_FW_STATE + 1)
+#define DMUB_NUM_WINDOWS (DMUB_WINDOW_TOTAL)
 /* Base addresses. */
 
 #define DMUB_CW0_BASE (0x60000000)
@@ -211,9 +214,11 @@ dmub_srv_calc_region_info(struct dmub_srv *dmub,
 	struct dmub_region *mail = &out->regions[DMUB_WINDOW_4_MAILBOX];
 	struct dmub_region *trace_buff = &out->regions[DMUB_WINDOW_5_TRACEBUFF];
 	struct dmub_region *fw_state = &out->regions[DMUB_WINDOW_6_FW_STATE];
+	struct dmub_region *scratch_mem = &out->regions[DMUB_WINDOW_7_SCRATCH_MEM];
 	const struct dmub_fw_meta_info *fw_info;
 	uint32_t fw_state_size = DMUB_FW_STATE_SIZE;
 	uint32_t trace_buffer_size = DMUB_TRACE_BUFFER_SIZE;
+	uint32_t scratch_mem_size = DMUB_SCRATCH_MEM_SIZE;
 
 	if (!dmub->sw_init)
 		return DMUB_STATUS_INVALID;
@@ -256,7 +261,10 @@ dmub_srv_calc_region_info(struct dmub_srv *dmub,
 	fw_state->base = dmub_align(trace_buff->top, 256);
 	fw_state->top = fw_state->base + dmub_align(fw_state_size, 64);
 
-	out->fb_size = dmub_align(fw_state->top, 4096);
+	scratch_mem->base = dmub_align(fw_state->top, 256);
+	scratch_mem->top = scratch_mem->base + dmub_align(scratch_mem_size, 64);
+
+	out->fb_size = dmub_align(scratch_mem->top, 4096);
 
 	return DMUB_STATUS_OK;
 }
@@ -334,6 +342,7 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 	struct dmub_fb *mail_fb = params->fb[DMUB_WINDOW_4_MAILBOX];
 	struct dmub_fb *tracebuff_fb = params->fb[DMUB_WINDOW_5_TRACEBUFF];
 	struct dmub_fb *fw_state_fb = params->fb[DMUB_WINDOW_6_FW_STATE];
+	struct dmub_fb *scratch_mem_fb = params->fb[DMUB_WINDOW_7_SCRATCH_MEM];
 
 	struct dmub_rb_init_params rb_params;
 	struct dmub_window cw0, cw1, cw2, cw3, cw4, cw5, cw6;
@@ -370,7 +379,7 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 		dmub->hw_funcs.reset(dmub);
 
 	if (inst_fb && data_fb && bios_fb && mail_fb && tracebuff_fb &&
-	    fw_state_fb) {
+	    fw_state_fb && scratch_mem_fb) {
 		cw2.offset.quad_part = data_fb->gpu_addr;
 		cw2.region.base = DMUB_CW0_BASE + inst_fb->size;
 		cw2.region.top = cw2.region.base + data_fb->size;
@@ -396,6 +405,8 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 
 		dmub->fw_state = fw_state_fb->cpu_addr;
 
+		dmub->scratch_mem_fb = *scratch_mem_fb;
+
 		if (dmub->hw_funcs.setup_windows)
 			dmub->hw_funcs.setup_windows(dmub, &cw2, &cw3, &cw4,
 						     &cw5, &cw6);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
