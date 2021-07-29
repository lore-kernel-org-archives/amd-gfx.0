Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB731C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 20:25:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B957F6023E
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 20:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B957F6023E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A3786EE56;
	Thu, 29 Jul 2021 20:25:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55DB16EE56
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 20:25:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ap32u7T8RxAymF2u1DqVtzCLcYyF+s13HCctkhgeMM/NoQK1S7P7ylKUFbBUg7Gm0Hraf0jfiYJCG/TmRM8MHDuNqvVCKsnR6GYfWJedS+PrUxjRQQK2h/JestmwYxHTa85QL67ygAAsfzjOHqKdXorN1chICOY+y5RWA/MHKl9KDHJgfRNqkkFoJumxI0hBgvuT/h4q4auKKi0ol/MgZCzvTd1lzljD9BBd9jRI69wU+qGJLK3DdeHkfBXeKuDVt7aMkh5PNKbsFEJr+qmApaROsbphgKpLRNhoUQRSvhti6YtDFA/3Fcqt1fq0MI+cvOnkZ1imFmpxgPYz59Wrgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHlbpXtMKa231rh3W9w7+2cWOwhhVx2IvIFM9RXndog=;
 b=KusbGOuGqOxmMgvhM3bWEY1Tw/AdMX8fmPKmfx35e9b6nWbZY6wWT0qISJJcXNFQpo8+UO6rD5mRHF5YJaU5hwwtKyEAjHQ+mb6sq59vruAy3M+7ld0qyOZfTGXfxKVTvomAFfWIxEbZXw7hH+mLM2Kqv10QKuOTvvRtyy7xHO1xSeWJBGZg5MFcV7QgM3JTzQaaZ2/P628gzYmsQ33Uet2IctbipkxesBo/UDWGn73KHUMZZt5nTPqpgh6DHX+wwWp79F0CXHCWdXdiWFbBh2ZMPfRnvHY+MWc9xcYJiFl+Ddzexo5vokWK59GcwhoOuu7qWDb2e2fYO8pbgDoUvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHlbpXtMKa231rh3W9w7+2cWOwhhVx2IvIFM9RXndog=;
 b=aDsyeovSoQW4KTVt7ILYbWPb2mst/+puSB3ptTsIPdqJBo6njt/dEeRecWbmNTzMkFbK+oLeJpPXMT+KkiJg7r4D9b+KJ9fuLm2Q3IEBbEkxXeplB6ICfT2BxT2kuGg0My9pkfNJBi8h5+iVM+dJy2abiYqoBiWk+B33rwZx/G0=
