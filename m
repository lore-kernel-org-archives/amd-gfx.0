Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB958CF3195
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 04:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DCA310E698;
	Wed,  2 Oct 2024 04:41:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kP8atpKP";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2BB510E69C
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 04:41:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRnvEJpVfcNFORKhJAE9cnqsA1+A9FoQH+aSpsNwHKVu1TZe3oGynqRDjVmyjVysbvqQwNs1OxawANDfiCzYFF8dsaWyYbkP9bGVq+NkhRKwE36vLiwowxiv+xf1R6rxOiYZLxh57ACs6I02dTdrUGcvXhpNOqtctjDHMLJk63E4oldQvfPH/CNvaiBE2l0NLZ/GqjHshxptv6aprUrsJXQB/vLdDpaI3HTllJhyJZRR3n9NGt4x1lkbeEKDL/XTeRM3SiZPFulf03rhUuCSY8VTzQ9zfjyfNgKQ5hFhUlD95tqXfKxBwmkyIcHd/dz2gPNiWYqb60rVJrRe8rmQpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8k9wGMgcH5AEdlUIFMGumFhOg8jKvhd/SGMqeHQQ7M=;
 b=MdrTuNRYeux6uxIcSAViCJSiHsED6L+NmOJCGP6HzUoCzymXvJBQ/2IHAsDURFxupn5Fj5vL2DmJTvjuRGvnuhg4Ib3dc0t4zq9SPQnfFrH1DFkE+0UA/3Qj0fT+aGT32I5bkyEclzs49396GdIRsB0n/WI77xlRyfyWLawUNRr1HpNpXHow/rn9XnMT08SEozzrWey+a6Ui1dWgSB/2uzKih4350T9Phof4xJLU/3WSYBaoqCliBugfz9SsX0n1AktMIamNQ5nbjvg8vZTxHDqK5d9CguoeLqPPRyUZbVj8OzF7YLIaSYfh8qBNrJnu7ekdPU4xBwSAPhIpLeB5pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8k9wGMgcH5AEdlUIFMGumFhOg8jKvhd/SGMqeHQQ7M=;
 b=kP8atpKPOnas3cAa5+Cib1iqnwZ9RFeHYbuUIFJdbfNKTQLnKsoAdWfB968mmUhaiaiwmpyGakzyqATwK3xVzH/JmQ6VNTO7A9akBQnrfJapdO5SXlrLd6JwmKmPjiy4imUBDD8cGZcLd3acwe7BF/CyZyU0+PArh+IINaDyIeg=
Received: from SN7PR04CA0165.namprd04.prod.outlook.com (2603:10b6:806:125::20)
 by CY5PR12MB6227.namprd12.prod.outlook.com (2603:10b6:930:21::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Wed, 2 Oct
 2024 04:41:09 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:125:cafe::2c) by SN7PR04CA0165.outlook.office365.com
 (2603:10b6:806:125::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16 via Frontend
 Transport; Wed, 2 Oct 2024 04:41:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 04:41:09 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 23:41:05 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 6/6] drm/amdgpu/gfx12: Apply Isolation Enforcement to GFX &
 Compute rings
