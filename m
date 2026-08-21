Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46847C5DF8E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:51:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F3A10E34E;
	Fri, 21 Aug 2026 19:51:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V8+Tg713";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011023.outbound.protection.outlook.com
 [40.93.194.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4203810E34E
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:51:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fl207yTzhyUksFngacz2TVpElK+JPWrQEhxXX4UqA1ebLBaOSVuflKsM5E/5BzxA89Y39oMyw6nuLaRpEjySXQpNXcmBNEF0E4ZkReP1llZgrtgo/qeLh3JADm3K6GIKOOH3scNn1Dw8mCRa4JYXQ8MU9Ei7Ne9juOb/lMJaRxxF98WIkeCfBjy/BOVZORgyUuiBox96TCLxT2VGzMUDhEparaFwUpXeCvvKvyokxxv24L0wzxrc9YNwWI6CXU0KScty+STxNB8qALcpjgKt8nwqV/xKNuLrjtPxjA2IR3gnmtS74m7Xf1Tb8MlEsSnGSQ1341nYdwH/Yz/PMDjA0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6NGOdhJ9aKnwtnDt5Tb+uZlGGr34teKqK204DBNxCs=;
 b=Gj37ipIeY2QG3rjYsYc+lblLCCB+iVDQmGgYkwTK0h1nwJbHrDxNs323C9PrqVPBYkbZlCE8gEp2Wmi6NkswZvmp8TtJG6I3KCKmJj3NVo941J5PIPX6klHVmm9jAgl8ke+YIsRJ4pIIJ1ls4coaOpzz9GRiz1/C0k7kAzsNFCSZEhlbyNVg25qkNN2nCsOXZ0VnEXrQEUWObtXu/r2nWkwZngt4V3z3h2Yo/iSBichBVNkOL85XwEkcx6ldzSGlKvBPZhGh+xNtgM0jUcx1/656aFu60Vx9mocf2RTfwj5Nh77vtzYDe2RWTyVK7Qn0W8I1yWSha/Idqfproq0S4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6NGOdhJ9aKnwtnDt5Tb+uZlGGr34teKqK204DBNxCs=;
 b=V8+Tg713FW1Unn9mgHc62dp7dveXYJEJlMdpCNgjRsdp4qXh6jZsT4O6CHxKFuEUbea3ccUSxbZq3fpFVTBDYQc/7x13nk6KPkwwbL9V/GGDAVfy1fO9V7kNaL/h0Hf+JH3oyckqq4/PwaN5sDB9kJuAEToRpcbUX/smiRdR5rQ=
Received: from CH2PR10CA0022.namprd10.prod.outlook.com (2603:10b6:610:4c::32)
 by CH3PR12MB7619.namprd12.prod.outlook.com (2603:10b6:610:14b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:35:33 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::95) by CH2PR10CA0022.outlook.office365.com
 (2603:10b6:610:4c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Fri,
 21 Aug 2026 19:35:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:28 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:28 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 28/95] drm/amdgpu: Use reserved VMID for NPA VM
Date: Fri, 21 Aug 2026 15:33:51 -0400
Message-ID: <20260821193458.808626-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|CH3PR12MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: 0008d394-3d77-4d7b-031b-08deffbb5dd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UYsYGqgw9BuwjxsKZINzLUDiNMV4vkD8dX28jYLCxMwoBb4wrpDW4GVZH9uMqYBWUM7Mqmj0A4OVpbaYgwYDrwwaisn7dN7BlJoaV7i6mTNv9fwtEBpudZ3OPxSPfOVxOUshwdIZq0RpDND6QDBsjUQqjo1q7Ha5u+VuPgtuFB/wR8q9Q8t9PJXR4xNNNHUDJvVPDS+RwUqbEq/cybmy2tbMCc/pzOm6LlL0UMrjXgmp8p+kHnQRwSTv9/XIJ0w/ZCkOZSqUv4todi4ry4axqTDzufJ3Gphayja1Uld3kOWNabCBq/CGn9m/2npkHJKphP3Ot510jHz98lAgQQ04oD8BbYCcS+1K+f+QDQtHAPMd6OiVbqxqqCjd7ROnUlowjfUN2JPSiB0n6pxw11sbvc6XwKRaJYuzPLhz5R4JcICJi1AZRiFcs1j22H36wlbb400Tkq2Az9fXAg3kgZLJinaXRjM2XeihN1XNfnhI3aMI6IPFa15V82ahE7wfeEvC6fOqpXCePuNtPa8M9ibRiYL5cH3gNgzeMYgyXxN7NQZEx/nzr+z9s+fxu2xkwmIYTNkT/ImJ/X4xHhzAnCd5kNu32LYAMRCE/A5yJ1Pz3SavPgQidgDrmXqCE0PZkbRQniDn3JmCbscHFWQsIepf1UyS2alqeQk7AMJV2P3lk810fL+nke10Ql1xV4fO7VIPUeTn81ZVsL3zLPD22RdG9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: orpkWWh2PFu/e8xrVWNl0DBKr4Ht8VRbHPPQ1fH1bpX3SKtd9W/RR6f65Rf3q0JxnIadf+hLqLUwHyioi8+u0DW6+yUS6HlXszyj0OO+FfdOH/qKJJiGN/ikKJtnhNfgsbIDCEydSfE6Pee3hmhfZpPmY8NTUViX/MafAjbtVhFi/SRnn2+OkZWfBWx4NY4Yq++TQTusKyFqkwoSrxHDFfTfzR1spcq5iN/r/Fi4Uu+goEiv591WmrS4GLCPUA7pPZyxZXkY3T5su0bOXldKpH6BWMaw+evWqIun2vJKS+0WgmwlE8gqitYMgYeV6caoPDcoaR+tzynOhwGLHKm8ogWQ0dHq1N1+jUNRR5Hga4m971BRdPxXAetPIIGrGKs0nQEYSjcyVgsSACAvwu6sHW6ADxKXPKp0RlRNKqX9MSFlBG6ndFKZosiICkknCIoc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:33.0827 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0008d394-3d77-4d7b-031b-08deffbb5dd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7619
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

Map NPA VM to use the reserved VMID.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index db9dce8fa8708..e1e1757050152 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -653,9 +653,9 @@ static void activate_accelerator(struct amdgpu_device *adev)
 	if (adev->ualink.info->accel_state >= AMDGPU_UALINK_ACCEL_STATE_READY)
 		return;
 
-	/* Enable incoming NPA address translation with VMID15 */
+	/* Enable incoming NPA address translation with NPA VMID */
 	r = psp_ual_set_npa_config(&adev->psp, adev->ualink.psp_if_ver,
-				   15, true);
+				   adev->vm_manager.npa_vmid, true);
 	if (!r)
 		adev->ualink.info->accel_state = AMDGPU_UALINK_ACCEL_STATE_READY;
 }
