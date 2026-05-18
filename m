Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E123ECD4F54
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 09:41:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19D4910E776;
	Mon, 18 May 2026 09:41:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KggwTH80";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 871CE10E770
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 09:41:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5pMKbaF2St9HHQwOiYwPOEJdxuyZ3pAKN4HD/3YXqJ2F0nyeUOBbxeIfAfZM0Ontc6k1fFjWuzVAgnrOB+Hwjsxv/l/zYja0QPM6rspbIqiX6/6YweuOcjJO8TgP5ZLrsNoE4NW8XPR7n/igvzJbeRoX8dhr8Z53wALUivsip38X0F9LVYqlKINtFuZSBVwikcMkJPkr5L5KUzaACrlJeAyJ/ZvXhcmwxyYlaIRp2/dVTl4odVOQ0VqgerwlmBNJJJo2Sr52P4/p2yzqtrl9zJJ/C8NSU/9F1XVYxJ0TZBd8WJnpoJ3a86kOFA60cVQbxibXaVjaHDVys/2rxUudQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9yONWLM5f+GzPWrPu/X85C3WyJ1HgcVSCq0g72k/+E=;
 b=cDFE5qs14StNHs4KGyGysnreikNJWofSS6SKDxAwcAvEbeBvr2tkb1fzQaEDoAMwc+TfhjIjdM44mIso6C1z8NzE4YGQ9C+iH/rpEDFrRphN+Gq+GAa8QnNTuEgF7SFWq4RloiZA+mErNceZYNrq8Z0WYvLWE8hL73Ga+pXXmRoIoHtrvz+JEBJb7/ZZMo+tYdaQdWqycMhT6KhJa5B6wm36uBXoz9fuJrSq0iTrbVXiDFNbY0y8AWiT0lwMNg2GyTBMQOdtIlfDg69HENEwH1bXmCbD1Yaww2LN+IB56ObCZpMFwJVPt9V5S8tCom82Qe/we0pZqz4fD2GxIyzP4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9yONWLM5f+GzPWrPu/X85C3WyJ1HgcVSCq0g72k/+E=;
 b=KggwTH80qWEwgAQsdI0Njz/ltQ4Sp8llAnpMDfE6ZwE3HcGklyrB2gSuS8o7N8WqxYEr9ICo8Y6bdFhujdRw1+Gd4X6jKhKqRB6VwmC5rKuJx/CVyH8xmrkMH/XGgBUJcpwuI+3Tv92VW27lY+4xsd9eiHGllBMsh0CZXUsZ8Hg=
Received: from BLAP220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::12)
 by DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 09:41:48 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::16) by BLAP220CA0007.outlook.office365.com
 (2603:10b6:208:32c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 09:41:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 09:41:48 +0000
Received: from stanley-test.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 04:41:45 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <YiPeng.Chai@amd.com>,
 <Candice.Li@amd.com>, Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH 3/5] drm/amd/ras: cap pending_ecc_list size
