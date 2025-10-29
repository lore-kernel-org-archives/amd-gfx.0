Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC456CCF9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 08:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AAC010E75D;
	Wed, 29 Oct 2025 08:48:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iHbhiMpN";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64CDA10E75D
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 08:48:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZN86GIm9Q4LPqHYomgXXKq4bTRnz2cthwJ+ZpBkBjY7qjLbJUGnBzZxiHP0ePQYvnL6j/WyOtf9w7233mekBsFacskw/CMZXbYTPGj8BlDRUmNmo7KRuCPQWc0emoewS5vRGZUTM5Ia46KFG6MhwqewRRAM3pNzJYLeSuD3DVLDik+UIM++Re77waHbwGw3J3OUiiZm8cRr+H6CXm6f6HiHqoBFh5SSPTJniR2pIXzbxa1+8TBnCulFdeqScMxUzBnIKWFjSgZ7c8Z2oU2Lkh0gcc+orQkE4kLhLe6rpE14On+R484Io2b4mleyCqznHLNkae0lHnmdH37xJIEK4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igRx3XsWurPNQM3SpJ4pNTGyz0hqQaja/V7NJM/yXi0=;
 b=NCpCwqVlEZvPiFzJ/fJFAAIATKfDjshoEFSLkch5pzzTaJpHcjxd0tZE/n2WbSNYBvHDKxByuS6hZ7fhcjOI6jjVVSmU4vqiNuZY4NaRfQOkCpdrzpLU1/Rk/6rPosK57XbYXyLlwG6+gBhFOdnimO22mL8zklYUikdQr+RXGZ4tVf+PJcOuDY/hodwo48CPQ1qwIlny0E1n6NTQfRzNiwmef3uPKYA912kKZ0YPnTuNMf8fGJoopnP5APVmESpzz+pj6EyX1GSs7/xci4skzQyNJlulvMydhn/Ln9uMA1x4VGfJ2d61PJn/bY06DygWiNNRxwB4oEuTGOC7M0ZFpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igRx3XsWurPNQM3SpJ4pNTGyz0hqQaja/V7NJM/yXi0=;
 b=iHbhiMpNNc2um2YbdnQnDpqdLub1szIPrKEm4/lojeQ63HiFb1+wBkEqNWWQ2uhDhpbkM/ZO2vRfzlxbaxinIBQBE75qGuP2fXe8lrpXOWnYNGFGZ1qtQJtHslUTDY/uejb7lYR/Lx5FwUsBoz7Qa7c2VbiL4unLrFBpNgjxKM8=
