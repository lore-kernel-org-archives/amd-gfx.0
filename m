Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1330C27C44
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 06:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E933310E092;
	Fri, 31 May 2024 06:53:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G9SR11B5";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35DDA11268E
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 06:53:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mW/9o1XJooJ+Xfg7F8sEkUdULIXeR5utmDafkvTf7XUzIYri3pmzOx4W2VfUIZ5EOlQHDSP7NEI5UItcS86a4+KKQ4cwTSiKWks/tT7u3JkZAQw2KNNA+qXIiG4bK3dU8L9Y3FcxlomKR+qhPWzIq/ICNiAYhZ9DB0/M4/90DRqcJEQa9iSvtFs0XRVseqbi1/xTW9TIX9Dqu0HRncyalozlp+IoIOQvJpjljlJVywM82QrXXH8SlK/mIuCPHnbkywI7XqiAKqV+pdiT3nptLLSmLY0MTqkH5Am5BzHCeFbpkptTjUjlWiOSindgEnwPdynHEcpHkod3i26otNjo5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KY92CfpX9ld68msDKRU/+87487q5tG/TzroMJvlbk+o=;
 b=lqLs0IyuPlN19yWBOFBgfFbxG7NoXm9N3P6+xqONKenGyPIWqLDD5nubdvLUabC3MKnTVm6eZYfn0/50X+f5pU3Cx+GCkc9vHUbBG5ujvPJCsB5z3vLeNqXtnYJtNtS+oHb9P0hoeTpHFFmqUSJ6pbzDgQ1ZDDw9acr0OgnkyK268vl6ri/BiVWFXV5U/5zLDVaq4BeL7A0GZPj5BGQBvLTFFo3H0YEoGaIPEs7lOdFHhvdUa+VSj9XACF0XKwvnxKPdPDWu1e9Y7j7lFm5A3+CxNuC5AmAL1EodK1F5XwKwGYllFnFv811Cp4BZW5COs5cSwoyi1ys34fLmW2ipmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KY92CfpX9ld68msDKRU/+87487q5tG/TzroMJvlbk+o=;
 b=G9SR11B50+oqOfIb6AzyhsmZNXT+w6i8VaPcvvAPUptO1i8+ABCeoML/16J0F4TYN9FBpNYqggiqqGXBvlZ4Y2VMWM991jLj3X9NiK9Dj3Sm1TGt3p6IEG5KOUka8f+4rlD2mI4Zy9zPw2PbLeqGIS+eBLlwX5yERd6S39Z5P9Y=
Received: from BY5PR17CA0005.namprd17.prod.outlook.com (2603:10b6:a03:1b8::18)
 by SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Fri, 31 May
 2024 06:53:11 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::a5) by BY5PR17CA0005.outlook.office365.com
 (2603:10b6:a03:1b8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21 via Frontend
 Transport; Fri, 31 May 2024 06:53:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 06:53:10 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 01:53:08 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 07/18] drm/amdgpu: refine imu firmware loading
