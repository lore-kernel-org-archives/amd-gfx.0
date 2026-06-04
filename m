Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87875CD6E4A
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 14:55:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26D1B112840;
	Thu,  4 Jun 2026 14:55:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OSbnWChN";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010036.outbound.protection.outlook.com
 [40.93.198.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B73711283C
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 14:55:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=np3OIZ7uwtnEx24ESVJ05tJrvWsCaCV9N1DmMhA/UE61dMpVMPX1iqG4CVz8zzW4QWf6DkYVLHFqtC9yXm8ug8NgD4GfYS3hBusskR+b7iWQ7pHZT0ul3HEG8SJ6E9eWQnUj7j+Jzlois8GMKJaEFTINiJq6Lv0wkNpkY5xANJzbsvnA75Yxvso08mUieUlAxnkWN80GuizOO4XnV9CX3geCk8bF6awmKf8f9jPMM5mq7S6M9nQ8TGThZ86TxCxqYW6bvbk/h8ekRPOwdBnAukkdOzpvehCW4lz+cR8cocibwwd1/F8wr1n8ykRieisgLfnAil9nnCLNrgEPY/zP1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40HGRZGZSofwP9nJ8DWYWJaVYe93U/WkCkj0IQhcVoc=;
 b=aNe40K0fK2Rz7bUh73aFfa3d5h7cqeh5bHRtUiks66SA/gbRoMejN2EreXI0hYGoza3hv0F3aguLfW7qmxRM/04SuoPjtZL/Kc6bPzV8yvKyGPN04gB/NrcxO+MJY569TwTQ0BoI2IpboaOtUxy0RHX6ACq74ntqNUrC87469KlCeIyf4K0njP0eBuE5Z/qohCzh+f24c7I//oThGflXr4yWdp//QTORwRvoGKo1L/CWDELcUpGQ1M6wX3Al7HcUfmbswKAjT3Z8X+BULoJFNTKD3wHE6v9G8HiB46HZ5T/kiSrairjVL8hejLXWAuDLpKFkdgqb24YbXBMLYBo4HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40HGRZGZSofwP9nJ8DWYWJaVYe93U/WkCkj0IQhcVoc=;
 b=OSbnWChNu77bJt9nqVqVd908OdIRuJyVZhMnP9eigJpatJYBZ+NzUdlJ9cVSTu3TjJ0gbb99v/YQ3aQtRunP2iMplB0iMxafCs4z6xMFjNjtXm1PE3LTK8xbUkPolFU5huI2oXbOnizov2mHC23s+zTXfVvyX7VkOufcypcbtbQ=
Received: from BN0PR10CA0020.namprd10.prod.outlook.com (2603:10b6:408:143::11)
 by CY8PR12MB7292.namprd12.prod.outlook.com (2603:10b6:930:53::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 14:55:16 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:143:cafe::6d) by BN0PR10CA0020.outlook.office365.com
 (2603:10b6:408:143::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 14:55:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 14:55:15 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:55:01 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:55:00 -0500
Received: from aaurabin-tumbleweed.king-squeaker.ts.net (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 4 Jun 2026 09:54:55 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 09/24] drm/amd/display: Enable warnings as errors for KUnit
 tests
Date: Thu, 4 Jun 2026 10:52:03 -0400
Message-ID: <20260604145428.809959-10-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604145428.809959-1-aurabindo.pillai@amd.com>
References: <20260604145428.809959-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|CY8PR12MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: 464f5056-789e-402b-a438-08dec24949bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: T/uvCV8UbXb8mjMxuqLlvMbjiyCeBb6zQ16hhGauM9sucqunr96Oa/mIOAv32Rbf2AXgAH9nKVzVzGVrCfsDiF1xIMx9IKeRBPtwIyjZpBvM4qUxDxtK75th1yMnhIiC3OH449pgy0qOLm5NR/EG/dy7tpKY9scj4dvHdwwaaCtopt0U8vkSOdfd5zNdf6llaZ+Xlg0vWEYxwbvtSCKodD4AeCn2/cFquKhHmxDf7ru3hxhNEwDtVq8cfJgaZ5H6GKl/YTdzHM+KL6V5tW9nlKbiV2XKzn77MiDMO3eYztdKKqZEEZefLyiwPRtJyAV87YRo6MI2BaGhWnxQo3C1RznJpSQ4h4AX5z2SGXfFCrfCa4PUqPRYe+C8Q8KPDdyAfqSsnhy0Ah7IU83mYMeSgDVYdhXTy6/7GcQ5Ry7VBdmsgtxXFe69X39HGxsRElb7NeAe1tkDcMzTw2y9izu8mnr4qtA1KsLqgQWOIexOXS2YCaxqLgCNbVX0wXMD80zA93ShPqe6jLdPH0I44plcVYoi/83+oEmoXQxv0quSnu/Kz8UtFd5zWz49Hnds0HFlH+QM41hEaHit0uwdRkc2Vog6hlvLnHMqB5nwq+61HRPWIWHAujvWbmjUJApeICCecv4FMoHvUNJXfkoJL0AsZT0hoMnwMsxAhGs+vVB2tN4ZqILl8emwwSksIWi321Yh8XULFBpvHC8VAGp8wcIZTiFbvISgkvU65m8S5N/4y/Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RjB4lLopu82HSmNScEuK18+5aWV/Rhh4P6x4oRQYckmyeH7CZQlkkiwQ0vB0Tp147JPZYqDh+O+dq3+ecCPnoKnMmUfqG3qKwatmlM5sDShefFSGREeWyNV39WcvnFOqDjB1EOA5APvZ7Wq0qmBFKojIV9sXP8RemfFstvxlGLI3Qasz05WyDy81GuqKg3rIP8faDbIsDX2rhFrAsf1FkQqHupLGh38o+Z+0RWeP77CEoCZCmVQNc/BcSSozj617pe8HF/KRrOvXTGw5iRXovv2MvZ2b9XxKBLCJjv+CJo7bVCKOjC2235wpxhG0Ght5YgX1FPwTBWpq1LsKcPv1caqBroE3RMJIOnZrqCZPhxfeme+/AE/4F0PQb0Q60/BiXdq7jzK2dPxQBKnljyMiXQEJOVg3JA68245nFJ2Xz+tbJF9O7i/t8EX2hNd5Uhbo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 14:55:15.8183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 464f5056-789e-402b-a438-08dec24949bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7292
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Add CONFIG_WERROR=y to .kunitconfig to treat compiler warnings
as errors during KUnit builds, ensuring warnings are caught
early.

Assisted-by: Copilot:Claude-Opus-4.6
Reviewed-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig
index bd1bf8d959f9..1e93bd8b44ce 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig
@@ -15,6 +15,9 @@ CONFIG_I2C=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_CRC16=y
 
+# Treat warnings as errors
+CONFIG_WERROR=y
+
 # GCOV Coverage - see tools/testing/kunit/configs/coverage_uml.config
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_INFO=y
-- 
2.54.0

