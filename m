Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F619CA0EE4
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 20:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21A7610E7E6;
	Wed, 20 Aug 2025 20:21:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="daFJyXIi";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 741E610E7E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 20:21:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2EvaN9nDF/aQjiRfufBQGHSRY07jBgQjiHq8XZgVtK0a8G5zLvBO+FXcK02FTVdH1YEV3T9v3ecyWd42txnYGPyS7CVp65CYVuAnOV4E3kgKIcspibNAYjZAtn7Y3AO4zgvlE006OGwFhK5vxKlQumsNZMbybuN7trr6DN1AHb4oLMidchwek9cpO0iSMveSEd1YuZu+7A2L4oIeQzJ+xoszzH/qyMIaL8SOr3vPQZ8Cq7LISVDOZ1XUvsKKMhsttPDjHtZK+S/RhGYsmu3pcYJKLHesPkSQwOkAx9G8zHHPFvcIoj9dykph8eseMEZNDqiTIctJO8+U6SzRPKwNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OVl7lrADhEhopJ2ceqav9o/Kl72ZEbS8KwdXUuJykE=;
 b=VAKlwJ4vU+bIP/RqjCYLndXaUyocXgkAkYeaFnNopgN2yCc+bwFmsAxpeSRqk2/PSiOhJoMx5l5NaR+zSSBHd3H81WAeccRrFLiqMN8mvb5LDeQ0fGwDWegXCyOwSQZUKA65ZdCT/a9FHFq8RWCiDjsti1sRMnRQ4DanhXEUdeWEj8sPcSgPQXKuE5UPXdU9jqyasnpZ630gthOcQzevOl4NZEYTm0ATxrKTeRrLsw2w+bisaHOoHgzWqixBU/+gN5HReJP5i1APQzr8XWURpFJtA7aOp0DYm5A+nLbFmxgcTurOjRKCYRFvgO7/8sOdkMe3LLqA0zoAr0pYIw3n1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OVl7lrADhEhopJ2ceqav9o/Kl72ZEbS8KwdXUuJykE=;
 b=daFJyXIi2Iyy/s/g4fGuNGGlzgN6bVd6PjoPMhfM2LlVohGEE/apmaOzhhFaSC58CER++wvbwR515Y5m1p9IxoYqH8jR1Zfd9cfiPbuZ23pNfLdbQ2FVkZGrxeuS2oHAZCxalh2tnyfbH17Xpjg+L/BIWCMQaMlvqXMWxv75BhM=
