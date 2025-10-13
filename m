Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50ECECCD183
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 16:14:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0BE510E466;
	Mon, 13 Oct 2025 16:14:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KPyaJNPT";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8418310E466
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 16:14:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWgA4h1kypO/XSdisMG2EGBRqkUMJGmDbcXlJoxtaoj90P1T/J/yO/M8+g/4vfOctrea0Dpq7MuFihF8wMt5zUb+zO3MIcfwn70ekpdwQewv8L0vpaEIAUMVTsLMVHQhoaG9XqjsWjZJfq5SN47ubjQUpfsFajydL/3sUk1HWLseZcChJ3+3jyTZPDI/knXGcjhqh9BkutKmWSbLygxpJh9qEIxXqE6Skwjpj9Kgq1oHgynxR5+Ya9FKdAjI/yIAod5GAuuS9kBZ/v45U5O+6i8P/foMuZdQeHGyIbK5O2AjZjxjfZPkxx3nHSQbwCF0hBYuIPGWmzPH5L8ntF1ZUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKFTu1lpsZr9OSzA74ycbSIK5lksnLY6e0h0qUr105Y=;
 b=UgJTq4f9mZktDlxCg/vaZd1vamFGt/mTrV0/1OJVteaaB2/2h7LdnO1bpG5lvgrwSAm4C34NWSkEOnei9acFhK0l/UoYNd4sBuwErdLcg9N5AvDxqsihDF4urZvdd5+qqwnvrkXpqvjmFiY90281FLiKdFRIcZozw9pG8K235hI2Hw5AOjYKuGp+bDyQjvFC5MCCTFzPwRTLOWIYuRoD1zIv0t8UW69hgp/EU7AYeWLUp4XMnoKLDeBIWtmAjXPI5ASXcb9R9skHbJIMsvvYpRWOvqnSJP3zWCGLjiXi+X9OGYrL+K/aB+rpzdCXt240K1cwudEKao3cYx085mKDTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKFTu1lpsZr9OSzA74ycbSIK5lksnLY6e0h0qUr105Y=;
 b=KPyaJNPTz+wTczC2e27+WJcorWJNhnNuaV594KVHp+Us6HSwIqtXf6u8fzRUf1XjV/GuDFbFsuuv0+sc6EGL1TSrQrXMo6BrteqvCjG1cIB9kZK1ldfPGJs9tWvnnfGT3klUF7j2jxC5lEK5W4UrgXjnvCgRBNRn2pp76NDkvzQ=
Received: from CYXPR03CA0025.namprd03.prod.outlook.com (2603:10b6:930:d2::29)
 by BN5PR12MB9488.namprd12.prod.outlook.com (2603:10b6:408:2a9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 16:14:09 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:d2:cafe::cf) by CYXPR03CA0025.outlook.office365.com
 (2603:10b6:930:d2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 16:14:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 16:14:09 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 09:14:07 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 3/6] drm/amdgpu/sdma: add query for CSA size and alignment
Date: Mon, 13 Oct 2025 12:13:49 -0400
Message-ID: <20251013161352.1628044-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013161352.1628044-1-alexander.deucher@amd.com>
References: <20251013161352.1628044-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|BN5PR12MB9488:EE_
X-MS-Office365-Filtering-Correlation-Id: 02c5a44c-d313-424c-bb06-08de0a738a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RtjaNlZjpre+zH4VPmoL5J3Ucf3uLdlnGYCpgCqmvrP2BRyUnEbv+sbQMgd5?=
 =?us-ascii?Q?jMU66lJkULJVF9BqVfXYNLh9JlEQw0XGdwx8cFPVkbAo4haAFr2cEEUPMdOU?=
 =?us-ascii?Q?Cyiqdlnlgns0IUn79jFqtuoLhQsT85kUHvwAYFXlxvIOMnYuSjqkWuMkmRbS?=
 =?us-ascii?Q?TZn6gQd+meCb8E5y9BOlKo0GCQhTJ3C5vc5ovj1aU+SDwPyAKWiEUTofBVR+?=
 =?us-ascii?Q?Y4ylbUaoizu0A9h4byLijW/fHRscV+PSqkSaxUebc/dkJrr99ygsjNLaTLbj?=
 =?us-ascii?Q?4QrQ5TdboqrK7joJ5FMurVM+PgyY5vUjbbBqoAYsoiNDLRBoxhYzcuFGyOOs?=
 =?us-ascii?Q?LeKi9QYsbky9WvJ63FH3UTdJlpy87gPjGIH6XsUDk4rTMPFWiR7CXRrUsdzD?=
 =?us-ascii?Q?iz2Z19b4bFOhrHE41ToTGgzu2+jHIu0w7PKo+1k7Eqe3WR+0UC3lMskPUxkr?=
 =?us-ascii?Q?vAUCIPBAE+JHYOAS3YiUhPmJ90n8LD1Xo9DgI0GB0KZoRM0qj18nnrNMrbvS?=
 =?us-ascii?Q?LWwOrcVamfzzhmkqqWvS2zN8HPEGNB8nLH2JA7Uf7nRQ6LqpiU3A47gcVx0B?=
 =?us-ascii?Q?d9L5fSiMmLoNEthZXRxxtwSDkzM1255tFvN3zANoyl71cGdpabKAUh0iPf2p?=
 =?us-ascii?Q?B/8zKGn445PKIxiOWYD1ukCvWEMiwQdt0rDoEcd1n/vpg4Ww3tE2r9e9HD7s?=
 =?us-ascii?Q?Ef3iVRGBb5RWlJIIAWm0t6Psl3dTpIwB9yyyUROK4D5qko/uXwI7KfgZvgCe?=
 =?us-ascii?Q?Ba+6PA5hnp5zU10EBAbcZ7RNmcuQc55yvXr4F7RR77/Ec/0q8fu3HX5shtqh?=
 =?us-ascii?Q?h/zuSIxnWMBIp7eslHSX1z9fVGWHWtgZhGqQwNxwtY83rhBgqIdqh0ZJITFc?=
 =?us-ascii?Q?E/qathlBW3Ce2mVhi1A3KTrihS6kR+zLZh6RdOxP9kDGnIRqGn3V7dv1YuG0?=
 =?us-ascii?Q?QxfcAO9JiiIzZKa3/fsJKSFqZXzNZUhzaEEEjmDsmeYZLGYPeQjHP+cBhUSX?=
 =?us-ascii?Q?lwGeypW5MBqBtQ0X+Eh6bL0IXqWh4UVAbHgS/NFajlHn8gbOcBI4AmO6QDWC?=
 =?us-ascii?Q?BOtf9Hnxyi3c9760u/dh0ER2dGfCOY1SDb3X95zgAEzlcE0/XBJqgGsywB0M?=
 =?us-ascii?Q?qeCoalfeTHVHTEGy+qb0TBDPtHzrDajdrxlXFRsnbNKLd6n306DM+v7TCoHP?=
 =?us-ascii?Q?L5HY3ry026mw+p2TqikpkHw0IAV0hthAN/Xddh8u+mWs+Bk90JkZhYOsea06?=
 =?us-ascii?Q?zymK4k4RYRlrvHQkWsal1JSUkxUke5Hc7t/cfTAK52X9qBY3F+4vUCnAc9tZ?=
 =?us-ascii?Q?ZF91ZZEOedkwfXPU6MfrGvkOUxkRQFLQesSmKnyutW6d4Z9Wtq9iTs6+gJ2b?=
 =?us-ascii?Q?YZflxS38B4BoDjDEDHcc6rvezq2ftdIuHoPJX8unBm7+hOZ6hzJghHlvIJZi?=
 =?us-ascii?Q?IJ8EZQDMB8y2k62PItiKcwnu+h9ou8EzKbYifVog/wDd2idMOLeMAWea6NJ9?=
 =?us-ascii?Q?mrWNC1KEP0gSJ6jiUxW0DP7OFCvTAmksjtlY3UmOxz6YbK4osX+9srw1VDnq?=
 =?us-ascii?Q?+geBJfattm6NTgBW8VE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 16:14:09.1095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c5a44c-d313-424c-bb06-08de0a738a5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9488
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

