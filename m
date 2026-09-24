Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A193DC98314
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 06:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24F3210F2F8;
	Thu, 24 Sep 2026 06:35:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qpyEglwS";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60C5410F300
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 06:35:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uy/BdUnKPDVxVrZq/A/MjP7kD1tmUAwpeyKIow+lX18X01xG6GJM5II/QI+Ls4l8eE1ZcTl6HiXz2xWoJunVTw3seOG212fjd20hYrHkslCznbeMbomOAl7ZDYd0sUtx2aDmTVEISYycw+AaTEThe7/FAKI2mVA85GOv6q680hZhCRrEsSwY+GG5vmb9zL95/n8Z1yzUy7Xigz3mSsqSzGJTqsmOvMQ5nmajRJyBnQVXzrMZkkhdjw9awRnfbyMwgepf0Ula74k8/we565OwPCKvZeypfTOqq6vAbAW1C3yG6BSNCZU3GHNum2dD3uv382KyDfdyrASQ/gOLIKgXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r23s1K/a99TTY7KTnuKNhu7ECVEm2MwMCkI9lbSQdXY=;
 b=bRqJ56Ksft+fITqMaJTfrPWdzmKBHlir4cQYEchYUVqx9uNcQOyOqn92pTeofOiteNjU0z2778n9xW3eP60By9hEJF5DvKcvB0jk0sz8UNW2Ngp4pE6BW4ZT6OKA2FNE9z63FziJ8mIzsHZngY4R3FO1IWXxXLaQ9oWsfxfuWZ4tb6y3d0PXayPN4gu3FpgGg9oCWy1UrCR7N+enUtpFltime+0v0AyGGPvRdSVS2QlHIC2viHyRiUWNHxgVpv7awEcgUH9DA8B3bTStE9DTH1A1EBU91Jr6xl14ooxw++fV3gcCu/SyzsayeDrKomFd0vwrcIl8dQQG2QG1E9bADw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r23s1K/a99TTY7KTnuKNhu7ECVEm2MwMCkI9lbSQdXY=;
 b=qpyEglwS9Neg4ugch0gqNrByrl5k+NY1DmaiyRKN+ueoWe+tEFdrjgPyk4y6MXtNT4HazsdSN05IMvmImHUjv1n5F8DCNQcTHbpoALsF2W7zELz4HTlacfkILEX+1ak/lx3ZMuJGjst80wDnFVHxznQdFzo0+Ddh9m43VXsurmI=
