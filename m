Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECC8C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 09:15:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 064D120809
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 09:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="f42LydUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064D120809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE14D6E8A5;
	Thu, 30 Jul 2020 09:15:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7317E6E8A6
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 09:15:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KC4SZthEHLc/4tLXCVn+IoxGV2IgB9j66TqFznX/jAD6vesTS6JNcuXYEhwgnJ8w6E3V7sm5oYtrmSD5pp7o2WN2kOrIs5qfTcT/e9H1K8rnah81YkTLtuO1OdtjhNcXJeMgtByRfB3Y1oom8Gjo5GpxBNDdj/UV4yTpPwh82NSRQ9496CWRRNKtFBpp+uGEAxNaHr+5y+eqzHL+Wk1JXn8DUyu1Zad25psY4jzl/lA6awHWM/H0ODJI+cnGTuIw9o5HO0HiyZ4zSCLBLAwxGf6NHjhw359/v+flaM0negd0QbV2td3P1mRFWLHYPBa7xuES+pWSNIy476FFTFIZBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJi7aAfXaiFPBIZEei5UYQvyKZ86Oh8QdBZLA3YjGfE=;
 b=N/mCGmmM3k7v1DmZPgIvuvAwSFhSS5Ei7urwYicI4br7Vo4GhM7jsWr6ZS5USj1tdymoPUzIcQe9rV68OfTY9crvKdnegYPz1nB2MtRxwsBcZVuxhPyL3TPQqoda6KlFv3IjokpnLVY/TdPWj5EmKDWlcgt97CBh7Tib9GlgmjezCTt+DDXvQ3iFUdjWIhIpOACCyh8xX66NJ4tr4FPc/M4Axg2MV6o7IFW057elVb1hIINz6BBPhJBnT/kjonDhyzwwUWbGtL5KcWc9yqqjpN0JoNCxyMdES0xMgSwmYazPhhfbx8K6G6CF5qgxxI/ki+b4MLDNp70+oaorT2cgvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJi7aAfXaiFPBIZEei5UYQvyKZ86Oh8QdBZLA3YjGfE=;
 b=f42LydUH/GmWOzrlkbVX0ifBQeUQgWj34491hgwjnNZpn5kq/yAIkgmkWtVChpw63zR7n2F5L0MZz5s9NqQmj9jnzOrKcQGo9HYZcyGKWYScKlFvszMp2KkjFcEHawnxVaA8glERWr2NBeVc7wv+rUriytSep+I7PYN7KM6YFIg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4092.namprd12.prod.outlook.com (2603:10b6:5:214::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16; Thu, 30 Jul 2020 09:15:11 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Thu, 30 Jul 2020
 09:15:11 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/9] drm/amd/powerplay: add control method to bypass metrics
 cache on Arcturus
Date: Thu, 30 Jul 2020 17:14:31 +0800
Message-Id: <20200730091436.4551-4-evan.quan@amd.com>
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
 Transport; Thu, 30 Jul 2020 09:15:10 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3143e938-c794-4681-0301-08d834690fdb
