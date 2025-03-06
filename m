Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89471C282DE
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 18:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 321B310E296;
	Thu,  6 Mar 2025 18:46:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OHNjFwVX";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0057F10E296
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 18:46:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0OGvGEXcnqwsmKgqgnOvoox+4j8tAJk64l187z0XV26OYQV/BIYi0bNuQE4LW1YqV4Fl9LuePitXvgSeN/7rwD2Sq6xRnXD6UqptkyF287x3c6jicMoEEz95eczwhE6IR4iu2dUsi6hieKLuUtpTkDlJkWo1dQ1QKjheXPxj3DMyT5G2Ru8CRrHK37iCnsJ33HAACsNdrrC624Vq89s55cBci/36MSsN39o2fXVq6Dc7Q8rH87u6GQ72OfmUgTbgIJbTB1xcCGS9wMp/bS+irvRlABC8CwbOnedHkkicV8rOrvkoowIGjAK957L6mwFwLCXT8uhOXylzwbYkePcYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8I7n4FYIXL5JB19nXbhRxggfIlhsfRJ5RC5fwuhqOY=;
 b=TTzYTD8hO4vVbq22/omjYP9IrNvqIT3GAoPUuHfjbLkGHMSdpZhf7M+OPMrGQ1BDjIckCl7TLtycOsPDPjjFd7ADROag38JnX+6fCKoOyEFjGUP18mgNoU7K65nX8zZGMRzF3e1O9vd7pdeZ9SdMYJ5pPc8TZfW6sPcvM/dBXBXg2v2G1Vqb69zO2AobwEV0nPMFwPoWNAnl5rH9X/uQ6HdyGoMRu4bOmrzxQc3rLUZH8OjuSWdbS0fzOThrBgmGg7yHLsqblJc1DQG2YlIIBt3/D6OcJ8XDvQnC0jUl6d49/bfqfgwJuSv+76C0lOP/J+dQtDwbPvLKdgszCfQc1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8I7n4FYIXL5JB19nXbhRxggfIlhsfRJ5RC5fwuhqOY=;
 b=OHNjFwVXmVgVFlDpsvld/UK76lqF66VqLSg4gahMd10VzndJ/TljD0jKMd3qA6bRwEKS7K+d0ic9NXuC2tT5f5yHv8gwAyxaufwHHlI+vuuuY5X5TRPAWkqWAeOYG1xlasm+AkeAP2RJd4PW+eB0icLuDCbiywZ49u2Zu2RgYSc=
Received: from MN2PR01CA0037.prod.exchangelabs.com (2603:10b6:208:23f::6) by
 SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 18:46:30 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::9a) by MN2PR01CA0037.outlook.office365.com
 (2603:10b6:208:23f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.18 via Frontend Transport; Thu,
 6 Mar 2025 18:46:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 18:46:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 12:46:26 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/11] drm/amdgpu/mes: centralize gfx_hqd mask management
