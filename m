Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB86C3065C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jul 2024 21:31:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2A4010E4F1;
	Mon,  1 Jul 2024 21:31:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aYu6b/T3";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D79510E4F1
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jul 2024 21:31:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQT4hvbAuZzaC09R4QrhYE/Xxdf7XUs0OEgWZJy1fzjLh9jLf50QNEUoyieWGr3CV/oA6XTRnSxPvirJvh8tNssEuujnynWTuuzHUW52sybpljZ9ljGM7TNrjAyB/kqpvYTFf3g9AjZKpLreHj0kdZT24sLda/YA321aOveFd/wTvplv1zbRNvFFxCMGEPRx3UTc0dUNOcKULt0p7a4DgTWqk/+1nkeMzPqMBB/lZE0ytb4an7LmMley27t19ndXazCwwwkW4d4Zdf9yzZYAcq+xN3Y24iJn63uFscj0KpsfD27m6VJjOqZMDCyA9eODJ/gzH5e16N6Ef7fjRwrIiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENKLqyfsVyk7xEwg9AvrDNouiclzx+wlat9NqoCbDAA=;
 b=Hk1r9blBunSCgmuV16v2rSgG5mq1EyDppieKHksmg4ppLN1ElU+p3F18aPtvqXkJy1x6wPEVSUUvmqw59qXQZZ/hLQnvK9gl3SKJP32MQDwZIZHFZE58gliZpVfwtOovwgeitkg0TUTcsBup/pTr9fXC5HQMyB4vEO6+uTVduq45SmlTA6mCE2jRZjg85I6oB1tXBSs1M3myl9OXtvtWM1Nwb5MtS8v4j+hfKTUK+M9wXIhfu6gmqMsgb6Ixkydm3Djs5LRH6bKNnYQ1C8Y2YeC6ATjI4T2oJAvVyZDBJxVuhx9VYEmwgY9O3c4yoXPFBwyqZYNYtzoSu85oDpBTzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENKLqyfsVyk7xEwg9AvrDNouiclzx+wlat9NqoCbDAA=;
 b=aYu6b/T3eMXDTlyCqr1Nnc8albU9/FeSjaOy6Wr8pXPc8NqsDfTUXzjJiw7+s4f/66QonkSRSEptjkdEq9zkDbucTLfEHgzRGUQHQRaPoUjDyWB1Db1abaBp7KGLOC50lsQOjCRA1wqewFCpAUBYbpLGJwnqkxzboVCxNrFMM/U=
Received: from SJ0PR03CA0282.namprd03.prod.outlook.com (2603:10b6:a03:39e::17)
 by CH2PR12MB4117.namprd12.prod.outlook.com (2603:10b6:610:ae::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 21:31:48 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::98) by SJ0PR03CA0282.outlook.office365.com
 (2603:10b6:a03:39e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32 via Frontend
 Transport; Mon, 1 Jul 2024 21:31:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Mon, 1 Jul 2024 21:31:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Jul
 2024 16:31:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] Reapply "drm/amdgpu/gfx11: enable gfx pipe1 hardware
 support"
