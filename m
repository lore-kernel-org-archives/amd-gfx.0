Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9459EC624D2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9BF810EAA1;
	Mon, 31 Aug 2026 18:30:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qvdoZ95q";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011059.outbound.protection.outlook.com [52.101.57.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85E3F10EA8F
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPqA0rQobKPZkSETmdY7sSNJUZS47TNRDU9MTbD+w3v1do2VxyocYeoCDFZRDHjW+fq5fJaW0ndy6Ht++GQeBqVgEs/WiJiUItBUCeKUk4OdAAJjztvkPuzCoRLZOvf5Qfi4p7BYgagHBAnFpdL0E7rjNdxsoAToPSvLXDMjYWFQek62Hryjy1bKTYtLgFDOU1IUa9TJJZSba7Hn39rkFkjadHAYc9Wsxd8RYbUk21Z0z1mpBxec2FW9Djy5A63ObEmthlsNQfdRFOmHACcA+ddxJcxrMpGSenm9M2+YVJibfRL6tg7PS/jZAODfmLLJKvrlCE+d2Ntl+y+izRhYYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtfa+haWJ7wPi1SPfTzA8mTWN5CbvgnsJyy6oCf35tY=;
 b=rVHIOOxX3pNC58L2K7AoAAakiIIXZkBFv1/4+055gzHtrVHm8gw5Gj+pLNqnKbGYr0BnqMalHaaOypoLQi7EcjR8mbzxI/9a/GlaOTDX2XXgl9fj4nEHsmFiT9s9JNk2HML/x0A76vnsKTm/IYzOPt3lScommO7Tv2Uv3ARoyUKyciyWpC6ODAMNJz7l0qTqMpo9tmy5VR+Zyw5Bt/lCHDSdQVHvW5gKS2CJP19IBfQgOtm7pFd0l+4W5SbZvwUF5lzt9A1s2Lx2KWFSovUEzXCEAjBd6PFe7M0Cxd2X+4+eNxWuZY2qv06hpjS9uJ4sDQhqRWuJJUyecdGeNQ4IFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtfa+haWJ7wPi1SPfTzA8mTWN5CbvgnsJyy6oCf35tY=;
 b=qvdoZ95q2yYIprZtVFdyrbSbmECTrGUVXFSQy44qCzdmQwF3JRWoNIBnEAtHisW9gmEuiXGRo5iWV29oYTSk565VqsWAttnrMMxmR5mru5iDA2eN1n7oHp7OytWk1mdv5ATpjLeT+0yGTDU3vxeI8JMXarB2/HOPPsxq8R+ReZA=
Received: from BN0PR04CA0066.namprd04.prod.outlook.com (2603:10b6:408:ea::11)
 by DS0PR12MB9274.namprd12.prod.outlook.com (2603:10b6:8:1a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:18 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::95) by BN0PR04CA0066.outlook.office365.com
 (2603:10b6:408:ea::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:29:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:29:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:29:06 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:29:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 94/95] drm/amdgpu: add mtype_remote module parameter
