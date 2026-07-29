Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8613C54F5C
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 08:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84E7610EB16;
	Wed, 29 Jul 2026 08:58:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Hkz4LCp";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCA2010EB16
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 08:58:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzc+NHJVM1o6P2auDS5TlPufu1kCJkrjBTOgAwPh/89pGOE5Cjpi1lzkvZpMQzouJe0buZrL5mEkKBRFQFev1zgcshd8cK3l50gDXk3e+O7gohRMuFPBWa2Sf+JKmMUEOddp/zJt+H5TKlhNEiPwieGmIZ8b5mdgyUk55cXjI2mMJ1HkMAV/zVZ1i8ueWvwN12MQKTiQ61wZSJXJwLjPOMN8L3797viL+lYT5UKNqAyFpA3gwEtsd1TRsnqJEJKhuHEmubIqe/apWvtGiWYSJXEYupStKyAosstJjK9gfTeXs/LHiiq8bTYX6o8feWNA+dJtZ3QwpSVUohHZLR217A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuk8kHa+x0rqQTNgzopQD5FoLqTzZ3z3B8T5yeOr6e8=;
 b=kNXSDIvDWxnthjAawMweoNEhRMrnkuJK4fC1zj9uf/wdRCdhNMsAa6O6nSxaYadCRH0YkTgKOlC/O+bF0dXU/Ps4BMqxUTc8qL47s5K+kYvEBYgpzghc0n0sWYXj5JJHqq2/q5EYn2lYuITJI0EUVXw4vXq/+bjIiCYGXMYb+D36ReSKCtKi3l3pz3kYAFjpsVM+wtdYWtTPaXR0XsCW3ar5YIm9Mm1LwGZIJ1TIjP2TyuBWWjW6KvMY5yBMvzZ8zp5RCCvpmALDxfPx06NxyXb5Q3yNn7JHXVntHW916O8vRl6W0f6DJetce7Df82eIlhq2fSMPQaqCsw6ChZKd+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuk8kHa+x0rqQTNgzopQD5FoLqTzZ3z3B8T5yeOr6e8=;
 b=2Hkz4LCpT5DUUbMrA/j2WEp7EldhapF4F5n9Gv54GZtdpinsUyvbysCTYOGr04eXEazXaK72TmNtcNaiLJ0oUZ2/P9rH04Td+sdF5uJsBfiYMpwz1fw/P69+AfymTpIHQimX76wdXOF2Sj3bEIWB5PQBDusi/eBMWpclVNnIDpQ=
