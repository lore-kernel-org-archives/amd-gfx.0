Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697DEC5CFCF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 16:19:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0745E10E172;
	Fri, 14 Aug 2026 16:19:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S4CRZCXZ";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012007.outbound.protection.outlook.com [52.101.53.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A61D210E172
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 16:19:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHTKVfeQSXIZiykyEgMtKHgZC8JYvQbZU4UPDRwAPNU/AML8oHxra1BExtvIYYff9jqS2V8VhAOX5eJhQGEdI+2Me2mSg30zwCu/P2fc8GyOaayMmkfmhRY2w8v2uf33K8kJ/k3+F0R5rkU66EdR/5Nv8kdBGjOxFVEzPgMU+m0Gi8FEV9OAzj+q3JcOK9eJylU2Vbiprh7UnskTUvEETHNbYasxCg7QrpxPawwZ3upS0k09CzPfWYORgXxwKj31/1r5T5kO9vcfl6dRROmKweuieUi2E+kOQZgC7yTCCEYK5HHD+rfa8NxnGnFkX9A36H/3HV0wP4C89RdfzgLyvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6LjGh3/Tb+jXtvEOal6cSn6/SJo/eq2wBqPXa2KFaM=;
 b=Ffsh9Ppza9mNUvNFvFk9sEd4ijbLWA764WvSUIS9uYtB3GWurvjRoYAy2PDGa99nmQLp3Hms15/msZSWZV4s3I9eWqXyvif8GVko+L6QUUiWGGOJTJ/a5n6I3eMOlEQuWQXtAo4rbLlXE3OVQnBgYiwhIuPatUq+BsgNyFh2CBfJPwNK/Y/Wg/Wkpu4aaYhJZcKpOxI3TUerOIMCBjhn8ezulsyMwO0h2f1JEQS+8bekNUvk3FbBHPrDnDY6Itq60qf4UjGKoBf7op2HGsesnPUrBRwVog559fTCBEm5NrOx6hxS364gO+IGkCmp0aX95nOPszThKmGrrZjkRH6jeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6LjGh3/Tb+jXtvEOal6cSn6/SJo/eq2wBqPXa2KFaM=;
 b=S4CRZCXZfqghgwISyLN3/8wpLS8pqyqIdihDIM+zPF51RxL1bQF3CZlCzJyls1cMDuMY3ExwcyCdP5G1SiQ03jHW+CCKuTftaJbVL1l8e+YSL7ZwdZWsCzT6Zaarfk3unJoZp6GaXk/8cHBZai6ywPU5Z7YE6zqrSY6aWNlK0Qc=
Received: from SJ0PR05CA0130.namprd05.prod.outlook.com (2603:10b6:a03:33d::15)
 by LV5PR12MB9778.namprd12.prod.outlook.com (2603:10b6:408:300::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 16:19:00 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::7e) by SJ0PR05CA0130.outlook.office365.com
 (2603:10b6:a03:33d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.4 via Frontend Transport; Fri, 14
 Aug 2026 16:18:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 16:18:59 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 11:18:58 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 11:18:50 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Sunil.Khatri@amd.com>, <Felix.Kuehling@amd.com>, <Shaoyun.Liu@amd.com>,
 <Lijo.Lazar@amd.com>, <Mario.Limonciello@amd.com>, <Christian.Koenig@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v3 1/2] drm/amdkfd: Add TLB flush after MES queue
 eviction/suspension
