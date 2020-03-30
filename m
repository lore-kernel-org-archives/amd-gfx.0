Return-Path: <SRS0=xvO7=5P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C4EC43331
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 12:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3699420714
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 12:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1i7vyiJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3699420714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3F886E288;
	Mon, 30 Mar 2020 12:14:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 707CE6E284
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2020 12:14:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjMCUZLfn8WoLmTywYOvJuiKYOmmRIOsQ7uQYjP7e0GPIWM4PwotT8ZBz0re/NjeJr55PoWDw/42EIFc6lQ1hAHCPsoWoUjGodx/Xj4GGP5xxzsvKA74cvXjMbh/7yeDm62wmlrsgx+IQX6taFnhq429nh2NU801tPoW4WTD+NSTzOKadQ1D40JBH27Usk9+ZonC9QlrT+1X3aPP87lxRTfebx/V4rxMi8kg8ANj1eZPxP4rIarpZ4ULylMBgdEWrAu6XyoYaszAYRhNJwAgbTh7nFWtQ0zOhfKnDwpxCjf82FM/O+S3S+lIPD+qbfd37fQmwFehdpclYfH7YfYE5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3qW0NmQ/psOCLeUID13kZpVj/1NOn5DC6h0PKg8rUU=;
 b=UR4Go+sHroybwhzZDzmpS1UoYePQ4GR+s+XP875iB/weuXEaJyYT628PPjnMNAKTfvL3jO4qca+o+Sh6fcL2J/Fz+tsJjLE93PscM8NyCYSnxGAKVykXZsurPi0gVDzaQD4I8iAT0+Q3IzRqsnY8pUvryTp/wyniUANLGCPiwayuz6C3XqgFTwZ05K5sc0QZcCYojw5zsIrneY/Eeh27sV4oM0TrrU+yD9M317KS3dGiAMEFO4fhppDI/KtVBCUUD/21r5JY9TAeDxY8qL9OH5FzWu4s0HTHxcKiWAy8PiRAbQtWgomvl+q48wo2fS36c1Db7BG7UIuAZUykGc8TmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3qW0NmQ/psOCLeUID13kZpVj/1NOn5DC6h0PKg8rUU=;
 b=1i7vyiJ31jEGC+mo5M8bJaG2Z/tB+QhORvD+AnQEZ4y/h0ipZILzoHPJ3bLTXaBaeGiOxQk6UUJ1276NcMH3rusA+GqsoIJ17SSWWjCZ0blm71nuyakV4XkL7neXC3SLmZWgogKg3aH0KS5iZzMc65JWazqrmJLGNxrJvXfQTO8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB2358.namprd12.prod.outlook.com (2603:10b6:4:b3::34) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Mon, 30 Mar 2020 12:14:32 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::bcb9:8228:818:6129]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::bcb9:8228:818:6129%3]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 12:14:32 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/5] drm/amdgpu/vcn2.5: Add firmware w/r ptr reset sync
