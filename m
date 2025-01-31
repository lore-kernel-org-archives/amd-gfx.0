Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60312C02194
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAA5210E3C9;
	Fri, 31 Jan 2025 16:58:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ru0S+TJz";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8262E10E3C5
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWPS4ZcMGalYf1aa9AYbuU9P0Bktw1wFCjI2fpnnWN5zvz8dQHwDVggZLfNt78c56MOq/0UwtQ6cQ2R2M5hHua1jKUOZxCgcp2uyipJlZiokIBxhMeIlrhxo/WrPXaAd64f8ATdEK5EuXtvE/KbMTcekF/gFBWMAnLrOLLLGfQsM1vBLNjq7zzk7pjXlUbcYerJ/QOZmUKwiHlneNH3SXqqacymkv4otR/hKPjOMMSwjKGBzpjwgVEj/3yJvbPYD2DRKcs0nliGj8X2zvQfCs/nMRfpNLTO5psrJ1LwHxfRKTYmw0mN4dWBp5NX+mricloKiDDN/HnNP5MjdYZ6dQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nr77sKBjVydauZPQfIvRrtGsSqyXdyY2dp/I70C7+98=;
 b=CHOOTJke7TAd0iiQz8aWYZp/j4stMXTtNO1V1nNx7xdH3FepmHPgeqEvaFSCJewlGG0ana54G2OsFOHHrn+yLxOhTOaDKt4WA3gnTEt684QKrBB3SfksMNpGiW72b7q1q6L+JTHfeGzKcMu/ldWo14fHGYLFPhlIOwMkFjMyclWpt5/Hz3WFNU1b5pYw2r1yHchcF4fMGtKXLveDs98PLt6l8BwGTZTWCtncfvawlAmy3tg2gGHz/j0TcD7ERUIDBIiYt70+Enq0w/Mex44IIFHCP+G0exghq/zTvNca0wVyg5VdtzWBtj4xtgl/7HAldQd55+CviTKgLODXypq54g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nr77sKBjVydauZPQfIvRrtGsSqyXdyY2dp/I70C7+98=;
 b=Ru0S+TJzoQtdCV6ANWln+ykm56gb6Ke42sP2kz2g6Rz0Z+wlLRSSZ2+gyJcTwZcNukZP+7JhETgcT8C6EDj4hiQxCpExwlF4QhgNGcSuwIO3CD7klshXyywKX1x5juXfUS7DQBFxM8/+cge6+xiAyO6WMb3K1GXusetXZX6JLJE=
Received: from CH5P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::21)
 by SA3PR12MB9160.namprd12.prod.outlook.com (2603:10b6:806:399::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Fri, 31 Jan
 2025 16:58:17 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::15) by CH5P220CA0003.outlook.office365.com
 (2603:10b6:610:1ef::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 16:58:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:13 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 23/44] drm/amdgpu/vcn1.0: add set_pg_state callback