Received: from CH0PR03CA0197.namprd03.prod.outlook.com (2603:10b6:610:e4::22)
 by PH7PR12MB6465.namprd12.prod.outlook.com (2603:10b6:510:1f7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 06:35:41 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::81) by CH0PR03CA0197.outlook.office365.com
 (2603:10b6:610:e4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 06:35:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 06:35:41 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 01:35:40 -0500
Received: from victor-aws2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 24 Sep 2026 01:35:38 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Shaoyun.Liu@amd.com>
CC: <Davis.Ming@amd.com>, <Gavin.Wan@amd.com>, Victor Zhao
 <Victor.Zhao@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: Read RLC GPU clock on GFX12.1 VF
Date: Thu, 24 Sep 2026 14:35:18 +0800
Message-ID: <20260924063519.688340-2-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260924063519.688340-1-Victor.Zhao@amd.com>
References: <20260924063519.688340-1-Victor.Zhao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|PH7PR12MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 68b7adfb-8fc1-47ca-ede1-08df1a060daf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 1c/xZXcY6AMmR4W7PHDVaEjupaRxosFxxx2XKCIeaWxTqAIAyGkH4L/ZW8eJPXoWOMoELhZaSTJoFmmfO9zujR1SxsK0QwwmYdGwhnq/xQe5UMA7iVLKoO07AarHGTjozrJgtPRJogwCk+gtoJ8ZNe4D3JLIxgoTfr39vvUC5lJTkt39oa2pqEEx7v/OdXD3ZczAEr2STz/qaXba2pRX/+C918Ha01wKess4/FAsENPc2PTtIObOJ4dTyKz0ycdIG0A89Ry27El/2JpxFsr/FmeloNz5EwDONaWzBumDO51dg/P+owIjWNIE8Xpr789pu58WlUZpeVd1ZF+H0dKZfLLFm+7Iu67OXF64mSHZGlUmJpKVrliQsZIHJqxzu6PQoHNMrblp7MeO8t7SZxsCinJhD4TVKlKbjtD5Lau+rWO7lW2vmTR4r2f0Q7TGqQkEm8oi2GNVMZyvD37qG2Cc94f1/ceoIA14/ACXkKDdHz27LVHZ6Zb4dMDCJpr4Hwd6v1PVHagEbVVkg2KHao6vXP+uI5OO9ggVWUVSZPJoDqHkMKLNoeuzYoBNEdIPq+njoiAbPQRWlu+fKm5P1YK/m2E9tD9V9ohMgENSpLEz0iNlhcHykKbGbXvsyhQB9/l4ySCXsB/ylpok5VIQCTYx0nuPQd2ZAAlgEA8BSavalJlOidhG5/HyGIJy7OGcWVeL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4GOmq+5iMmQ5v4nJzVJp8ACFUv+O1ZQFlrfxDPiAcXJ5ySvSp2+sC4Nkw7jm/EAPaME5O0sgRC4+iHmH2tQw65YQet38QUyHJSnR95gjW+qxS9PhWAfgkqsZKAL7KJ0YWpjX3xGHosnhtAxPmuVYORJVttmsAFsZP9YtDYxk4snmXArUX7kHVVuLTtyTNGgS3TAVJKFtf9H+svIVIG5l85qije/zq+BgUYXj5L9RCsXoxn2LJ+i/edZT3eVDtC18pMBDcM/WX9tSPrO8CImNouTE1la1gLL70kStb0+l87zPogec9O2Jukjdy33xKKgFDFMZp4dF0sTnCB/FQOHE2VfL4FBgmMYV6Hz+JwDhXOugCHs7sRFujZkBjorXQaM3PhBo8NMxB/DieAy6lrzQ+PVnGLGKOIYkb6MGAMF4vyoTAjUIDx62koB3XAFixQE9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 06:35:41.1325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b7adfb-8fc1-47ca-ede1-08df1a060daf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6465
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

[why]
VF timestamp queries need a TSC sample independent of CP/MES.
The SMUIO path is not safe on VF.

[how]
Capture via RLC_CAPTURE_GPU_CLOCK_COUNT and read the consecutive
count registers with amdgpu_mes_rreg64().

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index d6f70d33201a0..3c8133c94d6fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -3168,10 +3168,36 @@ static int gfx_v12_1_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
+static uint64_t gfx_v12_1_get_rlc_gpu_clock_counter(struct amdgpu_device *adev)
+{
+	uint64_t clock = 0;
+	uint32_t reg;
+
+	if (!down_read_trylock(&adev->reset_domain->sem))
+		return 0;
+	if (amdgpu_device_skip_hw_access(adev) ||
+	    !adev->mes.ring[0].sched.ready)
+		goto unlock_reset;
+
+	mutex_lock(&adev->gfx.gpu_clock_mutex);
+	WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
+	reg = SOC15_REG_OFFSET(GC, GET_INST(GC, 0),
+			       regRLC_GPU_CLOCK_COUNT_LSB);
+	clock = amdgpu_mes_rreg64(adev, reg, 0);
+	mutex_unlock(&adev->gfx.gpu_clock_mutex);
+
+unlock_reset:
+	up_read(&adev->reset_domain->sem);
+	return clock;
+}
+
 static uint64_t gfx_v12_1_get_gpu_clock_counter(struct amdgpu_device *adev)
 {
 	uint64_t clock = 0;
 
+	if (amdgpu_sriov_vf(adev))
+		return gfx_v12_1_get_rlc_gpu_clock_counter(adev);
+
 	if (adev->smuio.funcs &&
 	    adev->smuio.funcs->get_gpu_clock_counter)
 		clock = adev->smuio.funcs->get_gpu_clock_counter(adev);
-- 
2.50.1