@@ -665,9 +665,9 @@ static void deactivate_accelerator(struct amdgpu_device *adev)
 	if (adev->ualink.info->accel_state < AMDGPU_UALINK_ACCEL_STATE_READY)
 		return;
 
-	/* Disable incoming NPA address translation with VMID15 */
+	/* Disable incoming NPA address translation with NPA VMID */
 	psp_ual_set_npa_config(&adev->psp, adev->ualink.psp_if_ver,
-			       15, false);
+			       adev->vm_manager.npa_vmid, false);
 	/* ignore return value */
 	adev->ualink.info->accel_state = AMDGPU_UALINK_ACCEL_STATE_CONFIGURED;
 }
@@ -1127,6 +1127,10 @@ int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
 		goto uninit_vm;
 	}
 
+	/* Map this VM to NPA VMID */
+	adev->mmhub.funcs->setup_vm_pt_regs(adev, adev->vm_manager.npa_vmid,
+			amdgpu_gmc_pd_addr(adev->ualink.npa_vm.root.bo));
+
 	xa_init_flags(&adev->ualink.exp_xa, XA_FLAGS_LOCK_BH);
 	xa_init_flags(&adev->ualink.imp_xa, XA_FLAGS_LOCK_BH);
 	xa_init_flags(&adev->ualink.handle_invalid_xa, XA_FLAGS_LOCK_BH);
@@ -1153,6 +1157,7 @@ void amdgpu_ualink_manager_stop(struct amdgpu_device *adev)
 {
 	int i;
 
+	adev->mmhub.funcs->setup_vm_pt_regs(adev, adev->vm_manager.npa_vmid, 0);
 	amdgpu_ualink_npa_mm_fini(adev);
 
 	xa_destroy(&adev->ualink.exp_xa);
-- 
2.55.0

