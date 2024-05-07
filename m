Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B558EC25B5F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 May 2024 16:45:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 372FF11209C;
	Tue,  7 May 2024 16:45:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GmfJWhF+";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6A8511209C
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 May 2024 16:45:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3/G6UzzKKWM61tWd/E2fIMLCkbZMMZBPKxLvkLR6w+UBgETabtyzBodMelJfo3tpRhdhToE03r4jVUc7u2qqR9f+eUzXgrh3QHGNmaFQZca2kZC8mYA4JLo5AekkDtYu2VO3rclXoJqq8XhBdktLeno+fp5LIisKokCMYX7/VdCTYXB49bpDVNSlny+sWoX9ko4iIvqJHFd3naVEjnfzpltN+acQJUvjtiruJ5bgIwTd5gh+gIMMRNLJhKKMmeEucgYEY2I0Xa65EH/o1zWyR8benlZE14y6JVu2gRpYBnbBGlKLx//yfU+BBvmEL4Uo5M9qZd8G8clRUl6XVsBhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cir59y/r8QgqH0y5BFgqgxwaalJguoDOeVx2nx3EL/c=;
 b=TbRYxMUKOlIIf5TkYemHs0B5LTXun9tY49VJTHcOuOCMAxZWCurqqlRCawYBmzqBU0bV6SHAtSQRzFvHUmBjsB2AaqNRXT4xhBbH74BfqcZhl1tq5mYCrwxfiuhMkKGCEdE3pzQ8KvncUsUmHpy85DpMK6oWwy6onSBlf3DQn+G57j5E2r+Z6WZma9y4OC3k4eEsvK2GMiqHmB0Bw5duFA1JAVp0/2feb9bNwxhRYzDWtVobcrTJlaD0rLzYLC/L9BmsTWMIv6ik00um4zKsLSpbv9VbDP74SdwnCQWMuzhIEarlhGI4aC0c7dQDY3o5E8LomcaLjIq+Kj0gayXpfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cir59y/r8QgqH0y5BFgqgxwaalJguoDOeVx2nx3EL/c=;
 b=GmfJWhF+Ut4GVR88Gh4J2JOKwaAQ/bd8vxE1N+dCgtDe+a4nf1KmafbraLci+KzEZzcXAnq/gHKR+ZJvM7UZ/0aKU/p59S6i5gFf/lEjOzVgDhbT60PNPmZ3XjatmEr2VAwE5pQeosCPtyyNASAmy9QzV1i2aVeTITzbrqApwaY=
