Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF69CEBF78
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 04:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B90F10EC0F;
	Fri, 27 Sep 2024 04:58:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1BiQ+Hpw";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82BA110EC0D
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 04:58:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdrOXGsgwTXOzpCSHtPg1NT0jHtU3iCeUB8EuJCfHXxW2qWt/zKHxlbwyHT7pHE1/ALP8FFj/1RtoV/9JvnPb4URdH7Gq59CzqeiBgy/cvSKYkrC79F7OcwPyTD2lYtKARgVLLI9M5Il6JLnQOu/Zef3utKBt4eR/HWxsJOv/1Ca2T/YGQlZV19lcUq3xCarjnMpzecoHLdzYhmd7BYdDEASDXEjh2AgycR6yLjOa3yfUYOJJ3uZhRCwW2TYxzlRn/02KrM3PvzY2bJbZYJlJRkgCF8huMnt/0Uk0/CuFug0piiTnNCA+3iRJBvu1RMD5x5X2x4go35q3SEUnE3p5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44uHodzQ5YnoxZHl5XLE89Yccm0QTI360GzcxGsB6+Y=;
 b=U196aollC2T+DJDH9Rkj62Gcy+f2mJmGEqGkkznU8r9cr22F3kH96xpboFETZ5Fy5Jau+w+A+2eir11pOBOJMe3Wd8GzRZt6MsoyL8SDbJzLFdwQvmpUyb3vS4ELWLTaOEFNlsBvSkTKq4GkLmOdP/8iz3obIoptiYkVA+Mco5wzJZxCY9tcP68Hq18G53fjAwHdJbEnH7shlqa+ZQdWFjyLxMgDd+RuCP2ZAnJMdhShhsKhJNEpwToZqC9zdva18qtEs6IS8p2Qg8okXe2DY3hoCAbb3ZuyCADyyA5FTxmQ6sL2savGWIPp7m62y5ucvI5NjV4kENk7+mhEssLlCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44uHodzQ5YnoxZHl5XLE89Yccm0QTI360GzcxGsB6+Y=;
 b=1BiQ+HpwR6Y3Q/wonGWLyEdXIY8XRpXFVsdPVLP8gwDss3oMc4ZUS4HOO2FKpPZ0XOajz5T2WGgJtY5Eg+7AGnHmP7AeQiGULTBFWv/2Kj1IOqZs+NBGiTTWqrUaZXWVvAx+QO3RgUHiR/trTMjHjXvg+z2sctbrhPQMqLFONPA=
Received: from BYAPR08CA0065.namprd08.prod.outlook.com (2603:10b6:a03:117::42)
 by PH7PR12MB7020.namprd12.prod.outlook.com (2603:10b6:510:1ba::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 04:58:11 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::70) by BYAPR08CA0065.outlook.office365.com
 (2603:10b6:a03:117::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.30 via Frontend
 Transport; Fri, 27 Sep 2024 04:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 04:58:10 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Sep
 2024 23:58:07 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <rajneesh.bhardwaj@amd.com>, <Ramesh.Errabolu@amd.com>, <Feifei.Xu@amd.com>
Subject: [PATCH v2 3/7] drm/amdgpu: Add gmc interface to request NPS mode
Date: Fri, 27 Sep 2024 10:27:39 +0530
Message-ID: <20240927045743.2718949-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240927045743.2718949-1-lijo.lazar@amd.com>
References: <20240927045743.2718949-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|PH7PR12MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 38407328-62c9-4172-8a8c-08dcdeb0fc46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pXpKL6a04sWkpenlZ6mjBx2X+Gupzv4z7ealnPFFx8QhyAdmL4Aqg5WGFEPW?=
 =?us-ascii?Q?Ggp+Vgl0HvY6DS6tyU/fXL5G0geuShrqj9sYTYZUYpL64ysmafGAywujbo/q?=
 =?us-ascii?Q?NbavSU9e6aOK911Bxk9I8VwHYQHByO7vBDRoyHjlU+DbMQ3iGK4z3MJawizF?=
 =?us-ascii?Q?DctFC3rnzOE2DS73ZOk9ezvdEnRoh6NlLh35dtQIqHsVBhaK7I0JZwzwyNfd?=
 =?us-ascii?Q?l9qJE+VSBEzH5witNtDnEN8hypN+rtaPaVYR6SpIJIukKPPnAS0V+gJH8qmL?=
 =?us-ascii?Q?fIixkFsVy5dqyR+vUl/CAOc+mjYk3aCbH2jVrL5Vmiu8fN8FJHutwPyyNCmp?=
 =?us-ascii?Q?e22dMwAjri1E7ru4/97b8+fOunFn41F5f53RciM7NIEfseakMWJbn6itMyWF?=
 =?us-ascii?Q?lEq6hp7YxkkmalYJWclAsAxv5bzwSGD0J6B0hsH/wJrnofcl1Jg8BrZJt/1i?=
 =?us-ascii?Q?/UZ6JPTEqjzKqkS533/y79n/fccmqI/NSFaJoSXPzS16CpE0tH0YQpPo2Izs?=
 =?us-ascii?Q?XYJam0McwLb2N6OKvn+odZOF/Z5kpNBU6/XrtmNvq49g4MVqt8YF/ShBD3oa?=
 =?us-ascii?Q?Bk4tHDlDVcv6FBoO8kFOXL0TzxmnwRfAWpLV7wzzOZVdTeC0J/YaBHfOo4HV?=
 =?us-ascii?Q?4XqLJFq6reOkrSpxempqCg3POuGZzy+UQrrabKQZsUf4wRmYrT869JCUvOCN?=
 =?us-ascii?Q?XFj779pArjH4ZsT56hm2wps96fs/o5Vipo0jM31IJaD+kWE+ar5tC2B/rfSK?=
 =?us-ascii?Q?9BzQh7jvutTEhOKY2WWI2hJghut5Yg9UjmA4yfZLiyrEA6VgAQTv7cd2KdCi?=
 =?us-ascii?Q?veCaVBvhnQfOc1AB1bfzvBFsZ+KzTV38fuQ5rSWhiFkZHjEl+B4e5HRwBTIj?=
 =?us-ascii?Q?nYDvvpcFfqxmn8MFtNfFTeSnqoR9NQsZdhDeYzpS3ROWyVFbBw7w715T/7H9?=
 =?us-ascii?Q?wGJa9I/F/w87ZCcZHNEPY0pkOqHvfcSyO237NJ+qW+329NHdkm43PA24i6MM?=
 =?us-ascii?Q?UHLHndZBhPp5qD5XJVSw6boVu9UqNCJZjinyYtoVUYzdhPLz1kC2zAmKyloE?=
 =?us-ascii?Q?hAXH3+vPZ3PrNc98LFscPG19pheaw26FeJgGU1MwtoQRo88h3xU9Ji+nDt/O?=
 =?us-ascii?Q?Co6pN8xoSyblrpE++JUXe7EMnyiNseUH4zI9/f97C4ywhIYmlgoGBv0T2sO9?=
 =?us-ascii?Q?fwreVLEZ8StgoQncfHxH36rLp4Gkhyg9v8JBpUbcsXbbwWUr0/GUyL4J448A?=
 =?us-ascii?Q?QR+ZIbsjChJ26zxDOjai1Rs4rF6pKHwlqrVxVzH9LC2R5qrlKcsBr6mCjfEy?=
 =?us-ascii?Q?gDAZZxT6qmXryjbZULufBXZ9/kd7W7F1LmcG11N7vK0k0qoxv696mDtyrVNH?=
 =?us-ascii?Q?7k4+kezNSalMPaqVL6Y4Ng0G5MSS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 04:58:10.6453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38407328-62c9-4172-8a8c-08dcdeb0fc46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7020
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

Add a common interface in GMC to request NPS mode through PSP. Also add
a variable in hive and gmc control to track the last requested mode.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h |  1 +
 4 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 4f088a5368d8..758fda4e628f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1247,3 +1247,19 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
 
 	return ret;
 }
