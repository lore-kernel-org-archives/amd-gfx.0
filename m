Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CC9E6917E
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2024 16:27:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7166010EC0E;
	Fri, 22 Nov 2024 16:27:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nQ5KHhav";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 005FC10EC0E
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 16:27:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFjWEGY0Lhj4APWpAmjzkYFcW9Q82Ii4c8DsHCg7KCJVwcdkkG/pLH889U7H5TF3IeQdEKqQ8xoo37Nl9/i16lnXTs4ObkvEyLwy933N3YaAA4fSahl4jSlt1b/yITVLKG1s0ufjl8Ua7MGzBcwlAflcb1MHkd6FRbgy+/1MgY187p8AaZPYWY6etklB8oBYqhIs90t07tuLE/BPiiyv/RS5dpt/kL1VxyiH9IjvwMdgBYviuXxklD1lYpPynpqreIiGFRz1mzOnm9pH8LdRlFqo6Cd31LqyLVDvMRmScpzVInJ6X4Dk5G73ITGajhU4SpyQedt9ZLqBYB5U4HEl1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCqvnnbIE3F/fRch4UrIB0PNUaHJM7fm7KNt4CDZgSs=;
 b=J7rh8EOW6vWGWWfuu+wI+nQujBsuLYNV0xjU5mdiky98g0aDCA+gPKak3zG0OWN2mif4GuIvJlNAtOx20OvsSza4AL+F5zyCg1p+/BWeI5XbSripq4NaSqCUIpWxovCAgtBLKRKqLpFntUk/vmQL/xoCZ6J2iYrxsmuv7NC/u1y/WqLhlloOk/V1XbZyZKf4yA6rAG8S1hBWaS1dfREIpVLZ9yzgTolFPV2vffCbQUg8GlFDyM8V4D7ovDwQVFq6ehNP//asfdOpLDX++vT33OTvGSJTE15E/76kWJJJ52N5uL4Bl6dyYww5McJ8m6ITURovW7i+h4SOKO/PpwAcyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCqvnnbIE3F/fRch4UrIB0PNUaHJM7fm7KNt4CDZgSs=;
 b=nQ5KHhavQG3uNRrjJIq6r5Vk+VMyO3f6VjqFVPEisO03rxBX93uQIiIGhKP/vAfhmQxOFNVSY6p0gH3BpZGdZVeYt01c5JLtY66JS9t8am4yyAzsStfxoZnTNaxF2dFpFP1j35eV8W/WhoQbO1n8ii+MlDXOl2Aenx2VA3MRL00=
