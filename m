Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3393C88E40
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 02:03:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32A2510E093;
	Fri, 11 Sep 2026 02:03:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rs+qXCqd";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012007.outbound.protection.outlook.com
 [40.107.200.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0254510E093
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 02:03:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIDeH82725sO3AIGeYEQjfQlo9aEkaEfKVREYiIQkZtOLYM1zD03ZqYNG9sCMhA81wYsGxIjVD6nHgEMaSXl9LwStu65hSd45fnDCYgNITUQURU0Z12amp3zZz/uKjiR5zAFJuurT9sJ/+BM+DTu7Hh+iVytXGsPWMrsBp/+l2TVzawf4dvF118u5/p4Q4EJvUVepirdK7cjB6s6ejeDVIxr/d7GbDhS7mfVQjwoZmhzFbDixBWxYnLqAXqraauihLNqGEbs9PDpKK/7NqY3ZBTV1ByGDRmRp5CSBOaviTYZkeqcy07Yc9482UXV0nF21/cbneBlq+YElYinxZ/Dlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CcRu430tBodm4zLJ7QVtLzhoFmYdeOcbCd3z2ASi/8=;
 b=SoSJmyiidQBkB1hN56WcfgZHhvqrXfy/nhhsmVThLtUndP6P2L5bje/pKpXM/OXZKK55BKFSkcUFkAn99eBE1TSJsz0be4qQMoLEa07p8Oa3npPzpy+T7nilJf8lRmab+Nmk8StpxMNaSdQefV09eXCF3obBG7mCZ+wrTHZ8MYBPB50xvXgbkb5rEKvMtUcb+awFs7l26/pUSO1z/buOXXEdFaigxjtLmyd5R4Pyans1tQilghyMX3Yzc0w+dVb31zm1z1LkPxY5CMUW5OE/LRzcMRw55Gqe4SENsd/+5zbNrWYdgvdnCI5rfqTt85r2W1E2O2tnazemB4wOOf/9wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CcRu430tBodm4zLJ7QVtLzhoFmYdeOcbCd3z2ASi/8=;
 b=Rs+qXCqdLIJcBWiUYiRQ1rCkkl+2DdGSMvUPQTQRSwNd7SorJ2RdnXj08C3wI3ID4Dav4upQ/0oP9Br713vTPH4ZEHwJz3Eiei+BVqNMu1SiN4o/6b/Rp0JwlgZrpMpQiMotHPLnkHVtq8IaZJI2i6FJc1SCrteO1tIHBzMlbg4=
Received: from BN0PR04CA0120.namprd04.prod.outlook.com (2603:10b6:408:ec::35)
 by DM4PR12MB6159.namprd12.prod.outlook.com (2603:10b6:8:a8::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.9; Fri, 11 Sep 2026 02:03:25 +0000
Received: from BN3PEPF00022BBE.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::a) by BN0PR04CA0120.outlook.office365.com
 (2603:10b6:408:ec::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 02:03:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BBE.mail.protection.outlook.com (10.167.248.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 02:03:24 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 21:03:22 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH v2] drm/amd/ras: apply the MCA debug mode on every RAS resume
Date: Fri, 11 Sep 2026 10:03:05 +0800
Message-ID: <20260911020305.1742633-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBE:EE_|DM4PR12MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d07e72-9c3d-439f-f032-08df0fa8dd15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|6133799003|10067099003|18002099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: pIRVrXfLQTmag1/v5uBZt2pXfS1jKER2jFppOeJxB9g0Af0ckb3KgTwYPJVdOMv2A2Rc1FLUaD23COieRukyxc2RI+inq7akmgrsDgzf7WCPf86VlyWbesUPbIRyP49jbJTYlipyWxnMkh/onSevikDMV92Ydr4jEbtnFEo4w0+8bG7YjEeerRzAlx+QHboI/Bl7ccBWqs0USBZhUnBjlWMqeV7AqbMtmDsB0SYwiJZqN/nCLH6tQChVCHaNogINLLdFq+h4r9D3gfjOLDNukUltl4cm+VriMcp7FSed3tpPG4FlKphZoqvkNMEtKwJIjB3v6q9N0eOckIN5c5ttSP9/xkF/3MNsMmvkgfD5GVIynvlM4uNT/GGAbTKcGRyVWXFX/93RAjzill39YJ6DMaN9HEG2E3aQRLh/laQcoYacU1ggfVwYzlFNdB7nzQD2nSG0GJhQfcWPPDRGrCPT7VXtSIIt0JdbcOgsJXxjXUmJQY4eDt3gxaVcSTYfMkT8iWUgaMpNROEWomiL1M/jHgJQm6HaERy2b/mumtS1TbiJo5IFtBJJQFSQ2EObCvYVNoYUnDaC1RZLy1cyblt23NDBnjlFXUHfoQSKxsF5m0No6SvIPKE9DTaYxPT6TN9Mkn+l3MdQ4MrKsYoZJIE8bwkm/06VDmj6V4AjZGa6BUNbF9N/kqOqZNueH5igE4mHhwnUJea4PrYkiJl22ZhDlw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(6133799003)(10067099003)(18002099003)(56012099006)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b6Jlah+XV9zWM4cjjEdn+K2lL6YlcNBCriHhKe0NtJjEyEz2aZ/GaJIsZOHedwFkN8DfKntKRQJDVrmaa2mhwXs/dCquTBOahw63gfufY8unWaFDWYC/VyVa8JsjlVLhq5kGzoE1Qd5sHVYIdd4l7SyHRqy/aVT9mUllcX+l4jRwoOwKsZ0Gg2lxlH/atAMLgfOb88XQIbIC/ATRbzzIcYESxeTdY3BkV6vDxd3oWxENsII6mxZn2GgE/M4bHjv+4BW/paG6LC8juuiV6BY7ndj+CyCGuFbp+ymnrcd41DRymnpMel97Fau+FMKnaVI4YZBoN1QyLHSjsNypGUrMPvw+vGjidBtpdqtDLFH9yamAayunILGpz4wylJlTocsQQzX7QwgBJjBR2cUu5x0u5Aj7Eg2Y+fbW+vHm7ztvxMtqOAs9JoegQJDFFYpE8tpu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 02:03:24.7580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d07e72-9c3d-439f-f032-08df0fa8dd15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6159
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

amdgpu_ras_late_init() sends the MCA configuration to PMFW, but it runs
before RAS is ready on a device that still needs a hive reset, so the
request is dropped and CE polling stays disabled. A reset loses the
setting too, since PMFW is reloaded and nothing programs it again.

The request is a single SMU message and does not depend on the RAS block
being up, so amdgpu_ras_mgr_set_debug_mode() no longer requires it. Send
it from amdgpu_ras_resume(), which covers modprobe, resume from suspend,
GPU reset and reset on init, and drop it from amdgpu_ras_late_init().

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c          | 5 ++---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 5 +++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index becad704113c..f1da56a4389a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3906,6 +3906,8 @@ void amdgpu_ras_resume(struct amdgpu_device *adev)
 		return;
 	}
 
+	amdgpu_ras_mgr_set_debug_mode(adev, false);
+
 	if (con->flags & AMDGPU_RAS_FLAG_INIT_BY_VBIOS) {
 		/* Set up all other IPs which are not implemented. There is a
 		 * tricky thing that IP's actual ras error type should be
@@ -3966,9 +3968,6 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_ras_telemetry_en(adev))
 		return 0;
 
-	if (amdgpu_uniras_enabled(adev))
-		amdgpu_ras_mgr_set_debug_mode(adev, false);
-
 	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
 		obj = node->ras_obj;
 		if (!obj) {
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index a02167397ce2..982ca34dba8f 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -830,8 +830,9 @@ int amdgpu_ras_mgr_set_debug_mode(struct amdgpu_device *adev, bool enable)
 	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
 	int ret;
 
-	if (!ras_mgr || !ras_mgr->ras_core || !ras_mgr->ras_is_ready)
-		return false;
+	/* this only talks to PMFW, so it does not wait for the RAS block */
+	if (!ras_mgr || !ras_mgr->ras_core)
+		return -EINVAL;
 
 	ret = ras_core_set_debug_mode(ras_mgr->ras_core, enable);
 	if (!ret)
-- 
2.34.1

