Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3479CD116F6
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 23:15:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBF1910E4C5;
	Mon,  1 Dec 2025 23:15:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MjTs3P4M";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1012D10E4C4
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 23:15:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZq07tbR75riMuaqYk4wfQySOMBrM79g9bA/lYpszS6VgmAUdVuDcKZNSxsRUk6xRwT6hk+zHAKHfCu5rmABievKp1VQMRd/Pb/s2BSWjei4/DBb06wUJTnbTOLHhpwntL+HJtc1pItgzPSIlRjpYOMgc/T2BwX+1tg3CIU5JGEsIQqTFBvQ/TO8Jxu2MZdyJK/4EQvk1iFjt2f1BzW0JP6G4+fRuWUiLMo21utkP/jH7MaF8bjgG6N/Y0aBnJinixd3+wpQ/RlJ4l1k5iixVnsr0RUo7CM0cYJ5m94D1OIaQZQh4fpdDIKJMxTXDG6zcSxlWwqNKjKa44jn8U/cSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJzQv9NP6cYUeaUXh6ADd7WtdRs74Qgz69uYD/dAsCs=;
 b=MfC8T9PdqJpUKpWoei9fdV6u1GjoYs3iCDzdybbOBkll/WM1LiU5j6VeToMBk9JNfC+ZVol7s9JvWw4vhs/sgaxMONmHrZO4hSG4dKlzrJxcYwA91ftrxIx0ywchAkHGFlIkhQuFJMstc+5bnbqQOw62PqdCBX61qzzGEYzPGOOxWSL2rYFyuMgUJDYyh3Q/FII33/4VgSqsIyngdiLV0HVMy47Q5eb45KuF4cjlaY6PKsS3Z7R2CRXb7A0jn+ZTy9jueV5ipGYiLkuZzq3siHQHmxQD0rvGT27+fQZ5uBkMytcuJEFX8jlS68mAOP0Huho69uarbmLdzG374uaEcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJzQv9NP6cYUeaUXh6ADd7WtdRs74Qgz69uYD/dAsCs=;
 b=MjTs3P4MlGDhJJvMYxROcrb7mlL3fbEEFkbpAZcB0mFs0TCeb+JQG4qrgcK9Y/+XRtQ61rgQCfCnluVPFDBwcwwZhvn9mYYhkirBorFigRohadX5AQpRFza2EYbJPSck+IlPzAqivOFI52z4coIauk/G7ES4DRGe7GmpQQ6r/JM=
