Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB76C53219
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2026 20:45:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 352E010E5E9;
	Tue, 28 Jul 2026 20:45:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0dNjncin";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010056.outbound.protection.outlook.com [52.101.61.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67FC810E5E9
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 20:45:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qjpn6yY1PPYZhpG7htK4mNQ0IjHMCj9KHWlrPnO83cWiDjvwhdrXwY+fcMAlLxi7xlPUzdMX/YmmGJOlJQrhzOrDLD6vR23yLz6iABs82vuDr9kLzPhrpLKV8dCwZcE7zVkGG8B1fcw98hZYYRd4+03xhR//CaAvUYFratnllSAPhqIZSY3U6wBYtP83yp51YlysNeENsOhmFNikPqe2NN6vz8epzVfCto8JSWSCgYFsyHCbt4qyFuHXu/6wYn1qo9lc/5/9wzgSIEvxXNLMH2mGKjvA/ux+aIxZ6IbVYJ8UeVbAtjX2GInjqheR49c+rmqR1wvlqltqvWRW5PrTvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKV8xg4Fc/DljRWnSGSdUiZuoUSMRVb71aDusA9rZZQ=;
 b=LfBQBwEuyh6lhmBekR345rriOASEDjzC0u0GhjM7EMKfinqqG3SCUcGxhi0UJJ548DvJ+o0XWSlZUcfrnB5ESs3efygCZ3AaZfvNODJedkX4bpIDtGJLKLsGe61NF3EMyiAs44XFsCJ/JZ9bQItLwGBMR061/fNoDnKklQyrzRMrv33FfcaSGgqbbmbI1RUyAYeZrE+v1IZWBss0KXfSCFmHDTYraDWqoUtPfANvvYe7yQupnT3K4WjNGE55dx/hWZ2QtI8dtkFgwLAsNJQXFzsM89b7SJXbZhC/NdhvYIMnTPOZOghENJZtJ8EEaKVcDEjZj3ambTeCV/AuLSGyMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKV8xg4Fc/DljRWnSGSdUiZuoUSMRVb71aDusA9rZZQ=;
 b=0dNjncin81gOE7OUDvX7poz5y0L3AfO0hz8QDJZIZP1vcgyQ0E4ZY26476v/xB0+zdHFEb2fe+zqUH6ks2RhHXgOyFYzOT59RQR31IvsOcQarICyOTs4rFb6A2EjHGOX+WbsAMWfwIae04wgXE5lrsXeqtV+X+2gxFTqj8CkeXA=
