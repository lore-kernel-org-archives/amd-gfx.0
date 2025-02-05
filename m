Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7FEC02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 17:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBA9A10E07E;
	Wed,  5 Feb 2025 17:29:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KbyGRldN";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4325D10E3A9
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 17:26:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kA/9Buu2iMTCbPAf3thrFFlMbAt0KGvupi04zPBByHlOux/CeE81hbASHnf5lX4OcOW0Gc2Y2p2eCXzmDlK9fKdZtftwGaRintK7s40WGdrFNXRVbAxGPIDy23mK1wpKTAmnK4sCXo7A8az5MxIz1PyvLGUg5yTqzYZ+ddjZg5VhKxLrK+eauj7UDkkqt51OuNHoil7CwzPKJxdpnB4rK1oPBLWHYdlq3TGmLRJ8r0YiNcDjmnIXM5k4SRyjBrXG8+Cu45bDUXq2sxRg0O4F6zneGMJzAADlbfSwIuIfVHNeE5/6lgNxvAERFQYseav9bO6+wiFG//+uvIOVYEa1uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYnFpYJcM3Cdd9BdYjI32fTt2I209s2jd/R5N5CyxeI=;
 b=CqyuexCI5MTqnfNq8i5hNZWrz4X1FUw2QQZS+imvyZgW8l50YDcjHY1CjBBgmy3xvFW9yHF+dRmsvFWQAHoaXjLFYLMvpFF8WhB66xHNYtAxvqu8k6evaUzV9k0hWFCBOmkv4zRNflWo6YPnzR5I6zuXleLrllzE4GAN7BjZWYrE41K7Pmn8aX9u4BhyqYKm9iAb8uPA6WAMUJXLu251ESAOAYCabADM+h6R/eZAhTvA5ehly6Doij/JgEpD1wPyzC2Ujp80hr6JlLfxk5gEhTEYegU5+XHfzou5s7bDtVjM0H9dNxOFOBaRdH0nJxQBCLyCnff5woU35+8mlz9lBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYnFpYJcM3Cdd9BdYjI32fTt2I209s2jd/R5N5CyxeI=;
 b=KbyGRldNU+IFUuPhMNAadvNK8sL3rEWRrF8Bf7e+16Uqudr+je2rANHgIJD3+i3GjHpV4YHirjmZUJN9fREmBAB4nhgimKM8eA5yQI6iUOCZFl36SFQm8Y95ybbkE64u1OjAKWUYT3altRT/Gnp6uhLsRGCmgqK+v5JmlzapwQU=
