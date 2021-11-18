Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F2AC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 20:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05DC6610C8
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 20:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 05DC6610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63DCA6E853;
	Thu, 18 Nov 2021 20:19:03 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2086.outbound.protection.outlook.com [40.107.102.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D21D6E853
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 20:19:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dp11avvn3aqCAhRAYyslwdOQyohxIAMyLAow2cBd9jPrNTDy9dxr5/7JHkI2W61egw27OHmJvSFXb9TL9R+7OiQjjoGx/2EgySEvt+EaZWAiN9zG3k7Px//dJadQfKqzI9Xkv1eBbULMSbO88dxJFIE8zZ1Ylt3/XCbV+pwk109GrV5zifweBJcK5VNhKK1ONQo7YP8Qi1pUMv9szpB4GdySGQR2HzKQzcngaiXkTF9aUn4jPLq276YPnqzQY4hbVWLHAzw01e7p0DeyavsH5paSaB/TkuhHWfN8F2bLcTPW/mYuZXwFsp5EIXqnJFxF6lB1e2GLqxUOmGcJLVh83w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16ag9POaaZb61Y/niH1jFAl4xxZYs4s1/9sQmn4qe2Q=;
 b=N3XKkVYDJvvfndpy/hNPScaPyisQvCf5YWFC8tQvCKY60wC5MN+x38Oz4qcIy88Jl9sLQ5Zs6sXGQ+qLhiFHESc6/InHTF3LeJoQDeu3bcf+TAJ+ueuZZRlmqC3b3btDf0rab7Ezy8xA60zn2+aGA0Va/4azsEj5NcndsJyhlpYi8uk0msPuehOWR3PK9cujfmfo9BppPuo4ZsHKx5rdXpxbjwo/n0AKXSK0ttqEJkojjKyAkPvnkoR21Y7AFv6Sztc6AyLC2HLMRS0bmxosoF1fUOKhq8ilQcDLstPE4Dj52fVoCMbQqsxOnIum3ElENNF1+GOiI+z57khPWXqXeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16ag9POaaZb61Y/niH1jFAl4xxZYs4s1/9sQmn4qe2Q=;
 b=HNAZrIDuleH27bpVh9GfmLaOJwiPlWdVrvfUA90rA1dsNlaGCJeRuli9KgYsvXlWIalAg625l0Yf0HsXXO6820dfDLdRZYiNh0EvhLjJoRQrObQwu2+aT/C5B45Jlergq/BnkiQVthiDdGSvYY9zVYgHjjxqT4NixJeEbsJ+GOg=
Received: from MW4PR03CA0259.namprd03.prod.outlook.com (2603:10b6:303:b4::24)
 by BYAPR12MB2615.namprd12.prod.outlook.com (2603:10b6:a03:61::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Thu, 18 Nov
 2021 20:18:59 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::b9) by MW4PR03CA0259.outlook.office365.com
 (2603:10b6:303:b4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Thu, 18 Nov 2021 20:18:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Thu, 18 Nov 2021 20:18:58 +0000
Received: from alin.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 18 Nov
 2021 14:18:57 -0600
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Remove unused entries in table
Date: Thu, 18 Nov 2021 15:18:39 -0500
Message-ID: <20211118201839.22284-1-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08cadc75-764f-40fa-6cd6-08d9aad0a72f
X-MS-TrafficTypeDiagnostic: BYAPR12MB2615:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2615735B0B194CE0E26813EFE19B9@BYAPR12MB2615.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:586;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7B3fxcJctMW7rK0mv3PVEXmjIzfoa6MhKjgQTEEq8KGm290YHTs8WiYmobjRhvEzr0tjPOfXIqkn5AzZjfD4TnURXlJDt7AJm6Vo02//j2BN/xw8RyX2rPKGC+BTrvaZabG9C36kS6wJf4Fhlk2CpsYFTHmE4/OcnHIxHV2XStSKSWABXFXqZRPuSVQTyqaiuI2HKoUSYHWeG57SUIQTVGCJ1aHE2kCtk5H7b4zyqKpWq4B5kOP5aATAd362AW4pCzgbp4ISsk1Z5InTzqNJPqBf5p6LtlF63qzazODQgU43sh/ffGm83xvzg/wjBT8e5RucUMlNwlYZSktVq1Oq3JqqALZEvvAZDT+mEdlO9GEzy2dcbhj+7vhGXjNgznHrjaQjnHMQ0/CUTtRudnMbYAQN8LsRocgVnkYJcOta+8/GjAtGm5NZrLgc+f4A/eY8XMOYxNzE4/+L8VIc5QLPn0H4JqDDJb724UdcTF2tLK+EkR+YufQla6zgouyDv/5uADv79BSMJu9Uuqtym0WULDok73IuXnyh1OOXNG5tdiisd6Rq4ImdziiX2hbUu7DwYQ83ezz5txx921W07d4nuUPxKPM8YyE/apsSWNZbKipYMA6ijNb/3gVmHUWwMvLwEsMKcP5+2yTxVPBxpt6YWm6jKDMpTwCBLpCu4I1bYp38w1vZIFLKNq4H+IPxHNIB47eIRA3mOaCdGkA5WyJ1LKaAdvkDOK5pYOeto7Idi1w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2616005)(36756003)(47076005)(8676002)(8936002)(86362001)(70206006)(26005)(426003)(2906002)(6916009)(336012)(83380400001)(316002)(36860700001)(4326008)(7696005)(5660300002)(356005)(186003)(508600001)(82310400003)(1076003)(6666004)(16526019)(70586007)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 20:18:58.2909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08cadc75-764f-40fa-6cd6-08d9aad0a72f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2615
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
Cc: Amber Lin <Amber.Lin@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove unused entries in kfd_device_info table: num_xgmi_sdma_engines
and num_sdma_queues_per_engine. They are calculated in
kfd_get_num_sdma_engines and kfd_get_num_xgmi_sdma_engines instead.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 58 -------------------------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h   |  2 -
 2 files changed, 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 3fea47e37c17..e1294fba0c26 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -68,8 +68,6 @@ static const struct kfd_device_info kaveri_device_info = {
 	.supports_cwsr = false,
 	.needs_iommu_device = true,
 	.needs_pci_atomics = false,
-	.num_sdma_engines = 2,
-	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
 };
 
@@ -87,8 +85,6 @@ static const struct kfd_device_info carrizo_device_info = {
 	.supports_cwsr = true,
 	.needs_iommu_device = true,
 	.needs_pci_atomics = false,
-	.num_sdma_engines = 2,
-	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
 };
 
@@ -105,8 +101,6 @@ static const struct kfd_device_info raven_device_info = {
 	.supports_cwsr = true,
 	.needs_iommu_device = true,
 	.needs_pci_atomics = true,
-	.num_sdma_engines = 1,
-	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
 };
 #endif
@@ -126,8 +120,6 @@ static const struct kfd_device_info hawaii_device_info = {
 	.supports_cwsr = false,
 	.needs_iommu_device = false,
 	.needs_pci_atomics = false,
-	.num_sdma_engines = 2,
-	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
 };
 #endif
@@ -145,8 +137,6 @@ static const struct kfd_device_info tonga_device_info = {
 	.supports_cwsr = false,
 	.needs_iommu_device = false,
 	.needs_pci_atomics = true,
-	.num_sdma_engines = 2,
-	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
 };
 
@@ -163,8 +153,6 @@ static const struct kfd_device_info fiji_device_info = {
 	.supports_cwsr = true,
 	.needs_iommu_device = false,
 	.needs_pci_atomics = true,
-	.num_sdma_engines = 2,
-	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
 };
 
@@ -181,8 +169,6 @@ static const struct kfd_device_info fiji_vf_device_info = {
 	.supports_cwsr = true,
 	.needs_iommu_device = false,
 	.needs_pci_atomics = false,
-	.num_sdma_engines = 2,
-	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
 };
 
@@ -200,8 +186,6 @@ static const struct kfd_device_info polaris10_device_info = {
 	.supports_cwsr = true,
 	.needs_iommu_device = false,
 	.needs_pci_atomics = true,
-	.num_sdma_engines = 2,
-	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
 };
 
@@ -218,8 +202,6 @@ static const struct kfd_device_info polaris10_vf_device_info = {
 	.supports_cwsr = true,
 	.needs_iommu_device = false,
 	.needs_pci_atomics = false,
-	.num_sdma_engines = 2,
-	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
 };
 
@@ -236,8 +218,6 @@ static const struct kfd_device_info polaris11_device_info = {
 	.supports_cwsr = true,
 	.needs_iommu_device = false,
 	.needs_pci_atomics = true,
-	.num_sdma_engines = 2,
-	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
 };
 
@@ -254,8 +234,6 @@ static const struct kfd_device_info polaris12_device_info = {
 	.supports_cwsr = true,
 	.needs_iommu_device = false,
 	.needs_pci_atomics = true,
-	.num_sdma_engines = 2,
-	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
 };
 
@@ -272,8 +250,6 @@ static const struct kfd_device_info vegam_device_info = {
 	.supports_cwsr = true,
 	.needs_iommu_device = false,
 	.needs_pci_atomics = true,
-	.num_sdma_engines = 2,
-	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
 };
 
@@ -290,8 +266,6 @@ static const struct kfd_device_info vega10_device_info = {
 	.supports_cwsr = true,
 	.needs_iommu_device = false,
 	.needs_pci_atomics = false,
-	.num_sdma_engines = 2,
-	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
 };
 
@@ -308,8 +282,6 @@ static const struct kfd_device_info vega10_vf_device_info = {
 	.supports_cwsr = true,
 	.needs_iommu_device = false,
 	.needs_pci_atomics = false,
-	.num_sdma_engines = 2,
-	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
 };
 
@@ -326,8 +298,6 @@ static const struct kfd_device_info vega12_device_info = {
 	.supports_cwsr = true,
 	.needs_iommu_device = false,
 	.needs_pci_atomics = false,
-	.num_sdma_engines = 2,
-	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
 };
 
@@ -344,8 +314,6 @@ static const struct kfd_device_info vega20_device_info = {
 	.supports_cwsr = true,
 	.needs_iommu_device = false,
 	.needs_pci_atomics = false,
-	.num_sdma_engines = 2,
-	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 8,
 };
 
@@ -362,8 +330,6 @@ static const struct kfd_device_info arcturus_device_info = {
 	.supports_cwsr = true,
 	.needs_iommu_device = false,
 	.needs_pci_atomics = false,
-	.num_sdma_engines = 2,
-	.num_xgmi_sdma_engines = 6,
 	.num_sdma_queues_per_engine = 8,
 };
 
@@ -380,8 +346,6 @@ static const struct kfd_device_info aldebaran_device_info = {
 	.supports_cwsr = true,
 	.needs_iommu_device = false,
 	.needs_pci_atomics = false,
-	.num_sdma_engines = 2,
-	.num_xgmi_sdma_engines = 3,
 	.num_sdma_queues_per_engine = 8,
 };
 
@@ -398,8 +362,6 @@ static const struct kfd_device_info renoir_device_info = {
 	.supports_cwsr = true,
 	.needs_iommu_device = false,
 	.needs_pci_atomics = false,
-	.num_sdma_engines = 1,
-	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
 };
 
@@ -417,8 +379,6 @@ static const struct kfd_device_info navi10_device_info = {
 	.supports_cwsr = true,
 	.needs_pci_atomics = true,
 	.no_atomic_fw_version = 145,
-	.num_sdma_engines = 2,
-	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 8,
 };
 
@@ -436,8 +396,6 @@ static const struct kfd_device_info navi12_device_info = {
 	.supports_cwsr = true,
 	.needs_pci_atomics = true,
 	.no_atomic_fw_version = 145,
-	.num_sdma_engines = 2,
-	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 8,
 };
 
@@ -455,8 +413,6 @@ static const struct kfd_device_info navi14_device_info = {
 	.supports_cwsr = true,
 	.needs_pci_atomics = true,
 	.no_atomic_fw_version = 145,
-	.num_sdma_engines = 2,
-	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 8,
 };
 
@@ -474,8 +430,6 @@ static const struct kfd_device_info sienna_cichlid_device_info = {
 	.supports_cwsr = true,
 	.needs_pci_atomics = true,
 	.no_atomic_fw_version = 92,
-	.num_sdma_engines = 4,
-	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 8,
 };
 
@@ -493,8 +447,6 @@ static const struct kfd_device_info navy_flounder_device_info = {
 	.supports_cwsr = true,
 	.needs_pci_atomics = true,
 	.no_atomic_fw_version = 92,
-	.num_sdma_engines = 2,
-	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 8,
 };
 
@@ -512,8 +464,6 @@ static const struct kfd_device_info vangogh_device_info = {
 	.supports_cwsr = true,
 	.needs_pci_atomics = true,
 	.no_atomic_fw_version = 92,
-	.num_sdma_engines = 1,
-	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
 };
 
@@ -531,8 +481,6 @@ static const struct kfd_device_info dimgrey_cavefish_device_info = {
 	.supports_cwsr = true,
 	.needs_pci_atomics = true,
 	.no_atomic_fw_version = 92,
-	.num_sdma_engines = 2,
-	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 8,
 };
 
@@ -550,8 +498,6 @@ static const struct kfd_device_info beige_goby_device_info = {
 	.supports_cwsr = true,
 	.needs_pci_atomics = true,
 	.no_atomic_fw_version = 92,
-	.num_sdma_engines = 1,
-	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 8,
 };
 
@@ -569,8 +515,6 @@ static const struct kfd_device_info yellow_carp_device_info = {
 	.supports_cwsr = true,
 	.needs_pci_atomics = true,
 	.no_atomic_fw_version = 92,
-	.num_sdma_engines = 1,
-	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
 };
 
@@ -587,8 +531,6 @@ static const struct kfd_device_info cyan_skillfish_device_info = {
 	.needs_iommu_device = false,
 	.supports_cwsr = true,
 	.needs_pci_atomics = true,
-	.num_sdma_engines = 2,
-	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 8,
 };
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 1054fedd7b3c..836ec8860c1b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -208,8 +208,6 @@ struct kfd_device_info {
 	bool needs_iommu_device;
 	bool needs_pci_atomics;
 	uint32_t no_atomic_fw_version;
-	unsigned int num_sdma_engines;
-	unsigned int num_xgmi_sdma_engines;
 	unsigned int num_sdma_queues_per_engine;
 };
 
-- 
2.17.1

