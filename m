Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F00ECAC5BB
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 07:33:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E482D10E324;
	Fri, 10 Oct 2025 07:33:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jqLCkSjL";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010065.outbound.protection.outlook.com [52.101.201.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CA1D10E324
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 07:33:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IemC86DvdZNLD2jUj5Gox5AKAL+ePlgAUYGP78JHJgxBARtfMUNZ/7eUho5ks8u9MnqOM1aKdhw7aBmpB8B7AmbGyHSYgl26DDgFrzJx9vnvldAddyaD311gZKZU1mmjyIFsYHzIKp8/sg3swtuflNID/zvEJhOwCpxe8GkV3QOsnPLdU01uhDpEpfEK6NgClWM7kYR/6Q8KWVeMll+N0jAvKjj9wJ5rh0iZ5oNR3+Up6rXKNzLBKt/kigbBoGTG9FYqxrlnoNw2RNFg0gVuZmhOyUm3pKIdk7LkNJ6rcDwSePKX/p73iTNjyyz12x666U0l9Mv65tkNp1/O2Q/JSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ih4s6xNv6aifKbTgurQpUzJ+qYS55ZhDola+kmGqVU=;
 b=aLtao/mYPwhdLJWPVIiM7Wwxpoa31AP5LPU/TX3LXhlaNJA/1C7KXIH6jGNnmdChF5TBSE1Mz44SV2TKTPJ9eSb4cMuWY4t06QRce03EKXLaPAcPeHHwRhlYx2/Vp3vtD1oQsYIsYFq+oH+EnkiNrkLSYzAdSBRyEt9vIhQif7VDPdKzqhtz2TQ447KlVtiXxM4pQbS50NGIx0qkD5HxjwfTGIim870GASBrvX4EE0K0EgAcJHXuEJgwXzIgsWlSBLoMJSkQbkJuzWMJjD+7sq0obG+rSNdpV8SItCEdetM6t8HpBaEn3DvPEmq7EPQSSRzcfRfd6imk7Bcw/qyzaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ih4s6xNv6aifKbTgurQpUzJ+qYS55ZhDola+kmGqVU=;
 b=jqLCkSjLkXZ1dMhQkcnyWGspXvh3FWIcQLWgYe1NeKam4glJSmGrG6RBSco2apZbumNIz9Q+DJ0bkBVgwyTZbkn+W5h/Oyr3CPvlvth2v49Pl8q6OWF0zxPRkcken9oJCKw/mlML39ZusGHlrPkRTAMQaoDSdoWN0Pb1b+8AAYA=