Received: from SA1P222CA0045.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::22)
 by DS0PR12MB7874.namprd12.prod.outlook.com (2603:10b6:8:141::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 23:15:26 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::1e) by SA1P222CA0045.outlook.office365.com
 (2603:10b6:806:2d0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 23:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 23:15:26 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 17:15:22 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Setup MTYPEs for GFX 12.1.0
Date: Mon, 1 Dec 2025 18:15:02 -0500
Message-ID: <20251201231509.791954-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251201231509.791954-1-alexander.deucher@amd.com>
References: <20251201231509.791954-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|DS0PR12MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: d3e85e1b-1a9f-4353-ca10-08de312f8323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?83e4YfQ+Vdjl0qja5GKiYEpLxtPjjcuzfICFhbPMo7LX8OD81akn3UrojABT?=
 =?us-ascii?Q?r39CL3mr4Szw4/zNVuNOe/aVGtKWg7gsxspS7puTEUeI3MAB7rEoaPMblm+L?=
 =?us-ascii?Q?NmhQmh1vFowl/ANujNWkUvPdF6ZGGLFA4CN33D4cT6Tdd2TZBQnArgED+Rpc?=
 =?us-ascii?Q?0ysB3jq6JZLAjb+vy9uniRzD5v+R7FlLasg8EkeSIbJbHTODvFON2qBiVENu?=
 =?us-ascii?Q?cOxBa07zmV59DWBrxRpf1tQYq+ytSS/hPDSsD+kw2quejWpVKbiX/fClUsyP?=
 =?us-ascii?Q?5BjpatguFbH/UBTrDj3LLoNaV73GOTTCadbbJW4UrF3hSefp1cIddSu6QUgk?=
 =?us-ascii?Q?R64vr1xtBcdM+KP21o8J2Wv3ygh0eCf1Rr/dhzBcTmND33ta3zvvifABLHrG?=
 =?us-ascii?Q?OeJjYHi8/w/O0xqK+v0uZFq2X7VNiaZnfb+MUKvvJwyX5guHwubCx29rMYt9?=
 =?us-ascii?Q?8e8tmdElyhXswzJYLCESTSQfRb60whI5mMSTSQEsDG59YZIo1ibkIl2dRlfF?=
 =?us-ascii?Q?X420DtazIqr16SWQIsHpPof/SU+J67VJKm9T7gSj848GOVIiSTB+J5IhN7vF?=
 =?us-ascii?Q?xFDzvIgpdGGW/mLV5TrcixAfIlGOkXEEf8wca2QX0ASJjnM3liUTrlkGOm8/?=
 =?us-ascii?Q?O804cwp16Dh4FGwAZX7tInCZDEL3sV90FezU9Jg5pOtKni+Y/BEbUujqkJAI?=
 =?us-ascii?Q?gWGUHVYAl63xmiK2LxjBw6lIZ+YavL5Ef6g4aacMRa/Cb0G1O9I3bDI2S6u/?=
 =?us-ascii?Q?xjO9Ll1CZkVOo8kEjlIkUpjKtaCOsmpP6Hp6ewIJjHDYYfeL1+3BlKZAu2E6?=
 =?us-ascii?Q?AMvZ/Js0k1d5WQNx4SUQ080mh2JzNmD7DvIFz984NoY5v9BzsbsY9Qbx4ui2?=
 =?us-ascii?Q?AMT3GWLKbl76YNYREIlUgCTxR/TZ7OvLV8O9Gsah8ITXW7JmnXAAs1CGPfit?=
 =?us-ascii?Q?KSLKh5yphQKygEWUupXraQje4E0RP+PNjSSwvCcw+kEqrsLj1KuSJq4Pmw2n?=
 =?us-ascii?Q?NdHT1am27d9DX7u6VCRckYBLiibmS4x18yeYVgXyy+l0YkGqc0IIlhvtInsy?=
 =?us-ascii?Q?bGXCWYYvlJZ5v2Au27XRF0GsDLxG+nai1xE/NhH2wVYSoVbtgpG2uxwixH2J?=
 =?us-ascii?Q?zRO+7sEDw664/NocXcfKZjW1XwxOOVUE8+AF6v00xwX22nfc1cmeAM9ocsjV?=
 =?us-ascii?Q?z92s/JvDROFcf6PDZUOTTe13wXmUO8jZ/DKifyzaHSNXmBuTh1xu+/y5QbZV?=
 =?us-ascii?Q?0OTZGXWjHP5ecao3c04dvdoII+cSqplRuw7SzT2NOca5EibPdM+5v3EWhf0B?=
 =?us-ascii?Q?355W0GiaWVBJZc8YETlG3UFrGNoEmyXGh83DFTajCz3rOOarXeXwOnVVJdrg?=
 =?us-ascii?Q?0NqZ+Pld5zihSL7fw/vnRnSnuqCYbeDjegbOnC1tI274dpiQZJCK3CY/RkVr?=
 =?us-ascii?Q?yeBebUNqS90EE/5VMStRbJ6aWx5VIdiqzhL90iBDHmmrOGLpJB9rmLjimtZx?=
 =?us-ascii?Q?P/sj71jcjTFLi7tkbuvuLyWydV6asYzMFoCLNrUNBcmik5wdaWK6FEeWspim?=
 =?us-ascii?Q?X/eTHnwB7pLFuNV/nSE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 23:15:26.6170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e85e1b-1a9f-4353-ca10-08de312f8323
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7874
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

From: Mukul Joshi <mukul.joshi@amd.com>

For GFX 12.1.0, setup correct MTYPE for a BO depending on
its current location relative to the mapping GPU.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by:  Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 62 ++++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 15 +++++++
 2 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 4ead488261a68..b9ae8469d5538 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -265,6 +265,62 @@ static void gmc_v12_1_get_vm_pde(struct amdgpu_device *adev, int level,
 	}
 }
 
