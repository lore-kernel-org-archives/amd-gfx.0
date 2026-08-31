Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFCAC61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:31:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B59BE10E41E;
	Mon, 31 Aug 2026 18:31:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="30hr6sG0";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013045.outbound.protection.outlook.com
 [40.93.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 789CB10EA7A
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0oLshQ0ZWiHPiPLZNOG52AHXq8KFgnCp5xJ913P+laDfpLJYerF0BzYOFFQim7kbS63K1bgsvkpnyU/7h/ENswdtvy/LvosRU22X8GspaqK7wXuFPMlUfe2T1WNkKph1x6mBQvvgD0ec0g8n9oAygngqGs6j3PN/0brcMxsh3T4LPg04V71dcS9w4gqjv/VPiN6ERqKkJXmPwMPPi9QOPzfHQM7IkPBH0XK50yEQQSnkUDiXhc45B9oxiZqutEbf7uHYjK3g2I4ylfboQiAkKBn8CxG+OnoKvThnc/yg90441Ac7QTyYG0EkgyFjjlH9289J+mAb00cq3XPDde1kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KD5ZIDae/1lyzopxf+c7n2PEZTFbHaFmzaE/JGd6LD8=;
 b=iShKifAVv+jhlEgWRpEKdr1ly84zwVIhEpRKVHtqq9R1y+zVLYB02TZbz02axhovzfN2Wa7kWdgEQpY6/PTpojuWEu8VBjP+KTrOW0mvmM45xYv/jbXZ0G5i8QQhK7HC5N7zvSKY8hyONwcTFDXkKOMZN7Ft17AnLCGfipMWi1ZqEKzfDHxkfwU60s3w+TstbxQV34j+rGNOe/kNj/H7648zJ3o0S/idKF28vnjp1nRV3KqMUXSlbvqmaePtb2sRuduslNCJ3SWsGdSjtbAH9kqWjbBO271PMjep7YiXc5lULoENuISf+xxWMqFPoGHhK41HLhUyRbsgCuZSAZitLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KD5ZIDae/1lyzopxf+c7n2PEZTFbHaFmzaE/JGd6LD8=;
 b=30hr6sG0si/RouixT5kf9Zieeea7iTopU4Kg5rObxBkItSj8wQT7PuoXVxgd0qnx+Jyth3+PrxtX7IHLayBjcvTyLhqmzV6nqMsJyiNrglMHGpXFo95ndlA300Cc3mERSV3rLnLRqDSifAHdytn8pNv2HhGNRI+i3xa9axNxp4U=
Received: from BL1PR13CA0071.namprd13.prod.outlook.com (2603:10b6:208:2b8::16)
 by PH0PR12MB8125.namprd12.prod.outlook.com (2603:10b6:510:293::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Mon, 31 Aug
 2026 18:29:43 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::1a) by BL1PR13CA0071.outlook.office365.com
 (2603:10b6:208:2b8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Mon,
 31 Aug 2026 18:29:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:42 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:29:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:29:06 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:29:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 95/95] drm/amdgpu: Honor mtype overrides for NPA remote memory
Date: Mon, 31 Aug 2026 14:27:54 -0400
Message-ID: <20260831182754.1089811-96-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|PH0PR12MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: 3887035d-8de7-4ba8-b019-08df078dd372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|3023799007|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tPHSKupoK651KVmLDjdPbpZFOEURxiimjy+DieK7dYPFZXANXakUqcqEZDyJhGlpsCQ32d6XHni2GgluWthSNZFfvc3/CxixdCOCXIHyCTr7yJu1OlveXTpXi8a5PzMGcpYfKxy9zy6Ui98nQTxqdaCB1uCn1g2OZxDS+EmER3KQfgNVf72hQn24O5dJj+j6+Yk5EX1PEYUHBcQW5NHUh10T6sMZT87TPZ2Xstg2VDvJu6DeyjDPAdQXzjHuq8BFVDn0I4z+AcsW1SM7HPD/OOnNipgxNes3LcJitdY6seBDI8z4wx10tmUgvnVOprKN88MR445tvT4MuhPSsCu2T+hF6Yblf0gO6re/UUxebh0CSPNjZVYhU7k+c1MZYGj/hfx4UYCm65u8x3jPjie3eFUuTbSwbTSLIMH/G1D27YRAKWa1KQI5mj1NGC2aJddShgfpYIFMLR4yVxfmaWgPNClfKndUxKya4+6hiyy2gdScThSPEyGv7TTmFoLt4kzOx3kN1PGkg7hU2nfCv3AWJNg4GFzndBZp2QpdwyIsqv+Z0DT4llxS5iWB6b/exg6Bd6svMWTQYIx3zPWKaE7udrA8Oo0uSxGI53NdqmckZRR+iqa7jP3e0vAqJnOzGjccCmI8m4NaIBu0Hpk5ereqL7MGHGq0pRoBcoT6fQDT7Tt2PALr9VL6mEOcmo0L/dCa0AZThKwsCTfKZXAmwZArhg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(3023799007)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZwbumymoMnHV/M2NCajZfj6UJWrho6cuULQWUJy+9HPqlKoLq5XyiYhJ54S0nxX0iCUVKW0DD1/cPSeRS0O6XUaCohFyHHk+BJNPI7SUNiNMCV0sxlrjAj995MWcuMFakLJAFz4xDHkZtvO62LREfHNCMbi2pUXN6fsG2FWksgXmxozQ4S6yUwl57s9XsgQncYw4L6jumzpxZ9KUaXPizkJ8l8CVcRKWgwNxQcZo+wUbJU+tPmVBnzYH2IPlZ6YIfPwO6KE1K0/jORyGM/u79buE7zqCM15l3njuN7RWstg5XqBiMqRl9Jm6PuS0Dmwnl8NQ83WSTa957HhRKt/HR+bZVn17L8QPaFQqXwbtK2QCyhiM78ae1ljPDPVGfPu11WWsrhLr1Rn43UgVi9hJEwFCZR2yrbOlVLl4uY8X9CCqDZRdC+JFVC4ZcFiMAJFx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:42.8730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3887035d-8de7-4ba8-b019-08df078dd372
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8125
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

From: Mukul Joshi <mukul.joshi@amd.com>

Derive mtype_remote in gmc_v12_1_get_npa_flags() from
gmc_v12_1_get_mtypes() so the module-parameter override and ASIC
defaults are honored instead of recomputing with hard-coded values.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 4e7b6e2c87ab5..565ee7fba3cdb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -28,6 +28,10 @@
 #include "oss/osssys_7_1_0_sh_mask.h"
 #include "ivsrcid/vmc/irqsrcs_vmc_1_0.h"
 
+static void gmc_v12_1_get_mtypes(struct amdgpu_device *adev,
+				 unsigned int *mtype_local,
+				 unsigned int *mtype_remote);
+
 static int gmc_v12_1_vm_fault_interrupt_state(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *src,
 					      unsigned int type,
@@ -603,10 +607,9 @@ static void gmc_v12_1_get_vm_pde(struct amdgpu_device *adev, int level,
 static void gmc_v12_1_get_npa_flags(struct amdgpu_device *adev,
 				    uint64_t *flags)
 {
-	bool is_aid_a1 = (adev->rev_id & 0x10);
-	unsigned int mtype_remote;
+	unsigned int mtype_local, mtype_remote;
 
-	mtype_remote = is_aid_a1 ? MTYPE_NC : MTYPE_UC;
+	gmc_v12_1_get_mtypes(adev, &mtype_local, &mtype_remote);
 
 	*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, mtype_remote);
 	/* VSCT = 0011 to identify NPA. Additionally PTE.B = 1 */
-- 
2.55.0