Date: Wed, 2 Oct 2024 10:09:36 +0530
Message-ID: <20241002043936.2960921-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002043936.2960921-1-srinivasan.shanmugam@amd.com>
References: <20241002043936.2960921-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|CY5PR12MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c2561f2-adf7-4398-5af1-08dce29c6f9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SEhBNTV1bHViQzlOOHFrdE01dHpwWFZMWnZhWXBxRnBoQ0g4SHRTN2ZtYms1?=
 =?utf-8?B?c01BZnFlZGlTUm9CTGVqRmJqeEphc1g4QWRDcWZGeDR4V2dUNitrQ2ZoaVIr?=
 =?utf-8?B?TzlCeGdIeVBJRm9Ocnh4ajR6QzJlVnMvRnVxcHJrRVVzOGsxOExscXRuVEl0?=
 =?utf-8?B?VG1IaUcvZ040djkxc09nbGpIamRnOE1Sdm5iMWVCU3lIOXNxbUFSUEJqUElC?=
 =?utf-8?B?S2psNExuT2lhYTA2bnNiUTlRcjFzQUYrRkFwUmtlTzBPenpxL0tGMkRaeEdi?=
 =?utf-8?B?c2xsRGVPYXVDZ0ZrZzQxTzVZR1hHSjQrYkEwOHp1dWp2U0IwclZYU3h1SU5E?=
 =?utf-8?B?WVBxQkFtUll1aHdzd2s1Y1lGenFkU3ZBejQzTStEVlV2cGVyZGR2Z2xyQ1hx?=
 =?utf-8?B?dmFoK3NOY0FHWWxjTGgvRS9WSXFaM3I4ekpkZTc4U0xOQmJNdmN6cGFubDhC?=
 =?utf-8?B?cmt4alVvajBNVnNqVmRhWjdveE1GeTBvaGJkUVZCSThvYlcrOTJDb2dBVHVZ?=
 =?utf-8?B?cFpHTlJuMWNGbGIrMDdCQVpYT2VBMzdCMExlSEJFYXMwak5ibGxxNFVtQ1R0?=
 =?utf-8?B?alhINHkwbmhOZ0QxZk81MlVDNW02dHZSV2RTMkZ5UFE2R1NQUDNUcWRDRi9j?=
 =?utf-8?B?Vjl4aHJLNzRnS0VRUGxpWklEN0E1ZXhycWZvdjNScnBDSldPKy9xMkU2eDc0?=
 =?utf-8?B?dTdrODQ1OWE0Z0QzMFFSVGtvNHRHQUdFNVVEbXJFTUx5Y0RZN0xaQkcrTlZy?=
 =?utf-8?B?ZVRpTVlSL0x6dzdDdFhlVnMzMThBVDlYKy85c2VYYVdLaUJEQnY1aFQ5ajhP?=
 =?utf-8?B?ZVVzdnR0Q0NXRFQ1Q0I2MUdtRDZWVnl5RS9HQ082MlU1WkV5OXdnSU85WkE0?=
 =?utf-8?B?M2orOU9EVmZ0TTZINnNubU9oSFREVWVwUXkxOEx5aHU5SjNoMU9lZTF2dCtr?=
 =?utf-8?B?R0pyZjZpVGMraElTT0xLL1hDMm9MQkQ3THp3NUJ5U3Z2UFpTenA0ZDNqTEZu?=
 =?utf-8?B?R3VWQzl3MkxXVHZ1WW05S1BpcWRiZVJsYTM1bmRnM1g0dUgwN1hRY25PUHNX?=
 =?utf-8?B?YzVTdnFVenhKbVc1bGx1eFBDcytwaEpTN29qajdmdE8vRjdKUXdxR0FXV0lm?=
 =?utf-8?B?TkJQZWdielgxU3ZtbkZlbHdOU1Z2STlPVVZQYzZ4RmhXbW9SUHZQVWJyTW1D?=
 =?utf-8?B?QnBVcFFPY29MSzlWbkxaVlF3Q01GMmRYZkVGQ2hSelU5UzVhdWhwV1puTkVB?=
 =?utf-8?B?OEFHRkJESy9hWTEzY0tpamU2Z1NFdkhIRlc0Z0FHNVR1M3hNZjUySVM5VlB3?=
 =?utf-8?B?YlRKcGZob2pPVkk2WG9UK2hCVXZuK201anRCd1lmRnM1eTljUUxJMVg3RVNn?=
 =?utf-8?B?YTV0eE0xdGhOVTEvQ3ZlcnlJcHN3LzA0dHFJUC9nSXlzY0s5c3BPbzdYZC9U?=
 =?utf-8?B?OGxIZXN2TndWVHR1b1F2MHU5YWlpdXZMOEo2WVc4QzlPYzRTaWU4ZVRnNytp?=
 =?utf-8?B?WFBVeTB4RXAxQWlveG1MNHlLZWZZZWkvR0huMnZPa2xmRVVTMHg5UWcwUC9v?=
 =?utf-8?B?YUJ3aUt0NXpYWnpsWlhCVDhoM3Z5Y1pFUlVMcFc5NE5HUjZvakpaZWlsMENt?=
 =?utf-8?B?ckpWZk9wSW0rcXVyN2N3YlNMMHhsQi95MTRMcHNqakh1UDlXMFhVY2hsdTVy?=
 =?utf-8?B?amF2ejc1ME11eWF4QnlDL0dwL044WEh0eWRNcllGV3lLY1U5aDZpVjRMNVBT?=
 =?utf-8?B?bThWZTJ6RzJ6QUtEdmhKa0g1UFNsUzVzTllpWEd6K21yQmlWUk5yY2xLT1oy?=
 =?utf-8?B?U1BCVWhUWGlYUDhmRGlvdFlCVEZjWEdGeUVveWtjOE9SZ1ZjckUwSEpDdHp4?=
 =?utf-8?Q?94GOlnu508gdk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 04:41:09.4189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2561f2-adf7-4398-5af1-08dce29c6f9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6227
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

This commit applies isolation enforcement to the GFX and Compute rings
in the gfx_v12_0 module.

The commit sets `amdgpu_gfx_enforce_isolation_ring_begin_use` and
`amdgpu_gfx_enforce_isolation_ring_end_use` as the functions to be
called when a ring begins and ends its use, respectively.

`amdgpu_gfx_enforce_isolation_ring_begin_use` is called when a ring
begins its use. This function cancels any scheduled
`enforce_isolation_work` and, if necessary, signals the Kernel Fusion
Driver (KFD) to stop the runqueue.

`amdgpu_gfx_enforce_isolation_ring_end_use` is called when a ring ends
its use. This function schedules `enforce_isolation_work` to be run
after a delay.

These functions are part of the Enforce Isolation Handler, which
enforces shader isolation on AMD GPUs to prevent data leakage between
different processes.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index df4a30f8a205..a012166b6bcf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5340,6 +5340,8 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 	.reset = gfx_v12_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v12_0_ring_emit_cleaner_shader,
+	.begin_use = amdgpu_gfx_enforce_isolation_ring_begin_use,
+	.end_use = amdgpu_gfx_enforce_isolation_ring_end_use,
 };
 
 static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
@@ -5377,6 +5379,8 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 	.reset = gfx_v12_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v12_0_ring_emit_cleaner_shader,
+	.begin_use = amdgpu_gfx_enforce_isolation_ring_begin_use,
+	.end_use = amdgpu_gfx_enforce_isolation_ring_end_use,
 };
 
 static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_kiq = {
-- 
2.34.1

