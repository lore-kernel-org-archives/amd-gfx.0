Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CABDCAC5A7
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Sep 2025 02:40:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 001E510E38D;
	Mon, 22 Sep 2025 02:40:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="11gRpxE4";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ADEA10E38D
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Sep 2025 02:40:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEXyHPOz+OoeRdULgqJqFuHEj3z39hv4s6iH5qj6fdpWucWBUYdcTmtaq3pIBEKTpBxJaIZF8qDakypC+92PMR+g608SvVWFY+rdqiWmQLocOtTRlK3LM9wrNvnoWtIfEsEHbtxczPdX6tMxvk7mvd/SNM3ix2hRXbhq2r8rmRTdMA8cY9qNz1cuWLiKFN1TQjCgRaHj4IxKPl8a7Juh3JUOMnizQ9JifZrjHt52aXKN1E+aZZ17XNEwia49SGrL2+NMREHu8v412/mu6Nj5QpcE9ezRA+B+ba9+CFNAeds81XbphoxCCRoCQb0nEbbfpRoLEkno3rhUFqqbpfDztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83oNflmrtq0rlbNICkRQUw/r+fliDL/puIQMabOEbcM=;
 b=DJNaNNhDFhdvM2TJgCVLyDtZJUEnL8CRy7PPktoSokmP7BzGwGoHhG7d5gueUc0O7Tml1kVihE1GdLJcP1bp8vlJGNq3kasppdfSR2FAUeNjtdHpUcSvHn0pYR5NaP1DdrEPx3c6UO+e5APwXtC5hSZG8iKjQ2ZCsAD0+Wy+XzC3oUdNP1oPNDbbHxr4v+pdFPSMLqZ+fUoH0+WXLTyKI8QNlUlzzq8KNYTnrnZUOuIwX3AsVOKDnyn3vkpc8eUuM+y+7tGhojBD8bkLfmu+6yLQOGGaMXtYWzjYC7idyL0Br8O70ygHRMe56zD+lIRax73QfTQOCTSGiyD00nJmZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83oNflmrtq0rlbNICkRQUw/r+fliDL/puIQMabOEbcM=;
 b=11gRpxE4NuxFr8qTQH7HExPvHZsXfA0Q41xUg3soNXM0pTd60Hgle9RxiyAtqaxh/aKPcsoZGGDDi0l178hb+YA09MKTPa6iUgQNtPFcRl4Wv5S+72flKTKSAtVkI7QRZebKvirMeM7Y+4Fg3RemjvkBgkM/m11alYjONr8iO3k=
Received: from MW3PR05CA0015.namprd05.prod.outlook.com (2603:10b6:303:2b::20)
 by CH3PR12MB8188.namprd12.prod.outlook.com (2603:10b6:610:120::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 02:40:13 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:2b:cafe::9e) by MW3PR05CA0015.outlook.office365.com
 (2603:10b6:303:2b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Mon,
 22 Sep 2025 02:40:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.0 via Frontend Transport; Mon, 22 Sep 2025 02:40:13 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 21 Sep
 2025 19:40:02 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH V5 20/20] drm/amd/ras: Add files to ras core Makefile
