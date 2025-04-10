Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0F4C3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 18:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5403010EA20;
	Thu, 10 Apr 2025 18:54:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4jgOsiCj";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40E8C10EA0A
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 18:54:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vS1kdaJSjqkLE7oMZgUdiscy+XvQJt/s1x2paTkwFLKyPlQiRhsN9rnm8fyXP/geQp3P7jdkNrBFdqTwQl+lrvCPm+ENVZNu4xLDLeISbe92FiRT1hrNxuqApYDfkYbZlx2FLAdMcSikEdIrILVQ5TbAR1OPSy4Bb2jLMXcr3c6dbGu6fQsTNCBJH0hhi4HtNIAA9WVv1jB5DVrq5GefRiHgu3hulnjLLNvwWp6P7/wMGKdpqDWC20U3duQZNTKDX82RYZnStPBleHrQT2o4e3r5RSQtDZXgl7X5IlXM9WnwOUUIqvikryeOMfnw5Rgj+dbI/6F1/LzuFVgWmT1qkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjmOXZv73BiAoLp4rfbzLMUmP9JitLIm5WbUkLHv2Zo=;
 b=xHRpmq0KaAhdP7ieYyyoZ2UEwuNUihDmne9KTkY4kEGTWd6uFsBCrILtRU28qkI4YdXANzxnhmpYUFhcwokzQQ++hTl4IPnp3hGdZrwTbHIPs4ssSB9eCJshfEWiVL2HvegisPqTHYjVi3IIXyhhKeFmgMchwxYhtrd4GYJsYE9qSHGJ0R2m06Tpxp9j7ap9PyBMMH1gTROFJ18rIvVy++o+1O3/Pl8YJslGXWfb4l+C80/3ZNwVSITtreMRD/Jg/KYHRp5AUTJptpNYQOB7yKs9Z7qHcIwekEK7PStQkY/0nGOQxZ/1rTHKVpcpr6fWYF1LWhbyLWY+h7lQNOJRSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjmOXZv73BiAoLp4rfbzLMUmP9JitLIm5WbUkLHv2Zo=;
 b=4jgOsiCjy+60f2Me+2K7HiPEcKp1D44+bbk+MM9BSLCwP2F5pOVbi9Vc7v/s3b1gukSVQD8R+KpWvHauDOR6/459vOXvTV/4+38rlVj6yYilnEIYGLAkZd88BcT3zMKDikjR9LXb6E8mVJZWOXjGoxV71QMgSNT5LZb0+3jVIxU=
Received: from BN9PR03CA0909.namprd03.prod.outlook.com (2603:10b6:408:107::14)
 by BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.25; Thu, 10 Apr
 2025 18:54:21 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:107:cafe::83) by BN9PR03CA0909.outlook.office365.com
 (2603:10b6:408:107::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.23 via Frontend Transport; Thu,
 10 Apr 2025 18:54:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 18:54:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 13:54:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/13] drm/amdgpu/gfx12: add support for TMZ queues to mqd_init
