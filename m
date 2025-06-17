Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFCAC71157
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 08:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4037510E54F;
	Tue, 17 Jun 2025 08:02:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DIKyDUJW";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D569310E535
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 08:02:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rR0taqzoygMkAaDgJllhliDhCgWU/v/YqWsEwxgYbDsfAiaZqEYbNld3Ys/OpQG9NRVQ560neU3m8q16apVnhKk7/HVtrwPIXN3f7lcEroy3265YSc8C4BB8mZpMiiC+RHEacDnsP0x5hUuagIRau1WZbusj+wUzATMCthjXy2KizuHCq3BmxPxeKZU55H2KnGM2k9P2b/oNI9z4yL4+XYXZSpCd4Ro528ZJvDaNRl/gse8KFlCIYMuCth/qzHPssjR1DAgB87gOLvric3p19I/OZO/zPyY3EkJ1gEFBhVz+1H203cUOel9/UKxlPfm4Y3iJvk1pFiYVLB86f8G1Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZYxdg2z0Gd8dYfHDKhwaypdxvR973xSPJXYAQuV4rM=;
 b=OW7h7MXOuV+kbMV00U2GTC+0Cji25i7kNpEwXwCB7wMYJpNkJI8/VrDqXIp/+fRwt4qIZvFIZKqDTVaAjkXYONp+qfoVD+r1zAphViqvrjxa3o69hS9DZJUMz9btzzWVJpwtLdKslC3PDIJ/pVaXHrd1eqCrNewjfON8cKk39U7ruTzq0E06oTPElHtU/vMpIGrXD19Ze9bPl4lzzlAoW3S4MC7Sn+8Zpbt70nJ/U3GdvNA+x+s80dBgbQbuTfvHNpIftT/lbAsuH+woYMdBxotE5l4Lk3AGl1lU1Wv1jTe+53LrwZFL5Cckd6JF/x6LzJ+V18MOs9xUUTYmI8FujQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZYxdg2z0Gd8dYfHDKhwaypdxvR973xSPJXYAQuV4rM=;
 b=DIKyDUJWImZjo99A1WYZRi+X15DyVOo7KFLZM0bWThEBBPoQUMCRRSV0JZU0MDC0KM4XyrEwhZbK0XPt2iSNIvWmcS3fc8CY0bojrRpZBn6+QyUuDfGRJo5sIHvuO5qbXIVyWuzh9LU0Al2/bSMB5sQIJZanQkWIBSPlVCvlXf4=
Received: from BYAPR11CA0065.namprd11.prod.outlook.com (2603:10b6:a03:80::42)
 by SJ2PR12MB8158.namprd12.prod.outlook.com (2603:10b6:a03:4f7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 08:02:22 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::42) by BYAPR11CA0065.outlook.office365.com
 (2603:10b6:a03:80::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Tue,
 17 Jun 2025 08:02:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 08:02:22 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Jun
 2025 03:02:20 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2 07/11] drm/amdgpu: add user queue vm identifier
