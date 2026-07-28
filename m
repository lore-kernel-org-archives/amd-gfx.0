Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E563C54F4C
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2026 07:36:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C860A10E7EC;
	Tue, 28 Jul 2026 07:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IJLNHNqt";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10E4810E7F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 07:36:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ElfVK2kN1s82O4juCIXLTW7oOFkIdFo8z2HKW5kz0D5QT9VimnLjN1sCmGF7i5y29QN0llZI5treJFaVssL+UgzEmWDT17sAOGEROUwy2w6STSTVCfZZj28cXAbIAnPHsyl/W/ImjVz4luBJLpHedc1zbHg+d+rqTfrNay+SnYqV3KRBrnxxen2YmCRz8GKQ4IFfeBlMiAsIID1lU2dXI64hMpWnqSeDYihbi4B2kXW6qgDGSiqzB1GLTfHzKYe1yt+4pwv5PTfyEZvmZjkAS7bA7PS9ZmHyHI96JvJsMp6vSWrx/C5jM0SWGyvELekBrQG+x8BgTdzSOJ0aGJ4STQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwZlvCLM8hjaS6gJGUlTGnsWr4xpkKlkX6hyJ7bxXT4=;
 b=N/Kwm9TxYp+2xShbLPEE4fD0S4/KYsuUhHle6Xvw0J6t79NsN1lVQpIOY4B85cenFKMj3ks5u8c3R9qdVVe+edin1FfxT5+UTcs4mEiRw/bYv3vdkRMuyDmpIr2bk4R2TyhqapjwDMj/bPhsSKlzccq9F3zwpMB5sns7fIfL7VcXxx5VVErOw9YK9UTk2pep5mgAY762zVQ768EoqHOLFoKGdkm4QaZpVAxM/sioOlOCZj3XkcGDxQAIkqRO8vJO3dz4YzVq6XovCa2GwZGl4GsFizgt+02Hr+kOO4Hv5P3kCKaHrNN71ZLFoLfIURTl8U1LueSi6OMQv8/Yr8kSZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwZlvCLM8hjaS6gJGUlTGnsWr4xpkKlkX6hyJ7bxXT4=;
 b=IJLNHNqtnvTFPvT++tTlPvEpXTpFkR59Bs6lgxdl2QRbceQ/lIRipoCw3dhzUzJPIQrYyXTzdAk8KzDOGD5rRCvKRz14WOvmfEMVnDO+daJxWyXcHJo8Ylw1cXve6HSxU/TZLmzbpkKSY6vKkJcH/8kDbOEP9cMYkQ69H+QwEUA=
Received: from SJ0PR13CA0011.namprd13.prod.outlook.com (2603:10b6:a03:2c0::16)
 by DM6PR12MB4108.namprd12.prod.outlook.com (2603:10b6:5:220::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 07:36:24 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::86) by SJ0PR13CA0011.outlook.office365.com
 (2603:10b6:a03:2c0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 07:36:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 07:36:23 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 02:36:23 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 00:36:23 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 28 Jul 2026 02:36:21 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2] drm/amdgpu: fix NULL pointer deref in
 amdgpu_vm_handle_moved for BO-less mappings
Date: Tue, 28 Jul 2026 15:34:04 +0800
Message-ID: <20260728073621.79910-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|DM6PR12MB4108:EE_
X-MS-Office365-Filtering-Correlation-Id: 0235316a-3af9-4452-9d46-08deec7aece6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|18002099003|10067099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: l+CA9m1Hqb54M6FYhoMwejQeOerhRfu2bU8G9Xuxo7q11b1SfijPk8DrAvNw7yqSrju+LAaaocAyGK94zl6cSkJ8LYIxv5tDbPX7AAG/sthJAOfBvosnygTdLaueolM4smpEvhGL/GOuhNIAnpe69l5mzZVGZqU/HUNlNyYVn+Y57e9GQ1tEWP4L1GOBffvB+tKYd9ldvMwsaGRldcl6NWo2fk2jh/85ye7FFWUxhWNtiWdfIgyCPQLsf+J01ZUwA3J9hzwyE33kzStLQxRbVV+FZisOGIf6utq+bIUHqKUxdd/TNcaHyjw2gNinlhawGEnuYFapBwi7zMFavof4Nw0o29wcyDKiLnuJfJ76j+y5E2eN4ua526tCdbvikFeoKMKGwwYXA9pFrQ5ofaD0An/AQeslKX76NLXxxAfvQSFcPaRTX+F5zuCMOKodXMxeKRiJONO8SDkKjJgMoZsDdNexYnc0c3qmeqQi1ydeVDl/WOvP0p+3rbpI4rA8qHY22DnCbDsoSyevZq6y4zbtvrgzTJKpCitaJ9y7obxI+taAqHDGdC55lyqnFNYjFg3pjzjcLL9dn9MTsudDxwStbmzrG3CBJSyNs8YjEpbKyApzcTTc77fIllQ+zPOob8auuL0vuA27ZUC5IFhmCZrV2pNEwuFJQbyvthT6kGQEMei1+OV1XqQLe6ffQTWbZDsls6w8gkdexbAIeOYee6YPWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(18002099003)(10067099003)(56012099006)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CxrfNMC6j5LVsi/R4zpHD/Bn9JhdmQx1hjlv0ageEolTLL03NfNHJoEJE5xADKSSJaR9c0OqrXOS3sxLBJPp33DEKGwIyPC24FSzldT98po/W/9mrwn/HAWS8M4pfJTIhHDGxPdbpMvooMSJyDKxTuMJDNu0U1o6IsgB0Q+WdyF7JIS8g37eV5hFBAG0xk4E3JlUsj7V8PHPtJEJrq4VFGuac9kAUOokWAyMmRB5+h0Opan3SG7D0iGXUa6GjU6OZj8KoFX/HLvURWkcbopQyM/EBwE/rZJZgnZiPzrIOGhKcTxXJRlUgBLxdzd56jYotRx6fdv+bzrPdbyW64f7zr6byDO4c/PNn4IAmMTtaVZHvK0zvFi5hbRFXAvuV6NYwbfjEQPnsdEaw+J5wY7fRa7nscD5IUyFSo6+i3jq5jSML+40j0jL7ZUYpCXfte6t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 07:36:23.6879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0235316a-3af9-4452-9d46-08deec7aece6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4108
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

