Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25C9CA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8699910E843;
	Wed, 10 Sep 2025 05:27:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jh8m8kj0";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 897E110E843
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:27:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhHQFl4vIISGO6NE9RkZK5uPKey4av/eHmskraRxDCnlEfudnktWj1hxVYz/Gk0PP3JWGxGGxAkEhcEMrsuvWIvaZSp85hKdwItd9O/AQ2l9e1yXt60wqD3QXbT+jxDKRmMu6weYKDTAwIXrI09Ek8TqxpohFEI8y+P8TFxMdTDKws9hLejUTjT3B7uXtdShfGN+5K5HEc/A4i1nAEVTnt8425rqtte0y3+6COmwfMibwDO2PCjglSQHHS0kpx6InxJm2TVBtipUGLDyF/riaGXfnhpoNEgUgum5qwbY6+ouvRjf8Tl9B5eMUwIsWAy7FgVMdBLlsADTLqWNN8VGmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0JYulrIfElXnKjWH974+gil3VEEoTamxog/Qrbb7jg=;
 b=EWFCa6Aj49hj0RPiEmErhTMfE6J/MuwLRswM+i8RgoxzkHjCERGMGEBRyKhCvkXoz9mGc2eePMClVIM8HQ3LB2fr/MdUoQ1St/F67xh8uY3mvttVXGO8mCRHv0x7TZSgQbU/+MYpHRH7nDqBcqQkvoS4hlSc7VvvzQessdIP1eMFQSZcU+Egapkq0nueqLJNqVNj/ppIdnx2WUMmHe2dqPsMnCdFGepXvSpUQjlpLAW9+vPQa7uben0gRxTaSGZWjCKx6a9dTzO0RCi11bVFuPsFJlSdD7ujPVplQwc5WqqVSO3ZJMo+cJ9AOPDR1N73dicPYMZW/GYpS7qdqKnjuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0JYulrIfElXnKjWH974+gil3VEEoTamxog/Qrbb7jg=;
 b=jh8m8kj07qEHM4mhr/9R8MhC3Pha6BN2kQbWs23DskL8fwPjmUXzPXPrjspBdeCJveTkYJ/eb6lotedKkwPPUynSm8cys1R5yzkuUIDuGZu7NusprMIKwMLX762kMvsWGPxZkvBtztICZIwXzK3JXtrUwdeZxxVYNre/96um6Pk=
Received: from MN2PR16CA0030.namprd16.prod.outlook.com (2603:10b6:208:134::43)
 by DM4PR12MB9733.namprd12.prod.outlook.com (2603:10b6:8:225::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:27:27 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:208:134:cafe::b9) by MN2PR16CA0030.outlook.office365.com
 (2603:10b6:208:134::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 05:27:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:27:26 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 22:27:12 -0700
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:27:09 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Ausef
 Yousof <Ausef.Yousof@amd.com>, Leo Chen <leo.chen@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 08/15] drm/amd/display: fix dml ms order of operations