Received: from CH0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:610:b3::10)
 by IA1PR12MB8406.namprd12.prod.outlook.com (2603:10b6:208:3da::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 20:21:11 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::1d) by CH0PR03CA0035.outlook.office365.com
 (2603:10b6:610:b3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.25 via Frontend Transport; Wed,
 20 Aug 2025 20:21:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 20:21:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 15:21:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 13:21:06 -0700
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 15:21:05 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ausef Yousof <Ausef.Yousof@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>
Subject: [PATCH 03/12] drm/amd/display: track dpia support
Date: Wed, 20 Aug 2025 16:19:53 -0400
Message-ID: <20250820202103.1122706-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820202103.1122706-1-aurabindo.pillai@amd.com>
References: <20250820202103.1122706-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|IA1PR12MB8406:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b77a091-8c27-4087-562b-08dde0271a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yJ6Ogy55MsMayk5Cp22iBDYsaw7fjWUCLZ1Ny5t3tJFXdSbccOwAsbpZKj1d?=
 =?us-ascii?Q?pFepNzQN97it/2e9nz1ufLnQ3fIZxfdnWCvlvwnVUDn1bnr99hizpp6kqnJt?=
 =?us-ascii?Q?B/dYDfTOFK30JULxiozRJIAxw8CVtRQel6oZ06ZSbZctq5gZ+qWG+ddUZDxZ?=
 =?us-ascii?Q?0I/Ajv6MJaLkzK0hBgVUEfT9d0GIDSq7cX81CGoTeaOApsMvK+OCob/hYVVz?=
 =?us-ascii?Q?j+AdLcf8YuxeOIjc13O772ubxs+/HW0NWUdyu3lVUjTtngPPEvHGu2sxWRhx?=
 =?us-ascii?Q?ZJMx8UHEwdrhg0N6zn3cYYVoUa4zxGvRpGp0FvNoAlKt1KkDsUcN0G7e4Pun?=
 =?us-ascii?Q?5Ho9pzSd7R5LhRcqtevksCAeUJrmI440jkcyUyredqZBtjD77AX7pWyfxipe?=
 =?us-ascii?Q?Mpnfu/iMAjiWlpUP5QZBRQHyEBh+V7QAIajYeVZMO8WHDBeZKX/QHxP2nxkK?=
 =?us-ascii?Q?oCl0XfUG025m40MdFNKpBZfXoIdTJ7kN1T4W9Fw9PCXreU4+nxVs9pSymtNb?=
 =?us-ascii?Q?Q2Ms3ZWdmH/x5gHgCmEErQQUpWg5kwSj1Xqg3YjEREHo6YQcCHc0E80xuj/p?=
 =?us-ascii?Q?rxIgKOoQp3KTE8A+e1aVyLotRNMGoFaZsbSgLd2YRRQVfyqTYcj2jihua6ev?=
 =?us-ascii?Q?nvvVMBEdvem3EcVI2nNtY86O79N2zf+KHSQhZ8BcLfyOkSB0mDQO2fOwJqTF?=
 =?us-ascii?Q?JPNKt8ceU6BDlYd3qSjaKXv29hvTEwq6q0fVCCEnVX18l+gM0+T2LbSSO2rk?=
 =?us-ascii?Q?/atkObraWtuHQr7IN0BocChLvG9faEgMOKukKcZqkCvG7ue4Ds6sy9uyfSTU?=
 =?us-ascii?Q?TWPN1XM+IQM3u9XRYnPw5SFx0JeXnVZza1zHAXs7J1VY5pvxC5v+PXBuNOYd?=
 =?us-ascii?Q?si6Hcw5Ix612/NlwptRnb9DPNi9g0rZ1hIgmL9yIZ7/dIrWOu3oPZDyGdxIZ?=
 =?us-ascii?Q?z2NgIkgzkT8Bc+kPU0kIeUL47ry4nvpKwMSt7T09VfSB0f3ViJJllQH0o4nt?=
 =?us-ascii?Q?YKZqbW1AIVItY1seFQF4UkpN912wbe8MjU47Seg7kWv5BYRd+KJUBuOU/9NZ?=
 =?us-ascii?Q?xYZqGCaLfpZ+qL0H6C+t2O2TizrN0qhTYWXgXx3TBpryL4LtmLwtFPcajaCm?=
 =?us-ascii?Q?3FFiANnWZz9aZupZb3+QALFtzOHGkZaqz8SEC6ddKcU0mlq8nRScRLghYB+J?=
 =?us-ascii?Q?aBgoCq92Hi9Cj3eDDfd22OUM8IHjpUhh00SrqmW9jZND77lcWRhzo4IudR1K?=
 =?us-ascii?Q?n1yjFh77r0Q9loUP0gz6feETfL2heS4YUxz0UqaMfK6BpCMOmOUxhR0I6ftr?=
 =?us-ascii?Q?C+yFvTNnQmklb1B/WaXivVmzxzdogbK/rvXq8MuOGLzwh26hLUqeT0MN3kqb?=
 =?us-ascii?Q?I058p2PmgvVe5GM6N8N1VWTmBaYHjMbfANBAmdrPaLKZiqn9rjkZbVwKURMQ?=
 =?us-ascii?Q?glQ7fpTn72O35C4db+wWmAPZ4hWVzowiGQ/uYxJA1xAOtNyp3L5kZYhw0wSV?=
 =?us-ascii?Q?KXQqVyhOmeAMji8CvH1GM6pmgchJ7ADOoctC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 20:21:10.7377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b77a091-8c27-4087-562b-08dde0271a6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8406
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
initialize a flag to track if we previously
supported dpia and write that to boot options

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Ausef Yousof <Ausef.Yousof@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h       | 1 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 7abf7d0fd02b..338fdc651f2c 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -568,6 +568,7 @@ struct dmub_srv {
 
 	bool sw_init;
 	bool hw_init;
+	bool dpia_supported;
 
 	uint64_t fb_base;
 	uint64_t fb_offset;
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
index 2228d62adc7e..834e5434ccb8 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
@@ -400,13 +400,14 @@ union dmub_fw_boot_options dmub_dcn35_get_fw_boot_option(struct dmub_srv *dmub)
 void dmub_dcn35_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmub_srv_hw_params *params)
 {
 	union dmub_fw_boot_options boot_options = {0};
-	union dmub_fw_boot_options cur_boot_options = {0};
 
-	cur_boot_options = dmub_dcn35_get_fw_boot_option(dmub);
+	if (!dmub->dpia_supported) {
+		dmub->dpia_supported = dmub_dcn35_get_fw_boot_option(dmub).bits.enable_dpia;
+	}
 
 	boot_options.bits.z10_disable = params->disable_z10;
 	boot_options.bits.dpia_supported = params->dpia_supported;
-	boot_options.bits.enable_dpia = cur_boot_options.bits.enable_dpia && !params->disable_dpia;
+	boot_options.bits.enable_dpia = dmub->dpia_supported && !params->disable_dpia;
 	boot_options.bits.usb4_cm_version = params->usb4_cm_version;
 	boot_options.bits.dpia_hpd_int_enable_supported = params->dpia_hpd_int_enable_supported;
 	boot_options.bits.power_optimization = params->power_optimization;
-- 
2.50.1

