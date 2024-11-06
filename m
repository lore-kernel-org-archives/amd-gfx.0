Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EDDD35E5D
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2024 02:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AA2410E658;
	Wed,  6 Nov 2024 02:17:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MISgQMwu";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FD8F10E659
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2024 02:17:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AdeXBJwIjwzjRPux9Zj9Wvtrusp96ZLP3m9vK6Ch8TQS1i8t23UIO5ErtNt9RJekbE0laj7v0eJgwNadaJUH8zDH+Qg5lqADHtF2GyZuV6lV7DPLs3+5j8d61X/lG2CAepODoX5hxIX0HH8EtJPAesyAb1H/gZCyT9mwCqhDhb47+dUTukvcKqSL+3AfAzsVyX4sgv9p8WScJTBT2eszZ82oCFGJohDRKTgDgVjFLwpPqLkMo0z/unmzo2Pdp0HYu1u0VjbPijHNgn2xBVeYp+Yfgyr48ON0YixlasNdHz3l8/CkW9/ZPvbU9PiBeKSIZ1aThQUx5xoHtKp6Vl2CGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nl+MPJzBabMoMLFifLllmiOSkWVLkMxCJHto438qV/0=;
 b=Pdey+QzNeJpvS3gKEo4SAyU7uprtC4xGNHGc7VcDJP67KY/1x5qw80qvBckf4C+4ov/Mr2WtlnF59wp0UiStnYgv9WqLbmu1qrBQuPbKdQLL+uk/mCOU5fKfOMbyV0NF7fFnV9GR1HTj9oVt1ERQ7ZDU3KFtbYxO4wF963xmaweBmDwaf8Hahi1HP2TEEOeq305wkJQ0QHnxP/gCzLPKoISJKx59g3nIw4w6i0io1B16xKUZCMW3Kcc3oDokNjmYM1+lHUJUHmV2hoWI51y7cwiCp5nLVRihtuciNvbo7ORjmdiBDqZu5Np/dXY4759yAt5cssICfcArt89GaCoKDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nl+MPJzBabMoMLFifLllmiOSkWVLkMxCJHto438qV/0=;
 b=MISgQMwuj/5ws0eVqe5Sq2soD10/2Yeomjk3p08CY1jp1uWmzlDfm4n/FYd/SdGvb79l4MhxjvVW56dfkGFFH6Ej1enSLJiBWBb3i/mIvzMvleQZCSS843pwGVp+mE/VA/P+rdRAFOLz9P8oFUqBdJqoLr8TWk/CZFs5dLksBSI=