Received: from BY1P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::12)
 by LV2PR12MB5774.namprd12.prod.outlook.com (2603:10b6:408:17a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 22 Nov
 2024 16:27:21 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::a1) by BY1P220CA0010.outlook.office365.com
 (2603:10b6:a03:59d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.25 via Frontend
 Transport; Fri, 22 Nov 2024 16:27:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 16:27:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 10:27:18 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, David Belanger
 <david.belanger@amd.com>
Subject: [PATCH 5/5] drm/amdgpu/hdp7.0: do a posting read when flushing HDP
Date: Fri, 22 Nov 2024 11:26:57 -0500
Message-ID: <20241122162657.1056489-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122162657.1056489-1-alexander.deucher@amd.com>
References: <20241122162657.1056489-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|LV2PR12MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: ee0f0922-83a7-4973-00c7-08dd0b128a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h16W9zNgzJBITiZFqOwfTnRziWdQ83WpXnVWDjSUAsCntEraFv9ahI8QMxHv?=
 =?us-ascii?Q?TypluV/K8/07nxr646J2PKx9ourBri0IImo9iRlrlD7PJSspYHDAonFjB4AR?=
 =?us-ascii?Q?TGPvg9cYvPu2XDU4Ig8OTdZVcBFUoeLWSiKhc5qrSlFSOn/Cp9w2vBmEUhp0?=
 =?us-ascii?Q?PJsZCef5XjTKMvG/KTq/qSEbE1qN7JT3kv+GE8VpVUzrUCENdjuAvsM4cwmS?=
 =?us-ascii?Q?vaTiqNlaGQttiYWSwm0zpD/o7cDkk4up5Wt4xRrTGkLPUGpQTfP6a5Br2zMv?=
 =?us-ascii?Q?24XxOxmvefCkISfRizQZhgmRVNxZ2gNANNMQQMxDZKMLQSTKpSz1zJzU93rs?=
 =?us-ascii?Q?iFuYrhT08ymmmpjfXfnlBW3PryOxXdvGmPc9dEo45V1pWZa1wkSvtmTd3ByI?=
 =?us-ascii?Q?kARU4/XfBkvprXcpTlFzqDgVDJrKL/akUzNOP+1W+d+UBl3qXk1z06FVG/it?=
 =?us-ascii?Q?8OSRinmAgdDE54SUJawbdFPgZjsZ76bRQb6X/eBiNbCTdQsAG2i+yEOqopMK?=
 =?us-ascii?Q?dm6imGxPPUFzXvjFKLbrsTKi3PGG4nZFHBxOTiTuBZNabypITjugIPTpGmXK?=
 =?us-ascii?Q?uu74Ff1qnF5t18JzYmbsLmevvqz1I9PKMY2OCi5iqcO05S8MB1YQPJkZh0vK?=
 =?us-ascii?Q?RsMd3AcfnWkMRCZP1oHm0w1H5lb1uAk6ZXiqCG6ZR0FzP1bbBcgnmz5c2InK?=
 =?us-ascii?Q?Fo8swjnJ8HB+usAHAkhOxkg89rbATO8PDQpKaJAdyBk3wkIHoTovdbycPzUs?=
 =?us-ascii?Q?XGgoHxngX7jgi1KfhjCv/WW2hO0ynHhcrfjs3hwWjMfOmOFjNXJ33tMsxpKO?=
 =?us-ascii?Q?dThLmkInBkV2zAZUmf2Ajj8a6FFkTNVDTw9YNV0BqJmM4XJbrqZBdatCBGkQ?=
 =?us-ascii?Q?YvsY8UJM6Rz39RiVCJZzur+zYYsNSvbDE80mzRDOjKsNRaBfv5/22opBikCd?=
 =?us-ascii?Q?KwdxZFA5oB7aH19Y4LncnhjsOPZr2tqKEP45kwCfDn9s9D++NRfQjthOnY7Z?=
 =?us-ascii?Q?2Gocp2q48fV9hR/KL/HstOV+ioBzwkgzZxOJDCjIOB237vN78cdiMjRLnxyo?=
 =?us-ascii?Q?2MOGyZJ8FV0huIxtEE0xVnEonzGC/eLmI3nvqHtmFhnCxHxekhCzpt05zHM8?=
 =?us-ascii?Q?VjDDek2ey5PZMROhHAlF6vqvTGUK72Uy0ZqGhSRrwVINR24og11eMb2JFdCL?=
 =?us-ascii?Q?v0Vsi9SIK/Je/G0LU1TW/gXwNHxTZL21cd6i4sfARTvGjXRNI0A7pNtmQxSY?=
 =?us-ascii?Q?mO1UN7RgKWBFcbJTC/+Lh+PHYLO1kkGec/dASUmR1pKE2xMrNaQ+bv2lrxSY?=
 =?us-ascii?Q?goC8wZ45ykO23aMThTSX5q/UUVwtGfW17C1U6vHCB8UQWSB8PR52o65CJ+OY?=
 =?us-ascii?Q?BjMEcFxxlCPwIiWMzyKVEh0YdMb54cRwJy/YycYhUUEGLSv7Kg8Bu0HINHX3?=
 =?us-ascii?Q?Sb+HC648FUBlWE35QXyNUioKQcGlN/7r?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 16:27:21.4566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0f0922-83a7-4973-00c7-08dd0b128a6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5774
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

Need to read back to make sure the write goes through.

Cc: David Belanger <david.belanger@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
index 1c99bb09e2a1..63820329f67e 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
@@ -31,10 +31,12 @@
 static void hdp_v7_0_flush_hdp(struct amdgpu_device *adev,
 				struct amdgpu_ring *ring)
 {
-	if (!ring || !ring->funcs->emit_wreg)
+	if (!ring || !ring->funcs->emit_wreg) {
 		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-	else
+		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+	} else {
 		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+	}
 }
 
 static void hdp_v7_0_update_clock_gating(struct amdgpu_device *adev,
-- 
2.47.0

