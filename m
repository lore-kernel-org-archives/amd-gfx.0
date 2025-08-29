Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1F0CA0FF9
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Aug 2025 13:59:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0356D10EBC6;
	Fri, 29 Aug 2025 13:59:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VLAgoVDX";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3FAE10EBC6
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Aug 2025 13:59:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZVP+N/N+SldYCdH7YmZ3eMXH51MagGRyqSMNTxwRA2qqhsbdHf7qVhHTJgOwZ0Ecct5J504TFjrFaVjcJI07AWPEeHloJWim6Z/1F72wzedqA+Hj2XWqJQxGLGgEqJNYycq9/rb9MwtgidFGO3QQGD5ctq0BY03JI/Rrifisew39CTW7XiX4N+A8I236vWaAhWel5CrukTpNgI0LU7XNFN6NDIf3gDtyT9GR9alEXycJSnscoB6t5yHCMwvFPImcN3m50yj1jmnlkmHvvx8u1vRwJnDiSfqqAjUNlCVFv0GNaKx1fA6ejoF+MWx5snrQomrSttd4XFLzlvMiNhDwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QR3ExshdUXvTNfbAEYmtcYZ96cUrQhO3ZKmdNp5BilE=;
 b=e+v4VVy55mGt9SBKfe8qAzKjJXQwPjpSo0YmG71+k+BYBjnW1pUWI02IMdBV6BhJcPGnea6o4Fm84qBnyWlo64lzaH/oymGbbm/tukpcj735veQrdKYuT3QP79XMGmtERQD9EBgIiawqITCCIOLo7PKc4a+JjPaUZo9spiep45tzna/hGA64AzxKzXHhOgjUu4FKmN0k87yX2mkPKlnVMV9WnE47nEBqflxP0nVs1ZJ/vj6gL5pC3x3ZnVA+YDMvo5EbhlfVWqVADsSapkqbj6Sh2+CgJn25xdMLqGII+19szGnEMLlgNLNgKzT1mr9vw+O2w128IlY36aGLIHb74Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QR3ExshdUXvTNfbAEYmtcYZ96cUrQhO3ZKmdNp5BilE=;
 b=VLAgoVDX3h8UoN4fFGX8XIvb9HmIDJvAgQl/lwHBp2KKepRra3ZgncC6sf1RmKDAN4HLkClW0JhrRjX5Wg4oHBQ9SoXYdmPfsvr5d45hAu8ulI+IOEkdqX4KWcVvHwTS60v84fttWJprEweIPurrSlR/lcAXLiWKNLd1o3Vnrkc=
Received: from BY3PR10CA0030.namprd10.prod.outlook.com (2603:10b6:a03:255::35)
 by LV8PR12MB9205.namprd12.prod.outlook.com (2603:10b6:408:191::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Fri, 29 Aug
 2025 13:59:09 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::be) by BY3PR10CA0030.outlook.office365.com
 (2603:10b6:a03:255::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.20 via Frontend Transport; Fri,
 29 Aug 2025 13:59:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 13:59:07 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Aug
 2025 08:59:07 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Fri, 29 Aug 2025 06:59:05 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 3/9] drm/amdgpu/ttm: Add New AMDGPU_PL_MMIO_REMAP Placement
