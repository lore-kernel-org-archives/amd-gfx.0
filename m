Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFCCC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 01:12:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2C9610E173;
	Mon, 22 Apr 2024 01:12:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HyMfFBHU";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AAA810E173
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 01:12:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7cvC3QJrKlREFzFT4AvC/MWSL2SPMNQnPqSQqnc3F3iIuAyCY/i7QoGbuYV8jeOpYOn7NHiStFreThi6+UuLbDfZOh1IKiXO8MTNsszIWNiPxnS6f5Nm6CybwGxU2Cb7E7mZ7Jqr7IO2gebl9tjwZl36WlFvSx8ZPueyIbIffBUXqlDw67bMVYwIWn+eB5x/JlXjEZhcoP1M0FGclzhmXKekV23QR+2HJ6EJBUT/tRHOvs1msjTDrCXR7UPS3ckjbH9KYSSf9B3cl512ewCwlUkwpUEKVZZaD+991FF30hazvHHH8dxRMtrI1/s5qEf09Fe5tiW1uto3iiqPqYAHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHEnsVbL/yzRAqNVqf8vApW95qGz3Jlb33jWVKZ2PbQ=;
 b=FN/zGPxGgmsQtH/SpBheTDkZXMQZNtcJBiOn2iud7V4vpmmZU8ZYX/J3wTrNWrz7vRnAciqWTLZrnEiNVgwpMOJdqXFOcQrbsyOJqDagEu1GZzwzFr5MXS1wvk8m6D/gJu+mMiMq14JTpaC177ynuRiPJgqB7UyS40x21GE3XpN9gyinSMoxmAM4Pw38Zm+zTiscEEq7FUup6lxMowuLhIL8PVrlEizGaaeaRXTlB1IV8lPnSVreYfpTn0bwJpSu7xWr1AhM5aAM0mM+9qGVNjz6B9tzf93yPMK1LEsUMh9akmtL2aFnnDyo4atBUnRveOmdEp+sTmQc8l2CJQ8q8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHEnsVbL/yzRAqNVqf8vApW95qGz3Jlb33jWVKZ2PbQ=;
 b=HyMfFBHUJfxOmePnJZDNFqSEHZdUJjve2+NPc+3EXEiYGpCX10KuGSv9cQ+fuQf1eLr1xA/t6xVo7OqFYVGF4tbVlbxpYo5IFiqj4IzUfExNDjXCM+qgNAcF2DHSGERGK5nt6j0I4jOf+lUXrJqlwNkv89lNXFpfhW4lWRdWDHo=
