Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A07EA3F0D
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 06:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23F9F10E1C5;
	Tue, 10 Feb 2026 06:34:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JLRHAKqv";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010054.outbound.protection.outlook.com [52.101.85.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7A7110E1C5
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 06:34:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxqfjKSRShQZLdO7esPqkjf2mNXnHcfZu+/hUer7inCUGRmuLYyfBBujpMQdoI2oO1wpqnxMSWVNJk5KY7/h89YstUQfjVcRYLZndeyECoyB4OxXDBnhifwNqD+yxyj15/bXXZgSX/OljNbp/qw+B4nd+nlLJWxXG4vQIOHR1FbgUIxndEdOB68+k48M2zean6b6Bor35luWuiG3T0aneUmSC73tbFbMDYUDWYJW8aNph5GJkpvc0XXH+Fl3ntbNwffhSVaka4oToFjo0oe6opFBMLQ3Gj0faAG0D+RDkRPz9HjVH2p5SuccNIi9oNBE/uYaOYeV07w6kjt2oAlT5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HioqD1YKY0g8hIKTAMVwevsoWM5OOeyxrmMWQvFm6sU=;
 b=Y9l/vKOisAi92Y0Cw5oxPf01h+h7jMPqLp8wYi+y8G1neWL3guNjJkl6rzZZpGrwvE69Cpp6fYVseIRjZ/G6KsSajK+ijKOXBQA3I4rJCBkX2IpY27LeXOj+5AwUowM7c0OfG7GoahFvJAZmuTj20qLklYEHxgI0vkZeuH9RuwLzNbDUDPl5DkWZ6Io5jYlWRLw60XdTt9u4gBLknlrzUHYBTJsfKhqCStH3d8bNm15Esf85oKv+PcbxZv+DTFWfIggW38uEqLncdI21B+rAOe8LnDOUuV5YvkNIyTHycaIO47NHfv/thbFWrBvUvczeh91LEIWAJOE4nQBJ0XPTAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HioqD1YKY0g8hIKTAMVwevsoWM5OOeyxrmMWQvFm6sU=;
 b=JLRHAKqvFzD1dkl9crO9bL6cPEmZ/nRJt1vdNTFYibKCttTMiL0EfeIsV09t9BCgswKsv0CcUXQhC6E1SYd9XM+e3ANZ8v5OyevVcGgMW0uE4h9MirePLIdbqkQQRRZ6mdl8xgASzdoAEaTrBcjKpYoPNQb03m7I1DwuWN5kP1s=
