Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE37C3600E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 17:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C61D410E76D;
	Wed, 26 Mar 2025 17:51:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nza0nZIp";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E72D10E76C
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 17:51:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbjZ8QDEmseTpux7lRHsQX2u/v+RmEA0qbkXHP/zgXBFwb7f6JzcPVw/sHxjVHtE2E4lS6XVTGcKvtzPprF8Avuq75XvlexWIWBppmUJfAHXzXl5GVhlAyDcTaJu/x/O0ZOy/DwGzxtd3VTZ5ZPfQFLR/glSz6SaQcglNtmWLXPGoV9NouqbJy5pTd1Mcls3Pwt9S9dDC+3heLRYeUfLt2wgcLStzuyhcXLJeOtwRo5USDOx1twz0raEJAgB7AzmzHk26ISqUTXPJWv0/6OpTZNnLLPPEHR2UT4eKnYY0osxUAtzqqlN+EGQyoQzLab/oW4TH3dxS6nxfZSJ2OezuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOMCwMAppXh9WIzubCMzAmaDmD+leh8R5yMR+7v12kU=;
 b=D3IOIPD3oy7V5pkIBFu+7tf5O/cb8crgMa42rdSOxPHkRGyqLkUbZiLRKwZcDX3v6Ea6z3xYMfEZdm0Shv179Nc/pXNovL5OSYAlnfDgcFjxol8eq1TBqq7ntyuG2B3+ah6q9QoX/EsLmzqyDs8+llH4y6gkLQdU5189mo4OlmyNpDd/0+ZvyYqNZD6asKUO7LPIlq3K0NwG/GRdGY28LUgdfdC4C5rAsMM9iUdMx6GpqKtnsD0xx1p+ECQQyWaCBPih7/grGVCN4Hg4yMM702ENgv9NkERy5v+ey0E4dXwMaHGZmKj+Y43RhFua/u+Ag+Qd+gZpzhRWHp3OKgngjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOMCwMAppXh9WIzubCMzAmaDmD+leh8R5yMR+7v12kU=;
 b=Nza0nZIp6yBMelSuWq4hwrPeuFpruc5RN0Jr/3E55zQVTUjN5IbH8JDr+OHSb0hFqdnjTu0Cq8jE8Jys+y0XJFV5UD0yYAARQl8JyfYBnYKMbNoVzXz3HS4qZ3bGbdxP7Rr2V/0COp+nUqm793rtr2JnPkqBw9bect15LbxgXi0=
Received: from PH0PR07CA0107.namprd07.prod.outlook.com (2603:10b6:510:4::22)
 by SJ2PR12MB8649.namprd12.prod.outlook.com (2603:10b6:a03:53c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Wed, 26 Mar
 2025 17:51:37 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:510:4:cafe::66) by PH0PR07CA0107.outlook.office365.com
 (2603:10b6:510:4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Wed,
 26 Mar 2025 17:51:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 17:51:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 12:51:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] Documenation: fix typo in debugfs.rst
