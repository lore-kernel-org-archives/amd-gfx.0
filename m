Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921ABC10F1A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 May 2024 16:45:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EE5311251B;
	Tue,  7 May 2024 16:45:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z59zd1mO";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 038DA11251E
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 May 2024 16:45:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbPToEFTFzXsDCqKnWBtCg0v9+cZq3Ujf7o34HthDJaoLCvh4SVDXlFksutK/f2/z4OJG/ICjzFr/ebvZap4mI67lWrKYUzl45nxEY6fTTAH36mEFmrHA2oYQQQInahk7FRRydDJk4e0obz0FHFfV/PCOAS7VA2vWZaog5S331O9qWF563TUvfP3TeDuHul9AFnMzTXXxo2qqafAplh6LVThtUhQOWUffwX2kiKRoz39e1rPeqDxFiBhpqzActc61LtEjtYYyWni4llny5lL06c88RB7ChkJRlL/f3lfzJc3+O6Lzdza4c4rTUbubZ1hg1L9soJBK1ZZhP10nK0vmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRUVTWGb8r1cFMTB+Q3NAO9GVkMfOyHbG9HZxHthie8=;
 b=UIycfuAP9QD3bCiAqnRWDI/RviBi0xQCF+VKCcAMB17ZIH2J2bJRl/81MO5CcWVhOQyn/i+KOT/93atmO1eCJ+Qdnv5Pb1SkDPs5DxOkLGgnqW/HShaVNCKMHy/eBp9oo7xCkx99dAT2SHKa7TDaGlTTB//dKxSNkwO9paYvQ9pCsvyMvCsawhnQnoBEaq5aS2zCw/fKI6IVeh9u74Ri5RbImYdvd+wzxuH5q09as4Q1RT1QePAykhQMi/94EWJbe2eo7n5kV0d6Fr1LCcWdbQHu1I0e7kqEZPtKnBVbtpSw5/L1Xbjdpr0cNBTmB0UZhiDoH7a164GAHHB4ixXcQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRUVTWGb8r1cFMTB+Q3NAO9GVkMfOyHbG9HZxHthie8=;
 b=z59zd1mO5BNuGQvCwmxOj5DH5M2Gc/Dz95rXZocwSbtKDX3iWZKq7AkpkppGbfFQxZmgEGzv653FWNr+wBt2PEi+KErpebeRRtweNCO9An3sFuMWuaYOUG9tu4212gYAUe+zIA6ZSRmhnqVJM+H2HjWyVyRHIdYzwM0dssUrAPI=
