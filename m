Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3EAC021B1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 18:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4B7410E9D4;
	Thu, 20 Feb 2025 18:38:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GQgE2ZmM";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 423CB10E9D4
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 18:38:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIYWuatKx/06RafIio2ABN1Zq8BuLbBCfIfpAojUy8fR7CEJTsv9aRcKPy2JY4ORsiuRS5zFguBonrv3IROF7gztR5eRzyvRV+c4mIJQW5AISO8GXmMzGlWM0IqY3B+DWRcWKeFEv/rqUFlqo9H4kALpxuFUcOzJ12xRHB47nIy6P7xE4INMSbwTs8I6N2uXiz1MQpTScEJ8vf+CtCP45v3sPc/dptaj64/m+rIDavXQr7CBKkKPJrQCygatTJ+OL6d2A2RQkVdcHIq3p1RVEtJ7jfvcTZibFTroCQ1ufj/QPPaeqY+gSXPKd/N18BwlzUES8s2M48GKp/Y/bNu9Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlDx2PM7crh0ya+cZ8ZaL1Va/WboPrlFNSaGnL5JO+o=;
 b=wXXRosJnQzr8TS6lSPw1HLx4LPMuFMFZ30AnbF1Ie537+0Sxb8EopzGdgQ6wlAwligo/zEFQbN8xrnXMHFRtBS+hs84Jh+1DGErGXAe6qloIGn5MzGWmtjwPKTKiTFDMW1QVFdvPEg+2ecq4oSe0gNvDNNamp8TPc/ecB3GbJEQXfqKSkD6M3lmKDFcKKTy6B4EbNXBZvv4iCiClGFQg2xyPUSWedrsn+BnYjmJKirgN1uivf1gMQIch6K5b0279Y5P1ga0ynoFhcif2wAkSY81TMweIV/p856c7f74rAnWj95q9cTmKn2PqKMMHvilDXuo9NEXrpsInxgVBXnEu7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlDx2PM7crh0ya+cZ8ZaL1Va/WboPrlFNSaGnL5JO+o=;
 b=GQgE2ZmMRka0O8KO9kXku2j7OkICt44m3l10kt/p+7b+EmXuL4MTeD9nHAfuRH9KWmvqtzAkHu29bgRX3xTcvQrXE59KvfEWukVhbfiC9aJRr5WdNPudsZMKJoZl4a5gXVBsboxdthS18EUyyp/Xxt2xDHVZidqIkPNEcu2YeE4=