Received: from BN9PR03CA0668.namprd03.prod.outlook.com (2603:10b6:408:10e::13)
 by BL4PR12MB9506.namprd12.prod.outlook.com (2603:10b6:208:590::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 08:48:15 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::98) by BN9PR03CA0668.outlook.office365.com
 (2603:10b6:408:10e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 08:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 08:48:15 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Oct 2025 01:48:13 -0700
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>, Yang Wang
 <kevinyang.wang@amd.com>
Subject: [PATCH 04/10] drm/amd/pm: add smu ras driver framework
Date: Wed, 29 Oct 2025 16:47:45 +0800
Message-ID: <20251029084751.1701305-4-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029084751.1701305-1-ganglxie@amd.com>
References: <20251029084751.1701305-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|BL4PR12MB9506:EE_
X-MS-Office365-Filtering-Correlation-Id: a3a60b0d-3dd7-4203-ac05-08de16c7e6a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cf1EUGkFYVZEsT1gmP76ySNMC3+0MD1AAFhq3H3scHhLuqPYAT/RVmKYZnsW?=
 =?us-ascii?Q?kAwSiUGTOqpemJkXKTJLqvn4nUtyUVyYBqG7CYSIx/0fOktIppIYhv4FuX1Y?=
 =?us-ascii?Q?1ItJ37bmOgKZOG+kJCys7086b1Lxuql2CtkwPlINs9MGpbMAZmdPTyO/2MhA?=
 =?us-ascii?Q?HpF5HAc0Xgpiv5F/vMKCe9t0uUNlKEX2zbv4UY1I4JpU8CBOPkRU89K8ccjM?=
 =?us-ascii?Q?Tq8iN2vHQhIzKz0hZtuH4G99I/gzYy9pe6FS4KnThkp8ZtXE4IU8wd4FdGH9?=
 =?us-ascii?Q?E0Om/sFu6tQqivLFgqU8WprlmuRflc75wBUZY4rfsuCdJQWFK/MXTZpqpO/F?=
 =?us-ascii?Q?XXBeDaUP+srTTNYqhXsrmBFVHCfQMVrGW8EXxICdMTHz7RwM/tAureKunvr0?=
 =?us-ascii?Q?50G+NO9Gxg3TYrhaoPbvRhoZcYIjfS4Q2LenC4bTu6a6QF1xzTUBYMmZ1D+X?=
 =?us-ascii?Q?/Mo7vFuDm8d4bVgHdyuwXLps6OsGAGfydFjQwce1kJXx+knDDEYiwow5M5xv?=
 =?us-ascii?Q?3V1Rt+ADsABu72G6UGkWRPzOYy2mgnGsRltI+yfhcCndhYoBZFAbxcWEl1Vo?=
 =?us-ascii?Q?0YKRegJnNDU2W0HCgs07SiNcm9JMgi3TM5AXJsNcZ8IluSgpWNLH+WLbLJet?=
 =?us-ascii?Q?G3RXgI35FTOeIr2BW/zDPSMigSWJDO+13HxsB0rgNCaUz5zeA1w6v/ClEEnQ?=
 =?us-ascii?Q?QdDyfrjPIIa9uyvjkbl3qr5q/r30le86P7B0rZxI7qRXIEtjtOYEqyXPoo2u?=
 =?us-ascii?Q?VpUkhwYlPxacxjqQutPs4I0dc7JjkacmuYZ6rjc/Uz1G+ueoOtdLiT1HPPM/?=
 =?us-ascii?Q?UA/kOjjywJIrGDgB1ZSL9ShcNAWk+p4U0QXF8P+YEkdjODM6u6zNR70poeuP?=
 =?us-ascii?Q?x18Q2zNFOIuz+4M2En+lQV8giStf2JPcBOXsVD7imJLUbI5r8n4BaG1xuypY?=
 =?us-ascii?Q?Kay5DBhbmgsuk+wr9kkS/wKNbtEkp3j/VuRftxLURyoE8yQ8H34o64LAEz7Z?=
 =?us-ascii?Q?qdpSWf4FiptrksFmtm5ZzdppiP6bHi/ADrUYCznLm/I3mADy7zCOKLrVVgcB?=
 =?us-ascii?Q?3k1D4NfbL000n6Yq8ODFpwcjAjhGSiLxOFFc6T+Kf+j//fLhAwsTN4Y0gCMb?=
 =?us-ascii?Q?YPnSrQ6Da5L/WgITH/XZxUSL1iMAwoUIX8sTemL7XCqNVX0EyZKaf7MK7gpA?=
 =?us-ascii?Q?lL+EcyM3jhXngy3r6qOB0tqdtCrEmlIZD0+Ujj1wYlrBQHc0oGJfOe3NPOwK?=
 =?us-ascii?Q?X2/grjghxLHB00GFxWFASF6a0FTpUwcavWPQ6sybD7yH9s9gPyYZ1vMfBl44?=
 =?us-ascii?Q?rOvl2vgZPg/QgtIatUp4vOlXPbAgjE7r3CNclJScuhKanuOiXJpumVTJD1fg?=
 =?us-ascii?Q?4lbvqHmGBDu2IhLPZFiUTrKgIwyAhyfhvambGxLdwK8ctqsayOXfUAWPMc4E?=
 =?us-ascii?Q?DtzmwXnQN+2tIH6wTMJezyB+NhjXcrjB05D5fSR8kaQwwDTZ2q+50i6acbR4?=
 =?us-ascii?Q?RF+0ShJauNTx1mA71KDLLZ/uV1zlEYef7uDIdrWzU9hZiZ87I62G3RTswv4n?=
 =?us-ascii?Q?9VOd6Mk0UuDxGWFfmJg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:48:15.6744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a60b0d-3dd7-4203-ac05-08de16c7e6a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9506
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

add functions to get smu ras driver

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  2 ++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  7 +++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 11 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  7 +++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 21 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  1 +
 7 files changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 076e2280d375..4564965ef5c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -617,6 +617,8 @@ struct amdgpu_ras {
 
 	/* Protect poison injection */
 	struct mutex poison_lock;
+
+	const struct ras_smu_drv *ras_smu_drv;
 };
 
 struct ras_fs_data {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 5d08dc3b7110..65cbb65b3b12 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -2140,3 +2140,10 @@ ssize_t amdgpu_dpm_get_xcp_metrics(struct amdgpu_device *adev, int xcp_id,
 
 	return ret;
 }
+
+const struct ras_smu_drv *amdgpu_dpm_get_ras_smu_driver(struct amdgpu_device *adev)
+{
+	void *pp_handle = adev->powerplay.pp_handle;
+
+	return smu_get_ras_smu_driver(pp_handle);
+}
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 3bce74f8bb0a..c15ddcef1595 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -614,5 +614,6 @@ int amdgpu_dpm_reset_vcn(struct amdgpu_device *adev, uint32_t inst_mask);
 bool amdgpu_dpm_reset_vcn_is_supported(struct amdgpu_device *adev);
 bool amdgpu_dpm_is_temp_metrics_supported(struct amdgpu_device *adev,
 					  enum smu_temp_metric_type type);
+const struct ras_smu_drv *amdgpu_dpm_get_ras_smu_driver(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 4317da6f7c38..1f748ce59ca2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2797,6 +2797,17 @@ const struct amdgpu_ip_block_version smu_v14_0_ip_block = {
 	.funcs = &smu_ip_funcs,
 };
 
+const struct ras_smu_drv *smu_get_ras_smu_driver(void *handle)
+{
+	struct smu_context *smu = (struct smu_context *)handle;
+	const struct ras_smu_drv *tmp = NULL;
+	int ret;
+
+	ret = smu_get_ras_smu_drv(smu, &tmp);
+
+	return ret ? NULL : tmp;
+}
+
 static int smu_load_microcode(void *handle)
 {
 	struct smu_context *smu = handle;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index c48028abc8c4..8815fc70b63b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1531,6 +1531,12 @@ struct pptable_funcs {
 	int (*ras_send_msg)(struct smu_context *smu,
 			    enum smu_message_type msg, uint32_t param, uint32_t *read_arg);
 
+
+	/**
+	 * @get_ras_smu_drv: Get RAS smu driver interface
+	 * Return: ras_smu_drv *
+	 */
+	int (*get_ras_smu_drv)(struct smu_context *smu, const struct ras_smu_drv **ras_smu_drv);
 };
 
 typedef enum {
@@ -1795,6 +1801,7 @@ int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
 		      int level);
 ssize_t smu_get_pm_policy_info(struct smu_context *smu,
 			       enum pp_pm_policy p_type, char *sysbuf);
+const struct ras_smu_drv *smu_get_ras_smu_driver(void *handle);
 
 int amdgpu_smu_ras_send_msg(struct amdgpu_device *adev, enum smu_message_type msg,
 			    uint32_t param, uint32_t *readarg);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 0a7d2cea7dc6..32d98a43ea3d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3883,6 +3883,26 @@ static void smu_v13_0_6_set_temp_funcs(struct smu_context *smu)
 			== IP_VERSION(13, 0, 12)) ? &smu_v13_0_12_temp_funcs : NULL;
 }
 
+static int smu_v13_0_6_get_ras_smu_drv(struct smu_context *smu, const struct ras_smu_drv **ras_smu_drv)
+{
+	if (!ras_smu_drv)
+		return -EINVAL;
+
+	if (amdgpu_sriov_vf(smu->adev))
+		return -EOPNOTSUPP;
+
+	switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
+	case IP_VERSION(13, 0, 12):
+		*ras_smu_drv = &smu_v13_0_12_ras_smu_drv;
+		break;
+	default:
+		*ras_smu_drv = NULL;
+		break;
+	}
+
+	return 0;
+}
+
 static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	/* init dpm */
 	.get_allowed_feature_mask = smu_v13_0_6_get_allowed_feature_mask,
@@ -3942,6 +3962,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.dpm_reset_vcn = smu_v13_0_6_reset_vcn,
 	.post_init = smu_v13_0_6_post_init,
 	.ras_send_msg = smu_v13_0_6_ras_send_msg,
+	.get_ras_smu_drv = smu_v13_0_6_get_ras_smu_drv,
 };
 
 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index c09ecf1a68a0..34f6b4b1c3ba 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -100,6 +100,7 @@
 #define smu_is_asic_wbrf_supported(smu)			smu_ppt_funcs(is_asic_wbrf_supported, false, smu)
 #define smu_enable_uclk_shadow(smu, enable)		smu_ppt_funcs(enable_uclk_shadow, 0, smu, enable)
 #define smu_set_wbrf_exclusion_ranges(smu, freq_band_range)		smu_ppt_funcs(set_wbrf_exclusion_ranges, -EOPNOTSUPP, smu, freq_band_range)
+#define smu_get_ras_smu_drv(smu, ras_smu_drv)			smu_ppt_funcs(get_ras_smu_drv, -EOPNOTSUPP, smu, ras_smu_drv)
 
 #endif
 #endif
-- 
2.34.1