Received: from CH0PR07CA0016.namprd07.prod.outlook.com (2603:10b6:610:32::21)
 by SAWPR12MB999140.namprd12.prod.outlook.com (2603:10b6:806:4e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Tue, 10 Feb
 2026 06:34:49 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::c6) by CH0PR07CA0016.outlook.office365.com
 (2603:10b6:610:32::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Tue,
 10 Feb 2026 06:34:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 06:34:49 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 00:34:47 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Remove amdgpu_device_invalidate_hdp
Date: Tue, 10 Feb 2026 12:04:19 +0530
Message-ID: <20260210063419.4154560-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260210063419.4154560-1-lijo.lazar@amd.com>
References: <20260210063419.4154560-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|SAWPR12MB999140:EE_
X-MS-Office365-Filtering-Correlation-Id: 957592a8-0312-417e-9cc1-08de686e7db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6BT6pTYGQclVTrqyOS1gXEHVZU0OnKm3M7UP0F7ytBySROicj/wS+AXIRe68?=
 =?us-ascii?Q?BkqELM7Taoi7ZQsxjS3A2yf0UlI2AFRdmrg+R0PHNsQfpluuLFepaYZ/0z4u?=
 =?us-ascii?Q?wSLq0RVMpW4uS0XN22mK8/O2EHCQTxRwfyb4RqNYxmxaeq3knbtIFBBm7AWW?=
 =?us-ascii?Q?k5kqXgz9jKxSkIGnYXs38THbCIim3j8NU4P7R169Rb4v4seYAn4U3ABVpWsH?=
 =?us-ascii?Q?Up3JAyXyb0WSITkADqceDZXRL15eQQe+h/N+8tATDlFIb6/gVQ8n1UzDura2?=
 =?us-ascii?Q?EisNiuG0OFj9+qwcIHAi5vnWi7AoGl2v7ONGF2BVwwPUKsncov4JDzdcsQEh?=
 =?us-ascii?Q?FllrtTnD/1aVv6iW/97xmnbWy9IpNo9rlJgnfN2gQqkUeiANwsMqO2itGZqB?=
 =?us-ascii?Q?yYzXJTudAmnYI5gk+qobQbYls3fBpTDc/U+vliANOZ1KV0M1hjSNHVKuu0fe?=
 =?us-ascii?Q?eQt7knWzkZFV1DRIm7t2N/g2B7qcECW0JSkYfATcnNxYBeXKi5mQxJW3z80K?=
 =?us-ascii?Q?hLIAKll0CBlzyvMdXmt+r71aDf4/MOqUIYLy1qFlg8cx1f73zgvUJ+s/GoZ1?=
 =?us-ascii?Q?QSvJqUKU2KzWkm7M//PG2seVBYgWa5lo14X+YjN314mg08Duv9rGsVgHkhrs?=
 =?us-ascii?Q?3njcmx5sIvWgIH2YqyoFmRKQ0pXmDVMd8Ph2W6oaWD7DbMbh4OTSaPrZrmCc?=
 =?us-ascii?Q?Co4hcZWVGwLANG5iB17K+dF3vhPyA1tS8DeJj2XKGWO3+4E4K4fyrt7lF9RT?=
 =?us-ascii?Q?asb4sU6DFiGw9I5GAAAbOO2NpauGBfyP9naBeo/sKsGoz+eqaGytbbQ1dPOi?=
 =?us-ascii?Q?D2pdHenNJONit5qdw4dWQmQYS4WiO4dDG33XEzfVmju2hloChctEmYkf+oGv?=
 =?us-ascii?Q?0xPNyokBNvdpRYpPCuGMr/zPpQWic43QYlW2BMZ5UPW4wzli3QKfSI3RJz5b?=
 =?us-ascii?Q?lQ+I5h4pD1o8Ts3bWjABQ0dQ4kIknuhcellIBfXUBZodaYt1EdXk4zhQYFjE?=
 =?us-ascii?Q?92h5+0MDfSsSFKRTfrdxcJ6IbuO1sBfHYKcdLIxuTSnNcpySOm93ohNCTpAi?=
 =?us-ascii?Q?hQNElmpNI4pgLufv3j15Qee6sKcU1UrEUpEcMGiEfU/E+A7k3OQrdVCrohs1?=
 =?us-ascii?Q?h3TPliRsuzp7SR2SdM73KaE4/NyGjPMPuVCzrukl8IKnb3IKQsFSenZ0+oXG?=
 =?us-ascii?Q?NKMMXoH5SmNPFIQXFgSDzHyMP7uaBF2HQN8UO4TidUvfLR7i2AMbG8MTL2Yk?=
 =?us-ascii?Q?lF9z7V0vW7tm0i8mlNlt7qu41zDEsnnpS8JoksjNiGMUtvipg1h4fE0nA1NA?=
 =?us-ascii?Q?nio3fxPlDSbkztgGZeMCjZmXb4FqeSMk13Ay7Pc4MABuwN5CnwVKW9Sb2eRT?=
 =?us-ascii?Q?qXFcVD90AXk0JAYe3su5IMehjJqhPCy657ZLzJlt/aCds0ZvwLt5Z6mhJJHZ?=
 =?us-ascii?Q?LaFwxFDdPf/hXiOUJQNrCuBvt6k6JO3pY/uX+7/TOQmU1zzH3KhVyixQHLus?=
 =?us-ascii?Q?/RHu1yyUxwx4awyCMK9dtG3L1SfXb8fNKhkE5hhqsh98zEX2765PF37ym5XR?=
 =?us-ascii?Q?lMhs0TU44yMqfB83iDij7eC8L31FK46DbRLiAEK1s5GPBZ1lOpUnWXtONZ3c?=
 =?us-ascii?Q?M2eRCn4H8clekpr76OSsNxmo5XXriLEYRDt/hC8ukDBikppKG4pOUNiBoCe7?=
 =?us-ascii?Q?DNrUBg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0dYRL45Z/rBEFzta1YkxGRO7QJ9/t/RQyklJwNxKovQ4hR3+L8GLmYFG4SnQayFW6c3TXmFJgw2ATiKG60E08tS+d12oRb3HxyQwmO6RrtcVpoT2HietKxhTd6tkhraa0akSSe5jgLLPDNxPPYWhdITST9axDZhaVqhqq0EHRPSHI4G8a24v3C5iGLpT86sqndIqJUAtCucnBydplHy+ECXw5lwXoc8Ec0MGrHY/rlYH5CJXfLR5Vn2OyT7DfgvW5adXRPgmsWR59sL3aWJrL/GrBCzWZmG7bjK8uGpO5chGQXg0ecwa1keco5TFso83jx31em1UxlVb3oBfQZr5LVD3xFXfbYMZKZMSB0Q8Wi2IuaV2ugZXkZv+ehSS2sIEiSBr0MN3xjsXjJLqliefYB329VN2FCAM4ZRTdeM8njCyLx3oupjAwatI/sBNMMAg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 06:34:49.7583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 957592a8-0312-417e-9cc1-08de686e7db8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999140
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

Merge the logic into amdgpu_hdp_invalidate and use it as the public
interface.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c    |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  4 ++--
 5 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c1eded4bfa75..5a724e8e7199 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1527,9 +1527,6 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
 int amdgpu_device_baco_enter(struct amdgpu_device *adev);
 int amdgpu_device_baco_exit(struct amdgpu_device *adev);
 
-void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
-		struct amdgpu_ring *ring);
-
 void amdgpu_device_halt(struct amdgpu_device *adev);
 u32 amdgpu_device_pcie_port_rreg(struct amdgpu_device *adev,
 				u32 reg);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 212eadb90c6c..b4962fb8d2a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -773,7 +773,7 @@ size_t amdgpu_device_aper_access(struct amdgpu_device *adev, loff_t pos,
 			mb();
 			amdgpu_hdp_flush(adev, NULL);
 		} else {
-			amdgpu_device_invalidate_hdp(adev, NULL);
+			amdgpu_hdp_invalidate(adev, NULL);
 			/* Make sure HDP read cache is invalidated before issuing a read
 			 * to the PCIe device
 			 */
@@ -7288,19 +7288,6 @@ bool amdgpu_device_load_pci_state(struct pci_dev *pdev)
 	return true;
 }
 