+#if 0
+static void gmc_v12_1_get_coherence_flags(struct amdgpu_device *adev,
+					  struct amdgpu_bo *bo,
+					  uint64_t *flags)
+{
+	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	bool is_vram = bo->tbo.resource &&
+		       bo->tbo.resource->mem_type == TTM_PL_VRAM;
+	bool coherent = bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
+				     AMDGPU_GEM_CREATE_EXT_COHERENT);
+	bool ext_coherent = bo->flags & AMDGPU_GEM_CREATE_EXT_COHERENT;
+	uint32_t gc_ip_version = amdgpu_ip_version(adev, GC_HWIP, 0);
+	bool uncached = bo->flags & AMDGPU_GEM_CREATE_UNCACHED;
+	unsigned int mtype, mtype_local;
+	bool snoop = false;
+	bool is_local;
+
+	switch (gc_ip_version) {
+	case IP_VERSION(12, 1, 0):
+		mtype_local = MTYPE_RW;
+		if (amdgpu_mtype_local == 1) {
+			DRM_INFO_ONCE("Using MTYPE_NC for local memory\n");
+			mtype_local = MTYPE_NC;
+		} else if (amdgpu_mtype_local == 2) {
+			DRM_INFO_ONCE("MTYPE_CC not supported, using MTYPE_RW instead for local memory\n");
+		} else {
+			DRM_INFO_ONCE("Using MTYPE_RW for local memory\n");
+		}
+
+		is_local = (is_vram && adev == bo_adev);
+		snoop = true;
+		if (uncached) {
+			mtype = MTYPE_UC;
+		} else if (ext_coherent) {
+			mtype = is_local ? mtype_local : MTYPE_UC;
+		} else {
+			if (is_local)
+				mtype = mtype_local;
+			else
+				mtype = MTYPE_NC;
+		}
+		break;
+	default:
+		if (uncached || coherent)
+			mtype = MTYPE_UC;
+		else
+			mtype = MTYPE_NC;
+	}
+
+	if (mtype != MTYPE_NC)
+		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, mtype);
+
+	*flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
+}
+#endif
+
 static void gmc_v12_1_get_vm_pte(struct amdgpu_device *adev,
 				 struct amdgpu_vm *vm,
 				 struct amdgpu_bo *bo,
@@ -306,11 +362,11 @@ static void gmc_v12_1_get_vm_pte(struct amdgpu_device *adev,
 			       AMDGPU_GEM_CREATE_UNCACHED))
 		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
 
-	if (bo && bo->flags & AMDGPU_GEM_CREATE_UNCACHED)
-		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
-
 	if (adev->have_atomics_support)
 		*flags |= AMDGPU_PTE_BUS_ATOMICS;
+
+	if (bo && bo->flags & AMDGPU_GEM_CREATE_UNCACHED)
+		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
 }
 
 static const struct amdgpu_gmc_funcs gmc_v12_1_gmc_funcs = {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 903064610c23c..0210819b4c7f2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1287,6 +1287,21 @@ svm_range_get_pte_flags(struct kfd_node *node, struct amdgpu_vm *vm,
 	case IP_VERSION(12, 0, 1):
 		mapping_flags |= AMDGPU_VM_MTYPE_NC;
 		break;
+	case IP_VERSION(12, 1, 0):
+		snoop = true;
+		if (domain == SVM_RANGE_VRAM_DOMAIN) {
+			/* local HBM  */
+			if (bo_node->adev == node->adev)
+				mapping_flags |= AMDGPU_VM_MTYPE_RW;
+			/* Remote GPU memory */
+			else
+				mapping_flags |= ext_coherent ? AMDGPU_VM_MTYPE_UC :
+								AMDGPU_VM_MTYPE_NC;
+		/* system memory accessed by the dGPU */
+		} else {
+			mapping_flags |= ext_coherent ? AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
+		}
+		break;
 	default:
 		mapping_flags |= coherent ?
 			AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
-- 
2.51.1

