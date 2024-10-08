Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350C8CF0428
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 21:16:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE8C510E5D6;
	Tue,  8 Oct 2024 21:16:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gxHvVMFm";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC9AA10E5D2
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 21:16:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AipWjbg/yEUHfHH1Dezitj1wOhflvbdiZABhrXaAjIRKgTZmQ8tj/fcZLJBYNn1mdsZXdMFh0PuhbW3o6LDigGTyXhK+Gsc/SJdCZHaLGPEkusf3c+lB3lmi7kaZZ5K4Wcn1si4Yrhucmkzphb0Odx2kQCAxu7aGaFaYdvHfh2bBtcz9t3xS0/4jsubIMwICo58LzGlVeSbzQ7CIcFHk0T43YeTlwiFfeItXdUdMCwA5UGC8gqNMvXB3i3ormiIFLBcZp1DHS9Ta2/uwSQth5x7pwTAK4y8iejcRJMG3V8R0VGG2sVPHAMVXvw+U/pV2GA9ls30atj44x06wyafC3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7crJ+NtUIgjWk1yrgVsMLY/bqI9Fnu5IYPasoR9wz/4=;
 b=hvm30ndL0wa5hwVVkezqnb7HYS3CsPPr6VUx3v8xMSTrBrqTEUw6qYZ6/n1MHTqtQHZb8y1RKer2/h44RZxIyz/9ZxeLVzwYY8o9+zYtpJNS5jM1U1R/ub8DcAFZVdSUSNBl/98ZGiWxe/3hBDJTX1FPgYolLmwgPKd6Lcz8bfOE9qFOPsIKpvzSHV59JkUpELTOjzs609oC+tnhrG1eWFTbIiKGsUcXoh2UuYlzkfRb8mwTUcQMp2Fu44QoJNlLPU2YvAglTo4D11lhT4/cyDQL2jvHqPke0ZP+RGCSI0x0C0UNfSrGlO/JvBdlvnpWWX+86s9Vg5xOFdoRBigZzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7crJ+NtUIgjWk1yrgVsMLY/bqI9Fnu5IYPasoR9wz/4=;
 b=gxHvVMFmp+2KezsBf/UlYIh6HKOQlKywzOtlvabiAd0ODxZrY0sNbQdvOEinjMoHW0gAHHkzW+0KXEMkrJsJ1vYZuDTPMPWZkQLX1gp5NHm1pLJoDOVzw7UIpgFWur+wzclNfMUyQyub64CeE6TuJbOgNVALpWH6OS2D41eqi+0=
Received: from CH0PR03CA0419.namprd03.prod.outlook.com (2603:10b6:610:11b::8)
 by DS0PR12MB8576.namprd12.prod.outlook.com (2603:10b6:8:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 21:16:27 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::52) by CH0PR03CA0419.outlook.office365.com
 (2603:10b6:610:11b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 21:16:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 21:16:27 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 16:16:23 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 13/32] drm/amdgpu: power vcn 3_0 by instance
