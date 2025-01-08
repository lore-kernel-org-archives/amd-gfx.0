Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCEAFE77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 15:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 786F510EBEB;
	Wed,  8 Jan 2025 15:18:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="biQTFoZ/";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF3F410EBF0
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 15:18:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZDytJjY2k+d4RWabHK/KQJj9MIUDmC4GNoqAe6RhRneAOgoJ9r7PcjDsIaUmi0RugsdKgajg7KDsQSmcj+WP4r3XE2XEySOfSFFWKmPkril9RhlZYI6zXVs5TRqQ/WZI7iph5gSHWTvHSIvPMhxlWMrP4CebINB6gWE+bs5TMs2OhtqfwB5kvDoHCVJWhEF0o4UwR1FuDhp5WL3mi+drtvAPPOcmsAr6VLCnHBl0cvqYOT+Nk9ml642uTkqVLme7wICHOxEvu0IRq7mYhDJ9d4vZoZgX/SiTyfe7T3dW1yjDJJgHeAlHgmxtuAGnzUOYfwHoa4tz/sfrfLvJEWz0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHAHtkZnySVGaRG3g00zuDSgQmm/27tYHpKGrmpr2W4=;
 b=foeBYEeEZMSqrRVrrAA9A4fQrEr9ltUHYjOq8/BplcIXncA39iIrm6ItBJFJ+tcodVddCrgeuELT4VeuR/Bu55zXo/ab2Cjs9LjdjwiLBMFFDHiCIPSENr93MR1ANytm+PV3ZIwReakosddTSlF3sb5+Dj/nfC/t9+bc+oPpoHgIURh/YVuHSMRr9Ff/6jrcsV4sVD5flgpE+ExJx/pFVbgn0oNy+QC5mW8NUEYUrhhPZMi8YdW4OLxuqYs9PbuRh39gBLLao1VzH1BsOmRywi70dGx+PUJVKf+iM7Qz1k1+L6JPvuiLOkfpXmNrzu5bKyFTEmKJDp80lFKx2gwPWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHAHtkZnySVGaRG3g00zuDSgQmm/27tYHpKGrmpr2W4=;
 b=biQTFoZ/Uf/JdbeJ5z4muuQkZ54LzcP+HMHBWgg5lbbOSogB9gWbduVuRAKzJRf7BWPvA14bXg1mnqoRkLYo9vKxTGMuPwXY29KX/sjfidKljK6r53H2RQtjSR7Xu2E6DVxFDmRys6623BHIkzGiUppMKgMuyo8A9JjQODRdsl0=
