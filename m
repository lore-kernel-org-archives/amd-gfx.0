Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC241D35660
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 01:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D26310E5F4;
	Wed, 28 Jan 2026 01:59:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NzJZFth+";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011048.outbound.protection.outlook.com [52.101.62.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C6B410E5F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 01:59:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s86EhRUScgTttp4QubU218b5SeV4CzcEMqtCBy5bC0Esz9vxbd9a0s2T5gZlQRvw3AQm5R2JhIcLoKhqROCZhMWBcrJOB5kyahoA7LbDkKCqlCnxRLN9j8nAt+8AnhseX3Eq06BBjXF1diRDE9+MrdimeAE9pKXTF1WcH3F5di6lP1qx29bhlioP5imZuM9FnKknC8KRNVJ35WqKqcbXkRWDhhqLPWkzQMEZkhiQ5qmY+pgfnRnL6j7bPGr93qxZHICzqEyJUKGj/ZQuqwmI2/xnpLuWRLCNyk10LtDVgcaYGFMeBou6tPWNN7Xrz7NSPJ6iqCw+nYQmzj/G4yCkZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=th4ojGaEorQQ1tKoYGZ1W55aoUa7MxgaSFUAN6H6bR8=;
 b=pabA2J8Xusvg9nQByh2545w/RFEUfeVMOFlyrKwLbyPbl/y78rrsSdh3fM367MQmXXsS/RuMY4x3Bdps1FOvkaOBWyg75FcmO+xMbmPaUiSehmWC4xuGaqveUbcET9IXNsV5fDAZKPxD/t4544ErqL95gTyFB4EUfGXEjLtoIZreTQYkdHBGm9nGNku4IVELlbwwEXLaJgt5cjfujuCIa7tKs+2atDRtb6XF9/W1A8ZhqbYkaDyy40QIA6fH3GEnRVnMiXa+q2a54fEdwdiOyQfk+1xabJwLec9De2nziK959Z9eS1kM8Bsi/lKjhtMzYGCKpYPgMFmYsH0kB+N+4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=th4ojGaEorQQ1tKoYGZ1W55aoUa7MxgaSFUAN6H6bR8=;
 b=NzJZFth+qkCbcriAt5HXK7d2bSZ/9NNPrLYqnTw6Zt7GJ2zZb4VTWYR1jgb7sYC3/wDeCBAkHDdIt3XYKbJI1qE+p7iPzIVkFD0b2y19+wco0NItw+h1xBQxmNZfXHjdvvnugg49nCHWH40U0IJuiYVJv2fP3cnnbRtzOwg2vbY=
Received: from MN0P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::17)
 by LV3PR12MB9268.namprd12.prod.outlook.com (2603:10b6:408:216::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 01:59:47 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:52a:cafe::a1) by MN0P221CA0025.outlook.office365.com
 (2603:10b6:208:52a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Wed,
 28 Jan 2026 01:59:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 01:59:47 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 19:59:47 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 19:59:46 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 27 Jan 2026 19:59:43 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 09/21] drm/amd/display: Fix system resume lag issue
