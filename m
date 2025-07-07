Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3366EC71130
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD0D910E538;
	Mon,  7 Jul 2025 19:04:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZyEdoeHY";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6630B10E544
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hObC1dg4lg9HLIPbdAnos3rc3P/U0vUEH3RmgHuN+JU80OErEUVYCxWeOwrwEwj/X0UA98UwziS03sL1eCoFwXBZGmZr6Fd92SaPgbYb470/qryUvgp1V64QaBq7FDioW1Sr+Cos0kyi93sIVdMfW8QL5ygM8Zlcq/7pMVuCuy/hz7+s9W8LksiBmdRWl/Z4oMIfYxD8MP8Q89HhxogbJhs3WwGskYB3WLQ16bok1Ch7TraRC/e0IDKkzotGUos7+7iydg+NGwiiFNSNQ1lT3CF2GXx5b3UX831lDWkCLlbGJ3LtBW3068uF6ycV+dDDZwA88jOZWTRESXdtLqT+KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FaS0B0TLnOh+VZysaaUHBY/Xl1awnizwQ+8+kHwKNI=;
 b=oi27XA9CS3AzPfa2SLd9+WTsbp5HxonScob2gvDERbgUlYE2373xXIJ6vA6f1I+lkLwjMOqZZocb5yYoVckDTTCR1kykV5phRssBd8kJflxV0EKL5WEaLhchChRr5HekK0WWshlKf/kLdEE7SxeMh5t+hA8Ev8wq4AFepK7d8dVCX3olUuRfmC2EwSJtQOq10oC/ti9PRwsLPkWXAzBlKzVDbS/1P1gw+CdfMZd4L8cnunFEai9idTpxsYGcr2leBigrJZmyPFrV7cKKl6LRbKCzfsBWQ7gV9GeqnV0yhzWtLuo+FAH4N0+WA+gqAtUQdpqyTW58W9uHBhM004nGaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FaS0B0TLnOh+VZysaaUHBY/Xl1awnizwQ+8+kHwKNI=;
 b=ZyEdoeHYfh8HEnfYCYi3lkAspy+pueYUW/J46kAYdHK28GnctuOz0UWsSmwy7mz4MsPnNZZZOO33X9AE6TvTlBKoBHIEFAyNTqrlCQXYWRjZGt7hNftpeN6+SXmdpU6bcGiDBMDWsksJeYzxBPHaIY4ZkaiSet9g8Ic35T+RE94=
Received: from PH7P221CA0071.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::24)
 by CH2PR12MB4264.namprd12.prod.outlook.com (2603:10b6:610:a4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 19:04:35 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::cf) by PH7P221CA0071.outlook.office365.com
 (2603:10b6:510:328::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 34/36] drm/amdgpu/vcn2: implement ring reset
