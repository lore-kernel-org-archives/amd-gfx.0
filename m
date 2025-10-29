Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B845CCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 17:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2486310E812;
	Wed, 29 Oct 2025 17:54:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wXQHl1cX";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013050.outbound.protection.outlook.com
 [40.93.196.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FDF810E812
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 17:54:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8hDMlyQfjJyI5ELW64vbBouQIOjumPbSLtJmLGNqM6cFA1Dn4+q+8G7AE/pUG8bMpI7VQUp2pXc83f1sPC3pg0zdPcABHjFKLhGl1er5UaDIhnrFgv+KC+bKd96Psh877STipOVNpQMlP6uBvbGCXH8FNSwoEYTQp5RiPPOh6QV6wN52O6/sA34CpgjE9qa/uczxjISkJ5rGhdPnmEW3XhtR5YtHkmeIV9VahZej1GIUcMMXy79q1343vjtpYo4ULP+yleFpM/G0yLvb8b02gveusJlhwKntlBZ+Sjjo/06RzXbqhAfRzu1TR6xP5/RssafJqfDkHbDTTsI+XxeIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AeZeoo66K+2tqNcDjR3ODarwKBupuNUADHRmuajDLI=;
 b=BzkwLR0BHnVxMp572fc11rwYcAxIXL9Kyz4VbBduJ1BUCi5jaOQaEhX3JAc5cfJUbokR0xIAUBJPxogr4MMF7RrCvlC0OvvDS81ER99F5tp4x3c5rsIySW51IbGmovVojjgxRVo5SRvtNrlcrOr96WRlegA65w0proDOVfGUGkKx1FKtndgaYgsO+rZqrsuZD76/kAscNjuZeSNnhj136RpD5+ydAeNUbcQwjb+uZHG9BLX4+JracInm6GoPz7XMSSyCR0OqSgkc6t7WZqETYDbjd7njH82lYd/m/ZJqX9yC3wA7JmCC6pcA2pai//Lx7S1+n5CGu7a0eLSzmPRogQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AeZeoo66K+2tqNcDjR3ODarwKBupuNUADHRmuajDLI=;
 b=wXQHl1cXRmvF8zh9PuRmnfWyqcuap7oV7xvh8ZM/5Far4sTqGUu9JjvN6KDeajzz12e+0o3fVhW/YxpDDv84DZMuKN66/NmQCsufvtT1hCUqYGwsE18AWFfPVWoA9x/q/TgglMmwNerlXmHm8bN+Bg3kj2vhGPnAZZgadS7R1ds=
Received: from MN0PR04CA0014.namprd04.prod.outlook.com (2603:10b6:208:52d::20)
 by IA0PR12MB8228.namprd12.prod.outlook.com (2603:10b6:208:402::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 17:54:13 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:52d:cafe::ce) by MN0PR04CA0014.outlook.office365.com
 (2603:10b6:208:52d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 17:54:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 17:54:13 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 10:54:09 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: add support for smuio v14_0_3
Date: Wed, 29 Oct 2025 13:53:53 -0400
Message-ID: <20251029175353.2861924-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029175353.2861924-1-alexander.deucher@amd.com>
References: <20251029175353.2861924-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|IA0PR12MB8228:EE_
X-MS-Office365-Filtering-Correlation-Id: a6c8f8eb-178b-4639-a310-08de17142bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SJbEJAOutmDxWSTen5otPNBKJwn1+rf/rGn5oS7qwZegFMPbZ4KqKzXN+ZpK?=
 =?us-ascii?Q?i0ukBJM756Gcw8RT6P2HpcgTxuMzCWyw0k7gXJGYmjsP0a3hN7aX9IycTF1s?=
 =?us-ascii?Q?VABCrWMdz67LFFfDRrBBaTixRHBe/ugOUKK7QtPMkuFvRO8wxHtBlUZsWs7G?=
 =?us-ascii?Q?JxG0WI7WOYbItTlRTs9Pyqj4LhflZYCaTfOSdLgIPgOf+0W+6HPSH42U3TdJ?=
 =?us-ascii?Q?Wv6PuirFn9R4IkPNBcl17LdLeP5blrYFR01yEPMlylN3UqVezgEkkkwsPNkC?=
 =?us-ascii?Q?9JsjyLHrQG5Sy4sYqSspolVt4ykMo1yQgo2A6H5j/eBrqrRyTA0T6v2R1FjH?=
 =?us-ascii?Q?vbgo5ONE4awANnNXsyIR/QXz2QiIAqK+zeny1FFTRDpWY84gbb1hY2Mzt1Br?=
 =?us-ascii?Q?gfW2/YDxb0y5yXHhaQn43xG49diFT+2H3RsAGh+glTciEy7smViNoi4U7X5g?=
 =?us-ascii?Q?XkGtoxoV1PztuZPCzGh0Zq1lmdg4u/O2bApHZ71+wZNKbXuHgtmQq1BoAM/d?=
 =?us-ascii?Q?a9Bpb2ULdanPSp/cIFeGEoJqz9Q7J5BaMd2QHKs9o4BYXvNm3zGGGoOXj4PV?=
 =?us-ascii?Q?SB3+CSWnSrmE1kR/jcsJJyg0C4682iqJE6j6TiFyuPbQJtqY6S0scsUSpygz?=
 =?us-ascii?Q?fACSJc5OL6ysREVXYZD7lKQiNlnU2fXhYHIKlOjgxnhv5G1MvXRrEJoDQJjx?=
 =?us-ascii?Q?Hahg1nM18puGWOErNXxhLqFFmpjIsSAQnl4y2aRtDSrkJPrP6tqaGliFQhA4?=
 =?us-ascii?Q?56criK39Xs82caa7TROXxyJBL+0uah8z4qaRpUN29/lYoWpETe0LzOCvMzld?=
 =?us-ascii?Q?/U1DZ9GU1w7Fek36N12A9F2/SBhwB7KrO4O6ht3p4vdFsbpZqKZ6I9KlXluy?=
 =?us-ascii?Q?7WcPMckdjIASu/M/qEYN+0JFDBrtRUfCgoPUWUfuy5kWK528jfLaZen7BnJP?=
 =?us-ascii?Q?ldXRUqCOnbk69pEga0iaTaJ2I5csDEE8Y4MaevCSPCALsa5ikSoY/8eFWz/P?=
 =?us-ascii?Q?ZdxHMD9RSAPsb0GehGDYLxGKmqy0J9WFi2Y0O82VHYbUhSpDkkl+OKKEspmQ?=
 =?us-ascii?Q?VYo+etYXbrTKKv5MrZD5esQkGOFhbesXG45Wg3XwaNlHUGRVnVtBXRzv8Err?=
 =?us-ascii?Q?UhzE3GlsYRjIg/keSJYz/W1saIGza50knNXp2C8gyXQmf1J/pLBPGOLRobSN?=
 =?us-ascii?Q?Q35KvORH0gl1Czc+VkK2yWrr6JKwUFZZhgjRYU+9JCLKSkKPc7Iy/B1+ouYI?=
 =?us-ascii?Q?jA5L5g7tzeZaam5USqAIS8FQcZYUcvH/996SQQKqdIhSU+It3rDSjAq8tSdN?=
 =?us-ascii?Q?MJWTG6XDMpqs/xszJnvz9bPLkQcazua+8/8sQBcywrlfrMVMjFqQnxAbzqbd?=
 =?us-ascii?Q?DwNQJRNDWqRV5bS1xq4CpSY8QXw0QmSb9LcT+DFwaQE81U64f+4LdxOomgbA?=
 =?us-ascii?Q?vio61nMkEou5sQIfJlwIDfDPKIAelYek6GUn0ujdNNgYN4tY0TqJZ5np61MA?=
 =?us-ascii?Q?TiP7XfY4O6ZkrPtgrWStG2MM6n4kBVLLy9MAr2DzhjZLOYe/H138PHX7SE6a?=
 =?us-ascii?Q?y6U6o3X9NMzlj+viUJs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:54:13.7441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c8f8eb-178b-4639-a310-08de17142bfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8228
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

From: Likun Gao <Likun.Gao@amd.com>

Add support for smuio ip version v14_0_3.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 9799e645b6bcc..b569e574f310d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -103,6 +103,7 @@
 #include "smuio_v13_0_3.h"
 #include "smuio_v13_0_6.h"
 #include "smuio_v14_0_2.h"
+#include "smuio_v14_0_3.h"
 #include "vcn_v5_0_0.h"
 #include "vcn_v5_0_1.h"
 #include "jpeg_v5_0_0.h"
@@ -3143,6 +3144,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(14, 0, 2):
 		adev->smuio.funcs = &smuio_v14_0_2_funcs;
 		break;
+	case IP_VERSION(14, 0, 3):
+		adev->smuio.funcs = &smuio_v14_0_3_funcs;
+		break;
 	default:
 		break;
 	}
-- 
2.51.0

