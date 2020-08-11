Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FF6C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 03:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54551206DA
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 03:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Yot5ySf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54551206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23C926E0A8;
	Tue, 11 Aug 2020 03:36:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAF876E0A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 03:36:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcRWRZLFXUp2E5/baE6BYicXJLho7mTAXmwVlSrVqZbVAliV/32Zj5eWxJ2Zu6lf7hVORwAsovax4+vEDASL7g3gh2LLsc+1+L0BOhoPDUlSDwbqvaAhozx1OXYhPcDf8rskfSNvl7u226zIykO2NabnpuyHe6kT4szez/LKcbhor/Y2y5lBOKI46S8/NfX2I4h8DiXFMS7k/WAI43biuRsWYaa512SAK1UE//+3pp3FzW5yODrHg1Z7tnO4aXKgCvFHYUaLx2sK7tW9SDh/uJD7vMqYsFR8DWLKUu2ajdH0Ah27CrQKDk49Vnquj3jDzeoyPOLL98vSwDvqB0TJ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFQPohje+GuNjVWZGV1NS2NY8veDnQ4+dW9aENLpVDI=;
 b=MUIjTdSna6hCzCKDFK/tXuZGnPwWOATU7+CCWJrxCIFutWpNCnr8Cu9KxO1O3Rvbkc1xXX3WwUiG+/e1vVO9JT2SStmfYLhShhA93B4gxPNGOwnAeqSvN/Mg3nACms4QFjf8ro7hJ8IdzKpkrCAIITQ7wexNdU9f/gKoxWC1Q1+p12c7sSCU7dtIxrqwvHqYOz4SWMOA8AL/+D9Edf3DQjsMf3XB1J5jB4xmADXjCbEB/o10Q45iWI+yafmXPQqayCElvM6/5/5HfWkIRJHK0hZcFr7ZYOWi162KWQcBFH010Oq84TqkmmmIA0TVOiyySH3u3hWlzEbWJf2EHfstCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFQPohje+GuNjVWZGV1NS2NY8veDnQ4+dW9aENLpVDI=;
 b=Yot5ySf+f6H1mPpCuRkrGvmfsX/irV6L6qAY9IkX8jsanWH3VThHGKnmin8EWO4puLYcLiST+obzY1CptQhrnVTy4ClXe5R9/CaDVetKNRE+fhCGQUAqF3ZGrMjnCuD42vZnD9IhTIWwkW4TkKzZc421Sy6xqOcF1karsCTyVXI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2891.namprd12.prod.outlook.com (2603:10b6:5:188::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.18; Tue, 11 Aug 2020 03:36:24 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3261.022; Tue, 11 Aug 2020
 03:36:24 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/powerplay: maximum the code sharing around
 metrics table retrieving
Date: Tue, 11 Aug 2020 11:35:56 +0800
Message-Id: <20200811033556.1004-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200811033556.1004-1-evan.quan@amd.com>
References: <20200811033556.1004-1-evan.quan@amd.com>
X-ClientProxiedBy: HKAPR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:203:c8::9) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HKAPR03CA0004.apcprd03.prod.outlook.com (2603:1096:203:c8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.5 via Frontend Transport; Tue, 11 Aug 2020 03:36:22 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 36591361-6310-4e8f-5498-08d83da7b8ab
X-MS-TrafficTypeDiagnostic: DM6PR12MB2891:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2891A6FCD2490506D8C93BE3E4450@DM6PR12MB2891.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:205;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TpfoldKuCj50ASkELNhN1BzpsOVjLBmk2lOhGxe1NaI3eqLQlkJJe6djGToJhIXb8h9+30pGo4ynjoRK6bRXeaFus84clRuILKgFLcwr/1+BEcNtLp8giGz24mhUpguRV+n4jYUYXYgdztmwove9stivH1ze9bAzp2+vBR6R+cdL9fbW6sBn7O54UHT2EVBmcP9z4tfGpW7f5zOqHAbnKIle36kTbJSlprg/8j1xP4pwHqDRqgsstbSUNWjfX41CPt9KCyb2Rqxow3BwBLvN2j6K+Q3w33hywWSNcXRjCaMSxcmPYKMkYMhM79yLP22VaWFTO356vrgRdUL2d8PClg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(8676002)(16526019)(186003)(26005)(36756003)(478600001)(956004)(83380400001)(5660300002)(2616005)(52116002)(8936002)(7696005)(4326008)(44832011)(6486002)(316002)(1076003)(86362001)(6666004)(66946007)(66556008)(66476007)(6916009)(30864003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: P+JXPK2CFsHyNZ3YNz6X5MQ9BcBlkadcfzGE9ziVqrIRdpvRpOR0Gd7HSe92Qip1webnOgn/NRSk9sTkpNa5ezt+WkLiZBWSyTyku7/K6li7CGVyWIAFZFwIfcwm2aFqfsYLyVJYbfZdWsUD8kaUhRX7LuDYlq6mf7A0KiIVPYM3WCFMPWz4abIuCap1pthd7qaS4biTjKfqb+M8BlOAqGWg7NwQA+UirfAMdpJw8v8yOIY/87scxpqVmOTcw8rynDUAxGUoiJ/BK5utSUK/ZIbuilRKcPgAQ52UswSuLR+kdmek/q8m5oZPFpFS1DEzFlhPJqfbgc/fWZZkdwkLb6QVL4prbNIMh5q4ZDUlGhKSxv6Q2SW09nZd/BO+eFBj194SvvkDr0fbOdrcfrs88GDS5SMwGgZwGwHDA4kuBupQWXNST0gRMfjNV+1qwuyhFDbYaiTBn8nCPLy+V35WRpyKfGb087ZDRROWIWqwIWhYBXBZrtJfEdsbmiRXWOMo68rBJgs5R86ecweK5lJTmrZmJrxzshfphXy82q59XrvVxq6SkYcBm8r0ZESNhiFdFDljlwqy1pBpfvb62vFfAD+xxCxHpuELWbQNnTLbtnHeBVoVSzBcjONgr2jobDEc5w+MaNqqErKYyiKr5h2IsQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36591361-6310-4e8f-5498-08d83da7b8ab
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 03:36:24.3142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79/rtxnYMn9iQFWIwN0IE4gMdXbNMVGgHFpB96HxPRA+Vx6LxgcB/vZRB03kOD/8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2891
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of having one copy in each ASIC.

Change-Id: I5e2a72382700cdb0e4847e5d9e2143f4b5508cdb
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 55 ++-----------------
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 41 +++-----------
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    | 40 ++------------
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 55 ++-----------------
 drivers/gpu/drm/amd/powerplay/smu_cmn.c       | 45 +++++++++++++++
 drivers/gpu/drm/amd/powerplay/smu_cmn.h       |  8 +++
 6 files changed, 77 insertions(+), 167 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index e59e6fb6f0a8..8b1025dc54fd 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -541,49 +541,6 @@ static int arcturus_freqs_in_same_level(int32_t frequency1,
 	return (abs(frequency1 - frequency2) <= EPSILON);
 }
 
-static int arcturus_get_metrics_table_locked(struct smu_context *smu,
-					     SmuMetrics_t *metrics_table,
-					     bool bypass_cache)
-{
-	struct smu_table_context *smu_table= &smu->smu_table;
-	int ret = 0;
-
-	if (bypass_cache ||
-	    !smu_table->metrics_time ||
-	    time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1))) {
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_SMU_METRICS,
-				       0,
-				       smu_table->metrics_table,
-				       false);
-		if (ret) {
-			dev_info(smu->adev->dev, "Failed to export SMU metrics table!\n");
-			return ret;
-		}
-		smu_table->metrics_time = jiffies;
-	}
-
-	if (metrics_table)
-		memcpy(metrics_table, smu_table->metrics_table, sizeof(SmuMetrics_t));
-
-	return 0;
-}
-
-static int arcturus_get_metrics_table(struct smu_context *smu,
-				      SmuMetrics_t *metrics_table,
-				      bool bypass_cache)
-{
-	int ret = 0;
-
-	mutex_lock(&smu->metrics_lock);
-	ret = arcturus_get_metrics_table_locked(smu,
-						metrics_table,
-						bypass_cache);
-	mutex_unlock(&smu->metrics_lock);
-
-	return ret;
-}
-
 static int arcturus_get_smu_metrics_data(struct smu_context *smu,
 					 MetricsMember_t member,
 					 uint32_t *value)
