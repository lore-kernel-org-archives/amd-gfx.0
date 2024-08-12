Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAA4C3DA7F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 04:50:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA2E910E0A9;
	Mon, 12 Aug 2024 04:50:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e7sSoQPE";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EAE610E0A9
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 04:50:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yY/XKhLXo0boTJ69PBYZIBfm83PoCUC2EZKYsNuWzZoQAAFdaqvfGCHQ9SFtl3PXhdF9ADa3J35JJ2quN45lP2cY9bSDWxTUWpVyIqWJyE/PfzqeEdYuoQKIuLKkNcc2SFFhaZvpLEa4FiqEX1OjDKnoLbctRC4GSOhPc3Fj1Ls6KXGOKC6ql0PPBSFoh0L9crrcoL4eV4jVK6gcM97zZwqldQlq+wP9pthVxmJGG/4Xc0Pc0x8Uh6D2lRzG+kHWdsDI9QV7xGuiMQNMyXsFFp3d4+vcapSsTAZIC8QN3AXZUwERtvI1kB3JP7sJusU0UOvahoEeNnz3hhwD2G5a0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bly+tLieino4ylwCQVAgMgfglkjXNNpLRjCsocf7wCw=;
 b=SZ1c9jIoCjsyR8uzLjaBmmDXDIw6P2KdyiDWNpj674GMmAZxVWrwKSy3l4aYIga/YWZqy5S/rR+cotJ6IuVFWf4IyjDgjvOGgUaIkKQ9+22HetLSYt+VLv+gUFkghs/FjIIIrybZxZY6pCvKl5fdffrg7QSYRonx38pyrjIeyb0ARKCQV3MN/y4l+VjQyCopMnBo+VdPypZdZvLjaj8+ihKVeFK7dbt2qcwMc/7xwjKcvd3YqTpygeCrzfXYqtByc11fIfPi8ZcRhtDdvqbV/mR++IldX6HIgRdwy3NVZe+0ByJ1PbHFzyPRq68u5I9Zto/OBzpVCE4+qekllF9SMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bly+tLieino4ylwCQVAgMgfglkjXNNpLRjCsocf7wCw=;
 b=e7sSoQPEq6+Fs/qn27HuNbzXOufeqSsUdsrNxBCU/cWCXaNRwlkmX7bJQKoGMNtJd8T/MHE61pvb6JGWPB1mJPX/wLITRjMKpd5NLu/Fz8SKNZPNCVXojCd/Jjo1d2nUvGiQd1bBmBg4M8n4Bg3l0mp6Vu5sogPXbiIarM3WIRw=
