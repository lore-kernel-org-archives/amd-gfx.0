Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AE9C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 20:20:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E71810E62E;
	Tue, 11 Jan 2022 20:20:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D02BE10E62E
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 20:20:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9XNFS7nx1o2moQvfx3GxNebpz4KX3KDyW9qtFWvcXy/OgZKrRBUI5sAbTyK6SH7/1c+8ilzmKtKWTFRgwd8bYhmylqlCDYtcYdGK3kYohlC15vbXDK1eWT4AB7GSC8+z3pCJ1Mkw2KxvgueTpXcRY5LxqVIh3mQRW68qPacTUkEVtV9/z9eD0VXXgBKgNyfIjnwoFCVu3md+/jW/50+SS+keQiqsUVK0qbQm22eNocMplSIw9NKHj+Bj+vcaCnEeQgh+fMbW7D9UoKi7dh3DuWIe5YJcwLaf97l5MnWAyTWGb72HBxALx+vgObgRTzuyg5UuQffngTfbrFSrZAd1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5okgRTKSg5NTilMR82AQXoQViRvJ3kZVuwvwk0bNXsQ=;
 b=LaGYbx0j/M4sUu34hrd6cuXq359JqxAJ3JGhzIxWQG8AA02DX+HcHB5e2waPMjqlA2HzCeXbgYwFGHndYPo/0DQI6ZyoljM2/L5nWKu70OYwgvHEMFqR7/jKjXgfMLlOg4dZxs85UYhX8/sFfPMFs07IdDFjuT/Jj8csyNFibY5/ttAvE08uAToyVmNfqnuhRLzpLv4z7leFGIkAskNg9BKx/5CoBEsLZGV5yFi/9wcZS6DMeQGAe8QVgvXNEzf8048yLLcVfPVGUKZ2+1k1ykc77r4PLJCv99W9OxV+K4vwzHj+DsNgwGB1D7NHcIt4seEHdHDH+oWf9C/6O/eIMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5okgRTKSg5NTilMR82AQXoQViRvJ3kZVuwvwk0bNXsQ=;
 b=bwCDuIVb+0g81iqLiZ2TGUE8HS9QmH6s19MX09eebIhivv9tPDSlKrQmFMazRHDJe265HX5FgEdw2D3ZMl2qooqGDvMd3O5F/MT5+taUAWFysJ38851yHfIjCkJFN2JDYTUhnnSLwZeE4S/5Nt5W4P/p5hRcWWYm3Vh6raS1yB0=
