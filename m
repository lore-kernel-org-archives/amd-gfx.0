Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBA6CD98E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:56:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ED9C10E5BD;
	Mon, 15 Jun 2026 23:56:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XMn8YF98";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011022.outbound.protection.outlook.com [52.101.57.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19A7C10E5BD
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:56:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KeWDi3H/vqf8iM/rXN8QgsG9gkW8uIY80SaggQdLHTYOMYYRKmKkEYo0/Zrx64+lCrI/LXxCMF0q/XHo0TW9jRB7E8EW4yR216qKcJdYSp/9dsdLQ0OUEnC8MpMSO34pnKAxrN4124oDz6zp2Wy9y/YQjml5kJ8QBfH8KkWExgdqE7z+ISSNmw9vEQ/shjzzGnZp8/j9nCVWxgKn6QCL6GSGFFMUPOw1yCX/gTqsp45/jxGfBs3X9Gl0AJudcn2MBBdyhnkz5WTuwT+Z+K3L3V9FI4oIJm0mvO2lB55jrzCuFkhezF8XeSgHnxa/vLtruoXvFJnN2bjyAPczu2yGeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBP4LktiMEc1xYaJDOW2b8UIfzvp0Mf7bgDxb8TxoVU=;
 b=Bd6ZplJ0z/xb/NFtzJ592WsklngSlFNEvWI2MoMGnNoXIBWKqHoNOH1BweNI6a1bg7/QNy9NUCuxF7udB/rNKR+zFVO3lQzTgBDnn813LwLZatA4j8lzwkeUNazpKB7DuJuNSpLyxvhnklu5HDY9Ht6OCNydit4mMnlMBEcKTuCBtJKiCSR2NKw3A0zL0u4rWrlh2DOHAF8GY5+TbnvrPRTwIjjhrnFn1eBttUBZFwfgIfcHwpHWpWKJBtzkVgiLQAc5vxLgr0VtPPuvBNwmG56k4OxsvMygrp9R6i+rkKOh2W6aI/WLQahKt53ZApanOY8jvD4c+23lbmraWGlydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBP4LktiMEc1xYaJDOW2b8UIfzvp0Mf7bgDxb8TxoVU=;
 b=XMn8YF98ByzShj8aTzaGlVPI/xQ46gd3thb4vDUNLWFd2Ev2YBoIbd4MktwRpVplH9aork81Luem1XZLFW3qA9EhsqBsLqdxlxk+bWqg9+bjRgZRgTnZhM03S4XZpTmseqW1L/48YMD0J5BY7knfIPKOKrEB/o0KyIpOVLOAoko=
Received: from CY5PR22CA0040.namprd22.prod.outlook.com (2603:10b6:930:1d::16)
 by IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 23:56:53 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:930:1d:cafe::36) by CY5PR22CA0040.outlook.office365.com
 (2603:10b6:930:1d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 23:56:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:56:52 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:56:52 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:56:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/43] drm/amdgpu/gfx8: replace BUG_ON() with WARN_ON()
Date: Mon, 15 Jun 2026 19:56:03 -0400
Message-ID: <20260615235645.737189-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|IA0PR12MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: 740bb29b-62bd-4fe4-9104-08decb39c614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: qcNCJKh9JcQLvDtlpZ5hu9z4lckhpTQ9Lc8usNLmCZo1yzuKtDAruCKg75eucQeC9snIC9S6QlLItSdQntWlSDak/9SOWHK0XFOKRgdoL9CZBiOzvLpRhe9DebUqJejsnyWAWRkG/hAjX/6qppRwmeOFbUJvXOSapsjhDEF4MWhjQJRZmRt9r6ItYOeL9huq6UmrTBnOdRwiOQcPyO+YQ0+fHgz8NU5AmbnqgREApcJGG7LOxQeRUwSd1A7R6Vx8Ol9MjNE5hjGnh9L+NxyYQ+L01RTYxm0BfcRCiq715uXDqCj1owuGOR+5jFr9sIhj3kr5kXqAEwR4PMcQTeagmFSiKn5+hTFfDGh/4iD0zpoH/iMFFn5RO56LYLSdaExvKApimkmKfAn/wYPMUqKqKGyID4eo9SnDLCdYRPUDb1nCuBRcYpjSIsuIKCp0orhLQUuXsg2cSyc7OfTyDonQlhMD5iah2l92IK6e2CMhjTjhYAa53vE1+HpL+07bZA4p38gmVkMLm6IBqDzdJRFrc/FjHmRAe9SAywcveI5FP+zD45uNLzv6DHYvlLNee03Teud4mchVRW0waT6iyT/hEYLHEPYgi+824QxsHElYs774a/et/zBGUQTcxFGbx1B+laUscLHiVieHEHsKKTUQt1yE/7i3UxYpk3jR82uYi8G46Slam38xWdhS30CYwvbUH4QK04ZC2cHKl6AM9JJ8NGh5/S8uYZPJiV8HMDJKs8w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(18002099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EXDH+1qR1jckGf+5aiXEqJ6Et2ccIH23sHIpeZx4GL0lbUGUzKoe+NouMcbhwFKS6LcrKzJzyWxGYEyx5e4a3tkyZeNQLRGPw/SZV2odW+02KdGD5WFxeD3pbrv0P9A09e/4qjzqZdn98nEO8gUbJVna8QSxBHXtsjMRh9GPPm5meas5qeZvd8gXSbSf/Zd0CudQDy1uynJzb0VR9HS0Y2TGQBn6746Msgn29iRji6ZRPhJaIhY/d9xq92gjW9MmkCfU9C0waIeIhbn217SLCOKzPqm3sF4wLtexQljGaSjN5bsd7K7I0NAzhDfS851UvATEDXad83gHMPDTnP/I/pHSZI2UF7fcbSFvlm3Kwlp8qJFP65VDQPWdw3zAmMaF8c36P8uGDyyCsxsTxucJ6iVAOn0VFzis94y0gIQFwYf/uxNoW0IdIGQljyKQZDqo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:56:52.9439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 740bb29b-62bd-4fe4-9104-08decb39c614
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8906
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

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 130196859ff3f..70ba81e6b4d43 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6256,9 +6256,6 @@ static void gfx_v8_0_ring_emit_fence_compute(struct amdgpu_ring *ring,
 static void gfx_v8_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
 					 u64 seq, unsigned int flags)
 {
-	/* we only allocate 32bit for each seq wb address */
-	BUG_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
-
 	/* write fence seq to the "addr" */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
 	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
-- 
2.54.0

