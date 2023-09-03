Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFABC71153
	for <amd-gfx@archiver.kernel.org>; Sun,  3 Sep 2023 06:52:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A52F10E0F0;
	Sun,  3 Sep 2023 06:52:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9ECC10E0E8
 for <amd-gfx@lists.freedesktop.org>; Sun,  3 Sep 2023 06:52:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdoHu6EpqP9wcpDtWSMkUP3OPtq2eu4gtWZFpDR+T5BpilN2cutTOnDpdrB/HtOCvPEme2rdHbUeVzpCHNvurJ0+emEQxkd5aywNyxjEmjSp/BHaUkechVlTRydjYXt6naGX8LQHRUfDc0ZEpJyyZmfBZvqIrOTfW54j2Ma+b/AjEtxAPY5tkAHQJfosSTMsJaLf1RnhyyeZkFxxLZz9ESz41cQxJAbe4ejy9s4MDV4ndcnXPT0Mwv22ECEtLWoB2R/iFWh1wm3v30m5b7u79++y+zLKNIpDlQicrReaUEVF0q/YQZg/xqq3hK+kLE7rtQjvIOVXrRsaitPSDxqayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YruaLGAFLPkjHBxmV/AKa/jpcFBpYm5Fm+NIfX7ns3Q=;
 b=eJi5JQasP6ws/5LnjmhsVBoRteJ7GFnDQteEtSwmQb2SG1QUlpSmE3B+jurDUD72CFourMf1wWevaqJS70ZurZJUpAKOD02CCdq1nUWJ94u7lPXNFru89dDAgMgMoBbGhKrl7s0Z6F0xfo/RIWvzMRNd6q+F4m9qnzxLg6NpGzRwb1qrX31Tpb40IAhglHZwzksRVnmjAUglIqsJSyZVa+g4nLTukg5JKlxyxnbPuTevdAi9DVnoYoPDaSOzxNuu9f4bAwYl30gU3bpJS7O8n26HoHt4bA1nCyemkpvlKtb4zDczMhHgzN+DeOYPzfRxL93zgsKgwiFpxqmDvZHQuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YruaLGAFLPkjHBxmV/AKa/jpcFBpYm5Fm+NIfX7ns3Q=;
 b=lQ2OG2fxYxTzGiqXgb8rmW0G1QzcO3G27f6jPrtautXyfy8ih7JuJJz8Upo0rdD6VPsYF18TdKUeMAO0D9pfOS/93L95KV4DNEoSKakNhb/TG58rTTHsal2oHldThgwMV45rdWKBsLRA+7lWhzIBFPb94n/D7RaKEj3H8pfI1Dw=
Received: from SA9P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::34)
 by IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.28; Sun, 3 Sep
 2023 06:52:44 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::ab) by SA9P221CA0029.outlook.office365.com
 (2603:10b6:806:25::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30 via Frontend
 Transport; Sun, 3 Sep 2023 06:52:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Sun, 3 Sep 2023 06:52:43 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 3 Sep
 2023 01:52:41 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Use min_t to replace min
Date: Sun, 3 Sep 2023 12:22:25 +0530
Message-ID: <20230903065225.1976529-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|IA1PR12MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: bba8f1ab-54fc-4154-98ba-08dbac4a5fa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Db5ZtJ2Q99QyZea83BRDkAimGAf5kxKj7WzrfuLXdlydVzg9C+75qc0QGFaSw8PHPkS1q66Zh1e3H7wUHkBdz8Yr4z+3d3dZvBLuaiGMWuwehlEYK9VIXwAvsjkYVWvErwIdN5aErPJ1P8w3RihIvCiqGyu5rTh3yzVi+cSxs3JDu0ySi/tfV3czuUAlTbXJ42j1BVgSWtzbLV+HTxnu+OOTu0ZBskANkGNp1s92r+rKrX7kZwwk03axSeU4apP2npPnTnCm/kt42RAv+D1BCtGo46RJRTrePbUHa0JM9EeEx9LlzRDLfCumwNzDlupgCA0TzvnIHQQG+8xO5ryjyVYS/tZM5E3cAJSLf4UjZT+WuPMnhPf47dwh3GyVorU3xWtuFa/8+tvoUrfKnv36xqPGj62Xtm4Tv/FCGba2Ptif2MZwWRJWmMT76KDFMjFngTArA8tBmotZryZ/4HRf+5C+o/kxYUWHcMXVvpZii2fxNehnoZuJgPhdtqIFqV3HTySY8bq+bYiq0FFY2JsAj1bXoiC0xCLK+fnCFPVqT2BLM6Pyynic5oHiAdFh9yvBu8MJf5ZjGrOSl94MFmPIZljiaGZSrkqNEdYt+Bwxrh2hxmmzQDTWKiJ6ZuTxyShB6gF/dWicZ4Dhh2wJSGresZi68bKTthJ/kg5cUR2A0EEzhIC+1O8iJMpyXYGgDF9tCfJTTR7E6NCwQQZ314iEWlX465mmo8zOIpMcXIh9x6e4Who1lPqldLB1gbOiwImhdQAQS7ftaweFF5LunZ9dZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199024)(186009)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(2906002)(54906003)(110136005)(70586007)(70206006)(36756003)(86362001)(6636002)(316002)(40480700001)(5660300002)(44832011)(8936002)(8676002)(4326008)(41300700001)(40460700003)(1076003)(66574015)(47076005)(2616005)(83380400001)(336012)(426003)(26005)(16526019)(36860700001)(478600001)(81166007)(356005)(82740400003)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2023 06:52:43.4546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bba8f1ab-54fc-4154-98ba-08dbac4a5fa3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8517
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use min_t to replace min, min_t is a bit fast because min use
twice typeof.

