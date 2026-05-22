Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3134CD5BB1
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:22:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44B9710F47B;
	Fri, 22 May 2026 00:22:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nTIa6miI";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011024.outbound.protection.outlook.com [52.101.52.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF72910F483
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:22:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRugOvnzMg5C945u/uYYuaM98H0jso41/fSIHA9FZuXx4T3eo83ItW+9KVnybXvzwwKyVqDOTDF8FPN5Gsftxjar4zDmVajlyJ+0lRAB8QR1zCEkCrrVXT7pPzhKcW7/QT/3KaOWnBZoiN0j+l6B19PV/WqFpNawinb/lmXMqgn9HqBUqYDGkPIYKvEsGFtrXi8zWXruqxFXOKL8CpGetL9kIBM/gvljb8DfzR24BzFnlwx+ysWHmiFoxiWCOXSAdxptpL6kxELPQfNV14FVAPRxyjsnlSqOax6M3/afPI9SGypCXrFlAB0thurYUBeTbA5vrMVZciot09bUotiSbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FSeeOuvwKQNMLGgq0VYmTHEWIQKnGJes3udlVX8w/M=;
 b=IvqwhfEVanB2hDWjoYcAE8N4ti25qE3q6eV1qbP+tBIXbJX7GJ+rVO/kq2IkCoUmn/fj549XnGLCdKMm7ubUMIez1aJLPrFI1Mqfe/iEYFCSjKVlLYO6giXhVqmiEBVeLtlZz049jEzXv5KTW7ZfyWYUqQDO2+Zi667mt06Ti+cYWD0IDm/FaJSWyrKLg13WUABV4+4GxBtYB1j5v2WtTTLOa2a7Nnc81tHu6sBnXUp7DbTDpsxs0D3WoG34xK9LNCKsyUBCkYvP1PzlbR7SLREt4XMNJ5GdjzEOWHbyElTXkt5F/bYtI5i4FqZWqanZLA+gRilMRWv3gDtUJWo+CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FSeeOuvwKQNMLGgq0VYmTHEWIQKnGJes3udlVX8w/M=;
 b=nTIa6miIqcu1aNFXqNLwDd8ucXMY9+B9QKGD2pldRunViFjm8GC/pNn6vI7/vRopjzGOXKzYmA3sBotTUEuvaHVD0n80I27+9ZQpUkqxSePbfjHip+3ewehsxiJA+usFyih5wxVYcZrVjFhKIJ8eOfo4JfZb1aFEQ+Wet9tajsA=
Received: from CH2PR15CA0017.namprd15.prod.outlook.com (2603:10b6:610:51::27)
 by CY1PR12MB9602.namprd12.prod.outlook.com (2603:10b6:930:107::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Fri, 22 May
 2026 00:22:12 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::b0) by CH2PR15CA0017.outlook.office365.com
 (2603:10b6:610:51::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:22:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:22:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Thu, 21 May
 2026 19:22:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 May
 2026 19:22:05 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:22:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 28/42] drm/amdgpu/gfx11: use the new MQD helper for queue reset
