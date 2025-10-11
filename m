Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6699CCD183
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Oct 2025 07:50:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2639D10E2DE;
	Sat, 11 Oct 2025 07:50:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EQyWkdyK";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013008.outbound.protection.outlook.com
 [40.93.196.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CC9E10E2DE
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Oct 2025 07:50:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pc3AYIGXNwpAfLT47SzqhE+ItDHHT8TUDp9zZjfJLrFPOcnEsQ7ULnw90A5ZNBkh7P8xemM2S3trR/TkdPkLuGIZemTwBM/4dYuA8O6c1rEPuBp6SQNBtZGSVR80E99Fz+mj9Edwac0kYozglqmKcrwOFxk1z8YXgkQZTH8sH/L+7R+l8ccj5a1r9Dhc26PnN5C+vVRDJMx1PN3ATPy56FDi3tSzrerWvjMqjsEyPEWwaCAXKgqM6trZZvlwbjjM13IIrYeFMysHRk7mYJj0pyzb3NMWv+ivPShC4yeMXHYAdzmAqKGdoCTYAGVDXW/jE2lezo+5qC5yJntcT/b7Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiZ0tRQTwnJfl5bPQEmKIkN7M2svPAjEqeaTBD8m9xE=;
 b=cGBsuIS+OZuSXxX6vNGKiQt+67P5xBF39hfq4KiiL26PPqgdf/yp8Di2pFalMOSMzsYORmDkabOjXLaC7XWhq1qF68wzdlYoO5ZYKRcqIjiq0VgElwk+kGwL4AvG3fZ71zl+6PAV067z7/Ldg/fWb+2W7+ObsIKzPzfZtf2x25kBOn9ZLJ+orXfJ8UFnSUQXfe0laojDdI7Qecv8xwQvMzeR9R1oBI5eVNmzRG7giHUINnKm5sDRszykLCAi1/uM7V+Se2vPC146dheNmFK7Q0hcyAvwzqcziLtq24Jub9uBWant7YsRiLiyylpvjwZCrbDPds8y+Lbh31UaQcbjAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiZ0tRQTwnJfl5bPQEmKIkN7M2svPAjEqeaTBD8m9xE=;
 b=EQyWkdyKW60MYlwbDExiqUpYZqIzLDGqvIEgauvf28hIkODnuyQ6DUsSYopcubO5gAtotR8iCiK6n3uJgFu3xXL2jDYc4/Qm5Fo2f+AZXE93X6KPbL8rk0Tb5gbe8mTa149yyo7TifnFUs6/I9Cn8quLnXw8kU5KMaQwAAFpXAY=
Received: from CH0PR03CA0082.namprd03.prod.outlook.com (2603:10b6:610:cc::27)
 by SA5PPF06C91DA0C.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8c4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Sat, 11 Oct
 2025 07:50:00 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::4c) by CH0PR03CA0082.outlook.office365.com
 (2603:10b6:610:cc::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.11 via Frontend Transport; Sat,
 11 Oct 2025 07:49:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Sat, 11 Oct 2025 07:49:59 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 11 Oct
 2025 00:49:57 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 3/9] drm/amdgpu: Intercept ras interrupts to ras module