Fixes the below checkpatch warning:

WARNING: min() should probably be min_t()

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c  | 6 +++---
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c  | 6 +++---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c   | 6 +++---
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c   | 6 +++---
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index f5793ec4b7c4..80bcbe744e58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1089,7 +1089,7 @@ static ssize_t amdgpu_debugfs_vcn_fwlog_read(struct file *f, char __user *buf,
 
 	if (write_pos > read_pos) {
 		available = write_pos - read_pos;
-		read_num[0] = min(size, (size_t)available);
+		read_num[0] = min_t(size_t, size, available);
 	} else {
 		read_num[0] = AMDGPU_VCNFW_LOG_SIZE - read_pos;
 		available = read_num[0] + write_pos - plog->header_size;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f731f0a99bd8..edaebabc8e60 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1976,7 +1976,7 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
 	if (amdgpu_vm_block_size != -1)
 		tmp >>= amdgpu_vm_block_size - 9;
 	tmp = DIV_ROUND_UP(fls64(tmp) - 1, 9) - 1;
-	adev->vm_manager.num_level = min(max_level, (unsigned)tmp);
+	adev->vm_manager.num_level = min_t(unsigned int, max_level, tmp);
 	switch (adev->vm_manager.num_level) {
 	case 3:
 		adev->vm_manager.root_level = AMDGPU_VM_PDB2;
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 584cd5277f92..bb666cb7522e 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -1036,7 +1036,7 @@ static void dce_v10_0_program_watermarks(struct amdgpu_device *adev,
 					    (u32)mode->clock);
 		line_time = (u32) div_u64((u64)mode->crtc_htotal * 1000000,
 					  (u32)mode->clock);
-		line_time = min(line_time, (u32)65535);
+		line_time = min_t(u32, line_time, 65535);
 
 		/* watermark for high clocks */
 		if (adev->pm.dpm_enabled) {
@@ -1066,7 +1066,7 @@ static void dce_v10_0_program_watermarks(struct amdgpu_device *adev,
 		wm_high.num_heads = num_heads;
 
 		/* set for high clocks */
-		latency_watermark_a = min(dce_v10_0_latency_watermark(&wm_high), (u32)65535);
+		latency_watermark_a = min_t(u32, dce_v10_0_latency_watermark(&wm_high), 65535);
 
 		/* possibly force display priority to high */
 		/* should really do this at mode validation time... */
@@ -1105,7 +1105,7 @@ static void dce_v10_0_program_watermarks(struct amdgpu_device *adev,
 		wm_low.num_heads = num_heads;
 
 		/* set for low clocks */
-		latency_watermark_b = min(dce_v10_0_latency_watermark(&wm_low), (u32)65535);
+		latency_watermark_b = min_t(u32, dce_v10_0_latency_watermark(&wm_low), 65535);
 
 		/* possibly force display priority to high */
 		/* should really do this at mode validation time... */
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index c14b70350a51..7af277f61cca 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -1068,7 +1068,7 @@ static void dce_v11_0_program_watermarks(struct amdgpu_device *adev,
 					    (u32)mode->clock);
 		line_time = (u32) div_u64((u64)mode->crtc_htotal * 1000000,
 					  (u32)mode->clock);
-		line_time = min(line_time, (u32)65535);
+		line_time = min_t(u32, line_time, 65535);
 
 		/* watermark for high clocks */
 		if (adev->pm.dpm_enabled) {
@@ -1098,7 +1098,7 @@ static void dce_v11_0_program_watermarks(struct amdgpu_device *adev,
 		wm_high.num_heads = num_heads;
 
 		/* set for high clocks */
-		latency_watermark_a = min(dce_v11_0_latency_watermark(&wm_high), (u32)65535);
+		latency_watermark_a = min_t(u32, dce_v11_0_latency_watermark(&wm_high), 65535);
 
 		/* possibly force display priority to high */
 		/* should really do this at mode validation time... */
@@ -1137,7 +1137,7 @@ static void dce_v11_0_program_watermarks(struct amdgpu_device *adev,
 		wm_low.num_heads = num_heads;
 
 		/* set for low clocks */
-		latency_watermark_b = min(dce_v11_0_latency_watermark(&wm_low), (u32)65535);
+		latency_watermark_b = min_t(u32, dce_v11_0_latency_watermark(&wm_low), 65535);
 
 		/* possibly force display priority to high */
 		/* should really do this at mode validation time... */
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 7f85ba5b726f..143efc37a17f 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -845,7 +845,7 @@ static void dce_v6_0_program_watermarks(struct amdgpu_device *adev,
 					    (u32)mode->clock);
 		line_time = (u32) div_u64((u64)mode->crtc_htotal * 1000000,
 					  (u32)mode->clock);
-		line_time = min(line_time, (u32)65535);
+		line_time = min_t(u32, line_time, 65535);
 		priority_a_cnt = 0;
 		priority_b_cnt = 0;
 
@@ -906,9 +906,9 @@ static void dce_v6_0_program_watermarks(struct amdgpu_device *adev,
 		wm_low.num_heads = num_heads;
 
 		/* set for high clocks */
-		latency_watermark_a = min(dce_v6_0_latency_watermark(&wm_high), (u32)65535);
+		latency_watermark_a = min_t(u32, dce_v6_0_latency_watermark(&wm_high), 65535);
 		/* set for low clocks */
-		latency_watermark_b = min(dce_v6_0_latency_watermark(&wm_low), (u32)65535);
+		latency_watermark_b = min_t(u32, dce_v6_0_latency_watermark(&wm_low), 65535);
 
 		/* possibly force display priority to high */
 		/* should really do this at mode validation time... */
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index f2b3cb5ed6be..adeddfb7ff12 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -975,7 +975,7 @@ static void dce_v8_0_program_watermarks(struct amdgpu_device *adev,
 					    (u32)mode->clock);
 		line_time = (u32) div_u64((u64)mode->crtc_htotal * 1000000,
 					  (u32)mode->clock);
-		line_time = min(line_time, (u32)65535);
+		line_time = min_t(u32, line_time, 65535);
 
 		/* watermark for high clocks */
 		if (adev->pm.dpm_enabled) {
@@ -1005,7 +1005,7 @@ static void dce_v8_0_program_watermarks(struct amdgpu_device *adev,
 		wm_high.num_heads = num_heads;
 
 		/* set for high clocks */
-		latency_watermark_a = min(dce_v8_0_latency_watermark(&wm_high), (u32)65535);
+		latency_watermark_a = min_t(u32, dce_v8_0_latency_watermark(&wm_high), 65535);
 
 		/* possibly force display priority to high */
 		/* should really do this at mode validation time... */
@@ -1044,7 +1044,7 @@ static void dce_v8_0_program_watermarks(struct amdgpu_device *adev,
 		wm_low.num_heads = num_heads;
 
 		/* set for low clocks */
-		latency_watermark_b = min(dce_v8_0_latency_watermark(&wm_low), (u32)65535);
+		latency_watermark_b = min_t(u32, dce_v8_0_latency_watermark(&wm_low), 65535);
 
 		/* possibly force display priority to high */
 		/* should really do this at mode validation time... */
-- 
2.25.1

