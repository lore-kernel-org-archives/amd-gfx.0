Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FB9CDB471
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 08:13:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2E0F10E9E8;
	Tue, 23 Jun 2026 08:13:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fY4qgNMd";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012058.outbound.protection.outlook.com
 [40.93.195.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75D6710E9E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 08:13:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfIjbHndOJ4CIV9pwhVv9ciUwrH6r+95Zwno1nOQoGj8moXPPxei8yw4zsQGmUVhDos5mATx6815uZW8FqvubVAINnBa0X79N7nGSZkBnK8x16WYrs6+ii1q7il9+lC11yEXquCTLGdZ8ozKyMhxI7Zsq0jcJuU6Lho3guBL/ZPl3uUl56BdM3w3bcPn10M0Hvrz/xgDrs5cftmglnE3vfbPE5fCKZ86/iJE6M3YP3aUTKvlIqjFpjpj+7BIoyo/vJ6OM4wn0Ucy7Esbgq2vVCR+7DnX2jZTWKx7Jq76+W/H3CoTC00xiOVgpVsNX+gQPxMh1nDjsFR/lbHJArYhnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apzw3pztjbjWt7pTqhSon72WGZgpVuFyQtncKYhxM3Q=;
 b=X2uI5WO/cgQs04cYc4DSMdfMRZd9yu2zoRy3aEUqrQ9vFYjeEhNscT8stpD4b+L7pu+jtP1j+FgnNEEC4JbDqI0/xqYQ8TkPjefMmB6zZtooAkSUqLn0Ihn4Kbd2kWV7pCzW3PYALwqv/66dwDw2SCA3BgeEcUnBbmccu7zA5LyGtqmVQZBnf7IukXXua9XwiJUpSjP7gQQkTpRYiHqKaeBTuHMXnoRROkX5yJ1/OxxWaMklD02RUU5rhCjE/QtqGkodGRkHu3ic7L5+QuF6+ZSJ5Mubq+cJxg5HJeGWMsOCE63IIGe5CDyNnyPK7C9WY6/25S9UhoSIsFhJySBZhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apzw3pztjbjWt7pTqhSon72WGZgpVuFyQtncKYhxM3Q=;
 b=fY4qgNMdKvCqY6ayiFNkynAAizcYsGRkhao11B6ulAwPQQ0gJzZ1MwSobI5930fNWoavAB5ptGF77qthE03mRrA2LSFYzqD60zpVuHBb1EhJg3KoMYAlSVoFTENziBViKmU1leDA7SEKblC+amnQlucBhHCw4AtaUEF+h0xHajI=
Received: from BN0PR04CA0110.namprd04.prod.outlook.com (2603:10b6:408:ec::25)
 by SA1PR12MB9545.namprd12.prod.outlook.com (2603:10b6:806:45b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 08:13:20 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::18) by BN0PR04CA0110.outlook.office365.com
 (2603:10b6:408:ec::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 08:13:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 08:13:20 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 23 Jun 2026 03:13:18 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH 1/3] drm/amdgpu: Add PASID fpriv lookup manager
Date: Tue, 23 Jun 2026 13:42:59 +0530
Message-ID: <20260623081301.3046023-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623081301.3046023-1-srinivasan.shanmugam@amd.com>
References: <20260623081301.3046023-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|SA1PR12MB9545:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dcb7a19-8cce-4b09-3eab-08ded0ff49e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: jSSBcBI3WsdqqYyk3tU51ulb7iCGmnT7LdHvLuCctz4fo4hdQtrmyNQyA9UAFy1CpcoluV0/jd80SGEy2o7U4w1SDDlMSh7MKe/KGLVXpeQIzs1VBaKKmWQHSq7DCaJ/Fk+fkBcVkIqjZZlLIMa1lRaKQn4yzvxB6/vtn6OdSOO6y/9THGXjWJsYW+jTzrdonzKsh5fkWPWS7YpRPuPu6QXJj6HKeFBIfsU0rtovQXa0JHfsX/vJZrJJz0WGsu7nx5NcKErAO+3/khhFgVSofdDSvOO3ds0S5SExVEhTpmY4w5ZFahIbdVzLnkwtJ23gyWK8/PShVsgZomtvpxaBG4AMN3XNWzzraN1w079mD85X6RPuoG3UeeBfm5MbaB7/07RBj1gJaOdIahL1niPUfPiMerhaVHqsXOmb3OtUVrphIf2Y39rWpqntsGHSuH74v+Mvd4+KoGMItNM+MT0kD/8nd3nRs2AOQASo0zG18E/I4Nv0Rbr/nNGCIh8mNHR44p5qK/z4PvulSu0PneCmuNCp4+/XAsE5lW0kUpi+2YixkAswty1y8/eLt7BNYn8RPdv7NKwkpACQxUqNquNBWcGKelANXi5oSnWEN7OudUDbWbz/jU+1sBMABwD0UJF6raeRgty4X+dlBHiUoE35d8hQqvR0/pwP9Sa/PqUvrp4TklyOvrelRgHSHYzAwVaUt+a+XqLWCzsRsnxxGhQg4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zRNgMhDd5YVp9BXDzvdYeP4N3JwyMHFI1bFeCKobd7SLxUoGfQqGl63EIU3KhV13ltdmGbpnA9tgRcOMo51UPMsDH8zgvLlJZigHHYLZT9JPSicXYkuKaOobhSsjQDNXIZ99hW4R2k3rTOPyYqIrVHTDMjOX8dpkCFoOlpBd61wcCfuIgMn9NbEUM+TCl5kH8fb6XK0K3YJlUCxm3cpLV8L1OFPERKK87qP5Q4GxbZowVFFsFlg/2yj8zR6mu/yu8TDaHeB+6iGjdcR+RnycGADllAeoztI19pLgCrpxf9GL+HssgGC7uhp1WwJOsFY0wxe29r9efOGrgviDivUoqyFIq1sI4WNPqPtG5jszUoUsh18rjRLN/0qVrGdMXYF6uYVDbYXKFEGPHAPmg/P4xqQPWiryihYwVfEpE3Rh9NCzOmBMmp5AsRBplFhXaypa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 08:13:20.7636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dcb7a19-8cce-4b09-3eab-08ded0ff49e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9545
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

Current VM fault handling resolves PASIDs through VM state:

	PASID -> VM

That is sufficient for VM fault handling, but process-scoped event
delivery paths need a different semantic mapping:

	PASID -> amdgpu_fpriv

Although both mappings are indexed by PASID, they serve different
purposes:

	vm_manager.pasids
		PASID -> VM fault handling

	vm_manager.pasid_fprivs
		PASID -> process-scoped DRM file-private owner

Add a PASID fpriv xarray beside the existing PASID to VM xarray.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |  5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 13 +++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 450bd9dc6bc0..3141ae1383b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2869,6 +2869,8 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
 #endif
 
 	xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
+	xa_init_flags(&adev->vm_manager.pasid_fprivs,
+		      XA_FLAGS_LOCK_IRQ);
 }
 
 /**
@@ -2881,7 +2883,10 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
 void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
 {
 	WARN_ON(!xa_empty(&adev->vm_manager.pasids));
+	WARN_ON(!xa_empty(&adev->vm_manager.pasid_fprivs));
+
 	xa_destroy(&adev->vm_manager.pasids);
+	xa_destroy(&adev->vm_manager.pasid_fprivs);
 
 	amdgpu_vmid_mgr_fini(adev);
 	amdgpu_pasid_mgr_cleanup();
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 4d96bb8c2c6d..5318e833bd97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -450,6 +450,8 @@ struct amdgpu_vm {
 	struct amdgpu_vm_fault_info fault_info;
 };
 
+struct amdgpu_fpriv;
+
 struct amdgpu_vm_manager {
 	/* Handling of VMIDs */
 	struct amdgpu_vmid_mgr			id_mgr[AMDGPU_MAX_VMHUBS];
@@ -484,6 +486,17 @@ struct amdgpu_vm_manager {
 	 * look up VM of a page fault
 	 */
 	struct xarray				pasids;
+
+	/*
+	 * PASID to DRM file-private mapping.
+	 *
+	 * This is separate from @pasids. @pasids answers which VM
+	 * should be used for VM fault handling, while @pasid_fprivs
+	 * answers which DRM file-private owner should receive
+	 * process-scoped events.
+	 */
+	struct xarray pasid_fprivs;
+
 	/* Global registration of recent page fault information */
 	struct amdgpu_vm_fault_info	fault_info;
 };
-- 
2.34.1

