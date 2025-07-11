Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9028CC83F21
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:40:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A10710EAEF;
	Fri, 11 Jul 2025 22:40:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k7SAdFpa";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 205DC10EAE8
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:40:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7XVeTd4YSuK9QZXeUvRoSYbeTJhjosPhWr07Hh3kkyPAU4CSGoyRvuchSUoWKp0DVzYOB1N20uK3s0fypBweBYylIh+a/6HZZFT8vwVLu115xhE2W2uC68HDpenizWGWatRzLd5zELvozjE5tltlO5zwZf1ujg0L6tuBZVKP+AGBs6EDjR8BKGnZeiSUQ5fNIiV/5QYCk1F8Pa8jwyWw8xXjlKZdFm+BtJJ2F9xOuzkQz783L44abUvQgleWVdgD3HhueinxiHgLSUn3bldYrcFSKlG5BYw1ftTG+N8X0nz3oDVnvJo78n5RVldTtGPJ2jZ6KY2snp2fAOYEn4sxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jp6YQgAXYkzU1jRvCIE1W1+/Zp8TT/4Nz/wA1zlrneo=;
 b=hyXNXYsKGJxUID/zxsHW30J8fWS7v2hNBZSk6VHCD9lzY0QY0jrIFN3Ld4EhCRpxPDcHzJpy8hMYfNDaofE3PL9tRUjhkKfFbiN4azyHLJcGnsC1d8gadTNgxLKYTy49GWGugq/KDK+nsCs81Gfew7M8FS/ER9uAg+1C/duB1T4hIYX0kuuXN5zv5hL+60h4C3UH9dPprQRpnZIsFTDKYfMWq/oGb7GIlbwEWVi4GIRhb/Vm1muUot74qDWQkgVPJsEETqEWlPHg5hHALyIY1KcSomrgoMhyrHNvkYdZcNBVl5elP+bOZEHJ/kSmp0mKDs1333E2uzf8vQSEqgl0Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jp6YQgAXYkzU1jRvCIE1W1+/Zp8TT/4Nz/wA1zlrneo=;
 b=k7SAdFpaGZCSauDexgbYBnlQEgpUzqRq8mDneK+BRds6FSVhG/Hqc+ih1wzNxy3A8tNEMWhM/Ah9JDrIH3g3E7ARajMUB5+Un22mDTHaiLWgJuqrJSALCo6dc6ttdwqza6RByUHAqxhCn3MPk72Z6y/eMu1wa1Ln2nKISsE7Yfw=
Received: from SJ0PR03CA0228.namprd03.prod.outlook.com (2603:10b6:a03:39f::23)
 by CH3PR12MB8211.namprd12.prod.outlook.com (2603:10b6:610:125::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Fri, 11 Jul
 2025 22:40:48 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::54) by SJ0PR03CA0228.outlook.office365.com
 (2603:10b6:a03:39f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 22:40:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:40:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 15/33] drm/amdgpu/sdma5.2: re-emit unprocessed state on ring
 reset
