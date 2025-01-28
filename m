Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CC5C0218A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2025 09:10:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D521510E413;
	Tue, 28 Jan 2025 09:10:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jQdH+c21";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 751F110E413
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 09:10:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBGWNDloDbpEX7sKfkZzDfaoT/wMrapSsjE+tBtqJpSw5q+Ba14lGWsYWnqaF/b7ncrCw2z2xZBzqG26adZKe1fPwNWlQeqoKHcQXYpDkyvEniEQdi/HOmH8ZX7nYeRZlegfvcduG2zeErhCXJ5NyfycYwD7JHsF/on+S9Ho3mRAzX/0vimqpreMSZKAJbvAg0my5eDatX5q4c+NvUfsUiVws8BHiWuN4GloTyHexlt0hWhWXl+P/8t93A3s0i/tZod9k7vmct0ltad0BZ7WWrkiFHsMJfQxkXVl4tdAhwiTe/KMdJGcYjDpLU2dWfVN223p5lSEViwzNEfKxB1Fiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzuzREBQaxUi4pGvqSGOlQqKCVvwO7Q9VKaTCAV3L/8=;
 b=Ks0UnTm6ldTD+l8EXCeaVf5tDztWlnSpEO8tHAByP2YBY5b+5SXh+PLdJMPdiJ67G9Hq6y4l/wlP+YEQo4iSTiZFGtGeEVn+Ex3qhk8+zrapU9xiXbnmFv5LFh7cRc4T4KgKJIZSS0utqsQBowWd08KKAZ7gXQCwT055FxSAbBby452sc5p/5w1htTAKHQXSJ51Z5Ide9zXIeg34L+NJb6nHeeVxC4FKg3o7e2KZ98EBiV2ieQ5ubtRuQ797xYLdg2yeIb9K5ZFth66RNUTg51ai6l6nQbMgzgTilnDX5UrXM9btXzTOM5u2L6kHyX80imn5iO55IBNc7XspAIR8sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzuzREBQaxUi4pGvqSGOlQqKCVvwO7Q9VKaTCAV3L/8=;
 b=jQdH+c21g7DW3G2F943L7tb8h5ius+Uez0qnwbWgf+IwzRCKQHvyfRu6GddkaEWEzmyV4gCQGHgJjPNN6vkYeOu/94y2d5gicr7M9qYtxT5rLKkYug0YcBsz93XbPC41C2bTdFm9oD9hmuhLxWtuAB5rcJsg9rh4xEpU7IbjH5M=
Received: from DS7PR03CA0315.namprd03.prod.outlook.com (2603:10b6:8:2b::10) by
 SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 09:10:35 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::26) by DS7PR03CA0315.outlook.office365.com
 (2603:10b6:8:2b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.24 via Frontend Transport; Tue,
 28 Jan 2025 09:10:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 28 Jan 2025 09:10:35 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 Jan 2025 03:10:33 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 1/9] drm/amdgpu: Add a func for core specific reg offset
