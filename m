Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C92C54798
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Feb 2024 15:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74F1C10E60D;
	Tue, 27 Feb 2024 15:54:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5N9aFPAC";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34C4A10E68E
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Feb 2024 15:54:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e18DS0y0yq9lIqfSg+XM46KAHBp1eQOiRTGcUGAYN04i0wWkLh8DXX1VndIHWV2BD/catUEMfxToDqwJVF+Jozpi0Ed6wBzjfh+la0GB0nnWry2Qz5GkZqNyS6NWR3il4M5lbG9nYCgSKkgEmfGzp4PGGRBYAZ3XX0AfKuM2gjL+S6AkldJpOhteVz5YiLXSXC6YkOWVhMWjBJjIPaZMdDaU/szUGyLrkr/XHkPbAu/5wSF1voFbmjcDqsqKlqV1EEqrSMhp0qe7emztwVmghlST0P1ySiplXzE7ngnBeI23AthUTDQhPwGeOvL0UFkEzekqYvCxtFDgdG18nYWR0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAGflL946tGg0PZAD4iqZVOnSpGiGyJFCC8GD+C+YUM=;
 b=d8uNmAsKhjIAVvBm4f0k4JIvguc40mISlJ++aBG0HFgCZ1Y+UbnyiIUfRAbBTL2A7XmOGFj0nJfHYAb/cMXKT9EHS2cj6tVX45XpKnghH0LOh6vsxvoQFevW+KrYa9kst2Tn5ZkqJvMu5+ExhL1W7EEfstFtEI09mobU7l5jrXe2O4BQQZEj9GpTJX9oajYdRRfpCGptRXAT57JI7Io9f4kuoQJKWuonllDCY/dGatFUn3L/kZsKUbYI/aIpwhTxs4D2ytwe4yqVaCur55nADzsYAgumYfW9XPag1C7tFqNfhZ557gvIfS0Xrhp6v7Aj4YdEDnpibOL7LgwsoTzUlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAGflL946tGg0PZAD4iqZVOnSpGiGyJFCC8GD+C+YUM=;
 b=5N9aFPACQQ70pjp7w2TpXPbwLWyXl6eBlF/kpzL9lsn9euL6nCbXBbY0sL0uXBfP7a30bf8NmrMnkwSYy2yM+aOng/9DwtKa1Z1ePIGunItk1MyVhOfLYTOqO9D79RzaWIl8NYUcN/Y9cwRerlhO50++e5fEvEz1JCVuBboKK1I=
Received: from BN9PR03CA0412.namprd03.prod.outlook.com (2603:10b6:408:111::27)
 by DS0PR12MB8454.namprd12.prod.outlook.com (2603:10b6:8:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 15:54:13 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:111:cafe::a8) by BN9PR03CA0412.outlook.office365.com
 (2603:10b6:408:111::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Tue, 27 Feb 2024 15:54:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.0 via Frontend Transport; Tue, 27 Feb 2024 15:54:13 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 09:54:12 -0600
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amdgpu: Removed used parameter
Date: Tue, 27 Feb 2024 10:53:55 -0500
Message-ID: <20240227155355.517538-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|DS0PR12MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: b342d283-0a5d-4472-26b0-08dc37ac5808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 76Q+Bmqc4g8Gx1+FVMh0/QkOqg3tQViBAXGP8Oo6qWEwy/9b3lyLw6vGO2y41H0RpvkzuXUv+pDLapdjYBDhCzVny2MeipbHuyPaUmTbpeCIJa0WdZ+Aje1FZXbzxiRUQIffGEzbYuHsRCcpJVpj2smPipmY+Hjlh74hlTbec8QjMsro2F133AXCKkQp5pNkAqyyuIe8vLp/k2kCdp5OiOPSnOlKTlAKjtoL7zo0Q74Rp/aOEYfc9LqxtkkriQO/AAzPMKetzTb1NQgmOdaznFJ/EpUqpxvbOemVRRp73Ql18sJrG//hWNmmpiCK0kiToPCv+c6OZ0dXcFSm7Y9UJpKN6zZ3ge+v8XlDfqYw1UMi/a3J6IT6/1eo/eG9+HQhQK6g5qD8e5TyTpN7mNnu/jK2jK+2qPM6qbJX4lvzSBH6QeoD4O4H+ZTsqxwHGfuyH1bv45N+gXuCi4H1pcEvEclKL4WX2nKWBGcPBlysTf+Yv9a1HCZjb2gxfo6OOcUauJhecyhyejMVFU2doA+07l2PIDPCYl5eKEEkf86rOukYwVGLaWbbkbrkO422oq9WA0JaLHRF9Y6jthM4tlnAeB45ZUdwgSppNHAx99tj1M4WFy4JCztTNx5YBumBjZa+V9/u0m4uYkvu+DRHdXFKorJsjUs4Iv81857HB0m9FBWNakxFZxGeSVTAn0wFpaXDXOvkwcDZ5CeZLrhdKAo1oPia9N99/yJWxaBzSJfDDUW6BH8QbcpP5ZMH9w+mxx8m
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 15:54:13.0130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b342d283-0a5d-4472-26b0-08dc37ac5808
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8454
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

Also passing adev is misleading if BO is associated with different adev.
In this case BO is mapped to a different device

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 4fb32d86cd0e..0ef223c2affb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -320,7 +320,7 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
 					     void **kptr, uint64_t *size);
 void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem);
 
-int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo);
+int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo);
 
 int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
 					    struct dma_fence __rcu **ef);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index ef71b12062a1..d0819fa5fcd8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2189,13 +2189,13 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
 
 /**
  * amdgpu_amdkfd_map_gtt_bo_to_gart - Map BO to GART and increment reference count
- * @adev: Device to which allocated BO belongs
  * @bo: Buffer object to be mapped
  *
+ * BO will be mapped to GART of adev to which it is previously associated with
  * Before return, bo reference count is incremented. To release the reference and unpin/
  * unmap the BO, call amdgpu_amdkfd_free_gtt_mem.
  */
-int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo)
+int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
 {
 	int ret;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 824e660283b2..f030cafc5a0a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -371,7 +371,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 			goto err_wptr_map_gart;
 		}
 
-		err = amdgpu_amdkfd_map_gtt_bo_to_gart(dev->adev, wptr_bo);
+		err = amdgpu_amdkfd_map_gtt_bo_to_gart(wptr_bo);
 		if (err) {
 			pr_err("Failed to map wptr bo to GART\n");
 			goto err_wptr_map_gart;
-- 
2.34.1

