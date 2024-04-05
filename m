Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5250BC67861
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Apr 2024 14:36:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FE3610FA69;
	Fri,  5 Apr 2024 14:36:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kBk1TwiP";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E00F910FA69
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Apr 2024 14:36:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWNT7QIDMHwbQ3b7Bp1RFF0DlmOzEfwWuYDHnxdtuAKKPDaVXfgxjS4KbPiOSL8aMK8wYu+e7wb+qpPLtdCfZfQ15N6GYjF8MprE5QxRbE//CA77/rQ6BUgEhuWsF4NkzjoKAnwQNn/RXu6moiyh1UpjlsAsuAoRCeMWEGc/Wjy/pMAkHCGRIyIIYwuvnSbEL/+3htrx4lopaGBUZdUW81g1aN+G7nn9zZXPf9C8HfxAHrWwnK2M093ueXExqLT8f1Q3MEvfSmFP8swUzN7O865pQpLi3XmIENKwbjtOSxbek/meSo5Uyyu81+KUmAX4Q1Gn6aLgyfDlXUlpmPMWkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foFTjwrYJEQ21xWoNQLBdE7QABr82arCCY8Fx7dvEmw=;
 b=DliQ4nBN2WXPKteHOgMs3rT6jmzMSSz0GNlp/dVRD1Y50n7ksXxuWGnmrDok8cZv8rmspQHRXCfMDMhYQn/VO1b8S8DOfTnrxxm+uPuckuNZ/qX9q8I5+AglkcBUmnzJcLJGdye5MNgvnmwGwRR+JT3aZM46o/O6piRPX8AbZU+2jkOdG2bULAUaH5GLkrjTwAlKe2yOoi76GCEUSScnSplJZ9KjEUnjUK7PaFE+rVahhv2VtlX457JVm2NOVsKhQ6h1x+P7mCz5PNGOPheHpgv4/zYSuvijNMW+/OpUNaanjpM0uFNX6+jJY6iMmm1T75HtIMcdIBvOzvS9MJwn4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foFTjwrYJEQ21xWoNQLBdE7QABr82arCCY8Fx7dvEmw=;
 b=kBk1TwiPE4ro78J0W6njyBFHknEcsYBMJ3EsWozcUmVE/hpWvV+NKFF+E9dLdvMT1EcHIAu+/nKMJIiqLBWmNSazFA3i3XuvUu6xG2ckuSOtDz3xrGPurTPm+CKnFFGhiBCUVRJy5ILgI6IzyR98BCmNruQUZS2zONTzD9g6sSg=
Received: from DS7PR03CA0235.namprd03.prod.outlook.com (2603:10b6:5:3ba::30)
 by DM4PR12MB5914.namprd12.prod.outlook.com (2603:10b6:8:67::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Fri, 5 Apr
 2024 14:36:39 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::11) by DS7PR03CA0235.outlook.office365.com
 (2603:10b6:5:3ba::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Fri, 5 Apr 2024 14:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 5 Apr 2024 14:36:39 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 5 Apr
 2024 09:36:37 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <Christian.Koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Arvind Yadav <arvind.yadav@amd.com>
Subject: [PATCH] drm/amdgpu: fix MES HQD masks
Date: Fri, 5 Apr 2024 16:36:16 +0200
Message-ID: <20240405143616.704-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|DM4PR12MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: 87b65873-ae73-42c2-88a1-08dc557dce00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bnktrIuBRp/cNK4I0dnJ9ePTJfJcUpV8Kgj8hELDYrBgc65rKAh8b34+9+KUoY/Ply1zbQjfWntuBshdjXA/4/SbMwuTDQlWncI1L2IZVAqExLA6eIklded08DJgSPUKOOBdJrxs1wunY2uMd5/Tk9q+fQ3kmtXkd5Ksf7htGP4WttU5eXlBmjLyBRVnrqEJl34O1mmtgj8lnFhd+IiY0R6riB/M9dKt51SyOsN7f0i9Cp6xrDJW6T1vzntuLI9asoY60O9S/I91Z+uDyxv9bkfRl3+cdfFAKhRa49xC3RBltV31bFMSW9r0vI/P/uWjCaLAf/kOExKVxBGy6sP6lhTwHjE8iVnl6COaQLPb9e5k0wmpduHNwyq5mLU/yOzo4KPjrQzF7CS8fbm9g0OQlEE7NBPN+RR7lNSjLX/bKp5/zdmVwwhAVTWVuVeL+uJDXtp5MPplBtSje320c1QSWn4N15gRBiyQ6YBHx3T1QWzivtlI2DSs8P1byysijSQvSRgOfDkenLelnB6c3ysprxvIKabhzASbKik1noVRixmMVpJ9KvAke1R/+T4HYcs9gFFx4ObKX8nrz+I7un/IzjJaolycXvxH6YcGvQXVZCBGeijFIA8zIHjDvIMCb7lTGAVhjUF+LdiYS/uu1U4BzZoOU/1+lKH2EbGLPmNE0jH43tMAykkbupZbzIljIplta2UKC7Y0z4BIbVdHeNqNKUZXynfvDFfIOyQUdbU/+AV4MWq1BdX6/vE0AERts/PB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 14:36:39.4401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b65873-ae73-42c2-88a1-08dc557dce00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5914
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

This patch fixes the existing HQD masks prepared during the MES
initialization. These existing masks values were causing problems
when we try to enable GFX oversubscription.

Cc: Christian König <Christian.Koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  3 ---
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  | 15 ++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 15 ++++++++++++++-
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index da48b6da0107..7db80ffda33f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -148,9 +148,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 		adev->mes.compute_hqd_mask[i] = 0xc;
 	}
 