Date: Mon, 22 Sep 2025 10:38:44 +0800
Message-ID: <20250922023844.3108065-20-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250922023844.3108065-1-YiPeng.Chai@amd.com>
References: <20250922023844.3108065-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|CH3PR12MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a89afe8-620c-4761-f26f-08ddf9815b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WfmLTz3w4LX3YpQhU8dtRrABoNIuKVqdbYoQlw7FKPi/qmyqz4v/zK8NErX9?=
 =?us-ascii?Q?OZEakLEOue2gjOq2MpyvrUXIxKJjY0tQxddWmPaTVG0h9mXnbYfNgCAQwtUK?=
 =?us-ascii?Q?djQ7Y4GHXsqYhSlpypDLwSqIpy5LK5nNXL2Ncp0gWcsHGrEeftcT4mDXVl/4?=
 =?us-ascii?Q?XOuKKo7RVswdobIcflFDEBDPi9Ao6kuKYLlh5DTrUnRr82N2GTAPZik5PEcR?=
 =?us-ascii?Q?N+LIdVJUAE9BCGfAwKLNN8mPEY+0I/LRrZD9Ast/+qEezgBGlAztRW78DeLj?=
 =?us-ascii?Q?seatp0a9gtPJ6m42EwC2CnMYmmnhjEa7SbCeCS13np31pyYXACux+7UTmCo5?=
 =?us-ascii?Q?3QJDk73pqixOsC9sENBc8Eam0p9J4bVM8FoftzvBH5GGPzl7G50fiGAFeWPD?=
 =?us-ascii?Q?XHaFGahAsq/bcjRDKt/kgPUmVA9s5iG1Y8EFJz71UzdsM69eZFoBeJOGzQ64?=
 =?us-ascii?Q?p9CR+YWmRWVgwuEr2c/PvHWBD/2LUDgifaKhzDUpjYV7br05lAug9i3LU7zk?=
 =?us-ascii?Q?UcAF09gy3R/G0Df/VXl8q07YY0nBSm5bWKOLRclZ+wFHOAwz5DrCCmEmbR8d?=
 =?us-ascii?Q?hvWvaJZGmGeBPveQJ+cOdxoV0pPHv4lGdO36TEV+RaAswp82yToBYj467q/F?=
 =?us-ascii?Q?NbFyF4nCReeoLAJdlHj6jX++Z/bUNyVf+ZeuSUupEciBwspwP9yruFopD92j?=
 =?us-ascii?Q?sLbtmLSvqmyf+EjxwU2pelxjYjNojgO2O7NUESqiqi7bIWP3qTz1Y7T1yPDi?=
 =?us-ascii?Q?w40ekz6VuC18cHWCdB6UipbfXlsWRsKcGovNenPK08bZwRv/ynJYMmaFOem3?=
 =?us-ascii?Q?geBPwSCDAOkOJAErJjIT4zBfX8W6Re+tB7gYDJnkaRzqHpXJr9pS/ygKkva5?=
 =?us-ascii?Q?cAbmiTNTInBER7O8X8fzA5H+AZoQLgs8htyx7NJ1Tx17H0+lSUWklJFPOCBz?=
 =?us-ascii?Q?DN/WxRgAuYbcfYh/U16D70LJFNV93KwEprAqJlGXoZcirMJiXz0W6ZVT17Fl?=
 =?us-ascii?Q?1jvhGXd06e5VnzeRPQAvrXlW0EsmjNif53gCnfWQw/YSe3FPzgqOn8D2c081?=
 =?us-ascii?Q?wPEz2JeyyNgcZjCFHxJZpJ2AEObtaTeixtgqivuxSh78UxaCRTL90m8aFqEX?=
 =?us-ascii?Q?vic4vGF9Xx0Xgqks7IrqC4AHV5SLhJwVFU16+78fjLCJHsPzD2kRJTjbjwg8?=
 =?us-ascii?Q?RDjRTMb0lzagXyzroCz5H4Vm4k+LEWjcvrQ+1YlrqFCb4aWbW5GveayAwBx6?=
 =?us-ascii?Q?bi8W2akRGVjPr7917s9gl1QxlLv+oNul50JWFTCQRN5XID4XCvNIc2c/CA3U?=
 =?us-ascii?Q?/gXI7OTVDr1SPeQgw3RqikZcWlJz3i3yHrmnVg1yWWfl8us/0JZ4OWpkywiT?=
 =?us-ascii?Q?CHvgmmr9CPUZkh9VWNGbo+MxbR3cAF0sEk+Ba41emOuWkdK885iXHcwaznHu?=
 =?us-ascii?Q?hPu4HIJy9j1DIJDMws2ef21ToNIkTJFB4uJvvuQLxx1JqB1AaxQUkwXKUONR?=
 =?us-ascii?Q?XnRBPJoedjSSvYPEzccRGe6C3dbaaeZjFQB/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 02:40:13.2675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a89afe8-620c-4761-f26f-08ddf9815b47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8188
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
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
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

