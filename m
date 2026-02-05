Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F9EE9126B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 06:51:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3B0B10E7C8;
	Thu,  5 Feb 2026 06:51:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a6EBk7iP";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010036.outbound.protection.outlook.com [52.101.85.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81AAF10E7C8
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 06:51:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7VjI4Yfpq9mHDUM3Oa0gUA3PI88/ptuuIKN/8K5y/j2EojOJHxW/RS6M4PYFrX20vRE4c6X7SMTuWfwt0JYTQKHIos8RfAShCrRDFNSZj3LaUwPzit3xQnp8nFWuCoVN9oB0RS2gc4sRnkVGT0myz9ztOBpDj3gplHftlabo3GDIC8B8dPVTv2vRqjkeYXl3l4ZYSiycN1/fxfY1WWwnIxEdLpuVL/t5CpwfieFE/MIloonuXXKUBjEpO2boaFTuye8rCrVkmSnv58vrP4snEP68ujsR/Tcpxrv4UczhZwxr1XXLgfSeoKAlVtoyOeek+viHN4MaqFo4iU/y3IzUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXXpYwPwmCagM5D2UW7x3JwuQwz3PVoFMx9GBXYnqNY=;
 b=abrNwWI8PKlmQhYpURNcpxNb0RVI4ztRrzOL1A7JSsbG58Z3rJD74aUYz2BsHqCoTFLF1/XGiXMSBTO0fRzo6LMHZY2O1NeEtoZkW7pdsfbcJW1U7rhfZmLQVTFZ0lV5EhDnFiESLlj2xwrj0H5w7+d9L0SDGiV5APy6rpK/feUGVoRH0KJRmjywbNyuBkkaWBEBQYb1cLm3qikMAjJO5hLfROo3DfWuVgHsJbFY8hFckWJctLWYMSYge/rdgcJw4YnnsL/+qau+AlNRpxE1yndcp+RedBYWSXs8ulLB6jUmI7oR1u2TvQxL1VRb6cvs4IeqyuR53tcm9YW0BS1BZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXXpYwPwmCagM5D2UW7x3JwuQwz3PVoFMx9GBXYnqNY=;
 b=a6EBk7iPUj2ox2o0OZcMLy028igupRE1aJb1+ZsWRtndJ2sHSGC91rrw0LmtHeY0fbVRh3emzwmF+/CtmKQGdxbP8wAVvTrP7Y8omv4PMSYI+oHBDKQ1J5gv0Y2YvSIbK+0gMi3awC7Xubg1z66hSjFjxix019CG1892DgjVOY4=
Received: from CY5P221CA0044.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::10) by
 SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 06:51:54 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:4:cafe::4b) by CY5P221CA0044.outlook.office365.com
 (2603:10b6:930:4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 06:51:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 06:51:53 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Feb 2026 00:51:51 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <yifan1.zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH 10/22] drm/amdgpu: add PTL sysfs interface for old kernels