Date: Tue, 8 Oct 2024 17:15:34 -0400
Message-ID: <20241008211553.36264-14-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008211553.36264-1-boyuan.zhang@amd.com>
References: <20241008211553.36264-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|DS0PR12MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c42cb4b-b925-429b-8d57-08dce7de78ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0Nw2r5oTDgB5XI+sfrHyTWntwznb1NhITZOBQPDIb4BRqbCQKT7DHsLrOp1w?=
 =?us-ascii?Q?D7FIwqL1VJhaoIsgQtp/DftzPkOUnoR3jiq1dkS4I5aU7L+eUi133gOpqXsw?=
 =?us-ascii?Q?0cFIXhg+BppoonDNq775pHftLGqrkw+eRzHwldpTvvWk5XtpUXIji0Z6RMfP?=
 =?us-ascii?Q?iltCSyqn7HLwQQcUa5bXakh67qmH4sTIaLnqWEXeOKBx7wpYlWejJfoouYDV?=
 =?us-ascii?Q?+AKcwFDW4oIjWrDevyL9J4DGbp/dU/6/Es17kj6cwzu1zgRkrgT3sGQnCN7G?=
 =?us-ascii?Q?JDB2vh9bPmA3qmpJUln1C560eOYeY65qaUJHW8RAMXIXbj8EBPJVLstqkHju?=
 =?us-ascii?Q?ZkO1xUyVpq05x+VPkdBtlYQjRltPwN7Kp9JqLFvQ6CVYNosFypU0EaifzQWo?=
 =?us-ascii?Q?KVCsCpqaKZz2XDiXKZfrvFPUBMGxQ86tPOKkBw6OJFeIimJVcbkrxADwR7Mt?=
 =?us-ascii?Q?J/zyJUIVJcy/fxUxT9l2fHSk9fWxBD3JDg9akQveVKEbCDKCT6O7isEwEOuf?=
 =?us-ascii?Q?+L5SCbt3G/1hGmryOF2D+BqbNEBTLdyxIsG7Ddnu4x/5aYgJitgyVyV6FC+5?=
 =?us-ascii?Q?TySJ+aAjWWrUkoBSXd45NGOTZkymBExdNLk8/7UFlqgV5Wt9Y0FdhrutTd/A?=
 =?us-ascii?Q?TT4CJ85i6x/QOEqF/ihzoOe/k+OkcHajfZTxtK3sjswCPBHoX+ah2/a6ghda?=
 =?us-ascii?Q?RC3/m+1GyMzhin96Jhkica6a86H5wogjUFyvREGALyBFS2OMTWgRbU23MuIt?=
 =?us-ascii?Q?ht8MqnJwaJFfrnzOlu+BP7d+D0sQv1syOuYvgF61/2yiF+cSGJe2AFlo5YqT?=
 =?us-ascii?Q?vBRd0oE8h72O+HuQPIgJIWNeNF0uiG4zH937gTUFHJMAL+5w0JZoj3uFvexL?=
 =?us-ascii?Q?exiAdw8VFcKqVRSFtmf1zHMXmCA3j1R92SVhQ78nD1B3sHghTquSk/9n5ip5?=
 =?us-ascii?Q?KsUKVqOw6mw1kFUTUHRKVyQc/sqorCDbIDIUu+TPSOh+E/Q8vNbs6aS7gZSi?=
 =?us-ascii?Q?WhuCiq+6hG5zTyBkdLfFB3Ffv6eCx6QLBAKiu+B8Nl7KYEAviR9W5f7NbeCP?=
 =?us-ascii?Q?JDGVsAuAmRjKzSXXpnhFAiqWB159HyeyM8x88U6RB7zc+toMEqD3IVbiGkXq?=
 =?us-ascii?Q?5KRRBpQyvIReo25RKhSeuT0GKlhHnCE+VyrODAU+Trav4pMEufx6RkcntqFj?=
 =?us-ascii?Q?SNm/qEBILkii2Q2wcduCDoGumMRe2Sehyr9Loy5zGagE0Fh/WBIuQ0n05gEt?=
 =?us-ascii?Q?h87g/55uuRSnGPhmuYS3DHP6obm8ir25TrSegb82aUGS4FhAzTXWvbvoqMrF?=
 =?us-ascii?Q?IMtDQFajvxqR0imepJ5t3QsmOuZdnOnh0wVZGgEApNLOQV82THO6tQRuYh3R?=
 =?us-ascii?Q?+et+nx4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 21:16:27.5770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c42cb4b-b925-429b-8d57-08dce7de78ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8576
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

For vcn 3_0, add ip_block for each vcn instance during discovery stage.

And only powering on/off one of the vcn instance using the
instance value stored in ip_block, instead of powering on/off all
vcn instances. Modify the existing functions to use the instance value
in ip_block, and remove the original for loop for all vcn instances.

v2: rename "i"/"j" to "inst" for instance value.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         | 583 +++++++++---------
 2 files changed, 289 insertions(+), 297 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index eb77eef60368..4ab5f11f0659 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2336,7 +2336,8 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(3, 1, 1):
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 0, 2):
-			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
+			for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+				amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
 			if (!amdgpu_sriov_vf(adev))
 				amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
 			break;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index a5648089ba05..e68904659059 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -160,7 +160,7 @@ static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
