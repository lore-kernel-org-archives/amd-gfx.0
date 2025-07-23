Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D15C83F17
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jul 2025 09:06:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB74F10E0AE;
	Wed, 23 Jul 2025 09:06:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IQK4FqpH";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2307510E0AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 09:06:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMVlxicJKIJD+Qt4lkzsN4SA33HtqX3udRLeNcvt+3QVrl6WM/t0ijwtMSvDhvnjuLdU7BlfytdPagr9YLgRVWd2R2tvCordsIWKeUC0zp0Z5AgqlQCD3o+iKE2XCsfZLNekiEpsns4pj/j6pPQHdQhIHB2EOxW33lbYXV0hHGo0UjMR9BVHWCD4/ueM9qTtZOCpx1nPuXj1xZc3Vji5lZWUrKlo0ocFdAvL4yK7LKC6rhWJc3NwrFqG8JBhf98HPuDK53oOksymmUae4Slx3C7X0Qkgx5b275oSzyr2fTFX69HE7v1xi1VM4x1/I+UaQby2GRaI+/kVXFrM/1U0qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEk49WaI4J0nNiPbmwht8Vc9qK82qn6yyNAD8Ma9Dcs=;
 b=uxa6/tjkb1Xr0rDSfO93jCWJI4ymODAt2tGkFpNcJkPAzjG5vBPhmamfkRJLzsJOAA4RtRHZrHdSqyueVIbZ1WyFcqvx1px7D+0h2yOeZVyMGnPICEN7mktdEow7toiOcpLOcESh8+AijYgxt9WveyaZd98v647aF7HxawGbNMTklXBMm0laf1JX7NfwNbBMvTXs+1kWA7PYnckd+1A/Y+8ZteWGz93wj3Vm8D5qKTel1SpqjkGSK5DTN7ngqYy9kk/pwWvgzoBu8Qanmhvkob2hZXLXtVY6/RFrfaqUgQw+sRANPIfDrXibuzhY5x45RCUCM0KfD3THZvZluvfWtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEk49WaI4J0nNiPbmwht8Vc9qK82qn6yyNAD8Ma9Dcs=;
 b=IQK4FqpHOV7t60fVQF+n4apgrz2r5V1//q78KrgGHLDv84AlYXz6/rSDgLaFSD9hRxo3Ucq9Idk68qMUdCK3txqcQvJLvhaNMwKoGB/Cks+r9K5UY23ZjyejtyucRL0FJXUC8x5imoT/+t4JrmEw5UjpNwz+ZMpXIuJ6upJo5eo=
Received: from DS2PEPF0000455B.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::518) by BN5PR12MB9488.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Wed, 23 Jul
 2025 09:06:40 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:2c:400:0:1002:0:7) by DS2PEPF0000455B.outlook.office365.com
 (2603:10b6:f:fc00::518) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.7 via Frontend Transport; Wed,
 23 Jul 2025 09:06:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 09:06:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 04:06:38 -0500
Received: from mao-Super-Server.amd.com (10.180.168.240) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 04:06:37 -0500
From: YuanShang <YuanShang.Mao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, YuanShang <YuanShang.Mao@amd.com>
Subject: [PATCH] drm/amdgpu: keep job->vm in amdgpu_job_prepare_job
Date: Wed, 23 Jul 2025 17:06:24 +0800
Message-ID: <20250723090624.53536-1-YuanShang.Mao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB05.amd.com
 (10.181.40.146)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|BN5PR12MB9488:EE_
