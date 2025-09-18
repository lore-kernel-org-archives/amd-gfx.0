Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102E7CAC59A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 01:33:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4FF310E602;
	Thu, 18 Sep 2025 01:33:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T805GV1c";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011049.outbound.protection.outlook.com [52.101.62.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3FFB10E5FB
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 01:33:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mnhf1at2Tgv8QKRkCKD0mQnt5kwk2ZgsuwZFGcT8KuldZVGntlKkBlSISb1h1lGqwfiv80tSadSoKnVlhk52SXqDsDZ+scECptPNTOFPdYogOo4Msd/00MmXmCSwGMsA/GqgilfCsnacXS0kgIBG8ZA//EqvkYSdBfdT+2Dq71QM7oE+vjYhp88UGStbtg7IL8YDXI8U6J7rA5/UyVhu/T1bby4l9nX6QtNerBikEi/3gV/88AsrJ7uTloevLcfFaED3ACHz1ZZ6pq8CV3wc27nbOLVaU6e7AKncd96dHt3SOJ3fRkepIjzUCHvfd1vgME0MOXqv6432qHFl3zVwtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awfDJkBv4BEhCdPVuqJW9963+5ykpZgzusN7cQpa8+I=;
 b=uhiay0Nx3WlE/jXDJfjldNjAOoSN0b9tekWuD9RpZh19tmT0r4WR18y41B/BsH2W3LLPzM+6kN7kxUhWix0qTrp+vmjIAzpT6zNrqFqgG2GwjTjwHG+oZb6kwV8JJv2On2vdWb2qFoCgLuVW0L34Fn3PbScwujDdWFJJ0egy8hH+XxKkFc7MZyhasUnHFSZHjnr7a1yvKJr5JKAUoRj4b6Kw/G+7TEkfGTnZuRScjqxmTJbJ8YNmemWsV4rc0ZG8WTrVa1dYLEoQRrk/SUD8xX695sNqzlx22zWaNkAzp6vxIePGYrNCZpc/B26jfzj8ikoBAWDBwWwwFh/SfY+Zbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awfDJkBv4BEhCdPVuqJW9963+5ykpZgzusN7cQpa8+I=;
 b=T805GV1cUJmNCsHdMAhfAWGWKhcLTgxBugVSpM3Exrx8zoYTBN4TVn8WSZPBv4Fe7ri3wm7wVjCVbmDlBu4tAPTNmyKK5r83dh/w7oCbSP9zkwzrKPrhp/T/55+O/wJYaVHt0k9KwGb6eOeXA5mT0nN+GLP+xM1E89v2yBeGJPA=
Received: from MW2PR2101CA0023.namprd21.prod.outlook.com (2603:10b6:302:1::36)
 by BN7PPFD6BF22047.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Thu, 18 Sep
 2025 01:33:51 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::7b) by MW2PR2101CA0023.outlook.office365.com
 (2603:10b6:302:1::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.3 via Frontend Transport; Thu,
 18 Sep 2025 01:33:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 01:33:50 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 18:33:48 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH 21/21] drm/amd/ras: Add files to ras core Makefile
