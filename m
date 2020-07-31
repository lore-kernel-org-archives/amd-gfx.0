Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC08C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:44:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B26212083E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Gq96ZITK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26212083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E7026E99C;
	Fri, 31 Jul 2020 02:44:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 671B76E99C
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 02:44:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWVrlkOVVk5lQweerHYpCpup4O21J56Kq8t9TTufp0TQIrcPk1vr8zgcTmHhdyfWBGsWHqjZ47H/V5rjCPzIYDf7MU9tVgoWS56cDOwUpqqZlx9HYBQl0BMl+e8DqDlgP8nDtBE2EecdY27szpu2xyPT78pVPZI5271SeSd2HZep/AqMqdbo46Dmxnu0d1B9PFkXCexsCLnGnOuBNNGo/Gu1lRcLEFPAwVg/LS+m5+q0XR7mWc5PdIPA+mlILjsj1RxPu2A74f+S1QDAUaUZqZ29dXhY2Mat9MKQkgSICjxmxkl0B11DHaOmFXGjVMurJvVbVVdPOVydnzWXXA5fvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RHq5dA2/1mGS9X+g5FKWm6DdHfJkNkTS+TEitJpvWw=;
 b=afIIhbgY3LfT7jgsdsNJyQ6l15opl6cSq3OhSp+A8K81+Hli1elNUUl2Y5BdODOdY6Tn7W+OO9j6WU29prt3KMSwRN3hXot72pJc95KRqsTssOunFBhYinLlkeZH7zrSoSQDt9BFFdf4V6XJjurbZw4J9WIpmgh18BrW1HY5qzcmIPdoV8DRNzvq1tHrzYxesxhLVdk7aYFzq1E+8g5pO2dzDWEZ5ltpi7VD+PFN53PFyTm2ykqqFSwMsI9rjpz20TsIqLbFGH0ka5yKlHGYl2OulF8MXCLu18RWGt84mR0MOMQ7fdMFoAF7/lgVmESgLMB0cYvwWFgrrP7faLaarw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RHq5dA2/1mGS9X+g5FKWm6DdHfJkNkTS+TEitJpvWw=;
 b=Gq96ZITKghabSiEcw5k/6T+uaXdQFUG2J2nZkoBvsflOrQyrn8ZO9PVni3wFmOP4uJ8aeG+ltawr7mygSLrpEOzn9iJasmJnbVvd/xOCFU+cctvL4NqA6PzSxwM3URpUrgAxxb5wfAI1OOeCnEa+zEFqAOugJ5QCx+4XVURd98U=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16; Fri, 31 Jul 2020 02:44:32 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Fri, 31 Jul 2020
 02:44:32 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/17] drm/amd/powerplay: add control method to bypass metrics
 cache on Navi10
