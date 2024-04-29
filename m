Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FABBC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:34:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F024F10EE8E;
	Mon, 29 Apr 2024 14:34:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0cD/tx6T";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8764910EE8E
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:34:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALuxcPATSjo5f3HzGIrWJP2gX50flrJUC4MLFyLtGYx+IMey7md0jlecjykz4svetA3EkIvfU7owTEjnarsnLF4gqiWGUa/mbjb5a/mSzolPuqoDewRZCWiRPd3kPXmrQAmSivSOzEoxY0zjA2dvq1BB6sTXXvASqGKZfr9TvVY48CEjWJNrB+KktiDjBzbBOBeTQXUxk8VNLkEBjvX4WJI8VUdv5qDplW74RhKjTP4KcRo210RrKTDIAFKhOalbcH2xd/hRgcfxNAIvhtAi/5lc8m4qwecoUTQhOHrmhRSY2CPrQkuTcL/rWqof6iCHotgTS/3WQ3oADChtcDD5xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfwBxTMRU15tCCgV3pliiTJd8q2Kbr5vBfWkHe8MZu4=;
 b=NGcg1dd/Nqsp8tXkjF6uuhwVYFMwvnla2wJdASyT6n0GSzj0ABWrHmuLCIIrwmuf6LosmWPfosuybfcwzvL4yTRYjvMho5dEipyUfoLogCDhPE1RG7yo8ITpAfTY9XGTMGlXoKBVoki1dPvo3GfJObnpwRpwP27N5+dNX5qOApU73AUNorEIrzc5LaoJtEYYKHaOgyAkATewdh0OpkuE7aGNgGnUfWrci+puaKYK9ktTccxM9fRXqHUwClDvLh4BOfyNsIQoPaJo1+RG4LFDXX79CqdJf54EotnFAmLQHwXA41eNLs7TXY+gbYnrrVdbp0mZTgXd0n+pAbVAi9e/uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfwBxTMRU15tCCgV3pliiTJd8q2Kbr5vBfWkHe8MZu4=;
 b=0cD/tx6TkufEd4Iy4dwJRrWS6JdlS6VXVo+Z8ta8XrdX5qtzgpXS9J0F0eWdXrS5/8kAMZCueuojc/+R8EWqxX6NBas5hh82yFw95LU4N2RpZmgcw55VEwxP6SxCq/8Qzr/v97BSXCx+N2LdKG6fgZonNeV4Puf+HBupeHjtHG4=
Received: from SJ0PR03CA0356.namprd03.prod.outlook.com (2603:10b6:a03:39c::31)
 by IA1PR12MB8310.namprd12.prod.outlook.com (2603:10b6:208:3ff::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:34:10 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::63) by SJ0PR03CA0356.outlook.office365.com
 (2603:10b6:a03:39c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32 via Frontend
 Transport; Mon, 29 Apr 2024 14:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:34:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:34:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 07/31] drm/amdgpu: init mes ucode name for gfx v12
