Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082A0D14893
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 04:49:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BED610E67D;
	Thu,  8 Jan 2026 04:49:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KwCGqFtE";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013004.outbound.protection.outlook.com
 [40.107.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F91710E679
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 04:49:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDhxyLrOPedt6D7rRyf6T2xkQblNo6bd8QFkVMcjz6++rWjF7t3eIm6WjSA7i7DHv6vXvd0FP9aw/GOa5FYN2hVlQWKHYn1J6lyv5lo+1jeHH8zhZbjOAez44oxO2eDfpFXIYnePyf63d/mWLZ/UL5tfipRKxmcxf5ScZvZACoYbkfarlHdP9RQ9hXhm/YuXp2Lmn1LZMX8EPxbS0JvdMHDvDjHev6MTrsO1xiYNNMvtZ115p+KeDR5iiHjFnpp1M8tL6/a5hVe9LslSRaRjmcsOAq6oiCZ4uRrNcovAV5m1d267DYBeKxhxaKZ+YnquZPG16q9Fj+KGQdtiod46yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MB0IoBjrEGX0AKpI2PaAmRLIiNVAEXTgVDizVmIZaR0=;
 b=TuSVnGnUYRAh3maZ4oY+UHl+2s6+to4qHGsml+9tFvMiLOoJrq6MntbUPvqM6YuUMimdKAb/4S7dHcTLk79wCdQmI8vC6VTjXrn6ZjUg1e5FAE1GTfbzsQnnOgRLx4Qjk9V8m/sZwC6GSUFUxMyjJfNzIyuYbg61gyhaPoXp0e2ifsnE3bw8jCFOeIC9XvoidjvNiTi7NOS8k6Z7BcNP/y2zqh8rvbLSu22hgSfLmByfNpOIuyCBSOYIteiDG9y1MBEnXqS2Pb3ub2cYcOi71jOXnjC/g9Y41jf1FBxEFmoaRSn0Wdl71TmoQ2nP2Nm2jrtOwXUWSt+DkWgJq5n1AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MB0IoBjrEGX0AKpI2PaAmRLIiNVAEXTgVDizVmIZaR0=;
 b=KwCGqFtE0I6jkkSwzEnkKOmz4a/ItGxgGc6Xi5LKnPT4bRppAbtJLCCnth5AS3Lqmd/PBnU/pJyxNaFs7M0PiQfGoFGUWtdFWr0NLEMpy5+l1/5E7IMpTkv7icnMEIh+A4lFWL7cFMdejR5GeVtA/3SgG/US26eaSWT//i1CKOs=
Received: from DS7PR03CA0022.namprd03.prod.outlook.com (2603:10b6:5:3b8::27)
 by LV3PR12MB9258.namprd12.prod.outlook.com (2603:10b6:408:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 04:49:26 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:3b8:cafe::62) by DS7PR03CA0022.outlook.office365.com
 (2603:10b6:5:3b8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Thu, 8
 Jan 2026 04:49:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Thu, 8 Jan 2026 04:49:25 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 22:49:23 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v3 06/24] drm/amd/pm: Add message control for SMUv15
Date: Thu, 8 Jan 2026 10:17:22 +0530
Message-ID: <20260108044839.4084279-7-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260108044839.4084279-1-lijo.lazar@amd.com>
References: <20260108044839.4084279-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|LV3PR12MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: ab940715-961a-4d77-4692-08de4e714cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iJZBbJSlZw8IBhuRQ0N880bH7mw/JMeJSow1QalZEHI2FrZmNOy8vQpB4uen?=
 =?us-ascii?Q?9lK9kp6Xjm7ppajxJeQaDWWroK47pr82MyOfgZAVEAi6jp2FjPTWEMUBP55K?=
 =?us-ascii?Q?RFYmi/Q4MElmCfQ42UVSR9r480hGDnPldVzJE30oRWrZwyXwC0k98FD5aKVU?=
 =?us-ascii?Q?SRUFUqpXEFkKksrJFusR6VlkGqoqAs5JaA+qI043v/kISHRAg5jXM78QaMce?=
 =?us-ascii?Q?7yAzonL9KVfXqJ4hDgP7M5cKDRchLLux0O4llhi48CShQiDmGHCasF98IsHx?=
 =?us-ascii?Q?jHgprFhX9PWx7Dhwk9h1GYY9ouSyb/56sLsN+mDcSq0mHasX+jp8UaaiT5RQ?=
 =?us-ascii?Q?kS/VQLpfuFd3w62M4ksMtCRZGlPr6vrBwCytXGn/tFetjfn9LSjY55YZn7b6?=
 =?us-ascii?Q?23V+w2jHhNbrZBV/3f4nrgUzTxtLhdmm4gp80ShBj+DXts1bNq4L83p0Kuny?=
 =?us-ascii?Q?r2NRBKo1yJN5bsyRBdffyFLfFTRMAW1F+MFivpduz0RhVLdVlroERTCd0+Zl?=
 =?us-ascii?Q?2YbrvYkBuTD3lps7vd8V6C+TqeZsYMul3HwxcM848uZjKROBYOQsr7rS/oZH?=
 =?us-ascii?Q?X/2d37/FIqaQRzUXpFiupy+9KoabEleCuh8G1dEecinMj466wT3v2Ileu3MK?=
 =?us-ascii?Q?2Jo5Amy75cqE2S6ODfjhbc8J/+yq7GDXPJUSiXapYOltP1y2Q8Y7nnrPo3CB?=
 =?us-ascii?Q?knoJ+xUAy/5/X/sZV2pIR92RWJNwzu78uF3Tl/D/LVK+agEBe0TXStmqMI7F?=
 =?us-ascii?Q?t5eF1ipFt2QAFrihL9yeOiAKGksBL3i+q/Veckie0OzYciOt4/aRYK2M73k+?=
 =?us-ascii?Q?/3nDfCSnF/hOtQhosPdxx4MJSzjMGe6g0nxDe3k21InfUN/9Dg9VEPZkvIMK?=
 =?us-ascii?Q?4JwbwDtECK/ah73SU1f9jPMAffm2zWG8iWkoQDBebo7IRsVSDICD0aYEmpLj?=
 =?us-ascii?Q?JDyer+NXVdAwTVbX87bTgit9giJoVFmO8v2uHvN0Ltdra9an6CtR7u0ltlhl?=
 =?us-ascii?Q?mhb5nsUVYEC1MR8FaQ8Q6IsSozb2g5507UL9aG8YZqzsV617N7SoZBWuSKt/?=
 =?us-ascii?Q?4T0dvBWUfszfx82h41hr9Bb3Vgme8c/32DjwzW4u1xCwlaDzzX3Pc1rRWFLD?=
 =?us-ascii?Q?VSJvpVtSZNM/8k591A8P4xa0z4AEp/uDivBhvZYpHA7CDWVgIrjV1dE8bqB5?=
 =?us-ascii?Q?SDvWCTuIQKO2qs3eVPQXHcJSqc46AiSOcpKBotOIqpFGuPGOkS512KCUlt2i?=
 =?us-ascii?Q?yftltEbAmZ456Qu93pLAozhgv+0UFKlx2HXFjjMuGGsqwKCNwNg8kWEKNdp3?=
 =?us-ascii?Q?Vbqcgu7/+LIq2pA5pcTkOcbJqLx9CkgkG5OTe8bbbC4o3oQInWcoREAn1TS9?=
 =?us-ascii?Q?0sngmcFP9i5wUrrFPWr1u2CvupNSfNdraUTmx/a+BUyyyHlj+qbZdchVmgR2?=
 =?us-ascii?Q?f7EByVgv5PeyFXm631pNyTRS2mz0omWrr4yVYjUUjuRx5FZOoqzo79xWpRnz?=
 =?us-ascii?Q?yx9rbUj6DASUuR+2jDAjaactL2HUQnaIyBM+UtcS0ZON2YVJ7RpmiGUQVv59?=
 =?us-ascii?Q?UJtGGCRvgsWrljM7MjY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 04:49:25.8922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab940715-961a-4d77-4692-08de4e714cc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9258
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

Initialize smu message control in SMUv15 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 05d4e8d293ea..bbde9ade02ac 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -1342,6 +1342,22 @@ static void smu_v15_0_0_set_smu_mailbox_registers(struct smu_context *smu)
 	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_31);
 }
 
+static void smu_v15_0_0_init_msg_ctl(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+
+	ctl->smu = smu;
+	mutex_init(&ctl->lock);
+	ctl->config.msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_30);
+	ctl->config.resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_31);
+	ctl->config.arg_regs[0] = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_32);
+	ctl->config.num_arg_regs = 1;
+	ctl->ops = &smu_msg_v1_ops;
+	ctl->default_timeout = adev->usec_timeout * 20;
+	ctl->message_map = smu_v15_0_0_message_map;
+}
+
 void smu_v15_0_0_set_ppt_funcs(struct smu_context *smu)
 {
 
@@ -1352,4 +1368,5 @@ void smu_v15_0_0_set_ppt_funcs(struct smu_context *smu)
 	smu->is_apu = true;
 
 	smu_v15_0_0_set_smu_mailbox_registers(smu);
+	smu_v15_0_0_init_msg_ctl(smu);
 }
-- 
2.49.0

