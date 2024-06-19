Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A52C27C53
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jun 2024 09:55:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58D4510EBAE;
	Wed, 19 Jun 2024 09:55:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zq2X+1M0";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6848F10EBAE
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jun 2024 09:55:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpT8zGBpeiY/Lwb9FdSsLGhIu3YatDGTYpC8VRa3b1hP36G/9IOs4bFKHu96JNqZ1U0e8FcZy8yQkqvmUmORg572/KqYbN9zr26SHKozkD+HWi5eadUbIUjc/W2tlovcNfkENrRvtOtdnUzxfL0OMSkHQ+5r9C18MSNrkXEwKoeyH36ZenGRhE/Gxreanzc9bFSVKBuJe10qe/m6t1pgKhWSs+vsOAtVZlWyhhGslOXhHdm55LLmHNPQwZPqjEF/LSVh4EGI0LzTX8v01wLPoy+b1sQmUV8CElEe/TlXW+LMPu+5a47GGrTp1oPNk97ax6K7t3BLXT7x4n0vDOwZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6oE6pwVAC2xgseK0NVB/TIl37Celt2LifNLj1WmEg9I=;
 b=TgPXz2ERznS1uJYsXAO2hH8jn6OEySfjmp7h4pHYd+k6v3LNZUgyf2E6Vl7WdSSwFQLDomAC9dpVFoaqTv9YeDUuregps06RPOLWpTCCeIC6J6EY0WfD7zeJ++onNFuZXAezwlsuepD6bxOp/FALzc0LzecmjliDyEWvZhF6EXmiaHF/q/bw0f9WkRnQw5whMpdqR7iN2Hw3MOjY9U1kixFOiPVQYydgXY3Xm8qnQntNuWQxtPHDEvNzVOK/Uk9IB7nphw5e0llygC4Ds5Li08SlojZM7ngfr0S5OPcqzzI7S32cMM0/scS85mVuhPZyRBs15atIQfEcAbh8dP4xFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oE6pwVAC2xgseK0NVB/TIl37Celt2LifNLj1WmEg9I=;
 b=zq2X+1M0ZXrFI50iXYet7XoHaJm1NHexuIwOm1HZG55pRfncHa5yFVoFNcTTPgmYcQSAEsKd+Pst8y/M//1ouzKWT7Kgs4UBFo95D4Pi5nVTA1mc8Obh5bbuUEot9t1k2GImNbeq1hpRdblN5xsGKOPrFIkaTnWUX0OLuY0qIBE=
