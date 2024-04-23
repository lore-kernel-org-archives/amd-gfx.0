Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F304EC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 01:45:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A2C5112F43;
	Tue, 23 Apr 2024 01:45:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iVFj9uqM";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B1A3112F42
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 01:45:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HM1H3857lBhakJO32mS/OH39nv3g7OcO/JKuauwjxfDzrFFqTKiyzzKj3F7USC+2ytawMeuo5D012MtyfEyaBkPdQ02RmLaqL/DaH3KOKrab5BsUoGQeNdIx3gOef4XPVpHcBmDNbVUcd6ySX7jq2s0LhFnvIW2dkYzptFfqxzj//Yq1nUWxw5coEtaKYCjBEDGZMqGRS2o0RLKzRNSVNhh8qQZCzzEJvZu5eSxT6+BRF1puI3o8EmR+veKmKmgxti1LipLR3znDtrx7kj7+44wlUuMHRRFJb35D6Sgbc722aQ4IzdipnKQWO3qo4Qgbkz2RbAg1zQxfnRYb8cbmoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMm5jrs02sjyxvH95Sp12gGYCSaZ0X4MhS9tVrAVmTw=;
 b=I+CPEsQv8hOOcsGj81zIoJddLrrnZM6IoOS+3s/5TygLs13ZBOXBAsovBNxaQ6frqYwTZdjcG5y48U8wnT80p2NWNkhNq/NEzhYj8FrH/6TTUVx5A/4a14mMCd2pdZOXNKfYRVqoPgkOCaTMBGdGLy6YQ8L37ZIOH0mvCtedd7zzM6WN8DsiEi6CQTFZdK2gmKXQzW7R/Q12FfAr4pJCPMeoJYKVPnI3rhMziPepq5Y/d1c7XI9MpyullHJKA3Cs38WvktL4UmK5I1q0dFe3DCteIx0vqV2WpZGxMrRkkTfU0eI0ASCMRABt0Vd/iCJEkTN3r5zuWLeznHek/0nPRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMm5jrs02sjyxvH95Sp12gGYCSaZ0X4MhS9tVrAVmTw=;
 b=iVFj9uqMrX9xPmMc3LOwf2bC8viDM1DE/ht9klCvgy/CpcS4AS/553Jxcy0OU/Rb8zI5BHkR+DXvTRZ6ngC9ExLusZXVUIwwTIHBUZGeMx9UuxuNiNTYtlA4yW5taz+79dI7PU8v3S2ZHLpze2XNi/afjwdFz/KXrB9E1UE7Ovs=