@@ -594,9 +551,9 @@ static int arcturus_get_smu_metrics_data(struct smu_context *smu,
 
 	mutex_lock(&smu->metrics_lock);
 
-	ret = arcturus_get_metrics_table_locked(smu,
-						NULL,
-						false);
+	ret = smu_cmn_get_metrics_table_locked(smu,
+					       NULL,
+					       false);
 	if (ret) {
 		mutex_unlock(&smu->metrics_lock);
 		return ret;
@@ -2305,9 +2262,9 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 	SmuMetrics_t metrics;
 	int ret = 0;
 
-	ret = arcturus_get_metrics_table(smu,
-					 &metrics,
-					 true);
+	ret = smu_cmn_get_metrics_table(smu,
+					&metrics,
+					true);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 82659b781f05..42a60769c52f 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -504,34 +504,6 @@ static int navi10_tables_init(struct smu_context *smu)
 	return -ENOMEM;
 }
 
-static int navi10_get_metrics_table_locked(struct smu_context *smu,
-					   SmuMetrics_t *metrics_table,
-					   bool bypass_cache)
-{
-	struct smu_table_context *smu_table= &smu->smu_table;
-	int ret = 0;
-
-	if (bypass_cache ||
-	    !smu_table->metrics_time ||
-	    time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1))) {
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_SMU_METRICS,
-				       0,
-				       smu_table->metrics_table,
-				       false);
-		if (ret) {
-			dev_info(smu->adev->dev, "Failed to export SMU metrics table!\n");
-			return ret;
-		}
-		smu_table->metrics_time = jiffies;
-	}
-
-	if (metrics_table)
-		memcpy(metrics_table, smu_table->metrics_table, sizeof(SmuMetrics_t));
-
-	return 0;
-}
-
 static int navi10_get_smu_metrics_data(struct smu_context *smu,
 				       MetricsMember_t member,
 				       uint32_t *value)
