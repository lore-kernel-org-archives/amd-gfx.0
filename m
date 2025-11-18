Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C05DCEBF92
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 09:17:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21DDD10E466;
	Tue, 18 Nov 2025 09:17:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oR7/KhpS";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012037.outbound.protection.outlook.com
 [40.107.200.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0044610E466
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 09:17:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzZpuTR0Y6Vlk1RSoReZIduSceKlz6IAh8OxMuBy51gKd5ST0cPNVdJNYNb99bc2U8dS4T8WkZzOHvyNUTib0m10yGYDXChI4cQMKkLd1tJOCO1ToRAQLJ7hCGHtvId8BiDHtGn2cXEQF+ubbXLo0gISFk5+kOReU4s8go41DyW5F9JCUWzyU7uq5mW3bX2B5j+a6bhAsSCpI8vzxO4jXCkxj3xat/ekM90p8Dp1Rbi90KXst0i8MOhWo/4FLjCc6SfdMkA74Ccwxr0mxyfWDlHT/jGW4uqG94kAMBVnMBg8UHsatyQMF7S9BCBsPenEsF3UgPGYcbgd+/3+bnwumw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OhXycDzwzcDBfZAEfEErkzJcAGRR2qonJdKVmPzOi8=;
 b=fYSsB1h0G6Os/qH9frWaOMTSINvTO0M5PlxPf1TabRzzBgxAFSAF4Ne/XW1fo9ucZIf1rTyZVNIBs9VWZA3VSfUkzGdJsqoexPVAx29NWFjb0cGfGn8o7TOmqDLts5bkBRLMqp3ThuGlJfgm2gmNgkYpIGr5pyLCSVvQJ6BON4aI2eH0Qj/yGsXciBnu5RPkZAZ6KCzuolRxblx9c0h7WUQhumE3qZmUpVCk6AcijT9JqZ6VX19FUZBQSqe3C3SwH89ExOnmbvuHNJj25zCTTfSGTkhK1/43Q93vo00MgR3Czdgmpz+oInnwJhxnrVzLPQZhu3uuFQDMRjmBpnuv3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OhXycDzwzcDBfZAEfEErkzJcAGRR2qonJdKVmPzOi8=;
 b=oR7/KhpSoCGag1SvVSQL9/qdRYvvCGOTgzp+7HEHbtcOH4eGgyaBArsjEo0gU4+/GV56lZcowZT5bJNYfUM4fuVwKEYlzzYuj1CrgvU3al4/Rv7bcGLuBxdM05ATC3RTCvZK7HJ/IC+HzGsVJkBdEw9LmZN7OyPjkx7zvNRsHzs=
Received: from MN2PR19CA0059.namprd19.prod.outlook.com (2603:10b6:208:19b::36)
 by MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 09:17:05 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:19b:cafe::af) by MN2PR19CA0059.outlook.office365.com
 (2603:10b6:208:19b::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Tue,
 18 Nov 2025 09:17:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 09:17:05 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 01:17:03 -0800
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 5/7] drm/amd/ras: Add sriov ras preprocessing before gpu reset
Date: Tue, 18 Nov 2025 17:15:57 +0800
Message-ID: <20251118091559.959683-5-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118091559.959683-1-YiPeng.Chai@amd.com>
References: <20251118091559.959683-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|MW3PR12MB4460:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf3e65f-26e3-4cfe-63df-08de26833e1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lU+mNteFveQHuvuXcEJu+WIOJzMD5FZiH2kfqdMskgohfA8Ve8Z1EaLZ9hzW?=
 =?us-ascii?Q?qMdFTleePMDTuaMVDvGoDZ8N/9FSzFiw1cfnCjDLkRbEMwk6/L/5UIRbBcoj?=
 =?us-ascii?Q?1UempygD13YRdw7lLr6w/UOlpaywbTQ1YTBAvdtykPnP8d2zHlmjxgqlLpCL?=
 =?us-ascii?Q?DPD0/Zr4XUnYASm6EgmjwAB0T0DHBpZ4F5O13TE0JuxuwIWTJn2XswKFFPuu?=
 =?us-ascii?Q?uZkY82ojh5BBFqMATD+UqVQ22z3LdD4zo7KjbHHOo2ncGdNb6AA7GTFxk33/?=
 =?us-ascii?Q?mjBHYCfIDPEDjt93Tr6IV892KlmFuEmY++J6Ru8OB4lnWDnhLVCp4vKn7OKm?=
 =?us-ascii?Q?U4azAxmZYtS4j7qOsUB5vdcXo8LcC3/3xIvxD/Uc4MsK+kKYO16zFUElOnYQ?=
 =?us-ascii?Q?4PAU+FVt3LnJfXpq7Umgv7iLIm5ewxQT4ptoZablH3HKmBQzSy+w13ltKvzF?=
 =?us-ascii?Q?A2cN3CwDOmx8mjDAEiU/VIXVnUmO6VgEbziS80XFP1AQmeOJ5Ue5/jx04OCP?=
 =?us-ascii?Q?mkjfIQKlJtINppyOc/fE7W1FbA8HI7tgewlmfgNDPExq0XzMNwd2KVFi6lut?=
 =?us-ascii?Q?gmvYpars6Ak19xh5GvTzA/C5ZRK8gV5tRqdEmABHDAQNVP6+z1txppUaYn59?=
 =?us-ascii?Q?N1PunY7F0ibvAfVqi7+2bNKTMakyxslgsGwtZTdKcz3sCRZDTBiyiO7jzpIi?=
 =?us-ascii?Q?+alP1G26AyoIvbigeDetko5ZlkPfubWPn1c6S104PcL5p5YhNLtu9KYerQ/O?=
 =?us-ascii?Q?WUntV7Cwf085KgaKCLAVGgMdfMhve2QrIfhdAYxYkLaaGvc8vXfbtAz7bhbT?=
 =?us-ascii?Q?sy29rnSAAqFjv0gdLkcOj2Wgdiymaat8nFPwZw4BFRNvhS91iMBdhzKCBUD6?=
 =?us-ascii?Q?vFcmJnxySV6gVqlfr1G5mMq6gmW9ksr/OwFJs3plV0+vkuoM5MpJnHXsuY5y?=
 =?us-ascii?Q?Z+uFGxWiJ6uVorb3inxx6f3rNr9X8ojA3TFfudDdZqNimIt2wB9LRuoECX7D?=
 =?us-ascii?Q?7gny4c516UWD4J1HtiPbnoWdAvPLRbQVlK4zltu5qPHbx6hyt4BpLMWYTcKS?=
 =?us-ascii?Q?OFxachq6uuVeox1juPdVaRk3biRm89r9bBiyH2UiPWYBV3R7RlyN50kd3YmT?=
 =?us-ascii?Q?b2HY2afh5DArR463S9x46rPbGWcRbjbVTJz/dLjVq8u/0IZbxTvhjpYRwHhz?=
 =?us-ascii?Q?3/xFcWiauXex5xlYHydvnRZ8OREfPTM77ruL2F1lKZds5u8wDAE4kK4afv0P?=
 =?us-ascii?Q?EgAJnD9uTrHM/RpvlvU+cS2Y3Hnt7QIqqOYCnkEfwNRvQ6f2mahJ/y4h5KUA?=
 =?us-ascii?Q?Nx3E4tAQziBCUuC0wc2ZYQ7KQk0axDdCsXksHQQ30xkL419OqY5u8hyQ98k1?=
 =?us-ascii?Q?LsTSAjw6WAiQW5Lhb/ujgbg741u7zGIBxnUciP0SyxiZnHWRJbMItw6gMv5/?=
 =?us-ascii?Q?/w7OHwab05wwdSn9r2EzSIBrbn0D/r9rYzt7Vv81W8cl5Jw6LdXYQ7FPGQBe?=
 =?us-ascii?Q?Oq8aqMWnykKGFXYLBmYbDGJDsDBwpeofUDC5EMKEW9/orGRpzruO+79XdnB3?=
 =?us-ascii?Q?7bUGDXi1aABybp6++jw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 09:17:05.7502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf3e65f-26e3-4cfe-63df-08de26833e1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460
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

