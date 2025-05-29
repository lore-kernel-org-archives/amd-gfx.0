Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C5CC54FB3
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 20:08:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC1E710E24F;
	Thu, 29 May 2025 20:08:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P82JKCYX";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 207E810E221
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 20:08:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOU0EbszlEFhYNw6FuUHPepILftSi200i3u3EptZMu7V6/o8835DaQfDTI6uZJQXRDCgLNwAXzv99HW/JjKzoH1puQ78YeOZhtHYYb0wXDswzmq6CczQEIsOJOC45BTX97XPpoUK0VqlQzpESNaApbS4P8WRrEYirWxCNaZwXoNcPbczsl8nY+oPNuVE/tKNnwId+v3NYQRGrk6XJ1apHOxTzLj02vNdU00M1DfxYKeopkBP8gicydoU2hyMBsDE+pITUZgRt0cmQx5Tx822kQd9qen8GrUtFQ4RatMCXqJhqI5ZWNosdcKoHUPdTfRoACKnBP7QAphnwy1KqWg/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgYmWJ2M2Z8sLiFYH3pvZz5gZ9v0IG4SCHxbFALKoQg=;
 b=MJrQI5hVWhb6au6UQGLzDy2JJei9Ihe8M5o9HZ4T78H1vEE1C0CT9eM5PegTZdsoLf8xRTJte/P7jaUQjWgN+ZpBWaOSQstSU0JSzFxjp2B6AMkUWn/N1CbSXre3NJh7cQZ24UssQk2enAUln3aHSgBqyxckX+xQ9h/de1sPS3BsCe5DvqGPtcDASrDEr/sVKunJDG4JJtNl4XQj+1kxSdWRAdX7hAyIuI2voT7SBU0h8imSwd9Z2rIzJyGw2e/E5gyEyPOQyTd+4O60oFmFvUbKjM0JUtkVbhiyF5PWPW8cM74fP0sUTLCAMHl5Kat72246+9DW9q+Bt0YzkdrV6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgYmWJ2M2Z8sLiFYH3pvZz5gZ9v0IG4SCHxbFALKoQg=;
 b=P82JKCYXLowxVIHWaf1LswR8f5fn0UNS5iZAeGEeV97eBI0voE4qLM259XB/BYS7gIAuLh0/EmkZoUvr2IiMMdF7t6Ryh437BOWHdpqf6K4af6lw/obf+2D7A6wk/9W8dye9mafq0x8UXhyhBtbLHkHgXqdZKTSsjyYwBoV3lpM=
Received: from MW4P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::8)
 by SN7PR12MB7347.namprd12.prod.outlook.com (2603:10b6:806:29a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 29 May
 2025 20:08:19 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:303:115:cafe::6d) by MW4P220CA0003.outlook.office365.com
 (2603:10b6:303:115::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 29 May 2025 20:08:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 20:08:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 15:08:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/28] drm/amdgpu: enable legacy enforce isolation by default
