Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC95C83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 09:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D76510E9FD;
	Fri, 11 Jul 2025 09:39:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LvtXTEct";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC86210E9FE
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 09:39:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/llq+82wZX4njxX+aWtMPSYCsFTA6i8TOpsn3WohmL79vMpwP64jf86LItzySJcDImsg3cI7W1msJZSu/0jmsEufKU3odky365ZJ8Ft7ucU4IAuZg8/mWRh/oV1yO04DXfBJFnbJ09KrhmEWR22xRlnvhUH9V8kXD85jO6nqcUpuQedMB/QJN3P1JXepBuljYvxlRfsa0mtLheHbd5tDgd4Rnr9x8VMMbVibHAK7Ez2B0XJQcBd2MOqX7SxVDl66YPdFsuOaGtw6E6airASxSINFe0ursCjenS4DSa5pOuJTSWLMjakyWOgRHbtI/WFQfGdDTFxtzWyIPADVaG0yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6RV+5JbU2ohPjNEMAGigjfOXpst2aJChTyRTQA9Iss=;
 b=WvRDF8nj++iYJqSjxyH9+PHuXzHkTJXl7AyB4K/3CoaSUqFxQ8gG/d3YmT+Kpjqy2FlS1dcIEpySt4EIO2giNLe1JHaICZ3l/GiCdugpNkllj36copUREi5N/j8sHKmBRZjhwfB5RbzZkF2xS+KwWXKdq+YSep6UNc/4Xtowvg7T4a4kL0mUjJPelqfpOX4gkDbP6kYx4apW6GNkgrT8rBXYX5nEu//moPwcAo14XyG+LrST9Ouc5QqWB/J5s63q9FFFr3utZAaSj4bQLf7UkAGbqTA6DIU7stpc+WSWQXxfovt/tx+0S1G+9fPq4xzQsy/CCohlpZRI5ZYlPKbvYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6RV+5JbU2ohPjNEMAGigjfOXpst2aJChTyRTQA9Iss=;
 b=LvtXTEctTlw9MEUPndWCOjPtohsLeU+WlAFbFiFy3gD7RlgX25KOLZoqpRqSXoW1bplwfEQ4+mpcGWB4UcK8J68N1d5clZ+kdH79+JVslmIBysWEr2KTIPmYSCnbnP18h2hvxr8cCQdvpW4lAvBcrLqdsBmC1MxXB6hTXShPlo8=
Received: from MW4PR02CA0014.namprd02.prod.outlook.com (2603:10b6:303:16d::29)
 by SJ2PR12MB7919.namprd12.prod.outlook.com (2603:10b6:a03:4cc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 09:39:53 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:303:16d:cafe::7e) by MW4PR02CA0014.outlook.office365.com
 (2603:10b6:303:16d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 09:39:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 09:39:53 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 04:39:51 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v6 08/11] drm/amdgpu: clean up the amdgpu_userq_active()
