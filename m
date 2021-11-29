Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D2DC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Nov 2021 15:01:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6917E6E9FE;
	Mon, 29 Nov 2021 15:01:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 198FD6E9FE
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Nov 2021 15:01:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAzUjvB9SZVnlCgenU9xOpZ4H8YgrvsUiD2Ny/q3zS+l71mx6qaOGTYPAmnR8ocL+WVxjjOp2PEwVXm83hURiV4n+xGMmCHnmAlC1YE/qf2nud3TNW3P4VQ6Z5Um+U4aFJUkK1a1tJEnmxHu9X6dwLyGoGBe+7K7WajuiJciU8SzQS5vmJ2wXGbX7ZRpLlcxapyi+acalZzxVBEsUAXw93gIMIpkFIaDuvW15ElgryDrjIxumvNDw524BHPBouaA9iidJ2lmBEx0UFXrSX0bhUh5fXmryhbt65KsZiSCOIhWRyZMK5UExpw4OMzQHWJqJJQjX8mMXQf2VLKystyvxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3F8sEA1hJQDDrgnoqyR4gbVhR5gYxf7zPc0a6671BA=;
 b=cjC0+OveKf6Pp8jNPGeHXSBOMzBW9k42onPIbk0D9tSai9tHD4EPJqywowsSBr1Czrnj1ywQm/QpVv4lEvFlWpi5Y4xzZd7uqd1gz/EUi6ELL0BcOkEX30FKCxakGLuIc7OhV0yVYX8fQXmVbnLuyEHioY8spNRYzZRV9EsBgiqIAYZtU0t3GUkOigc9gzf5AX6PInbMzXmEDS7iqhDXA7iBaDmS1YvC/mLOra4XiNRHL6Kn5m/Zu0RT+jOzJD8o0tYm0dwVhmRaQSA7S2rfwf88qhdMsgBsWrft/kfPRpb0vRN1xKokyUk/E8lwWazPkP7qg2x3g3WGEgC66JxUIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3F8sEA1hJQDDrgnoqyR4gbVhR5gYxf7zPc0a6671BA=;
 b=trSpx6YABzxYQSIPYWrFc5aU7rPs4UO5iuYpXnfBAUTZ/24lcWZVApI4SCVgLmw9WTmiO3V2L5bx64CdLMLI7/D5ht3oOj9qxZaehqd42kNXhEQGr1MH8J6pqixa1qrwer+LfNuRlLZelJDfeAMK+QX04LxBOUqQnr/J8F+l2T0=
Received: from BN9PR03CA0315.namprd03.prod.outlook.com (2603:10b6:408:112::20)
 by CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Mon, 29 Nov
 2021 15:01:35 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::7e) by BN9PR03CA0315.outlook.office365.com
 (2603:10b6:408:112::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Mon, 29 Nov 2021 15:01:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 15:01:33 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 29 Nov
 2021 09:01:31 -0600
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/3] drm/amdkfd: replace asic_name with amdgpu_asic_name
Date: Mon, 29 Nov 2021 09:59:40 -0500
Message-ID: <20211129145942.3542707-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a70a5159-1b63-497a-7e47-08d9b3492255
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5444EC79A85A0C2123EE3F388A669@CO6PR12MB5444.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l3opJ6qtCn/N5jFPO+VvITCnZSUiUvDorMIYXbLstdTKpI2fLT/AYrLJ3HoY/DVcH4zRTJu4KNtVzYQIaajgl0pfFbH/1insXK1D/vWtfgOqEM7tQAppA9iL35Iv3vRhk7phhJJLOEX4q2DcbC+IiIYSer9RCsAer1yiZI/DQ0N2qGtVZ6hC0dynM/n9YllJN5Gt7eD3mqzAsiI/c3hG7igQT2sBfbwf2UaR2YKXPhA5/sAFDdsDaxVyCHwoDeUb51u6PVnkYofedPZe9Cr6RUR/VxewrFYIKMPe26xNDQyIBR/g+1/AcM97rqHQ8bAuQBMToQ2sgqA7U5LF61wBAwpixNkXde9BWaA/+vVPHjGi74dG5yGWGDtIX5RQHyzCWYvQykumHGlAgVWLcq0bisoqEO7LYvaqy/hJtSQZXELfBlc4ImiMv6M+i+rq/xJ/xdRmXkgiWfqwVj7W0ZNDH2k+OMYjpw+r0C5dAqd8v36bYPKqCS6lLQh8j7FcdBUayukaELl59aCJH7LkQoIt6mOjlxoq9sZPAJr1BqJnqkRMJr7gQlKBpCRcLxxZYKj/0/0j0AlgVbvok1Pmjg9Y4GX/QJeFdV6NRlcV9KmF/truwDR38gVjBleEaXU8EZkLG/18g01l3cQEvmwTZGBiWxd9Q00G6EGsBhWeyzNO+GOpY0RZI5v/5rKrWn6HdE4vmEoY5PSeeI8/nqHcZ0JGfWNVKNDVnj091TFRYaA4eWM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(316002)(4326008)(82310400004)(6666004)(16526019)(8676002)(54906003)(356005)(36756003)(1076003)(86362001)(5660300002)(2616005)(70586007)(70206006)(36860700001)(336012)(81166007)(186003)(83380400001)(47076005)(26005)(426003)(7696005)(508600001)(8936002)(6916009)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 15:01:33.9168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a70a5159-1b63-497a-7e47-08d9b3492255
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5444
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
Cc: Felix.Kuehling@amd.com, Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

device_info->asic_name and amdgpu_asic_name[adev->asic_type] both
provide asic name strings, with the only difference being casing.
Remove asic_name from device_info and replace sysfs entry with lowercase
amdgpu_asic_name[]. Ensures string is null-terminated so that this
doesn't break if dev->node_props.name ever gets set anywhere else.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c   | 29 -----------------------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 10 ++++++--
 3 files changed, 8 insertions(+), 32 deletions(-)

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
index 7ea528941951..0d6d1fe1481b 100644
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
index 2d44b26b6657..d6aa27b1ae33 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1285,6 +1285,8 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	void *crat_image = NULL;
 	size_t image_size = 0;
 	int proximity_domain;
+	int i;
+	const char *asic_name = amdgpu_asic_name[gpu->adev->asic_type];
 
 	INIT_LIST_HEAD(&temp_topology_device_list);
 
@@ -1370,8 +1372,12 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 
 	amdgpu_amdkfd_get_cu_info(dev->gpu->adev, &cu_info);
 
-	strncpy(dev->node_props.name, gpu->device_info->asic_name,
-			KFD_TOPOLOGY_PUBLIC_NAME_SIZE);
+	for (i = 0; i < KFD_TOPOLOGY_PUBLIC_NAME_SIZE-1; i++) {
+		dev->node_props.name[i] = __tolower(asic_name[i]);
+		if (asic_name[i] == '\0')
+			break;
+	}
+	dev->node_props.name[i] = '\0';
 
 	dev->node_props.simd_arrays_per_engine =
 		cu_info.num_shader_arrays_per_engine;
-- 
2.25.1

