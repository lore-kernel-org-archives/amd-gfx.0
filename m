Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F124D3C529
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 07:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CC5010E67E;
	Wed, 10 Dec 2025 07:14:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lz46nSdb";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C920E8935C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 07:14:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2i3/Ht7WrpN78/1Kdie9t1ra3b/arW9lV8rQBWE64/KNuEn7sar0ywlLnPp1apqBgJG1wz83CjSjbfAX8aWoIEzMw+NiElkUjjT0LsWkWfPMH1Pp7pTJk/Aqy2vsYBJ0StYBDYYkghY2hp7Ir01ddGm7ekx6UaEcFidrZrqLsQfPm6Ef2MblWYDGVmNvXX42jxUrAk+9HoYZDVM27AY6YF3bCbZX5kTxrVFpEde6GQtcr/+zXFUqaEYJlbv8rvQzyV+3S/c+vopHWAfmb+sycEEYKV/hF3TjlOka0newDBhUI3df1ibRVOvrWLFMQqHgW6CKTNw1IbVqU0tbXZkeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nc8J3TFAp9Toigw+GCpaF+1snZgsP8P+nDsxiPq6FHw=;
 b=WAA5VnjPq17We0ddzy2YvjP2X1MVRWq0BO+6Gf8Ns7M4mdAO8YJs7nn+NjR1BPdLlz1WW1WCYm8wHC+ZsHE8XORoyjSvVnA6V+UHkEb2N12SoXSu/xM61x0pWd0/noCzKI9rzNI3O6plrxettKHjdVk9+B7wBIbD89jCe7iyE1y+4kUnVVcEQK81lTQV0Y8KigwCV7qSBUR8e2h8RPUTacyXpAMd7U+OSjEKVqphsBIXg+r/u975+8jWoeyTKGSUH2XOsLWgCQLrO7AHKbwaVj//n512xjyZ0hPPA+QbXIR5AH+vUxF5eD1fNnas94PY7Y54jzt4RC1eg1iMPtOqBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nc8J3TFAp9Toigw+GCpaF+1snZgsP8P+nDsxiPq6FHw=;
 b=Lz46nSdbHY3E31Nl6X8FYGToEFlCe60e9KDPc4lRqCBRRIT+W6KD2hS1/Nw8aTBnI6uu8MZyf/VCpt8KoOyn9xa2Mj7QtoYlLewyW2l0XuHNgHNPMf/+wGbSSho4hMe2cyTPXfFbmYYVdzsFcSI0jNcdH7zjU5wZSokG7NW7bsk=