Date: Mon, 7 Jul 2025 15:03:53 -0400
Message-ID: <20250707190355.837891-35-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707190355.837891-1-alexander.deucher@amd.com>
References: <20250707190355.837891-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|CH2PR12MB4264:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a3f23a5-ec27-4769-1ce8-08ddbd891cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6qKEMRSmWfPbhwZ/zXfNEDfxYYkyADx8aRjuXp78yRwgeg+L35cIDmcu6ets?=
 =?us-ascii?Q?4NRk/KULd1XHQroA7sJbcZCnkyWXgIkf1BnClx2ZQTw1ZG7jrvZYfc4qaoYL?=
 =?us-ascii?Q?dTZd0HNYn4CzN8bPf9/6hQDbdNxx89rcuywb14dasvAJr73RsQDhThZsKmlg?=
 =?us-ascii?Q?m5afhebOZo8g/az1r87U7xG/F2QHkUfN2O0qIJ1J8vayRS6cIrqtcTKprlVK?=
 =?us-ascii?Q?eLRF5NYbU9P10n5efN1PVrTMuXHZwgYJGeN3SaQsM3R/Y09wrbUvBfRM8zrI?=
 =?us-ascii?Q?PGPTZMMCXoe4T20tmxgNmN2HgB9U1OjbTtp8YJmkoXfbIFZYwUGmyt/MFT9h?=
 =?us-ascii?Q?o2/EsZp43jQJ3NLdqwoYZW83e2C2nNzccXV5Fz+IHip+5Kq05Z12zktqT9SL?=
 =?us-ascii?Q?LbMpH9RkhhXu8ONL7YYg/3jFC5iSTbdlFcQsfXD+UucnDbMlZmZxqfsHMuMY?=
 =?us-ascii?Q?sWuiSceJdaPppCgJKlsil48vcQfsRt0qykpnU7p6ZZvb1CEiYkHNOwIyhnEu?=
 =?us-ascii?Q?XmUgBKsHHwiHGAhQdYtjpczE3enyMwrhluE/EaQvmC7I3GemdlwLiIQVHMB8?=
 =?us-ascii?Q?g5FZBhsvwsVj/HxVVIV1P8tIYdbeGN5YUihXW1rNzCLHEGoftRxVS3lmpvrP?=
 =?us-ascii?Q?BJt1SSrfNUn2stjZzKKbiaunrTk1FmuHH7Tw6neqFo7Kh17Pdbn5r/wPK556?=
 =?us-ascii?Q?dIjKw4v8xTjzq+EQASMyMrpaan8L+AOpfGQig+IPqINpx3Om3lyCkzprLdfm?=
 =?us-ascii?Q?kAo+FCxgBm16+6EPMW6j7WNiF3BtMQxeVsO4yYMUs6TF3iagduJ/ksC1MTWS?=
 =?us-ascii?Q?p3zTSM526ELCrT3rMODbqXK+gTSfBBj2MMm7btCWY5Y0MkITCMmKkixhiA7+?=
 =?us-ascii?Q?MqORFIsSGXItl3OMN2tGqC4AZCbxdDk3gBVII0zizX98mNJiVo98N3YPyptB?=
 =?us-ascii?Q?zXtQNdXa5slv5jvc/6TVQeyMWqUrG5+ukZBTQS+GyTzMme26hn9znJsdPiby?=
 =?us-ascii?Q?SaaM2E8KjekhBvRTwY3ZF14kWABAt+y++8k5ygF92XYThMpISIIkSb5n3llG?=
 =?us-ascii?Q?1OJErcLnbg8TpEQH2YxhEgIzpXJAO0m50QIFWZWKuaf1LEo/Rzj2+veJ7sak?=
 =?us-ascii?Q?QqyWFMr/DQ/BGpqA1q97s+Dtk3I8BLL34PrTIBmBwRyy0ZXolsqm6ByemfnW?=
 =?us-ascii?Q?pfCVfJYFYmRXeW8BlnV+nleqdy1robFUON4DGMm6/LAdifFTSa5gmkD+sLTW?=
 =?us-ascii?Q?R5ZdRs7Wmqfy1I9WcCP930/7OrMz2yLkLAylt4blwZy1PX2f0m4ptrxu3rwW?=
 =?us-ascii?Q?X6r8+UU5fJFAmkzd3VTFyruJoz1/75HmqXCcY4zpNKqCQRrHhl8Dws1GPNhC?=
 =?us-ascii?Q?7PVzffAIVHBJlyerz3aKSFPa1slvskAWWlAY6NGC17cxAu+DEA/VWJu9bw1H?=
 =?us-ascii?Q?KinNZ56cRm4oROL3zGhtTgeD26txFV5p7OR+TqJMWVhdtsaEc1STzZ701cIq?=
 =?us-ascii?Q?iKlW5sUbWI/z+6+MEKknwCIg7VAf7R72Pbsd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:34.6494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3f23a5-ec27-4769-1ce8-08ddbd891cc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4264
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

Use the new helpers to handle engine resets for VCN.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 148b651be7ca7..00ed157b88f07 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -98,6 +98,8 @@ static int vcn_v2_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 static int vcn_v2_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				   struct dpg_pause_state *new_state);
 static int vcn_v2_0_start_sriov(struct amdgpu_device *adev);
+static int vcn_v2_0_reset(struct amdgpu_vcn_inst *vinst);
+
 /**
  * vcn_v2_0_early_init - set function pointers and load microcode
  *
@@ -213,6 +215,7 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	adev->vcn.inst[0].pause_dpg_mode = vcn_v2_0_pause_dpg_mode;
+	adev->vcn.inst[0].reset = vcn_v2_0_reset;
 
 	r = amdgpu_virt_alloc_mm_table(adev);
 	if (r)
@@ -1355,6 +1358,16 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	return 0;
 }
 
+static int vcn_v2_0_reset(struct amdgpu_vcn_inst *vinst)
+{
+	int r;
+
+	r = vcn_v2_0_stop(vinst);
+	if (r)
+		return r;
+	return vcn_v2_0_start(vinst);
+}
+
 static bool vcn_v2_0_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -2176,6 +2189,7 @@ static const struct amdgpu_ring_funcs vcn_v2_0_dec_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 static const struct amdgpu_ring_funcs vcn_v2_0_enc_ring_vm_funcs = {
@@ -2205,6 +2219,7 @@ static const struct amdgpu_ring_funcs vcn_v2_0_enc_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 static void vcn_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.50.0