Received: from CH0PR04CA0084.namprd04.prod.outlook.com (2603:10b6:610:74::29)
 by LV3PR12MB9236.namprd12.prod.outlook.com (2603:10b6:408:1a5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 01:12:30 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::c0) by CH0PR04CA0084.outlook.office365.com
 (2603:10b6:610:74::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Mon, 22 Apr 2024 01:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 01:12:29 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 21 Apr
 2024 20:12:20 -0500
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>,
 <lijo.lazar@amd.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Subject: [PATCH] drm/amdgpu: Update CGCG settings for GFXIP 9.4.3
Date: Sun, 21 Apr 2024 21:12:03 -0400
Message-ID: <20240422011203.2140619-1-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|LV3PR12MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: a7403e2f-2d62-46fc-b305-08dc626947d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DuXjTMDCjsDp4R13Of3WqTOmfy4NFtQdp6N3YMfxqQIpOM/bIiSPK8ALELxm?=
 =?us-ascii?Q?DDWEGFsMEaFKWOF2Y339nOOBXDTgN1uqAlxxfMnpl7Dney+Y4BR+JGSviVZl?=
 =?us-ascii?Q?ynShMIdK/gTZCtZN+7y6G6uB/qAWa3keBVFeI+aEyIGWVrI83/uSCwkvt6qT?=
 =?us-ascii?Q?79csuCKuheZvIHjJ7PCisfPtJX4v9S8IeL7+B3DuAAHIH8KCkwMKW7n+2bYK?=
 =?us-ascii?Q?2Ae7qidgLdUe6ST3e4r+v9dUMOpCgZKx8SC4m85e/CCGYQcrIvBmZwwZ54yx?=
 =?us-ascii?Q?PMC5H6DRlpKXdyWnfxHw2UgQsa35mxuWoETczLHxYO9xaHKM9/D3iIJzWxxF?=
 =?us-ascii?Q?6h/YEFsSzIVQHoFYd48BDSymPrPItAmbBddjynELMu9sAFc4QKHfBY5ESVgh?=
 =?us-ascii?Q?cVx7BzgmuVkmQjn2ddTs9355bLoAiFU1D0dn8+i4aWX9YkKkxMtREp9ZaOhG?=
 =?us-ascii?Q?vQSgN1xTRzFFkm68Vm5rJnAHGv1OjvxU5RGp4v0glkkBGsyPmO5UVDdwUJnX?=
 =?us-ascii?Q?ck632LfXjvxaMRHaKBr0nvgaPZKtzUavlgJVcRDoAQtySx5aLjLyoXUD/pvo?=
 =?us-ascii?Q?ce4YF53MGQVYj+PIEHHD+NQSeD4NqJNXy2LXlbB0nyVRzEor4tzHA7d/87U0?=
 =?us-ascii?Q?DXGw6VmdgDNtsIYv+lKV6tjXTDy5C9Kq7nL1Cj1Q4SjO+LYXbriYb265DUG4?=
 =?us-ascii?Q?mrXlhuqX+9UveMYyEo2Rct/MSXU3Ax7mnPDPJC+MyWfxmiarzMX042u4rIAR?=
 =?us-ascii?Q?cLDNuWfDDExRLemZDVNNaP5SerEj6OE87lkIGmT1enM7Hrgz1B++29ph54cw?=
 =?us-ascii?Q?xbtTUXRv3yL+xw/koVrSfA2zRf+9jHqQqvjyVNURpQg/3SLlYyAnHcEbpsf6?=
 =?us-ascii?Q?hKbpVRaJeoR9GW8LIrLE9bFGeuNgxc7ku3pWF+gaLE7xIbrjcUnizYGPgNRJ?=
 =?us-ascii?Q?fYkQV1uaXrIuPRdhHik3bznm+2bGysVjXayRMBEHFuetxz33Sktv5+ZNOTSj?=
 =?us-ascii?Q?nMIQ7DISonkadqOUk2/l2Mt0ZLSwWfcbI+BYvd87PN/w7UbEhXdKa28DVBsy?=
 =?us-ascii?Q?YcPQJL5lpqU0DtQdtwajWQukkqO+N2g5P+SYlN0nTctQgLpVjnVmJiCFXhkf?=
 =?us-ascii?Q?AQMrqsM6yrqZA86ARtEZV30NX2MIo9SlpeyZSqCIilyS9pVZGACJU6B4XtoT?=
 =?us-ascii?Q?qWme1oS0fU2yOEvDwy6SkGoFuqdf2rZ9p+G/EXltp+F2MbDFS8t1LZi1CGQT?=
 =?us-ascii?Q?mH1opo8imf06LFDQLgmDICwgX9JQCiPVSg+VFUeOj5m9WjsDvIZruQYTDria?=
 =?us-ascii?Q?P6MiOGtk4pwTeskYocaURsv8dWh+77/Yk5CLLXm4PC2LXqK/iw9Ae2b3rI71?=
 =?us-ascii?Q?bcB1upRKT2mE8cX5sz3XgaQP/Bxj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 01:12:29.5040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7403e2f-2d62-46fc-b305-08dc626947d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9236
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

Tune coarse grain clock gating idle threshold and rlc idle timeout to
achieve better kernel launch latency.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 835004187a58..813528fb4f2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2404,10 +2404,10 @@ gfx_v9_4_3_xcc_update_coarse_grain_clock_gating(struct amdgpu_device *adev,
 		if (def != data)
 			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE, data);
 
-		/* enable cgcg FSM(0x0000363F) */
+		/* CGCG Hysteresis: 400us */
 		def = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGCG_CGLS_CTRL);
 
-		data = (0x36
+		data = (0x2710
 			<< RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
 		       RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
 		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGLS)
@@ -2416,10 +2416,10 @@ gfx_v9_4_3_xcc_update_coarse_grain_clock_gating(struct amdgpu_device *adev,
 		if (def != data)
 			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGCG_CGLS_CTRL, data);
 
-		/* set IDLE_POLL_COUNT(0x00900100) */
+		/* set IDLE_POLL_COUNT(0x33450100)*/
 		def = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_RB_WPTR_POLL_CNTL);
 		data = (0x0100 << CP_RB_WPTR_POLL_CNTL__POLL_FREQUENCY__SHIFT) |
-			(0x0090 << CP_RB_WPTR_POLL_CNTL__IDLE_POLL_COUNT__SHIFT);
+			(0x3345 << CP_RB_WPTR_POLL_CNTL__IDLE_POLL_COUNT__SHIFT);
 		if (def != data)
 			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_RB_WPTR_POLL_CNTL, data);
 	} else {
-- 
2.34.1