Date: Thu, 5 Feb 2026 14:51:18 +0800
Message-ID: <20260205065130.654921-10-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205065130.654921-1-perry.yuan@amd.com>
References: <20260205065130.654921-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|SA3PR12MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: ac91efa3-c85b-409b-56ec-08de64830c12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D4PJiOgoqkvv75NZCx/tgh4tTy132Cicb3SuUraTufwLuvsd3E1TSjJRLvQ0?=
 =?us-ascii?Q?Y3foMaUoL3FmK4vQ4n6QiVrSz/fKWHes1B8vW8YA1fn0MFgIiRptWDjkEp+I?=
 =?us-ascii?Q?T152RAb3I0X/aAz80Bm2nx3NXRLYBohOI7qEE6iSwLOOXrlwBm8wnHJjgFxZ?=
 =?us-ascii?Q?hK6fJ0QA/dF44yQKzzV7rwDeTHvu2lmQKQEbhkJdhiZILSruYFxRwwW1hqoz?=
 =?us-ascii?Q?DXAXiOi0gfeYSA3fdPL4m31cIjda3sNd1qvGodiIinyEwsk2yBDBMWQmW9J1?=
 =?us-ascii?Q?sNKdryuJI6bJdAlL2bt/OCXbdkxLLrnTalf695xvkaS6ztshg7f7N5xT4kED?=
 =?us-ascii?Q?j7bmSJIPapxPGxq0ORKZGg7NtdpNhP9W6boSEkHDVICSaRsqNYBujOe226U2?=
 =?us-ascii?Q?QIyGMsqUZWhJR3FNTPH8pAhtZljUCmm/4cKSXJv/rx8WJeXI7Ecl4J8KLTIt?=
 =?us-ascii?Q?Ux3DN88T0RiNqZAM5QJiavhM1BZ19cR34uSyFhXTOnOw0DhEF6ewCPFzclJ1?=
 =?us-ascii?Q?2Py2RU6riGB9ScQyqxwU2cl9UH630itvOMOW976iodkxD6Gzc0hR28ulvt9s?=
 =?us-ascii?Q?9P1F9TEozAgJA9dGt8v9qNn2yh3WY3h0dNZcq/LjGU+IUciU+T51ac1qKgfb?=
 =?us-ascii?Q?216My09Svav/vYgMToslbI9ezPQct9S4dw737E/yQwDEqhXmOPmMUfaIFCEq?=
 =?us-ascii?Q?Ih1cVvWVhYnP/1x0+7XAsi9c4TPO8mZxTa0GaN8Sqp/HinIh9d9Vk0SAv7lN?=
 =?us-ascii?Q?CwsU1ETA7W3PBd638jnNLyfXhZMTIyuIfwiBRKz6UXcPvoWb+JAcY+jdA+gI?=
 =?us-ascii?Q?daKk4kyIyYvFl092se8jlvtOFdozIgosKFEg9boy7ORwxs1Y+fuMiFt5b847?=
 =?us-ascii?Q?qVqWg98Lvmdry+LpGLO9P/3scr7L3PJcD7w/my/qo2f70vgGmubY/4VfI3dx?=
 =?us-ascii?Q?D86rP9JbDMWl8r4CNFfhjmTzhgTT6z1655WTrIetW3U3K+f3eUhXh2/UHnAv?=
 =?us-ascii?Q?TBYfSYO2PDfvq75JYCFqsS6vHhSlB6NKCFfCbj5jaHfC3syrvcIIjB9sOVeY?=
 =?us-ascii?Q?kMFrIjK8tTyph1HsEcHnHdtltVipARIr9Bl2zl2O7nmMjr+d+F9KvBSMFrrn?=
 =?us-ascii?Q?bBAoQOSAqNKGP3n6KGBH8TZysE0ZxqUBXt58YWt+rt8VJinRH7QKCuXFq/xM?=
 =?us-ascii?Q?APdxDOIUEAzmiy5qOZM5WZQqYhYFUHATqrJd/G0/rVuuljDbcdX1cj23Hr1O?=
 =?us-ascii?Q?FnATAY2AvT9aqdtj6iykG7pwqh9zasfldUdGjTLiL97LBPrBqN5SRXo/cfv/?=
 =?us-ascii?Q?hP8DpDgcTZ7S+L2xbLUNFaas1e+PwZ6wIyqJQTZYWIOP1GkGojtWlJrtwZNb?=
 =?us-ascii?Q?hpZXGdQivQg9PjHT6qpnm5c62Ga2v4UwYACTep21QXzcerHLnGSOjhPaXXw/?=
 =?us-ascii?Q?x4FOZX5yXuaNg8PtoEX/og5zgaqX8agYqDtkmUvTrXLYg0iuR8KSzlSnCqtr?=
 =?us-ascii?Q?4Lis1zinZIYIxPMfklRRmVCL/02l6kz/QYRogYXz5BSC2TpGRMwCbm7T7k/T?=
 =?us-ascii?Q?YAOQi5diU/ERYsl3SnJE8wAIn2q8N2E0kpIixSNSSBOaOH3/HqOJBsAQuwqO?=
 =?us-ascii?Q?y9SXiYrSoCFpJxs22jD2tskb8gepEuCELPXz3LhiMj8Rk3MgW5Dnw+10u7l2?=
 =?us-ascii?Q?2XI6Tg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XJRVZ3UKN5LKPJVNg5ua1e/JUzqYMcftwWXTuVbcJH/x45//I85kDQ/qeE3uemhwPKKYNytak26FpFxY3cLkSyyXtd7mXLEuSBotWTp9Ji5W4McS7n0rA8176omlQjfCxFmKohnQr8u/Tfs8UbdQ/Nkeuoib4gJK6qq5fnqrsE14Z9vPcV6J4c5bBRrtQpSja6OPHQFO9TSV0u2Qn2YrrE6SMEojJGlpnX/fFxlbpbpTLtKSsVBffw1gEXWZokX5ipxFQICJ0T+5Yjxs8p2SB6Rm9eGBWfBXEYuuk50ofMWZKhwQ9WyGwTQld4HfmmTn20nrva1fHO+c6jN41txvSEV81+8ySb4JE5oJrC3ZlAarwGdZSOJvraoXmBRSmI3Q+ciop/VDJKWhGPEPaf8slFfVoUGuFkezJhwmpLCT3hZXhJohbWe1sYU5GSPRtJvu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:51:53.8589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac91efa3-c85b-409b-56ec-08de64830c12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782
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

