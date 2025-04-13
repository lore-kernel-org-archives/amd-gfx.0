Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E258DC3601E
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Apr 2025 16:06:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DEE310E225;
	Sun, 13 Apr 2025 16:06:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uGuKxZxc";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AE4410E226
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Apr 2025 16:06:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaLOFscPv8F3/6KSLuo5HtfJGW8Trils6EFEQ9iJY7qgWMBcHTuU+hUiPTU2KHpDkutgGadbKeFG6jjbUfX71CtAx56Ai6SXgQTugr1vmfrufEz3P3/12bclzwcQxIyF1+nC05yFJ7a16lNuqeMUB8of4e1TtRl18qXrvTM9L/J6nQpHAU708HleiRSe+qu/2RXwJlKnJsSgtWkFeBbAB7nepH1zaqly9pBGggp8l/0gx/ucGrwzuOQa3ZOMGRe+F4SzhiJGPkl5nxgBm4TFlpoymB1Pvx9owwjytNGPuUBrA0i++7ttpFQ/vSJf5MTy2wv8dz9Gfrowj1oD6I/kpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhQiNEEqKNb6oocWzfh8pFVhPGtoV+BALKimFsnpfOo=;
 b=iGg5zC1MjjXlgUL5mgFMYQ9OEh/MplSAkH8RlYo8/MWDEkreiGMPitGliRdeivm+OypoES9a+6lqNky1qw0WT97+02V/aMNB2wSBlV+wNIC1lRfdzSgOMfZ+QntR6S7sNI57t6evaPrkpqMZimb7tfhFEDonWx9s1wYhT//dc8QMJJFN0NdekrpOccVzXaR2ssp9wfHY8RaLfCjl32zoI8N/0kuVhKdY0BufNxhjKwj9153JahSmWSiCejp0usKgDAxzdmUo09aD4Xn3MaCbfqPGPKsfm4iMVqoG+TbxOs7wdCDdlwYhdfhs3ykevZm87YYyLbyMHCg+qgRGjjWS9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhQiNEEqKNb6oocWzfh8pFVhPGtoV+BALKimFsnpfOo=;
 b=uGuKxZxcpBUnen+Ahkl0kunsYN9LJJBEof+gd6HzV0eKkse4TE8BSPn7ZU+DReNcCBAJHv+fTMdnl4Ygo01KNJLt/8RnivPLu5FJaoRorhY6ox0TFWOPIlOTaiGWC1I5qJQmevddUeDkzAyqKnSsFPA9KaAkVh6keVOYgOPyD80=
