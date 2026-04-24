Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDE4FB44AD
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2026 05:28:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D8E110E054;
	Fri, 24 Apr 2026 05:28:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q7mJIBrx";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011056.outbound.protection.outlook.com
 [40.93.194.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 056D510E054
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 05:28:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3vSemLCBqqglLnvt1ZEhW/AhqnI3KDnPqldN9+uBJ9Tf9XXOcroMfgTUjfL31xSR6MnAEXZ536eVFuZeUrhQQ+jKepMjlctJYX+/k+H2Fq5UKnn7tBFXCe8n1iGI+RSqePl5I2tj145RP8AEtr9rniYvfO12I5ViHka9P7cSKpIUdxSnAs+BDYhVUTnl1R0xrNkXYw41xdoE/+H4TMPbkUFi/DM1/2mmpeEn/k6dNU9T4zTKd4avlIr0+Iphbvi0Kv1lReX81GQEfqywScboP8snENttrTEBVZszYaIkRmXE+QOifN0reGiT4EXDspLmP8HmfxuKvRq+nOMsm3WAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrJ+aVrNdyIESJsy2KrsP5OssYn9sdzOBjBf3Rea0pw=;
 b=Q+ywKX3gDfTti2Z4jjk1tBYcP47n3OFtNwj8xF0HYaK5myuqb27ztBJXfXM6XHGDmBLxoOkz+/TZlqTgzTS3QKJ6g0cAlZPdzDH3OZK7vo405ziaAACo1TH0T4rsgQKv7qartpH0bA3FMnpG0UJpQG7jz3Jmp/W8E5gCDRsJYZFw0dK6Nm51A+ZYMu3SsA+ofiyrazma9ScfWhbn3eOKtRilbPGPiDBQ7VE8BNAgVIAGt0Mh1tdPNQbYL9S8jWBmYvNFEn5Gl2uPxk77f8dRec6u/hpep/a1yMUqixhtuf58u+iEjTlvTSA4kd27fATtdqgc0zQxy2W5UkIKNcn3mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrJ+aVrNdyIESJsy2KrsP5OssYn9sdzOBjBf3Rea0pw=;
 b=Q7mJIBrxlv7i947jhVQfdECYPqKVpL6qbkDYhJ0CdcBA8xf3hpHA5dJrpI+zDvShww1ZHAInan4IWDTnkRGy9Bwg2Cv14HcsWTa13Uso8l8QI8UtN3obLuivgpmR+tSmGwUl20+Vgsnt/PiV3ASjvOJVO7jjYqjS0B7e9x83ODY=
Received: from DM6PR11CA0064.namprd11.prod.outlook.com (2603:10b6:5:14c::41)
 by SN7PR12MB7225.namprd12.prod.outlook.com (2603:10b6:806:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 05:28:29 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:14c:cafe::b2) by DM6PR11CA0064.outlook.office365.com
 (2603:10b6:5:14c::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 05:28:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 05:28:28 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 24 Apr 2026 00:28:26 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Likun Gao <Likun.Gao@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Remove invalid init_mcm_addr_lut call in soc_v1_0
Date: Fri, 24 Apr 2026 10:58:05 +0530
Message-ID: <20260424052805.2455063-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|SN7PR12MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: 294ccb70-125d-4911-083e-08dea1c250c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: SWJFT6eX+BedG0+A7q2fFA3VT+/tk0CXhDZDlux8A4Vzfe304O97lqA2sBMjBw2iQnMI3p5lCEuma9WxZEos8cORZFHmjquvSGZmeZGDmh+0iAItT5b7avAu43w5VXXz3Zo2ahFaGE+G5RbiQNCFA9o1iYeKHN7Cbgic/nggderGGQHh59+85kAeYe6XTfix/rk4PG4ujUlaAr+X+y9L7Umq0TB6CaQHy7Y4Nh7auiGWAxxFtzkQiqexm+TiMuNIzCZfOi8A9ZhaXqm8Q4rwFCZ2AoLzu9Vw5aA0TZC2nODGuxsHuXxlB3OGM+4NwyGq/be6C6z9yoR6wHsmRhC+WofFbBkAt52Q/eRyIurh9oAqufqwePvOK2j2VNNofM7zucNOW7qYDBLLH9XDuE2/2fsv7jtR55II6583LR7wU6T4ODa83CeYCgYbH4ddnV7qmovauyLvKY1yJvYupVnV7lQn8bIvBFcF0Y9uG765kNenBvdpJcszGZnLRkPLD9hVVx7bjtncIimvPijuHTiBxh8yhKs9p0vezdCNtZwYCWkacqBNij8miB1qCLUIzR3r+99H3DJ/J7SCzUpCgeJo7J8cyjeGudOCb6EHBhhLpaK1Wa7lgXcX6fzZd8FzBuy2C7BRXvUEZlkJYzQ9PMEIWcnSOKT0iZ4tY8MfVp0f/9QS/N/jc0kILDJc9wsUylhJpNWmP8E/WoWYDRfsU6dA6kZjqfrhcekLSFWcjU7WaYZjDhXT7SZdBPPteQAuGCfT5WxfSwrh6Db8r6MgKwocTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mQQdDiJ81vJNR++sfgc1Vjdzux0ITBNjFc2/g9rooXLXdy+W318B5Qogl2ko5gtE/PuIjIWCZ1C0FFLWH3z0AJzAmJcRhtljprZ+I2rOv7yz238VzwJDndMV8KsLRYz2DdWZg8L7wlYHwBbCrfUP7jshc6ZQ/pWNRM8vS7IsOpsGZQHpDdgwjvT4wRrIxogugoyS1Dxy1UKThWUDCsxSaDIYYWkajE8202lLuRpagMdjYvIWeZJmfc4SllOnReqWx1zd/yn/AeEjWrNi21vM1kMtrXhvGX4aWwPvvfvBTN1ebxQ41r9w1uXoYZ0O9Q/fODM0Asgrk5lJqu4Yy/AtivrbxfIPDGFjvSHgq8yeNotxUf6SVbnXte/kydiNQxfAJ2v5fINqmha5myN+nx3rgdfq/cKsRYT9cNcRe2pzMAn1fuGlKN00DPxKhjllZsPQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 05:28:28.3392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 294ccb70-125d-4911-083e-08dea1c250c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7225
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

The soc_v1_0 compute partition switch path calls init_mcm_addr_lut()
through the IMU function table.

However, struct amdgpu_imu_funcs does not contain this function pointer
in the current tree.

This causes a build failure like:

drivers/gpu/drm/amd/amdgpu/soc_v1_0.c: In function ‘soc_v1_0_switch_partition_mode’:
drivers/gpu/drm/amd/amdgpu/soc_v1_0.c:748:32: error: ‘const struct amdgpu_imu_funcs’ has no member named ‘init_mcm_addr_lut’
  748 |             adev->gfx.imu.funcs->init_mcm_addr_lut &&
      |                                ^~
drivers/gpu/drm/amd/amdgpu/soc_v1_0.c:750:36: error: ‘const struct amdgpu_imu_funcs’ has no member named ‘init_mcm_addr_lut’
  750 |                 adev->gfx.imu.funcs->init_mcm_addr_lut(adev);
      |

Remove this invalid call to fix the build.

Fixes: 60481d95ad989 ("drm/amdgpu: update mcm_addr_lut data for imu v12_1")
Cc: Likun Gao <Likun.Gao@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index d06953c237ed..f09d21738400 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -744,10 +744,6 @@ static int soc_v1_0_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 		if (ret)
 			goto out;
 	}
-	if (adev->gfx.imu.funcs &&
-	    adev->gfx.imu.funcs->init_mcm_addr_lut &&
-	    amdgpu_emu_mode)
-		adev->gfx.imu.funcs->init_mcm_addr_lut(adev);
 
 	/* Init info about new xcps */
 	*num_xcps = num_xcc / num_xcc_per_xcp;
-- 
2.34.1