Date: Tue, 28 Jan 2025 14:39:42 +0530
Message-ID: <20250128090950.461291-2-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250128090950.461291-1-sathishkumar.sundararaju@amd.com>
References: <20250128090950.461291-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|SJ2PR12MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: 45ab80ee-f0fb-4487-aedf-08dd3f7ba01d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cklWUWtUZEVMb09KT2NlNUR6cm5ROVY0a3RpLzloQlc0Q3hQSmhnTnhvUG1Q?=
 =?utf-8?B?OVZoeVEyL1Nna0J6eWp2UkVQZnoyWUFqeHBqWFZSa0dtVWYwQytDRDNGR1Vp?=
 =?utf-8?B?QTN5Wk9zNC91Z1JIS0RSaFZTTmNkNjJma3Ryb21oZ2htNU5qOUhXeS9MZjEr?=
 =?utf-8?B?cVdjWVQ4eTZrSkMvMGpxTlIxY09lR0lnbllkdktYRWZ1KzVNVzBsWk1nL3ZK?=
 =?utf-8?B?Si9YcXhTR3Y1c1ZkUHJFZWlBMFZsQTdQZ1FiNHAyblZhRk02M2RoUG41U2J2?=
 =?utf-8?B?dU5JbXJUWVBLVTc4Z1Q0Zng4QlFLNGV4clBMa0ptM2ZCZURSSEJyNWo5V24v?=
 =?utf-8?B?YlpoT0lnQTRPWWZpemlRNm5pd2o1cmVkUDQ4RTJvWWpNOWhYcHM5eXZiK0NL?=
 =?utf-8?B?eG4rNGM1dHlFV3ZiaC93R25wK0VUaWlWZkhwVmJWaDUxbnY4bUluV255TTBW?=
 =?utf-8?B?RXBYaUZSMzZGcFJreGVuQjJ5bU83b3B5ZU05N0l6KzF5QTV3bE9CRjJQcTNq?=
 =?utf-8?B?TFNraDJuUmFCdGo4cVRxd1VlTW8rSXk3YTQxL2h2WVgrMGlUa2lLR09BY2ow?=
 =?utf-8?B?K2tOaWUyako5OWUvZFdNVy9TdEZ2WmtpSWdKNkluMlFZN1EyZ2wwZENjZ0di?=
 =?utf-8?B?a3RtZDE2RkFzSmU2Z2JWMXFmYlpzSnFuZmc1TW8zNTJtdHpTSFErOVE2YVFR?=
 =?utf-8?B?YXcvWWxyV2xPNS9qblY3a2RtS2FBRW51MUlTczEzZEZDSDdxN0NSaDJjUWg2?=
 =?utf-8?B?a0ZoVzBEYVluT0lEZWVSQnJxaExvVFg5SmNRb29saHQ2K3NWR0d6enpiNnZ1?=
 =?utf-8?B?eGNKeU9QZEdoQlR1cDdDUVhYVHdxM2VQWmw3RkI5S0F3dUw3Y2QyVGhKTVJ3?=
 =?utf-8?B?QVhuVTlwVm9UZFBKcHh5Sjd5eFRER2plZUQ0U05vUlkxeWU2MS85aVIzUVFl?=
 =?utf-8?B?VEdweXpleXkvb0IzVy9LUjJlMEVsam9QRkFqblhEZXA2TGMwRU8zMnRjL1Y5?=
 =?utf-8?B?eGl0SDZQdFowaXU5c1V2SlFqZ0d6M1ZJcXpNTVFNOEVtTTBYN3ZURmE5SU03?=
 =?utf-8?B?V3lLbTh6WGpIOW1IejBnY3RRek9SU21hZzZaVEFJeDVvMUZzcTErYm0rNEdi?=
 =?utf-8?B?T3hEMEpVM2pwRjlNeThodkVCdEoveVRTY1grUGRSMnNhRmtOZ3pPOXZyUWdv?=
 =?utf-8?B?aUwvK1JJRnQ5aS9OQVZqNUh0aXBNNU4rY0hEV3VnQWxiOWtqUExYS2E3L2xP?=
 =?utf-8?B?bmkySExwMkYzNkFZbi9QajJRdm5VRGRDWS9uUk5HbE10NGN3SU9QSGthMWh2?=
 =?utf-8?B?dnBwTmZUMVdPS2hRYkh1cy9vcW1uSm15ZHZkbE14Y0FTcDE4MlhWaFN1MTF4?=
 =?utf-8?B?S1ZxYkZ2RGJ2dmhJZ3ZjWi9ldTZQd3pZUDF3elcrNGlPSHZUN2RGZU9QZDdR?=
 =?utf-8?B?eGR6NUlYRUZYVE5NZ0NGM0grRHU1dU1KUXdEQjJzZjBmazhCVGRyTzRGQXlL?=
 =?utf-8?B?Y3lNdk5oVDdWK0FnNUwvZm1TOXpCZ0YwLzdTcEduMXZMOGl3a2lOTmZ1ZW5K?=
 =?utf-8?B?MkxIYk9xT0M0aDR1NzRRYitWTk1SMjZNUVU5NTNiTEd1M2NKeUR0cmpiU3Rj?=
 =?utf-8?B?V01NLzhsZGluU0ZaWkhkRUFoWUtDWlJ1MVI5Z09jdDZiZHZjLzBHcXYrbHNq?=
 =?utf-8?B?ZjQ2cmM3K1JwV3BiOHNMMTZSQ2VxN2tONWtiTEVXWDlVYkVnYW5iT0tnR0VV?=
 =?utf-8?B?alluVERnaTlyRTZsekU0R3JtWDdaalpxRHRYQ1FKd0s0endIUkZkNHlIWkx1?=
 =?utf-8?B?bEkvMSt4Q0VoaW5KUEZLOWhVL3BsSTJFZ2J1WnNWZDNRTm4rMUlURzQwY0Q1?=
 =?utf-8?B?L2x0cmRXUlBJbVUxQmxJSGZxWVVDZzNqWWlmSk55UEV5OFNQN0pnTWhKbDdU?=
 =?utf-8?B?azRBY0pxMitlUlVtM3N3VjdYUm5kSCtnbGJFRVV1TnArRWxXSUlrRWZuTFpD?=
 =?utf-8?Q?LfbYkZlJK/WyMOr0rAX/MeBFTjJJMk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 09:10:35.5211 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ab80ee-f0fb-4487-aedf-08dd3f7ba01d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831
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

