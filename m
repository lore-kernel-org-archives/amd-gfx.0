Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38816C02190
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D52DB10E3B4;
	Fri, 31 Jan 2025 16:58:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F4boj4Lg";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAEAA10E3B3
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PShdYWzVfT6p9A29A0y0BX06bMxDC9XaNh07TAIpTVmhM96pC9dambjrAN+k0G3M0p38SZMtFvCJCjZkTT8JU+VdPCIRUwoYzhgQUhvh0wSruSrMaxMALDkxl2onh2V5KbF7AJh2K/9IP05j/jwQ3UWBMSmk+0A3KQaMhaZme3fCJIsMYazEyPa0JtQDbFAKkyvWs1qjLHrjkg5q/KqS9DeQfFF2thOQZE1hUwochvmO3kJSdBkWhwnSzNzs1okGLVs8Umch5CTTPqSN4V4VCGEDGehq9FT73I0aMYJsfSuIO1mRolNjNej/nu39Fv9Xkuy/LEjV93WMfGwGNAfHmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTTUA8kj6erjjESlEXapOKl5FGhxRdNA6Hq120E5L1I=;
 b=ZyPd3uTCvtCbk1w+EqSXv3F8VjlQC6Atb+iR4pPD4275DrzD2Hf6sS6vBzviWuZbemt9Ys14CkRYr8ehxPPobGmxGEq3hrxyZj8R72TVLzpMoVaG4ew1n0HtNw/+kYeW9zgK+bm999QnVdembYCabVMF/mFkFPrx3R7ZfSP1LLcad1Y7AjmKG3ZTgchfK93KIu+fWS7Dp2FqHCgLoSbfvgoy4XB6VQOhAaAmXb4w7i2iQRtksM8MslIKF/jGp0SyxWAwDl3IqUlDZ5MYQAo4cA8E2gc+DbGLJ9FA+nUo8vz2tBgHaDAojvrJtcp+v/EC0E/VHAPMkCKNtrzC59D4UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTTUA8kj6erjjESlEXapOKl5FGhxRdNA6Hq120E5L1I=;
 b=F4boj4Lgyx9OTcadH4JnxRdmFTnlBKPPDppnyx3GN5JNrpAbttOPXxGtou0yTz9ho+CGTlBvszBLIf1OElftHn/yTTGDJjR0/yDz+eFCZCo9OARpe8qbUka1AWaQ/RCZ/g3C/QClH03uboGjhgT57dBPwEyJlaNTTxQhJjRFlPE=
Received: from DM6PR07CA0088.namprd07.prod.outlook.com (2603:10b6:5:337::21)
 by SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Fri, 31 Jan
 2025 16:58:02 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:337:cafe::5b) by DM6PR07CA0088.outlook.office365.com
 (2603:10b6:5:337::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 16:58:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:00 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/44] drm/amdgpu/vcn2.5: split code along instances
