Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E83C021A9
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 04:53:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAB7010E5E9;
	Tue, 18 Feb 2025 04:53:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0MiBV2Yd";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96CE710E5E9
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 04:53:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XuW3uu5lwHQKBV+QukruTNdEutW1E+Tq6R3cOaFwTd7IBv7Pbr/DpQPxxO0UZOnwWCTHEI0zKWsqkddj2DeJtDxjui1YJE/q0MCv9z/J1WLT/Ipjz26h711UrTLFlrMZH/VQP0tA2CwOJya54PImcN6E3x8qeP1jhsIa3JoZ5rnosoGrAYV9CvgapBijEdSOQJvqp53NUbxov4RZ9W0RwoTpsdDS1iRletzTHZJeYPQi4OuJQz+XYTN3STXBLwuxvBQTxqL4k3fCizQ9nN3ImtLN2mlLgN+7fhuN27oNfxn9Bd12E9C1Yd3znoxUTknMVRBeWiXo1IpRZsTsiYeX0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkQBBda5FWRZsTOGrDFWgr5NKQgptQdbDAnDVndpMB4=;
 b=Y70qMoV6HybeOc/LXOxvytEJyU5hRvhSLoqBqnMChSREAbYXkYIEWWJ+Ogt6vjIe8471i1wSKsL8bKDFYRy6gTlDFZGs6CsBQhV8+foG4hzS5gbKjmN44MABP7YoXFect29nWVgW6iTZUKZ6vdq1++GyAlfNeio2kUYdlYQ7qqdgpz7mSRH5HBXqOnZ3WTRxT0iGIclbRrPY5rVQMNHLe8Qq2/TX2budpeuWORa73BpgQwWPKNklAzwOfRtHL3XT0rB/BkZzDrB4m3AX/H8jVS5ek1jMM59uVJG4KxeofK9YBD5grhWDr+Ynw2q/5mbuWVSY8uQzLvNZM7yLRH25ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkQBBda5FWRZsTOGrDFWgr5NKQgptQdbDAnDVndpMB4=;
 b=0MiBV2Yd9wC+jinKwr3XUrM4mOwTU7ndu6p8ChwdT3Rb70JbUx1+ZVeJxVUF/rwRajfrYnUkkdRvzwpEIwKSYag2zjS20ovO2+nK8Hu91mB/Y+9/+PMmQqpMgioYsfbAZE/0N0vnxJwvG6OA8RJ6PhP2AAOtapKnvzQKUbLb3NE=
