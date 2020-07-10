Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C4BC433EA
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 20:34:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13D6E20748
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 20:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MvN1r4xd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D6E20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9FEB6ED12;
	Fri, 10 Jul 2020 20:34:09 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750078.outbound.protection.outlook.com [40.107.75.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D0696ED0A
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 20:34:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4NBtGldYm2VvxqHYxGUtJf4aiZzkNUf2/mMHF4m2F1Jta6eBoVP0NUFO/vRi/cFFfZjCO0qpu+C2sZOfh+MWTs86fmr3vb7srngSYpyOCnOw9bOKwlcFMpG+AiX7XiY6On2E1iyzQGGRPUeEYIY+pHoDSdcjjWMyfbvEk2IWIXCvTUFCupB2nOCoEid+zLap5U27t0DfA+tVHgTogBgg22NZ1Uh40NpW3PqUeG4kimf5cTfUQDNmCAQrsM1UfQh/UnNZmkC84PHEpKlCsihwjUsJHFI6lZi8rCh/lK9qVvaMOkU7YJC5duSIstrNXQMBIApAic3uUfG0s60Ha8ztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=580p5NrOuSLc5DqOeaEwN0j41bBAYeMYSIZ6tBRSbEw=;
 b=YZ8t4E0E15W6fkMdM2Qr+Yo4Q8g1+LxgJBJ9cA6k55eBk+3AAgTjz6MnkFFeahoj1ZpO739TjCy9hVgdMdiN16sJM90Qrb5DH2aAWs3GW5fPMXmxFC5FA4pGtvycl4JKCkLW4y4iKiwelju0pVWz4gu3mPjaLPvBpZYphqgjSE6CCZrrXRwiye/XoFQZr43RHRC8GYHQTMGK9an9sRCrzqXJ14Fgii48fC4SUXIl8tnx/7QsX3d2m4M3ghrdMbkRcInH0XXtOEgaOa6abyTFq+uq8T/glmMH0GJo6fjgo4STUm0q3lUvqrBZ5XJrib30UAHezphjQ1s7jq0Tlv7tNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=580p5NrOuSLc5DqOeaEwN0j41bBAYeMYSIZ6tBRSbEw=;
 b=MvN1r4xdO1vJkYWOPMxp445eF92Idas83/o7ny+xkrsaz0n/NeUWphrnL3RwxBqmdwHYzB82kxn+PGEh8crFA99Q0rknDHMzRyfEZwm+w58AZTNmLWQGv/+/oKKvAQ6iCEiPkLZXd8TtLBTBLtWK51wc7YNOOkoPcnb+LnmeaLI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 10 Jul
 2020 20:34:05 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1%9]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 20:34:05 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/10] drm/amd/display: Reuse parsing code of debugfs write
 buffer
Date: Fri, 10 Jul 2020 16:33:24 -0400
Message-Id: <20200710203325.1097188-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710203325.1097188-1-Rodrigo.Siqueira@amd.com>
References: <20200710203325.1097188-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::38) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:8440::b10e) by
 YTOPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Fri, 10 Jul 2020 20:34:04 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:8440::b10e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 73ea85e9-7ef3-4dca-76c7-08d825109673
X-MS-TrafficTypeDiagnostic: CH2PR12MB4231:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4231A32A0EE44A5578060B8F98650@CH2PR12MB4231.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BJFkoSdQZezeWliHb9oFQq3aJ5YLUjckuXSVZ6tHiN+cSRJNkEDxIF0A8AUqMhGOC0q+pOw4BcY+89OMGUEPypPnbizrHpnrp1MDAZP6EPR5HrSPZmaSTylaTWtKhugKGPjGq1ZfC0s7JBdPEbj5pzbWhAiSv0q5FbjMn5LEiMagI5CeRabFxnTBSbeadD8t6R287xXihJYvLp77GJjHT0bAM8zIYi4r3SlgCOIK2vw9biqzoF/gZF84vXamUWdNobiTZ5hBNu1YIyjsjTaTW457GGGYnPTLkfeFkNRryOYUGErSYANRCiACo4WxeCtZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(54906003)(2616005)(8936002)(8676002)(6512007)(478600001)(30864003)(316002)(16526019)(5660300002)(186003)(4326008)(86362001)(6916009)(52116002)(6506007)(6486002)(1076003)(6666004)(36756003)(66476007)(66556008)(66946007)(83380400001)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: daUV80F5a6PDVqU7ItsXVXWX+kbH1mJ0F6DjtSJl3qZFQem1+mfB8H35CtuA8h/BChwovk+PxDqKgcNkuXs5TGcGtxL4AGv8eDKml42bzH0qmVXWbZvb85rHOfSPmBQkglZulwNgWtkVmpT3jZ1ObtXrIoubLIst6Eg55ATUT6w8pMRLjjq4o1fLwdz03vE9HzankjIJtt3oTagYIPCMghtUu/B/DuDpVf00s3M4JjPfN4hRNHYduNX9uGzt5t7VnmYoxcnTG/w5WpM3E0QbYbUVthWefAxt6VPtbby07w/P1JeUce8b1P40IzqY5l300N1gNV1q4rkkXqOX8pnZ5n8Tv2/3ixy09n1BpDbYB1UmGp+dfzBX+1e6daIBG7IFR8J1oyUXqCUmwgD7GRuupIQNJYw8O/PIKNf9FxSJKj2ezA6drWN7aCGSNFn2ptGR4fVdRhK9ggFJ5BG2/RFqj7GoteLg7i+QRMGOgJ5Ok6obWsjYPuabQb1UQFFp9P9xvdHKpENWovSfcGo8HjJJYQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ea85e9-7ef3-4dca-76c7-08d825109673
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4198.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 20:34:04.9228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1pJWgMceNY7+fESc0fG1r05rBWDXedxOO3tQEMdOAnp44lAeqMar5UU/lhBVE5LT2bdaF97KvV1BqoddvqN+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Mikita Lipski <mikita.lipski@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mikita Lipski <mikita.lipski@amd.com>