Date: Fri, 31 Jan 2025 11:56:57 -0500
Message-ID: <20250131165741.1798488-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131165741.1798488-1-alexander.deucher@amd.com>
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|SJ1PR12MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: d0985bd9-0dc8-4715-922f-08dd42186c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Qv2I+ej9S6+BGtdQJAbFJNYVPLBySrVLxgiJBv5B7/JScdskhKfSz3HOVHVy?=
 =?us-ascii?Q?WnVIZ/KcDIANt6i/wAjO7b1WSEY03/quskUsWyO0gPAQTdrF1VrxD6C76XcR?=
 =?us-ascii?Q?sm6DfVtoxUX0yfMIAhPsHBmghE5NQKr0ThjbogHsfbuydaF/2Yp7h4z7XmYl?=
 =?us-ascii?Q?5HY49/ImlSOIQ/1yTZYqR6MNSK+22pGktVD6JCmRl8IXMWw+eRaDaQr8Z6Xq?=
 =?us-ascii?Q?yfoCFH7yrRdZ2iK7xwtVAM48tNQeldbEEE5Zg/fRklJV1wM82n+gNI/N6YiS?=
 =?us-ascii?Q?yYaRs8yAUUVsX5/39LXSb7yayOiuIa3TV+01cpFDkL68FkN5PxhxYjE+hHth?=
 =?us-ascii?Q?QFnP20UG1O4DgpstjZYGDlPgKEIQE/0GxGhH0BPPne4fpZKJAjsxvUKG0q1c?=
 =?us-ascii?Q?71WEAH1sT7cWRdSSS0U5eXDnRd+yDVKMwdLwXDgzJHRrulvSR9bWmYaxmUjR?=
 =?us-ascii?Q?zpb99vOoeBuAx+so4Q3fooa4V8sFjjIUdm/nycITANBND9c539vCTZIrcRXE?=
 =?us-ascii?Q?t84AGZh0SofawP1ctNxnE8zYLVxdiKsb+efbVlBs1rEO5eAj/BVLNDLXv8hp?=
 =?us-ascii?Q?pN/R+LXpxWZxWEvioSBrKx2nAzYiztcObv9fQJX84te1ib2LVpJ5GR352wyJ?=
 =?us-ascii?Q?6fguol/ymtwXab/m8WSo94bWUiMAZ1pqizd4LVIkyhux7EwfjGIAoIOVKnkx?=
 =?us-ascii?Q?2trKFkZzpGQa7+yvpTJrIFrY0jMtttp6FBrl2ZFx6XxH918WxPcBrs4jKVZ6?=
 =?us-ascii?Q?RuqZ6JSDX9U1Q+QjvoKHtTTrUlRPPRqwmOY9gLExUCQ7AfEbJfYiqIwAJenL?=
 =?us-ascii?Q?7lCp88DW/Ct5sqL8/f/Gta/SXiT6DH+CPHMvAmr0TYLje/K20KzmhbOrGpzG?=
 =?us-ascii?Q?ec7Mveg2ZIqV+Ni+w9qF4EDO4GMEpUSNbl1q/EcanWEl/KReWSQajgA3+o+g?=
 =?us-ascii?Q?VoAZbyHvaUs6Y6sHRW2bDwkTn0rI/7+FVy1itVxhwkqWunyea6CtZhujFocI?=
 =?us-ascii?Q?cy5c6KQkB88gCu1HjMnYcihR2V/lFOjdOEp8ADOvKqiU2UI1OVzjpkZr3HRZ?=
 =?us-ascii?Q?OSSBidN+JHt9uqdGBOzSZhkPimX2WBGospEOP0KiyNwOE7m4BzOop4PrCs9d?=
 =?us-ascii?Q?MnI8uCFQOBRtSHArsyuKVvuwhqx0ezChULv1Zi2/B2IAq6EAOSA/a++xO/g8?=
 =?us-ascii?Q?6rdgLOTfgzEjnaqs+0WXqdTXjwtUg0zJMuj1CPJkKEITUIFeHAuqZAWXrwcb?=
 =?us-ascii?Q?0FV6oSX1BZVIbTTheGnBe8bFnUEdgl7vlulKR5L/r9h0QPFc/diVu8xqHNR9?=
 =?us-ascii?Q?QGoZdpekSATuLkUhUARcAJJHTaZmhLuLao06s9FnaykaCODHvW+nbfAsTMwV?=
 =?us-ascii?Q?6I5RDxlLHWEthtwBJEvfQPA/NETTxXkbJiHNbt1tL0UUwU8UN1XyC2I2uOTx?=
 =?us-ascii?Q?vR7w/3shLOIEK02zVMoR3+9lBuh1l51IiKhHAn+F7bpktBL1sDwq0g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:02.0301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0985bd9-0dc8-4715-922f-08dd42186c60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6289
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

Split the code on a per instance basis.  This will allow
us to use the per instance functions in the future to
handle more things per instance.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 841 +++++++++++++-------------
 1 file changed, 411 insertions(+), 430 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index b518202955cad..b9be304aa294b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -452,64 +452,62 @@ static int vcn_v2_5_resume(struct amdgpu_ip_block *ip_block)
  * vcn_v2_5_mc_resume - memory controller programming
  *
  * @adev: amdgpu_device pointer
+ * @i: instance to resume
  *
  * Let the VCN memory controller know it's offsets
  */
-static void vcn_v2_5_mc_resume(struct amdgpu_device *adev)
+static void vcn_v2_5_mc_resume(struct amdgpu_device *adev, int i)
 {
 	uint32_t size;
 	uint32_t offset;
-	int i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
 
-		size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[i].fw->size + 4);
-		/* cache window 0: fw */
-		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-			WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
-				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_lo));
-			WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
-				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_hi));
-			WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET0, 0);
-			offset = 0;
-		} else {
-			WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
-				lower_32_bits(adev->vcn.inst[i].gpu_addr));
-			WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
-				upper_32_bits(adev->vcn.inst[i].gpu_addr));
-			offset = size;
-			WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET0,
-				AMDGPU_UVD_FIRMWARE_OFFSET >> 3);
-		}
-		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE0, size);
+	if (adev->vcn.harvest_config & (1 << i))
+		return;
 
