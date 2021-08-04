Return-Path: <SRS0=biE/=M3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286B3C4338F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 18:18:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9AF560F58
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 18:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D9AF560F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F5916EB2E;
	Wed,  4 Aug 2021 18:18:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 960556EB1C
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Aug 2021 18:18:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYA0U13no6ituNq3oHd//fBE/iu248dOa0RZuaXHHGetHOj/ayuDSwcDxDc7bTNAt3NTIPFeEeFcC4s8YQMrWJ3uOJ/qlzuPCnf4jY9shqJLIhG0C9KZTZ1ZZknJnFUVmNlqeYgb9xl2CD6Qsoc1dANCEClzo9N+KKHV7Tp8hG/jyQjmzVIbzv0e+lq/Mz0j4RxfZIUTDxgdBC+GKtP6WOvbZs+nv033Nah6Q26TgFdJ5ooeyr36q5YRpPAeVOBMseXvBfzA391Ixd8sbrqqveNdI7MNeTMfqsA6zh6jaMd/ssTc7/AgCoEXiZ3atSji9fcY24fxvTxJ6aPCludGxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+YjfDcFHwwbkgtc/mhxyzj/ZkshJznxZdnab9W1WVA=;
 b=WmbwquL/9gNLsufTibr2fbnB+QAHGZzeQqf2b3jOPFre8i/c6/f//IKLnhltGYyB0mFWR5cr770uPGkRwaZmrvXS2K9rpr09tFCDYNpwgjVDLASS52kmi89UdoKmn4iCcv1Ssd9T9czjmSpU58fIS6MfY9kveMOFcoUUUX2dkJB403F3YeH4YeMwiXxnGWKyTKyunLPxza1f3pnoGuCuIlZeWzwzA8Y2mt/C6k2k6Zp2bsMnzguq8CFz8dzvG0ixo6iWwLkL2f4Gp1M77Su1qpUiKVMlG2aR7xjwiGJwHJ5Iu+m61vQvavF6MOA5SMssRxWRVfKYWKEI9H5TaPjmTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+YjfDcFHwwbkgtc/mhxyzj/ZkshJznxZdnab9W1WVA=;
 b=fEV8XADDhYA7XbQXQGQaH0KcbQHSwb19+FsVkxuKw9OHZrnTpOAWswattklp2mfpXi+kInoOxywQvLpqIRbSiMmE24dU9onOteEsdLXXj+EQ2jUKxim+m0ZGO2LnYhuejNOrXS0+idzw5VkykXwtOjlJRUXTUGln3fdzi4eX6RY=