Date: Thu, 6 Mar 2025 13:46:04 -0500
Message-ID: <20250306184612.8910-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306184612.8910-1-alexander.deucher@amd.com>
References: <20250306184612.8910-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SN7PR12MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c91af8-5912-4393-1b46-08dd5cdf35c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GGuntQLwke7M+AYfhOHyfhHstFacekx0o/X2lkbo6JgBJCq6tVjGkcRHBYz3?=
 =?us-ascii?Q?cwrhir6yhhZXg54JBT+S3vZ/BMc6HKGvl1ZDUb6nkREyiAfWHJd6fXR4bioJ?=
 =?us-ascii?Q?u2OGvL60hX76F9GO2VghheQ7ygA6+aTAyuVSfmeikmoVR44Y+NL4lczyUgjr?=
 =?us-ascii?Q?x8qK7aKmnVL05mRvEBKkDV4+AAqLGlmdGorDiUQ3GLwT/rRztqp792l6SCIt?=
 =?us-ascii?Q?1o6AnPo/+IU5Ibxv787fPWW3gMa3GQbnXdnoM26cOANqB4lFvGNr3KrffJiy?=
 =?us-ascii?Q?qpL87u7iOMMK+NCbHEpp35MjqIFQkya2Jc6gxSId00VsQq3oc7Ys8QgA48Cz?=
 =?us-ascii?Q?E/ro7PJqetdyyQnn9RqEixJCszH7QqIEN7U5ZeKyPFXy6wCq2Zlnf8PW02p2?=
 =?us-ascii?Q?eXl0ImqAxLfVnX0P/a77IpK/SuMV9IGcRFZMa2PrYB1VrQccKz56kYDMY0E4?=
 =?us-ascii?Q?mojRiwy0A0vL7ocpaiDPM5kgwJI4/LJ6f9x8pNsLECPJan7Civo3Axy4pyOV?=
 =?us-ascii?Q?vFgJI3IIxEIEXuOdKrrZHPdz4eV7SesuVlh+mkOs7r73dlv1Sl9jkKP2Ad8v?=
 =?us-ascii?Q?BlPDbfrluPcSWm6mJUA12gIQYV59/jfvz5eAhZIhmwIUzOLtcX5O0EQ3KkSJ?=
 =?us-ascii?Q?l2yQQhT5n7ByabMORtbtAPFtv4MJkPWj6QRQrGWls/kAZ0FRW2+Cn9LsBQH3?=
 =?us-ascii?Q?8z656oLyadkZslOUCOvjxUenlDym08eTRM6CZOBodY/iNarabizNEHp5dWbb?=
 =?us-ascii?Q?3dyrV1THAfxDftzPUzvgvw522i43Hb5qbrYfLoq5LC+FsmWgP3BbRvwhJ7zR?=
 =?us-ascii?Q?j2/tC3/uU1TppfLvfMZFTb4kXEtaJypaOAtQaf+3n7NdQc1VDfct5nu3/XSq?=
 =?us-ascii?Q?8CooWtMChLGwrvjF3PsYGefWSHndDCXPZO5XSET+dFyajXuRjoB04ya09bsx?=
 =?us-ascii?Q?oG/fDjxRbBMZUfmNjP5pPsx7lw1ydVBWtDjjXqkCqnQKRyWbDxsklzoWBOLM?=
 =?us-ascii?Q?hSknbmvsmAce1zbB5Sx41RoNSkLrRXIskhk9Jt97gG35wdhweqoq7wLemvxw?=
 =?us-ascii?Q?rX5rnI9Xs2zvAVHndYnT5CaLfZx109Hk/eoXrHBaz51LbNoPZVmvGDdhJZy6?=
 =?us-ascii?Q?cBzpvn4kQUUsQGJ0dOTzpuE+RqNfsB2MpJNfVY1EcSBFrurCduBd5Aiego++?=
 =?us-ascii?Q?l1Ylfs/Q2LUyvUniWS9Bg1f+vgtH2L8rRAOVVdARMQzPBQFOkDcae9TCJlZx?=
 =?us-ascii?Q?7HfDBQoW4ieFmc2cdwLrx80PjCL0QKVqZZ9g1TeiLXa50VKLOjyUSzkY7TyH?=
 =?us-ascii?Q?5SdE7zqk1vWksd1C47rR3pJfw7JdokxVzdoQT6fOAow3jJyXHA4yM+7IodoF?=
 =?us-ascii?Q?K/xmO9Z+ANVakbdm4I4s+BgRsenc54THAS/B4fu1uVnQconePCJjkVnhEkd3?=
 =?us-ascii?Q?htfr0Jo/s6JUizLVRHmhIDuUws0j4VlgzN8FJS01ae237ysr7/Fnw8GAkpqa?=
 =?us-ascii?Q?ukfVztmhdBop2rQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 18:46:30.5320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c91af8-5912-4393-1b46-08dd5cdf35c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7835
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

Move it to amdgpu_mes to align with the compute and
sdma hqd masks. No functional change.

