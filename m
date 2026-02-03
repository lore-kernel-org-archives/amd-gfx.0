Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F28E8783F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 15:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00CE910E6B7;
	Tue,  3 Feb 2026 15:14:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X4xv80o1";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91C9310E6B6
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 15:13:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAvjhwSQMm1PrHa5u1CgbpwBXGQDJnrfzQvJBp676OdMb6Y1m+KIgaPeU1xITtSGDQYzF6gVF1CIn1Os4I3+fqqjIHuKQFvifglj+hKRmkW1FiedQdEVBK3r/7E3asU7pfp0lrE5Xo9JsAEkb47dmXy60/zG3iKzCBkWvA95o+EM+HiPbGkUus8PvIM87dOe0TfnIZUz2JCNJOY9UtvqCQ4KAKzo08lZGG4T3VwXYqiUQXuB19ES1/2fWsFb7OD2BiwMrTyHyqtmqEa8N+2nr1QNX0XjKtGSi7U/L6XG7LJHUGBaZ9t2uKQb8wyt/nZ06o5OrH0HErlbai/ljHiIRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulLVjHs0dy/FbCygRDkBKW3lyaoVjxvHXezjFoc5lpA=;
 b=vpxF0NVoCikSQ7n5C0qMDkhb3L3BVRPAoCjDOYaBKc8nDu0wJdgqpVr/SOWSRW5GTB7pDStgCh58U1KMrj4Sx01XKnVzeMvbsBRN/m7b1UBV+6TlPnANFhBdY3k784W/0QFuArR0mtYvZTb7DbIOOOatXhfKsK8mJM8eWA6LAW+LendOmvBsrhIfGT9QaKKmSSiYbjOlYmeMhXUEBfZ1VMrY2Qo6riRGyT79nNCaf+Spcy0CeVkhrO5lVGPddllJLf58HC+GCuiQyu8NP+M9LuicSSt1y1rVm6HfRFWLfyemzmWMywdtjGxsTysVt2RHzB0RYxZd/Ixkr599991DVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulLVjHs0dy/FbCygRDkBKW3lyaoVjxvHXezjFoc5lpA=;
 b=X4xv80o1GCsOLHcQ84llX5+hIoy24a6SdJBlW+pulZyLb+THtt40T+/BsHfWbd57RqVC9gflZ87eS8oGgBXG51clC+yefB1ppZodsDjWwDdNPNgqym75cWd8iLH2XJrPoAWOXTLyyGiYIX1WB39+++xruQl1oexmpc0x1sG0AHI=
