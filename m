Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D46FCA0FE7
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 21:01:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B225210E56C;
	Mon, 25 Aug 2025 21:01:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5AOvA7+T";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D3D210E568
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 21:01:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ib8y24DEORLobQWaxC3W6pKjYU5UbN9zoSRPsO6OeFT4tFcUfcFpr5fk9lKfkb+ZMXpRG4F+RmexyvBrri86K7lTYVgW5S3YHjYX6BGG7tvTSCBAzhNIxmobM4k8hDc8W+QTohoUczqRjaQr4DSJqoNQnXOabp2yetnFF7NguwRHnHhdvuKn8NfoPYDeLV+qkC+Z3Ad9ggnJ4OLLEVtKX34Vd9mrB1vNUMXl0E+IXTVhTnfTiGXwa04JeSspjQGKPdzNdbQ7hXAZdJ0sMHUlo24jGrbb//bv4zBv/CTUoUFpa7hXe9cHRJoYAmzgNfH3kX2j22VUutmP180/2NVolA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7CDSVkllIehEtEUvFxbF+9UF1Yeh157vg9qkNTyMKQ=;
 b=beA8sAv0odjCD3Wkv/hJ+iqnzzG8LdM3uO0Ugz51OEElKDuTMmSxM7nkr1CqxycncfmN72ttm0utXjWEKZykwN6vERjSn5uVOZW4sFvsf67Tu101Zlpl01bfXvspOAcjhGIhqZAyUbizhBLg6EWuFuZLG1MP6SEWv0UXm5K6L+yHLMRlDxEslDaBH6COslBhgYYeuJkZ1NiT99bpNAk82eyJmyDvXowjRZETXQb1OAMqQSwgxzE+RU6mxpFOo73gehVpjZ4ymSt7aX0XrlFATekw0vNpIsdrKxg8fz+84hgYEitutAS2aTWmdHlM1g5ybIpLFHgvjl4yl7dX39vSBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7CDSVkllIehEtEUvFxbF+9UF1Yeh157vg9qkNTyMKQ=;
 b=5AOvA7+TQZP8H7sO+RTLAmdHrAYGpCjSwz4JIGkSTKduZ54QNCA85J/57DFceo94l+QOqhLUlgAnXLJz4gh3dVFi4eQS43T8jNDgIpfuB3xNGfBICskwJRuAMKS8cL3sksAaxioYGJCsX0B+Aadpl+xEgWu9vD9X5oe1VPaAkZE=