Date: Mon, 31 Aug 2026 14:27:53 -0400
Message-ID: <20260831182754.1089811-95-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|DS0PR12MB9274:EE_
X-MS-Office365-Filtering-Correlation-Id: 63065a22-ff1b-4b61-e373-08df078dc514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|3023799007|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZcHKC9YZgJSmfV0IrCfRjHEIyXwWeB14C5TGTkFXwlGW+s9l591pnwSPzjMgTxTAYr9HvRJOig5RUU4ImmNBRapGUn5VnyhrKQ6Q1z59PIIsq1CI2NHrPmAmnaVZ/T6vQ1j1vQxYTbbXnSyRQC/A4pQSJO2g2bOUCOc4+DH/Hv+1riwwhik4ayv/9IofiIdWyGKovjf8afjV03C1bWsG4TBn/vSB3jIarI4rJmN+QwzZ+Aeh7gdpkfZvmKfRW9TZTyVP8GclUdrum3B2PItV1CuXIomoRhdL9oY/kPMJn/IjrJYXHiD0gjsk9nfOwNNGOYw794/s+PGv4NGmj2RH4D9oQ65OWLWuttF0ZnjEIthWhUSTSQjveYJs1PZcOVvMIhUNolNDFvlA5lPddgCplAQp3f4XvEdMEbyUww0ze5gG1YBRtXf/3xmVYOSm87uZQl3ICwWamaKGeLFmo25cuWW9DkJTqUDnIUSWlhUbXGvxc3cKxH0kdzUC9jfrdui4cvSXre0Omvg0+JtWnSbUahEL8WfF0SFb+Ye/JliHbe7tZtgX1vur0qr9qOWMxW7Ym9qD13HLWj2FVBeKOnWLm9c0cUpHz+Dxgfy+szCeClgh6/ecMbJqOWQ4F4ozi0eriaBSYOlEkCntsMdvxv5BtGxqMKNy9UVYkY2+eSm0vwS98k2iX/pUj2y4zMgyJhPPjB+m3FX9jk2EawziSItu+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(3023799007)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cTW8SFsqgJKIbOSZFOdp4UO6Qr/fmUrk+jmnaV1sOxmchrHf2/Ez4tGs1sa4D63nOghoMowqdq9CyWjoWSHv+jkeExXjTMX5ZNlW1dDBUFwfwEQ8Hbn5IuNQ8Ph7qzKBJoI3TrxJdqSpQbd9uRUVES5szUJHooHROdGnYXh1T3eh6HFHoT8+ZFQcg/4RjhMM9CcYzl4/oKvsKsxauLY3NgKgyWcl3dHhRXkFgPi81rtG0Rqgzx7r9o7bcuTTz1FXnMig8a6V/GoMq2mIkrsrltexTXv29ro5BoLKv7iDN84WzU1zICEWWAsoQkGrtnih9zc2I7ziMdY1gKpGT52N/+wGWlJ9PlSJpBqBpEzYOjRLEdAlk7bmpbamzlBtJ4qgDkuSs8FQQAlKZXfOftC+OtnsE1IwfGC7j7Bjh8lS7NaQYYKosDZBl7p3fgdfSWmw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:18.7649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63065a22-ff1b-4b61-e373-08df078dc514
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9274
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

Add an amdgpu_mtype_remote module parameter so the MTYPE used for remote
memory accesses can be overridden. For now only MTYPE_NC and MTYPE_UC
are selectable (0 = MTYPE_NC, 1 = MTYPE_UC); it defaults to the
ASIC-dependent value. Currently, it is used only for GFX 12.1.

The MTYPEs resolved for both local and remote memory are logged once.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  7 +++++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c  | 34 +++++++++++++------------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    |  8 ++++--
 4 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f619d95a5ccfe..79b69d74eb2e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -223,6 +223,7 @@ extern int amdgpu_force_asic_type;
 extern int amdgpu_smartshift_bias;
 extern int amdgpu_use_xgmi_p2p;
 extern int amdgpu_mtype_local;
+extern int amdgpu_mtype_remote;
 extern int amdgpu_enforce_isolation;
 extern uint amdgpu_debug_mask;
 #ifdef CONFIG_HSA_AMD
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 9c2ff3e147d17..287c9455969b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -845,6 +845,13 @@ int amdgpu_mtype_local = -1;
 MODULE_PARM_DESC(mtype_local, "MTYPE for local memory (default: ASIC dependent, 0 = MTYPE_RW, 1 = MTYPE_NC, 2 = MTYPE_CC)");
 module_param_named_unsafe(mtype_local, amdgpu_mtype_local, int, 0444);
 