Received: from CH0PR08CA0003.namprd08.prod.outlook.com (2603:10b6:610:33::8)
 by PH7PR12MB5856.namprd12.prod.outlook.com (2603:10b6:510:1d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 04:49:59 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::8f) by CH0PR08CA0003.outlook.office365.com
 (2603:10b6:610:33::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20 via Frontend
 Transport; Mon, 12 Aug 2024 04:49:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Mon, 12 Aug 2024 04:49:58 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 11 Aug
 2024 23:49:57 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Reorder to read EFI exported ROM first
Date: Mon, 12 Aug 2024 10:19:42 +0530
Message-ID: <20240812044942.1670218-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|PH7PR12MB5856:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b3ffcc-91a5-4d22-d7d4-08dcba8a380d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OqW5hOMk1PHoPeBbqstlOzczspVJggLTiwZZz5xVSHTJuFkgFshv9dKz73uk?=
 =?us-ascii?Q?mZN6p8h9UwSSoSigMRLnJNb5moL5KK8NAgBAxlw/BjAEGiwPzzD4ODgIFi1p?=
 =?us-ascii?Q?FWpNk966wxYnFtUsi8xVwZf9iQL081lcbCFxjaUkkdl6tBCh8is0EqHKO+zT?=
 =?us-ascii?Q?HpgJzdkCzJ+XXkQwAO48IFmAn7qJ5eQgXec4V1CqjjAhe0lWM6B9/E5eq7mH?=
 =?us-ascii?Q?esBJzu4FOYvmXu6AKQ9lhX/ttQBx9SuFyF6qIx/5Opmlya+MhU79CUOBGlr6?=
 =?us-ascii?Q?K2LVoxmYTLogMr88O7pedtYoZk7mt3j/VRKADrM1JJWRQ+t9TS3gjobYIAg7?=
 =?us-ascii?Q?5qzszGV3EhmPzMVSJg5xf7mDKirGNz0W+x96L4wmiFXvZ9BV7wIQmZvr1kzI?=
 =?us-ascii?Q?Qi7YseSVvWU5LYOo8fOncLLGCjZWEACt0uuYXcwicxtVpvTvM3xeERTBtGkC?=
 =?us-ascii?Q?7M9HjeF/fyz331CvQhUraly3R0QzbSYSQe0G8OEc+dzBwDfs5tpWpPFhVytf?=
 =?us-ascii?Q?GhCryhAlEm/FRzYxhcYomMDfKPNF/eCanoXYjQ1EPiGG3EkiAt0rSgJw6il3?=
 =?us-ascii?Q?d9BYnEBeurIXAVUYcf2vwqBR9a+2xLMR7m+z/DyOWMv/9lCQgmgdBc7XzfIm?=
 =?us-ascii?Q?4qCiC9pFBAUBb2PFlKM/OR+aioJeCGncefaLzu6hqjZpzxxhRDPoH4vXiPCf?=
 =?us-ascii?Q?eL8MceZ0okBtG8R/R+7Wq4ZrMZZ47HguMWga9zl8Z6QIkrVb2L/laU69u6rg?=
 =?us-ascii?Q?824xpRJOfMLlTh5P+lema4aqZR7xI/NJGl4euftesnrawMEXM4B0q0zyybEU?=
 =?us-ascii?Q?HHRu40A7QWLEiGN3du55Qpkengn2qUN96kB/m9qOxS9XoNkyRbFo2n1xwJ5q?=
 =?us-ascii?Q?uN2r0Uk/oibjGpXKhOOmD8nGzvC9hn3xlZ+1HooevcG0SKl1bkmX388Q8yTa?=
 =?us-ascii?Q?TnyIQGiihYsou4dZEsyUKRKroeaUh90SfcTZ9mADIsK6xToIYOJ1SDpWkjAo?=
 =?us-ascii?Q?MK168to9/LOVijjRciH6A04mA0LpI7ZOXBnHQUg19ldkpM8fRU/BpS94uhu7?=
 =?us-ascii?Q?VkIVgKA48VF2Zxsl1Jt2oJXyUIT9COEFp1KEqu49o70VhlKL9PDpBYYEfNYr?=
 =?us-ascii?Q?WVzBdAJIdgFvjHfy7/nEiXgMyZSQsUyuFfLtzTMsz8QCc/0HX6ZDYYublK5v?=
 =?us-ascii?Q?sFSxb+dqggnPuF45H2exoxwVVMDyV9mgG1gdXsFbg+MztWRg1gC3Lmlxfeoj?=
 =?us-ascii?Q?oAP04tV2mqsF8O87cFGhl9JS6B1BE7i6mT/562Uss54woCBesCxeJTn6menM?=
 =?us-ascii?Q?n0yTlfbIIKX2G1Uja9z3bo+AJc4zaEQET3YcYKwLSbY2znLFIBl5pnsit3/l?=
 =?us-ascii?Q?BnlLpSQoDd8gvnzuVs7lyj7XvZ0Ix9S1SHJ9m6AAAXRkNquFBAyxPXZbVCCt?=
 =?us-ascii?Q?YDSU+soYvCDUkdVBnxdeNB4w6/e8fdiu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 04:49:58.7670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b3ffcc-91a5-4d22-d7d4-08dcba8a380d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5856
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

On EFI BIOSes, PCI ROM may be exported through EFI_PCI_IO_PROTOCOL and
expansion ROM BARs may not be enabled. Choose to read from EFI exported
ROM data before reading PCI Expansion ROM BAR.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 618e469e3622..42e64bce661e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -431,6 +431,11 @@ bool amdgpu_get_bios(struct amdgpu_device *adev)
 		goto success;
 	}
 
+	if (amdgpu_read_platform_bios(adev)) {
+		dev_info(adev->dev, "Fetched VBIOS from platform\n");
+		goto success;
+	}
+
 	if (amdgpu_read_bios(adev)) {
 		dev_info(adev->dev, "Fetched VBIOS from ROM BAR\n");
 		goto success;
@@ -446,11 +451,6 @@ bool amdgpu_get_bios(struct amdgpu_device *adev)
 		goto success;
 	}
 
-	if (amdgpu_read_platform_bios(adev)) {
-		dev_info(adev->dev, "Fetched VBIOS from platform\n");
-		goto success;
-	}
-
 	dev_err(adev->dev, "Unable to locate a BIOS ROM\n");
 	return false;
 
-- 
2.25.1

