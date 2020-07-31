Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B28C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:44:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6597C2083E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="niZakDBc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6597C2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 366966E99E;
	Fri, 31 Jul 2020 02:44:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8394C6E99E
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 02:44:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExqkZwd8SncMbocza93xXiBvBKsT7cjAnfZfBtsSfwo5syDRUnzJm4io/ZX7Ss8ETMOXVQYJ7vi6G+6v639XlqSW9PBZOR7ubOyVYyxNpuormFSB7vN9blWoE6NiJN8ttZvg79tsAtcvTzDLXa7FgMmCR/Jn5raTq9qIVr9Tl/l3u+P3mMjzk4BqibXeYIG23H5B7YJkqokGqRKGrxpz+Y/G5X6F9eEiiFdAhiZZRkoQ7nRGLOdWM06oaMQz+s3BXtm+7zALMRUOetFYf4e43yTY2zMs0Z2VMMjslmZbvpuYzUlvOTMFEWyQolq8vfF6nhu0DfpQg9nwImzcEoSmsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kQELiPsdcSAYJf7g4fA7g+36jT/9dG00vJ13GqK2Ag=;
 b=KIDTy1rPcauXwZPlK0NEUlBz/zzuknkDQkp0MUxim1xADOGh86m32ty729crqFmE9ggj//CN3Ny6bfGrxDaOJmqq7dpYTIv1YNnj2ox+PCpt0zOR3d8A+C9r0C+pQudQRd7DGOTOTywOnBGC55Vid1h+QkN3ssl8hGs3iMRh/b1WgP2DLMWgn7jPSk73uGW5ku9eg4KfLhXNfXFuXYZat+93ZgWe5lWAF8Z/NXrspHcoO9UQ/k2LI1azISxzrgKGkKqz+hNZRfYrl0bc+/iBzMTuC6w2S9JNJoALlkrxQH47eVlapMuU0t8mQVu1edHeM+s2IGjnS8C5FLAFaq2KTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kQELiPsdcSAYJf7g4fA7g+36jT/9dG00vJ13GqK2Ag=;
 b=niZakDBcoRAnkF7AhdD50RlNHPlAzYFabxhD0RplW/lBwadnWouATqEFpd28EBrgybQiVG+iTTm5IDyeUCy37lie741RP4mXwEjU2OuIYQPTIQLEMyiPl2i34mg6hmSdCSEl8KYgr0n7D5LsVKdXmdna8+E7TTD9bRKwtxvVDC8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16; Fri, 31 Jul 2020 02:44:37 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Fri, 31 Jul 2020
 02:44:37 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/17] drm/amd/powerplay: add control method to bypass metrics
 cache on Sienna Cichlid
