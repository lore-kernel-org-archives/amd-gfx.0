Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C4EC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 06:36:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BB3511A1C4;
	Thu, 25 Apr 2024 06:36:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cQt0QIGh";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BEB21123BE
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 06:36:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEeqmsbR7scydAJxKHT6ooVyoKe+fsEgtdsIo3FpqcMUAWkepRrE8dA8IxsljQFnrwdk7le/RIvhWmlXKA8v4B0gvkePCs5YhhPOmEoc1HI8Y+RaGlBx5R3seaiZ+sWh3Z4Yx6c3w6xcCaNPmWkafXWOQtW15K0PSqmwgUyrRN/0nkq/r20w8LYujy1bIUSH/N4Se80jfvCWj4wb71lvvES2Y4lFQTdTpWH55P3YcX4H4W1VARk0bcserJ21SPJEYyUTRhHjT6Scv9moX99eLsBljvS/wtJnIYJDuhiCaxGp3TlnYpqQ9TKJheqhAkrofteSPjBZ3I3OY7OKVx8AXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjJv9Qsis/E1HL7Z0UbbH98aG9xcKucMGRJYBbbRl5U=;
 b=Bo0GGkCuRi0VqgPiHaTV42BcP5RGfUShi7udgoOURLzGWmyDV0sNvuwqTRFzTOC27K2U1Fsnl9sH8Lwk4yNV9Houc5HCOTVzVAsIgce9QLdT2pNw62mHhTzNNZwzoWNjTu96/zFMv3qjWzM7VmMvqrtbEIWvDvL9qLPVmMYbkbblZSeZwt0Azc+d6Wx355DgNrvqBa5tFTNEDVMVrC0gUv7ZYcnTTLLkst9gSkQ+Re36G6JZaV5T/HC18VUTk4kaNijBvSj6UNIYymTKRupGhDapB9bqmBa5czaQIqvY5Z3ioUxXiWuuqsAcj3DHOdbgCTmQaTvSxqduY/O1XD8LeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjJv9Qsis/E1HL7Z0UbbH98aG9xcKucMGRJYBbbRl5U=;
 b=cQt0QIGhGIrLxgfyhAgv7vRaBlvotgo9Qkdb/7H1uZDTAQtb9rlzMa3kVAVpeAc/EuBE2rNy1ImlHsFnDfUOGRBKV+a8K1wWj0eH9IPboqxOvwo7rZK3c4lSMVHIOnN7r+QpzXSRPaWi9qbMrUJblrJ6mGV9fZ09rTEysBBjO8s=
