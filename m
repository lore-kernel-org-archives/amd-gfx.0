Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE78C77B7A
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 07:25:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CD0010E443;
	Wed,  7 Jun 2023 07:25:52 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B02A610E443
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 07:25:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jl+pUgubMCcmaGFJxBXNXFjB9fwf3O6JsMnqeovzTcjEXlMs2nXdofqTY93J0QX0JY805xMEYnmu6JjUT2BkkL1UqCPfxCSFPxiCprc8J8JyBKwUUGo1L6B/ivND6jYnHxsJ0IdoYs25Plb3TlP/M2993UIIXJRvOi/3C7rxeQW2gtCiT1d6y6y1plGZRNMFbp88jNJ1U3OcxdXYRf5rwS3OVLUbG9DwrPhDVFnH2YJfA0IvaVx6jvT5JmFcyN3hsWM+BHhFFDv3FO8cMzdbdkHdze61CnXLJsvnOT654tG1ITKJhEpZAk3tEUtjSYBtspzDNQL2gt1t/Q1CyauOFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3pocQvsX3GSMQL+ODcNvNXQTFEpeABgs0JPRY6Gd+Q=;
 b=IJf5cux2CybIL+IlgBYSoHy4vT8sjSSmEoI6MC9VpLcbOEodYE8Vop8qG0+L6YLOQ20IiEqHJeRuL5z84s7TkrarUo8txVMf6vOI8FWl4XUvRsUJfjpn2DCf96QRTX0dGj9p0jf7xXbHOhJu9AtzNDaa44TTWWXnejdKKqVH3AithpYJkWojyIXV7QMxlAZXICuSPivEH990W9q+TuWeHCLN/KvDdrk1QR7T1EbWZjl21xxpsrnYkYtJ+ZrcORGQpLwp1pbXQtXR9ybHB3ikeE4zo8lPBcCPxXkfrZWTTISkCkusXWoBOA6ElMApSwqw6QLPXjIqfAc6VQTJJdzG7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3pocQvsX3GSMQL+ODcNvNXQTFEpeABgs0JPRY6Gd+Q=;
 b=YTiNcjDPbTslA7p3NusaT9XUuXqM4Kn15arn8ClB+l1z0Y09eX8ocLXJsrDb6etM/EGkyQnVfXxEIQWRmhVY2voQpSeYJq606j/k5w8iOY5mT4+YjruXJa51t7Lh5gTS7oEUsyEWzB49Wacf/7hdkS0OVPSgj0iHEpSAxvXTV/0=