Received: from SJ0PR03CA0088.namprd03.prod.outlook.com (2603:10b6:a03:331::33)
 by DS0PR12MB999289.namprd12.prod.outlook.com (2603:10b6:8:424::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 08:58:45 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::6f) by SJ0PR03CA0088.outlook.office365.com
 (2603:10b6:a03:331::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Wed,
 29 Jul 2026 08:58:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 08:58:44 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 03:58:43 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 29 Jul 2026 03:58:42 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: fix JPEG v5.3.0 queue reset failure in DPG
 mode
Date: Wed, 29 Jul 2026 16:58:18 +0800
Message-ID: <20260729085838.1338931-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260729085838.1338931-1-Jesse.Zhang@amd.com>
References: <20260729085838.1338931-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|DS0PR12MB999289:EE_
X-MS-Office365-Filtering-Correlation-Id: d7ab2a08-5703-4645-abea-08deed4f9858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: P2q4UlAma7IYH/XbOg9dZEX8fNmfhBcFIBjeajiMsaiC/G34MaWmTUF/b+GbDcTm2q5urZWnSFv5keOW0PAWEFBPaTIQ8CMgs8tVT1amnpQ+GKKhzWO0eNLji7vIiGSiwlF6u/N9tFcw4aTqCPVQkfkYVcEOnmjs9syRh+UePC8SC2FMU+3v+kDCPweamjqBhL+NfPK6NJRtRF3zCfH7hu+cOyarTW+6HejpkuMhHmaYmd2MSPUikWem3LaAWHbzD32tt0I5Yxd5JebVG7jvHZVBqDUVTx499F4aRpqS3Lfy+pXKdsgayavtRetGmaazVZKKYzjc5WlWAmXvD45SNFj+grCgBDvE/RK6KVT1KNZ2Ye93WT+XSrothiBOHYDrY9R4wgoxXiWmVgvkgMxd8rifT+xwM9agx2qbG2gsYJc60tbhDTEG3Le4tZeaHZw/+2CM1aNgotzby8TRui3Z/U4Wze2EgJjxtvVUsJbHHKu7xUvr+rZBLtCvCZc6Nwv8HdsTShvxbf7VDJiN7bs0b+OyTX4+08nq/DM8FRy1AQusQMZJqqknPOB0TN4R+rszkbXuwoDudIbbt9oYD1BGXG3xGBW4yN7hJAh6z32yUswxVhn2Lve+W0S++uSmg2/52X3WoqIketMvwW2A5CMVgWdOiRfG7dX3CMJR+ru9cNgIXfc7G41sjaatrN6v9Ej7O5iavFkjyqTMUwYvFSRkDg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VK0JNutiXiEw3HLrQfEW39M3OqZyL9jU4uHNCWizmXVD9tdkq0sHliCNhHGlu+wpeG1uHEJSzgy+SybG/YuDi/bPjU2ERfE7dmw024dqG/iNc/DVXX1U9+5tlVVzesVW5FGi1pWDGue0F097nVUAA/nAuxdg3AriaFwXZzUxbCVCvwznvXW/TnX6ENwFvRGWDvNgxPjzicv3YQHDR6DRmjGOSlYyl4JbVwOD7TpVQPOXBrL20cX2TwabbKTTbWogMEOxcTQim2FjMdqNLVWjz2eN+668J5jF+GOCBvOCFUh8tyT4uo4x9abgi8qge+2cqcpvZCBxCkcW6RvH3sep3aUCO+wtbgvD0OV7L+BG2Nkhup3ObBNaTUNfxORjybIwGUARMTw1ov9Lce96ML4soPbcWOtinqWZUFG6Ke6iQ8LWXkXSuyQVaqQJ+PE6M6eX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 08:58:44.6074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ab2a08-5703-4645-abea-08deed4f9858
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999289
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

Like jpeg_v5_0_0, in DPG mode the ring reset path only clears the
JPEG_PG_MODE bit and never resets a hung JRBC, so the post-reset ring test
times out and the driver falls back to a full MODE1 reset.

Temporarily force the static power-gating path during the reset so the
stop/start sequence power-cycles the JPEG block (JMI soft reset + power
off/on), matching the jpeg_v4_0 reset.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
index 68152b2ce015..c929d6f83bac 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
@@ -637,15 +637,28 @@ static int jpeg_v5_3_0_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *timedout_fence)
 {
+	struct amdgpu_device *adev = ring->adev;
+	u32 pg_flags = adev->pg_flags;
 	int r;
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-	r = jpeg_v5_3_0_stop(ring->adev);
-	if (r)
-		return r;
-	r = jpeg_v5_3_0_start(ring->adev);
+
+	/*
+	 * The DPG stop path only clears the JPEG_PG_MODE bit and never resets a
+	 * hung JRBC, so the post-reset ring test times out and the driver falls
+	 * back to a full MODE1 reset. Temporarily force the static power-gating
+	 * path so the stop/start sequence actually power-cycles the JPEG block
+	 * (JMI soft reset + static power off/on), matching the working jpeg_v4_0
+	 * reset.
+	 */
+	adev->pg_flags &= ~AMD_PG_SUPPORT_JPEG_DPG;
+	r = jpeg_v5_3_0_stop(adev);
+	if (!r)
+		r = jpeg_v5_3_0_start(adev);
+	adev->pg_flags = pg_flags;
 	if (r)
 		return r;
+
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
-- 
2.49.0

