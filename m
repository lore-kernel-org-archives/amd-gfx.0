Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F34CC001DE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Aug 2023 05:01:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8156510E23E;
	Fri,  4 Aug 2023 05:01:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A47010E23E
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Aug 2023 05:01:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rwv9lOEsubAdwY7/Kqazrj89CxA1/roBPTHqYOgf3psw/d3K0/y+pzu4gcXQ3J36KaMyO3H+uZD0HCzMr0dZhyB5Q56LeCq3PfsDhOuQG/gnEkyDVQiOFzwmcVt7H5VCyupl6oJncdUhD9CbF2tEDZ3X/niVhu07mlFA0laHqiI42ecA9NngjvAL0nc6zUiohKqBmxwjNel/jevm47cHzbrbzCMGMMsrNMzOIQB2Wieli8bUlUG+iQNOAyHeg3ZZCfA2XQbJuWLCg3w0nWIkUPC5qWU5sgydAvP3sxS3y8u6nv9iZOKqHJvPrcv63AvI9KLmK8Dq+2+oXdYEyv73jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNEHypzNXqqNl3wyMklbyokz350+B3bM1w6JIUK9TEU=;
 b=IeE1oBvs8lWa0C8R1Uzj7GwAEuQfAdyHQjvFMuVfQGvXhH2CJIYEpYt9TMWKiU7uXZg+LSbo9ldXzVc/vsCwldrUFAWRximQs88XAxoEkwp8J1zA75oT+KHc7AmWLpSwNNq2Npif3cHhmOOO6rLBNS22Y3RGSXAtvl2qBTdkQgbijuAnMODF0O1PR6KVKQtSIcZ7mBUeJjRwJtMSLS6nmoMJeY/8+Nl0+HxlLskvws6IHkRX8V3QYC+4LTeFobdw6vi4y0kaoWH9dF4WaTZzfPindJAtL1mLCk7Mtry2GbcoJer7fi92r+1k2OaXQfGI7j//cj6gW5rb976doE6m6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNEHypzNXqqNl3wyMklbyokz350+B3bM1w6JIUK9TEU=;
 b=reh1dao3xp30KvcQz5RU7y4TA/aYyfXRhMEHZEouOIU9TsWEqLjTkBV6mWMa9tlRr+NV1K1ad8GIWb6nXU3wIdfe5dMaCy4fMWsV80ATVnLfkTSF023xWsKFJczBsOdcZtwOggv2JP78PaPC4WCh5izjdZpdqXOvEisv/F6i4lI=