-		/* cache window 1: stack */
-		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW,
-			lower_32_bits(adev->vcn.inst[i].gpu_addr + offset));
-		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH,
-			upper_32_bits(adev->vcn.inst[i].gpu_addr + offset));
-		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET1, 0);
-		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE1, AMDGPU_VCN_STACK_SIZE);
-
-		/* cache window 2: context */
-		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW,
-			lower_32_bits(adev->vcn.inst[i].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE));
-		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH,
-			upper_32_bits(adev->vcn.inst[i].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE));
-		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET2, 0);
-		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE2, AMDGPU_VCN_CONTEXT_SIZE);
-
-		/* non-cache window */
-		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW,
-			lower_32_bits(adev->vcn.inst[i].fw_shared.gpu_addr));
-		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH,
-			upper_32_bits(adev->vcn.inst[i].fw_shared.gpu_addr));
-		WREG32_SOC15(VCN, i, mmUVD_VCPU_NONCACHE_OFFSET0, 0);
-		WREG32_SOC15(VCN, i, mmUVD_VCPU_NONCACHE_SIZE0,
-			AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)));
+	size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[i].fw->size + 4);
+	/* cache window 0: fw */
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
+			     (adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_lo));
+		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
+			     (adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_hi));
+		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET0, 0);
+		offset = 0;
+	} else {
+		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
+			     lower_32_bits(adev->vcn.inst[i].gpu_addr));
+		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
+			     upper_32_bits(adev->vcn.inst[i].gpu_addr));
+		offset = size;
+		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET0,
+			     AMDGPU_UVD_FIRMWARE_OFFSET >> 3);
 	}
+	WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE0, size);
+
+	/* cache window 1: stack */
+	WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW,
+		     lower_32_bits(adev->vcn.inst[i].gpu_addr + offset));
+	WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH,
+		     upper_32_bits(adev->vcn.inst[i].gpu_addr + offset));
+	WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET1, 0);
+	WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE1, AMDGPU_VCN_STACK_SIZE);
+
+	/* cache window 2: context */
+	WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW,
+		     lower_32_bits(adev->vcn.inst[i].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE));
+	WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH,
+		     upper_32_bits(adev->vcn.inst[i].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE));
+	WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET2, 0);
+	WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE2, AMDGPU_VCN_CONTEXT_SIZE);
+
+	/* non-cache window */
+	WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW,
+		     lower_32_bits(adev->vcn.inst[i].fw_shared.gpu_addr));
+	WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH,
+		     upper_32_bits(adev->vcn.inst[i].fw_shared.gpu_addr));
+	WREG32_SOC15(VCN, i, mmUVD_VCPU_NONCACHE_OFFSET0, 0);
+	WREG32_SOC15(VCN, i, mmUVD_VCPU_NONCACHE_SIZE0,
+		     AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)));
 }
 
 static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
@@ -612,117 +610,115 @@ static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
  * vcn_v2_5_disable_clock_gating - disable VCN clock gating
  *
  * @adev: amdgpu_device pointer
+ * @i: instance to disable clockgating on
  *
  * Disable clock gating for VCN block
  */
