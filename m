Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0A0C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 17:05:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D03C61027
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 17:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0D03C61027
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B9A86E063;
	Tue, 24 Aug 2021 17:05:57 +0000 (UTC)
X-Greylist: delayed 77791 seconds by postgrey-1.36 at gabe;
 Tue, 24 Aug 2021 17:05:56 UTC
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (unknown
 [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A3C06E063
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 17:05:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBxd7WDlaPuztN59E1jOoHhr5KSI4anfT6Ekdo2VOZoMcv7g29oQ/tPF+Vm78NsnygRiZX8usMQKFYWJxwth+XsN5zwyWuGoy4TvTHt7y1tDBqdk+SMvOlBlVSH9IFxnZx0qHC0ayLpk/i7qYXJRe3rrAjvrRJMHrf675nEGxXPs7GEnvJKtbx/aHqIvh33ABxrnAgZwsLoRWdqQyjlTYIEOJWGdjSLmW65XC/MqN5lXGK5GCeYe6JpTzU76CvkCOCBXx1idVWlo+GdLiH7QiwIj17qZU3PsNVF1OjHvrRLjBDguMuCpdqAqNDyLAvfw7fEfXLakcxcU45iWjrYfpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzenyxFUU+u2fjiNqv0m1IeELFm8n9+4uYl2vJWj0QA=;
 b=Jg6hvquuVePy3xQC7tewDJIV/zzi5J5S0QfNrHbujaIRgFmsRgZi54ga5q4jkQKc5Y7ThPQyku54oPckmKJ4bW/DkBYHspzOUv2VJOo1ySchh3A1gZe7bvt+wSFv8vtSFbTPGTP8/ZRD7KheY1xuxkzGjjc0OGowdW2bbVP0U9wd8zuws5Y07wFXytK0sgZtn+xFZ+t4f468D16kJCpE+oPLrtTjsPMsAtQSVcPizO/blXFDi0qL5Vt90hPASrqR/9zVEpBm2w/hGPePORRYkl0a/I7fBGjJMWBg2OkiDfa0RXAvdSRmqL2kCVthsMpW+8JHYjIMZ3N41j1oUH9YkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzenyxFUU+u2fjiNqv0m1IeELFm8n9+4uYl2vJWj0QA=;
 b=z/snk57pcHRs9Szgs9jX3qptjmpCl7eymEhMDSID4FPxezlunjgrIAQON9MJXTN57mSHkemui66PPtWSS+X+NfqHITX1vf0GBr/zrdG6jvGcdoMb15p00xhZEPX6bwFRZF6Vb4LYtKf/7iq0WRz4YqlI+QA3Url45PbT2P5a7Sg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Tue, 24 Aug
 2021 16:51:24 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5%4]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 16:51:24 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/8] drm/amdgpu/display: fix mixed declarations and code in
 dc_link_dp.c
