Return-Path: <SRS0=BIvg=DA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DEEC2D0A8
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 18:35:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A612068D
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 18:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AMNmypYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A612068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 026956E9E7;
	Wed, 23 Sep 2020 18:35:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A8BD6E9E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2020 18:35:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eK1OCjRnyJ8a6HalETOwJySGHQTEQ/IFnykSCI86QfTXevyB5+rSOFYa4dAQ62j4bLZLQlQKjDUYiyjusuvfSTNATUmGDw4YsTa6jZ/WGboVQjzvjf10CEl0AYuHUShLEGmhFQ1mmZ7pgyM3QMLXknCEw2SjRFObRU9S2jTdAJw6dPQ0+az8wtMz/IMZKbvWysu6itg8BigHBLMgZMU/CppkL58JcU+/KX9gKU3pYFgCU7fkvdp0T7VbsqJo7VEi/smPDcjBkzNJWDNng8l4oUpTgJ33TOlxavr7g1LqHY9TWcTXqseSlvQc6LezbPslQ1S1T0zyTjiywtXDyWH7yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExUXNjOXneRa4LxJoLN83x5LQ+4PbzjiUYyH4gtZL3Y=;
 b=iNOlgrugBksLmgbwLFFpb1TUbOA07k3ycOc2Ua85EhNN8dFm1Sj7/QY3E55DANnBf5r2c7QAS/45GRaXn6fPCNqzUqglUuVDs55uByPN1mMdewr3Puu3ffdZMW9CDkHPQR0PV1hwT5eimpfpK/0NM47FI2S2I7VQEJua5D2IN3IxEZOIQZvi0KmSkGsCaczSUNPSo2C3fjN6R9ffYSxDLF1xdb8VSMY/cVlehCqYnC439syjdoPT6tlrB9NLKtR70nIK17KJB3ranegm2hIZYB3C3Kr71fkp0jyUFAAP1OCn7KqNPhx58fIm5A/5xnz1gWlAxUgbgsemEoCyqpbZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExUXNjOXneRa4LxJoLN83x5LQ+4PbzjiUYyH4gtZL3Y=;
 b=AMNmypYfUh0obnU2eSNZ87ZUFbVckya+LdamvRosLea0A/2werWH0WMdamuM0RSx5DfbSMCFE3RwilkQNx1DsWLhET4Jhkyds1y5SAlnet8clhd9FgCYCtV+GmnEN5XWbaE3TFpEOU7XeAJgmOjo7SMtrGcXjAeE53ik9QWFp+s=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18) by BN6PR1201MB0082.namprd12.prod.outlook.com
 (2603:10b6:405:53::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Wed, 23 Sep
 2020 18:35:44 +0000
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be]) by BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be%4]) with mapi id 15.20.3391.027; Wed, 23 Sep 2020
 18:35:43 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: fix xgmi perfmon a-b-a problem
