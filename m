Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5305105A591
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 12:51:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50BC610E9DD;
	Thu, 12 Mar 2026 12:51:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s2xgOEef";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9235410E9DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 12:51:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOn3um3lZTchzDk5uvbP4TBIzO9Z8eqaweDEzHvBA9Zu7AYBf8mFx3bsoQ6vYBTSaJfAc5M+Uq82SVK7RKlQ1aUMldOSX2DYbyZ41qksQhbK97PRcfDH8sB01pKcCovZAeUhE67ZnwC+Iq/Ux3Vvw0rVQBMB3Qgvoad2c3YZUVVoWTyGEpUz2nNhhukQWuTd0P4uQl5hNa/8BNnfgWbVQEa7NQoql+/GQA7iKtTxBqlsEqHeiZBUhkDXUA+APOnYcr/CahUjpITjyRrI5JReRTI3Qo7dpTJ0Zrfq88XyYcVRjyNkC9aEmhf5o4HUkpPXKtXwBvGiFcXGNzTiTtcfbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMZoLs9ZCGkrQ87A9MBqndZlxsySHZEFnbOm7D/93Y8=;
 b=y4kynM6woPQIxdYIEmHhhh7ZRbJ6fu7PZ6W7dONC+dKY14zJJmBLZmxNDerK/WGOhcN/xVsCVh3en19Qv0vfbGr7Hr8hSpvddC3gfF9OwQpP2eykYf+uYzpikNlxKuJhcwMBWNYJnpNzG01G21WOC4tOFq06RY1kiI65mpfJMjYgc3VEGGX4jhv9X/ldEPaeG8Vdychf5enkK0PXmpNciRxvsLrMr1eeNbP2ccOYO5hAecvxrFZQ14BJyQdqnSNxNJ3Kn56imPJVbu7NVbj2Ul+j7jLk1ELP82C5ex1s4n3RyFJ1WJIe8I1KSYqdt4mm8QoWfqFJX/3L7DCuxrJBkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMZoLs9ZCGkrQ87A9MBqndZlxsySHZEFnbOm7D/93Y8=;
 b=s2xgOEefP44DQAls5lypATNa8BcYWDXLURbaw6eutExOjCroy4OR2nZ3mjsDOvJQArW+uWqpMtLUWzMM3eCLURVGreHkQFl/VtQXPtvwSMDUCJ7SyGPR0oR3Hqp7Yarfs8x+l4Jfnv7Jauhv8BNynYUZF8hiP2B5cL3qkGUbY60=
