Return-Path: <SRS0=P3OX=CR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E09EC433E2
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2020 13:06:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A8622D04
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2020 13:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zFrMl+eM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A8622D04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F1516E029;
	Tue,  8 Sep 2020 13:06:52 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680088.outbound.protection.outlook.com [40.107.68.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 980146E1CE
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2020 13:06:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8dDL5dkVlNlxs9tamDybj4fVp1Z4b8Pco4DxDbavvSPp40VlZlcaTsOwxpAnMGK9v+bL28HYXDp37qSTuOcVZCzU42XlDoCvqnTg12OBdU8yBOit2IkjmfmZKtShYccfwsCVATTMx35HIjMbtbtMhIj/Rm7Kn8RSKTgThBve/3nvytgPjAoA5pVE/bMOzZP36xyZWDIxqM1mALhUQVhUCH5S3j5IL3oGPZw7N68/Xgp5dfoUYY74+RvWY09K6oDnpYm4R+VuXNmZsRA1YIJDxA/Z3wGuFbobiLPCAyI44h9tV05oGRItC+3l66RmEw8kkiY+dYHAZ3IiCnoEDxvJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8uwc/TCAH+8Uujwnd0dfJ+9je8AG+ChhBlwuOrlXqQ=;
 b=f/BR1oGsWUz2J6pjLxzyTPCZ5RIp8413F3sA3RIVaIBfvAZUwpZzR7rRuHmaz74BGOZyX9nBQRUml5z8gsNmen3aPocNemqm84uG6AlGP0I0JRZbKGElE1tbny9CVCI73UVAt/v8t2hQG5+ADsI2juP1f67ZRtcjEfJQk4uqibSWaNBKQ+Gqm0OGOUq4wQDFg23fdp4AIr+Uy5gP9biy5zrb9SLM2xFvSph7ZrlXNPNmBqNage+yOMJfTr05mznL6Enn5IaV4YDmG2hgygeZY/Nw8/87lQxIS+leUs8BskbAuyic48L9nleAhlIi0pSQ8SyukabU30dP/vYoKTRR3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8uwc/TCAH+8Uujwnd0dfJ+9je8AG+ChhBlwuOrlXqQ=;
 b=zFrMl+eMxMinIr7ppsClfyy6uuotah8QljYpnzdRd2n5cnGypkJVmbDnkrperB5C0h9GDBtmegCGcUJpAWjC/5SqB4i+5QL9Z1fRnBJMLXcqPz7Oyk1zWZ2Q+KkGyPoXPaYkQR+LYW4q+FuDrILkXrx4TZVqhZOtOIulpsHXXkY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18) by BN8PR12MB3604.namprd12.prod.outlook.com
 (2603:10b6:408:45::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 8 Sep
 2020 13:06:49 +0000
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be]) by BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be%4]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 13:06:49 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu: fix xgmi perfmon a-b-a problem
Date: Tue,  8 Sep 2020 09:06:01 -0400
Message-Id: <20200908130603.10344-2-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908130603.10344-1-jonathan.kim@amd.com>
References: <20200908130603.10344-1-jonathan.kim@amd.com>
X-ClientProxiedBy: YTXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::38) To BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jonathan-KFD.amd.com (165.204.55.251) by
 YTXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend
 Transport; Tue, 8 Sep 2020 13:06:49 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 10de5933-afc1-42ec-3f4e-08d853f80c10
