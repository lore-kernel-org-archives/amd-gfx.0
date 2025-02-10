Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859C9C02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 07:01:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2F8A10E4B4;
	Mon, 10 Feb 2025 07:01:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CcgCVBK7";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EA7710E4A9
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 07:00:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rInvHFWGAfYyHf16yx5JC9wSfphZh4SbP8oJKcmVxAd8hhuY1CyEqVkPixnSAP5LLXliqAXMLHdr2H36lpRTMW4olZETuTuX8hi5wXrdIa/YgQ/+NqMGACZhqAOPkl1s8RIcKyhuPpu43O7x8N3fBnRLNowBH6SBGmmx7Cx/HnmOk1nwHULFCok+LzegB+2oRTo4mZ9UAUMgLOAfpq5kQ7bTN2LediY8mqq+EvkvW2xgFfPtoz+lAnHqGHAtBpOL2J9/pKIbnWJkP8Opq9UoTaKwV2hGE1V9YzUalYFPHHZLNdnAEdZCKLJD2pXwd553jmEwyOwg8RjvGJzChCz3Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYtF3SV88iDEIaRrMbuEAgch8RgsWLGyhbiEt0oLOog=;
 b=pULwnyeYB7XV+9uoDIGodeWtPppavIXHKnU7b/lQqXORwzeM9d9PatGLKr+jlDUr68KNHLBOZ6+KVy1y0mThGADGAxd7Mkc79oxj2ZE+5D91ks+DpUANgTSKjPLZBQt+GaiYZs2iDr85tOSvcAJALmCj9MkbFN+qdLC3doM8fxCXZKooweU6RrZoOtDXXFWLXzkuCK+ZNobm3IQEaanhi6Wd2Og7MMi2/TYfhh0uSqBv+5AqfBHejfgWW55OmP+mJfzxJd8NWo+Xq7e/fS76IFPRL5NevbBOTKu1QUaKUc0OkPUWzEXy1QDU7CrR32oZrJ5gtUDcMwQV26CCO4LD0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYtF3SV88iDEIaRrMbuEAgch8RgsWLGyhbiEt0oLOog=;
 b=CcgCVBK7zDXh7IeeJFgrJ3qsUKw9uaO51WXr3lZ2zsuyQ2uSfKm4UwdA/RtEyJOwDXfzksWPfA0B2C7AVVv1QoxvyGFil9Hi9Oaf7VgO4q3iyQfl8CrIYadG1p4sJP/Q6tH4UhQOsB9l9oHapcFRGgKJn9D4NUo3exBDRJxu22A=
