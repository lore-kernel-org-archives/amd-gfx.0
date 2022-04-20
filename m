Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C6EC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 03:53:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7EAA10F12E;
	Wed, 20 Apr 2022 03:53:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D23D10F12E
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 03:53:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BO7QNdFcwAB5/J8RuL89FGWixH//rQzuqqXUsTYWwy5tFP9R6vYIib2sHR/LWWK168EWQH8YKA/mxh8Yl8o6hxzbSeWcW4dYubVUhianbmA6Keln8tD6uLynAUd1DoONsJtJ/SQo0/81GGmwsrmQedHYQwKXDaH/OmG/yyMBkOJhbenAzFp5HU3WAnUNFPsfmXzb+lfqGXXHP7oaLlryxMHDh8OQA8+ljs/OJknVqm1VMf8gVKnYWav5vrw1Lw/3bH72Qnwd7cEgknqqOOtyU0V0Xz5LXjRrRbb/l61tHC3z93J7VmkUi1kT/a9e3Czg5OwMpkN5a0j/bPDkERqbJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIo/fYW7aIKhevoDl5m3w4cqq9caH86/JjRj1yyi2Cc=;
 b=TmqAyMbOEsA2DVatse5vK7He6yDoP5tB2K0IkrB5zAmg5EH10AKYT+566m1uzsMttG1iFukSRRiZKk9kCkqb6oNzdGCYJzIJ8ijkBMZUXMDevBXUSRm8aFu3/HzdMmwi/Gp7DIBNF8SEsrl00+bde6MzqlwT99+oYw+eoMkSH1yEKAO5ltXJJ6JfMfD3mhFHAujmZHKbqLaC1O2zpZqTv6bNHck6+pVDIRV6TCdtw5wVtPYI/RNx4w+CJNiCYp8yIINQ1LJEnzLS/V+4T8iuf6qGIphioaGUuJZ+1oYM4UZG7lbKjxoVoUG+6HsfiGFwdlk/1A1ZxHL975k3sLeuZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIo/fYW7aIKhevoDl5m3w4cqq9caH86/JjRj1yyi2Cc=;
 b=jBWi5qyeMrvva8NQJvbUOYv1BEF9zAVYI3vFDNPlYWw3VMGkydz6n6a2/0gLVxMLxgA5u6z6uaQGdpFpdtMPo8xvOb90K605fzgru8s2f9VDmo8B+oaqZJGfKUlNdB10ZXfCOxJqHHDjt9ACP86OLjSkIwJ7C0e1hiAq/WkuVFk=