Received: from SA9PR13CA0035.namprd13.prod.outlook.com (2603:10b6:806:22::10)
 by SA5PPF530AE3851.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8c9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Wed, 10 Dec
 2025 07:14:32 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::78) by SA9PR13CA0035.outlook.office365.com
 (2603:10b6:806:22::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.4 via Frontend Transport; Wed,
 10 Dec 2025 07:14:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 07:14:31 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 01:14:29 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Enable 5-level page table for GFX 12.1.0
Date: Wed, 10 Dec 2025 02:14:00 -0500
Message-ID: <20251210071415.19983-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210071415.19983-1-alexander.deucher@amd.com>
References: <20251210071415.19983-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|SA5PPF530AE3851:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c1ebce-c991-4c4a-1669-08de37bbc3fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?as97DqDQKvAegzfbP9L3GRymFjIZMBx+5N8KxDPZR/ytoqlWat+ftpHiy58R?=
 =?us-ascii?Q?gMnqkW5EDAc7XdiHT46SesWNhB0Csn5ML1b5llXnMPeOETtFCmtBpDZaddwR?=
 =?us-ascii?Q?i0QdEMHE6cV9+Y45d3NkOGqPLc/xtDuizA+9NByRDh25La3O5TIC9Ci/inBS?=
 =?us-ascii?Q?k+BsmOb9Ic1qPBiZJSYnbjHaFrQQ+LpULhKfFVy/H4o3fFrD9VwRnXlo4CNv?=
 =?us-ascii?Q?9EGiV2hvlHc3Bxu5Bn1UrwqfXiPp8A/QG3PHbKuTg1hg8I6ztgBk9XVRTHY7?=
 =?us-ascii?Q?lHdRCXieeS9KGSshH8tKmQW4mSrzQ5fNagvZ2XV1lswEIcZH0T5ZT3oZ+7Sr?=
 =?us-ascii?Q?qccScc4ghr5tyA0C38SvyZ7ZhD2HQlCmhrZ7gHCfvhC0Y742Xu6UIrUSnUOU?=
 =?us-ascii?Q?B72FOWlzQ3HtL4oQXEX3i/be5kLkD/l4V/lRhnmsX3le/KZZfg1jYzNNAU97?=
 =?us-ascii?Q?VmxA+KhElV93UP1Wg+pChcNXsYnOf7KE7U3vf0HQqp3lakvLDwSnOrBSb8eR?=
 =?us-ascii?Q?w2UqGI2K57fHEnGEZNFVIlFVoCvthJcbXvUne4ADzhiZ4YP8L+leGW+Fsjn6?=
 =?us-ascii?Q?9yKHF4GFLl+xsK/N929fMzB9gEAYTpUWRTd47lE/bh58jFplcE6mHm6EM2sz?=
 =?us-ascii?Q?Y6Qc0sqoiYS/QBNOMvmm7cKLk86rUgsXyJxe0G1m8IJfhZb736CHkWiSheoF?=
 =?us-ascii?Q?qsPTpTi79+qvYtJUGAhZ+txYsbL5SGYkAeb0G/SSgU1rdKcHMfdlZxcOcxLL?=
 =?us-ascii?Q?xf3jNeEIoRfxFynMbB2iBtwvvYLNUNgQ3WS2t7kLs7B6T38k0/PGo2DaSsri?=
 =?us-ascii?Q?lQc86/NCyH8M5kXKIUOmsiaGimRCAcQavYqLGV2roowY2L28VSpGIBPqmn2c?=
 =?us-ascii?Q?hTenmL4kAQEscKOv5NYb0hLzBNhW84bQOtL0JUGJ17KM5rX8LYjU9KMgSG8+?=
 =?us-ascii?Q?wTrBLDIvSuP1rs8c2ve7T2+9ZLCyKWDWR4yN/ry0Ntd4lFPQqm2EZ19T92wY?=
 =?us-ascii?Q?gE1Xo+XCg8Y+IWretxm6AAMpmBiXUk6rXCKB5k7xKKteiMIlJYo4lEOr2fgp?=
 =?us-ascii?Q?RpdtalzzTc+mJfo2kNp329DyaY+8zGJ6f55cW0G2YSpE0gAeOJR4HRg/2Lvb?=
 =?us-ascii?Q?qmE3NKbuWf2bAoVh1xdFuZXeb+lDVEDWQdaYZCdwkIm26Q4h4LuAJEpKvUUa?=
 =?us-ascii?Q?1jpYjukHQsN1JAw/OFpuEdHZgQJPs2rFqT7mcjCH3Kl+aI5lTjVboCkolyHz?=
 =?us-ascii?Q?7y+4akixGl63AoDMSdCCAxe1qXQ7IULv0V4le87WiPllLqhlHHKkky7WNW6r?=
 =?us-ascii?Q?KzfwQ74Jbv/wkBoDb81452243yHAb80kEC3z8TOPonCkjTfgNSzaLA/XVhZy?=
 =?us-ascii?Q?gkrwzzg1UgFFPJYEgFHyjqC50MQ8jirNxVy2ap4kSCRWeqyL/9fZJ5jfg4hC?=
 =?us-ascii?Q?pdRjlzj1NVJVkl9uV18glIk+GiPAMakQLrCH2qeQvUD0UOSAznGKF3Eqz1h9?=
 =?us-ascii?Q?7vGYvRnPBSiimEMKEBmPk8ggSSTYNpYpa6DjJJUDdPpGUgcsJBcgRl00j811?=
 =?us-ascii?Q?bw2vFIO4BCmDcIRC/9E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:14:31.9036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c1ebce-c991-4c4a-1669-08de37bbc3fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF530AE3851
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

From: Philip Yang <Philip.Yang@amd.com>

GFX 12.1.0 support 57bit virtual, 52bit physical address, set PDE
max_level to 4, min_vm_size to 128PB to enable GPU vm 5-level page
tables to support 57bit virtual address.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Acked-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index e63ad5f18a8e1..57aabe0dcfdfe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -809,11 +809,11 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		for (i = 0; i < hweight32(adev->aid_mask); i++)
 			set_bit(AMDGPU_MMHUB0(i), adev->vmhubs_mask);
 		/*
-		 * To fulfill 4-level page support,
-		 * vm size is 256TB (48bit), maximum size,
+		 * To fulfill 5-level page support,
+		 * vm size is 128PetaByte (57bit), maximum size,
 		 * block size 512 (9bit)
 		 */
-		amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
+		amdgpu_vm_adjust_size(adev, 128 * 1024 * 1024, 9, 4, 57);
 		break;
 	default:
 		break;
-- 
2.52.0

