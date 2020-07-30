Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259B0C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 09:15:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED72220656
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 09:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="O6NTbnqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED72220656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B66A46E8A9;
	Thu, 30 Jul 2020 09:15:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 562896E8A9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 09:15:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGKcZY9Co86SLqP87PEtHpFhclRJ8Ov7zI4mtgYTpSMrQkUptyB5oZ6iYrrmt5NpOHSMOyOffDd9HiURAHoCwlpt9Gkjn+OIheXb9qttChPBdh3ZOhy2gkLfDAPGi1111xXa5H1pRK3E33pcD/aLE5hsYt9C/Wqr8+dMv+PoIXMQL6OhLfCelcSQ/f6DsNeKQ2lc7v/mP4f/lQuMAoj0OEh9+rFIrq3XHc8L+i1CMoog4i9QItNdh6hkHTbGdv7Bblj8V2Z179oMHlt4/r/jiGuLajB1z+2ERZUC+cdxDgj05iCCb9MQEFPyJPorSJiqkwwu5y3sr0ljGIu8X8dftA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CydBz5qXbRH17j6T3PmJ98KqYf+CSw/513L98Gr2Z38=;
 b=lEP0OQBTav1D+glb2oYnYIgjvHZjg6PbnQFu0avJXGPCTsnU5h0Yo3S4PBQIJOeT8Y4XqccuxGb6RZ6njxfdoiWrO5vB+vXB901XOaMayWNOmPRs+XqQ9Y0eVz9rCKOGx5D4Z8iJsE+1h5t04dPXfWKgTNEKciOBiMUsAeCpplZxSKSDrkHoH/zck56fpnlkgfWee3B3FxvD3mjYUW9vYsBZ3scdXASNB1O4rYAbUh1aC5rfG0+o6qijTxx7DM4xD/nIhPjkmGVM5iXjA9WXspxPoER1IsdI9q8qComHTJ/YCglLLCmXTW+5gXggqYM3O0loV1Mzv523z0aWTfNo1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CydBz5qXbRH17j6T3PmJ98KqYf+CSw/513L98Gr2Z38=;
 b=O6NTbnqoDiUXr2l0c5oHDpq0Cyt82bjHMIcAYD34rG80nIjHyymw30tp+8bL+0nKBUSgUY8V/ArpP2shEzNTyFgngo1f4iSdPHj5qCf6JFSnBRbx+Umk2R5Qyef+KWTgqTKjG4kMRHtRwIRJWGivemseiurTPJbMKim7O/syF+4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4092.namprd12.prod.outlook.com (2603:10b6:5:214::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16; Thu, 30 Jul 2020 09:15:23 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Thu, 30 Jul 2020
 09:15:23 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/9] drm/amd/powerplay: add control method to bypass metrics
 cache on Renoir
Date: Thu, 30 Jul 2020 17:14:34 +0800
Message-Id: <20200730091436.4551-7-evan.quan@amd.com>
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
 Transport; Thu, 30 Jul 2020 09:15:21 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a5a78627-ff38-49ff-091e-08d8346916c2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4092:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4092DDB411B52AD3024B3C88E4710@DM6PR12MB4092.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vb40/WbAq6vkJPayq1UE8AYNZPKsdYGc+I6XE+3rwvymsRnQdJtjyGM+b1rKRtF4fk2zXmGdeMy+VzrknneY9TMi6k8ytwjObMqfgL5NP7EtrdavvJP+thXpC1tz9FXTQYnCQjlhSHinOmsi+kAwlx1s8e5QkMtRzTYxOBiG79x+4cG3jnzJgK+KRJeaswkjgEuT3Uhuuq1yw/LRRNQSxmfGPeVsZutJLt8MaHPg3bkA/XfDHH7IjXQWmTRarn27phekUU+z9ocohO7mcLTLkGuErmoSGVwYyZf+ZCe23GOzxPvw81GpIMrdHaA28RRrfJz7E+w4Ta0Wo1aPnNmnvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(16526019)(5660300002)(478600001)(4326008)(186003)(26005)(6916009)(44832011)(6666004)(316002)(6486002)(66946007)(66476007)(66556008)(7696005)(86362001)(1076003)(83380400001)(2906002)(8936002)(956004)(2616005)(8676002)(52116002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: GRRE09g0fRParFGbJAXUb7QLs+MIRMhsANp2MDavdGyZNYsU3j8dtiWBuHOnCjrTknhBDpRCKxVTMus4xl4W70SA99tWE8LCBa7BXfRx4lIaOTaBP0Hom1Wdih0WX5YCBU4rUfWjVrOd9lL0G/HXt4H/Omw4j7dBBnbva31eXWkqOBYuUOv54o+lvR8aL8A4ar5pujuUSRJbpVYmDQogPjaFfgLZf0FQNORtbFWDItrZGpR2BFK7/+5+Hfn1YGZpttVJpqBX3XNiqCCIyByNoSnjaqirCufnQACJiQF8jj6uw2QDxxcRFX4qJzmMO3ahrEQUyhiv6ZhHEHompGrtKuuSVkyYhnr1S5rvzwGmYpyUZ0Gyf1U5rxZcU66Wamkv8A08cR9iAE52sxdqB1hYS5/D4IVgNk7o8zCt+8hXKzfZQYZMdqGMF4MQ46+jZIGufnvd6cS8ep6lPL1qESsL9VOCPArH7qQLcyDoVuGcessS/IFFJ1GATBw6xsw7XbsSyPheqDrd6glfVWWCD6CLmkFGHjKvPugz8Bg1Tf3ZV9BNMRuDPTHnfBVsIiWyel2emSnSpWSUf8Xxgsau3XWvHyYaJddPQAWBzX3fUkqJT0PEF9GFhyT5NlR9DBKWCcfczuo0TpXKrRvIB/ErfOzV4A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a78627-ff38-49ff-091e-08d8346916c2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 09:15:23.3379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AjogAI8tln39pucgL2oQoX1m51nT+pwqvLgfHuvpW2l3rmxi0IpGPMROADJ/LccG
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

Change-Id: I780aba0be35a35bd9c9727118b33625e7cc9bf1f
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 8d73781775bc..ecb90da88b81 100644
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
