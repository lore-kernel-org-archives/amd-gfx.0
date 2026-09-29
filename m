Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A59D9CA5FA5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 08:54:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AE1910E113;
	Tue, 29 Sep 2026 08:54:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rATgiF5a";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011062.outbound.protection.outlook.com [52.101.57.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A33B10E113
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 08:54:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3tYTglyfaNm4IhPV0ivWMdeRx6eE/4iVB8fq/jo6GWE9m5CgNXNrgVcEm6iFY+5w+jUZn3g38doZ7YrKgl2IMZzXhPjP8+Vk4dP3SWS3P/m/DSVQxbNN03WlMxSh2dWIjZeY4kJ54fvpoUr6MzvVdBg8/HpcClUEGQcXuGOGXSwOWoV6y2J5JTlFOyUAOzPdYA32CcBYObeUU4gKIbZ8bCFZzre2haImuVkTHS8hDy3WxozseFgdQ8jibHhrVzB1qhGFsIwCuLq+sz6jgE/wS1NsRVcQFyPcrqvRu5GwgBZQlTz2jOrI/Oqksv/gBj2h/ZO+BCzFBt8JqF7w2VytQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzZqcQ0BqQ/SQvjR67YZxeDSGsbVUJ2y5Kng+SHS7Io=;
 b=UmKAFUzC8W6XtfsBtbnEaLl9OCh/anDdk9vKHDWwLmFTACfKAVdtqEiQjFmAf3OYp/NUzgGXNXk617x2IGrGqDbaqVBCJ3FQHrbDMNwF+1JSq6h3r+LoTkR8Xv3I8XlZ1X5yUPSV9qV3PM/C9+NH26PlhiUdI4NOdWli3jMKqt/WJhZcUXsnhbxUQ/8/ZseK6F8wsei3zakcQs4gnNZk9/aaZiDByFtQ4BSA+V7mOZmgOZbLfS3JbcqE5qBBEbBcnWCd+9J7O2khANOz+HbXs3bxU2f+3vaaIp1OitCNx0R+Q+3lZv0dbLB0m7yWbhQ9qX7HjpXyFIKLQxlOUE8hgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzZqcQ0BqQ/SQvjR67YZxeDSGsbVUJ2y5Kng+SHS7Io=;
 b=rATgiF5aQ62lOX+eHzDCx3WsJE3rm7hwt9c3DMXCgHjCKok4Uv0ljIA8+bI7Xq+yUutNxGgjT/BnI9gkIDrCwQ2GAhoQ2ZvC9uFPnLekG3GEMwAQDbP/WpaCIFiGEcaQfoX+SIyvf46mw8pmYdsPlJCVPNI2mrp+wUuLmwEsPHg=