X-MS-TrafficTypeDiagnostic: BN8PR12MB3604:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3604A348857F7A73AB40A1E985290@BN8PR12MB3604.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WEgh2SY7Zkxtap84k88vmb+8sAD9mJHHcGns6qNKeHKm2jiFG6Khbde/qiKe58dQWKah0PEk89DD2lYqukKKWz0rO55tKQgaP5kKKILPHWQDuSSG0He1EkPpqqkow6yE+OwdX3kOkFYioAb1CdBxDKSPRfExRcSnh+8UfgU0lq1H+nJghHoABTyg5zlbalUGzuqZFGew8zpL95wMT3sK/ntvCR9LKYIC94R+9rfAiAKBZK5sV4PNGhRk3AKxU38bJLw9qZvh9f5Y1HU0xcflL9WiOeBx/mEDKcUXt0S1qzMEHgte9Qu7yW76FRmnUAwPEUFWlo2EZYYtI1zqYEXP7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(36756003)(26005)(956004)(16526019)(2906002)(83380400001)(6916009)(2616005)(186003)(44832011)(7696005)(6486002)(66946007)(8676002)(6666004)(5660300002)(52116002)(54906003)(66476007)(66556008)(316002)(4326008)(478600001)(8936002)(86362001)(1076003)(30864003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: FnHbb4szn9N3QdIu2ddnABDfYrReX0yVwLX7/5U7HsnDfA8gFiIQXR1O1Rv1PPr0U/V8m0bSZNTMwg5UXOyg7pQkwiHQ4UvZkUUPYfwn+DOJbpf3jle4ExXvgaFkeweFjOAb/GAqEEXl+MgC3GY93vYzuDXsdi0yfmwPzSKU9dBnVU9L4jmQATZIP1mCmq0awLEiUZhM3NPJHsAHmVRURkLMdqPY0noI7/5MfwXuJ1X59tNpXinzSgnAjrvPa4nniz4KzW8CoDpAiMFYpoeJwDxR1frXPvxr9V49G4XDkmJh1DgPVa3IyFHFFCNOHH6dOWRyH/xWwayuKaNdsO3qWWmSBgvJDLsFX4xNJmeS05x3UdCOGOHUsy04EzKwCuXSntZJHtjKoi38DCdu+vzXImLUHbtbFncO0cexC1hSGKrenwHj+S0DsLqGcoB9dSI7wBLpnTo1AN246q4vxa2NRxlckuckosnBGiWINuWmjV9237FIzAenik4g1YQMBqVSLw3Khw3CX6QUfZTe7i7Xomwta3qXZm1MFFqTRMDiXIi4AbzwGdcpnafnfVlCJObs5ZtbfMm7lvVeOhxRkNEREb09IR/FgHbU+lCmdUf6V6sf57FSa+Sy3uhxKcpnIQ1ytLEz6lXfKiw4DIlldkkIiA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10de5933-afc1-42ec-3f4e-08d853f80c10
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 13:06:49.4790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: irtBmJ+miXGLmMZPYz9GrPAs4dzotHmELsOYEiOthPz84Ia1U0Q6CYKg/GNghKwb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3604
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <Jonathan.Kim@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Mapping hw counters per event config will cause ABA problems so map per
event instead.

Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_df.h  |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c |  23 ++++--
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c    | 104 +++++++++++-------------
 3 files changed, 65 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
index 373cdebe0e2f..52488bb45112 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
@@ -44,11 +44,11 @@ struct amdgpu_df_funcs {
 	void (*enable_ecc_force_par_wr_rmw)(struct amdgpu_device *adev,
 					    bool enable);
 	int (*pmc_start)(struct amdgpu_device *adev, uint64_t config,
-					 int is_add);
+					 int counter_idx, int is_add);
 	int (*pmc_stop)(struct amdgpu_device *adev, uint64_t config,
-					 int is_remove);
+					 int counter_idx, int is_remove);
 	void (*pmc_get_count)(struct amdgpu_device *adev, uint64_t config,
-					 uint64_t *count);
+					 int counter_idx, uint64_t *count);
 	uint64_t (*get_fica)(struct amdgpu_device *adev, uint32_t ficaa_val);
 	void (*set_fica)(struct amdgpu_device *adev, uint32_t ficaa_val,
 			 uint32_t ficadl_val, uint32_t ficadh_val);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