Received: from DM6PR14CA0048.namprd14.prod.outlook.com (2603:10b6:5:18f::25)
 by PH8PR12MB7160.namprd12.prod.outlook.com (2603:10b6:510:228::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 09:55:30 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:18f:cafe::50) by DM6PR14CA0048.outlook.office365.com
 (2603:10b6:5:18f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Wed, 19 Jun 2024 09:55:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 09:55:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 04:55:28 -0500
Received: from jane-sm-stand.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 19 Jun 2024 04:55:27 -0500
From: Jane Jian <Jane.Jian@amd.com>
To: <Lijo.Lazar@amd.com>, <Haijun.Chang@amd.com>, <Victor.Zhao@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Jane Jian <Jane.Jian@amd.com>
Subject: [PATCH] drm/amdgpu: part I - normalize registers as local xcc to
 read/write under sriov in TLB
Date: Wed, 19 Jun 2024 17:55:26 +0800
Message-ID: <20240619095526.1387723-1-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jane.Jian@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|PH8PR12MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ae18dbe-98a9-423f-3049-08dc9045f3ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|1800799021|82310400023|36860700010; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gn6gHgUhsfTvfWs3MZAEA+F9LLQURp/HHyLYm5ArtHqsQZcrDg4De2RH3IW9?=
 =?us-ascii?Q?S4MKslNCzcurh05v8BmtrP38djvHZ6NMYKqgV1i3JfNsDbjblvOU3XGNqaDT?=
 =?us-ascii?Q?etL52wComc3GsOLsidzXSV/vMKGzvurXpF+lwH3czQ1FHNGO0nWoVCQzRz1n?=
 =?us-ascii?Q?7fl5DFCt3K4SILiGjOrRbQVoPMXmxFGjUZc/5UVJ6PsCUlB72xWlx4KOcVx6?=
 =?us-ascii?Q?BjK+/yhKz8Rp+F5GPrDrHd1wxGc00Bb5EZugXrFQWDSGzJWaC0YsE6GR78J/?=
 =?us-ascii?Q?TZcr3LFkdsUCzcXirXSRO/C1p3AwLIi9ZCmsH8mhwwfJMQOD+AuRDSmSbTLf?=
 =?us-ascii?Q?zuSVsGTIZdYDhPyCWpUK/ncLHfj/Fg8N5+sIbHMlK9M6X69jvJipfm5+Msp0?=
 =?us-ascii?Q?p4X8Epj1PllMMgosiZb/dEAsCT8SN0n/PrarPpRHpdxg5/IIeDCxBJpxkbzO?=
 =?us-ascii?Q?3QHAulbjMK++ilheBtaH8qhS7vabxgQzXxVNCGJIuxKiDwVupM5cMbevecvY?=
 =?us-ascii?Q?JBTaAEce4i+bUSyjq6M8PAiGFHumGmdhH1Rmj6w+3CskgtlhCf8g9PitvApJ?=
 =?us-ascii?Q?8x2unmjakmo79k8UKsKoC3bPPl6/gwAROuRXI4pBV6SKHQ/5y+iscJZuIbzF?=
 =?us-ascii?Q?Ai3WQK/xVpZ4JdVQEd1N7d+wIhnofs9acKrnfrbpsFYR3AJwzjaJRLlobimq?=
 =?us-ascii?Q?CaZ+F/5LLq5DO5aRoGGtvwqoNmN/JY20gWJulY/0Q17MoQqdJkPrNElTHWJ4?=
 =?us-ascii?Q?bUSjDP7eeILatfBRkO7974/EWXDRGqrcRziNQ7OY5qlbdE52+jf32OiJRU5Q?=
 =?us-ascii?Q?mQw2oCaz6nQDe5pVOuObXsDGXlKGYgfCCco11xnuCfMjhKGdFN7K3dSVnXOo?=
 =?us-ascii?Q?7LVn24R5OoycdEIaun19Rlyu4m1QCr7TGN0tETFh3a07NEUMUK23asvg6xfC?=
 =?us-ascii?Q?0n75GNI/dmF7V3FGKL4rgzYyH1qb/hKio3tZ47EDVnN2F7am9h+K9kCqclcK?=
 =?us-ascii?Q?BTEdzGEG5Y5H/OlJntiPfflFwOr2ZAZsY5p4BdHowGabgp1o28+iJQIiuAkL?=
 =?us-ascii?Q?zf/Nsbw0jFcU+Pry0LxGj9bvezg5i6u259S/9Ntc7R32QxIFlofPby/33blI?=
 =?us-ascii?Q?QKqzT7iOuKoc05V8Yfeq5+RkLW1Yt4qkbGFuFfeG1l/ZK6kq5msWBXgbjw61?=
 =?us-ascii?Q?Vwhr+bDUmxrFc5DYvupWbMoRS/z7Xg90khWVEMEETeTyvTjr8SaD7c1VnJkU?=
 =?us-ascii?Q?Tef5YNUBLUbIOrFscU9xyUZktsn+YQ2QbywUeRaJ9LP7tOOwuCUdNXhkulUu?=
 =?us-ascii?Q?9BufGSaCEHRN0HfEyBzvcKGU59u1OI1BNicUGju9q1unDceMxW0uT4tKFCPk?=
 =?us-ascii?Q?3rRN31metISm9DijE5BOwksXzr9C34DmMGyeNquqAhCK16JUwg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(82310400023)(36860700010); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 09:55:29.7353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae18dbe-98a9-423f-3049-08dc9045f3ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7160
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

[WHY]
sriov has the higher bit violation when flushing tlb

[HOW]
normalize the registers to keep lower 16-bit(dword aligned) to aviod higher bit violation
RLCG will mask xcd out and always assume it's accessing its own xcd

[TODO]
later will add the normalization in sriovw/rreg after fixing bugs

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 10 ++++++++--
 drivers/gpu/drm/amd/amdgpu/soc15.c         |  1 +
 drivers/gpu/drm/amd/amdgpu/soc15.h         |  1 +
 drivers/gpu/drm/amd/amdgpu/soc15_common.h  |  3 +++
 6 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 083f353cff6e..da8d3669cc23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -632,6 +632,8 @@ struct amdgpu_asic_funcs {
 				  const struct amdgpu_video_codecs **codecs);
 	/* encode "> 32bits" smn addressing */
 	u64 (*encode_ext_smn_addressing)(int ext_id);
+	/* normalize offset to keep in lower 16-bit */
+	u32 (*normalize_xcc_reg_offset)(u32 offset);
 
 	ssize_t (*get_reg_state)(struct amdgpu_device *adev,
 				 enum amdgpu_reg_state reg_state, void *buf,
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 2c9a0aa41e2d..3306df74457b 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -1085,3 +1085,12 @@ ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_device *adev,
 
 	return size;
 }
+
+u32 aqua_vanjaram_normalize_xcc_reg_offset(u32 offset)
+{
+	u32 normalized_offset;
+
+	normalized_offset = offset & 0xffff;
+
+	return normalized_offset;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 88b4644f8e96..fba2e4ad58db 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -853,8 +853,14 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 */
 	if (adev->gfx.kiq[inst].ring.sched.ready &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
-		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
-		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
+
+		/* Select lower 16 bits to write in local xcc
+		 * for MMHUB it uses xcc0, NO cross AID reg offset
+		 */
+		if (AMDGPU_IS_GFXHUB(vmhub)) {
+			req = NORMALIZE_XCC_REG_OFFSET(req);
+			ack = NORMALIZE_XCC_REG_OFFSET(ack);
+		}
 
 		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
 						 1 << vmid, inst);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 8d16dacdc172..31037f068902 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -927,6 +927,7 @@ static const struct amdgpu_asic_funcs aqua_vanjaram_asic_funcs =
 	.query_video_codecs = &soc15_query_video_codecs,
 	.encode_ext_smn_addressing = &aqua_vanjaram_encode_ext_smn_addressing,
 	.get_reg_state = &aqua_vanjaram_get_reg_state,
+	.normalize_xcc_reg_offset = &aqua_vanjaram_normalize_xcc_reg_offset,
 };
 
 static int soc15_common_early_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
index 282584a48be0..0d405a474283 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
@@ -124,4 +124,5 @@ ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_device *adev,
 void vega10_doorbell_index_init(struct amdgpu_device *adev);
 void vega20_doorbell_index_init(struct amdgpu_device *adev);
 void aqua_vanjaram_doorbell_index_init(struct amdgpu_device *adev);
+u32 aqua_vanjaram_normalize_xcc_reg_offset(u32 offset);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 242b24f73c17..43887836377d 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -210,4 +210,7 @@
 #define WREG64_MCA(ext, mca_base, idx, val) \
 	WREG64_PCIE_EXT(adev->asic_funcs->encode_ext_smn_addressing(ext) + mca_base + (idx * 8), val)
 
+#define NORMALIZE_XCC_REG_OFFSET(offset) \
+	(amdgpu_sriov_vf(adev) ? \
+	adev->asic_funcs->normalize_xcc_reg_offset(offset) : offset)
 #endif
-- 
2.34.1

