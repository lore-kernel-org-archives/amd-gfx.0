Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1448BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8233610A1
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D8233610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 771D86E532;
	Fri, 19 Nov 2021 19:53:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33D6F6E532
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 19:53:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuQkOWZE54+91T2IodL15JO8VXfywvt/PWygm4FhN6NVHui7ifHtIiW1HnV1aZR8MX9KhBAqjZNp0hmYKY0mHFP+KkJNN5pFq6QTEzlHBSVMvITgw0CQfFHnBlewdfscmxw8LJM03eSvzMBheEvt3l4hWSWizBiW43Yq5TCggs4sWWNsmmB1GuewKIs9Xsac41ba7gkl73P9yXRMPeyhBN/lalld+0QiXRzeztCLQtiq0J6DMpjF+T9tUDrcUMsqzhqS4UBJaXObA6BpY2rTBoNaAbQNlMSfMVhDyt/n5geg5QkBAnLhqzsY5BUzvhmwZjvTZcQ91lMtpTcg7q/Ryw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieHxoksa4pbKfCdTFYqNOAYqBFxdDWPNo0gUyqvfuJU=;
 b=j9Ra8D+cbv+z3HCCCUddydHW+T190+jXRweEQFGTHjMA4WrHRy9ExJFsqgIDNeve1JHgh1qRlpJU+Yn9v7BJbT/TB7DTZntl5Us0TlLo3D+tlsMxloc9KCZFJMqLlumQfiVW7V60b1D+9DVrE4DAWh3fxQyYPhvwYSygk5Y2G55BexN59/HVQWpRpxjyQs+DkD8w00XC1TrbfHwvOySigcp8G866jm2+jy/4+km6SEllTtZ47PZ4SReDAQNycLZ6uMiG7t0rPbHFS5JaYoNrZ/CEPEFosIcosHir8Ffuu1ElwF3YbQhmPdGWhZt9YZ9/6mdytjaXzp+mpqJWt2CCew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieHxoksa4pbKfCdTFYqNOAYqBFxdDWPNo0gUyqvfuJU=;
 b=5IB95abjojqEnKKZg18133wTwIhDktT9MDWvgL4pQZc1d1DlkJaipKSTLfAxjU/K1WSXp+d5BLVaY6aGbp6HJ8YJDNlJAjSdulnXT+O+cmfyazv5ObCghKdG20KsOpB6UTi3YCP8FQdFIbhZ+qf75rv3/vKGOAzy7Z0z1zIrXjY=
Received: from MW4PR04CA0388.namprd04.prod.outlook.com (2603:10b6:303:81::33)
 by CY4PR12MB1816.namprd12.prod.outlook.com (2603:10b6:903:11c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 19:53:54 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::f2) by MW4PR04CA0388.outlook.office365.com
 (2603:10b6:303:81::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 19:53:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 19:53:53 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 13:53:52 -0600
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/4] drm/amdkfd: replace asic_name with amdgpu_asic_name
Date: Fri, 19 Nov 2021 14:52:55 -0500
Message-ID: <20211119195258.2173551-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5081474c-e390-435d-3706-08d9ab9650d0
X-MS-TrafficTypeDiagnostic: CY4PR12MB1816:
X-Microsoft-Antispam-PRVS: <CY4PR12MB18165FFB4C75B71670F6C7738A9C9@CY4PR12MB1816.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RxtQPMTCKw053/LO0x0GmxSU/E9XRpe011g/79e//wLBo9YG6PTu62VXzsqm9IuM/GuFRrSG7Pkth8ejp2DyaGzaOvCWYIjKYWzKzrSgmMfO12AEM9+jy+BaEQ+/vYiDvDK0IZ7kERFXtWu0S2ULEtYJ7WAd0GAP6dGy8ZbVxqcarVrL2tWJSI2vHYmt6xXuBXlv3rndBeOl6/JeUB7yQD4+CpYrrCwXa4yZlvIWGJewEglWTZ6DF6TaDI4Tv/TTmke7kcvMdPCnvbVvxwWDO6zFCgNN1vamKkH59B9F9BJdSETfmc9uRKiT+WTaasznbnBNqmIkcbDnERP2FP888cGtWiyZ8Q6htv2FcHgdKCGnztKrTd0z0pijlRVwZBvme/38S+8UvpmxHwAbCU9xtLGDk52Hl/I1wWtAGkZCTJjy26FtQz79s5BKU8qyGz/7uRas/YU7ak7edkTyVvjlSKjF6HOZqlEACXQ/PRjvBrMOxiqgjFCypCElWR0HwYTKHOEry1vISp2J0SVWjqWTGxHL8mVedwVD55XPTTYTTQCKbWZb+CG5QiHzZDFUahMg1aoLVX0FhqvySmxN1B+hzUM+IjmzisPHI6SNmE3iBCsJrhoKtjwKwOLIc0aj4eI4d6qqRxN2/PfZ0awaNAoG7ULM1FI2Gi/He4HQouKD0PuxQYuXE/7QGw9yrLrOgOdTfWQWTWLUVJWS+21TzQ3oqH1wT08pG6K1IHQoOdbND4Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2616005)(508600001)(36756003)(82310400003)(1076003)(426003)(356005)(47076005)(54906003)(6916009)(316002)(8936002)(2906002)(36860700001)(81166007)(86362001)(70586007)(83380400001)(5660300002)(4326008)(26005)(8676002)(186003)(70206006)(16526019)(336012)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 19:53:53.7303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5081474c-e390-435d-3706-08d9ab9650d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1816
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
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

