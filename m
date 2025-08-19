Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B3DCA0EF5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Aug 2025 09:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA83610E552;
	Tue, 19 Aug 2025 09:18:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gl9IR254";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA47D10E572
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 09:18:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWXQK2CNyaesJ4XjqWg0x3UOgoqDxksNvkF8XQ7d+Ro741KQb8NR8dwswrLs0i5Nfby0KYeLScRuU1SH4Fkbbr0P182vC+r0CQI8cHZbX9CDWQ3SsFdgX3xEl00pceZph23pXwwKoHUjxa/KtK6kYiV4fD1y46PzH5SAfF+GbcuuFIbleYOjGbZkNScm0I7UUbdL+xdYft3vK+Y9DKOwtbuB0grDHk6IwmBlN3IeQpxaHX7jAkmodLtNHrMFIsSltdvKY2U9M9qoJ/sMNdWFgaN+B6ZUfxR7Ix4JZYXTi2ALi0wjvpwOaO9YO+KHqXshZXeZ3To8RyjfEE0342iOdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6u2sd3k0GnSVoYE0R8opNh1FDegPGZGRzbmA6FI5uRo=;
 b=i7769bx6tE2FpIUHPPeM6fsTKjexXZRbbSaFEMpu3drl3Gb8+lip/Hen2fQfmzUY8VHOm7CTOLKfObOgBUZ5GGt5OlCogRh1PCWaWqujI9XEOAo6UNq4HZJSfRxoDpW438LbTx22dbob4vhM7165GmJNhAvIlKApBb9hb+AXAC3GSblI+VhZ5xGFdar3Hrtz9SpMs9sAt758RuCoFmldF3g5L0L7D3MK5AOtCZilauNATLzuvVQVlM12RewFOuJxxH68RulIYUNOxDgmaZFoWZ5WpsFOcefHc1ZQFabZfkDQQxA62CGCKAc8CzlUiaFAsmMCr/saRJtWdD9J3UMW5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6u2sd3k0GnSVoYE0R8opNh1FDegPGZGRzbmA6FI5uRo=;
 b=Gl9IR254o2z3OARmQhPD+k5K6Loseraj/9XQRPxb+UlmKtf42bJ+AQfnSnWCaB4FBaoqmVhYJ77mzEbb3TzHJiMU2PYY5pkor4Xjojro8gqrHT5TEDCH1b6xmBuoThWnxPsvefyMKzJ2YzuEOzhV/6BmFLKMdukOqNkbqMIkG2I=
