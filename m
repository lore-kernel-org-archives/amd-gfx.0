Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038DCC35FF1
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 06:38:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83AAC10E2AA;
	Wed, 19 Mar 2025 06:38:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jhddsMX1";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A9FF10E2AA
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 06:38:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTIY7DZbAJ777ckMiJELlpcGf8rPnmTRBmaGkdyfV6JSyQ9h0a2ctTXZcrJeg3jFfmGVNQjY2xsJNFovch5J1gJsrYLAwQgwxEiiROOwzc2SVEf8So6ZzCuXjtoSugTYwxdWIdWIsQMu6rjfSzo36Yf46/s1RMbCiD3c44KyeGiQfXjXu5TloFKBqdByaXd3sxBFXOIMTC8VP/YMBUHYEfVaZTJzrcZDjk20bS49dJz5L1TreQ+QvCa8l/sZ46wvL+lr9PLTuohJMe8Xn6gupU6kCzeU59bo3L9BCnh18JF+XJUHw/bOiICtoK6AqpWeHxSi0pZQAm69S1gO9aetcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBqecDd7dNC+o49BfbVt36Z6Iu4qn4oz27cILSwo4Ag=;
 b=lLgWIXi74bQMBeuW1oggbs90z1EkQ9jZ1reBjzvG6p0x8p0GF9QjyD8kjvrWnE3qOHzQjhLE+MKMvauA6XuEvQk6EHvDqBIRmV+PnGOUl8QsQeU+ZmK6YbjR7ckuQrUMA1AB2+NzJIyPvmHQI63E67Ln6MRLguuAlL0FAzJ41ymN6d3xpUxX1kf/BXux1ta6o9auTEjsKR7DmfmdorUaFY3YmFn7ct8hDIn9zgHxpo+Eh0o3ppGGrhIOBKv8mJWRwW+XAIDGzQCtH1vp2HQ6glE806rZ+4gA6x6sG9w3yqwBlfhoFG5itMZcy3jjseaBw4Dwy3VxITIeVsMmAeDr8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBqecDd7dNC+o49BfbVt36Z6Iu4qn4oz27cILSwo4Ag=;
 b=jhddsMX1gPyyz6PMfOfOMbCbCJumOFw3ZVja1iz9a7ec2ueaXTbfDfV6VivFtp+hQ9+E3/OkFQ+kGHFDLu+ZyUx79wgoCKAcR/8Tgrt4Cpgxo0LgnPYUMqlV1eq8Elz77jVyL3WBIu9hZmEdDzkFEyOncR3H4ZfS9JSddMWEIMk=
