Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5A7CCD1AB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 18:16:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07A1B10E82D;
	Wed, 22 Oct 2025 18:16:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rGQ1UQok";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011026.outbound.protection.outlook.com [40.107.208.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9892F10E82D
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 18:16:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRYYopjc+Nq4WwaNEmMHcOrjQbf+0UPGp+u0Bh2HrwzD4QrD0ykMzO5MijJVF8OQqEb/Llm6ZeSD26Qpj0UZb561F+plmeii/QMB0sDkeDpYt9ra8gO4DYXrAb//jC4bWrn4ouqf0uutJlSyCOCRVWanLYnZL+4JaNm2NRk+LkW/TAhTKSWEEoECt8E8tgUBURie9ALYiQtvtH734njG0WcN/7XlkJlPDguNbRV3PPdCcDJ1dbAclhXEZPUI/uV5Kf0ermAjEti2+XO5SVu3rrQjrQCUZK3NY6iXPnOClG088pKCuxUqOGo8UJCwBMQcfn08q60ujyIy/CcPJHYi8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXAepZD8y5pSw0BqH4LIKwc6e8q4vYD+asUcDSnLqKI=;
 b=WiXmER0/7tm2GrG2jdKt9wYudPSt2l/U+aNpTPWlgQ75YOd1SJPenlHT5v+AkCptIQbgt7+C/p3BbvJB/dfbrtbv3Kgc6knucODdBLkVD/FKG76B7JlL6CJnalaGH0LqsZsiv/5TaVGIqM9U7237e2kHXhDvGPVWAiQ3JeKgOiEQQeHKCxOHuh1h6G3aj7SaYrPKyemhbL2u8muzJIcftxtye3tm++KpZGkUnCJnjejRbSeXORzHvC747GBCuYJqhfLpRXvOP9wLRzioYGcLXi9PFp8aBIht+NCf4iwGNMZ+N0xyB2Id0sxDcz+bd6jYPm/hfSnMx+WryL/2QVQdPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXAepZD8y5pSw0BqH4LIKwc6e8q4vYD+asUcDSnLqKI=;
 b=rGQ1UQokLVItOfTozXJfcl0k7qJ8fsAoOypvRb6Vyd/o0mbVSH14K6oXSQDI6LhV1y3Kx6fzDIwb0c8/TZ6tuQlPZqnoT6Oa1/JjkRaIBulMBKK6kF8MurKeuL37A3i5gZb0anVO5GQVxjjsyHIYMULZv+SDEzXqmCcCenoKfV0=
