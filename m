Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5180C3ABBF
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 15:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FD3B10E840;
	Wed,  7 May 2025 15:27:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nkor5wDJ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EB2E10E840
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 15:27:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMTV3guWrdyY6IjmLCVy4WckhfzjDwjn4iUl229Vo3ovxxFjU31AjJAv8ZlNu4IlfWBPynrPrkeuEKFZ27ypthOvbAQKHC18F59sFG59yQGecq/VjvXk0O/fVTy2HG/N2xi1O98V6bIrwqZfFIlDTwd93igNai/exkpvbooNSA2PSAdYz6kkuYSTTgTme0JDn58m63HmbCXMslPmm3570VM0wrUvXn+19nOqrvU2IthMfu/QZBO9Vjc3NWZGQzXk1VL+RB95sVfZg7s1lW2PRMVhXJ4s4G09P7c+imrDgAZcgQpirTkA9YiIpAqtAXtPkidJsiOagHvpydG+J8lTDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGbCCdB0/vAkclv14DjnndJa4ZJ5njGvBCUxRsyNCqA=;
 b=MMl/08Bt4JJ6Qrr5KIr8PkFE/+aP1n73djqna9KJZK5Lr6PYXpO+EFHPo6f/hKRBCXsUH70TNWP0W0wy06WTe9ivFDWzNhNPd7JWV+z522C7DqtLN8Npi3Bu0XRZDqJgy9EUi0/ExCREOFX5oThan4D/UvYoDyum7W6UK3ZfOgBZpFIPUUqAZ7YXUpr19t0qB559MvnbLxvjjv5YtizXuxkPPAL7p+qcJjxwkWQ3LTanGvSm9Nk8VOq92VB7yHTSUdXvbjrF/CXLDQ6PDsqbLMkwJKiHpNP5Ug5iJI4jU6VyqIEgP8M7ANEc35TDlotojPVC5V5FNKD5evfhhwqtxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGbCCdB0/vAkclv14DjnndJa4ZJ5njGvBCUxRsyNCqA=;
 b=nkor5wDJZlyuXop+jtIdrTf2qyABg1X2OFsvCv6TX5sbBFoUpbvOpGqpr8jgNpbZc4D2WX+cnSjbz0RikrOzhFInUpK/rQylo2QjZ+Kl1IQFUSVARSglnUhS33/jvKUV2qt3kMaBD6Gynx/pjfPd8w/HfFcbTFyHmjsYXNSiWEM=
