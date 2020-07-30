Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A22C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 09:15:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5741620656
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 09:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Gc7tIcRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5741620656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 245166E8A6;
	Thu, 30 Jul 2020 09:15:17 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750080.outbound.protection.outlook.com [40.107.75.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12A8E6E8A6
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 09:15:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDQEATWNzwjt/3iItItKloVoNaEVnEmsGB95GVOaZjtdro5h3cHLJLQ5qbcQSoX9XDaV7b3gRUpxCMZ6unuac1Ay5E/kL1gVRbhEKgyL/NA2EKTcboKR+zly210un6+qYqIUesyacrJNheqJqLFw/u1Z3o61p4G3GdQgNojX8p251XQcu950ZIjSU/Z2eR3M+HR+VSE5VRWLFMafKRuLHh1F59DmfUuWmO4sJbtrbJ/k9Wd7I2BgXioWHfiAYDIhs9LsZdAIT0TXINOAwt/lwzaI++oC9CHlhYlBt2cZtquI+t1e5TuuEitrHT4wV/H54xfkIkXHZDXLAuPgHroMew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RHq5dA2/1mGS9X+g5FKWm6DdHfJkNkTS+TEitJpvWw=;
 b=fEiUq7eLiseD6agdS+vZb7Jb7CNH6snwlzn6loqa2tMk36+McSI0GdFf8ZFVk+dJ7OmL1CFto4RXYbovAx7r5hkcbpyW5+J1Xg775XxZjK19GMII1U62bwuR50RF1f5NXQYyAye3IQcEp3T82mIFHSIoAzWL/1qFkcfLe/ueCp3Yd4XcaJf03xyjZYXD0cju6EL5wJc09udww8ue4tsGciYbs2G3nbHf1ipsmtfb8aCez0TL8iz+Uk1uCDdLfKnACQXMdEKKz2Q4RpAk3+J+crA2jcA5hrQti9Hj4B4aV9K0yykMjNsGXwRT01Rp96Gty9rBzlCm7/4X6go924QQrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RHq5dA2/1mGS9X+g5FKWm6DdHfJkNkTS+TEitJpvWw=;
 b=Gc7tIcRhn+Icqq0zCT3L/qfNtUpH0vny/7TOKbMGyE1NHiHHWj/A4ykx8cP5CkJRu6PDQUmQ5lehcxxQFg5oH0mTbGrLQCZJAaSYkqsEQS1O2n8W2uCK3kfxk59XxCLdn1LedIKXio7tmSzjcaFz1qzeCIMDwJJKrp5Y/hGiGc0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0027.namprd12.prod.outlook.com (2603:10b6:4:59::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.24; Thu, 30 Jul 2020 09:15:14 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Thu, 30 Jul 2020
 09:15:14 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/9] drm/amd/powerplay: add control method to bypass metrics
 cache on Navi10
Date: Thu, 30 Jul 2020 17:14:32 +0800
Message-Id: <20200730091436.4551-5-evan.quan@amd.com>
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
 Transport; Thu, 30 Jul 2020 09:15:13 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 719f0a39-665f-49fb-d9d2-08d8346911a9
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0027:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00277CF466CC13FE7028CAC0E4710@DM5PR1201MB0027.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nCZsD5xmUBGJg9gUUhRZ0aYfNfTLh08jxk0L40dREWAkoev4tmykvxeJMVlAdaMak1UGsSKvsWc6VrUBwDHhHQJPy59ziS4rVcD8JiFIQ4KVqugo86Vx8lVpqTjQ+/+QOso930IQ9ZcZ5leSq3BdppX3qRuJ/RRoMGpBh8k6fUmua6RXxZyJQtWy9RqtNFXxqicfqBOFXe35zO6WA9VMeYAllTNTCAGpjVOiF2/GxRJb2fhuaKz2GwpOtBOsBo9UlT/+MohnM3ywtJW5frWYu5Z9cScD826aV8rnkuj7YqnE0Z0eEDTD7Kn2JfCmk0vT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(6486002)(4326008)(2906002)(66556008)(5660300002)(66946007)(6666004)(66476007)(1076003)(83380400001)(26005)(2616005)(956004)(36756003)(44832011)(86362001)(8936002)(186003)(16526019)(6916009)(478600001)(52116002)(7696005)(316002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: bpDeG+hal3wvC5fVBYRsaujlyrfCwJqp6NbAKDItlzqr45VqmJofKeg3YnJYHIHoGoXcQ6qATVVeUZD/paIPArNJC8JUIcpeMDh7vNsMEhS/7he7qJOoNaJg+DV+yMXQ+pXQDXuIF+qD2hdyqSXWHISrDMQu92F9Xr91z4pQ5F+m7A5eVicjxXZSxnSzABffdpwr7DR3T34nRzQL4xInN8M917LHNKFxVuZUHmFHM8o6+L/g44k+G4CCTfT2NR18nl+CSe7XYaxQ1LeqJ2syxoVwE3pzJncOC5RFe6NcM2YufecTWQvd6In7vm9gWfSoElo5VAwZJdZ0cTQmrIImViRp5rlhd7Z4dIImxo3UjmWuCyBofjyo79JOJWyw82risaSzDbGFx+xpV5bQVtWrPjZXOf0KePq4DOcYt3szpZnWHOfgk/oORrmDz/gcGGdTkKR9vc9ImuzmaLiPOB5682EQgEgt5rObYA8+BCS+WiJ5ZaIeNAY2/+uSc8KR66Q2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719f0a39-665f-49fb-d9d2-08d8346911a9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 09:15:14.7758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P8KxtUrl+27yj7BFNa7diJuj2AC52HvMpeLYlmrggQdUZXA0lq/Eziiu96ppArME
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