Date: Wed, 10 Sep 2025 13:22:10 +0800
Message-ID: <20250910052620.2884581-9-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910052620.2884581-1-ray.wu@amd.com>
References: <20250910052620.2884581-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|DM4PR12MB9733:EE_
X-MS-Office365-Filtering-Correlation-Id: 6124cfb9-75c0-4393-c7f7-08ddf02abacd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8M2lPEPklv5L/0r+JMja4AVYmVDvGsbk4siHLAmgt5dSkjIhD7TZUSclH1X6?=
 =?us-ascii?Q?tcmTJWLfn2GpCXTdj3rwzW047R4jlCK/NuumJReSAEsH3fE0KXcfdftOJhYZ?=
 =?us-ascii?Q?piX8fAb1Oxuxy3+9Cb0fT+cAixGSbLNZOfnAuIwSw4Mgcr+g3MZ8M7KSw509?=
 =?us-ascii?Q?lB0hw1YKyacJAoCvjEKYvX1K7N/BG1u7sQZ8JQyUvwMc2k+gFsplLOseYg+L?=
 =?us-ascii?Q?IZXX791PO6w4wdyDE/BJtUBciZFpLCfIiTi+QMDSXUfg58msRJRKCUg1OgcW?=
 =?us-ascii?Q?fn9yHaj1CNExTWcdJN72hLWWqZ3/3OkoHZ21g/v4MYY4uelhsRQddWJZs+Fo?=
 =?us-ascii?Q?g1NjnPTmlP9EmWzqQqCYM8MTfWs85NSJkQ3Dxio5QhEEeYVY6dVB9A40Cuwc?=
 =?us-ascii?Q?aGpFONXd31EVWBRgGlkytbqcUTR4YucYaCPxhklSmrNdCtTptN3QqNy0Phcs?=
 =?us-ascii?Q?YInvfvZgizOdIPnCcKHs3LQ9QKp8oNSR1E+X4B6ldOC1v5wiC8aQG1zC9kF+?=
 =?us-ascii?Q?jGvLZJQiA9kUK620brvCnot44NhiOvsxxDQuMVCt74KrzBBzdry9kXr6ic9Z?=
 =?us-ascii?Q?23pARGTtCiPesj3PUbezGVlhBMk45TgmPHotvc0gF7HcSWKvsO9c8sNT62GX?=
 =?us-ascii?Q?YrekncsnRYjuLmsc1mYmJz4Jl2ttKjfLw2cExDbjjyJANhRrdbhZGFSkAHG7?=
 =?us-ascii?Q?nvCkJHqqc3gfxA8uescrMxMZT505KXehk1/1zH62HtuXMBD3p3AtfoVhSYNf?=
 =?us-ascii?Q?C53+OYAQW/JkBqfYdKuYlb3VTSpXKQ1KzOaUMkYVSeQZmlG3obnaNvq2pnT+?=
 =?us-ascii?Q?SS1i7jW9ZI0N/ITz8S8u4samsqqqmOMeHtuTljDQzJnREfreLBRvBQr3mQgO?=
 =?us-ascii?Q?eoYnkmX8YSFByxxIt6zcSSbnf6dSP0bJTKwBhnrscOB08Mxr2fU4cu4FWocl?=
 =?us-ascii?Q?TxGRIxAAqiKfjGlHAKL/L35FvonnTA97WlQ1ogibWjqA5dCHNp7swLEqKm4o?=
 =?us-ascii?Q?b3/3E70tU666fuXZFJDavkWV/oTbdLri5YwT+Dsa8iazn+sVRXz37Ead9r0L?=
 =?us-ascii?Q?RLcNnmZLzm4qdKjM7UpARRQlHgEPzxVtTrOpzTD8SQHmp3vdRqrr62bmMRtN?=
 =?us-ascii?Q?zqE1GDov9wrFQMMg80FDAqfxRMEZtYXO2pUR65UwUFsm+7/xAU/PND20oA3d?=
 =?us-ascii?Q?eNQpSaEzwXVpJ0jxH4Xie019+WPADwWVLNWrFUD3LKu8dxFEM9zzG+JiTv9A?=
 =?us-ascii?Q?yNDwTTCByfP7UvY9WJmi7doQSBjzXa4dpj1c+uQGBUEn9kJU4s/F4WzPHls5?=
 =?us-ascii?Q?PCcyRtRydOmjNSIqPHCxRG6oFIyzzZir1gssQ14sv2C0Sj/98RGCs9IuHlr/?=
 =?us-ascii?Q?QB7WwW40f/Zc/dehY5BCEE8Z5jLqw2bmW7zzXkLE3skQw+/y8VEd45mSUyFF?=
 =?us-ascii?Q?KgcDIqWzIL2VF3L1/lhSdSgqHE9/9qSR5C4Azz0j6uXPkYCpfhVM57P/DirV?=
 =?us-ascii?Q?WfInmRW1B7CDHSduGyYhNFkX6x+AKjgjyL0P?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:27:26.9387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6124cfb9-75c0-4393-c7f7-08ddf02abacd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9733
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

From: Ausef Yousof <Ausef.Yousof@amd.com>

[why&how]
small error in order of operations in immediateflipbytes
calculation on dml ms side that can result in dml ms
and mp mismatch immediateflip support for a given pipe
and thus an invalid hw state, correct the order to align
with mp.

Reviewed-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Ausef Yousof <Ausef.Yousof@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index 715f9019a33e..4b9b2e84d381 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -6529,7 +6529,7 @@ static noinline_for_stack void dml_prefetch_check(struct display_mode_lib_st *mo
 				mode_lib->ms.TotImmediateFlipBytes = 0;
 				for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
 					if (!(mode_lib->ms.policy.ImmediateFlipRequirement[k] == dml_immediate_flip_not_required)) {
-						mode_lib->ms.TotImmediateFlipBytes = mode_lib->ms.TotImmediateFlipBytes + mode_lib->ms.NoOfDPP[j][k] * mode_lib->ms.PDEAndMetaPTEBytesPerFrame[j][k] + mode_lib->ms.MetaRowBytes[j][k];
+						mode_lib->ms.TotImmediateFlipBytes = mode_lib->ms.TotImmediateFlipBytes + mode_lib->ms.NoOfDPP[j][k] * (mode_lib->ms.PDEAndMetaPTEBytesPerFrame[j][k] + mode_lib->ms.MetaRowBytes[j][k]);
 						if (mode_lib->ms.use_one_row_for_frame_flip[j][k]) {
 							mode_lib->ms.TotImmediateFlipBytes = mode_lib->ms.TotImmediateFlipBytes + mode_lib->ms.NoOfDPP[j][k] * (2 * mode_lib->ms.DPTEBytesPerRow[j][k]);
 						} else {
-- 
2.43.0

