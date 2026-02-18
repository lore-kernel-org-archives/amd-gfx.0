Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6647E9A04B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 19:34:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74FD610E311;
	Wed, 18 Feb 2026 19:34:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p+4SO5ft";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD9A010E30E
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 19:34:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HudLeH09BDUv9Byr82zeFN84rtmmjogF5tPU6+srgOMLnoI3M4qmpgPF0UZs6DAfDGSes/+tWpyQfvD7Mx+1j14Owj4NMurg2OIZkCnZbOc5vE4hqEHlMMa7NtuJzlMukotzdNBw4SGXaM/8Ce+0K6OkzTg1sThs9g5g4YVggJbNW/ZsnB7yzgO+zmUDsrvCxAlqJUxFt+6RQLwn20WUSWdpLPuo7zQ9Xc/RQ4EeyAUwswci6mQf5DKB/LV2OoSubEsnDLcNuFP3oUiGAWUYzeNPIaB0hoUsejzxHdGw/oCIIcArsz3pSyHrKps1RAHibZBG6pKZ3rw4jzjIrtXI0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OvgFC7qSfC9jLZ0oDcXYfvrJA8sKXYEpUU2fC9Rg6s=;
 b=jOP/qMsD6H/UKRAWz0VyDTq+Uj0/L9SfdazEz4MttPYrqowOWAVXc34i3GmLKSfnTNG4HGcNoa3Wxi0lMvYRxlcjBRTS7ecgeafQxsLzQ3hFW6YXbeGFSI+B2U0sKT/Xyu4eird9otbiuB+xhUV6bsgR+/hXhkQ/NSo6LTjVrHPioavVNbu3cgBCDoxcJpTY3nF2OACVFBc0Czem0rhoKn9MXX5nS3JO17Iblc1+CH/DN3zOuI+k1SBpply+QkJl37uUgpFQkiZeVTFsCLRX/FfjQFImAZ2CKN/bHRW5Eu+K9CrDLjTkDAOQATjZN/P+xn5qqPpdpVxctIHgFuAfTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OvgFC7qSfC9jLZ0oDcXYfvrJA8sKXYEpUU2fC9Rg6s=;
 b=p+4SO5ftzjuh/AH7E2wjYwAyjFC+Qhv8oIvHfKy5QhNArdS1V6MvxhkHqU+RdhBnP9K9TT9k6InU0M9U5BQFT4UH3GvKvClitTKNkTEEDmXY9cKIZaZltguVevPz+pxeDtrnKrpuQS28iA8cMq3R5yHWyJFkQV0n+Mvceci9tPw=