Received: from BL1PR13CA0327.namprd13.prod.outlook.com (2603:10b6:208:2c1::32)
 by SA3PR12MB9090.namprd12.prod.outlook.com (2603:10b6:806:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 07:00:56 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::a6) by BL1PR13CA0327.outlook.office365.com
 (2603:10b6:208:2c1::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.9 via Frontend Transport; Mon,
 10 Feb 2025 07:00:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 07:00:55 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 01:00:53 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Jonathan.Kim@amd.com>
Subject: [PATCH v2 3/4] drm/amdgpu: Remove unsupported xgmi versions
Date: Mon, 10 Feb 2025 12:30:33 +0530
Message-ID: <20250210070034.1998011-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250210070034.1998011-1-lijo.lazar@amd.com>
References: <20250210070034.1998011-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|SA3PR12MB9090:EE_
X-MS-Office365-Filtering-Correlation-Id: 7507d20f-4221-48b5-05f3-08dd49a0aa35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I5NrGQsL01YOolDPLblUCDZ/viLcMKpCbtjRmpBa9whg09ZzKiRQjQtiv+Gx?=
 =?us-ascii?Q?HuIgsEsc7uz7HW/MenkkYEtwCXqh8YhnAz16QJ8sLh2brwNecW80N5wihX1r?=
 =?us-ascii?Q?gFUXPn5BYSWiTXfeE/8umBzAGpm3D55fvrqFTM0/5gamZBQYakIzYPW7XA1d?=
 =?us-ascii?Q?6RqJt966nwc6Oe3gygmyumv82OuXg6dO+gMrx3X+trl0KWASYr3DpEhF0etV?=
 =?us-ascii?Q?ktUpzvYpjUv4pUySN9IVfx6S5IX2egaTn+40hsW9/8FFLedFOW1ccGQVk/zT?=
 =?us-ascii?Q?tZgRC0FUWwkWpn7p4ftWxrh3sKlfzqrvTGI00637cZbEupZLtWSjlZ/+f2J5?=
 =?us-ascii?Q?HTts+NJ7KX2/alcBrl7j94hr6fFAMKfJFn4RXzd3T8m1P+7GU3dvEZrVCIho?=
 =?us-ascii?Q?D2ljnk9y94H/ivoG/9ImicjyLpENwJ31wkdsSWoZxNWkGa+Wy6N+Cv/xuJJQ?=
 =?us-ascii?Q?goWb+VdKeOveR+bDy6LaPOQVHR/poiX5Z7woRdZ8bP/YZHKPQlGCXfFeVL8Q?=
 =?us-ascii?Q?3kfZxPa7YZPqCIUUDKtJkAXFaHhladHna9G64MMMiIVx6yI2c0PkB2rvAxMO?=
 =?us-ascii?Q?wZCOFOY34M95Xo5vUL+EiukcA+QGAKbSnyaShnuCrlzD0FbqB/aZk6TlbGGC?=
 =?us-ascii?Q?OMWTrtvjZ29EIHVJsJb/2U/yI0X+kXBXWXB3LSgffRPgSjAd0oUWRKWIRxyn?=
 =?us-ascii?Q?8lxdHJWo4Hk61My0ZZ5H/FPkUUaa7bcspy0an8TEsUibwkueNRuoEylZIant?=
 =?us-ascii?Q?1YjoyRuwcOegnZ7EZF2c4HuprAIBa2Fr3iy/UTjpjSOabspoiUwo00OkNPZX?=
 =?us-ascii?Q?kDlv395/VR2CvGGW/OhCPygt7+yjLkiaW5I4Y8iXo9S1uj87QT+Yzs5kkHdF?=
 =?us-ascii?Q?D4d24Mecm+TCpJGl54k7D1aVUONU2kIA+KaVz2zTTa0Xsp9nYn0TSzEXbDDk?=
 =?us-ascii?Q?s8Ceum74l9X7KwDhyQaZT3ngcNZkqVVGABcUdt3Ygb00sfhQdSPNzvUuMQz0?=
 =?us-ascii?Q?u5Sor4b2JngUtciC+Vax/GWgu395ilwc4A3BWkjhWnfw1ZMSwdFoLgo6XCZa?=
 =?us-ascii?Q?x8amWFcM2lFLikVvoJ1AOduOWjto8I7UrI8/F3G8ukn0uUyLE1Ogn5tqpN9T?=
 =?us-ascii?Q?/qVLtvcLOrE9lyGEr4Gg39/6MA5jpaIoJAI1LGFRYAwTbgO0q2DQmtx1y96z?=
 =?us-ascii?Q?HBJeFbq9iyqXleBoyFC0pKSwHkIyKNcVHOmvfbF8rvaP6Iw/tbPWG5jV7lEZ?=
 =?us-ascii?Q?8er/aeXX6cPgEoN4X9EPGawJ5GJurPRMneG02G/BQhy69c3BxqVrAjWOse3C?=
 =?us-ascii?Q?B6gb9pvajfIj4UHJzBeq4wglM+/a/+rqcuPOiISp+GGq1s5s79ExtHNB9DeH?=
 =?us-ascii?Q?/0Q+WB4MS2pwGu11701vfnDqRhQDStXoQN6sWTUkopCbYe/71LqKAyJ7Yns7?=
 =?us-ascii?Q?dqK31dqt/9XgELZMkqf9/EiyBhKm3I72vm/jYbUIUbFYIa3tEYJKhR5FDJU2?=
 =?us-ascii?Q?dXlN3SaYDksbTfg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 07:00:55.5050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7507d20f-4221-48b5-05f3-08dd49a0aa35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9090
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

XGMI v4.8.0 is not used in any SOCs. Remove the associated functions.
Also, ensure get_xgmi_info callback pointer is not NULL before calling
the function.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2:
	Remove XGMI v4.8.0 as it is unused (Hawking)

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  3 --
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c      | 37 -------------------
 3 files changed, 1 insertion(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index eab530778fbd..315ab2d6717a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4398,7 +4398,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	amdgpu_gmc_noretry_set(adev);
 	/* Need to get xgmi info early to decide the reset behavior*/
-	if (adev->gmc.xgmi.supported) {
+	if (adev->gfxhub.funcs->get_xgmi_info && adev->gmc.xgmi.supported) {
 		r = adev->gfxhub.funcs->get_xgmi_info(adev);
 		if (r)
 			return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index eca431e52038..c88e44c253be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2769,9 +2769,6 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	}
 
-	if (amdgpu_ip_version(adev, XGMI_HWIP, 0) == IP_VERSION(4, 8, 0))
-		adev->gmc.xgmi.supported = true;
-
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
 	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
 		adev->ip_versions[XGMI_HWIP][0] = IP_VERSION(6, 4, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 17509f32f61a..deb95fab02df 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -505,42 +505,6 @@ static void gfxhub_v2_1_init(struct amdgpu_device *adev)
 	hub->vmhub_funcs = &gfxhub_v2_1_vmhub_funcs;
 }
 
-static int gfxhub_v2_1_get_xgmi_info(struct amdgpu_device *adev)
-{
-	u32 xgmi_lfb_cntl = RREG32_SOC15(GC, 0, mmGCMC_VM_XGMI_LFB_CNTL);
-	u32 max_region =
-		REG_GET_FIELD(xgmi_lfb_cntl, GCMC_VM_XGMI_LFB_CNTL, PF_MAX_REGION);
-	u32 max_num_physical_nodes   = 0;
-	u32 max_physical_node_id     = 0;
-
-	switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
-	case IP_VERSION(4, 8, 0):
-		max_num_physical_nodes   = 4;
-		max_physical_node_id     = 3;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	/* PF_MAX_REGION=0 means xgmi is disabled */
-	if (max_region) {
-		adev->gmc.xgmi.num_physical_nodes = max_region + 1;
-		if (adev->gmc.xgmi.num_physical_nodes > max_num_physical_nodes)
-			return -EINVAL;
-
-		adev->gmc.xgmi.physical_node_id =
-			REG_GET_FIELD(xgmi_lfb_cntl, GCMC_VM_XGMI_LFB_CNTL, PF_LFB_REGION);
-		if (adev->gmc.xgmi.physical_node_id > max_physical_node_id)
-			return -EINVAL;
-
-		adev->gmc.xgmi.node_segment_size = REG_GET_FIELD(
-			RREG32_SOC15(GC, 0, mmGCMC_VM_XGMI_LFB_SIZE),
-			GCMC_VM_XGMI_LFB_SIZE, PF_LFB_SIZE) << 24;
-	}
-
-	return 0;
-}
-
 static void gfxhub_v2_1_utcl2_harvest(struct amdgpu_device *adev)
 {
 	int i;
@@ -696,7 +660,6 @@ const struct amdgpu_gfxhub_funcs gfxhub_v2_1_funcs = {
 	.gart_disable = gfxhub_v2_1_gart_disable,
 	.set_fault_enable_default = gfxhub_v2_1_set_fault_enable_default,
 	.init = gfxhub_v2_1_init,
-	.get_xgmi_info = gfxhub_v2_1_get_xgmi_info,
 	.utcl2_harvest = gfxhub_v2_1_utcl2_harvest,
 	.mode2_save_regs = gfxhub_v2_1_save_regs,
 	.mode2_restore_regs = gfxhub_v2_1_restore_regs,
-- 
2.25.1