Received: from DM6PR02CA0084.namprd02.prod.outlook.com (2603:10b6:5:1f4::25)
 by MN2PR12MB3792.namprd12.prod.outlook.com (2603:10b6:208:16e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 03:53:37 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::aa) by DM6PR02CA0084.outlook.office365.com
 (2603:10b6:5:1f4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Wed, 20 Apr 2022 03:53:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 03:53:36 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Apr
 2022 22:53:31 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Lijo.Lazar@amd.com>, <Mohammadzafar.Ziya@amd.com>,
 <YiPeng.Chai@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: add RAS fatal error interrupt handler
Date: Wed, 20 Apr 2022 11:53:17 +0800
Message-ID: <20220420035317.4008-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420035317.4008-1-tao.zhou1@amd.com>
References: <20220420035317.4008-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed10bd89-fbf9-47e6-75bb-08da22815912
X-MS-TrafficTypeDiagnostic: MN2PR12MB3792:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3792AC0E99A2B9341880184CB0F59@MN2PR12MB3792.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ANXxMYwBRuCsEv2pHmTUxmEjqQ5/ddHP+75i+csjpl/FpkuT1Pnf52cqPoHWi5atFQ0/d++SvaTCZusmtYBBGRFI/fb2DD3ZO4UzoXbkzZnYB4tyCKO35g3R5IaMFkmqceeofVZSs4UDs89eiJFCeK6zljCFEf+GvtPprdPSBwjOsc49wMQut1VJuak+d0AfUUd3Wr2XsbMqDBwXSHT/13+w3T0zjAMUVYs6uh6j+iKIdntDONsd56xx/NVeYy8rx8AJdHk5PrUNqTZqjr3WS0DR+Q5cGA+EVBxcGABjVbmmxQgrRVjcBbEHUXM7Rz1P/eO8Ny814UhbdVI5nVRSHfi9WuT7sHuu44PsDdOYSlkkWCpehT2OwdGIRrkxKhaZ+6HdN+mEevY/HfyPMWFqRNzn3DRULTI0IJrPZjmDQTwuTPz+ED9CRp9vWE8XuTMGj7rf5Xyv4NdD/vUoscFXkBs8TKm66dGmGHU4ms5V7BHHoMhP29JALBgOV/lIhKKt4N+HtCvDYKdLIugh/uaWen/Sl7LIsRQBz2ojjpQ1PUBwpp5KEGE0N9QZf50KgTseZNr0LHWN1mnQOGmly+Y7BodDikQv7OKxSK6KGzSPkYuC8s70fAz3QMtSuyNHYFoDJ4aCQS5/BQ5LVyMDprSb5wfc/K2V2mW3AZH/I/D+cmBdZJA83ZZ5geUOWdvj3+hk1v3xSRibPRAwH/Wt+hz0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(70586007)(40460700003)(8936002)(2906002)(36860700001)(336012)(508600001)(316002)(4326008)(82310400005)(426003)(6666004)(47076005)(86362001)(5660300002)(16526019)(36756003)(356005)(6636002)(2616005)(8676002)(70206006)(186003)(26005)(83380400001)(110136005)(7696005)(1076003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 03:53:36.5916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed10bd89-fbf9-47e6-75bb-08da22815912
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3792
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The fatal error handler is independent from general ras interrupt
handler since there is no related IH ring.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 15 +--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 20 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index ea3e8c66211f..b4cf8717f554 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -193,20 +193,7 @@ static irqreturn_t amdgpu_irq_handler(int irq, void *arg)
 	if (ret == IRQ_HANDLED)
 		pm_runtime_mark_last_busy(dev->dev);
 
-	/* For the hardware that cannot enable bif ring for both ras_controller_irq
-         * and ras_err_evnet_athub_irq ih cookies, the driver has to poll status
-	 * register to check whether the interrupt is triggered or not, and properly
-	 * ack the interrupt if it is there
-	 */
-	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__PCIE_BIF)) {
-		if (adev->nbio.ras &&
-		    adev->nbio.ras->handle_ras_controller_intr_no_bifring)
-			adev->nbio.ras->handle_ras_controller_intr_no_bifring(adev);
-
-		if (adev->nbio.ras &&
-		    adev->nbio.ras->handle_ras_err_event_athub_intr_no_bifring)
-			adev->nbio.ras->handle_ras_err_event_athub_intr_no_bifring(adev);
-	}
+	amdgpu_ras_interrupt_fatal_error_handler(adev);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 4bd3c25be809..a93024f72255 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1515,6 +1515,26 @@ static int amdgpu_ras_fs_fini(struct amdgpu_device *adev)
 /* ras fs end */
 
 /* ih begin */
+
+/* For the hardware that cannot enable bif ring for both ras_controller_irq
+ * and ras_err_evnet_athub_irq ih cookies, the driver has to poll status
+ * register to check whether the interrupt is triggered or not, and properly
+ * ack the interrupt if it is there
+ */
+void amdgpu_ras_interrupt_fatal_error_handler(struct amdgpu_device *adev)
+{
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__PCIE_BIF))
+		return;
+
+	if (adev->nbio.ras &&
+	    adev->nbio.ras->handle_ras_controller_intr_no_bifring)
+		adev->nbio.ras->handle_ras_controller_intr_no_bifring(adev);
+
+	if (adev->nbio.ras &&
+	    adev->nbio.ras->handle_ras_err_event_athub_intr_no_bifring)
+		adev->nbio.ras->handle_ras_err_event_athub_intr_no_bifring(adev);
+}
+
 static void ras_interrupt_poison_consumption_handler(struct ras_manager *obj,
 				struct amdgpu_iv_entry *entry)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index c4b61785ab5c..b9a6fac2b8b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -683,4 +683,5 @@ int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras *ras_co
 
 int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
 				struct amdgpu_ras_block_object *ras_block_obj);
+void amdgpu_ras_interrupt_fatal_error_handler(struct amdgpu_device *adev);
 #endif
-- 
2.35.1