Date: Sat, 11 Oct 2025 15:48:05 +0800
Message-ID: <20251011074811.533871-3-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251011074811.533871-1-YiPeng.Chai@amd.com>
References: <20251011074811.533871-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|SA5PPF06C91DA0C:EE_
X-MS-Office365-Filtering-Correlation-Id: fc206c8d-ee2d-493e-2867-08de089ac78a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?reZucLLPiW5uOoU2EHNZZY88My/JDVswrDjLBjpMdHng9amZ6ISgej6qUQDQ?=
 =?us-ascii?Q?OoCNFUtvXrGyBibvxiSd7BMdfGa5BezLM7IsIbHa4DVHqesZtsNhEWB4tJ7m?=
 =?us-ascii?Q?eDVGdlYIMpvDOCo8Oc4KZGI6IaBbh/Q3U9Lp/MfXk44umbavfWMnIU6QO0l6?=
 =?us-ascii?Q?2U553Lj8QmOrmoKEoGQ3qV/EyvvBUi7Ii49rp/G0w6XVOlt/wR92mULdnBbj?=
 =?us-ascii?Q?Zo1Vp328qAvFnCcEHGNv/K4LiCZYmmwfo65gQJIPqLgXVVw3mXEPctXw/opY?=
 =?us-ascii?Q?Ss7NfqTKbbR9Jx9aZww3eAVr2s/i3WWqGvVFp8hay/kwk8WGwXJwXthksjat?=
 =?us-ascii?Q?1anAy7gDpT2Y+Ya2+soZCeLFLcNrSuwvK3nrbrluzZiqVhL40OH79FjYEghO?=
 =?us-ascii?Q?yB0gJYA0I+9eJeEk8wAt4Yni76O3eYWWVShEWpstNCQyo4UIPFHpZSBaX3f7?=
 =?us-ascii?Q?IciDWqi6YTFaiRvAETW3/LqhvQQ4fxL37s2hCvMdiRbKvbQy2yrvHip4KVqA?=
 =?us-ascii?Q?JTir5CvR33BnvNyFJjAQXVouxfBmXoS3oeau3iUyXEcA4tJdilQHoQIO1G1u?=
 =?us-ascii?Q?OvqHjwPFXU1MjxZCfkiAkZ3xy5Uz/mRUN19lvmfljw3rfnY4AF7s7MwTLG1u?=
 =?us-ascii?Q?O3s1LBkPyAiaAXIhZtzcw/+/Eq9TUfvO4U/4cp4Yn28AKwE0jSoDHwoQcLMU?=
 =?us-ascii?Q?yM2dacrrJyrzusC/zaaa1gVqRsfU0Zu8dXfQEL9Y/XuzEfAST3dOXEMfODpC?=
 =?us-ascii?Q?yra4df9QfPiZwfrIv1+mE+TiDwKSunl1DTSn8z6MYhWM8x2s2RDNQ329fYjJ?=
 =?us-ascii?Q?0kVOiB2kvf2d8bs/mxAqjPBTuDPbYNnIbLWCystZOP40JXHh5w42VmrsJgLV?=
 =?us-ascii?Q?lHVhkiP9w+keIaeV/ef2TEqIlcVDSSpiR4lYrvcqDL/KoJLREoJ2HR6OKeBP?=
 =?us-ascii?Q?0MprdCbgL4qTSqmi8/nSdynkXkhuic6OfBeALHzLAKWWApt+Xm6rZDHT6dtY?=
 =?us-ascii?Q?uXz1PiECIPNNYKcAAEfsKgviUF282HAf9593ucq9Lg0NyD4ms0Fp1HNm6ed0?=
 =?us-ascii?Q?7YEV49BaDlAyuFxmhAmug6yzoRmJ3MssjdfRRVFoCmWGoNV+o0BvO9TqDPkC?=
 =?us-ascii?Q?jbMuH/s3xEiaU0uvQ9o1HA/lLbxCDla32+UO6y1SSx1InCiAaApDn1zjLbdb?=
 =?us-ascii?Q?eD0Q6xQrdwdWqssZ5ml4WsiwgHUqMOjrPRrTsTVWCpqQlqgFv3jE5V7asdVq?=
 =?us-ascii?Q?0U4YOOmNWxDhqP9HvRIXlUpxtFwc74xfXhMJbFgEC4n/Y2/TWJctU80lHBwv?=
 =?us-ascii?Q?XflRtqAm7CIuYVT+uYmzHlAm3OqrktGuM+w2UDvAfzDhZy2PJXJ1Kv/1XVD0?=
 =?us-ascii?Q?MB93pLs2VX3tCV+4kc/uGzZNcHAo6NcjjRvvhx5YAnJlfz3FkXrbk+1JHv0u?=
 =?us-ascii?Q?KVcOsF1CV2xG1KKPzITaFbnk5zFkic83oROb0pnuv3t9OpNxnx+ZC84Z2JJ5?=
 =?us-ascii?Q?p5zYsihmkKRFgNfTVpFgLKxfCxzLPNNUD6KjH9gh7Dnh/w+P3OLXnjNxebkP?=
 =?us-ascii?Q?5zlaCevC/RpUwoPCigY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 07:49:59.8351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc206c8d-ee2d-493e-2867-08de089ac78a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF06C91DA0C
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

Intercept ras interrupts to ras module.

V2:
  Change function names in ras module.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c       | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c          | 16 ++++++++++++++++
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c |  4 ++--
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h |  4 ++--
 4 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index a2879d2b7c8e..644f79f3c9af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -36,6 +36,7 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_umc.h"
 #include "amdgpu_reset.h"