Date: Fri, 29 Aug 2025 19:25:17 +0530
Message-ID: <20250829135523.4032168-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829135523.4032168-1-srinivasan.shanmugam@amd.com>
References: <20250829135523.4032168-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|LV8PR12MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: f1366453-fae8-4d93-798c-08dde7043926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFZwcDVHM2FhdzN3WmVscHdzSFdtSnFmVnptczE3S1lWN3lzL0lvdWFpczEy?=
 =?utf-8?B?V1g5b1p3T2hCQkdyMWhoMjhPOHpVM1kyZVltSTZBckQ0cWNuRUtpLzJyaGNa?=
 =?utf-8?B?MnM5R1dCY1YzaGg4RFhMK0svSWwwdS9FaEpJZmswZ1FyaWlaRGVIbFR0MGNo?=
 =?utf-8?B?anAzZDFRVEc2SXhYVDBLc2NjSC9KanZSYkhpZ1U4ZlZNRUF1NFJPZ3MxQlcw?=
 =?utf-8?B?SEFsNkFVdjlKaE1oTnJuWDh4MytTQVg0UEtPNnVJVHE0UEpIS2ZMb0R5QkVV?=
 =?utf-8?B?cEZxVEJVbTlTeGhKenBENzNOOFhOSWZZVW1QZkNuby9RdkR6SGN6U3FJOUdQ?=
 =?utf-8?B?Q2hsQ054VGpuQ0hXMVN6NTR6TzFJV1d3RGJXVE1NL3lZSUZGVTdDN1BqVFZ0?=
 =?utf-8?B?VE82MGZ2eExEUWVZUHlXbDUyTk9ZSzRTL3MrbkRHUWNVZ0hRSkJPeTIzSDY0?=
 =?utf-8?B?dTAxV0VGa2k4Y0RUL3pjMmo2NXI0ZnROT1B4b0dPMm9ScGk0cjgweGwvZUdy?=
 =?utf-8?B?S3RBUFZKSW1FeGhCc05FcllNVnlpN2VrMXZxSy9EUW8zMnRZdjkydGNuZkRC?=
 =?utf-8?B?L3IvcDhwVXdPbFdIeWlEN2o2SGF3Mk52NTFGWnlnaml4aEU5YXRvWklBSVha?=
 =?utf-8?B?UGliN3dxMktPWmNWWVF1UVBpbFRZd0p4VDRnS1hXbWlEbUVCQ3JNVEFISTR2?=
 =?utf-8?B?WXVhd05HdDBFSkhiWHQ1UTdDUE9MTkQ0blN5N0FJTkZwVUgxcXZQdFNJenpZ?=
 =?utf-8?B?RjZYakxEQUhTQVVkTmV1U1ZDT0M3ZndnRmVHUTRVcVl2bDhWSXdTdDlyT1dq?=
 =?utf-8?B?VTVlRVNheFRSVVhBVGp1cHViOXVyblRDZUFkb2RGVXpIb0krZTc4MWZKbVdH?=
 =?utf-8?B?RVVGWGJLTjFid0JtWXJTVW95UDlnQUlRaGUvdFE0QUQwcDZEby9GdEFlYTZp?=
 =?utf-8?B?Um1FN3FOYjJkVGl2MjdEUWF3QU5EdmUzcmxMUERaVUR6RnBDdXBUQXQzaG9S?=
 =?utf-8?B?cWRHWVM4NzBBTEZXcWVIeUFuZ0FvNGptQ2FiNzV4M2s5L0s4RjZKMEEvYyt6?=
 =?utf-8?B?RUUyRUJpQTdUcHQyTWlVdURLQzNIc1lIbHNRdHcvVSt4UWtJMjNUdUNhSXBi?=
 =?utf-8?B?dWh6c3lWVk1WZi9IYnE5L1oyZnN0SDZtdEVIQWpQTUVZRDc3VmdYWlV4L1My?=
 =?utf-8?B?dTJ6bHFsVFBKR0ErSE5acG1teS9aSzZlQ1d2aEZ3clp1MVRnTXlKUGx0Y2o3?=
 =?utf-8?B?SGZLY2pRbzg5bkVnZG1zRzFMQUhhdGwvYVpzTVEzNVg5M3ZmbS9LRGpOalhE?=
 =?utf-8?B?WWhIOG9seXRLQXNwaHMxZWkyNEhhOWFkV3RRQlQ4Sk5OTjBFQ3dtQkcwV1Yv?=
 =?utf-8?B?TjFta0ZYcE91TWlqRVdGR3Zpdi9aRVcwZ05kRWI1Sm9wS2l1UzZlZDNmOVY3?=
 =?utf-8?B?dHV0ejJBeDhKNmhyazBoZWpzaTUzMlo1ZDZkTmt4SFdpbFV4NTAwT0VRa3E0?=
 =?utf-8?B?a1R2ZXNoR0FnU0o5aVJHVUloeUFQbXFnemJBYzBKaVZTZmRGdHJnbklZaFhW?=
 =?utf-8?B?dVF0MHluZ0RlMFdVWTJqaDIyWDRvSUZkdlRIQVBNK1ZhV2t4WVE5VC9Xek43?=
 =?utf-8?B?SldOVTZ0QjNJTFVEUUd0eE83WTVXdVVpRHlnNTR6RUs0YkxaYmFnQ2xrODNk?=
 =?utf-8?B?aDYvTVVoaHdxVDNBTE4wWEtsNU1UbFY2U2ttc05UYS9VZW5jc1VmUmVYSjJ2?=
 =?utf-8?B?N0JYNmpBeTZUdXNtWkZLMnpmdDJHQXUzU1paam5RQ3g1aCtIc0x3SnpDUUpD?=
 =?utf-8?B?UHBNUWNqYXRXWlNhMksrelN6c0N2cGhzT2FGdWhJWlYrcWNLbDRtSTVYSnVs?=
 =?utf-8?B?Q3RrZERMUG43WEZSZlJhaHo4NnJJVmgvVjFXcXJrVTVtdGp3ZUZ0MU9Eem00?=
 =?utf-8?B?Z25CU05CekNKRkpTWmExbVhlMUdIVUV6NEVKVVhKUzArUFBFQ2MxY2JreEhV?=
 =?utf-8?B?b0JsalUzUDBpRFNtVEtVekw1QzE5dFdWZFd4Wkx0S1d0ZmdTR0l4T0VhZ3lO?=
 =?utf-8?Q?jkJs8g?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 13:59:07.9838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1366453-fae8-4d93-798c-08dde7043926
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9205
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
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
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

