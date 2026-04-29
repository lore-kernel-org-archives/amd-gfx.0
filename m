Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3A7FF885A
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 01:52:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 775C410E3A1;
	Wed, 29 Apr 2026 01:52:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XrRS+sSz";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011068.outbound.protection.outlook.com [52.101.52.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33C9C10E39E
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 01:52:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3QXCpTC47PyA9I860WBOGgG7haQLTAj4OYfTzyR2ZLkUIoeU6PgSQhhIlzyQzFAAgHr5Zts/gBieSb14ahkj1tmrFT7ct7GaoRO+fdBbhF+ZO7g43uXB89e4GAUo7HVom4QFTqT61QzqDi89qf4ZNAMtXWKh8ivmU5R2WBEip2b7MF+74JW+3avFzeM2iKvVTeBs9SGtZqT+FZ6YrxAPVXlRB+KGOcra4+Kgu8TVP0lRSPFwna6SB/M7n7U+T5KwpMGxOlRgZpPPrt8z4D7tKEUq4cmUMOdR9Ns4iRZ9UQHpnM4ffDFqhjQTu/SlrTVmSMuB0VwbKxGXX5Pe2EHJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmuMv2RkmI6LzFnertm7Mo84CWk/v5k69GfIQvTUyfY=;
 b=ESvo9m7qMm7ACgUNcxM98KHoj6IdHhdANVL9Ys5OeIu4zaSfS2mJv4czJ3AFRIIW+5E9YMAPZSf3xBKVqcJ0l4LumIvQUJ0EHXIYLTvRvGkFXzcvntYH+9Vos0CllYNii/4nbq93Dud+0//ayeS7QUh7pUMe3FN/o58Xo/DMXYcPdDT59dUPIO3SAhrqYIzQMngbM3WiVM7o01OgsIxcMrr2eeJLzbRggA10pPbj11stN5hpzc1hlJWoqNxIoaC8igDl3HxXfPrtOm8pUNDvtBxdkLrk75+b4JtC7jWN1jBlx3oDUT0mg8dRXzNzXaNPAa8B+T1Mo63t5Q5895ISlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmuMv2RkmI6LzFnertm7Mo84CWk/v5k69GfIQvTUyfY=;
 b=XrRS+sSzqhbVzg95Sq41IXO9n1OsnvOXSrqOirtAubDT4xgihXmaFlTQ96tuGT3rquE0VmFuhHqeKOhr0S3PvghG/XdUWovetT2Jz3UYXrpUnrfIjT/nocRZuB4LtOKq7BZBvtdTZ4wXhnCU8SDutM3Td0WVyEz8cFV/PI5AnzE=
Received: from SJ0PR03CA0173.namprd03.prod.outlook.com (2603:10b6:a03:338::28)
 by DS0PR12MB7851.namprd12.prod.outlook.com (2603:10b6:8:14a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 01:52:47 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::9) by SJ0PR03CA0173.outlook.office365.com
 (2603:10b6:a03:338::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Wed,
 29 Apr 2026 01:52:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 01:52:46 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 20:52:46 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 20:52:45 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Tue, 28 Apr 2026 20:52:37 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, "Zheng, Austin" <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 06/17] drm/amd/display: Clean Up Legacy DML Content
