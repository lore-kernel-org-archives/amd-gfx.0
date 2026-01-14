Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97FCD31A29
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 09:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69B7F10E5E7;
	Wed, 14 Jan 2026 09:01:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kdaWNHUd";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012006.outbound.protection.outlook.com [52.101.53.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F36A10E5DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 09:01:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ma+VjESc39AJr8Z1zocZ/nw5et9Z/Uah/W7NT6yKaz+2r6Ir2UAou/qNUPc+cTygBp90vGsd6bhYXDZCbcLihOyN8Cnq1dKiyvYcFOw3QF/9w+QFRQRFAb4JUEvEVzDZ48+0zAfBlXPGKRpj0hSAj7XuCtGMvZIjbglRbjqmjJf+4fVPWHNZVOYcTfGIVtvVsv7tfs4F7lPkCoq4IC2t7EaRorYjjqtuhvb+1XnpA4c3lz+0TpNXTBNrRfhvXCM71MxtrY9jpS8CnP5Evy57MM9AurqKXfFrYIZ/AjB9topOUiBaZSm9O3k9jBPICFcgtA4Wrz/wUS/l0JEJGOq/0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BALzcdcgOtUewkoF6xLbuAZpWSAJwNMKYjttWMWHP+4=;
 b=l+aZ6WHisZziOq0CV7D8EBbUqWoi8DLnpfPxpz4TUlEJR6lygNAgwo/uiEGImmbSIcQh5lkge/8At5rKFNYSa9u9N5UVu/8sgOFWMm2RHUslJMIr4nfon/15vNtKMg+natlM414P+dU/ew3aGnoWJcGj9TiuxXB/jgDIVX6F15zmP8ODs/mI1DzZxbTHCSLi2s13qs7qmgEEoCsg2nB0/3ldOM0drcHIgcNqh3lmJwqInt9uqkLK4eshHeX8EGzDzbf7nwZuqzXuqrJ5Nz1R0UCJ28OEeqN+mQskKxSlBUevMvkNrWENyIsB6O2H5EtRS3rsPwq48jSNYDwfaHLMHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BALzcdcgOtUewkoF6xLbuAZpWSAJwNMKYjttWMWHP+4=;
 b=kdaWNHUd2OelCk4kU/+kTrOQyMKoD6Q8CNoB46SLwViL6tHceDmpec7Gw5aXXi100OKQUU6zeXMsB9T1YmwNyS5ga2ckfQ6PbeVBDmrEacsx16g1N2cCjaTjMrMEMp4NrDDnWIl/EguhBJISsXUfS5cB1x3AWy3T0s1FjvtyKdU=
Received: from CH0PR03CA0059.namprd03.prod.outlook.com (2603:10b6:610:b3::34)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 09:01:50 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::14) by CH0PR03CA0059.outlook.office365.com
 (2603:10b6:610:b3::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.6 via Frontend Transport; Wed,
 14 Jan 2026 09:01:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 09:01:50 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 03:01:50 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 14 Jan 2026 03:01:44 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 5/5] drm/amdgpu/vcn5.0.1: ensure JPEG is powered on during VCN
 reset for VCN 5.0.1
