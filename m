Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AC6C04FFE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 May 2024 03:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B1EF10E246;
	Fri, 17 May 2024 03:41:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OLQpEVUB";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3A2010E246
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 May 2024 03:41:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bpogzl/ay1FUvox8l3jq70hspsqGlr25G5EunkK7tfvCyjMdNV4gyFh2Kc+9hnTlQ1heQIlJcmLBAnun2N2z/oAAkHvOVDDcaS4x7hdtqWFP8dfh+u75Tm/BrkgDlncdfSTM9QVYfYZzNe5+1cPIWleDRIodc91gc7r6YikNMukyUmS8BX7aer+cp4o8OYzhZ4evMZeO3UtY7rSGpsKfPxmb/AQFgHlftbUPGfSJe5FIrM6tLIfoztLoREKF42zaoND72NuVHx4rscRWOqkD3CSm/k0zv8yuA84mPfwnxrW4OtrWzdHhRCdcYY9WuVoiSCojp950GUOwkY1TEr0COg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nV/IqJpV6yFLlr7tbbHBt1kPCtoXd5xUdl24VfRilA=;
 b=RkyGFhkcxNNYsyt8NM3qjHTt5eZPc2nSiwaosQdfHUbwX1ww1nlkN+2L4M/kYOPeTvvgH62FAZkzDRjyOM8mind2qI4DMECPVuF0F7vMcwPr9HroHyrwgTkd1kHBbOXNQ4ghS2CXQZNUBwjdKeAEiibU+tTaRK+gQ/1UFvmntUe9dsxrBvJK9GtPNU4Jdfwzu+XSK6Grv6IDsh/JB5N8m2EPln5gSpubtP4/qasWDcV0uJIhXbVu8M8Q/2ZcEZWH/fsnP+ukao09CRiQxCUcfMM/RkuWxxMObdGbT4f2YjlzAMkmZmgplwlw1mE82UdY4ApARDObQs5XHSNiKvY5qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nV/IqJpV6yFLlr7tbbHBt1kPCtoXd5xUdl24VfRilA=;
 b=OLQpEVUBDYLFktmYWXyU/S1+zCoCILwMU/gjVtjlrr2BvZa3rRS5ysVSOCBu5AnpyI5vjO43Eup2LOeyNSvsLA4s8S2Yvf2nWrQq4K3WZhQNQUZQGgi9Il2Qxg5+vzONaXqW5pjm37CeJY9r2G3VzwjWd9ZAvEnLRDUvjtpdWWE=
