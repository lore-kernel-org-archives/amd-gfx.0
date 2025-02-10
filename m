Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D66C0219E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 14:26:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E9EB10E55F;
	Mon, 10 Feb 2025 14:26:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j/HCtXST";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9634110E55F
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 14:26:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6oEQQr+A9Rjm69b7bd69xnOuZD2GOG3GIvIPMQ6t8LgWBo4eNSCkPx83/bFj7D41n2Xcp0inWnp0MX/yeW3tSlUxGgb9WbdQCkf5/6OHHLTdk0z6lOK5IzTxAA9lkN519l11roxIBTWCaoshb0ym0uHXlQ6EAkIRh8WNC+aqg5ij0AGy9D+IkGgWVyslFE4/7M0AgcjuQUckHevLBwpn32HOGbchO2aPRyVSVcB40c7dd+42nTVml9adn83x3Ifge6jBklmU34n7mhA0rS6u2g8bGlfXTCoARLff38jTX/qa83vmg3qcSG1dRwEG1G7Ne1hG2ga2geNodPxqYoTJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2dtlltnnOdLDpt9x3Hshl5rZspALsZDJkDi3bOig8U=;
 b=hzZFFZO/Qcnzgdm+MrzPURAifNEC9bsU2sc8gUMQKsSgKeU7ovuk1GrRFG7tjPbDod6egMmPIlD8+bvOcH0T8qLFDY6p/EwldZY7v3yc5KudB34BsSUnYy/bD+BS+XdSSOuUlWyYXXKbKgp0OC+khRlfhOPOR4FKXDnXkHnz4Z9ewXAJe/PfiZZYUMRxJ5+wUa/eNnaQZeuHRt7auA47r5FHaxep9IyvEPN49zysdeJC8Cvfg8thfZ7rRjMxH9pyo4TSh0j+cLNutxAv/rNXxShpCOds9tkhvaawdNUiX/9/I8w23s6GUZPl/ZLTrt5fj9L4rRKImMDRFTr0zDBWIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2dtlltnnOdLDpt9x3Hshl5rZspALsZDJkDi3bOig8U=;
 b=j/HCtXSTg+Xe5C6+9rVWn4g0Tq+lKHZcno7oBZ1HJjPGeJIeHYbXInvSYTobjAmWXRKCy0oAQmxSFg4xBz7Fy1RV5JunC/wNjv5rS6wFv0jkT37e5Zqi3vAGKZ/ItzVatdQb/d0khMAsVVBrgl6Z26gWYDJap4kc/X0lDWs/BjE=
Received: from MW4PR04CA0244.namprd04.prod.outlook.com (2603:10b6:303:88::9)
 by BN5PR12MB9512.namprd12.prod.outlook.com (2603:10b6:408:2ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 14:26:36 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::11) by MW4PR04CA0244.outlook.office365.com
 (2603:10b6:303:88::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 14:26:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 14:26:35 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Feb 2025 08:26:33 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>, 
 Koenig Christian <Christian.Koenig@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH v2 2/7] drm/amdgpu: Add ring reset callback for JPEG4_0_3