Received: from SJ0P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::9)
 by DM4PR12MB7503.namprd12.prod.outlook.com (2603:10b6:8:111::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Wed, 6 Nov
 2024 02:17:05 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::a5) by SJ0P220CA0004.outlook.office365.com
 (2603:10b6:a03:41b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Wed, 6 Nov 2024 02:17:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Wed, 6 Nov 2024 02:17:04 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 5 Nov 2024 20:17:00 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Add missing kdoc 'inst' parameter in
 'smu_dpm_set_power_gate' function
Date: Wed, 6 Nov 2024 07:46:46 +0530
Message-ID: <20241106021646.4089039-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|DM4PR12MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f1b06ec-fd42-45f8-4603-08dcfe091b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDRFbDd6Um9Cc0I0K05ETnRlZUhpQTI0anlXK2hQYXAzaDlIMUtraDVMOGxF?=
 =?utf-8?B?MUZYMmNoRkRGTWFlYjlZYVR0U2ZBUnFMV1M1NDNLN2x5dWlwL1NhVUdQUkw3?=
 =?utf-8?B?RUx3Q1IvQmdvSjhVcGdObFYvYXU2ZGlUYlRBUXd4Y3Y2eTN5TmFkSDBqM09x?=
 =?utf-8?B?T3o5WGRtSGlDY3grTk1xOFNPUncrVUQxMXMzNkpKSGZIZjRyZFZGWkpLNUVy?=
 =?utf-8?B?dmVYR0tvZE4raGhEQnY1V1p4Smg5UUFVU2RwS29wMFBwYm0vTzB3MzNDUFI0?=
 =?utf-8?B?L3dsTS9VNHEvNUNtMmNoaW5OWFdjbnFGVm9zczhRRDhuWk1GSE5YZERRMlVl?=
 =?utf-8?B?MjNSamV4WCtQTitnUzdkZjgvTUFqQmVtNnBoSjFKdGc1T0JnaVc1UjZzQ3Az?=
 =?utf-8?B?TFE1L0RvQVAzdG5sRURDbVVUaVpCYlQzUFp0djNRL25kZ0tuTTRPNGl0eFpi?=
 =?utf-8?B?cDMwUGFhZlNzNmRtdWh6SWJpRmJoNG9qOTRXS0pzSnJTKzhSYkIwWHQzUjJ1?=
 =?utf-8?B?aEVEbVFKWmtkUFpjeFJOUXc5ZlpjWEdCTmJjb0lJQXQ3SDRreFlUNktSd0xa?=
 =?utf-8?B?K3M3VVZ5RHI5cy80MVpvV3V4dHQxVWdKT0RCSWp2Ym1xUHNnQUJheE9TZTJS?=
 =?utf-8?B?YThYZHVKQ2E2V2dPRUlESHlmUVo0SEg4SlVEL2xuVWYvbS9FS1I1dlpXWThO?=
 =?utf-8?B?NG1jQW1TSWdOcVI3KzhrcUNOcXhvZFBqSnhmc3psK2UzZWUzZzNWazMyN2w4?=
 =?utf-8?B?SG9YSC8reHEwT056NkJGUHlkM0lXcUcwdkVWUDF0NllDYzkyTy9Hc2MzVzNE?=
 =?utf-8?B?NStoQk1ROHU5NnM5dkY4MG5GbmoyZlJORTRaRVo4K3BGTmZJbWR0Z3d4SzVZ?=
 =?utf-8?B?RktYVi81VDRid3dWOUpwS29qNEtjeks5K3RDMFhPWW5MUHozMWw2anZWSWVG?=
 =?utf-8?B?MWwreWw4QVJSekJsbEdqa0t0Um1jbHR3ZmhBYmozYzYvVzlNOFpoZW9EcmpY?=
 =?utf-8?B?dmtKb0NEZmFjU3BMV0NCbDVKMTVNMmdUWjRlVXAvUnlOQ202TVYwYkVmSWFl?=
 =?utf-8?B?YjlQNGlpSHZjcmo0V09yQURHbTdOelc1cHA4WWhyb1hndHRHS1Z0Q0FpczdG?=
 =?utf-8?B?Y2tZcUt6VklHSkZoZmlTcWN2WlFwUkRtRVBwREZPUG8xMjJJZWxtWnRSdCtG?=
 =?utf-8?B?NjB6T0N5U2JXWVZIT0YxNVR4Z2w1bTh3K2hUV21IWUFDSmJUd2RvY3V1MjFC?=
 =?utf-8?B?VnFNTnhlZnBYUUtDYWMyZXdmeUZXVHBab2tqcWVBSFhvMkxlcnhVem9sMXR4?=
 =?utf-8?B?cVA2eXYyeXUwTGNIcUdHZnliejlzdXJyS2pGK1ZYTVc3WXEwWFY4QVA4T0l6?=
 =?utf-8?B?ZGZFMEgvcCtlMityRlZrOElsdzZMQUNtVFdXWHBqWlJMZGNVVWwxcFpPL1Nq?=
 =?utf-8?B?VURYdGJ3SFhSZzVnWTk3ZlBHRU92MHF1T21uN044M0MzbmxxSWhxK0VYZy9H?=
 =?utf-8?B?R2drUW5RR0pDSXF1WFg2QVJueUZmaFhPN1VlWlFjRGZjVW13bVFIL016ODZI?=
 =?utf-8?B?eFBjb0RrS0R2dk5XTndCYUMwWFpGTHJXMTBHeXpMYlpjQXFXMnB2UU5NMEsw?=
 =?utf-8?B?cHRpUjg3a3JIbDFMUW1IbTN3UFAzc0xnSFBYNEVYbGdNTXpCTnVwZWJ4MWJD?=
 =?utf-8?B?MXZRenY4UVpwNGZGQmdtMzFCb24wSXZFSEpiV2hOWVd3azlXejVhbVpOWkNW?=
 =?utf-8?B?ekRxQno0dTV1OFBnWHpNUFF2MmI1MkR6c0p0MXMvbXhpVXdOaWsxOGtwU3BG?=
 =?utf-8?B?UWFDZ1dyemNGSStsRFdoMm1ycTcwcWwrNTh3Vjl3MnE1UXVQN1BrRlNXaXcx?=
 =?utf-8?B?dStFVDhQbVBwVnBPekZJNWpmUFJHTWRSUHBmUEh2RlB6UUE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 02:17:04.6648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1b06ec-fd42-45f8-4603-08dcfe091b7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7503
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

This commit adds the missing kdoc parameter descriptor for 'inst' in the
smu_dpm_set_power_gate function.

The 'inst' parameter, which specifies the instance of the IP block to
power gate/ungate.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:359: warning: Function parameter or struct member 'inst' not described in 'smu_dpm_set_power_gate'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index d08c61cddede..0a82fd5a8cbb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -342,8 +342,9 @@ static int smu_set_mall_enable(struct smu_context *smu)
  * smu_dpm_set_power_gate - power gate/ungate the specific IP block
  *
  * @handle:        smu_context pointer
- * @block_type: the IP block to power gate/ungate
- * @gate:       to power gate if true, ungate otherwise
+ * @block_type:    the IP block to power gate/ungate
+ * @gate:          to power gate if true, ungate otherwise
+ * @inst:          the instance of the IP block to power gate/ungate
  *
  * This API uses no smu->mutex lock protection due to:
  * 1. It is either called by other IP block(gfx/sdma/vcn/uvd/vce).
-- 
2.34.1

