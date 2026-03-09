Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543B1F417E0
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 14:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F7410E15A;
	Mon,  9 Mar 2026 14:26:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lVKZCmnG";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012039.outbound.protection.outlook.com [52.101.43.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E908110E15A
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 14:26:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9BKlLW7H4dx3wKY0Yo2dTGhWRHZsWppUZKCZ89u35CAGn4Pt9iokBuWcRgoqxOpv8S0W33GbVnfDVsG78myYoMgZiv4KSMHslCXFOWKJipePfQj1CoDqEerv7xoXjkn70esAFcjcHmZ/fbPCwiXkq/cuPDkXaoybLcN0IOkhzMJqFOz0YYYB2RDxkorw5CtAqGtY8Pt4QEZOXHPB0rjH8ooucBZ0N9K34MF1TB9vZsh0a96xMVV4ZtCAXPyfeyKyTp2N/kABo3LSGSshnVKCAfONhIuQj1mX1Fa3C6bJcuR3tjOKiTJMZ4oi/PhbS7Cj6L5jp7OLXzlGmYPLDI/mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPQi3rvi52AznJYtZ5KrE/GMkav5vg80nVz5Jv/AfYU=;
 b=h5vwUFQj75s8Vc+zLEtZY5ZD3qPLPKG6NcL2MFsS5oD+2P4kgGj3Dj/h6xCLUC5J2UY65C//8ChkBnSBAhWmXPOVRCELMn/GiR1NhfN+mYDA4gLkpIuhKNg+rnluxYkQAYDJqv32XNjQNy9YorpPo+xW5XEJmTovSCSJH49uTGbbuehKGByrZJBDmXPCd4INqAxStqZ7LkbL9RRDOkndKMp0G3gMdms8g0vJvUoYxwyQ6jukKsEI/9QGXW1XM7u29mcGFLrLQABHJ640K+u7+DwcCJG3kSDPAzS3vL1Rtw1WXCsjLjSBdbvnYbGfp65V6PxuH/sxjCI2U16/R2f6CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPQi3rvi52AznJYtZ5KrE/GMkav5vg80nVz5Jv/AfYU=;
 b=lVKZCmnGs/PfKCfxEJVKc+JBxUzOOGCsjd+FDABxAbrUk+szslTulZwsDo/iPpgaQR8KloqdOtsqxmbqcUfyzJ+rsl1uDzmWB83dwlxxPMH31ImeUoWhTnPkzeycKLPRzdqchphSWBikQHHrAvdSaZKdJha6gPLLJM4X1vXYJJQ=
Received: from SN1PR12CA0078.namprd12.prod.outlook.com (2603:10b6:802:20::49)
 by MW6PR12MB8914.namprd12.prod.outlook.com (2603:10b6:303:244::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.10; Mon, 9 Mar
 2026 14:26:37 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:802:20:cafe::10) by SN1PR12CA0078.outlook.office365.com
 (2603:10b6:802:20::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 14:26:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 14:26:36 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 09:26:34 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 07:26:34 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 9 Mar 2026 09:26:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Michael Chen <michael.chen@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix RRMT for gfx v12_1
Date: Mon, 9 Mar 2026 10:26:14 -0400
Message-ID: <20260309142621.2843831-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309142621.2843831-1-alexander.deucher@amd.com>
References: <20260309142621.2843831-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|MW6PR12MB8914:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b5fc85-4050-4083-8f5d-08de7de7df03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|18082099003; 
X-Microsoft-Antispam-Message-Info: hZjpKLQnxKVy2zr3LaDKUuDO7R5PCx1fTbUp2rljyzSSJHbmupiKX2cSwaQd6jzgJPGVHz3bU/bIWEgMt294oXpxrLw7lj1h/uI+hqEScwMde8Z4x6mVeKLCQE9bFhIhfjULumu3FQQ0hyZEYjm/DHo9taba8eiSpR6v6rZGhydFBGCpCgRVAq6qHWqnhGlNQdG5FotSeYcVnXYYeRCEhst+hjn2eTC+mG7qACfUUNkKIB13J9tyJ8TBlA/gaFvkYgBZjC2oocqhI57HJMAFOOZSlBTtZLrBeUao1fgpqFJIPQSKpAifLmjxxzGE1kmcZTd/46JPaX/n2a2Qqa8Z+aSffTa8R6YcMtYmrfdsJB54KTFdQi+vuK6knf6zlwVE4+YBvuiN5LjirWw8b5YDe68y1JV+VhjVyV1oWOpgvEvJ83Zep17tnk8jcDNZOlZOe7DApsb3ylAZkQTUa/myBQ5ZAwNOq91LWfGe2mt3mnRP0m+EvCmf1YvX2Q63YAz47nFv7ZuLhM/L9niDGdQaUCCIKvcBWOnwfpRgw9nrNqyi3kPypNSLT2w1mvptN+bRuhsk66xmYpOiLK4LpA082cA6pUQ1nfqm5yhspYTJhHOIXqVz9Xo8BzRpR81PQ8NAVYWrN7XkE0XJbqjsXI7F9ihClYnIMyb5u0dvAUxh2EXeG+2GhBgTNy08FD5YHi3R61h9mnjPvO0mWanNVcMimMsKF/4/aXedKU4EMFx3KhkBxDRV30Zg49XCBTYXHY+HrAPBR1FBBhGyZiT0tJEKzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(18082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rsa4mnftMR34UmV13pv13MDEAA8P49aU+ZQtqkTsdkt03cKwIanJXFXhSKbw21lQbg//O5sjTlb0Mrifbs9HAmyyUwiYNoWdWfFyOF2hHl6CkkmkEPF2fSOB+lfiCmWUmm5kA6P8+j9yKN7sQpjK2L8543ITMQUqEZvQVwQGNKlQN6V0ybtng7rs05YollzvS6OofnLmCOhwvNHyPXcai7gNLl8RnZB/Xe9a2+lyIJE/RoegYjad37hs5kFOOyyDpE9nf+tnALPs3RgY+K+zYioSRD8NrxauapPxMjcw+p/magQXvAwh080B46pUPm3mk/1Bv/el1CJ8jSgLKpoZTC4aowuhHYXsn5i0F5GGDE/OVNY/6z0AN+qWnqwH/1xs5q37OX9OLigOCA3vQ4p3jXUNX8MLQNWXtONGnhxf+5qrT9PlTJCd1fOWYVuO88jc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:26:36.4985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b5fc85-4050-4083-8f5d-08de7de7df03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8914
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

From: Michael Chen <michael.chen@amd.com>

Correct NORMALIZE_XCC_REG_OFFSET to 0xFFFF
because reg offset is in DW. Also set mode 3
temporarily for out of XCD access for MMHUB
TLB flush. Will need to figure out how to
differentiate between AID and MID access later.

Signed-off-by: Michael Chen <michael.chen@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 2b3dbc3190ce6..ca8cacd345736 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -512,7 +512,7 @@ static void mes_v12_1_get_rrmt(uint32_t reg, uint32_t xcc_id,
 		rrmt_opt->mode = (xcc_id == rrmt_opt->xcd_die_id) ?
 			 MES_RRMT_MODE_LOCAL_XCD : MES_RRMT_MODE_REMOTE_XCD;
 	} else {
-		rrmt_opt->mode = MES_RRMT_MODE_LOCAL_REMOTE_AID;
+		rrmt_opt->mode = MES_RRMT_MODE_REMOTE_MID;
 	}
 }
 
-- 
2.53.0

