Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA546C79F9E
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 09:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FDFA10E75D;
	Mon,  7 Sep 2026 09:50:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mL20xcQE";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010035.outbound.protection.outlook.com [52.101.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8D8F10E74C
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 09:50:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkhBeTIMNUKcTqPTneaY/HgMy2Su3jiXaIoBInP5RWKAKDXc7lnxxhsrWXUk3gB//8ogjWM8Z86qMAxhC5qd2iFdvXbFL4HxOkgcGMd3Rd+wLheT+tYhbC4feJHRhQT6Dd2wYwHqVU2BZmRmzjQ5P2DSzAcOksJYo12f8DXEIvR/9chNrgqBc8E+IiLBWTTRNEA4+2C5aRVGishdoYpJ54IoQrhIN5dojh2EchT+08H0uPvscHPmwa092IbkcafmuMR257bSjA0ZUSHszGtGOfc12SXohHToEdqm6y360Dqo3DAaQe0FEh66tLEaJX5wx6XB+1rm295/Ihw85j6HYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSIUKF6fe8VwdrqBGYVLAZMow1a4E3PmGhP6B95DzvM=;
 b=ReUhPMjauynP4H+PFITcX3N6DpEBR6bCadK3dB576An5EUa7v+PfEqekooMv6l57xum5boQC9QQic0AQovjjTdKCI7yGMgFByGglK+v2p6hciZFPSL7oy/D12PlKT7Gdro48w2T45rx4oH2wJjpczAtEqbSK+035PM9ChcqKTrDlQGVmzKpFIFOeJQDZIi8OeAw1SOsDwPJ0xN4TVp6oNe2a74g3+goh4+1uetm9lsaxiHBtD/DfOijB/2xPSsv9QbIhVQQncBFhtp8xBxMYnEiFUjCDGOyxuFBR/+S72sw1A/61tBaC654MaWnsG1qSfi/y0zEhQx79QgMv1UFcaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSIUKF6fe8VwdrqBGYVLAZMow1a4E3PmGhP6B95DzvM=;
 b=mL20xcQE0INMJkzIyOlXBH7drZ7M9uM+Ak7PNowrnBoPin2CTNks3ZUnoVOg/io9p7m3bCTfyW7pwVzKudlF0Qq4xtgnj0zaifJNwVLZvehbag3Ef0K3kQ0rEiyun7dojF4/QWZ6Ey1l1JDIZsPKBpqtnvPd2/Ac5tHSk+zWroc=