-	int i, j, r;
+	int inst = ip_block->instance, j, r;
 	int vcn_doorbell_index = 0;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_3_0);
 	uint32_t *ptr;
@@ -189,93 +189,91 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 		vcn_doorbell_index = vcn_doorbell_index << 1;
 	}
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		volatile struct amdgpu_fw_shared *fw_shared;
+	volatile struct amdgpu_fw_shared *fw_shared;
 
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		goto done;
+
+	adev->vcn.internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
+	adev->vcn.internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
+	adev->vcn.internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
+	adev->vcn.internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
+	adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
+	adev->vcn.internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
+
+	adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
+	adev->vcn.inst[inst].external.scratch9 = SOC15_REG_OFFSET(VCN, inst, mmUVD_SCRATCH9);
+	adev->vcn.internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
+	adev->vcn.inst[inst].external.data0 = SOC15_REG_OFFSET(VCN, inst, mmUVD_GPCOM_VCPU_DATA0);
+	adev->vcn.internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
+	adev->vcn.inst[inst].external.data1 = SOC15_REG_OFFSET(VCN, inst, mmUVD_GPCOM_VCPU_DATA1);
+	adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
+	adev->vcn.inst[inst].external.cmd = SOC15_REG_OFFSET(VCN, inst, mmUVD_GPCOM_VCPU_CMD);
+	adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
+	adev->vcn.inst[inst].external.nop = SOC15_REG_OFFSET(VCN, inst, mmUVD_NO_OP);
+
+	/* VCN DEC TRAP */
+	r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
+			VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT, &adev->vcn.inst[inst].irq);
+	if (r)
+		return r;
+
+	atomic_set(&adev->vcn.inst[inst].sched_score, 0);
 
-		adev->vcn.internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
-		adev->vcn.internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
-		adev->vcn.internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
-		adev->vcn.internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
-		adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
-		adev->vcn.internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
-
-		adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
-		adev->vcn.inst[i].external.scratch9 = SOC15_REG_OFFSET(VCN, i, mmUVD_SCRATCH9);
-		adev->vcn.internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
-		adev->vcn.inst[i].external.data0 = SOC15_REG_OFFSET(VCN, i, mmUVD_GPCOM_VCPU_DATA0);
-		adev->vcn.internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
-		adev->vcn.inst[i].external.data1 = SOC15_REG_OFFSET(VCN, i, mmUVD_GPCOM_VCPU_DATA1);
-		adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
-		adev->vcn.inst[i].external.cmd = SOC15_REG_OFFSET(VCN, i, mmUVD_GPCOM_VCPU_CMD);
-		adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
-		adev->vcn.inst[i].external.nop = SOC15_REG_OFFSET(VCN, i, mmUVD_NO_OP);
-
-		/* VCN DEC TRAP */
-		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
-				VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT, &adev->vcn.inst[i].irq);
+	ring = &adev->vcn.inst[inst].ring_dec;
+	ring->use_doorbell = true;
+	if (amdgpu_sriov_vf(adev)) {
+		ring->doorbell_index = vcn_doorbell_index + inst * (adev->vcn.num_enc_rings + 1);
+	} else {
+		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * inst;
+	}
+	ring->vm_hub = AMDGPU_MMHUB0(0);
+	sprintf(ring->name, "vcn_dec_%d", inst);
+	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].irq, 0,
+				 AMDGPU_RING_PRIO_DEFAULT,
+				 &adev->vcn.inst[inst].sched_score);
+	if (r)
+		return r;
+
+	for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
+		enum amdgpu_ring_priority_level hw_prio = amdgpu_vcn_get_enc_ring_prio(j);
+
+		/* VCN ENC TRAP */
+		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
+			j + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[inst].irq);
 		if (r)
 			return r;
 