Received: from SA9PR13CA0124.namprd13.prod.outlook.com (2603:10b6:806:27::9)
 by DM6PR12MB4139.namprd12.prod.outlook.com (2603:10b6:5:214::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 17:26:44 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:27:cafe::a7) by SA9PR13CA0124.outlook.office365.com
 (2603:10b6:806:27::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 17:26:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 17:26:43 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Feb 2025 11:26:42 -0600
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amdgpu: Set snoop bit for SDMA for MI series
Date: Wed, 5 Feb 2025 12:26:29 -0500
Message-ID: <20250205172629.173528-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|DM6PR12MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: 781778cf-b839-4fd3-13f9-08dd460a42a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6iIfp6kOZ7KpVpQjQBOXCBDnnyDkf0VeVLv7HavlMUaCOKMEeDPtCgZX3faX?=
 =?us-ascii?Q?95HCwMBvUeCkaFKitM27PPygXQkJlNvbdi3im7F/TQprQWMNndogdD+h/0Yw?=
 =?us-ascii?Q?OWOjrAHIIZJe93wFGZzYjvCihjG1JxmAAi8SBnRiEW5CG2SVIqj+8VwVcL6m?=
 =?us-ascii?Q?Jc7kCGZjlXz5EKVTmgCWZUt8awlbKlYryZSA6fSg0rVTNnDGP9yYdMR8JDds?=
 =?us-ascii?Q?awjno8KmmbQI/UiCWsbwu4ieK+FBpCYOSDwgZSeqwL0bs3fu3FCMsvRLnKN3?=
 =?us-ascii?Q?SFeZOIVrtcgtMAPN9VJmuNRsgrUUwyNdta3qWZ0Pr4z5N6Yc229Kmk4ZAjt/?=
 =?us-ascii?Q?Vp3hD22ZLqta+BAg5IskNLQSVMjiGMODU0nfmlbGBJK/T8OczvkMSSrBHOUc?=
 =?us-ascii?Q?WmeXdf42gU9z4OjEtuqnGQZ/8d0z8BbR6VWbnM3lbgOqlc+rjttq6a2XBQlA?=
 =?us-ascii?Q?jeLH2LA76ReqHwR6/Ntev3oAgKRFym4+3IHFD8+bCTV9XXsJNfNxPHLBAhr7?=
 =?us-ascii?Q?tSKg+jBAd9EeZVgXnrOaWZQlgr50DnT43nkVFhyp0rmzJbrkF0Cs7Uf9G+Lq?=
 =?us-ascii?Q?e0CFSXkPxghnQE1pWQSHDcM6VQfwaa/q/JVMzt0Eqms+PwJyG8nBrBxxaG/i?=
 =?us-ascii?Q?1kOf2j/vPtrQ31AcQ10ZJU147ma8iLVfTREUvoFVbl1xE7jqVMflf7MCBhqU?=
 =?us-ascii?Q?R1FHzMe7obXFzAFggHHjY9oHkaP/5VQTv5yOdz+GyOnAbXJLfrj6umaxSLlE?=
 =?us-ascii?Q?oDsMHSL7Ej/KDUh7uy9IW8YUOY+BEAckhtLP8KeVnojtT4iGFn/Tu10qRmuk?=
 =?us-ascii?Q?R/cw8dqd8fcYSwZwDWJaxY2/AYa8UHpfHRQ/tWlNiN41bHe7StuSFPz5VxXR?=
 =?us-ascii?Q?5Z11UjFVjp3pyNETCxe3/khKiLrvg0G5XMiCRRP21ZBn+nvGm7lzzFhY0WRQ?=
 =?us-ascii?Q?/fuE3mB1yIgaMjZOrDHw4SkaVbf0k+NR0APkZ+j+3z6SE9//DiN9o9pX3jte?=
 =?us-ascii?Q?2yJSWsSqaE1kyAjHu5sEINtx5ROLf8hTPfN4Cq+oK15bjkmSlMrVH4KYPX4p?=
 =?us-ascii?Q?JSBuS9fql62jT7SwsZI9NJlQirXvNgy4iWnqNFyphpMJ0rD5ZtMVvtynoubA?=
 =?us-ascii?Q?bPKdzTn6gJ9WtgtxxwZEkZIuv7bet6L7rq315s9q3XBgdy/SS6TKrwwwCeyR?=
 =?us-ascii?Q?ocupcXrFft/1FDfIDJ454K1N4w30+YtL1yG9+aCfIomg8nR5Hn6tiGmBp2na?=
 =?us-ascii?Q?Ns0FCaaNdv5RlLltn640suEvixAekyzJtNZTKO3U4qLwUjfmm2wGdOjjJ0y7?=
 =?us-ascii?Q?AMcoHlC37iisKbVDMJLxRFi3ZGW3S0icPWEe1El6mNBQnJGdwKmJ8+Pr57AN?=
 =?us-ascii?Q?prKcYMNF+EflwoTBdIl2GP4p0QKsRm5G+f8udiNt15eWVIK2M8omXHAmiGju?=
 =?us-ascii?Q?2vuY4z3Gd54/IM1KYPJpvKuqXAX4mwv55pGNgwM1mB2UWTGy4asSUg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 17:26:43.7429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 781778cf-b839-4fd3-13f9-08dd460a42a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139
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

SDMA writes has to probe invalidate RW lines. Set snoop bit in mmhub for
this to happen.

v2: Missed a few mmhub_v9_4. Added now.

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c       | 25 ++++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c       | 27 +++++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c       | 30 ++++++++++++
 .../asic_reg/mmhub/mmhub_9_4_1_offset.h       | 32 +++++++++++++
 .../asic_reg/mmhub/mmhub_9_4_1_sh_mask.h      | 48 +++++++++++++++++++
 5 files changed, 162 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 9689e2b5d4e5..57602c456c10 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -172,6 +172,30 @@ static void mmhub_v1_7_init_tlb_regs(struct amdgpu_device *adev)
 	WREG32_SOC15(MMHUB, 0, regMC_VM_MX_L1_TLB_CNTL, tmp);
 }
 