Date: Fri, 31 Jul 2020 10:43:13 +0800
Message-Id: <20200731024316.28324-14-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200731024316.28324-1-evan.quan@amd.com>
References: <20200731024316.28324-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0206.apcprd02.prod.outlook.com
 (2603:1096:201:20::18) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0206.apcprd02.prod.outlook.com (2603:1096:201:20::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 02:44:35 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fbc0bc48-71a5-477e-0ada-08d834fbaa4e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4435AB0A2E6D0FB887AED24CE44E0@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: geaLWTILjnST/S2EpqWNrHTF5YTM9Q7QFYyDzz+NWjwsMh7fmc1eXtYld1LPyJsiulun37NVyseQrUV3Aiyqshq7CqZ/UiSlxlu4heEDdVAGURlsb/2PnjL/4XUdP0MuKCEIoo+WZBtO3JKbG6E754dRM3O73dOidcXIZpcFtFkgoYv2hhgio6JBiXopW6/RhQAH6A7/akOf+GKULAnkPCygydZgqm+ptiGnJmTNuBfHjCUAKKE0pFRa7eN1v+1DAbd3n9Bjr5db11OqKDtsDC/fK1XkGVix7CE1O1PHj8POUOlkBOuzZzR9/1QvXawOWkbvNWM7ZUdIYE1FwXnoWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(16526019)(186003)(6666004)(6486002)(36756003)(6916009)(8676002)(44832011)(83380400001)(956004)(26005)(66946007)(1076003)(5660300002)(66556008)(66476007)(4326008)(7696005)(2616005)(86362001)(2906002)(478600001)(8936002)(52116002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: sZ1qwiBVhu8K292W3aD9te1IUPQT8UMVtZsikbJbalCqwRS9hBEXZuBi+Or/DNYm4INXvAoQjtQ2NgswPD3rIMuaopvhhzJt+C5wbVOGKadIga2xQ5j1XoVGlyJH8WAvcyFV13Q0d8UOxKb9AgQmKAT2i0GcdmfoBnZ4i+/9EVR3k4rjoEoaNNHqS3bTMA2b0VF5/F6rV5OU1MjdRzQTQQfm+EXCR88TqWw0KrysiZIkfod4YmZ7Hca1mzB2QWLfMid1I+gt8wHrrFAWBSpnagkqO/9qa07wFZwXqN3EIKi0401U1Dk45HX3wDWK77X2MgZHRRAanVRkIDnxavApvKgITMAsmS5d+yWSluaDR92qTC7aJZYuPAMeNs+faXBEU6SwI1sjWDtU3yOGEwKUIpLVxbcUelO1G7z5MxtHf26Hv/iv1giFicBixqB61v+D25DDEad37G3opjQjt2awdf4ktA1UQkv5MCdGSUGsFx9ThIcZZ5rm69WmOGRCF8PnGfSQxNl3Qo5aD/xZN+Fq2bLKnlPSkQ0E4a9INW0zavFoefQBasWzg2aljCZeK3r7KIskZJg+BNbQ/jw+KzUUXmIDaLYQOKCyAEoPm261LyzgqQD09UhjUDRENwhIyohrPjos0Q0Gi+/2vRRr60qz/Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc0bc48-71a5-477e-0ada-08d834fbaa4e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 02:44:37.2881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fiaYLHhXRUeEGSd1J+jBILiFhTU3/jBnYy1ZLw5N41yrFTnYEpF2Vim7Y5ONGCKB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 Evan Quan <evan.quan@amd.com>, Harish.Kasiviswanathan@amd.com,
 nirmodas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As for the gpu metric export, metrics cache makes no sense. It's up to
user to decide how often the metrics should be retrieved.

Change-Id: Ic9d5f10b470584c82d4ca9035ab27fed44f0ac20
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 73 +++++++++++++------
 1 file changed, 49 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 345b8571f716..a95c82a709d8 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -407,17 +407,16 @@ static int sienna_cichlid_tables_init(struct smu_context *smu)
 	return -ENOMEM;
 }
 
-static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
-					       MetricsMember_t member,
-					       uint32_t *value)
+static int sienna_cichlid_get_metrics_table_locked(struct smu_context *smu,
+						   SmuMetrics_t *metrics_table,
+						   bool bypass_cache)
 {
 	struct smu_table_context *smu_table= &smu->smu_table;
-	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
 	int ret = 0;
 
-	mutex_lock(&smu->metrics_lock);
-	if (!smu_table->metrics_time ||
-	     time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1))) {
+	if (bypass_cache ||
+	    !smu_table->metrics_time ||
+	    time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1))) {
 		ret = smu_cmn_update_table(smu,
 				       SMU_TABLE_SMU_METRICS,
 				       0,
@@ -425,12 +424,50 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 				       false);
 		if (ret) {
 			dev_info(smu->adev->dev, "Failed to export SMU metrics table!\n");
-			mutex_unlock(&smu->metrics_lock);
 			return ret;
 		}
 		smu_table->metrics_time = jiffies;
 	}
 
+	if (metrics_table)
+		memcpy(metrics_table, smu_table->metrics_table, sizeof(SmuMetrics_t));
+
+	return 0;
+}
+
+static int sienna_cichlid_get_metrics_table(struct smu_context *smu,
+					    SmuMetrics_t *metrics_table,
+					    bool bypass_cache)
+{
+	int ret = 0;
+
+	mutex_lock(&smu->metrics_lock);
+	ret = sienna_cichlid_get_metrics_table_locked(smu,
+						      metrics_table,
+						      bypass_cache);
+	mutex_unlock(&smu->metrics_lock);
+
+	return ret;
+}
+
+static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
+					       MetricsMember_t member,
+					       uint32_t *value)
+{
+	struct smu_table_context *smu_table= &smu->smu_table;
+	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
+	int ret = 0;
+
+	mutex_lock(&smu->metrics_lock);
+
+	ret = sienna_cichlid_get_metrics_table_locked(smu,
+						      NULL,
+						      false);
+	if (ret) {
+		mutex_unlock(&smu->metrics_lock);
+		return ret;
+	}
+
 	switch (member) {
 	case METRICS_CURR_GFXCLK:
 		*value = metrics->CurrClock[PPCLK_GFXCLK];
@@ -2684,23 +2721,11 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 	SmuMetrics_t metrics;
 	int ret = 0;
 
-	mutex_lock(&smu->metrics_lock);
-
-	ret = smu_cmn_update_table(smu,
-				   SMU_TABLE_SMU_METRICS,
-				   0,
-				   smu_table->metrics_table,
-				   false);
-	if (ret) {
-		dev_info(smu->adev->dev, "Failed to export SMU metrics table!\n");
-		mutex_unlock(&smu->metrics_lock);
+	ret = sienna_cichlid_get_metrics_table(smu,
+					       &metrics,
+					       true);
+	if (ret)
 		return ret;
-	}
-	smu_table->metrics_time = jiffies;
-
-	memcpy(&metrics, smu_table->metrics_table, sizeof(SmuMetrics_t));
-
-	mutex_unlock(&smu->metrics_lock);
 
 	smu_v11_0_init_gpu_metrics_v1_0(gpu_metrics);
 
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