Date: Mon, 29 Apr 2024 10:33:15 -0400
Message-ID: <20240429143339.3450256-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429143339.3450256-1-alexander.deucher@amd.com>
References: <20240429143339.3450256-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|IA1PR12MB8310:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d5ca99d-6302-459f-1b19-08dc68596e92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|36860700004|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uz3Lynjz9Z4oFewzK5J7RA7AvtfiIbiOvZG0aUtsVDY3GFUpUaY+aUmQ/0ND?=
 =?us-ascii?Q?B+OJbRw+PVRmXQbd15pSkD+evnfOQEDCPgCe0CzDffzBBYPTLDab7rZU/sAM?=
 =?us-ascii?Q?O1LlBY4kZFccBuoGKYtFfB3hZU78Re8gWBiVEohqQX6pPAZUftshbZ2HxslB?=
 =?us-ascii?Q?3wZBIaGUK5oRwL7utcuKqX4IpWsKAKiH1FPjA95SqTA1hFHKQbABjWMY3nW9?=
 =?us-ascii?Q?m1S2LR10/Gsbo/CyCPrVY8hOaLaEHI+8Jb1AptauPjBLD5y63L9dgxQu8zIQ?=
 =?us-ascii?Q?/85T8V/GCvU6nYGQgcx9RIogGxXLON3GsUwYr4M2OvxAqseD4y5ky43OlcDQ?=
 =?us-ascii?Q?Le3Hxd2HIZ0YyZ1w/jMGjvFS7rQUwYgL9DJbv4LUYTt8iSSjbtxOcE9VGlKK?=
 =?us-ascii?Q?uC7Cg4Q4MwkuULXd7+KH+jrm2QSPZIsGdrPSutWW9rqNJml6LLlrDZSiqPxt?=
 =?us-ascii?Q?cgl8xnTkyNyNsxPvUPY/1mO+CWhb4sr0A1fjdz2H0nPKNSVZh/dCvJGoztCp?=
 =?us-ascii?Q?lNFIKYBAiPUiEbPArm2YHAVn2VWK5Hs52SGVqOSg+gQnMMJZ+re9dzl5qGag?=
 =?us-ascii?Q?PVEF/2pr9X6qXt861gokP00DXuOrrrkQ8YPwUe7Tg4Dx9DwPvStolTCC9C5a?=
 =?us-ascii?Q?LvC1d9URu1AgZ7sji16/DDjXfp3+MmrINgIWdSx3x0tT4p6Og69AMffGit9A?=
 =?us-ascii?Q?TrBmnP/5q0qEQ+pAij8xWWgtMN4a5M4TJqedFU8a5vgPOAhM4C3893vnWXFa?=
 =?us-ascii?Q?g9VY51sIeWQYCXkC55TUWYKEeT0iPCR38O21lT3R3WwaWqjcuJWku8uMWM9m?=
 =?us-ascii?Q?YKdmz61UlvFUyNKC7dNtRKzwbjhg2g1zq9b56QifR+pPFGWe/vXSBlJZDS0D?=
 =?us-ascii?Q?krvO2H/gFnYFeBItNOF3iczhd9x/2NM/Bsuu8PzTx/qE7fSRxwt7g/AcfWV5?=
 =?us-ascii?Q?cBbRuAQ07xMLw7NAwuTJjiAcbYrOB/Blyh9dluzgYSVZLdv6335sd8EW5JmT?=
 =?us-ascii?Q?qcY/hNTJO30hC5LwIKFXSMgQ0Fdq1cFAMyZ4+6rdPL4ZHLIQDUycY5JuVbAT?=
 =?us-ascii?Q?GkLwPDm3J4sg2bDp/gR2iFLgFbAlC2obdEUhddHdtENaY+B5GBQXkgmcrtQu?=
 =?us-ascii?Q?wvCYlWp37yJ86I5Mr0ikAkhpsx9MSrn5scy9aTmNOZpiJoCsg3V/mvaVqPmp?=
 =?us-ascii?Q?qEHCcevOy/0d7fQNyp02jxKCY0t/UqN4gzXFvKeiqp7slxixN52kbooJO2VK?=
 =?us-ascii?Q?MWgoI0QaXxpO9ESsdai6+ZkwNH22BPNpc7L8k0n+aOszbBuF/QLAv+N04ou7?=
 =?us-ascii?Q?31+8/yDRJly6e4trT7sNm/5iVZxLTRES5nz/HIrYjh6tF+HlRDcdfocBCp7n?=
 =?us-ascii?Q?c/cuFojrcGovI567JEsk60MCbVbr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:34:09.4808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5ca99d-6302-459f-1b19-08dc68596e92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8310
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

Keep gfx v12 mes fw name to gc_12_x_x_mes.bin
and gc_12_x_x_mes1.bin.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 5ca5c47ab54ed..02ce69e3d1ddc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1511,7 +1511,8 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
 
 	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix,
 				       sizeof(ucode_prefix));
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0)) {
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0) &&
+	    amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(12, 0, 0)) {
 		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
 			 ucode_prefix,
 			 pipe == AMDGPU_MES_SCHED_PIPE ? "_2" : "1");
-- 
2.44.0

