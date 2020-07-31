Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84210C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:45:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5655B2083E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="c5NoR8m6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5655B2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 172406E991;
	Fri, 31 Jul 2020 02:45:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20E3F6E991
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 02:45:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWKEnQM6/AOs3GPLIIW0IhXww8mmE3SvwQNIiOEgZCPcBUDlM0TQ/y2lIBS4sdE+yyPDVBjXiPN4gya9V5QI3kD8YWhAPscpZTynVbgRoPzL9Fm5A94drYRjXgwLbW3cOlyt5dDhJXrIJztNXtfOhIkcftdAy5IOfP8KvcUC6l1qcvR8cZHLIxe3a5htpuWEpKnBMFwsEodY2pX70yTL2OvUFzjQXlAnfx/kLxxIwFYa/NTe93GqNPNpDNFJDHB/6c+vtSoAcMU5MSaeVEYRgZCwicNSiVrgT25ER5Sgdy5VRuDmis3NBvYMbdeUnjI133wi1I+yGxcS/B/hZRx+IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9X103uXzuJsJn3fEjK8ScAWl6GNE7xnvRMFT3jY7gQ=;
 b=mnesu0NK2Cb2F4XnEBgs/OyXOyy3GtdCBiXd/lfDWAAr24orWdk98/pQyctE2cBugiNeKg+Tqhcz2WuGXLYRHEE8dHQTtygtg3SliA12yec2fpYPjMUDWJiqY81FQYIAaC8QhyEShrDyx/aOu99/qxxuRn8ABhbs/UpZ6u+QfIcHxn0z5aTVih5/6lgKauKas2x1Zoi8cwt7m4sOkh8D/jk46PyoudmTcpsGJ+j0mvBjH0xOEQdWPhtfLPfMJzC2sZ7f6YYphDgYZT8vfRm3kjFUfmOXsfnmbHhbqcPMPsckjGH+WknaosfaMylq10J0clL05RcfywueKc0JiObSMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9X103uXzuJsJn3fEjK8ScAWl6GNE7xnvRMFT3jY7gQ=;
 b=c5NoR8m69ukqO1pVn4+k305u03hGqcmyKQ0G2qYBc9f5Gr2X9eZEewoK5KTkn4qBml1YN7/J11dATLZVnkm/j73+QDheN2nSA+WmhTGUHzvayMznw7TMXM3Y9wU+oNB9jDkLmW4feGaYzh5rPIhx9vRfHHiGe701MSQxgGpV+Xg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16; Fri, 31 Jul 2020 02:45:00 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Fri, 31 Jul 2020
 02:45:00 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/17] drm/amd/powerplay: add control method to bypass metrics
 cache on Renoir