@@ -547,9 +519,9 @@ static int navi10_get_smu_metrics_data(struct smu_context *smu,
 
 	mutex_lock(&smu->metrics_lock);
 
-	ret = navi10_get_metrics_table_locked(smu,
-					      NULL,
-					      false);
+	ret = smu_cmn_get_metrics_table_locked(smu,
+					       NULL,
+					       false);
 	if (ret) {
 		mutex_unlock(&smu->metrics_lock);
 		return ret;
@@ -2526,14 +2498,15 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 
 	mutex_lock(&smu->metrics_lock);
 
-	ret = navi10_get_metrics_table_locked(smu,
-					      &metrics,
-					      true);
+	ret = smu_cmn_get_metrics_table_locked(smu,
+					       NULL,
+					       true);
 	if (ret) {
 		mutex_unlock(&smu->metrics_lock);
 		return ret;
 	}
 
+	memcpy(&metrics, smu_table->metrics_table, sizeof(SmuMetrics_t));
 	if (adev->asic_type == CHIP_NAVI12)
 		memcpy(&nv12_metrics, smu_table->metrics_table, sizeof(SmuMetrics_NV12_t));
 
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index c50c4547fea9..186929c31e9e 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -128,36 +128,6 @@ static struct cmn2asic_mapping renoir_workload_map[PP_SMC_POWER_PROFILE_COUNT] =
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
 };
 
-static int renoir_get_metrics_table(struct smu_context *smu,
-				    SmuMetrics_t *metrics_table,
-				    bool bypass_cache)
-{
-	struct smu_table_context *smu_table= &smu->smu_table;
-	int ret = 0;
-
-	mutex_lock(&smu->metrics_lock);
-
-	if (bypass_cache ||
-	    !smu_table->metrics_time ||
-	    time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1))) {
-		ret = smu_cmn_update_table(smu, SMU_TABLE_SMU_METRICS, 0,
-				(void *)smu_table->metrics_table, false);
-		if (ret) {
-			dev_info(smu->adev->dev, "Failed to export SMU metrics table!\n");
-			mutex_unlock(&smu->metrics_lock);
-			return ret;
-		}
-		smu_table->metrics_time = jiffies;
-	}
-
-	if (metrics_table)
-		memcpy(metrics_table, smu_table->metrics_table, sizeof(SmuMetrics_t));
-
-	mutex_unlock(&smu->metrics_lock);
-
-	return ret;
-}
-
 static int renoir_init_smc_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -381,7 +351,7 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 
 	memset(&metrics, 0, sizeof(metrics));
 
-	ret = renoir_get_metrics_table(smu, &metrics, false);
+	ret = smu_cmn_get_metrics_table(smu, &metrics, false);
 	if (ret)
 		return ret;
 