[why]
Move code for parsing debugfs input into an array of int parameters by
specifying the max number of expected parameters

Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 259 +++++++++---------
 1 file changed, 128 insertions(+), 131 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index db4fab10a0c4..caf3beaf4b7b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -46,6 +46,89 @@ struct dmub_debugfs_trace_entry {
 	uint32_t param1;
 };
 
+
+/* parse_write_buffer_into_params - Helper function to parse debugfs write buffer into an array
+ *
+ * Function takes in attributes passed to debugfs write entry
+ * and writes into param array.
+ * The user passes max_param_num to identify maximum number of
+ * parameters that could be parsed.
+ *
+ */
+static int parse_write_buffer_into_params(char *wr_buf, uint32_t wr_buf_size,
+					  long *param, const char __user *buf,
+					  int max_param_num,
+					  uint8_t *param_nums)
+{
+	char *wr_buf_ptr = NULL;
+	uint32_t wr_buf_count = 0;
+	int r;
+	char *sub_str = NULL;
+	const char delimiter[3] = {' ', '\n', '\0'};
+	uint8_t param_index = 0;
+
+	*param_nums = 0;
+
+	wr_buf_ptr = wr_buf;
+
+	r = copy_from_user(wr_buf_ptr, buf, wr_buf_size);
+
+		/* r is bytes not be copied */
+	if (r >= wr_buf_size) {
+		DRM_DEBUG_DRIVER("user data not be read\n");
+		return -EINVAL;
+	}
+
+	/* check number of parameters. isspace could not differ space and \n */
+	while ((*wr_buf_ptr != 0xa) && (wr_buf_count < wr_buf_size)) {
+		/* skip space*/
+		while (isspace(*wr_buf_ptr) && (wr_buf_count < wr_buf_size)) {
+			wr_buf_ptr++;
+			wr_buf_count++;
+			}
+
+		if (wr_buf_count == wr_buf_size)
+			break;
+
+		/* skip non-space*/
+		while ((!isspace(*wr_buf_ptr)) && (wr_buf_count < wr_buf_size)) {
+			wr_buf_ptr++;
+			wr_buf_count++;
+		}
+
+		(*param_nums)++;
+
+		if (wr_buf_count == wr_buf_size)
+			break;
+	}
+
+	if (*param_nums > max_param_num)
+		*param_nums = max_param_num;
+;
+
+	wr_buf_ptr = wr_buf; /* reset buf pointer */
+	wr_buf_count = 0; /* number of char already checked */
+
+	while (isspace(*wr_buf_ptr) && (wr_buf_count < wr_buf_size)) {
+		wr_buf_ptr++;
+		wr_buf_count++;
+	}
+
+	while (param_index < *param_nums) {
+		/* after strsep, wr_buf_ptr will be moved to after space */
+		sub_str = strsep(&wr_buf_ptr, delimiter);
+
+		r = kstrtol(sub_str, 16, &(param[param_index]));
+
+		if (r)
+			DRM_DEBUG_DRIVER("string to int convert error code: %d\n", r);
+
+		param_index++;
+	}
+
+	return 0;
+}
+
 /* function description
  * get/ set DP configuration: lane_count, link_rate, spread_spectrum
  *
@@ -161,15 +244,11 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
 	struct dc *dc = (struct dc *)link->dc;
 	struct dc_link_settings prefer_link_settings;
 	char *wr_buf = NULL;
-	char *wr_buf_ptr = NULL;
 	const uint32_t wr_buf_size = 40;
-	int r;
-	int bytes_from_user;
-	char *sub_str;
 	/* 0: lane_count; 1: link_rate */