Received: from BYAPR05CA0064.namprd05.prod.outlook.com (2603:10b6:a03:74::41)
 by PH8PR12MB7447.namprd12.prod.outlook.com (2603:10b6:510:215::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 18:38:01 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::3e) by BYAPR05CA0064.outlook.office365.com
 (2603:10b6:a03:74::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 18:38:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 18:38:00 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Feb 2025 12:37:59 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Add ring reset callback for JPEG5_0_1
Date: Fri, 21 Feb 2025 00:06:53 +0530
Message-ID: <20250220183653.3000793-3-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250220183653.3000793-1-sathishkumar.sundararaju@amd.com>
References: <20250220183653.3000793-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|PH8PR12MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: cf38af11-f189-4cd2-12a4-08dd51ddb44a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0ZOV3NDd1JyRjFtQ1RSUlJ5L1Bkd2FPREtJU25aZzd0Z0JzWWxDOExuKzc0?=
 =?utf-8?B?RDZDUlVCcEgwOGM2cGZnSXQydk1NdHc4WEFxVyt3aFYwU28rUEVYMVcvMEtm?=
 =?utf-8?B?ZGd4cXlhaCtzRjEzY1JXNmhBMm1lN0k5L3pPNjJZNllDZHkxNjdGUGJITHBU?=
 =?utf-8?B?T1FFYjVKM3dlNW4xeWsyWmZ6WWRrM0NqandLaTFDOWNBUjgzd1hHRXZISTZh?=
 =?utf-8?B?YjVSZ1VjRDV6N2t0Ky9MTzJCemFob1ZpdUtjUkVZeFN3Y1dyQWY5VDYwMmxC?=
 =?utf-8?B?ZXhIUng5cWpSVTZtQmtTaHRXNWkrbFF2K3lPUHRWKzl0a0FHYjhSZFAxWUpV?=
 =?utf-8?B?NUdvMWVVQmVPaHZTNE1JNlE4bjdvbTI1Sm9hZUJFektKTkNISkJKM3VqRmYz?=
 =?utf-8?B?OWZaeVZZQ1c5NTdKOC9RMTBYdnNnRWxma09kZXhLTjNGWFFacDd5UkV0NDFJ?=
 =?utf-8?B?RkJLcTdiWThJTDBUSEhmdVMwYzhHL3BzNCtNRkxITkpPZWF5SGNCQjl5K0tn?=
 =?utf-8?B?a2ptVDFnWDlIYXdGVnNJeWFLK2xxWU9IY21MYnNzbUNEcEF1RC8wOWVHcWZs?=
 =?utf-8?B?cUNkeVZLU0VpdlMxNy9FVjJycEZlVU5JT282K1dMRWo4SU9ncFROOVQ1WmpO?=
 =?utf-8?B?SW8zeVU0Tlh1MFYvMUtqR2lHS3lkd0RkUU5vOTF4N2tVUERaeTNJUHU4SXR5?=
 =?utf-8?B?SjN1U1RPSGhNbHlTUEtqcndIOGRnczNZZlZkMVhhSkUyMkRoTVoxcTUzczl1?=
 =?utf-8?B?Q1hySEVCWGxWSTRoUjNuRlc2QjNtaVN1aWIrdkQvVkEzZ3RjamszMTdiVW1N?=
 =?utf-8?B?ZVpUcFUyMkdxaUZOb2xkQjhPSzJzRFo5QWtvTzVXeHZhNFVUTDRvWE5raXhj?=
 =?utf-8?B?VHpldXpnRUh2TkpKdnJqMzI2LzZtenBMZ2E2OEJuYTZWRDBvcjBWQnJIaUZ6?=
 =?utf-8?B?T3QwYkRMODFhMkVIUFZSUG91czUycTVjZy9wOFhVZUwzVlhIcW5QQTF6Z0t6?=
 =?utf-8?B?ZHY5YnNzSEtHY2ZZTit1ZTVEM3RxMmNjZFFBajFaOTVSL1EvenBJSkRJL0dB?=
 =?utf-8?B?S0xIZ2lXTGhQOGdkTVB0U3lpOXM2L24weFRtbjZic3p2dGpnRU5pV3hZSlpS?=
 =?utf-8?B?UG1Zby9aMFRKSWJRZkNTWFdsR0xNckFlVFNZV0FvbVA0elJFTjlXclNydE5u?=
 =?utf-8?B?b2JndFJaQVJYejcyeXlvSTNXZC8vVm9KOHdoSlR5REhRdVhIMFBpYjExR2Ni?=
 =?utf-8?B?ZjZOL01LbTgrRU5VR1prZWx1bXRQcTNpRmRwOGxNUW12Wk1JakRscStYOExU?=
 =?utf-8?B?dW9vM0p3RlBjdHp6a3FubjhrWk15M1MzYmlOWWdSblRDZVJKdXNyc2ZRMEpi?=
 =?utf-8?B?a1E4UXlqQTBRV3c5TVV4MHRQandNRmxIUzlCSzNIWk56cWRnYVU4TVFjdERQ?=
 =?utf-8?B?aVdpWDRqK1BTMkpCS1ZWUktBQk40eHkwa1RYb0FsbytJNGkyVDF2aVphL3Zz?=
 =?utf-8?B?VUJZNjZ6cGtCa1Y5eHVaenRBQVZudU12ZTM5Q3IxbWlTMFhqWXJrcXN6Q1Yz?=
 =?utf-8?B?NkFaZlJ2MTlSYU55U3VDelVEakQ1V0xyQTg3SW0xTHIxOHhkaWpKTXN4TDMx?=
 =?utf-8?B?SlhHSWNEb3UxaHVZZi95blhjbldwVnh5ZUNzTjBPYlBpeGNzR2ZhbU16dHI2?=
 =?utf-8?B?MkVvTDRHSklraWFIVU1aOTlyWkFxdndHQ1F2Y0hpZktxSlZma3pSby9UVXgz?=
 =?utf-8?B?VnFDc1FlQWwyRWVEZmhPcFdsWFB4SkU4b05QQzJ4THpTcitjR0F3eDZUM3ZQ?=
 =?utf-8?B?b28rZ3dUWXRONkFzdVhPMUtHdTZFbEpLdHhtMUJNVDdEL3k1SERlb1pid1ky?=
 =?utf-8?B?WEs4MWQvOWRUWXlOeVlNWVNRMUhtZEhqejJVMjhFY0pydkVnbEdzQ3Z4ZU1P?=
 =?utf-8?B?YVFueDFyeFJtZDFuMWZqSEN4TFdnQXFQSHQzdm1pcmRrbjdwelNBNFBtL1ll?=
 =?utf-8?Q?3UL1ikxXaUpSFH6Oi62HxEElWVgNlQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 18:38:00.9760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf38af11-f189-4cd2-12a4-08dd51ddb44a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7447
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

Add ring reset function callback for JPEG5_0_1 to
recover from job timeouts without a full gpu reset.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 50 ++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 07481cea55c2..b32eee5ab3f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -190,6 +190,13 @@ static int jpeg_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	if (!amdgpu_sriov_vf(adev)) {
+		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
+		r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
+		if (r)
+			return r;
+	}
+
 	return 0;
 }
 