index 69af462db34d..915c580d30be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
@@ -74,9 +74,11 @@ static void amdgpu_perf_start(struct perf_event *event, int flags)
 	switch (pe->pmu_perf_type) {
 	case PERF_TYPE_AMDGPU_DF:
 		if (!(flags & PERF_EF_RELOAD))
-			pe->adev->df.funcs->pmc_start(pe->adev, hwc->config, 1);
+			pe->adev->df.funcs->pmc_start(pe->adev, hwc->config,
+								hwc->idx, 1);
 
-		pe->adev->df.funcs->pmc_start(pe->adev, hwc->config, 0);
+		pe->adev->df.funcs->pmc_start(pe->adev, hwc->config,
+								hwc->idx, 0);
 		break;
 	default:
 		break;
@@ -101,8 +103,8 @@ static void amdgpu_perf_read(struct perf_event *event)
 
 		switch (pe->pmu_perf_type) {
 		case PERF_TYPE_AMDGPU_DF:
-			pe->adev->df.funcs->pmc_get_count(pe->adev, hwc->config,
-							  &count);
+			pe->adev->df.funcs->pmc_get_count(pe->adev,
+						hwc->config, hwc->idx, &count);
 			break;
 		default:
 			count = 0;
@@ -126,7 +128,8 @@ static void amdgpu_perf_stop(struct perf_event *event, int flags)
 
 	switch (pe->pmu_perf_type) {
 	case PERF_TYPE_AMDGPU_DF:
-		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, 0);
+		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, hwc->idx,
+									0);
 		break;
 	default:
 		break;
@@ -157,7 +160,12 @@ static int amdgpu_perf_add(struct perf_event *event, int flags)
 	switch (pe->pmu_perf_type) {
 	case PERF_TYPE_AMDGPU_DF:
 		retval = pe->adev->df.funcs->pmc_start(pe->adev,
-						       hwc->config, 1);
+						hwc->config, hwc->idx, 1);
+		if (retval >= 0) {
+			hwc->idx = retval;
+			retval = 0;
+		}
+
 		break;
 	default:
 		return 0;
@@ -185,7 +193,8 @@ static void amdgpu_perf_del(struct perf_event *event, int flags)
 
 	switch (pe->pmu_perf_type) {
 	case PERF_TYPE_AMDGPU_DF:
-		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, 1);
+		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, hwc->idx,
+									1);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 7b89fd2aa44a..8dadcdcffba0 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -391,33 +391,28 @@ static void df_v3_6_get_clockgating_state(struct amdgpu_device *adev,
 }
 
 /* get assigned df perfmon ctr as int */
