Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4750D1951A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 20:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4336C10E47B;
	Mon, 26 Jan 2026 20:08:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HoZrS7IX";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98E0010E3C8
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 20:08:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c74xmNKpzZ8ytpRfkeKWvsmaUo5v8KmjotC4I0rVRJxIjJr4goFeKgCzGUopB87fid6M7MDom/kOh0oc1aCZl6d8KMtubNtZcLMD2//UPiP0ypzNXVRsnvcHH31VgrAHmlxdMVaHZLQTXV65z6rnWZiYu5ewQ86QUd3nAZtLFI2ABToJr4aOKcJTAIlKmm41Aettf2vac/sQqD0l1O9u0AVQz55DMxHsQ4RIBTKtfHuwrBolOGnfWd30Ga/NPjuiUCCdTIHRhdrWDr6QhrIrp35xgATgWnO2ILHj2ksHPuzA1txjXG54O98oLlKXCEr0T1OjZeWGakawA5oD1Crc8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kU65TgL3lRPiF+RW4VDylXgHMXhjsm90wamkKdQjBfU=;
 b=VKU2Ts0sDST/OKWc8mhTG/rRRR3d7sLL1aonjSlpR37uYMiBmn9Twn4LGZA6jeTCh/QtF77lgW1qsLcfxBiuKFzPStcE9m1Ie3AkKgUEwvt1SSLu96JE+sIXxf69Rd4D5XL+4PKEtPX6xaG+AU9hEIe56mmZGhYPBVH0+n/9e4dXQgFYNa5l3FqfZqUUX/gcOXt333L9673TSLG6gJCvoK2DlIsj77Y8gpss6a7209VwQ9FX5FVuL2Wig5WkwCTNcCPP5qBU1PBOyYTQ+8EZDX9jgInhEQ7oF8fjlneiYPvBh4Wkt+qPFhpmalTBaFvCrX7tQ1bU7xq6n87MErQy9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kU65TgL3lRPiF+RW4VDylXgHMXhjsm90wamkKdQjBfU=;
 b=HoZrS7IXmio4eisBkqtL/35+kaButBHQgh7Bnf3uPfbJWtzjOAIJ+QHEvQXgq20Yjeaonr4qQ8cAETI9CXur5Ka6jemwfP646XR2pLeDXFJdo/1b2FgscJioZWOO2LnhkW4YepohoEUTkeaHsXHzNXaXyM0fxlLNkz+h9nWteeM=
Received: from SJ0PR03CA0014.namprd03.prod.outlook.com (2603:10b6:a03:33a::19)
 by LV8PR12MB9406.namprd12.prod.outlook.com (2603:10b6:408:20b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 20:08:00 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::98) by SJ0PR03CA0014.outlook.office365.com
 (2603:10b6:a03:33a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 20:07:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 20:08:00 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 26 Jan
 2026 14:07:59 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 26 Jan 2026 14:07:59 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH 07/12] drm/amdgpu/gfx11: handle gfxoff in interrupt set
 functions