-static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev)
+static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev, int i)
 {
 	uint32_t data;
-	int i;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		/* UVD disable CGC */
-		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
-		if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
-			data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
-		else
-			data &= ~UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK;
-		data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
-		data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
-		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
-
-		data = RREG32_SOC15(VCN, i, mmUVD_CGC_GATE);
-		data &= ~(UVD_CGC_GATE__SYS_MASK
-			| UVD_CGC_GATE__UDEC_MASK
-			| UVD_CGC_GATE__MPEG2_MASK
-			| UVD_CGC_GATE__REGS_MASK
-			| UVD_CGC_GATE__RBC_MASK
-			| UVD_CGC_GATE__LMI_MC_MASK
-			| UVD_CGC_GATE__LMI_UMC_MASK
-			| UVD_CGC_GATE__IDCT_MASK
-			| UVD_CGC_GATE__MPRD_MASK
-			| UVD_CGC_GATE__MPC_MASK
-			| UVD_CGC_GATE__LBSI_MASK
-			| UVD_CGC_GATE__LRBBM_MASK
-			| UVD_CGC_GATE__UDEC_RE_MASK
-			| UVD_CGC_GATE__UDEC_CM_MASK
-			| UVD_CGC_GATE__UDEC_IT_MASK
-			| UVD_CGC_GATE__UDEC_DB_MASK
-			| UVD_CGC_GATE__UDEC_MP_MASK
-			| UVD_CGC_GATE__WCB_MASK
-			| UVD_CGC_GATE__VCPU_MASK
-			| UVD_CGC_GATE__MMSCH_MASK);
-
-		WREG32_SOC15(VCN, i, mmUVD_CGC_GATE, data);
-
-		SOC15_WAIT_ON_RREG(VCN, i, mmUVD_CGC_GATE, 0,  0xFFFFFFFF);
-
-		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
-		data &= ~(UVD_CGC_CTRL__UDEC_RE_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_CM_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_IT_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_DB_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_MP_MODE_MASK
-			| UVD_CGC_CTRL__SYS_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_MODE_MASK
-			| UVD_CGC_CTRL__MPEG2_MODE_MASK
-			| UVD_CGC_CTRL__REGS_MODE_MASK
-			| UVD_CGC_CTRL__RBC_MODE_MASK
-			| UVD_CGC_CTRL__LMI_MC_MODE_MASK
-			| UVD_CGC_CTRL__LMI_UMC_MODE_MASK
-			| UVD_CGC_CTRL__IDCT_MODE_MASK
-			| UVD_CGC_CTRL__MPRD_MODE_MASK
-			| UVD_CGC_CTRL__MPC_MODE_MASK
-			| UVD_CGC_CTRL__LBSI_MODE_MASK
-			| UVD_CGC_CTRL__LRBBM_MODE_MASK
-			| UVD_CGC_CTRL__WCB_MODE_MASK
-			| UVD_CGC_CTRL__VCPU_MODE_MASK
-			| UVD_CGC_CTRL__MMSCH_MODE_MASK);
-		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
-
-		/* turn on */
-		data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_GATE);
-		data |= (UVD_SUVD_CGC_GATE__SRE_MASK
-			| UVD_SUVD_CGC_GATE__SIT_MASK
-			| UVD_SUVD_CGC_GATE__SMP_MASK
-			| UVD_SUVD_CGC_GATE__SCM_MASK
-			| UVD_SUVD_CGC_GATE__SDB_MASK
-			| UVD_SUVD_CGC_GATE__SRE_H264_MASK
-			| UVD_SUVD_CGC_GATE__SRE_HEVC_MASK
-			| UVD_SUVD_CGC_GATE__SIT_H264_MASK
-			| UVD_SUVD_CGC_GATE__SIT_HEVC_MASK
-			| UVD_SUVD_CGC_GATE__SCM_H264_MASK
-			| UVD_SUVD_CGC_GATE__SCM_HEVC_MASK
-			| UVD_SUVD_CGC_GATE__SDB_H264_MASK
-			| UVD_SUVD_CGC_GATE__SDB_HEVC_MASK
-			| UVD_SUVD_CGC_GATE__SCLR_MASK
-			| UVD_SUVD_CGC_GATE__UVD_SC_MASK
-			| UVD_SUVD_CGC_GATE__ENT_MASK
-			| UVD_SUVD_CGC_GATE__SIT_HEVC_DEC_MASK
-			| UVD_SUVD_CGC_GATE__SIT_HEVC_ENC_MASK
-			| UVD_SUVD_CGC_GATE__SITE_MASK
-			| UVD_SUVD_CGC_GATE__SRE_VP9_MASK
-			| UVD_SUVD_CGC_GATE__SCM_VP9_MASK
-			| UVD_SUVD_CGC_GATE__SIT_VP9_DEC_MASK
-			| UVD_SUVD_CGC_GATE__SDB_VP9_MASK
-			| UVD_SUVD_CGC_GATE__IME_HEVC_MASK);
-		WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_GATE, data);
-
-		data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL);
-		data &= ~(UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
+	if (adev->vcn.harvest_config & (1 << i))
+		return;
+	/* UVD disable CGC */
+	data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
+	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
+		data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	else
+		data &= ~UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK;
+	data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
+	data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
+	WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
+
+	data = RREG32_SOC15(VCN, i, mmUVD_CGC_GATE);
+	data &= ~(UVD_CGC_GATE__SYS_MASK
+		  | UVD_CGC_GATE__UDEC_MASK
+		  | UVD_CGC_GATE__MPEG2_MASK
+		  | UVD_CGC_GATE__REGS_MASK
+		  | UVD_CGC_GATE__RBC_MASK
+		  | UVD_CGC_GATE__LMI_MC_MASK
+		  | UVD_CGC_GATE__LMI_UMC_MASK
+		  | UVD_CGC_GATE__IDCT_MASK
+		  | UVD_CGC_GATE__MPRD_MASK
+		  | UVD_CGC_GATE__MPC_MASK
+		  | UVD_CGC_GATE__LBSI_MASK
+		  | UVD_CGC_GATE__LRBBM_MASK
+		  | UVD_CGC_GATE__UDEC_RE_MASK
+		  | UVD_CGC_GATE__UDEC_CM_MASK
+		  | UVD_CGC_GATE__UDEC_IT_MASK
+		  | UVD_CGC_GATE__UDEC_DB_MASK
+		  | UVD_CGC_GATE__UDEC_MP_MASK
+		  | UVD_CGC_GATE__WCB_MASK
+		  | UVD_CGC_GATE__VCPU_MASK
+		  | UVD_CGC_GATE__MMSCH_MASK);
+
+	WREG32_SOC15(VCN, i, mmUVD_CGC_GATE, data);
+
+	SOC15_WAIT_ON_RREG(VCN, i, mmUVD_CGC_GATE, 0,  0xFFFFFFFF);
+
+	data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
+	data &= ~(UVD_CGC_CTRL__UDEC_RE_MODE_MASK
+		  | UVD_CGC_CTRL__UDEC_CM_MODE_MASK
+		  | UVD_CGC_CTRL__UDEC_IT_MODE_MASK
+		  | UVD_CGC_CTRL__UDEC_DB_MODE_MASK
+		  | UVD_CGC_CTRL__UDEC_MP_MODE_MASK
+		  | UVD_CGC_CTRL__SYS_MODE_MASK
+		  | UVD_CGC_CTRL__UDEC_MODE_MASK
+		  | UVD_CGC_CTRL__MPEG2_MODE_MASK
+		  | UVD_CGC_CTRL__REGS_MODE_MASK
+		  | UVD_CGC_CTRL__RBC_MODE_MASK
+		  | UVD_CGC_CTRL__LMI_MC_MODE_MASK
+		  | UVD_CGC_CTRL__LMI_UMC_MODE_MASK
+		  | UVD_CGC_CTRL__IDCT_MODE_MASK
+		  | UVD_CGC_CTRL__MPRD_MODE_MASK
+		  | UVD_CGC_CTRL__MPC_MODE_MASK
+		  | UVD_CGC_CTRL__LBSI_MODE_MASK
+		  | UVD_CGC_CTRL__LRBBM_MODE_MASK
+		  | UVD_CGC_CTRL__WCB_MODE_MASK
+		  | UVD_CGC_CTRL__VCPU_MODE_MASK
+		  | UVD_CGC_CTRL__MMSCH_MODE_MASK);
+	WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
+
+	/* turn on */
+	data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_GATE);
+	data |= (UVD_SUVD_CGC_GATE__SRE_MASK
+		 | UVD_SUVD_CGC_GATE__SIT_MASK
+		 | UVD_SUVD_CGC_GATE__SMP_MASK
+		 | UVD_SUVD_CGC_GATE__SCM_MASK
+		 | UVD_SUVD_CGC_GATE__SDB_MASK
+		 | UVD_SUVD_CGC_GATE__SRE_H264_MASK
+		 | UVD_SUVD_CGC_GATE__SRE_HEVC_MASK
+		 | UVD_SUVD_CGC_GATE__SIT_H264_MASK
+		 | UVD_SUVD_CGC_GATE__SIT_HEVC_MASK
+		 | UVD_SUVD_CGC_GATE__SCM_H264_MASK
+		 | UVD_SUVD_CGC_GATE__SCM_HEVC_MASK
+		 | UVD_SUVD_CGC_GATE__SDB_H264_MASK
+		 | UVD_SUVD_CGC_GATE__SDB_HEVC_MASK
+		 | UVD_SUVD_CGC_GATE__SCLR_MASK
+		 | UVD_SUVD_CGC_GATE__UVD_SC_MASK
+		 | UVD_SUVD_CGC_GATE__ENT_MASK
+		 | UVD_SUVD_CGC_GATE__SIT_HEVC_DEC_MASK
+		 | UVD_SUVD_CGC_GATE__SIT_HEVC_ENC_MASK
+		 | UVD_SUVD_CGC_GATE__SITE_MASK
+		 | UVD_SUVD_CGC_GATE__SRE_VP9_MASK
+		 | UVD_SUVD_CGC_GATE__SCM_VP9_MASK
+		 | UVD_SUVD_CGC_GATE__SIT_VP9_DEC_MASK
+		 | UVD_SUVD_CGC_GATE__SDB_VP9_MASK
+		 | UVD_SUVD_CGC_GATE__IME_HEVC_MASK);
+	WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_GATE, data);
+
+	data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL);
+	data &= ~(UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
+		  | UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
+		  | UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
+		  | UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
+		  | UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
+		  | UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
+		  | UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
+		  | UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
 			| UVD_SUVD_CGC_CTRL__IME_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
-		WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
-	}
+		  | UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
+	WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
 }
 
 static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
