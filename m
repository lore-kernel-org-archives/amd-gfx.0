Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B61C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 14:31:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFAA9112749;
	Fri, 17 Dec 2021 14:31:27 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3470F112749
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 14:31:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4YJxTkAWrWbbLfsN/+tUAbNJyKmBqqd5+65r9qi0InZLgl6EBSBre1z6JazY3NkUghbaNveT8Emp49hXRaq0yds4AwG8kwnKgST5pm48qVfsTs2P0ioZIBGwZHOqCrCqncNkcwcjutujAzu86KE+N6H2d2kANHs7A3dGpekQpmOs3LMivgGu98gFNS7SzVb/saZomm/kOp1YypQGtvEyOJo/yCoUi8miqnChy59oPU4U7KYEsfw6CLunPmIyEcnjq+hLnzqfxCof5/Px74kLoGnUuLQ21eERHObRcchvvuSwAwwTMawBdFDmBzCf6vJRExpIm6D6Fe1qpLQ5S2osg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhnMZkbaSD1YhQFzyk32y65j32brLtm7OI1oHVYwQzs=;
 b=fPgMEyqcF0hw7rG0q62X6OI7F/J/ff2gb4Jwx2+P3T/QZWQiiYXIjskxPzmXV2YRyUqc8AmbrtEW99QmppnP7dYcjcansPaCkHSdE6Sb0G/q8xvSa/uzUEo4/KekIDfa20Si/tisKb4uWnhExupswoA9BErQy76ytCf8xobt24pp/P3ANTdU6KIF7FC8F1QgqSS4mdBsoXq4H07nDtyE1DlRJUtVSYLLBUbCql4VYS8LY3oWg9F3DSEUAhAjVqqv99cq01mt79VZMWRBOrtAQpZlFa+ERLyE9GQ59ZP/FFWfu/ATI58hKH8l0mFztdngJUVWKY6rs9j2dVn1RZ6hzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhnMZkbaSD1YhQFzyk32y65j32brLtm7OI1oHVYwQzs=;
 b=QemZHNHWzLOmp9uWbKDqBgeK1sKOBek3ywGX6/S9qqNFPEmqN1AxZ3o5SVohXKyDIpYJeHQqdNtSI3tWVxUTK1ispkANsg+S+9Us1RGns6vDhGWRgX3ROdWWOmdJ9UpiYJFNj2EKQ+EZwb1IX+UJT0u/nmn9dngYNSqjQ/GKUho=
