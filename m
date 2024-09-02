Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B94CD3427
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Sep 2024 07:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C698D10E21E;
	Mon,  2 Sep 2024 07:34:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yotpK2mT";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E8B10E21E
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Sep 2024 07:34:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGnVfVqpInv4Q7CE76QbeybBBva2K1NM3RFCCx1Vyw9DS+dCVDtpobRdwV8p/RXbjpegbwqWf/J21NifMFktA3IcQzutD3UNQiBoC8jfU1pJC0lkVvylmhdXX8M1K5nY+MwzoH1KNfJLfcl0jft6e0P9H66mKCd/sXMNTflRy5Xzv7DI6j/KXMyTneAkPtTZwKu4SlaARPj6Di180MWmuHoBYtS3gM2nACQlFduBOH/uqRMT3dl+0aPrww1T88y+H3eJvDKjinQtBiT6bDhD12tG33GA3+CYNrmzak72U+KQdAiiNBdqCCAd1J2T6W/dyMttiRvi2TGGabFclmL+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2c1320p7tf3kZ4DJp3VyFhCFv0fTrZPIROOpp4YY5w=;
 b=c0EbbZrcYbg//nvdCQ8mNuTg5ZfNPJWzV9pb6qdXENAQn2AifKFqOnBhEe9F0rTM/bIA+XmYZj3dmONRtPuIaMrx/7Fzi7JsM9OKYk1gzbbr/MgqLfh40zTuYvQUSQ7mB3y5Ifx2AZwklQ3k0FcbmQbT8IZMFzVtpYCmxitlNRL2LsCsVi4Z8VPFm2y9qBlnIlmjVWTSY5J/xHigdXs/OSZYhb4Vz13FpJJWUg8aoq3EJSCBBBBI4eyuAYbj2G2jpZYAyUwfhlo22wbDgJsl5PuJipQ5vOt4taaCkIds3vEnWDxQ1Py31UdbUXTxjC8lxsAQDDXx7e/kCycnrASs9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2c1320p7tf3kZ4DJp3VyFhCFv0fTrZPIROOpp4YY5w=;
 b=yotpK2mTTpj2WcTjihrDK1WwUxVHL15hIHSKxx5obSmj4rW1PID6mLBxlZyFwsPtou0C7S2THn5yxEviOFcH6MUQ1PhgzKNL5WNhBi7Zc+hndo7qIfGv5PpCngJBLXp4L1oJqiwzTZoMeXr4FTVRIFKnBv635NWczopdD606Xbg=
