Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40A7E7717F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 07:54:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71FD110E80B;
	Tue, 10 Dec 2024 07:54:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M/rMq/Xu";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0921310E80B
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 07:54:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0McndaERwIXODK2hTK2Kpg2dKD0i/LL0H1FBe1wiL5eeNw7Z98T9Fb2k/QIVlENh1MtoJUmco/Gaco0V2IDDNtr9xTA2WAkNPlS+kCVVazcNkl5pDmkY8SnNYP3el5tDVUl/DheP6kC05dkgUyW6L6SBKZOsYWs6/mRMNcMBO5vb77q1GRY6kVIF4H2T2FAhxzOK1Ed3DpbqYKBpi5ensL7KoCBbdfmha6Z62IXJHXEMF0dzFNDlTKPoXdXElZb4m9yZFkuroAyN1mSCAuAF8V2heC17r9mxm67IyNHCso7fBybZlsWMz0S/F4TLxXa62NTrRa3FMZYP6S1aTKncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1esD1UDanXi/sKVCTwFeVlgLq9QGRhlfLUnShJX4NY=;
 b=J6LKI9+HMDQRKfZckRj6Mq7B/HI4+CnZvnXWloFBtpcRs9CxMcjZzXQizv7Dxq/FjRWO0yfDSuw157I/eYtXz8bcp5HuxBsR/PSXEe3P5S4GCq5vYxjKFpH6K47bhCwxisLgJMNgTtUOCdYHIoei8L+vdABcFIT11VS3OpfwAtvqc2znDK6P2RhZ8lvYzq+pVaWw/zb1j0HrYV664k3+xV6CVOaDFK7NRVVBsDfyyYN/2tY+f9RxYK9Vdj8Nm/FcQxML6Cz9a+OxRUqWNsQCXwwkVKEOydeBidb+GlE5eM607C7esZR+IG7TqG2Fbas9Qe9zrBt4wuw7ythfpvnSZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1esD1UDanXi/sKVCTwFeVlgLq9QGRhlfLUnShJX4NY=;
 b=M/rMq/Xuf6DD6pOZhnGBVWOFiK6/X/HKs9hlTtND5km5EloSKmxZKlh/NqHyOzl6DhWFa3Uu1e2QJEUHgYfCe+2rzKWLGiAhKv0OqsUrr3GyW9N7NQMbFPygeuQDUIGhY9CDYrW6PngYxSjK7JIoRRM67/4smfpu5dcZj++zNvY=
