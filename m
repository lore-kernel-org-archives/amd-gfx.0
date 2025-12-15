Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CAED5B85B
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 18:16:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43AC510E4C3;
	Mon, 15 Dec 2025 18:16:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aJIjGhhk";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4216F10E4B6
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 18:16:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JbdllYho+VumG/gM+zPkYt4HXDRvtav7siJy8WltyEvAjh+oTsf79an5Dzg0GBsQPi8OLAR2wU3V2k0X9hGugMSyMcf69G+Ew9lxvFoefM7xeTxaD+D5elgOSKP7v4PF3JwUWPgtOjOYS5TPyPz4AuqGOk2GGrPbQ2TKIwKE+Cmdn7jPxGWD+2p321SJtNClhTp5rnKCdw2me0NcEre9E6kDcsDxgviaGk20rE0I2jVTM/deeQWs8zhsNbGfIbLGcBTff2efvKi+hSTk9AN4TzU0kIM7YA1UUDTzpkGN11JyYjtQA0TEbdei00+XhLiGP1aNCsoHykJuRoW7XjZnaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+h1qpEhd/HD6ht6gUAsZanYsG8KsEmUVNc1rfvEpMHk=;
 b=nf7M6Y2osHWb90rXI6NDQlbsKCi5u+iL/yo9c+k14t+jv+5g9LQuJ0MD0eo9KG0t5AQj/p22K1kxwEScqh0357tzDat5Wf0nfo0s8VNvMsxM+gDpdmFgsBTlzxiWuwcE3d7rE25+B1TjvzLSrspnWk968Vy4/GjYzHPdnEUqaJMTC+ymJrG/qw38vtZVQecAwRkHPl706vt00/tue3BN0iGy1pFFK7VgQ7jrbCXWYvVEtxgH348Ny8BnIj//XF00eb38nJkIdXgcusjr4HOG2Hr+jLM6rQk0DyNTPHka5GHO6iepgJREhxWLVEGk5Anbb42qw8UK2dLR+c4UbADeLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+h1qpEhd/HD6ht6gUAsZanYsG8KsEmUVNc1rfvEpMHk=;
 b=aJIjGhhkDzogW446yAWsF7ipQ1hz4/jtVs1Bh8dVC/9GXD+S7gtG5pRAXDRtitFduPHpMVErTazqU9+98peMKrKho54yterNvrqZUI7w+/whL3H0JO+n+K5N14+TN8tTCTxk7lAXyjqAQPAdNJWWwvmbVjY44EWhkmS4Wt+r3EE=
