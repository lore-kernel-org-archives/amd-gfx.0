Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10398C54FD2
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 02:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 919E210E0F9;
	Thu, 30 Jul 2026 02:59:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qRq17aWx";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012029.outbound.protection.outlook.com [52.101.43.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB25D10E0F9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 02:59:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdtkT69OzYbTiNZ9wEYeBOHa1kXwNB8wiBRecu5eBZE5DGwO6H6GqLFUu5/FGcahNjtqFlqNc+ruZOHTOa4fPmAcc6vSNgXxT3VVNxP5BvEXeThIuN9tPM5eG458df8sau/ZFFehhEd7EziHVsBXnIGZcRdtSklas8MWhHSCXco+rz4s9HwpzLSxExbLLgqTjXe2gZAuOUlI6mbDYEmhxy+DZfF0oXYHFuzFDSsbaIyz4p2FHFfV/FxFya+oiYEoh6QfEu0hmlB6OlvwbH5pooil9EP0MJ+HXaswTbzd4JbpqsOaK2mSXsI0+RMxFMgmNbZ85aDAhAKVxVnId0Z6cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrAnrhy7IcdbF/wfkEigtGAwKYXNhAUXqt6daP94q40=;
 b=LFwBqZKDPrm1Rz9DDtG1b2y+072lUSCDl3B5tFrWIRbXhFR6XYMQHisk+GgoPWVcUYGkOpZJhx4M2MJixeLrWKFqKhtSd9Q0crpU2bXV2LJ3V0MFS4dI3iqScFDUHLftRsRy/yr9ftdcUw9eexKHR/JRnGrZSj0va/bmkU70QYg9y/BvIHGtnJ/1Z0ZNHN0gE3LPLUJvf+xL6+lYEwBNeq3lLUHL4owadkXSBGTjCghLSMju8UDDkSfqAgCjAU450yIBnjBxMRSGUOgcONAyZ10+oiI6DNYRL1kapbLxqzmnzdZ6R5lpf1t6UgvQpGoStwrTTRZeug9BFhHkhoMIrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrAnrhy7IcdbF/wfkEigtGAwKYXNhAUXqt6daP94q40=;
 b=qRq17aWxVlwo7UQ/2MWxfsfM10nyIPy7F+9zERGl0AfsmGKX3XvctjMal9vsTcSExdrYqz4Ky3ScMGqS1CP2e/X9aQ6egX1qL6hKiCDS3rC9amDtT6NuCpQbcLwc3gttrmha6mLDifmNKWBlAQCoG6B33B3WCpYUMGHUr6FmiG0=
Received: from CH0PR03CA0096.namprd03.prod.outlook.com (2603:10b6:610:cd::11)
 by CY1PR12MB9582.namprd12.prod.outlook.com (2603:10b6:930:fe::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 02:59:17 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::90) by CH0PR03CA0096.outlook.office365.com
 (2603:10b6:610:cd::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Thu,
 30 Jul 2026 02:59:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 30 Jul 2026 02:59:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 21:59:16 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 21:59:16 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 29 Jul 2026 21:59:14 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v3 4/4] drm/amdgpu/userq: mark a queue unmapped after a
 per-queue reset
