Return-Path: <SRS0=93xL=DJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A7CC4363D
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2020 20:19:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EBDA206FA
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2020 20:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cupk4iv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EBDA206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E7F16E9C9;
	Fri,  2 Oct 2020 20:19:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FF6E6E9C9
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2020 20:19:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXqh9DQOPJLh1KqysbyQR+VCg+zRMSxCVHm6vAlGhTLwbpj200jZ+ulaioBbtogTulzWCAsxxQY7ImiKTnCQaysrWqejG6rKgDLN/HX8emw4awKWw4kq0bBEij/EBizxAlsCBOtmSAT1zH5RzdEHlnIdL4pJQ6qA9CAWyuWKQf9qz0ZS1hEiSrQ+vdkpVCF8milcpbNSK81iytZO6iFLWMcwLWfgDdVXVqxtbzJ3jt5QXUFPm9ukeVJQZ0brdpABgo9BMAx7RBGLu6bQovA/eHBwdM87bk9BfSwWYra+v/lLNJxBxcrxmv2BGsjKPUgsp54jV8TqrPSciccWX+S/mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/ouAPfTuxP9hFJLJ4wGUuuWcUoO+d0TY7sxDecsTxc=;
 b=gjGv/5WF3DisirgDT7uqeamrM02hk7Gi0iV1uXAlixfOkZxfYVPpoYZFJk0xrp4Wm2wwuhRULbhOqMvphpUD9osebm7wX0QIoPfjOFx1+zwNktk/XlUCUCEmMS3ONeEldVOyIAKJoviaWvfoqNEIIwYkykRoRBDemGHWxw7pXfGq0rj2MnZR+JgeRaGP/jRoW287l9RLH5mLjoV6rxwkD6yCGQXaLUTO7tWHC5J5j5Nbx/5FDvTMi4rkadIWeo9VtfrAuXQyEvm357a+sg70bcznw1bmAVfE4JaTQ7zxd9G/8qlauOEtcTe+UERUN4i9rHySsrDb8FV6DFHzfsgzQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/ouAPfTuxP9hFJLJ4wGUuuWcUoO+d0TY7sxDecsTxc=;
 b=cupk4iv40/d5yAH+4wPewemHhPKgsoKA8wfk6rXjDP1pjtJI1cjMNk5BwXTIjS0rqZYRF4DhOE6io0dk++aOCSsT3pRnAIRmYzWheaoseN+4viBiEBU9aZEJprPH4EooVR6LElmXLGC8SVHzKWEGSRujJuW70X1Pd4hlD5Sv/0U=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18) by BN6PR1201MB0018.namprd12.prod.outlook.com
 (2603:10b6:405:54::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Fri, 2 Oct
 2020 20:19:28 +0000
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be]) by BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be%4]) with mapi id 15.20.3433.037; Fri, 2 Oct 2020
 20:19:28 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: fix xgmi perfmon a-b-a problem
Date: Fri,  2 Oct 2020 16:19:11 -0400
Message-Id: <20201002201913.126122-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::19) To BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jonathan-KFD.amd.com (165.204.55.251) by
 YT1PR01CA0050.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.34 via Frontend Transport; Fri, 2 Oct 2020 20:19:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 74d52c3d-9bd0-4e42-23b7-08d8671076a4
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0018:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB001852B7B175A86F3F5BD33E85310@BN6PR1201MB0018.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /CRm9KSHwr759AYh1gDwBOa2cuAYcMr5gE9R35TWbFbygzy9Lo+Nl3goP+JGXQCrvh/rRP0Vo+klU5RLlGJFuHaGeM7LgN386GPgGJi/Z9FQAwk9Vy+142a9aT1nbtWysq0jV0JpmGcSwXvPSMCbd2xBs0YAf2o855RMnQVo9dFeQdKfYGpXVK3nrKlUtmk3asMD0WTqBbDWhla1Ng52m9ceR3TuIpTDNrhmvw77VfWB/ZbbUFZbzMEu9mmihgFNU0SlcyzUC1okMWTIXqwHFPPiQHxWM433/i12PL3Ko8DPaVF/1Naum1s1vWdflCjjVdiSLKvuV4Yy7KqQ5+J4Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(8676002)(4326008)(186003)(16526019)(26005)(956004)(8936002)(83380400001)(6916009)(44832011)(1076003)(30864003)(2616005)(86362001)(316002)(6486002)(7696005)(66946007)(2906002)(66476007)(66556008)(52116002)(5660300002)(6666004)(36756003)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Vc2n4qf1FfmhNeqBt/7NSQwR6YvyxEwlx/sRWzNZZquIIMGrO0ErjkdZkuvHkaiUsUX3gWTyl0L7fOfEPJcKV6cGieMxueHvrX7HA5pOfYZ3LfMeZ8V5F8aLXiUYk4b5Qnx+eAJvad5OQbQigxQZWnlETULgB3xffZG9Fns+kjdusIksUE3/Dbwz5btlEVJ1o15zbxmzrkuV73BCupTFrN31n1NY/SM3IAxCUPo1yf3f0A/S8J3nqlzsqZmAVOaTek3g0k6YM086NDsJpP0T0K3cWS5lygyBHRSGb68bZGnHwZuQtI5m6e8cLyKDvprw6sR3CyJ2QlYEZXqpXl4+unL1QmTkZ05Ufyn1PHsXDZQU3BCgZOD3mWLl+GJNz6k+tLJVwxeUnqe4sPhKozw8p4F/J7TAwULu4txQbuPaGoAuJ6jOZjT0aTP4KcDtFL2M96FI08yVnhDZYADZjrQI0QOhhIANF8k1KUSkMM5TUKaC0On3jwJ2eQNOrdVF1dCY8lpz+vvUpgf/Ls381aSSgAb1DKuy5fG64aY7vuamD14mwU7gnrx+ihKur1WtKScUx5Mkz4vUPOeKkOTTPy3G1e62WbJ5N4MQvPkaviJHdUzfzI6rVNscK/Q8IqJViUndcsAYWyiO4S9bIfJBo7+NlQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d52c3d-9bd0-4e42-23b7-08d8671076a4
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 20:19:28.2550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4EplTCn/QnC426IMK90Zdd4YCmZJlbE47vbCj9vftu4FMS/Wwp4135LopW3A+cBu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0018
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
Cc: Jonathan Kim <jonathan.kim@amd.com>, Harish.Kasiviswanathan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Mapping hw counters per event config will cause ABA problems so map per
event instead.

v2: Discontinue starting perf counters if add fails.  Make it clear what's
happening with pmc_start.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
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