+/**
+ * DOC: mtype_remote (int)
+ */
+int amdgpu_mtype_remote = -1;
+MODULE_PARM_DESC(mtype_remote, "MTYPE for remote memory (default: ASIC dependent, 0 = MTYPE_NC, 1 = MTYPE_UC)");
+module_param_named_unsafe(mtype_remote, amdgpu_mtype_remote, int, 0444);
+
 /**
  * DOC: pcie_p2p (bool)
  * Enable PCIe P2P (requires large-BAR). Default value: true (on)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index a3b7e240abaed..4e7b6e2c87ab5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -618,8 +618,8 @@ static void gmc_v12_1_get_npa_flags(struct amdgpu_device *adev,
 
 /*
  * Resolve the MTYPEs used for local and remote memory accesses on GFX 12.1.
- * Remote memory always uses MTYPE_UC; local memory depends on the AID stepping
- * and the amdgpu_mtype_local module parameter.
+ * Both default to an ASIC-dependent value that can be overridden through the
+ * amdgpu_mtype_local and amdgpu_mtype_remote module parameters.
  */
 static void gmc_v12_1_get_mtypes(struct amdgpu_device *adev,
 				 unsigned int *mtype_local,
@@ -627,23 +627,25 @@ static void gmc_v12_1_get_mtypes(struct amdgpu_device *adev,
 {
 	bool is_aid_a1 = (adev->rev_id & 0x10);
 
+	/* Local memory: ASIC default depends on the AID stepping. */
 	*mtype_local = is_aid_a1 ? MTYPE_RW : MTYPE_NC;
-	/* Remote memory always uses MTYPE_UC on GFX 12.1. */
-	*mtype_remote = MTYPE_UC;
-
-	if (amdgpu_mtype_local == 0) {
-		DRM_INFO_ONCE("Using MTYPE_RW for local memory\n");
+	if (amdgpu_mtype_local == 0)
 		*mtype_local = MTYPE_RW;
-	} else if (amdgpu_mtype_local == 1) {
-		DRM_INFO_ONCE("Using MTYPE_NC for local memory\n");
+	else if (amdgpu_mtype_local == 1)
 		*mtype_local = MTYPE_NC;
-	} else if (amdgpu_mtype_local == 2) {
-		DRM_INFO_ONCE("MTYPE_CC not supported, using %s for local memory\n",
-			      is_aid_a1 ? "MTYPE_RW" : "MTYPE_NC");
-	} else {
-		DRM_INFO_ONCE("Using %s for local memory and MTYPE_UC for remote memory\n",
-			      is_aid_a1 ? "MTYPE_RW" : "MTYPE_NC");
-	}
+	else if (amdgpu_mtype_local == 2)
+		DRM_INFO_ONCE("MTYPE_CC not supported for local memory\n");
+
+	/* Remote memory defaults to MTYPE_UC on GFX 12.1. */
+	*mtype_remote = MTYPE_UC;
+	if (amdgpu_mtype_remote == 0)
+		*mtype_remote = MTYPE_NC;
+	else if (amdgpu_mtype_remote == 1)
+		*mtype_remote = MTYPE_UC;
+
+	DRM_INFO_ONCE("Using %s for local memory and %s for remote memory\n",
+		      *mtype_local == MTYPE_RW ? "MTYPE_RW" : "MTYPE_NC",
+		      *mtype_remote == MTYPE_NC ? "MTYPE_NC" : "MTYPE_UC");
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 64fb38400bd1a..c521ec07bf3c0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1348,8 +1348,12 @@ svm_range_get_pte_flags(struct kfd_node *node, struct amdgpu_vm *vm,
 		mtype_local = amdgpu_mtype_local == 0 ? AMDGPU_VM_MTYPE_RW :
 				amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
 				is_aid_a1 ? AMDGPU_VM_MTYPE_RW : AMDGPU_VM_MTYPE_NC;
-		/* Remote memory always uses MTYPE_UC on GFX 12.1. */
-		mtype_remote = AMDGPU_VM_MTYPE_UC;
+		/* Remote memory defaults to MTYPE_UC on GFX 12.1 and can be
+		 * overridden through the amdgpu_mtype_remote module parameter
+		 * (0 = MTYPE_NC, 1 = MTYPE_UC).
+		 */
+		mtype_remote = amdgpu_mtype_remote == 0 ? AMDGPU_VM_MTYPE_NC :
+				AMDGPU_VM_MTYPE_UC;
 		snoop = true;
 
 		if (is_local) /* local HBM  */ {
-- 
2.55.0