-		atomic_set(&adev->vcn.inst[i].sched_score, 0);
-
-		ring = &adev->vcn.inst[i].ring_dec;
+		ring = &adev->vcn.inst[inst].ring_enc[j];
 		ring->use_doorbell = true;
 		if (amdgpu_sriov_vf(adev)) {
-			ring->doorbell_index = vcn_doorbell_index + i * (adev->vcn.num_enc_rings + 1);
+			ring->doorbell_index = vcn_doorbell_index + inst * (adev->vcn.num_enc_rings + 1) + 1 + j;
 		} else {
-			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i;
+			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + j + 8 * inst;
 		}
 		ring->vm_hub = AMDGPU_MMHUB0(0);
-		sprintf(ring->name, "vcn_dec_%d", i);
-		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
-				     AMDGPU_RING_PRIO_DEFAULT,
-				     &adev->vcn.inst[i].sched_score);
+		sprintf(ring->name, "vcn_enc_%d.%d", inst, j);
+		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].irq, 0,
+					 hw_prio, &adev->vcn.inst[inst].sched_score);
 		if (r)
 			return r;
-
-		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
-			enum amdgpu_ring_priority_level hw_prio = amdgpu_vcn_get_enc_ring_prio(j);
-
-			/* VCN ENC TRAP */
-			r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
-				j + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[i].irq);
-			if (r)
-				return r;
-
-			ring = &adev->vcn.inst[i].ring_enc[j];
-			ring->use_doorbell = true;
-			if (amdgpu_sriov_vf(adev)) {
-				ring->doorbell_index = vcn_doorbell_index + i * (adev->vcn.num_enc_rings + 1) + 1 + j;
-			} else {
-				ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + j + 8 * i;
-			}
-			ring->vm_hub = AMDGPU_MMHUB0(0);
-			sprintf(ring->name, "vcn_enc_%d.%d", i, j);
-			r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
-					     hw_prio, &adev->vcn.inst[i].sched_score);
-			if (r)
-				return r;
-		}
-
-		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-		fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_SW_RING_FLAG) |
-					     cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG) |
-					     cpu_to_le32(AMDGPU_VCN_FW_SHARED_FLAG_0_RB);
-		fw_shared->sw_ring.is_enabled = cpu_to_le32(DEC_SW_RING_ENABLED);
-		fw_shared->present_flag_0 |= AMDGPU_VCN_SMU_VERSION_INFO_FLAG;
-		if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(3, 1, 2))
-			fw_shared->smu_interface_info.smu_interface_type = 2;
-		else if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
-			 IP_VERSION(3, 1, 1))
-			fw_shared->smu_interface_info.smu_interface_type = 1;
-
-		if (amdgpu_vcnfw_log)
-			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
 	}
 
+	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+	fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_SW_RING_FLAG) |
+					 cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG) |
+					 cpu_to_le32(AMDGPU_VCN_FW_SHARED_FLAG_0_RB);
+	fw_shared->sw_ring.is_enabled = cpu_to_le32(DEC_SW_RING_ENABLED);
+	fw_shared->present_flag_0 |= AMDGPU_VCN_SMU_VERSION_INFO_FLAG;
+	if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(3, 1, 2))
+		fw_shared->smu_interface_info.smu_interface_type = 2;
+	else if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
+		 IP_VERSION(3, 1, 1))
+		fw_shared->smu_interface_info.smu_interface_type = 1;
+
+	if (amdgpu_vcnfw_log)
+		amdgpu_vcn_fwlog_init(&adev->vcn.inst[inst]);
+done:
 	if (amdgpu_sriov_vf(adev)) {
 		r = amdgpu_virt_alloc_mm_table(adev);
 		if (r)
@@ -1132,192 +1130,188 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	return 0;
 }
 