Received: from BLAPR03CA0029.namprd03.prod.outlook.com (2603:10b6:208:32b::34)
 by DS0PR12MB8044.namprd12.prod.outlook.com (2603:10b6:8:148::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 04:53:39 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:208:32b:cafe::74) by BLAPR03CA0029.outlook.office365.com
 (2603:10b6:208:32b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Tue,
 18 Feb 2025 04:53:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 04:53:38 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Feb 2025 22:53:36 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Leo Liu
 <leo.liu@amd.com>
Subject: [PATCH v4 2/2] drm/amdgpu: Add ring reset callback for JPEG4_0_3
Date: Tue, 18 Feb 2025 10:20:58 +0530
Message-ID: <20250218045058.2478917-2-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250218045058.2478917-1-sathishkumar.sundararaju@amd.com>
References: <20250218045058.2478917-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|DS0PR12MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: e50b5499-b92e-4c25-f240-08dd4fd835a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXdMdkpLK1ZlS1dKVVgzaWNNYUxwaWowK0l0VTZjTVdZOTZJU0ZlSXllL2tJ?=
 =?utf-8?B?WXMxcTBVUmxxZ0hNb2hJNEI2eGlnamdpclpWWnFnNGRzTkpIUEJuQWJ0bkMx?=
 =?utf-8?B?Y05ta3ErSVo5MWwzRFJSY1RYS1Q1dmhuTU1DSnN5cUtkWU41c0ZaNGtSUGpZ?=
 =?utf-8?B?bnlwcTZqV09NdDBPNmtiNHY3NVZlVzArQmdZaU1UdDQzZ0hjL0RUNisxNW0x?=
 =?utf-8?B?dkUwRncvUG9sOSttOUkrT1dmOUpyb1VVNHk5bzJjbTFqVUZEMlFZSlBMU2sz?=
 =?utf-8?B?dzFndWF1MWxtbURZMld0QXhCYzYxcFRpSTNlTGpWLzIvdlVPTXJrYW50L2lp?=
 =?utf-8?B?UytlYkp4VSt2RFRGL2t1eWlPd0xFQXQ4Z0VPcXFYY3IyU29yK1VOSzA4am42?=
 =?utf-8?B?UDU3bjFFY2EyR051YUJ1bCtHaWxqMHJicVRGa0dybzI4QU5xTFpRR3lPZDhU?=
 =?utf-8?B?dVJLRHlPQjRxYUUwdTVOanRySVgzTHpiWmtDUGtYSjF6K2VveTdrM0VxbWkv?=
 =?utf-8?B?ajdWWnBtSU5OZXMvcmk1OE1wWWFWc2MySGxvK2N2aURFUUgrOFEzQ25TZS9L?=
 =?utf-8?B?S3o5eUZuQU9hTURzK0pVOXV6S0RMRmJBVERIbzE0d3NzVTRWc2xzRWJxYVZh?=
 =?utf-8?B?MjlkaThydjV3T2xWd05zT09FWHZ5Yk81ZTY0dWZEeUVEajJVZXI5TjNhNzhR?=
 =?utf-8?B?VkFRLzgwM3ErUU8zZGxTcUxMY3pvT2FLQ1laS3dEd0Z6ZmptWU42bGNwMlFs?=
 =?utf-8?B?TDEwYjlhWDJDdVhRclBtZ3Q2VGJ2YjA1Q1hyUWNpOGZBWTIyMHdUYm1XWUt2?=
 =?utf-8?B?RmhvTzNUWjV1S2FOTDludVpic2JsRndmcTRBUzI5dDF4RWdhRFBSV0lnQTI2?=
 =?utf-8?B?U0pJT3llUWY3bWRZL1k2Z1ZZQ3dFR2lrdmc1Y05FekZDaGNhRHYzUFBzM3dJ?=
 =?utf-8?B?T09QaFYyVWhUN1pwNW5Qc1FsVXhIaDhZNnNMOUdDWHI0UlVyTmlUTVRqMXhi?=
 =?utf-8?B?YmhFY1FoM3N0ekU3WGhZUU5hYWlmdlcxLy9FeHdEMlhkNlFqK3ZDNTF6Wnpn?=
 =?utf-8?B?alArYTVHN21JWUx3bEg3Y0V0dHFxd2hlNGprZ09td2l0SDR0VU5RTWJjZk5S?=
 =?utf-8?B?RFZFaDN6VE10MjNLUEt2TVZ5bmprcXQ1b1FqUUxMSTRtdFFTakJMbmRRZkly?=
 =?utf-8?B?d3MwSmRneUVncHoreXF0M1NqRzRNSVQ4MnFLN2J4Zlp2bTZJMzNtRTdxZmth?=
 =?utf-8?B?bkNpcXhINldGd0E5Q0t1MW01RzE0cG1iNTEvQWZYR2x6NWR1a1lJUGdweTAz?=
 =?utf-8?B?a1VRYi9HTUlSejRJNVIrT2FLV09NWlN1Nnl4Mldkcm5KQ3o5ZFBmcHJTTFNE?=
 =?utf-8?B?TzBPUVd4aGtzOE9oc2FMS0dRTW0zK2NoM2F4UEE2WVFaUENDTW41M2xIVktL?=
 =?utf-8?B?QnpySS8wWUtSd2lFVkl4QmNoenpDV0NNaGVyVGhkSGtVYngxK3NIbnB0YmhF?=
 =?utf-8?B?YkErU285cHY2dlZ2ZUlUd05rNFNERTgyNDJoa2hOanhUVndTODJkSDhXdHBl?=
 =?utf-8?B?N1I0ZDcwWWJraGRTb2ZiTUNVWVFQcW9YMVN4RUZzeVNsamxhYlc0bkpNWWR3?=
 =?utf-8?B?cE5qcGtBb2NPWk00Rk5tVHNoQ1dpT1NOTmNpL2lySUMxQTI1T0M4NHhQcWhm?=
 =?utf-8?B?R3U4TE9CZVYvdVNDK2NXV2YzWDFaSmJ4dDJFa1FZME5pYVpPSGRBWFlGNTFo?=
 =?utf-8?B?V09SQkxVQ2xqYVQ2WElyVXNrRmR3ZVJISXBNRHB0ODNReThLWERzY0xzRmRt?=
 =?utf-8?B?bGRXOUZjV3RjK1o5ZlpIYVFDTCtiNEFnWkQyZjNRd0hWV1dYbHZ4THFpWGY3?=
 =?utf-8?B?V0d1VGpwWGZ3VlVicHVPYkYwcEtaUXZ5cjhlOVFPOHhaeWhadmJVZWN6WDho?=
 =?utf-8?B?THFDTDMvQ2Mwb2Fta0RQYkpRV2hETllZcW9zN0oyRGpzRTljaW1ZWGF5cXFy?=
 =?utf-8?Q?OgrU+zd7/DeyAmrA35MQCiAc9I41MI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 04:53:38.6942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e50b5499-b92e-4c25-f240-08dd4fd835a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8044
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
 - sched->ready flag shouldn't be modified by HW backend (Christian)

V3:
 - Dont modifying sched/job-submission state from HW backend (Christian)
 - Implement per-core reset sequence

V4:
 -  Dont create reset_mask sysfs and return -EOPNOTSUPP on VFs (Lijo)

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 56 +++++++++++++++++++++---
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index c67ba961de91..0588bb80f41e 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -204,12 +204,12 @@ static int jpeg_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	/* TODO: Add queue reset mask when FW fully supports it */
-	adev->jpeg.supported_reset =
-		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
-	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
-	if (r)
-		return r;
+	if (!amdgpu_sriov_vf(adev)) {
+		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
+		r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
+		if (r)
+			return r;
+	}
 
 	return 0;
 }
@@ -230,7 +230,9 @@ static int jpeg_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
+	if (!amdgpu_sriov_vf(adev))
+		amdgpu_jpeg_sysfs_reset_mask_fini(adev);
+
 	r = amdgpu_jpeg_sw_fini(adev);
 
 	return r;
@@ -1099,6 +1101,45 @@ static int jpeg_v4_0_3_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void jpeg_v4_0_3_core_stall_reset(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int jpeg_inst = GET_INST(JPEG, ring->me);
+	int reg_offset = jpeg_v4_0_3_core_reg_offset(ring->pipe);
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
+static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	if (amdgpu_sriov_vf(ring->adev))
+		return -EOPNOTSUPP;
+
+	jpeg_v4_0_3_core_stall_reset(ring);
+	jpeg_v4_0_3_start_jrbc(ring);
+	return amdgpu_ring_test_helper(ring);
+}
+
 static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
 	.name = "jpeg_v4_0_3",
 	.early_init = jpeg_v4_0_3_early_init,
@@ -1145,6 +1186,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v4_0_3_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v4_0_3_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v4_0_3_ring_reset,
 };
 
 static void jpeg_v4_0_3_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