Received: from SJ2PR07CA0024.namprd07.prod.outlook.com (2603:10b6:a03:505::14)
 by CY1PR12MB9627.namprd12.prod.outlook.com (2603:10b6:930:104::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 07:33:00 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::df) by SJ2PR07CA0024.outlook.office365.com
 (2603:10b6:a03:505::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 07:32:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 07:32:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 10 Oct
 2025 00:32:58 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 10 Oct
 2025 02:32:57 -0500
Received: from victor-aws2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 10 Oct 2025 00:32:56 -0700
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <HaiJun.Chang@amd.com>, Victor Zhao <Victor.Zhao@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu: Add kiq hdp flush callbacks
Date: Fri, 10 Oct 2025 15:32:45 +0800
Message-ID: <20251010073246.204178-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|CY1PR12MB9627:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f2df939-4e05-4a81-b71d-08de07cf3d0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0PjcWu6MDSeZjecC7QXwvQfvfiUieH3Ykl/mxZCrvoMpbfXbY+V6MTm+OGwP?=
 =?us-ascii?Q?OmFo9qT0IKSVE6Cy2KiksgFCzciHicFQvjKBKNTnopbog/nmK+Zhsyec/Iw0?=
 =?us-ascii?Q?0HSbmBjEx6k8scED+M4vTrG43DHJLpwFWa8wfNoNYEvBAs+CtkhQPUslL1pB?=
 =?us-ascii?Q?II2htRPs0rDZpRSs8rc2U8Ijp6HcOcxRcBb82ZuX/Lg7jj81OZALJGa1iuDl?=
 =?us-ascii?Q?Uew9zRpPWsc/cZpvvNIVGYWFh2R7Zg4P2LTslcoCpyqM6xMetfB7d7qTQqAG?=
 =?us-ascii?Q?Z9Z8T/vp2qoxM4pedOU+Y1DRGXIB4t2vjPCcw6Zy5GYQzOpwg2VGK8FpRTnv?=
 =?us-ascii?Q?OfE99HYuYjlAAjK2TSiq13DbnaiJZjEhAnkwR7UMl63OA30/z3+VdvP4LtoT?=
 =?us-ascii?Q?/qB06QmctMVkhr+kR+3BqtD8AFFloS69uu2uSQFAfGSK4wkAJidaJ5aQT2EM?=
 =?us-ascii?Q?v0UvaxKX+9dbfOP3fLrQItOvEfFCZYi0w+14ZSXzY6+N0kbZFsP4jIXiDY1R?=
 =?us-ascii?Q?3QdcRNtkG8E6kkcgF3wtMB+aSk6xBvnO5udaB6jf6L3RHq0RoiTG7Wd5R+bT?=
 =?us-ascii?Q?q0GL3q/TwiuP1+8i0nUUIodlAQ2ErE0+ir/TSLhWOC4/QP0H9Uci95l6tCXw?=
 =?us-ascii?Q?m6FbrvWfDfA9vWmOh4R3jjm9TuFPO/MXjTaVVVSrUA0QXeLs6xWgZgzDEAaJ?=
 =?us-ascii?Q?j/lJ80HNxsMXou9uR3JLAaqL1um7YRQcJim1rguDncn8dMl24KD9U+Dx8+r0?=
 =?us-ascii?Q?hoUMOWqNU4C3mqow6Ps8GXuVW0G8hfTlQZTnOHKZbZp0kbDpnlYYLvKPr+YO?=
 =?us-ascii?Q?edcAYofRJgfr96KN0nDyVLohEXgsvSzC8USS9lG7RTzMWO6VAMf6pl5czvMO?=
 =?us-ascii?Q?AG/Na8pNTq8SG+5QypJBubKw5+4BurTDtnjVA0VVrchoiaT+aXwCkZQdpH4D?=
 =?us-ascii?Q?mi2HIPqEuYMsfolob+bJbks+18zrPKWp5fGyTnkOh1N95nC+7fyOJfSOm7E9?=
 =?us-ascii?Q?X662FX54iOF8It3Tw8AyJMLFMmmAmiFU2f/2p234NegAXqiTjdpPAIR+G/IJ?=
 =?us-ascii?Q?MlG9LH2NOZBUgLhxDq62AWd6KIJbkjEDmoHmzt5ScnZXn9+b/zrF/Aqx+jlG?=
 =?us-ascii?Q?11ExaVgStPx8Djyw1P1nAqmOSD+6bLhQD2KkHHIXZtaz85+DG2D/N3tvJJol?=
 =?us-ascii?Q?Kh440PH5IbRzr6J1P5qpIFTe4Y+9HK2fmZ9LzZ93G+FGgs+Xjn2dDIalFzsU?=
 =?us-ascii?Q?YZBaEZ6nhS6hTco+1yKm9mYuMskFN9+LkMyT0tOejXZzjzKfUfAt5jd5n3kW?=
 =?us-ascii?Q?rF1AQ7ZVKQgolpXx/RGHeanLRpajRqsjkKE3c5Kap1+E139SuP10f1JI2YP8?=
 =?us-ascii?Q?fl5BfySFp2Ely2QwqPlwNpr46Pnbz24QdMnzG+wEG3YyuRUHLcWfcIeWyu8q?=
 =?us-ascii?Q?0iW7J39NRzYMbPUXTYWGmbsjN+6Nph4LhTEAjk11sGe65hSZdK24MIm5g4WR?=
 =?us-ascii?Q?KyO/FPusU2FCkzVpJpX0DiDTUEbuntdBuFxePhPbbfG4GUx0sdYIBffvKUAG?=
 =?us-ascii?Q?NFgmnx/Rp3XlfuoD7Y0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 07:32:59.5660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2df939-4e05-4a81-b71d-08de07cf3d0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9627
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

Add kiq hdp flush callbacks for gfx ips to support gpu hdp flush when no
ring presents

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 5 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 1 +
 6 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 8841d7213de4..751732f3e883 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9951,6 +9951,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
+	.emit_hdp_flush = gfx_v10_0_ring_emit_hdp_flush,
 };
 
 static void gfx_v10_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 66c47c466532..10d2219866f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -2438,7 +2438,7 @@ static int gfx_v11_0_rlc_load_microcode(struct amdgpu_device *adev)
 			if (version_minor == 3)
 				gfx_v11_0_load_rlcp_rlcv_microcode(adev);
 		}
-		
+
 		return 0;
 	}
 
@@ -3886,7 +3886,7 @@ static int gfx_v11_0_cp_compute_load_microcode(struct amdgpu_device *adev)
 	}
 
 	memcpy(fw, fw_data, fw_size);
-	
+
 	amdgpu_bo_kunmap(adev->gfx.mec.mec_fw_obj);
 	amdgpu_bo_unreserve(adev->gfx.mec.mec_fw_obj);
 
@@ -7320,6 +7320,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
+	.emit_hdp_flush = gfx_v11_0_ring_emit_hdp_flush,
 };
 
 static void gfx_v11_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 710ec9c34e43..e2bb8668150d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5597,6 +5597,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_kiq = {
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
+	.emit_hdp_flush = gfx_v12_0_ring_emit_hdp_flush,
 };
 
 static void gfx_v12_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 0856ff65288c..d3d0a4b0380c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6939,6 +6939,7 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_kiq = {
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_rreg = gfx_v8_0_ring_emit_rreg,
 	.emit_wreg = gfx_v8_0_ring_emit_wreg,
+	.emit_hdp_flush = gfx_v8_0_ring_emit_hdp_flush,
 };
 
 static void gfx_v8_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index dd19a97436db..f1a2efc2a8d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7586,6 +7586,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
 	.emit_wreg = gfx_v9_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
+	.emit_hdp_flush = gfx_v9_0_ring_emit_hdp_flush,
 };
 
 static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index fb5585ab52be..e0b50c690f8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4792,6 +4792,7 @@ static const struct amdgpu_ring_funcs gfx_v9_4_3_ring_funcs_kiq = {
 	.emit_wreg = gfx_v9_4_3_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_4_3_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_4_3_ring_emit_reg_write_reg_wait,
+	.emit_hdp_flush = gfx_v9_4_3_ring_emit_hdp_flush,
 };
 
 static void gfx_v9_4_3_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