Date: Mon, 30 Mar 2020 08:13:38 -0400
Message-Id: <1585570418-13894-5-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585570418-13894-1-git-send-email-James.Zhu@amd.com>
References: <1585570418-13894-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTBPR01CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::15) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YTBPR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2856.18 via Frontend Transport; Mon, 30 Mar 2020 12:14:31 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6eba73a9-1068-4ec0-3b20-08d7d4a3e6f0
X-MS-TrafficTypeDiagnostic: DM5PR12MB2358:|DM5PR12MB2358:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2358A5366988A44C330C709FE4CB0@DM5PR12MB2358.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(66946007)(81166006)(86362001)(8676002)(81156014)(8936002)(6486002)(2616005)(956004)(478600001)(66556008)(66476007)(52116002)(5660300002)(16526019)(4326008)(7696005)(316002)(2906002)(26005)(6916009)(186003)(36756003);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m6l5bSa4yFw71gYcoaRs6G9rOC05WXhS/S3fjruDNf1qYzUjgFr2wD5nPOhR8KQBrzrYw2bsqJP5usXIVTKCv30IF9Fkt7wydV1KvsmAEZH/s3hECIMXX3+4q7WHz5GplqEP6TAieiMd3ImIeoHn6Z9oZ/3FQFpQy3QYJff/cg2y6DfAXo/KNAYjozu6f94bhwQuC2gUopQH1gN2FjoM/flZE1Fl6soJ+zsv4R2HtO3OFDKMVTw3xDaAJcYKq3V2IH6fQ1PdFTlSbXk3RVqJF3oKirodfzMY245mGq9G4eTWkLcQaBjPV70l0Zs7aoGZmAQ96+Ql7p+AAxotsKh2W1hyvK6BbUneMxdCexSkxfpk3MF3/jcx1CteCu1i4rLzuZnpbMTa9GCeY7Zpd8j5yx/pavWdPqKFb5CLZA2ODSgqDk7TOjzU2JksEJSfgJjn
X-MS-Exchange-AntiSpam-MessageData: Y4IcaEKJsOpKo8eAR8PBEuTWtdI8DQ4zfY9hJPrv6PM7d+6+uQ9A1npJxe2lWoVXj6bV/EL55jlJrBS/CP/Qa8dxdLU+gZnxVVgVzDNTk73Jmg5Yay+y4NXuiiaXB+mdTYJA8ftxdZV9vALtIM74Ug==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eba73a9-1068-4ec0-3b20-08d7d4a3e6f0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 12:14:32.1132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdclsEKQU6nqkvtTq3N3j2A+VrO4aXVGTnYGkDPF2c/1/3ZdcqaWK4tP9Zs0YKcE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2358
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add firmware write/read point reset sync through shared memory

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 51 ++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 7eb3b9d..6aef04f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -165,6 +165,8 @@ static int vcn_v2_5_sw_init(void *handle)
 		return r;
 
 	for (j = 0; j < adev->vcn.num_vcn_inst; j++) {
+		volatile struct amdgpu_fw_shared *fw_shared;
+
 		if (adev->vcn.harvest_config & (1 << j))
 			continue;
 		adev->vcn.internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
@@ -207,6 +209,9 @@ static int vcn_v2_5_sw_init(void *handle)
 			if (r)
 				return r;
 		}
+
+		fw_shared = adev->vcn.inst[j].fw_shared_cpu_addr;
+		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
 	}
 
 	if (amdgpu_sriov_vf(adev)) {
@@ -230,8 +235,16 @@ static int vcn_v2_5_sw_init(void *handle)
  */
 static int vcn_v2_5_sw_fini(void *handle)
 {
-	int r;
+	int i, r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	volatile struct amdgpu_fw_shared *fw_shared;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+		fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
+		fw_shared->present_flag_0 = 0;
+	}
 
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
@@ -424,6 +437,15 @@ static void vcn_v2_5_mc_resume(struct amdgpu_device *adev)
 			upper_32_bits(adev->vcn.inst[i].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE));
 		WREG32_SOC15(UVD, i, mmUVD_VCPU_CACHE_OFFSET2, 0);
 		WREG32_SOC15(UVD, i, mmUVD_VCPU_CACHE_SIZE2, AMDGPU_VCN_CONTEXT_SIZE);
+
+		/* non-cache window */
+		WREG32_SOC15(UVD, i, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW,
+			lower_32_bits(adev->vcn.inst[i].fw_shared_gpu_addr));
+		WREG32_SOC15(UVD, i, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH,
+			upper_32_bits(adev->vcn.inst[i].fw_shared_gpu_addr));
+		WREG32_SOC15(UVD, i, mmUVD_VCPU_NONCACHE_OFFSET0, 0);
+		WREG32_SOC15(UVD, i, mmUVD_VCPU_NONCACHE_SIZE0,
+			AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)));
 	}
 }
 
@@ -507,13 +529,16 @@ static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
 
 	/* non-cache window */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW), 0, 0, indirect);
+		UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
+		lower_32_bits(adev->vcn.inst[inst_idx].fw_shared_gpu_addr), 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH), 0, 0, indirect);
+		UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
+		upper_32_bits(adev->vcn.inst[inst_idx].fw_shared_gpu_addr), 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
 		UVD, 0, mmUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_VCPU_NONCACHE_SIZE0), 0, 0, indirect);
+		UVD, 0, mmUVD_VCPU_NONCACHE_SIZE0),
+		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)), 0, indirect);
 
 	/* VCN global tiling registers */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
