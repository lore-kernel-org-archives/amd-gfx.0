Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22D5CAC597
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 13:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63F4E10E4B8;
	Mon, 15 Sep 2025 13:32:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QNwLaS75";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010006.outbound.protection.outlook.com
 [40.93.198.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B9D510E4B7
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 13:32:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhGFWIcPY/hCC9fUdoD9eaWr03n2KXT5IooGfpwYIn1AZT5hDUYXXanp5ftoPv+VRi43NVjglLXludnT7Hi8IsRRx5iad6xAUSL7sEmS4JnqmTQ/XJt+eyiBFGf/9ucRmtWcmdya9cYwDxcQ/z9WgGk/ULPMHw/1AGRW6DRUHmELrAXDVL9Ltme7V9xwInF3nkWJdHS4OLH5XLcU++77RXuuhLeMS7dK5ogsYrMZzr3Q/zofBkSFU+Ae8p3Ax4IplYmN/Ymiqzln0ftMwo0I1s4sE2Ve8cD7l/+8gTY4ReAiRDnRyIgE5ZR4JcJgrxfE+ubJCt8ANZaG+YRQGin+TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azqXBQl7CKSJRlPrPJjjm1R0AZX3gWOLOsCwhW2CSQo=;
 b=TwU3tBhcthpvIGNYUy/rwyYspayizZGh+Vngn6s2nnOBrBG64FLHVCvYHSYtKZT424zMtcLt+LR29H13ovnZIKd8mcNrhdx14w0gkFuGepddnfk0uBzJECGRijCtgR4SYocBynpzPiQsieBsaOUAL5CMWhm4TFVkx10qRxML+SRu+kgz/DjS1UrvS9/ruH58sjEPBCPtTXBsSGTWY5pTDVxdoDnDC6I/QaV4hHcimzu05+RljOKyQHDfwHq8EgTy6hb644zYdjcuGkbN8SEwy1dnGtR93v+bWLMEH174JKQjUZTh9CDskp+JAtESzFWdvWZWNf0oOfs5TKq6ZeniXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azqXBQl7CKSJRlPrPJjjm1R0AZX3gWOLOsCwhW2CSQo=;
 b=QNwLaS75pRBi7D9sqOmiBNqvJ7rAuwQYG7sjRQnWOsaY0NgnwPOB3IZBBYh00magvABbl57M4fL1dygJFtI93m0/dYgLJwYYSzHM8iHEmUZJKnC4Qc2Duep3BUTi5/0TmeeIMAtOmhdTbTp44qpibtW+dRMGLGunaeUDqBZy2B4=
Received: from BYAPR08CA0018.namprd08.prod.outlook.com (2603:10b6:a03:100::31)
 by CH0PR12MB8551.namprd12.prod.outlook.com (2603:10b6:610:186::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 13:32:16 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::b4) by BYAPR08CA0018.outlook.office365.com
 (2603:10b6:a03:100::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 13:32:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 13:32:15 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 06:32:15 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/5] drm/amdgpu/sdma7.0: adjust SDMA limits
Date: Mon, 15 Sep 2025 09:32:01 -0400
Message-ID: <20250915133201.3547033-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915133201.3547033-1-alexander.deucher@amd.com>
References: <20250915133201.3547033-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|CH0PR12MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: 25795f9c-32f1-4567-d2ca-08ddf45c493b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ew228JPXiXKPsgGtm0SXBw4SYdUi8lg1/hkTJmBe2Nnt4c9TX0I0z1v4fBNh?=
 =?us-ascii?Q?B2oHS8Ze4b5cw0kxTH6g4x2VxMYTkOgT96isN+ejeg+B176nImDx33N5IuL6?=
 =?us-ascii?Q?154Wiy1Lp+yRKGA8KIcjVnBMebAAKwPPqQhYOKRbABrIzP+6mV3A7MevN16k?=
 =?us-ascii?Q?9ajFG8Ok9uRpZ5Swnr3CoR1uwlM4d95RE96SSrgPTH8a2eS5WYHcAkyzLufR?=
 =?us-ascii?Q?Qh7AZ+hNzyaURDS7qwcBbKUYjRj7hHRt2VA0JGAlyetIRLzvLqMEL7l0IB0P?=
 =?us-ascii?Q?uCX/xrPwy1SLbXeZPOa8NDM6JrMhWw0FRAnKvBYeJRmy3xwiXP1Q+kOIgPjw?=
 =?us-ascii?Q?TQLBzQF2I/zwRQ6chjhGH7KzCCm8JThBkoI4pHW2Z1hsVOUCyBYZW8stm/Iu?=
 =?us-ascii?Q?md5yh8DbZlhSDFpKlODYG1pN+rWn2K7fiO8QIc0+/AbctKseQIZ740Ot4Lnz?=
 =?us-ascii?Q?7XwofHjjgSb14RjQSNHGtZYxmau61yxSAHuEGZofGpsBHjk0o404L6tK4NPo?=
 =?us-ascii?Q?jO4zrhoIGi/+WnY0Sm2vdp5C5WB3EQFYghA5++yvAWBbqZSQ4VhZQaX9IJwZ?=
 =?us-ascii?Q?iLzlU92EvSX71EukQ4jlgizKqHnzXpSlzr2wykc94BUYTHCNygjvSrpAbYft?=
 =?us-ascii?Q?HPc+1+0deQBa5PEa9sWO1ig1IhXxwCz2iIa9JeYcb6sM2Ab9OQ1ocsq9LaPI?=
 =?us-ascii?Q?V2mSZf8kTb9QnfGYcbJcrck0fgwIZj/HorAiWyYLTYmXZbb0uUbe27GumBwu?=
 =?us-ascii?Q?UL0b4aALsffHS55X61/p3QMPHsFnaByUD+QeeIVtVypCEzQkP6dJcleI1z0N?=
 =?us-ascii?Q?TJ9cjwVy4dR3yZJAnvlstCtNVi0ZzY0WSjf1zVAjkPXaL7hmKyZCXO4Qq3fh?=
 =?us-ascii?Q?oWKcvN9lU/epLE6POhoh64lImjOmm2ppMJV/iFuLU5djmfdKsb9/Onnvkq2C?=
 =?us-ascii?Q?N7W2rQHC5AInx3d4vtXJf9kFzWJXxqQ3v2WiqTMPYZPmDAPTr4pz7CUtMCGq?=
 =?us-ascii?Q?JnUtGoL88ziFoHkGQ5jIcXnuU3AYoc3QhKffCks8CF7O4NOeZ1mbPOyH/d5u?=
 =?us-ascii?Q?q3DqATsGS+vj1Iozpxr81eL/HRvx6YawNUtCUsSeOdGoYtZqH3aWoDaOVn0F?=
 =?us-ascii?Q?Rqy58XSMymQJePZKgBgQBH4V9FpW81p5Sakuk06RV6WQMrmuHRN9/ALaDzpa?=
 =?us-ascii?Q?Odva0h/ISwiJl2xZFzAlvfYhuKchRJxVlC/T4RA0J7pBWvbUpgYkkPCCSxBM?=
 =?us-ascii?Q?Hmw9/qX1FWufGhKFCgtL8fz/HvTzgviFR6dvs9wEbJZ0GBjZfgrD+uGN9BY0?=
 =?us-ascii?Q?9KQXXmiKRItMDaWrTBFg9lVh1uqx91PAd0VtLeFuTU8RwqOeeVloVf8SyGTj?=
 =?us-ascii?Q?nfiU1tfdgrsKOY7tIfyzJ8eObGe9iV/SAhWHLEVKA40r3KzwaVX2dl9Ubq8T?=
 =?us-ascii?Q?7MxTPWgdNcuQm2VCRCKwXHuQzquzE4iIhuGNyoimfSJ1o9S/uNLEYyl7/Lu+?=
 =?us-ascii?Q?hrw6kZqfINw5rS6ZTRPRFpLBEudoIwtlaVxC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:32:15.7978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25795f9c-32f1-4567-d2ca-08ddf45c493b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8551
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

SDMA 7.0 has increased transfer limits.

v2: fix harder, use shifts to make it more obvious

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 326ecc8d37d21..cb5a9daed63ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1816,10 +1816,10 @@ static void sdma_v7_0_emit_fill_buffer(struct amdgpu_ib *ib,
 }
 
 static const struct amdgpu_buffer_funcs sdma_v7_0_buffer_funcs = {
-	.copy_max_bytes = 0x400000,
+	.copy_max_bytes = 1 << 30,
 	.copy_num_dw = 8,
 	.emit_copy_buffer = sdma_v7_0_emit_copy_buffer,
-	.fill_max_bytes = 0x400000,
+	.fill_max_bytes = 1 << 30,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v7_0_emit_fill_buffer,
 };
-- 
2.51.0