Date: Tue, 17 Jun 2025 16:01:47 +0800
Message-ID: <20250617080151.1093481-7-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617080151.1093481-1-Prike.Liang@amd.com>
References: <20250617080151.1093481-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|SJ2PR12MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: afaa5a65-cf97-4978-edd5-08ddad754a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KC1wCBTWjyGlmq20cl6CRZyIneOpcJBkZjkxNgp/ZETTx71rwnCqnyV80nA3?=
 =?us-ascii?Q?zNNvmVDqFRY8YqcL4XuPOKenVZnJL3K8+5MJczuH4slf6lznZxioGko58vcJ?=
 =?us-ascii?Q?hUEYyIDlCigzWsDRTVbp4+Jw+QvSyjhdKvQa0oEDf9xMMJu9sSywFgJOnTgT?=
 =?us-ascii?Q?G1/R+DPrv7fLn3RTAsnMCMak+N3psQQ/AZtEOB/vq+lcy2iz5xipTB06+/hN?=
 =?us-ascii?Q?ivRbHHFXb1HtF9zedlqzT6jqGr6tIthiB+ARqW96bas4U+RmNPNU++a7Hxtu?=
 =?us-ascii?Q?4rl951Zq/sOdCq3tdDZuPLRkf3TK7RpfEJC3PG2loXEi1npa50WiTv7K74JQ?=
 =?us-ascii?Q?PJZEzrKw6Pve1FotgD+miKTax8CTa/jQkYK7E3Yc7JmBqqnMd2Wf6/tzEsgq?=
 =?us-ascii?Q?u+/mX8LUzMXB0210OWv66tjfuSoP32clNpaP2gq6tGq2bBz6dzVsIP55mKUO?=
 =?us-ascii?Q?nTCpZjPRTuEeR4n0zERpekBIKs/xsdIIQmLx5FS4BiQFkX7UrUCTrTUjdWLk?=
 =?us-ascii?Q?VSqqSXF3pkzk4PXGR9MbADv9usown3cofSg3BCzUsWT3UzAWHNUiGIAZLmxi?=
 =?us-ascii?Q?9+XRpAmLR/5P5oVhETCkKJtdLj1trSDpiRfSq6a5982TVsqdu/LgWoKlPUo7?=
 =?us-ascii?Q?K6LanRf4QlhtpI0wOQZtMfW+MK3ab05FDY8hsYMAFk4fVx+oJUIhRNPXMyvE?=
 =?us-ascii?Q?WY2j087jCwsGNc6QxN9htLvg5JQUvoiFgSvYPgNxZMyjU6ENsEnzDcmSovjj?=
 =?us-ascii?Q?6cWSo547jmhSS7DJgXfVKcp812bLRjw9Ign/ZM6yGXURSnA7iA+kTkz2IbHO?=
 =?us-ascii?Q?iqwpRKpzKJytKlfpMqRO4DL9rq5iLy8DcmjSbCe988nxDIgqOZj7ouU+gjM6?=
 =?us-ascii?Q?AtzFInsRQKU8CegpmyCQPOgA1/NiR/ouLgp7Bw5rzZPsZlRhlqdwmrxlY7Ps?=
 =?us-ascii?Q?JbWeCYg2LS9RUYghrqEagmcbd1uEJkr0N3Fgi62Qvz7K//OK54CEupbbWbxy?=
 =?us-ascii?Q?xdfPwADkQFHpMQb2bykO/rG+tTAwqIBZ2ZLwoTZp5zRwHq9VUsgeMBVnrpW5?=
 =?us-ascii?Q?UyjzhaFQiZr3kn315teFMufaGHxTDgMxP9DiZtBTVKF7u4TzZ7fMhUQcrw3Z?=
 =?us-ascii?Q?tRc2vkeUFyKPCx9XK3V0v8ofsxu6UIuiSA3URk09sx5Tyn4+8nMws0iqOPpS?=
 =?us-ascii?Q?fdSokozMzdWr7es9G1HJSnpZvIWfvHHomeswR34BtbwMmZDi0j5nm/c1hNwZ?=
 =?us-ascii?Q?0moU9dg3lIDwAL2SzsBxL8COcNor+ir3/U8dAE80Zmmjl8Qfo6n29dkFwS3Z?=
 =?us-ascii?Q?idrtaYqbklOMSkP9SNy/TaeSh90ymwaK2Dj1VHjAEpO3vkScg6loYqA88cU3?=
 =?us-ascii?Q?Z8N2QtocnMWto8cZxnoCBaHaSmoBqVEfsXLTSh8ljS5BpiGrQvEpnUJ04FyY?=
 =?us-ascii?Q?5MrkiS7u7IaU5LT354/wX9edK8dzzI8RRIISJYdq0Q75XtOBGyJA6UgIwgCy?=
 =?us-ascii?Q?f3SaIRufEhQ6tfvrIdHC01p1+Tx0kxCFtb1r?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 08:02:22.3354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afaa5a65-cf97-4978-edd5-08ddad754a3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8158
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

Add a user queue vm identifier for each userqueue
kms opt accessing.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 2a7ec7daf3da..4b00d9b16046 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -483,6 +483,8 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
+	fpriv->vm.is_userq_context = false;
+
 	return r;
 }
 
@@ -517,6 +519,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		(args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK) >>
 		AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_SHIFT;
 
+	fpriv->vm.is_userq_context = true;
+
 	r = amdgpu_userq_priority_permit(filp, priority);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3911c78f8282..5e075e8f0ca3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2560,7 +2560,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	ttm_lru_bulk_move_init(&vm->lru_bulk_move);
 
 	vm->is_compute_context = false;
-
+	vm->is_userq_context = false;
 	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
 				    AMDGPU_VM_USE_CPU_FOR_GFX);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index f3ad687125ad..1e3c0f85c98e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -422,7 +422,7 @@ struct amdgpu_vm {
 	struct ttm_lru_bulk_move lru_bulk_move;
 	/* Flag to indicate if VM is used for compute */
 	bool			is_compute_context;
-
+	bool			is_userq_context;
 	/* Memory partition number, -1 means any partition */
 	int8_t			mem_id;
 
-- 
2.34.1