Received: from PH7PR17CA0046.namprd17.prod.outlook.com (2603:10b6:510:323::6)
 by CH8PR12MB9741.namprd12.prod.outlook.com (2603:10b6:610:27a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 7 May
 2025 15:27:31 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::15) by PH7PR17CA0046.outlook.office365.com
 (2603:10b6:510:323::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Wed,
 7 May 2025 15:27:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 15:27:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 May
 2025 10:27:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Alexey Klimov
 <alexey.klimov@linaro.org>
Subject: [PATCH 6/7] drm/amdgpu/hdp7: use memcfg register to post the write
 for HDP flush
Date: Wed, 7 May 2025 11:27:09 -0400
Message-ID: <20250507152710.234881-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507152710.234881-1-alexander.deucher@amd.com>
References: <20250507152710.234881-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|CH8PR12MB9741:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc33c41-6aa1-4289-a4e6-08dd8d7baebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L9rdwHvTufJ3jRF5BcXg/TlEeMG92/HonZahqIr6yL144K0ZC3cBzUgf2CGH?=
 =?us-ascii?Q?KtI4VENNERlfsEJl7lk/rjavJy2Q9Zh587YtIyDV26JXvd0EN7V4K9VS7AXL?=
 =?us-ascii?Q?yCJOq7k9/uBiq/uaZdpdAmecv9c1nT3H4TMps8uJ3Hb9QdPd1/F9xo3ce4Qw?=
 =?us-ascii?Q?q2nU+1ZzgPD03gp00/EyR3qEyxgn/ZhPaMm6JiX2AaXKiPJJuvyt5SBF0qgk?=
 =?us-ascii?Q?3r8qwnOfEATp6kTHrX+DBHUHCJAd0tft62nkAFnnBSD9RJ2Sg/WDo5LfSwEc?=
 =?us-ascii?Q?SayX1PZ2eRxINQv7WzyulQ8DmElrKvF2JRGIu2e8uY2kZLO6M6zBtqa21ZMn?=
 =?us-ascii?Q?HAV8wyKYmoy9d3HCnsMDBNWLw935vdFNUSAkfzhitqxg2jZqBY13xlKr4OYE?=
 =?us-ascii?Q?viIuAWddvUnxi038S1KM/oYJsGbwZlRVvGf0Ls9DGfTKvPfJXMEvTTyBFcOK?=
 =?us-ascii?Q?bnTVniv7Ab3oa+GjIJJkDH7zwe1/X9TJlzBWiMYUNy8EmabhyYyETGqeTKlt?=
 =?us-ascii?Q?0bLWkjW5fCcK4+B7QrBugAYdXfY81W/LGaKXExI9RLlz6kYRnRXNVRxg917T?=
 =?us-ascii?Q?8iCxV7nP17teYzH1D8GJT7SoQbd9SXOjiu9c9ujpZalQHR8KP48Moh3CkWyi?=
 =?us-ascii?Q?IDLB899TZUQDm/FDOEFAvxNTRsYZoiPE3Yg592Azjh3IjTqdP0NWQs2mX2km?=
 =?us-ascii?Q?Etyl30KZeD6J1hcJnvUwf6VOvSPKlAwJL8yAO4Jmy5Eux6g6gG9If8UOEVr6?=
 =?us-ascii?Q?X2YyMO/t/nu919OvfmerAkLI+xP+WOSYImpviGty5q93ZOO7usRq1mmDFMEN?=
 =?us-ascii?Q?LJLI8MyxSTHi5xFKQ07maCnX0iZiVbkkgbJE8qW8jzQw4605eCtikOd3TCcf?=
 =?us-ascii?Q?9L8wQDB+lIHzFy/GJsMsVaeNJlwWllovAE3UV6xTeOn4jH4inq1oMdAOiEjC?=
 =?us-ascii?Q?eUwdgiKvOPAl2FCPt5G7PwRFT/gf+DPaLdmOy3Zf6mpQ1Js0jLBFHlLKK5AH?=
 =?us-ascii?Q?5WQsWT5Z11y5FXEi8BfINW25xJYAy6lofO1P5bT45UDEri+n3f2OezLF1wBH?=
 =?us-ascii?Q?uCnLJUSKecouDo1SYijiAqxfScbGWh7/28YkeMaiy+CYpMo0ZL9Yzv41HYe/?=
 =?us-ascii?Q?kdGwlqDrd2b/rVpGdM+lGbl2PMiY0IK8BMVBZrxqulsTGzw496zLSUi4aFaD?=
 =?us-ascii?Q?T3uSpNx2lMHudRBG6r39QRMsiVuLfNU09pnyIGuViOjdAufxJrrp4KeeDdrk?=
 =?us-ascii?Q?jpaOJHoUvehxXCUP+14WrHMDyxuWywuvemB5vMJInsQnt627iAmgM457hoUj?=
 =?us-ascii?Q?bAOJVP0m6D5ikOhWccmPQhdTNL5wjlsbyMJY8AvYiVMhzG4HHVCIxPuxY9lk?=
 =?us-ascii?Q?zdqPRI9KNs0/Z8Na1mA+7kL1HPVW3K+YSEgQeZF4oyrMkiT7JzROWx0euM7M?=
 =?us-ascii?Q?jXKQvmduXGSwNMF/6JokO7yv5wGc1VI+tzSvQRxkqJv+JT2w0EO7qw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:27:30.7875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc33c41-6aa1-4289-a4e6-08dd8d7baebb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9741
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

Reading back the remapped HDP flush register seems to cause
problems on some platforms. All we need is a read, so read back
the memcfg register.

Fixes: 689275140cb8 ("drm/amdgpu/hdp7.0: do a posting read when flushing HDP")
Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
Link: https://lists.freedesktop.org/archives/amd-gfx/2025-April/123150.html
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4119
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3908
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
index 49f7eb4fbd117..2c9239a22f398 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
@@ -32,7 +32,12 @@ static void hdp_v7_0_flush_hdp(struct amdgpu_device *adev,
 {
 	if (!ring || !ring->funcs->emit_wreg) {
 		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+		/* We just need to read back a register to post the write.
+		 * Reading back the remapped register causes problems on
+		 * some platforms so just read back the memory size register.
+		 */
+		if (adev->nbio.funcs->get_memsize)
+			adev->nbio.funcs->get_memsize(adev);
 	} else {
 		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
 	}
-- 
2.49.0

