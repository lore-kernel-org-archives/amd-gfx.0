Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9594CA6002
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 22:15:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1EC710E6AE;
	Wed,  7 Oct 2026 22:15:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W/sN1//h";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011062.outbound.protection.outlook.com
 [40.93.194.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AF2A10E6AE
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 22:15:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3AIgLJDWTn0LyFBs5KyZPgIEY7/wGyzq34Hwn0J4+dcZ+Cq/Dvoek4VTDQq9DPwINzxeVa+5OxdwFmfSc0q6U3pqbytZUqSwOGaoPmikmtXnGsHt2+aMpdYRdKkSo87tTiN3p2e2MFteYvH4csANqG6+3QSaBE4NtEMSVIXVjk5E0Ar2R9rRQ6N3OQSOL/rDqg23mNcb0TDcfu7xFyvWu8OMhCPo3USOeuK/V9JL5SGN8sab3vdW0fOmyvf2kYgs/KCmAS1WSKT11Ob5FD2iZ5IXuw0fxWv8BqKJYTTqpW86fmM5ZmwunU1yTComMG06M74OBnyaH6xOI4s5/PhQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sjesd5KYzl46oKeOKP9HCQSlnvh6FPtu4meDO0KWGMQ=;
 b=prfkMn57rWVDGQRcgo6YCRJJ2ZTUUa3nHMCnYOKkdstX+puINRVMXmhaGX0j6ixdTkvUmT9hBnOtpVReaLiSK2RTywFl2HTVxZ1MLbJaqYkKS1bws7lQ9Lrquwx9YTueKR7L4JEhd4rwdqfTc0KftbUC2vvbLj6uJt8Q1k1wUrTZlRVGQm38D+UVRMMkX6MQWx/HUAJAsWpJMmfr+N98hcguIh/V9vDM1a1DlwziJ5xpEkey5RfoHwKpyJ92wauUB1hSj9U3tXIIxn0SJPFUsEEH5+KysgWLPt7+y6M6/jw7r7Mh0v0jfc0M5PFc6YiIZutiY7AmHOp6EgyQG+eR5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sjesd5KYzl46oKeOKP9HCQSlnvh6FPtu4meDO0KWGMQ=;
 b=W/sN1//h5JZsGtAE07Hh7tV65ryv5TuctTDgIjpXNxOghCXAHEEEZzWbMlIiZedzC+L2hBgVpqOFPY3x5+yQAHZu/L7qLmTdaWyuYvJYWhkbCMCHG2v5EnPB2XRBFx64TfsAc/Lomn/WDW9N5oEldVz0mM5tNBycTveKM52Y+AQ=
Received: from DS1P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:455::16) by
 DS0PR12MB8456.namprd12.prod.outlook.com (2603:10b6:8:161::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.18; Wed, 7 Oct 2026 22:15:45 +0000
Received: from CY7PEPF000000F0.namprd05.prod.outlook.com
 (2603:10b6:8:455:cafe::7a) by DS1P220CA0010.outlook.office365.com
 (2603:10b6:8:455::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 22:15:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000F0.mail.protection.outlook.com (10.167.247.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 22:15:44 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 17:15:42 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: move amdgpu_vm_bo_update() call into correct
 location
Date: Wed, 7 Oct 2026 18:15:29 -0400
Message-ID: <20261007221530.389925-2-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007221530.389925-1-shahyan.soltani@amd.com>
References: <20261007221530.389925-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F0:EE_|DS0PR12MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e11340e-3baf-452a-fb0c-08df24c08868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TkwX+OS2pKD+dTqZQedKeLY34tvyaS+95hcwlrmuiMOhr9DKkn99i7Duc7RiyWkqarkrtY/tx28zOJ+UR1mJD8F+QR2Y2E89RhFmD53BLuln700kQV1N34mF991c68kmaw7GzHzpj6FsuTlYck4iRo1KHyktSad8UKjFzsrmGL42zXv5p3P1shvr66rFsjP1zHdtZa4Ht847+bjJiYHukm5rMiFETKyXE+XeXHidWMMhSiLPVjdCGD4S2lS3DS7me1VOEM2teZUsHK9mVZyA94nqCIEGh7e9bWOsQ370t33QvSt8Da1Il91mZSLEymh1r6xuVd3L0n1W/cTychLK8sZVQmrkoRtdkdRIIIhXvUbx8cd3uyz7zRHAyl74dYkmcNLOksOmJjTQcqQ7qGa9ktgsfQk2PCj7p8zu1JNA3zJT2l90oQh0Ku7iVjGlyENfbNS9G2tpB1SabvahuiHzAh2usGDtRAo4wk5OUGluCvDYp1dDfejnfPLeb/ad6amN5rj3Mb1qdcB4fIyJcf9hle5AZpz3/OoqTSRYAWMAb8cZPIx4N857ADpm8YOGAucWzGnmFbsYmgxddPHS0KGokRQvltOZFctJCCM4qm9NMzwx4HeRiaYloAEC+YiKfcZIlrGjGzM8GD1vF94QjRtcg6SAMuWxQYNHsck+/Iyw/fS98tHraWvq9vmxLt2Yl2lY6GEjVCyyIcHDYMQyKJBmMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HYS7TEUq4BkC5qfa87smN5SXlEDQOu9fUxQnBo1Kxkng/Y0wUe7QM4RMaApfmnZRE1c52/ngkb44p9GvQ0R9E8fqRbwPG3tB91AJZSA9dLpK1SCqDiL0XgK05ALLuQRlAZ4ah5XgbrgWoTFn3M499EVJkIvmtKL1j3Xw/e1yT9HsUUJJSIofrUgSxW0IRgFUvZj/GduywSrVO3A/dknk3fMRaZzWELMtG3MhsjCyK47N0jT/0Mm1MS0igj2AyA7iicRpo4IIjStTClb7E/T3UR6k/mBwHldDxOeFA3b7U5I8ysl8wwy2uufuPN06mFjxcnoZKAPz5SPTLg/g4ZDnmjIrqhMf27lOy60RqkUtRQxCzUpFOQtyyLEj5Ghg9GGs5nKgJ11S8LQXpGg7fNcI4iMUPq+CtXHwkHFJfmETKZ4IeAdNvsTDoxBtyb34o1h6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 22:15:44.9915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e11340e-3baf-452a-fb0c-08df24c08868
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8456
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

Calling amdgpu_vm_bo_update() this early is unnecessary. moving it to
amdgpu_cs_vm_handling is the correct location for this function and is
required to allow the VM to initialize without waking up sleep.

Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c    | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c |  7 -------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index d059e0c92866..2d01a831d534 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1159,6 +1159,20 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 			return r;
 	}
 
+	if (fpriv->seq64_va) {
+		bo_va = fpriv->seq64_va;
+		r = amdgpu_vm_bo_update(adev, bo_va, false);
+		if (r) {
+			DRM_ERROR("failed to do vm_bo_update on userq sem\n");
+			return r;
+		}
+
+		r = amdgpu_sync_fence(&p->sync, bo_va->last_pt_update,
+				      GFP_KERNEL);
+		if (r)
+			return r;
+	}
+
 	/* FIXME: In theory this loop shouldn't be needed any more when
 	 * amdgpu_vm_handle_moved handles all moved BOs that are reserved
 	 * with p->ticket. But removing it caused test regressions, so I'm
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
index 21a225b0116a..fbf9ec7d467b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
@@ -103,13 +103,6 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		goto error;
 	}
 
-	r = amdgpu_vm_bo_update(adev, *bo_va, false);
-	if (r) {
-		DRM_ERROR("failed to do vm_bo_update on userq sem\n");
-		amdgpu_vm_bo_del(adev, *bo_va);
-		goto error;
-	}
-
 error:
 	drm_exec_fini(&exec);
 	return r;
-- 
2.55.0