Received: from MW4PR03CA0241.namprd03.prod.outlook.com (2603:10b6:303:b4::6)
 by DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 20:20:04 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::c) by MW4PR03CA0241.outlook.office365.com
 (2603:10b6:303:b4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10 via Frontend
 Transport; Tue, 11 Jan 2022 20:20:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Tue, 11 Jan 2022 20:20:03 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 11 Jan
 2022 14:20:01 -0600
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix indentation on switch statement
Date: Tue, 11 Jan 2022 15:19:02 -0500
Message-ID: <20220111201902.902923-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46ef181d-4d42-4a5c-d421-08d9d53fc0a2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB48771619074FC498202BE2008A519@DM6PR12MB4877.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:486;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oe7TvcqP/IS/KUcnIUIFWO0TyeFn+DUIUox4U+9Ugra/DH5j4m6Z0p8m7OhlTza6ui/5ug+cZlNoLOD5f1AyO+3YDZV8r1Wgh2Orh6CmsWU15lgwurP3nj/jILe7x8PVUslbUtodgemaXJ6rN3JRxAnW+0DCzt1qT/STW/H7K4+mYedYEa2WRaOx0hR/Of7yER6rQFGL2pBekj2rEZ04Y34Nf66f6Z4/gxsdlAbNUU+27gKOnIwr3LIB8+doSioz31wuFzsyNt8TjpdBx/ksmgZ+w4zgyRCMykv1Tx5gK0hcnY2zricoLRc8BMgn/XjFJXGvAjS/i9ErJdEC1pok1PdD780ZtaRitBY+P1L/1BBURopXfq69yBx4YbsOCnh2JfkMJMyAJqWKC3HEQxFvNMkHgoDu+aHikE/UHaQDpTBH1KOJpdkJu66TE/xRIcUbO7RBa3HyhwKL5wxGum5FItuXVWwDklRiPZ2Y6BGhaE6akcsBfiAncqq2nFC2n/zmdOyLePiOX3+BFgsoOCKLsM9Kjr6KMBWbRfBwpUUjdBMcWptaHVtCU0UITLmEsiz2k3ytdUo3/kl7YFLkqO3wwzzp/15AGJ0/69lQnTHWvyfqNuui9Q4Rxi93JQ88lToIf0ZjdqO0kYp5dEMH/g986lT7Wd5h9xgO7FwIejnR2neGhrLTfgNdNGKD6Vi0oyOYrz54WJsoSH6mDWgjGPnbIqt6nCxsY+v+tOSK+iMH1DUc7zI/Jni+U9MBmxKh46fxtP6NR8vYjN+l/5F3fpSrOkIqrswv+1YpaPoezDdc28U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(82310400004)(4326008)(86362001)(2616005)(40460700001)(316002)(1076003)(356005)(336012)(83380400001)(2906002)(26005)(81166007)(47076005)(508600001)(7696005)(6916009)(16526019)(36860700001)(186003)(70586007)(70206006)(8936002)(426003)(8676002)(5660300002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 20:20:03.9625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ef181d-4d42-4a5c-d421-08d9d53fc0a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4877
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
Cc: Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Cases should be same indentation as switch. Also fix string spanning
across multiple lines.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 55 ++++++++++++-------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 2b65d0acae2c..5a47f437b455 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -64,34 +64,33 @@ static void kfd_device_info_set_sdma_queue_num(struct kfd_dev *kfd)
 	uint32_t sdma_version = kfd->adev->ip_versions[SDMA0_HWIP][0];
 
 	switch (sdma_version) {
-		case IP_VERSION(4, 0, 0):/* VEGA10 */
-		case IP_VERSION(4, 0, 1):/* VEGA12 */
-		case IP_VERSION(4, 1, 0):/* RAVEN */
-		case IP_VERSION(4, 1, 1):/* RAVEN */
-		case IP_VERSION(4, 1, 2):/* RENOIR */
-		case IP_VERSION(5, 2, 1):/* VANGOGH */
-		case IP_VERSION(5, 2, 3):/* YELLOW_CARP */
-			kfd->device_info.num_sdma_queues_per_engine = 2;
-			break;
-		case IP_VERSION(4, 2, 0):/* VEGA20 */
-		case IP_VERSION(4, 2, 2):/* ARCTURUS */
-		case IP_VERSION(4, 4, 0):/* ALDEBARAN */
-		case IP_VERSION(5, 0, 0):/* NAVI10 */
-		case IP_VERSION(5, 0, 1):/* CYAN_SKILLFISH */
-		case IP_VERSION(5, 0, 2):/* NAVI14 */
-		case IP_VERSION(5, 0, 5):/* NAVI12 */
-		case IP_VERSION(5, 2, 0):/* SIENNA_CICHLID */
-		case IP_VERSION(5, 2, 2):/* NAVY_FLOUNDER */
-		case IP_VERSION(5, 2, 4):/* DIMGREY_CAVEFISH */
-		case IP_VERSION(5, 2, 5):/* BEIGE_GOBY */
-			kfd->device_info.num_sdma_queues_per_engine = 8;
-			break;
-		default:
-			dev_warn(kfd_device,
-				"Default sdma queue per engine(8) is set due to "
-				"mismatch of sdma ip block(SDMA_HWIP:0x%x).\n",
-                                sdma_version);
-			kfd->device_info.num_sdma_queues_per_engine = 8;
+	case IP_VERSION(4, 0, 0):/* VEGA10 */
+	case IP_VERSION(4, 0, 1):/* VEGA12 */
+	case IP_VERSION(4, 1, 0):/* RAVEN */
+	case IP_VERSION(4, 1, 1):/* RAVEN */
+	case IP_VERSION(4, 1, 2):/* RENOIR */
+	case IP_VERSION(5, 2, 1):/* VANGOGH */
+	case IP_VERSION(5, 2, 3):/* YELLOW_CARP */
+		kfd->device_info.num_sdma_queues_per_engine = 2;
+		break;
+	case IP_VERSION(4, 2, 0):/* VEGA20 */
+	case IP_VERSION(4, 2, 2):/* ARCTURUS */
+	case IP_VERSION(4, 4, 0):/* ALDEBARAN */
+	case IP_VERSION(5, 0, 0):/* NAVI10 */
+	case IP_VERSION(5, 0, 1):/* CYAN_SKILLFISH */
+	case IP_VERSION(5, 0, 2):/* NAVI14 */
+	case IP_VERSION(5, 0, 5):/* NAVI12 */
+	case IP_VERSION(5, 2, 0):/* SIENNA_CICHLID */
+	case IP_VERSION(5, 2, 2):/* NAVY_FLOUNDER */
+	case IP_VERSION(5, 2, 4):/* DIMGREY_CAVEFISH */
+	case IP_VERSION(5, 2, 5):/* BEIGE_GOBY */
+		kfd->device_info.num_sdma_queues_per_engine = 8;
+		break;
+	default:
+		dev_warn(kfd_device,
+			"Default sdma queue per engine(8) is set due to mismatch of sdma ip block(SDMA_HWIP:0x%x).\n",
+			sdma_version);
+		kfd->device_info.num_sdma_queues_per_engine = 8;
 	}
 }
 
-- 
2.25.1