Received: from BL0PR1501CA0027.namprd15.prod.outlook.com
 (2603:10b6:207:17::40) by CYXPR12MB9427.namprd12.prod.outlook.com
 (2603:10b6:930:d6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 21:01:25 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:207:17:cafe::a0) by BL0PR1501CA0027.outlook.office365.com
 (2603:10b6:207:17::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Mon,
 25 Aug 2025 21:01:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Mon, 25 Aug 2025 21:01:24 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 25 Aug 2025 16:01:23 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu/vcn: remove unused code in vcn_v1_0.c
Date: Mon, 25 Aug 2025 17:01:11 -0400
Message-ID: <20250825210113.182727-2-David.Wu3@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825210113.182727-1-David.Wu3@amd.com>
References: <20250825210113.182727-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|CYXPR12MB9427:EE_
X-MS-Office365-Filtering-Correlation-Id: d0aa8651-e740-4577-73bf-08dde41a8d03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0Jc+7LlFR6bc3Fjdv9tIzyz4UE3tyb4Tq77P862RdfvG6t6pzVX8ubjkoPFg?=
 =?us-ascii?Q?gNoj2GGdhreMFNR+WmmrC6KtnehA+wBEmFknLHlcR+OILzpCJ07AdoUCZkts?=
 =?us-ascii?Q?WzOY/jhUvNAnZYfxLoPd1xgKFS1JDoXWtDpfW65dbh+I2cKiLebaZFHVeFcv?=
 =?us-ascii?Q?vt0mhEWlPYKKlTOh08T8zPfEZsoQlzOMh5RnTB4PtxC8BjNz+JmQY6J7mng5?=
 =?us-ascii?Q?9OiI3olQch24iGStPy44HmNHh6fgUxMbB1BzVfjCyv4LX1tWuSGjXjTmO+h+?=
 =?us-ascii?Q?eokWDrAX8d9j79+ziMQOjMS7X6hnDzQVxKpYA4oblEPusuhy0ZRVM5JgGnic?=
 =?us-ascii?Q?ICjMMZRl98+/xVaVJGgzycjqkqenHTpJPf0YedHX+dmmGPRxmdlTIa+4pE0c?=
 =?us-ascii?Q?685IoXPFnJAYUmlbAErkdFIrBLpNTFaK6D7hFhYj3zT32XyLqNoA1Iut2986?=
 =?us-ascii?Q?WogbcwJpzmoiUEC8Ok+vWeZlCkGzJMAYzMB5XFsdmo1+xsB95zqL1TbJ/ZJT?=
 =?us-ascii?Q?MByApnSzdYiRJxBQj6NQHGSFfZWi8pz2gTT2cHKNUP5vkPNhoIauo54LJCm8?=
 =?us-ascii?Q?KIqFiFmJInikUqQbCNEoBh+HsgbPIC4AcWEFYQwxE4O9St58P/rmZ52ipuc4?=
 =?us-ascii?Q?/hw0Ez3TVJQ9hwe0HvjPYTLKzKQLY5UhE7PHDIlSGeKtkVEEd3nP6Hitlq+/?=
 =?us-ascii?Q?3oIAsUa6jfPmNwkv8KYp88MGLOZ32W8L2sX9vIctnxbBV0auRuzGZhgZsEQX?=
 =?us-ascii?Q?N1OhdDPeQkRoqMKqz/SoLCKNruFQvK1gxhluZ1mr6dpSq7srWnfsvmDSTZDY?=
 =?us-ascii?Q?Gg9VrgPp+NGquRy4Y7uOOLEvmcyB22BA4CGdVSxWEPWyIQQWPQHea6KzFrY4?=
 =?us-ascii?Q?Q2RGMVTbKVnYxegPOUi8NX/P4/xAuu3nguPIRDWOzFuyD8oObLW2NolQBw5j?=
 =?us-ascii?Q?U8FL7fohj2USi9FWCvkKuLY45ZfaNh8GBJRplQx49DKLegJ+EkphEiQjgHMT?=
 =?us-ascii?Q?uazgk3f5hWF4hUkM+kGYv//DgR8KdQDfWnX6ZAC+D077S193jyhPSO+nfCKL?=
 =?us-ascii?Q?cbRDavYyJ6WSWbAAX+vmMYh8lsGKJrLZvlIFfi8TxxbqLgyxAxpxTqpnynbb?=
 =?us-ascii?Q?skRi8kX572l/6mTPia3d79K6BfUUxul8pgyGdErHKBfaeWvHYEJQHKvU+UQ/?=
 =?us-ascii?Q?fc3TvywHgBsRj3/sZ3lHqWjNVLWyQF1DANBoC9HxAo+eY+/FtpD5hPM1wa8o?=
 =?us-ascii?Q?XhsGTZr+mq7sil1smI3cmeHh+iQmoFFBVWC6qL7oiqllx6M5hYSBCh/oxbVF?=
 =?us-ascii?Q?D1D7ODy0PILJumJR1S0wq4AnU/IAztroTAsWu/DwdGyRzuJc/o8+BG6nDFhp?=
 =?us-ascii?Q?kavONSDk/tbl+hBIYXVkqAS03TceG6AfL9hVJ6GhWt2W92WAnJpr5RBI54n0?=
 =?us-ascii?Q?bV1aIiMntluB8nmoKSzDPUEUITM8d5PqGf7gNToflOOhhXrdZTGhKY8ZvhmW?=
 =?us-ascii?Q?HCwT0ByH6aQSz6INuIXua8ezM2FWlLW4lWng?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 21:01:24.2142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0aa8651-e740-4577-73bf-08dde41a8d03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9427
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

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index c74947705d778..1e89ba153d9d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1338,7 +1338,6 @@ static int vcn_v1_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				WREG32_SOC15(UVD, 0, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
 				WREG32_SOC15(UVD, 0, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
 
-				ring = &adev->vcn.inst->ring_dec;
 				WREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR,
 						   RREG32_SOC15(UVD, 0, mmUVD_SCRATCH2) & 0x7FFFFFFF);
 				SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_POWER_STATUS,
@@ -1399,7 +1398,6 @@ static int vcn_v1_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				WREG32_SOC15(UVD, 0, mmUVD_JRBC_RB_CNTL,
 							UVD_JRBC_RB_CNTL__RB_RPTR_WR_EN_MASK);
 
-				ring = &adev->vcn.inst->ring_dec;
 				WREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR,
 						   RREG32_SOC15(UVD, 0, mmUVD_SCRATCH2) & 0x7FFFFFFF);
 				SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_POWER_STATUS,
-- 
2.43.0