+/* Set snoop bit for SDMA so that SDMA writes probe-invalidates RW lines */
+static void mmhub_v1_7_set_snoop(struct amdgpu_device *adev)
+{
+	uint32_t tmp;
+	int j;
+	uint32_t distance = regDAGB1_WRCLI_GPU_SNOOP_OVERRIDE -
+			    regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE;
+
+	for (j = 0; j < 5; j++) { /* DAGB instances */
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0,
+			regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE, j * distance);
+		tmp |= (1 << 15); /* SDMA client is BIT15 */
+		WREG32_SOC15_OFFSET(MMHUB, 0,
+			regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE, j * distance, tmp);
+
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0,
+			regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE, j * distance);
+		tmp |= (1 << 15);
+		WREG32_SOC15_OFFSET(MMHUB, 0,
+			regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE, j * distance, tmp);
+	}
+
+}
+
 static void mmhub_v1_7_init_cache_regs(struct amdgpu_device *adev)
 {
 	uint32_t tmp;
@@ -337,6 +361,7 @@ static int mmhub_v1_7_gart_enable(struct amdgpu_device *adev)
 	mmhub_v1_7_init_system_aperture_regs(adev);
 	mmhub_v1_7_init_tlb_regs(adev);
 	mmhub_v1_7_init_cache_regs(adev);
+	mmhub_v1_7_set_snoop(adev);
 
 	mmhub_v1_7_enable_system_domain(adev);
 	mmhub_v1_7_disable_identity_aperture(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index e646e5cef0a2..4ae73f768eb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -213,6 +213,32 @@ static void mmhub_v1_8_init_tlb_regs(struct amdgpu_device *adev)
 	}
 }
 
+/* Set snoop bit for SDMA so that SDMA writes probe-invalidates RW lines */
+static void mmhub_v1_8_set_snoop(struct amdgpu_device *adev)
+{
+	uint32_t tmp, inst_mask;
+	int i, j;
+	uint32_t distance = regDAGB1_WRCLI_GPU_SNOOP_OVERRIDE -
+			    regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE;
+
+	inst_mask = adev->aid_mask;
+	for_each_inst(i, inst_mask) {
+		for (j = 0; j < 5; j++) { /* DAGB instances */
+			tmp = RREG32_SOC15_OFFSET(MMHUB, i,
+				regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE, j * distance);
+			tmp |= (1 << 15); /* SDMA client is BIT15 */
+			WREG32_SOC15_OFFSET(MMHUB, i,
+				regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE, j * distance, tmp);
+
+			tmp = RREG32_SOC15_OFFSET(MMHUB, i,
+				regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE, j * distance);
+			tmp |= (1 << 15);
+			WREG32_SOC15_OFFSET(MMHUB, i,
+				regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE, j * distance, tmp);
+		}
+	}
+}
+
 static void mmhub_v1_8_init_cache_regs(struct amdgpu_device *adev)
 {
 	uint32_t tmp, inst_mask;
@@ -418,6 +444,7 @@ static int mmhub_v1_8_gart_enable(struct amdgpu_device *adev)
 	mmhub_v1_8_init_system_aperture_regs(adev);
 	mmhub_v1_8_init_tlb_regs(adev);
 	mmhub_v1_8_init_cache_regs(adev);
+	mmhub_v1_8_set_snoop(adev);
 
 	mmhub_v1_8_enable_system_domain(adev);
 	mmhub_v1_8_disable_identity_aperture(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index ff1b58e44689..fbc52ac7ad89 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -198,6 +198,35 @@ static void mmhub_v9_4_init_tlb_regs(struct amdgpu_device *adev, int hubid)
 			    hubid * MMHUB_INSTANCE_REGISTER_OFFSET, tmp);
 }
 