Date: Fri, 11 Jul 2025 18:40:06 -0400
Message-ID: <20250711224024.410506-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711224024.410506-1-alexander.deucher@amd.com>
References: <20250711224024.410506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|CH3PR12MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: 7712344a-05b1-4b00-9a25-08ddc0cbfb2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HRxxRp3O/eo5G4kmqomKtqTreyMCNPS/dfG0u//tkVTKX6QbY6pu+MwDnY3a?=
 =?us-ascii?Q?f12lqyjJXcwaQ6jxY1Zcnf3Oz7Q47TWSaPNBWuNdCsBCuC5Zxwre1C8MQ1v2?=
 =?us-ascii?Q?1WbA9qJ45kCNwLEvVRHXoCAIUWfk3WjuE5dP8egkYRkCQuSBXyo/VAtZNlRO?=
 =?us-ascii?Q?yIQoeaI/09JpSFVHGAS77TxKwkbzbbNuzwav8b5cy7/38A4xefMBecuXEmq3?=
 =?us-ascii?Q?dWNI6hyUjQtKGixB5FfwElV2ksT+yuBlDQ8XA3ZJZOk5QVQDwyT6xsEQnPQJ?=
 =?us-ascii?Q?3JC9zvqJYig7EesTpbK15DoUFyh4jtiglTvztwg6OU3BnDcBCfM6ChzIXJJm?=
 =?us-ascii?Q?kQFrSLI/FO0jbmcq9qOXbM6OtevHYh2Jvizd79o/9/PY3yvwGFf3/g6PcT+n?=
 =?us-ascii?Q?pH8hIBbwS20fNvj8wg01EA5kdGpibI/aHuFG80IIX1klK03u0mwAUP0XDjHF?=
 =?us-ascii?Q?1TtBk59dZhy8tgGmUwU9KManrN0PP7IzIojcXTKaf5SYYK1Uk9iqHQ8aCwdh?=
 =?us-ascii?Q?FSLSRcZMphhFaQayLzInA6PGbmqaByGZloPZoBdHXOn/7QitnOTZHm1FTSo8?=
 =?us-ascii?Q?0YL1G0lhGT7o/iefcyG8clAV1JX+QzhpeHp13iDU81TT6PU/aZJcIuN6EHd3?=
 =?us-ascii?Q?ZNTFEVR5ETVlJaxqaX9TDlpTB/BKXY1cPqs7sqDpnPUnxaYxp7PPDz4sEeHO?=
 =?us-ascii?Q?4nFpmDGxFFzrWId5emRzBZoZf7v0AtlRVVFRmlO1EjEgt5p0Rt0ciGOsINoi?=
 =?us-ascii?Q?D8z8teCMutjeauSXzCj6dtuITh68YN1aIukgOL/y+njYzvueCV9ifwKJd+bM?=
 =?us-ascii?Q?Si4gqOdIEAO58N+979RkfM8HbPn0sxCohiymVcYxUPcB5YhZbmBmizTbt75w?=
 =?us-ascii?Q?//pgHr+vcm/Coj8v74UEvoYdPL2kdOVbMoR2HPahVDA9zwn9gxV9uuU4vrbF?=
 =?us-ascii?Q?7wiYeRjuBgHDlQKDGUjrmEbtYZqd56hdXUcO2njnQzm1d7Zz6s3Luu+X60Ls?=
 =?us-ascii?Q?fNdyqMHrlS7dhJv1kBByrpjJVO2ZieN1Zo1r906FpO8RaMcPc2+c9hnpHr2d?=
 =?us-ascii?Q?GWHKJ4SeMbLNVyPPJlLhY0gVTWV6kKKtzdEG9551w22ROtnV0E0SIeRoLzrP?=
 =?us-ascii?Q?9Zsoyy0KZEvNDdsxrlHcFEk9RPIALlP2HMDSXXerC9fw2S23hjjwmPQPNXB/?=
 =?us-ascii?Q?U6GnEkME2UAbAzrnCu2KofsHjMV/YdD1Y1ubEuoxlBhhURnPoKDFMOwZj9SK?=
 =?us-ascii?Q?0W081B+v5OBA9n5FeTdwXjJA+D9xJpHHhFNDBsNo7sjxtkzXjubfK9vQ4N2u?=
 =?us-ascii?Q?NUi4rYWisBM3sNK8MpKkpjttlglIde7ev6F9YRQDPkw+y1XdlQB9THBF3KOQ?=
 =?us-ascii?Q?e30++u++SZeP2tmivXlcq/sBwZ7zEMOr3JkFDz/FniN/G2HsiwsdnkDMbdD/?=
 =?us-ascii?Q?oK116dDxjMKgI0foR98bxIQ+A3WkTmJLAeEPoXuB1WOoBMMrBuoYJfFMQ3J4?=
 =?us-ascii?Q?CobU7zAjPcc8Yp/P7V7juXHeqUJ+qiANjtyZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:40:48.0356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7712344a-05b1-4b00-9a25-08ddc0cbfb2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8211
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

Re-emit the unprocessed state after resetting the queue.

Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index e542195972dd4..5d56029e88a62 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1469,11 +1469,15 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
 		return -EINVAL;
 	}
 
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+
 	amdgpu_amdkfd_suspend(adev, true);
-	r = amdgpu_sdma_reset_engine(adev, ring->me, false);
+	r = amdgpu_sdma_reset_engine(adev, ring->me, true);
 	amdgpu_amdkfd_resume(adev, true);
+	if (r)
+		return r;
 
-	return r;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static int sdma_v5_2_stop_queue(struct amdgpu_ring *ring)
-- 
2.50.0

