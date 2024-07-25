Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F717C3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46E3B10E843;
	Thu, 25 Jul 2024 15:01:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xVAlv4nu";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8DFD10E842
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOAxK6CdkgTJsCv9d6eiaUpTxWXS51Zbsd7T/xX0g/ObCcda4w4NRFWizTfdfScs4eYBmOf4P9imlGDrXOUPayxjlwxlkgB9ABD60ghdZOa+79itGsILD0aesl5t0enstgMaNCZMQ2gbVki+w+wYdrTjOO4iRtLF3q70bwghejqM+wpdssz2+rze3PYYEaio7uKlGMdCHuchuhD5/Cv8As7ocpvtDEXvjr63O2jIJy2cwdg2egkIlF5ccwR8vPliYh8YBnAYNx+xIBpWLdK/pngtxmxrUWFQyDXfp7K4Xyo6c3bVCaxCXU3nr/5CwVVA93O+hcwvaIngQ9YSTp2miw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uOc3BFgd49pluIPav1P+WoT8w7CjVDlYv9H4TJiydY=;
 b=mXymIjmLje+WyuWHyScfvKDom+vyo56fm58chamnyiRl/8t4fe/GtqVJ44cqXZvcoiNT/L/KdW7cA2Hp2n8q7I1TzjGODUm8wzpgjRvUxglTBd5NCOOZJhWPxikbXFmG79Csk09cjvc1cD/G08q0S5lwhwOo8DNyqXbJ19/WlMZqXkmSurOSdTfITXT1XMon334PPTzf0weSIPhv86F+EwS+fuyRAa8zArz7Bmb3wo7hhksPVYf9CwWTeWMRCfmRQpVpHkvXQq2q5jmMPecJSXLjt3h/C5Y8htssOGNGnmN/mT4ZzoJQNE3+q/QAxzjZg2p0xTZjtp4/YTUQxFcdSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uOc3BFgd49pluIPav1P+WoT8w7CjVDlYv9H4TJiydY=;
 b=xVAlv4nudA8HnmIBLXakTPMeDuVm4XQ5+OjVraQqRZo+HtzmDcPUy1AUwalThcnUggVWXeLQ/+gmOnXbEwG8ccD9HYfpMtdMvWAIRulwNGF/Qc2R9dNKZaO87X4iVZP7DGGwaVils10NDmAHr+0TxmAqrYXNPb4gm5sPRIqkShU=
Received: from SJ0PR05CA0024.namprd05.prod.outlook.com (2603:10b6:a03:33b::29)
 by PH7PR12MB8825.namprd12.prod.outlook.com (2603:10b6:510:26a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.35; Thu, 25 Jul
 2024 15:01:19 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::a8) by SJ0PR05CA0024.outlook.office365.com
 (2603:10b6:a03:33b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Prike Liang <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/53] drm/amdgpu: increase the reset counter for the queue
 reset