Received: from DS7P222CA0030.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::10) by
 PH7PR12MB9255.namprd12.prod.outlook.com (2603:10b6:510:30c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 07:25:47 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::6e) by DS7P222CA0030.outlook.office365.com
 (2603:10b6:8:2e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Wed, 7 Jun 2023 07:25:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.24 via Frontend Transport; Wed, 7 Jun 2023 07:25:47 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 02:25:45 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: unmap and remove csa_va properly
Date: Wed, 7 Jun 2023 15:24:58 +0800
Message-ID: <20230607072458.522645-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT013:EE_|PH7PR12MB9255:EE_
X-MS-Office365-Filtering-Correlation-Id: e5619e59-ecc7-422a-8dab-08db672869ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d4e5hszrVswbguG2TOEkNl3VdmHWc8Yzh3XIB/6Kq4hp3/xroUu6XAJvnE7SCUDQukvcPbuW15elAHHig4QzoEYV5RiR/ObLwzDS9Cgn6Ij0guARkkJFIY7oypHXGGWogynUvI8L4573Kc+bi5zrwOk90i+8GX0seh55hsGGQAdJscop0h3HJnReH6TE5BZMe/A7upcyKamedAYjEGkRJDsJSqjU9Mv4VEXOXQ3n0YSR5uJM9Cg61d52QILPxocqatUbqbxfj4lANVN83dtcRbAJ4+bLIFVQgMhKRTbztl8uCIlond6PDGVaUD7LtEEAt10SfxxlK8b9a0lh5IojD5ZJ5EesUX7eDzfWD2RbabYo2ouvcnziDP3I0v49moN02Ax6oXPJppgSlxJxLCVFmZNlQcd7QrtXLrSyW/xw8+4CMwl/HXqVL6OHZS+UIUDaihmTaSNkvagxsYWrUPOlICG8600KczZjg68+EJUvygzs4wxQ16KdTbWWZ9QW1wO1cMDNdsOlyj5atHxTQtEnsl0ITnWbF9g75P1Yh6SMhcSr/sQzoX2kAr1P9jXkyyu10fOo0sJaIYKkE3EyZauxRLzlLnXhmJCNyEcIDybrttrAggy1EncOU9qSiRqbeJm5Wcqgf2ORkg2upKVr1ACYZnbHCo26EjeEjK2vhV9HJQHyqUzWo+dttp14cX0gTT9x4fN47B7cSjRHVL1yA2b9f7hm3OeLSfDmlkCn9JESMDTmOYjLC0le0cOz5G7oAOsI/A6Dm6ZpvkgpMrrkUlktBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(40470700004)(36840700001)(46966006)(41300700001)(6666004)(36756003)(40480700001)(8936002)(8676002)(5660300002)(54906003)(6916009)(70586007)(70206006)(4326008)(316002)(478600001)(40460700003)(2906002)(7696005)(82310400005)(1076003)(26005)(186003)(83380400001)(66574015)(47076005)(36860700001)(336012)(426003)(2616005)(356005)(81166007)(16526019)(86362001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 07:25:47.1544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5619e59-ecc7-422a-8dab-08db672869ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9255
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
Cc: Lang Yu <Lang.Yu@amd.com>, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Root PD BO should be reserved before unmap and remove
a bo_va from VM otherwise lockdep will complain.

v2: check fpriv->csa_va is not NULL instead of amdgpu_mcbp (christian)

[14616.936827] WARNING: CPU: 6 PID: 1711 at drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1762 amdgpu_vm_bo_del+0x399/0x3f0 [amdgpu]
[14616.937096] Call Trace:
[14616.937097]  <TASK>
[14616.937102]  amdgpu_driver_postclose_kms+0x249/0x2f0 [amdgpu]
[14616.937187]  drm_file_free+0x1d6/0x300 [drm]
[14616.937207]  drm_close_helper.isra.0+0x62/0x70 [drm]
[14616.937220]  drm_release+0x5e/0x100 [drm]
[14616.937234]  __fput+0x9f/0x280
[14616.937239]  ____fput+0xe/0x20
[14616.937241]  task_work_run+0x61/0x90
[14616.937246]  exit_to_user_mode_prepare+0x215/0x220
[14616.937251]  syscall_exit_to_user_mode+0x2a/0x60
[14616.937254]  do_syscall_64+0x48/0x90
[14616.937257]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c | 38 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.h |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 10 +++----
 3 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
index c6d4d41c4393..23d054526e7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
@@ -106,3 +106,41 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	ttm_eu_backoff_reservation(&ticket, &list);
 	return 0;
 }
+
+int amdgpu_unmap_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			    struct amdgpu_bo *bo, struct amdgpu_bo_va *bo_va,
+			    uint64_t csa_addr)
+{
+	struct ww_acquire_ctx ticket;
+	struct list_head list;
+	struct amdgpu_bo_list_entry pd;
+	struct ttm_validate_buffer csa_tv;
+	int r;
+
+	INIT_LIST_HEAD(&list);
+	INIT_LIST_HEAD(&csa_tv.head);
+	csa_tv.bo = &bo->tbo;
+	csa_tv.num_shared = 1;
+
+	list_add(&csa_tv.head, &list);
+	amdgpu_vm_get_pd_bo(vm, &list, &pd);
+
+	r = ttm_eu_reserve_buffers(&ticket, &list, true, NULL);
+	if (r) {
+		DRM_ERROR("failed to reserve CSA,PD BOs: err=%d\n", r);
+		return r;
+	}
+
+	r = amdgpu_vm_bo_unmap(adev, bo_va, csa_addr);
+	if (r) {
+		DRM_ERROR("failed to do bo_unmap on static CSA, err=%d\n", r);
+		ttm_eu_backoff_reservation(&ticket, &list);
+		return r;
+	}
+
+	amdgpu_vm_bo_del(adev, bo_va);
+
+	ttm_eu_backoff_reservation(&ticket, &list);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.h
index 524b4437a021..7dfc1f2012eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.h
@@ -34,6 +34,9 @@ int amdgpu_allocate_static_csa(struct amdgpu_device *adev, struct amdgpu_bo **bo
 int amdgpu_map_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			  struct amdgpu_bo *bo, struct amdgpu_bo_va **bo_va,
 			  uint64_t csa_addr, uint32_t size);
+int amdgpu_unmap_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			    struct amdgpu_bo *bo, struct amdgpu_bo_va *bo_va,
+			    uint64_t csa_addr);
 void amdgpu_free_static_csa(struct amdgpu_bo **bo);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 41d047e5de69..e3531aa3c8bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1311,12 +1311,12 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_VCE) != NULL)
 		amdgpu_vce_free_handles(adev, file_priv);
 
-	if (amdgpu_mcbp) {
-		/* TODO: how to handle reserve failure */
-		BUG_ON(amdgpu_bo_reserve(adev->virt.csa_obj, true));
-		amdgpu_vm_bo_del(adev, fpriv->csa_va);
+	if (fpriv->csa_va) {
+		uint64_t csa_addr = amdgpu_csa_vaddr(adev) & AMDGPU_GMC_HOLE_MASK;
+
+		WARN_ON(amdgpu_unmap_static_csa(adev, &fpriv->vm, adev->virt.csa_obj,
+						fpriv->csa_va, csa_addr));
 		fpriv->csa_va = NULL;
-		amdgpu_bo_unreserve(adev->virt.csa_obj);
 	}
 
 	pasid = fpriv->vm.pasid;
-- 
2.25.1