Date: Wed, 26 Mar 2025 13:51:22 -0400
Message-ID: <20250326175122.1209403-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250326175122.1209403-1-alexander.deucher@amd.com>
References: <20250326175122.1209403-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|SJ2PR12MB8649:EE_
X-MS-Office365-Filtering-Correlation-Id: 6984ddcc-7e9b-4ecb-67a3-08dd6c8edb01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?28ZVB0OYXI1ge8sLHtVGLoxKUnxrj5+aINRxnc5ZWkeBzmmuYA0NajqBuKtL?=
 =?us-ascii?Q?60Y5cSmbgBycxXc1I/zVrIuSUr+kRbP8sBVmWM+dH0drkQ83IyZUydV/pIkP?=
 =?us-ascii?Q?ixo30BExEnnlGT2HLMabDGatvR0f0b6W0Ds0gYmyL3aW2xC0qEmga3CeKxdh?=
 =?us-ascii?Q?8KJWmOF+TVicd2hkUMV7CLXOoyGJd4Uk3+O/IkjQ4bs+Dc2JugqkJu/h5p1/?=
 =?us-ascii?Q?6PZ+FqPDsdom/DFMYE9EBX17UmVTvni26hSPS/6dPlVixvfIs/V+i7CKLDTt?=
 =?us-ascii?Q?4gzNexXbbTXnZ67/yv1ldX59Wb5ftuJqzYTmcUarza+7gmhmHMFvaZNC/IFr?=
 =?us-ascii?Q?RRPdVg06lavtQ9Sa7ogPzHcZlR3No5Awxs+s1REZCdr5a+4GzBRqlAXCFfHQ?=
 =?us-ascii?Q?sxxGe64MTeeEwuEhp4CIFlL/1lMKmNQqL/qYVpvQiD72TDc6UBUzO7lNvCWU?=
 =?us-ascii?Q?dUMuLng5Aofb+hm1+Ow9mKdXCaM2C9YHEAprN7mkEjLixsgMY28KbJotThGk?=
 =?us-ascii?Q?60WzPyjav6uAvc3sjASbGgHAqrvJKpXa6L9z1d1XHBsmf2TZnXpZr6uNb0Pz?=
 =?us-ascii?Q?ZzjojLmdeAgj2SDCV+LyEUITSkdLHxC5d/hSLXSQGtvyV9+UlsyLq60fFToz?=
 =?us-ascii?Q?28c77n/Lfodp/vutuPSV5E3LGvNs3N1OVMf9vrUKLlIuuGrkP27UzHNOwYXt?=
 =?us-ascii?Q?JmI6c60/+2zGvxj7fiEsAfxir8PrQvJMThH7z/YejUwIs0cQdjhUc1FsFXz7?=
 =?us-ascii?Q?7B/etr/QglpEbLGYjNovc/ld0EEpYN/5O4CqWO3NzQ/jCaQMh+1eiDzTXNOn?=
 =?us-ascii?Q?2G2l9403t4Z4IUq2ggYzAa3qRfIKdBc0rbu2KMajuL9dLJJGLB119oKpuOE4?=
 =?us-ascii?Q?YsBENrfSDYD8+sN4VxKeg+XuuKEL+q7KA5Juj4jrthnovLolFWD7XAtt+s/J?=
 =?us-ascii?Q?aAT7DE0XOjf12nO1ZwpfF0BEvz1u3SxoJGOhCWSyEgo3AUq/UBaQbMfbQWOA?=
 =?us-ascii?Q?bqledngCBKw3oBO+doukWSNmTId/nw63G6YSOejhCVl1ZHnPjB+3nwueuZnF?=
 =?us-ascii?Q?G0NlF8ciZjHM9w6Jzn3Z2KJA1aWX2u1iN9CmorKft036Mj0FKZtHZNH7A+Km?=
 =?us-ascii?Q?Zqg8vyxVR57N0NwfWDTrpXyL9q5wWYani+6QHTMxlmGB2FvhRQhdVTjXz+kq?=
 =?us-ascii?Q?t8omLji3Y5gi0fYFA/sn+GjLIpwYBOG3uqpUmup7TX38mOKRr+Iv7QMykmoZ?=
 =?us-ascii?Q?3U5pOEvciFL9ZlXMavao6wcHDsF1lE0RgETlkpa9mby5v0f5NFQCC4WQriYS?=
 =?us-ascii?Q?rJRCNlUXVDqjIlNRd6xRLgXccVFCs5CpB5dyrdITWaXjXrYUvRZCivsP6L7J?=
 =?us-ascii?Q?Oh+RYcsmdDOrsVvEvXmKqJLU0epYMuuYKso7lz3cuyaSXwCcP7HUsymEMbUc?=
 =?us-ascii?Q?I6y1mXZHY2ggeDo2ByO+hty+P8mpLM5UqbvyhyRQE/vwrYWcXcF6kIPfNiJ3?=
 =?us-ascii?Q?Y88zxO3LGcc5SGd/RdWh5rQlYbdEKnC0nvAR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 17:51:37.0374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6984ddcc-7e9b-4ecb-67a3-08dd6c8edb01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8649
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

In reference to memory carved out for APUs,
s/cave out/carve out/

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 Documentation/gpu/amdgpu/debugfs.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/amdgpu/debugfs.rst b/Documentation/gpu/amdgpu/debugfs.rst
index fe7736a0b43a6..5150d0a956581 100644
--- a/Documentation/gpu/amdgpu/debugfs.rst
+++ b/Documentation/gpu/amdgpu/debugfs.rst
@@ -14,7 +14,7 @@ amdgpu_benchmark
 
 Run benchmarks using the DMA engine the driver uses for GPU memory paging.
 Write a number to the file to run the test.  The results are written to the
-kernel log.  VRAM is on device memory (dGPUs) or cave out (APUs) and GTT
+kernel log.  VRAM is on device memory (dGPUs) or carve out (APUs) and GTT
 (Graphics Translation Tables) is system memory that is accessible by the GPU.
 The following tests are available:
 
-- 
2.49.0