Received: from MN2PR16CA0037.namprd16.prod.outlook.com (2603:10b6:208:234::6)
 by MN2PR12MB4174.namprd12.prod.outlook.com (2603:10b6:208:15f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 15:18:39 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:208:234:cafe::e3) by MN2PR16CA0037.outlook.office365.com
 (2603:10b6:208:234::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Wed,
 8 Jan 2025 15:18:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.0 via Frontend Transport; Wed, 8 Jan 2025 15:18:39 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Jan
 2025 09:18:38 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, Kent Russell <kent.russell@amd.com>
Subject: [PATCH] drm/amdgpu: Mark debug KFD module params as unsafe
Date: Wed, 8 Jan 2025 10:18:29 -0500
Message-ID: <20250108151829.1495321-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|MN2PR12MB4174:EE_
X-MS-Office365-Filtering-Correlation-Id: 589e4c94-3461-4e8c-2791-08dd2ff7baa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zgXyPUC/g9e5IBvtAvo1SCMPL5Ev6kXB+V9YwxxJ0wbnaKEhyG1aOwZcYtNl?=
 =?us-ascii?Q?IYtlksv2FuihWtqsLl0TCacd8YzefMrkGlminkYsLQSI4hCPInkz00lddSZV?=
 =?us-ascii?Q?5dovqSXlOSRjM6NxH13tyWPnijSaXCf9DTNodsEpkozl3zwxLhd70164AKuY?=
 =?us-ascii?Q?MM6aAfDwFy3zalqQkQoLFIBXdIRwwFOUWuz5FYa5foVPZS5dQbfj+8aTPKqF?=
 =?us-ascii?Q?uXWtm/B2Qb1o6B27cM6pLnXffyIFZmKiUQ5s6nDBzbAzqSMF+zaKckbE7vLr?=
 =?us-ascii?Q?1eyp83YIc3+i3+ObEySzSfcHXos7iVAOleOlK1eBWwIoN6IuJB6n2g/F+zw4?=
 =?us-ascii?Q?4vr6VpCppQ61G/aZkRyDwjDesqL8y+RQz8ACI3y5rst2mKYgUvFYL8xwiyqI?=
 =?us-ascii?Q?LGWTWYJ9rLmwkYWhMiaoYeyUKZvq6dQb+lyWoG4bCg6DhQBaO11l4PRy5pvm?=
 =?us-ascii?Q?yD7rQa+hnXL5bfSptNpX01Ba2KqnRn2iCI8FJwmEpaEGfNOAudUOU8EfgRZs?=
 =?us-ascii?Q?52+Gz2oPa6CCqKrBBpRaILoWFaINXKz04v9Sgs1fsmKFjXykg36NUXc+wpG8?=
 =?us-ascii?Q?pINB8trCIAeXfOqZnkm28dG0KVZ//Tcet5sMfoFI7Rj6bcFO8/jYhOrdGptj?=
 =?us-ascii?Q?HJCTUYcmeO1Ndiyk67egZcrALyrs+B25Ml3A/wN9YBmEPB3zhesWReH6ksuD?=
 =?us-ascii?Q?klIo/sPGmpuAeoR5DE32FHqKUjPLSZZMc5JGGX1Q+lYHWLIAjn4xFtpZ3wId?=
 =?us-ascii?Q?nieX1OrHIpt9zwKXKE3kcj5eGqDhGdFUU4AKVvvLHJJFjNFD6+ppAt5i+EvU?=
 =?us-ascii?Q?m8DHpmcSj97BGYTvpmETPsWign3sbflKMKoOHzYZx3yET4bFVL6nLBTVqBI+?=
 =?us-ascii?Q?9Dy4m6sQLKAYiD6fmtvwM/i3cDU5EQMMeiewBKFGPcAPZnNlDUFFSFjTnQFZ?=
 =?us-ascii?Q?pFmzanJRGRC43h+BEfx0UNYyhUKI91X8D+yI3AXdTT+KbtXHDdQ2UJzrDE0k?=
 =?us-ascii?Q?upKUfiiE5Bo/ny69v1PRlUl2tKQ17MwWiP+HRXPhZ84T8Zm8QiQGjCZgo8d1?=
 =?us-ascii?Q?H5FrOvxUFDmj/Efo5jxD6YM2uRdFK0gLv01GMQP4d6+ldbmlls9nyf/cBtx+?=
 =?us-ascii?Q?3xmH82SaEdmqQ8jrPbCWE/cix0s1Oe6KJdlilqEdal3XdFB8xontK1Ix4ifp?=
 =?us-ascii?Q?eet7PpyqwhIfld6ByJqsyTGW9jazt3Lqs7nQE8uvJ1b53dL5s13rSvPTk9x0?=
 =?us-ascii?Q?ZoJCo65U5BeMILuTnwnAgc/w3lNO+8X81pTux3dHooiXTB0KNrzG5vDce1sW?=
 =?us-ascii?Q?sGfnRgtllVG81o4vubjTZaSqUHh0djhslOojaQB5y9v0SjOpMGnFei1Jot+K?=
 =?us-ascii?Q?c0YO8hYUxB6MU+zEj+6vo9Unw56BrUlODCFjuzQyn8vCZAgmE893E2SY562O?=
 =?us-ascii?Q?X/u+gLOmhepjQz51WNmb/U3hIFOo3jHhB5VlpDhogcp1zJC48Cb2vz3krPNF?=
 =?us-ascii?Q?XtTVct7QchNp8cs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 15:18:39.0772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 589e4c94-3461-4e8c-2791-08dd2ff7baa9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4174
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

Mark options only meant to be used for debugging as unsafe so that the
kernel is tainted when they are used.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index acb9dc3705ac..1371b56beba2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -751,7 +751,7 @@ module_param_named(use_xgmi_p2p, amdgpu_use_xgmi_p2p, int, 0444);
  * assigns queues to HQDs.
  */
 int sched_policy = KFD_SCHED_POLICY_HWS;
-module_param(sched_policy, int, 0444);
+module_param_unsafe(sched_policy, int, 0444);
 MODULE_PARM_DESC(sched_policy,
 	"Scheduling policy (0 = HWS (Default), 1 = HWS without over-subscription, 2 = Non-HWS (Used for debugging only)");
 
@@ -801,7 +801,7 @@ MODULE_PARM_DESC(send_sigterm,
  * Setting 1 enables halt on hang.
  */
 int halt_if_hws_hang;
-module_param(halt_if_hws_hang, int, 0644);
+module_param_unsafe(halt_if_hws_hang, int, 0644);
 MODULE_PARM_DESC(halt_if_hws_hang, "Halt if HWS hang is detected (0 = off (default), 1 = on)");
 
 /**
@@ -810,7 +810,7 @@ MODULE_PARM_DESC(halt_if_hws_hang, "Halt if HWS hang is detected (0 = off (defau
  * check says. Default value: false (rely on MEC2 firmware version check).
  */
 bool hws_gws_support;
-module_param(hws_gws_support, bool, 0444);
+module_param_unsafe(hws_gws_support, bool, 0444);
 MODULE_PARM_DESC(hws_gws_support, "Assume MEC2 FW supports GWS barriers (false = rely on FW version check (Default), true = force supported)");
 
 /**
@@ -843,7 +843,7 @@ MODULE_PARM_DESC(no_system_mem_limit, "disable system memory limit (false = defa
  */
 int amdgpu_no_queue_eviction_on_vm_fault;
 MODULE_PARM_DESC(no_queue_eviction_on_vm_fault, "No queue eviction on VM fault (0 = queue eviction, 1 = no queue eviction)");
-module_param_named(no_queue_eviction_on_vm_fault, amdgpu_no_queue_eviction_on_vm_fault, int, 0444);
+module_param_named_unsafe(no_queue_eviction_on_vm_fault, amdgpu_no_queue_eviction_on_vm_fault, int, 0444);
 #endif
 
 /**
@@ -851,7 +851,7 @@ module_param_named(no_queue_eviction_on_vm_fault, amdgpu_no_queue_eviction_on_vm
  */
 int amdgpu_mtype_local;
 MODULE_PARM_DESC(mtype_local, "MTYPE for local memory (0 = MTYPE_RW (default), 1 = MTYPE_NC, 2 = MTYPE_CC)");
-module_param_named(mtype_local, amdgpu_mtype_local, int, 0444);
+module_param_named_unsafe(mtype_local, amdgpu_mtype_local, int, 0444);
 
 /**
  * DOC: pcie_p2p (bool)
-- 
2.43.0