Date: Thu, 10 Apr 2025 14:54:00 -0400
Message-ID: <20250410185402.2352109-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410185402.2352109-1-alexander.deucher@amd.com>
References: <20250410185402.2352109-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|BY5PR12MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: e57e5b6d-9c33-40f1-3832-08dd78611adc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HItfABiVAZd9YnYVTpGcUL3Vgc8UIpzKxvZaV5qoS4TiOQL5u3CKSW0LJg9R?=
 =?us-ascii?Q?gnHTJC+3zaUInB74DK6OkyYYHChXh1ia/MFRoS/y4TdAQU1OKG5QIK0kdosX?=
 =?us-ascii?Q?pKZQ3xIi9RwcaTAOxHEt154ktKePhgF2CF5FsMAgfy2Wd/UP3jxkhg+t2j5/?=
 =?us-ascii?Q?jkyRU3IOOmR9I9wvLCAKLOWtvKyTF1+cZenWJTtTsq0YbFUHUXjGr9SpbUV9?=
 =?us-ascii?Q?2Mt5k6wVF11YwLrpaZSzFi8aDnGRh4/nji2IUgVU2CuCk80o/TyQiimg5dXN?=
 =?us-ascii?Q?XP38cmz6TctpMuS7OMQCnDn5uDVBKcubBs7SoJhX18ia3h14xN9AKa0nXKyo?=
 =?us-ascii?Q?ZsPoyGjAQ2iA7XlL2vyUacbj0xN6wkJGybdq0NqOthGhVJ+mPdZyQ6FzamWZ?=
 =?us-ascii?Q?qHCHA7lj432VmbHsS42ZZbC+f1Hk2KramNUz7CICmV7a6b+aSXthDIrppA1r?=
 =?us-ascii?Q?FJ2Tm9hihPJnuEjV+3bWSyvrxvWnNcdQiPqqA7tfIuTpirg9webXLdS25ktU?=
 =?us-ascii?Q?KJeK2pwh987330ORrCovGsibPCdP+dn1dhD63veFrS7vlma5pt8VnlPaZ5VP?=
 =?us-ascii?Q?XXGRrh7dKKzDinb2B+k1RlSC/Gv5sv8GA/SEjapQnp9tF6Vd29ElC4DXBJ7J?=
 =?us-ascii?Q?fJbakBe8OHaLGIr1jfPHWLJb+cwrU74GhzOUoRy5LCr0JGRIPMnt0wcWFRGw?=
 =?us-ascii?Q?eWoefhqNvz/Tr7wxIQgiUZVIUl5Cj7vK3SS3O9WQfd0AjNoHWt2fanDCf3Q0?=
 =?us-ascii?Q?8c4pbqtGQ6qPc53HyeTWPuMc63a4vNR5zIST8xvcEzZXL28HoQoOWop9qC9I?=
 =?us-ascii?Q?dS4Kjko2z07ip0w5ZnPr5fJXbzctrP2wkvk/ryywdbamBaMwPxzklQ/eBTyF?=
 =?us-ascii?Q?okyZ8Lv30oMIWhh2HkzoeoUJXfZZrl5Crj1zWScQqLjYwacShvmbUyEWs9lC?=
 =?us-ascii?Q?4lCajBlvapSL0zZDQgj1EpSxyKpAi/bDD8jeI7f953UmetRksgWXn0RypSGR?=
 =?us-ascii?Q?Zti7CAGKbJj8s1poYDDsjc/XpadNL3GHX9GLntIC/PghO5XlwvZgHhsEGas1?=
 =?us-ascii?Q?eip9CpxaO2rOi1M8sYzfzBcfbHq8CJW7RJv74SxynYYM7fbmnW+J4ma4Mf+b?=
 =?us-ascii?Q?jHbNfZ7b1Yexa6YUbBl3mLssR9fm8rfmYKd45f5yxkKVAQfSh7Z+CRgcIzKu?=
 =?us-ascii?Q?yoKMyGkMbdKQ1LCNPCJ25vcwNAAZPXIABm6H7SQ5FjVfPoWxlTRSEqPAD+oe?=
 =?us-ascii?Q?GEGZd42b/vaExOCaFox0+VU8kw79BShIEYejagHTkcdh5b6YWJi8lmVd5/cH?=
 =?us-ascii?Q?jiPb8Lr1aePyE5SF4z3O0auuS917W8f2cE7ScKfjAlLqBll6AltBeaAsfcp7?=
 =?us-ascii?Q?IlnX2ZrY3riDqpCNdNGrHBuh2D3XBeKWB+kF8xH6LsXGGZGpqPqyRBj7eXi4?=
 =?us-ascii?Q?T5lgpVf5DNNUdyxJonQPAas1dz2uC0jGRlh6Qiluk5PWnXAwGgRQZwceORXI?=
 =?us-ascii?Q?UXXsaqslzdBzoLg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:54:21.3861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e57e5b6d-9c33-40f1-3832-08dd78611adc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100
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

Set up TMZ for queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 2474006b1a340..da67f27d65a33 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3013,6 +3013,8 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 #ifdef __BIG_ENDIAN
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, BUF_SWAP, 1);
 #endif
+	if (prop->tmz_queue)
+		tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, TMZ_MATCH, 1);
 	mqd->cp_gfx_hqd_cntl = tmp;
 
 	/* set up cp_doorbell_control */
@@ -3164,6 +3166,8 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
+	if (prop->tmz_queue)
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TMZ, 1);
 	mqd->cp_hqd_pq_control = tmp;
 
 	/* set the wb address whether it's enabled or not */
-- 
2.49.0

