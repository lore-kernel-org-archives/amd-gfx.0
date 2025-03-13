Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A84C28B2E
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 14:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD1EB10E8D6;
	Thu, 13 Mar 2025 14:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w/ifsJpE";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F031710E8C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 14:42:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIQMT/QxF305raBmL8eZcCw8XBtIpK9rTAzRP0ThmDRz5pV39tJHXGCXgJAN6gpjvL+rpazJ0cv2RPwIPkR8TbMwEB6vkkj3mu8oIUukiKbURVNd3zNf8UBWncoE45lo/Rp2ehepvm5ZbLa5doj6STphAHqhbZEDuPcUI3k17w2+awjiyBKIvuL9pnurcm+fE3Nn/JPDdklnkOqsN6igz6ciRNLQPkBQl15PeORvl4kVbaf6FIJLts6rdiYkVO//fDOXfoDkbuAbjxAgBuno7e2OFfFnoTjxPdLGJtnrDZ2bRkwmx9VaDNKhW7vvo4Lh8mIqDufCtXkLdZ2eOBZKUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9v50qX7Xds1b1mbTQng2Bnzn/DtWgowPeCKVC+UbXP0=;
 b=AAV4hhHPSL8/j01tJ8+DymhdzhbUL8zDCjVrGynScsM8TjfuG07q0OQLroqBGYxZByyfJRrJxdchTmJ3SOyXUT+UUOW8IqLxKJBni1xWbI5ErWX5CbcpK/s91vfTLQwGh/KNQVftzCwZoSYiEpj2T4Qu7MrAMhT/D3Y1LczMNt5zvavUDBho/QxqyNIzFmGkgYjJ4Nen0WUrtT3APSSJyCxohB4t6/oQWbssrTgcd5psqGvtdBZZnx0sWiM3mNz42KF03DcHEhcXwr8IohRw9MlFoyE+qgzt0DFviqoFb6penBr8AgM4MUGp/QWLzfl09NBHJa2azoWa4K0+z4mxKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9v50qX7Xds1b1mbTQng2Bnzn/DtWgowPeCKVC+UbXP0=;
 b=w/ifsJpE56QXeUvTdalMQgi09XmPtTtIScTnVn5x6whIti9Eiz6H7D63KFwzAGQOGA2CQsBmu5LpyhZ+AS+UGlgS48SBNDTigslk/OiLuDjYLkfGmn5jLgmEsBCxFrhWcyD9MlwGDtoj7THr3eRE9Huc8esLvappVlBo5YYmUlM=
Received: from BL1PR13CA0336.namprd13.prod.outlook.com (2603:10b6:208:2c6::11)
 by IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 14:41:53 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:2c6:cafe::59) by BL1PR13CA0336.outlook.office365.com
 (2603:10b6:208:2c6::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Thu,
 13 Mar 2025 14:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8558.0 via Frontend Transport; Thu, 13 Mar 2025 14:41:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 09:41:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 01/11] drm/amdgpu: add parameter to disable kernel queues
