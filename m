Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F20C61DD6
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B8D410EF03;
	Tue,  1 Sep 2026 20:11:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3bTmLWPH";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011017.outbound.protection.outlook.com [52.101.57.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B9C610EF03
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:11:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxMLq7ozADUMhQHU0otZQeNokQJ9+6ySE0VuU5HtfyGZ3hrUh5aH64p/qVVjaaoHaSs0133rcWeJ0SfrF0YdHCKPfXzX+orN1CewEg3rIMIpROE0+L8xjvc6FvGuVuhx2XDlN7okAHjx3ZWhTmmG5f7C73n9gM83tNho3ExUlJXhzYX3bNQmw1IZ52F6npNLWFZtup4ieduavsh6+0sHp+MsGfTJheK8iu0DSTxEHeZsiJFm1oUq6w7eOJQvpT0XGVaIjcJDwYUp4v3rMeymoW98C+PBqBchLzAwBIKfrt1ZOJpb+AvMYZf3c9IJjs8Bt6+db0QdM1CIStKRz4JQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChLUnq+55C4JIdnMwoVoFbvBmdQh82nkqbpuWF2GBDw=;
 b=ap4zPyLBxZNhbLKLZ2y0ef+jxI6Od1xmzd6qEYuAFfvTYTUN4G4wYZC5NSxVj7CR+ium8Nsxc+H/PTYxrbSR2Z94J4d60FKL9X/bUI1/IeFUJr1y0iRu9whFRj7AfZPAPVeT9MxoynheocZBhsjco1IZmwOrGtG1mw34HylhS28FTvckfZy/Jbd5Df1SRs/1bVBO7F1KQ0JzWEQrhS5V+6rjMcDOZLAuYt3L9rMhIIhkdXqjxyUp+MjakTg48TXtKgh4sL11ui6fo22iHY8m+zyRJjgCBMg4LMT8BfJoU0aGqfBmNZbS2bHfN6ZV2MEPV8iqV9Z4EOymqVt4r0r2Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChLUnq+55C4JIdnMwoVoFbvBmdQh82nkqbpuWF2GBDw=;
 b=3bTmLWPHzw8GQ+qiUfpcfRtcxFtVyihVRd9krBVDWqs1u5xTZFLuvKdNbVl21fP9KWPEq4CZl/s5OLsLn35/S/uBO4rQ01UEw69wYODvod7PL3rb7U44C/XFhaNSNtADGDK6pJJ5Z+r8xTazVHyDd3jgKwGG8LlchfcerH0GZTM=
Received: from CH0PR13CA0039.namprd13.prod.outlook.com (2603:10b6:610:b2::14)
 by IA1PR12MB7757.namprd12.prod.outlook.com (2603:10b6:208:422::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:10:59 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::af) by CH0PR13CA0039.outlook.office365.com
 (2603:10b6:610:b2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:10:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:10:59 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:52 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:10:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/31] drm/amdgpu/gmc11: use MMIO for TLB flushes
Date: Tue, 1 Sep 2026 16:10:12 -0400
Message-ID: <20260901201034.2960437-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|IA1PR12MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc30f5b-c5eb-40fa-9be0-08df086523d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VlFstKkIFKfYlpslNhdgLs6iVfb3Khm0Pmq+gk/sedubb5N9OJdvUCNrB0jsOXc5Akc43ZSEjvmmOK00QmPnv919PjT7QN9BT5r+EGHB+z7Wsx3fdTkWlLczVqM449J53Xcb11GoaTFIqR3BnTB/M3AQsM55ozQ+qRDneRt+hl07qNBniwnQsKYJUoGLBokZuzu1SjaB0FTiOhuvQGj4IKWlWadin2xrV+vWN3wLOcQASor3qWB6RM4yno7OAkTwL5hIW+61oDM1wpTlvJ6wL/K5cW2g03MDguZBmN0W+T7PrqIOmSg6/T+qiQpFgitH0cZqSlrp6IqtN+eAi6ww8ZRh/2S1KsFwbhCLDCQmDQBycN2qOKMktGAi6VV3GKb6Wm6UkEhlGCyuvEX28GB7sAeQMs1RBlvw8ug1bOT4R2h9Fvq9zEXfuzzfX3GzvquwbWh3mCyFpXytmf0YRJ02NtUiOZimLARPzKBS4m6qfmD+xTg1l6xJUM65aFzYusMHjg4GLxhfagFUidJS49vNjQpxG1y74ZgQteX5MvD7VNwOeD7QVT8xpPxSGla3OTL5kdL7EHfiqgZ0cYkVM/bpOPXFAacZ29Iv7HE3BL4MTP2SKVNLb284m/OlX11pFN98Hv7MWN8NYVduHJvU4muw13Hk/tvc5L5QCrcrgySkMwkoLRCfmYOZvoCjH7DW/TU3TF9pJKHhp5rkWiMMIeAXwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fCjkDX10i96BAYHKVLNQmyTW+Y9PmpemD0C2Wa/2TEP2yeKDxPg3ifYS/n1vSUF9Us5qVMtAtMypJ712pEu5xp/Nb7okZ8UqYd2eGzHMSoIoXH6tqqTYUa0ZxD8rHZVgq86O3j1+ffTm8bbNrFIMuThODO/Zr+VDdKrNJXKsTiNzdpC18bDaFvS7209mZRgSss6c3s4nYxx3h2H8PF3gvyaEUTF7XzLJT05nMUKhHqSyaJjlEe7ASfcUrIl5r3qi8+diwPyqEOiFMqWwZIjcvP4HAQ5XLTExa77emqfC79yj0Xeqz7Lc6T/uzj12WNjmVLiWi+DhAozovb6CTKdrR9P2i6Wh/Q2obhucdv5BpcxspJKYv7IYKJxREz+JVpvtRZRuCmgCQkRatcNhOrGZobMPWTk1aOA8nUZIolTEGwco2go+mpVG1+V3Vvm86D9E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:10:59.5379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc30f5b-c5eb-40fa-9be0-08df086523d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7757
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

MES only has one pipe on GC 11 which handles scheduling
so it can get delayed if there are a lot of queues active.

MES was used to avoid disallowing GFXOFF, but since the
MES will wake GFX anyway, just disallow it when we
flush and use MMIO.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index fc730504be5f0..098e1340554c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -866,7 +866,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	adev->gmc.use_mmio_for_tlb_flush =
-		!(amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev));
+		!amdgpu_sriov_runtime(adev);
 
 	return 0;
 }
-- 
2.55.0

