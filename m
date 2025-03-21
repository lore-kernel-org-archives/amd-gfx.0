Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13BEC28B30
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Mar 2025 01:26:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 738D310E02C;
	Fri, 21 Mar 2025 01:26:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hp1KFJIV";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 923E210E02C
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 01:26:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8HBRxQ59O6CtDufjAuDYRvSFwVqvNm1dXn2cTVb1fIhJIT2uuuOrCCXxthqQKKizuWMon1K34SzCNmEdDymb7xD/NXs/vcpE9ghZtNG574pZGnIXikJ5GCwVKJ0NYDlOdBK9+nApF4+JIL3DDdtLlEsN3DUm0Qm3HMWCZtjoUkGelDOHdn/72Bpz7jtHIMjX8t2uqog/mH2/4KWsJSZ1G4B4WJR2KGp0JwtZwuFz4zJY/7oXqr1E46SCjHRLd2A6U9wxSypmr59p8H7/0XCINUoFd/AJ/bxLRk8dy8uMeIK6VAgFoTw22Vh0dyoz8nzf5VBOQpeYL2dvXAqPxSqZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7dcD2bbez/uAdlytBKBV9CBSy+Q9cuwfBglBSU/9Q8=;
 b=OIlFMnIlz5g6Dm641anI/t5K662DzyhKRxvv/6PRO3uJ0o0osyfdWqdx89eM1NRb9y3Xjrp9i23hxpubfbMCX94hCAHGBTET44mKKUdF5NVkKfU8dd117nsqjPf7VzuqwsmQpDMs9IefcpSygMAIFPl7Lt/rWI+c+kPonFUCa1O2+bfnsC0/QJcxkPpsQw62vUDXLAN20whlyU9/2ylBzRwIlllZSwawXX0MdJkNmemihpEC6x3BJofPVTo4owYBNu0OH6LDO7dAlxjdd6Isb8+cPIZaZFEzXs8hUAt6hP0dxb0zJUI2AtD7tWByuBPLzDnoRAO5PgZ6JxkeuaTpFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7dcD2bbez/uAdlytBKBV9CBSy+Q9cuwfBglBSU/9Q8=;
 b=Hp1KFJIV/gDjLya7TYcyxsoddbQEGqb+tprc1xmvKgFKDm4jnIIsGwGkLxAwJ3YZeg2dUrwXn6lQNnLb4kj+0gIrZOcDQf7G+NP0TeAzfmpl4/5DPS7brvozBsDZez2Vm+uPQZhru/aMhCffIwkxMMaeaAML58JhYIEEQyQSb7o=
