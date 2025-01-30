Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141F5C0218A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 09:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6F7710E916;
	Thu, 30 Jan 2025 09:51:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cWjozIQR";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0033610E916
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 09:51:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUoVlWz0y05IZGl+t9YWTliCJKbOK2Qt207TjtshWL60q/Tz+ArCw/n55wDR7MHlLOxLhOB6OXxgzSrI9O074Md3vG/FKmCa7K5TB44OAjs+3LHjSwhFErMWCCstcdu0y/sReozqQrLJmiGq7JcQrYDjtxQoFEbZ/wsxz0BHevkomiJtB31FivveNwz3Eg5MqGYN3BjOM+eh9dzxdYslrR2f5E2y+dNoGEJtCMr8r9neTquZCdXMOTLf2vv6F2EykQKAhl41ajQf2Q2yvoQMMnUzmaTO+sFFVrss+8ahSTLVDWhL5LVmnKPIfGml1ox85n88dTtVwVeNo9GEx190Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRFF2rLwOpjui6uv50z3v+xgJjwPulHtG6kkGFnLSwk=;
 b=nGz/buH7HDaJtNF/J7U4FEA88X7ZZNFcL9c05U4zMWgMrjGFUhFbNscim1mjKOmBiGN5Xy5QDbiohoG+wlylTTffcuyw4ZGCo+GzpXng+wGblVtbcplz8aW2leaxUfEjQgP+DI+uhOCdZ9wQckuyJ701m0yEPBwo9lH3OqjfUYbU3l+xwK5PCNnDTeCBYx+CFSiXkgsmamAdDmT8tuga39TctAjYFgxRKKBfdgEzH2KaNFBZzCalhSwGhMAtVWzX2vlQLija9+TYQXAC7/J/tfD4Gc1yNnOeBTbE0DvWvC84TQOacrp5f4cblOY12G3vLQHCLF4mi8i/LvC4DPnXeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRFF2rLwOpjui6uv50z3v+xgJjwPulHtG6kkGFnLSwk=;
 b=cWjozIQRY3JcIJKu186yuw6uRy6ImDFxCULcOVvuQ7ifS+m0SoCa43johLzjyTlkgIiR1eomDMTAwbFx9QsZDZmXlVXTv0i9VS+b+5lPv0BDVuymJct63EEmuJ+PcXNilmT6vcYAiwAzfHtg+vM9kWVk8L5WkC4AEfDMQrtghAk=