Received: from CH0P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::8) by
 MN2PR12MB4344.namprd12.prod.outlook.com (2603:10b6:208:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 18:16:48 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::63) by CH0P220CA0005.outlook.office365.com
 (2603:10b6:610:ef::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 18:16:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 18:16:47 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 11:16:45 -0700
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>
Subject: [PATCH v4] drm/amdkfd: Dequeue user queues when process mm released
Date: Wed, 22 Oct 2025 14:16:00 -0400
Message-ID: <20251022181601.10142-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|MN2PR12MB4344:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bfeae3d-e197-436b-69b5-08de11972a0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F3LUoh/aHRwoQ7QC/FEQaRVZxJgQ9dQVm0Z6YZAFjYP35iZ68le5Tgn9YCqM?=
 =?us-ascii?Q?t/HUd4y+cP3hFZh8rTieIW/f9av35hkY47ZUasQ189BVqVEp3GIf1m5/nQn/?=
 =?us-ascii?Q?knwZPYczSLqPoqVbfRBiqyFJUu10wGRANIfElNgeKBT8HrsiG5xxW8QaUVex?=
 =?us-ascii?Q?ObpxVjSGzDGSjcYHBPGvtMxaH9TYhRm1kQj6p9tnZ3uBRsoOQSpXylt630KD?=
 =?us-ascii?Q?5NZ5wHaQ5BPpEXT/0lYVYVYORjOdT+HNHEOpQRDG5S9E85RKd6DETIEq2Hsq?=
 =?us-ascii?Q?DDy7ZNLbB+5tteHBz6a7vy8umwKZlfiLZoB5S+8bJZXbqQRmnV2AZ+Q2N/5S?=
 =?us-ascii?Q?fZRPUBn3G0eQDnkoCQ3zoPwXyys+D1kZJkdeRAZw0JTZvhO2Hjipp2gKbB8A?=
 =?us-ascii?Q?h3JEyhDubhEKAhdl/vxcN/4WQCBIytIsbP6FdWC+JcdPRqSkecI/WjlTvC4q?=
 =?us-ascii?Q?tfvoHZbnm69CMYb6PfmTWyYoBF6D3ljhrvgEdXBEzpFpi4POKZ/XDzr6S4ho?=
 =?us-ascii?Q?/ItqVf9JUAVnwV9dEjjnxx5uechJHnt+WBOSLEAR/DKZjbUaSGRFh9N9dSVo?=
 =?us-ascii?Q?3OYBloJIhYUqKxQhcxUwKoQJYwHlMuYy5r7c45epcKYpbp35fRL53dXIZw6k?=
 =?us-ascii?Q?l4JtVhqgKh07Oq3QMn0FisZnVUo/8p9sptgLNQ09FIqVkl+GEcxY7SCSgs1I?=
 =?us-ascii?Q?9zAqLRbIPQLEwKVtq+uMUmw5/Luuzc11cSqMH9WNKejOKbWjP80N3NX4F0+D?=
 =?us-ascii?Q?ZKvvnNpxVNde6pgPwOLlZmHKjTYVQOckL3k5J0MDS2cCotH4B9aBZ1eE+zgY?=
 =?us-ascii?Q?D4Syr5swn/IibepLPKdbJJdugE/F9GMzdP7zeD9izbws+7UZTa5V/PLJHg0Q?=
 =?us-ascii?Q?6XDvW2yE57/GREPEqCYTc8dCQJUUE4n+/3otMnLqqbTncx07GOVUtnmaPclo?=
 =?us-ascii?Q?+CnxbGwOV/VDuP9/sqC7xrhL34i5NozaOwCUufspxsQtzvdNAa2ILRny8xq5?=
 =?us-ascii?Q?XK7zsVBOUHKlB7eoNNRlFcUR4eelsZ/AzZkYf/nZypH0KVb4bOyMtm4EtVdL?=
 =?us-ascii?Q?jbOKI2sDExDY0X2qX4Wu4XOtLijdmKvSJA0yKv1D7P/OxOgH9QXe6zoKKhaF?=
 =?us-ascii?Q?7xfz5PxIYQdPEPTQjdwr4Zwa63LPfhUxGcQscFV9LGYPCPIii3t+io1iyqxP?=
 =?us-ascii?Q?8/q3ULQzp+Z32VWZmHPZBmDysfuXC423ahPICurYefjM9QLguIG9PyacTbXb?=
 =?us-ascii?Q?X1s5n5+/a+lmvzGZp25rDELrRlIZBsPSOXT3CCCNbA/oPY3FsHWPSUkl8hbq?=
 =?us-ascii?Q?f26FAgoGDwxh7ZZXXbSL+/NbNYyN/L3INkdP2nqBVlw4Tcrsq+N+4AoQeHZO?=
 =?us-ascii?Q?1IfXTfkZ76v6glXqFZHW7eNYtVypJPtn7KqthC3a1LvX5nfbBDixfYxEHXlg?=
 =?us-ascii?Q?gxtNdpL1PTQ90pul/tzunXEs4e3O18mjyFJOYkc0utVnaYWtL7kc7UXRSfwe?=
 =?us-ascii?Q?v11i/HvKZGHTv0FB53UP6CsU+0kNhDVU5L1buWFn2ZJBcpouMTAKpvChKEqP?=
 =?us-ascii?Q?eML7SaJ+mzJpP9LOIhk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 18:16:47.5758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfeae3d-e197-436b-69b5-08de11972a0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4344
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

Move dequeue user queues and destroy user queues from
kfd_process_wq_release to mmu notifier release callback, to ensure no
system memory access from GPU because the process memory is going to
free from CPU after mmu release notifier callback returns.

Destroy queue releases the svm prange queue_refcount, this also removes
fake flase positive warning message "Freeing queue vital buffer" message
if application crash or killed.

Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 849456ac498b..b429ee4c4ed7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1162,9 +1162,6 @@ static void kfd_process_wq_release(struct work_struct *work)
 					     release_work);
 	struct dma_fence *ef;
 
-	kfd_process_dequeue_from_all_devices(p);
-	pqm_uninit(&p->pqm);
-
 	/*
 	 * If GPU in reset, user queues may still running, wait for reset complete.
 	 */
@@ -1226,6 +1223,14 @@ static void kfd_process_notifier_release_internal(struct kfd_process *p)
 	cancel_delayed_work_sync(&p->eviction_work);
 	cancel_delayed_work_sync(&p->restore_work);
 
+	/*
+	 * Dequeue and remove user queues because exit_mmap free process memory,
+	 * it is not safe for GPU to access system memory after mmu release
+	 * notifier callback returns.
+	 */
+	kfd_process_dequeue_from_all_devices(p);
+	pqm_uninit(&p->pqm);
+
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
 
-- 
2.49.0