Date: Fri, 31 May 2024 14:52:38 +0800
Message-ID: <20240531065249.1746350-7-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531065249.1746350-1-kevinyang.wang@amd.com>
References: <20240531065249.1746350-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|SA0PR12MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: 631ffbd1-0e02-4e7d-9a1d-08dc813e55e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5U/S65jRPiASnYM0lvCKBiFt9Ay2AzXw2/Gc6O+Jmn4cLIhWwqEz+cXN22Ea?=
 =?us-ascii?Q?0rm2BzApUbqUBNWVTqVHQPIPmdDXuVUHEic3vAcntNx35yxycOpZzXB+XMmH?=
 =?us-ascii?Q?aTGQw9srC+723UJZ2eYh14vviEYKWWrSG1giJiEmPhTJT3Ux3DfG+9xRRaNl?=
 =?us-ascii?Q?kOsnAi7P0bQznsbgp+PtxHUW5+013VPyKkOD8MHXNWKv+dF96Ie1eJWqrAmp?=
 =?us-ascii?Q?6QtOeKhMFtlhHc2RvyxiNPCHpeL1cjDeRFFQVd5rbAEPPVukKvA7LO9bvqlV?=
 =?us-ascii?Q?Jg8Smmjkj4KXrOguOm6QS25ujkmNW0kgyjJEQcVIzBR6WhWmeiITh+6I+PUW?=
 =?us-ascii?Q?C/2w8fzf9K649M56tAbRI9OP1DWpRLI2lFgB7AH45OxFaIt5CCRy5IWpUbPE?=
 =?us-ascii?Q?r2dbx0DogcaD81kLJZeH9Hls4kf80IOq/SiK4krz0mCl7ewR8kb8TDPN+SfE?=
 =?us-ascii?Q?shYM80LEJkqJDK1vTYF0yV0rfEwy7tRPFkWPtyYFuEfY6ZB/XxsYlwgqMDsx?=
 =?us-ascii?Q?4G3qeC4DA3pxVSHozFzIGkqmkV2rRAQb5LoXTgSARrGfFWoAc4Jg9KKOLv9N?=
 =?us-ascii?Q?ZQpUrI/ayPyaGcuwRCgSLQsvm0WaAg5DPei0ULiT4oMQXvvWHKmh4h9Zheel?=
 =?us-ascii?Q?V2tDvlG2Z3DRrR0PKORbTFywnUWrNgPkpAh0Emf9FG0kmpfKTpDQpB6DdFj1?=
 =?us-ascii?Q?EQ2egImp3pX8+tMeDGgI/wPwqYJJptHYRKJLfm8O6kPClsv9C9sLQhyZLO3o?=
 =?us-ascii?Q?+tB5Yug5NnnJp5s/z4jGIX5hv/rQ/uyT/PTHHA7yJy1FVX4Wg5/NXWauXlkR?=
 =?us-ascii?Q?SpgZUCcltkJSCI+JK3DoWGw1YVEjiYQKjKLZq4s5XtBBm5XunW0xPy8ySe7J?=
 =?us-ascii?Q?fQV4zfoEqP/XtSWgDpV+kL0ivL228bWWFv+Bd4DSMqX1nppMSCNpns91uczw?=
 =?us-ascii?Q?UaCwdsKY6BXgDMn3ame/pSxZgolEQUkvq/PR8lZmlDJbxLS0uw52DsD01wEU?=
 =?us-ascii?Q?IhZT1wIKv67ZF8TIbVYScZr6qyfR7htfjS6yeDSHgRoxXAGCOY+0R/n+xIgy?=
 =?us-ascii?Q?ctu9BXTTygFej5hm83tH1vccepDjf+bBaBUyTTZYXj3LdM7pEknkwEMMxdKH?=
 =?us-ascii?Q?B04ex1Lj+sNDeevJVHFVJJFZTXkkbRfeT7B/dMuE9B51owv0uXwUqauGPNU8?=
 =?us-ascii?Q?0UBNKNWPUJNDQBGNK8EJmM2D8D4f7sw5WZDxRJujOwSa95JchfezXUXFjZ/E?=
 =?us-ascii?Q?rNw436nh3aZP6/YVp8jBaXn/SIDhHEYmF4Z0HEz3Ttz3+OxJ4+2I8Ic/GZDl?=
 =?us-ascii?Q?/o8zWlDwjiXj0gO82MAV8VyVoAUW0dqF9NzMDQ8y2OWUQGOYngU0zVq0X9jn?=
 =?us-ascii?Q?f32gZ2BDKbhDgHSd5hkq6wLVHTPr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:53:10.7165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 631ffbd1-0e02-4e7d-9a1d-08dc813e55e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7091
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

refine imu firmware loading

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c | 10 ++++------
 drivers/gpu/drm/amd/amdgpu/imu_v12_0.c | 10 ++++------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index 3e91a8e42c21..a9f5d9e4610d 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -41,7 +41,6 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_1_imu.bin");
 
 static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
 {
-	char fw_name[45];
 	char ucode_prefix[30];
 	int err;
 	const struct imu_firmware_header_v1_0 *imu_hdr;
@@ -50,11 +49,10 @@ static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
 	DRM_DEBUG("\n");
 
 	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
-
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_imu.bin", ucode_prefix);
-	err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, "amdgpu/%s_imu.bin", ucode_prefix);
 	if (err)
 		goto out;
+
 	imu_hdr = (const struct imu_firmware_header_v1_0 *)adev->gfx.imu_fw->data;
 	//adev->gfx.imu_feature_version = le32_to_cpu(imu_hdr->ucode_feature_version);
 	
@@ -75,8 +73,8 @@ static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
 out:
 	if (err) {
 		dev_err(adev->dev,
-			"gfx11: Failed to load firmware \"%s\"\n",
-			fw_name);
+			"gfx11: Failed to load firmware \"%s_imu.bin\"\n",
+			ucode_prefix);
 		amdgpu_ucode_release(&adev->gfx.imu_fw);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
index 0c8ef908d112..41b88ec26a20 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
@@ -39,7 +39,6 @@ MODULE_FIRMWARE("amdgpu/gc_12_0_1_imu.bin");
 
 static int imu_v12_0_init_microcode(struct amdgpu_device *adev)
 {
-	char fw_name[40];
 	char ucode_prefix[15];
 	int err;
 	const struct imu_firmware_header_v1_0 *imu_hdr;
@@ -48,11 +47,10 @@ static int imu_v12_0_init_microcode(struct amdgpu_device *adev)
 	DRM_DEBUG("\n");
 
 	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
-
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_imu.bin", ucode_prefix);
-	err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, "amdgpu/%s_imu.bin", ucode_prefix);
 	if (err)
 		goto out;
+
 	imu_hdr = (const struct imu_firmware_header_v1_0 *)adev->gfx.imu_fw->data;
 	adev->gfx.imu_fw_version = le32_to_cpu(imu_hdr->header.ucode_version);
 
@@ -72,8 +70,8 @@ static int imu_v12_0_init_microcode(struct amdgpu_device *adev)
 out:
 	if (err) {
 		dev_err(adev->dev,
-			"gfx12: Failed to load firmware \"%s\"\n",
-			fw_name);
+			"gfx12: Failed to load firmware \"%s_imu.bin\"\n",
+			ucode_prefix);
 		amdgpu_ucode_release(&adev->gfx.imu_fw);
 	}
 
-- 
2.34.1

