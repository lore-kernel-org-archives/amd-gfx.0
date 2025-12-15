Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130C0D5B84E
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 16:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA2B310E23C;
	Mon, 15 Dec 2025 16:08:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dsGcI/Rq";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013051.outbound.protection.outlook.com
 [40.93.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9F1210E99A
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 16:08:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSp9jllOAyFhtNfgnwWVRASJrp+JXMW71T/K4Kx13ubB+MyciaubU2FCzCz6ek0MCZw/i6IiGCTLRaJW3k1oOzI50GnTCP/zvizfoAYg7+F68SRAx2VBtKhJAILdrXStQJw2I+sLETQRphJ/eoLjFuMR38mlPHz8E9VX6hs/XfKVeaWSd5DpjWnl53nfcaNKZDHsgSLTDoNFYa/KqF9Y0ttJKTGgfOmTjGrftFa/dOXm5pqbLNUQivbpNS2R3FdESXFEm4Sb4JhhtoEgSPzPStrzbEjFejCG8gvcdpH/TqZKdkMHXCZdNzcYmUZ35SD/tc7UXV586sySC556tgnPqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiAGCiv3hAYrychpFV8gkBlRcM5Pl0N4ErYWJWx+DV8=;
 b=f9nxl2XlAHdClt6coci1BIq/Nt1jYQujx0IUbdFbTJZ+0MjxFUxJ/aTPKzEX2Qbrk8LdhY0YdFBG1V7Pd3QL8LOUezE+PEHTSWMXCCsfta6Ix8IrKulRTfMTcDo48PRFBHzZpETjd/snVrUUGrLiDneX2/vKEuEartlStX2hMSo8X71M/ix3LBx8jinsplfh+EaIwCEuhFln5wNFyobAfMS9pXVuhqFxxniZr7XchLZLnL54/qIKDLaubNn6B9XnIEIRLMQfMXzXs2OEUDToS3d62oLyZXZqrt0wrM5mFgAQNRxGXCXxuewVG7LVcFjc6XgJH/Tb19mOclxwgaASvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiAGCiv3hAYrychpFV8gkBlRcM5Pl0N4ErYWJWx+DV8=;
 b=dsGcI/Rqwdv+jQweqwh0Lt1HwYGiiK/+gHYrA1iMT24bA/UjM4s9f5CCopDOPJJVET9aEkoC5XBw0py72n3kaqbdPzxI0f1H12+0XDrWQq0FCRw2XQE/6JztfCHtj33DTmjOqpSAR8PT9WpHuS1LjZCsBwk/FaYhRhPK24MvXAg=
Received: from PH8P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::9)
 by SA5PPF06C91DA0C.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 16:08:44 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::61) by PH8P220CA0025.outlook.office365.com
 (2603:10b6:510:348::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 16:08:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 16:08:43 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 10:08:32 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/6] drm/amdgpu: mark fences with errors before ring reset