some old kernels do not export pci_driver.dev_groups, so the
"ptl" sub-directory is not create whle HAVE_PCI_DRIVER_DEV_GROUPS is
set as false by kcl.

Move the sysfs creation path into amdgpu_device_sys_interface_init() /
amdgpu_device_sys_interface_fini() so that both new and old kernels
use the same amdgpu_ptl_attr_group definition while keeping the
implementation in one place.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 16 ++++++++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5e73b9d67325..6e422da88b7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4337,6 +4337,7 @@ static int amdgpu_device_sys_interface_init(struct amdgpu_device *adev)
 	amdgpu_reg_state_sysfs_init(adev);
 	amdgpu_xcp_sysfs_init(adev);
 	amdgpu_uma_sysfs_init(adev);
+	amdgpu_ptl_sysfs_init(adev);
 
 	return r;
 }
@@ -4353,6 +4354,7 @@ static void amdgpu_device_sys_interface_fini(struct amdgpu_device *adev)
 	amdgpu_reg_state_sysfs_fini(adev);
 	amdgpu_xcp_sysfs_fini(adev);
 	amdgpu_uma_sysfs_fini(adev);
+	amdgpu_ptl_sysfs_fini(adev);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index d88da1beb532..95d26f086d54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3146,7 +3146,6 @@ static const struct attribute_group *amdgpu_sysfs_groups[] = {
 	&amdgpu_vram_mgr_attr_group,
 	&amdgpu_gtt_mgr_attr_group,
 	&amdgpu_flash_attr_group,
-	&amdgpu_ptl_attr_group,
 	NULL,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a5f101ef51ef..2b197cdefe31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1424,6 +1424,22 @@ static umode_t amdgpu_ptl_is_visible(struct kobject *kobj, struct attribute *att
 	return attr->mode;
 }
 
+int amdgpu_ptl_sysfs_init(struct amdgpu_device *adev)
+{
+	if (!adev->psp.ptl_hw_supported)
+		return 0;
+
+	return sysfs_create_group(&adev->dev->kobj, &amdgpu_ptl_attr_group);
+}
+
+void amdgpu_ptl_sysfs_fini(struct amdgpu_device *adev)
+{
+	if (!adev->psp.ptl_hw_supported)
+		return;
+
+	sysfs_remove_group(&adev->dev->kobj, &amdgpu_ptl_attr_group);
+}
+
 int psp_spatial_partition(struct psp_context *psp, int mode)
 {
 	struct psp_gfx_cmd_resp *cmd;
-- 
2.34.1

