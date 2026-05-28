Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C674CD5BD5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 06:29:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B30E10EC95;
	Thu, 28 May 2026 06:29:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bVknAc23";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010025.outbound.protection.outlook.com [52.101.61.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECAF610EC90
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 06:29:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWoVVAk9JHI89wBnw8Pfff4V+fH3icZEr6WHgrivvBL3qYiDVQXkSLPtjv8MbUNeEhdwhxGHL4i5PTHTs3lxD868xgbltVoMutvpUROVUuH1hmk9jjt5D/a2+7mNs/AGCRCKBMYz70tdLYvmctwgdKSBCQIfXIqPJjg1bVOm7w0fYHcXQKdXrTTXh3t9JViH1eHkpdcNotxHyHS9/c9Q4UJocLZrjtth/LT6hbUlARVIqe5OQrKIEncPcInTihpIuSkCt5g94oU92Uwf96RNbtJlzeR4DHePFEvYzVDnUYN/c+Ukek5QrkcAHbHHxtSRIyAs0Xma9d9NgDLQ4vHkDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OTEP0BEjmLK/JutmyczW6VOTc+BvTBnGD8ilJEGmUI=;
 b=GpMa4I7gcVMH2hmgo6nRWMK+9FeEHcUg+v109ApjZomlQqXP2zSDge2aMBhuwyjbmv52bY9MzExwq4r8unNGAPGniMMKhn9BJdqP7B//lAyBGTHabkGQNZzojXeHDpCnsOKKYq47FBODf2bQMcurW2ry9N0hkMsrtq/h2PabwGey1kAaz75UKxhVwGXsMS+/K9mge4n2w9Jpoos+Ehy+pWh0Hk4cPeJdcjqW11iPntiIFu41T2Ieb5HXhcEHx1Myrd96s4Z4bs8DBaKCt+jqx6o7jfJOW24oJmvtvUibrwgGBqN5ELoGqbU0xo6FBEiS+syIS9qF7Zz0FVerUOPnFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OTEP0BEjmLK/JutmyczW6VOTc+BvTBnGD8ilJEGmUI=;
 b=bVknAc23XJ5Yl9IslaFwwmUg5sLJqBpvGdrZN3fd+dNhQlEV270bcCynl0SAQDZC0pJa2JJn3uhiYvW/W3qWIdu9itbJX3cbRuByU4YEDR05C+mQwE4uDkP6YrXCm/eHR3urOGbmZLEi0a0v0M2fFNRTDKsTjEDeuQDiolbqUkk=
Received: from SJ0PR13CA0092.namprd13.prod.outlook.com (2603:10b6:a03:2c5::7)
 by DS5PPF1ADAD2878.namprd12.prod.outlook.com (2603:10b6:f:fc00::646)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Thu, 28 May
 2026 06:29:21 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::9d) by SJ0PR13CA0092.outlook.office365.com
 (2603:10b6:a03:2c5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.4 via Frontend Transport; Thu, 28
 May 2026 06:29:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 06:29:20 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 01:29:17 -0500
From: Honglei Huang <honghuan@amd.com>
To: <Christian.Koenig@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Ray.Huang@amd.com>,
 <Vitaly.Prosyak@amd.com>, <Jenny-Jing.Liu@amd.com>, Honglei Huang
 <honghuan@amd.com>
Subject: [PATCH] drm/amdgpu: move notifier_seq read back inside retry loop
Date: Thu, 28 May 2026 14:29:02 +0800
Message-ID: <20260528062902.362031-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|DS5PPF1ADAD2878:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a43bced-ed27-48ef-0bad-08debc827397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Ztgeb5YLME/lvPtbs73InqyNDesDZWdHqOEBEC+30It8c6CYqKXWJ4yxDt0pnSuBBIwPL3S/BS33mruNbjy3QQJySxzOvDmqFNzYux77lJ1eo3uf+kIC0ymfKe+kuVF/pWKyOecbanwbIKrMRiE0vKlarRGtqIvrz/dYUN+3CJ6f2kjUP2Sj04PjzDJlRzQTZvPvaWontWMTugnykW3h7IIpX43cnT9dIwJAPK36kIyNMyobiGEk2vj9U/t1g8X4OM7S3B+04zoDX/xUSsM4xXJ7dc7A6YcE+zrki6K7uPJhBSf+9nC9IXDZBdf/wNsRblo24D7ScVnhwi1oXRHCuHKd+u8uoX02GfrTrRo4g2EI/4A8PYpeHwE18QC8pNfOhfSCCglXJl+x9dMLeIfuEMXqcRuGPqZM3ETNyogBVucc4/QHB2LcOeO20pMqMcbxt7KPdQiuao4Kfnsh8zPu38k+EnyfChV0eC0iakeuNQjR1JjPoOJpCW+h8n3m2x7HN7sWcJGk+Z543OYA+o5BOINCubR/6RP1F96l4qbs3g1eagP1HVuTl3LBAIt8RiI5WQgOCn2B9i+0AqCZ08v+v6jRmE1Cmc2SPm0IrT15jbSb+iDjbaRjAmKGtogrBtUa7uBqiqnl5Kzss0OQHWDLt2nTslqZnyrZTsTi4ij5D7t0jAU7yiMHbm5B/h9vGIcOrvQwU/C++kX5XOW0Zzv728FfHzZgP2bi4btpDGW1J70=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w1KgYsjfpQH0++iM5n8bQODqCjufSU+T6sAGG8mc4lmQ+X5kiLFiMyB6OdHP+MHBYQn4i/j4yXSYFhShC/2BiHDKiG4NcakKCsojiTyWFom/k7TD324p8HCeGuOz8fkQvam83j4PeKT1Srpm6pPhQMZBCJiun26/IzpTwrGbI8MmlhitR/Gwe8YeHNOq7lRvYN1Kn9JIXijY6mFO0HTW7IlnzOpV2u37frmVRZDa22FjVcyeIIyf4iBl070Bclz3+6o2wBSljXNfl9BfmZ8SZ0gFa7WcDLc7fIrpQgHp2O0T5qvWubhvZTtFbytKD7Qf7UH27M02cpqzFc8pEjTL0iK5mcggo4jiNG5W5hJwbdP4DNPRo03EjEzCR11lyFqonJp54GUqmwD8hF15hJaRucg9qB3eDHNaC6rerZd6XJN6UxlE2pEmhtoL0M/8wIAP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 06:29:20.2884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a43bced-ed27-48ef-0bad-08debc827397
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF1ADAD2878
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

Align with drm_gpusvm_get_pages() (drm_gpusvm.c line 1416, 1440) which
refreshes notifier_seq via mmu_interval_read_begin() on each retry
iteration. Without this, a stale sequence number causes
hmm_range_fault() to perpetually return -EBUSY, leading to an infinite
retry loop at the caller level.

Fixes: 144ba981783f ("drm/amdgpu: fix amdgpu_hmm_range_get_pages")
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index 5d72878c8..ec0fe9044 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -192,7 +192,6 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 	end = start + npages * PAGE_SIZE;
 	hmm_range->dev_private_owner = owner;
 
-	hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
 	do {
 		hmm_range->end = min(hmm_range->start + max_bytes, end);
 
@@ -202,6 +201,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 		timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
 
 retry:
+		hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
 		r = hmm_range_fault(hmm_range);
 		if (unlikely(r)) {
 			if (r == -EBUSY && !time_after(jiffies, timeout))
-- 
2.34.1

