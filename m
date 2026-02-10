Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9DCEA3F2A
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 09:53:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFF0410E533;
	Tue, 10 Feb 2026 09:53:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DuuS2d+L";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012066.outbound.protection.outlook.com [40.107.209.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA5D910E531
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 09:53:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFwrDmoFjy4K3KZg3paPgYB+77OXh3sStigm0ERZfbk8kNzuo+QrtVZeX9nJDYJNwFdCiTye1mZHcnXmS7BbYgfqtaWtk0V5RCL+ChkCR18O7pZsCawq+pclhYoE8TGoy4qXa8ViQ2Sry+OT0XAdCnQ8nNDqKjOaBHrCiyG11l6vkqTP6TzWY8rZLv01LgdcugWh5IpNhOox1lgMG1oNWnSTvgm+UZEcZAqTa/oM2zaesLLkKVtNPTABdttosKFSt4V68R4JusRgug0BpH6pasJK71ykhUvE+yWoPB0N6FFhi/30pA8h2yB8mpjdyqAW9NMcpQjIqBy2ZnZHs+rg7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9ZN4a4LXUgF2oDlfQT15gk6T2E2b3M4j1Y7u/tB3VQ=;
 b=tY/sDcx5v73AoZ/yWi85ctwiUSPa1ehlyNwQ8eR0mgQGw+i2zBBp6Nby05c4lTNmuJTsNbyi7mAe9/YMs36y42Zdn6pEhQju5s/te0/f4H+70YsUSYKweTNOUAVN1sd+9Klkx55IBvHOpeb5UHgqPNH1Zj8uaDItKEaWT7X8iBlHk19HJnqJOOJYMVVxueTbv1f1vZ4Mj+5x+jmqvXGAC3pp1FxFXVOfF17sTZLor5UkHkpOUaTls2r+wBGF3TOgjyUidgDezl1Lbb63EcvU2jOoB7INw7TSfX7MLbuI6TGO4IU94nOk4y8b1uBLv9IOPZ7gCbTRr/zBfjpTJihbRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9ZN4a4LXUgF2oDlfQT15gk6T2E2b3M4j1Y7u/tB3VQ=;
 b=DuuS2d+LAt0ErKqDy8y2DBPaAReKWvqMJzIvi8K2CS7sSSUbyWuHwC04MNNd+Y94sXRzwzLLQRYv2h/RBWkPufY7Mpbu5unOucu2G0Ex1ZXgzTL8SONeG4MMjx9aryM1Dobybxd99nzTPWc+jTcyjakvE3HF+G0B4y+JVhBzlOo=