Date: Wed, 23 Sep 2020 14:35:16 -0400
Message-Id: <20200923183518.65789-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::20) To BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jonathan-KFD.amd.com (165.204.55.251) by
 YTOPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21 via Frontend
 Transport; Wed, 23 Sep 2020 18:35:43 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7ca8305d-73dd-4e94-cc9c-08d85fef7ac3
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0082:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0082DC4659C44A2C7E48E2B885380@BN6PR1201MB0082.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zqtGExXlKi2rfStKpi6//ZA58m0PXB5WrnprcvEvNLHS8l9g/pU4fwcJtdy51EvDJwnzmxtzTLE0pAVRYI0ZMHps62cZEhJz6AhIjFkzIzhnZnHKfEXwyrlajRhJnKvldlwiFUP9yAejNgSuDfpgaQuYSZIZ8kTNFaEWIH+Q9s+0cnv4KbPt32OSjCDeArE7DDM1eNL6XPE8YhDxcclQ3tXLGpN41xAIOQwidRiCFtwB2Wi0AFpEYIpGpx0kkX0ftiOuNYPG60Uk4ztcJOn09XKmsKaRnK3D+dKLfKby8c1NpuB6HUo1nGfp9lNXps6BseFgYbCTyaF0WsCBYy+a5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(86362001)(6486002)(316002)(478600001)(1076003)(66946007)(66556008)(66476007)(956004)(2616005)(8676002)(186003)(16526019)(26005)(83380400001)(6916009)(6666004)(2906002)(7696005)(54906003)(30864003)(36756003)(52116002)(44832011)(8936002)(5660300002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: UOwOH/qKLgjbpZsFSHw+StZ/yVSmH9j4gwznNpWCqYEIWhl2RJzta+/f4MBbQfBT/6E7hJQVsdHyJM1PMsZPwyXrg5jM5Oyj2VviUIrBnAwrrf6VOdMxAnMduUMjHY3aBXvkxs4R1pa+v56KfxTFrOif1rJxpjhPlwwhzJMf097O0k4w7B5Z+EWA5B2n6Jab6mihaR5gHp2/vyeOthQCeBfEXbih5vmN/ISTen/6GglwYLgzoSNAt5ClTvZRXlO9H+Avkijaesyek9LvhNROzLT2jkVExuGIv3dRIbwx7wRN/lAE/f7purg4WN4cO6//BsXfUXnOzgXPm8TGdzrab5xXCF1ZEPIVV9MF3DERuGcGfAL1L5oiDymVMXgTDUJukLDZTMxqZXjnBHHR4n45EcP4AmG7I02OKkoa3w9D2Mpj0C970tM6VZBwqiO3weHQfoVeaIYfE/Tliz6M1RE8HhpTKpYvrYJLo3xD3t55eiKHpsOVJMCf2LIH2Kgki/CaFVIu1HlvGU5lXAo23b0ci5ICtS5JszZnDoPufaD0mIuq0XwMNQKtxQ3BsaPsfb7UpGOL0pND32Hnscow3wMc3JIw7bRCk17+NLEiCcFGM6VOjg9eBUdfCyYuEAjI4lxYkheIZ0yHtBV70i9p1IborQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca8305d-73dd-4e94-cc9c-08d85fef7ac3
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 18:35:43.7098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T85fcX2PpU8dtcU1ocnLuGtOiQcKysUnrggNXs8rfrNwoPqnNaw1Td9icHdgvCM8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0082
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
Cc: Jonathan Kim <Jonathan.Kim@amd.com>, Harish.Kasiviswanathan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Mapping hw counters per event config will cause ABA problems so map per
event instead.

v2: Discontinue starting perf counters if add fails.  Make it clear what's
happening with pmc_start.

Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_df.h  |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c |  42 ++++++----
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c    | 105 +++++++++++-------------
 3 files changed, 78 insertions(+), 75 deletions(-)

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
index 69af462db34d..1b0ec715c8ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
@@ -64,6 +64,7 @@ static void amdgpu_perf_start(struct perf_event *event, int flags)
 	struct amdgpu_pmu_entry *pe = container_of(event->pmu,
 						  struct amdgpu_pmu_entry,
 						  pmu);
+	int target_cntr = 0;
 
 	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
 		return;
@@ -73,17 +74,24 @@ static void amdgpu_perf_start(struct perf_event *event, int flags)
 
 	switch (pe->pmu_perf_type) {
 	case PERF_TYPE_AMDGPU_DF:
-		if (!(flags & PERF_EF_RELOAD))
-			pe->adev->df.funcs->pmc_start(pe->adev, hwc->config, 1);
+		if (!(flags & PERF_EF_RELOAD)) {
+			target_cntr = pe->adev->df.funcs->pmc_start(pe->adev,
+						hwc->config, 0 /* unused */,
+						1 /* add counter */);
+			if (target_cntr < 0)
+				break;
+
+			hwc->idx = target_cntr;
+		}
 
-		pe->adev->df.funcs->pmc_start(pe->adev, hwc->config, 0);
+		pe->adev->df.funcs->pmc_start(pe->adev, hwc->config,
+								hwc->idx, 0);
 		break;
 	default:
 		break;
 	}
 
 	perf_event_update_userpage(event);
-
 }
 
 /* read perf counter */
@@ -101,8 +109,8 @@ static void amdgpu_perf_read(struct perf_event *event)
 
 		switch (pe->pmu_perf_type) {
 		case PERF_TYPE_AMDGPU_DF:
-			pe->adev->df.funcs->pmc_get_count(pe->adev, hwc->config,
-							  &count);
+			pe->adev->df.funcs->pmc_get_count(pe->adev,
+						hwc->config, hwc->idx, &count);
 			break;
 		default:
 			count = 0;
@@ -126,7 +134,8 @@ static void amdgpu_perf_stop(struct perf_event *event, int flags)
 
 	switch (pe->pmu_perf_type) {
 	case PERF_TYPE_AMDGPU_DF:
-		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, 0);
+		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, hwc->idx,
+									0);
 		break;
 	default:
 		break;
