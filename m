Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE8BC8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:21:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7E3A10E952;
	Thu, 28 Aug 2025 09:21:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LpNxNyLJ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5289B10E950
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:21:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5UBdR1HI7I4UvIJdSyI/nxepa11GqTsyQCASywdEa1byO+BgSi7yldkDZ279HCjnTgJweISSHJCzZi4eie4wlP61rKI0gS2568BT1nUylzXTUXSSJ/ZTGKvKr8hSHJUr6gh9EzagFxDYYsli2TXDbsvEWszs1ufm/Hma55A1BTMaOhZh/3XMDfgUdU2yJ3Mjy+3iwcSmw+D3sxE4tbplhCmpYd6i9v9G7g2fThjm9p1bjKIs3EB7TZ3o9LmmNYciraKM8lOPX4PBdD+lSyO6HlhUSn13hmJYMHelUtakhthM6yE/8uO/M+WBwhiGWJ/QrnA3YCpgam1qjmYLZ3fYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bkK/PSa0eWhTWxZbQflOCEmAExpUEoGTNAKGy/cuiA=;
 b=g6eNK85SBTvdycqhwOg0bq9QOt//O3hzkUCbZ3dPviWTAkQTZC5Bzd0b18k4UrQ7y11hKg3MJgfjA6+Ey5y/6b7b7it0/+ncBL0pXnElyfm6H/3nSAX02e1DTD/xxioMCDfGCxi9vFE5cI7MMnOMxLPguBcDvE1imJ00mv9EXCKfUrTJy/XqXEkMWOtfoLVldi389bWdc5JCtDlJr3V7zdfGKXZLTuAjJ7XBy9DtdyouVmDS35LH55oO9cIL5DExL2oZgYaF+G1uj+UpEqXFzlZ6yT85vSg54wesmZ+Otoy25HH7QrNfg/PNDBdJCytRHLSIqWzmj/d26dReYoj7/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bkK/PSa0eWhTWxZbQflOCEmAExpUEoGTNAKGy/cuiA=;
 b=LpNxNyLJn910F9c15JDbMMa+Fck1Yg+p5VJg/QeVj5msyWKqpV7D5/Fq0YWmXfbS2bjZlDhwGqOLjAcZO1hVsqUotW5v8s3KROt/ixOA7ICm39saFkN8YxibohxrAxaKwcgaO3RvOciR40Tsn3FWteV5/Gpb/53xWMn3lmA7YCI=
Received: from MN0P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::30)
 by DS0PR12MB7825.namprd12.prod.outlook.com (2603:10b6:8:14d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 09:21:20 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::7) by MN0P221CA0008.outlook.office365.com
 (2603:10b6:208:52a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Thu,
 28 Aug 2025 09:21:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 09:21:20 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 02:17:24 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 28 Aug 2025 00:17:23 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 3/9] drm/amdgpu/ttm: Add New AMDGPU_PL_MMIO_REMAP Placement