Received: from MN2PR01CA0059.prod.exchangelabs.com (2603:10b6:208:23f::28) by
 DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.32; Sun, 13 Apr 2025 16:06:22 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::5a) by MN2PR01CA0059.outlook.office365.com
 (2603:10b6:208:23f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Sun,
 13 Apr 2025 16:06:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Sun, 13 Apr 2025 16:06:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 13 Apr
 2025 11:06:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amdgpu/gfx12: properly reference EOP interrupts for
 userqs
Date: Sun, 13 Apr 2025 12:06:06 -0400
Message-ID: <20250413160608.2198429-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250413160608.2198429-1-alexander.deucher@amd.com>
References: <20250413160608.2198429-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|DM6PR12MB4468:EE_
X-MS-Office365-Filtering-Correlation-Id: d2217f46-70ce-4214-6c8b-08dd7aa5229d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JYei2mZ9tufiQDdDm93rBKq1xB+U1n7Imwc6ZN7IXIgsdWGRzs9TuzH19ePG?=
 =?us-ascii?Q?wZ6WCd0hA53/b92UIOd7xJUnXKixxui27SQfAD/j7qq076vFdnhN4f9HgOBC?=
 =?us-ascii?Q?08sBZIqQTKUGuZN8TRAuYjNLppJ6bVWoM3DJD+6uRhzM3xs7/G3iFp/030Ut?=
 =?us-ascii?Q?9qXKYWNYom4nzEsA1QKwhMyzko54KQzx5UkAb4PuOMSKJt6u2GkMjb0EFdsP?=
 =?us-ascii?Q?Z1LEB6EZoCzdJ3W4b1L+f38kYPHW/Fcb6Nqxplizifaclj22Hj3T2JBkEE5+?=
 =?us-ascii?Q?21RrjtIfvAZX75n25yWnhhxjPvQ7h/bKPSEP8NaW0SYcFc+g0P4e4m3XhMzu?=
 =?us-ascii?Q?/0x1emQUmuHZD/4DQI/62hRJomzHtvnKoUH5kQog0wv8Q6J08j9lcqbVKjJM?=
 =?us-ascii?Q?YfuhEPNKnkE+HjcRRIJq5OeM3PEfe2UOWb84s2/uszSgWPaVHY37Y5GIwpmS?=
 =?us-ascii?Q?LvNSQ8Hosto/ToaIbtefCb2gq2pPnMb3Nr1i6f+KemhaK8JuItq8/EsiMHS1?=
 =?us-ascii?Q?c5viYvNx2ZJ+jIR8RKaOKkuDhL981GG0rYvJCzwCQBomKrqfqyBrWBBa/q12?=
 =?us-ascii?Q?ufB0XRAxZ63AeZgFqkFwES4apVpjR8xBW4i+F27/uQPEEKW2B70qJGNW51Ib?=
 =?us-ascii?Q?FdzT/Do1GPPo1aguGZnwTPFXKUfh1+1vfJIozLNSU3TGpESh8V4rzryfuDmG?=
 =?us-ascii?Q?WloaL9+Vpz8CTRxalyC9wA5K7cd5mqKBxxIOAGNCBUr3E8C3ZBkXf8TP0OOU?=
 =?us-ascii?Q?LOYwmyot2tebr1cOTzSpSXstIah1gMzQ2hyhSuaOSBygWv0oyDs9YU7IZfbq?=
 =?us-ascii?Q?aGz/Zk66QNLSbdCH/gqh2A9ZoZLEHLXqzYQ+PnkIm6P1n+kaKx6FW9eDiASk?=
 =?us-ascii?Q?ibq2LolrmTw/FHcjyLo03gWjksX17dj9JuqyeHkUCO3R/XbO56tW+EeHlmL0?=
 =?us-ascii?Q?y59A5kfKpeDFQpgC9m8PTc5wCoFCRXjEeyQsDMgHJKPujBRuMEY2tscG4BFc?=
 =?us-ascii?Q?7itU+IBuIkAh/gix5C2krgHsaH2To0b2LUzfMuM3yTzynAOpvjYv4jpGUe1T?=
 =?us-ascii?Q?c1MjbbbuHWTP60rHhGJl4bldbOhgaKBrpX7h6n8stdp8xXRl/ORQMM4qYQ2c?=
 =?us-ascii?Q?3kPsf5gekp4m+3TrkhRcxwLW4Rjc6aOg5MS3a7ZI5eVtodwN3n8fTchJWUqn?=
 =?us-ascii?Q?e8tZEFi3eWhOr4cEellYLugphf8rxtiKyUI+bUSUBxpRU4qEWo/CLAaEfpqz?=
 =?us-ascii?Q?BIsy137zQo7jZa4Irosp+4PGi8JH1m9swlARJEy8Wt2wWVRLtfV85utFJ23F?=
 =?us-ascii?Q?cr+4Ebn2g8M1kSqx/IM/9ywXSZljBN2GEvHCalKZUwKh0rWqeA9lw53Zl5/T?=
 =?us-ascii?Q?2/6GlQIWuJJvMYxssuaocOXAqQ+WgHnW/34+orJ6U7XNUVKCsojGrc1poYnn?=
 =?us-ascii?Q?zlz46JzD2dHAJ6yrehDBV9tFSFArOgx1AdI737e48Jd61TAFZjokSAz5Ntzo?=
 =?us-ascii?Q?NnxIkdoKsEj0k6+B/nrb5bggc/Fiq+tmxtpr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2025 16:06:22.5100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2217f46-70ce-4214-6c8b-08dd7aa5229d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468
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

Regardless of whether we disable kernel queues, we need
to take an extra reference to the pipe interrupts for
user queues to make sure they stay enabled in case we
disable them for kernel queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index acfbf48482ef0..ff56368df66ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3684,10 +3684,10 @@ static int gfx_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 static int gfx_v12_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
 					      bool enable)
 {
-	if (adev->gfx.disable_kq) {
-		unsigned int irq_type;
-		int m, p, r;
+	unsigned int irq_type;
+	int m, p, r;
 
+	if (adev->userq_funcs[AMDGPU_HW_IP_GFX]) {
 		for (m = 0; m < adev->gfx.me.num_me; m++) {
 			for (p = 0; p < adev->gfx.me.num_pipe_per_me; p++) {
 				irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
@@ -3701,7 +3701,9 @@ static int gfx_v12_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
 					return r;
 			}
 		}
+	}
 
+	if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE]) {
 		for (m = 0; m < adev->gfx.mec.num_mec; ++m) {
 			for (p = 0; p < adev->gfx.mec.num_pipe_per_mec; p++) {
 				irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
@@ -3718,6 +3720,7 @@ static int gfx_v12_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
 			}
 		}
 	}
+
 	return 0;
 }
 
-- 
2.49.0

