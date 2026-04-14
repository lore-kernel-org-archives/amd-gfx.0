Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C872BF9D0F1
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 19:48:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D59210E664;
	Tue, 14 Apr 2026 19:48:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nVDdrDty";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010066.outbound.protection.outlook.com [52.101.56.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B4AB10E664
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 19:48:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9Kpr3cdVyNbjm9pahKjwaJ+otajpFwi6bVvncwdxiYnnX7F/JHl09uh3I+GZ3tvrtVU6Dp3/GKHSJSKUv7Mv7lSTJb97KVr1c35/xyqsQNI71u3UKlVXNS4Wk+rSvKZn/JL0GzZiklsJdWGmWt9qqOozosk/TF8Nts9WWXI2pgRHp2cvPVUgjnoCA8V4F0UM654OvL0OG4Xrtcsd63CG+lZnti1Qt2vvOgdDXDVjC0VCuzpdZDn8KmIPlto4w5k66zhQNsghxz9iKFC/HTLuJt8aEZeDpkpasT7bwyfSzlat2t2lJlJs0F4Tkve2JCr7SKiWBofAO84AyX1fJj4ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMhQis12jmVPf1vBv626rQy91AoDaCCck86HH2LWxxs=;
 b=V6K+vFZZBALSuMSa4cBw4p6IpmWOP9YHShAMwuQ6ViNAwK2EIfwuCW9X+IWFJUQV4fAPfy3ReLexrHtM+6fPXzipIA7RWLcZq2L2Va6X3xscYtaZVfELbSMU9nj/ELg5MIz9ubWExPM8fU9iurpa9hx8k1CUFCNn5WABey+/jZyrQTE1W4ksNVKUzyzLMTxJjJCz6IlR+d/Tsz1UB+1LoaZwbwcDnTOQ5moHqeU7D9iymQFNjjMPr61IpUiIY7bCUfaj/HpiZCVYuZMudp0XoyUI/D6XlLIfEgsaOsaM5wjM9hR8Vhnn1Vh4ZBnaKQI63KjAQkwyoy0bsTM59AJa9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMhQis12jmVPf1vBv626rQy91AoDaCCck86HH2LWxxs=;
 b=nVDdrDtyeUlf2nLRlXP/1xbzK9B4dDxzxJbcq/CPj/8eAE2B2fzBAtGaP2d+St00ZOfksLLTUrnooF41opiiwRmCkWf/ZHn4rPZRLkQc/zqxu+MYwEcVrXZOmfOiE5SNRMgj8DwqtT2o7U3IAX0AfuPdBOlgVAoWVfb70MsioH0=