+
+int amdgpu_gmc_request_memory_partition(struct amdgpu_device *adev,
+					int nps_mode)
+{
+	/* Not supported on VF devices and APUs */
+	if (amdgpu_sriov_vf(adev) || (adev->flags & AMD_IS_APU))
+		return -EOPNOTSUPP;
+
+	if (!adev->psp.funcs) {
+		dev_err(adev->dev,
+			"PSP interface not available for nps mode change request");
+		return -EINVAL;
+	}
+
+	return psp_memory_partition(&adev->psp, nps_mode);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 33b2adffd58b..f5be5112b742 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -161,6 +161,9 @@ struct amdgpu_gmc_funcs {
 
 	enum amdgpu_memory_partition (*query_mem_partition_mode)(
 		struct amdgpu_device *adev);
+	/* Request NPS mode */
+	int (*request_mem_partition_mode)(struct amdgpu_device *adev,
+					  int nps_mode);
 };
 
 struct amdgpu_xgmi_ras {
@@ -304,6 +307,7 @@ struct amdgpu_gmc {
 	struct amdgpu_mem_partition_info *mem_partitions;
 	uint8_t num_mem_partitions;
 	const struct amdgpu_gmc_funcs	*gmc_funcs;
+	enum amdgpu_memory_partition	requested_nps_mode;
 
 	struct amdgpu_xgmi xgmi;
 	struct amdgpu_irq_src	ecc_irq;
@@ -455,4 +459,6 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
 				 struct amdgpu_mem_partition_info *mem_ranges,
 				 int exp_ranges);
 
+int amdgpu_gmc_request_memory_partition(struct amdgpu_device *adev,
+					int nps_mode);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index b17e63c98a99..5d721ccb9dfd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -667,6 +667,7 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev)
 	task_barrier_init(&hive->tb);
 	hive->pstate = AMDGPU_XGMI_PSTATE_UNKNOWN;
 	hive->hi_req_gpu = NULL;
+	atomic_set(&hive->requested_nps_mode, UNKNOWN_MEMORY_PARTITION_MODE);
 
 	/*
 	 * hive pstate on boot is high in vega20 so we have to go to low
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index d652727ca565..67abadb4f298 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -46,6 +46,7 @@ struct amdgpu_hive_info {
 	atomic_t ras_recovery;
 	struct ras_event_manager event_mgr;
 	struct work_struct reset_on_init_work;
+	atomic_t requested_nps_mode;
 };
 
 struct amdgpu_pcs_ras_field {
-- 
2.25.1

