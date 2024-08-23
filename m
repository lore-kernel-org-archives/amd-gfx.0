Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB919C5320E
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Aug 2024 00:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5870C10E13E;
	Fri, 23 Aug 2024 00:15:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PAa2kAei";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A33B410E13E
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 00:15:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjtyH4AF/slTubne5YmkZYCxnCxkIWc1pdZ+ha3sBgu1hHkB9X1NBAx0tZoVrgl4C/mdLPdsxWGrVZS6sSY3TJ26xi+uLwlmP/IeRkrAR/B13rJ1ROl/nsnmnjAxJQykCOZHwzBYdkwWVZDsb+IX4EVq57zGDrX/ohXgFFkTF1fQBGIZmT0Nyp9s1SAsdEB9XLCe7/VsNXLJOsbJlob6Wq6tALyOfkFgKOuGIWjxfIktJy8Vkz2szTltEbrfYS+wKG3TSGIC4tkkmkp6B/IQmPQ6D5epBR6ym9E1moepX990R5vsRXI4pX3y5qLbjWVR43B6PKsO6SccArcVp1OOTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRaNAdBeGX1i6ZsKY3XDS+aC6WZ1vV91AeLvlFve6Sc=;
 b=PKK4SgDPqPNv86Whfzm+2tYHwAYNHHz/3An5Db8CrjR5IMIlvugzA4i0vgpDiGen1o3EDvt4OVG/XeYbboiImWOc116XLnBZzAB2+XfELGzc/EMWmjb8RDYSiVAvCfgJCFNPSuLJlw3UPqXkRrRKtKkE1uAO2qz6BrS+79DmPEsrLvT+XQ9K70yyGZ7yXuZYfBJaIX0lk5oEXlx9aTr+CCoWojZ6YVz2yEWaYP1y/hSqD3G998/4DjioCtfisIH5S/LtxnLhv2l18wouW0/Lskwv/JOPhhYgRsPKkB+X3w8NZGSW6gyYKO5WqaPisgXLdBs7J15UoNJrFSvMPc9B+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRaNAdBeGX1i6ZsKY3XDS+aC6WZ1vV91AeLvlFve6Sc=;
 b=PAa2kAeicX+oNtoRq7trIGnISFCW5tH8H51JRl9FYCPyC65Ik5tB1cvkxx0FL3gQITbpYqJ9X9z9teWvEkMGdijmmFqcFhMzEPtQLoX+LQsh7tmpbU+S5DIYT807j7DiaYjfSsJtyHNlBGBIO6mZ1dt7d0/u6PqFAENgJIP/fY8=