Received: from BL1PR13CA0232.namprd13.prod.outlook.com (2603:10b6:208:2bf::27)
 by CY8PR12MB7220.namprd12.prod.outlook.com (2603:10b6:930:58::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 18:16:22 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::17) by BL1PR13CA0232.outlook.office365.com
 (2603:10b6:208:2bf::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Mon,
 15 Dec 2025 18:16:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 18:16:22 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 12:16:21 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Gang Ba <Gang.Ba@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Set SDMA_QUEUEx_IB_CNTL/SWITCH_INSIDE_IB
Date: Mon, 15 Dec 2025 13:15:52 -0500
Message-ID: <20251215181607.29132-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215181607.29132-1-alexander.deucher@amd.com>
References: <20251215181607.29132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|CY8PR12MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bddd432-ffd9-4b96-f36b-08de3c060d8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2rkfSqmY3Pw5YRQEdU0YYBeuoTJPgNHp/SHjCY8FCnsX7pOEMmmWHheg5ymR?=
 =?us-ascii?Q?E0jkfHETxg903BqZHnXQcvC6q0M0qxg39q+gSHYlFobmRiVo7mdEvytS6aLS?=
 =?us-ascii?Q?dhe6/V0C2WY5Fgkxqnn0LrHshiZIOe1nLA3mMCqUvtXoTF36oQ/aWfRJ1yDd?=
 =?us-ascii?Q?10txd1zU8a1M1cgtizhvK0zLb1Q+al5uvlI1o9tqEVGJn8NgH3mbztcMbVSh?=
 =?us-ascii?Q?62BqZnyMUxhdLmC94hSeWgK8i2AVwuZM/cLA6S0sbMv5BiQIOJ4Eser96ot/?=
 =?us-ascii?Q?2xFkYbXNyV1nAKkVxT7byXPrUfGue0uzjYwUscdhrUs0pHJYZccSWddyHkTE?=
 =?us-ascii?Q?Sq2ypVOJxYDzIuwGjJduUcZ0QsNiLU+C+ZW4P9wEyISGl6y5GaHFaZ4Pm4Ar?=
 =?us-ascii?Q?u9fHY5mQSULE9PgiZGUQ0Lp9zbCd17lB/WtcyLE0IYfrRepM5V0MTEkGfp9J?=
 =?us-ascii?Q?cAapJiT2pn1pdfLmn5QBNX0a/tenlXyzm1RG9mdIslvbuo5N/5o0+JyCEL/C?=
 =?us-ascii?Q?+dtW+t8A/i6X1TQAKMVSOyDty/BLorFqokjmfpcmLebImnYPa9RVpkz9Iion?=
 =?us-ascii?Q?sW31zEWu6egk53xWk+ff6oaL7kbMZxQTXhxFhmY//OkPJLypGIfCoV+FCd6E?=
 =?us-ascii?Q?kjziNQCYVHji3TtqbQrQe1MYhQe7v253ejBUYUegtBv+R9R8YssgSpxcZPOd?=
 =?us-ascii?Q?F3GuFM5D4YwORWw2nvy2XqFnVJwJItLzuOsN/9gnMQ41sS3och3c0pdLwleu?=
 =?us-ascii?Q?RJ/TN7vkB24NpnpC0w+rFmwwvDkk3x/MJ3BLUiR1ZcIvUIAiC0wU+fNJyjDD?=
 =?us-ascii?Q?NcHsUzlF3MHUJRGwyr9405qxNYbtf2W9P4K7AdNUgmQ5v5H4T2vKDkdgebnE?=
 =?us-ascii?Q?j6AkKGD53D3ItkOVf4ceLqv2XBxguji7sR3wICk1Ft8FOWGlPvTGraeIqGqG?=
 =?us-ascii?Q?ERFDi7qflfNKRXROkdUz39A+UArZ1gTdYa6WBtfGJIUXUopCXtGmhl8kPBhr?=
 =?us-ascii?Q?x0VZRWSEZzgurJRFFNFjaUSNJOg2iVc2iiHCJHbOYQiGErJewLJ6Og/VfFiv?=
 =?us-ascii?Q?+jL8sBFiwPBx1sWrYt/yXJylu48XHkXEboTjNMV6bCvYdOG9+DAAyuA3CfPN?=
 =?us-ascii?Q?69Y2Yph4vtJe0N8T09K3JpGSstfQf68OI7374fn+C2xke5AxbmTvPxGosCXy?=
 =?us-ascii?Q?JMwmkr1qujoKaxSPKvOmQ8unbaUbf/pdp9P+ANfTSCAYNypVPYJG7DEar1QB?=
 =?us-ascii?Q?o9GI0CUnZw/uIZIoc0ICTGp/CGRbe9j618oGv3ux4fem0OlxplLR6LIjO8rw?=
 =?us-ascii?Q?FT9JoYfrrXIugVXdMppZ5RKLaRmODk8ISW+tI/44XrsHAXybL+iVVVofxNAw?=
 =?us-ascii?Q?c+pM3gQN6JEzN6tDzWsXgPJbQdRqD++/C/GXljiu1gdaURdN/T26UQOOjoD+?=
 =?us-ascii?Q?D3wVMH1EP0uXUHPo8H6/MsI8J8yXs+ijUrAF6fB7NbjiSJu2ia1bSCEiuZT9?=
 =?us-ascii?Q?/lrmC4gtidsEfde02KFi3n57tb0AT2xGHlpaLNn0lVkLaQPgQbEWznJxFfCj?=
 =?us-ascii?Q?whDxDhpaIbs96rUgQo0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 18:16:22.7494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bddd432-ffd9-4b96-f36b-08de3c060d8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7220
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

From: Gang Ba <Gang.Ba@amd.com>

    When submitting MQD to CP, set SDMA_QUEUEx_IB_CNTL/SWITCH_INSIDE_IB bit
    so it'll allow SDMA preemption if there is a massive command buffer of
    long-running SDMA commands.

Signed-off-by: Gang Ba <Gang.Ba@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   | 6 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
index 565858b9044d4..729df66ebfb3c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -351,6 +351,12 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 
 	m->sdmax_rlcx_dummy_reg = SDMA_RLC_DUMMY_DEFAULT;
 
+	/* Allow context switch so we don't cross-process starve with a massive
+	* command buffer of long-running SDMA commands
+	* sdmax_rlcx_ib_cntl represent SDMA_QUEUE0_IB_CNTL register
+	*/
+	m->sdmax_rlcx_ib_cntl |= SDMA0_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB_MASK;
+
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index 06ecc86fcb4c3..9cc8a1ae88f9c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -363,6 +363,12 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 
 	m->sdmax_rlcx_dummy_reg = SDMA_RLC_DUMMY_DEFAULT;
 
+	/* Allow context switch so we don't cross-process starve with a massive
+	* command buffer of long-running SDMA commands
+	* sdmax_rlcx_ib_cntl represent SDMA_QUEUE0_IB_CNTL register
+	*/
+	m->sdmax_rlcx_ib_cntl |= SDMA0_SDMA_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB_MASK;
+
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
 
-- 
2.52.0

