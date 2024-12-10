Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E90E7717F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 07:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C3BA10E80D;
	Tue, 10 Dec 2024 07:55:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N3gu9nOI";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6813310E80D
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 07:55:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtX8c/eOgDamz3KQ+BuL7dZeut1RY3Sz9nP4kJux53AYVJL3dogyfL5siRMeDI9e2wJYH2RnOT8IDp0UBvJElTHoFRlSda9pFHK97angnhd/VNx+0HCavFmAFXmPUARk3CsKcZXE0pJaxcl+Ship01y4URpWqMFBG+nORs8hLzF3iEXrxg4h2iSYd+8wG92rJaTI+mNgNgvSRVNuIm4LknhiLUevG7NQr8NChb4VsiZHEaYN8Wi3/SLDsR6cnG3wv0p7TfY4JSlSgFX3o+RDoL8M2BtIBzngdP/8iq6UaXfxhZnaGYo5w/7IVAaG5+hhuNbA+2TB5cdHtt68dmXt8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70NSSo9SXYNIVgIyvYnxfcIu//OgvJZvJ2Xi+lzY42I=;
 b=X1JLkZiFtK4qQS/0UYHwcQtb+1DhkN3npVGPprzk3ekfnhGjgaJgbAvAIkNmmaAIBl7BU3xi9MeNW1ckYUXlJIkGUECToSua485OQ1sHzdPwVmGgMuT2G00moVyn2HtSAkAdf5zVyNqebqyAMKFyAftmIMLRM0wWx0pxPywX2QTNSy1u7nmEkeyxIx7a/1fykjUTZHD4bwnD65zVaMmiD5kWDnWu6yXgOr5QwHUc/bCAGrBJM6PEEBykf5zxTx+ImYoBDVdOQ6YnAj/riezKHgXgJ8gCygl0SipkldeXFLX29fkSMD7t2R/yIuehaYBfg1UZ5znw+fpt8C+OECxRew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70NSSo9SXYNIVgIyvYnxfcIu//OgvJZvJ2Xi+lzY42I=;
 b=N3gu9nOIcOHdhVgnLXuqLFpL0/7q1XLmpeo43keQhoRYcUVNRsiylaH53t0X5EpJh2nAbfodjPxM6QeyHkH+UIzRGYq/RHY2lu68wx4eYDAAOIj6ZFNTD72xZ9Yq+vAMiyufVwcp8N3qEOyKl4nGgeBfn5ZE1dFYmfV3w/FeEw8=
