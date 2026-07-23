Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233A3C4453C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 05:45:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9221B10E527;
	Thu, 23 Jul 2026 05:45:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rWb7xsyb";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012066.outbound.protection.outlook.com [52.101.43.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2217610E6EE
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 05:45:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umC8bBFGHdY1HcvpPefwZczybv6C3bxasKuICGQAaYCPT9KT8mqv7jwrtaG9vzwMxMRPPjwMdzii5dMkCF2qbzO8+jsl1hmbrccOoslY10t9YidDBj6urxW/M7DH+1wInhZiO0deHMtzMfMdGeohuGM95jmh9HeI3XWRuAXaZpaF7Z77Ky1Ih0BqUuEb7nsP55mrcuAPUk3wF9so0C1cQ+/r+mJoVCGvw1FOWRoBEfXem8Lhxcsb95la45IJ2p1QI5QMBC8GffPQk2lNVONIOIvSmN0g6MMwK+Nz3/xI7zarjBIlRkdEgixA1EaXWiWxVLUJ/mJBRvw9dV8t+JvbAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJ24lK7z8PF9NKSO/Pvk6WKmj7ZdPFQ0C/URquSSRls=;
 b=eCImxFw/rVcO/SCrpx/YCKChnjiIbD/r3zeObdAqPqbGAl4dvk4J4H6Taf53NkKMeFCckCuelJwnxmF+QkyEPZI6aBE/8Q0jGJHL7Uxx84NLd3wobT8hPlC52qJxt7INkYewSMjp4lcLRP7IOARfPDtXZ2LBBcG/cSZwvwo1AeUgRpdkqVywpuu8fm7KM+yOO+q8+BR+T4z9Ud3Gs5Tdav3Sotbu5zNfKFg/pF3GjYRe6m1opXozQyShs9Kpd7kIaAnztXmuXRd5DU5rkkMbNN7QTDhsVtqPIPYkTAKStSoPLmUocpua5r8TTc0kEqKiEhvDvy2hS9y5iDc0yKTByg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJ24lK7z8PF9NKSO/Pvk6WKmj7ZdPFQ0C/URquSSRls=;
 b=rWb7xsybmCkvU+jkWEmLde5JxxbeWm4GxlNQB4Zrsi6H1SVS93Rf1C4UdD7X25QfMIay1AkVo1jwkPIQbRmbn2DvtmBCGjA0Q8HkI4X1BqXRm7axZA8vl88DbW6+nfdyUabNtMSLMWHxlok9qKWQ1WaQTMGohL7rLNMxyPT4YDk=
Received: from MN2PR11CA0005.namprd11.prod.outlook.com (2603:10b6:208:23b::10)
 by PH7PR12MB7841.namprd12.prod.outlook.com (2603:10b6:510:273::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 05:45:00 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::a9) by MN2PR11CA0005.outlook.office365.com
 (2603:10b6:208:23b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Thu,
 23 Jul 2026 05:45:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 05:44:59 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 00:44:57 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <harry.wentland@amd.com>,
 <sunpeng.li@amd.com>, <jun.lei@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] drm/amd/display: Fix DML file discovery for out-of-tree builds
Date: Thu, 23 Jul 2026 13:44:48 +0800
Message-ID: <20260723054448.177257-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|PH7PR12MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: 15a4f74a-b499-4c47-3e03-08dee87d88cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 7nDwKFVIkA30u8cVz27Z6T4lce7KwEFuru0cy+saQ4SStWTc5alGZx+HRjhsZkbi3dN08u8N8Wp63nJJM5hCWk+vfOnJaewpCV9diiR+DocbXd2k8b3PsjeQKdXhqPHwY6lHVvN3e0/otJRHdvnq1UZaZVtc7IGrxtYCuj3S/WMmhMHCbr1TUkw2fCxMwAfer7pm5TOUs0LC08TaJstVSU6O6nVDPYFFKUIgDTxGjC8pfC4Jm4urBy77KaWA/c1I0cClHhvcyvQppFu///Xgmd5WOWAF8DQOMk89YlBhf4S0OewKAI41pn/bXnKlzzmfqYBiTaEpvkh4WQyR6+4b8sx7CUOTGnmM3fmknfgaonl3O+5RV6i2nPWWWyq8TiKma2Z1PPeny/GWuWxXwsmnh24LEFCLLhdhz+WjLTIB18z8ylKD1VuBM2LIPJMdX2cF7IMF/90TJ8ObzHBCDiUu6Rpf8wEtCc1xY9NSPgPdYiY1010TRZBoXf7eGwpXF7mUFjvVoP/pR3JOZx6L+W0u4C0XWSFblXufD4yGu2s70qnR+LI6ZqHQYvwVMbWbHC35Orn8mKhy+EHQZBhXNaFkpTjE7tqrLz3Qvs9XWxGh0/RYFQoIIl1Qzm9XNbwG7jC73xn4bKSallaNtcac72aXW3gnGvA3vgjG2OYHpgs9zZXiVNDk+I/7i2zOI9Y1YjCL+KdMb7O0XB4s8eOpbUVhuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(11063799006)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vDwtNPqOSSSaMZ35NiaHzH7hWp3G33kkslyWufBSm8W+ST2/9rmN499MdWANrQDgjwqXwbp+bS5ZflPAmoEdY0EVSoPE8nnkj0Spl9RiDqR32brxRPtc45wzV38vl9Jj4RZwwgY+ya8rm0a3mCWaT+mB9X/KUVVouJbq9rzRrSDiFVODEE+OasahnixUivpntQW3VzJmYBIRBBfFXRO+fTRAHVySQU6YAPnaQDwGpdKbBdYB8OAqCiJ28OUq9/We6JKo5CYkSwYVErkmRo7RHSo2HL+zd5Xe7NyxMonGIMP55XqsD/5IyMYkQWE9Bg97kq66FmengSt33ahoYtfrPE3q+PPhb+0N0PSDchKGuyxZ2d8KX8LYHwUPYGQqw8SNeL4SCiKFNRb7NKkxLIPTXhzLL47VR0BVhnCRiLD1SqXsnU90IEv6HRroB8MvB8xq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 05:44:59.6319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a4f74a-b499-4c47-3e03-08dee87d88cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7841
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

By anchoring the search to the DML top-level Makefile directory,
FPU CFLAGS are now correctly applied to all relevant source files.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
index 44e00c2b7ac7..e9ce7813b0f5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
@@ -55,8 +55,11 @@ subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dml2_0/dml21/
 
 # Add FPU flags to all dml2 files by default, remove NO_FPU flags.
 # FPU flags step 1: Find all .c files in dal/dc/dml2_0 and it's subfolders
-DML2_ABS_PATH := $(FULL_AMD_DISPLAY_PATH)/dc/dml2_0
-DML2_C_FILES := $(shell find $(DML2_ABS_PATH) -name '*.c' -type f)
+
+THIS_MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
+DML2_ABS_PATH := $(patsubst %/,%,$(dir $(THIS_MAKEFILE_PATH)))
+
+DML2_C_FILES := $(shell find $(DML2_ABS_PATH) -name '*.c')
 
 # FPU flags step 2: Convert to .o and make paths relative to $(AMDDALPATH)/dc/dml2_0/
 DML2_RELATIVE_O_FILES := $(patsubst $(DML2_ABS_PATH)/%,dc/dml2_0/%,$(patsubst %.c,%.o,$(DML2_C_FILES)))
-- 
2.34.1