X-MS-TrafficTypeDiagnostic: DM6PR12MB4092:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB409270FB6486ADB58396419AE4710@DM6PR12MB4092.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FpfMIRqcG+MYOoN4v1pxqmAZmG3Q45RNuo9AJCt4Ev3M8h1OdHGo7hhl7irKIO9kNKdtlsUn5GG26BA1nzBfeeTJ3yh+QwkaJfZ3Sx+xtCj3N3bTs6ua+ll679oKLBKGzDE6SSir0wf229uLXhcCAC/WHJU6++GYyRYSiCqgz0KTJtjqFiPtPbrplvgyhQuvXVxoay70xjWdk3vmFufCxRkxdl+ep4Mh6nEVw0lrXcX7/7grt2WPTHmgbbvH0mjM8ZlVWXvF3DaRnlZj5A6eoMSt3gbEk0XjMO7TD0BonSEskkQUtmfRJnUCK/EMwxCq3GHiXHXIl16T/lBHxS2P3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(16526019)(5660300002)(478600001)(4326008)(186003)(26005)(6916009)(44832011)(6666004)(316002)(6486002)(66946007)(66476007)(66556008)(7696005)(86362001)(1076003)(83380400001)(2906002)(8936002)(956004)(2616005)(8676002)(52116002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: HE/NnQDk55zvGl4ZRHZLQKvO74HUoQnIh8hm3At4kHEOk15HGW1TpGxWl1Qj/sGsm1xYdeVALKUfvTALRY8ofGekL7Gg3lrPyiHRHywTrqhLSG9/kjtxyikFzPCjTBBb2rAcwDt2ylqXx0lR7VNBXMJr5Xko+Mc+jWcubFYiQ8kSjptWTV8EYgdBxcd4NTznhemGKR1BS9Ex4srfl8UhTJTOjHzW/41Fn/Zgw80foAUKDxdPYWZXOdRJIxXL56n8n3X9IibCAmZRpb+CdHACrjjlh6iJ9onZ/BDGfaW/TFvVgsxsqoW6W8PXGA9bUm6z2mSwzZojkT//Yu3EoA182qnuchGaxpT7XTohOQi1eDRbDccUS5EthiWAlatzCXiG0cWs8gGQo4e9H5fkYrhSJgPxh8ulVfzCXq8gf3ro7HSnDMH2XpuvUfJyhXnVGTMWAGjpX5JQs4ipfpzV746L9R1ai/aPgrnnC4bIuqCXJM5FqN2SQjLXFZkqc2HFoFXCNkUuW/amKtZZwbSbDhitXFNC5tBm4aJPy8OTGftvSi8gZzOxU66Prd/EQP476+e9c853YwZQmPcMYQRPEllWykKl57PCCgF7U0c4rQnXjYQtyGmE3FNBURaiVTtGLAmy43MWrlmG1QiKvnh9aeMfSA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3143e938-c794-4681-0301-08d834690fdb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 09:15:11.7535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4qeLbB13nwSvKHja41dURtdiQ8/I6HfjE2q/lziOhKh/bGrUPsk0THJmrLyMWbIw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4092
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

Change-Id: Ie6e9377f5984c3c09737b323c52249f9189bcaf5
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 74 +++++++++++++-------
 1 file changed, 49 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 39bfe0ebfea3..d678534ddc69 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -541,18 +541,16 @@ static int arcturus_freqs_in_same_level(int32_t frequency1,
 	return (abs(frequency1 - frequency2) <= EPSILON);
 }
 
-static int arcturus_get_smu_metrics_data(struct smu_context *smu,
-					 MetricsMember_t member,
-					 uint32_t *value)
+static int arcturus_get_metrics_table_locked(struct smu_context *smu,
+					     SmuMetrics_t *metrics_table,
+					     bool bypass_cache)
 {
 	struct smu_table_context *smu_table= &smu->smu_table;
-	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
 	int ret = 0;
 
-	mutex_lock(&smu->metrics_lock);
-
-	if (!smu_table->metrics_time ||
-	     time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1))) {
+	if (bypass_cache ||
+	    !smu_table->metrics_time ||
+	    time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1))) {
 		ret = smu_cmn_update_table(smu,
 				       SMU_TABLE_SMU_METRICS,
 				       0,
@@ -560,12 +558,50 @@ static int arcturus_get_smu_metrics_data(struct smu_context *smu,
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
+static int arcturus_get_metrics_table(struct smu_context *smu,
+				      SmuMetrics_t *metrics_table,
+				      bool bypass_cache)
+{
+	int ret = 0;
+
+	mutex_lock(&smu->metrics_lock);
+	ret = arcturus_get_metrics_table_locked(smu,
+						metrics_table,
+						bypass_cache);
+	mutex_unlock(&smu->metrics_lock);
+
+	return ret;
+}
+
+static int arcturus_get_smu_metrics_data(struct smu_context *smu,
+					 MetricsMember_t member,
+					 uint32_t *value)
+{
+	struct smu_table_context *smu_table= &smu->smu_table;
+	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
+	int ret = 0;
+
+	mutex_lock(&smu->metrics_lock);
+
+	ret = arcturus_get_metrics_table_locked(smu,
+						NULL,
+						false);
+	if (ret) {
+		mutex_unlock(&smu->metrics_lock);
+		return ret;
+	}
+
 	switch (member) {
 	case METRICS_CURR_GFXCLK:
 		*value = metrics->CurrClock[PPCLK_GFXCLK];
@@ -2285,23 +2321,11 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
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
+	ret = arcturus_get_metrics_table(smu,
+					 &metrics,
+					 true);
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