Received: from PH7P220CA0098.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::9)
 by CYXPR12MB9277.namprd12.prod.outlook.com (2603:10b6:930:d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 12:51:40 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:510:32d:cafe::a1) by PH7P220CA0098.outlook.office365.com
 (2603:10b6:510:32d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Thu,
 12 Mar 2026 12:51:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.1 via Frontend Transport; Thu, 12 Mar 2026 12:51:37 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 12 Mar 2026 07:51:34 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Bokun Zhang <Bokun.Zhang@amd.com>, Monk Liu
 <monk.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Pack VF2PF ucode_info entries to keep struct size
 1KB
Date: Thu, 12 Mar 2026 18:21:21 +0530
Message-ID: <20260312125121.1838642-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|CYXPR12MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f7dac97-fa7d-4a58-1602-08de8036196e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: xf9iV6KlWgMYuFMM/bgj0IHCxSSMf14Jz5TqoSjkd3oEhBSIE0Q+GlNOuJ7MTg+qn3+BfvvpI1rRKP4AhCwvJKYQpwKYMd2U5/zzCdzlmOb0IFR2EEiZRpEyYVFTbPGKBSmMr6fZK9EZzn2DRRefZM+2wN8OaxkhrDJ27XApM89s0Hu3rSWMPrdAcmfN1lrFdmU1aooJv9r3KRG6j3kZUNRRsdze6bZNGoJXxKRNI7no8uH8LiChHLYHGaJjhcquP27s/vhM7RD4UxOdNpQ/lhFADSdKd3NQb7i3GZY1F08LYQwOFL/HeQ6pOFP+Dii2IwPiyroze704ylNeMCi2k8zgQgYvWLuRDEcowNnHQMHdkgm8CJ9n2JGpFoeonn19OD/hgOGMponBSi8/D3ULoiRRhHkzBSUwAXqO458t11jKFsr6B8sLdL3Vtk1PNKnZt8Su8kqAve19MJWAANgGwNjUxQALXEwSAFq+FV9Ycz1WyNcE801WbbXNkNugRZFbDDHFZZVqDNFYfH21D7/NAMXRcv/ppowy3XiSWgsQJFLhskBw9+Lgn9iwX6BvqN523rZugZ5BBM+beSlGybK5b+KjMyv/FM4bFDBsMmu2JBfZuEn5Xqo2cClq1bG7tEL+ckjVxF3tYUK+iKXS7zsP+NzVw93eSL8OaggpjmcsWrvfGrAGkGYsGyi139gesJnZE3obl1sDHsUZwZhnfT9aCQUlrtL0+2Sa31AiHjbvI8ffikRbGG5uZODRB+lIi8ISlngV4fe26ulS2AJs1YeS2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N0Lth5ZTqLLrLsmt4yRKK+PZ0PQuIcvLTtFrjMtwHorc0vIlM7GWj9cI7WOj9vP0KDNQ2rDxkwi0kfJJdGa0L2nNErwSpd/f3rXGelUJELSoQNY/jBY9Dyinj9nFNCKm2Clk0pGdbzK9vXLOEblsTiRPat2atBRzUTmniKnIaLi5DyOOUR4rVI4/rLWvoCKI1Lu9Cqg2FprNFiNs7NlJnHCNYk7bnJa5NLFLsWrVEfe0RR6/cuboGJ9sQdJ3Xm3N0sEDPZR3s4PS+NGa329QS9CN5XUz9xaGdvlHMwB+/WjjEvEU7wjA1DyFcwITjZQWstPH8wOqsETooT4zeUeMc04ov1e0Ufg2M9OUEmMj80K6+TxYxG4qCcnuN0E7RfkkoGgw3JAGoYdKfpYlY/MwWtSmY/cmN+YDsLx6PiuB2goxMSeB+kddAe9LZ8Metotp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 12:51:37.5079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7dac97-fa7d-4a58-1602-08de8036196e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9277
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

The VF2PF mailbox structure must be exactly 1KB, which is enforced by
a compile-time static assertion.

The ucode_info array currently uses a small struct containing:

  uint8_t id
  uint32_t version

Without explicit packing, the compiler may insert padding after the
uint8_t field so that the uint32_t field starts at a 4-byte aligned
address. For example, the layout may become:

  id (1 byte) + 3 bytes padding + version (4 bytes)

which makes the struct 8 bytes instead of the expected 5 bytes.

Since the structure contains multiple ucode_info entries, this padding
can increase the total structure size beyond 1024 bytes and cause the
1KB size check to fail.

Define the ucode_info entry as a packed struct to ensure each entry
remains 5 bytes and the VF2PF mailbox structure stays exactly 1KB.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:510:49: error: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"

Fixes: 1721bc1b2afa ("drm/amdgpu: Update VF2PF interface")
Cc: Bokun Zhang <Bokun.Zhang@amd.com>
Cc: Monk Liu <monk.liu@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 847cfd1fd004..31fc54111519 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -328,6 +328,11 @@ struct amd_sriov_msg_vf2pf_info_header {
 	uint32_t reserved[2];
 };
 
+struct amd_sriov_msg_ucode_info {
+	u8 id;
+	u32 version;
+} __packed;
+
 #define AMD_SRIOV_MSG_VF2PF_INFO_FILLED_SIZE (73)
 struct amd_sriov_msg_vf2pf_info {
 	/* header contains size and version */
@@ -367,10 +372,7 @@ struct amd_sriov_msg_vf2pf_info {
 	uint32_t fb_vis_size;
 	uint32_t fb_size;
 	/* guest ucode data, each one is 1.25 Dword */
-	struct {
-		uint8_t id;
-		uint32_t version;
-	} ucode_info[AMD_SRIOV_MSG_RESERVE_UCODE];
+	struct amd_sriov_msg_ucode_info ucode_info[AMD_SRIOV_MSG_RESERVE_UCODE];
 	uint64_t dummy_page_addr;
 	/* FB allocated for guest MES to record UQ info */
 	uint64_t mes_info_addr;
-- 
2.34.1