Received: from CH3P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::27)
 by CH8PR12MB9838.namprd12.prod.outlook.com (2603:10b6:610:270::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Wed, 18 Feb
 2026 19:34:26 +0000
Received: from DM2PEPF00003FC3.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::fc) by CH3P221CA0026.outlook.office365.com
 (2603:10b6:610:1e7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Wed,
 18 Feb 2026 19:34:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM2PEPF00003FC3.mail.protection.outlook.com (10.167.23.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 19:34:25 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 18 Feb
 2026 13:34:25 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Feb
 2026 13:34:24 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Feb 2026 13:34:24 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/6] drm/amdgpu/gfx12: align mqd settings with KFD
Date: Wed, 18 Feb 2026 14:34:16 -0500
Message-ID: <20260218193416.1474441-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218193416.1474441-1-alexander.deucher@amd.com>
References: <20260218193416.1474441-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC3:EE_|CH8PR12MB9838:EE_
X-MS-Office365-Filtering-Correlation-Id: a82440d7-74df-430a-f0c3-08de6f24b9b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+A9KdC25ryYnGJxokwY+a4JZgdSsdzILuGi3ttBIgJx2FDC2TxDi9nK/zItQ?=
 =?us-ascii?Q?K4xqApKk8NCUsIgeJUf2noVt5C40xVQUzl2mFYULL8KT6XK8ldReXgqYRjHq?=
 =?us-ascii?Q?p/hT3V6M3qO2x9Jx4Jbx7MjJ9U+IrCtInEQ9+n2azYYtvDmvTq/tqn8AtxWf?=
 =?us-ascii?Q?AnpIgwWVG7Z3Wx4cW+o2bRaRzEkIP9M2Lg7/fSefeQ0UjDtBPuUpacntKT/l?=
 =?us-ascii?Q?Dto0F9ZtOhA7eyVii8/0s69q9ewm1uCTO6plgxDQ8bAzvA1f5IhBs2quVJus?=
 =?us-ascii?Q?2lw/gBGUJFQdJE6ooI5UrGcDYy5Pr54S7BZvaLIglO+22UvDv9H3VbTSGTXn?=
 =?us-ascii?Q?6uCY0BYztoI/l1vKbdpBza65s2RS9uCVvlnLV9atJ2G/ePIeRFNBtURGgBzX?=
 =?us-ascii?Q?BbypN45DCxolNVIfQnYrFXG1xckq5OXfDJj6bzUGtnI/E/5SlAOh4v1bugnh?=
 =?us-ascii?Q?o+pKpcGeriz5G5eh1VfjMkJveie/piZ0qK1oBuDibcdga+QeMNh+2jRt0t+e?=
 =?us-ascii?Q?COR7pBZV1xdz1RhcurR4VumT7ogX+8TjZHtzW/XSWWo/HzCQ6WvOLx42rxDF?=
 =?us-ascii?Q?LeVBKJWIxszsbYmC7gDLo3loyDg3EPjh/tqwHAK8TmGvGFVPTxlAuFBPZQs6?=
 =?us-ascii?Q?j5TlroCiMaHZWS3eudJjWEsSPGeuGkduXy8h4TYsv+5SoxnAAaOvtKsSE/E3?=
 =?us-ascii?Q?tsDJq9fw4ytXF9VwLIf7i3R4UaeoByCj+04sK/w9bd18rSfIEo6qFVKAstNr?=
 =?us-ascii?Q?Qr6XNBZZIokvIIQDWdKoExs20/uFPF1yiVwVDilf5/l5TWvGLrkhn2Utx1sq?=
 =?us-ascii?Q?f2kerEJPvHA3jiyfTCpgOYwl1f8j4rdPB2EpiNdPamKygYoH51duHd5khlNk?=
 =?us-ascii?Q?T/6WBc+LjA7k22gqahM0r6KQUz7teH5efpWlg06AU81ybeYkbjZJ0pRRAF0/?=
 =?us-ascii?Q?i5Ab9vgYlzK8D/Dn7badNvrsGOUpLfM3h5/IT95kJ4U1XMuXq8IG05U3f/Iw?=
 =?us-ascii?Q?y4JF7vwTfui1NPdKG3+sQ12qk/p6OmuLJYCcg0e+23RSIEs9Hexeus5VUdkI?=
 =?us-ascii?Q?3GwM4KK79jogZ5G5PV8nKQSN235n3mwC2BFI9N/dsnhMGrEimgJ4dji2ZN1w?=
 =?us-ascii?Q?zu1cMcWTaAnt3vSWvMkyc6fPuZ0tyiM6FKIKSD6Gce6FxvwKqiow3sm7CgxE?=
 =?us-ascii?Q?DAEZpcQ+o1uzGHHgzd3k6wakv7vyX7XnATqEuxIzXFGfJF8vPP9QwdydONxc?=
 =?us-ascii?Q?SmzBsEvQKxUyTrSjh3cOQhAD72Rua3EndZ8PXBTkKEsePMKVW5BnBkCxepv2?=
 =?us-ascii?Q?eDDD7C4KupqzBqbhBK99EvwsrCWEU77QCE9DT2y4162y9AfMINrk/iSYBVdV?=
 =?us-ascii?Q?Ey+lmn0MEKJu6zM6dD6JylPX7/bKuNFgAhbcOqhHgq3F0Iww5zV0ICHfwEbL?=
 =?us-ascii?Q?NU2qp4xUzh8krJKitICADRu2vl2Sg4k9vkUcVEGaGNyIzUy8ftsSGP+nWVkT?=
 =?us-ascii?Q?NEnsG7p9lQVxSt5yhCxrEtMHr/twwt7QU1rtdLiC8N6v9ZiQhugimWdPW16c?=
 =?us-ascii?Q?mjE4753FAXywqkAJYWI8Z9NrxGuXAlvmwAS3pSenMUqvgFdxCp8vCHX1Vzhk?=
 =?us-ascii?Q?8N2U0neHVAOUgeFqihRdPO+V2DcmrhHn7g3J2v6UKo9q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 72GrwKgwF5dHQ9d6ICEtjl5CMcn8jy60vrJkmb12o0jjBWTra7XPQYJPUOMhhGnfiRThIM3WUgdTYsv8An3aXK91DwKUrXinU75gp5rsVFkcDVaNUzE02vwcaDfd4pNsZwbYKR+J0EQC02WyNyBcdJcddXdRUyW85m/xvNqNZbEWNpL9+UQA9J4ERkVCMgYXmNeKeWR/43vf5DoWOcZcG+YW2HFD9XKtkIi7owoCMPUCpSjEgp8AUqLf7Vsml2lDu8cymrAXPSDNtwfn+WqutnAl8nsrP/dMyT9RA3kkbELFbI7t0xDtfy18XnqlQf/kV2X5uOqaGsD8tAruenviTc2+jX34DMZPocGLgPbwFS5hUKaSKz8bzi5etCjzWDX5j/CUzTz01k5XfBTppx1hFIk4ik7UBbkwqjwF2TaGCTibBaxDNcFxpeAowHYzob2y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 19:34:25.7535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a82440d7-74df-430a-f0c3-08de6f24b9b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9838
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

Make sure to set the quantum bits in the compute MQD
for better fairness across queues of the same priority.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index c902e20960b02..c8c9ebe127654 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3279,6 +3279,11 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_hqd_pipe_priority = prop->hqd_pipe_priority;
 	mqd->cp_hqd_queue_priority = prop->hqd_queue_priority;
 
+	tmp = REG_SET_FIELD(0, CP_HQD_QUANTUM, QUANTUM_EN, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1);
+	mqd->cp_hqd_quantum = tmp;
+
 	mqd->cp_hqd_active = prop->hqd_active;
 
 	/* set UQ fenceaddress */
-- 
2.53.0

