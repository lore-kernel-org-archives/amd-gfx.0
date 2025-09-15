Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E939ECAC597
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 13:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 672A510E4B7;
	Mon, 15 Sep 2025 13:32:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ec9OO7d1";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013006.outbound.protection.outlook.com
 [40.93.201.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 676FA10E4B9
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 13:32:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7sPA933RaQs36843D618mPOGwUbr1rsCs6QfvxYFhv7/uYPHPSwkAYdJEW2XPfdmisqRKH36mebqJtJ+nlYFO3sRmB8LvxxNssm60L2220Ic7OajCps7G4msTxhKUA2h0yiWrAbCgWKdgJ+17kI6SrHAWnb94hwW55Ct8R9Ha7DVv/2FRfkIro30CF8EyET0ntDF13OKESXp3Fujr47V4KIDDKM3sr1CBNgPxjNlIkaWYqe5aia9kj7JdooCiQudBuaFS1VnLPz7ktzN7sh0Koc0SZ2R2PtrVabbwBB6Xt2xv4v5YMpJY31gMmn5eesjxlw5DEHd0Z6Iwg+/u2iIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDI+RhhA//1/vPRPbFQsxflxQ0H+KGzKGDJaHI0u3/o=;
 b=ZfTiI1GmqFoaPNSOjd2CHwjWig5iZZzcz0KHWba/GmrYggEO2CripycpRlaiamINiuKBThcYFuZVCi3Lsrfjq3UwBC3/IfOlkZUTSivEKGlDMxNPez3hhvK5wHvn+bO9P01WwWpEw+VqjJ5KmGuuaQB6ET3N/F8j/2EMk4B3lblSNE63pXcWGGw3nRwyPqPNI69H5DKzKOPRpQEYZfYW4lMhxzRME8iNO5U5wd05LBxrPS5o5zRreYvmXFcg6iitH6W33wVQDJ/rVq1skNd+L5G72zEe9do6n/8KKWn/IPMSHLcEBYQ9xfEgyZXDs3fy9bX53y7xN6KLcGPxFrJ+Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDI+RhhA//1/vPRPbFQsxflxQ0H+KGzKGDJaHI0u3/o=;
 b=Ec9OO7d1Aiab74Eau6c0Xsyqp51a8Y65lwF5l2JAxwuGXTCh/GMmf4abYqFlpZG/DkS+cir7w6xncqY4qodpCvxGV/fB2wSltn5kXBve76o2jstrTjCa3bNNeKWCbHDKBb2F6wfEZovCEG2xjUFQX/tr/Xdv6zQEAS3x95r9wYU=
Received: from BY3PR05CA0040.namprd05.prod.outlook.com (2603:10b6:a03:39b::15)
 by CY8PR12MB7291.namprd12.prod.outlook.com (2603:10b6:930:54::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 15 Sep
 2025 13:32:17 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::2e) by BY3PR05CA0040.outlook.office365.com
 (2603:10b6:a03:39b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.11 via Frontend Transport; Mon,
 15 Sep 2025 13:32:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 13:32:14 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 06:32:14 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/5] drm/amdgpu/sdma5.2: adjust SDMA limits
Date: Mon, 15 Sep 2025 09:31:59 -0400
Message-ID: <20250915133201.3547033-3-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|CY8PR12MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: eb61fc57-f4a5-477f-7c88-08ddf45c48a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?625O/ghF9tD8v7FIqBNq8nO0uN5FVJahXjlJ+YMbFnmrBRktimnv9PNDvJYi?=
 =?us-ascii?Q?6aW+G671sbaoaFk30puV9LCYHyCRtKL+61vEmO4RDxqtIQtoHpZ9vgbFqTl5?=
 =?us-ascii?Q?iUIuuwo8yOrXu7BvRSIyTIS8mU2t0xbjXpzBhkhHZ3OrbS3iydDVvoVUR7cU?=
 =?us-ascii?Q?mXMD266/px4S7Y5Zp9HhjIYxFL83+cNWLtdyUgxrBRumyghITMu//K+1IaVf?=
 =?us-ascii?Q?W5N3Lo2k10LmTC3hXaXoD2c1cM7e5y7NHc2SQeU4F/Xoshajl0/djd1AAYW1?=
 =?us-ascii?Q?Z71vSMeAJnZOaeC11qypCUP0Tgip0n0M6OQq3gDmFuaJctHnHhOCJIYR/NDV?=
 =?us-ascii?Q?3UA+7L1etnOzdmQ0hyV/lfKr/BtXNn8N+o1UMAv4Hxtr0VN/sASyUC9yZi2h?=
 =?us-ascii?Q?veGRYkoLSMwy2jcvkbx8jsODr6Z4X7yFn4q1nbcZ0PYgNjXSOVccg55XwanW?=
 =?us-ascii?Q?QJ5PfeFAEj8RGBuo0Rui1Nd6mbKv5wjjvPyPFFE4kh63VdmVGcIl1BLvDCNp?=
 =?us-ascii?Q?Lcduq+4o/6rQbhnhOG6benzNJZCJrQM91Ok1CUuNDEeMYUK/JYUHevesi+H4?=
 =?us-ascii?Q?yX+Vkr8vs9WkB6U4rmYfylXjQYjJhmOJ9sNvxr7CHjuVLNiQhhwoSDKoDwAQ?=
 =?us-ascii?Q?L6onmYwmuVjsjtzUwCtVtiKBIh/inhd138fu4jnexQY4nKas4RIfVbIERuWa?=
 =?us-ascii?Q?R0SMObvby/r/n1ZJU4DAdJrNBEq/SIYI7b8VWqgIaE7k+DjZYzTX74lZICZ6?=
 =?us-ascii?Q?5clpz0PsEitYZuqrtvrEtoeg90T0yk/YdKZcow8MmFI6oxiwUMW5OCrbGso9?=
 =?us-ascii?Q?+wqnfPwIsr58zqtERLAnVhMjURJ24oQnZDB4ppDD1qLqww386QeJHwm20TdN?=
 =?us-ascii?Q?PBJhXPMEd6YwfXn8mwuS/ym6E9Jo9isWgIAdvg2bZ7JqWQZSkkSqXq7kWNpK?=
 =?us-ascii?Q?5QpyTu1WvYR0oTRYLU39zB9Ak9643j8nOZboKXxyX9/FtwWyao6TlWDjbB5M?=
 =?us-ascii?Q?IOCB/zgVP7MFkhmPgOHvATW2Xvx+zrp+xal+H9RZzyafo3xlX6BEHj5LU207?=
 =?us-ascii?Q?u3rKfecaRVcekQhAaSFfk9qzVMw3XiD46R02QxU5PiPiTAP7MMHXs50v3txw?=
 =?us-ascii?Q?2+Q3fmi4CfM/Wy9FEpvzKzrZssL8QhUkQn3UX5G7nsHoAO1V45RDjFNiUt3G?=
 =?us-ascii?Q?Jf8iJ9TYNg/NBmqvivPJLZ8w5VMHK88NIHYzSPk+lgtnnf781dwRihaPPD8v?=
 =?us-ascii?Q?gOf/JaiemgUKi/Zr9G7IyjQOqra2C2o2Kt6wwJC5hkdO4tlWgHjheuCjKV5D?=
 =?us-ascii?Q?pL2fAUog2TV807WeO8WITLe7vlOU0SC6XQ06EtFe1Dne4xBuobuLYEgUqIbE?=
 =?us-ascii?Q?SQsUzgffSWVJLyn2HN+XHGekPK9uALbpNmbiym1ndVOH1HaLMKyj8crIFjsJ?=
 =?us-ascii?Q?wjtJHvFDdkDfOq5eblo+UKDW9YMK8IFW9HWhcg74jPAfPPb318i/bHIdGO1p?=
 =?us-ascii?Q?T52ihE1sDYaaBQrb2+2vy9JyMiAD6QAKubRE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:32:14.8315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb61fc57-f4a5-477f-7c88-08ddf45c48a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7291
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

SDMA 5.2.x has increased transfer limits.

v2: fix harder, use shifts to make it more obvious
v3: align const fill with PAL limits

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index a8e39df29f343..d3b2ac5813383 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -2065,11 +2065,11 @@ static void sdma_v5_2_emit_fill_buffer(struct amdgpu_ib *ib,
 }
 
 static const struct amdgpu_buffer_funcs sdma_v5_2_buffer_funcs = {
-	.copy_max_bytes = 0x400000,
+	.copy_max_bytes = 1 << 30,
 	.copy_num_dw = 7,
 	.emit_copy_buffer = sdma_v5_2_emit_copy_buffer,
 
-	.fill_max_bytes = 0x400000,
+	.fill_max_bytes = 1 << 22, /* HW supports 1 << 30, but align with PAL for consistency */
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v5_2_emit_fill_buffer,
 };
-- 
2.51.0