-	for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
-		adev->mes.gfx_hqd_mask[i] = i ? 0 : 0xfffffffe;
-
 	for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
 		if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) <
 		    IP_VERSION(6, 0, 0))
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 1e5ad1e08d2a..9217914f824d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -266,6 +266,19 @@ static int mes_v10_1_query_sched_status(struct amdgpu_mes *mes)
 			offsetof(union MESAPI__QUERY_MES_STATUS, api_status));
 }
 
+static inline uint32_t mes_v10_get_gfx_hqd_mask(int pipe_index)
+{
+	/* Pipe 1 can't be used for MES due to HW limitation */
+	if (pipe_index == 1)
+		return 0;
+
+	/*
+	 * GFX V10 supports 2 queues, but we want to keep queue 0
+	 * reserved for kernel, so enable only queue 1 (1<<1) for MES.
+	 */
+	return 0x2;
+}
+
 static int mes_v10_1_set_hw_resources(struct amdgpu_mes *mes)
 {
 	int i;
@@ -291,7 +304,7 @@ static int mes_v10_1_set_hw_resources(struct amdgpu_mes *mes)
 			mes->compute_hqd_mask[i];
 
 	for (i = 0; i < MAX_GFX_PIPES; i++)
-		mes_set_hw_res_pkt.gfx_hqd_mask[i] = mes->gfx_hqd_mask[i];
+		mes_set_hw_res_pkt.gfx_hqd_mask[i] = mes_v10_get_gfx_hqd_mask(i);
 
 	for (i = 0; i < MAX_SDMA_PIPES; i++)
 		mes_set_hw_res_pkt.sdma_hqd_mask[i] = mes->sdma_hqd_mask[i];
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 26d71a22395d..b7dcd936afc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -360,6 +360,19 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__MISC, api_status));
 }
 
+static inline uint32_t mes_v11_get_gfx_hqd_mask(int pipe_index)
+{
+	/* Pipe 1 can't be used for MES due to HW limitation */
+	if (pipe_index == 1)
+		return 0;
+
+	/*
+	 * GFX V10 supports 2 queues, but we want to keep queue 0
+	 * reserved for kernel, so enable only queue 1 (1<<1) for MES.
+	 */
+	return 0x2;
+}
+
 static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 {
 	int i;
@@ -385,7 +398,7 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 			mes->compute_hqd_mask[i];
 
 	for (i = 0; i < MAX_GFX_PIPES; i++)
-		mes_set_hw_res_pkt.gfx_hqd_mask[i] = mes->gfx_hqd_mask[i];
+		mes_set_hw_res_pkt.gfx_hqd_mask[i] = mes_v11_get_gfx_hqd_mask(i);
 
 	for (i = 0; i < MAX_SDMA_PIPES; i++)
 		mes_set_hw_res_pkt.sdma_hqd_mask[i] = mes->sdma_hqd_mask[i];
-- 
2.43.2