@@ -750,6 +775,7 @@ static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev)
 
 static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
 {
+	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared_cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
 
@@ -883,6 +909,7 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	WREG32_SOC15(UVD, inst_idx, mmUVD_RBC_RB_WPTR,
 		lower_32_bits(ring->wptr));
 
+	fw_shared->multi_queue.decode_queue_mode &= ~fw_queue_ring_reset;
 	/* Unstall DPG */
 	WREG32_P(SOC15_REG_OFFSET(UVD, inst_idx, mmUVD_POWER_STATUS),
 		0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
@@ -972,6 +999,7 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
 	vcn_v2_5_mc_resume(adev);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 		/* VCN global tiling registers */
@@ -1045,6 +1073,7 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
 		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
 		WREG32_SOC15(UVD, i, mmUVD_RBC_RB_CNTL, tmp);
 
+		fw_shared->multi_queue.decode_queue_mode |= fw_queue_ring_reset;
 		/* programm the RB_BASE for ring buffer */
 		WREG32_SOC15(UVD, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
 			lower_32_bits(ring->gpu_addr));
@@ -1057,19 +1086,25 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
 		ring->wptr = RREG32_SOC15(UVD, i, mmUVD_RBC_RB_RPTR);
 		WREG32_SOC15(UVD, i, mmUVD_RBC_RB_WPTR,
 				lower_32_bits(ring->wptr));
+		fw_shared->multi_queue.decode_queue_mode &= ~fw_queue_ring_reset;
+
+		fw_shared->multi_queue.encode_generalpurpose_queue_mode |= fw_queue_ring_reset;
 		ring = &adev->vcn.inst[i].ring_enc[0];
 		WREG32_SOC15(UVD, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
 		WREG32_SOC15(UVD, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
 		WREG32_SOC15(UVD, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
 		WREG32_SOC15(UVD, i, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
 		WREG32_SOC15(UVD, i, mmUVD_RB_SIZE, ring->ring_size / 4);
+		fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~fw_queue_ring_reset;
 
+		fw_shared->multi_queue.encode_lowlatency_queue_mode |= fw_queue_ring_reset;
 		ring = &adev->vcn.inst[i].ring_enc[1];
 		WREG32_SOC15(UVD, i, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
 		WREG32_SOC15(UVD, i, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
 		WREG32_SOC15(UVD, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
 		WREG32_SOC15(UVD, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
 		WREG32_SOC15(UVD, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
+		fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~fw_queue_ring_reset;
 	}
 
 	return 0;
@@ -1390,6 +1425,8 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
 
 			if (!ret_code) {
+				volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared_cpu_addr;
+
 				/* pause DPG */
 				reg_data |= UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
 				WREG32_SOC15(UVD, inst_idx, mmUVD_DPG_PAUSE, reg_data);
@@ -1405,6 +1442,7 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 					   ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 
 				/* Restore */
+				fw_shared->multi_queue.encode_generalpurpose_queue_mode |= fw_queue_ring_reset;
 				ring = &adev->vcn.inst[inst_idx].ring_enc[0];
 				ring->wptr = 0;
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_BASE_LO, ring->gpu_addr);
@@ -1412,7 +1450,9 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_SIZE, ring->ring_size / 4);
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
+				fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~fw_queue_ring_reset;
 
+				fw_shared->multi_queue.encode_lowlatency_queue_mode |= fw_queue_ring_reset;
 				ring = &adev->vcn.inst[inst_idx].ring_enc[1];
 				ring->wptr = 0;
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_BASE_LO2, ring->gpu_addr);
@@ -1420,9 +1460,12 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_SIZE2, ring->ring_size / 4);
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
+				fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~fw_queue_ring_reset;
 
+				fw_shared->multi_queue.decode_queue_mode |= fw_queue_ring_reset;
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RBC_RB_WPTR,
 					   RREG32_SOC15(UVD, inst_idx, mmUVD_SCRATCH2) & 0x7FFFFFFF);
+				fw_shared->multi_queue.decode_queue_mode &= ~fw_queue_ring_reset;
 
 				/* Unstall DPG */
 				WREG32_P(SOC15_REG_OFFSET(UVD, inst_idx, mmUVD_POWER_STATUS),
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