Received: from BN8PR04CA0050.namprd04.prod.outlook.com (2603:10b6:408:d4::24)
 by DM4PR12MB6446.namprd12.prod.outlook.com (2603:10b6:8:be::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.24; Mon, 2 Sep 2024 07:34:48 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::21) by BN8PR04CA0050.outlook.office365.com
 (2603:10b6:408:d4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24 via Frontend
 Transport; Mon, 2 Sep 2024 07:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 2 Sep 2024 07:34:47 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 02:34:45 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>
Subject: [PATCH 07/10] drm/amdgpu: Drop delayed reset work handler
Date: Mon, 2 Sep 2024 13:04:14 +0530
Message-ID: <20240902073417.2025971-8-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902073417.2025971-1-lijo.lazar@amd.com>
References: <20240902073417.2025971-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|DM4PR12MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: f55e4d73-e63b-412a-04b1-08dccb21b91b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JrrZ3aMSk9WTudh+umFQcOM8eWZD3j3elWE5+YlO0dQ8zfIJwWwW3haWLmJC?=
 =?us-ascii?Q?bAOaUvYvq4YwEkvVi5cn8X3wXUFPKHBEtxF+mC+9UHRlOYmu7IsXlgP39fFG?=
 =?us-ascii?Q?FAr3nBcYhz7BAr+Nxsxs7I1KoDw8VpUDwfaEtWOk0m+93CbBcLQqOUV25dnw?=
 =?us-ascii?Q?c3xJ9TE6kZTMLmGafncQ7Z/zwqcmt1qSB4MYBgRwQ2FHEYSDv26etMSnzkNX?=
 =?us-ascii?Q?CXV+6xke9ByNzszrZKs+eBFO782SZ83lJkvdD+s7CFVFSpHhfrkn63p2BhAx?=
 =?us-ascii?Q?SpqoNGg8wnmCkus1jKo/2pjJFewhWbHgBOzKl0oXGkzODQWkaFgRSPxUqJPt?=
 =?us-ascii?Q?DVOzew4kiBZAYwnIF5QRtTobaMgvSB4dfGULd//A2Y0oWij08k+zUY/W3pPN?=
 =?us-ascii?Q?CVCTbsPz4u4YVNsEtqOanhW1itGOH/uF0IXRFMwIMddoB4lVOu5Z2TFyuyuU?=
 =?us-ascii?Q?FmK8XnG/X7jy1TjbTMN6joF5nJdwSq7Wp8fAfhbwMTeP2lsy3p4q/VSVZ/9q?=
 =?us-ascii?Q?Pyz67LwQq6kFxR4CBGhXDR50HEKQ/j77sDGhRWQJmXriV3TTpx6ph30VGFTa?=
 =?us-ascii?Q?X0enTKvxvbBrGpj8kis5GAk5xkURU5gMmDhjd6QzGiZI/RGWooUepovOubjR?=
 =?us-ascii?Q?zFsDyT2dXlMsrH+TLvJEaKUHtAKPtkrK2G7z+ZxDNsH6w5N9KBuCgO2/7Zyb?=
 =?us-ascii?Q?mCuq+NHvKJlimz9AW8/sf1fWfznefj9955RPpkoRZoFyVde2/ixBZVKO8Is8?=
 =?us-ascii?Q?94dZjlHDLp8gIOgIJdBnb7zL4u3G/TqE30pXzf0iiU7/pgt+fKNSS2d7T+XV?=
 =?us-ascii?Q?MJRB/FmTkNxP99izT4g60X+VsR8L8LE0KIyGldV0XqYjbU6aI1KqPdBDmOKZ?=
 =?us-ascii?Q?Edv5NoIDMnpXKm0upgq1+Mrq4MOZp00rLGurrzzA8RP0jXjvhQgoXgN7IV8h?=
 =?us-ascii?Q?QtW0gYFZA3XcNKiWP2qyT8GhWQ4OVrPekYPwHX5VGpbbbW3NDEhO7QTeRLfN?=
 =?us-ascii?Q?IxcdMn/KJkrluxNwCnj74t7H3VRHOST3i9Bbb9lFOhMzWizwzmC1mh+h4tXn?=
 =?us-ascii?Q?1ozwl6KiiMRZPX62Zf/0MTllAVyF//SSgJX1hScfr0MBVw+08g1Nq6qY574d?=
 =?us-ascii?Q?7kNx0XbI+4lKVpROLY5u9PS2h/DG9gXt/GF+N+GFmwfUp//LCr+b8HEaQ1Ia?=
 =?us-ascii?Q?mLZ0R8niYQLevUHJJWauspJ+tDD080ihhtt9//BBdiHwxwIxfPJqndTlAR8A?=
 =?us-ascii?Q?pva7aQlPtZ3+nrc4w39BAXn+2ZmMvtgkhBYjNqoUVKQrlCr1PQIP9/SXHCvO?=
 =?us-ascii?Q?lWfjyhkSXqKiNQ6a4P4Sp9cTVsQduEjMbK/eyfQtFrX4ns/R+XQ0de/tudvH?=
 =?us-ascii?Q?E7n8e06juLXMFaiJqCzzhWVT3UTnfeidlGyBJjdERAHqIcwHKvjV5ldgqwy2?=
 =?us-ascii?Q?5T7pjseDlQOIw3LE/1JTRdRAD7+FyzfE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 07:34:47.8901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f55e4d73-e63b-412a-04b1-08dccb21b91b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6446
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

Drop delayed reset work handler as it is no longer used.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  4 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 80 -------------------------
 2 files changed, 84 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d17506d9adae..9285108d537f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -131,10 +131,6 @@ struct amdgpu_mgpu_info {
 	uint32_t			num_gpu;
 	uint32_t			num_dgpu;
 	uint32_t			num_apu;
-
-	/* delayed reset_func for XGMI configuration if necessary */
-	struct delayed_work		delayed_reset_work;
-	bool				pending_reset;
 };
 
 enum amdgpu_ss {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3dece2e69608..4f644b120df7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -221,8 +221,6 @@ int amdgpu_wbrf = -1;
 int amdgpu_damage_clips = -1; /* auto */
 int amdgpu_umsch_mm_fwlog;
 
-static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
-
 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
 			"DRM_UT_DRIVER",
@@ -237,9 +235,6 @@ DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 
 struct amdgpu_mgpu_info mgpu_info = {
 	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
-	.delayed_reset_work = __DELAYED_WORK_INITIALIZER(
-			mgpu_info.delayed_reset_work,
-			amdgpu_drv_delayed_reset_work_handler, 0),
 };
 int amdgpu_ras_enable = -1;
 uint amdgpu_ras_mask = 0xffffffff;
@@ -2455,81 +2450,6 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
 	adev->mp1_state = PP_MP1_STATE_NONE;
 }
 
-/**
- * amdgpu_drv_delayed_reset_work_handler - work handler for reset
- *
- * @work: work_struct.
- */
-static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work)
-{
-	struct list_head device_list;
-	struct amdgpu_device *adev;
-	int i, r;
-	struct amdgpu_reset_context reset_context;
-
-	memset(&reset_context, 0, sizeof(reset_context));
-
-	mutex_lock(&mgpu_info.mutex);
-	if (mgpu_info.pending_reset == true) {
-		mutex_unlock(&mgpu_info.mutex);
-		return;
-	}
-	mgpu_info.pending_reset = true;
-	mutex_unlock(&mgpu_info.mutex);
-
-	/* Use a common context, just need to make sure full reset is done */
-	reset_context.method = AMD_RESET_METHOD_NONE;
-	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
-
-	for (i = 0; i < mgpu_info.num_dgpu; i++) {
-		adev = mgpu_info.gpu_ins[i].adev;
-		reset_context.reset_req_dev = adev;
-		r = amdgpu_device_pre_asic_reset(adev, &reset_context);
-		if (r) {
-			dev_err(adev->dev, "GPU pre asic reset failed with err, %d for drm dev, %s ",
-				r, adev_to_drm(adev)->unique);
-		}
-		if (!queue_work(system_unbound_wq, &adev->xgmi_reset_work))
-			r = -EALREADY;
-	}
-	for (i = 0; i < mgpu_info.num_dgpu; i++) {
-		adev = mgpu_info.gpu_ins[i].adev;
-		flush_work(&adev->xgmi_reset_work);
-	}
-
-	/* reset function will rebuild the xgmi hive info , clear it now */
-	for (i = 0; i < mgpu_info.num_dgpu; i++)
-		amdgpu_xgmi_remove_device(mgpu_info.gpu_ins[i].adev);
-
-	INIT_LIST_HEAD(&device_list);
-
-	for (i = 0; i < mgpu_info.num_dgpu; i++)
-		list_add_tail(&mgpu_info.gpu_ins[i].adev->reset_list, &device_list);
-
-	/* unregister the GPU first, reset function will add them back */
-	list_for_each_entry(adev, &device_list, reset_list)
-		amdgpu_unregister_gpu_instance(adev);
-
-	/* Use a common context, just need to make sure full reset is done */
-	set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
-	set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
-	r = amdgpu_do_asic_reset(&device_list, &reset_context);
-
-	if (r) {
-		DRM_ERROR("reinit gpus failure");
-		return;
-	}
-	for (i = 0; i < mgpu_info.num_dgpu; i++) {
-		adev = mgpu_info.gpu_ins[i].adev;
-		if (!adev->kfd.init_complete) {
-			kgd2kfd_init_zone_device(adev);
-			amdgpu_amdkfd_device_init(adev);
-			amdgpu_amdkfd_drm_client_create(adev);
-		}
-		amdgpu_ttm_set_buffer_funcs_status(adev, true);
-	}
-}
-
 static int amdgpu_pmops_prepare(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
-- 
2.25.1