Received: from BN9PR03CA0325.namprd03.prod.outlook.com (2603:10b6:408:112::30)
 by DS7PR12MB8275.namprd12.prod.outlook.com (2603:10b6:8:ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 01:45:51 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:112:cafe::df) by BN9PR03CA0325.outlook.office365.com
 (2603:10b6:408:112::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.31 via Frontend
 Transport; Tue, 23 Apr 2024 01:45:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Tue, 23 Apr 2024 01:45:51 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 20:45:44 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, "Lijo
 Lazar" <lijo.lazar@amd.com>
Subject: [PATCH] drm/amdgpu: Fix buffer size in gfx_v9_4_3_init_
 cp_compute_microcode() and rlc_microcode()
Date: Tue, 23 Apr 2024 07:15:23 +0530
Message-ID: <20240423014523.1598424-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|DS7PR12MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4b4e47-f1ec-4c7e-c2cc-08dc63371b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjVjTEZwem9pQUY4Z2RSNXg3WnErUWlHZGFpMEVXYVI2SXFmSWhhWGhoT204?=
 =?utf-8?B?NU13a0NrV3JVVXlGdHRBRzdZb2VGMmJ4WEZDTWdLQVlueVJrOHMvQjgzUWxH?=
 =?utf-8?B?YWtiZXNmVkVzSnJWTVVhTnAra1R4dUlnL20wdDR6eEpSRm0yelV5d3ZxajJU?=
 =?utf-8?B?bUt4TVliS3F4ZnNXRCtvcjllSUlzOGZVaEorL1ljdU8yc3UvOTRLaXRrMEpX?=
 =?utf-8?B?cUV6NU12cnVrb3FNTkwzcWdMNzlSbXExWFRVd2VScUtWZ3NYY3lJN3VXSUtn?=
 =?utf-8?B?N0p5YVVIaW93bjZGbGdvZmRKZXR0Q0lKTkhqUk8yS0VmaXBKRzhMQ01yU0dt?=
 =?utf-8?B?Ylp5NSt4VFREcUsydGZBMXBPZSs5eDZvR0ZoZDNMblNIR1Z1ZDdWd1dteVdp?=
 =?utf-8?B?aHdxZmtDSE9SOUYzejI4MjFYUjlSTVZwbit0OFk5WnVMdVpBa0Jsb01Uc29E?=
 =?utf-8?B?LzFVNXQvZ0xCc0pweU1vT0JXQThZcjB2VkYvUHdFdVU0RE90QXQrWU5UMk15?=
 =?utf-8?B?NHFPQ1FkUlVxaFpYNDgrZmExMi81Q3RKMC9jd2xjYThaKzdteUR0dlR4NEw3?=
 =?utf-8?B?Sk5IZW1OeVZtWTBkbW1ma3o2N1Q2UDROQWZPbHpwSXpoc2hGZnJKTUR0cURj?=
 =?utf-8?B?L2NTYTRSNXEwdzlhQ0hpOFFaT054aHVhczNrSjY2cUlnNGFSZkkwbW93Ymwv?=
 =?utf-8?B?dHdFOHNWbG5FZUwyR2EvUS9TaGNqUFV1a0JTRWRFQ21od3VqU1lQUkM0bm10?=
 =?utf-8?B?WFhRSkRmMzdueFVxRmxlb3lGcVEzd0h6aVZObkdUcjVSQkNXYWJheTN4M3I0?=
 =?utf-8?B?VEVXcWpZanQ4T2Y0OG1TZlBDL21DTDM5ODZSOGdTMlhLSjRmUmYyanBNUEJO?=
 =?utf-8?B?RHNxZVl4M2NkZGYzQmRSWnEwREk5eDNhelJqMUlQWTNObGtJcFJjOXdBa3RI?=
 =?utf-8?B?UDlMM05yTDBycDJQcnZGU0hsWG5ybXovc09waHR5MHFYcC9NQ0p0aW9DTnh4?=
 =?utf-8?B?dWFxcHRQa3lqQmpJakN1MDhRYWw2UjYrVE1RM1ZPRG5hVTBQRWUrNWl4VHZ4?=
 =?utf-8?B?aTByQlRKWDdadURKQUFETmNKc0tNWjJTYU1zWHo0Z0pnN2NIbStVcVlvcTMx?=
 =?utf-8?B?VWdzMnV2UFZoZjdSREt5MHF1blZhUnpXdjRHVU5HbzNOc1FCUk42NjZrcUZH?=
 =?utf-8?B?R0EydVdBVWxKVjlsOUUrN0V4RWhqYlA4eng4anVSYURVclY1ZHl1WXZXY0xt?=
 =?utf-8?B?ZmlwOHp4ODREVlcwYjUxN3RvdG9LemtEVFAzQXBTUThYc2s0ci9zS1RSckda?=
 =?utf-8?B?MjB6QW1hbFA5S2hZLythSkNqV09Oakt4RTBqMm5uK0Y3L1ZhMHpxTzZMQmds?=
 =?utf-8?B?aElIMnlZd0ROTTYyNTVjU24wbVBFaWV0QnB6VzlURHpvSVh0UUNNeDZKa3Fv?=
 =?utf-8?B?bGQreFNudUpJK1F1VzQ2YVNENkJEMDRUdWxwUFc3ZmxsMDBlU2VHNyt3MXRP?=
 =?utf-8?B?NklqbU5Va290U1A0M2VmYjgrSVI2UmJiNnhHS1lVSHBoWEVRTDNCMFlmbWd5?=
 =?utf-8?B?SnBCeG1VQXpTZFQrQWtVV3B0TlU3aDdDZXVlSGZQZ0QycVhwSngxUCs2TnFM?=
 =?utf-8?B?Tjl0cFdmd3dlZmZ2VUVNb0plQ1h6RmdOUElSTGppaDhxeVJ2Rmt1WEQ2RERw?=
 =?utf-8?B?Y1lxNU9ibUZGdXRSY3BVUGU2UGZQZ29xUzYzTVdlUjRDeUlVYitNVVBBMFFG?=
 =?utf-8?B?SDBHdjNMaWY3ZUhFWGVkYW9rUFE2aU9KenQyUFNLTFpXUDc4Z2lLV1NkNlo5?=
 =?utf-8?B?SG8rWkRSZ1EzcjBIQjgrTGJrMHlxZzRLb2IyWERPU05lS1A4WkFtUENKMXdi?=
 =?utf-8?Q?3PfWs1Fcx4ykm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 01:45:51.3172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4b4e47-f1ec-4c7e-c2cc-08dc63371b63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8275
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

The buffer size is determined by the declaration char fw_name[30]; This
means fw_name can hold up to 30 characters, including the null character
that marks the end of the string.

The string to be written is "amdgpu/%s_mec.bin" or "amdgpu/%s_rlc.bin",
where %s will be replaced by the value of chip_name.

The length of the string "amdgpu/%s_mec.bin" or "amdgpu/%s_rlc.bin"
without the %s is 16 characters.

The warning message is saying that the chip_name could be up to 29
characters long. If we add the 16 characters from the string
"amdgpu/%s_mec.bin" or "amdgpu/%s_rlc.bin", we get a total of 45
characters.

This is potentially longer than the buffer size of 30 characters.

if chip_name is longer than 14 characters (30 buffer size - 16
characters from the string), the resulting string will not fit into the
fw_name buffer, Thus increasing fw_name buffer size to 50

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
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 0e429b7ed036..1c46d5f6677f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -370,7 +370,7 @@ static void gfx_v9_4_3_free_microcode(struct amdgpu_device *adev)
 static int gfx_v9_4_3_init_rlc_microcode(struct amdgpu_device *adev,
 					  const char *chip_name)
 {
-	char fw_name[30];
+	char fw_name[50];
 	int err;
 	const struct rlc_firmware_header_v2_0 *rlc_hdr;
 	uint16_t version_major;
@@ -407,7 +407,7 @@ static void gfx_v9_4_3_check_if_need_gfxoff(struct amdgpu_device *adev)
 static int gfx_v9_4_3_init_cp_compute_microcode(struct amdgpu_device *adev,
 					  const char *chip_name)
 {
-	char fw_name[30];
+	char fw_name[50];
 	int err;
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
-- 
2.34.1