Received: from SJ0PR05CA0021.namprd05.prod.outlook.com (2603:10b6:a03:33b::26)
 by SN7PR12MB7978.namprd12.prod.outlook.com (2603:10b6:806:34b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 08:54:01 +0000
Received: from BY1PEPF00026957.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::1d) by SJ0PR05CA0021.outlook.office365.com
 (2603:10b6:a03:33b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.11 via Frontend Transport; Tue,
 29 Sep 2026 08:54:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF00026957.mail.protection.outlook.com (10.167.244.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 08:54:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 03:54:00 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 03:53:59 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 29 Sep 2026 03:53:58 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <prike.liang@amd.com>, <sukhatri@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/userq: reject mappings without a backing BO
Date: Tue, 29 Sep 2026 16:53:50 +0800
Message-ID: <20260929085357.3900280-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026957:EE_|SN7PR12MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d92386e-e219-4532-6583-08df1e0734e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: eOxZLaXD3M1wtzfMFNCajvMFBBImGWMbH6oRrLc8qOQ9mnQ3UnX9bJkUbmn7of1EIuMo26ZyIakrBILvvMiGMIpcIjwJ9Kke1+7U7P3YlWoGUak75ciQ0YjchlwPR+4Ze6p2gg4JyPVn/Bn9WrEDKilwvSxD+bMDiEFW/aXseNPyNCcsYA6sZZKQAw3BwTqSgIzLaN3lpZL85lvuUZpHhwWO2W4688S62zsIdrvgyCyYcwrljMtxNeb5HGJ36wssIa2EegwGwptXznZ1xxjU64c2/+N/ZnnM5TqrV97DzDqkvWXr3aUDSOIFlFRy9h2htRyyDOpEmro+2K5Bg0LyincDQBSvbwY5zPm7JSpJHyyxredCT5ow8h8QolPUwhpF5TnlpreRs7cu5DCNJ7pjStc7pGihO5hH3zWhFWdCDe5yrB9QyMfexI/ojq2XeGkFUpPIHyD3GBM20Sa7BOcKmOeppvk3R2U6iudkyzEkYDC63W54ckIDXoD71zSVFBwrnhZ8zqqjWM+bvfis4Lbr63J2Y+n91wYOvY7CvgBk4DRhGNo7em52ByyixuWcvFgJaNhQVDtu+R13++kVLcUtR8tVaWvqTcd+0dJ6wk8gmgS2dwOEIjZwn0zdc3j3Ttq0z3wmLfh6n7rrvYgXRBQLkCZPSSS9G+uWmAakcYa4wB2WzPavmsTFLcuXx9U6G51jlVu8TWkCPJaHTcc47tqaPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j1M5VpZ4uZ4YtZaoBQCIl5c6j/RphxCrNZl1BNS6GR3iU0hGQveBG7Ui0cS+pJep5r1NyOs76UmTKLkn/q3DAp67uyjLTP17cILSTRcJKFw0ZGOuOXr7/Mt7FXWHLl/f4Yfrc1KsCs6p/Bd2n3B7iOwHbqjAZo+TvsqjfBvJzdHU1+td+P/emkK96ZkyTNOdCjTIhGfeSQHK0husKELQjHg54B/3DwetZJJYXtUELXkSv2z7CFW7K0ezS3ebwa//W5J+F8Aw87wNN0v/TmWqFsKfuHrmS6inRwFbstPxF7FEJKSWzsam8Xxq4arnhzYFW6z25GAMZFqjpx4cBGdT+gtTHYZ4vElowpHnp5R7qj6R31Dbb7Ag1s6ftftjn+deOBSwLCawy1XDX0DArCcdespHsoE/UPSqc1pOfneKAdPFpktG1wuQdVt6F0UlTJQX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 08:54:01.0060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d92386e-e219-4532-6583-08df1e0734e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026957.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7978
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

PRT mappings have a bo_va but no backing BO. Reject them when validating
queue buffers and when looking up the WPTR for MES or USERQ_SIGNAL, before
passing the BO to the reservation or CPU mapping helpers.

Repeat the check at the WPTR lookups because the VM reservation is dropped
between initial validation and use.

Without this, pointing a user queue's WPTR at a PRT (sparse) VA mapping
makes mes_userq_create_wptr_mapping() dereference a NULL bo (base.bo) and
oops in the reservation helper:

  BUG: kernel NULL pointer dereference, address: 0000000000000158
  Oops: 0000 [#1] SMP NOPTI
  CPU: 0 UID: 0 PID: 4558 Comm: amd_fuzzing Tainted: G            E       7.1.0+
  RIP: 0010:drm_exec_lock_obj+0x2b/0x140 [drm_exec]
  CR2: 0000000000000158
  Call Trace:
   drm_exec_prepare_obj+0x25/0x60 [drm_exec]
   mes_userq_create_wptr_mapping+0xc4/0x1c0 [amdgpu]
   mes_userq_mqd_create+0x351/0x870 [amdgpu]
   amdgpu_userq_ioctl+0x7ef/0xf80 [amdgpu]
   drm_ioctl_kernel+0xac/0x110 [drm]
   drm_ioctl+0x2c6/0x5b0 [drm]
   amdgpu_drm_ioctl+0x4f/0x90 [amdgpu]
   __x64_sys_ioctl+0xa0/0xf0
   do_syscall_64+0xa3/0x4d0

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c       | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 75d5ceaa53c6..63875761dfac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -253,7 +253,7 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 		return -EINVAL;
 
 	va_map = amdgpu_vm_bo_lookup_mapping(vm, start_addr);
-	if (!va_map)
+	if (!va_map || !va_map->bo_va->base.bo)
 		return -EINVAL;
 
 	/* Lookup guarantees start_addr is mapped; ensure full span is covered. */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index b885e90ec5f5..118db0306559 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -386,7 +386,7 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu_device *adev,
 			goto lock_error;
 
 		mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, addr);
-		if (!mapping) {
+		if (!mapping || !mapping->bo_va->base.bo) {
 			ret = -EINVAL;
 			goto lock_error;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 1b06a4618125..e6c167a39d44 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -54,7 +54,7 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
 			goto fail_lock;
 
 		wptr_mapping = amdgpu_vm_bo_lookup_mapping(vm, wptr);
-		if (!wptr_mapping) {
+		if (!wptr_mapping || !wptr_mapping->bo_va->base.bo) {
 			ret = -EINVAL;
 			goto fail_lock;
 		}
-- 
2.50.1