Received: from SJ0PR03CA0102.namprd03.prod.outlook.com (2603:10b6:a03:333::17)
 by PH7PR12MB6737.namprd12.prod.outlook.com (2603:10b6:510:1a8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 15:13:51 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::f1) by SJ0PR03CA0102.outlook.office365.com
 (2603:10b6:a03:333::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 15:13:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 15:13:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 09:13:49 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 09:13:49 -0600
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 07:13:45 -0800
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 13/16] drm/amd/display: Fix system resume lag issue
Date: Tue, 3 Feb 2026 23:01:55 +0800
Message-ID: <20260203151229.3673042-14-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
References: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|PH7PR12MB6737:EE_
X-MS-Office365-Filtering-Correlation-Id: 184426e3-ba4d-42f7-e6cc-08de6336d679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yW3uPh8SPRdQ31orxPar4Oi4t7LRoU2Bh5SRfDJs5GOe/ntjq76ymgFeIla3?=
 =?us-ascii?Q?Rc8Su+uSEOXwvO2W3DOMLwNr2OnHoXIkvA1W/HeX2Miqn+pcb6LQ1PCJzv1s?=
 =?us-ascii?Q?tbTKfNAQPB8K6tYxH9rQnfzFfeZq8YlIZRRxQXZN+8yyLxSfKfJo2uu6irbg?=
 =?us-ascii?Q?aHoEse4cVBpZH/jSF1s5bfxIlrwmlF/yWX7hbJqlvncuAl6d2SKG+dIML7F6?=
 =?us-ascii?Q?HrOQwsrYOrurvI+zMyy9/a6vO+lG3RhuhZANn3QGU3o1vCZrnQxO75BF1ayi?=
 =?us-ascii?Q?w6gE9+b9ed9MQDv0EgHysJFImhhJl33zE0jgC3Ixzim1YVLneWz6kmv5bJJi?=
 =?us-ascii?Q?J57xUzz0mbrX1xOc1ukN+sB28l8vMls8S7YNGZ3Rtglf+SjsGmk73ifSCjrM?=
 =?us-ascii?Q?HmKAP1nC9MBDx6bUws6fE/2KP27WSQX3/tSmUj1z7RFaRpEZ5NoASieZOaX5?=
 =?us-ascii?Q?oiwC2FvdoxwhQhJmQmRhyQlQnFLfUC9Czyxd5vgptfOJVoffLF6fyuudxasY?=
 =?us-ascii?Q?bF136ri0jAbQxUy1O+x3IGOH9L9HDhrYwkifkfSum+/bv3DuMHgBroCSyFkS?=
 =?us-ascii?Q?0qPZKuWhPdPl8E2Wn4utgaZMeSA+USwgKfnlUmGXhCLcxscUODE9yvhY6TPF?=
 =?us-ascii?Q?pk9mRgZ5YjMOn4WVyh4puPLB5BQ8uO1r7ntQEueMcKU1SetDjsVp1UZkiavr?=
 =?us-ascii?Q?lvB/a1+rEFfsPJLuZSb/VUehscN2m6wG7Pb5mQwCU3Y+0V7MDh1gw+CMW9Zi?=
 =?us-ascii?Q?b300aXNv9I8vEdzLJcvyZuXxqMPH73fztmdevel4QztlW9TZl2QjkhszPTJB?=
 =?us-ascii?Q?E7EuWuODJwRthH4wTs94ZaKEWnrue7D6VhWrsw5dNLzpOPWkArSL8EdpVxNf?=
 =?us-ascii?Q?pwUUxItTFUJjxcY5fB6Z12k9vL86715KrKm2t3YlBNDpPX8PRGRDWIRLEyPu?=
 =?us-ascii?Q?UPl2RJldejIwb1iIrE/PaUZI3h54yxsrj7lGm7vrZu7mW1PYKftm/CXPpIEG?=
 =?us-ascii?Q?b9FfUoayoR3JX5peyg467YeRmoHfGAwKzt+uTJ/LyBz7QVs+Sp/cNpiLghqo?=
 =?us-ascii?Q?ttc/9rS/FPd+5bZFxC2iLnadq9Y17cfjsZlC5NUo0Z7/bzFH2WkEpZAhdgqf?=
 =?us-ascii?Q?ODiOrq6yrTL/Qh+JmDf35B+5qJpYcVArSbwMxpPIW4nZYzNl2th7U1pd6iBe?=
 =?us-ascii?Q?VvNN2Dt5R4RI22z1V8bKzLWzeCk2Bnq9ksK4dzHFULtm1rTxFA6XigFnbHwe?=
 =?us-ascii?Q?Q0z09HZxPmUjNtPy40n9t6efmbR8Sd3xylnSTqYOSCUnMN9FhAVJhtAknFfe?=
 =?us-ascii?Q?ncq5Uv/9ZkglW1OpKo/ddDQk88VUAs91zy/3V/R/3ek/Fuht0PqvP+HXPizj?=
 =?us-ascii?Q?vuUZoz+HoWeUmd5cKGfAztwQZ9HIUriVsi4b5v1Ae/bZdBD+A3Fr3Twt0iBy?=
 =?us-ascii?Q?LmZw1dp2xmE3OVDzV+AVtXX2qgSBIhdVE8khPorb7Le04IreUQNofNiMsmGk?=
 =?us-ascii?Q?M495NKB0Cw+TSfhesmq7qJ7cwGScMCpSVGr1h7d2ynOU8Rfh3PVRZfqnDe+Z?=
 =?us-ascii?Q?EGV0iOfGFucSOkCBK5/R/vroCHlgjY9SvCL3LxiOM5/dUcSEimgd6yfBrQNj?=
 =?us-ascii?Q?8L1rJpKP7jmXjCb9LzgXRQsTQXSisrQiYm79IMbGrX9PI9Uglb44q7TLHS5s?=
 =?us-ascii?Q?d8YKKg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /a1D2uqXiFVkpOOzpZTTvrB8fnV3DLlCQjfQZeAsgpjjZ3658EBKpmavAqY2jDmZ81WE7PgwPmruEXfiaEpra3SU7MxKaU7/0Xq5GuHSSBjj7tCuNsO8LBjOg0mH4xrbR3an7P2xY0pdvjFGmzrNorbThp90YYW72L/ETs+uPcoey92MZqJrWfNGXjHFv0Zt+6Ewwje3hIjk4N4hGSgtT1zVOyzYfMWdwVJvwtRDzqN8NTlnnL6pahO19ekXwZ6JbObyKKzLGQJnlhqv2mY+30GV9P4ojAuoXdKHbeYavzZUspY0dVTmMvVvACsyJeedMSOggjsoYr/WfNDH0Jak8qcKeJyfGnVlfxrmamtPX4vgGd16U19sNQzsP3BArCPk6nDAT3pqlXIo8bJhdXGYC3e5fYFV2LhR7krr2NEgSBIKhUdHhIgQTW6cXvXMH+kR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:13:50.9756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 184426e3-ba4d-42f7-e6cc-08de6336d679
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6737
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

[Why]
System will try to apply idle power optimizations setting during
system resume. But system power state is still in D3 state, and
it will cause the idle power optimizations command not actually
to be sent to DMUB and cause some platforms to go into IPS.

[How]
Set power state to D0 first before calling the
dc_dmub_srv_apply_idle_power_optimizations(dm->dc, false)

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7af538adac46..3dfbbf66bcd5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3479,7 +3479,17 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 	struct dc_commit_streams_params commit_params = {};
 
 	if (dm->dc->caps.ips_support) {
+		if (!amdgpu_in_reset(adev))
+			mutex_lock(&dm->dc_lock);
+
+		/* Need to set POWER_STATE_D0 first or it will not execute
+		 * idle_power_optimizations command to DMUB.
+		 */
+		dc_dmub_srv_set_power_state(dm->dc->ctx->dmub_srv, DC_ACPI_CM_POWER_STATE_D0);
 		dc_dmub_srv_apply_idle_power_optimizations(dm->dc, false);
+
+		if (!amdgpu_in_reset(adev))
+			mutex_unlock(&dm->dc_lock);
 	}
 
 	if (amdgpu_in_reset(adev)) {
-- 
2.43.0