Received: from CO2PR04CA0173.namprd04.prod.outlook.com (2603:10b6:104:4::27)
 by BN9PR12MB5273.namprd12.prod.outlook.com (2603:10b6:408:11e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17; Thu, 29 Jul
 2021 20:25:30 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::67) by CO2PR04CA0173.outlook.office365.com
 (2603:10b6:104:4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Thu, 29 Jul 2021 20:25:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 20:25:29 +0000
Received: from grasider-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 15:25:28 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Expose GFXIP engine version to sysfs
Date: Thu, 29 Jul 2021 16:25:13 -0400
Message-ID: <20210729202514.3506-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85967805-5656-421a-893c-08d952cf0244
X-MS-TrafficTypeDiagnostic: BN9PR12MB5273:
X-Microsoft-Antispam-PRVS: <BN9PR12MB52739A20005228F570B13A548AEB9@BN9PR12MB5273.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SScK6GXV2gwZAjHB8GnniZY+xnvdWvlDi+QK2mLg1DX7DUTwUQiWLyWpmHDcoi29rhNQlY3pTUmtWfRsM2zpAhruYsoefZwMnRjcMR++UEqf8PW971zrK47c1gXWI5kuyOwKOF3ShjKrYM/JLbiC1qjs0X54hQek5YW2JEXMn6zzn3h+gN9O86Z5Dl9GQ3ZJGxQmsIm0j1Bx3xCozvolskZX8aAHGQ2mEKi+01yhIkxrHoAYivDmq4Fos0V8F6k/qfrYw37D9cw4VA4wBvAwM3mPJm+pN0nFQtTNNX/+pIBZfSOZlipBdKruGoAojHOGXgKRHtsGw4+znzWciwEvDYuRJWR9dLduhYK6WlXfUDwq/24T7yLDblqzzuvVs3DbxAld8OLuOkiatgcnEx5nykvZ8A8b01kfgxMeWRbZDXLj1ZDBJVbFrHE/UMM3f28i/jkB+Kix4GR2iPTJrFxEvtvkUEHgkJnIZhBlNW/z8ED6Za4wocLQmKEdNrBKbve+5AST9HLrUh12CCRaJ4PRvwvyHJGtUuIqRA426i9Fr6N1WTVV5zzrNMrtprb5115AStlXLb49M9v3WQZJi0JtfZ+0yL217jQ56CXi2hTFOUgEbSsgXF7+M6ExTeavIrkwVMamu2ZcRyRiJTyqU6OrQQF4G45k6N40QRioNDsSBs397JPwMPJlFNF5LHtdToVdyhXLu0KQWVxF2I91LCx1JE5mvkqsnloa8Ul6eNLgZ98=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(82310400003)(7696005)(356005)(30864003)(16526019)(2616005)(2906002)(86362001)(508600001)(186003)(8676002)(336012)(4326008)(5660300002)(1076003)(8936002)(316002)(47076005)(36860700001)(54906003)(70206006)(6916009)(6666004)(70586007)(26005)(81166007)(36756003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 20:25:29.7760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85967805-5656-421a-893c-08d952cf0244
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5273
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
Cc: Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com,
 Graham Sider <Graham.Sider@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add u32 gfx_version field to kfd_node_properties and kfd_device_info.
Populate <asic>_device_info structs accordingly and expose to sysfs.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c   | 29 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h |  1 +
 4 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index b551dd675085..1699f1adff9d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -91,6 +91,7 @@ static const struct kfd2kgd_calls *kfd2kgd_funcs[] = {
 static const struct kfd_device_info kaveri_device_info = {
 	.asic_family = CHIP_KAVERI,
 	.asic_name = "kaveri",
+	.gfx_version = 70000,
 	.max_pasid_bits = 16,
 	/* max num of queues for KV.TODO should be a dynamic value */
 	.max_no_of_hqd	= 24,
@@ -110,6 +111,7 @@ static const struct kfd_device_info kaveri_device_info = {
 static const struct kfd_device_info carrizo_device_info = {
 	.asic_family = CHIP_CARRIZO,
 	.asic_name = "carrizo",
+	.gfx_version = 80001,
 	.max_pasid_bits = 16,
 	/* max num of queues for CZ.TODO should be a dynamic value */
 	.max_no_of_hqd	= 24,
@@ -130,6 +132,7 @@ static const struct kfd_device_info carrizo_device_info = {
 static const struct kfd_device_info raven_device_info = {
 	.asic_family = CHIP_RAVEN,
 	.asic_name = "raven",
+	.gfx_version = 90002,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
@@ -148,6 +151,7 @@ static const struct kfd_device_info raven_device_info = {
 static const struct kfd_device_info hawaii_device_info = {
 	.asic_family = CHIP_HAWAII,
 	.asic_name = "hawaii",
+	.gfx_version = 70001,
 	.max_pasid_bits = 16,
 	/* max num of queues for KV.TODO should be a dynamic value */
 	.max_no_of_hqd	= 24,
@@ -167,6 +171,7 @@ static const struct kfd_device_info hawaii_device_info = {
 static const struct kfd_device_info tonga_device_info = {
 	.asic_family = CHIP_TONGA,
 	.asic_name = "tonga",
+	.gfx_version = 80002,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 4,
@@ -185,6 +190,7 @@ static const struct kfd_device_info tonga_device_info = {
 static const struct kfd_device_info fiji_device_info = {
 	.asic_family = CHIP_FIJI,
 	.asic_name = "fiji",
+	.gfx_version = 80003,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 4,
@@ -203,6 +209,7 @@ static const struct kfd_device_info fiji_device_info = {
 static const struct kfd_device_info fiji_vf_device_info = {
 	.asic_family = CHIP_FIJI,
 	.asic_name = "fiji",
+	.gfx_version = 80003,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 4,
@@ -222,6 +229,7 @@ static const struct kfd_device_info fiji_vf_device_info = {
 static const struct kfd_device_info polaris10_device_info = {
 	.asic_family = CHIP_POLARIS10,
 	.asic_name = "polaris10",
+	.gfx_version = 80003,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 4,
@@ -240,6 +248,7 @@ static const struct kfd_device_info polaris10_device_info = {
 static const struct kfd_device_info polaris10_vf_device_info = {
 	.asic_family = CHIP_POLARIS10,
 	.asic_name = "polaris10",
+	.gfx_version = 80003,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 4,
@@ -258,6 +267,7 @@ static const struct kfd_device_info polaris10_vf_device_info = {
 static const struct kfd_device_info polaris11_device_info = {
 	.asic_family = CHIP_POLARIS11,
 	.asic_name = "polaris11",
+	.gfx_version = 80003,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 4,
@@ -276,6 +286,7 @@ static const struct kfd_device_info polaris11_device_info = {
 static const struct kfd_device_info polaris12_device_info = {
 	.asic_family = CHIP_POLARIS12,
 	.asic_name = "polaris12",
+	.gfx_version = 80003,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 4,
@@ -294,6 +305,7 @@ static const struct kfd_device_info polaris12_device_info = {
 static const struct kfd_device_info vegam_device_info = {
 	.asic_family = CHIP_VEGAM,
 	.asic_name = "vegam",
+	.gfx_version = 80003,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 4,
@@ -312,6 +324,7 @@ static const struct kfd_device_info vegam_device_info = {
 static const struct kfd_device_info vega10_device_info = {
 	.asic_family = CHIP_VEGA10,
 	.asic_name = "vega10",
+	.gfx_version = 90000,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
@@ -330,6 +343,7 @@ static const struct kfd_device_info vega10_device_info = {
 static const struct kfd_device_info vega10_vf_device_info = {
 	.asic_family = CHIP_VEGA10,
 	.asic_name = "vega10",
+	.gfx_version = 90000,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
@@ -348,6 +362,7 @@ static const struct kfd_device_info vega10_vf_device_info = {
 static const struct kfd_device_info vega12_device_info = {
 	.asic_family = CHIP_VEGA12,
 	.asic_name = "vega12",
+	.gfx_version = 90004,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
@@ -366,6 +381,7 @@ static const struct kfd_device_info vega12_device_info = {
 static const struct kfd_device_info vega20_device_info = {
 	.asic_family = CHIP_VEGA20,
 	.asic_name = "vega20",
+	.gfx_version = 90006,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd	= 24,
 	.doorbell_size	= 8,
@@ -384,6 +400,7 @@ static const struct kfd_device_info vega20_device_info = {
 static const struct kfd_device_info arcturus_device_info = {
 	.asic_family = CHIP_ARCTURUS,
 	.asic_name = "arcturus",
+	.gfx_version = 90008,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd	= 24,
 	.doorbell_size	= 8,
@@ -402,6 +419,7 @@ static const struct kfd_device_info arcturus_device_info = {
 static const struct kfd_device_info aldebaran_device_info = {
 	.asic_family = CHIP_ALDEBARAN,
 	.asic_name = "aldebaran",
+	.gfx_version = 90010,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd	= 24,
 	.doorbell_size	= 8,
@@ -420,6 +438,7 @@ static const struct kfd_device_info aldebaran_device_info = {
 static const struct kfd_device_info renoir_device_info = {
 	.asic_family = CHIP_RENOIR,
 	.asic_name = "renoir",
+	.gfx_version = 90002,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
@@ -438,6 +457,7 @@ static const struct kfd_device_info renoir_device_info = {
 static const struct kfd_device_info navi10_device_info = {
 	.asic_family = CHIP_NAVI10,
 	.asic_name = "navi10",
+	.gfx_version = 100100,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
@@ -456,6 +476,7 @@ static const struct kfd_device_info navi10_device_info = {
 static const struct kfd_device_info navi12_device_info = {
 	.asic_family = CHIP_NAVI12,
 	.asic_name = "navi12",
+	.gfx_version = 100101,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
@@ -474,6 +495,7 @@ static const struct kfd_device_info navi12_device_info = {
 static const struct kfd_device_info navi14_device_info = {
 	.asic_family = CHIP_NAVI14,
 	.asic_name = "navi14",
+	.gfx_version = 100102,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
@@ -492,6 +514,7 @@ static const struct kfd_device_info navi14_device_info = {
 static const struct kfd_device_info sienna_cichlid_device_info = {
 	.asic_family = CHIP_SIENNA_CICHLID,
 	.asic_name = "sienna_cichlid",
+	.gfx_version = 100300,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
@@ -510,6 +533,7 @@ static const struct kfd_device_info sienna_cichlid_device_info = {
 static const struct kfd_device_info navy_flounder_device_info = {
 	.asic_family = CHIP_NAVY_FLOUNDER,
 	.asic_name = "navy_flounder",
+	.gfx_version = 100301,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
@@ -528,6 +552,7 @@ static const struct kfd_device_info navy_flounder_device_info = {
 static const struct kfd_device_info vangogh_device_info = {
 	.asic_family = CHIP_VANGOGH,
 	.asic_name = "vangogh",
+	.gfx_version = 100303,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
@@ -546,6 +571,7 @@ static const struct kfd_device_info vangogh_device_info = {
 static const struct kfd_device_info dimgrey_cavefish_device_info = {
 	.asic_family = CHIP_DIMGREY_CAVEFISH,
 	.asic_name = "dimgrey_cavefish",
+	.gfx_version = 100302,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
@@ -564,6 +590,7 @@ static const struct kfd_device_info dimgrey_cavefish_device_info = {
 static const struct kfd_device_info beige_goby_device_info = {
 	.asic_family = CHIP_BEIGE_GOBY,
 	.asic_name = "beige_goby",
+	.gfx_version = 100305,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
@@ -582,6 +609,7 @@ static const struct kfd_device_info beige_goby_device_info = {
 static const struct kfd_device_info yellow_carp_device_info = {
 	.asic_family = CHIP_YELLOW_CARP,
 	.asic_name = "yellow_carp",
+	.gfx_version = 100303,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
@@ -600,6 +628,7 @@ static const struct kfd_device_info yellow_carp_device_info = {
 static const struct kfd_device_info cyan_skillfish_device_info = {
 	.asic_family = CHIP_CYAN_SKILLFISH,
 	.asic_name = "cyan_skillfish",
+	.gfx_version = 100103,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 8a5dfda224bf..eb4eab9a18e3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -196,6 +196,7 @@ struct kfd_event_interrupt_class {
 struct kfd_device_info {
 	enum amd_asic_type asic_family;
 	const char *asic_name;
+	uint32_t gfx_version;
 	const struct kfd_event_interrupt_class *event_interrupt_class;
 	unsigned int max_pasid_bits;
 	unsigned int max_no_of_hqd;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index ef992dd2da3a..6043b6e7b390 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -478,6 +478,8 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 			      dev->node_props.simd_per_cu);
 	sysfs_show_32bit_prop(buffer, offs, "max_slots_scratch_cu",
 			      dev->node_props.max_slots_scratch_cu);
+	sysfs_show_32bit_prop(buffer, offs, "gfx_version",
+			      dev->node_props.gfx_version);
 	sysfs_show_32bit_prop(buffer, offs, "vendor_id",
 			      dev->node_props.vendor_id);
 	sysfs_show_32bit_prop(buffer, offs, "device_id",
@@ -1360,6 +1362,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	dev->node_props.simd_arrays_per_engine =
 		cu_info.num_shader_arrays_per_engine;
 
+	dev->node_props.gfx_version = gpu->device_info->gfx_version;
 	dev->node_props.vendor_id = gpu->pdev->vendor;
 	dev->node_props.device_id = gpu->pdev->device;
 	dev->node_props.capability |=
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index 8b48c6692007..073567a2e0d2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -78,6 +78,7 @@ struct kfd_node_properties {
 	uint32_t simd_per_cu;
 	uint32_t max_slots_scratch_cu;
 	uint32_t engine_id;
+	uint32_t gfx_version;
 	uint32_t vendor_id;
 	uint32_t device_id;
 	uint32_t location_id;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