Date: Thu, 29 May 2025 16:07:31 -0400
Message-ID: <20250529200758.6326-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529200758.6326-1-alexander.deucher@amd.com>
References: <20250529200758.6326-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|SN7PR12MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 602fb1bc-213b-42fa-b098-08dd9eec8e4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GkzNphN8rn66a1Gy6vD0zpqLnXsABwDY1mVFdSpDlLr3hjFRfaTKYAIf7tld?=
 =?us-ascii?Q?h0pNQ5P1gsVLMHU++YN8q7HNT+U3/y4M2iDK++472i0oQW2bhqZMIfwMgLoG?=
 =?us-ascii?Q?wNi77tgcmhIa2/pvfSib574ArIbEnyr4m1ESN18mEiSVE7YxcdsDP2wZFdgm?=
 =?us-ascii?Q?tUgMfsgr8MbmEqAYgwKcZbWpJlyzwtb625vDEt5Zfi/g7WGZQgCHV6bC9Md6?=
 =?us-ascii?Q?4wHzWzr5xd9xIgDWtU9rjH0QWqWSl9g8PscNE18WXnBBYN/7q0YwFIg59k+e?=
 =?us-ascii?Q?M0dTDx5alltvdBoWZRCFQpSd46qhK46brzdgd0SLDzK8XS2v9o0YOgtp7pqj?=
 =?us-ascii?Q?zTPvcRP4Ef78P6CzaZD97JJ9c/yKEgXriI6X1tP5uGNFnT3ICMr3cyK7FpdL?=
 =?us-ascii?Q?DDTiXZOYk0CAAyLu1xPUd8JfkLrAsbtaqtAlZG5rj9fZXe/XmbTNyh/PTtFR?=
 =?us-ascii?Q?20mGjPZTy15gxjOditbzFm6sDhs8bvnpnT7aEpIQCAYiinChYbucdxZQSUi2?=
 =?us-ascii?Q?dHKDYqcxBV96Z32GhzRp6aHTKvLwVn16nrD9Cy4lt4jQHn0E4pCwHeR6NllE?=
 =?us-ascii?Q?OP0GZun/6dMZrlAdd2q9zhKoEK/fITJcZLTT5mFfFEXg+CwY9+KLzq1ZJ9sS?=
 =?us-ascii?Q?5FXfZyRLbGRwIN4ueNXB6IzHACxwDguDxYBce7PWnw/FYxj14GWIpVSv/Map?=
 =?us-ascii?Q?1t2n0INMpz86/qz773Pli9s0UTWKjz3aMeOoJ05AXYS7jwrAqOhKnMucMGhX?=
 =?us-ascii?Q?BssppLydYWpK4marihSe5bhqYprLmkNmHOjXLG31kur3v2SpZgsNJd/Ujfj0?=
 =?us-ascii?Q?P+LTNdGFgimknNwQRwFdI7QC+rJW2Sp+lL3DG8F0rMPRIIu/Ku/AVVqin4xN?=
 =?us-ascii?Q?D3yTUPSvUricBge2CwRBBwSDHR4qKUlkarpBSFjO5e72XfOo4ITq63ibLvDG?=
 =?us-ascii?Q?sZ9aGjeonZBjRhDA31DTcuPQdDHx4W3NObDaxPsy4SYGyno/6rJWavgSSQ9Z?=
 =?us-ascii?Q?BwWYqrZgZPdsa4Cal2QY4D7bc2xZ74zZmDhfdLPs9O4Hojbc7fcfnSIfUlVv?=
 =?us-ascii?Q?ryyVHu/ADjib16WMb+bvcZvELfZrrEGBvHqKQ+50Uoe2WL4hOoxdM/k3N2hT?=
 =?us-ascii?Q?nCZDwswxBjeB6hneUKacxVS0vBlghKXoZT/9GcZ53BJA5MZxxuQl/SfiShyH?=
 =?us-ascii?Q?kbv/NgZcMj4D+0j2D8+c5suB/S8izM2lmikWZT8FxAe6N4tiiIJFckjMzpjD?=
 =?us-ascii?Q?V3p9opMXOnSpOqQ/wJ1yQtinlOgWEpaIFBnIfSzTQocAuC9fLMQNDieJwo0Z?=
 =?us-ascii?Q?gThc/dy32Hkt4YeoYOqGpVL2j/vFFytg+OzymUTG4LalQ8oUk2CEGEKZVkga?=
 =?us-ascii?Q?wqK/yggeIw+3zs1KhoK3EB0vEWxGKmZSdQDNpqJLLBUXIW7fdbdu6JQpVUeS?=
 =?us-ascii?Q?S1OfJutei6VcNEh/19twe+HcJJzWPv2GHpcHDPFQxJQ5SpexFq8CYD2NZNbc?=
 =?us-ascii?Q?yzZajDAUvNnJ6CKa10Zr8ZAkzXOWECT9PSOu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:08:19.2068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 602fb1bc-213b-42fa-b098-08dd9eec8e4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7347
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

Enable legacy enforce isolation (just serialize kernel
GC submissions).  This way we can reset a ring and
only affect the the process currently using that ring.
This mirrors what windows does.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 72e41781afb06..ca882e3d95bb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2148,9 +2148,7 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
 
 	for (i = 0; i < MAX_XCP; i++) {
 		switch (amdgpu_enforce_isolation) {
-		case -1:
 		case 0:
-		default:
 			/* disable */
 			adev->enforce_isolation[i] = AMDGPU_ENFORCE_ISOLATION_DISABLE;
 			break;
@@ -2159,7 +2157,9 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
 			adev->enforce_isolation[i] =
 				AMDGPU_ENFORCE_ISOLATION_ENABLE;
 			break;
+		case -1:
 		case 2:
+		default:
 			/* enable legacy mode */
 			adev->enforce_isolation[i] =
 				AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY;
-- 
2.49.0

