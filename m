Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1CFCA5FA2
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 16:44:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A30CA10E93C;
	Mon, 28 Sep 2026 16:44:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="elnBf2n+";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012058.outbound.protection.outlook.com
 [40.107.200.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A75010E68B
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 16:44:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jdu2+9lbxzb0n+vWpFu8muTwwwRGVSVpgM73Q98BOYspWG197lAShILBmBJXX7MGQGRZoH+juLWtoDql3kq+I6QcL+Gw5QYWrWsgiOTQ2ovdINerJfrawih39250PsxsvKyxzOCl1E2ao4BzHVC9TJJu2J1gHzAxstyrA5za8HDIkEesOgdWuN0TiyYt5XcmwU2Ue3866/ovQsikmKUZN9GJafRs8WOGixijz6YlUXn9GLtUTRw5AB/hMBAjkjB75UWtygTCzdw+bExehxXZ3CEa7PUzdsfJ9bK/f2L/cc+J6BcAEtESfdAEz62l1G7Vl7gVlpj9IcI3G1ZTjw1vOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IujzeL1r3tPlCUi2saa0bWI3KVgzRnyaN6TCrJozMAo=;
 b=Wf+N21T3uTS4iCnTEoo2h73EKcRluwRfNJ7cgGz0NATGcmb9LKZoCjKlhNnKzUzA2SioqXSQCStLeue/SmCnt87ommxvV7bCSx09JduDtPsgzufqENw0SiGm+vbnK3cCVAYymmWb6Kp0HFF1zTVIMBcNCkZlI2S3dsYKblkQgwdubjEmGy7qFS5GYfenKV9xKbLAkw8xN4cXAwAx132c+gnwZ1CxPCrcFtIarftVEKaHkxuGil0qdOSfJkwOlEyk3ZPLMbK2zA2G2kz2aumfLtc8I+FLmXB6+WUqgHYDknaZ25cBzwC13CYUof5n9egBbs/vvAx7LDs2SKsBdNnDTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IujzeL1r3tPlCUi2saa0bWI3KVgzRnyaN6TCrJozMAo=;
 b=elnBf2n+IY90pg+Bp1vJrrwCXkfmBVUQHcnN35kkRibSRZOa4Dbrjz5vQ86e3f6dOcn/xvG3ALF8zETRSgF1HfieEEfQGXh+25GSkQBHV6j+6rr5TvWX2kjBTgBVBsWw5jur4dBa/FEfssjSvgaXboybX6muytEl5iCAU7IxwJ8=
Received: from BN9PR03CA0767.namprd03.prod.outlook.com (2603:10b6:408:13a::22)
 by MN2PR12MB4144.namprd12.prod.outlook.com (2603:10b6:208:15f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Mon, 28 Sep
 2026 16:44:47 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::13) by BN9PR03CA0767.outlook.office365.com
 (2603:10b6:408:13a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 16:44:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 16:44:47 +0000
Received: from MKMZHLUO01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 11:44:45 -0500
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Philip.Yang@amd.com>,
 <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>, <Gavin.Wan@amd.com>,
 <Victor.Skvortsov@amd.com>, Zhigang Luo <Zhigang.Luo@amd.com>, Zhigang Luo
 <zhigang.luo@amd.com>, Fangsheng Huang <Fangsheng.Huang@amd.com>, YuBiao Wang
 <YuBiao.Wang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH 2/6] drm/amdgpu: add helper for VRAM in system physical memory
Date: Mon, 28 Sep 2026 12:44:16 -0400
Message-ID: <20260928164421.10144-2-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928164421.10144-1-Zhigang.Luo@amd.com>
References: <20260928164421.10144-1-Zhigang.Luo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|MN2PR12MB4144:EE_
X-MS-Office365-Filtering-Correlation-Id: 00fb8eec-be9d-4ff2-b6ca-08df1d7fce9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|3023799007|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: eLx94GKnqMmD6WA3nthFKA1GAO6orAHwWoKALLztlgz273ybXZngzgISiCI5YBx7E8TamW74Brg15F4tsfe8VA3PNGFrPuCuDFnprXuLEqtedn8JUKIETP7ZXvUdWYv7ODb/3tKXoPPiDvWup97F6qeVS1cD/CiGydeIOXEBFj8ZoJZBkjjmjfYjr0EVt80K3wGuoWIX/j9aChu4kauFbnfwrwZ545Nl6rT9k8UHjkNTPDHYuVHZxjbUFDqUqgpE7fy9Rw/xinSHtxslqsD6LeWShppED3g9IPGhIixYKtEtrNAoZgJVcEcNlcmFXtdubn3IuMTqxTgCtqL2IJa0vSyfv9gWzbIEsxlhGxUzVAEDTkIwmuN3wMxhWUxm2PQruGAJOvelVZpxIXRSoA4QSGNuRkeJ/zYALHM9a441cX1h63p3+GGbTyr4Juwr6wG+0H1zlQfcHzdQ9qg8QVGRWuIYdLyTJ0khPCArmlfeZdt6GgYAyAYsssds4N4S54moBvJLU0E4SL0+HfxvTtAdf8yFsm6CC+4xgMIuSEVqVPTc84nq1CO+1GpVLTOtulhrTOp8E18ONQxopvYVEaRU4LZwprKqJsYPPryQSuafymm2eEKUijHjRhoiv0bcAHDjTh1zWsSrY9ysp/RPzb2doZXb1tgh4OLrJGrf4Z5WBAT9NIQB3Zxwp41dGZry2hAyfGHU8di8Vv2hrMsVi5Og5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(3023799007)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pNMHyOe7gmRT8bS5IBu8hJu5zApvclp9Rmqm3mhNEPAmmdIhoTuqb5MDscfV/IPdaazM+k8gmXQ+wPETwu0W+3zRYEQ/EzRJBL5WSXFBLBgVCOB3ejGxaJU72Kvk7lNmMvKJCUtt5KZ59H86eLMHkmyXb151Fp70poHoGyGcKEMaH7bxrIZrQzTQPuED1u9BoPtPX9uO+dm4ku4DmBPkVDsDMewtzRn14RHXvM7GVFiqw2lz6IUuK+JFLAStGNC+iFKdb7m1zllYWolEjD2AkPrsXB/udauTmWt645V9ypyHiK6I4RZxi8uSUUBfftJly6/mtiy2lVdrdWAT56hzbRYuir//kOXGkIlWU7SiJvQRd9minPt4M+GHUgwBLLtfYWC8V6UuAPzuccT4rBmOvZhmFGK4l+bonErOpbkD0fGZ1tqnhqWkVao/yQi+ScIr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 16:44:47.3778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00fb8eec-be9d-4ff2-b6ca-08df1d7fce9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4144
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

On A+A, HBM is reached at a host physical address, so VRAM mappings
need the system-memory path. That is true for both an SR-IOV VF and a
passthrough VM; native PF A+A keeps the mmhub/sysvm path.

Add AMDGPU_VIRT_VRAM_IS_SPM and amdgpu_virt_vram_is_spm() so later
patches can identify SPM-backed VRAM without repeating the cap test.

v2:
- Rename the helper to amdgpu_virt_vram_is_spm(); it only tests
  AMDGPU_VIRT_VRAM_IS_SPM.
- Set the cap in ip_early_init when an SR-IOV VF or passthrough dGPU
  has no FB BAR0, after AMD_IS_APU is known.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
Signed-off-by: Fangsheng Huang <Fangsheng.Huang@amd.com>
Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 44091ac12fa9..96165b1b3e6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2085,6 +2085,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	if (!(adev->flags & AMD_IS_APU)) {
 		parent = amdgpu_device_find_parent(adev);
 		adev->has_pr3 = parent ? pci_pr3_present(parent) : false;
+
+		if ((amdgpu_sriov_vf(adev) || amdgpu_passthrough(adev)) &&
+		    !pci_resource_len(adev->pdev, 0))
+			adev->virt.caps |= AMDGPU_VIRT_VRAM_IS_SPM;
 	}
 
 	adev->pm.pp_feature = amdgpu_pp_feature_mask;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 9957241bdf59..a2c1aa838737 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -32,6 +32,7 @@
 #define AMDGPU_PASSTHROUGH_MODE        (1 << 3) /* thw whole GPU is pass through for VM */
 #define AMDGPU_SRIOV_CAPS_RUNTIME      (1 << 4) /* is out of full access mode */
 #define AMDGPU_VF_MMIO_ACCESS_PROTECT  (1 << 5) /* MMIO write access is not allowed in sriov runtime */
+#define AMDGPU_VIRT_VRAM_IS_SPM        (1 << 6) /* FB BAR0 is absent; VRAM is SPM */
 
 /* flags for indirect register access path supported by rlcg for sriov */
 #define AMDGPU_RLCG_GC_WRITE_LEGACY    (0x8 << 28)
@@ -406,6 +407,9 @@ struct amdgpu_video_codec_info;
 #define amdgpu_passthrough(adev) \
 ((adev)->virt.caps & AMDGPU_PASSTHROUGH_MODE)
 
+#define amdgpu_virt_vram_is_spm(adev) \
+((adev)->virt.caps & AMDGPU_VIRT_VRAM_IS_SPM)
+
 #define amdgpu_sriov_vf_mmio_access_protection(adev) \
 ((adev)->virt.caps & AMDGPU_VF_MMIO_ACCESS_PROTECT)
 
-- 
2.43.0