Received: from BYAPR07CA0108.namprd07.prod.outlook.com (2603:10b6:a03:12b::49)
 by PH7PR12MB6610.namprd12.prod.outlook.com (2603:10b6:510:212::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Thu, 30 Jan
 2025 09:51:50 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::cd) by BYAPR07CA0108.outlook.office365.com
 (2603:10b6:a03:12b::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Thu,
 30 Jan 2025 09:51:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 09:51:49 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 Jan 2025 03:51:47 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>, Leo Liu <leo.liu@amd.com>
Subject: [PATCH v3 01/10] drm/amdgpu: Add a func for core specific reg offset
Date: Thu, 30 Jan 2025 15:21:04 +0530
Message-ID: <20250130095113.534630-2-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250130095113.534630-1-sathishkumar.sundararaju@amd.com>
References: <20250130095113.534630-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|PH7PR12MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d54d7f1-4bbe-4d62-95af-08dd4113b7c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0V6OUdDWS9kNGVtMzJsTHRzM1BGRmMwc3Y4eEcvWURQYjdURm5uMGpUMGp4?=
 =?utf-8?B?Rm84aUk4TkF2bHRuTkJ5eDl2NGcrR0NsdERrTGlML1djNGd6dncyckFEQ2Vt?=
 =?utf-8?B?bmVodUVVNHFGaG9VNTZSQVlDL0NwYWM5RXp3a0hFUjM1R3VVVHpVeWJKOUZJ?=
 =?utf-8?B?NWxpUWV2a0RHMGNQMjZ0UDNhMDc2Y3JUbVk5aExKeFphMnBaOWNNYkhndGsx?=
 =?utf-8?B?MUtuQklGOEJSSmkrVTZTemNIWVRubU1BdWo4OWs5NHBabmlwNFJZVUNOS0hO?=
 =?utf-8?B?Y1J4L3NPMys0YmdHMG42UVovcEtXRjVTZGRXdUQ4VFB1bVFzdGxCSVJXSWJ5?=
 =?utf-8?B?WDJlT3ZwSVI4S0VHbWN6ZFpuL3lTYk95SHVNQzZjM3BGa0Z3OUZKQ0NHeVB3?=
 =?utf-8?B?RnJIUGhYcXRJZFpCeHd6WllYeU44WHBhSjY2UzJ2SHlmT0k2NGJaVEttcERn?=
 =?utf-8?B?SUNkMU8vaGFQNUN2UFpjWnMyOHMwY0h6U0hlb1BCd1QzdXNUT1NIRlRmcURX?=
 =?utf-8?B?MWltWTcrUnRJNDVJTHpwNHM2VGJZRVdtbjB3QlNBaUx4R2lCWXAwOTRSNlRK?=
 =?utf-8?B?RFkyWXBIR2ZtUG1JWGtmUXpWUzljaWF2OGJ4L2Jka2wyNlUvSTFuNDNoVXpS?=
 =?utf-8?B?QnZHWVBpeWxmNnJiVytGc003THM5NGlxMlZxdi9OS1NJajVVUDhZeXdPOGd2?=
 =?utf-8?B?Wm0xSUFmbFlVa0J5R3NKYmRFUThmQUM3VFpFM0NSbVRoUk15bE5oOTJocXF4?=
 =?utf-8?B?UTA1YmZjRWxWZG1jc1pUYWpGYUZQUzNVV2EvV2JvSVUyMEV3SE4yZkplNURo?=
 =?utf-8?B?RnBDY1ErSUZ4MFBObzU2bk5vWU9JSHFmYllwZlNHSXd4OEhFeEttRXlQdGxB?=
 =?utf-8?B?NTZQZExsOVhhL1NvdjJXeHprbXNtejJoazd2SnpYZFFyQkxvTkV1aDgrOThr?=
 =?utf-8?B?bFphL2t2SFNPZGhLYTZNaUhCZTdqNGVaRDBqTG4vdHNtNkp0ODQ0Y0hMSVFo?=
 =?utf-8?B?dVk0RFlBVVJwL2ZJREkyNnExSkRhSCswUDBJRUJSMS9ETXpJVFFHRUl3QXZn?=
 =?utf-8?B?dWdKSkJRTjZRTitVakY2SlVwY2Y5aDdEbzBoS3Y5RUR5cWIxaVZOd2djRTcw?=
 =?utf-8?B?b0VPcFpzdjIxZXYvUE50aCtYU0dqRy93NDVwdmxhTWdwUnJGR0h5VVBwcDJr?=
 =?utf-8?B?QlRSeHI4dmlTMGlnYS9VblJKZXZYcXR6Si84V3RaQkhIbzh4NDNNYkZBbkhF?=
 =?utf-8?B?YWNiSzVJQ0FSU3M2SUtWNkY3TkFsc0NoUm5PNHhYU0l6NnBYSTJLbTVSRFNm?=
 =?utf-8?B?RHdiZzhhUGlvOWJZY1lEdER3THRWbGE2dUxkeGs4QlZFS2RlcThxelIweVdo?=
 =?utf-8?B?clp4b0F1eHNYUHlldHhORmZVYlRzQjhBVzA0dGltc2xUYVJ2NHI2MFlhVlUx?=
 =?utf-8?B?TkV4VXNUNzlhV05Obit4eUhXaitXdDg2bkFYSFpIVlV5amduM2tmVGl3RGIr?=
 =?utf-8?B?RmtPd0w4VTZHeGNFZTVQY3JHMjNsV2ZaTDc2SnVNZ2l0Y1lJY2NSSHJEZjZG?=
 =?utf-8?B?YUtWQ2Jpb2pMTy8xNkN4NjhuN2owc2pDSEdQSkdzVE10VWpJT3duUDVSTmFv?=
 =?utf-8?B?NVZ2K2lOWUdXMUdRTW9yTlF3S3drR21VU2RCT2lmVW1JRHV5QnJEUmVIT1lo?=
 =?utf-8?B?YXJSeGxZcUdMS2p3MVh6MHNWM2lRMDFaKzQzU1dJaWI1VFRGTEVLckZFR3VU?=
 =?utf-8?B?VG1ocmRsdmRjNGtRWTk3alJMRHVIWjFONHBrM2ZPeGVPZEZQYzhYQ2FEc2Ru?=
 =?utf-8?B?UEU2K0FtQlJhdjAyQ1hpb2Q1bEdDMjF3Z0x0eWtON1BtbGpiUDhlSXlMempy?=
 =?utf-8?B?TWEwN1pJSWl0MStpRldtMlRxM2hkSW51ZU9rUzIwaWFoNUt1aUhyVDNnWUJl?=
 =?utf-8?B?NGF4TkFFKzNWT2orRDVyV0R0MUx4dVB0ZU5jYlhKYXNKSGJFL0pqWk9Xa3R0?=
 =?utf-8?Q?cdAnk6OKMMPFZ1DjAC/P5F/0MjnOVc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 09:51:49.8410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d54d7f1-4bbe-4d62-95af-08dd4113b7c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6610
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

Add an inline function to calculate core specific register offsets for
JPEG v4.0.3 and reuse it, makes code more readable and easier to align.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 54 +++++++++++-------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 9459e8cc7413..bc21f12daea8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -64,6 +64,14 @@ static inline bool jpeg_v4_0_3_normalizn_reqd(struct amdgpu_device *adev)
 	return (adev->jpeg.caps & AMDGPU_JPEG_CAPS(RRMT_ENABLED)) == 0;
 }
 
