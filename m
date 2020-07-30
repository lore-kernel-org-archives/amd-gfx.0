Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884DBC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 09:15:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F1BE20656
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 09:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4Vr/j35l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1BE20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2701D6E15E;
	Thu, 30 Jul 2020 09:15:20 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750042.outbound.protection.outlook.com [40.107.75.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E754A6E8A8
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 09:15:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKMnXyckra8RwLzx3e9myDEriQMxbFBcGht2uFEOTqhOJnQpJjC9Nrscq+S8ck/aDE5k/rY3Rsmy/YLvS8fZj2c3TIWdoGF0kRxC1yf2kFJ7yqgb36Zgt2bL93RdNxTFjzYQVHC2E37007qY3YOJd7DrokNgO8aNiN9UKpt3x3tXW24dWdbWMn832X+2DBNCLCY8hzkCIHyr+wEqu0GPBwxOwIBsBW6br7P8d6cwYMn1rECCW948OgJZDh0hUjTXBU3Y2MjswX3zqUk301Ob3xqDBOeZrQYMsDfMpj4VMko7iAXl6nPxaOc1SSb+snu+oWml+b+QakOx+Ny8H5SgNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kQELiPsdcSAYJf7g4fA7g+36jT/9dG00vJ13GqK2Ag=;
 b=XSFEdhjWeYHGLJiY/1tB0XGqDohw9srCBeikmtxN30zsb2j3elH5otOXv9EmVsX/Y/ibtl6dZ9JRc1k+U8GWhqOwgYGBLZf6R2aoroYd27/zrBWNMFP1cTF+VAE+5cpEm6zPs28Pl4GHSstR4nCb+wNc7B4MqpfAYhRjZkRe8TJaBqFNdpXxba/BP8knm171PaIXmk1OQ2QV27aB/p3/4DEMQPZSnZKblIPMuS1TNUdbFUWfjY+JDxIP9I11UnJoNV/ijJttH21LHOAStTI+YnUwZIlUDRfH0gLt0JUs7Am2JjeLzfe6hQvjZ+uEajpPboHLgVDhcOYV/H1h/UNWjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kQELiPsdcSAYJf7g4fA7g+36jT/9dG00vJ13GqK2Ag=;
 b=4Vr/j35l0tayPJjLvhwt7Oi7VMpAmbWAsuhoKdZh0dUMdVj6avLP7+YWfOpYbgrZfhkh97gAGG/gWFX5yPTb/NDDfhlT/rka5aAOQeNNBwVGdRbln+6w8eOlbxHsc9CThCfnPAQhtPlT5rqPSZcctr9SDz9X9BqcFu3huoRZSFE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0027.namprd12.prod.outlook.com (2603:10b6:4:59::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.24; Thu, 30 Jul 2020 09:15:17 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Thu, 30 Jul 2020
 09:15:17 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/9] drm/amd/powerplay: add control method to bypass metrics
 cache on Sienna Cichlid
Date: Thu, 30 Jul 2020 17:14:33 +0800
Message-Id: <20200730091436.4551-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730091436.4551-1-evan.quan@amd.com>
References: <20200730091436.4551-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::16) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK0PR01CA0052.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Thu, 30 Jul 2020 09:15:16 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ab8398f-082f-45e9-f7ab-08d834691361
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0027:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB002706D675A42642E5DDDC95E4710@DM5PR1201MB0027.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: shRa/+lqIE7UC7oaARERyr0Qj0LeAz0RGgwMXbPjg+HMoKsvbt0Z4oksu5oRvJlmcWqOwOjeDOknDl4eftvn9VzRml+BiFPSRGEavulIt8p9RxCfjkxAudQNGxRnYjqZTuxwqJvedztVX9yuoILkXmIILUyDX32g/STPO3LO6BTh4wA+Bglez2vQ9DvQXvn5+2x5QclTuMfDAhNXLgOljAemuiuRq0dGeV8NQPyfS8Irujmwm54imPlm6DVmcBEU4ld1ho478JhkfE0W9DFr83uUJnjrTQ9FVVZl6Hg12MvNoodepj6385RuyJDUTorS6YhU2r6H8IRFdJ+zw6gm6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(6486002)(4326008)(2906002)(66556008)(5660300002)(66946007)(6666004)(66476007)(1076003)(83380400001)(26005)(2616005)(956004)(36756003)(44832011)(86362001)(8936002)(186003)(16526019)(6916009)(478600001)(52116002)(7696005)(316002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: VNkInl97sbYPmwv/9RahAbyD+Mc+DoB23GXXpXZHFOFp5xye27OQwmKbRl4YeBqzhj1Betjp93wUkjHm3mfMiYdEK2bA4BLaReZbZYVBE9JmJs79e/RtdRtg+hGzGCSxZp0L6kdaj+6pVA/8ErwAeNOL3VVXFoXwgolz3nCoPNshGL42wz0ols1BrJuqGfZhScXyEj/aS4NlJ6la7TZcsKLX5DdWKoJTThy7/c+2fRXHmPao6QFqo+sk3wRP9bSAqI2xDz6jfMSYaaTg1fydC5/WpOzkEgm8yb8ZRKOlSZcgAVTGz2ZwTBdtxY6vwrhiTzg+mnHjn941NWUpBTxGCXoSLCICkleF/gXMIw4szYCuYev0jriA1XC77i76VSKOeBPB26n17A6yYX7Q1AeqgQcNE9hXDkeD2dOM4fZ9NBpKRGZDZHQX9wM9i7iAgKT69OWWuK+kIWSFkqMqDbMQxGcFVzjsB2ppclDXs/lYmEAig4JuPmNhi3dnPCjwgs+j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab8398f-082f-45e9-f7ab-08d834691361
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 09:15:17.6741 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjHrTXnZu37dyGGqjEgxBMJ6zFCKLJxh1rZfSTqrEOix2dPe4xQltSlBVrWvwQZg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0027
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
