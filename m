Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2382EC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Dec 2021 06:16:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B91610E217;
	Mon, 20 Dec 2021 06:16:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BDEF10E861
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Dec 2021 06:16:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fG0JyHvcWy+aW7zhTBdQK29ea78YdN+7P87pHHuh7rBZXeaSTMt0xyDz3wxnozO1wjvtr7+CveoQAkxavfDqYSYwjPow3PbQP1znv0JIikruDTl1GTzTWPgcxzHuzqBxHKaag4p6G0RSn4JIv7yczdMGcpdKJ/UY3pHq7P26eAbIB/4iE/r5UxfAfj24tG8zIPYBMJAiaiojYNXVrr9woVf/Arqu7FCcDuk17nN55Z18avre1IFI+Tud7OB9+wiJnPvafoCWJpuSK2Hkjm/cPMrQ/ymUa6AhzWpBWqOGOQmDpsoPN2iROQGxEaoBHegP5m2zJB+qTcMf7QoW8aQsoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DiTVuPyopi28k4tNvd+Ehi574mAM1Sjx+WGvvmEKrNc=;
 b=JC7GgmDbxbFrPYnCgVCZwhOJwApTRwn4+68hcnvR1NHM+J+VAOjUO3ssBGq6MtmzhFkcMVzwRwXQeSvddB+nZU72FsaS2MDIr3WOvupTi92yU4ck82NCETtp115+j4eW3lArfi2uZ9559yZDp1GjeDN3PB3VpEQUCiVxbRUYLPguuZYuVXC/MCbs17Q7mmqIsHoGRQ4L5+vcfeRg8JgtaB04Da6mJ1xGPm0BBxt0nkrW/xsXyDYaP6HywzAo5TTm2JrXUb10bmnamZEylpAJd+129lsCdIdKJF4tF+6+SZcrWyOiuHu37SS9BS7Ddy68w/ObIV4pv43lMuFQV0qkGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiTVuPyopi28k4tNvd+Ehi574mAM1Sjx+WGvvmEKrNc=;
 b=JKvVxPjctjAqq9QTSzuJ2Y4fSMHK92iQznb9NI5Bp1QC7D5sJUrsxNiW8CqK/RixI/HIOh4eLQ2bmifmCby9FapaT7I/jxNRfxCt8IxxHEyDMfalpzUdV37Do02VCn47vStBxoozIHhH8nHPEYwEcy9ijqblKwc10V7Vb+SfrWg=
Received: from MWHPR22CA0006.namprd22.prod.outlook.com (2603:10b6:300:ef::16)
 by CY4PR1201MB0184.namprd12.prod.outlook.com (2603:10b6:910:1d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.19; Mon, 20 Dec
 2021 06:16:17 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::7c) by MWHPR22CA0006.outlook.office365.com
 (2603:10b6:300:ef::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Mon, 20 Dec 2021 06:16:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Mon, 20 Dec 2021 06:16:16 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 20 Dec 2021 00:16:14 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Graham.Sider@amd.com>, <Felix.Kuehling@amd.com>, <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: correct sdma queue number in kfd device init (v3)
Date: Mon, 20 Dec 2021 14:16:02 +0800
Message-ID: <20211220061602.4320-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dd192a4-a91b-41e7-a8f1-08d9c3803b7b
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0184:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB018499EF9F669A059FA2704FF17B9@CY4PR1201MB0184.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zz94cTtxujntyr/0o/+tPj39mbsbtaN+x+zJHmvPT2Fp6JnCxejcUMTEw581Fg2f5/Xw5mFkb6aoCjZiepi95OzHE+vTgJf7yDqZlGv3gDc/iWYoR2i9pKZGnwlE1zoeSgefZJari/WzREfagk2/N2u33h1aUpzf6lxHrnqw4wsJfzRdKtEnakia826Q2kWPImwVAwEx1wxzkM6usyfrPPhmqQdUzDsASudO/QLivQHv2U9DjofHJ0AvMxDVpovAoHB56787iIzKy5vWMjcjkV57sUveqAgwyiCGfHCcTYIm1n1GxMuvX8NE8Y0PCiqBH0xLbor603BkGX6r5BxH3hVkQVpXPtMixdYF/unrVISX2WLgnofTRfw5Ee9UKGgnohT9o/zceJ7srEQUAan6U4x5f8fthDc8OLJODd3w4zHQ07O8XbmQMpBuJopkjjbH/9/GoSpOuVTGJ0L6oZu1f3YtQ8b+7FnkZor7RjqvJki3ZGe6ASfu90PalJQ6/Q7fBTYn2LEfX9OdToUZyHNfJ3VyKbjkXogc14MTaH5TpEjkPRPq5sXhosG73mY61DdbJ3CgMSwjQZTEUl1AaFojW8L/lQI80zowCukjWYyMBlgxbnICeQmCHN7iMvWQbvaow/acxSCAs8U8meobtPEI4JHL1Dlr5fGUvx+oaETxM19xAHtjN79vKSTaNdf7GABgd0hEY2+jXGmMpUo1voH4TS3iA+WhcOQ/ct9lLBRXrKBWi0WmGr1TVwJqRjN/nuPH7D5Uv8q+5uhmkUDWDqFrDNyZmZqWMsasfCscy9/12FWxhP4gMz4Uas2H5pdNtNVF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(110136005)(426003)(2616005)(6666004)(336012)(44832011)(47076005)(316002)(186003)(16526019)(1076003)(5660300002)(26005)(7696005)(4326008)(36860700001)(70206006)(508600001)(70586007)(8936002)(6636002)(36756003)(2906002)(40460700001)(83380400001)(82310400004)(86362001)(356005)(81166007)(8676002)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2021 06:16:16.9419 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd192a4-a91b-41e7-a8f1-08d9c3803b7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0184
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

This patch keeps the setting of sdma queue number to the same
after recent KFD code refactor. Additionally, improve code to
use switch case to list IP version to complete kfd device_info
structure filling for IH version assignment. This makes consistency
with the IP parse code in amdgpu_discovery.c.

v2: use dev_warn for the default switch case;
    set default sdma queue per engine(8) and IH handler to v9. (Jonathan)

v3: Fix missed IP version check of Raven.

Fixes: a9e2c4dc6cc4("drm/amdkfd: add kfd_device_info_init function")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 80 ++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index facc28f58c1f..127d41d0e4f0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -59,11 +59,78 @@ static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
 
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
+		case IP_VERSION(5, 2, 5):/* BEIGE_GOBY */
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
+	case IP_VERSION(9, 1, 0): /* RAVEN */
+	case IP_VERSION(9, 2, 1): /* VEGA12 */
+	case IP_VERSION(9, 2, 2): /* RAVEN */
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
@@ -75,16 +142,11 @@ static void kfd_device_info_init(struct kfd_dev *kfd,
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

