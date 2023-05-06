Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859B4C77B7F
	for <amd-gfx@archiver.kernel.org>; Sat,  6 May 2023 07:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80EAA10E1B9;
	Sat,  6 May 2023 07:03:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81C6C10E1B9
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 May 2023 07:03:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNr9nWFezx6ryRwedtkQBkbM9tjQDJpFD1l7XD0+H9iUTuoMupaJixDPy8ZZGrWidbkX8ydzAgtd/iUDv8RSQH0YP1S137M6QBFuw6xbe7bztWIuM4Me/rtuVrIRYAWNWIps4hTF0mJ50nuPuQH4zdUOaBSAL6Wf2d3up9T5isy8V4l2gXW3NcXm6QGqIymFAVJYRJDHhW4k/3nDiAVvIeNvbCWvyVx/LdH3YROVLc3XtNChMqjC0eiE3NGmBLYbFo8BdieRqN5frzv4HR20MNGi/gVjRg7rb91mJ6qGtBYQhADeT+LLMFsK9/cS0PMMqOlXBkVtDkWJQrys7+kWsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIU98Sriw5Q6JHw2qGRl6acpviFinPh7ck/KQIP1Blc=;
 b=I5kyx9zTGvjBG26jgnMcp/4x3VBkpTz3RN2G0Nd30DVN+Q8TrKcZ+y2YbsG0Lxt7I7L9pZzTZjWNtr0TD3tRD2lo6+lddPSu8Vs0iHuvdpzaZEHS11u55JsboeYRQ39EiTdgBV7IREAfr6WV4DCNwaQET6Xz63LvDKcY9DKywKlidLRjvGT7Jio40hCjcR+BL2FZcvp6CtpJhpguREzZWufVR+0sfcyeviWd0sW0OefAVPouUSSTFbm4Hv7Zb2wob30XObhy1vn55SR7OqrL1O/yURYuwWu5Fwdma6pSWnMZq80r7+VH8V8Mjh/9YR62DWuL4hFItfkkbk7pj9rW/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIU98Sriw5Q6JHw2qGRl6acpviFinPh7ck/KQIP1Blc=;
 b=HlL5v59qdSvl9rIzpk0HxnaXaLJagEW8gthIZvU3w78aoahJ/zdO7YU2qYWsF8mjbKQIIzp0/QIeXjDHkJrBqQOsS8MiUdh/nllvhXT4KxlMM5gfi/GzNKvk5c2SgS5FGw1NQpX1QXYKEdNTRO+ajhIO014Q1ADrqB2cY1mynv0=
Received: from MW3PR06CA0004.namprd06.prod.outlook.com (2603:10b6:303:2a::9)
 by SA1PR12MB6919.namprd12.prod.outlook.com (2603:10b6:806:24e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Sat, 6 May
 2023 07:03:47 +0000
Received: from CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::c7) by MW3PR06CA0004.outlook.office365.com
 (2603:10b6:303:2a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27 via Frontend
 Transport; Sat, 6 May 2023 07:03:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT069.mail.protection.outlook.com (10.13.174.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.29 via Frontend Transport; Sat, 6 May 2023 07:03:46 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 6 May
 2023 02:03:40 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: unmap and remove csa_va properly
Date: Sat, 6 May 2023 15:03:02 +0800
Message-ID: <20230506070302.246369-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT069:EE_|SA1PR12MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: bace7ef2-3ab8-4a4a-d2c7-08db4e000972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lqiJSdqsaAo1ODXjuUF9s3d254BzJP8kjgZYPa002/Fn0V1R+8Ft1maEAr2GFkFdSFO1uVcYw8fMycY3Z+9Tp6vFpzHgo/F7iT0p58FiEyqnQwliIiBW3VDl+lUOkPIVs+zbsWg0EQl49ypDl2EnBgG3OpHVUa1lQwrqq7CXxakEBP7DG6hZyBr130Ss5BQw3l9k4YblPKqpATWKP2dYEZfLBK33u45EVlmzwDOsqkc8JdkrOamWBjcSFxRK7jRsM/bOxZburyILqqTdUFgAGhIn7+gTE4XWXga6xkOPaT5eMaPJdfymIZllFHecVwmohLnuwfH/Cz1k22jCKnV88tayJ66HhZuRFUHnRA0OGfOjnizNnVhlS2u8TeXMH+NO+VvS+Eh7izjrDVlWWh4RhM/mtXAqicrQhft14MACQ/pHkhzVQ4B+bylv8aH94JEfxTTADGgZbGhWhmbWLrqjBQkxpQbfSo+5PCt9yFO+zUDcHw9+FLPstFVN2vXtbYp80Uq+eMm2/HKJhwTPNyoAx6RWNtGEEnsSkw6bpQYhbfNs8JD2LOX2LSMsfs/wDeKq9SmYRjfmZdbV6gWVMFud2zqg+wP7ybAE82MQszyi7ySK41apme+v5Z3C5uzvfA+hMtxrsKcldFln5gpf68kesGQMbqDvoyG1kuPlFEC2my33fIhfC6wTgL1Aq8+sgLrRP7+cJ+6PDEycuIiIj2JBDhTFIep7EVYi62ET9s71poM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(36756003)(6666004)(86362001)(316002)(54906003)(70586007)(6916009)(4326008)(478600001)(70206006)(7696005)(8676002)(82310400005)(40480700001)(8936002)(5660300002)(2906002)(41300700001)(426003)(82740400003)(81166007)(16526019)(186003)(356005)(26005)(1076003)(36860700001)(336012)(2616005)(83380400001)(47076005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 07:03:46.6825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bace7ef2-3ab8-4a4a-d2c7-08db4e000972
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6919
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
Cc: Lang Yu <Lang.Yu@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 Monk Liu <monk.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Root PD BO should be reserved before unmap and remove
a bo_va from VM otherwise lockdep will complain.

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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c | 38 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.h |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  9 +++---
 3 files changed, 45 insertions(+), 5 deletions(-)

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
index 1d3b224b8b28..6b47ac3eb40d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1307,11 +1307,10 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 		amdgpu_vce_free_handles(adev, file_priv);
 
 	if (amdgpu_mcbp) {
-		/* TODO: how to handle reserve failure */
-		BUG_ON(amdgpu_bo_reserve(adev->virt.csa_obj, true));
-		amdgpu_vm_bo_del(adev, fpriv->csa_va);
-		fpriv->csa_va = NULL;
-		amdgpu_bo_unreserve(adev->virt.csa_obj);
+		uint64_t csa_addr = amdgpu_csa_vaddr(adev) & AMDGPU_GMC_HOLE_MASK;
+
+		WARN_ON(amdgpu_unmap_static_csa(adev, &fpriv->vm, adev->virt.csa_obj,
+						fpriv->csa_va, csa_addr));
 	}
 
 	pasid = fpriv->vm.pasid;
-- 
2.25.1