Date: Mon, 1 Jul 2024 17:31:28 -0400
Message-ID: <20240701213128.7596-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701213128.7596-1-alexander.deucher@amd.com>
References: <20240701213128.7596-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|CH2PR12MB4117:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a25645f-faf4-4a7c-5ef5-08dc9a153694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WiqF4FxHsjA+3fq3U9SbNl/RtZJI5nPN60RKQKzGkjGj3uJ79X0QqMFJ5BRG?=
 =?us-ascii?Q?SDNXlDPvAKznynKWWZA1FcjB6NMG8qFwr0eWTm+rKtxvfEzi8JGLLH8x8IvX?=
 =?us-ascii?Q?ncQLsKHR4+sBvb6BwGWP8sjM2AzF3nUyQaKSx3d4XuypHiBLah/vm7R0pAPg?=
 =?us-ascii?Q?J7GMhoudx0weXz/McMLjl5KZSLPTGuAraAxfPw0ShklLUzEKgt9l9kWFAVQu?=
 =?us-ascii?Q?P8Z+2ksycPTjcDRPDY9S2AKWZ21Bw/5TcO0Ma23SI0fsBjsgkyL7Qb8PWo42?=
 =?us-ascii?Q?s/yJtKAv8tiZMHUI8pRZFsGQKxuQ3eLln9c3WUiOkudBYJCuYZ6r3KAuP4Gm?=
 =?us-ascii?Q?A3zvO+Vv/mVYGmJOqJPIaYsQi+vsp1foWqvWj4Q7FisNFV65HtpkQWtBUfWI?=
 =?us-ascii?Q?hAOGv06ng3EUMO0i7VQrUjojV1yZHimNrQXcUEHfaFEe1eQqMDnr7hnJx7x/?=
 =?us-ascii?Q?2MwP3l9cpeqEYhgcbrkrFucuNQIzBnwAu6f6Z1+N+wLIHBZ/OHJOdxavI7Fu?=
 =?us-ascii?Q?jxC2YEP/FUNDwP9fErknYWpzPRT+XrBr2edx3dfyZL7q0l/wULT+W4RQL2pT?=
 =?us-ascii?Q?m8gu8u63711qjlZbJF2scPsjR9fflI7PYJOjmgb2k/5PTpM4HVBXMz2cJmes?=
 =?us-ascii?Q?bStP2KdeGBA+gMm7/xjhC49QkOH2Rhl1u+9t4ZZA3qxUI0AseC8/x79+eegv?=
 =?us-ascii?Q?2hzaiNysZRdLCHqIwdvlx08H1S0Bsy1yE5YN6DVhsSLAjJyjz+6FG84C3/fv?=
 =?us-ascii?Q?7rx/t+ACZh9seUY03JQRxqFxL4O6PnJOq1c0l4Lxhq6THmge8X/FVAX+ZAuA?=
 =?us-ascii?Q?q7biAlmfbKw6+vcwkWhUz8qc2bItgL6BrCpd+09Fz3IrzPzKA54Vz/zTiaK7?=
 =?us-ascii?Q?MGhbCPLlVSyxi73S9C4Bl7lXRkfb0M6idC0cyR66XldxakcTBGa0ELTj5XLG?=
 =?us-ascii?Q?tXQdKVusGyb7771ADRzjDIp7sTdjQM8pZGmON35JxqAl9yc3b8JszQm1Uj/M?=
 =?us-ascii?Q?UujHFaBIuC9zwVSn8Qje/ruwfj/yIPD1lnU4oiggkUuOXbIomN/7aT3PhdOF?=
 =?us-ascii?Q?Y2L/uMw0stks8QOYnyWYJt7LoyN9g5NAeRJDeddGa1aaY01uppgzp2ydkqPi?=
 =?us-ascii?Q?s5gqTEdn8mEe+DAJBx65wjMxe2gDVt01vsNDjDEC5LvUAc50Of3ene6bXYpj?=
 =?us-ascii?Q?luSocAA4Oh0QAB98sX/lI1wLgguoL3K1le/q+I1IMxhpKs1ExzEFSswNwDmT?=
 =?us-ascii?Q?nmIJb9sNYLP6O59Ie9gpSeVSjnk1Qgg6GBLl5jDWlXewjb/sW+GiXFf7rsst?=
 =?us-ascii?Q?ls+0wjRAEPps/zsiurNO1tqvcrGQ1+5L4A4dAHA8WOR/sl5dHeTF5Ap6+0O9?=
 =?us-ascii?Q?MEw7gC5gKIHMXaQ3hB6a7mlCv8IZBgtF1/u102w+AxLkYN3pDc4GM3QL31Pg?=
 =?us-ascii?Q?lrWYHftoxWfu79NlkhB6dlJhfLoiioPp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 21:31:47.9045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a25645f-faf4-4a7c-5ef5-08dc9a153694
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4117
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

This reverts commit 28ebbdd7677d84d6d25ccff40ea6e9f01c2c8c7d.

Let's see if this works with the gfx pipe1 interrupts fixed.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index fcf31483ed25..91adfa1aa1f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -50,7 +50,7 @@
 #include "nbio_v4_3.h"
 #include "mes_v11_0.h"
 
-#define GFX11_NUM_GFX_RINGS		1
+#define GFX11_NUM_GFX_RINGS		2
 #define GFX11_MEC_HPD_SIZE	2048
 
 #define RLCG_UCODE_LOADING_START_ADDRESS	0x00002000L
@@ -1524,7 +1524,7 @@ static int gfx_v11_0_sw_init(void *handle)
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
 		adev->gfx.me.num_me = 1;
-		adev->gfx.me.num_pipe_per_me = 1;
+		adev->gfx.me.num_pipe_per_me = 2;
 		adev->gfx.me.num_queue_per_pipe = 1;
 		adev->gfx.mec.num_mec = 2;
 		adev->gfx.mec.num_pipe_per_mec = 4;
@@ -1535,7 +1535,7 @@ static int gfx_v11_0_sw_init(void *handle)
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
 		adev->gfx.me.num_me = 1;
-		adev->gfx.me.num_pipe_per_me = 1;
+		adev->gfx.me.num_pipe_per_me = 2;
 		adev->gfx.me.num_queue_per_pipe = 1;
 		adev->gfx.mec.num_mec = 1;
 		adev->gfx.mec.num_pipe_per_mec = 4;
-- 
2.45.2