-static int vcn_v3_0_start(struct amdgpu_device *adev)
+static int vcn_v3_0_start(struct amdgpu_device *adev, unsigned int inst)
 {
 	volatile struct amdgpu_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
-	int i, j, k, r;
+	int j, k, r;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, true, i);
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_vcn(adev, true, inst);
+
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
+
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
+		r = vcn_v3_0_start_dpg_mode(adev, inst, adev->vcn.indirect_sram);
+		return r;
 	}
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	/* disable VCN power gating */
+	vcn_v3_0_disable_static_power_gating(adev, inst);
 
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v3_0_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
-			continue;
-		}
+	/* set VCN status busy */
+	tmp = RREG32_SOC15(VCN, inst, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
+	WREG32_SOC15(VCN, inst, mmUVD_STATUS, tmp);
 
-		/* disable VCN power gating */
-		vcn_v3_0_disable_static_power_gating(adev, i);
-
-		/* set VCN status busy */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
-		WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
-
-		/*SW clock gating */
-		vcn_v3_0_disable_clock_gating(adev, i);
-
-		/* enable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
-			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
-
-		/* disable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
-			~UVD_MASTINT_EN__VCPU_EN_MASK);
-
-		/* enable LMI MC and UMC channels */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
-			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
-
-		tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
-		tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
-
-		/* setup mmUVD_LMI_CTRL */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
-		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp |
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
-
-		vcn_v3_0_mc_resume(adev, i);
-
-		/* VCN global tiling registers */
-		WREG32_SOC15(VCN, i, mmUVD_GFX10_ADDR_CONFIG,
-			adev->gfx.config.gb_addr_config);
-
-		/* unblock VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
-			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
-
-		/* release VCPU reset to boot */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
-			~UVD_VCPU_CNTL__BLK_RST_MASK);
+	/*SW clock gating */
+	vcn_v3_0_disable_clock_gating(adev, inst);
 