-	uint8_t param_index = 0;
+	int max_param_num = 2;
+	uint8_t param_nums = 0;
 	long param[2];
-	const char delimiter[3] = {' ', '\n', '\0'};
 	bool valid_input = false;
 
 	if (size == 0)
@@ -177,35 +256,20 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
 
 	wr_buf = kcalloc(wr_buf_size, sizeof(char), GFP_KERNEL);
 	if (!wr_buf)
-		return -EINVAL;
-	wr_buf_ptr = wr_buf;
+		return -ENOSPC;
 
-	r = copy_from_user(wr_buf_ptr, buf, wr_buf_size);
-
-	/* r is bytes not be copied */
-	if (r >= wr_buf_size) {
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
+					   (long *)param, buf,
+					   max_param_num,
+					   &param_nums)) {
 		kfree(wr_buf);
-		DRM_DEBUG_DRIVER("user data not read\n");
 		return -EINVAL;
 	}
 
-	bytes_from_user = wr_buf_size - r;
-
-	while (isspace(*wr_buf_ptr))
-		wr_buf_ptr++;
-
-	while ((*wr_buf_ptr != '\0') && (param_index < 2)) {
-
-		sub_str = strsep(&wr_buf_ptr, delimiter);
-
-		r = kstrtol(sub_str, 16, &param[param_index]);
-
-		if (r)
-			DRM_DEBUG_DRIVER("string to int convert error code: %d\n", r);
-
-		param_index++;
-		while (isspace(*wr_buf_ptr))
-			wr_buf_ptr++;
+	if (param_nums <= 0) {
+		kfree(wr_buf);
+		DRM_DEBUG_DRIVER("user data not be read\n");
+		return -EINVAL;
 	}
 
 	switch (param[0]) {
@@ -233,7 +297,7 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
 	if (!valid_input) {
 		kfree(wr_buf);
 		DRM_DEBUG_DRIVER("Invalid Input value No HW will be programmed\n");
-		return bytes_from_user;
+		return size;
 	}
 
 	/* save user force lane_count, link_rate to preferred settings
@@ -246,7 +310,7 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
 	dc_link_set_preferred_link_settings(dc, &prefer_link_settings, link);
 
 	kfree(wr_buf);
-	return bytes_from_user;
+	return size;
 }
 
 /* function: get current DP PHY settings: voltage swing, pre-emphasis,
@@ -337,51 +401,34 @@ static ssize_t dp_phy_settings_write(struct file *f, const char __user *buf,
 	struct dc_link *link = connector->dc_link;
 	struct dc *dc = (struct dc *)link->dc;
 	char *wr_buf = NULL;
-	char *wr_buf_ptr = NULL;
 	uint32_t wr_buf_size = 40;
-	int r;
-	int bytes_from_user;
-	char *sub_str;
-	uint8_t param_index = 0;
 	long param[3];
-	const char delimiter[3] = {' ', '\n', '\0'};
 	bool use_prefer_link_setting;
 	struct link_training_settings link_lane_settings;
+	int max_param_num = 3;
+	uint8_t param_nums = 0;
+	int r = 0;
+
 
 	if (size == 0)
-		return 0;
+		return -EINVAL;
 
 	wr_buf = kcalloc(wr_buf_size, sizeof(char), GFP_KERNEL);
 	if (!wr_buf)
-		return 0;
-	wr_buf_ptr = wr_buf;
+		return -ENOSPC;
 
-	r = copy_from_user(wr_buf_ptr, buf, wr_buf_size);
-
-	/* r is bytes not be copied */
-	if (r >= wr_buf_size) {
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
+					   (long *)param, buf,
+					   max_param_num,
+					   &param_nums)) {
 		kfree(wr_buf);
-		DRM_DEBUG_DRIVER("user data not be read\n");
-		return 0;
+		return -EINVAL;
 	}
 
-	bytes_from_user = wr_buf_size - r;
-
-	while (isspace(*wr_buf_ptr))
-		wr_buf_ptr++;
-
-	while ((*wr_buf_ptr != '\0') && (param_index < 3)) {
-
-		sub_str = strsep(&wr_buf_ptr, delimiter);
-
-		r = kstrtol(sub_str, 16, &param[param_index]);
-
-		if (r)
-			DRM_DEBUG_DRIVER("string to int convert error code: %d\n", r);
-
-		param_index++;
-		while (isspace(*wr_buf_ptr))
-			wr_buf_ptr++;
+	if (param_nums <= 0) {
+		kfree(wr_buf);
+		DRM_DEBUG_DRIVER("user data not be read\n");
+		return -EINVAL;
 	}
 
 	if ((param[0] > VOLTAGE_SWING_MAX_LEVEL) ||
@@ -389,7 +436,7 @@ static ssize_t dp_phy_settings_write(struct file *f, const char __user *buf,
 			(param[2] > POST_CURSOR2_MAX_LEVEL)) {
 		kfree(wr_buf);
 		DRM_DEBUG_DRIVER("Invalid Input No HW will be programmed\n");
-		return bytes_from_user;
+		return size;
 	}
 
 	/* get link settings: lane count, link rate */
@@ -429,7 +476,7 @@ static ssize_t dp_phy_settings_write(struct file *f, const char __user *buf,
 	dc_link_set_drive_settings(dc, &link_lane_settings, link);
 
 	kfree(wr_buf);
-	return bytes_from_user;
+	return size;
 }
 
 /* function description
@@ -496,19 +543,13 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
 	struct dc_link *link = connector->dc_link;
 	char *wr_buf = NULL;
-	char *wr_buf_ptr = NULL;
 	uint32_t wr_buf_size = 100;
-	uint32_t wr_buf_count = 0;
-	int r;
-	int bytes_from_user;
-	char *sub_str = NULL;
-	uint8_t param_index = 0;
-	uint8_t param_nums = 0;
 	long param[11] = {0x0};
-	const char delimiter[3] = {' ', '\n', '\0'};
+	int max_param_num = 11;
 	enum dp_test_pattern test_pattern = DP_TEST_PATTERN_UNSUPPORTED;
 	bool disable_hpd = false;
 	bool valid_test_pattern = false;
+	uint8_t param_nums = 0;
 	/* init with defalut 80bit custom pattern */
 	uint8_t custom_pattern[10] = {
 			0x1f, 0x7c, 0xf0, 0xc1, 0x07,
@@ -522,70 +563,26 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 	int i;
 
 	if (size == 0)
-		return 0;
+		return -EINVAL;
 
 	wr_buf = kcalloc(wr_buf_size, sizeof(char), GFP_KERNEL);
 	if (!wr_buf)
-		return 0;
-	wr_buf_ptr = wr_buf;
+		return -ENOSPC;
 
-	r = copy_from_user(wr_buf_ptr, buf, wr_buf_size);
-
-	/* r is bytes not be copied */
-	if (r >= wr_buf_size) {
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
+					   (long *)param, buf,
+					   max_param_num,
+					   &param_nums)) {
 		kfree(wr_buf);
-		DRM_DEBUG_DRIVER("user data not be read\n");
-		return 0;
-	}
-
-	bytes_from_user = wr_buf_size - r;
-
-	/* check number of parameters. isspace could not differ space and \n */
-	while ((*wr_buf_ptr != 0xa) && (wr_buf_count < wr_buf_size)) {
-		/* skip space*/
-		while (isspace(*wr_buf_ptr) && (wr_buf_count < wr_buf_size)) {
-			wr_buf_ptr++;
-			wr_buf_count++;
-			}
-
-		if (wr_buf_count == wr_buf_size)
-			break;
-
-		/* skip non-space*/
-		while ((!isspace(*wr_buf_ptr)) && (wr_buf_count < wr_buf_size)) {
-			wr_buf_ptr++;
-			wr_buf_count++;
-			}
-
-		param_nums++;
-
-		if (wr_buf_count == wr_buf_size)
-			break;
+		return -EINVAL;
 	}
 
-	/* max 11 parameters */
-	if (param_nums > 11)
-		param_nums = 11;
-
-	wr_buf_ptr = wr_buf; /* reset buf pinter */
-	wr_buf_count = 0; /* number of char already checked */
-
-	while (isspace(*wr_buf_ptr) && (wr_buf_count < wr_buf_size)) {
-		wr_buf_ptr++;
-		wr_buf_count++;
+	if (param_nums <= 0) {
+		kfree(wr_buf);
+		DRM_DEBUG_DRIVER("user data not be read\n");
+		return -EINVAL;
 	}
 
-	while (param_index < param_nums) {
-		/* after strsep, wr_buf_ptr will be moved to after space */
-		sub_str = strsep(&wr_buf_ptr, delimiter);
-
-		r = kstrtol(sub_str, 16, &param[param_index]);
-
-		if (r)
-			DRM_DEBUG_DRIVER("string to int convert error code: %d\n", r);
-
-		param_index++;
-	}
 
 	test_pattern = param[0];
 
@@ -618,7 +615,7 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 	if (!valid_test_pattern) {
 		kfree(wr_buf);
 		DRM_DEBUG_DRIVER("Invalid Test Pattern Parameters\n");
-		return bytes_from_user;
+		return size;
 	}
 
 	if (test_pattern == DP_TEST_PATTERN_80BIT_CUSTOM) {
@@ -685,7 +682,7 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 
 	kfree(wr_buf);
 
-	return bytes_from_user;
+	return size;
 }
 
 /**
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