Received: from BN9PR03CA0340.namprd03.prod.outlook.com (2603:10b6:408:f6::15)
 by PH7PR12MB9076.namprd12.prod.outlook.com (2603:10b6:510:2f6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 07:55:02 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:408:f6:cafe::ab) by BN9PR03CA0340.outlook.office365.com
 (2603:10b6:408:f6::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Tue,
 10 Dec 2024 07:55:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 07:55:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 01:55:00 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 10 Dec 2024 01:54:59 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jiadong Zhu <Jiadong.Zhu@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 <Tim.Huang@amd.com>, "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Subject: [PATCH 7/7 v2] drm/amdgpu/gfx11: clean up kcq reset code
Date: Tue, 10 Dec 2024 15:54:58 +0800
Message-ID: <20241210075458.2183464-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|PH7PR12MB9076:EE_
X-MS-Office365-Filtering-Correlation-Id: baef0161-4c93-4426-db4b-08dd18eff3a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vTc+5MT+3G4POaDzzjzi5EVbLg3vP0WSRPZ7TkWWtnFFO7+8vT34pOg/sJFG?=
 =?us-ascii?Q?2qaRVNA+OCISqi80l3zLmVJGF4chJkJF4tQrFszcvrLWm1Wqhfh4BP0fld+5?=
 =?us-ascii?Q?RwKcZ6ifXEzGWKxTBShxJGEc0uG0ta0BAal2qJ9T5qGzDZGc6xrCmduTe37f?=
 =?us-ascii?Q?FPECcKsXV6t/Yt0n6Zjg9w2tPYVrUQyspQZucobzSRQcTcnO1/0bVfNE8QPH?=
 =?us-ascii?Q?ROlqxYXBKne4AwKsKShV7O7uqzc070qanrCQLRk+bhKvB3OeXH/4NfZYhzEB?=
 =?us-ascii?Q?j6iX1uxgzPEl+80lA4ZFZIG+Ts1o80OaaH4qJIdermEtlvhsE2CghwazLRxC?=
 =?us-ascii?Q?tG38DI9WkW7g2Erp+4VEiinhMu0DzMvCBpWVDOt+PXXgUEUtY6nCO9/Gr9An?=
 =?us-ascii?Q?kE3McwosZhJPQOTBBR2YeHPuSl8WUAeFT56/T84XRv3ks+zUA88SYeswPxmh?=
 =?us-ascii?Q?9yk0KrZ4eGpnn4h4pSPrDGuAGRrWaXQoM/f4uiKlTSyo6KciG8e/YgZv5jzS?=
 =?us-ascii?Q?Yn1s4XXKj/HpwD07pUjNRO/w3atJbl5+M4/8OepqWVrKja/raoFMnHmpk6MS?=
 =?us-ascii?Q?S3LXs1x1jApztNjK9HSWWkDVk3nWAmngw+C273j0IeBAUdauzlPLQ66KpIf1?=
 =?us-ascii?Q?Wm7irY8n2R+AwxPilUPanGfaA9GFpUWFMw9n/H9g++yLkXHpa4e3gv6A4g3e?=
 =?us-ascii?Q?ZEt3j3EX0kyep6gNelvsMHhnfvzLo6wRTOq5W6m8uVm1eoPbW/78F+HYAOUl?=
 =?us-ascii?Q?FzpizGczIJaaVdFfPhYcnQGBxeuGywmr0oX1gO7xO7HUaBiB+rka70Me/56s?=
 =?us-ascii?Q?6s9/2CHIzZANk92YqcMcgnt6j9or4tXtMv512NRoASMM2tphoLg6ztFRM2o2?=
 =?us-ascii?Q?yho0KfJ5sVkig1Gy7qFLqO8xDzyoSi8fwW8OkR840npE9+1eT6z06bRqcZP1?=
 =?us-ascii?Q?6fDEblIR6S+igz0nYKgtb6kxaDMJ13Nm70KGA4a7bIL0Win3g8+v4vJLMm7M?=
 =?us-ascii?Q?nVOepQCjErXyyR+jLVDfJqUGnixP0/5ySH3EXUsOa8+GZAWvMLqoQv6mXWNN?=
 =?us-ascii?Q?3XwvWv/agUxbr8+a5LzmoD6hOVLUlLQU2OO619TNzWAvAcrcSjYB508T29WA?=
 =?us-ascii?Q?BmZQFnrD7SDTfEYGOUjphThiDFr4Wt2/sMPhP1yjC4nBFejTxwqFD6J4EG4I?=
 =?us-ascii?Q?71DpCcpxZaLn0zmA4LIWrZ3DC4Gho+fr0Aw18fAXUJlWfpQxZ0XBkMdSwtie?=
 =?us-ascii?Q?diNGEfurjPNK/0H5N1lA41irW1qH03JpRKP9h6sApq0DBAhnBsfQedOqCSGn?=
 =?us-ascii?Q?CrzMHFLzSZ+0l6LGtUnHsacbK7Q5tcGZVwktuAFmj7Rieib3gFXAcQGvx0F+?=
 =?us-ascii?Q?dWVQIBW6yL7iB08y9KzktGqnYU7gU8W1A64sAFi6eloTre9zj+dsWh0ZGz8r?=
 =?us-ascii?Q?EzRsZccqVfF8eCLK+EcFwSnzKL5Uyjmv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 07:55:01.9836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baef0161-4c93-4426-db4b-08dd18eff3a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9076
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

Replace kcq queue reset with existing function amdgpu_mes_reset_legacy_queue.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 67cd42031571..b741dcb0a5a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6675,30 +6675,14 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int i, r = 0;
+	int r = 0;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-	mutex_lock(&adev->srbm_mutex);
-	soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
-	WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0x2);
-	WREG32_SOC15(GC, 0, regSPI_COMPUTE_QUEUE_RESET, 0x1);
-
-	/* make sure dequeue is complete*/
-	for (i = 0; i < adev->usec_timeout; i++) {
-		if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
-			break;
-		udelay(1);
-	}
-	if (i >= adev->usec_timeout)
-		r = -ETIMEDOUT;
-	soc21_grbm_select(adev, 0, 0, 0, 0);
-	mutex_unlock(&adev->srbm_mutex);
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
 	if (r) {
-		dev_err(adev->dev, "fail to wait on hqd deactivate\n");
+		dev_err(adev->dev, "reset via MMIO failed %d\n", r);
 		return r;
 	}
 
-- 
2.25.1