Date: Wed, 29 Apr 2026 09:19:15 +0800
Message-ID: <20260429012055.2065869-7-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429012055.2065869-1-PingLei.Lin@amd.com>
References: <20260429012055.2065869-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|DS0PR12MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a9b45d3-a12d-4f2f-ca9a-08dea5920309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1FMHdN3BqXQvrsJunKbNaWzLRO/Ki7Lj5b+8lOQ17TSkggfGD42/nwI/KIJmGHp+AJCnDjekH5RQcnhXHjM1ShXTeAkQvhgrMGpTJZ4GJtvqKtD4XkLVuctS9RSEUWvtFKr5afFHYDHU8kE6eYlq8rqt5YNcsx1yxeZUtFG0Pzg8ENUmAuP87/JFKjlHo7mFnob64rbYBak2uY+rAmdtOE1JkfaAjkUQ6y4KO/h2j6OotsR8ZkV0Sr/LtocukD/zxgNDVUqW1EbXFHSPi6YvxLjDZCgkkpvLgi5Nyn3FD3gszPSQ26HCUKqJRrTNpSwAkgNlHq4kjtchXtrajyfNyxMaHXKxk0qK0J6ZaGZMv9V1aCHFStRWP+irDqolNpoHX2ZKtK4sWeWgZwmlVTbAMhvBHAZ/thR+Uw31tv3PDGYumOYqHOGBadg+AzNrm3CYkRzh3VWP3+9OezCLkMzEPfTHWc7cIfx/nSeJLVL1GhwEj9EDhpjebiRd9iAxXGSWQTVhaIanlTSXAiEWZ4EQ2cbXzDDkmt1EGpdzq6UYy+F+RHmt85AT+vLcDVTR4raHwWK92SYLGggzeOXgbNKxxf3g4ak1RF7yXXM09ByI4KJN5SYIZCdfRN229frZnWwZ3b6gO+AzKppgjIxpjFGt1r4Mk2v42Kod8n1/ggN2XgBmRd27QAC3cDDn5YhxRsydt+4jMo3SY5ShXG64t/IxomqM2+6Emz9UFdrTGsPop3YUyVZH//byZaQeZuoHPAAvTalV4SVmYyxHmNdMwNxgSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MXaS0BUjmAV82gWBcRkRJyjxX+cdX8wYx+cpjET3ZLCYZgzNN215t0kvxsLXBRi+qrDzEukTHlP1P08TKch6/gr6KdBHPojuJ/trCvxio/0MVs8ASpiZzLm2baW/fVHYPy9oPz8clj5ug5wOts7gtnwsyFZiXnrySdHgD2H1nZoDXcL8hV63DtdyMv2fDxooIDOZTfTHRuBBrcNjHWX6wdM31709JCk9n9d94I+eFEcvvP/XirpQ2bPVFPVbZ5N+AMxWLegZ939ySpkGhx7wdnO9SbMGeabxxCdMxm1b1GXiIa44Kv4qxKixULiEevRj3Vbt0oOIE/WCNWFypC2/WG4LMQs4KL5AUNQxRjl1u4grHKSnqOfxRt+u+Mo8gWSZKZ5NuF+/P33xggmLz3uCD5oNfZ+VNImW5YuP0QISr/Z6dWBEI9N8OoTceLFx8cFs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 01:52:46.6593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9b45d3-a12d-4f2f-ca9a-08dea5920309
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7851
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

From: "Zheng, Austin" <Austin.Zheng@amd.com>

[Why & How]
Legacy files were used for the transition period between DML1 and DML2.
Fully transitioned away from DML1 so these legacy files can be removed
since they are not actively being used.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Zheng Austin <Austin.Zheng@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../dc/dml2_0/dml21/src/dml2_top/dml2_top_legacy.h       | 9 ---------
 1 file changed, 9 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_legacy.h

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_legacy.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_legacy.h
deleted file mode 100644
index 14d0ae03dce6..000000000000
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_legacy.h
+++ /dev/null
@@ -1,9 +0,0 @@
-// SPDX-License-Identifier: MIT
-//
-// Copyright 2024 Advanced Micro Devices, Inc.
-
-#ifndef __DML2_TOP_LEGACY_H__
-#define __DML2_TOP_LEGACY_H__
-#include "dml2_internal_shared_types.h"
-bool dml2_top_legacy_initialize_instance(struct dml2_initialize_instance_in_out *in_out);
-#endif /* __DML2_TOP_LEGACY_H__ */
-- 
2.43.0