+/* Set snoop bit for SDMA so that SDMA writes probe-invalidates RW lines */
+static void mmhub_v9_4_set_snoop(struct amdgpu_device *adev, int hubid)
+{
+	uint32_t tmp;
+	int j;
+	uint32_t distance = mmDAGB1_WRCLI_GPU_SNOOP_OVERRIDE -
+			    mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE;
+
+	for (j = 0; j < 5 - (2 * hubid); j++) {
+		/* DAGB instances 0 to 4 are in hub0 and 5 to 7 are in hub1 */
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0,
+			mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE,
+			hubid * MMHUB_INSTANCE_REGISTER_OFFSET + j * distance);
+		tmp |= (1 << 15); /* SDMA client is BIT15 */
+		WREG32_SOC15_OFFSET(MMHUB, 0,
+			mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE,
+			hubid * MMHUB_INSTANCE_REGISTER_OFFSET + j * distance, tmp);
+
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0,
+			mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE,
+			hubid * MMHUB_INSTANCE_REGISTER_OFFSET + j * distance);
+		tmp |= (1 << 15);
+		WREG32_SOC15_OFFSET(MMHUB, 0,
+			mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE,
+			hubid * MMHUB_INSTANCE_REGISTER_OFFSET + j * distance, tmp);
+	}
+
+}
+
 static void mmhub_v9_4_init_cache_regs(struct amdgpu_device *adev, int hubid)
 {
 	uint32_t tmp;
@@ -392,6 +421,7 @@ static int mmhub_v9_4_gart_enable(struct amdgpu_device *adev)
 		if (!amdgpu_sriov_vf(adev))
 			mmhub_v9_4_init_cache_regs(adev, i);
 
+		mmhub_v9_4_set_snoop(adev, i);
 		mmhub_v9_4_enable_system_domain(adev, i);
 		if (!amdgpu_sriov_vf(adev))
 			mmhub_v9_4_disable_identity_aperture(adev, i);
diff --git a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h
index c488d4a50cf4..b2252deabc17 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h
@@ -203,6 +203,10 @@
 #define mmDAGB0_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB0_WR_MISC_CREDIT                                                                         0x0058
 #define mmDAGB0_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x005b
+#define mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x005c
+#define mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB0_WRCLI_ASK_PENDING                                                                      0x005d
 #define mmDAGB0_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB0_WRCLI_GO_PENDING                                                                       0x005e
@@ -455,6 +459,10 @@
 #define mmDAGB1_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB1_WR_MISC_CREDIT                                                                         0x00d8
 #define mmDAGB1_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB1_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x00db
+#define mmDAGB1_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB1_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x00dc
+#define mmDAGB1_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB1_WRCLI_ASK_PENDING                                                                      0x00dd
 #define mmDAGB1_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB1_WRCLI_GO_PENDING                                                                       0x00de
@@ -707,6 +715,10 @@
 #define mmDAGB2_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB2_WR_MISC_CREDIT                                                                         0x0158
 #define mmDAGB2_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB2_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x015b
+#define mmDAGB2_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB2_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x015c
+#define mmDAGB2_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB2_WRCLI_ASK_PENDING                                                                      0x015d
 #define mmDAGB2_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB2_WRCLI_GO_PENDING                                                                       0x015e
@@ -959,6 +971,10 @@
 #define mmDAGB3_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB3_WR_MISC_CREDIT                                                                         0x01d8
 #define mmDAGB3_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB3_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x01db
+#define mmDAGB3_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB3_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x01dc
+#define mmDAGB3_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB3_WRCLI_ASK_PENDING                                                                      0x01dd
 #define mmDAGB3_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB3_WRCLI_GO_PENDING                                                                       0x01de
@@ -1211,6 +1227,10 @@
 #define mmDAGB4_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB4_WR_MISC_CREDIT                                                                         0x0258
 #define mmDAGB4_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB4_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x025b
+#define mmDAGB4_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB4_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x025c
+#define mmDAGB4_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB4_WRCLI_ASK_PENDING                                                                      0x025d
 #define mmDAGB4_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB4_WRCLI_GO_PENDING                                                                       0x025e
@@ -4793,6 +4813,10 @@
 #define mmDAGB5_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB5_WR_MISC_CREDIT                                                                         0x3058
 #define mmDAGB5_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB5_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x305b
+#define mmDAGB5_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB5_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x305c
+#define mmDAGB5_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB5_WRCLI_ASK_PENDING                                                                      0x305d
 #define mmDAGB5_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB5_WRCLI_GO_PENDING                                                                       0x305e
@@ -5045,6 +5069,10 @@
 #define mmDAGB6_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB6_WR_MISC_CREDIT                                                                         0x30d8
 #define mmDAGB6_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB6_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x30db
+#define mmDAGB6_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB6_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x30dc
+#define mmDAGB6_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB6_WRCLI_ASK_PENDING                                                                      0x30dd
 #define mmDAGB6_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB6_WRCLI_GO_PENDING                                                                       0x30de
@@ -5297,6 +5325,10 @@
 #define mmDAGB7_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB7_WR_MISC_CREDIT                                                                         0x3158
 #define mmDAGB7_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB7_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x315b
+#define mmDAGB7_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB7_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x315c
+#define mmDAGB7_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB7_WRCLI_ASK_PENDING                                                                      0x315d
 #define mmDAGB7_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB7_WRCLI_GO_PENDING                                                                       0x315e
diff --git a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h
index 2969fbf282b7..5069d2fd467f 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h
@@ -1532,6 +1532,12 @@
 //DAGB0_WRCLI_DBUS_GO_PENDING
 #define DAGB0_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB0_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB0_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB0_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB0_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB0_DAGB_DLY
 #define DAGB0_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB0_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -3207,6 +3213,12 @@
 //DAGB1_WRCLI_DBUS_GO_PENDING
 #define DAGB1_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB1_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB1_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB1_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB1_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB1_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB1_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB1_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB1_DAGB_DLY
 #define DAGB1_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB1_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -4882,6 +4894,12 @@
 //DAGB2_WRCLI_DBUS_GO_PENDING
 #define DAGB2_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB2_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB2_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB2_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB2_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB2_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB2_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB2_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB2_DAGB_DLY
 #define DAGB2_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB2_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -6557,6 +6575,12 @@
 //DAGB3_WRCLI_DBUS_GO_PENDING
 #define DAGB3_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB3_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB3_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB3_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB3_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB3_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB3_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB3_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB3_DAGB_DLY
 #define DAGB3_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB3_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -8232,6 +8256,12 @@
 //DAGB4_WRCLI_DBUS_GO_PENDING
 #define DAGB4_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB4_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB4_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB4_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB4_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB4_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB4_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB4_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB4_DAGB_DLY
 #define DAGB4_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB4_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -28737,6 +28767,12 @@
 //DAGB5_WRCLI_DBUS_GO_PENDING
 #define DAGB5_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB5_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB5_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB5_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB5_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB5_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB5_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB5_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB5_DAGB_DLY
 #define DAGB5_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB5_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -30412,6 +30448,12 @@
 //DAGB6_WRCLI_DBUS_GO_PENDING
 #define DAGB6_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB6_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB6_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB6_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB6_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB6_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB6_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB6_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB6_DAGB_DLY
 #define DAGB6_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB6_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -32087,6 +32129,12 @@
 //DAGB7_WRCLI_DBUS_GO_PENDING
 #define DAGB7_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB7_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB7_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB7_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB7_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB7_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB7_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB7_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB7_DAGB_DLY
 #define DAGB7_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB7_DAGB_DLY__CLI__SHIFT                                                                            0x8
-- 
2.34.1