X-MS-Office365-Filtering-Correlation-Id: 8752af13-a2cf-4729-c2e7-08ddc9c83bda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FB7WqD8fyUi4UJim0WPlHNS0yjoVNJ7H7gnP8FtEyOEKh6U88yFgcIW8RoRv?=
 =?us-ascii?Q?KB3EUwnfBNqX8N5EHw8660m3lXRMWRF96h2QALXv0vLz35pwRQs/I6DrEaJQ?=
 =?us-ascii?Q?LAZIbb9xHPA+I+0/q26+z9J09EPkI7dGFusg0Y6rFbRlnAGXemZU++TzzM2o?=
 =?us-ascii?Q?xCT3tx0mtHB2R3SeoBfWSGh4KpfCfkjyhVMikg5bb8YRWV/NV0nXmSGK8qSB?=
 =?us-ascii?Q?RR7bMpHjyQRFs7pyT5W0mUhfgLvmWA1fkjNt2CuBF/lJuLTJdQbWja1rti6a?=
 =?us-ascii?Q?Z4tv9vWRWS7Aejvs/gPaAu/IKj4UueIF6zpClFkgzmMWqxpnvUMkQOmJPEBu?=
 =?us-ascii?Q?XIMQiG/SCnmeTQE8VXRxbDlgK/lYEN886n6v0iwox+GZl2N3Me89eXYooGzG?=
 =?us-ascii?Q?GE6lrNN1ZbBehyxh71z+x7JTZ/m5qu4BZx83BghS3EeJde8YcAjBdC/clrs8?=
 =?us-ascii?Q?QYQvewHjTIptJvakq+ooii2p9qkXzL4//jm9Xto6q/dh4k0QBRmBEiL6fo4o?=
 =?us-ascii?Q?naPNSI6F0g9KnLXXNgGd7oE/xpzslakgt6xBflBW3kA9hXeUmuR1XNXKQMg+?=
 =?us-ascii?Q?/ngTq0GLKpkXihiNE/PcWjKMKbSBj7/+YUMrifgveRYrNIGONZt3mFGfQ1Zy?=
 =?us-ascii?Q?0ws6Vj1sVxmj7MswP5y5gVT4S5CsTKi7DeEDD7A8Lh1y/4yfX5E5c3QbKcpf?=
 =?us-ascii?Q?JNGd0GdxYcV2xWkiT0eyKUxJZDO4hzrE/4qMuExf4G2xxRgvbh8CeYEFuzdY?=
 =?us-ascii?Q?iXwf339U5Z2QF8gGB8cVyrRiV4Upiaz9x9FSSmiw30gPlL6VRdMznYRwQEeN?=
 =?us-ascii?Q?CjraIICn5OqRmqVEJjk4eB0QWNmdQstoySzDlC2aBhaoHyGyJ4n00v7mSvoi?=
 =?us-ascii?Q?Nams7KdonBulI6P/cnDxTmVGKC0RK0swRNBkfJUtXIjeIJdjcmHGj83+wfFZ?=
 =?us-ascii?Q?JervoHMTNlYi+0dcMVDnsLupgxF00CMS6O7cf3dGrQSMY6M3USxH7OJvGVG5?=
 =?us-ascii?Q?at8sgCgqb5lexAdZeIRFxFGg5Z0svErJp0cN/JekpA8gcFkdok5BOTAYGMKa?=
 =?us-ascii?Q?pKFjFMQrU10tDlTDSkTunQ5TjIFIg6d7lCxkQbzFGQ/zO0SNiRbVN2QHUI/F?=
 =?us-ascii?Q?shnash1U4eoPccUVaSiC4+6J2HhTY9XVy8catiimSUYrHoPGt/dlDTUbPrXV?=
 =?us-ascii?Q?fZEgjxs7ffb6uRRmEXZNuDhWF9l13rHwzrdE1iiyRld3UUechVKzkwE/Xpeo?=
 =?us-ascii?Q?GOVisiCTnu9CnPUkere43FbQb1QeqynHC2IN2OwtO3gn257O2hPjZN23vNc1?=
 =?us-ascii?Q?fwxgmSln33kj2zctG2f8N0nXVCMw2rMGdu3gJTd804ySbTll+miEBIpjC3rA?=
 =?us-ascii?Q?tCeIyeLyDpkPABmPVXOfDwWjVW+m7d9dBbwTMd01nsoz0P4rfH7weuMnBrD/?=
 =?us-ascii?Q?Asvrhm4luV3oJMpDXvDhogByLMo5LZ0gZSqez2YWVtStKb7XFa7u9WIreyW9?=
 =?us-ascii?Q?JBW5TyVPgGAGb06JttJ05tkGpY2sZ1Fk8F+s?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 09:06:39.0506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8752af13-a2cf-4729-c2e7-08ddc9c83bda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9488
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

job->vm is used in function amdgpu_job_run to get the page
table re-generation counter and decide whether the job should be skipped.

Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 45febdc2f349..18998343815e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -360,13 +360,6 @@ amdgpu_job_prepare_job(struct drm_sched_job *sched_job,
 			dev_err(ring->adev->dev, "Error getting VM ID (%d)\n", r);
 			goto error;
 		}
-		/*
-		 * The VM structure might be released after the VMID is
-		 * assigned, we had multiple problems with people trying to use
-		 * the VM pointer so better set it to NULL.
-		 */
-		if (!fence)
-			job->vm = NULL;
 		return fence;
 	}
 
-- 
2.25.1