Date: Wed, 14 Jan 2026 16:59:23 +0800
Message-ID: <20260114090056.356633-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260114090056.356633-1-Jesse.Zhang@amd.com>
References: <20260114090056.356633-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|IA1PR12MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: ecbf8335-e0db-4a60-2e9f-08de534b8e53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8YhXFZTXB1pw7w77TMMSV7qPooxGUi//jMleEzEFp3w2ZN0SU0C3OsKQZZpA?=
 =?us-ascii?Q?MZSl7wX7ObHb1pZj8hhfKmdy79iStvn/Vw7F3wagQq+j4Grg/tLhqyG16Hm1?=
 =?us-ascii?Q?t+0fq7562mrhCfLs5hJDJy/zI4nV0tWoYCdoGLbw4QBPH8KMasn9Wk+aQoen?=
 =?us-ascii?Q?htNX56nDLM+5dfnV43a88cukDB07tD27MO8JdaRqsKSpbWDBYHLt+HHpDkIB?=
 =?us-ascii?Q?XgNw8aOLDXX1nNWuZrEw4b0MBF/tQOMVly6iuFxcxSEwuDyGD8sYmx3jwNuS?=
 =?us-ascii?Q?sy6FoK69+r0Ew9LSC3lhaNwsiQLv30p+Db6TjL+BkDQEpoyvPqSOp+8uE9Xj?=
 =?us-ascii?Q?L8s5us29YXz6JyicYtKfUGapo8ZH9ql3U5QR8a57cCDtVJJt0TZNusxgEssb?=
 =?us-ascii?Q?v+UG+Qp2xjyQLYRsK8stiO6rWubrSXnTb43GmTCoAr65AgRQRPEhS8hFfaPd?=
 =?us-ascii?Q?pZeqRrCMZR3Pj8lg3hx85lbsPKkS5e0Fnjb6Ob7EKX0Pi1PQdyRJ70ZcZqMp?=
 =?us-ascii?Q?rNesYQFCz+ZARp+amy4AOUocvOgoJF2bczB8oKa3KWT940l3yOUQrQJcRv2/?=
 =?us-ascii?Q?1zxEqQ8k1gZwOl+fUZ13ijaG/kgT4Fk8/jl8jyabGuRHJuvH/wWDKufa4yyv?=
 =?us-ascii?Q?seiKkjywCW6yWpbDxH8AeMe4YfacZ+THsXxSstLGAZ/ZMWEM2WsEat4nXrW6?=
 =?us-ascii?Q?S1obc4PxompAquyXX85U4l1eLmRSCjPh6FmnkZoTgtXqNrKzS7fPUSQJJB6y?=
 =?us-ascii?Q?6PGStKMAf68e/rfW3357f78Yw1emsYC19O/TNh064TXfbYCWPg8VQ5VhY8J0?=
 =?us-ascii?Q?cRXrjRM1EGvLJD8t0w0nGERft6n64yrThy5zlRZOlLEu2epmzy9CN/DOQhbw?=
 =?us-ascii?Q?qu37KObZtdKryj3BvyLvJ5EV9QFG+dqEFesYLBhAqegTot5RDdsNRh++UpiL?=
 =?us-ascii?Q?3mcTHrwprT8FigkeidWVlLUQ7MPBHNFlA/X77oJ7zKGoxDePWAHnviIB3hTU?=
 =?us-ascii?Q?mZjPOZxdlOXMbVqDtjJgMY9HrmGR3mLM4znNi0BdDa+FH0AduEATtNU0KS46?=
 =?us-ascii?Q?ESkXp56ukF1P24kBB3f1WZh8CBhToyQhXgSysnGnzbg/RzVd5TbYDaNWXnC2?=
 =?us-ascii?Q?V/OnOh1jZX84WfIY/US2ZbyZX5XOcsHmQy35K13oyOCg58yiNKrgdKGF8/T9?=
 =?us-ascii?Q?QdZC68I3K5g3RDENLYh7V1ZuFWwbgt6kLS4Jbl4BCLDt5oNJPaMBSDuPR7x8?=
 =?us-ascii?Q?R+dcRczs3ntpUI/JexBTGlU+FPct5zxA1wh7i3pUiGgDrUpTvbhPcsKuiHIV?=
 =?us-ascii?Q?wJL/ppodGhGnc5cbwDr+QT0g1+59FPu6eUjjRVQ2DrtAtoB9hOpEl2jFu1Mb?=
 =?us-ascii?Q?I8jPkC/O7OAsAz38gmUMv6nM+iGFI+aWHkQlmlnYo6gg9xeLNy2bRrN9OCKK?=
 =?us-ascii?Q?xhcC8UWBVmlqCHE5Ew1PS/qYvhni4qTRi0urVWnIt2FHkpvYLFtvhe59JK6C?=
 =?us-ascii?Q?C5vzJEbKKHiU+gmv77QI6iFXzOLZrMmxQlIOahp6MJVYecDToA1X5pZbzix2?=
 =?us-ascii?Q?I+Nn12DQa4TW5nbA4Mk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 09:01:50.7884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbf8335-e0db-4a60-2e9f-08de534b8e53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467
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

Resetting VCN resets the entire tile, including JPEG hardware.
When we reset VCN, we need to ensure the JPEG block is accessible
for proper reset handling and queue recovery.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 0dd841c2b0e5..9d9dd8cdaa27 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -1335,9 +1335,18 @@ static int vcn_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 	int vcn_inst;
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
+	bool pg_state = false;
 
 	/* take the vcn reset mutex here because resetting VCN will reset jpeg as well */
 	mutex_lock(&vinst->engine_reset_mutex);
+	mutex_lock(&adev->jpeg.jpeg_pg_lock);
+	 /* Ensure JPEG is powered on during reset if currently gated */
+	if (adev->jpeg.cur_state == AMD_PG_STATE_GATE) {
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
+						       AMD_PG_STATE_UNGATE);
+		pg_state = true;
+	}
+
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	vcn_inst = GET_INST(VCN, ring->me);
@@ -1345,6 +1354,11 @@ static int vcn_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 
 	if (r) {
 		DRM_DEV_ERROR(adev->dev, "VCN reset fail : %d\n", r);
+		/* Restore JPEG power gating state if it was originally gated */
+		if (pg_state)
+			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
+							       AMD_PG_STATE_GATE);
+		mutex_unlock(&adev->jpeg.jpeg_pg_lock);
 		goto unlock;
 	}
 
@@ -1352,9 +1366,18 @@ static int vcn_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 	vcn_v5_0_1_start_dpg_mode(vinst, vinst->indirect_sram);
 
 	r = amdgpu_ring_reset_helper_end(ring, timedout_fence);
-	if (r)
+	if (r) {
+		if (pg_state)
+			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
+							       AMD_PG_STATE_GATE);
+		mutex_unlock(&adev->jpeg.jpeg_pg_lock);
 		goto unlock;
+	}
 
+	if (pg_state)
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
+						       AMD_PG_STATE_GATE);
+	mutex_unlock(&adev->jpeg.jpeg_pg_lock);
 	r = vcn_v4_0_3_reset_jpeg_helper(adev, ring->me);
 
 unlock:
-- 
2.49.0

