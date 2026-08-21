Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05829C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D69D10F35A;
	Fri, 21 Aug 2026 16:07:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r1xzxJ/B";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010035.outbound.protection.outlook.com
 [52.101.193.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B7E510F352
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:07:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uT6XvjcciZ5F1Iwi1Xvl5XiNYmKTSRT9exTA2aKmIQqJ9JZfy04ml5n889vjAirG5i6XijOU+pEYDDeRzlHLGzFRkE7mhQRUMAaWNnAmV92RcH/a/UYov/8NmGpIifdhMJin9Tx3nNrdQT7/Ke8l80KPC9J1R/VK0d8m9LT8mAcQkzHtilGgtVoMk2cJpuYhfR/VfIYp6ALxLpAYMPfxx+QP33SNzpBQ8HdK3Fe1TQfRn6yXR/5jKMvvFl3EzyzSgQbsrc/+zPfCP0ZtfujovO673bbd3lX3NkJD2TvTUEH5MdH4kCQudvIjM94qFg/Y9Hg1zo2uJiECASjtIST3Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEJqa5/qP3bbmQdpw6kEamDAWwnh0r7uwDkECItdN6E=;
 b=vNK7DYM7rfB47TQAyi5cnzCmUbzXxZVp7qYgbPQM8/BbpQtzHto2Fig7l+vJm5DvVNO/yY5ehzme8l0fpVcyh7Y6b9OaDHvETX/+VA9v4LesQDNfRalvDdYTuubEbIXce5Ip3ksiFj2KA9JjAKEP/g8ypYwc70H151WtmAtVIBRz6EFubB29ZTWpeKzCTDhJDvj8kleTPIvt4FJ4JVEyvWvCzrmMckITgnLWvsNVlM8paw5kRN6WaIzCSctk03XH2DdiSrBHMyJKUrLfnhPObQ4B4ZsL3J5dunVdr43/ZX5VW97EynhmBx1zUWz0jYGO/jiPAAusgy+mLM1Zp7PsLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEJqa5/qP3bbmQdpw6kEamDAWwnh0r7uwDkECItdN6E=;
 b=r1xzxJ/Bx3DcMnexvMM4lkxvjTeT2IE+6mDVb6Eixi0lTAbt/F7vrNgWmAn8F8LxF40gRqsLbBNTEPrU0kCO3QFmcwfapyeNMuarnocue6Ic3K7IBBZ0gP1icbmnhu5ezqKi/Z2+R4QE0qJS6tbZGFVqCQqSNqfdXK0QvBzVHl0=
Received: from SJ0PR05CA0116.namprd05.prod.outlook.com (2603:10b6:a03:334::31)
 by IA5PR12MB999277.namprd12.prod.outlook.com (2603:10b6:208:608::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:07:30 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::28) by SJ0PR05CA0116.outlook.office365.com
 (2603:10b6:a03:334::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.0 via Frontend Transport; Fri, 21
 Aug 2026 16:07:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:07:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:07:29 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:07:29 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:07:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/15] drm/amdgpu: remove retired cp cmd pkg for gc v12_1
Date: Fri, 21 Aug 2026 12:07:07 -0400
Message-ID: <20260821160710.752459-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160710.752459-1-alexander.deucher@amd.com>
References: <20260821160710.752459-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|IA5PR12MB999277:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a5aadd7-fc20-449b-c99c-08deff9e4d9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ITwATPOtOyG9HpPLCo/Z5J6G0CSTRa8+QmOHICGk0vtg6Qetes0EeHeWmPOEahJXkGBqhjAJlgqu6ecYMHvQZwl4/IZCJAKmuKl6s6Gsw5ZfTPdJZ41XwE+Pogh/mX2aKUarFmB+j3TmSh5zfzhhh/tYmfanSxIckoHM9eAN+Uglc4OccEi3qxPjRXtN2DqRXYTNmsksMLcYfI4li0y03PmRZpqOQq6fwrtc17NeMflowlhu2klHwORX4KgaUVYxK4/go/BTB4Dxh7/pUFAnE4qqw9jspjlRuYFfXxX9Wgfcg+TCXjS01EP1QSnAdcBXqclrgLTCfBMp+wdOv4CwJZJwwJFAtM11BXzWDN73abRq1W3KGSxvja7ayIyEVNhhikEJ34cyDlbDwyR/mizaMMly+w+bUgzUcTL6c+Ypp5Pgu95H6XVBO3FNibX/hruSqPzrGqwa0Spf/S6a+xKMLee2ERZ+hFwKySoNsgZ0himcT0y0J792CreFw7ZfDCLJGMStBYA254MwTCOINYWu1EfemInwMl3dLc+EPaX2TNttz7QclK/2face6VVFk7lF8LaMPet83e2Tm4bpfNB67NmoBU2Sbo2JtZDvBJ3zRBTcgbpb3kxWa/4iX+F914x5Pr3OEcB2KQDaW/YwdlIKx8tRFibMB5gQ9T2EZYFf6OmCPZ53vhdCUoItr8wwhoqT5ElUST5Ce3k8z52lGwvUXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: D+IZNKNJQjTIk2CXvWi+TzsHqZlYHdB/jheDwO9iNrnI28WoPqPyurm5fmdivQuP05rqBG8XDvOVaph+7K0m9z7L1IaB7qyd3VGVibcnW6d125TUSzYzc2ulbgEUp6CKM4jYHstCxPRHPUYrmi3iBoVocPF4Vj46yLNagt90QUTGoxehDlEeIq36Yxi070JDJ54JGyXX5UP8kKkVquyKA4tSrupvcIbc/tSyNeHzXC3onnSgvJYa+UVFcQ/sxo9XJ8zCq3eTY97fJsMheDVllMtSSa7M2vZQxOvE7T+clauZ7Kb0pEf0WETbLMMcji/E4x2hCM+CzKQIE5Ig7wfed2s13lzftCuV0Ev9ljVnfL3mxYVSU5Q2LFMIgA7dzWMY9ev+sys6yiJqx2wkIXCZmguDt1n96fEek6UXKt3hPvfd/JQwDPHNDijLbeQoPy8G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:07:30.4089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5aadd7-fc20-449b-c99c-08deff9e4d9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999277
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

From: Likun Gao <Likun.Gao@amd.com>

Remove retired cp command package for GC version 12.1.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h | 39 ----------------------
 1 file changed, 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h
index 77b4f6ea532f5..349c28685c7c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h
@@ -53,8 +53,6 @@
 
 /* Packet 3 types */
 #define	PACKET3_NOP					0x10
-#define	PACKET3_CLEAR_STATE				0x12
-#define	PACKET3_INDEX_BUFFER_SIZE			0x13
 #define	PACKET3_DISPATCH_DIRECT				0x15
 #define	PACKET3_DISPATCH_INDIRECT			0x16
 #define	PACKET3_ATOMIC_MEM				0x1E
@@ -81,23 +79,10 @@
 #define 	PACKET3_ATOMIC_MEM__TEMPORAL__NT 1
 #define 	PACKET3_ATOMIC_MEM__TEMPORAL__FW 2
 #define 	PACKET3_ATOMIC_MEM__TEMPORAL__UC 3
-#define	PACKET3_OCCLUSION_QUERY				0x1F
-#define	PACKET3_SET_PREDICATION				0x20
-#define	PACKET3_REG_RMW					0x21
 #define	PACKET3_COND_EXEC				0x22
 #define	PACKET3_PRED_EXEC				0x23
 #define 	PACKET3_PRED_EXEC__EXEC_COUNT(x) ((((unsigned)(x)) & 0x3FFF) << 0)
 #define 	PACKET3_PRED_EXEC__VIRTUALXCCID_SELECT(x) ((((unsigned)(x)) & 0xFF) << 24)
-#define	PACKET3_DRAW_INDIRECT				0x24
-#define	PACKET3_DRAW_INDEX_INDIRECT			0x25
-#define	PACKET3_INDEX_BASE				0x26
-#define	PACKET3_DRAW_INDEX_2				0x27
-#define	PACKET3_CONTEXT_CONTROL				0x28
-#define	PACKET3_DRAW_INDIRECT_MULTI			0x2C
-#define	PACKET3_DRAW_INDEX_AUTO				0x2D
-#define	PACKET3_NUM_INSTANCES				0x2F
-#define	PACKET3_DRAW_INDEX_MULTI_AUTO			0x30
-#define	PACKET3_DRAW_INDEX_OFFSET_2			0x35
 #define	PACKET3_WRITE_DATA				0x37
 #define 	PACKET3_WRITE_DATA__DST_SEL(x) ((((unsigned)(x)) & 0xF) << 8)
 #define 	PACKET3_WRITE_DATA__DST_SEL__MEM_MAPPED_REGISTER 0
@@ -148,7 +133,6 @@
 #define 	PACKET3_WRITE_DATA__DST_MMREG_ADDR_HI(x) ((((unsigned)(x)) & 0x3FFF) << 0)
 #define 	PACKET3_WRITE_DATA__DST_MEM_ADDR_HI(x) ((unsigned)(x))
 #define 	PACKET3_WRITE_DATA__DATA(x) ((unsigned)(x))
-#define	PACKET3_DRAW_INDEX_INDIRECT_MULTI		0x38
 #define	PACKET3_WAIT_REG_MEM				0x3C
 #define		PACKET3_WAIT_REG_MEM__FUNCTION(x) ((((unsigned)(x)) & 0x7) << 0)
 #define		PACKET3_WAIT_REG_MEM__FUNCTION__ALWAYS_PASS 0
@@ -298,7 +282,6 @@
 #define 	PACKET3_COPY_DATA__DST_SCOPE__SYSTEM 3
 #define 	PACKET3_COPY_DATA__PQ_EXE_STATUS__DEFAULT 0
 #define 	PACKET3_COPY_DATA__PQ_EXE_STATUS__PHASE_UPDATE 1
-#define	PACKET3_PFP_SYNC_ME				0x42
 #define	PACKET3_COND_WRITE				0x45
 #define	PACKET3_EVENT_WRITE				0x46
 #define		PACKET3_EVENT_WRITE__EVENT_TYPE(x) ((((unsigned)(x)) & 0x3F) << 0)
@@ -309,8 +292,6 @@
 #define 	PACKET3_EVENT_WRITE__EVENT_INDEX__OTHER 0
 #define 	PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_PIPELINESTAT 2
 #define 	PACKET3_EVENT_WRITE__EVENT_INDEX__CS_PARTIAL_FLUSH 4
-#define	PACKET3_EVENT_WRITE_EOP				0x47
-#define	PACKET3_EVENT_WRITE_EOS				0x48
 #define	PACKET3_RELEASE_MEM				0x49
 #define		PACKET3_RELEASE_MEM__EVENT_TYPE(x)  ((((unsigned)(x)) & 0x3F) << 0)
 #define		PACKET3_RELEASE_MEM__WAIT_SYNC(x)  ((((unsigned)(x)) & 0x1) << 7)
@@ -383,9 +364,6 @@
 #define		PACKET3_RELEASE_MEM__CMP_DATA_HI(x)     ((unsigned)(x))
 #define		PACKET3_RELEASE_MEM__INT_CTXID(x)     ((unsigned)(x))
 
-#define	PACKET3_PREAMBLE_CNTL				0x4A
-#              define PACKET3_PREAMBLE_BEGIN_CLEAR_STATE     (2 << 28)
-#              define PACKET3_PREAMBLE_END_CLEAR_STATE       (3 << 28)
 #define	PACKET3_DMA_DATA				0x50
 /* 1. header
  * 2. CONTROL
@@ -436,7 +414,6 @@
 #              define PACKET3_DMA_DATA_CMD_DAIC     (1 << 29)
 #              define PACKET3_DMA_DATA_CMD_RAW_WAIT (1 << 30)
 #              define PACKET3_DMA_DATA_CMD_DIS_WC   (1 << 30)
-#define	PACKET3_CONTEXT_REG_RMW				0x51
 #define	PACKET3_ACQUIRE_MEM				0x58
 /* 1.  HEADER */
 #define		PACKET3_ACQUIRE_MEM__COHER_SIZE(x) ((unsigned)(x))
@@ -510,20 +487,11 @@
 		 * 2: REVERSE
 		 */
 #define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__GCR_RANGE_IS_PA  (1 << 18)
-#define	PACKET3_GEN_PDEPTE				0x5B
 #define	PACKET3_PRIME_UTCL2				0x5D
-#define	PACKET3_LOAD_UCONFIG_REG			0x5E
-#define	PACKET3_LOAD_SH_REG				0x5F
-#define	PACKET3_LOAD_CONFIG_REG				0x60
-#define	PACKET3_LOAD_CONTEXT_REG			0x61
-#define	PACKET3_LOAD_COMPUTE_STATE			0x62
 #define	PACKET3_LOAD_SH_REG_INDEX			0x63
 #define	PACKET3_SET_CONFIG_REG				0x68
 #define		PACKET3_SET_CONFIG_REG_START			0x00002000
 #define		PACKET3_SET_CONFIG_REG_END			0x00002c00
-#define	PACKET3_SET_CONTEXT_REG				0x69
-#define		PACKET3_SET_CONTEXT_REG_START			0x0000a000
-#define		PACKET3_SET_CONTEXT_REG_END			0x0000a400
 #define	PACKET3_SET_SH_REG				0x76
 #define		PACKET3_SET_SH_REG_START			0x00002c00
 #define		PACKET3_SET_SH_REG_END				0x00003000
@@ -533,17 +501,12 @@
 #define 	PACKET3_SET_SH_REG__REG_DATA(x) (((unsigned)(x)))
 #define 	PACKET3_SET_SH_REG__INDEX__DEFAULT 0
 #define 	PACKET3_SET_SH_REG__INDEX__INSERT_VMID 1
-#define	PACKET3_SET_SH_REG_OFFSET			0x77
 #define	PACKET3_SET_QUEUE_REG				0x78
 #define	PACKET3_SET_UCONFIG_REG				0x79
 #define		PACKET3_SET_UCONFIG_REG_START			0x0000c000
 #define		PACKET3_SET_UCONFIG_REG_END			0x0000c400
 #define 	PACKET3_SET_UCONFIG_REG__REG_OFFSET(x) ((((unsigned)(x)) & 0xFFFF) << 0)
 #define 	PACKET3_SET_UCONFIG_REG__REG_DATA(x) (((unsigned)(x)))
-#define	PACKET3_SET_UCONFIG_REG_INDEX			0x7A
-#define	PACKET3_DISPATCH_DRAW_PREAMBLE			0x8C
-#define	PACKET3_DISPATCH_DRAW				0x8D
-#define	PACKET3_INDEX_ATTRIBUTES_INDIRECT		0x91
 #define	PACKET3_WAIT_REG_MEM64				0x93
 #define	PACKET3_HDP_FLUSH				0x95
 #define	PACKET3_INVALIDATE_TLBS				0x98
@@ -552,9 +515,7 @@
 #define PACKET3_INVALIDATE_TLBS_PASID(x)       ((x) << 5)
 #define PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(x)  ((x) << 29)
 
-#define	PACKET3_DMA_DATA_FILL_MULTI			0x9A
 #define	PACKET3_SET_SH_REG_INDEX			0x9B
-#define	PACKET3_LOAD_CONTEXT_REG_INDEX			0x9F
 #define	PACKET3_SET_RESOURCES				0xA0
 /* 1. header
  * 2. CONTROL
-- 
2.55.0