Needed to query the CSA size and alignment for SDMA
user queues.

Reviewed-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 12 ++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 34311f32be4c6..872d81f73244a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -50,6 +50,11 @@ enum amdgpu_sdma_irq {
 
 #define NUM_SDMA(x) hweight32(x)
 
+struct amdgpu_sdma_csa_info {
+	u32 size;
+	u32 alignment;
+};
+
 struct amdgpu_sdma_funcs {
 	int (*stop_kernel_queue)(struct amdgpu_ring *ring);
 	int (*start_kernel_queue)(struct amdgpu_ring *ring);
@@ -133,6 +138,8 @@ struct amdgpu_sdma {
 	struct list_head	reset_callback_list;
 	bool			no_user_submission;
 	bool			disable_uq;
+	void (*get_csa_info)(struct amdgpu_device *adev,
+			     struct amdgpu_sdma_csa_info *csa_info);
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index db6e41967f126..25b38f72e5202 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1268,6 +1268,17 @@ static void sdma_v6_0_set_ras_funcs(struct amdgpu_device *adev)
 	}
 }
 
+/* all sizes are in bytes */
+#define SDMA6_CSA_SIZE       32
+#define SDMA6_CSA_ALIGNMENT  4
+
+static void sdma_v6_0_get_csa_info(struct amdgpu_device *adev,
+				   struct amdgpu_sdma_csa_info *csa_info)
+{
+	csa_info->size = SDMA6_CSA_SIZE;
+	csa_info->alignment = SDMA6_CSA_ALIGNMENT;
+}
+
 static int sdma_v6_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -1300,6 +1311,7 @@ static int sdma_v6_0_early_init(struct amdgpu_ip_block *ip_block)
 	sdma_v6_0_set_irq_funcs(adev);
 	sdma_v6_0_set_mqd_funcs(adev);
 	sdma_v6_0_set_ras_funcs(adev);
+	adev->sdma.get_csa_info = &sdma_v6_0_get_csa_info;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 326ecc8d37d21..8f691d627ae3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1253,6 +1253,17 @@ static void sdma_v7_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 	amdgpu_ring_emit_reg_wait(ring, reg1, mask, mask);
 }
 
+/* all sizes are in bytes */
+#define SDMA7_CSA_SIZE       32
+#define SDMA7_CSA_ALIGNMENT  4
+
+static void sdma_v7_0_get_csa_info(struct amdgpu_device *adev,
+				   struct amdgpu_sdma_csa_info *csa_info)
+{
+	csa_info->size = SDMA7_CSA_SIZE;
+	csa_info->alignment = SDMA7_CSA_ALIGNMENT;
+}
+
 static int sdma_v7_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -1286,6 +1297,7 @@ static int sdma_v7_0_early_init(struct amdgpu_ip_block *ip_block)
 	sdma_v7_0_set_vm_pte_funcs(adev);
 	sdma_v7_0_set_irq_funcs(adev);
 	sdma_v7_0_set_mqd_funcs(adev);
+	adev->sdma.get_csa_info = &sdma_v7_0_get_csa_info;
 
 	return 0;
 }
-- 
2.51.0