Date: Mon, 10 Feb 2025 19:55:43 +0530
Message-ID: <20250210142548.2321625-3-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250210142548.2321625-1-sathishkumar.sundararaju@amd.com>
References: <20250210142548.2321625-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|BN5PR12MB9512:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e9c925-a68d-4802-6367-08dd49deecb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dCtacSs0TkhBbHlsTnVJSnlGTEFBT0JFZCtic0hmTVMzeGRFaTVodDBtL2FZ?=
 =?utf-8?B?VEZFZTRuekdQVGJnencrVUpOUU9UMWx4d21yMkR4VUhXcDFlOUl3VGE3VmtX?=
 =?utf-8?B?MFBpeUEzZEtST1BwQ0RQQkZPbEtkSlFRYVRRUG1XUGtBMXg2dDVhNU9taHJG?=
 =?utf-8?B?R3pCMC94VE9nOTQySk5sOW4yNTg0d3NOa2wxRjYrb2dkWjhyVUVxeTBxVFRl?=
 =?utf-8?B?cWlMRmRDOXI2SzNrTm53OW9zc2hvNjJ2bkhBTVptZDcrY2gxR05OMVJvN3Zs?=
 =?utf-8?B?b3VhRWZlNE9FM1dEdmVWeUg1RzNhYXpEbFFuNXA0YUw4TTlTN0dlblhEUG5D?=
 =?utf-8?B?U0F5V002RC9QcFZlaUtJUEFSZi9GVjlKSWlrVW5tRUdMRDFjU0RFZjFFczMr?=
 =?utf-8?B?ZGlSK0VMYkNWMTJPeEJkMWJON1Z5bUpjVCs0ZWo1YUhxOG9PbXZFRUQ1cDU0?=
 =?utf-8?B?UDN3VTZ6TWxUTFp6dkpldXVkNU91akQ2Z1gwQUVmbTI2TVhVV3NwMGZ3WXUx?=
 =?utf-8?B?TjlhbTF4UW1Yb3R5U29UQ0p0UVJqbkFsNmVLQ1NuYnorWUhKVHZ5Q25yQW9J?=
 =?utf-8?B?QjNLc0gwMmpKQjVCcHFBSExMQzVsRm1pTzBuMWtOeFdwdFg4Y2I1UGNrYXU3?=
 =?utf-8?B?R25UWHFSblpZVCt5UHFMTk4wNkRXalEzYyt3RVhjYjJRT21sakJGaTFsOU5R?=
 =?utf-8?B?Z1pXeVNldS9ZNC83SkRCUDVIemNFY3k2aGxtYnVJWmRxUTZxdi9vYndoZERK?=
 =?utf-8?B?S25pRTNqVmp6MnN2OTBGTjJCY1ZKUHZzYVlJQmF6OFRFaDZzWEY4VGc1NlJl?=
 =?utf-8?B?THhSTlg3Vm91aVUxbUlDeTNuOTVZWHNrREdsWDB6dWNOVDAvbGFqN3h5Nitr?=
 =?utf-8?B?ZDlyRS9LbTEwL0Rncm9OU2wyb1prUm5lOW9kYjJGdUs2SDdkWTVSK2FhSndS?=
 =?utf-8?B?Q3AvbHo0NnhpUWo5NkU0bFFHWm1vdFBGV3dGRHN4Vy9ieGxxcEU3bUx2eXBs?=
 =?utf-8?B?MXJOUmJndXBqMDVkcUhMY1JLeCtBNmFVWXQ3eVMvK2RDWkRwSmVXSWd3M3A4?=
 =?utf-8?B?UzNPQXB0ZzVjV1IrU3pJaVhiU3l0bTBkaEFQN2NhVTN2MGZVYVVQU2RtQkVE?=
 =?utf-8?B?MFJPWHRUbDA0NTh6d2M5K0ZPakd1UUc2aTlqMFd0T0FSR1I0eTBScmtXbFB2?=
 =?utf-8?B?SFgyd3BSdHBBaWQ4dnFjeUNPQzIwZ1JhQmY5YlY3RVRldjFpZ01acFJyRUlE?=
 =?utf-8?B?VGxkWkE3bnkyVFhHWmQ5WGpudmZyc3JIVGtCQnowWUd5cDA2VVAyaWFHVTN0?=
 =?utf-8?B?L3d0bVhxZjkzdnQ2dCtuREorSVZtZlY3QmVVK2JBK3RQODVNbjhGWWxHVXg3?=
 =?utf-8?B?RVFGWUMveDZhMTNRMmhORmdBaFhvYml2TGdsU1dQcTcxWk0yNjZ5eXFTZERF?=
 =?utf-8?B?bnM2MDA4S0NpZnpNcG01WlJUMFdwMXRkVjB1a1NnRFVwYi9xTEkrQ1hLTEdV?=
 =?utf-8?B?bnRYMkQ5N2VtaTlLZ2loVk9tWUwyUUJxd01wek9XNGJKRWN0NDUrcnBwUXlm?=
 =?utf-8?B?MXhqcm9zU0ZpSnpsN1Btd3NvVU5uY0Y1VStsbDBNaGc4ckRvcXF4M1Zsb2Js?=
 =?utf-8?B?SFFNcVdwU2swUUZKbFZTWGNZMkEzOFVrUjF3eTQzNUIwZy9NSXNHa3ovc2Iz?=
 =?utf-8?B?UjRNMHFReURvQ1g5bUpnd1lXQ1dJMC9NNWtzVVMyT3NuWVQ4TXZsS0M4amFh?=
 =?utf-8?B?U0syWmVWeGxyN2kwN2d4Vks1dkxuUWx4SEhXRzlobEs2NXh3TFYxYW1tUXA0?=
 =?utf-8?B?RHNsamR1S3B5YStqODNWQ0I3NlFnZlEvdkVRc2JyQkdmQ2gyaHJNT1gwT1JL?=
 =?utf-8?B?alFUeTNoQ3RPVXJYNTF6RWhEUlZtazNhNTlQb0xVKzVzVG55bEtENUVnMFpj?=
 =?utf-8?B?eHBKZWZ1Y0YxRFVDL05ENGpZL3Y0cFdaZFIwV2pZdGhYZlRydExIRGhCSXI1?=
 =?utf-8?Q?tYEuFluK2kXosMXtFvFhCAuXLnSzFY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 14:26:35.8055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e9c925-a68d-4802-6367-08dd49deecb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9512
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