Received: from MW4PR03CA0281.namprd03.prod.outlook.com (2603:10b6:303:b5::16)
 by SN7PR12MB7856.namprd12.prod.outlook.com (2603:10b6:806:340::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 09:18:11 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:303:b5:cafe::48) by MW4PR03CA0281.outlook.office365.com
 (2603:10b6:303:b5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Tue,
 19 Aug 2025 09:18:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 09:18:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Aug
 2025 04:18:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Aug
 2025 04:18:07 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 19 Aug 2025 04:18:05 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>, Jesse.Zhang
 <Jesse.Zhang@amd.com>, Ruili Ji <ruiliji2@amd.com>
Subject: [v2 2/5] drm/amdgpu: Add ring reset support for VCN v5.0.1
Date: Tue, 19 Aug 2025 17:17:06 +0800
Message-ID: <20250819091802.445099-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250819091802.445099-1-Jesse.Zhang@amd.com>
References: <20250819091802.445099-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|SN7PR12MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: ef97d13f-f752-482e-2290-08dddf0150ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CE/3Z55aIacUTKA6dfqPcUbTlXX5OMhEfmklL0C3oJYZ3ZPzruHkdHS+8Qfe?=
 =?us-ascii?Q?cXlagNxzjSn3bS3fzjEEnweCLvNZYkIEdMtj0kj4THor0/ShyVYPWENzYXC6?=
 =?us-ascii?Q?obLUg9tzNH1b/na0MxyzxVriM/8J6Adf9pcC5qjndIWkMwLUqq3VGDR9DrOJ?=
 =?us-ascii?Q?DOImd1EjWrqQIizf+h1JI4PfCHu6377xSoxfHZT5nhnQiWyuwQC9zGFkL6qf?=
 =?us-ascii?Q?fY7pdaDppgShzko7/XzTAuMd4pP8NHiAjFzrGMdPFaDY0OtpSlZXlNclxxtt?=
 =?us-ascii?Q?e0UvCvzjNkmj1Xg5pQ7anuxaZUscyq5fM/GxG+kge/FanPTox7DJDsW/Z/2A?=
 =?us-ascii?Q?ygzlYV/gFT/WFE9h7XYSA22f6r87zwA+XqqJNiNClBrp2KTuvvKouYMC94Ne?=
 =?us-ascii?Q?b15uXaREzl3M1ErXaNQJaVoK/oKBpJSRbpe6pYHMCVtniXFoISs+MNI/oKCb?=
 =?us-ascii?Q?Cx4wTGEoCml5gQCEFhmi3v6viY+R9xkAaYqC5eP6GsSS/PbclIMoLyF9eH6S?=
 =?us-ascii?Q?y9IkSAidhVon6VyofYZBbKJNtSAfM+wMYHuKP+gsxOrrDqCkG51vVCSkHHt7?=
 =?us-ascii?Q?/2kbd/nDud63mZFjq3VhwXlxLvqwOf1IKoveB3Gu+I0FMmbCpNAycIw1scwS?=
 =?us-ascii?Q?P8Hu22T08SpYH4Ny15q24cjxknA/MSg9n0Bs307vKPkuUOpFnJ9/3zS/D0Py?=
 =?us-ascii?Q?VeiPAGkUZW3lxAfKizsG7Qp+BGdASdJMHdD7S8ewtmHD+z6YlEJubxyLXgqT?=
 =?us-ascii?Q?qkqsvdksMcC6hhOMKbfeYDZ5A4hRJ3IUrJFaPpzo4c+OLLw4A3L3NPgsnoyb?=
 =?us-ascii?Q?VNjnVCrqik+Z9cZUg/MRMLuHtnrRkIXRpAwbOScgMojkgx7MOHFiKBB1AsVK?=
 =?us-ascii?Q?EXlftMpySzMnRmTBfzdhEvcUewCveVNUjKBozRfHZoEy5wy+AAg9rRREs8Bt?=
 =?us-ascii?Q?4vmjRgznT0rAqN580UObLPRVcWaI1zawZj4yzqLaPWNDcMCYXgdfBVE7fanP?=
 =?us-ascii?Q?OaH/kTtTauDrQ9OOSh+GHny71/9zMQm4f2twgZ+JTEm8CfHO6BMzTEs87nX3?=
 =?us-ascii?Q?yZhYSWvswpOrLDQc7sq2EYqR9acSSHL5i1v7lHLSTTQG+pgb+Nv4HWb/ipke?=
 =?us-ascii?Q?avW9dUV1qDdq2ApQXMR9KqsZv8E/r40WuJ30NL9YTxzJqTp84xG6TO4p5Uhy?=
 =?us-ascii?Q?3Gq54Fp8fCiHZH4hMQHTwR0vD35TzFdT29zpWgP47npc8RlfhQNPGxmlIY5r?=
 =?us-ascii?Q?qM59ERJj6aB0o+VAo4RDMYB5KYex5mS9HCAcOUnGbZzZ2fYr2vS16loN2QRI?=
 =?us-ascii?Q?9TKW1SPjzP2Otq+NosOhY92QwyA5d2h0GzqbeEKpBt/JkNu+eYNY8bXt30LS?=
 =?us-ascii?Q?24r/PBukKGiIqGPEQV2LYN13E66E+kP0occJAvbgjJRcnAP55tUckGCApPFo?=
 =?us-ascii?Q?FLNkdt5yucuEVHcHuCYVww7vNZ+5gONRoJuE8IPN1I7A+gO7esaYkzy9OsOs?=
 =?us-ascii?Q?8XAsNcS/p8hwSbtBlu5M5PhiDvuUKqXgiDfX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 09:18:10.1279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef97d13f-f752-482e-2290-08dddf0150ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7856
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

Implement the ring reset callback for VCN v5.0.1 to properly handle
hardware recovery when encountering GPU hangs. The new functionality:

1. Adds vcn_v5_0_1_ring_reset() function that:
   - Prepares for reset using amdgpu_ring_reset_helper_begin()
   - Performs VCN instance reset via amdgpu_dpm_reset_vcn()
   - Re-initializes hardware through vcn_v5_0_1_hw_init_inst()
   - Restarts DPG mode with vcn_v5_0_1_start_dpg_mode()
   - Completes reset with amdgpu_ring_reset_helper_end()

2. Hooks the reset function into the unified ring functions via:
   - Adding .reset = vcn_v5_0_1_ring_reset to vcn_v5_0_1_unified_ring_vm_funcs

3. Maintains existing behavior for SR-IOV VF cases by checking RRMT status

This provides proper hardware recovery capabilities for VCN 5.0.1 IP block
during fault conditions, matching functionality available in other VCN versions.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Ruili Ji <ruiliji2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 21e48df537bd..3b6c5bd8abdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -1289,6 +1289,34 @@ static void vcn_v5_0_1_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
+static int vcn_v5_0_1_ring_reset(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *timedout_fence)
+{
+	int r = 0;
+	int vcn_inst;
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
+
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+
+	vcn_inst = GET_INST(VCN, ring->me);
+	r = amdgpu_dpm_reset_vcn(adev, 1 << vcn_inst);
+
+	if (r) {
+		DRM_DEV_ERROR(adev->dev, "VCN reset fail : %d\n", r);
+		return r;
+	}
+
+	/* This flag is not set for VF, assumed to be disabled always */
+	if (RREG32_SOC15(VCN, GET_INST(VCN, 0), regVCN_RRMT_CNTL) & 0x100)
+		adev->vcn.caps |= AMDGPU_VCN_CAPS(RRMT_ENABLED);
+	vcn_v5_0_1_hw_init_inst(adev, ring->me);
+	vcn_v5_0_1_start_dpg_mode(vinst, adev->vcn.inst[ring->me].indirect_sram);
+
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+}
+
 static const struct amdgpu_ring_funcs vcn_v5_0_1_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
@@ -1317,6 +1345,7 @@ static const struct amdgpu_ring_funcs vcn_v5_0_1_unified_ring_vm_funcs = {
 	.emit_wreg = vcn_v4_0_3_enc_ring_emit_wreg,
 	.emit_reg_wait = vcn_v4_0_3_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = vcn_v5_0_1_ring_reset,
 };
 
 /**
-- 
2.49.0