Date: Thu, 25 Jul 2024 11:00:13 -0400
Message-ID: <20240725150055.1991893-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|PH7PR12MB8825:EE_
X-MS-Office365-Filtering-Correlation-Id: cb77bc8d-7c45-4fb0-5876-08dcacbaa3cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SqmJpOL2kJgRmtl7eb8HkXwfnbFPTtxDPEIcEuD6THWETnVOL19JRxma8YdY?=
 =?us-ascii?Q?+2tudgxyTTiOd/kjyoUqNtotUMfpNQVevICp+tGMMH5DF90+Y0JWCYod9Q6p?=
 =?us-ascii?Q?nUPRuuM06TpNTe1SP6p75rIBGl3R0hOJw6m3q8GIWb4Iu8f51jcuJMZ9SG8B?=
 =?us-ascii?Q?9lyjSXd844l2TDy/Nh85TVFgV6A0gICX4oqBRc2z7Yf+vqFPQxZb8CoxXDSd?=
 =?us-ascii?Q?lh6wYB+EvZEuwOXAtQFpqedHFEBmJxovrlP2uM2zpquUE2rK7OogkXGt5Gel?=
 =?us-ascii?Q?j/YlTnhSUt+5Pog8tXRgs7ztsW6VF0yyK5zCyt8TVZJWESAft32Pr1kPfGvW?=
 =?us-ascii?Q?a3I6lwZn3n83ZM4e4nNofnz9jSdFuyX/yQwN2LUswSQOp10CEll0RHqBygbg?=
 =?us-ascii?Q?MotvgeQooVHaDgkvMB/r/XiAN9NrfVurm3i5GwVNwGCZSW78soU2Z7/mcVRc?=
 =?us-ascii?Q?Zq11tIKwPABDJlqrlVhCLeBZuZit04a65jp1KzcOKeVGmGxkIJNZdWiHxgf/?=
 =?us-ascii?Q?LZlhcZj3zCu/jZzMojFOm2XB8bONvNb4V03wk3FZAy6UkA+qN/ggJt+NOaj+?=
 =?us-ascii?Q?YCF7BC0mY6xJ6/pPBvCYdTq4Bdj0gezIBmSKOJlYp97FVZXiwVIiFNNwjyl5?=
 =?us-ascii?Q?A05eAc+IGeSgcVaF2p7VmKpPqw60xvyUdjPQ3J/FSJGjhVyES/gOceNKiPrK?=
 =?us-ascii?Q?wfItcN4mNl4oYZrpdwmXSAq4MQ84yBrL5PJAdWPuWjjND9AF+K6vcw3Pc327?=
 =?us-ascii?Q?DuyciJ3FJk5N9G7wluxYQoYvP3pRTnk5oTlvc+6CJdp1xoKtCi/awHb8Bk0c?=
 =?us-ascii?Q?FgPYqc1AT7tzIsjaUbCCaFWNJunpRq3tv8xwz3MmC8Ms3bkJje1EsMQ38MDB?=
 =?us-ascii?Q?lVkKdCL+aKXUuJJH0jO6o/2mua7F4aEp8SuI6Ai38WLwPQyKLPhYlQPlhSmj?=
 =?us-ascii?Q?5KOU3xlNuDtEnyJI7hOmcqGl5fRa75lLwPVi7F+vvTEWr8O7wAOpm2q4oTQa?=
 =?us-ascii?Q?T3mX5SjJw7qh9+4FKCpwYNPO0b0XrbcbW5JHk7HM7T7m8HjrKh0IGb8BZZS8?=
 =?us-ascii?Q?FunbUxl1Zy84WsV2o6OS9yYcnrcvyo8ja5tbOoBuTJO6M7cPzj09X+iRMMnW?=
 =?us-ascii?Q?y6R0IQT6OEeHb8q1DMiZP0Q0B/yuJmrLoNMTOL5Z2ovhxwM+QFy4DGfPu96w?=
 =?us-ascii?Q?9NWatuzqbaBbiLZfQQkUFuKp2yr2XJ882alqCfkLgbCYzrGTSepRlRyWWlHh?=
 =?us-ascii?Q?xE0mBTdJ7SglHlqws2OmT/+CAXevl+liqXtrruhr416oyCsiLwNgXtoyfqNR?=
 =?us-ascii?Q?mnZIzv37Mc+tBZZ7/d/mwtuPZshHVzV0tFPtxQ6LNt+4hEAYKrPZySU9COZc?=
 =?us-ascii?Q?5qMsGxqZxIzKmE/xmEUzghiMqXxlLlMlcKDYV/hzuXTLM53HRKmEkEEF2O/d?=
 =?us-ascii?Q?NNIOiwQ3ucrS5C6wuNgfSQybjg7lZ2G6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:19.0399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb77bc8d-7c45-4fb0-5876-08dcacbaa3cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8825
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

From: Prike Liang <Prike.Liang@amd.com>

Update the reset counter for the amdgpu_cs_query_reset_state()

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index c104768cb787..563fe77559c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -84,6 +84,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		if (!r) {
 			if (amdgpu_ring_sched_ready(ring))
 				drm_sched_stop(&ring->sched, s_job);
+			atomic_inc(&ring->adev->gpu_reset_counter);
 			amdgpu_fence_driver_force_completion(ring);
 			if (amdgpu_ring_sched_ready(ring))
 				drm_sched_start(&ring->sched, true);
-- 
2.45.2

