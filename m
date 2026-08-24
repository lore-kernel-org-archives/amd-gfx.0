Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D66C61CE3
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 10:22:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43DFE10E554;
	Mon, 24 Aug 2026 10:22:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e+hoRVmV";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011037.outbound.protection.outlook.com [52.101.52.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 674C110E554
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 10:22:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4Fc0TgThivBrJIROS3KwgxN1XWHCIKVGxasnvp0pcAYz9pKPym+QS46aumu60ke/g9jt45abxXHfHWOWoP92pRyPa9k8IWYGqDtN9q96jRPSqY068V4ZImfsu4a9WrcS7tzWvyr38urh1Rj9BBX1PLp/68xiophShL0jZnoGxo6etjohsF2l44XAj+UQbqDTBLaIt4tAn4rl5NldAs/4U1/SdWuoi0yN/CVXcrfYf92MMUNgQN5B6sYPnpCfBsuK9UkNIYTiLFkl518NFHd+A3cIXUHuvfHyQlHYw1Re0X8IgPS/bwJK81KhJZSl13bv5NkVMLUj6vWdyLz5xjFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEj0kTHwOcQuqDT294GAvi39E327Kab1aJcCNKf1vWE=;
 b=R+EeIdnuaJHQhx+VlfByRPkaPMBAL9k97rWMfWEiMUaxXW0GGCokdunBTRyEWg0ZVQmu+xoGMTFdoEaoKvbg3lhGOLmNOFF+F+zKI6SL9G9PPD2alXEhhTAJeHM4q6fjeZLpKRW2Jcdm7dXC2ZqaAlr7U19RcEZqjMuijeYTbXcGnJanDOJ7B87Rv7R4qFrgv/Ru1H7FNNYIoJoakb9RLmCPKJa5JNrio5HLUtPMtvjbmLzNP6PkCxB/5DuJEWS9UO9MTu0WMagAanxj3K1w09XHnPUBoZbDcwgSmTo2+azUcUiNDDgbjHnMBFtKLKwWbOtFyiI67ghKpe93qIPjYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEj0kTHwOcQuqDT294GAvi39E327Kab1aJcCNKf1vWE=;
 b=e+hoRVmVcJRbnQgw4QgNpbjQNVNKkUMg+jBtj/QQ8df5TSD5oWTpSUoA2Yds/fzTbePgBu69nN6SccN2TEi5PXe2FcWawMLgFywCLyiC9+9lwTz0yvK6H+tO1+YkKNRQuk9MKheM+0Fmvg1UntsJUAdvsxzZjrc2q6hRGPQR8xg=
Received: from CH0PR03CA0105.namprd03.prod.outlook.com (2603:10b6:610:cd::20)
 by DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 10:22:02 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::88) by CH0PR03CA0105.outlook.office365.com
 (2603:10b6:610:cd::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 10:22:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 10:22:02 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 05:22:00 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 1/2] drm/amd/ras: tell KFD the reset came from an ECC error
Date: Mon, 24 Aug 2026 18:21:10 +0800
Message-ID: <20260824102111.264161-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|DM6PR12MB4105:EE_
X-MS-Office365-Filtering-Correlation-Id: 24bce19d-7def-4f39-e6b2-08df01c989c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|56012099006|10067099003|11063799006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info: CA3qA41zrA1UlREkvS5qjYRNP4jRwK0Er/GKkPcYQpdYw5Rbtuziblk3UQEDfizrCNa34eoitBHWtbL6/Me16GMmG77nwXx6gjvZhhkzf/IHUIWc/juKuAfZCeT9PA05UNfw/hyMgXWGntJCfeumYU35jvxNJEIISyjQBvInA7d4M7eX4W2pehSU+BL3bflCijTl5oTqAVqnp+EP+cBBmlHv/V2pFKIToZOsfkPF1VIBan9gOfUOeJmu6yKW6O1LdA+/kQRS5VlCYF8cTHu1o/sUoKZ11s93jHq0SPeoUMf2iLvf+nvF6+R1NLepB8y5MAHmxHcCIT6aVlEbB09mqNSAH4gIgUtQNmu0MqfuOzJvIyC/CjSylMlMKOJxAfTcFCgnvTd53EUNCwe7PiK5XOrUI3LGz+X5Rb2Yp1gDc/CmvmSlm+L+WSHX2Uk5lcuIFDTUXNhaxQmKjUL3DjaC/dU+DvUUmVv7kb660Oo3u+USzNRFLb3AuEtHXHcCRBY9F2spxma7dgcCqqAHmpsaZFQnqrYh+kip5wtxzb/UIpyWviCYYMOyh+UJ0HcB6OCIcPeNeV6JtaJ90IACuCDNLxY0ULyuwaXmXPMelFd3Mo/DhfH96/1g/vJz1VI0re3bsQxEXrYfOMr/Vkb5P3N802J0qmUN5qmgJU14B6jOSKG/MLJaqenUojzvWIXQw4pXSqVwSYNZYFZ7L9YuG4FafA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(56012099006)(10067099003)(11063799006)(5023799004)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KkGMgmhig0s0OzifJs2cOAB4Fe++d1lXpZP4xfoR2aep2qKmSCj+DKEmUjtuE64VMnVIKwnehYFCXMgeK1Gx9n7g07LkLeOBnuJpoKjmHXPLw2Apf2WZSOAqIK6OylB8yeSVRPY0Grpo0HJfhp4L2d4q0sKf4GsmnjAe/mu8eC5F7OEnGtYscyee9aDmblWG8k54SMfeMbZR+IJdlE5zZgfSO26MRqJa97WwM8lgWeqdhyFbk0QIF4aaEF/77MnTonUDGlgcwUDo7Qetv65WlWrwXOlTZ9QvvMARJE73fFoeYE+6Kc6Sl3tTQFuA2+mEIs49XVfUDhn6tXPq8lLwUl4tXJk6iBg1NnEkE+sIU8aNEVUzbJ/yDlq+weoRcZmq9UCjUQwBs07Vojny9961oErSXqcaQ/OZzd3PtjIJZVvg8I/Hv/yTpMX7P8CUsfsX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 10:22:02.0718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24bce19d-7def-4f39-e6b2-08df01c989c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105
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

kfd_signal_reset_event() picks between KFD_HW_EXCEPTION_ECC and
KFD_HW_EXCEPTION_GPU_HANG from the SRAM ECC flag, and only delivers the
memory exception event for the former. Nothing raises that flag on the
RAS module paths, so a reset caused by an uncorrectable or a consumed
poison error is reported to every process on the device as a plain hang
and the runtime carries on instead of tearing the workload down.

Raise it the way the per IP callbacks used to.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c | 1 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c
index 39452a900615..9dd44fb5b885 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c
@@ -89,6 +89,7 @@ int amdgpu_ras_process_handle_umc_interrupt(struct amdgpu_device *adev, void *da
 
 int amdgpu_ras_process_handle_unexpected_interrupt(struct amdgpu_device *adev, void *data)
 {
+	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
 	amdgpu_ras_set_fed(adev, true);
 	return amdgpu_ras_mgr_reset_gpu(adev, AMDGPU_RAS_GPU_RESET_MODE1_RESET);
 }
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
index afb539f068c2..081516c46cf8 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
@@ -54,6 +54,8 @@ static int amdgpu_ras_sys_poison_consumption_event(struct ras_core_context *ras_
 	if (!req)
 		return -EINVAL;
 
+	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
+
 	if (req->pasid_fn) {
 		pasid_fn = (pasid_notify)req->pasid_fn;
 		pasid_fn(adev, req->pasid, req->data);
-- 
2.34.1