Date: Wed, 28 Jan 2026 09:51:34 +0800
Message-ID: <20260128015538.568712-10-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128015538.568712-1-Wayne.Lin@amd.com>
References: <20260128015538.568712-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|LV3PR12MB9268:EE_
X-MS-Office365-Filtering-Correlation-Id: c2121cb3-6428-4151-0a9e-08de5e10ea14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Aignxqoy/RzjLM4qckvh7GCRpq1Dj/qmxYNHY1viN4SNymHd2/q0bJjekLEQ?=
 =?us-ascii?Q?h1aqUsSaZluhQgqXc/WoMmKD+5wAhgPZSEThq9TmeQpqMFp1GIy90kR+McDf?=
 =?us-ascii?Q?v7zEhAq1ZBUhzs+/Ql0XxinNSWqkJDTGY9YKwR5BUfvNZgS9bWwiVLWI0fg+?=
 =?us-ascii?Q?TyleSL6LOD7spFaHB0e3sBi/DvPGAJywUj1cVgHUN57kyWfizXRXT3VsC5LU?=
 =?us-ascii?Q?5re36nyqe+XvlVboPJvmLMQgAV6WlZ7v6G0mkvNDPdEq/Ig0DW8Y9MM9RwSs?=
 =?us-ascii?Q?HmcKuErWQWPF15QpPJi0XKy7dmdFwHx02jA/VKidSuKAUtIQimQj4HJVrkoB?=
 =?us-ascii?Q?CIYU4VIHEh5CButD5Yg6g619AOg36wQZlTPOluwjXvCTWG1S/8Yp6kyU/mU+?=
 =?us-ascii?Q?igtuGndyUiJrybPsddGIVSCt4m3lBTbPArDjsEMycEMSCLBCaG4p3xvLJgCJ?=
 =?us-ascii?Q?yJsKRUuIwWAvyahzkQkucx2U8uOjpXMiTn+k5CTPSqL00GAQCQlyWn1BU/XX?=
 =?us-ascii?Q?cMNVbpx8TRbWDX8ii4VGJSdThlU8/eWkvxDk2fpTUKBxBdv/mUFFufr47Vp9?=
 =?us-ascii?Q?Dqm/ZxDd2OcuAWZ//pdcjl/cD5rYFmF19IQG/XbG5T8SgCU3J1pQ8D2e0MTQ?=
 =?us-ascii?Q?nglgmPZGzxwB9EQRfVUE748Jjk92VDTD1jz8ZVVNOzZqOIobD393tIOgqkWD?=
 =?us-ascii?Q?M/RoP0GY43ht8MUHusE8RXgDBCvNK/B1EaIR2rKY57u8Vmn9xiPamOnS+gxk?=
 =?us-ascii?Q?vDbjDuU0dF/0RofrdMLeutEoxjyKdSeF3VEJ3E4dSzD68cZC6ExkefdHq9XG?=
 =?us-ascii?Q?Si9MX4yV5rJHqGmsxPpQ0AN9ia+AW9OOwVvKwMbKkNamvnB2rhgflohbHqGD?=
 =?us-ascii?Q?WpObGqw4dcmQtS2jXAwL4/7UluRQHyPJzKPyndPGxqLqyYSopSQsaD7CFrAM?=
 =?us-ascii?Q?tfBHfibLj5t1Aor9f8dzzWOCcgluo9aTog6UEs+ITt0fcntNgUqLUM73bHVu?=
 =?us-ascii?Q?XXuxqDYvZ2AZfQDtL3uamaINNtnj/JrHfQGicoXCMD6EtZwZ6g2LeSHaSZvL?=
 =?us-ascii?Q?Voy18ZMczpUYjioeziYETmnr/zXKjW+9UUWNhgrRmQ5fTrL6KmXwM7Ie+aY8?=
 =?us-ascii?Q?+kXYwiIYIk/7WgTF2lLF+BbcNS7LM8ndOOx/rBrx/gu9i5Ts1yYqx7d5hJU9?=
 =?us-ascii?Q?rd7dK0Lt9zbP2mfkLQDjGgvsRr8dddo4sG6J379zBxnEXtyrTZXpbbAVzjs6?=
 =?us-ascii?Q?/g2cxjn7eGTV3KaMs6wK7rCGFBmO4XcW9XG9VRbwUeEzDbyWLuod2+OgsmCX?=
 =?us-ascii?Q?Ma4f7pZNyMUYnfRJB730rm6KoI2ebH9xv7/Y319ZDrd82Gj3rHwGcJX6/RJM?=
 =?us-ascii?Q?4mCdhWXuEnS9DXZR50Om7WEBDBfrCesFAOBgcGy1c4USVj3nsV+QesJhDxQb?=
 =?us-ascii?Q?zKsg1x/x1Y0vC1QtBTqXNp7wRxza9C1U4H4nVqifLNa7PO7EXyFXMR+dPiqx?=
 =?us-ascii?Q?D5nTah48CpjV3WHthVgOTXn2Gsh6jCl3tkEmz5wphdDcoHRHvjvmUXJlQYF2?=
 =?us-ascii?Q?+vYgDcuGFysoBii5t8PvYX51UL91p9TwOjaDff5x28caT9Bjz3ydfGj6eu+E?=
 =?us-ascii?Q?d/GzGECm3wquIq1R1wU11gWZugb8wIsEV3sPi6CZFzpGjkVNC3YPytK1UFab?=
 =?us-ascii?Q?AZq0cw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 01:59:47.2429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2121cb3-6428-4151-0a9e-08de5e10ea14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9268
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

From: Tom Chung <chiahsuan.chung@amd.com>

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
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 572998eadb78..fcc48994c3e3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3481,6 +3481,11 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 	struct dc_commit_streams_params commit_params = {};
 
 	if (dm->dc->caps.ips_support) {
+		/* Need to set POWER_STATE_D0 first or it will not execute
+		 * idle_power_optimizations command to DMUB.
+		 */
+		guard(mutex)(&dm->dc_lock);
+		dc_dmub_srv_set_power_state(dm->dc->ctx->dmub_srv, DC_ACPI_CM_POWER_STATE_D0);
 		dc_dmub_srv_apply_idle_power_optimizations(dm->dc, false);
 	}
 
-- 
2.43.0