@@ -209,6 +216,9 @@ static int jpeg_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	if (!amdgpu_sriov_vf(adev))
+		amdgpu_jpeg_sysfs_reset_mask_fini(adev);
+
 	r = amdgpu_jpeg_sw_fini(adev);
 
 	return r;
@@ -650,6 +660,45 @@ static int jpeg_v5_0_1_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void jpeg_v5_0_1_core_stall_reset(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int jpeg_inst = GET_INST(JPEG, ring->me);
+	int reg_offset = ring->pipe ? jpeg_v5_0_1_core_reg_offset(ring->pipe) : 0;
+
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JMI0_UVD_JMI_CLIENT_STALL,
+			    reg_offset, 0x1F);
+	SOC15_WAIT_ON_RREG(JPEG, jpeg_inst,
+			   regUVD_JMI0_UVD_JMI_CLIENT_CLEAN_STATUS,
+			   0x1F, 0x1F);
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JMI0_JPEG_LMI_DROP,
+			    reg_offset, 0x1F);
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regJPEG_CORE_RST_CTRL,
+			    reg_offset, 1 << ring->pipe);
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JMI0_UVD_JMI_CLIENT_STALL,
+			    reg_offset, 0x00);
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JMI0_JPEG_LMI_DROP,
+			    reg_offset, 0x00);
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regJPEG_CORE_RST_CTRL,
+			    reg_offset, 0x00);
+}
+
+static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	if (amdgpu_sriov_vf(ring->adev))
+		return -EOPNOTSUPP;
+
+	jpeg_v5_0_1_core_stall_reset(ring);
+	jpeg_v5_0_1_init_jrbc(ring);
+	return amdgpu_ring_test_helper(ring);
+}
+
 static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs = {
 	.name = "jpeg_v5_0_1",
 	.early_init = jpeg_v5_0_1_early_init,
@@ -699,6 +748,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_1_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v4_0_3_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v4_0_3_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v5_0_1_ring_reset,
 };
 
 static void jpeg_v5_0_1_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

