Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DBBC27C44
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 01:42:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55A8810E214;
	Mon,  3 Jun 2024 01:42:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hFR9N02I";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2000310E1B9
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 01:42:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1ED+ewkUQ9Ag4bZDGWL2i7XxD6f5BIfLrlnXgxj6Of8cCvBuvPB5S5pVy3VjJtSGUyhSxk8ppGFTvgwwLN8+eYuQ+Co+3ABi6v4LxiL3z3NhTlAG4JVtKrZovgllRACxt81WRBqRsvob6TeSXHdNFaHXzhYgKq9r+MNf6J77+b60YYWoNaxfiEZpAYAC/LX8RzjftegbHHPWGtcrXzf91dsdsT41EjDKWLlbUl830ZGa8SmVCL8GUQ9Wwn2bZ0wYLz8yc4YR40HEb3y5swvk+ohEZq7bnypV6zeI8Ekk3ywSVZkE3amJkwdABf4HloxuE2ydtKjt6Fb/Ood/JAZmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KY92CfpX9ld68msDKRU/+87487q5tG/TzroMJvlbk+o=;
 b=UFcnEPsm7Y8JbGYF7n6AXb7NinfRZayXQ0zXdoDaSkUr7KUOtVonxjygr72U13Ij0jPhI7ssi2HmZvjoyN3st1hYFUaN95/MFey1xErAVKxI8o63ZOr1BQ7aKEPvYVstMYyZYL35mW0zpsiFYhlGK5jXt6YAklZ9nTqdO3TlXC4zyJYGbXvLdBqAwX5ssD0B0xmdJrRUd6YSDQtGBmwSQdcqdmVQkQ1eNcC2jmxSwVaoq+Yyg12meHytk3nbak4tmpT3aQP7aQrQtO+r8Rl9sjq7ZvkwXNtl3Mr2AONgAMr5l8MruMbgtEySkq/N9D2vGvTvQYQtmUfZ8A/sLN377g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KY92CfpX9ld68msDKRU/+87487q5tG/TzroMJvlbk+o=;
 b=hFR9N02IP2GSXYSXn5DyKA8yhLLW8CAYAn5o+MoDsBDYuWLFqfqIMU0m9HxC8+mlDF6C6bAiEXUX4rr+vqn8p/XLXitigUHdkT24iDWHdXuLdGNY55OKbVdySHpBcJKnlXKS0GeUjfV5NplyEafVtiwc68Tf7781gynHarQWTc4=
Received: from BYAPR02CA0071.namprd02.prod.outlook.com (2603:10b6:a03:54::48)
 by CY8PR12MB7635.namprd12.prod.outlook.com (2603:10b6:930:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.31; Mon, 3 Jun
 2024 01:42:51 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::4e) by BYAPR02CA0071.outlook.office365.com
 (2603:10b6:a03:54::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.29 via Frontend
 Transport; Mon, 3 Jun 2024 01:42:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 01:42:50 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 2 Jun
 2024 20:42:49 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 07/18] drm/amdgpu: refine imu firmware loading
Date: Mon, 3 Jun 2024 09:42:01 +0800
Message-ID: <20240603014212.1969546-8-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603014212.1969546-1-kevinyang.wang@amd.com>
References: <20240603014212.1969546-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|CY8PR12MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 08e3ab96-8f88-46bc-7156-08dc836e7ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z+y/KaWHlvknXg/PbZQytUvnUDHHeo710UKhuy0Fm7X+ACRn7O/zwUYepaCm?=
 =?us-ascii?Q?3PDoKD7xopenIxyVGZiqpQlKr6uGUtjVLRnjgt4vizF3+1fwp3guANDu3Bld?=
 =?us-ascii?Q?VoAE2xuct2xwd4yGi1bNkx5Ijfub3wZ62WX6XiwU3VVZdkw6hlsAdZWQrn+A?=
 =?us-ascii?Q?aKVUyplSsqkES9+QoouaxqXQZcV5WSfwGfIBwtNC3zfGmQvYJ3B6vXCMs+AP?=
 =?us-ascii?Q?HE2Dn8/UHaRT7FRFUPWbAa0ZC97rgJseOukk8zl5Xgk+QICm4ADHVj2P4vtP?=
 =?us-ascii?Q?Gg5tf7Qa+fpX7gi9uTfJT/FTpHd2zfMNQ5N9VTu6J5y1Olm0rtPKdv+MlzzG?=
 =?us-ascii?Q?Ukl0nZ8zAjeXEJ4MaqvgNWyyhVtx+zj5rIUhhLJrk7WGSSL2Lv9MWaHKJc2W?=
 =?us-ascii?Q?uFrKkV/vKGBhKRqJNBE3pfmUDFKC0TInuMaiN8NsB95+F+qDsHj7CJJUAYGe?=
 =?us-ascii?Q?lizv0smb29rNQJniChVLWXPMAa08AQPBb5OO4pS912c2LjXkgH3nQsFA1F0G?=
 =?us-ascii?Q?rf7/ELX4rUXAnoy62iV0fu63vZsije3/RqJNJdIkSf2m2uip2gRQ//nwTsq8?=
 =?us-ascii?Q?ANnTE6eG9gcd3UZqQnY+MUEE7rOujZpCezh2sImgDZYg2lXox+seUPDemkh7?=
 =?us-ascii?Q?hws7U9vI1Ht0naYUVSzccp9NKUh5fedYwRKu85Yz42vTSB6dlRv86qeoqNMH?=
 =?us-ascii?Q?kSNB7zJk081ut1laBrLrdfvZXlSKKu97iolVOwxyDM58IJ/8+OPTMj6agkcG?=
 =?us-ascii?Q?RM6QANNvCdM29Bxzv/BYyqyxQ2uHDNdtT6FWRDCEMtHsRQCKeiYfX0QzWbsj?=
 =?us-ascii?Q?ETqqwb3Pxv2Cpn8YIJdi3P+yxCIx73VHutDS3q3PbVCedP2ElscL7eyXosEF?=
 =?us-ascii?Q?IpwF0hQVv97taZM403GZLAtXfETTH2AIlHHqGXet5SvjMSnOnwbx4lRKJtk8?=
 =?us-ascii?Q?3Chh31F3FhpUvxniE+NTjA93X1BVSfrLwoI1CqCtV8X3Otw466Uy1L7UmSUM?=
 =?us-ascii?Q?RGcgi+cvunq4wUAsYVPZ+uwW0M/Xj8oV4FdXxDbReaVV1TwV8VEKSw5atzqK?=
 =?us-ascii?Q?LmilLvszME26Qc0a23DbuzmA0xKRhsFFMfwEDYvcfIIle9HMzfcSOPMoYJWA?=
 =?us-ascii?Q?sW4yK0FEIND+OuDlARtGCb/lQ0/HjSYYP6HJauh27eAGhVyysfvK/eAshoBV?=
 =?us-ascii?Q?DFRfAH+xmC0Pj1viYOUbux89cxD7H3b7wXtHcN26mMHAAncJ5oiLqo7JRdQt?=
 =?us-ascii?Q?O63y9oPKc7H9HjVsAdAQHXYFZevSBg3PjvDCn1jEUtqIVtmQLcA74GesRoAR?=
 =?us-ascii?Q?E+ic/5/NBpPxzlQplYmSX7Dmddhp14xq0JNq1l3QEDsJh2YoxyW/1aF35emd?=
 =?us-ascii?Q?exwkXoW60cmt0FLKHVa/73XGdBxE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 01:42:50.9033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e3ab96-8f88-46bc-7156-08dc836e7ad6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7635
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