Sriov host may clear all VF commands registered to auto
update list during VF reset, set ecc.auto_uUpdate block
to false before VF reset, and after VF reset is complete,
RAS_CMD__GET_ALL_BLOCK_ECC_STATUS command will be re-registered
to auto update list of sriov host.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  |  6 ++++++
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 15 +++++++++++++++
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h |  3 ++-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 4ce337b6e0e8..cb7fbc791c3c 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -642,6 +642,9 @@ int amdgpu_ras_mgr_handle_ras_cmd(struct amdgpu_device *adev,
 
 int amdgpu_ras_mgr_pre_reset(struct amdgpu_device *adev)
 {
+	if (amdgpu_sriov_vf(adev))
+		return amdgpu_virt_ras_pre_reset(adev);
+
 	if (!amdgpu_ras_mgr_is_ready(adev)) {
 		RAS_DEV_ERR(adev, "Invalid ras suspend!\n");
 		return -EPERM;
@@ -653,6 +656,9 @@ int amdgpu_ras_mgr_pre_reset(struct amdgpu_device *adev)
 
 int amdgpu_ras_mgr_post_reset(struct amdgpu_device *adev)
 {
+	if (amdgpu_sriov_vf(adev))
+		return amdgpu_virt_ras_post_reset(adev);
+
 	if (!amdgpu_ras_mgr_is_ready(adev)) {
 		RAS_DEV_ERR(adev, "Invalid ras resume!\n");
 		return -EPERM;
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index 73568a6e3463..609ac1a2cd7a 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -413,3 +413,18 @@ int amdgpu_virt_ras_hw_fini(struct amdgpu_device *adev)
 
 	return 0;
 }
+
+int amdgpu_virt_ras_pre_reset(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	struct amdgpu_virt_ras_cmd *virt_ras =
+		(struct amdgpu_virt_ras_cmd *)ras_mgr->virt_ras_cmd;
+
+	virt_ras->blocks_ecc.auto_update_actived = false;
+	return 0;
+}
+
+int amdgpu_virt_ras_post_reset(struct amdgpu_device *adev)
+{
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h
index ae7bf67b3a3b..03c3cf8363ca 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h
@@ -49,5 +49,6 @@ int amdgpu_virt_ras_hw_init(struct amdgpu_device *adev);
 int amdgpu_virt_ras_hw_fini(struct amdgpu_device *adev);
 int amdgpu_virt_ras_handle_cmd(struct ras_core_context *ras_core,
 		struct ras_cmd_ctx *cmd);
-
+int amdgpu_virt_ras_pre_reset(struct amdgpu_device *adev);
+int amdgpu_virt_ras_post_reset(struct amdgpu_device *adev);
 #endif
-- 
2.34.1

