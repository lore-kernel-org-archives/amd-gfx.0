Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4870C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 09:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 396B8611AE
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 09:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396B8611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADDE46ECF3;
	Wed, 19 May 2021 09:02:55 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2071.outbound.protection.outlook.com [40.107.101.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C7AE6ECF3
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 09:02:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bi9i0lV5U6miCizd96daSFRN94xjl5lolktZ7sWC/UN+DhF2uXImSgpagNf8uAFvmEOQNsqN22V7DC7KT2u66AoUgPJ4Mjpp3jNNzotFmM/ISOhSPmxND6i7Hen6K1WFu0kavPxnq5P4xpT+ScyqlFvRGczJBkulHI1QdL9Ub5rIaiqhzmh7HscDcOikmpINe9nnUDQ6GDnevqkKh9UsdX/70F5Jv37FG1rQ2Ztpc7niROcGMRl9hR+s/5Mh7pongWo8ovNCrG8AclJFdU8aLemqsb07LDO5MFqdDsoAD1sKP1gQB3HWryQMjFqOBCVo2uEho/3/PD4uh7fOB0Xu1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlMDKINw1jtV9Pi7ufcNyTv5rJWCvrIUOv1U3Bke7tQ=;
 b=O3U7xVtpOEY0hG2s3jwWqQB/gJZUX+tpMBqO88OGlHMGSOw9/GgRmJTEXxpJQDGwMKKgberFgZc7zjWjUcjDSWHiJ/hy7KXcot8MCQY2/XItBAjPb0LXPYj3ychbRK+KgGwErlGSSzsX6cS0xQNVi4v1Qw8KJTFFGZzaiAaHhhr0iP2nvXahHIiqZCvjQYLvaqy1myXAZfl/jLOAeROTpxeOS16AnV2RmBtrPs37j6VbqGaDs1llYkdyDe1IjztZOxpH2bBxsG5FSXHhOWVcJdCANA03yarZr5ru1srQ0axzP3u98HLPT1ezhaaYH1YJsLrOaC/x7Ewx1R1nladPqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlMDKINw1jtV9Pi7ufcNyTv5rJWCvrIUOv1U3Bke7tQ=;
 b=AKX1YKfLcRrAbq+D+sOuLxjcQD9HyJczQ1+0fI548rFfDQvjoQnqIphlUUpI8F0h8Jed92BVwKUOhzq6CJAnoexqFwRilfG+WLXIlk0JUcpwisMMkFEQ17A6y7OfwkmY0SgLokMo/q65TjLG6VNMqxmJBnQwJ0kbdnukB1gfQqs=
Received: from DM5PR13CA0003.namprd13.prod.outlook.com (2603:10b6:3:23::13) by
 CY4PR12MB1830.namprd12.prod.outlook.com (2603:10b6:903:127::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 09:02:52 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::c9) by DM5PR13CA0003.outlook.office365.com
 (2603:10b6:3:23::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11 via Frontend
 Transport; Wed, 19 May 2021 09:02:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Wed, 19 May 2021 09:02:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 19 May
 2021 04:02:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 19 May
 2021 04:02:50 -0500
Received: from chengzhe-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 19 May 2021 04:02:48 -0500
From: Chengzhe Liu <ChengZhe.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Disable cwsr for vega10 and Sienna_Cichlid in
 sriov
Date: Wed, 19 May 2021 17:02:42 +0800
Message-ID: <20210519090242.888065-1-ChengZhe.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22208c29-3fa5-40b6-7b47-08d91aa4e1f1
X-MS-TrafficTypeDiagnostic: CY4PR12MB1830:
X-Microsoft-Antispam-PRVS: <CY4PR12MB18304BC35964F6A5A7F5553F932B9@CY4PR12MB1830.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WmZsa6McbaMlDLsP6OE72PrBAz2OGt6kY/oEbnEdrfj7u9UJgUQRUUe70kguFfdcWHkYGNPQ7s0xH9Sy2sGUxuZ7jk8EgvjPj+VS1lafLDgWYLcAR78U89XK3o/1L0CtvLq3CT+JZ62Hdtzn9IRS5ogbxF8Od7qy0wS7+CUJA3oid9yw/pXH4mGhrd5h5+Wf0WAjy40Okck2a+ktt0L2LfGD+tkSZuU/AjYvX3qNu+CTTrjrJNjZFMRqAmQa5muBoLjj8oai5hO7gW6kHx1vyJRwCkR8LCNESBeXlAmq36YN1V0pzpYsdR8S4UokrvsYqOjAuxInUTSOtR3HJMXnHU7xUl1nGfaZ66jua8w8Tj2Qyx6HgculaArvOeZ68Pe5Bw66RvQRnGqIADGJoTr/NaYkjswsYU/LhrbCPt/LHhGCW3EedHUuFrQlI0p/9Gi759tpQZt3Hoi6cq6NKsSvFdU98Udfxh2Hq47kPleHxqX71qV4n1XV9oCB9Mv5PTEY5YCT0gl76JAZWTl4TPSLxul4jEb27V8GTVLfXmnwhibT62SqLp3NW5Vg5kyu90s56yVv3gV1amVF+ONhw5AdKQbTrJyplNSKUisD2TWJgPgI6dkE8g7q2y/u5Ake5H4Qk/agjJuucJo1RN7IXx8c55nxJOuLid8d358463A7BhWDbs4MYqfAGaS3+DNnL/xg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(46966006)(36840700001)(8936002)(54906003)(316002)(478600001)(81166007)(426003)(356005)(8676002)(82740400003)(86362001)(2616005)(36756003)(36860700001)(2906002)(26005)(5660300002)(4326008)(70206006)(70586007)(336012)(83380400001)(47076005)(1076003)(82310400003)(6666004)(186003)(7696005)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 09:02:51.6194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22208c29-3fa5-40b6-7b47-08d91aa4e1f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1830
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei
 Xu <Feifei.Xu@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>,
 Chengzhe Liu <ChengZhe.Liu@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In sriov, cwsr is not stable

Signed-off-by: Chengzhe Liu <ChengZhe.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 80015e866498..89bd0059329b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -335,7 +335,7 @@ static const struct kfd_device_info vega10_vf_device_info = {
 	.event_interrupt_class = &event_interrupt_class_v9,
 	.num_of_watch_points = 4,
 	.mqd_size_aligned = MQD_SIZE_ALIGNED,
-	.supports_cwsr = true,
+	.supports_cwsr = false,
 	.needs_iommu_device = false,
 	.needs_pci_atomics = false,
 	.num_sdma_engines = 2,
@@ -505,6 +505,24 @@ static const struct kfd_device_info sienna_cichlid_device_info = {
 	.num_sdma_queues_per_engine = 8,
 };
 
+static const struct kfd_device_info sienna_cichlid_vf_device_info = {
+	.asic_family = CHIP_SIENNA_CICHLID,
+	.asic_name = "sienna_cichlid",
+	.max_pasid_bits = 16,
+	.max_no_of_hqd  = 24,
+	.doorbell_size  = 8,
+	.ih_ring_entry_size = 8 * sizeof(uint32_t),
+	.event_interrupt_class = &event_interrupt_class_v10,
+	.num_of_watch_points = 4,
+	.mqd_size_aligned = MQD_SIZE_ALIGNED,
+	.needs_iommu_device = false,
+	.supports_cwsr = false,
+	.needs_pci_atomics = true,
+	.num_sdma_engines = 4,
+	.num_xgmi_sdma_engines = 0,
+	.num_sdma_queues_per_engine = 8,
+};
+
 static const struct kfd_device_info navy_flounder_device_info = {
 	.asic_family = CHIP_NAVY_FLOUNDER,
 	.asic_name = "navy_flounder",
@@ -601,7 +619,7 @@ static const struct kfd_device_info *kfd_supported_devices[][2] = {
 	[CHIP_NAVI10] = {&navi10_device_info, NULL},
 	[CHIP_NAVI12] = {&navi12_device_info, &navi12_device_info},
 	[CHIP_NAVI14] = {&navi14_device_info, NULL},
-	[CHIP_SIENNA_CICHLID] = {&sienna_cichlid_device_info, &sienna_cichlid_device_info},
+	[CHIP_SIENNA_CICHLID] = {&sienna_cichlid_device_info, &sienna_cichlid_vf_device_info},
 	[CHIP_NAVY_FLOUNDER] = {&navy_flounder_device_info, &navy_flounder_device_info},
 	[CHIP_VANGOGH] = {&vangogh_device_info, NULL},
 	[CHIP_DIMGREY_CAVEFISH] = {&dimgrey_cavefish_device_info, &dimgrey_cavefish_device_info},
@@ -674,7 +692,7 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
 
 static void kfd_cwsr_init(struct kfd_dev *kfd)
 {
-	if (cwsr_enable && kfd->device_info->supports_cwsr) {
+	if ((cwsr_enable && kfd->device_info->supports_cwsr) || cwsr_enable == 2) {
 		if (kfd->device_info->asic_family < CHIP_VEGA10) {
 			BUILD_BUG_ON(sizeof(cwsr_trap_gfx8_hex) > PAGE_SIZE);
 			kfd->cwsr_isa = cwsr_trap_gfx8_hex;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
