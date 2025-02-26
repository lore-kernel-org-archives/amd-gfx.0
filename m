Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18A3C021B8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 07:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68B7210E866;
	Wed, 26 Feb 2025 07:32:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z5z4SvZN";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDACF10E866
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 07:32:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKpPzyjcod3IfDMjqxfLB8MQtBs6v7zM29yZR7qQw0LlJ9yNB27TC/1V/Z1R2MnSSE9TC4/DbuCisfUch/xaRRreTeNiEMANUMOmHkGA/NYmvYpuEjgx+DYBXtX7P97YnAHJo8wYb0lDfXFGB23h29eUTbqnpsTgS6Y4vwed5GNJR7LPOo6/lU0WOct30++r+GztArFKaexClVE3caYiQoKkPW7oxq7M3h3MjfSNch47SIL9wORR1hSf3OZsFx/8nsodTWfHPWk0xTR/BaubruyceSsNdS5KOJSoBKCXfB7kQxk9knZpyPvUJsWWvcwql+Sal51RN+Lz8dMOUliHlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJw5NcSphJM1kUlyUVUc/qZltzq1EakPCQFQZ4fvOzI=;
 b=h5GTinxrcNxh6IxK/BnTCCyQ25SpCz8/XV1UJM/EjV6OIxxbGWfcnWqHn2NjSb1MJVmfbei1vI8LMr/0rC7wM/60DgfQvw9U3sqen0JSHbIoXl12mQ7HDQ+1OjgN2ctq9HC25gHamKFgza1jKvytpRSHK6PhOtygm7O1nIaXki+1DiPliDZS7GrduSFrj8fI5i7LW6XCmYo8C5I4BH+JyO1i098yMkgYydfML5YUW4CmJ9lrXP0ZUD906a+NLJIO3f3sAfelQ9ac3rtMSYm5r8jeVI8cUzDJNGUG0xzhKO4jT9s9I/eQVK5DWvUgzEpxu7CHkE0OTBuN7He+FN4A3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJw5NcSphJM1kUlyUVUc/qZltzq1EakPCQFQZ4fvOzI=;
 b=Z5z4SvZNuyVIuAvMRweBKGVt7Q0rFe7eWC16FJ/TF4Lm86FoTrh3TRL6YecgVzjLKOOXb5m4XpHJKHzwpQ+0A3YcuMUnLH6FMjSRylmY7Phk1AES1of509n79munDiqEUx+zbKHEdjCOGMYq24o3yRGACHQroiyWDS+xmKidxK4=
