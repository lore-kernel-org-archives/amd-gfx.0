Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DBAC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B5E22083E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Sq0uRQZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5E22083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 211C56E99D;
	Fri, 31 Jul 2020 02:44:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C99226E99E
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 02:44:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhZfa7dAIKPmlDGoIozzkepBpEhbdfAKZsKD9MpD7rUDGvHZ/twzBaf54opYrm3Z3uetKq9MKTmJWTB14rfUIaSJoBZum/RFECbq88W8Bu1EAIE4vI0tIt7TEFZ9UIt3A9TtMx7iO2/Iz3lMUO/jImmCuR29oPCuEU3RLFwlqfCSchEzSf7Ipn7kgavx8mb7fW1132/m8qFJsWaZ1z9iF3vmriME6xLWm1NZHjBbEg1xQ4yRH17ewzyTch+D6Gm0wDMnGfdhiCkMSXOMm7aYRWVHNuZuaGw6Wystt6mAcJzshmrcf4QiqEnb5z1CHTeTdrSpKdgsdvYfypafxP+UkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJi7aAfXaiFPBIZEei5UYQvyKZ86Oh8QdBZLA3YjGfE=;
 b=REimJwbDZ5oGsmpd1y61C2oxTc/jHr5+tI4Ktm1nUwPlWd5Djc5paPTk1bceDc0FybZhlO6aR/LZjEKkSGRZh8Q5SlwaFlqn3frCA7VR+AcmpIH12Cu0LTy+2K9i8tjavaLMAMFd4YwEsoEUJc6nHpZG06J10yffUBP9XkjXVHaERXQspRi7m73844Tt0RZcnKeySBhF1+n9q8zIC3hM/DPE2T7u1oRkhaAdZjPZIsXGP0SYQuBQVDTavDhyDTl7hCLsPXKmQKZBGnMfvxqFMiEkfo3NALnSuFZzf0KhaPeAc3CPzuiI9O9Nto12M8pv77/oelzdoPuuym98CEiU3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJi7aAfXaiFPBIZEei5UYQvyKZ86Oh8QdBZLA3YjGfE=;
 b=Sq0uRQZyZEJemlAO/AqW+nKzuqaCd9bohXyPFOa4SqW6bBLSMwHZM4nab3YDFFzbNJYAzzcWGWgsQ/DLzlzWrNHkuq37gAFKDORDdQhKh1Nm9xN6eJS80aqCAvmY+xOcRB6sf4tBLMrorAZ/+wofbKl/5q7DB++8tZDagKq+TXc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16; Fri, 31 Jul 2020 02:44:26 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Fri, 31 Jul 2020
 02:44:26 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/17] drm/amd/powerplay: add control method to bypass metrics
 cache on Arcturus
Date: Fri, 31 Jul 2020 10:43:11 +0800
Message-Id: <20200731024316.28324-12-evan.quan@amd.com>
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
 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 02:44:24 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2d260422-2bb9-460b-e03c-08d834fba3de
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44356525DA2C2DE0C71BEA3FE44E0@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rQMrK3FRhAv1iFIeqYVU8Ai9lFPP1koJxwyhP1WjPWVNArW/5v0XJ759jUUfdd4TJdnDWiXj9wuHbJPI6qM5bwvOw+rpwtDq/TMI/XP7eRS/e2UQVwqp8qJa+EJJIVLVH7z6RqosmGuRbvNljtA/Gtjvrk1CMY/tFRk8cRkV16W8sWjJ1KnOf4S1STagD4R5yKBLf2XUPFi7J+XMELUTeWUPX/MGXq345Sz71LZtROTJT0ZAqP3DVg1uPVrVMIR3p0LbFwyLVbCYBBbXjyk4fzql0a/i4fvOWymepe0QTInWVHCfEwIaZJ659k7Yj/XhnBKQ80FjG9Mw4cTGOvEYsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(16526019)(186003)(6666004)(6486002)(36756003)(6916009)(8676002)(44832011)(83380400001)(956004)(26005)(66946007)(1076003)(5660300002)(66556008)(66476007)(4326008)(7696005)(2616005)(86362001)(2906002)(478600001)(8936002)(52116002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ttZ/g+d1vMnYxS7+q7NFX4OsYRsNtYwxSstuRGsPVhww014JF9m/mP7rdlJQbLohPNAtGX2BieD+Im0JQ16jPXzTldcy+Eto0zZJjzaIX6i/j9q1rPU06pAG1Bl1b3mpMR7iS+siay2NIgOktoNRnlWQM1rIorSTDaofh7U1PiZEI/ectU7SvJGblAxrH27mvgExDdoDn9HtBaeHas3newXCKiX0dVEOsqc9Kope8jZ4hV/iIAqrF2l93npJudADRMu77NUDrC3UAptdcyaLWYXKUtrxmEH2Gz+iluSfP6Qg6d42K0PW8WQ5Y0fOTJ3uYpPuzBrwVBvX9RQUkmSCPrQnL2VibckEJA3r5jehJurviGtRu1Ri+B3mekhrRP0kxxKFNHpTzikdV2VSFP+arJYgxlJx56dwcbIgwGFqo/j69fQj4JXVtB/jO2GaO1+J4s4xW7/W45nh6rX7ZshBANIchf6zSXMytGwGdIl7iLf43SPb3DaD41eLDcqImiKWjeVif2Gsm/Pjfef5oreBgfbgpwuXwyl13HC+KPYLSC6EcOYpDD228VJ+Va/SbHjGX10n25ArszW0Pxg4+utblOf5bDfaY+pXQoJBfYBC4X8b7Vum9i+zL5uw6cqGfPvehOfcuxLXiyqWLLHA5x+nUQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d260422-2bb9-460b-e03c-08d834fba3de
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 02:44:26.5702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1/3yQdY5NToX4VGzBu4o5zMD08hqiN8c0u3DpnJ7wuVfphze2pGgmVKQcK0C1jB
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