Received: from BL1P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::17)
 by MN0PR12MB5860.namprd12.prod.outlook.com (2603:10b6:208:37b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 17 May
 2024 03:41:10 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::fc) by BL1P223CA0012.outlook.office365.com
 (2603:10b6:208:2c4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26 via Frontend
 Transport; Fri, 17 May 2024 03:41:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Fri, 17 May 2024 03:41:10 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 22:41:07 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: change aca bank error lock type to spinlock
Date: Fri, 17 May 2024 11:40:55 +0800
Message-ID: <20240517034057.2015624-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|MN0PR12MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a3c4ff3-da70-45f0-de0e-08dc7623312c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2HTff2FUhuWnJ/SVrv71clnbmgbJkyENH9nAZ3WLq13+ZZGgw1EdTd+M3nZJ?=
 =?us-ascii?Q?VSXl7AL56dCrU/+WJNDw2bg08qccEIAI5rEEkQKdRNo2fdJv+fl8a7s3ydwx?=
 =?us-ascii?Q?v7rMJpmgQmv2inxqPlGt5ctZZlIMDMNhhZP/OvW2TsabzPVBcsyC+mdIzaCd?=
 =?us-ascii?Q?o8R923MLx3HOOmDRYQJQWP8nhTT4pe5LHGl6Y8rwQe2xtzjaKuBaC0EFCmuh?=
 =?us-ascii?Q?EzC8AgNO0bPmENq91HRvpQtjBaJGQO9W0gZ3z825uvjvVNyI7cPaUSVwMT+C?=
 =?us-ascii?Q?n2bWWa2wm0XXewJ7MWE81ie3XR9iHIizLWSuZTPRI4KkKVvddS9eExLqZ68j?=
 =?us-ascii?Q?xmooO+zEP/TYuD1I5pEd8/8A64xa3Yy8WLEH4KcCGsOeOZPbfg5pXhyLJbEA?=
 =?us-ascii?Q?IKm/P5ZXkXTsF8Lfb/qqVYeoj/2XjYTAvuzr+gphK07PKHeOFQW4EiLiTWy1?=
 =?us-ascii?Q?jwSwzTxuynbL6GwHYq/+SXCAfw0G9fShYjrT7jglRCkrV6GTrwcCILn1xVBi?=
 =?us-ascii?Q?jhSRKRWXqlQUAh80e1JUtsJZ8QL41g2IMRznTUTui5Vnk3mOyXRG/ISwGzAu?=
 =?us-ascii?Q?GUAYLkPdktMOl3jSshTINVs7/eZkGdlW654YkHvhHeGlq1WqUTb1oxvD7UMO?=
 =?us-ascii?Q?69tSLr2DX9Kq2MkiWEOLJiTMotbNQeiRAmnN+MUwh5V2COefa2eVvh8wFEA5?=
 =?us-ascii?Q?tEXc9VaelXrwhJGKKuSn0Ea9GE8auXnHus9t866TgPQYUotmUbq6Z88n2pBq?=
 =?us-ascii?Q?fcRnb654J9G++NFrs6h2wMpKpFyYTkHPZeVvj50UFJefWPtMyr1CnP4PErEs?=
 =?us-ascii?Q?un7fFMbYefOpxOwrFASWlWm73wKTkzjdavYEQHHqPPYR9UAGzqyctH/XOqmu?=
 =?us-ascii?Q?s9QHQIXG7LbarG4JgYI3SUcWVxH9CL06owenMsYLTPZsgjlv/PBwZ3mSlXoU?=
 =?us-ascii?Q?VvoXQNU1qWckkJ0oEEgbXgx5ueo3EwHR0mOcwloBa8GajUgLQmbhgqAEXbEH?=
 =?us-ascii?Q?yhch6+K8j9qpd1tPwHB6loTfxasQqgKOsRjYAU/jnuuMXDa30Vn2CdsODfe3?=
 =?us-ascii?Q?r0ASuyVbjvB1s7/sQB7DvQhwqMd7kcRUrGRGo3vuGdnNjOfOburA07TnrLv2?=
 =?us-ascii?Q?hnvb3yvg4j7Cay/KAt3nonJKGTuY/F4rxCff6iGE3QmsM8+unn+Yjj/caym2?=
 =?us-ascii?Q?WvNmOETwg5ZmvmOB+vlgTnrKKvX7HCnsxaP7XSOxoEb0ZcAgsG79cmEeY7xz?=
 =?us-ascii?Q?EFqPLA7n5+r0Kkx1o9kxFbz49A3l+fIYkmko+CvTOkrgwLrjZLqisIYUnd+c?=
 =?us-ascii?Q?0k5r4qmaHCBcNrJYf/7kcFbCj7i5ATgbyVzZRpu4bt2oAsjFiY1dnnybG8Wj?=
 =?us-ascii?Q?h0xugk8hB5wfbZI+t0I6ZzB3Cbad?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 03:41:10.0256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3c4ff3-da70-45f0-de0e-08dc7623312c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5860
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

modify the lock type to 'spinlock' to avoid schedule issue
in interrupt context.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 19 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h |  3 ++-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 0b1b9911bd99..05062f2581a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -222,9 +222,9 @@ static struct aca_bank_error *new_bank_error(struct aca_error *aerr, struct aca_
 	INIT_LIST_HEAD(&bank_error->node);
 	memcpy(&bank_error->info, info, sizeof(*info));
 
-	mutex_lock(&aerr->lock);
+	spin_lock(&aerr->lock);
 	list_add_tail(&bank_error->node, &aerr->list);
-	mutex_unlock(&aerr->lock);
+	spin_unlock(&aerr->lock);
 
 	return bank_error;
 }
@@ -235,7 +235,7 @@ static struct aca_bank_error *find_bank_error(struct aca_error *aerr, struct aca
 	struct aca_bank_info *tmp_info;
 	bool found = false;
 
-	mutex_lock(&aerr->lock);
+	spin_lock(&aerr->lock);
 	list_for_each_entry(bank_error, &aerr->list, node) {
 		tmp_info = &bank_error->info;
 		if (tmp_info->socket_id == info->socket_id &&
@@ -246,7 +246,7 @@ static struct aca_bank_error *find_bank_error(struct aca_error *aerr, struct aca
 	}
 
 out_unlock:
-	mutex_unlock(&aerr->lock);
+	spin_unlock(&aerr->lock);
 
 	return found ? bank_error : NULL;
 }
@@ -474,7 +474,7 @@ static int aca_log_aca_error(struct aca_handle *handle, enum aca_error_type type
 	struct aca_error *aerr = &error_cache->errors[type];
 	struct aca_bank_error *bank_error, *tmp;
 
-	mutex_lock(&aerr->lock);
+	spin_lock(&aerr->lock);
 
 	if (list_empty(&aerr->list))
 		goto out_unlock;
@@ -485,7 +485,7 @@ static int aca_log_aca_error(struct aca_handle *handle, enum aca_error_type type
 	}
 
 out_unlock:
-	mutex_unlock(&aerr->lock);
+	spin_unlock(&aerr->lock);
 
 	return 0;
 }
@@ -542,7 +542,7 @@ int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *han
 
 static void aca_error_init(struct aca_error *aerr, enum aca_error_type type)
 {
-	mutex_init(&aerr->lock);
+	spin_lock_init(&aerr->lock);
 	INIT_LIST_HEAD(&aerr->list);
 	aerr->type = type;
 	aerr->nr_errors = 0;
@@ -561,11 +561,10 @@ static void aca_error_fini(struct aca_error *aerr)
 {
 	struct aca_bank_error *bank_error, *tmp;
 
-	mutex_lock(&aerr->lock);
+	spin_lock(&aerr->lock);
 	list_for_each_entry_safe(bank_error, tmp, &aerr->list, node)
 		aca_bank_error_remove(aerr, bank_error);
-
-	mutex_destroy(&aerr->lock);
+	spin_unlock(&aerr->lock);
 }
 
 static void aca_fini_error_cache(struct aca_handle *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
index 5ef6b745f222..ba724c2a997d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -25,6 +25,7 @@
 #define __AMDGPU_ACA_H__
 
 #include <linux/list.h>
+#include <linux/spinlock.h>
 
 struct ras_err_data;
 struct ras_query_context;
@@ -133,7 +134,7 @@ struct aca_bank_error {
 
 struct aca_error {
 	struct list_head list;
-	struct mutex lock;
+	spinlock_t lock;
 	enum aca_error_type type;
 	int nr_errors;
 };
-- 
2.34.1