v2: rebase on new changes

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 22 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 16 +++-------------
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 15 +++------------
 3 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index ca076306adba4..5913c5ba85ed0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -144,6 +144,28 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	adev->mes.vmid_mask_mmhub = 0xffffff00;
 	adev->mes.vmid_mask_gfxhub = 0xffffff00;
 
+	for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++) {
+		/* use only 1st ME pipe */
+		if (i >= adev->gfx.me.num_pipe_per_me)
+			continue;
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) >=
+		    IP_VERSION(12, 0, 0))
+			/*
+			 * GFX V12 has only one GFX pipe, but 8 queues in it.
+			 * GFX pipe 0 queue 0 is being used by Kernel queue.
+			 * Set GFX pipe 0 queue 1-7 for MES scheduling
+			 * mask = 1111 1110b
+			 */
+			adev->mes.gfx_hqd_mask[i] = 0xFE;
+		else
+			/*
+			 * GFX pipe 0 queue 0 is being used by Kernel queue.
+			 * Set GFX pipe 0 queue 1 for MES scheduling
+			 * mask = 10b
+			 */
+			adev->mes.gfx_hqd_mask[i] = 0x2;
+	}
+
 	for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
 		/* use only 1st MEC pipes */
 		if (i >= adev->gfx.mec.num_pipe_per_mec)
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index a569d09a1a748..39b45d8b5f049 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -669,18 +669,6 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__MISC, api_status));
 }
 
-static void mes_v11_0_set_gfx_hqd_mask(union MESAPI_SET_HW_RESOURCES *pkt)
-{
-	/*
-	 * GFX pipe 0 queue 0 is being used by Kernel queue.
-	 * Set GFX pipe 0 queue 1 for MES scheduling
-	 * mask = 10b
-	 * GFX pipe 1 can't be used for MES due to HW limitation.
-	 */
-	pkt->gfx_hqd_mask[0] = 0x2;
-	pkt->gfx_hqd_mask[1] = 0;
-}
-
 static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 {
 	int i;
@@ -705,7 +693,9 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 		mes_set_hw_res_pkt.compute_hqd_mask[i] =
 			mes->compute_hqd_mask[i];
 
-	mes_v11_0_set_gfx_hqd_mask(&mes_set_hw_res_pkt);
+	for (i = 0; i < MAX_GFX_PIPES; i++)
+		mes_set_hw_res_pkt.gfx_hqd_mask[i] =
+			mes->gfx_hqd_mask[i];
 
 	for (i = 0; i < MAX_SDMA_PIPES; i++)
 		mes_set_hw_res_pkt.sdma_hqd_mask[i] = mes->sdma_hqd_mask[i];
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 96336652d14c5..519f054bec60d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -694,17 +694,6 @@ static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe)
 			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
 }
 
-static void mes_v12_0_set_gfx_hqd_mask(union MESAPI_SET_HW_RESOURCES *pkt)
-{
-	/*
-	 * GFX V12 has only one GFX pipe, but 8 queues in it.
-	 * GFX pipe 0 queue 0 is being used by Kernel queue.
-	 * Set GFX pipe 0 queue 1-7 for MES scheduling
-	 * mask = 1111 1110b
-	 */
-	pkt->gfx_hqd_mask[0] = 0xFE;
-}
-
 static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 {
 	int i;
@@ -727,7 +716,9 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 			mes_set_hw_res_pkt.compute_hqd_mask[i] =
 				mes->compute_hqd_mask[i];
 
-		mes_v12_0_set_gfx_hqd_mask(&mes_set_hw_res_pkt);
+		for (i = 0; i < MAX_GFX_PIPES; i++)
+			mes_set_hw_res_pkt.gfx_hqd_mask[i] =
+				mes->gfx_hqd_mask[i];
 
 		for (i = 0; i < MAX_SDMA_PIPES; i++)
 			mes_set_hw_res_pkt.sdma_hqd_mask[i] =
-- 
2.48.1