Date: Mon, 18 May 2026 17:40:19 +0800
Message-ID: <20260518094021.280968-3-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518094021.280968-1-Stanley.Yang@amd.com>
References: <20260518094021.280968-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|DS7PR12MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 93174c77-955c-4c70-a7f7-08deb4c1ae66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|11063799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: Yq2DXjaQFA0NXLIJ5Q+FkE5sbGqBZk8LrWCgg+jNBaCSRaorKCi1f8cifGqZIaHO16qsM6tf9jESuuCbJfjNwIb9SADLwmuQBNT9rdW8jq7YqBH4n6KaPpEmHLn7tG43n3jAVCG/2yi3jTF0AAQmayNpekvnAM70IuR1UpI9fH7nutZbRfsdtkFcE+bMOFqSGfkZkV37C4zwiQWKv6OMhhpFgXiM3p0ObbnaY/F6yIediaiteNWbboD6kH59eiDO+5uCBjU4iKbmBfD3IleJhT+1uKRj9ElTbH2o/kZL6IJD8QC1JpJd6mE7adIhQqCfqeYp5EjuKqfswkChiRKPoBvGKOldSuLq/VEhwzzs5AwFFSukHWZQEbcYZ3Wk+ecIwnqr3WlsH1REFiI1wBtvUjkSf+H8BKHFp9584v95RxRnlnCjUuLiWLOMb0XGI2bMuZERd6fhLJhDHX8UYhq4X+/FvvrpfBEvPDTaddiqD+zKpLfj+2RqEv9a5LInub8WR41m7y6vNPhF0VGHEyHfpIl3qh9B2bYglTE7SaOUjfMlsmdr0TdlqAUxmP0kTVP2KMIEw9/rhnkw+wY79muLL7Ar46Hg7WpMco02jsK+YtB/UyJ/3xPYZgcRj6Cnur5o4MmH6vBtqG4OVTJ1cRMzAhXxaNTELa9GHG0U0vMJCW9FgEcES2QABCzFkc4LBlBHapKJ3qf3q1Uxmm5yXdL2LelfbD/sggPS2L6MO1wGqdA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(11063799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3oo9hg7Hucs1jpDBGjvcH58+3FQIREutOMPy8v0BhLHKyvDxQj7q1Gj/GqYtkVygqxnxyJHe2ePsJ11lo72MkQBkKP168PZbgD6BPLhLVTuZdfV+MfhSxZ1B6GsjfgBTkjcQBotzIrqrhyD1Kd1gZ0Sap1fHyAqj7JeKb/M9Belb+iBb0SJtHau4ZEt9R0b7/MZgTMlhvEpFU+XgemUD7l+0D0q2yrtfS6FYnZZoWDioQ0VUp+dckreLUOD8PsswjOdHFGTTm1DwOwiabwJgFZI4L4PBVeVnB+4DgQqKkjJAnKYUZgrym2wdp32qF2wVGNgrffmCao+9k1UkPi/wlzAMxtOVC2W1IJDQ8j7/Ga1wN8jObVeNThz/XmL7G1UJl7nX5BS4rL+dE01GAtb//j0YkcliLo8IjkOwWSKXv0T+jun6L5jJcyODIkecQJLB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 09:41:48.0384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93174c77-955c-4c70-a7f7-08deb4c1ae66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6263
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Drop new entries once pending_ecc_count hits RAS_UMC_PENDING_ECC_MAX
(4096) so an ECC storm or repeated UMC error injection cannot exhaust
kernel memory. Dropped events are counted and reported via a
rate-limited warning.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h |  9 ++++++
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c | 35 +++++++++++++++++++++++
 drivers/gpu/drm/amd/ras/rascore/ras_umc.h | 12 ++++++++
 3 files changed, 56 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
index 8156531a7b63..f34dda7ce87b 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
@@ -46,6 +46,15 @@
 			printk(KERN_WARNING fmt, ##__VA_ARGS__);                           \
 	} while (0)
 
+#define RAS_DEV_WARN_RATELIMITED(device, fmt, ...)                                   \
+	do {                                                                       \
+		if (device)                                                              \
+			dev_warn_ratelimited(((struct amdgpu_device *)device)->dev,        \
+				fmt, ##__VA_ARGS__);                                            \
+		else                                                                   \
+			printk_ratelimited(KERN_WARNING fmt, ##__VA_ARGS__);               \
+	} while (0)
+
 #define RAS_DEV_INFO(device, fmt, ...)                                                 \
 	do {                                                                         \
 		if (device)                                                                \
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
index d4072350f48f..e8c13e42c2f8 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
@@ -193,12 +193,29 @@ static void ras_umc_reserve_eeprom_record(struct ras_core_context *ras_core,
 }
 
 /* When gpu reset is ongoing, ecc logging operations will be pended.
+ *
+ * The pending list is bounded by RAS_UMC_PENDING_ECC_MAX so that an ECC
+ * storm or repeated UMC error injection cannot make this list (and the
+ * kernel allocations behind it) grow without bound. Once the limit is
+ * reached, additional events are dropped and counted in
+ * pending_ecc_dropped, with a rate-limited warning emitted.
  */
 int ras_umc_log_bad_bank_pending(struct ras_core_context *ras_core, struct ras_bank_ecc *bank)
 {
 	struct ras_umc *ras_umc = &ras_core->ras_umc;
 	struct ras_bank_ecc_node *ecc_node;
 
+	mutex_lock(&ras_umc->pending_ecc_lock);
+	if (ras_umc->pending_ecc_count >= RAS_UMC_PENDING_ECC_MAX) {
+		ras_umc->pending_ecc_dropped++;
+		mutex_unlock(&ras_umc->pending_ecc_lock);
+		RAS_DEV_WARN_RATELIMITED(ras_core->dev,
+			"pending ECC list full (%u), dropping bad bank event (total dropped:%u)\n",
+			RAS_UMC_PENDING_ECC_MAX, ras_umc->pending_ecc_dropped);
+		return -ENOSPC;
+	}
+	mutex_unlock(&ras_umc->pending_ecc_lock);
+
 	ecc_node = kzalloc(sizeof(*ecc_node), GFP_KERNEL);
 	if (!ecc_node)
 		return -ENOMEM;
@@ -206,7 +223,15 @@ int ras_umc_log_bad_bank_pending(struct ras_core_context *ras_core, struct ras_b
 	memcpy(&ecc_node->ecc, bank, sizeof(ecc_node->ecc));
 
 	mutex_lock(&ras_umc->pending_ecc_lock);
+	/* re-check under the lock to honor the cap across concurrent callers */
+	if (ras_umc->pending_ecc_count >= RAS_UMC_PENDING_ECC_MAX) {
+		ras_umc->pending_ecc_dropped++;
+		mutex_unlock(&ras_umc->pending_ecc_lock);
+		kfree(ecc_node);
+		return -ENOSPC;
+	}
 	list_add_tail(&ecc_node->node, &ras_umc->pending_ecc_list);
+	ras_umc->pending_ecc_count++;
 	mutex_unlock(&ras_umc->pending_ecc_lock);
 
 	return 0;
@@ -225,8 +250,16 @@ int ras_umc_log_pending_bad_bank(struct ras_core_context *ras_core)
 		if (!ras_umc_log_bad_bank(ras_core, &ecc_node->ecc)) {
 			list_del(&ecc_node->node);
 			kfree(ecc_node);
+			if (ras_umc->pending_ecc_count)
+				ras_umc->pending_ecc_count--;
 		}
 	}
+	if (ras_umc->pending_ecc_dropped) {
+		RAS_DEV_WARN(ras_core->dev,
+			"%u pending ECC bad-bank events were dropped during GPU reset\n",
+			ras_umc->pending_ecc_dropped);
+		ras_umc->pending_ecc_dropped = 0;
+	}
 	mutex_unlock(&ras_umc->pending_ecc_lock);
 
 	return 0;
@@ -611,6 +644,8 @@ int ras_umc_sw_fini(struct ras_core_context *ras_core)
 		list_del(&ecc_node->node);
 		kfree(ecc_node);
 	}
+	ras_umc->pending_ecc_count = 0;
+	ras_umc->pending_ecc_dropped = 0;
 	mutex_unlock(&ras_umc->pending_ecc_lock);
 
 	mutex_destroy(&ras_umc->tree_lock);
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
index 1d3026be509b..237525b46b9b 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
@@ -139,8 +139,20 @@ struct ras_umc {
 	struct mutex  pending_ecc_lock;
 	struct ras_umc_err_data umc_err_data;
 	struct list_head pending_ecc_list;
+	/* number of entries currently queued on pending_ecc_list */
+	u32 pending_ecc_count;
+	/* number of entries dropped because pending_ecc_list was full */
+	u32 pending_ecc_dropped;
 };
 
+/*
+ * Upper bound on entries that can be queued on pending_ecc_list while a
+ * GPU reset is in progress. Beyond this, new ECC events are dropped to
+ * prevent unbounded kernel memory growth in case of an ECC storm or
+ * malicious/repeated UMC error injection.
+ */
+#define RAS_UMC_PENDING_ECC_MAX  8192
+
 int ras_umc_sw_init(struct ras_core_context *ras);
 int ras_umc_sw_fini(struct ras_core_context *ras);
 int ras_umc_hw_init(struct ras_core_context *ras);
-- 
2.43.0