@@ -774,65 +770,63 @@ static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
 }
 
 /**
- * vcn_v2_5_enable_clock_gating - enable VCN clock gating
+ * vcn_v2_5_enable_clock_gating_inst - enable VCN clock gating
  *
  * @adev: amdgpu_device pointer
+ * @i: instance to enable clockgating on
  *
  * Enable clock gating for VCN block
  */
-static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev)
+static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev, int i)
 {
 	uint32_t data = 0;
-	int i;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		/* enable UVD CGC */
-		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
-		if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
-			data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
-		else
-			data |= 0 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
-		data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
-		data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
-		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
-
-		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
-		data |= (UVD_CGC_CTRL__UDEC_RE_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_CM_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_IT_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_DB_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_MP_MODE_MASK
-			| UVD_CGC_CTRL__SYS_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_MODE_MASK
-			| UVD_CGC_CTRL__MPEG2_MODE_MASK
-			| UVD_CGC_CTRL__REGS_MODE_MASK
-			| UVD_CGC_CTRL__RBC_MODE_MASK
-			| UVD_CGC_CTRL__LMI_MC_MODE_MASK
-			| UVD_CGC_CTRL__LMI_UMC_MODE_MASK
-			| UVD_CGC_CTRL__IDCT_MODE_MASK
-			| UVD_CGC_CTRL__MPRD_MODE_MASK
-			| UVD_CGC_CTRL__MPC_MODE_MASK
-			| UVD_CGC_CTRL__LBSI_MODE_MASK
-			| UVD_CGC_CTRL__LRBBM_MODE_MASK
-			| UVD_CGC_CTRL__WCB_MODE_MASK
-			| UVD_CGC_CTRL__VCPU_MODE_MASK);
-		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
-
-		data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL);
-		data |= (UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__IME_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
-		WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
-	}
+	if (adev->vcn.harvest_config & (1 << i))
+		return;
+	/* enable UVD CGC */
+	data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
+	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
+		data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	else
+		data |= 0 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
+	data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
+	WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
+
+	data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
+	data |= (UVD_CGC_CTRL__UDEC_RE_MODE_MASK
+		 | UVD_CGC_CTRL__UDEC_CM_MODE_MASK
+		 | UVD_CGC_CTRL__UDEC_IT_MODE_MASK
+		 | UVD_CGC_CTRL__UDEC_DB_MODE_MASK
+		 | UVD_CGC_CTRL__UDEC_MP_MODE_MASK
+		 | UVD_CGC_CTRL__SYS_MODE_MASK
+		 | UVD_CGC_CTRL__UDEC_MODE_MASK
+		 | UVD_CGC_CTRL__MPEG2_MODE_MASK
+		 | UVD_CGC_CTRL__REGS_MODE_MASK
+		 | UVD_CGC_CTRL__RBC_MODE_MASK
+		 | UVD_CGC_CTRL__LMI_MC_MODE_MASK
+		 | UVD_CGC_CTRL__LMI_UMC_MODE_MASK
+		 | UVD_CGC_CTRL__IDCT_MODE_MASK
+		 | UVD_CGC_CTRL__MPRD_MODE_MASK
+		 | UVD_CGC_CTRL__MPC_MODE_MASK
+		 | UVD_CGC_CTRL__LBSI_MODE_MASK
+		 | UVD_CGC_CTRL__LRBBM_MODE_MASK
+		 | UVD_CGC_CTRL__WCB_MODE_MASK
+		 | UVD_CGC_CTRL__VCPU_MODE_MASK);
+	WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
+
+	data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL);
+	data |= (UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
+		 | UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
+		 | UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
+		 | UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
+		 | UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
+		 | UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
+		 | UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
+		 | UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
+		 | UVD_SUVD_CGC_CTRL__IME_MODE_MASK
+		 | UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
+	WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
 }
 
 static void vcn_v2_6_enable_ras(struct amdgpu_device *adev, int inst_idx,
@@ -1006,197 +1000,185 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	return 0;
 }
 