-void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
-		struct amdgpu_ring *ring)
-{
-#ifdef CONFIG_X86_64
-	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev))
-		return;
-#endif
-	if (adev->gmc.xgmi.connected_to_cpu)
-		return;
-
-	amdgpu_hdp_invalidate(adev, ring);
-}
-
 int amdgpu_in_reset(struct amdgpu_device *adev)
 {
 	return atomic_read(&adev->reset_domain->in_gpu_reset);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
index c085031a6f09..c2fdd1d5cd47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
@@ -69,6 +69,13 @@ void amdgpu_hdp_generic_flush(struct amdgpu_device *adev,
 
 void amdgpu_hdp_invalidate(struct amdgpu_device *adev, struct amdgpu_ring *ring)
 {
+#ifdef CONFIG_X86_64
+	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev))
+		return;
+#endif
+	if (adev->gmc.xgmi.connected_to_cpu)
+		return;
+
 	if (adev->asic_funcs && adev->asic_funcs->invalidate_hdp)
 		adev->asic_funcs->invalidate_hdp(adev, ring);
 	else if (adev->hdp.funcs && adev->hdp.funcs->invalidate_hdp)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index f4885a140967..57edf3477621 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -280,7 +280,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	if (job && ring->funcs->emit_frame_cntl)
 		amdgpu_ring_emit_frame_cntl(ring, false, secure);
 
-	amdgpu_device_invalidate_hdp(adev, ring);
+	amdgpu_hdp_invalidate(adev, ring);
 
 	if (ib->flags & AMDGPU_IB_FLAG_TC_WB_NOT_INVALIDATE)
 		fence_flags |= AMDGPU_FENCE_FLAG_TC_WB_ONLY;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 57a8ac2c69db..43fdffb729d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -723,7 +723,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
 		goto exit;
 	}
 
-	amdgpu_device_invalidate_hdp(psp->adev, NULL);
+	amdgpu_hdp_invalidate(psp->adev, NULL);
 	while (*((unsigned int *)psp->fence_buf) != index) {
 		if (--timeout == 0)
 			break;
@@ -736,7 +736,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
 		if (ras_intr)
 			break;
 		usleep_range(10, 100);
-		amdgpu_device_invalidate_hdp(psp->adev, NULL);
+		amdgpu_hdp_invalidate(psp->adev, NULL);
 	}
 
 	/* We allow TEE_ERROR_NOT_SUPPORTED for VMR command and PSP_ERR_UNKNOWN_COMMAND in SRIOV */
-- 
2.49.0