Date: Fri, 14 Aug 2026 21:48:39 +0530
Message-ID: <20260814161841.5906-2-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814161841.5906-1-Priya.Hosur@amd.com>
References: <20260814161841.5906-1-Priya.Hosur@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|LV5PR12MB9778:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f12211d-3a4a-40e2-72a0-08defa1fbf4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|22082099003|18002099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: sKPP9LgiKlXprB6l2hYJE/fyAuno+Hy1w91ASoQ49gL5BcQKx22+18hoGzrjhB9tot7nFRCoIaFx2p4f48H1MHj8+RKZCy1S3MPnO5R/4pkD0jdqFOc9Gj58MIGJxJxCM/ZOcx+LCI7Hu6279aMCrpz+HtYbXVFZdrOk3DExRfUWfN3A1iSepoG6N2dyQjxetdkpCm3ApUxyDRw/bd8vOJkahkDjmh2CmNq1jJQiwUwRCMRefNz2GNUP0RxMBAKJm4KnoogEC5+OyJRhqPMI3RMj+/CvRSm+/mZ3VF86qBFQtpgmEifya/+TYt7y1nwz/QR9XIEBXdTzr8diMK6WBPV3rbQJHlnVN4laY0HvcbpMjslab2s8vtW1ly6/geNF1ESoASYskm0Rmz6iyJFlw0HbPrS8pxbzMTlLPurjbbsrslQ3UFnKzsTWLTPKvIy1FF7lE7sErk1Ry4nh2ULfcpRS0QTB7sOsBhbGfNrcDSss6iAlLjJ3KECvavL0zr/TBHns8gWJOolFbrvyNHGOpnlZcNPrX9PUkLHnJQDMu4OA7qg6yUrfuWruKYqYele1NW9YecsZFtI88VgIOkZWSfPb/jjUtk+K23dvbhjPMtwEGv8SvmpdcW59MOkKQl3mucfYhoFpxbz5qu68gRF+8qzLc4s6sQAmaHE3eE+eBLlF/s8aD+5JAOiPqkEc0BduauYFlBM+H4vFngMho7l+yw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XrSH5eE18l89n538UJ/f/Sjo+iLxTBI8Y2a3ORlNe2gG8VIaKbO8XTkw9uHP5Ex5mEVlTqPpWCAFKK4FYGt0ZGW4MqLrqg3r42Kn7KDS0l8YbtUmRc2k23DUrtosXVQnVtUHNE4cX9PgigJg406ip31w6Gt0ia+/0E6A0NJQa66jFA7Fh/GeW0Dul5pnsrxmvyAKNK6Udvw734CmoYtiC7tsCZBxM7zOjPJJm61CX3r69EMs44/lYme0jb5xcO8uOEON5PHv3HbUGMSiEMIjO2TchfU1Ky7yGq6AwASo13LtkFeJY8brMwCXlisQ4KlrJDWvSd1l9W/KSuwfHckMNNUYco3Hb5opSCnBQPBg4Ztmj6ObW1AEwdvc8FVoOlK2DonC3sI9fy6IAyH+NQw5k9jah50wbJlCgva0bipvGMKJqD/kGlEJETb+3YlzeYMf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 16:18:59.2352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f12211d-3a4a-40e2-72a0-08defa1fbf4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9778
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

MES (Micro Engine Scheduler) does not perform heavy-weight TLB
invalidation after unmapping queues, unlike HWS which does this
automatically. This causes a race condition where in-flight DMA
descriptors can access memory that has been unmapped, leading to page
faults and GPU queue hangs during SVM page migration.

The issue manifests as KFDSVMRangeTest.MultiThreadMigrationTest
failures on gfx1151 (Strix Point) with XNACK mode 1 enabled - the GPU
compute queue hangs with packets submitted but never consumed.

Add kfd_flush_tlb() calls after MES queue removal in two locations:
- evict_process_queues_cpsch(): after all queues removed during eviction
- suspend_queues(): after debug/criu queue suspension (with mem_fence barrier)

This ensures all in-flight memory accesses from unmapped queues are
flushed before memory is freed or migrated.

Change-Id: Iaa884d4a7ad1199446bc45f4ad8a9a179ab386e6
Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c   | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index a23384571193..6002c8a65fbe 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1450,6 +1450,14 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 		dqm_evict_mqd_bo(dqm, q);
 	}
 
+	/*
+	 * Heavy-weight TLB flush after MES removes queues to ensure
+	 * in-flight memory accesses complete before memory is freed/migrated.
+	 * HWS does this automatically, MES does not.
+	 */
+	if (dqm->dev->kfd->shared_resources.enable_mes)
+		kfd_flush_tlb(pdd);
+
 	if (!dqm->dev->kfd->shared_resources.enable_mes) {
 		pdd->last_evict_timestamp = get_jiffies_64();
 		retval = execute_queues_cpsch(dqm,
@@ -3736,8 +3744,11 @@ int suspend_queues(struct kfd_process *p,
 		if (!per_device_suspended) {
 			dqm_unlock(dqm);
 			mutex_unlock(&p->event_mutex);
-			if (total_suspended)
+			if (total_suspended) {
 				amdgpu_amdkfd_debug_mem_fence(dqm->dev->adev);
+				/* Heavy-weight TLB flush after MES suspends queues */
+				kfd_flush_tlb(pdd);
+			}
 			continue;
 		}
 
-- 
2.43.0

