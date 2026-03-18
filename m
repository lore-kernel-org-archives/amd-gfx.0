Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC93EFEDA09
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:02:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 584D810E650;
	Wed, 18 Mar 2026 01:02:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m319Bowf";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B36F710E650
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:02:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7+V7CRjBUS+JssgkvgLgknrUoRlDWfgScdpO0ZvuzRZ/2rfH1UniWLZiOB4tifnAJehRLlmFcq8w23kWqI3uypdpbIL/nt/sHZfFYqIiJRD+q23YZXuJ6wHxItCUr+c7xO5MVqUZvrr3VBtFz6MlN97dhxlOP5Qj9AnpnwF7w9ovp5YtcllwXzzxe0cDojLUBEokS6fPnQpaDtocGgSjvZCZW/Kb7UT3G6apr9ddd47fjR2L6CiJLVgdkjuLO2IJ43GSbCO44JTUgz3nNZkT3SNlPOpedoGDWbdBp53BHR80ls7IsLiOCVdrAd/rBubODnPluIoj8EzeeRKpviVsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbgXPrUhfxFaFq1/lHtCfxjUjh7Xf4kZY/UsKrx7/ig=;
 b=w27YrRApLP4G3JOGEq+Ilu8MF3SdGx7vi8fChzK32q5ZIgzs9A19AY+/oDEVnIfZ4XoaLBjK37uVcWFBDG+MyKL1uY/gfTeWKAgurPn1RLcT1QkEFhCNhNkDNFGC/IVEMJtJZBEZ7bDXbXYlp2KvBGswr0gkxBeX8waSrZIjXehEhhA2k26DhSeDOKh+aoNmDDTv8FupYuiA+p82mM7kEgeU6Rf7wdNNzQt8EgoKdyEjpv3nkenvR4eUmygPOdaW/x4DG20mxriSm7NWh9yxpsqc5ibtXJ0LTIKiWvA5/Q3P4/umrx+sCUrWprvROtFfL1rc7LneBjP9tyVj01GivA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbgXPrUhfxFaFq1/lHtCfxjUjh7Xf4kZY/UsKrx7/ig=;
 b=m319Bowf7KJ7qTpB+iAutQaVgfaJJuAkFAnwHJrjTQZ0nXed7atBnaErjsu703k7jOQ66JUMZuNm9k4Mglp7vZ4WRxsrwN2ji+Wo/DUHO3KePPg7Mi/m8YsXAXx+qF92nAx26/cKA0L6lOit0erJ4mkoH/+26koskmamFk/yORY=
Received: from SN6PR2101CA0015.namprd21.prod.outlook.com
 (2603:10b6:805:106::25) by LV5PR12MB9825.namprd12.prod.outlook.com
 (2603:10b6:408:2ff::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 01:02:04 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::6c) by SN6PR2101CA0015.outlook.office365.com
 (2603:10b6:805:106::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.8 via Frontend Transport; Wed,
 18 Mar 2026 01:02:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 01:02:04 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:02:00 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Leo Chen
 <leo.chen@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 17/31] drm/amd/display: pg cntl update based on previous asic.
Date: Wed, 18 Mar 2026 08:59:26 +0800
Message-ID: <20260318010224.513094-18-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
References: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|LV5PR12MB9825:EE_
X-MS-Office365-Filtering-Correlation-Id: f39bb28a-74fe-4e4d-9442-08de8489f850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: NTHTqOou3cFqROO/ft70xsfDoPUmo7cit9R1LegLAgMpRCcrOrPCWn/W4JTnu348GwiiMDQTq+seeAW3ULj7Qb2293woOyxGta2g1bGyXQdxvpKGP7x6+5Q+z841dirXFHm2OXJar/D4LF/mVlzR7dZl3SJ0mima/JnPlmZ616JgflkJg4bCGsGGJkIFFDIJOtZzghWElqdRXaySf3noO+LLAxn0rUgxHIEmq+XyeQb+TTosPcjouyhtpCVeZ+x3tLi3ST2YjDMHY+kfR9hs5UECBouuq92mo+ZmXTnoRM5z7uPcdeyBNe9oZolS72EIVr1iW/nz1umJnd4+YcN0UFezDLv3n1rAqD3aT+QhyCSPuo+AUrn3QJvwmQz0oGH9sivRo1CDU5AePJjuPPI9TXiGcv2cbnSs7K+fZ+jW7qwouD+AsLjhQaILRZs615MitsZMSV9B8FU3F8ohB9qlLbkgPbEpoqNPpFjGKA8x/xnVDhRsBxV7qf7IAacweqV4TfZKaxIM3x4xkv7JnGbpfiri0tOp0TljooGMd5uARnikpyyrEVtu9KRLt/gIeosgLL+xvpwEI3hwECIREK2EHXf8XMJQWxR35Z0eejrEZVajI/IIO6psSdeFuT9xq/+aWtszXQj2S8iHBFcleZxAKQw8/j1Tci2n/ZEc8IlKSSlamGhklhT3Mo6bVuQLTxkQ9DxW30vvMiwe5ycKLcV31gOLk1oyv9ilNUQQ8DHBPEXeZk+P9q3mbT2M7NO3HaIJALGJtEE44B9RwdQ8MGzT9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sEVLUGATHwEew7+UCpbmjdZgtgjC5xDzfJvWyGSjE7V+3wp45Mjc9ynQY/0nTyBLtNv6Th2L+iXogSuymHWnuwF8C6vbcmhj1d54B+7CKXSFeQRzIZsWOvIdsZqjcqB7faiNbHYF9eXxIlLIWLx82A0Lhi47qsgy0K9QJ1zBhwzW4y52YJAK68YyzLCS8CrRi8ok1hCRP614KqJJDAlQ9Jvub4ZVRGXbmTIKWecId8IT48DBzcWcRIlIxGANWLJrWOo6xpwDIP7gsRWssZoK247yZaDaYvtGZHNSNG5RzyU14v8rMtkd8SqupmsHZqd3QvG2sjKftb5fi2QWHraM0ERoRSyTy3bZnPm0U8SQgG803eZROa6fZIXOv5zZ/BdcqPJ1RvEvxKu+VbaEGrNhzGVdvMWEowyAM7AigZ/gM+zVTWH7klcwsmePo+v4aItD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:02:04.4293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f39bb28a-74fe-4e4d-9442-08de8489f850
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9825
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
switch to well tested sequence.

Reviewed-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c b/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c
index 3685080ce9dc..96290538a889 100644
--- a/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c
@@ -176,11 +176,12 @@ void pg_cntl42_hubp_dpp_pg_control(struct pg_cntl *pg_cntl, unsigned int hubp_dp
 	uint32_t pwr_status = power_on ? 0 : 2;
 	uint32_t org_ip_request_cntl;
 	bool block_enabled;
+	bool skip_pg = pg_cntl->ctx->dc->debug.ignore_pg ||
+		       pg_cntl->ctx->dc->debug.disable_hubp_power_gate ||
+		       pg_cntl->ctx->dc->debug.disable_dpp_power_gate ||
+		       pg_cntl->ctx->dc->idle_optimizations_allowed;
 
-	if (pg_cntl->ctx->dc->debug.ignore_pg ||
-		pg_cntl->ctx->dc->debug.disable_hubp_power_gate ||
-		pg_cntl->ctx->dc->debug.disable_dpp_power_gate ||
-		pg_cntl->ctx->dc->idle_optimizations_allowed)
+	if (skip_pg && !power_on)
 		return;
 
 	block_enabled = pg_cntl42_hubp_dpp_pg_status(pg_cntl, hubp_dpp_inst);
-- 
2.43.0