Date: Mon, 15 Dec 2025 11:07:10 -0500
Message-ID: <20251215160711.11832-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215160711.11832-1-alexander.deucher@amd.com>
References: <20251215160711.11832-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|SA5PPF06C91DA0C:EE_
X-MS-Office365-Filtering-Correlation-Id: 49647f1c-0fb1-46b9-74df-08de3bf4384e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZJIl3kxhZxIg2e+rSQOKmoyzQiODjlvS34n3j2JiSO8X0j4/3Fxa37nlOkRg?=
 =?us-ascii?Q?UMxc7Ju762ZvQ2yVcIXDy3vadf9naUNZocBTcgytkB1uDu3QgwC5WK+wDFPh?=
 =?us-ascii?Q?O3xTwA2dnOhh0SpP/Ai6BK6/C4KvN4Y01jZoyLackyBKp9Ro9ZUAmzF2/LFR?=
 =?us-ascii?Q?9ORYY2bYumn3fhip7vXniKz/S8SIaBGWj+OjTWuewEbPm91VVNwevRJDsIM6?=
 =?us-ascii?Q?3lK5opXxVwSXj9p7iVRK9UgPVxXkRIacbxQ8Wm4xElzgp0BgF6UQCv5SlLR5?=
 =?us-ascii?Q?M+DcI4Jv/y9Tr1QGO1HwrqQWsFQvJp3xpYk23YHk0vvc9MvyNV2URnLq6k2l?=
 =?us-ascii?Q?RYxjcykTgbp9qMrPRbAsMlUiVNkh+gayvNlsqwXEVGWH+8gtOxK1uMe803X8?=
 =?us-ascii?Q?GgfB9uN3wTLfKZjKlu+K0I7cd6XigC3u5liarv9uq//oxMR/7O1Ab1Vg5Ziu?=
 =?us-ascii?Q?wM+O3JhAV3v0Gpr/DNJe1y4LDstZZ9KUlf2pB8xRYuj1C77adrUjeA+OEnKG?=
 =?us-ascii?Q?RKz8esaQNaBQKjFqSbrIFL9UE+TcCMyavWp+jM4/QR8SWPHUhh7Fu3WSa67J?=
 =?us-ascii?Q?D/Qe8oh2kZiUTCTI4Zq2DALFeEDXLiqkZmUm7+6vCveuR+mqurde4lxnpxUh?=
 =?us-ascii?Q?CsQsX+DZfG6F25Z6C+QscuqYqRvHwn5gCpzrbgF0VQEZh9WilJcT7nb53AU1?=
 =?us-ascii?Q?6BwaRCRL+wXEkQgYHVYvPHL4lNv9Tz9ATSY+UudatUP58r6t4uE3tY+RYB+t?=
 =?us-ascii?Q?/5qDEVmR+i/SYMsgD4StiCAQEMkelYIUHcAKpYZuD096M0lO6DdxPGNvk+90?=
 =?us-ascii?Q?lc2VrS9UBuCwBlIKzdsErUP+7zQ2e/OywHFzIvWTfp/3OFmYEDxxoUN50tZh?=
 =?us-ascii?Q?cDv4eKL1JJRTOnXV+fJNh3NxlGDLxBHYLR0kZ9cef+/xm6bfckr8S2ypySRj?=
 =?us-ascii?Q?DWm+1Xa7QA/Ax0H62u4Jg5N/9ljR57/MX8KleQu+06AoVxpQohwWu0l4hkdt?=
 =?us-ascii?Q?d3jf9PBtA42sZ5fJTBtdJrk/yXzSaeVXegdLqMzc0s2Alvwi9BVMpaRIpjOd?=
 =?us-ascii?Q?17TJmKCRfwndFCPUo+hNFrrq2YvaZZjke54tGfFYMgdszSP/+XmU6Mkz0fbZ?=
 =?us-ascii?Q?L5CLE1eJTS3wuUdmmkbW3wYYbYjgjvlfsXobrFyBF/mhadfZl/8hsGWWAgPb?=
 =?us-ascii?Q?qhoE5zdKttH/z7dHUqBWK0XyXedJQ/wpZzmYclDNKLLTTjBwmr2fiaKDc85X?=
 =?us-ascii?Q?bOwUSwqp3XKoWboBr1Xu4X41GgtHUwq0o6E1MQmTujoJRaDWh6H5lVBPL3qw?=
 =?us-ascii?Q?5YZSRXsr8KOEZMHVfGO7IbISidYJwgIll6+b0VpGgjjABhJXVt7rbkLTxNtk?=
 =?us-ascii?Q?ipqbkW05WjPN+OhbtYxh6dq5fAFlXZ64LzrHBvaOPWVlcUs9A4WXArJYRmbi?=
 =?us-ascii?Q?IZ37KKgsXxH7gTqKBlqV+Q+5BPvyS+Rn3pMPuiWK3eE8Gt0SifLy2tJf9GPt?=
 =?us-ascii?Q?gMXx70lgTKkN2NJMY5rItFDVKu0Zwt/CcVPByETKYKoev7CfaDoX58cHxH0d?=
 =?us-ascii?Q?3dlnxZ2D981r4DCzT4U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 16:08:43.5045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49647f1c-0fb1-46b9-74df-08de3bf4384e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF06C91DA0C
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

Mark fences with errors before we reset the rings as
we may end up signalling fences as part of the reset
sequence.  The error needs to be set before the fence
is signalled.  On GC10 and newer, this isn't a problem
since we don't signal any fences.  On GC9, we need to
signal the fence after the reset to unblock the recovery
sequence.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 1aee207b13524..fd7b0f955e4df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -872,6 +872,10 @@ void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 	drm_sched_wqueue_stop(&ring->sched);
 	/* back up the non-guilty commands */
 	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
+	/* signal the guilty fence and set an error on all fences from the context */
+	if (guilty_fence)
+		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
+
 }
 
 int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
@@ -885,9 +889,6 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	/* signal the guilty fence and set an error on all fences from the context */
-	if (guilty_fence)
-		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
 	/* Re-emit the non-guilty commands */
 	if (ring->ring_backup_entries_to_copy) {
 		amdgpu_ring_alloc_reemit(ring, ring->ring_backup_entries_to_copy);
-- 
2.52.0

