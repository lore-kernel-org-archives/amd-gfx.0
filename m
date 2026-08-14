Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BB8C5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 06:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4F2D10E0DA;
	Fri, 14 Aug 2026 06:53:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v8ihhDdO";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010016.outbound.protection.outlook.com
 [40.93.198.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DDFB10E0DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 06:53:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIiqvwMdigrKayGVTHKcI3z2tzhXpQ/xUaqMGAoXAx2H4+LmfrEzO+YZDOiccLut/taCZmaygxoocfeDm6EziCbp2bUrtLSr3Cj2hcL8opB70ontpmmwj6hMdsHNlBr6VWKLCVlwDQA83XYmrwYFULFrBi4xg9bvB+GFQPCAL9y4b/46Dsz+bjSfo2mk+SKfsXtvZTVSU7FwIz5mI93d7d/Grjs/O3UOMwqSi/HW5hQiS5iwqIQZw+flJOAQdStMjoJwOzkItBmYf9AvsHk/QYD/pNW7a1MbYo/ToNMIxQ4sV+xugByrXslEz5TU+TkrD4ph9Eo8Rf+gZEVzihp4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlW2vpRs6iEEIEvEbHLHjdgbA2KKA/VTh+SWLD2cPHg=;
 b=s3yxLTi78GEFyWRfzxevFWEmy7pAg/6FK+WLDi71fX/pNW1grj2jKCvCz5wczMpVLcVQD/vpqpSpq1C7yhN/zwFbcXuMPSUKD06WMCIamusWBmJI+2RizeO8SY5RL0esSlLCowsmmPnC1vRzUJ8nPe5zMh9l8EEfjN+isRx7/neJ48PebSf1UvutecXzfPM0K11W3tcCwhK5uUvDxZpQDWIgIoEvnrK9hrcq8Nh8meomslyYb7XlGuuBhHbemQzv1RqjLfMqR2L+bS6bZ+34FUowfdFwHriWxLpyYeTbwl2s+gVf98hu/5y4Oq6uHJ+RyFM4JG3G1RyDCFaamLP3ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlW2vpRs6iEEIEvEbHLHjdgbA2KKA/VTh+SWLD2cPHg=;
 b=v8ihhDdOlpBCz0XTJ3noHG0U8PjbH0qv7dkXyvL67Su3zwzs0kTr0qPDhevGey81t5khnfHRNUkonLARp3ZhAcKTjErEdk4MJ7GHUC23VchJHvFxINw3IXJEPToM5rHpZ2T/1c/PNEh2utAWhL3mU5XZvx8Ujk46jkPIyBoiCaY=
Received: from PH0PR07CA0083.namprd07.prod.outlook.com (2603:10b6:510:f::28)
 by SA1PR12MB8096.namprd12.prod.outlook.com (2603:10b6:806:326::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 06:53:32 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:510:f:cafe::5d) by PH0PR07CA0083.outlook.office365.com
 (2603:10b6:510:f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 06:53:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 06:53:31 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 01:53:29 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH] amdkfd: let profile_lock_device return an int other than
 uint32
Date: Fri, 14 Aug 2026 14:53:33 +0800
Message-ID: <20260814065333.88615-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|SA1PR12MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: 307ed950-3711-4e4d-da87-08def9d0c0c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: wiNygGiqRCpq9AMxfZLqM7zpBfL0tzQ5VT6UqttsOLemtMS79dIR+us3N5FXaOHAPpgFggPubUSMu2PFzDGKQDTh7xd3Ow1mMkGNVuL4dCLXVL55nqF1DrwjuioKNfpPkb+3Be4PASq87OCWdSR+zYjbLUVdbkLVf7kbX78oTRRMJcp4Ta64S9gsasSAegTrbFA0Arig+ReHwKjxT/BZiWJfdosALu5PXJo7NYTfUQWA7kngywFMM9xeY1t9lEKTodEHzEChXfQDW5cuk55zEEo1qf7Smo79KMx8vufcDxERvulBmXCtQ+6VCZT5XUgofY9631Q1roQSJLTegQzjFbJ6btkYNy+Qc5rhteo62y8Z3mQeg4fh6B6rdWPfGLdka5moJAgCas2YcY7L8nY7ki1mhIIHa6em+tBGS17heCwb/KkAbPwJxT3uIJcElviOLsrGBMpce3lLtlqJ0sfvMrakoD9r+iLueZ1i1XrxcOBqmippPDSIZ62h2CezTDHi8yYzNU6Up8qm9k7tAZH1RNxAyNZ6IBiLRgGoC4uVhfIqdoIQSsuK3m0Bj5tLEDbKKKus2QkblXL1qHT5tZKqJEq9GQHdcRMsdwKcMKT8nMCDXOKuC3FBmJGtPCyt7f/zaJj3+D2eo7L+xnZMf5Wn9h/J3m6fc8VkxQSO17NZk17uJff00zoeo0a5K+R3JVm5ewj031MXHFs9jO6YlA1EGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gt/Tv4oQn/JAs6Yk/OrVbw33oseq96/+UXrRSW9fsmOAurOgpeOy1PGFd9seTwR8UESVj0J1DkHzhciazNvlEuwd6/qqUPB3oXdERL1MQ+YIcb5LRrIp0cniiVbz8fdJcimMddhFHk+pCPLTv6BWY4pHBE0uQpLErhr9AT2obSNoL2hrex6NPtA5ipNhD5sCOiv7xI4lftwshcjXxC4vjMGJ/cLau474FYuVP2Exb8p/K9bQZvNtqk8Fz64ygjc1cZQ6ebnXy3on9WeaN68a6RTeJ+HO1jkHz09avn1svW4GMh8c59IL7QyETo9cqLO37u0S2UAnqHlE8pNiMPiKnW7pbtl+MXlhnf7097Zz5RqBA39sdBDxDBPOs0LkNpI5SI5wsLHZIJXkGjwd1GYBfmW69GR+9yxdDt8R3xCol/aCQQ+VVw2ioCsQQmV3o+rT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 06:53:31.5095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 307ed950-3711-4e4d-da87-08def9d0c0c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8096
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

profile_lock_device() may return negive error code,
so the type of the return value should be int,
not uint32

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 309510e23315..6fd18488d5cf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3329,7 +3329,7 @@ static int kfd_ioctl_create_process(struct file *filep, struct kfd_process *p, v
 	return 0;
 }
 
-static inline uint32_t profile_lock_device(struct kfd_process *p,
+static inline int profile_lock_device(struct kfd_process *p,
 					   uint32_t gpu_id, uint32_t op)
 {
 	struct kfd_process_device *pdd;
-- 
2.53.0