+static inline int jpeg_v4_0_3_core_reg_offset(u32 pipe)
+{
+	if (pipe)
+		return ((0x40 * pipe) - 0xc80);
+	else
+		return 0;
+}
+
 /**
  * jpeg_v4_0_3_early_init - set function pointers
  *
@@ -143,10 +151,8 @@ static int jpeg_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 			adev->jpeg.internal.jpeg_pitch[j] =
 				regUVD_JRBC0_UVD_JRBC_SCRATCH0_INTERNAL_OFFSET;
 			adev->jpeg.inst[i].external.jpeg_pitch[j] =
-				SOC15_REG_OFFSET1(
-					JPEG, jpeg_inst,
-					regUVD_JRBC0_UVD_JRBC_SCRATCH0,
-					(j ? (0x40 * j - 0xc80) : 0));
+				SOC15_REG_OFFSET1(JPEG, jpeg_inst, regUVD_JRBC0_UVD_JRBC_SCRATCH0,
+						  jpeg_v4_0_3_core_reg_offset(j));
 		}
 	}
 
@@ -521,7 +527,7 @@ static int jpeg_v4_0_3_start(struct amdgpu_device *adev)
 			 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
 
 		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
-			unsigned int reg_offset = (j?(0x40 * j - 0xc80):0);
+			int reg_offset = jpeg_v4_0_3_core_reg_offset(j);
 
 			ring = &adev->jpeg.inst[i].ring_dec[j];
 
@@ -616,9 +622,8 @@ static uint64_t jpeg_v4_0_3_dec_ring_get_rptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	return RREG32_SOC15_OFFSET(
-		JPEG, GET_INST(JPEG, ring->me), regUVD_JRBC0_UVD_JRBC_RB_RPTR,
-		ring->pipe ? (0x40 * ring->pipe - 0xc80) : 0);
+	return RREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, ring->me), regUVD_JRBC0_UVD_JRBC_RB_RPTR,
+				   jpeg_v4_0_3_core_reg_offset(ring->pipe));
 }
 
 /**
@@ -634,11 +639,9 @@ static uint64_t jpeg_v4_0_3_dec_ring_get_wptr(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell)
 		return adev->wb.wb[ring->wptr_offs];
-	else
-		return RREG32_SOC15_OFFSET(
-			JPEG, GET_INST(JPEG, ring->me),
-			regUVD_JRBC0_UVD_JRBC_RB_WPTR,
-			ring->pipe ? (0x40 * ring->pipe - 0xc80) : 0);
+
+	return RREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, ring->me), regUVD_JRBC0_UVD_JRBC_RB_WPTR,
+				   jpeg_v4_0_3_core_reg_offset(ring->pipe));
 }
 
 static void jpeg_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
@@ -663,10 +666,8 @@ static void jpeg_v4_0_3_dec_ring_set_wptr(struct amdgpu_ring *ring)
 		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
-		WREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, ring->me),
-				    regUVD_JRBC0_UVD_JRBC_RB_WPTR,
-				    (ring->pipe ? (0x40 * ring->pipe - 0xc80) :
-						  0),
+		WREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, ring->me), regUVD_JRBC0_UVD_JRBC_RB_WPTR,
+				    jpeg_v4_0_3_core_reg_offset(ring->pipe),
 				    lower_32_bits(ring->wptr));
 	}
 }
@@ -919,13 +920,9 @@ static bool jpeg_v4_0_3_is_idle(void *handle)
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
-			unsigned int reg_offset = (j?(0x40 * j - 0xc80):0);
-
-			ret &= ((RREG32_SOC15_OFFSET(
-					 JPEG, GET_INST(JPEG, i),
-					 regUVD_JRBC0_UVD_JRBC_STATUS,
-					 reg_offset) &
-				 UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK) ==
+			ret &= ((RREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, i),
+				regUVD_JRBC0_UVD_JRBC_STATUS, jpeg_v4_0_3_core_reg_offset(j)) &
+				UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK) ==
 				UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
 		}
 	}
@@ -941,13 +938,10 @@ static int jpeg_v4_0_3_wait_for_idle(struct amdgpu_ip_block *ip_block)
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
-			unsigned int reg_offset = (j?(0x40 * j - 0xc80):0);
-
-			ret &= SOC15_WAIT_ON_RREG_OFFSET(
-				JPEG, GET_INST(JPEG, i),
-				regUVD_JRBC0_UVD_JRBC_STATUS, reg_offset,
+			ret &= (SOC15_WAIT_ON_RREG_OFFSET(JPEG, GET_INST(JPEG, i),
+				regUVD_JRBC0_UVD_JRBC_STATUS, jpeg_v4_0_3_core_reg_offset(j),
 				UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
-				UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
+				UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK));
 		}
 	}
 	return ret;
-- 
2.25.1