Date: Thu, 21 May 2026 20:20:34 -0400
Message-ID: <20260522002048.98506-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|CY1PR12MB9602:EE_
X-MS-Office365-Filtering-Correlation-Id: d897f5af-6808-4652-e170-08deb7982b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|22082099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: 6wH3C2cMBn42ZtzsrAAxIAro2UoizdOnMJvawuu8MsuZRTDITDi2XJuUfbulcaf/7Po3aIGpG1UgpgjvJUC49qJvBaW2t1T6ScyblDDuSyTtL+tG1QcBrwXpFFgS0qQlD03puTh+Xa5BC/gYt2addI6DtmWpDqeSrV/XDPJAhjkYad61RnjW1jTC+ZOEyq7U3Oxa2OoYPHUZvQH0vhaDJMVhLVdPsj2xVeWTYDvoCRRqws9n9vUjR/LiY+R8R0xsP7qyl4m28CvCE0kEAhUlkr+RWysRqb10l7f59e0d2HG80znTtKNsOIVV7kllse0ujSgd0qUnbCkT9JDN+115EsypOji98peaiaNb0p5LZqZjU7z0V64Y2vQqz4swz/u6tcowgyRas1P8ienZGo0uoQEiZl9MVoW0o6mYyjccokN7eV85p8i2SwGQEbyvQ9LXolFluE1T4pxd+i+Vx475sPr0TjPiLgvfo/B5XHHsptbXTcA/JLVzcqaGcseZXfBfwFRXsB9o7y92hG9boc3+lxRpNBS0r5oWdb0zvYaFgsCw5NQbRLOhlpHIe42H64BrIu06l0qGTH5UHXggTvOnO7crLnkyJ7OG1H63wFRsNsTUJ0XY7AqmDIT73alfu+11jHcfbVkzhIZofmBqmUo00jRALp/hBDZHhlLpn523ZVc1Ctf7uMtKG08g5P8e6EqK8NSugzacIvJK8ynZXSjh/bceL1HHlyXj66gG0zcgF9I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IiP8RyGFgiekPvI3dAqzJFqJ7KJhLIOALLnBzD+mCpUS+TVs3SJm0TVcZl/rYoavFl/frsB3OnvEHHrEts5fRqn5FXNUk/PE2TLhp96FF3qXz0PN9CYOurvYQNgw9PPvl+ES/usfEFuR63wS9wXKOhtcq/FFQaMcbrFcxGnVS2HbqgsTvNuETS1S68aARjnWzjpIDR43MONZxKoM1CzbP4yI5BySiCGGaQnKmzuCM6By4+fLHch/gAsrK5P5HBBDn+YonCF7E52MM6o1WkFJVBob348rxSclJH8rrKLkWc8CR3oYymX915d5dX9+3mkgguMCpiPlZMhucbQurb737Qs3MjXY//FvtU5Y6zJkE1yDMX/sfkNCo68h2AvET346yA0H6BNDc5/B3HUH9z+5sjclSdluhpfTKgDeYUb1E/TXxQrYlL6tt4QFQ5LuPdpw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:22:12.3834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d897f5af-6808-4652-e170-08deb7982b63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9602
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

And while we are at it remove the reset parameter as it's
no longer needed.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index f268d46e07598..1dd35aa6199d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4212,13 +4212,13 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
-static int gfx_v11_0_kgq_init_queue(struct amdgpu_ring *ring, bool reset)
+static int gfx_v11_0_kgq_init_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v11_gfx_mqd *mqd = ring->mqd_ptr;
 	int mqd_idx = ring - &adev->gfx.gfx_ring[0];
 
-	if (!reset && !amdgpu_in_reset(adev) && !adev->in_suspend) {
+	if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
 		memset((void *)mqd, 0, sizeof(*mqd));
 		mutex_lock(&adev->srbm_mutex);
 		soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
@@ -4245,7 +4245,7 @@ static int gfx_v11_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 	int r, i;
 
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-		r = gfx_v11_0_kgq_init_queue(&adev->gfx.gfx_ring[i], false);
+		r = gfx_v11_0_kgq_init_queue(&adev->gfx.gfx_ring[i]);
 		if (r)
 			return r;
 	}
@@ -4582,13 +4582,13 @@ static int gfx_v11_0_kiq_init_queue(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v11_0_kcq_init_queue(struct amdgpu_ring *ring, bool reset)
+static int gfx_v11_0_kcq_init_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v11_compute_mqd *mqd = ring->mqd_ptr;
 	int mqd_idx = ring - &adev->gfx.compute_ring[0];
 
-	if (!reset && !amdgpu_in_reset(adev) && !adev->in_suspend) {
+	if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
 		memset((void *)mqd, 0, sizeof(*mqd));
 		mutex_lock(&adev->srbm_mutex);
 		soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
@@ -4625,7 +4625,7 @@ static int gfx_v11_0_kcq_resume(struct amdgpu_device *adev)
 		gfx_v11_0_cp_compute_enable(adev, true);
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		r = gfx_v11_0_kcq_init_queue(&adev->gfx.compute_ring[i], false);
+		r = gfx_v11_0_kcq_init_queue(&adev->gfx.compute_ring[i]);
 		if (r)
 			return r;
 	}
@@ -6790,11 +6790,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 		return r;
 
 	if (use_mmio) {
-		r = gfx_v11_0_kgq_init_queue(ring, true);
-		if (r) {
-			dev_err(adev->dev, "failed to init kgq\n");
-			return r;
-		}
+		amdgpu_gfx_mqd_reset_restore(ring);
 
 		r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
 		if (r) {
@@ -6821,11 +6817,8 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 		return r;
 
 	if (use_mmio) {
-		r = gfx_v11_0_kcq_init_queue(ring, true);
-		if (r) {
-			dev_err(adev->dev, "fail to init kcq\n");
-			return r;
-		}
+		amdgpu_gfx_mqd_reset_restore(ring);
+
 		r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
 		if (r) {
 			dev_err(adev->dev, "failed to remap kcq\n");
-- 
2.54.0

