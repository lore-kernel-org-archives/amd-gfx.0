Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BE5606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 08:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aABeh6BR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 036AA112409;
	Thu, 22 Oct 2026 08:34:12 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010039.outbound.protection.outlook.com [52.101.56.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AD021123F8
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:34:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtsFjHB6e7NKftXMKdTUO/p1Vr2CwCjws4gyQ8ev+UfMNodDntohQEIRpwHoXKsXtisSmNygLwe3U4m3/xSQCl69+sI/cpp0uXzfJiXPELvNG3aJKzXvXbElop+2Uuc41YT1V/aPrMaYPjjuZnACAe3t/4zNmyh1Hu5CFROnDjySAJ2X/wbbqUkpc+AX+eSf1XEFqEN/gjOEJxS1EaWm24Wmj2bkpOzLl9hsEc/wiLuavT85l0nZk+IyXLS3VGPcAK/aRXfZurwhQqWZ2hGUL6Y9VyPjg4hpBHdVQ9DJjsOpPc41G+BYhyQtuioeDkDb74nFRY5mMkdEn7Q0WI6NEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSUWFSLpTu8w4DmE1Njj3LKLwL0/cdjkfhxmbiEa2Vc=;
 b=f2L5v3gaM0C5qQYuo6sO3m0H8uaeXWXSEFYWrzqLTQKq6OqngI+FHdAB6n3vjl8hTRL4DHO1xbP4NCzr45YFHpl9zBy5fVyF3m9tP4TpJBdF+wOcr04ChZDrtAZrJwMPfU3qkpvrWvlXgjiiAqC8dLHxjZWRPKdZIjEX3NtO0nA6BhH+ilBmLk+NHu4Lu7gONYuZU4mGDX+tmMWXw8eeFS2C1KnDDPVcI7vFC2Ppewzp/y3VUwNnjE2AI8xXAFc1ZTiXXbelf3D7MgoQWi9wS0oEBHDihkC+GboloG5zHoUOdfhjAmC8kGzYBYFdJtYQklvb2btSgOpSNh2Ug7+m8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSUWFSLpTu8w4DmE1Njj3LKLwL0/cdjkfhxmbiEa2Vc=;
 b=aABeh6BRl+IX3WVHcsHypsNz7ICoccdX7FZ8h4oEUqLS6dM+vUFPZ3IrBtozIkYEhgYmMXXHPCTCauruDOB3ls1DL2NmA78m0QnvRwyZzSIWU/+3mD40c0UvGcknLW1pQN0NvyfKaXTAIAX+hzfspIqcDJCgU2zdKIVm5IC7vKU=
Received: from CH0PR03CA0234.namprd03.prod.outlook.com (2603:10b6:610:e7::29)
 by DS7PR12MB5886.namprd12.prod.outlook.com (2603:10b6:8:79::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.14; Thu, 22 Oct 2026 08:33:58 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::4d) by CH0PR03CA0234.outlook.office365.com
 (2603:10b6:610:e7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.17 via Frontend Transport; Thu,
 22 Oct 2026 08:33:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 08:33:57 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 03:33:55 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 9/9] drm/amdgpu/gmc11: don't access the fault registers during
 GPU reset
Date: Thu, 22 Oct 2026 16:33:31 +0800
Message-ID: <20261022083331.3019779-9-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022083331.3019779-1-Prike.Liang@amd.com>
References: <20261022083331.3019779-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|DS7PR12MB5886:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d40ace-6b8e-4920-6d9c-08df30173742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|22082099003|18002099003|10067099003|261021121427099003|261021123027099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 7bYgpjrL8BmaPC8bAlxLSMoH9FKXFwqqA+z7YRfRRCVye6oJ5jvxWE1nyM+GjTYLuTu2WDq7XZ9Y2a7huO9u1m179kcVU0XUv2QSj8ktFKSms5ofmwSY+JxiSqHr23X9yJ3qK5x+Zi9EloeV+sH78c4fj9YTAkRkx8vz1OJ0QVEYdNa8LQhe2HjGuUTUUh8aBNFGEhD2yTaRnjHueV5lIrEezhUYut+RN+u0gRwZof8MlEMB5bVZY7wLo0hWJXSFeuQiaLKVUfUMCIhuRyDeyv57ce+iDoF09p6D3cwDxmKA4kXTSBA5xK7WbQVPAzK7pN+FpwkNfGj5VockGYb1zHD801kzIiJIQemJYzAtKYKvfzsqmQK3hVhHODHdpaKQ6ISNHarOxWPKXsReNMhTQFQgOWbVDQKIxvxdIz5rTVtgIrgHK4gTOGlavJeUTcTxPZPvXTvoptvjWR7kB2tiDeGgxXRYe7FQ0YujDXBeOKEQKBFSpbD0zSSmRw2nY6yLp4HF46Y03lH+5KdmRCs87FmRhxLQfoYZCAlnqpioa+nUitD6gTnrxjAePiRN9sw7ASkDIyzNTcYfBzzOz9ED/CkzAo8qRKyWn9aNc7T2fwLu4CJ2eDha/0ucyl7hPn0goyuY0RviAecHuEUbI4P4O+WsJXXqXs0ljbBIgoZEK8lxesnWqgB3S0wELdUV5lacNDaLFOIYKR9kcjlTvFGAag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(18002099003)(10067099003)(261021121427099003)(261021123027099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wTZez31AHQ7BFMw3m1/WkVHzSZ0wmPo9Bk1nivMyUemAWIuClzloPwF70U4jAx0l5HWXSvDfHQ0zpm8mI6Hf2Xv1sL8ZICaKBdtpX/Fg5huCNubwQ2FLjP12bOKSc3sSxdXLYf0oFY79h6/7SZquV1tHvlQ08Wmr5P+L2+b7yYkzj0Pp+jxWmH2An6gJPO0FamvBke3bTzMf+phptBsxIeSJV19d5XbUqhEURqxu9rmeCv2r8yI/dwEhcjL2+0OeOXQr+n0iGoSzcXoC6WWOhSzPUr+V1SMuME7tmf3sEohLXMZWoIibg9gLWAbTVr7M9HbPBQ0FyFTe/TEulFO8MgkVuOXRObOOmXTPXCAdIrFw9aoP9bpJ786ymVt/vTl4lTRBHafSODYanF6AKQw0FmUD6rbxL3JJLtlAjb1HutoNIG92437yjNvFCawWWn8C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:33:57.9089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d40ace-6b8e-4920-6d9c-08df30173742
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5886
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

IH1 and IH2 are processed from a work item, so a VM fault delivered
there can read and write the VM L2 fault registers while a GPU reset is
running:

  WARNING: amdgpu_device.c:928 at amdgpu_device_skip_hw_access+0x73/0x90 [amdgpu]
  Workqueue: events amdgpu_irq_handle_ih1 [amdgpu]
  Call Trace:
   amdgpu_device_rreg+0x21/0x50 [amdgpu]
   gmc_v11_0_process_interrupt+0x241/0x250 [amdgpu]
   amdgpu_irq_dispatch+0x12d/0x2f0 [amdgpu]
   amdgpu_ih_process+0x70/0x190 [amdgpu]
   amdgpu_irq_handle_ih1+0x23/0x30 [amdgpu]

Trylock reset_domain->sem around the register access when running in
task context instead, and only print the fault when that fails. The
semaphore is held just for the register access, so the reset never
waits for the fault handling. The hard IRQ path for IH0 is unchanged,
the IH is disabled before the ASIC reset.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 709c3d1b9998..bc3b1ffb5488 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -108,6 +108,7 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 			      AMDGPU_GMC9_FAULT_SOURCE_DATA_RETRY);
 	bool write_fault = !!(entry->src_data[1] &
 			      AMDGPU_GMC9_FAULT_SOURCE_DATA_WRITE);
+	bool read_status = !amdgpu_sriov_vf(adev);
 	uint32_t status = 0;
 	uint32_t cam_index;
 	u64 addr;
@@ -125,7 +126,15 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 			return 1;
 	}
 
-	if (!amdgpu_sriov_vf(adev)) {
+	/*
+	 * IH1/IH2 are processed from a work item, don't touch the registers
+	 * while a GPU reset is running there.
+	 */
+	if (read_status && in_task() &&
+	    !down_read_trylock(&adev->reset_domain->sem))
+		read_status = false;
+
+	if (read_status) {
 		/*
 		 * Issue a dummy read to wait for the status register to
 		 * be updated to avoid reading an incorrect value due to
@@ -137,6 +146,9 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 		status = RREG32(hub->vm_l2_pro_fault_status);
 		WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
 
+		if (in_task())
+			up_read(&adev->reset_domain->sem);
+
 		amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status,
 					     entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0));
 	}
-- 
2.34.1