Received: from MN0PR04CA0029.namprd04.prod.outlook.com (2603:10b6:208:52d::34)
 by PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 07:54:36 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:52d:cafe::b4) by MN0PR04CA0029.outlook.office365.com
 (2603:10b6:208:52d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.18 via Frontend Transport; Tue,
 10 Dec 2024 07:54:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 07:54:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 01:54:35 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 01:54:35 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 10 Dec 2024 01:54:33 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jiadong Zhu <Jiadong.Zhu@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 <Tim.Huang@amd.com>, "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Subject: [PATCH 6/7 v2] drm/amdgpu/gfx12: clean up kcq reset code
Date: Tue, 10 Dec 2024 15:54:32 +0800
Message-ID: <20241210075432.2183404-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 873b8dc1-803d-4382-adb1-08dd18efe43a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m8852EV3LJnPFZjN758tE/jDoHc2mqPmBla9KiL/r67sGodyxAL6WbsQqO92?=
 =?us-ascii?Q?+ipdvjQwDAc99IPXUTQ9Li5LINjYMYzSHc/zDyBjpCRUYrnmG44lvM8aZLuh?=
 =?us-ascii?Q?rgltzI1tx1USavZtRWqSuFN608ETp+t/JLn6/YDrvNJ4bucrN5hnyyr3UFMM?=
 =?us-ascii?Q?tcvHr7qY09vz6K+Bs44II0O/TAjy+gxmZxZBdHNlvxkJ3SZc9vbh0bxr3yjr?=
 =?us-ascii?Q?CPEnUZMYZNXzhaguLloQDhnUrbjm9KmcBorW8xmHM8EK46HY6lOP/kr+zmpA?=
 =?us-ascii?Q?2As+p7Q0nMGnOtA2n9ajwJHGEtywVmhUgSo2sF6tvqYO9Mp6P3IsYysPHMre?=
 =?us-ascii?Q?f7RRvNmcbg6H4DbTES1d8ciZ04HkI14ie+9YOFLZPk9XOsd4dX7TaquW2LWq?=
 =?us-ascii?Q?0clVZZ64w5IkJ81I+75X0tYvPLGumCc8SqSNRU1gWqxtBtAVWcLXd+ONj6Q1?=
 =?us-ascii?Q?rySlWZvgCG9d5KBGG443C6QX82LoWH36dxsEfFxPBAhclwXdvjZANI6TQtFB?=
 =?us-ascii?Q?X66wElXPW0O4qIBXH7moltgQA9sdNZI40iOeFb8wKa3mhqSR/x1f4xldHLTY?=
 =?us-ascii?Q?1fjLGDI7teafTJoYMvQ5nDd5/BpN/i+JTivlyaovtXDJ+ZDPk9EZwXYVTx2b?=
 =?us-ascii?Q?0RdqFPnqcQwmhoO+IDaiSVmsPJI6/HsSz0yioVBn3WK+D2mCt3M/J7zIXrQT?=
 =?us-ascii?Q?B7tmhAokotXyshEiIxEg1KVVYUwSQodgNcxBipjmm8Ipyw5KxJVapPBKa8wY?=
 =?us-ascii?Q?c0w7w8hFXBM2h//EMqLIL50mvRp1sVa7poackhRKfAvqCyQpm9cblo5cv8Na?=
 =?us-ascii?Q?MsyHilw+d53nPo00bCZockBDJ1VhlVEzfQVOm7Reu6A0GljkdzS3AJ7SVXgo?=
 =?us-ascii?Q?B6ktB25qDpy0FGMYaoqFkuKSXzeVZ3HPIbxoTjyYKI3M3dHt+uWChsLBWpZX?=
 =?us-ascii?Q?+1DIEvimvzRlm/rRL9z5SNXJR6ZkJdNVkBEtLXttM0jnU8gMuIG1SeJZdlEO?=
 =?us-ascii?Q?bgXATebtyLgY+Ks3HlxbQ0TNaPPsByAOoKRnVh0hBONshnkPMSlF0KwNR4QC?=
 =?us-ascii?Q?sARwWRjrHjXhIOrTwDZMjfjF61T1j4ASwmgQ7JqJL1XT8LZbP7HE4egw7wq2?=
 =?us-ascii?Q?yYhrDwglh/ldaEokdR3/eiMmQjw1pRpe2HCBPUhQlw61qPOjDYN8JvYYKB7M?=
 =?us-ascii?Q?vJqpAaqeaA2jMvZogsTUe54QRIRUVACmfqvDgO1Wm93KaFCsY1mJtFlDOlW3?=
 =?us-ascii?Q?RCY/R5PAOR0koVGVlEex4YWQAuY1ECtL8/xWHcDLVxX46YWwvm/DHtNdhxZw?=
 =?us-ascii?Q?TKYl2Gaeqe7nglyWimOp8yjv5IT49kwIWMxlLgcfUMbbvnSBI9DVWN3Dnlg0?=
 =?us-ascii?Q?UIb0Y5MGhBV1nktMfc8HdooorvqL5LQY1LupZi7xutU7PV493R6atDTXZpWK?=
 =?us-ascii?Q?OnsQYjuJz00Tg/ekN3fF6OSAk6+c9v8T?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 07:54:36.1154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 873b8dc1-803d-4382-adb1-08dd18efe43a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470
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
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index d0697b0869e3..035fc392526d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5277,24 +5277,16 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int r, i;
+	int r;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-	mutex_lock(&adev->srbm_mutex);
-	soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
-	WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0x2);
-	WREG32_SOC15(GC, 0, regSPI_COMPUTE_QUEUE_RESET, 0x1);
-	for (i = 0; i < adev->usec_timeout; i++) {
-		if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
-			break;
-		udelay(1);
+	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
+	if (r) {
+		dev_err(adev->dev, "reset via MMIO failed %d\n", r);
+		return r;
 	}
-	soc24_grbm_select(adev, 0, 0, 0, 0);
-	mutex_unlock(&adev->srbm_mutex);
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 
 	r = amdgpu_bo_reserve(ring->mqd_obj, false);
 	if (unlikely(r != 0)) {
-- 
2.25.1