-		for (j = 0; j < 10; ++j) {
-			uint32_t status;
+	/* enable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
+		UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
 
-			for (k = 0; k < 100; ++k) {
-				status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
-				if (status & 2)
-					break;
-				mdelay(10);
-			}
-			r = 0;
-			if (status & 2)
-				break;
+	/* disable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_MASTINT_EN), 0,
+		~UVD_MASTINT_EN__VCPU_EN_MASK);
 
-			DRM_ERROR("VCN[%d] decode not responding, trying to reset the VCPU!!!\n", i);
-			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
-				UVD_VCPU_CNTL__BLK_RST_MASK,
-				~UVD_VCPU_CNTL__BLK_RST_MASK);
-			mdelay(10);
-			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
-				~UVD_VCPU_CNTL__BLK_RST_MASK);
+	/* enable LMI MC and UMC channels */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_LMI_CTRL2), 0,
+		~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
+
+	tmp = RREG32_SOC15(VCN, inst, mmUVD_SOFT_RESET);
+	tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, inst, mmUVD_SOFT_RESET, tmp);
+
+	/* setup mmUVD_LMI_CTRL */
+	tmp = RREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL);
+	WREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL, tmp |
+		UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
+		UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
+		UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
+		UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
+
+	/* setup mmUVD_MPC_CNTL */
+	tmp = RREG32_SOC15(VCN, inst, mmUVD_MPC_CNTL);
+	tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
+	tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
+	WREG32_SOC15(VCN, inst, mmUVD_MPC_CNTL, tmp);
+
+	/* setup UVD_MPC_SET_MUXA0 */
+	WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUXA0,
+		((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
+		(0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
+		(0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
+		(0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
+
+	/* setup UVD_MPC_SET_MUXB0 */
+	WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUXB0,
+		((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
+		(0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
+		(0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
+		(0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
+
+	/* setup mmUVD_MPC_SET_MUX */
+	WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUX,
+		((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
+		(0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
+		(0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
+
+	vcn_v3_0_mc_resume(adev, inst);
+
+	/* VCN global tiling registers */
+	WREG32_SOC15(VCN, inst, mmUVD_GFX10_ADDR_CONFIG,
+		adev->gfx.config.gb_addr_config);
+
+	/* unblock VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_RB_ARB_CTRL), 0,
+		~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+
+	/* release VCPU reset to boot */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
+		~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+	for (j = 0; j < 10; ++j) {
+		uint32_t status;
 
+		for (k = 0; k < 100; ++k) {
+			status = RREG32_SOC15(VCN, inst, mmUVD_STATUS);
+			if (status & 2)
+				break;
 			mdelay(10);
-			r = -1;
 		}
+		r = 0;
+		if (status & 2)
+			break;
 
-		if (r) {
-			DRM_ERROR("VCN[%d] decode not responding, giving up!!!\n", i);
-			return r;
-		}
+		DRM_ERROR("VCN[%d] decode not responding, trying to reset the VCPU!!!\n", inst);
+		WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
+			UVD_VCPU_CNTL__BLK_RST_MASK,
+			~UVD_VCPU_CNTL__BLK_RST_MASK);
+		mdelay(10);
+		WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
+			~UVD_VCPU_CNTL__BLK_RST_MASK);
 
-		/* enable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
-			UVD_MASTINT_EN__VCPU_EN_MASK,
-			~UVD_MASTINT_EN__VCPU_EN_MASK);
+		mdelay(10);
+		r = -1;
+	}
 
-		/* clear the busy bit of VCN_STATUS */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
-			~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
+	if (r) {
+		DRM_ERROR("VCN[%d] decode not responding, giving up!!!\n", inst);
+		return r;
+	}
 
-		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
+	/* enable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_MASTINT_EN),
+		UVD_MASTINT_EN__VCPU_EN_MASK,
+		~UVD_MASTINT_EN__VCPU_EN_MASK);
 
-		ring = &adev->vcn.inst[i].ring_dec;
-		/* force RBC into idle state */
-		rb_bufsz = order_base_2(ring->ring_size);
-		tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
-		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
+	/* clear the busy bit of VCN_STATUS */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_STATUS), 0,
+		~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
 
-		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-		fw_shared->multi_queue.decode_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
+	WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_VMID, 0);
 
-		/* programm the RB_BASE for ring buffer */
-		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
-			lower_32_bits(ring->gpu_addr));
-		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
-			upper_32_bits(ring->gpu_addr));
+	ring = &adev->vcn.inst[inst].ring_dec;
+	/* force RBC into idle state */
+	rb_bufsz = order_base_2(ring->ring_size);
+	tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
+	WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_CNTL, tmp);
 
-		/* Initialize the ring buffer's read and write pointers */
-		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
+	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+	fw_shared->multi_queue.decode_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
 
-		WREG32_SOC15(VCN, i, mmUVD_SCRATCH2, 0);
-		ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
-		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
-			lower_32_bits(ring->wptr));
-		fw_shared->rb.wptr = lower_32_bits(ring->wptr);
-		fw_shared->multi_queue.decode_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
-
-		if (amdgpu_ip_version(adev, UVD_HWIP, 0) !=
-		    IP_VERSION(3, 0, 33)) {
-			fw_shared->multi_queue.encode_generalpurpose_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
-			ring = &adev->vcn.inst[i].ring_enc[0];
-			WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
-			WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
-			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
-			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
-			WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
-			fw_shared->multi_queue.encode_generalpurpose_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
-
-			fw_shared->multi_queue.encode_lowlatency_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
-			ring = &adev->vcn.inst[i].ring_enc[1];
-			WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
-			WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
-			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
-			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
-			WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
-			fw_shared->multi_queue.encode_lowlatency_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
-		}
+	/* programm the RB_BASE for ring buffer */
+	WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
+		lower_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
+		upper_32_bits(ring->gpu_addr));
+
+	/* Initialize the ring buffer's read and write pointers */
+	WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_RPTR, 0);
+
+	WREG32_SOC15(VCN, inst, mmUVD_SCRATCH2, 0);
+	ring->wptr = RREG32_SOC15(VCN, inst, mmUVD_RBC_RB_RPTR);
+	WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_WPTR,
+		lower_32_bits(ring->wptr));
+	fw_shared->rb.wptr = lower_32_bits(ring->wptr);
+	fw_shared->multi_queue.decode_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
+
+	if (amdgpu_ip_version(adev, UVD_HWIP, 0) !=
+		IP_VERSION(3, 0, 33)) {
+		fw_shared->multi_queue.encode_generalpurpose_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
+		ring = &adev->vcn.inst[inst].ring_enc[0];
+		WREG32_SOC15(VCN, inst, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
+		WREG32_SOC15(VCN, inst, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
+		WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_LO, ring->gpu_addr);
+		WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
+		WREG32_SOC15(VCN, inst, mmUVD_RB_SIZE, ring->ring_size / 4);
+		fw_shared->multi_queue.encode_generalpurpose_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
+
+		fw_shared->multi_queue.encode_lowlatency_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
+		ring = &adev->vcn.inst[inst].ring_enc[1];
+		WREG32_SOC15(VCN, inst, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
+		WREG32_SOC15(VCN, inst, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
+		WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_LO2, ring->gpu_addr);
+		WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
+		WREG32_SOC15(VCN, inst, mmUVD_RB_SIZE2, ring->ring_size / 4);
+		fw_shared->multi_queue.encode_lowlatency_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
 	}
 
 	return 0;
@@ -1563,79 +1557,76 @@ static int vcn_v3_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 	return 0;
 }
 
-static int vcn_v3_0_stop(struct amdgpu_device *adev)
+static int vcn_v3_0_stop(struct amdgpu_device *adev, unsigned int inst)
 {
 	uint32_t tmp;
-	int i, r = 0;
+	int r = 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		goto done;
 
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v3_0_stop_dpg_mode(adev, i);
-			continue;
-		}
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
+		r = vcn_v3_0_stop_dpg_mode(adev, inst);
+		goto done;
+	}
 
-		/* wait for vcn idle */
-		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
-		if (r)
-			return r;
+	/* wait for vcn idle */
+	r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
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
+	r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		/* disable LMI UMC channel */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
-		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
-		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
-		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
-			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
+	/* disable LMI UMC channel */
+	tmp = RREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL2);
+	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
+	WREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL2, tmp);
+	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
+		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		/* block VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
-			UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
-			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+	/* block VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_RB_ARB_CTRL),
+		UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
+		~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
 
-		/* reset VCPU */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
-			UVD_VCPU_CNTL__BLK_RST_MASK,
-			~UVD_VCPU_CNTL__BLK_RST_MASK);
+	/* reset VCPU */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
+		UVD_VCPU_CNTL__BLK_RST_MASK,
+		~UVD_VCPU_CNTL__BLK_RST_MASK);
 