Date: Mon, 26 Jan 2026 15:07:42 -0500
Message-ID: <20260126200747.13527-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126200747.13527-1-alexander.deucher@amd.com>
References: <20260126200747.13527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|LV8PR12MB9406:EE_
X-MS-Office365-Filtering-Correlation-Id: b5930959-eb7f-4570-e085-08de5d169af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QcN2QihWgMowoRVwotsF3/mL16NnlEbppV88lQagtjHUz+/0/5RBCRhzsQTm?=
 =?us-ascii?Q?Rq3ZU3IHjQ07N+j+hHkFDoHJHHOpkZGSjSnLSNQcqqYL+7esao3TCVRAPLVN?=
 =?us-ascii?Q?+3FrwQ5LbjR/XUpHH13+n8uUlPbNcwZdw6Usf954H7HM84mew2v3geLJSTWY?=
 =?us-ascii?Q?GqazuErk7AFhi38hCLVIXSk529Liymo7kYTjvspul+tMr7+h7tJZ4vBBS93N?=
 =?us-ascii?Q?ZFeRPOqDw5nA9+UYrGhPmTF1py43f4UhMN7tk6efooLzo7ZjQeQAfaQVEWUS?=
 =?us-ascii?Q?+IBYyu6Mq/Sh84pO+k2TijhBff61EHMuvDtyEtiNemH3/GQO86W1NyH9XaJD?=
 =?us-ascii?Q?/uHC6ply1LjnLeqDrflL0eU+H5zSJsmybk58YQpxMtzIUp0O0R5cszr2xG7N?=
 =?us-ascii?Q?cA5hXTYapt9VRRlXy88H1tt9nkjAc13kfBK23BjwUyaP5IWiR6VWvobFYnME?=
 =?us-ascii?Q?Lp/XTu3bwhttZQIEAsTIrW3jcZ6QrxvrWaYfK/O6XmF04LqFsSrOn9fpzojq?=
 =?us-ascii?Q?qUs7U98fz2K4IUiIKiIe4ZEV+Gh+3eDQNzMfN52owrG/xt1OAlbNkolCA+/p?=
 =?us-ascii?Q?51IFd4HlswHNO5iHUyih+Cl9nl8OCAD6sLWgLaQ/iJjfLCQP//RTJFoSwahY?=
 =?us-ascii?Q?mXkVNvnIaR++qbL0HLwNXOMvtrSzNVorrQXn3QUtwJ2Fhf4iYpanRabFUJVE?=
 =?us-ascii?Q?7y99n+gYvfp3Kgdh6VvQa4u4ZD8/voAdBa43IuXvlfCU5kbPUcxfKoxONaFq?=
 =?us-ascii?Q?Chmt6Q5D7ocOk9iklUtD1R/fp4G/QA772Ax4YnWSzH9I9nghCpNyYjskKnhP?=
 =?us-ascii?Q?5p4DRTvG9LI3cByjCJeh75hwxjkDhG7hmELKgj2MZorJZmM0QsztJk0LAb3a?=
 =?us-ascii?Q?S6ABWIACW48GC38REiQHW2xYbkPlXFRnUrnTINZx6Lz2YMtPeu4xKcBMlYL3?=
 =?us-ascii?Q?wpAYbOkJPJAB6+RwyiVwWMFph1D3yHgzWb+Lu/nwpQ6pY05Sus5tObOxg8w2?=
 =?us-ascii?Q?4yRFXmqbcmvVbE2gUMC/Z8kgHmdwTL+MeGF9K1b6mMP5UXxGJ+YbhALdC5Td?=
 =?us-ascii?Q?0+IZ/3cYR0x8ym5857j01rSteKsc+B0UNZ9QxkyBTC1p0Vg1c0xEE4RVCQ/T?=
 =?us-ascii?Q?57wyHbiq0jm6N9von4OprKbL2ftvKz0B+dZS4cfXlPe/fQGElVYzAjl4lhTv?=
 =?us-ascii?Q?YOO1CqSFropZ5sUeqWEEpo9k+g4jCCj3UVf1AxRQUlWV2fZFUBg5IhPgut7f?=
 =?us-ascii?Q?itdgor9az7eBm6yyEkU5pwjCkWGoS5ZlOidkPt8qRg2gAsqEV11W2ToZQJIt?=
 =?us-ascii?Q?AWVpyhW6DfldIUs/pUg79d1pm1/VKgMBs4szA6XSowql40NDLq6QwfFjAr4m?=
 =?us-ascii?Q?Qdc2MFsP6mgZFkuUvf+tlL3Ae21yPB4HTiClF+jTkE/ktocb7YxtNi5bwdb6?=
 =?us-ascii?Q?FyfYl4BPJl67OzMQZdctHr5mAtWYa8rHyYbwlH6AR2qGkV1FJtio21zL/j6q?=
 =?us-ascii?Q?4OmOGxI7Sxf9SRCoP+d/Gp0czyCS17jIqQRTKElebkoNNKlSF5IODZN8zHb/?=
 =?us-ascii?Q?WUo8vMChXq+bICtYCUTezgY9H59QJModE5Jc8Zd9R/spwezQcodBpSVYlB17?=
 =?us-ascii?Q?e2ZFsoNL8B+wGcQopDtnTrC5trZO6VijTy5m82ui06QbEwmSBNkfy79EqMTc?=
 =?us-ascii?Q?2o7KaA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 20:08:00.3196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5930959-eb7f-4570-e085-08de5d169af9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9406
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

Need to make sure gfxoff is disallowed when we touch GC
registers over MMIO.

Cc: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5ad2516a60240..ddbb92825fac3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6421,6 +6421,7 @@ static int gfx_v11_0_set_eop_interrupt_state(struct amdgpu_device *adev,
 					    unsigned type,
 					    enum amdgpu_interrupt_state state)
 {
+	amdgpu_gfx_off_ctrl(adev, false);
 	switch (type) {
 	case AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP:
 		gfx_v11_0_set_gfx_eop_interrupt_state(adev, 0, 0, state);
@@ -6443,6 +6444,8 @@ static int gfx_v11_0_set_eop_interrupt_state(struct amdgpu_device *adev,
 	default:
 		break;
 	}
+	amdgpu_gfx_off_ctrl(adev, true);
+
 	return 0;
 }
 
@@ -6507,6 +6510,7 @@ static int gfx_v11_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
 	u32 cp_int_cntl_reg, cp_int_cntl;
 	int i, j;
 
+	amdgpu_gfx_off_ctrl(adev, false);
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
@@ -6541,6 +6545,7 @@ static int gfx_v11_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
 	default:
 		break;
 	}
+	amdgpu_gfx_off_ctrl(adev, true);
 
 	return 0;
 }
@@ -6553,6 +6558,7 @@ static int gfx_v11_0_set_bad_op_fault_state(struct amdgpu_device *adev,
 	u32 cp_int_cntl_reg, cp_int_cntl;
 	int i, j;
 
+	amdgpu_gfx_off_ctrl(adev, false);
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
@@ -6587,6 +6593,8 @@ static int gfx_v11_0_set_bad_op_fault_state(struct amdgpu_device *adev,
 	default:
 		break;
 	}
+	amdgpu_gfx_off_ctrl(adev, true);
+
 	return 0;
 }
 
@@ -6598,6 +6606,7 @@ static int gfx_v11_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 	u32 cp_int_cntl_reg, cp_int_cntl;
 	int i, j;
 
+	amdgpu_gfx_off_ctrl(adev, false);
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
@@ -6618,6 +6627,7 @@ static int gfx_v11_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 	default:
 		break;
 	}
+	amdgpu_gfx_off_ctrl(adev, true);
 
 	return 0;
 }
-- 
2.52.0