Date: Thu, 28 Aug 2025 12:43:29 +0530
Message-ID: <20250828071335.3948819-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828071335.3948819-1-srinivasan.shanmugam@amd.com>
References: <20250828071335.3948819-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|DS0PR12MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da43d12-6ba9-410f-d7d8-08dde6143ff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ck1NeER5ZjhzTVpibEIvY0V3alUxWnBPREdjR25nREFVWDBselJZbXpQeTZh?=
 =?utf-8?B?V1hXcmtmbzFXU3N2WStKQmFpcmFLVHZmemFPWHYrVk9JeXFKVmt2SU9IM3dG?=
 =?utf-8?B?NTVVUldPcWEyV1dGQ1BwRWRQU0RVQUNCbi9VNWtWbmlVZTZDZTZFeGZuU0Mv?=
 =?utf-8?B?Mi9yTEZrdTZ3RDZpb1VoMHZZalRiWXdkS3Uza1MwTVM1N1FkZm1oQ2NYR0FN?=
 =?utf-8?B?QW9QV0F0VjBhTmxLYUsrOWdxdURuYTcways0OGxWc3Vkci9QUFNDTmJTY2JM?=
 =?utf-8?B?aGRQN1lnRnliZmhBRE5ha2l3NjRweW9mMTlzYUQwVHlKaHcrMGQ1UENtclQx?=
 =?utf-8?B?UkJLZFN6bXhmSXZWdW9RT0pPbXJ1cU9aRmFkdktsbWQrVnNOY3BrMDhOcGk4?=
 =?utf-8?B?SDZXTzZwd3hmaGgyZWxCWHdtSzZPUlludUMySVAzMnArc0JqY1FLNWh4QllC?=
 =?utf-8?B?S1BYZzNYTmlwcElOMW1DZVZRay9Iclh1ZHJmdjFKaklwVnlCSEJpZjJ1alRM?=
 =?utf-8?B?QkZpdFhrRFIxSmN0dkQ0Nm9jb0FoWTcwT3ZmcDBLVGhLOEQ5U2kxTThDNm4y?=
 =?utf-8?B?SnFwTUVBN3hDSEFtUm5wbkpWWERsWmNEeHRYbVRxSWN2V2FHYjBhdVpSSnU5?=
 =?utf-8?B?ODVTSGRMODQ0MDRWUENhVnpOZkM4czJDUnRLNmozRk1SVVVzdDFsV3VPOGZJ?=
 =?utf-8?B?dXNYZDBmdXlsazNMdC9jTkZzUVNSSGtTOEVnNFE0dWkzM2dmODVkZTRKUFUz?=
 =?utf-8?B?VzdISzhVR2NQdHlNUFJTZmZzNHZnUzNwbWRxd3A0cjF3TW9hOG1DQ2lTaEJY?=
 =?utf-8?B?SlNUeHIyOGZ0QWRPa0VtWnZiL0FzS0pNdkFndStrZlNvVHZKdTJWY2RvMWVN?=
 =?utf-8?B?OXlqbThjUEg0N25KS0VEdGdGbnJtM1c3bzlPck9Fczh5UEVYdTVPbUpVL1Rk?=
 =?utf-8?B?M3dSUzJFdmd1M1pBRGJwUTFMWWY0ekQ1WGdNT3VDVVVoRG9uZHpnSGQzSWx0?=
 =?utf-8?B?bDdjRGZrVzQzTEpnVWM4dzE4V1BJaFdWN3NxWVRlSnFNKzl6S0VDSWk2bDdh?=
 =?utf-8?B?Z0QzT2pvaTZRZzhJWjM3Zlc2MlUrQmUvWEpMQStzaE8vdVIvWjZYK294TjBO?=
 =?utf-8?B?RGRjb2hLWjVjMWpmYkdhRkpHb01COVB3Wnd0d2V2S0RyWGI3bjI3WDVOUDQv?=
 =?utf-8?B?b3dUWTQrcm5UMzZzWkdDdmpnVkRTMEFWZWJEWmdsYmpZaVNidWRCZGxySzF2?=
 =?utf-8?B?UjA3K0s0U1E5RHZmbFd5MlZaTEcxa085N0dGSk9PdXVVdVdjZk9zWjZYc2Nh?=
 =?utf-8?B?QjNnalJoaGM3dGx4LzBGRTh5b3dZcmZMbGZWdEp3RW5CdTR0YkdZdW03alRY?=
 =?utf-8?B?WjJhK2RRaEhGbFp5UkxhdUZaaUQ4eVZtekpjamwxdXpnSGlPdzFDK0t6NEVI?=
 =?utf-8?B?Qkg2aWtCaGtldVFPc1JLNjJMTWhhUjI5NThYSk9tQ3lSME8zakM4eWFTT1R3?=
 =?utf-8?B?SmZtYW5hYmE4SnlkcjIwbnczVVdpYkZsczVyWDZxUWl3TnY3blJYRDByQkFS?=
 =?utf-8?B?R3g2NjltdVV2N21ZazRHNHpXQk8vUE10N2g2MVgxOE9ub3VCVlQ3TUl3eHRk?=
 =?utf-8?B?NktJbVB4d2xCdWhiSmJ3SXdvaWFKdm9oZ2lkZ0lvS3FwVThJQ1B2V0Uzd253?=
 =?utf-8?B?dFlFdjlDTmhQb1luOHVGSVBIMnFsb1NJbUFJeXFrNDFIT1hCdUpmTkVNV1lS?=
 =?utf-8?B?L25SSENsVXYwTVJkaFhYc0xxMGRweEtrN0h3REZiWTl2TEY2TlNlUzMwNkll?=
 =?utf-8?B?NjBQaFl1SFMrNUF6cEgzbXVVelNqNmQ4YjJuU3E0N29uMHJ6MWx6MVA1RFgy?=
 =?utf-8?B?YWxDR0hnRVhSSGJGcDUyZk9zS3piS0dmd2l1UHhTOWVXVTdtV21rMnlkNkVx?=
 =?utf-8?B?R3oyeEFLNUEzVmxydXlQSVVGNk13cVdZQkp5SEpmYjYyUmFZUUdsajRzejVL?=
 =?utf-8?B?SmtHTXhwL0QyMGt2L2pCb25sQXVmMHIrSVBRZHR3UUJISVRobXFnUE9WaVg0?=
 =?utf-8?Q?IoSyTd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:21:20.3117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da43d12-6ba9-410f-d7d8-08dde6143ff9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7825
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

Introduce a kernel-internal TTM placement type AMDGPU_PL_MMIO_REMAP
for the HDP flush MMIO remap page

Plumbing added:
- amdgpu_res_cursor.{first,next}: treat MMIO_REMAP like DOORBELL
- amdgpu_ttm_io_mem_reserve(): return BAR bus address + offset
  for MMIO_REMAP, mark as uncached I/O
- amdgpu_ttm_io_mem_pfn(): PFN from register BAR
- amdgpu_res_cpu_visible(): visible to CPU
- amdgpu_evict_flags()/amdgpu_bo_move(): non-migratable
- amdgpu_ttm_tt_pde_flags(): map as SYSTEM
- amdgpu_bo_mem_stats_placement(): report AMDGPU_PL_MMIO_REMAP
- amdgpu_fdinfo: print “mmioremap” bucket label

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 2309df3f68a9..bb17987f0447 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -34,7 +34,8 @@
 #define AMDGPU_PL_OA		(TTM_PL_PRIV + 2)
 #define AMDGPU_PL_PREEMPT	(TTM_PL_PRIV + 3)
 #define AMDGPU_PL_DOORBELL	(TTM_PL_PRIV + 4)
-#define __AMDGPU_PL_NUM	(TTM_PL_PRIV + 5)
+#define AMDGPU_PL_MMIO_REMAP	(TTM_PL_PRIV + 5)
+#define __AMDGPU_PL_NUM	(TTM_PL_PRIV + 6)
 
 #define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
 #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2
-- 
2.34.1

