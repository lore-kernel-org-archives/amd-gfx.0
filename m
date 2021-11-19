Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC75EC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 16:28:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CE4361401
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 16:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9CE4361401
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB2066E098;
	Fri, 19 Nov 2021 16:28:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 528476E03B
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 16:28:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hh45l7NOye7hcM0yCX//h4vfh9tB5Ve3a1N6whrvyvEwy5uJLjSBK1m7BA3ahcF9pjlg9jOnkG9cxGt411BP3KwOtoH6sa3tuUxBSoYyg3dloLfZHInd+kNKw4qAYveL3At1i7h0hp0WHtC/Q4pu3tnVCq42TWdHNBMQTFSwi3DjzrF1Y9wfpX4H0Dmyiumge4YHJPOKxOG9OH5mNNyn83qz73zKWZ9Zf5Uih4IZchbF8A5242XC6gT6blef7WYxBxPSF23Na242MNGzQyG//HtwVd/vMzfjv4cajYgrURhgy38laW7FQ27tHYljCyYHx9/Z8YmC8qDjTt4nsUXnjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieHxoksa4pbKfCdTFYqNOAYqBFxdDWPNo0gUyqvfuJU=;
 b=XSymXMVwiiJfHugI+6Vxgrl95bg6rAFxMiuMnCt3FRDTom9mGjae2CohKjB4WmGH+IWn3C5pwAiMljkrb6ZyKq/1VpC+chPIsZp8XgUsR7VM4lBqP1BpikdNF/7vI9zrET6UPWQ9FyV56/sVdjExNTDagxzSn6Fo4L3arTdiNxGZeHCpDmwcdlvhXp1GNUosbFjxFhScNgow7CW3ARsgSOWpPFAitZADX8ja7nJWsI+gdlkVm/fg2ZxfKkszw1VvKmnAQO5dfn1qFQB3G0eeV7QmKT/0Ol7aawiL7sRisCoAPRTfknT+j8eaa0QF4azLKr40WeZDnUiHCZzIIa6vJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieHxoksa4pbKfCdTFYqNOAYqBFxdDWPNo0gUyqvfuJU=;
 b=qRgWDRQNbHiD6rnCOZjs6GsJOIuQ/jxjNfW5rYrKT3nFgzXfgWqDrefwDSbdvz8e5nRXB3YdEMmTDSxQr56lebl7Xm0mKq/w6V15J11jApE+6hnhK4XfCmkZqJgBUpzp46a8mCSoqaYAPOX+/zEHpzGpmy/Ox/4xR+8PZzwa590=
Received: from DS7PR03CA0341.namprd03.prod.outlook.com (2603:10b6:8:55::23) by
 SJ0PR12MB5438.namprd12.prod.outlook.com (2603:10b6:a03:3ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Fri, 19 Nov
 2021 16:28:35 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::9a) by DS7PR03CA0341.outlook.office365.com
 (2603:10b6:8:55::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 16:28:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 16:28:34 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 10:28:31 -0600
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdkfd: replace asic_name with amdgpu_asic_name
Date: Fri, 19 Nov 2021 11:27:57 -0500
Message-ID: <20211119162800.2111819-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 690abb69-5484-4472-0def-08d9ab79a200
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5438:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5438802CA6D02EE114E3B84F8A9C9@SJ0PR12MB5438.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RqW6LkOE103HesXqxY4eoUByWEctCpchTRIYk3qrPq+OXa3vJ7wU6Y02Pb/QxRRO3zbd7yv6AGJbyu7OXxkjIzXxwAnKll5bMOxpCZgZ51E7p3ddX6VD0A6t0OKO19PFv4avdHWLoGMiyO1TEXNP2pfbTfOQry6eTYIhFQYaDZhppPfMn9lU8J7MqmjNomLC/WuJlci36C5CBUFi36roE8F8+0IZyAuaCRiN4p8L+uIO1ng0L61e+ME+GpUpPz4ew0cWtNXdugXC01CBSyLQHbec/EDr++hkr2zbqlA862t/eYP+qcTnilCIuXaKtF0XPvrEJbunp1EFdIy51NfyNUFusUbD0+vG7em2RK+vuptfVUSqFPBcGwXP1avNhEFqqu2cI7c96VqlV9FJUo625BiypRVXGOqWhOX3gL8lUovyds7fasq3qUdGvyExJqPf7sRF77JC2fAFlh4hFBo7+SrMeCyap+o2nXsd29Nai09J1hx7MHEb43fDVz5KvLgCsm7AhiB6689zoFgYXaf02UjM2BtOilOEwYgOzWcDg1PQ/csX0PXSV4fF/1I1FqGU1odpZ7Q0/Q0Oss2zbbo6NmWD8WdHSg9Yf2cWMfj/vohspzOv+1pQXQsq1Aopd29BgXLfoubp9vijUHzO4nlT2Qmdyt5SxwO8f6y5FJEykbrZL2oD9+DAncegWhWZqr1ZbKJOAyxbD665cl6U3jXvekyRJ+1NqEL8xOWDnV9KrT4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(508600001)(6916009)(82310400003)(70206006)(1076003)(83380400001)(47076005)(8936002)(86362001)(336012)(8676002)(16526019)(186003)(426003)(4326008)(356005)(36756003)(70586007)(6666004)(316002)(5660300002)(2616005)(81166007)(54906003)(36860700001)(7696005)(26005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 16:28:34.5881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 690abb69-5484-4472-0def-08d9ab79a200
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5438
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

