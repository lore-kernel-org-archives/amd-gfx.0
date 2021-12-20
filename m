Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3740C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Dec 2021 03:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 103D410E13D;
	Mon, 20 Dec 2021 03:09:17 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2044.outbound.protection.outlook.com [40.107.212.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99C3910E13D
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Dec 2021 03:09:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igJIE2McyPy0YmbcQlSl0jVIZIK+UouesBqELyfsCuWX6CAxhHOTvocCIAPR9WDEbCkwEywnSk4meGfTFTfN/OrQbYmv7edXCvGlzbBXUmsrZrs7WqkPgt+YMCzA28yNFKZWFoO6/fPR210s56eJIKLXyUIjasseweIZ+4R3CjtH0EdJ7AoeyLWPb28epyYWgH9GPO/Lu7FdnyRBsVIlWGGuTIFYQlPkGmtnCk7RmjQa6rM8lc40vjGGhiVgfK24pzFRfDxyA7NZc9ANYxzVGIsDfNIYZ9gSllGru7sKF1CVdP+gXbbYDYKU9/fn9ENrwAbDxLDRCrlZrIhFtKqmRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYqeeArraGyYEvTGVLWnRzQyJdslX/CN2PMwnkM55Hs=;
 b=VpsgADUpjPixOxpwdqiE4KyYwqBaESHC+B4VBKB6n87HrWpmoMKfcAVCL24R2fjYMVutmGtYB5ikvjHmwSzOanSihHbXD95ql/VJ1f7VbGs9Z0WvsFbxgzfzV8wxtaG5As9cSoLD3xoL9b3ovdLmal37KdHIrtRPHEj9gtTdFggzKDcFGwQzxQKcG03WQlzIFRXpa9jCXKac/t0NFyBSnNQeEd3fwLOertbY4P7Evy21fwy8gCCAy7lGylwMQaulHML3RsVFQLVBb5diwbbMVq0PcYKpKU7ZiM+ZeTGSXz07xhYiphzuuAq//yLianhMN8og/Wsiv1rKvFOhhePMRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYqeeArraGyYEvTGVLWnRzQyJdslX/CN2PMwnkM55Hs=;
 b=iglU39ngQBKJ5DCftbBstC47BBbta25xh+xh4q4MxEZ4GDtaJOq9UP4EZGN8wQs2a0DtpYjQvTRTZSfBMTSLp5L6o5efFuQK/ghLg8okWZgCA3oVn8FicrD35OOBPekOBXlfFZ5FwdI55LXNq81l3VO7FrSQeO6zL8ssBCbvfEM=
Received: from DM5PR22CA0015.namprd22.prod.outlook.com (2603:10b6:3:101::25)
 by BN9PR12MB5275.namprd12.prod.outlook.com (2603:10b6:408:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.19; Mon, 20 Dec
 2021 03:09:10 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::e2) by DM5PR22CA0015.outlook.office365.com
 (2603:10b6:3:101::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Mon, 20 Dec 2021 03:09:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Mon, 20 Dec 2021 03:09:09 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 19 Dec 2021 21:09:04 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Graham.Sider@amd.com>, <Felix.Kuehling@amd.com>, <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: correct sdma queue number in kfd device init (v2)
Date: Mon, 20 Dec 2021 11:08:49 +0800
Message-ID: <20211220030849.32458-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6143735d-d46b-4e84-b95d-08d9c3661793
X-MS-TrafficTypeDiagnostic: BN9PR12MB5275:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5275C164E75BA9C0A8A5623DF17B9@BN9PR12MB5275.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kcHA6907koUh2TJIcTX2pW7gJxuBA68FpMz9P+gYZJp1O3S3LLCyVCcdCyx4S0gbVW1AtL8Vj63MmBLSn1U8/981vvloeQex4e+Zbh+PN091EZii02TI/gC8Z5z2f5U5oyPmjmLHznjXvp+TeUhm178fcvsrEYvpPrXj3Taj1/BjBq63+k7pO1mCjKbvdaVXesyLE5YH8F/fpwxAcSl7XRT0VX3aEuUjG7kE25VibFVFzOybj9CRmL2j+4Cl0VcAhSsAUj/rJYd0yEH1aaSrbtwKVgM6VR279cSYRaPAIg2b9ZrXSe53fEkw4B+JfgqxvMigm6XWqJFs69LFCidQm/7cpanG7pG7LVmm6iycrSI+8EzA3H4HbMMShw3SWhlnlTz/O/IR6KZMMaJHmn4wQr+bYVh/bFF/YUvWUrFvkk5LdoKUT8eVhqzkuxZdZUCS3s1yp7Z2cCK/UEsuHxnMjVuv38uRlIAEJAEfoh3X9cHOydFpxJaMBWwx2YJ62ZNrbAlFhYrGX4oRa+tW1wOxojIt1LrkCFB/gBohl9OlGPViWgC1GP559Z+u3znWSI8js8sD12zCPGoC1/zZ0Iz4AtwqGBAvCNbLn2YnNoxjP1wEDzxPz3N7LzCmI95GtDBDK99XtWTSR5OzxKkNvMIQRIfzKiveVllcvLMFZ3HgXvQzUJ4Q16srbjwtZzwCyGLNI8NZFp9QKiUOoN/JZsuCpyuL2NbfUu3iN9g/06ty57Ng9BNnZhmhOjFKZqwWVqT7agC5/dtRKKYubgYQRaymVZXpaRGE5LrX7d3d66rr3XPmYGXBg6HfdgIxWU+kta9a
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(47076005)(44832011)(316002)(86362001)(110136005)(356005)(83380400001)(186003)(508600001)(5660300002)(82310400004)(6666004)(26005)(7696005)(40460700001)(16526019)(6636002)(8936002)(8676002)(2616005)(70206006)(81166007)(36860700001)(70586007)(1076003)(4326008)(2906002)(426003)(36756003)(336012)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2021 03:09:09.8336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6143735d-d46b-4e84-b95d-08d9c3661793
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5275
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

v2: use dev_warn for the default switch case;
    set default sdma queue per engine(8) and IH handler to v9. (Jonathan)

Fixes: a9e2c4dc6cc4("drm/amdkfd: add kfd_device_info_init function")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 77 ++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index facc28f58c1f..36406a261203 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -59,11 +59,75 @@ static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
 
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
+			dev_warn(kfd_device,
+				"Default sdma queue per engine(8) is set due to "
+				"mismatch of sdma ip block(SDMA_HWIP:0x%x).\n",
+                                sdma_version);
+			kfd->device_info.num_sdma_queues_per_engine = 8;
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
+		dev_warn(kfd_device, "v9 event interrupt handler is set due to "
+			"mismatch of gc ip block(GC_HWIP:0x%x).\n", gc_version);
+		kfd->device_info.event_interrupt_class = &event_interrupt_class_v9;
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
@@ -75,16 +139,11 @@ static void kfd_device_info_init(struct kfd_dev *kfd,
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