Received: from CH0PR08CA0012.namprd08.prod.outlook.com (2603:10b6:610:33::17)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 16:45:05 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:33:cafe::3d) by CH0PR08CA0012.outlook.office365.com
 (2603:10b6:610:33::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Tue, 7 May 2024 16:45:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.0 via Frontend Transport; Tue, 7 May 2024 16:45:04 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 11:44:59 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Lijo Lazar <lijo.lazar@amd.com>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Fix buffer size to prevent truncation in
 gfx_v12_0_init_microcode
Date: Tue, 7 May 2024 22:14:45 +0530
Message-ID: <20240507164446.318263-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f5e2dc-5ef9-42e2-7355-08dc6eb50bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVoydytJc0dlaFpWM2F3SjBuMjh3c1JyeUpyMnFKUi9aTHNYY1Ara1lCcHl6?=
 =?utf-8?B?UzRRSUhLd0M1T0F0QUxBSTI4M29jNEI2RjB4M0V6aVpqaGNzd3ZpZXJLOU1z?=
 =?utf-8?B?RERTbjNpQmNEWmw0QmMremRibmNaY1VOSFFKeG0wVWNudURFbnE4ZXE1NGZN?=
 =?utf-8?B?Z3lxRCttK0tMTzVPQUhzdU4zL0xzUU1ONVJsQ0V6VTcxVVdJbVBpU2dteFBr?=
 =?utf-8?B?cXdwWXprc0N3dC9PWmlYQkMxYkZQWUJHOWtPL0pPbTFOYWM3ZUJTK2wwUFUw?=
 =?utf-8?B?c1NKNDZWOFN2U3JZMTlzcHdIbnV6OWxCWngxNEVveWgySVFpUXBNak45U3VG?=
 =?utf-8?B?Uzd3Y0RRVWhEcTErNzE3aGxmZGxHNElFR3RaVFlraXBVUjc4MDJORnFtK1h3?=
 =?utf-8?B?U0lHZFFVaEJ4ejlzMm5uZXdielBEWk8ybTh3SUx0dWFPMm9CZUxkSDY5bkph?=
 =?utf-8?B?SjNlaGt6Snhhb1N0WGhZTkN4T2NUWkdieXFtQlRaU09TUzQrNXZVREw4Y3pO?=
 =?utf-8?B?NWRYMmMweDU3YUdxZG1NbGRCMGlPd2R5R1dBYUlFdGM0SGpJVlpNN2d3YkJl?=
 =?utf-8?B?am1Zd3pOU2JSNkYxaHRJS2FOK1dkZm1aUENNWUJIZ2RqSFAvNFVJaUFOQTg3?=
 =?utf-8?B?Z0s1NmhOK3ozRFI5NUJJSEV0akcraUhjZnpReWsxTnBDTE9kby9oVlB1bEo4?=
 =?utf-8?B?VzJxcHdMUDJlYmk5R3NhRG1ZWVpwRzhHOUhJMFZyUGVhUnNwSWVuZ241OWx5?=
 =?utf-8?B?VTZSVHJ2MXpzSDU3bXBQR0lvSUpVZGxtOWN6amtJcFJmS2x5M2xEWXJwSytj?=
 =?utf-8?B?dVBsRFNmV1E3S0wxQ2RQL2FvdEZmRzVESWFvd3BSTW1SMmg1RFhBL1U2T0h4?=
 =?utf-8?B?RkRrcndnOEhoRWV1S3hHeTM0Q2lWNVBHdXZrKzV2ZTFyR04rUzlROTgrUXBw?=
 =?utf-8?B?OHBvblhsdlhPZkY2VmUwM0NWSTBMaXM5ak4waTY0S0ZGeERPSXh0UmVTRzJi?=
 =?utf-8?B?NmZRTmIvcjlUNlI4aWJjcHhQK1UxZU9ueVJnY0lOckVkZ1lveG9CQTJPb01Y?=
 =?utf-8?B?S0V2VGdLQUxQYUZXaU5sRkc0S3Nzem9tcy9LazJzWnpTQ0dmZ3ZYT3VUdVRz?=
 =?utf-8?B?SjF2emk1UUVFOVl3MG82VXlabi9rZTIvcUdEajhLUjNBMnpJaUl4eGhJMEFu?=
 =?utf-8?B?QmdYMUh0ZEdtZFM4aUh5c1RlMDFJczNuVUpiRVM3cTh5OUw4WTBvYU83RUxl?=
 =?utf-8?B?OWpkekMyaUZVdXF4cTVoMFZZRHlxZnBBZlNhZzRCVmZhMVMvbGJhZTlZenJ5?=
 =?utf-8?B?aDg1aDlyNE1uZTIxQmtXYWU4SWliZm1HWjN3emZHUlV3Vno0VHNaRjhsTHVK?=
 =?utf-8?B?Ly8xQkl4ZkVhSTVpM1drdzNQMHlMRUNjMnRpazIwWFhWWUFaeGliQW1seVAx?=
 =?utf-8?B?MVFqaGhaY0M3bTg5bmZOTVkvZEhqM0dvL2Y1RU9tUGwxWXk4TERlSkNXNHRt?=
 =?utf-8?B?anloZG82a3dPTWJWZkR4b0Z4a2Rra1QrQW1EUUhFUWF2SzFzNEtrcUxEWndm?=
 =?utf-8?B?R1FEdmZZdTZlT0pVQWFibUV2TzFJc3l6TitNcys3RnRLVWNTNFBueWlYSXpw?=
 =?utf-8?B?VTFiM1RIeGQvQW1RMlhyRXhMZHFFUVZ4YmxKZTVrT2poSjdoTHQ1OHBQWDlP?=
 =?utf-8?B?UTZOa1pVZ29vaU0yWURDdG9nWlR4UE1JYk0rQnFBSWRjaUJaK1BmTDVhMEJI?=
 =?utf-8?B?dHQ3NU91Y01CREhCaVdQQ2NXdTdDWTNJTEdHNDMrQ2gyZ3lRcFVpdDBzeEVU?=
 =?utf-8?Q?hpEIZmMye+NPM+HvIZuGqWQkqJR/t8xwbwOXw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 16:45:04.8569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f5e2dc-5ef9-42e2-7355-08dc6eb50bff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106
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

This commit addresses multiple warnings in the gfx_v12_0_init_microcode
function in the gfx_v12_0.c file. The warnings were related to potential
truncation when writing the strings _pfp.bin, _me.bin, _rlc.bin, and
_mec.bin into the fw_name buffer.

This commit fixes multiple potential truncations when writing the
strings _pfp.bin, _me.bin, _rlc.bin, and _mec.bin into the fw_name
buffer in the gfx_v12_0_init_microcode function in the gfx_v12_0.c file

The ucode_prefix size was reduced from 30 to 15 to ensure the snprintf
function does not exceed the size of the fw_name buffer.

Thus fixing the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c: In function ‘gfx_v12_0_early_init’:
drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c:421:54: warning: ‘_pfp.bin’ directive output may be truncated writing 8 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
  421 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", ucode_prefix);
      |                                                      ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c:421:9: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 40
  421 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", ucode_prefix);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c:428:54: warning: ‘_me.bin’ directive output may be truncated writing 7 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
  428 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", ucode_prefix);
      |                                                      ^~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c:428:9: note: ‘snprintf’ output between 15 and 44 bytes into a destination of size 40
  428 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", ucode_prefix);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c:436:62: warning: ‘_rlc.bin’ directive output may be truncated writing 8 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
  436 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", ucode_prefix);
      |                                                              ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c:436:17: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 40
  436 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", ucode_prefix);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c:448:54: warning: ‘_mec.bin’ directive output may be truncated writing 8 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
  448 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", ucode_prefix);
      |                                                      ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c:448:9: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 40
  448 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", ucode_prefix);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index b53ca25012e6..b6e5a2230622 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -408,7 +408,7 @@ static int gfx_v12_0_init_toc_microcode(struct amdgpu_device *adev, const char *
 static int gfx_v12_0_init_microcode(struct amdgpu_device *adev)
 {
 	char fw_name[40];
-	char ucode_prefix[30];
+	char ucode_prefix[15];
 	int err;
 	const struct rlc_firmware_header_v2_0 *rlc_hdr;
 	uint16_t version_major;
-- 
2.34.1