Received: from PH8PR02CA0037.namprd02.prod.outlook.com (2603:10b6:510:2da::35)
 by SJ1PR12MB6364.namprd12.prod.outlook.com (2603:10b6:a03:452::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 07:32:06 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:510:2da:cafe::a5) by PH8PR02CA0037.outlook.office365.com
 (2603:10b6:510:2da::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Wed,
 26 Feb 2025 07:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 07:32:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 01:31:51 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 01:31:50 -0600
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Wed, 26 Feb 2025 01:31:49 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: disable gfxoff on the specific sku
Date: Wed, 26 Feb 2025 15:31:47 +0800
Message-ID: <20250226073147.517561-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|SJ1PR12MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e5a366e-8f80-427e-ad19-08dd5637ab83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GbGt3Kuov90CiYvhKcCGuw9JKFdumm6yWm3ujnsjyKeXOgExPVnCWUhvo2j9?=
 =?us-ascii?Q?CXWWB1bnOWM+jSOrQat8KNZpXZ3ggSNwXoD8WG+FUPuIY1bKd8fZ+mbHtEGu?=
 =?us-ascii?Q?zkLdXfFCChWPLtBtFxZB8HXBAwpKUSQP/SPjfpIMTp5msOX9QyTAM4mKtPIK?=
 =?us-ascii?Q?a0m3r+b+b55fPy9Y0OZz1Mmwq0AQGq9rWZPpRaGZBlTsb9yNzV3zez3tBKBQ?=
 =?us-ascii?Q?PZiXfoX+UsNNHSd6NOu6+eZYBZYDENpia3uQy5R4AX424pgFH6fdiS7GTLw7?=
 =?us-ascii?Q?1ZIwiRrT31j/xVTZ5ILl81Utgch/TpPnr1VcLKka4pSc8KIPgnozew9NNGlU?=
 =?us-ascii?Q?B7bdsoenL8RDV8c/mC98Rq90CUTv+WM72eJy5p/6ZmB8TxJ9PT87UPpMGiqZ?=
 =?us-ascii?Q?LqtUaISBoS086RiVCxiEOJCIsVhjn6ZyGp6+JYxs3VfyYkMzoTdUXYB9JFRq?=
 =?us-ascii?Q?1FZu03HBHvUMdHtGlSFHitzOJIehu4lWtxaScu1WsSm7YrFlVZfAnGgr4d9Y?=
 =?us-ascii?Q?IINthTK6YwKcpdlMm4kqp8qYt8xun7RvGepk8Yy4fEx6/qWlFumbIs2Dj4k+?=
 =?us-ascii?Q?TCdbse0skl301OPN5Lsk4rG6UtoO987ue8camIa2wq1m8qbkDwOtGACbKkPd?=
 =?us-ascii?Q?eP/j7IxA9Z1P2NSha5ile1Yq7sUM5fay+bDsduqCTdObDSk2Yb5gqOOCFYAk?=
 =?us-ascii?Q?KCp79EJbZky8eBbFeZmI1WwI/bCHeatm6LQFmTGD9JADZcOGlysZeu0NEL0P?=
 =?us-ascii?Q?Qg7O718YrPDjdIy6DeoRMg6ELDTeuYjSpsOc+hWvE2/U257xXliJYzxqqZEz?=
 =?us-ascii?Q?RD2Xt6PikyJCXx5SCURUu+QpM8QksTUPA7dV9c+Vn9cG8Tmi2tmCLoKr+y+7?=
 =?us-ascii?Q?o14T+QvH8q4s/O5eNCHQ6xxVreTzWFdWKQ5OsYe1P1AUx3OxHo/3OrwmEL8d?=
 =?us-ascii?Q?EPI3JjtPo4MjA2gl9hN1hqa4vsGe0E4i3SMrH4GT+o6+V0Z1ScFMJ/uz3mRL?=
 =?us-ascii?Q?0r+Y4X2aMXZ+eyx96sT3drJkiOyFWEPl5X9UfI8rUs136P6MNl4V+SCI2H+z?=
 =?us-ascii?Q?/U9aACV1SPlcmjcPITKgDklu+htKaNy5gnzVs0DcEjIv+8iKbehwbMwD5vig?=
 =?us-ascii?Q?QuOcZmI+K7abvutVtmlcjUlTpn8ycIid71RdPpZl1H0frcZ6+fukbwPRAnNP?=
 =?us-ascii?Q?2O+EPNJo4u/md3Ysl6ysej3wZIC2pxXadd+3uImVUr4A8CWdiQfAGCaRmfE6?=
 =?us-ascii?Q?0AIygdDtPPSYu+Wc865YpUs2jph4kHNYbCY5MVdm3HpZGa8H5fng1cl8SPF2?=
 =?us-ascii?Q?CK2Gcq+AYPV4vQHxaTknH59pZi29439HussttwY0SNP9BCFs1Ex65Fu2BqjK?=
 =?us-ascii?Q?9lTi2n5uvmR+IQn2OlSFoBbYWtGDhl2u0uXjQvyybg+7BTAVPlMJ9yrqsTMn?=
 =?us-ascii?Q?uvLw8n20Z6BZ44iN/sfVxDubuufssKZJCk0Rcsnppf3vVXwAZk1/GIoPKDnZ?=
 =?us-ascii?Q?tzCYA7q7+5uW23I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 07:32:05.5795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5a366e-8f80-427e-ad19-08dd5637ab83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6364
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

disable gfxoff on the specific sku based on the requirement.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8cfb07549f54..bdff59026367 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -781,6 +781,12 @@ static int smu_early_init(struct amdgpu_ip_block *ip_block)
 	r = smu_set_funcs(adev);
 	if (r)
 		return r;
+
+	if (amdgpu_ip_version(adev, MP1_HWIP, 0) ==
+		IP_VERSION(13, 0, 10) &&
+		!amdgpu_device_has_display_hardware(adev))
+		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
+
 	return smu_init_microcode(smu);
 }
 
-- 
2.34.1