-static int df_v3_6_pmc_config_2_cntr(struct amdgpu_device *adev,
-				      uint64_t config)
+static bool df_v3_6_pmc_has_counter(struct amdgpu_device *adev,
+				      uint64_t config,
+				      int counter_idx)
 {
-	int i;
 
-	for (i = 0; i < DF_V3_6_MAX_COUNTERS; i++) {
-		if ((config & 0x0FFFFFFUL) ==
-					adev->df_perfmon_config_assign_mask[i])
-			return i;
-	}
+	return ((config & 0x0FFFFFFUL) ==
+			adev->df_perfmon_config_assign_mask[counter_idx]);
 
-	return -EINVAL;
 }
 
 /* get address based on counter assignment */
 static void df_v3_6_pmc_get_addr(struct amdgpu_device *adev,
 				 uint64_t config,
+				 int counter_idx,
 				 int is_ctrl,
 				 uint32_t *lo_base_addr,
 				 uint32_t *hi_base_addr)
 {
-	int target_cntr = df_v3_6_pmc_config_2_cntr(adev, config);
-
-	if (target_cntr < 0)
+	if (!df_v3_6_pmc_has_counter(adev, config, counter_idx))
 		return;
 
-	switch (target_cntr) {
+	switch (counter_idx) {
 
 	case 0:
 		*lo_base_addr = is_ctrl ? smnPerfMonCtlLo4 : smnPerfMonCtrLo4;
@@ -443,15 +438,18 @@ static void df_v3_6_pmc_get_addr(struct amdgpu_device *adev,
 /* get read counter address */
 static void df_v3_6_pmc_get_read_settings(struct amdgpu_device *adev,
 					  uint64_t config,
+					  int counter_idx,
 					  uint32_t *lo_base_addr,
 					  uint32_t *hi_base_addr)
 {
-	df_v3_6_pmc_get_addr(adev, config, 0, lo_base_addr, hi_base_addr);
+	df_v3_6_pmc_get_addr(adev, config, counter_idx, 0, lo_base_addr,
+								hi_base_addr);
 }
 
 /* get control counter settings i.e. address and values to set */
 static int df_v3_6_pmc_get_ctrl_settings(struct amdgpu_device *adev,
 					  uint64_t config,
+					  int counter_idx,
 					  uint32_t *lo_base_addr,
 					  uint32_t *hi_base_addr,
 					  uint32_t *lo_val,
@@ -462,7 +460,8 @@ static int df_v3_6_pmc_get_ctrl_settings(struct amdgpu_device *adev,
 	uint32_t eventsel, instance, unitmask;
 	uint32_t instance_10, instance_5432, instance_76;
 
-	df_v3_6_pmc_get_addr(adev, config, 1, lo_base_addr, hi_base_addr);
+	df_v3_6_pmc_get_addr(adev, config, counter_idx, 1, lo_base_addr,
+				hi_base_addr);
 
 	if ((*lo_base_addr == 0) || (*hi_base_addr == 0)) {
 		DRM_ERROR("[DF PMC] addressing not retrieved! Lo: %x, Hi: %x",
@@ -492,18 +491,13 @@ static int df_v3_6_pmc_get_ctrl_settings(struct amdgpu_device *adev,
 static int df_v3_6_pmc_add_cntr(struct amdgpu_device *adev,
 				   uint64_t config)
 {
-	int i, target_cntr;
-
-	target_cntr = df_v3_6_pmc_config_2_cntr(adev, config);
-
-	if (target_cntr >= 0)
-		return 0;
+	int i;
 
 	for (i = 0; i < DF_V3_6_MAX_COUNTERS; i++) {
 		if (adev->df_perfmon_config_assign_mask[i] == 0U) {
 			adev->df_perfmon_config_assign_mask[i] =
 							config & 0x0FFFFFFUL;
-			return 0;
+			return i;
 		}
 	}
 
@@ -512,59 +506,50 @@ static int df_v3_6_pmc_add_cntr(struct amdgpu_device *adev,
 
 #define DEFERRED_ARM_MASK	(1 << 31)
 static int df_v3_6_pmc_set_deferred(struct amdgpu_device *adev,
-				    uint64_t config, bool is_deferred)
+				    int counter_idx, uint64_t config,
+				    bool is_deferred)
 {
-	int target_cntr;
-
-	target_cntr = df_v3_6_pmc_config_2_cntr(adev, config);
 
-	if (target_cntr < 0)
+	if (!df_v3_6_pmc_has_counter(adev, config, counter_idx))
 		return -EINVAL;
 
 	if (is_deferred)
-		adev->df_perfmon_config_assign_mask[target_cntr] |=
+		adev->df_perfmon_config_assign_mask[counter_idx] |=
 							DEFERRED_ARM_MASK;
 	else
-		adev->df_perfmon_config_assign_mask[target_cntr] &=
+		adev->df_perfmon_config_assign_mask[counter_idx] &=
 							~DEFERRED_ARM_MASK;
 
 	return 0;
 }
 
 static bool df_v3_6_pmc_is_deferred(struct amdgpu_device *adev,
+				    int counter_idx,
 				    uint64_t config)
 {
-	int target_cntr;
-
-	target_cntr = df_v3_6_pmc_config_2_cntr(adev, config);
-
-	/*
-	 * we never get target_cntr < 0 since this funciton is only called in
-	 * pmc_count for now but we should check anyways.
-	 */
-	return (target_cntr >= 0 &&
-			(adev->df_perfmon_config_assign_mask[target_cntr]
-			& DEFERRED_ARM_MASK));
+	return	(df_v3_6_pmc_has_counter(adev, config, counter_idx) &&
+			(adev->df_perfmon_config_assign_mask[counter_idx]
+				& DEFERRED_ARM_MASK));
 
 }
 
 /* release performance counter */
 static void df_v3_6_pmc_release_cntr(struct amdgpu_device *adev,
-				     uint64_t config)
+				     uint64_t config,
+				     int counter_idx)
 {
-	int target_cntr = df_v3_6_pmc_config_2_cntr(adev, config);
-
-	if (target_cntr >= 0)
-		adev->df_perfmon_config_assign_mask[target_cntr] = 0ULL;
+	if (df_v3_6_pmc_has_counter(adev, config, counter_idx))
+		adev->df_perfmon_config_assign_mask[counter_idx] = 0ULL;
 }
 
 
 static void df_v3_6_reset_perfmon_cntr(struct amdgpu_device *adev,
-					 uint64_t config)
+					 uint64_t config,
+					 int counter_idx)
 {
 	uint32_t lo_base_addr = 0, hi_base_addr = 0;
 
-	df_v3_6_pmc_get_read_settings(adev, config, &lo_base_addr,
+	df_v3_6_pmc_get_read_settings(adev, config, counter_idx, &lo_base_addr,
 				      &hi_base_addr);
 
 	if ((lo_base_addr == 0) || (hi_base_addr == 0))
@@ -574,7 +559,7 @@ static void df_v3_6_reset_perfmon_cntr(struct amdgpu_device *adev,
 }
 
 static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,
-			     int is_add)
+			     int counter_idx, int is_add)
 {
 	uint32_t lo_base_addr, hi_base_addr, lo_val, hi_val;
 	int err = 0, ret = 0;
@@ -584,10 +569,9 @@ static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,
 		if (is_add)
 			return df_v3_6_pmc_add_cntr(adev, config);
 
-		df_v3_6_reset_perfmon_cntr(adev, config);
-
 		ret = df_v3_6_pmc_get_ctrl_settings(adev,
 					config,
+					counter_idx,
 					&lo_base_addr,
 					&hi_base_addr,
 					&lo_val,
@@ -604,7 +588,8 @@ static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,
 						     hi_val);
 
 		if (err)
-			ret = df_v3_6_pmc_set_deferred(adev, config, true);
+			ret = df_v3_6_pmc_set_deferred(adev, config,
+							counter_idx, true);
 
 		break;
 	default:
@@ -615,7 +600,7 @@ static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,
 }
 
 static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
-			    int is_remove)
+			    int counter_idx, int is_remove)
 {
 	uint32_t lo_base_addr, hi_base_addr, lo_val, hi_val;
 	int ret = 0;
@@ -624,6 +609,7 @@ static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
 	case CHIP_VEGA20:
 		ret = df_v3_6_pmc_get_ctrl_settings(adev,
 			config,
+			counter_idx,
 			&lo_base_addr,
 			&hi_base_addr,
 			&lo_val,
@@ -635,8 +621,8 @@ static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
 
 
 		if (is_remove) {
-			df_v3_6_reset_perfmon_cntr(adev, config);
-			df_v3_6_pmc_release_cntr(adev, config);
+			df_v3_6_reset_perfmon_cntr(adev, config, counter_idx);
+			df_v3_6_pmc_release_cntr(adev, config, counter_idx);
 		}
 
 		break;
@@ -649,6 +635,7 @@ static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
 
 static void df_v3_6_pmc_get_count(struct amdgpu_device *adev,
 				  uint64_t config,
+				  int counter_idx,
 				  uint64_t *count)
 {
 	uint32_t lo_base_addr = 0, hi_base_addr = 0, lo_val = 0, hi_val = 0;
@@ -656,14 +643,14 @@ static void df_v3_6_pmc_get_count(struct amdgpu_device *adev,
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
-		df_v3_6_pmc_get_read_settings(adev, config, &lo_base_addr,
-				      &hi_base_addr);
+		df_v3_6_pmc_get_read_settings(adev, config, counter_idx,
+						&lo_base_addr, &hi_base_addr);
 
 		if ((lo_base_addr == 0) || (hi_base_addr == 0))
 			return;
 
 		/* rearm the counter or throw away count value on failure */
-		if (df_v3_6_pmc_is_deferred(adev, config)) {
+		if (df_v3_6_pmc_is_deferred(adev, config, counter_idx)) {
 			int rearm_err = df_v3_6_perfmon_arm_with_status(adev,
 							lo_base_addr, lo_val,
 							hi_base_addr, hi_val);
@@ -671,7 +658,8 @@ static void df_v3_6_pmc_get_count(struct amdgpu_device *adev,
 			if (rearm_err)
 				return;
 
-			df_v3_6_pmc_set_deferred(adev, config, false);
+			df_v3_6_pmc_set_deferred(adev, config, counter_idx,
+									false);
 		}
 
 		df_v3_6_perfmon_rreg(adev, lo_base_addr, &lo_val,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