Date: Tue, 24 Aug 2021 12:51:02 -0400
Message-Id: <20210824165105.1913700-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210824165105.1913700-1-alexander.deucher@amd.com>
References: <20210824165105.1913700-1-alexander.deucher@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:208:23a::34) To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR03CA0029.namprd03.prod.outlook.com (2603:10b6:208:23a::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Tue, 24 Aug 2021 16:51:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71b32b2d-ad3b-4732-0e59-08d9671f682e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5349465AD67F57795BBD9A85F7C59@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CnBwJiNbXOC/Wu7sSosUVDU9whJqf3U9V6/AO7BflDOL1+hhVpJu+tITZy9uvLyeZzklsVi74hbzIFydJVVsf5KZDOERvtWkcfMK4s0/fKgQqTupdVkxTJGq1BqiC+Kmxyh2mqShj7sHGJ1SlFsOpq9dLCozUzaktx/Rg0rLC3gT0Gi2BIgsYuTbzRXSkU1HA0Skc3Q1sll9+sqO/QL4Q7oW7uCSIfcN6BgcO4ZtTIeR1yLUTCd4QFetLtHrlijXq8pDr5ZRA4dGPs1PgSgCaLNU4RbNqDruedByg3/pjh1jKWI6sx5pCdMdQrD0f6tACmg9Ql+MJkzZSPrC/HSZGRRIfm7DqHxPmADxT2mGLMJ5wCBnLGgmWxb1ZRUKAXLqga7VyDeMK4MgNNXIavA2qJyRkd9xTXhnbsukxriBH6/ylpl+wyRhdEjDlD5gQVEI906vY59aimGcZ3Kbxa25/EDGHFXMd+cIQ41BWgDJYdKH5t6b1u6TbZTlTuJjSd029JW/Hukh3ykC0U/YX/b0jFJd/byD+5TAM6LlRpExxdeqxM8RyWe5w6bEgLxAr2c38cUxIUNQFv7q8FNHYTafjYrqr12Cgdaw6o7Q30tRUYFz1uAGeFK355kitkMC5Ljqa7GatfbxQRIQ48PgdiA8CjUhm8vVcVPIPDD8kH9/YErhsT7AKM6Hf0fLU157tbp7NNaOsACBz7Zux0f7PNrtXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(7696005)(52116002)(5660300002)(2906002)(66476007)(186003)(66556008)(8936002)(478600001)(36756003)(26005)(83380400001)(38350700002)(6486002)(316002)(8676002)(956004)(6916009)(1076003)(86362001)(2616005)(4326008)(6666004)(38100700002)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fsZYd3Z8t2qkdT3B5Pibz5xZS0hnQ8b+OB/h2/rbVl0t28CSc3dfFRlh7HMj?=
 =?us-ascii?Q?Kkeub/WYh0c4eH+8ADyKWGliiUMRNB3UjgZ1htdy+x/bw6XlmmzoKHXzm9Ib?=
 =?us-ascii?Q?vh4tZFXJuOg2o31moR+50o8fcdrr3Y5lprYA2kyJUXoWlqTWZiINe0oJ0MjM?=
 =?us-ascii?Q?pNin74keU+gx8T9V/xVMzE0mTx0gIckdIzs79rBgzmj3Xx9mRG6jrLthhRse?=
 =?us-ascii?Q?FjD67O+2BhXotO6dJw0Lgg4UH8ls59bf3ZM8xq/cMOFtTRYxuvO5L3wuaxbW?=
 =?us-ascii?Q?aSxIFgp7tNUXyT4ff0Z5Rz/YB9OS9Ji7Ex9mejxZ/isCgtZzSQ9rCbWI7H95?=
 =?us-ascii?Q?kF3FO+jfgDETX7YFeCV/aqbWL0iDQ8iLzYF4wlmn7FKbl0JLGapXVbhFRtjA?=
 =?us-ascii?Q?FoHUkjP3HfDkA08z6Jzs+8qa5HvG752s0TwuRJzg94a8sVMTm7zGej0dJl0s?=
 =?us-ascii?Q?JvoXJFjgeRbOdNMbDX3mU/6wZ/rKNQ5bQWab2YpurnJZkuySjd1hBoKkjKzX?=
 =?us-ascii?Q?R/snhz0fALohq97VLUz/O6LsDcRMJOwPey4q8e7zpuQOh8YscN29Rbc+suPQ?=
 =?us-ascii?Q?E0AK3EVEOV4418VGCjpDB4BtTIlvWU0jiMXtgAhS7NQgrZ7YTMVlHxB6GzUP?=
 =?us-ascii?Q?J6Nwts6vz/ZoRiff2Qsy3McipqNR3eW0MiSNXXTneik+K9dgCIVulITJUPTy?=
 =?us-ascii?Q?aphhrv3vLr0Yr+AmMMQXzOujJpDb2YmOawwhKMNmvpqKCX5txbwmZve4daP/?=
 =?us-ascii?Q?gg0M8Ov3ahJ4i6oSDGsfGqZCZMWBgUI+BCohDE9FaN74hdniTI0x0mW5Qj6+?=
 =?us-ascii?Q?yLn9BSPtA+paFN5MGEIILt8UZlQ3kXVaCl2daX07ImnQNiTgv8EqkXAuYhi0?=
 =?us-ascii?Q?ko6x5wztZ6x/oo+gYwKGWGo6LA5KV0ntMPW8bptzEHC65/Yz+ayUE5LoxP48?=
 =?us-ascii?Q?CjJ3iFNhad2v7wMG3OoKwkKBE//9VhSNsVf392uT5FA6aPYbXCP0XMSyXIrg?=
 =?us-ascii?Q?KR5JSE8608XYk986GNKJ9Ik4McSOZrsFyvzwiWxb7pzNu28m25wrjPscbfjN?=
 =?us-ascii?Q?F0tzyh1Gpb/1BGddg87FigJPw3fBjdS3jhYUjlpEWm2/o98dgvLBW8jZqcB7?=
 =?us-ascii?Q?rYClVSMBDF9+1iEPdMI6BLeo2rlikXFI+KKr9CXux20dVkS+I7GLYzMrL20O?=
 =?us-ascii?Q?NPeNG88pPns55Qx16D3jRX2FFhLUDqDjyWimjyx4qMUbnhJOXskS7VlzSfGx?=
 =?us-ascii?Q?IudXC4naKEL62zj5W+x82AD+nLacHDAEc8mljPctFPPY5boFEz/BSsHJm6B9?=
 =?us-ascii?Q?OtClNojeuUE0oPTOCcJAJtDf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b32b2d-ad3b-4732-0e59-08d9671f682e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 16:51:24.4996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfHnaOC5Hswba5mFzLW8+tUsS/aRk277xPhdOhpDyc6ATqv5m2JUELMdiFv4E9rba0i6LKzXp2b1aUUNjtRu2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
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

Trivial.

Fixes: 808a662bb3a8 ("drm/amd/display: Add DP 2.0 SST DC Support")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c   | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 0126e71841fa..2222929cbac0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2643,6 +2643,9 @@ bool dc_link_dp_get_max_link_enc_cap(const struct dc_link *link, struct dc_link_
 static struct dc_link_settings get_max_link_cap(struct dc_link *link)
 {
 	struct dc_link_settings max_link_cap = {0};
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	enum dc_link_rate lttpr_max_link_rate;
+#endif
 
 	/* get max link encoder capability */
 	link->link_enc->funcs->get_max_link_cap(link->link_enc, &max_link_cap);
@@ -2672,7 +2675,7 @@ static struct dc_link_settings get_max_link_cap(struct dc_link *link)
 			max_link_cap.lane_count = link->dpcd_caps.lttpr_caps.max_lane_count;
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-		enum dc_link_rate lttpr_max_link_rate = get_lttpr_max_link_rate(link);
+		lttpr_max_link_rate = get_lttpr_max_link_rate(link);
 
 		if (lttpr_max_link_rate < max_link_cap.link_rate)
 			max_link_cap.link_rate = lttpr_max_link_rate;
@@ -4412,6 +4415,7 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
 {
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	uint8_t lttpr_dpcd_data[8];
+	bool allow_lttpr_non_transparent_mode = 0;
 #else
 	uint8_t lttpr_dpcd_data[6];
 #endif
@@ -4423,8 +4427,6 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
 	memset(lttpr_dpcd_data, '\0', sizeof(lttpr_dpcd_data));
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-	bool allow_lttpr_non_transparent_mode = 0;
-
 	if ((link->dc->config.allow_lttpr_non_transparent_mode.bits.DP2_0 &&
 			link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED)) {
 		allow_lttpr_non_transparent_mode = 1;
@@ -5926,13 +5928,12 @@ static void get_lane_status(
 	union lane_align_status_updated *status_updated)
 {
 	unsigned int lane;
+	uint8_t dpcd_buf[3] = {0};
 
 	if (status == NULL || status_updated == NULL) {
 		return;
 	}
 
-	uint8_t dpcd_buf[3] = {0};
-
 	core_link_read_dpcd(
 			link,
 			DP_LANE0_1_STATUS,
@@ -5957,6 +5958,9 @@ bool dpcd_write_128b_132b_sst_payload_allocation_table(
 	bool result = false;
 	uint8_t req_slot_count = 0;
 	struct fixed31_32 avg_time_slots_per_mtp = { 0 };
+	union payload_table_update_status update_status = { 0 };
+	const uint32_t max_retries = 30;
+	uint32_t retries = 0;
 
 	if (allocate)	{
 		avg_time_slots_per_mtp = calculate_sst_avg_time_slots_per_mtp(stream, link);
@@ -5965,8 +5969,6 @@ bool dpcd_write_128b_132b_sst_payload_allocation_table(
 		/// Leave req_slot_count = 0 if allocate is false.
 	}
 
-	union payload_table_update_status update_status = { 0 };
-
 	/// Write DPCD 2C0 = 1 to start updating
 	update_status.bits.VC_PAYLOAD_TABLE_UPDATED = 1;
 	core_link_write_dpcd(
@@ -5999,8 +6001,6 @@ bool dpcd_write_128b_132b_sst_payload_allocation_table(
 
 	/// Poll till DPCD 2C0 read 1
 	/// Try for at least 150ms (30 retries, with 5ms delay after each attempt)
-	const uint32_t max_retries = 30;
-	uint32_t retries = 0;
 
 	while (retries < max_retries) {
 		if (core_link_read_dpcd(
-- 
2.31.1

