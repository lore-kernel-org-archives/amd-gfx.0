Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F32C5DF81
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2026 15:01:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02AA910E568;
	Wed, 19 Aug 2026 15:01:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XiSaWWJI";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010038.outbound.protection.outlook.com
 [52.101.193.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEED910E568
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 15:01:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdMp0+/7kVoiDviHCISVyu0Y8FwFnmWkFzHuKPnpCUp2Kwc/MvtvIQcMQTYI2xjG6/ykma13AOy9APnofzD4Jxzca0mig+Wkh6KdU7SACjD2JA/RRLibMNZRgjMO+YX0o2/kJRkfIWoXbekHlI4vHNl3mDi7zjlqciLcG5PisT/KuuFNjX7m62kqeKMXe8Q7CB7qzfFZWDepgxD7Hc/djvApV1kkyQ8nY8ykkypx05kYgAuHjkBN8G2ibOuf92ZaRycy6c3qpENTYT+M9pbbQXpdt/TLmBjwYHyyM5pL7HECxiwxzNK63bX5lH7b8dZLqwRt/+4+3pfe2BEZgL1hzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bp2m7sH6dlOCYoNO27RDCxKhEyPHPxn3kkjP+yvWQto=;
 b=LT9HuqDzD/UpYGdEwyikQCTgCHUSMsLdRoPCmnP3IZGXWOPxsuXCP1uEsytaYDIYRFAMWCH3G4tZ6jeAs2Z6Ugtlw8O8eYGCZFgi0Ub/MHlVggYfgnfjrsd3Ryr8o/R9iS8pT2plAOpiiyrg3XCQKr5gyrGtuc1z2xEa0aunDegn/qpWPT2zUxhl6VuZ5FsOnPA1c/WdLAQOWLkt8fvMfI9QPI12hsvxAs6MkuHt75b3WD0n3CExPntTj4YaPXMrZC0SdhFnB2G9e66QixKfIWrY2D6Dv2ovQuAq2k74+rnThLEP8neRjsVC9UzlkX9t2Rvsc0N3M0+iWV9dfXR2nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bp2m7sH6dlOCYoNO27RDCxKhEyPHPxn3kkjP+yvWQto=;
 b=XiSaWWJI/QU4W2iExIzTbpvwIeWbzgzZhjymmZqGogKFLexGDbNB0TNmTAt7GdCT2YWnI45qXXUC9fJyE6iOqsSoyl515OUq80+pWyKiXc7TE1n005x0mEUoeH3MatkPFNu2Fs7IfQBGtKyuDsujmnWCxm3qYHnJvQ2DxJOXZSk=
Received: from CY5PR18CA0034.namprd18.prod.outlook.com (2603:10b6:930:13::7)
 by MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 15:01:46 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:13:cafe::94) by CY5PR18CA0034.outlook.office365.com
 (2603:10b6:930:13::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Wed, 19
 Aug 2026 15:01:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 15:01:44 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 10:01:43 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 10:01:40 -0500
Received: from tony-dev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 19 Aug 2026 10:01:40 -0500
From: <Haoming.Qi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alexander Deucher
 <Alexander.Deucher@amd.com>
CC: Ivan Lipski <ivan.lipski@amd.com>, Thomas Chai <YiPeng.Chai@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Tony Qi <Haoming.Qi@amd.com>
Subject: [PATCH] drm/amd/ras: Remove unguarded asm/mce.h include
Date: Wed, 19 Aug 2026 11:01:34 -0400
Message-ID: <20260819150134.2115118-1-Haoming.Qi@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|MN2PR12MB4128:EE_
X-MS-Office365-Filtering-Correlation-Id: 38933683-2d57-43d0-b153-08defe02c8cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: O4p+f7TO187gWX4RW3a18If2GknvxWl8Ipg4QishNeiWhCku2zeHi7IT3j1BdQWM1SxhhjMAVxmocH1xK4X5Oj03fTWaC0Evh2cwgmLP4jlKwNyna+zu6UhpUdJ7DD8m71MHOjZCG7QOZrhM81Ozm6EnNaoBi6BIOVeC+D5rCGoT5m1AbDd5NUkpXHPN2uGxNx3zT2STiT3LklPmweW3za3iDLAK+QcMCHqKv0IzpGDq6F6LKuceRM/9tRA218GEDfkFv5MIDDhrRBItZnPDwV+ClcdB+nLaGIQdWpvannw9ngrhYuvaY8H8EfBPwrOnIiUvHXM6lRwRjw9DGDDEyiUw33reYaBB+BEv/cLR6X+rqVF4ynoTss4wmjqpptmeVW7bwbxZQFtwlgNLGWTjl7mbhWjYX1s7tfUJf700iWqg7BIwqjkBOWB2i3zHX20D7VK3w+XAjWD28RqmN/rrBa5MIXQyAw5g8KwAOZj/dkfVqP/jplXn2g21JJEfw7ZuHIzo85kYldOfoCz6Njoid2jYvhdVCxtG05xRiQh6frgYv9TjHICwoJB+6I+MIrmsdau8jY0KTjgux0buwxssZa6Jsq9exIt0QZChHjYzwCkewJn2rhMD7Qm+E4Kbo1zPvWv4NwZrfHYDHwrdMolahDEGrink14WLyHjnL2saYIjt6d2TUl6grVG0EWEXXeY0qFj40F3WD0a1rlIPWXT7tg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LEfeTGaqPqYKol4X5m+h7zo0Ml4oCzx5mnRK/zKgvHDi1g31iOCGDLuJzSfQAVo8FOXqNndIX7NhwyiTIgOtJ1Jei9hJUNneBbr1SHeFMN5d0X29kel794z8Vff5s8toc+ubXx2BpQbLFQEGaI/LJ/q9thCxpF89n4JefXcuB9fpQHqy6vC5rLRkh8oygrF1Wwb/gcZtq6D2p1cWkVfVeTNsE7sgqAlFtdfvozzHQZiQAUMBSxqF+9IfQAuJkOzf4oa5Y3yE8JtMnf02mumMxDcJX8e9LD7Ekj31T3IebE4vh2StesfMeqlX92DeyAZ/s8RnNX8i97ekrCwJPBk3YT/zO+9/EtcDYO3SHC562dVZWZCubXynxd6K4BRoe9GkRJIuzHoldpTIy/eAw9uNMABxbzhXi2X2EGfg9rnKG+CjhpoeY8U375XDZhPOcrkw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 15:01:44.4497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38933683-2d57-43d0-b153-08defe02c8cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128
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

From: Tony Qi <Haoming.Qi@amd.com>

asm/mce.h is x86-only, so the unconditional include broke non-x86
builds with "fatal error: asm/mce.h: No such file or directory". The
header is already included under CONFIG_X86_MCE_AMD with the code that
uses it, so remove the redundant unguarded copy.

Fixes: 1c46b6971260 ("drm/amd/ras: Isolate ras mce handler with CONFIG_X86_MCE_AMD")

Signed-off-by: Tony Qi <Haoming.Qi@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
index ad978ed45843..0edb3dc06a69 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
@@ -25,7 +25,6 @@
 #include "amdgpu.h"
 #include "amdgpu_ras_mgr.h"
 #include "amdgpu_ras_mce.h"
-#include <asm/mce.h>
 
 #ifdef CONFIG_X86_MCE_AMD
 #include <asm/mce.h>
-- 
2.43.0