Received: from PH7PR17CA0028.namprd17.prod.outlook.com (2603:10b6:510:323::8)
 by IA1PR12MB8191.namprd12.prod.outlook.com (2603:10b6:208:3f3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 09:50:20 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::11) by PH7PR17CA0028.outlook.office365.com
 (2603:10b6:510:323::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 09:50:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 09:50:19 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 04:50:18 -0500
Received: from jenkins-5800x.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 7 Sep 2026 04:50:17 -0500
From: Horatio Zhang <hongkun.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Jack.Xiao@amd.com>, Horatio Zhang
 <hongkun.zhang@amd.com>
Subject: [PATCH] drm/amdkfd: allow 255 queues per process on GFX 12.1.0
Date: Mon, 7 Sep 2026 17:50:11 +0800
Message-ID: <20260907095011.1223820-1-hongkun.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|IA1PR12MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c4017dc-d624-4caf-fb90-08df0cc56dac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: K8gEEGVgqYQK5qXYb0JlipRr8mTa1hcwSzh2fj4mE1NFVKEwgOvqDuWsNPKFyR8lhop7ZyzI1hZVPkUzAgYNlwXUnNAEe/e4ijupz3I0niM5CBDusK3CbGcBqev7cbpOuyyy5hmv9DY/qjahZ5o2DjItxE4PJ+gA5xqdpHu95QsSJz0JNgIYOIZ6bcKjyqa8O/JSMKqeIlHa2CJkJyc78A1kClh810K/rveKeVe+HntDGv9mgP+GK5S3RLU2L4qeKvZkvlgb3CQ1sQHwIjJ3e1QEFp+q9E/laHgz1L39Sqt9qoa1ICGgh9gyTGPU5AhT3rCyu3R7iDcY1EKBmB7ZbKViULJnZ+09Q+YC+ImisrxN9cqq23inF5GPPL7QWvWZUDZNjbmrOn2ur8OInJ04BtAaWV/RtK/pHbX8A4xv1Wnn1IkS3b9q91jrfkZFD8JHNTa9j0HMJQ9g6HxBKgHaJhjttLT5AbnSxXf5U1apNNveSR5z4FHat5J7bV80qNuIvf341JDuK+FDRblWaOFOObQC4ppcVNIiou1OLDUN7ArPcd1F0nByAU107B+u3S+pXjoUeCCrfABgZ3nEYqOLI6sC5BLoF6YQfg8wK/2P0gYWRp8sxcmaWJDoDu5geWP8Cw8mcf7Al9OrdYAKkfpeyktrZGwco49D6s5BcVUIXpOFjKZyqRl+ls9C4QJ27AQs0/HeTHkODSM2ItgbiHWSNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kGOATOuHFiRX5cBTRkhjBUn8CqMVJL5ZGmUII08KOxuWX4Xfxxb6XHUXnJg78W4x9IhlcmNJBsX2GAnhzkVc1k48tjAjFxcTikY7D4dgiA6Cf75tcJ8/0RhjES8XpRB3M4x26SY7iPyopH1Htdwperzi9AmzZcolMinjnrEQDgt9X68Bv8iXa2XcLRmJXUaB9yfwtyWKQX9iUMuzoh/IHoSbTekal4MiFyA6+8c54wi8XJYKL3wM3aQdKuWmnns1cKfVTYvs1TodxA7XGR2iMBmfRUqe348c+mDCmVbhDL5wVlZJVLaQjwfgc27zDsx20ukNr/GRdtcHWafaJSGaZuXvVfbaVj3mi0CXx2N4FoIV7RY1weQ4wi4LbBKaO7pnd8CVAwzDFz+dsjdabf7PSyGoeSWcSRgbmQVGg/KdE1UhEx9AWARSKxTrFTvCj1L/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 09:50:19.7175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4017dc-d624-4caf-fb90-08df0cc56dac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8191
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

GFX 12.1.0 queues are managed by MES, not by the HWS runlist, so the
127 queue limit does not apply.

The topology advertises 32 CP queues plus 16 SDMA engines with 6 queues
each, so creating every queue needs 128 and the last one fails with
-ENOSPC:

  [ RUN      ] KFDQMTest.AllQueues
  KFDQMTest.cpp:365: Failure
  Value of: (sdmaQueues[j].Create(gpuNode))
    Actual: 1
  Expected: HSAKMT_STATUS_SUCCESS
  [  FAILED  ] KFDQMTest.AllQueues

Signed-off-by: Horatio Zhang <hongkun.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index fb2d8ad9c2c5..a15a826519ad 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -339,12 +339,13 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 	unsigned int max_queues = 127; /* HWS limit */
 
 	/*
-	 * On GFX 9.4.3/9.5.0, increase the number of queues that
-	 * can be created to 255. No HWS limit on GFX 9.4.3/9.5.0.
+	 * On GFX 9.4.3/9.5.0/12.1.0, increase the number of queues that
+	 * can be created to 255. No HWS limit on GFX 9.4.3/9.5.0/12.1.0.
 	 */
 	if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
 	    KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 4) ||
-	    KFD_GC_VERSION(dev) == IP_VERSION(9, 5, 0))
+	    KFD_GC_VERSION(dev) == IP_VERSION(9, 5, 0) ||
+	    KFD_GC_VERSION(dev) == IP_VERSION(12, 1, 0))
 		max_queues = 255;
 
 	q = NULL;
-- 
2.43.0