Date: Thu, 30 Jul 2026 10:58:29 +0800
Message-ID: <20260730025904.1993364-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260730025904.1993364-1-Jesse.Zhang@amd.com>
References: <20260730025904.1993364-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|CY1PR12MB9582:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d903168-e660-41ce-d2fd-08deede68b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|56012099006|11063799006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 0EOWSAS5t+n/KeehzQfzz/3OzgWYO3mqGXzPkyRRg4RxSO7WOcf/LXfCQl3C1NtoICXvsfkBtcIJg/J1kVE4wM3RpPwnGYikWpMyVcK/cZedpKAc6R1OfYjFsGtxyhQcNMj/RKNJuv/QEpzYrtsLLqjv6cMVyRfT33ma5o41x4w8ZRLQz2hdIC6OxV344df0m2YDgH9qzkMsTJxHFbAgt6lA+onciLsJHB3tkpaXXke3G/0knZ+sNGYSY94YmTIIwrCtVs6vvoYHtPVRE5MHGjFfOiq24iDP9DqwekxEFGCGA7lzORrHpoeqpu1jcSYRRSlqb5bX3N+GGlWC9Grh65ViwGNxi++XIjaHDNmD3Bnd6XzPe7pRFV6g1aWoO6mmGm2CQSzk0cKrB+H55wXH9Ro4Ft7iH36/nlYrOG7xSPPLlG/Eno8Y+jXAQ2YNbKhgGGIU0zhB4necmFAZ5WLaylwksM82bGcCSkYwcZSp8+TyEKaeIvOHBidpY4IqOBm4EuFaTkMo6m55nCoDJO3Ir5OlFdrbIXdyDNycjc/UvWA9KHv1/4MLZoHKkJAIMXY0yF56S7MH0u50M0vfcPUi+nQi8VOwbZnzNib+bd9GquU38n5pllj0j89I8AH6v8GK+UfVenwh2NgI8/V730pVfjH0xhfM6KXM8MeTbtLkcSEB+uJ/AzeIvfzaR9hIUxBTllj/b27KLas40lKe/IBWhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eil4fYvasuYQGGk0KXUpAacR1D561kxAnympqWpjVaD5WYc707FO/qm2kBg4Wh5P3VOV8m4EaJwGjVHBUg6SH4EEIXrCoZaTgb1Lvi6OOCfAo+Rez5zvp7+DkVcJPqRPERd562CAbCDQUE3VPsNQX8p4FvWUTQc4BrzMxyF/RYL4pgFMbo9hIebYWlkY8apOuTbkOJVZh5QwmAcpTRISbaWL2fG/ttSMIuyjrmX6tZYgdt5WYl/9/lojEQkTu905RNaItuBjk0J3EHukF3T1aVT6MV0vAYQzCbWYTvQQjh0rkH0JHVYTACk7enAvMxvtbv0/fVo6xhyzJ26vAdmjR3wqWeHtqAbBwQzfNpQsoZVB6H/oKi2TrWNhI4k3xT1xFwLewI5qeuK3qIrRcj1oibWgiESefG9xZ9jCj6OmwDjbcxum5bEA/crdmBfA/aaO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 02:59:16.7752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d903168-e660-41ce-d2fd-08deede68b49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9582
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

mes_userq_reset() unmaps the queue via the low-level mes_userq_unmap()
(REMOVE_QUEUE) but does not update queue->state, so the queue still looks
MAPPED. The destroy path then issues a second, redundant REMOVE_QUEUE for
the already-removed queue; for gfx that unmap waits on an EOP that never
arrives, times out (-110) and escalates to a full GPU reset.

Mark the queue UNMAPPED on a successful reset-path unmap so destroy skips
the redundant REMOVE_QUEUE.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 639e4a37f872..b5816f9a8ffd 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -26,6 +26,7 @@
 #include "amdgpu_gfx.h"
 #include "mes_userqueue.h"
 #include "amdgpu_userq_fence.h"
+#include "amdgpu_trace.h"
 
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
 #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
@@ -205,7 +206,16 @@ int mes_userq_reset(struct amdgpu_usermode_queue *queue)
 	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		return r;
-	return mes_userq_unmap(queue);
+
+	/* mes_userq_unmap() does not update queue->state; mark it UNMAPPED so the
+	 * destroy path does not issue a second REMOVE_QUEUE for the removed queue.
+	 */
+	r = mes_userq_unmap(queue);
+	if (!r) {
+		trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_UNMAPPED);
+		queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
+	}
+	return r;
 }
 
 int mes_userq_reset_queue(struct amdgpu_device *adev,
-- 
2.49.0