Received: from BLAPR03CA0028.namprd03.prod.outlook.com (2603:10b6:208:32b::33)
 by DS0PR12MB6414.namprd12.prod.outlook.com (2603:10b6:8:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Tue, 14 Apr
 2026 19:48:29 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::72) by BLAPR03CA0028.outlook.office365.com
 (2603:10b6:208:32b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 19:48:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 19:48:29 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 14:48:29 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 14:48:29 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 14:48:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: update cp cmd pkt for gfx v12_1 v2
Date: Tue, 14 Apr 2026 15:48:17 -0400
Message-ID: <20260414194817.2213993-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414194817.2213993-1-alexander.deucher@amd.com>
References: <20260414194817.2213993-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|DS0PR12MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f74bf2-8391-4e78-df81-08de9a5ecd77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Bah81rbXDT+RhF/0LNRV0tiI5+IDwdFJ8m9+qSzAnUZkCBbaTO6AbMgIIQ5lkx0V3wp2PnW/Ua946qF3+RgQir0JXGKSHzGJf+vb1+uLcaV3buJb5H3/cxN8H0QUOWmFguinqIeDgXMKLQjF/JR0yoh1/1rK3VyqBhbaRcea15Z1U33WGqZDmsku3UgH5+O2Pbw26XQXjA1Xofs5BvORsnoDowR6gpK25custMnQI6vVh9vpRMRIWELt0ztH1CXPizwJmiOvnwASiEJ+/wD5cqpL4EBBY3sL0pAckRrirn3z4ZN9xcWTLV4R9EvUw4W27V+GXzL4TPHRA49GKFr5bPnvu0aGhjIeUhgSBVPEPOpBaHv9A+elju6aglC7uZwWLgF2sWCGT5tA1nzxA4E17g/zoKETcFdVFW/iKdMICugEhKQklbVfXdkKRI05I1jwzttQDnc11cZiyGWOGbwwZhwGm4D7q/RC7XD/2ld4b/UssjZlYBl9T0WXjbc6j1PXUKCQaOC0zdWfRKlC3A7VGeOJDCgUEKoCUn2559JIg/wZ9dU/mnU/0C0HjRpcDQv+16cGhKZjwLNc/RD2s52mCt3Rhyq+4T0J2kN+xE8RT5vQ5HASrdzgTWrSKJZHAHziE/aOD/FBK4khWq1IkpHtDGfUOEnbiv7b5yYLvWQ3cexiqoRd8eetdItb1SVB5CAeQ+HteWE61eCRFO0x5g+fE5hnWfGdmNtbGjqxlNcGKDbLeD5nhebbolkMKR1gw6AVwd+GcgN6rnxTn0E5ikn3WA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: s0HQCWWedXTrbgD/xm6IeprP6j7k0MYLi1mwe/dmNurEPnag2GrEDr+P6UsFupaArYsBqmjbl6j3cjfyzKj+KxTKXmjsjV5W3WoQ8nKZ4/6xoiQHxIkaqmwnS1xvYM67Ed5CxXhc9sLCNpmlt0NH3daN1lBzfBzvXFZWA8/IY2cSdW7JZUoXIPTJMLVqrM8ZwkcVNGCxPU7L2+HnVo6oTdUFXpDgI96qlFWBy4CChvLBW4tWZL6aD0dSKbBi2VeLLEoQT8/+yWw0DkvQjVxAw0uV/0NerK+MrSzF9e3/9B6FkVR0b/8IYycfZhnb/ThuaLLHmkhl8C33vmQ08ixBfCJqe49qAuepMR4A7KHpEKnItsyUxRk0nPsZLAXdmvetb4abE9726nODrk8+MVxcaHjxzYPl9lkW5RFzPOgmswCQUQOmqt3+LssKEd/jTldN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 19:48:29.7545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f74bf2-8391-4e78-df81-08de9a5ecd77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6414
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

Update CP command package for gfx v12.1.
1. Update to common command pkg format for PACKET3_ACQUIRE_MEM.
2. Update to definition PACKET3_PRED_EXEC command pkt.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     | 12 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h | 68 ++++++++++++++--------
 2 files changed, 51 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 3bef36f5a487e..885183eb7e7b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -3825,12 +3825,12 @@ static int gfx_v12_1_rlc_poison_irq(struct amdgpu_device *adev,
 static void gfx_v12_1_emit_mem_sync(struct amdgpu_ring *ring)
 {
 	const unsigned int gcr_cntl =
-			PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_INV(1) |
-			PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_WB(1) |
-			PACKET3_ACQUIRE_MEM_GCR_CNTL_GLV_INV(1) |
-			PACKET3_ACQUIRE_MEM_GCR_CNTL_GLK_INV(1) |
-			PACKET3_ACQUIRE_MEM_GCR_CNTL_GLI_INV(1) |
-			PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_SCOPE(2);
+			PACKET3_ACQUIRE_MEM__GCR_CNTL__GL2_INV(1) |
+			PACKET3_ACQUIRE_MEM__GCR_CNTL__GL2_WB(1) |
+			PACKET3_ACQUIRE_MEM__GCR_CNTL__GLV_INV(1) |
+			PACKET3_ACQUIRE_MEM__GCR_CNTL__GLK_INV(1) |
+			PACKET3_ACQUIRE_MEM__GCR_CNTL__GLI_INV(1) |
+			PACKET3_ACQUIRE_MEM__GCR_CNTL__GL2_SCOPE(2);
 
 	/* ACQUIRE_MEM - make one or more surfaces valid for use by the subsequent operations */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_ACQUIRE_MEM, 6));
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h
index 21a07530c64d5..df0ada0b56d1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h
@@ -63,6 +63,8 @@
 #define	PACKET3_REG_RMW					0x21
 #define	PACKET3_COND_EXEC				0x22
 #define	PACKET3_PRED_EXEC				0x23
+#define 	PACKET3_PRED_EXEC__EXEC_COUNT(x) ((((unsigned)(x)) & 0x3FFF) << 0)
+#define 	PACKET3_PRED_EXEC__VIRTUALXCCID_SELECT(x) ((((unsigned)(x)) & 0xFF) << 24)
 #define	PACKET3_DRAW_INDIRECT				0x24
 #define	PACKET3_DRAW_INDEX_INDIRECT			0x25
 #define	PACKET3_INDEX_BASE				0x26
@@ -279,58 +281,78 @@
 #              define PACKET3_DMA_DATA_CMD_DIS_WC   (1 << 30)
 #define	PACKET3_CONTEXT_REG_RMW				0x51
 #define	PACKET3_ACQUIRE_MEM				0x58
-/* 1.  HEADER
- * 2.  COHER_CNTL [30:0]
- * 2.1 ENGINE_SEL [31:31]
- * 2.  COHER_SIZE [31:0]
- * 3.  COHER_SIZE_HI [7:0]
- * 4.  COHER_BASE_LO [31:0]
- * 5.  COHER_BASE_HI [23:0]
- * 7.  POLL_INTERVAL [15:0]
- * 8.  GCR_CNTL [18:0]
- */
-#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GLI_INV(x) ((x) << 0)
+/* 1.  HEADER */
+#define		PACKET3_ACQUIRE_MEM__COHER_SIZE(x) ((unsigned)(x))
+/* 3.  COHER_SIZE [31:0] */
+#define		PACKET3_ACQUIRE_MEM__COHER_SIZE_HI(x) ((((unsigned)(x)) & 0xFF) << 0)
+/* 4.  COHER_SIZE_HI [7:0] */
+#define		PACKET3_ACQUIRE_MEM__COHER_BASE_LO(x) ((unsigned)(x))
+/* 5.  COHER_BASE_LO [31:0] */
+#define		PACKET3_ACQUIRE_MEM__COHER_BASE_HI(x) ((((unsigned)(x)) & 0xFFFFFF) << 0)
+/* 6.  COHER_BASE_HI [23:0] */
+#define		PACKET3_ACQUIRE_MEM__POLL_INTERVAL(x) ((((unsigned)(x)) & 0xFFFF) << 0)
+/* 7.  POLL_INTERVAL [15:0] */
+#define		PACKET3_ACQUIRE_MEM__GCR_CNTL(x) ((((unsigned)(x)) & 0x7FFFF) << 0)
+/* 8.  GCR_CNTL [18:0] */
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__GLI_INV(x) ((x) << 0)
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__GLI_INV__NOP 0
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__GLI_INV__ALL 1
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__GLI_INV__RANGE 2
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__GLI_INV__FIRST_LAST 3
 		/*
 		 * 0:NOP
 		 * 1:ALL
 		 * 2:RANGE
 		 * 3:FIRST_LAST
 		 */
-#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL1_RANGE(x) ((x) << 2)
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__GL1_RANGE(x) ((x) << 2)
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__GL1_RANGE__ALL   0
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__GL1_RANGE__RANGE   2
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__GL1_RANGE__FIRST_LAST   3
 		/*
 		 * 0:ALL
 		 * 1:reserved
 		 * 2:RANGE
 		 * 3:FIRST_LAST
 		 */
-#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_SCOPE(x) ((x) << 4)
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__GL2_SCOPE(x) ((x) << 4)
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__GL2_SCOPE__DEVICE    0
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__GL2_SCOPE__SYSTEM    1
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__GL2_SCOPE__FORCE_ALL    2
         /*
          * 0:Device scope
          * 1:System scope
          * 2:Force INV/WB all
          * 3:Reserved
          */
-#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GLV_WB(x) ((x) << 6)
-#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GLK_INV(x) ((x) << 7)
-#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GLV_INV(x) ((x) << 8)
-#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_US(x) ((x) << 10)
-#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_RANGE(x) ((x) << 11)
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__GLV_WB(x) ((x) << 6)
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__GLK_INV(x) ((x) << 7)
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__GLV_INV(x) ((x) << 8)
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__GL2_US(x) ((x) << 10)
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__GL2_RANGE(x) ((x) << 11)
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__GL2_RANGE__ALL   0
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__GL2_RANGE__VOL   1
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__GL2_RANGE__RANGE   2
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__GL2_RANGE__FIRST_LAST   3
 		/*
 		 * 0:ALL
 		 * 1:VOL
 		 * 2:RANGE
 		 * 3:FIRST_LAST
 		 */
-#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_DISCARD(x)  ((x) << 13)
-#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_INV(x) ((x) << 14)
-#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_WB(x) ((x) << 15)
-#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_SEQ(x) ((x) << 16)
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__GL2_DISCARD(x)  ((x) << 13)
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__GL2_INV(x) ((x) << 14)
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__GL2_WB(x) ((x) << 15)
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__SEQ(x) ((x) << 16)
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__SEQ__PARALLET    0
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__SEQ__FORWARD    1
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__SEQ__REVERSE    2
 		/*
 		 * 0: PARALLEL
 		 * 1: FORWARD
 		 * 2: REVERSE
 		 */
-#define 	PACKET3_ACQUIRE_MEM_GCR_RANGE_IS_PA  (1 << 18)
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL__GCR_RANGE_IS_PA  (1 << 18)
 #define	PACKET3_GEN_PDEPTE				0x5B
 #define	PACKET3_PRIME_UTCL2				0x5D
 #define	PACKET3_LOAD_UCONFIG_REG			0x5E
-- 
2.53.0