Received: from SA9PR13CA0176.namprd13.prod.outlook.com (2603:10b6:806:28::31)
 by SA1PR12MB6701.namprd12.prod.outlook.com (2603:10b6:806:251::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 06:38:21 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:28:cafe::13) by SA9PR13CA0176.outlook.office365.com
 (2603:10b6:806:28::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 06:38:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 06:38:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 01:38:20 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Wed, 19 Mar 2025 01:38:19 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Revert "drm/amd/amdgpu: shorten the gfx idle
 worker timeout"
Date: Wed, 19 Mar 2025 14:38:11 +0800
Message-ID: <20250319063811.680138-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|SA1PR12MB6701:EE_
X-MS-Office365-Filtering-Correlation-Id: c85cb15e-a3b5-4445-5a03-08dd66b0a439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jKmYLplbjkweaGDuZaZrEiuBE70GQX97ZpDFBDkvISeWADMLSxtAWn9Ubqwi?=
 =?us-ascii?Q?QTdpe9uz4xZxRHP/mXGlIyIBML/Z1U/vvFJ7n5+QzQV/aqgpc4fZpXY7+vzb?=
 =?us-ascii?Q?InyDHitOFtn8+VWuJH3y6vrbqjNcgiAJYbod5dOvfE+8fd/ZurqZtY6nDWRw?=
 =?us-ascii?Q?csOPoaTcgF4dZkHHSGTqgLOmcCEI52IpVQ+hrlUvcCIYQOElH7Fxa6SD0EDu?=
 =?us-ascii?Q?8acEZdjJ7ql7AXVhU/KIsYMFne2p64hPOhzSWOhhXpfM/HgMjCJdmmDBLOOU?=
 =?us-ascii?Q?ac8W38B1N+4KM0k/JhetfXmGScS2jRPB5CBDl/log+cCisW+3pyyqPtJGmyP?=
 =?us-ascii?Q?dxUBsomZIFCZTiloXdkUu2t8WglRHlKKWhfVEedCRPg899OQVJpyl7DwRtZL?=
 =?us-ascii?Q?Mo6cte7AodPQeS2hxGyoRq4cz7FmgyvLENo6gS7yeczeYxRDc2FJ92oTYa7a?=
 =?us-ascii?Q?vkAWVmykq0lvnRWfPMcaqo5o2DIRM1b45OnatuIMDbEFxp+kFPaR2U+M9LR6?=
 =?us-ascii?Q?sEOVlGXDezUDc0kR7vFLbQvlQeJBVC7UEzDLnMQTqJIuL4kFdgJwu21/mEuz?=
 =?us-ascii?Q?DLaMiys6Rgu3VV1lSYygNz9JGkSX8uWZKXSyuwsPpHL5eempGupvhHXX4oqF?=
 =?us-ascii?Q?zFppS282f1RiIVCJrOcaP/WsOf5R7Yo1UYRgFgwCGQGnNEoPqTBqJLUobJWW?=
 =?us-ascii?Q?+0pT4/037YqrZWgaf73UvHbiIQRgr2VsfY04LwNuma4fwV0oxDUMByJbebtR?=
 =?us-ascii?Q?ALjMh8HhhgcSx9jjidEAf6h41lolqwRq/+uFhIJV9snkQtYzyWET7JjPXAez?=
 =?us-ascii?Q?/n2V6Bz9si/YH0xxK/JGFm1FxxjsPdnFFldAIYQXKE/DXkdEXFmzzp/dZ3c/?=
 =?us-ascii?Q?AIz6eWcRc8FqRCJphkME7wDEXOdQFB7CG+HKHRupmcg81f54MBFwu7Q6g35I?=
 =?us-ascii?Q?e5sUTOTevivMmfoqobJQ2bEdW1+vM6b6jyva0904PHvBW7nE/n487scRw+H6?=
 =?us-ascii?Q?dyX+e8Q681JoucICxEhCfdS5HVaf7CR8lpOLHfD8rTRIhaR95JReb/lhQX/E?=
 =?us-ascii?Q?/cK9erq5SDlNmEdWk+40MrY0Zau4GHkiE5Hamu6runNXnp+G12/7XfMD0AqD?=
 =?us-ascii?Q?MvmI/Y7jbb6vfFM7AB0d9k1R+hsesWnXPYOQkyy3sk2LDrqNvAPwr1mppuqd?=
 =?us-ascii?Q?hXbfG+009SyDnMWYY9OVeh8vb5jNSGIcWCynANVyfBGh5Fz4jY4/ESQmshVk?=
 =?us-ascii?Q?6IAFGOd5jMytWAzvYGAWrxqyx4NRtD+KbHcBeq4h4i7UIWHwiPWgP2l8st6v?=
 =?us-ascii?Q?NYatWJTQheOe2t3PKlvr8OfmKxkFoqPXMFfvW5hhPzUAqJbUmD2kw1vkvnsA?=
 =?us-ascii?Q?zZqgnbMJb6B8zEiolq/OahKtfoYD9mev7ERcDX1lWLPYjVPxjxsk86Ig+hnk?=
 =?us-ascii?Q?JIyPPxAEHelW6eyA3UNj02ROv3g6RXDTrpC6678xJ8lJtz5UrYppZhg9mpoX?=
 =?us-ascii?Q?dHFSsPJTl+rr5Q8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 06:38:21.1196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c85cb15e-a3b5-4445-5a03-08dd66b0a439
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6701
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

This reverts commit b00fb9765ea4b05198d67256118445c6f13f9ddf.

Reason for revert: this causes some tests fail with call trace.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index a6d3a4554caa..75af4f25a133 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -57,8 +57,8 @@ enum amdgpu_gfx_pipe_priority {
 #define AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM  0
 #define AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM  15
 
-/* 10 millisecond timeout */
-#define GFX_PROFILE_IDLE_TIMEOUT	msecs_to_jiffies(10)
+/* 1 second timeout */
+#define GFX_PROFILE_IDLE_TIMEOUT	msecs_to_jiffies(1000)
 
 enum amdgpu_gfx_partition {
 	AMDGPU_SPX_PARTITION_MODE = 0,
-- 
2.34.1