Received: from DS7PR06CA0040.namprd06.prod.outlook.com (2603:10b6:8:54::28) by
 MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.22; Thu, 25 Apr 2024 06:36:05 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:8:54:cafe::d2) by DS7PR06CA0040.outlook.office365.com
 (2603:10b6:8:54::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23 via Frontend
 Transport; Thu, 25 Apr 2024 06:36:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 06:36:02 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 01:36:00 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Lijo Lazar <lijo.lazar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix buffer size in gfx_v9_4_3_init_
 cp_compute_microcode() and rlc_microcode()
Date: Thu, 25 Apr 2024 12:05:43 +0530
Message-ID: <20240425063543.2621823-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423014523.1598424-1-srinivasan.shanmugam@amd.com>
References: <20240423014523.1598424-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|MW3PR12MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b90718-edba-4bf7-ca09-08dc64f1fa64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400014|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VE00MGFuRzgxRXJMVGhYK2MwM0J0eExJM3poUktTeVhvRWFhU3lURStZVURn?=
 =?utf-8?B?NFo5S0J2OHB1OE02T0ltb1k0WCtwV2N4ZTNEVWNkVWdBcFJ6WmdUQ1VscStN?=
 =?utf-8?B?Q2dIN25aNk81NnN4UjdScFQySU5YNXkrdFBHNVZQNHdldlh1L2dyTzVXZ3lF?=
 =?utf-8?B?VFBqdk83dmY5WGoxaGRseEF6QVhIS0dhYk8yYytIY2N4eGQwUXBoTDJmZXFi?=
 =?utf-8?B?TThmVnBlbEVTQmg4d0ozSWgrUDBBdmljc0xXdy82QkJUa1krc2JSL0R1VTlj?=
 =?utf-8?B?YXljZkp2ZTgwbkppeVh0VzR2c2l1MDFhRzVMaFA3bkNwcStBZm94UnVLSDdG?=
 =?utf-8?B?eCtPdG91QncwMVplMGxwNVJVZzdKRU1MdGFJdUd1RXNad3JMa2F2aXJGbzk0?=
 =?utf-8?B?RkFzUDlkeVhnd3ZXTlV1Q2FRN2tkbGhzNjBVK2h2dWZ5OC9vRkVId0h6TTJB?=
 =?utf-8?B?Nm52bGJQT2oycVkvdlNzZG8vemxrTjRZL0VVeEVGcks0cW9ZZVFxS3FrcEJM?=
 =?utf-8?B?MWhGRTY0cXFZcTNwcGRyazlIcHF4emJPUEFqMXRZN0RhZEZCYWlwT2I2aTFQ?=
 =?utf-8?B?TGhyVkRYRGI3anF4NW41ZFhqd05zQUxkOTFxbS9JNnhwdlFUK2hIUDI3UnJX?=
 =?utf-8?B?bGpneVc5M3dGSmxlbzNOcDJsaitacGhQYjZ0TWpVZTUvbWJ4c2RoemN5cXhL?=
 =?utf-8?B?ckg4eEk0bytrZFpOUnRXc0c2LzlyN3g3akNHNVZ5THFIaUh3aXpKazgyUFhh?=
 =?utf-8?B?b1hvYlJrakpGM3dhVEd5UE0zTVB1aHV0bkFzaWloM1VMKzEvaFlPM2NUZEpK?=
 =?utf-8?B?SGFwQjcvVnhtc1NyNnhLR1dYUnpRWmtBQk04VlRNbXFxQnp1aEp3MW9sU2RE?=
 =?utf-8?B?a0NQMmZRcUd0ME1FTTArUXUrdkdEVjRSNjVTdjREeW01dGtWV1dhbnd1Zm12?=
 =?utf-8?B?WnowSmNuVEZ1N2FhMVA2YzFjaU1RNXhuaDdDUXczV1VqTEVYWmdCaUNRcUtq?=
 =?utf-8?B?bzVGU3A1QzNmRDBBRXlObjBSVFIzWGt4TFBwUU13Q29TdGlqandnNXFPaUMw?=
 =?utf-8?B?b1JnWkQzNTFiTEZ3eEpFSDZrQ1NWVjdwYk1OSmlESTduaDFZSUZzK08rUjd1?=
 =?utf-8?B?NGNETjZlYkpyYnRsSS9TT0EvUFh0MzZWNWdWWFAxRHJZZ1NGa3ROeEEwaVY2?=
 =?utf-8?B?QnZnMVMvWXNyVStpOWYxdGFYRjZaZ0dKRjJwVi9WNTA0MUtGZVUxR3JBZ2d0?=
 =?utf-8?B?RkVsa0Z3QVFrTWc2M3hJRDF6bnhrU09qYnhmdHFVcWNZdDJDRmFEWXYycnhu?=
 =?utf-8?B?eVR3bnlzbm1vZTR2R0poVjcyd1B5YytZSWlJekFnSTNWZUgzWXlzTm9xZEI2?=
 =?utf-8?B?ekExSG5SSGNLUUVzaUUvWkJXRzBRWjBSSTdmRjBRN2RvRTh6MzVEbVN4aVJi?=
 =?utf-8?B?bkt2TVVGR0dFSkRqUGJVUG1PbEpnSXAvYW9RcHRFWTE5QVJRMzdpRThmb3ky?=
 =?utf-8?B?YlBYVVJOaFk0dnhsVm8rcVdkQzZmMzhaYko5ZlRNMTE3eUNWcmFnL2lQMXVo?=
 =?utf-8?B?YnF1ZWRjb0xDS1hnTDV5dmsvRFN4VVRCNmdEVHRvZU1HUk9WZk9xdStIL0w4?=
 =?utf-8?B?RFFXeklpNlhkS2VoRldCTlVrdTFRL1E4NXljZG1ycjYwWTMvZ282YVk3THJw?=
 =?utf-8?B?RDFIWlJLUWNDUmpPQ0NtWktJazE3UVM5MWVnU09XRnJSQVZiY0xrUkR6WDFM?=
 =?utf-8?B?Z0g5WFJyZ2RmL2I1SnRPNzQ2WXAvNm1RZDV0OThVQlpZQzVmaUJtRmNualM1?=
 =?utf-8?Q?b2XxT+AH4Py5twxYeF8RBtPxJMmUJ/N1B9g9g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 06:36:02.9635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b90718-edba-4bf7-ca09-08dc64f1fa64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348
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

The function gfx_v9_4_3_init_microcode in gfx_v9_4_3.c was generating
about potential truncation of output when using the snprintf function.
The issue was due to the size of the buffer 'ucode_prefix' being too
small to accommodate the maximum possible length of the string being
written into it.

The string being written is "amdgpu/%s_mec.bin" or "amdgpu/%s_rlc.bin",
where %s is replaced by the value of 'chip_name'. The length of this
string without the %s is 16 characters. The warning message indicated
that 'chip_name' could be up to 29 characters long, resulting in a total
of 45 characters, which exceeds the buffer size of 30 characters.

To resolve this issue, the size of the 'ucode_prefix' buffer has been
reduced from 30 to 15. This ensures that the maximum possible length of
the string being written into the buffer will not exceed its size, thus
preventing potential buffer overflow and truncation issues.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c: In function ‘gfx_v9_4_3_early_init’:
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:379:52: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
  379 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
      |                                                    ^~
......
  439 |         r = gfx_v9_4_3_init_rlc_microcode(adev, ucode_prefix);
      |                                                 ~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:379:9: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 30
  379 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:413:52: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
  413 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
      |                                                    ^~
......
  443 |         r = gfx_v9_4_3_init_cp_compute_microcode(adev, ucode_prefix);
      |                                                        ~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:413:9: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 30
  413 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 86301129698b ("drm/amdgpu: split gc v9_4_3 functionality from gc v9_0")
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2:
 - reduced the size in ucode_prefix to 15 instead of changing size in
   fw_name (Lijo)

 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 0e429b7ed036..7b16e8cca86a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -431,7 +431,7 @@ static int gfx_v9_4_3_init_cp_compute_microcode(struct amdgpu_device *adev,
 
 static int gfx_v9_4_3_init_microcode(struct amdgpu_device *adev)
 {
-	char ucode_prefix[30];
+	char ucode_prefix[15];
 	int r;
 
 	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
-- 
2.34.1