+#include "amdgpu_ras_mgr.h"
 
 /* Total memory size in system memory and all GPU VRAM. Used to
  * estimate worst case amount of memory to reserve for page tables
@@ -746,6 +747,20 @@ void amdgpu_amdkfd_ras_pasid_poison_consumption_handler(struct amdgpu_device *ad
 				enum amdgpu_ras_block block, uint16_t pasid,
 				pasid_notify pasid_fn, void *data, uint32_t reset)
 {
+
+	if (amdgpu_uniras_enabled(adev)) {
+		struct ras_ih_info ih_info;
+
+		memset(&ih_info, 0, sizeof(ih_info));
+		ih_info.block = block;
+		ih_info.pasid = pasid;
+		ih_info.reset = reset;
+		ih_info.pasid_fn = pasid_fn;
+		ih_info.data = data;
+		amdgpu_ras_mgr_handle_consumer_interrupt(adev, &ih_info);
+		return;
+	}
+
 	amdgpu_umc_pasid_poison_handler(adev, block, pasid, pasid_fn, data, reset);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 3d63e4448ad2..025d8bcf02eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -41,6 +41,7 @@
 #include "atom.h"
 #include "amdgpu_reset.h"
 #include "amdgpu_psp.h"
+#include "amdgpu_ras_mgr.h"
 
 #ifdef CONFIG_X86_MCE_AMD
 #include <asm/mce.h>
@@ -2241,6 +2242,11 @@ void amdgpu_ras_interrupt_fatal_error_handler(struct amdgpu_device *adev)
 	    amdgpu_ras_is_err_state(adev, AMDGPU_RAS_BLOCK__ANY))
 		return;
 
+	if (amdgpu_uniras_enabled(adev)) {
+		amdgpu_ras_mgr_handle_fatal_interrupt(adev, NULL);
+		return;
+	}
+
 	if (adev->nbio.ras &&
 	    adev->nbio.ras->handle_ras_controller_intr_no_bifring)
 		adev->nbio.ras->handle_ras_controller_intr_no_bifring(adev);
@@ -2411,6 +2417,16 @@ int amdgpu_ras_interrupt_dispatch(struct amdgpu_device *adev,
 	struct ras_manager *obj;
 	struct ras_ih_data *data;
 
+	if (amdgpu_uniras_enabled(adev)) {
+		struct ras_ih_info ih_info;
+
+		memset(&ih_info, 0, sizeof(ih_info));
+		ih_info.block = info->head.block;
+		memcpy(&ih_info.iv_entry, info->entry, sizeof(struct amdgpu_iv_entry));
+
+		return amdgpu_ras_mgr_handle_controller_interrupt(adev, &ih_info);
+	}
+
 	obj = amdgpu_ras_find_obj(adev, &info->head);
 	if (!obj)
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index a038c87c045d..4f70f873b543 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -381,7 +381,7 @@ static const struct amd_ip_funcs ras_v1_0_ip_funcs = {
 	.hw_fini = amdgpu_ras_mgr_hw_fini,
 };
 
-int amdgpu_enable_unified_ras(struct amdgpu_device *adev, bool enable)
+int amdgpu_enable_uniras(struct amdgpu_device *adev, bool enable)
 {
 	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
 
@@ -395,7 +395,7 @@ int amdgpu_enable_unified_ras(struct amdgpu_device *adev, bool enable)
 	return ras_core_set_status(ras_mgr->ras_core, enable);
 }
 
-bool amdgpu_unified_ras_enabled(struct amdgpu_device *adev)
+bool amdgpu_uniras_enabled(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
 
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
index fa761de381c1..8d6a1873b666 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
@@ -56,8 +56,8 @@ struct amdgpu_ras_mgr {
 
 struct amdgpu_ras_mgr *amdgpu_ras_mgr_get_context(
 			struct amdgpu_device *adev);
-int amdgpu_enable_unified_ras(struct amdgpu_device *adev, bool enable);
-bool amdgpu_unified_ras_enabled(struct amdgpu_device *adev);
+int amdgpu_enable_uniras(struct amdgpu_device *adev, bool enable);
+bool amdgpu_uniras_enabled(struct amdgpu_device *adev);
 int amdgpu_ras_mgr_handle_fatal_interrupt(struct amdgpu_device *adev, void *data);
 int amdgpu_ras_mgr_handle_controller_interrupt(struct amdgpu_device *adev, void *data);
 int amdgpu_ras_mgr_handle_consumer_interrupt(struct amdgpu_device *adev, void *data);
-- 
2.34.1