@@ -527,7 +497,7 @@ static int renoir_get_current_clk_freq_by_table(struct smu_context *smu,
 	int ret = 0, clk_id = 0;
 	SmuMetrics_t metrics;
 
-	ret = renoir_get_metrics_table(smu, &metrics, false);
+	ret = smu_cmn_get_metrics_table(smu, &metrics, false);
 	if (ret)
 		return ret;
 
@@ -610,7 +580,7 @@ static int renoir_get_gpu_temperature(struct smu_context *smu, uint32_t *value)
 	if (!value)
 		return -EINVAL;
 
-	ret = renoir_get_metrics_table(smu, &metrics, false);
+	ret = smu_cmn_get_metrics_table(smu, &metrics, false);
 	if (ret)
 		return ret;
 
@@ -630,7 +600,7 @@ static int renoir_get_current_activity_percent(struct smu_context *smu,
 	if (!value)
 		return -EINVAL;
 
-	ret = renoir_get_metrics_table(smu, &metrics, false);
+	ret = smu_cmn_get_metrics_table(smu, &metrics, false);
 	if (ret)
 		return ret;
 
@@ -1016,7 +986,7 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 	SmuMetrics_t metrics;
 	int ret = 0;
 
-	ret = renoir_get_metrics_table(smu, &metrics, true);
+	ret = smu_cmn_get_metrics_table(smu, &metrics, true);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index bb756b4c284e..c5935f0a065b 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -407,49 +407,6 @@ static int sienna_cichlid_tables_init(struct smu_context *smu)
 	return -ENOMEM;
 }
 
-static int sienna_cichlid_get_metrics_table_locked(struct smu_context *smu,
-						   SmuMetrics_t *metrics_table,
-						   bool bypass_cache)
-{
-	struct smu_table_context *smu_table= &smu->smu_table;
-	int ret = 0;
-
-	if (bypass_cache ||
-	    !smu_table->metrics_time ||
-	    time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1))) {
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_SMU_METRICS,
-				       0,
-				       smu_table->metrics_table,
-				       false);
-		if (ret) {
-			dev_info(smu->adev->dev, "Failed to export SMU metrics table!\n");
-			return ret;
-		}
-		smu_table->metrics_time = jiffies;
-	}
-
-	if (metrics_table)
-		memcpy(metrics_table, smu_table->metrics_table, sizeof(SmuMetrics_t));
-
-	return 0;
-}
-
-static int sienna_cichlid_get_metrics_table(struct smu_context *smu,
-					    SmuMetrics_t *metrics_table,
-					    bool bypass_cache)
-{
-	int ret = 0;
-
-	mutex_lock(&smu->metrics_lock);
-	ret = sienna_cichlid_get_metrics_table_locked(smu,
-						      metrics_table,
-						      bypass_cache);
-	mutex_unlock(&smu->metrics_lock);
-
-	return ret;
-}
-
 static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 					       MetricsMember_t member,
 					       uint32_t *value)
@@ -460,9 +417,9 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 
 	mutex_lock(&smu->metrics_lock);
 
-	ret = sienna_cichlid_get_metrics_table_locked(smu,
-						      NULL,
-						      false);
+	ret = smu_cmn_get_metrics_table_locked(smu,
+					       NULL,
+					       false);
 	if (ret) {
 		mutex_unlock(&smu->metrics_lock);
 		return ret;
@@ -2698,9 +2655,9 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 	SmuMetrics_t metrics;
 	int ret = 0;
 
-	ret = sienna_cichlid_get_metrics_table(smu,
-					       &metrics,
-					       true);
+	ret = smu_cmn_get_metrics_table(smu,
+					&metrics,
+					true);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.c b/drivers/gpu/drm/amd/powerplay/smu_cmn.c
index 5c23c44c33bd..968b734baac0 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_cmn.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_cmn.c
@@ -631,3 +631,48 @@ int smu_cmn_write_pptable(struct smu_context *smu)
 				    pptable,
 				    true);
 }
+
+int smu_cmn_get_metrics_table_locked(struct smu_context *smu,
+				     void *metrics_table,
+				     bool bypass_cache)
+{
+	struct smu_table_context *smu_table= &smu->smu_table;
+	uint32_t table_size =
+		smu_table->tables[SMU_TABLE_SMU_METRICS].size;
+	int ret = 0;
+
+	if (bypass_cache ||
+	    !smu_table->metrics_time ||
+	    time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1))) {
+		ret = smu_cmn_update_table(smu,
+				       SMU_TABLE_SMU_METRICS,
+				       0,
+				       smu_table->metrics_table,
+				       false);
+		if (ret) {
+			dev_info(smu->adev->dev, "Failed to export SMU metrics table!\n");
+			return ret;
+		}
+		smu_table->metrics_time = jiffies;
+	}
+
+	if (metrics_table)
+		memcpy(metrics_table, smu_table->metrics_table, table_size);
+
+	return 0;
+}
+
+int smu_cmn_get_metrics_table(struct smu_context *smu,
+			      void *metrics_table,
+			      bool bypass_cache)
+{
+	int ret = 0;
+
+	mutex_lock(&smu->metrics_lock);
+	ret = smu_cmn_get_metrics_table_locked(smu,
+					       metrics_table,
+					       bypass_cache);
+	mutex_unlock(&smu->metrics_lock);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.h b/drivers/gpu/drm/amd/powerplay/smu_cmn.h
index 98face8c5fd6..6d00ad740c27 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_cmn.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_cmn.h
@@ -79,5 +79,13 @@ int smu_cmn_write_watermarks_table(struct smu_context *smu);
 
 int smu_cmn_write_pptable(struct smu_context *smu);
 
+int smu_cmn_get_metrics_table_locked(struct smu_context *smu,
+				     void *metrics_table,
+				     bool bypass_cache);
+
+int smu_cmn_get_metrics_table(struct smu_context *smu,
+			      void *metrics_table,
+			      bool bypass_cache);
+
 #endif
 #endif
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