Received: from BN1PR12CA0002.namprd12.prod.outlook.com (2603:10b6:408:e1::7)
 by DS4PR12MB9796.namprd12.prod.outlook.com (2603:10b6:8:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 20:45:47 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:408:e1:cafe::c) by BN1PR12CA0002.outlook.office365.com
 (2603:10b6:408:e1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 20:45:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.1 via Frontend Transport; Tue, 28 Jul 2026 20:45:45 +0000
Received: from sclement-ThinkStation-P8.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 28 Jul 2026 15:45:44 -0500
From: Sunday Clement <Sunday.Clement@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Sunday.Clement@amd.com>, <Flora.Cui@amd.com>, <Russell.Kent@amd.com>,
 Sunday Clement <sunday.clement@amd.com>
Subject: [PATCH] drm/amd/dkms: Fix TOCTOU symlink race in build directory
 creation
Date: Tue, 28 Jul 2026 16:45:13 -0400
Message-ID: <20260728204513.5589-1-Sunday.Clement@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|DS4PR12MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: c4f60170-8296-4d01-0531-08deece9329e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: JEurnsOs8R7TtoLnz7UHm9zYpZ2UAgBM+2XQo5w5vbTDNgJKFLUi2Lv+nQKq5eyrUgaHJWi6lD5hHrMt/DzQ8eeuV++VQuLgMWy0//DpLeeGKkiCwehCPnf7XoAHxPXKBjr6OqvQvXHuqRzWFwRDKQls4ugc2UzoTqsCDjSJwJobH+LZA6nYE+9Rr95Br4bSZD1MRdDYrgd0MJsx1dkOHqKF7De6WahBhy8lNDF2nmP/fY3cBxFq6iuymbs5PHtYtvDjRm/ibKPW7tmakrQWwQJfr4T42yMrl7ivqHeH3Hdq5ZLzgOd6sTiPoDY3CsgU/J9T/Iu847cBLNb8bWrSfO2HWot7CMSLCwj8p6Wz098PVA3nTMFk6iym/jPsBQg3WIj7i54MVi54oPVQnvYBz7TTKLkREpewK+XX1EqtA/THMrgDEeniqmROCQq6n1U7ne0GMZc3jCRU5vuaEJ51lk39sgayAtrADf5N/FxoiqXfnl9/g9AW3pwAH7PjilFHdYKxeSGdlQihnFDuqU+WL5SJ4QU+FLskev/OQOG0mvd9mv3yp0IZDhwkTW81xadHkWpDko+WBNp83NPr8uB+MFBiucJB/PtAMkfAuJVw7gYKREe8ve3rpJmKSfKZI31EsqzxJcgggxnzvjlnHerKtvjqVxY61dYFYzR7Fao2DlDW5pW4cge2x+wb1HVwA5giZ5/UVj85zRQjTzv3Xqe0eg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: D7f/3DdDNpTp1GWhdUlef1zpAqfuK8kWNmH7xjPKP7AfQqI+aWmskWpTVlCtIVZfmZTBw7ltlHUQCL9PbFX+4kYNyRWip49cAKlojNEVL9oL1BdMs5vjkAHR/W3o9badonkEGzYBIQ78GF/NjX6RtHrPu5l9s8e1ciriWQgwBZF0wGEJrYB5ym51GHAYy+VUrmG/pqNCXWaiUXATye0brPRJF13ZD6hhza4scibqf/prNFu+rND3naaHQ/jKdE0dDcVPyjSz2z8TEMw1OFbJEYRJJRgaS/utQMOKKZkSSq8uRfScSOO4yXJec9GT97/PwolBM2Xk3ZwLZgf9F1kne5eumA9TkvJm3ugVMW8xozlkZ60TYGvGCXiSeLds525v8zs7YrdL13WSK3o6GaKLswyq3znXM3yDnRu5vC9KmD90yyclSb4D+3vFzsSKuN4q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 20:45:45.3526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f60170-8296-4d01-0531-08deece9329e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9796
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

The DKMS Makefile used mktemp -u to generate a temporary directory name
without atomically creating it, then root-privileged pre-build.sh later
created a symlink at that path. A local unprivileged attacker could race
to create a malicious symlink at the predicted path between name
generation and actual use, redirecting root file writes or rm -rf
cleanup to arbitrary paths. This attack recurs on every DKMS rebuild
during kernel updates.

Fix by replacing mktemp -ut with mktemp -dt to atomically create the
directory with mode 0700. Update pre-build.sh to remove the directory
and recreate as symlink.

Signed-off-by: Sunday Clement <sunday.clement@amd.com>
---
 drivers/gpu/drm/amd/dkms/Makefile     | 2 +-
 drivers/gpu/drm/amd/dkms/pre-build.sh | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/dkms/Makefile b/drivers/gpu/drm/amd/dkms/Makefile
index 8112b9746c8f..02eea52ae0e7 100644
--- a/drivers/gpu/drm/amd/dkms/Makefile
+++ b/drivers/gpu/drm/amd/dkms/Makefile
@@ -4,7 +4,7 @@ else
 KERNELVER ?= $(shell uname -r)
 kernel_build_dir := /lib/modules/$(KERNELVER)/build
 module_src_dir := $(CURDIR)
-module_build_dir := $(shell mktemp -ut amd.XXXXXXXX)
+module_build_dir := $(shell mktemp -dt amd.XXXXXXXX)
 module_build_flags :=
 num_cpu_cores := $(shell which nproc > /dev/null && nproc || echo "1")
 CC := gcc
diff --git a/drivers/gpu/drm/amd/dkms/pre-build.sh b/drivers/gpu/drm/amd/dkms/pre-build.sh
index 66f7177b6cf9..24f5a13ad854 100755
--- a/drivers/gpu/drm/amd/dkms/pre-build.sh
+++ b/drivers/gpu/drm/amd/dkms/pre-build.sh
@@ -100,6 +100,10 @@ if version_lt 6.0; then
 fi
 
 export KERNELVER
+# Security: MODULE_BUILD_DIR is now atomically created by mktemp -d (mode 0700)
+# to eliminate TOCTOU symlink race. We need MODULE_BUILD_DIR to be
+# a symlink to DKMS_TREE, so remove the directory and recreate as symlink.
+rmdir $MODULE_BUILD_DIR
 ln -s $DKMS_TREE $MODULE_BUILD_DIR
 echo "PATH=$PATH" >$MODULE_BUILD_DIR/.env
 
-- 
2.43.0