Received: from BN9PR03CA0807.namprd03.prod.outlook.com (2603:10b6:408:13f::32)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 09:53:02 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:13f:cafe::32) by BN9PR03CA0807.outlook.office365.com
 (2603:10b6:408:13f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Tue,
 10 Feb 2026 09:53:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 09:53:01 +0000
Received: from jenkins-joe.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 03:52:59 -0600
From: Jinzhou Su <jinzhou.su@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <stanley.yang@amd.com>, <yipeng.chai@amd.com>,
 <tao.zhou1@amd.com>, Jinzhou Su <jinzhou.su@amd.com>
Subject: [PATCH 5/5] drm/amd/ras: Handle check address validity in SR-IOV
Date: Tue, 10 Feb 2026 17:52:33 +0800
Message-ID: <20260210095233.3078476-5-jinzhou.su@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210095233.3078476-1-jinzhou.su@amd.com>
References: <20260210095233.3078476-1-jinzhou.su@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|CH2PR12MB4087:EE_
X-MS-Office365-Filtering-Correlation-Id: 1257a3be-6e1d-4401-b4f0-08de688a2dad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oWi6yOSCzyBOluqBW4tN3+EXt1/poY4RIkIUwm8LUAz9QyzebbXRKpruTSkr?=
 =?us-ascii?Q?228flrpdNmVrjCXY4rc6IT3wkkW8+gqEky601YWCgXbpUOUv5HYICIHn/arF?=
 =?us-ascii?Q?JEVyFzqj8owqMoSFud1oo9+CQEaK2FZPGduw1zs2YHVfbBOoLHBTWCnNVtLw?=
 =?us-ascii?Q?a/4KPrRFGkFx41FTSF6XWspTVGnW6kbYqX3ddniC9wiVrpoFziVa1k3dkFHk?=
 =?us-ascii?Q?GwihBX1MG0zYvxKmyOyPET7GJfl7ckKHhrQbEFymBjzBoWxX6x/OOzNcN+3d?=
 =?us-ascii?Q?KCL28d/ioxWUu1o2bQhSMtnkWWBXtPg1A4rxWRTS+XnHGXxOKLHpdnUBc8bN?=
 =?us-ascii?Q?Pgqdt/PZGYshHlqP+gxDZfZKJHm+lrAzDWpyYaUVwDXJ8G98L/nJOjQSylXC?=
 =?us-ascii?Q?spDKjb5b/BEmuaSrEq0TXvY0CuRrFUTvLRhpOKmZXW7kCv/wALsHFiwE94lG?=
 =?us-ascii?Q?XMYGoYpmQ5HgDMAiC3m4tYqhXOfphRZkeuG1pG+K3AAJoAO7HhWDkzumWe2M?=
 =?us-ascii?Q?+6OI0SLwbJVgIFKN2clZt0Jpp+FDVPGTnBD0DVPUhSqWwNsZI17m3nHIpUD8?=
 =?us-ascii?Q?gHMuzkeQzEur7THZjZeer0V0aLROWVkeFe6skjCMlKcuMvZjvl5Z/2pByp4d?=
 =?us-ascii?Q?lN3ii7riTU2531kRMfg6wjwNi+8bq2TMUXenSTV/5BgW66+5KbDsdWaqSOML?=
 =?us-ascii?Q?qwyPXQXXY2uxXPvjMKa0wqvRkvqyJ0xEBY9EYNLCm2iyxLLHLOXfSXzTf4kE?=
 =?us-ascii?Q?5g5t9X1yfGBMijIsfaZoUR8Gf71K6kvU8X0187QkzkGVuUkHW4RBEyZgt/MP?=
 =?us-ascii?Q?slROaIy8JMlqG49XyCWwW2iKw9ZR7/49VMlfh5qsSCczk0lH8wBj34hb4CJ7?=
 =?us-ascii?Q?nOeup+AzoIIhz84oTQCsPlg+EVxXLj8hU2YuCdrNSlCNJcQ1etTT4+vFQVJf?=
 =?us-ascii?Q?zSTMKuvZw8JhvbM5C+EgGspiD7HmiBEQXl4BuOT2sanS6ZgHEExfDXyCGnb3?=
 =?us-ascii?Q?MDZtcU6+p6l8cv0r/gFBZ/7UhbAnJN2o8MqYcXCjjz/+J4Uoh4cbgrviLNP8?=
 =?us-ascii?Q?9t6ByecRWA2ibgcwX3j6BoNC9cuyzNpuOJqNJL/l9zt38kAme1KzWkGKvrGx?=
 =?us-ascii?Q?cG/ifArBjR6UjOUs5P8JUjZc4IcQeAgkljgQxErxQIxDMLH0iPL1XpchL/iX?=
 =?us-ascii?Q?JL8U93xiurP70cPKKT2DJGZ4oMZvhKRY9p9b2IlZIZjFYu4u5jKtoISg43/R?=
 =?us-ascii?Q?AWnX/5OHgX2fWywEZMQ9OKAnTl2+YUZx5Q9DM/3eQZjDe97ZIiZxIZRSo65H?=
 =?us-ascii?Q?Gi7K2vSUb1RU0mXp0gcv0tVNUIWvj5X1iwu9FC7LnyaAn67Gd445b2rWwDCa?=
 =?us-ascii?Q?GtNYUnWHJDRqWfbgrXhG7eJNLWxtge1tnlmYyHIvLk/5tCdaIfXi9k8v3mIX?=
 =?us-ascii?Q?qyZVte1przWESLTIHZvo9nYTa+o5dm/UVRlFBKds+2qKANKdwFFw9xY4d3Cl?=
 =?us-ascii?Q?2e6HzJFn1ibsUrXG/sLPwVqm1KJNstqGxvreDqjJ7oXUfxTJs/O+k+Qe09JG?=
 =?us-ascii?Q?vqkWy+mnpjwOioOFFTnL6vD2LtelQjfjwccLzazgyW1HA2t41kLHDex+N/Mg?=
 =?us-ascii?Q?PfoSI83yhUBvivOscFAt5GlwrITNf61XKonHLHhat8jJbTFLPWvq/OL10C50?=
 =?us-ascii?Q?6lbDLg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IbkVCCka7uvrsu66vKnjVwQ3EtJlhp89hpj4Aoe0WZnGLgPEwlenTvB086dz9+lsHTTxwj+2yObEfR9sE/TYaVNh/HNsmZqkzi1+ZnBBE0/VNDxzttO4Rzd2ayRmsT8H1HLcyLWyClh/nApCmgz9YR2J1aFRhHavgjmgRH97I9uGOBlcZjcmK6EksqDJ5jWhColprA4NozLy7POJyXaqPRGn0kk4sl0zO6/eVNOJxE+nIewtm1Ub3bbKYz25l4Qrj5wFdOgZXOlNPDjM3DIjmAryHGKHM81mjtrrHLyYoJvNzrg3JfAx3THfsLKPfIlitG1LI/bqUBtugMF1RASyyMZSo0J51ftfrTikxqTzXVxadnjh7fLIKkuRrGPIKbXXx5V2K/VGH5sr6iJG+dY2XZBQcbJvR+iL3WFxm/+7t5QxqfP8s5HHraqA94KlENcg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 09:53:01.3899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1257a3be-6e1d-4401-b4f0-08de688a2dad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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

Handle check address validity command in SR-IOV
guest.

Signed-off-by: Jinzhou Su <jinzhou.su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 26 ++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 4c890cfea1cc..ff759f6425fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -42,6 +42,7 @@
 #include "amdgpu_reset.h"
 #include "amdgpu_psp.h"
 #include "amdgpu_ras_mgr.h"
+#include "amdgpu_virt_ras_cmd.h"
 
 #ifdef CONFIG_X86_MCE_AMD
 #include <asm/mce.h>
@@ -228,19 +229,30 @@ static int amdgpu_check_address_validity(struct amdgpu_device *adev,
 		return 0;
 
 	if (amdgpu_sriov_vf(adev)) {
-		if (amdgpu_virt_check_vf_critical_region(adev, address, &hit))
-			return -EPERM;
-		return hit ? -EACCES : 0;
+		if (amdgpu_uniras_enabled(adev)) {
+			if (amdgpu_virt_ras_check_address_validity(adev, address, &hit))
+				return -EPERM;
+			if (hit)
+				return -EACCES;
+		} else {
+			if (amdgpu_virt_check_vf_critical_region(adev, address, &hit))
+				return -EPERM;
+			return hit ? -EACCES : 0;
+		}
 	}
 
 	if ((address >= adev->gmc.mc_vram_size) ||
 	    (address >= RAS_UMC_INJECT_ADDR_LIMIT))
 		return -EFAULT;
 
-	if (amdgpu_uniras_enabled(adev))
-		count = amdgpu_ras_mgr_lookup_bad_pages_in_a_row(adev, address,
-			page_pfns, ARRAY_SIZE(page_pfns));
-	else
+	if (amdgpu_uniras_enabled(adev)) {
+		if (amdgpu_sriov_vf(adev))
+			count = amdgpu_virt_ras_convert_retired_address(adev, address,
+				page_pfns, ARRAY_SIZE(page_pfns));
+		else
+			count = amdgpu_ras_mgr_lookup_bad_pages_in_a_row(adev, address,
+				page_pfns, ARRAY_SIZE(page_pfns));
+	} else
 		count = amdgpu_umc_lookup_bad_pages_in_a_row(adev,
 				address, page_pfns, ARRAY_SIZE(page_pfns));
 
-- 
2.43.0