Date: Fri, 31 Jan 2025 11:57:19 -0500
Message-ID: <20250131165741.1798488-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131165741.1798488-1-alexander.deucher@amd.com>
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|SA3PR12MB9160:EE_
X-MS-Office365-Filtering-Correlation-Id: a93486c4-42cd-4142-53ca-08dd42187573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eaw2D9NdzrNBaP2wNpHyge2YxS2svLq6CAgqifD7GdRGhNIRyY8PB+JSbYz/?=
 =?us-ascii?Q?tP0ZaLSC3HLTgXoZVWy3V4IqbNt5+TPp3isq3qqJYWfHbrPDVukPbTky4YdY?=
 =?us-ascii?Q?UN1d3752g4eEZH6sukumUFkxqpAw+lduQQ6I2SXru9b8a/FsgJwKECdY7mJQ?=
 =?us-ascii?Q?jvtvRvhA7hbz65cacE5KNrqtdzDe0hXmzq+GZGjgx+SPlBE5M5vEVBHL2i1o?=
 =?us-ascii?Q?iYaApqDWN6izjtDIQKEjQmyTvOa1CP7L6hCKJPewIHbWe0n0oVIl2dkb8AES?=
 =?us-ascii?Q?0zPVR/Q+SFytjwwPv2KvCxb7U/o8+bGdwPvoltjQkZgEFvcCIPn/v5S8OZ4D?=
 =?us-ascii?Q?tKDdWANc5dKDPTONq5G74XWYq/HvDF6d74raq2f1KuOp1VF+LNj2htgGaWM8?=
 =?us-ascii?Q?YN9jt9s+ksD9IB725DHmogCLp/oQHIDh469nAVYsqhwHYSkPSOrSOtVnfFCC?=
 =?us-ascii?Q?Lht40oiOrBcj2Gv/yj94WICpWR5iQTpqQnaUfuxzO8VnCtLw1zjqwucc8U8I?=
 =?us-ascii?Q?7RzeCtooY5xldloZUMgl8k4HO8gfWVR/X7lTjUTkLEe9PvZZmKxXuv0jPGx1?=
 =?us-ascii?Q?j8Vj/EfQW7LSczX2cKndzYSdhQdhlt+1c+H24usk6cAqAxYHQ56vUc8pr/WY?=
 =?us-ascii?Q?dfz81DeIV9FM5GOSGxJd0BoMBOotffEeMrlnOI42aWaboEx9fdQ0nnyAj6Mb?=
 =?us-ascii?Q?L2MGu837qIDdRJsENbXhWizwE8NXQY7ici9wjtsniIhV3XBLhHwYfhB1YC04?=
 =?us-ascii?Q?lyRpjz4kdPRxukZSYxiDhC9t+a5IZeUHqDRIxO3acWTIlqC1YMIO8+a6fGbQ?=
 =?us-ascii?Q?2yuOD+z6cb0S+u5xnEjVKpdumGOSeXqEqOP0bmT3xTIqzFjKhxS/OtQeak7P?=
 =?us-ascii?Q?a6GuJNg/xZ7ikW1p3VvP2mQ1eicqwjASkHFcDJ5jBtiFo77Hf8ObPdJTMj/Q?=
 =?us-ascii?Q?86uaz7e3FHD5OGilx3u3caU8u69qJIUgk7sR9DMuiR3cJ97PgqOX0Km1ysss?=
 =?us-ascii?Q?eyScSYuHpeWYWiI0eX4tG64j9GVeHz2Lt0i3q05xVDWFseQauu/Q/73f53me?=
 =?us-ascii?Q?e2XP8WeT+yKEJV51/7Sm4dD7acBEy9MkI2VDKSfHcsQyO5eTvNr1EyXrix/k?=
 =?us-ascii?Q?Ify0YA8VAmZq5tJs+tqjOxZ9BMy/xgvMIQzsTSVo4dyMvoAW9ceLJT+ACPLk?=
 =?us-ascii?Q?Xr2LaVUWEoBedXhuHFRoxt7wejTTWye4sMr8tZLeNmAZiPgObdKMH1eVtNw5?=
 =?us-ascii?Q?64o59IqQm+lQYePmaivjeUp13S/Oqqk6j4Bfh6MR7FxbrPF/v/ZG1d6GcRBs?=
 =?us-ascii?Q?AsE+2xRGqgU2uKRHr4y2Fp2tIoaTXZga7j6Y2H0fmT0uhVp8AyMZ4Q1gfdWc?=
 =?us-ascii?Q?gbRVGpJKXSwTBEgTQk76NLKLFe7HxOhVXjq6tsdLin3V4ozN+j7OTkJfxrim?=
 =?us-ascii?Q?qPsDxdnvopoFrx28RDtgb8S7bb50uwhzctM81NkbznuBlbTFYiP1ZQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:17.2525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a93486c4-42cd-4142-53ca-08dd42187573
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9160
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

Rework the code as a vcn instance callback.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 32 ++++++++++++++++++---------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 3d56660fd90a9..fdb954c7377eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -85,6 +85,8 @@ static int vcn_v1_0_stop(struct amdgpu_vcn_inst *vinst);
 static void vcn_v1_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v1_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v1_0_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v1_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				 enum amd_powergating_state state);
 static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
 static int vcn_v1_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
@@ -106,6 +108,7 @@ static int vcn_v1_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	adev->vcn.inst[0].num_enc_rings = 2;
+	adev->vcn.inst[0].set_pg_state = vcn_v1_0_set_pg_state;
 
 	vcn_v1_0_set_dec_ring_funcs(adev);
 	vcn_v1_0_set_enc_ring_funcs(adev);
@@ -276,13 +279,14 @@ static int vcn_v1_0_hw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
 
-	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
+	cancel_delayed_work_sync(&vinst->idle_work);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-		(adev->vcn.inst[0].cur_state != AMD_PG_STATE_GATE &&
-		 RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
-		vcn_v1_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+	    (vinst->cur_state != AMD_PG_STATE_GATE &&
+	     RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
+		vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 	}
 
 	return 0;
@@ -1818,8 +1822,8 @@ static void vcn_v1_0_dec_ring_insert_nop(struct amdgpu_ring *ring, uint32_t coun
 	}
 }
 
-static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state)
+static int vcn_v1_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				 enum amd_powergating_state state)
 {
 	/* This doesn't actually powergate the VCN block.
 	 * That's done in the dpm code via the SMC.  This
@@ -1829,10 +1833,8 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	 * the smc and the hw blocks
 	 */
 	int ret;
-	struct amdgpu_device *adev = ip_block->adev;
-	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
 
-	if (state == adev->vcn.inst[0].cur_state)
+	if (state == vinst->cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1841,10 +1843,20 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v1_0_start(vinst);
 
 	if (!ret)
-		adev->vcn.inst[0].cur_state = state;
+		vinst->cur_state = state;
+
 	return ret;
 }
 
+static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					  enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
+
+	return vinst->set_pg_state(vinst, state);
+}
+
 static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 {
 	struct amdgpu_vcn_inst *vcn_inst =
-- 
2.48.1