Date: Fri, 31 Jul 2020 10:43:14 +0800
Message-Id: <20200731024316.28324-15-evan.quan@amd.com>
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
 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 02:44:58 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 793a8c2e-cd36-40c0-151a-08d834fbb839
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB443544243181E31526F24963E44E0@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6txYhvyc00w3FeGN/XBdkuzteUwRwoB+sunLy2VCG4bzY7J9EbdXKGsE3hisE/tyTFt1YDRaz+V+SPO0v7AXIkCZL+WjEWgSNflZvvRFLp4OhuRE5Rjvksy6xugoxx2jmuAsfK23QPnq9bGM8ZGvF1u1TNWWE2aYNBu9VG8WKgEXEeViJ1rN2Xyysg4NludAfT4zpbDaZJKzbxhr+lsHJlbTUiOtbVtQKC7ZqBVKzA7dSiQR48Fte6kUV81uPm0K6xVl+RTscUY8yE5mpkHJ+Wc8j6N3RstudZyQUgAVhK8kV4irjLxvCvhBOuqBhMRU+KvJUEWv285kOGU2arKcEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(16526019)(186003)(6666004)(6486002)(36756003)(6916009)(8676002)(44832011)(83380400001)(956004)(26005)(66946007)(1076003)(5660300002)(66556008)(66476007)(4326008)(7696005)(2616005)(86362001)(2906002)(478600001)(8936002)(52116002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 2mTD3sBXpSTC1uY1ddxEM8VS2YJDf4CgO5Qt6O2SaFetLYz27zzidUlGgUyaeHT8Pm9NrJl0VqpKdIRd3dRYOuUkO33ZpirTVNf+5teEgvzOXHzycybzZBA+2fJmpJQU3JCPpTXBuZGujDVvuAvzvmoMHwK7Ez8L3HtgexeGNnWhXAzkjIoie9Fj2IJoiOkfD3DWhSdGqH5YlvdpO+Jrez6/zWpDSKhh7zrD7OeGMn93hJ7T9wPVw0ZbFYenNsAV68gt2zBdEvXOvUPg2lX5RQSiXEs+Zhi5Y96cQOI55HsnomjShiA+HBAWY0JS+/pokH22UI2chvl0qgB6lXyV0iCgT8wWaoNqCpciJhS2PzlKK0bJH9rzKeeORdjGjthbEPupDxpr+biopecg9QjviV8dhs76XXlY+vwArczhczvnZW7be5v8aNXBN4L/z9Bske32br+qg85j24jll1oN3iF8tnTakFft5jAUaf+XzKkj6A2bcJ5qDq786yYHOGZOpicVdvhhlDV1pOzeqXToFWy1xBv3y3sqkJjUIIxg4Y2zlWi8gX+Iq1PJ0UiEVgZv4BZDNUpJmYl91XAlowmcATPsZNLbLvE6+Ms1NN0GKhF64xsWiMVRmF2b9HeWv58FsL63lsF7CsINm1xOrZTsLQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 793a8c2e-cd36-40c0-151a-08d834fbb839
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 02:45:00.7458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0g0nIfI8Z+erp9aogkmLSSrRQQ39v0UQigMUB5D86QExixswtxFD4poP+mZxc9S
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

Change-Id: I780aba0be35a35bd9c9727118b33625e7cc9bf1f
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 61e8700a7bdb..4c1a506c3c17 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -129,13 +129,17 @@ static struct cmn2asic_mapping renoir_workload_map[PP_SMC_POWER_PROFILE_COUNT] =
 };
 
 static int renoir_get_metrics_table(struct smu_context *smu,
-				    SmuMetrics_t *metrics_table)
+				    SmuMetrics_t *metrics_table,
+				    bool bypass_cache)
 {
 	struct smu_table_context *smu_table= &smu->smu_table;
 	int ret = 0;
 
 	mutex_lock(&smu->metrics_lock);
-	if (!smu_table->metrics_time || time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(100))) {
+
+	if (bypass_cache ||
+	    !smu_table->metrics_time ||
+	    time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(100))) {
 		ret = smu_cmn_update_table(smu, SMU_TABLE_SMU_METRICS, 0,
 				(void *)smu_table->metrics_table, false);
 		if (ret) {
@@ -146,7 +150,9 @@ static int renoir_get_metrics_table(struct smu_context *smu,
 		smu_table->metrics_time = jiffies;
 	}
 
-	memcpy(metrics_table, smu_table->metrics_table, sizeof(SmuMetrics_t));
+	if (metrics_table)
+		memcpy(metrics_table, smu_table->metrics_table, sizeof(SmuMetrics_t));
+
 	mutex_unlock(&smu->metrics_lock);
 
 	return ret;
@@ -375,7 +381,7 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 
 	memset(&metrics, 0, sizeof(metrics));
 
-	ret = renoir_get_metrics_table(smu, &metrics);
+	ret = renoir_get_metrics_table(smu, &metrics, false);
 	if (ret)
 		return ret;
 
@@ -529,7 +535,7 @@ static int renoir_get_current_clk_freq_by_table(struct smu_context *smu,
 	int ret = 0, clk_id = 0;
 	SmuMetrics_t metrics;
 
-	ret = renoir_get_metrics_table(smu, &metrics);
+	ret = renoir_get_metrics_table(smu, &metrics, false);
 	if (ret)
 		return ret;
 
@@ -612,7 +618,7 @@ static int renoir_get_gpu_temperature(struct smu_context *smu, uint32_t *value)
 	if (!value)
 		return -EINVAL;
 
-	ret = renoir_get_metrics_table(smu, &metrics);
+	ret = renoir_get_metrics_table(smu, &metrics, false);
 	if (ret)
 		return ret;
 
@@ -632,7 +638,7 @@ static int renoir_get_current_activity_percent(struct smu_context *smu,
 	if (!value)
 		return -EINVAL;
 
-	ret = renoir_get_metrics_table(smu, &metrics);
+	ret = renoir_get_metrics_table(smu, &metrics, false);
 	if (ret)
 		return ret;
 
@@ -1018,7 +1024,7 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 	SmuMetrics_t metrics;
 	int ret = 0;
 
-	ret = renoir_get_metrics_table(smu, &metrics);
+	ret = renoir_get_metrics_table(smu, &metrics, true);
 	if (ret)
 		return ret;
 
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