Date: Thu, 18 Sep 2025 09:32:32 +0800
Message-ID: <20250918013232.2629215-21-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918013232.2629215-1-YiPeng.Chai@amd.com>
References: <20250918013232.2629215-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|BN7PPFD6BF22047:EE_
X-MS-Office365-Filtering-Correlation-Id: 71d7e764-41d1-41ce-9b10-08ddf6536bd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W8UUmCpxbWK7BWrXrtgTIkv3qi7owkRTOEznWhYz7R1YYm4eB6Oi8II1Fbda?=
 =?us-ascii?Q?Hz3Yverl3E6/yjWHiC8NvUgBXnNBbinNTJ+TAvZArn9mlvuwvO6DwQyKFTqx?=
 =?us-ascii?Q?ID8rpXhYibpTlVbyQXeir57yu5WjsiY0dh067Ubq+P9ZZ4dO8h1Xg0XbZXTl?=
 =?us-ascii?Q?lxzgSXicQtvup1ZtNPRIKhA4DYNuswButvXjVdwuimx8U99cw96ApBZXD7T7?=
 =?us-ascii?Q?HTuIWWTfjyt39FaU5XvHwtfu+B2gz11goUYDjFG54APzqGpQKebmMhbjOwEW?=
 =?us-ascii?Q?PFWktVYvdzOPe0noGPN1sFOfXovIQ6qCio7TOz+haVG6AJV58JbdAq1ioPr7?=
 =?us-ascii?Q?lOhPYl4ZJwuh6+5Mky/teK/XA2j+KWDeq0oknDyq3aXhwMuSV8famNi+naaC?=
 =?us-ascii?Q?yRKvXrU40VrDM4LXO13PyLbF2yWXn8beZ2peuEb/VGilpJoPOnleZ9rVK9Sh?=
 =?us-ascii?Q?9LjcUlKY/V3DnjcdZPechCsOGbCK5qr+HaPgB+PdUrdHdJXIc3gQYWmgylzI?=
 =?us-ascii?Q?IIOKY8SD01svUutCIprc8X7oYJ/o8lLGIphNMvNsRtG1Wq4tRlvMUKXpT0JG?=
 =?us-ascii?Q?EFWqWDJf/ApkqnYQuzNiF23EQNlJ2bR+0dzsPL2TROKlcBd/kTR976KQdZmu?=
 =?us-ascii?Q?z1gzGbSsDtu5ZHydkUaunzMjtyMXZ5n/R0Gsp8ImiuBCcUsQQNNCWdP8McYf?=
 =?us-ascii?Q?FHcrGqSuVSEYHq0Vd8JK0bvneUbBr4U1II6EZA6YKkRf2rU4Sv1Hx0EIAv7q?=
 =?us-ascii?Q?a2/wonI13B+Y1bqzdIHvPaXZmtbmcUUgaWDjtWVceUjVe54KjFwYHmJ5+5/9?=
 =?us-ascii?Q?5spmET13TUOxeiZ6lYPsOP4hZTsnHBpNNb6rSWnp1yYv3UqjwNSOG2ZWxjZd?=
 =?us-ascii?Q?5maE/S/Z6ne8tqS/virbbnS3FVJCqMf7vD7o4fOZYLYuzwMZXyZIHe/CamOl?=
 =?us-ascii?Q?qYWgDT3TDwlvwSF+ioKV89Ota+RMgUZkzyL0A2vvdq4zKrCExpc4bf7NDvBX?=
 =?us-ascii?Q?3IhI91pVrC1ek+z6gT3MfqtIJsDe4y5zF3B4xskTDsv3v6g43aQPcZUCzGr7?=
 =?us-ascii?Q?yvRnfAweGsEJAnz/2U5HBXoFr5ZDXM2cFGeueP7W3qamGPrMPYrX3p7/1W/1?=
 =?us-ascii?Q?4U/v7kRlUxEmg4jwQNB2CFJcVD3QS+Ym4bD3xAxU6Ifp+0q4vmyc737lBxjY?=
 =?us-ascii?Q?ru80gAZYveiSZKPTXNFLbJzRlTQt7xmQaM01v14YyL/4TfXZkFc3gC7PdsSx?=
 =?us-ascii?Q?nD2LWa8+cimx1RkagemdG9TOHjmp3TdjoOt1DVsPvqoM/LruIKlrxN43DJgS?=
 =?us-ascii?Q?fYTgELvYJ2xEcuPcp3Gh0yp74i12nz+v7+yHwtxOwIcS+PSiWLM2S7T0PYKy?=
 =?us-ascii?Q?NA4uiieUZep6FLXj0t3ZJV08296rdiU02gCPkiuGi1vKA9MQYh+35Jchc0z1?=
 =?us-ascii?Q?XhDGguZqu0H1pc/CPxnvlbWD/OQFC1V/pqEyp/S625HXuC2TUleW646GyY2a?=
 =?us-ascii?Q?wNIVM3kShN/RYjgqE1sxu7CodHwoNiu0K88l?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 01:33:50.7024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d7e764-41d1-41ce-9b10-08ddf6536bd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFD6BF22047
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

Add files to ras core Makefile.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/Makefile | 44 ++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/rascore/Makefile b/drivers/gpu/drm/amd/ras/rascore/Makefile
index e69de29bb2d1..e826a1f86424 100644
--- a/drivers/gpu/drm/amd/ras/rascore/Makefile
+++ b/drivers/gpu/drm/amd/ras/rascore/Makefile
@@ -0,0 +1,44 @@
+#
+# Copyright 2025 Advanced Micro Devices, Inc.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+# OTHER DEALINGS IN THE SOFTWARE.
+#
+RAS_CORE_FILES = ras_core.o \
+			ras_mp1.o \
+			ras_mp1_v13_0.o \
+			ras_aca.o  \
+			ras_aca_v1_0.o \
+			ras_eeprom.o \
+			ras_umc.o \
+			ras_umc_v12_0.o \
+			ras_cmd.o \
+			ras_gfx.o \
+			ras_gfx_v9_0.o \
+			ras_process.o \
+			ras_nbio.o \
+			ras_nbio_v7_9.o \
+			ras_log_ring.o \
+			ras_cper.o \
+			ras_psp.o \
+			ras_psp_v13_0.o
+
+
+RAS_CORE = $(addprefix $(AMD_GPU_RAS_PATH)/rascore/,$(RAS_CORE_FILES))
+
+AMD_GPU_RAS_FILES += $(RAS_CORE)
-- 
2.34.1

