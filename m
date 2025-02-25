Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8342C021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 11:21:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A8CD10E635;
	Tue, 25 Feb 2025 11:21:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yecP+AF3";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D307110E639
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 11:21:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOqPUqRqUmqvGo0rU3EGzVMhH8t7CJiklHBbdCkNY8gJM9z4m5thgxqA5m79kDIQyTJnHd6IIjmR32HDtr4rKO/hvPj/PBT7BMv+7xNeHJyCD/AL7TKMOEWtH2GvOfVbvtBxqXTUVt1ASF3sWHOf4fZoUeHszM7MZOH2D6/0H6dKO4r/ZZI+3Pqq5kqKLauykb7r5ludnBmocpWJZd6B33D1J3tTVUcowmVUEiQQFif5FD8EhRdtJLZxk+Sf8ByhW4da8KBpiYAXka8hI2L3nOQ4R5ulLLWrUXJL8PYNI6lShFh/lDeUUR6fUtVcUCAMWW8pT0ffyjz0UdU8eg6w1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4BdUHES5wWuHJIgEIW+DFVGuKEdZI35EjFzsTGk8Ik=;
 b=frKc3aPXAse/74uA/mok+jMYFxadvsIWxW/wyaY7Sp6XaYESh4H9PPWKtu1WDGWW+wZWnHBeumxzlnffWs3IX/oraMHppZxlsGagJJXuPBw/mr3AuvwlBE5HnprMotov7mh84VtyxXzVA6T65MLqKJMoIXcA7q87Bi7oXAVJjE6M4Ixz+5MpgsRzbOPWlGbNMOtHufqDcBFLs9obRygcL/rAVEn0X7S1NwAW6ayIAJRQEpBoCGm2vu0l9vHmo17Ch8XcEH983CfbkLKaxq3C/BaMgqwZMvYDKzJusK8huD1LBz08QigW533HYmRmctxl08sT495F6bBD9lQbmHYYcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4BdUHES5wWuHJIgEIW+DFVGuKEdZI35EjFzsTGk8Ik=;
 b=yecP+AF30orUM474QQl3l4yEMY3Dh45Ro1wZe53R4wdNXIdzRiYb+C/ilJAayIDc7+/4JLyTf07Xx8mHTaL6vHYXF7QQ0/mubx2MlvQIzpS9lg15NUeDnJG4KXDN76bdan6oSixfAoYkX2KalsTrxT9fU3O14Te4R8HXnfuYcZs=