Received: from MW4PR02CA0001.namprd02.prod.outlook.com (2603:10b6:303:16d::21)
 by MW6PR12MB8866.namprd12.prod.outlook.com (2603:10b6:303:24c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 05:01:11 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:303:16d:cafe::65) by MW4PR02CA0001.outlook.office365.com
 (2603:10b6:303:16d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 05:01:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Fri, 4 Aug 2023 05:01:10 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 00:01:05 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "drm/amdgpu: don't modify num_doorbells for mes"
Date: Fri, 4 Aug 2023 13:00:32 +0800
Message-ID: <20230804050032.2110016-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|MW6PR12MB8866:EE_
X-MS-Office365-Filtering-Correlation-Id: 140c474e-b5ee-4c29-43f8-08db94a7d22d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CqcAgJuHsryjv0pn2qEyM2Tnh2+6Kr0MbvUGc0gNfV0+yWYiO5LAMf7q5axV63K0XHxuj2SOowoOoV2ObvbEMXzXpqoA2k4U0KnCsEknNhL0iQ0ujFL5ym3d7h5TF0vua41Y/Euw17OGgIFpQFlRx67q0vFtduaVzpf9ljjEvvdOivxjNV27cPzWrJ1GPtyuXR3Vj4j+RioI5jrjAtra3LLNUUiKnE4xrNqLmx8VWy13pSGf7Q+iPfIZMy1kj0sn83VpFGkJJUcP6ARmpBw8PuEeK/GaoR/dNiLn0iGuczDuU0GtFgBGhwUM4GAzo1HDsLFix6TwwtsTsv8WMfSgg2VXIXOTRCCy78+hbfoffZtE2whGKkx1qI4DHLTjRSIrYeYpc+XwbQ5qlvIJhn2u6atQji3lbhu5nNVC9Nv7NFwSRGp87TzVukfScpetz1DS8YmRrsnBwj0ZkvAxVgQXrsLJbynCCF1pSgHmjyfMJ2Lc2sshfe4CIqDglZZ91oD9atR3Lgr43QNSBqFvp2s+5+xT9ZE0aQya5k5s64fDzveu02XEYrEnELWMelwDd8fnJCnsPW3j+M4QjkcQsIT00xxDofDmcjiBDaRutfXGrmzq93CnOhpRcjCTYCCQk8pDrOJJFsq/pKRz5Zi++wwlNs0xx2SMSyyVESZZQ/eBTAP4nSHTWSaekwXFsRuTugSS/uxRp19OgTgGYXCEOkwmmvnxorLNJ7VRxDRQmcALPrBaotEKtGP+zmejGQGqEcPF6uC2ub3+Dbp7LpfetyexFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(1800799003)(186006)(82310400008)(46966006)(36840700001)(40470700004)(40460700003)(16526019)(2616005)(426003)(1076003)(83380400001)(336012)(26005)(47076005)(8676002)(36860700001)(316002)(2906002)(70206006)(5660300002)(70586007)(6916009)(4326008)(41300700001)(8936002)(6666004)(7696005)(54906003)(478600001)(40480700001)(356005)(81166007)(86362001)(36756003)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 05:01:10.7969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 140c474e-b5ee-4c29-43f8-08db94a7d22d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8866
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 christian.koenig@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit f46644aa8de6d5efeff8d8c7fbf3ed58a89c765c.

THe doorbell index could go beyond the first page for mes queues,
this patch breaks the mes self test on gfx11.

[   23.212740] [drm] ring gfx_32768.1.1 was added
[   23.213147] [drm] ring compute_32768.2.2 was added
[   23.213540] [drm] ring sdma_32768.3.3 was added
[   23.213546] [drm:amdgpu_mm_wdoorbell64 [amdgpu]] *ERROR* writing beyond doorbell aperture: 0x00001000!
[   23.214148] amdgpu 0000:c2:00.0: amdgpu: gfx_v11_0_ring_set_wptr_gfx: 5168 0x402 0x1000 100
[   23.560357] amdgpu 0000:c2:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring gfx_32768.1.1 test failed (-110)

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 34 +++++++++++--------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
index 5c0d3cea817d..31db526d4921 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
@@ -140,21 +140,25 @@ int amdgpu_doorbell_init(struct amdgpu_device *adev)
 	adev->doorbell.base = pci_resource_start(adev->pdev, 2);
 	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
 
-	adev->doorbell.num_kernel_doorbells =
-		min_t(u32, adev->doorbell.size / sizeof(u32),
-		      adev->doorbell_index.max_assignment + 1);
-	if (adev->doorbell.num_kernel_doorbells == 0)
-		return -EINVAL;
-
-	/*
-	 * For Vega, reserve and map two pages on doorbell BAR since SDMA
-	 * paging queue doorbell use the second page. The
-	 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
-	 * doorbells are in the first page. So with paging queue enabled,
-	 * the max num_kernel_doorbells should + 1 page (0x400 in dword)
-	 */
-	if (adev->asic_type >= CHIP_VEGA10)
-		adev->doorbell.num_kernel_doorbells += 0x400;
+	if (adev->enable_mes) {
+		adev->doorbell.num_kernel_doorbells =
+			adev->doorbell.size / sizeof(u32);
+	} else {
+		adev->doorbell.num_kernel_doorbells =
+			min_t(u32, adev->doorbell.size / sizeof(u32),
+			      adev->doorbell_index.max_assignment+1);
+		if (adev->doorbell.num_kernel_doorbells == 0)
+			return -EINVAL;
+
+		/* For Vega, reserve and map two pages on doorbell BAR since SDMA
+		 * paging queue doorbell use the second page. The
+		 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
+		 * doorbells are in the first page. So with paging queue enabled,
+		 * the max num_kernel_doorbells should + 1 page (0x400 in dword)
+		 */
+		if (adev->asic_type >= CHIP_VEGA10)
+			adev->doorbell.num_kernel_doorbells += 0x400;
+	}
 
 	adev->doorbell.ptr = ioremap(adev->doorbell.base,
 				     adev->doorbell.num_kernel_doorbells *
-- 
2.37.3