@@ -142,12 +151,11 @@ static void amdgpu_perf_stop(struct perf_event *event, int flags)
 	hwc->state |= PERF_HES_UPTODATE;
 }
 
-/* add perf counter  */
+/* add perf counter */
 static int amdgpu_perf_add(struct perf_event *event, int flags)
 {
 	struct hw_perf_event *hwc = &event->hw;
-	int retval;
-
+	int retval = 0, target_cntr;
 	struct amdgpu_pmu_entry *pe = container_of(event->pmu,
 						  struct amdgpu_pmu_entry,
 						  pmu);
@@ -156,8 +164,14 @@ static int amdgpu_perf_add(struct perf_event *event, int flags)
 
 	switch (pe->pmu_perf_type) {
 	case PERF_TYPE_AMDGPU_DF:
-		retval = pe->adev->df.funcs->pmc_start(pe->adev,
-						       hwc->config, 1);
+		target_cntr = pe->adev->df.funcs->pmc_start(pe->adev,
+						hwc->config, 0 /* unused */,
+						1 /* add counter */);
+		if (target_cntr < 0)
+			retval = target_cntr;
+		else
+			hwc->idx = target_cntr;
+
 		break;
 	default:
 		return 0;
@@ -170,7 +184,6 @@ static int amdgpu_perf_add(struct perf_event *event, int flags)
 		amdgpu_perf_start(event, PERF_EF_RELOAD);
 
 	return retval;
-
 }
 
 /* delete perf counter  */
@@ -185,7 +198,8 @@ static void amdgpu_perf_del(struct perf_event *event, int flags)
 
 	switch (pe->pmu_perf_type) {
 	case PERF_TYPE_AMDGPU_DF:
-		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, 1);
+		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, hwc->idx,
+									1);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 7b89fd2aa44a..0ca6e176acb0 100644
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
@@ -573,8 +558,9 @@ static void df_v3_6_reset_perfmon_cntr(struct amdgpu_device *adev,
 	df_v3_6_perfmon_wreg(adev, lo_base_addr, 0, hi_base_addr, 0);
 }
 
+/* return available counter if is_add == 1 otherwise return error status. */
 static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,
-			     int is_add)
+			     int counter_idx, int is_add)
 {
 	uint32_t lo_base_addr, hi_base_addr, lo_val, hi_val;
 	int err = 0, ret = 0;
@@ -584,10 +570,9 @@ static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,
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
@@ -604,7 +589,8 @@ static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,
 						     hi_val);
 
 		if (err)
-			ret = df_v3_6_pmc_set_deferred(adev, config, true);
+			ret = df_v3_6_pmc_set_deferred(adev, config,
+							counter_idx, true);
 
 		break;
 	default:
@@ -615,7 +601,7 @@ static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,
 }
 
 static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
-			    int is_remove)
+			    int counter_idx, int is_remove)
 {
 	uint32_t lo_base_addr, hi_base_addr, lo_val, hi_val;
 	int ret = 0;
@@ -624,6 +610,7 @@ static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
 	case CHIP_VEGA20:
 		ret = df_v3_6_pmc_get_ctrl_settings(adev,
 			config,
+			counter_idx,
 			&lo_base_addr,
 			&hi_base_addr,
 			&lo_val,
@@ -635,8 +622,8 @@ static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
 
 
 		if (is_remove) {
-			df_v3_6_reset_perfmon_cntr(adev, config);
-			df_v3_6_pmc_release_cntr(adev, config);
+			df_v3_6_reset_perfmon_cntr(adev, config, counter_idx);
+			df_v3_6_pmc_release_cntr(adev, config, counter_idx);
 		}
 
 		break;
@@ -649,6 +636,7 @@ static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
 
 static void df_v3_6_pmc_get_count(struct amdgpu_device *adev,
 				  uint64_t config,
+				  int counter_idx,
 				  uint64_t *count)
 {
 	uint32_t lo_base_addr = 0, hi_base_addr = 0, lo_val = 0, hi_val = 0;
@@ -656,14 +644,14 @@ static void df_v3_6_pmc_get_count(struct amdgpu_device *adev,
 
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
@@ -671,7 +659,8 @@ static void df_v3_6_pmc_get_count(struct amdgpu_device *adev,
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
