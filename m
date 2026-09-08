Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18C5C79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:42:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E9DC10EB6F;
	Tue,  8 Sep 2026 11:42:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ylu2ziWA";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013042.outbound.protection.outlook.com
 [40.93.196.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 255F010EB6F
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:42:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHvoBRijKHMju+qlooMcoYthy4fmsq+f7edDiCyb3UYAYK3YK4ErQQTII6n+GBCNKUNouQf63JIfW7IzKt6BoH8gCbGmNM36pRAPpzs30BXqvxdgTciX3Q9Y8ofkiJ5s28DivVLLKpKvKLLYuu7DpTNOh9qOdjyZX2bueReq39WSsK2UQWFswgCJZNWczGYe5N31eA76/g7VWOBSMbsXYujE8i+VhN6kpgWYF4AEbXN+T3Yh9ivwqU/Caqi7cbUf2F6WaeJWNFCViQC1H2W6cB+TE+vBiTe+VAXK8tZw30Y5i5LD9KEa/qWGMmOlhg0THhbfX7VAEplxYmBjgdtJ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1P0sqLQYMSIskhiRcRhqt70MaEuuY5lYzdZYmjSIe0=;
 b=fR9+ZuifM1u74Up9bX7zO2BItSrvR+QitWZDiTrea27ccjDbaMs+r82qkasxPWQSq5GehlCCXUWdNNWqu66ms0GUZqGvM8Sh4sxDfs3aLl5+xwVoEqmVkzN1ogvTgD1wYnxn1Esob6V3QC4xKDAViUakOf6RB6tWhnje69a9aSqOHUk8Mmh2U2fIztNPeYKa+85QP0WftpOObNRD8W+lA3OAMEL79YyWhGQCA/UuyqKaAdxIb6FWshRglrn/FNKWXR+lseTC8ZJLOYLViTI5nyGT/hn2J1GuZPXb6bvciTqRq6T+1juTPuooSPDev+OqsphTDpz/vTwQjzuAZZIP0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1P0sqLQYMSIskhiRcRhqt70MaEuuY5lYzdZYmjSIe0=;
 b=Ylu2ziWAZEYGQpRKjyZnvabNotwVMBfjApnSFGR8nB8zaGzFXtbd34/t9v5RLpL3faYDZkXWej+vFsqygJxNaBL7LBbq7B1M+T1Dh1M7940W4995a4rS70qlcS0IKtDOhLhuUKf6tpVhqtAA4OeLpWmnXoLalKDCeX96iuaYQJg=
Received: from BL1PR13CA0441.namprd13.prod.outlook.com (2603:10b6:208:2c3::26)
 by DM4PR12MB7624.namprd12.prod.outlook.com (2603:10b6:8:107::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 11:42:42 +0000
Received: from BN7PEPF0000009C.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::70) by BL1PR13CA0441.outlook.office365.com
 (2603:10b6:208:2c3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 11:42:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF0000009C.mail.protection.outlook.com (10.167.248.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:42:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:42:29 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:42:28 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:42:20 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 55/66] drm/amd/display: Add SPDX license identifier to
 dcn30_dpp_cm.c
Date: Tue, 8 Sep 2026 19:31:48 +0800
Message-ID: <20260908113338.2433445-56-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009C:EE_|DM4PR12MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb7dc58-bab8-4d29-c046-08df0d9e4ac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: n8IM0pqznu6AQv1cYmzG5y+bVk9JKzi8O6+Pd295xUasSzfSVbY32jg6Jiz3G39JQwLguKxUm+rnYS99WMTL2/KwlOkM60bhkOz9g8FcB/QE9nSh+6K1acwNnfrdH4s4fDz5YNLVWT1eXYzKuzgcLCDFKgAyAdcudolaUakjq6Qxu3RIP6uQPF2/hbXmiCF3RSqdR3weX+PGPU+n29G8HWP174ipLVdiF2pPzj9cuC10iJLHuZiVJr18YptXBLw+loSRt9sLDf4G5o7wEhVqO0t3A7aMZ1mz5zavOf2uMxa1b3In4Fyp726qAgM82I273Px0+yeBz7LCoyrL6mksk4dyj+vPMU0JoFMTb5Dxa+eFqnAEWQG1Cvc+GJLjf43mQdht/M+YDtzkY8qgAfnYNJ0wcdtugI/SDCrBXYUOYZ8TStDgRbU/JimSrsfCsuNPVoztgei4UGBcAGA9ot4xABqX4fMwX5oSOIz4Ru/HsT8LSm4wKx38uGrJ3QoAf8xVg3Rfl6kdDgslBWm587KU1HlIlL2bet2hjJbcPmpU96TZaM0hDb1ncx83umOYKFXK59Pdo+LtZZZFSe3AhjfjwNH9El822kI/VWioo6Tg69IUQ8upMUQ0rW+XYsgZcJ8PNdMKkO1qkghsBpSJy5fNJ9c3Ak0VlfVdDglpEI0Y/eDEAxZJJC87a44svSsVcqxBzzuNsqLoDmMb6RPfIm2efQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Mwoj24y7v85pENFKxmyL7/MJa7h6GyuNO86bWBIVqs9bIIfvihvb+zn69bRB+Il4XK7SI1VGkJC0NnQMQR73xKPGFfp8GmViqRQIQVvbtqe4xFMv/BWeu1UErbF55PBmo80Ipcfy099O2VEtdrihDvuE2pY7nTq2m8VGUBbSjEEBBezu88tGH64Fx9TR1j0AmpJCio8/dX/bgNK93ZkYaeuLTyylg0gcgy7LCq/Mq3x3FZuRsZXNcTI8Bckq7NQzepz2MTuNDi6iVrYZBRCZhsQ0JqAXnP/iqA+oBxoEcA9n+SJRoE6HkPbvdpxPmpTHL10slImiUYGpEPYzA+2puYP7lVmGAj928+0s46huHQ3mO+eNoHHjPAZjpyHboXHdUpz1ay8d7VXIMxz730p1wf3QDb5co3cjt7xrExnV7BhsxscVIqrDhb+ofjDOdZOK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:42:41.9600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb7dc58-bab8-4d29-c046-08df0d9e4ac0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF0000009C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7624
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

From: Tony Cheng <Tony.Cheng@amd.com>

[Why&How]
dcn30_dpp_cm.c carries the full MIT license text but no SPDX tag. Add
the SPDX-License-Identifier line so the file matches the rest of the
tree.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <Tony.Cheng@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c
index 8fe3474411b7..083ab6acb687 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c
@@ -1,6 +1,8 @@
 /*
  * Copyright 2020 Advanced Micro Devices, Inc.
  *
+ * SPDX-License-Identifier: MIT
+ *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
  * to deal in the Software without restriction, including without limitation
-- 
2.43.0