The individual.needs_update loop in amdgpu_vm_handle_moved() unconditionally
dereferenced bo_va->base.bo (to read its reservation object, ttm_tt and to test
for a DMABuf import). However bo_va->base.bo can legitimately be NULL for
PRT/sparse mappings - amdgpu_vm_bo_update() already handles a NULL bo via its
"else if (!bo)" PRT path. When such a bo_va reaches the moved list (e.g. the
userq eviction restore worker running amdgpu_vm_handle_moved() while a user
queue is being torn down during a GPU reset), the NULL deref crashes the kernel:

  BUG: kernel NULL pointer dereference, address: 0000000000000158
  #PF: supervisor read access in kernel mode
  Oops: 0000 [#1] SMP NOPTI
  Workqueue: events amdgpu_userq_restore_worker [amdgpu]
  RIP: 0010:amdgpu_vm_handle_moved+0x17a/0x200 [amdgpu]
  Call Trace:
   <TASK>
   amdgpu_userq_vm_validate_and_restore_queue+0x2ce/0x920 [amdgpu]
   amdgpu_userq_restore_worker+0xce/0x210 [amdgpu]
   process_scheduled_works+0xa6/0x460
   worker_thread+0x13c/0x290
   kthread+0xfb/0x140
   ret_from_fork+0x1b6/0x2b0
   ret_from_fork_asm+0x1a/0x30
   </TASK>

The faulting instruction is "mov rax,[rdx+0x158]" with rdx (bo) == 0 and
CR2 == 0x158, i.e. reading bo->tbo.base.resv off a NULL bo.

Guard the BO-less case: skip the reservation dance and the DMABuf-import check
when bo is NULL, and let amdgpu_vm_bo_update() take its existing PRT path.

v2: Use local bo pointer consistently after NULL guard (no functional change) (Bob)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index aac8ace9d7a6..d8552d9dbe5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1631,11 +1631,17 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 		bo_va = list_first_entry(&vm->individual.needs_update,
 					 typeof(*bo_va), base.vm_status);
 		bo = bo_va->base.bo;
-		resv = bo->tbo.base.resv;
+		resv = bo ? bo->tbo.base.resv : NULL;
 		spin_unlock(&vm->individual_lock);
 
+		/* PRT/sparse mappings have no BO to reserve; just update the
+		 * page tables (amdgpu_vm_bo_update() handles a NULL bo).
+		 */
+		if (!bo) {
+			clear = false;
+			unlock = false;
 		/* Try to reserve the BO to avoid clearing its ptes */
-		if (!adev->debug_vm && !amdgpu_ttm_tt_get_usermm(bo->tbo.ttm) &&
+		} else if (!adev->debug_vm && !amdgpu_ttm_tt_get_usermm(bo->tbo.ttm) &&
 		    dma_resv_trylock(resv)) {
 			clear = false;
 			unlock = true;
@@ -1659,10 +1665,10 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 		/* Remember evicted DMABuf imports in compute VMs for later
 		 * validation
 		 */
-		if (vm->is_compute_context &&
-		    drm_gem_is_imported(&bo_va->base.bo->tbo.base) &&
-		    (!bo_va->base.bo->tbo.resource ||
-		     bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
+		if (bo && vm->is_compute_context &&
+		    drm_gem_is_imported(&bo->tbo.base) &&
+		    (!bo->tbo.resource ||
+		     bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
 			amdgpu_vm_bo_evicted(&bo_va->base);
 
 		spin_lock(&vm->individual_lock);
-- 
2.49.0