-		/* disable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
-			~(UVD_VCPU_CNTL__CLK_EN_MASK));
+	/* disable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
+		~(UVD_VCPU_CNTL__CLK_EN_MASK));
 
-		/* apply soft reset */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
-		tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
-		tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
-		tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
+	/* apply soft reset */
+	tmp = RREG32_SOC15(VCN, inst, mmUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, inst, mmUVD_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(VCN, inst, mmUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, inst, mmUVD_SOFT_RESET, tmp);
 
-		/* clear status */
-		WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
+	/* clear status */
+	WREG32_SOC15(VCN, inst, mmUVD_STATUS, 0);
 
-		/* apply HW clock gating */
-		vcn_v3_0_enable_clock_gating(adev, i);
+	/* apply HW clock gating */
+	vcn_v3_0_enable_clock_gating(adev, inst);
 
-		/* enable VCN power gating */
-		vcn_v3_0_enable_static_power_gating(adev, i);
-	}
+	/* enable VCN power gating */
+	vcn_v3_0_enable_static_power_gating(adev, inst);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, false, i);
-	}
+done:
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_vcn(adev, false, inst);
 
 	return 0;
 }
@@ -2177,9 +2168,9 @@ static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v3_0_stop(adev);
+		ret = vcn_v3_0_stop(adev, inst);
 	else
-		ret = vcn_v3_0_start(adev);
+		ret = vcn_v3_0_start(adev, inst);
 
 	if (!ret)
 		adev->vcn.inst[inst].cur_state = state;
-- 
2.34.1