Received: from DM6PR03CA0086.namprd03.prod.outlook.com (2603:10b6:5:333::19)
 by MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 11:21:05 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:5:333:cafe::a9) by DM6PR03CA0086.outlook.office365.com
 (2603:10b6:5:333::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Tue,
 25 Feb 2025 11:21:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.0 via Frontend Transport; Tue, 25 Feb 2025 11:21:05 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 05:21:03 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: increase AMDGPU_MAX_RINGS
Date: Tue, 25 Feb 2025 19:20:55 +0800
Message-ID: <20250225112055.253865-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|MN0PR12MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: ec1ff816-643f-4ded-cc98-08dd558e7e64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CLL/mPydqFGgzjeZqxTcjSJaUK/ajs2z65v3qwSrlzZAv+sCajxIf3LjMcX7?=
 =?us-ascii?Q?UzsA/X5BzXoiKO/mmXzLU+yFzY6y9xnTJyI5S7K3Ag4RE3DTSwRbnrqsNcHi?=
 =?us-ascii?Q?609CBBKER1qECqjhpyaFmsoh/sfE2BpSZS8l5lztQMIqpGwGQYczNKXv13pJ?=
 =?us-ascii?Q?B4Tx/TnsxumXvP1NFlxeCQTMfpmym4Aaw1HwBrg9Avv9fOXJ7nu1iVgkeg8D?=
 =?us-ascii?Q?xwvcZqD1mh45D7qHe+re52838Wu8vS8Wa8AfQvM8vol0jQuxMppSiwgyHbrg?=
 =?us-ascii?Q?4Xu9MvU95GPFA4kh/Hi30elpXDALrBBh1viPrt5EiMQmDUoqX9U+nwuiA2bR?=
 =?us-ascii?Q?z8L1pqkt5Qp1hBlk5ZIrMcvE0bDYu9nl+XD3E4bmeB7N7Je/dbinzaiA4YwA?=
 =?us-ascii?Q?RYjrfKDkOs6hP1fL6SBs4Zshkc8/7r/jdtAgSiIRzfP36j2fhnW+EovK/vrd?=
 =?us-ascii?Q?6n8T8V5kliQRqbBrHBN2REGGD914XiBQjt+k0QnsLxXUkyPM3Pe/eidYz1yV?=
 =?us-ascii?Q?5hdYPFuqKCB93tvVejZG3BC19WJJmMnL0ef9HIwC2cLSrgky6U74z3SJo8hl?=
 =?us-ascii?Q?J6fQMbOfmhyA5zgcm6nL8BxdGu+wKPpeAg+mGwdoCCfGrxUQR4AWgXgZmxDR?=
 =?us-ascii?Q?t+AU1Rmsj5HRCeTfiRKWQbN2ruFAADTSNs8q5QldRVpKZF+2N2plYaw74sal?=
 =?us-ascii?Q?v/e9GlaWTVgBhlpPEGmRNXZwL7Hf0EfRfwx+gJ+ZQ8K3C+R8Lb+WwytgxsHi?=
 =?us-ascii?Q?eRwYlRqqM08awDBvinoPuMfg/ORPuMSPAdfP6TU8kyKqdOeanlI+ktMM2lZt?=
 =?us-ascii?Q?fDwFsVQr1IMyVPH+WE2aBC7xcoAggga4L1IZ0JSDwvGRH4FEwWgoPwI/3Z7A?=
 =?us-ascii?Q?qnjj6ALYohD6XcbGNC157cuJGGsRJ+pIdqw/7MJYpGcWKYVRN8bUJEye8yi6?=
 =?us-ascii?Q?n3lXFhLlL09RP4qluNw82zNsmeiayZ+D8i6r3suovpp5CwjNq32EcKpWLNAW?=
 =?us-ascii?Q?AdhTjsr+XI3ZIas/LdqMyqqG/AXr5cSmtP8lPlImoWacxQ6TNUoV3OR7KsOS?=
 =?us-ascii?Q?fTZZBQjIoyOeDeVFjGDRF+QamEcgw04zhcpBzu61z91baA1z/M93GsNkls6q?=
 =?us-ascii?Q?r32xhoRb9BjFUaShJCgP3SAiHisjbdLBpbCtMfuyQRDMd0QV4YvUmw+lp2Oq?=
 =?us-ascii?Q?ZlGR5gKMaiNeMoBcvhZrKHkfc35ihgvXV/N2pq4KJEwInJtda+no80XfTNgm?=
 =?us-ascii?Q?kCyrC6vgLRgKOhCyORNp5OjWpfCHEEV85qX5kVSDt4EwhUd//Dfa9n0mn/dX?=
 =?us-ascii?Q?TzqCxTqO8R02Ic8yLw7sDpR93rFAiHlcZeqP0TPTJtxSeG8Z9PsbNcEqpRHJ?=
 =?us-ascii?Q?0SKez0+Vy4Ei9ywwDYdFTRebylX1QaplAocKW5b1OXUOzVvSsZTxy9du2wFf?=
 =?us-ascii?Q?ZduAytxZMEijVWkyFDFXgElTSO3FQ/RuTuF2zr00YcWdSUUZ4f+MkMUPhmt8?=
 =?us-ascii?Q?Md051K4xPJEJiho=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 11:21:05.0105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1ff816-643f-4ded-cc98-08dd558e7e64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930
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

Increase it since a cper ring is introduced.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 52f7a9a79e7b..b4fd1e17205e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -37,7 +37,7 @@ struct amdgpu_job;
 struct amdgpu_vm;
 
 /* max number of rings */
-#define AMDGPU_MAX_RINGS		132
+#define AMDGPU_MAX_RINGS		133
 #define AMDGPU_MAX_HWIP_RINGS		64
 #define AMDGPU_MAX_GFX_RINGS		2
 #define AMDGPU_MAX_SW_GFX_RINGS         2
-- 
2.34.1