Received: from SJ0PR13CA0024.namprd13.prod.outlook.com (2603:10b6:a03:2c0::29)
 by BY5PR12MB4290.namprd12.prod.outlook.com (2603:10b6:a03:20e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 00:15:46 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::68) by SJ0PR13CA0024.outlook.office365.com
 (2603:10b6:a03:2c0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Fri, 23 Aug 2024 00:15:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 00:15:46 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 19:15:17 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>
Subject: [PATCH 1/1] drm/amdgpu/display: SPDX copyright for spl_os_types.h
Date: Thu, 22 Aug 2024 20:14:53 -0400
Message-ID: <20240823001453.1845297-2-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823001453.1845297-1-zaeem.mohamed@amd.com>
References: <20240823001453.1845297-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|BY5PR12MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: 531de293-c374-4609-c8e7-08dcc308bc57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dCb/7+qNt3IOGxwdm6dCods6v+4woswGTMRnveiww/uTHvigK1+FKvkXU2/C?=
 =?us-ascii?Q?fSKVg1C+3eJReX/4gSODoaPo4YTuIUrxyuvnLi/8DlfF7LRSg6POZBfsmBtV?=
 =?us-ascii?Q?Bp/2BSF6yjUthy99P1uAUJhIch0QLzjCQ9wSmaXJ5X6hx3VzW1Mk5RMgH2Ph?=
 =?us-ascii?Q?m18PFUx5PjDmNSoHmQ9b53vsAkZDtY2KCs8hdYOPbHpiFcgYqnTuP+irHboy?=
 =?us-ascii?Q?iefIi1h302A8CrU2FCv6F/7KqqHA9nNMiZTWGpK6aKdePcwwpGr9OLJdD/BA?=
 =?us-ascii?Q?OiEAJC/cpFlSth9yccK3c0hBBi5mXZ72CO2FK9C7w5Umz3SO+qVJuP1zhQzY?=
 =?us-ascii?Q?N3OZUMQxAaPAyam796kWQIDudLqGWB6wiJSArZ7j/c6gOGMfmVMEdUC6XB8U?=
 =?us-ascii?Q?VPeez9pqSHAA2uujqIgz9LdWKEm4lrZJ4iscCv9wPUuOdAv8WHGB6+B4i7SG?=
 =?us-ascii?Q?XZ5NaT7JlBEimBqg0+oHw29SY62h1v00xBiffARuhZRLSXUpyIcTbY2Ihtba?=
 =?us-ascii?Q?+5GH1XON6q5z7JP51bDfwe7OD0hn6zCUKXu43tvpMNHEvupB8+ZvbBZttGYJ?=
 =?us-ascii?Q?C74cvbVzc2Az90tFrtgLruZq6OVYRoVt+aliP3033uKQn4+nyKwIPPQttCnI?=
 =?us-ascii?Q?A8ly1XkJDS8palHqzCkOX+Bjp6kQuvlh4SLUIStlZwFpOissi53IuuYzsYPd?=
 =?us-ascii?Q?/mkwlwG+NdRqpM1qJ82CXh/wJ8dI9AOat/4hpHkGuNzfL4rE6NsWZ5KsuMsG?=
 =?us-ascii?Q?uOi1CQHIkdV8j+HTkpX+jmZGTgYYnDbIaGE3J5GpkwgXC3aXsT3fc5q7Tc6W?=
 =?us-ascii?Q?I1dC22eqf7GqMI58y3taqqZAhuLQi2cbiMj9frurwWoPB0pJ8ABBB2gHAkIK?=
 =?us-ascii?Q?KW7wOYr4Vt/Z12v6nwQljwzddB8kIt5A2PSlpq8D5+4JzmHWGLIpBXQEp4DH?=
 =?us-ascii?Q?undzjIzzjG82jGe5iwrfEirtzgXX/Arh5ab1n39Ip4bf09EX1YG96gQXaxD8?=
 =?us-ascii?Q?PD1MzTCgt8/JQTnO+KeG+8+T7rtSKKn9RqzMcuUbCs9IcXIGGZhpKQa2BtCA?=
 =?us-ascii?Q?kLsic2efgo5MeDO+s5MNjau3LmJ7hgY1DOkCAXGfhpewlXdqQE77xa/4x1Ve?=
 =?us-ascii?Q?Qtjae2E1yq4928oz7kCli1IM2+/TsCKRrdB4wI+O0D4zOYJiKZasqUFn9PRZ?=
 =?us-ascii?Q?AlZLrV/QK4qBWcoEVl3DE81qUt7C6BkdppmudndRG4IKeWltHeNj0Xcq2RR6?=
 =?us-ascii?Q?DRKpnHvbfdDf+7pWykH9YCwY2p1/GuwZ1crwaXk9Q2edBy9yDD/yeqW720/F?=
 =?us-ascii?Q?UT4sErOqWbJ4GnPY5AeZe+RkALExdXKpCTNna53bM5j8WOl1bWBZj71tYcGQ?=
 =?us-ascii?Q?Xk++gFCl10v9D+1T0+QvqSb7c49lyd4K3gFoMWMoIsycjYfdASnWqNSW/s6Z?=
 =?us-ascii?Q?OBwT/T+B9heObQYN+rfuIggbBcQRPxOB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 00:15:46.4760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 531de293-c374-4609-c8e7-08dcc308bc57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4290
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

Use appropriate SPDX copyright for spl_os_types.h

Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../gpu/drm/amd/display/dc/spl/spl_os_types.h | 29 +++----------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/spl/spl_os_types.h b/drivers/gpu/drm/amd/display/dc/spl/spl_os_types.h
index 7ebea91c84f6..058306bb41aa 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/spl_os_types.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/spl_os_types.h
@@ -1,28 +1,7 @@
-/*
- * Copyright 2012-16 Advanced Micro Devices, Inc.
- * Copyright 2019 Raptor Engineering, LLC
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- * Authors: AMD
- *
- */
+/* SPDX-License-Identifier: MIT */
+
+/* Copyright 2024 Advanced Micro Devices, Inc. */
+/* Copyright 2019 Raptor Engineering, LLC */
 
 #ifndef _SPL_OS_TYPES_H_
 #define _SPL_OS_TYPES_H_
-- 
2.34.1