Received: from DS7PR03CA0173.namprd03.prod.outlook.com (2603:10b6:5:3b2::28)
 by MWHPR12MB1775.namprd12.prod.outlook.com (2603:10b6:300:109::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 14:31:23 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::d3) by DS7PR03CA0173.outlook.office365.com
 (2603:10b6:5:3b2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Fri, 17 Dec 2021 14:31:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 14:31:23 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Dec 2021 08:31:21 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Graham.Sider@amd.com>, <Felix.Kuehling@amd.com>, <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: correct sdma queue number in kfd device init
Date: Fri, 17 Dec 2021 22:31:06 +0800
Message-ID: <20211217143106.14140-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e781f943-ab0d-4659-ed42-08d9c169e6a2
X-MS-TrafficTypeDiagnostic: MWHPR12MB1775:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1775801366864BF333954BD7F1789@MWHPR12MB1775.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vn5P/ird0B7PKPUeiECLGi6c7W2HjM1jwag5l7MmtAEBzNjMMtIPEF0ZGPNInNj4M3UtDD4/WC9+57rDeOINIc9hTp4Za2skBFr9Qbgrz9+e75TgrnV6maTL4DRGsYxc537fSCPyJQnnab3T6d49ivFqxUWld64hEj54s8Fitx8sCN/6QoYrKu2OkTuyXCrJVnylSeIQQ1o53I1X6W0KAiVSmbgGnB0N8klGM1kDbKUEPzbIyk8dc8fXrutb0Dd21E96QZvcokajYSRdrtX4sPV1duSzoB6Tzb6WZ5V8+0GHaSrtP8/Ed0sL+PJmT7sWcHJtK51F3+xy/gJOCz2HEbTItNMl87Ho+S4XIh5GMZ+I1Sb7+yrz5QGwcwC8MKrsqxMZMu4Yfsamhe7Cz3ZB9aH/wPmKnxxvENFn1sQZb4H0GiBPU7tSPJZr+2BP8EyzoerGI60XOf45TGKT7YCX4TCutWaqtK2XW0pq8igQ7Tf1GxjUZrQNjsvuWDCy6uTrPjTVT2IW4HhaBEmUdvUBhUvQGocn8ZxZIiJDIH9jLbfp7b0IZ1c4SBev6mSRyWikLnOSBBDX8JAfIYsj+enwb138KjnRlxJM6ai6x0O17FzGj2Z/yytEz1xOKDPxujFz0bnogQB/jzzUiMTgGvg4rNRC1xqXPys3sPmMCpOeQl7CxNysSV86Jf1I42c8Jut/clHYNDk2bUWh5DhrTdn/CzmH+Q12t/rMaWZeBZAMrcsux32Zy9nblAvGlRJTn70FA35n/crLYM3IHT5QzQC6Tap/LBKhMv8fsbeBjm4d7mRaJd43kr4Sv1toG7Owwan0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(7696005)(36756003)(508600001)(6666004)(70586007)(1076003)(6636002)(2906002)(26005)(81166007)(356005)(316002)(5660300002)(40460700001)(47076005)(70206006)(36860700001)(110136005)(82310400004)(86362001)(83380400001)(8936002)(2616005)(44832011)(4326008)(426003)(8676002)(336012)(16526019)(186003)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 14:31:23.4018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e781f943-ab0d-4659-ed42-08d9c169e6a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1775
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

sdma queue number is not correct like on vega20, this patch
promises the setting keeps the same after code refactor.
Additionally, improve code to use switch case to list IP
version to complete kfd device_info structure filling.
This keeps consistency with the IP parse code in amdgpu_discovery.c.

Fixes: a9e2c4dc6cc4("drm/amdkfd: add kfd_device_info_init function")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 74 ++++++++++++++++++++++---
 1 file changed, 65 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index facc28f58c1f..e50bf992f298 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -59,11 +59,72 @@ static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
 
 static int kfd_resume(struct kfd_dev *kfd);
 
+static void kfd_device_info_set_sdma_queue_num(struct kfd_dev *kfd)
+{
+	uint32_t sdma_version = kfd->adev->ip_versions[SDMA0_HWIP][0];
+
+	switch (sdma_version) {
+		case IP_VERSION(4, 0, 0):/* VEGA10 */
+		case IP_VERSION(4, 0, 1):/* VEGA12 */
+		case IP_VERSION(4, 1, 0):/* RAVEN */
+		case IP_VERSION(4, 1, 1):/* RAVEN */
+		case IP_VERSION(4, 1, 2):/* RENIOR */
+		case IP_VERSION(5, 2, 1):/* VANGOGH */
+		case IP_VERSION(5, 2, 3):/* YELLOW_CARP */
+			kfd->device_info.num_sdma_queues_per_engine = 2;
+			break;
+		case IP_VERSION(4, 2, 0):/* VEGA20 */
+		case IP_VERSION(4, 2, 2):/* ARCTUTUS */
+		case IP_VERSION(4, 4, 0):/* ALDEBARAN */
+		case IP_VERSION(5, 0, 0):/* NAVI10 */
+		case IP_VERSION(5, 0, 1):/* CYAN_SKILLFISH */
+		case IP_VERSION(5, 0, 2):/* NAVI14 */
+		case IP_VERSION(5, 0, 5):/* NAVI12 */
+		case IP_VERSION(5, 2, 0):/* SIENNA_CICHLID */
+		case IP_VERSION(5, 2, 2):/* NAVY_FLOUDER */
+		case IP_VERSION(5, 2, 4):/* DIMGREY_CAVEFISH */
+			kfd->device_info.num_sdma_queues_per_engine = 8;
+			break;
+		default:
+			dev_err(kfd_device,
+				"Failed to find sdma ip blocks(SDMA_HWIP:0x%x) in %s\n",
+                                sdma_version, __func__);
+	}
+}
+
+static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
+{
+	uint32_t gc_version = KFD_GC_VERSION(kfd);
+
+	switch (gc_version) {
+	case IP_VERSION(9, 0, 1): /* VEGA10 */
+	case IP_VERSION(9, 2, 1): /* VEGA12 */
+	case IP_VERSION(9, 3, 0): /* RENOIR */
+	case IP_VERSION(9, 4, 0): /* VEGA20 */
+	case IP_VERSION(9, 4, 1): /* ARCTURUS */
+	case IP_VERSION(9, 4, 2): /* ALDEBARAN */
+	case IP_VERSION(10, 3, 1): /* VANGOGH */
+	case IP_VERSION(10, 3, 3): /* YELLOW_CARP */
+	case IP_VERSION(10, 1, 3): /* CYAN_SKILLFISH */
+	case IP_VERSION(10, 1, 10): /* NAVI10 */
+	case IP_VERSION(10, 1, 2): /* NAVI12 */
+	case IP_VERSION(10, 1, 1): /* NAVI14 */
+	case IP_VERSION(10, 3, 0): /* SIENNA_CICHLID */
+	case IP_VERSION(10, 3, 2): /* NAVY_FLOUNDER */
+	case IP_VERSION(10, 3, 4): /* DIMGREY_CAVEFISH */
+	case IP_VERSION(10, 3, 5): /* BEIGE_GOBY */
+		kfd->device_info.event_interrupt_class = &event_interrupt_class_v9;
+		break;
+	default:
+		dev_err(kfd_device, "Failed to find gc ip blocks(GC_HWIP:0x%x) in %s\n",
+				gc_version, __func__);
+	}
+}
+
 static void kfd_device_info_init(struct kfd_dev *kfd,
 				 bool vf, uint32_t gfx_target_version)
 {
 	uint32_t gc_version = KFD_GC_VERSION(kfd);
-	uint32_t sdma_version = kfd->adev->ip_versions[SDMA0_HWIP][0];
 	uint32_t asic_type = kfd->adev->asic_type;
 
 	kfd->device_info.max_pasid_bits = 16;
@@ -75,16 +136,11 @@ static void kfd_device_info_init(struct kfd_dev *kfd,
 	if (KFD_IS_SOC15(kfd)) {
 		kfd->device_info.doorbell_size = 8;
 		kfd->device_info.ih_ring_entry_size = 8 * sizeof(uint32_t);
-		kfd->device_info.event_interrupt_class = &event_interrupt_class_v9;
 		kfd->device_info.supports_cwsr = true;
 
-		if ((sdma_version >= IP_VERSION(4, 0, 0)  &&
-		     sdma_version <= IP_VERSION(4, 2, 0)) ||
-		     sdma_version == IP_VERSION(5, 2, 1)  ||
-		     sdma_version == IP_VERSION(5, 2, 3))
-			kfd->device_info.num_sdma_queues_per_engine = 2;
-		else
-			kfd->device_info.num_sdma_queues_per_engine = 8;
+		kfd_device_info_set_sdma_queue_num(kfd);
+
+		kfd_device_info_set_event_interrupt_class(kfd);
 
 		/* Raven */
 		if (gc_version == IP_VERSION(9, 1, 0) ||
-- 
2.17.1