device_info->asic_name and amdgpu_asic_name[adev->asic_type] both
provide asic name strings, with the only difference being casing.
Propose to remove asic_name from device_info and replace sysfs entry
with amdgpu_asic_name[].

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c   | 29 -----------------------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  2 +-
 3 files changed, 1 insertion(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index e1294fba0c26..e11fc4e20c32 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -55,7 +55,6 @@ extern const struct kfd2kgd_calls gfx_v10_3_kfd2kgd;
 
 #ifdef KFD_SUPPORT_IOMMU_V2
 static const struct kfd_device_info kaveri_device_info = {
-	.asic_name = "kaveri",
 	.gfx_target_version = 70000,
 	.max_pasid_bits = 16,
 	/* max num of queues for KV.TODO should be a dynamic value */
@@ -72,7 +71,6 @@ static const struct kfd_device_info kaveri_device_info = {
 };
 
 static const struct kfd_device_info carrizo_device_info = {
-	.asic_name = "carrizo",
 	.gfx_target_version = 80001,
 	.max_pasid_bits = 16,
 	/* max num of queues for CZ.TODO should be a dynamic value */
@@ -89,7 +87,6 @@ static const struct kfd_device_info carrizo_device_info = {
 };
 
 static const struct kfd_device_info raven_device_info = {
-	.asic_name = "raven",
 	.gfx_target_version = 90002,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
@@ -107,7 +104,6 @@ static const struct kfd_device_info raven_device_info = {
 
 #ifdef CONFIG_DRM_AMDGPU_CIK
 static const struct kfd_device_info hawaii_device_info = {
-	.asic_name = "hawaii",
 	.gfx_target_version = 70001,
 	.max_pasid_bits = 16,
 	/* max num of queues for KV.TODO should be a dynamic value */
@@ -125,7 +121,6 @@ static const struct kfd_device_info hawaii_device_info = {
 #endif
 
 static const struct kfd_device_info tonga_device_info = {
-	.asic_name = "tonga",
 	.gfx_target_version = 80002,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
@@ -141,7 +136,6 @@ static const struct kfd_device_info tonga_device_info = {
 };
 
 static const struct kfd_device_info fiji_device_info = {
-	.asic_name = "fiji",
 	.gfx_target_version = 80003,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
@@ -157,7 +151,6 @@ static const struct kfd_device_info fiji_device_info = {
 };
 
 static const struct kfd_device_info fiji_vf_device_info = {
-	.asic_name = "fiji",
 	.gfx_target_version = 80003,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
@@ -174,7 +167,6 @@ static const struct kfd_device_info fiji_vf_device_info = {
 
 
 static const struct kfd_device_info polaris10_device_info = {
-	.asic_name = "polaris10",
 	.gfx_target_version = 80003,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
@@ -190,7 +182,6 @@ static const struct kfd_device_info polaris10_device_info = {
 };
 
 static const struct kfd_device_info polaris10_vf_device_info = {
-	.asic_name = "polaris10",
 	.gfx_target_version = 80003,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
@@ -206,7 +197,6 @@ static const struct kfd_device_info polaris10_vf_device_info = {
 };
 
 static const struct kfd_device_info polaris11_device_info = {
-	.asic_name = "polaris11",
 	.gfx_target_version = 80003,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
@@ -222,7 +212,6 @@ static const struct kfd_device_info polaris11_device_info = {
 };
 
 static const struct kfd_device_info polaris12_device_info = {
-	.asic_name = "polaris12",
 	.gfx_target_version = 80003,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
@@ -238,7 +227,6 @@ static const struct kfd_device_info polaris12_device_info = {
 };
 
 static const struct kfd_device_info vegam_device_info = {
-	.asic_name = "vegam",
 	.gfx_target_version = 80003,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
@@ -254,7 +242,6 @@ static const struct kfd_device_info vegam_device_info = {
 };
 
 static const struct kfd_device_info vega10_device_info = {
-	.asic_name = "vega10",
 	.gfx_target_version = 90000,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
@@ -270,7 +257,6 @@ static const struct kfd_device_info vega10_device_info = {
 };
 
 static const struct kfd_device_info vega10_vf_device_info = {
-	.asic_name = "vega10",
 	.gfx_target_version = 90000,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
@@ -286,7 +272,6 @@ static const struct kfd_device_info vega10_vf_device_info = {
 };
 
 static const struct kfd_device_info vega12_device_info = {
-	.asic_name = "vega12",
 	.gfx_target_version = 90004,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
@@ -302,7 +287,6 @@ static const struct kfd_device_info vega12_device_info = {
 };
 
 static const struct kfd_device_info vega20_device_info = {
-	.asic_name = "vega20",
 	.gfx_target_version = 90006,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd	= 24,
@@ -318,7 +302,6 @@ static const struct kfd_device_info vega20_device_info = {
 };
 
 static const struct kfd_device_info arcturus_device_info = {
-	.asic_name = "arcturus",
 	.gfx_target_version = 90008,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd	= 24,
@@ -334,7 +317,6 @@ static const struct kfd_device_info arcturus_device_info = {
 };
 
 static const struct kfd_device_info aldebaran_device_info = {
-	.asic_name = "aldebaran",
 	.gfx_target_version = 90010,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd	= 24,
@@ -350,7 +332,6 @@ static const struct kfd_device_info aldebaran_device_info = {
 };
 
 static const struct kfd_device_info renoir_device_info = {
-	.asic_name = "renoir",
 	.gfx_target_version = 90012,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
@@ -366,7 +347,6 @@ static const struct kfd_device_info renoir_device_info = {
 };
 
 static const struct kfd_device_info navi10_device_info = {
-	.asic_name = "navi10",
 	.gfx_target_version = 100100,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
@@ -383,7 +363,6 @@ static const struct kfd_device_info navi10_device_info = {
 };
 
 static const struct kfd_device_info navi12_device_info = {
-	.asic_name = "navi12",
 	.gfx_target_version = 100101,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
@@ -400,7 +379,6 @@ static const struct kfd_device_info navi12_device_info = {
 };
 
 static const struct kfd_device_info navi14_device_info = {
-	.asic_name = "navi14",
 	.gfx_target_version = 100102,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
@@ -417,7 +395,6 @@ static const struct kfd_device_info navi14_device_info = {
 };
 
 static const struct kfd_device_info sienna_cichlid_device_info = {
-	.asic_name = "sienna_cichlid",
 	.gfx_target_version = 100300,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
@@ -434,7 +411,6 @@ static const struct kfd_device_info sienna_cichlid_device_info = {
 };
 
 static const struct kfd_device_info navy_flounder_device_info = {
-	.asic_name = "navy_flounder",
 	.gfx_target_version = 100301,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
@@ -451,7 +427,6 @@ static const struct kfd_device_info navy_flounder_device_info = {
 };
 
 static const struct kfd_device_info vangogh_device_info = {
-	.asic_name = "vangogh",
 	.gfx_target_version = 100303,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
@@ -468,7 +443,6 @@ static const struct kfd_device_info vangogh_device_info = {
 };
 
 static const struct kfd_device_info dimgrey_cavefish_device_info = {
-	.asic_name = "dimgrey_cavefish",
 	.gfx_target_version = 100302,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
@@ -485,7 +459,6 @@ static const struct kfd_device_info dimgrey_cavefish_device_info = {
 };
 
 static const struct kfd_device_info beige_goby_device_info = {
-	.asic_name = "beige_goby",
 	.gfx_target_version = 100304,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
@@ -502,7 +475,6 @@ static const struct kfd_device_info beige_goby_device_info = {
 };
 
 static const struct kfd_device_info yellow_carp_device_info = {
-	.asic_name = "yellow_carp",
 	.gfx_target_version = 100305,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
@@ -519,7 +491,6 @@ static const struct kfd_device_info yellow_carp_device_info = {
 };
 
 static const struct kfd_device_info cyan_skillfish_device_info = {
-	.asic_name = "cyan_skillfish",
 	.gfx_target_version = 100103,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 1054fedd7b3c..3e11febee7c6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -195,7 +195,6 @@ struct kfd_event_interrupt_class {
 };
 
 struct kfd_device_info {
-	const char *asic_name;
 	uint32_t gfx_target_version;
 	const struct kfd_event_interrupt_class *event_interrupt_class;
 	unsigned int max_pasid_bits;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 2d44b26b6657..d2bb35f1c58f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1370,7 +1370,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 
 	amdgpu_amdkfd_get_cu_info(dev->gpu->adev, &cu_info);
 
-	strncpy(dev->node_props.name, gpu->device_info->asic_name,
+	strncpy(dev->node_props.name, amdgpu_asic_name[gpu->adev->asic_type],
 			KFD_TOPOLOGY_PUBLIC_NAME_SIZE);
 
 	dev->node_props.simd_arrays_per_engine =
-- 
2.25.1