Date: Thu, 13 Mar 2025 10:41:26 -0400
Message-ID: <20250313144136.1117072-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313144136.1117072-1-alexander.deucher@amd.com>
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|IA1PR12MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 388f99ca-b908-4c6e-f34f-08dd623d3270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PyCuLb0lxcqtyWhQ4yOHGAQIsO/L8DxoF4YzpPP2+yz/qYoLwKZMQV8iIzc7?=
 =?us-ascii?Q?Wq59dPeuEaij4UtYZv0nMxahhlNjVJRIZyL6Ecppd88G45++h7EuTc/6WZmM?=
 =?us-ascii?Q?vASEEkl72UYYEgEWKyxdYEGg7UED4ZgnDlb+Xi3JBxI6Gj7/E0AobX32TBma?=
 =?us-ascii?Q?qhJZsd1qni3dAMgd6eJT0/c+7n5kdEU1IHrdji7RdfomKB8aiOU9Yyw4W+DV?=
 =?us-ascii?Q?aRklaGpkPbFOgxOgAq/Zis1HBzeGxIVvti7N0OX7aB0webVnM69trJp8n7N/?=
 =?us-ascii?Q?B2aF9kfqPaEN+sNkn+a3IL1ClM1MUgttPzfyFcnIv2wNDXgG7KtvNM6gYNJZ?=
 =?us-ascii?Q?KTwqm1MZi9R0kHs5BdivMzmAPqHwraqwN+SPTderw/e1Ylyk5Nu34Y0oXWBD?=
 =?us-ascii?Q?BAsnFtmx1iduJZwLJIuhaHEDZoPDAyjnteVomg0SnvCwPAg2YrgwIvn3sU3q?=
 =?us-ascii?Q?7dPtbBVA7MYH96NxVUhyxH9v7rTC0h5DYUi4P2y8V6ArzgRLM7IV8w6Ve9Ph?=
 =?us-ascii?Q?eSkJ9WgHlv/8bF0Wgp6+7ik+BbntQN9yv5MXrK73WtPtxOzDEkb9CDN3odJH?=
 =?us-ascii?Q?ay5Wr/5/8mbmgiuCdRduYSurezxJlORouMKvRPBbDYsL6mTPic3+bPPGuQmi?=
 =?us-ascii?Q?1AWt+Stnu5jNouxvomSF4hqiNKoV44g+Sn2xgRE44nEqUX+H7Y9CLLyvzLfl?=
 =?us-ascii?Q?WzvLNnFiPDeri2yB8GoSM5FwPV4RtHiSF52J/ITrv2RWvc095SlNMu77J6Qd?=
 =?us-ascii?Q?gRFBygsXYFOkLY9FhGuwG5Iad73LLg1Ii3C5OVytqxC1ZQtBbByIWBFFlMpC?=
 =?us-ascii?Q?yBKaZjnfcaLRGcxYMgI8kvf0cozR5V4mRQIjZXExQhndT6q3NTO8L7raOCNm?=
 =?us-ascii?Q?E20O5/PwPhlXb/Q7xJgjktPq13X92iivTzA0XLhMrBB7J0D9N2kFES4gia1m?=
 =?us-ascii?Q?w7vyFRnuT5h3W2ruRCPhR8rMCX82u8cbXpCYTna4pVqCMmoM5+ACDHCWX+np?=
 =?us-ascii?Q?W2A1IUP8P7UOb4Us4emySs+R2qtk4LDy3KsXv7RIS44hOU4GS4hs+JXcpVDt?=
 =?us-ascii?Q?Mesn1ZDITeBOphktR7MA/4fMvGzz2Ng3QHV/TUDkEYh3ASZx3OAGxck4xhI9?=
 =?us-ascii?Q?lZXZKpnms1ZtWvvuyWXppGuV3G6T7XvGLTpUFWUrr00pCwuj8tRJDa26ffLK?=
 =?us-ascii?Q?jjxdVaBp4XwJrj3V8PODJdrSIxrjVk1nBVaMUfepcnt67Y5OSAf1GpCi66UU?=
 =?us-ascii?Q?8yN+KMbXSn15UAk1r15pDT+Icezh3MY1zjposZuHUUbfly1yDv6Y1ax8RIyi?=
 =?us-ascii?Q?wDFkfYHipLksYYNZFxs4/3pFXK+uAcljR6Iyh+Ui8cI80N/TO2aoLCB/rM1d?=
 =?us-ascii?Q?+vGDRI8U3Q1bJhpby2/r88D6/a1wBV4AXQNsF0Wk0cX16u6cq5ima03PCGP1?=
 =?us-ascii?Q?Ly/Xot4y2rdBLxQOZACrofCobDxmSNiHzlXeUW2IaAXUZ2QegXMj8g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 14:41:53.4799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 388f99ca-b908-4c6e-f34f-08dd623d3270
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7663
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

On chips that support user queues, setting this option
will disable kernel queues to be used to validate
user queues without kernel queues.

Reviewed-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 87062c1adcdf7..45437a8f29d3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -270,6 +270,7 @@ extern int amdgpu_user_partt_mode;
 extern int amdgpu_agp;
 
 extern int amdgpu_wbrf;
+extern int amdgpu_disable_kq;
 
 #define AMDGPU_VM_MAX_NUM_CTX			4096
 #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index ba8111169fa99..f50a25fb60376 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -238,6 +238,7 @@ int amdgpu_agp = -1; /* auto */
 int amdgpu_wbrf = -1;
 int amdgpu_damage_clips = -1; /* auto */
 int amdgpu_umsch_mm_fwlog;
+int amdgpu_disable_kq = -1;
 
 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
@@ -1084,6 +1085,14 @@ MODULE_PARM_DESC(wbrf,
 	"Enable Wifi RFI interference mitigation (0 = disabled, 1 = enabled, -1 = auto(default)");
 module_param_named(wbrf, amdgpu_wbrf, int, 0444);
 
+/**
+ * DOC: disable_kq (int)
+ * Disable kernel queues on systems that support user queues.
+ * (0 = kernel queues enabled, 1 = kernel queues disabled, -1 = auto (default setting))
+ */
+MODULE_PARM_DESC(disable_kq, "Disable kernel queues (-1 = auto (default), 0 = enable KQ, 1 = disable KQ)");
+module_param_named(disable_kq, amdgpu_disable_kq, int, 0444);
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
-- 
2.48.1