Received: from CH5P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::19)
 by CYYPR12MB8730.namprd12.prod.outlook.com (2603:10b6:930:c1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 01:26:05 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::12) by CH5P221CA0006.outlook.office365.com
 (2603:10b6:610:1f2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Fri,
 21 Mar 2025 01:26:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 01:26:03 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Mar 2025 20:26:01 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Add parameter documentation for amdgpu_sync_fence
Date: Fri, 21 Mar 2025 06:55:48 +0530
Message-ID: <20250321012548.2397824-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|CYYPR12MB8730:EE_
X-MS-Office365-Filtering-Correlation-Id: 13fa810d-747b-4704-cd32-08dd681758ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXFTRGp0SEhEcFhUZUkzM1RPN0dpblhMWG1sU0NjTkZIRmhwYTh5T3pHOWxR?=
 =?utf-8?B?ZDZDejBSTHNhTmlvSGhYOFk5RlRuY2pyWTMrQW9SNlFaUmRXS1djM1JaQTFa?=
 =?utf-8?B?R0tnWndoNWNTUlJBUFZwcXM4RnJNSU5jT3NvU3d5a1ZhalBJTkJnUVBoZ2NH?=
 =?utf-8?B?dnE2S3ljZmI1K1k4SzIvRGNNckpqVE1ORmdlY1FzY29vNlROYzJHTHZETDYr?=
 =?utf-8?B?WlVNakNDdnlDeUpZMjJEZVcveUYzVHdYKzVxR2JoaUdnaDJHMDZJbno3RVRr?=
 =?utf-8?B?MzBzR3V2SDdJSVBEb0ZSNXhMcU5IUUZycDZhZTl4VWhmUytyWDdMd1lsLzN4?=
 =?utf-8?B?R2cvQVpvTWN6MVpIR25MU1JPM1oxcWZCbGx4aU5MVGVHenlHRzg4emZZclN1?=
 =?utf-8?B?NjJtRVdEWml6UlVhKzJoZUoxNFc3bmFmd0Y5KzBtaldXb3k1TVVYQ09FZWhK?=
 =?utf-8?B?U045bVptSTUzV0IvQkkzbXNlTVl3QlA5MkdnQm5ZOUdTZ0RhMnJwaU90ZXFa?=
 =?utf-8?B?OWV3QjJCdnhMSUcrMHB5QUJ5MTkvV0F3clcvRWdVUGZtRTBZKzY1dmpUME1l?=
 =?utf-8?B?ckRJUzZiOVBuTnVva0RCeDlla200cFhPQTd6VlR4aE8zdGQySTlsdDFKTzcx?=
 =?utf-8?B?MmFyZkVPT2VYN0ZkZ0xPTVJBMnE0dE1RYXBNNDVLdlo1OTZac3R1UnhXcWJ5?=
 =?utf-8?B?T000UEFFODBYTU91elVIMnNuVEVKcjNMTDBKeEVaZkFCc3FDWTlvYlB1TDFP?=
 =?utf-8?B?OW5icWxKaHlCS01ub1lFMmxjdFhXdlBtd3pWdVNESmFMbU1QdzJLeUo5aGRB?=
 =?utf-8?B?K3dGV0ZIdmcybWZUR051S1MwcjUrc1hkVGErOEZsWE1McWtTOWRQQkpMemt0?=
 =?utf-8?B?Q0x1dVpDQ1dFZ1MxdWJWVUVDRDNJbGR3aFViSEFjbjM2NnJiQ2xUYUZnZk56?=
 =?utf-8?B?SzRHVjRoVkNIMFAybk9hTXBmTU9GU3dHUjNrME9US3JhdU15dytnMXFRLzlp?=
 =?utf-8?B?QXE2OTQzL1F6VmF4TU8yOXBVTmRISWk3RzRvY0xnVExLT1lVUjNHSEtwTjBB?=
 =?utf-8?B?NEZVcEN3NHFSbVA3MnJ6b2hBcTNmWGp2bXJJR2xCSExjOUlGYmMzS2dXbGR3?=
 =?utf-8?B?VDFoWWx4MVhmd0FtbUpDRUJjdEkxck4weWhaRzNQRmZEb01ubzRNazAxVTdx?=
 =?utf-8?B?ZkZDY2kvQk40NXFYUlhLOVp5RXRZMGNWT3hmZ0R2YUdhM004NjYyWFZwT3h3?=
 =?utf-8?B?MTZScldLZW1rd1FCaUl4UHFHYnpEbGExRUYwZCswVGszbnVVZE1telIxSFRx?=
 =?utf-8?B?MkNGUnlJelVtZVA3SmlidTBPTFhlRkxTaXpNVEFTTjJ6ZjBOVzRXdXNvNUJa?=
 =?utf-8?B?TEtYM3ZJNFBKT0FlQUNIYTExNDlwUUVBelNmMysxMUErS0NKMWRiQ01lZm52?=
 =?utf-8?B?QlNHdTNLall0aGRPTjVlSUFEWFZ4U3JuVUJ6RVdLSTBTYkExVVZmbnBDSUMy?=
 =?utf-8?B?YnJVajZMS2dzZ3VmV1cwVmNUc0tESEJ1ZmwrSUltNlgvYmE1dXpZdmF0MjZT?=
 =?utf-8?B?SDQxaTJIV0RtM1FhTW5LQ2drOGZVZ0ZQenJ1Ky9ZcUdsWVk2NVIwNU5qa3Fo?=
 =?utf-8?B?UDZRcy8wak1NVE5TazR3MEZlT2t4eTMvTUFLUFQ1WENYT2tWU096MXdYRndH?=
 =?utf-8?B?ckpKaG9RSnNrUndjV1VYNDloczF6ZE85UHkzWnFGcW1yRGhkaVlTS2xraHVP?=
 =?utf-8?B?TmczQlQ0RjI2bkZTVjFjTm1kdU01UERmMGJrSVU4WmpLUnRHVVA5Q2NEcnB2?=
 =?utf-8?B?NWVmMld0cWZ3TURWVGUwSFd6VWtJUEpiNlZnMU54NmpaRUNyUjRKTzBaVjl4?=
 =?utf-8?B?RXZBcG9SdDU2VkFhTEVsZGU1ZW5KdDcvODJ4YWQvTWlPMnBVSjV1cTVqdjgw?=
 =?utf-8?B?cW9IQkpJNFJtaGJRb0ZrKzVaU3psZzMySnp1SU1waEVXcDdlTENXSjZ1bXU4?=
 =?utf-8?Q?pUqk0CQr/CiFa/XXdEod/zrnA1w/a4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 01:26:03.7870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13fa810d-747b-4704-cd32-08dd681758ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8730
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

The 'flags' parameter, which specifies memory allocation behavior while
creating a sync entry,

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c:162: warning: Function parameter or struct member 'flags' not described in 'amdgpu_sync_fence'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index c5f9db6b32a4..5576ed0b508f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -154,6 +154,7 @@ static bool amdgpu_sync_add_later(struct amdgpu_sync *sync, struct dma_fence *f)
  *
  * @sync: sync object to add fence to
  * @f: fence to sync to
+ * @flags: memory allocation flags to use when allocating sync entry
  *
  * Add the fence to the sync object.
  */
-- 
2.34.1