Date: Fri, 31 Jul 2020 10:43:12 +0800
Message-Id: <20200731024316.28324-13-evan.quan@amd.com>
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
 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 02:44:30 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ceb2e685-f114-45c8-4172-08d834fba736
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44352836511262CCD0E5B365E44E0@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZjMiFvvWcIR+bi3tmPlG2nqyqpptlZpOEQQne69b+iDIKeEF0yQZmsQyJwaDqe7z2Wo8py5pithVI3DI2f2B8bEV/LicIifOamXX9EU0a29AFIqO6RCZIThG3PewN663DEM/hKuLBB8e4+gOrwI6ZhJJE8fe+3+jIh8p3nloeMS5kq1ynkJyl81AS7jX1Wh4DGwJGE+vMphXXJPdSvR6UTVXBrAwNmcyqjp6aVOfEZiIR6df+f24w3BS2brN8STSuaGv7ef+pZS9KrbDDea6XzrPZdcCt958Azc/dgJKAlfCj4dwEghvOB0123C6ZTGE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(16526019)(186003)(6666004)(6486002)(36756003)(6916009)(8676002)(44832011)(83380400001)(956004)(26005)(66946007)(1076003)(5660300002)(66556008)(66476007)(4326008)(7696005)(2616005)(86362001)(2906002)(478600001)(8936002)(52116002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: oXcVAmHLC+RpUcMNgaZsU2xJgEznVlBTWQtoGqRkKJ0fmQx6s0mqGdMnsOsKDH+v0E13xquibKiJzlNETybD7H2dOHLJJS/9PgE3a1vJAhchYjdoRv5iW7RuFCnjFNJUl8YrEA23Lj3ilm7nvRuNfOYxfO3wk3hGU4Bt+o2+9uXhlvk6WrSKFVXfTXrZQw8stIiVvUMWujqsMA0autMI609ZacPDDw+kAm/isk8NbTXAXnmq82dpryHMTKgR5o8vL50wTJ/v47/qVY9FfpIQEuH/l83yk4wl5mjM/wy0HC1yxxi5kV0xXkkCEi1NtKzx5aJFhbG3oHl/6rgHI1YebokfVBM8pwUxa8Nkj2mppuqv2Pg6fwoyku0GI5wFAhcq+J7uGrZ6O9MGzCZyqGU77kV1x4plY8XbWfJXiLQsBIihlRGA0SjpPSYW+w2OOpjZsF5B2fQf3QtBo2xjrzfNeDpNMrhpU0arXcHTMGA+vD8RNdewbLbBmk3+g1Bmoi0AJvQ3WDMswcJ2yGl879zWtyCl1kKVhMnRNN4p1NRt8vDw1lbm/gUydAOFX13gIv95yzyusPH1vYkG/U8yzmgvd5MvG6k35KfaM6CxkDz9ymb2zZR4pjDUcERDW3XuYeDQz8EOfs1S0H0z2qcnV7XsKw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb2e685-f114-45c8-4172-08d834fba736
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 02:44:32.1050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NkKtXQalg9UhIsawCnikTjc8vQu+OUHFMaDL2BZsY9tf6S6OE3RECT+EpBOYqmaA
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

Change-Id: I281b4de9262b98f0c52131feb39ba9e101b548b7
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 60 ++++++++++++++--------
 1 file changed, 38 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index a4ab1ace38fe..ee8d938ea3bd 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -504,22 +504,16 @@ static int navi10_tables_init(struct smu_context *smu)
 	return -ENOMEM;
 }
 
-static int navi10_get_smu_metrics_data(struct smu_context *smu,
-				       MetricsMember_t member,
-				       uint32_t *value)
+static int navi10_get_metrics_table_locked(struct smu_context *smu,
+					   SmuMetrics_t *metrics_table,
+					   bool bypass_cache)
 {
 	struct smu_table_context *smu_table= &smu->smu_table;
-	/*
-	 * This works for NV12 also. As although NV12 uses a different
-	 * SmuMetrics structure from other NV1X ASICs, they share the
-	 * same offsets for the heading parts(those members used here).
-	 */
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
@@ -527,12 +521,40 @@ static int navi10_get_smu_metrics_data(struct smu_context *smu,
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
+static int navi10_get_smu_metrics_data(struct smu_context *smu,
+				       MetricsMember_t member,
+				       uint32_t *value)
+{
+	struct smu_table_context *smu_table= &smu->smu_table;
+	/*
+	 * This works for NV12 also. As although NV12 uses a different
+	 * SmuMetrics structure from other NV1X ASICs, they share the
+	 * same offsets for the heading parts(those members used here).
+	 */
+	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
+	int ret = 0;
+
+	mutex_lock(&smu->metrics_lock);
+
+	ret = navi10_get_metrics_table_locked(smu,
+					      NULL,
+					      false);
+	if (ret) {
+		mutex_unlock(&smu->metrics_lock);
+		return ret;
+	}
+
 	switch (member) {
 	case METRICS_CURR_GFXCLK:
 		*value = metrics->CurrClock[PPCLK_GFXCLK];
@@ -2526,19 +2548,13 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 
 	mutex_lock(&smu->metrics_lock);
 
-	ret = smu_cmn_update_table(smu,
-				   SMU_TABLE_SMU_METRICS,
-				   0,
-				   smu_table->metrics_table,
-				   false);
+	ret = navi10_get_metrics_table_locked(smu,
+					      &metrics,
+					      true);
 	if (ret) {
-		dev_info(smu->adev->dev, "Failed to export SMU metrics table!\n");
 		mutex_unlock(&smu->metrics_lock);
 		return ret;
 	}
-	smu_table->metrics_time = jiffies;
-
-	memcpy(&metrics, smu_table->metrics_table, sizeof(SmuMetrics_t));
 
 	if (adev->asic_type == CHIP_NAVI12)
 		memcpy(&nv12_metrics, smu_table->metrics_table, sizeof(SmuMetrics_NV12_t));
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