Received: from CH0PR08CA0018.namprd08.prod.outlook.com (2603:10b6:610:33::23)
 by SA1PR12MB6773.namprd12.prod.outlook.com (2603:10b6:806:258::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 16:45:06 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:33:cafe::b4) by CH0PR08CA0018.outlook.office365.com
 (2603:10b6:610:33::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
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
 15.20.7587.0 via Frontend Transport; Tue, 7 May 2024 16:45:05 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 11:45:01 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Lijo Lazar <lijo.lazar@amd.com>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Fix truncation by resizing ucode_prefix in
 imu_v12_0_init_microcode
Date: Tue, 7 May 2024 22:14:46 +0530
Message-ID: <20240507164446.318263-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507164446.318263-1-srinivasan.shanmugam@amd.com>
References: <20240507164446.318263-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|SA1PR12MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: 3537c550-144f-41b8-0a2b-08dc6eb50c98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVZUbUFOajl0RExyN2IvYnVBU2lIOXZ3dnE3aGRMbXpRSE1wSUx0UldKMTVQ?=
 =?utf-8?B?R2pNS0ZrbE9BSWZKNnc5b1E5Q3hLUDlFYlRYM2o4NlpBdWtIcTQxZS9QTWc2?=
 =?utf-8?B?M2pWbkF2dDJ3bkZ1MWtOdjZlL1Ixd2RrZ1p5ZFpaOE5vYmVseE9XL2Q3TVoz?=
 =?utf-8?B?cEMyamFsYjRJaWpma1ZRM29WMHNUbzZPQW5MeG1zWEgzOExCbzdSazA0Y3Rk?=
 =?utf-8?B?Q3IzZXd4am5ZV2d3dDFRYTBNWWVzZWRObyt5czVrd2o2enJabnNwb1FGcEtU?=
 =?utf-8?B?b0t1aThNMmtTOWFydmVnNjM4SkpYMWducUhUa0JJSlY2TFZoWWY2bllUUFRn?=
 =?utf-8?B?U1hYWU1LSzhiSzQvSU1sakRab1I4SXczcElGZ1lxS2QxNXFYNnFDTk44OUcw?=
 =?utf-8?B?aDkvQ2dZTEZxWGdLeExOMmRlMVlKdHY3QytpTysyTklHVE9UbkZtRTRGdmhT?=
 =?utf-8?B?d01KbG5nVWkrREMxYVZwbVgxM2l1NHlJYmNiQ20rVE9tanl2M2JqSmMrNklQ?=
 =?utf-8?B?dUpYMmZwWkJLM0FGQkI3R3JkeHdMUFJXUjNiT0pPUkEvTFV1VHhQZ3ZHSEp1?=
 =?utf-8?B?ckhlaEtlcXQrOGxOeGkrdit3N05MOTVqZUhKYmVMQ1VtTlVIV2lJQUFXZjV3?=
 =?utf-8?B?M29KQUlmOVNFblhlWWVJR0dQR3RwYnVyTGFlaCtlNTBldXNyZVBzVWd1NHho?=
 =?utf-8?B?SHp0OEkrYUwyalNhZHJUU1hsbXhXUlhORTFsaHlNZWoxTUk1RjduN0tiQVRR?=
 =?utf-8?B?SDdQQWpCZDFCV3piVkhRMmkyM2FXYVdqUm5VM2FxdFJWeHZPTnVNd2RHTHZT?=
 =?utf-8?B?WW5MV3ZaOWtOK2hNRFVOTTBFUXNpbEw1OWI5eGNROHQ2d0c4R0l1WmFFbVRT?=
 =?utf-8?B?WUkyUVpyRVVlTGpuTE1PWEdGeGVqWEFISkltY2xSUnJnb1gzZzU4OFNMaXdM?=
 =?utf-8?B?ZFhqNlRkTDR6Uis3a2FIRXRGMkw3aUpVOU81eUFUN3BFK1R4QzFMbWI4Sita?=
 =?utf-8?B?eWR3TDV5aGZnRjdVZTkwQVpKOGlVYXd3SE8vQ0NwR2NKRE9tVm8xS2ZPdEtC?=
 =?utf-8?B?TlZDRTFjVmVSdVViVVByd01uNWJINnNiU2VwV3U4NjdFakl2RXQ5bG9ZK0ov?=
 =?utf-8?B?K0FiS3Q2WXNBSndKOFBDcUtnQS9mOEVzWlJEdXJNOHdmTmFNbE5KQy9Jamtz?=
 =?utf-8?B?N0t6N25JV3lZVXlVYVVrZU9yQ3RpWS85TTJHU1VnWUNNWEJvdjhCaTFObXFt?=
 =?utf-8?B?Wk43bk1ONkhHb25RSFhQOG1iSElHUnNoVVhPY3lOYi91ZGwzaUZuVitLWklR?=
 =?utf-8?B?aWhqMHlsNGRTSW5KN3FwanBIZTV2dlRpR052dElmRElhN0czOEtIdGtCNG1s?=
 =?utf-8?B?bnE5ZTdON3Vvejl5Wlk2ekxBSGNvTjJJWUFwQkl6SWNhZEFieEpNVUxOc2V4?=
 =?utf-8?B?M0V4eGJBcHNzOXZmcGhUbmd4S3QwU3N2ZUVzVjlzUktsRVhhTzE0OHpkU25R?=
 =?utf-8?B?WE13SjBoTm1LUk40QTBnZzY4dGIzQkc1ekdxcUVUV3MxRnNHRDNWVldTRk4y?=
 =?utf-8?B?V0t5dHFZV2MxbnhaKzRObXVvdWFBUUhEcHpBVGN0SllyUzYvN3NoKzEyYlMy?=
 =?utf-8?B?aWswUWwwa0xWVjk2bklTb29XV0diTnJYeGQ0ZFBoMTBtMTg5eGw2WER3UFQ0?=
 =?utf-8?B?L3dsS3JnSkJVSDVWWE13blYreTQxZnkzZC9oWEhRYTJjM0ZtOEJ1RXI4cFdo?=
 =?utf-8?B?VFZYMk5HK2JHSTBVQXlvd1RRM0ZyMGxkdE9KaWpqTUxFU1hmS2tyYnFubHZx?=
 =?utf-8?B?ZWJ2WHB5TEpjeTExU0FqMTdSU0hNZkhvWFE2OXAvSjN2U25vMnhNMmtPQWNT?=
 =?utf-8?Q?8Ol97cGi4O7xe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 16:45:05.8569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3537c550-144f-41b8-0a2b-08dc6eb50c98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6773
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

This commit fixes potential truncation when writing the string _imu.bin
into the fw_name buffer in the imu_v12_0_init_microcode function in the
imu_v12_0.c file

The ucode_prefix size was reduced from 30 to 15 to ensure the snprintf
function does not exceed the size of the fw_name buffer.

Thus fixing the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/imu_v12_0.c: In function ‘imu_v12_0_init_microcode’:
drivers/gpu/drm/amd/amdgpu/imu_v12_0.c:51:54: warning: ‘_imu.bin’ directive output may be truncated writing 8 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
   51 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_imu.bin", ucode_prefix);
      |                                                      ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/imu_v12_0.c:51:9: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 40
   51 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_imu.bin", ucode_prefix);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/imu_v12_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
index ec2a4613567a..032ae12b2be2 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
@@ -39,7 +39,7 @@ MODULE_FIRMWARE("amdgpu/gc_12_0_1_imu.bin");
 static int imu_v12_0_init_microcode(struct amdgpu_device *adev)
 {
 	char fw_name[40];
-	char ucode_prefix[30];
+	char ucode_prefix[15];
 	int err;
 	const struct imu_firmware_header_v1_0 *imu_hdr;
 	struct amdgpu_firmware_info *info = NULL;
-- 
2.34.1