Received: from BN9PR03CA0560.namprd03.prod.outlook.com (2603:10b6:408:138::25)
 by BN6PR12MB1633.namprd12.prod.outlook.com (2603:10b6:405:5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Wed, 4 Aug
 2021 18:18:36 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::9a) by BN9PR03CA0560.outlook.office365.com
 (2603:10b6:408:138::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Wed, 4 Aug 2021 18:18:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Wed, 4 Aug 2021 18:18:36 +0000
Received: from grasider-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 4 Aug
 2021 13:18:34 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Graham Sider <Graham.Sider@amd.com>
Subject: [PATCH] drm/amdkfd: Expose GFXIP engine version to sysfs
Date: Wed, 4 Aug 2021 14:17:38 -0400
Message-ID: <20210804181738.6339-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4702012a-5e5c-4e78-da39-08d9577446e7
X-MS-TrafficTypeDiagnostic: BN6PR12MB1633:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1633072E68F0E936DB7A08398AF19@BN6PR12MB1633.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uKt1BweRn1bhFnjomfBA929Sl1w/LL7ZyeGGA/2fBZ9PNH5qwkIVONUsy/wfFmy3cY/wVXmaEFL4Tg8Bqn47qkJD9eAZlcNn+4y+1PI/FM0azAvl00CtygyPBpfMRHeIXPjXy/Y/pEzYQQMYtA3DMgk6NSWSlVnM1rxekMmqbqrEIe0+KVwQoOtA1DC5jq0oJI9Z3PvqjNmipsFBNTzNyP2nDAbHwa4iBizrsZs8yCX4m8b23cQtX2HDdj+VN7pXPhl/l/7a0X2zOLKZOw+EZgOjUJRvnSkoI71w7aKhGZJ78qvJOwZKqWh1xFvWMmEDCalFJcTFfHKEYbPc9DT6KFP8O4fjdZO2bO95SupgX4kKf1oIn8QWkN0X9iJrVTAfcvZjiSGNmtXZRJDnZZjYS6IDpJfUFeh5QdNbTlvGnJpQT+Uap0mfdGATHGowpOK84KNDfBGBnNozLid4ossoEJ+vx924gK/heA1ZBPwTW3cIKzVE6icwtJdBLUJrGGY1i8wte5NcJ4wiU7eFWKRwudGkbdHXqrF0fgClTKY4AxaTjwpGkrIXUnjGVpVhEIMbHDFYd2NCQ1KBR2QuwErsTZseKCllW+Piy91texRLQ2fGpCPop3T9G048gaW13X5M5CNDp5DN9baK7GQ+CA0n6iiSw4XRkvLYqrj6Gp2ewh0ysVP5PtmSq5Txq8eWhazYAO6Z7/UcsrGKkeepGhIk0QD+5M9E0et/1fIl6gyMcF4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(46966006)(36840700001)(86362001)(2616005)(426003)(54906003)(47076005)(5660300002)(4326008)(186003)(30864003)(478600001)(82310400003)(316002)(70586007)(81166007)(6916009)(82740400003)(1076003)(70206006)(36756003)(7696005)(36860700001)(2906002)(356005)(8676002)(16526019)(336012)(26005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 18:18:36.6628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4702012a-5e5c-4e78-da39-08d9577446e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1633
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

Add u32 gfx_version field to kfd_node_properties and kfd_device_info.
Populate <asic>_device_info structs accordingly and expose to sysfs.

This allows eliminating device-ID-based lookup tables in user mode for
future ASICs.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c   | 29 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h |  1 +
 4 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index b551dd675085..16a57b70cc1a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -91,6 +91,7 @@ static const struct kfd2kgd_calls *kfd2kgd_funcs[] = {
 static const struct kfd_device_info kaveri_device_info = {
 	.asic_family = CHIP_KAVERI,
 	.asic_name = "kaveri",
+	.gfx_target_version = 70000,
 	.max_pasid_bits = 16,
 	/* max num of queues for KV.TODO should be a dynamic value */
 	.max_no_of_hqd	= 24,
@@ -110,6 +111,7 @@ static const struct kfd_device_info kaveri_device_info = {
 static const struct kfd_device_info carrizo_device_info = {
 	.asic_family = CHIP_CARRIZO,
 	.asic_name = "carrizo",
+	.gfx_target_version = 80001,
 	.max_pasid_bits = 16,
 	/* max num of queues for CZ.TODO should be a dynamic value */
 	.max_no_of_hqd	= 24,
@@ -130,6 +132,7 @@ static const struct kfd_device_info carrizo_device_info = {
 static const struct kfd_device_info raven_device_info = {
 	.asic_family = CHIP_RAVEN,
 	.asic_name = "raven",
+	.gfx_target_version = 90002,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
@@ -148,6 +151,7 @@ static const struct kfd_device_info raven_device_info = {
 static const struct kfd_device_info hawaii_device_info = {
 	.asic_family = CHIP_HAWAII,
 	.asic_name = "hawaii",
+	.gfx_target_version = 70001,
 	.max_pasid_bits = 16,
 	/* max num of queues for KV.TODO should be a dynamic value */
 	.max_no_of_hqd	= 24,
@@ -167,6 +171,7 @@ static const struct kfd_device_info hawaii_device_info = {
 static const struct kfd_device_info tonga_device_info = {
 	.asic_family = CHIP_TONGA,
 	.asic_name = "tonga",
+	.gfx_target_version = 80002,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 4,
@@ -185,6 +190,7 @@ static const struct kfd_device_info tonga_device_info = {
 static const struct kfd_device_info fiji_device_info = {
 	.asic_family = CHIP_FIJI,
 	.asic_name = "fiji",
+	.gfx_target_version = 80003,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 4,
@@ -203,6 +209,7 @@ static const struct kfd_device_info fiji_device_info = {
 static const struct kfd_device_info fiji_vf_device_info = {
 	.asic_family = CHIP_FIJI,
 	.asic_name = "fiji",
+	.gfx_target_version = 80003,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 4,
@@ -222,6 +229,7 @@ static const struct kfd_device_info fiji_vf_device_info = {
 static const struct kfd_device_info polaris10_device_info = {
 	.asic_family = CHIP_POLARIS10,
 	.asic_name = "polaris10",
+	.gfx_target_version = 80003,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 4,
@@ -240,6 +248,7 @@ static const struct kfd_device_info polaris10_device_info = {
 static const struct kfd_device_info polaris10_vf_device_info = {
 	.asic_family = CHIP_POLARIS10,
 	.asic_name = "polaris10",
+	.gfx_target_version = 80003,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 4,
@@ -258,6 +267,7 @@ static const struct kfd_device_info polaris10_vf_device_info = {
 static const struct kfd_device_info polaris11_device_info = {
 	.asic_family = CHIP_POLARIS11,
 	.asic_name = "polaris11",
+	.gfx_target_version = 80003,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 4,
@@ -276,6 +286,7 @@ static const struct kfd_device_info polaris11_device_info = {
 static const struct kfd_device_info polaris12_device_info = {
 	.asic_family = CHIP_POLARIS12,
 	.asic_name = "polaris12",
+	.gfx_target_version = 80003,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 4,
@@ -294,6 +305,7 @@ static const struct kfd_device_info polaris12_device_info = {
 static const struct kfd_device_info vegam_device_info = {
 	.asic_family = CHIP_VEGAM,
 	.asic_name = "vegam",
+	.gfx_target_version = 80003,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 4,
@@ -312,6 +324,7 @@ static const struct kfd_device_info vegam_device_info = {
 static const struct kfd_device_info vega10_device_info = {
 	.asic_family = CHIP_VEGA10,
 	.asic_name = "vega10",
+	.gfx_target_version = 90000,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
@@ -330,6 +343,7 @@ static const struct kfd_device_info vega10_device_info = {
 static const struct kfd_device_info vega10_vf_device_info = {
 	.asic_family = CHIP_VEGA10,
 	.asic_name = "vega10",
+	.gfx_target_version = 90000,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
@@ -348,6 +362,7 @@ static const struct kfd_device_info vega10_vf_device_info = {
 static const struct kfd_device_info vega12_device_info = {
 	.asic_family = CHIP_VEGA12,
 	.asic_name = "vega12",
+	.gfx_target_version = 90004,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
@@ -366,6 +381,7 @@ static const struct kfd_device_info vega12_device_info = {
 static const struct kfd_device_info vega20_device_info = {
 	.asic_family = CHIP_VEGA20,
 	.asic_name = "vega20",
+	.gfx_target_version = 90006,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd	= 24,
 	.doorbell_size	= 8,
@@ -384,6 +400,7 @@ static const struct kfd_device_info vega20_device_info = {
 static const struct kfd_device_info arcturus_device_info = {
 	.asic_family = CHIP_ARCTURUS,
 	.asic_name = "arcturus",
+	.gfx_target_version = 90008,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd	= 24,
 	.doorbell_size	= 8,
@@ -402,6 +419,7 @@ static const struct kfd_device_info arcturus_device_info = {
 static const struct kfd_device_info aldebaran_device_info = {
 	.asic_family = CHIP_ALDEBARAN,
 	.asic_name = "aldebaran",
+	.gfx_target_version = 90010,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd	= 24,
 	.doorbell_size	= 8,
@@ -420,6 +438,7 @@ static const struct kfd_device_info aldebaran_device_info = {
 static const struct kfd_device_info renoir_device_info = {
 	.asic_family = CHIP_RENOIR,
 	.asic_name = "renoir",
+	.gfx_target_version = 90002,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
@@ -438,6 +457,7 @@ static const struct kfd_device_info renoir_device_info = {
 static const struct kfd_device_info navi10_device_info = {
 	.asic_family = CHIP_NAVI10,
 	.asic_name = "navi10",
+	.gfx_target_version = 100100,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
@@ -456,6 +476,7 @@ static const struct kfd_device_info navi10_device_info = {
 static const struct kfd_device_info navi12_device_info = {
 	.asic_family = CHIP_NAVI12,
 	.asic_name = "navi12",
+	.gfx_target_version = 100101,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
@@ -474,6 +495,7 @@ static const struct kfd_device_info navi12_device_info = {
 static const struct kfd_device_info navi14_device_info = {
 	.asic_family = CHIP_NAVI14,
 	.asic_name = "navi14",
+	.gfx_target_version = 100102,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
@@ -492,6 +514,7 @@ static const struct kfd_device_info navi14_device_info = {
 static const struct kfd_device_info sienna_cichlid_device_info = {
 	.asic_family = CHIP_SIENNA_CICHLID,
 	.asic_name = "sienna_cichlid",
+	.gfx_target_version = 100300,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
@@ -510,6 +533,7 @@ static const struct kfd_device_info sienna_cichlid_device_info = {
 static const struct kfd_device_info navy_flounder_device_info = {
 	.asic_family = CHIP_NAVY_FLOUNDER,
 	.asic_name = "navy_flounder",
+	.gfx_target_version = 100301,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
@@ -528,6 +552,7 @@ static const struct kfd_device_info navy_flounder_device_info = {
 static const struct kfd_device_info vangogh_device_info = {
 	.asic_family = CHIP_VANGOGH,
 	.asic_name = "vangogh",
+	.gfx_target_version = 100303,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
@@ -546,6 +571,7 @@ static const struct kfd_device_info vangogh_device_info = {
 static const struct kfd_device_info dimgrey_cavefish_device_info = {
 	.asic_family = CHIP_DIMGREY_CAVEFISH,
 	.asic_name = "dimgrey_cavefish",
+	.gfx_target_version = 100302,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
@@ -564,6 +590,7 @@ static const struct kfd_device_info dimgrey_cavefish_device_info = {
 static const struct kfd_device_info beige_goby_device_info = {
 	.asic_family = CHIP_BEIGE_GOBY,
 	.asic_name = "beige_goby",
+	.gfx_target_version = 100304,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
@@ -582,6 +609,7 @@ static const struct kfd_device_info beige_goby_device_info = {
 static const struct kfd_device_info yellow_carp_device_info = {
 	.asic_family = CHIP_YELLOW_CARP,
 	.asic_name = "yellow_carp",
+	.gfx_target_version = 100305,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
@@ -600,6 +628,7 @@ static const struct kfd_device_info yellow_carp_device_info = {
 static const struct kfd_device_info cyan_skillfish_device_info = {
 	.asic_family = CHIP_CYAN_SKILLFISH,
 	.asic_name = "cyan_skillfish",
+	.gfx_target_version = 100103,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 8a5dfda224bf..ab83b0de6b22 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -196,6 +196,7 @@ struct kfd_event_interrupt_class {
 struct kfd_device_info {
 	enum amd_asic_type asic_family;
 	const char *asic_name;
+	uint32_t gfx_target_version;
 	const struct kfd_event_interrupt_class *event_interrupt_class;
 	unsigned int max_pasid_bits;
 	unsigned int max_no_of_hqd;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index ef992dd2da3a..98cca5f2b27f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -478,6 +478,8 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 			      dev->node_props.simd_per_cu);
 	sysfs_show_32bit_prop(buffer, offs, "max_slots_scratch_cu",
 			      dev->node_props.max_slots_scratch_cu);
+	sysfs_show_32bit_prop(buffer, offs, "gfx_target_version",
+			      dev->node_props.gfx_target_version);
 	sysfs_show_32bit_prop(buffer, offs, "vendor_id",
 			      dev->node_props.vendor_id);
 	sysfs_show_32bit_prop(buffer, offs, "device_id",
@@ -1360,6 +1362,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	dev->node_props.simd_arrays_per_engine =
 		cu_info.num_shader_arrays_per_engine;
 
+	dev->node_props.gfx_target_version = gpu->device_info->gfx_target_version;
 	dev->node_props.vendor_id = gpu->pdev->vendor;
 	dev->node_props.device_id = gpu->pdev->device;
 	dev->node_props.capability |=
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index 8b48c6692007..a8db017c9b8e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -78,6 +78,7 @@ struct kfd_node_properties {
 	uint32_t simd_per_cu;
 	uint32_t max_slots_scratch_cu;
 	uint32_t engine_id;
+	uint32_t gfx_target_version;
 	uint32_t vendor_id;
 	uint32_t device_id;
 	uint32_t location_id;
-- 
2.17.1