-static int vcn_v2_5_start(struct amdgpu_device *adev)
+static int vcn_v2_5_start(struct amdgpu_device *adev, int i)
 {
+	volatile struct amdgpu_fw_shared *fw_shared =
+		adev->vcn.inst[i].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
-	int i, j, k, r;
+	int j, k, r;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, true, i);
-	}
+	if (adev->vcn.harvest_config & (1 << i))
+		return 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v2_5_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
-			continue;
-		}
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_vcn(adev, true, i);
 
-		/* disable register anti-hang mechanism */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS), 0,
-			~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
+		return vcn_v2_5_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
 
-		/* set uvd status busy */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
-		WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
-	}
+	/* disable register anti-hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS), 0,
+		 ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
+
+	/* set uvd status busy */
+	tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
+	WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 		return 0;
 
-	/*SW clock gating */
-	vcn_v2_5_disable_clock_gating(adev);
+	/* SW clock gating */
+	vcn_v2_5_disable_clock_gating(adev, i);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		/* enable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
-			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
-
-		/* disable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
-			~UVD_MASTINT_EN__VCPU_EN_MASK);
-
-		/* setup mmUVD_LMI_CTRL */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
-		tmp &= ~0xff;
-		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp | 0x8|
-			UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
-			UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
-			UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
-			UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
-
-		/* setup mmUVD_MPC_CNTL */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
-		tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
-		tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
-		WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
-
-		/* setup UVD_MPC_SET_MUXA0 */
-		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
-			((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
-			(0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
-			(0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
-			(0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
-
-		/* setup UVD_MPC_SET_MUXB0 */
-		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
-			((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
-			(0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
-			(0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
-			(0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
-
-		/* setup mmUVD_MPC_SET_MUX */
-		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
-			((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
-			(0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
-			(0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
-	}
+	/* enable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
+		 UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
 
-	vcn_v2_5_mc_resume(adev);
+	/* disable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
+		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		/* VCN global tiling registers */
-		WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
-			adev->gfx.config.gb_addr_config);
-		WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
-			adev->gfx.config.gb_addr_config);
+	/* setup mmUVD_LMI_CTRL */
+	tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
+	tmp &= ~0xff;
+	WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp | 0x8|
+		     UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
+		     UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
+		     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
+		     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
+
+	/* setup mmUVD_MPC_CNTL */
+	tmp = RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
+	tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
+	tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
+	WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
+
+	/* setup UVD_MPC_SET_MUXA0 */
+	WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
+		     ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
+		      (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
+		      (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
+		      (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
+
+	/* setup UVD_MPC_SET_MUXB0 */
+	WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
+		     ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
+		      (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
+		      (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
+		      (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
+
+	/* setup mmUVD_MPC_SET_MUX */
+	WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
+		     ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
+		      (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
+		      (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
+
+	vcn_v2_5_mc_resume(adev, i);
 
-		/* enable LMI MC and UMC channels */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
-			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
+	/* VCN global tiling registers */
+	WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
+		     adev->gfx.config.gb_addr_config);
+	WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
+		     adev->gfx.config.gb_addr_config);
 
-		/* unblock VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
-			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+	/* enable LMI MC and UMC channels */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
+		 ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
 
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
-			~UVD_VCPU_CNTL__BLK_RST_MASK);
-
-		for (k = 0; k < 10; ++k) {
-			uint32_t status;
-
-			for (j = 0; j < 100; ++j) {
-				status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
-				if (status & 2)
-					break;
-				if (amdgpu_emu_mode == 1)
-					msleep(500);
-				else
-					mdelay(10);
-			}
-			r = 0;
+	/* unblock VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
+		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
+		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+	for (k = 0; k < 10; ++k) {
+		uint32_t status;
+
+		for (j = 0; j < 100; ++j) {
+			status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
 			if (status & 2)
 				break;
+			if (amdgpu_emu_mode == 1)
+				msleep(500);
+			else
+				mdelay(10);
+		}
+		r = 0;
+		if (status & 2)
+			break;
 
-			DRM_ERROR("VCN decode not responding, trying to reset the VCPU!!!\n");
-			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
-				UVD_VCPU_CNTL__BLK_RST_MASK,
-				~UVD_VCPU_CNTL__BLK_RST_MASK);
-			mdelay(10);
-			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
-				~UVD_VCPU_CNTL__BLK_RST_MASK);
+		DRM_ERROR("VCN decode not responding, trying to reset the VCPU!!!\n");
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
+			 UVD_VCPU_CNTL__BLK_RST_MASK,
+			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+		mdelay(10);
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
+			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
 
-			mdelay(10);
-			r = -1;
-		}
+		mdelay(10);
+		r = -1;
+	}
 
-		if (r) {
-			DRM_ERROR("VCN decode not responding, giving up!!!\n");
-			return r;
-		}
+	if (r) {
+		DRM_ERROR("VCN decode not responding, giving up!!!\n");
+		return r;
+	}
 
-		/* enable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
-			UVD_MASTINT_EN__VCPU_EN_MASK,
-			~UVD_MASTINT_EN__VCPU_EN_MASK);
+	/* enable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
+		 UVD_MASTINT_EN__VCPU_EN_MASK,
+		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
 
-		/* clear the busy bit of VCN_STATUS */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
-			~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
+	/* clear the busy bit of VCN_STATUS */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
+		 ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
 
-		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
+	WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
 
-		ring = &adev->vcn.inst[i].ring_dec;
-		/* force RBC into idle state */
-		rb_bufsz = order_base_2(ring->ring_size);
-		tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
-		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
+	ring = &adev->vcn.inst[i].ring_dec;
+	/* force RBC into idle state */
+	rb_bufsz = order_base_2(ring->ring_size);
+	tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
+	WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
 
-		fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
-		/* program the RB_BASE for ring buffer */
-		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
-			lower_32_bits(ring->gpu_addr));
-		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
-			upper_32_bits(ring->gpu_addr));
+	fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
+	/* program the RB_BASE for ring buffer */
+	WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
+		     lower_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
+		     upper_32_bits(ring->gpu_addr));
 
-		/* Initialize the ring buffer's read and write pointers */
-		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
+	/* Initialize the ring buffer's read and write pointers */
+	WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
 
-		ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
-		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
-				lower_32_bits(ring->wptr));
-		fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
+	ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
+	WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
+		     lower_32_bits(ring->wptr));
+	fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
 
-		fw_shared->multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
-		ring = &adev->vcn.inst[i].ring_enc[0];
-		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
-		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
-		fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~FW_QUEUE_RING_RESET;
-
-		fw_shared->multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
-		ring = &adev->vcn.inst[i].ring_enc[1];
-		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
-		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
-		fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
-	}
+	fw_shared->multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
+	ring = &adev->vcn.inst[i].ring_enc[0];
+	WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
+	WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
+	WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
+	WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
+	fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~FW_QUEUE_RING_RESET;
+
+	fw_shared->multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
+	ring = &adev->vcn.inst[i].ring_enc[1];
+	WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
+	WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
+	WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
+	WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
+	fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
 
 	return 0;
 }
@@ -1425,72 +1407,66 @@ static int vcn_v2_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 	return 0;
 }
 
-static int vcn_v2_5_stop(struct amdgpu_device *adev)
+static int vcn_v2_5_stop(struct amdgpu_device *adev, int i)
 {
 	uint32_t tmp;
-	int i, r = 0;
+	int r;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v2_5_stop_dpg_mode(adev, i);
-			continue;
-		}
+	if (adev->vcn.harvest_config & (1 << i))
+		return 0;
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
+		return vcn_v2_5_stop_dpg_mode(adev, i);
 
-		/* wait for vcn idle */
-		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
-		if (r)
-			return r;
+	/* wait for vcn idle */
+	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
+	if (r)
+		return r;
 
-		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__READ_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
+	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__READ_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		/* block LMI UMC channel */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
-		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
-		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
+	/* block LMI UMC channel */
+	tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
+	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
+	WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
 
-		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
-			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
+	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
+		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		/* block VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
-			UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
-			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+	/* block VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
+		 UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
+		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
 
-		/* reset VCPU */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
-			UVD_VCPU_CNTL__BLK_RST_MASK,
-			~UVD_VCPU_CNTL__BLK_RST_MASK);
+	/* reset VCPU */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
+		 UVD_VCPU_CNTL__BLK_RST_MASK,
+		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
 
-		/* disable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
-			~(UVD_VCPU_CNTL__CLK_EN_MASK));
+	/* disable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
+		 ~(UVD_VCPU_CNTL__CLK_EN_MASK));
 
-		/* clear status */
-		WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
+	/* clear status */
+	WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
 
-		vcn_v2_5_enable_clock_gating(adev);
+	vcn_v2_5_enable_clock_gating(adev, i);
 
-		/* enable register anti-hang mechanism */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS),
-			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
-			~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
-	}
+	/* enable register anti-hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS),
+		 UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
+		 ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, false, i);
-	}
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_vcn(adev, false, i);
 
 	return 0;
 }
@@ -1811,16 +1787,19 @@ static int vcn_v2_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = (state == AMD_CG_STATE_GATE);
+	int i;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	if (enable) {
-		if (!vcn_v2_5_is_idle(adev))
-			return -EBUSY;
-		vcn_v2_5_enable_clock_gating(adev);
-	} else {
-		vcn_v2_5_disable_clock_gating(adev);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (enable) {
+			if (!vcn_v2_5_is_idle(adev))
+				return -EBUSY;
+			vcn_v2_5_enable_clock_gating(adev, i);
+		} else {
+			vcn_v2_5_disable_clock_gating(adev, i);
+		}
 	}
 
 	return 0;
@@ -1830,20 +1809,22 @@ static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int ret;
+	int ret = 0, i;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	if(state == adev->vcn.cur_state)
+	if (state == adev->vcn.cur_state)
 		return 0;
 
-	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v2_5_stop(adev);
-	else
-		ret = vcn_v2_5_start(adev);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (state == AMD_PG_STATE_GATE)
+			ret |= vcn_v2_5_stop(adev, i);
+		else
+			ret |= vcn_v2_5_start(adev, i);
+	}
 
-	if(!ret)
+	if (!ret)
 		adev->vcn.cur_state = state;
 
 	return ret;
-- 
2.48.1