Add ring reset function callback for JPEG4_0_3 to
recover from job timeouts without a full gpu reset.

V2:
 - sched->ready flag shouldn't be modified by back-ends (Christian)
 - use drm_sched_wqueue_stop()/drm_sched_wqueue_start() instead (Alex)

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 69 +++++++++++++++++++++---
 1 file changed, 63 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index be0b3b4c8690..b6168f27addd 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -204,14 +204,10 @@ static int jpeg_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	/* TODO: Add queue reset mask when FW fully supports it */
-	adev->jpeg.supported_reset =
-		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
+	adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
 	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
-	if (r)
-		return r;
 
-	return 0;
+	return r;
 }
 
 /**
@@ -231,6 +227,7 @@ static int jpeg_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
+
 	r = amdgpu_jpeg_sw_fini(adev);
 
 	return r;
@@ -1099,6 +1096,65 @@ static int jpeg_v4_0_3_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v4_0_3_wait_for_idle_on_inst(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_ring *r;
+	int ret, j;
+
+	for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+		r = &adev->jpeg.inst[ring->me].ring_dec[j];
+
+		if (ring->pipe == r->pipe)
+			continue;
+
+		/* pause work submission on this core */
+		drm_sched_wqueue_stop(&r->sched);
+	}
+	for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+		r = &adev->jpeg.inst[ring->me].ring_dec[j];
+		if (ring->pipe == r->pipe)
+			continue;
+		/* wait for idle on all cores except on the hung core */
+		ret = SOC15_WAIT_ON_RREG_OFFSET(JPEG, GET_INST(JPEG, ring->me),
+						regUVD_JRBC0_UVD_JRBC_STATUS,
+						jpeg_v4_0_3_core_reg_offset(j),
+						UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
+						UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_ring *r;
+	int ret, j;
+
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
+	ret = jpeg_v4_0_3_wait_for_idle_on_inst(ring);
+	if (ret)
+		return ret;
+
+	jpeg_v4_0_3_stop_inst(ring->adev, ring->me);
+	jpeg_v4_0_3_start_inst(ring->adev, ring->me);
+	for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+		r = &adev->jpeg.inst[ring->me].ring_dec[j];
+		jpeg_v4_0_3_start_jrbc(r);
+		ret = amdgpu_ring_test_helper(r);
+		if (ret)
+			return ret;
+		else if (ring->pipe != r->pipe)
+			drm_sched_wqueue_start(&r->sched);
+	}
+	return 0;
+}
+
 static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
 	.name = "jpeg_v4_0_3",
 	.early_init = jpeg_v4_0_3_early_init,
@@ -1145,6 +1201,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v4_0_3_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v4_0_3_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v4_0_3_ring_reset,
 };
 
 static void jpeg_v4_0_3_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