Date: Fri, 11 Jul 2025 17:39:27 +0800
Message-ID: <20250711093930.1411470-8-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711093930.1411470-1-Prike.Liang@amd.com>
References: <20250711093930.1411470-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|SJ2PR12MB7919:EE_
X-MS-Office365-Filtering-Correlation-Id: fa38eda1-c464-42ca-d957-08ddc05ee3be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TTwf1TxkYJ7VnmX3KAsCyPxewOU/WUfgDVtI9pc5yg560ej7I7OXTQl/pNQg?=
 =?us-ascii?Q?DSP+Nd/sxJbbvVpxipCNm3SyWFUBkoOaNM8CCukuQJp0yNI49ERU+FUuWcJs?=
 =?us-ascii?Q?TxS3X9l6nwKK+QLkYhF1Fp+BnqQA+Z2cHxH7IFMGPbq0hRpi4yOp8HkC1XUI?=
 =?us-ascii?Q?/VBPGXFTYAU+5WCf/L1V7/xxPjHNXmXY9Xtny44cYKR4sWaJm2Mv/p6GRxxW?=
 =?us-ascii?Q?7zowpQeESGwQB78IoyGv86HdqWIaBNK7xnn+/H3yoi7CxS8BP714PuAof3eP?=
 =?us-ascii?Q?sk4fkwNrYEY6wdMXdnKR19Z8u8wdyhr9Ko3xbYjDtWKgiBAUt68y0VeoVoV+?=
 =?us-ascii?Q?6E6fYJ8X6TvKk836fNTrXQ+w32MiSzRPSyOomBGkcL3UZ0mEwhbdn/m8fi42?=
 =?us-ascii?Q?EC5pPRox90oFfoIJOaA7dRGb9zDyizGv6iiFJOkPVzI9wwwihtuWZFmNBxw/?=
 =?us-ascii?Q?Dr30XpzU4LFtKNKZUV6cBQRuJbTr7zWGA/BV9pMqflWPkjqMM22BE6VWT/WA?=
 =?us-ascii?Q?ERcJsZueLXRrdXZzsbRpF5wk0C8aShiT8o5PiJ5zKO1HH14r3SxOL6Iad2Uy?=
 =?us-ascii?Q?aGutIbt0Oq+OrOVTpV4V+lTYIgfuJD/ziS4QyiG3+DUdCV1kOX2GREUihwcI?=
 =?us-ascii?Q?toOijXkdloOAgu4eDrT9oig5lEO8h57ofZOktt1lKyxpI027xkbL+ILFSY10?=
 =?us-ascii?Q?gXPOcp/DSDmwYABUHbPtVh5DQCcCEkfLQMC7cJjWaO8JzE06PFVN4LuOEWz2?=
 =?us-ascii?Q?99eCE4OpnPOdEpXrMFCZ0AlLePuSHjKEsClca907Qmo9R5hJVBBvHc7cru0i?=
 =?us-ascii?Q?69ckEXBB0cpyeozSs5BpGWrha7FwsU0qmMNRQDVbeF47NazhV2c2KfedyGM1?=
 =?us-ascii?Q?VKApKC8uDt9lwk1UEUIdFCvr6TDxFt4wJLtDFZnvePTXDXlXDdWzBXwM8u6c?=
 =?us-ascii?Q?/hRlysvXXpb0zAz8y9pN1XzVMkvA8XP+qc9V9iUHfWORKFbXqLwVmx36EhNv?=
 =?us-ascii?Q?5ChmGIJlgsOXvu1Jd+PuvCO+x9wlxr8xQphU4vQFkB3kzPZfWqdc17e0Ak4R?=
 =?us-ascii?Q?9bj7vLoobjmik3MsddHmoR46XuMcAa/7jyx3ucz8y63upnxRkdJ4rjOeLAxP?=
 =?us-ascii?Q?ylwQ71p4VVO8sl45zjTeIWUcKA0EA4Yk5fctISbLRBg5C0gdYIh3W6KiGDc9?=
 =?us-ascii?Q?Truqb0br2+A3i2JJp5fSEDJ3ytoPuVKtQZ7qOfAu2olVbE4bV/LIO+toUqcn?=
 =?us-ascii?Q?R9dnH9zjAsZIWL9LTTFCLPBXBMH8e2eZFvLmQGgExEkfnW8ASMIPTxjxXmzN?=
 =?us-ascii?Q?JeYfY3ZHCC/WXAUF/HkmoA/1Ibm0pA2tX/BN481sCWBDPHwH9tOq3PQdL0g9?=
 =?us-ascii?Q?yyIxS84qsAODpq0pwiBPiCHQ+AskAB35vrYpAtLDxzHtm/0eC535I/L0lBb4?=
 =?us-ascii?Q?xTbycYMDMOSBzZlEcUQ/C1yU+LtRN0VrL1f3wxt+yFmYE33TPPKQwsrDOj6k?=
 =?us-ascii?Q?tmpqlrCR9HYDHB2LABfGochZxprejJbyzM2G?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:39:53.5499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa38eda1-c464-42ca-d957-08ddc05ee3be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7919
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

This is no invocation for amdgpu_userq_active().

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 ----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 --
 2 files changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index bcbe8d3f66ed..bfe7b229011e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -314,22 +314,6 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	kfree(queue);
 }
 
-int
-amdgpu_userq_active(struct amdgpu_userq_mgr *uq_mgr)
-{
-	struct amdgpu_usermode_queue *queue;
-	int queue_id;
-	int ret = 0;
-
-	mutex_lock(&uq_mgr->userq_mutex);
-	/* Resume all the queues for this process */
-	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id)
-		ret += queue->state == AMDGPU_USERQ_STATE_MAPPED;
-
-	mutex_unlock(&uq_mgr->userq_mutex);
-	return ret;
-}
-
 static struct amdgpu_usermode_queue *
 amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 194ec7a6b3b2..ca6ede32b260 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -120,8 +120,6 @@ void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
 void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
 			struct amdgpu_eviction_fence *ev_fence);
 
-int amdgpu_userq_active(struct amdgpu_userq_mgr *uq_mgr);
-
 void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
 				  struct amdgpu_eviction_fence_mgr *evf_mgr);
 
-- 
2.34.1

