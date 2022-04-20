Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DBDC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 11:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF58D10F242;
	Wed, 20 Apr 2022 11:30:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D9DE10F240
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 11:30:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yoi7L1J3KedVSi9r3oUZpJymdcshs3GDtc5eJOrun2BO3qIGsR11JpcPUxroC78GMk3TzO1f81j9r2Ch7YryYXtEnpPTGD7GzcV5eOXhxhnMDpHUE72eErhkU9SruQKtupjM1yBQLJw9cFZywrEPhkKR62xBxttjkKftDp7odh1BROt8L+Z3o9YaB0UfUNWfqvoMU+gv+zZowmTjxQhkJzDzQXs3yH5It/P8NGdvxpoILa5GcrNu1sIG0zlt17NJFnKfVBaX+i3nIZ1NBdagh4o7CtnmN8I62U0NurfcDCu5pkv51VjzE1FI2JeKQdZxDIXqJAR/N0VMBrpq/Bu8fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERAfcPN8XZlS/78QRxAF4o5ZGHS0r1yIUf5xplUayfE=;
 b=hIrTHjgtma4lriMfsFpRDqqghpShukNBFY/j7MAXL7v5vxRTZAjRe+ayTQHqRQJELOcztEG+4nkqFwo4CykyYp8oDQVKJwEu72cGkt5kGCKSfgkdI8OMe22Bx+MsTgGRX8gFfGmbh4TWcvHfxtirZsMCNqcGJ1QZDsjs+NS95JSGfNBvCLgLd0MvsFFuzzVjdJwQfxHKpfGFNfiB5ohWKisRQUvr4iOZQ67p7745rXEu7UjaaNWowEvJr4l+hufHJD+pDa3D33uCzoRvrbslxXuDyd2KhM31Bb6NdsMPqGFwJAWaIn8daOogb2wrWvxcVfu9UxU84NU2hfTQsOSrzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERAfcPN8XZlS/78QRxAF4o5ZGHS0r1yIUf5xplUayfE=;
 b=lD23XUoJ9sYz7eirrttVp2bWaVp8gHYsK9ivZDp7GLnsxXRiO8lMd3E4vIsEo0OsEGu6t1Qh6/4gMUEei7wAdiZslnTlsm/RVasaa3ukh+6oGzyE9gNELkqDd9p5nGM6jXLLDSwDRGsmphO2RW+tWAfDTh6AkE8Nd986UvptZ30=
Received: from BN0PR03CA0007.namprd03.prod.outlook.com (2603:10b6:408:e6::12)
 by BYAPR12MB2773.namprd12.prod.outlook.com (2603:10b6:a03:72::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 11:30:31 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::d1) by BN0PR03CA0007.outlook.office365.com
 (2603:10b6:408:e6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Wed, 20 Apr 2022 11:30:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 11:30:30 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 20 Apr
 2022 06:30:28 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Lijo.Lazar@amd.com>, <Mohammadzafar.Ziya@amd.com>,
 <YiPeng.Chai@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: add RAS fatal error interrupt handler
Date: Wed, 20 Apr 2022 19:30:09 +0800
Message-ID: <20220420113009.8062-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420113009.8062-1-tao.zhou1@amd.com>
References: <20220420113009.8062-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 437e1ecc-0cd1-41f2-e477-08da22c12ce1
X-MS-TrafficTypeDiagnostic: BYAPR12MB2773:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2773B488412720422125FD53B0F59@BYAPR12MB2773.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FYlEYGK+syrPTCKs2TnOs3+XojjHheKShpmj+rhlnsolyWgzGTxoFTMlx4jB82GiZ3hpJPEPdklIlcmJELwixvTGgd0Nu7sWSBGsAyu3VCvenWse40tQyTB9p74UOj5AGJT9l0BBjvRvVkKqAym/GTJXLJo+kDEizCypnDXFJi3N6cYP+No3PiEDJw89+8sAa0xysdHpGdeVv0Nnhsjax1+dX6F5+SwKDU7pPG9BCvRte8TzUTUmQokApgIE8imK+mlIL1mOlTZVtfA2IhdwkGJ7g/+aFoZ6wiYRXgyjcln3tRNZFdx+k4OT496DbTy3Do7+ex1mvPub43i3hGXA0GPzKytGNUrNVT+uiag4a5oGbz18XLLluE/Xe1OW+GVRbARNOgggM9darGMEBZBuFHUdLJMz0OVKFMg8NW8ZQ4fhcPETeEVDGx+Y0ZzAc4JdRYmVTLbmdN5ZM0XcgDU34DmPDay5J3Ji5SiduzkuFAQ5n0LNB01vtIMdH5XbuSV98ZNq7aemq0xfJuuEy6nq/GL47T7XklQsr7lvv4zi8uO2lnseuj/zJj1+eZs/TbUoK3P3SWahwS4zyQLCBiRM9fBwXxckLSlIkM/qO41QV/KxShyjVR4HKVFp7d+eMwXucZnD+hLIR8XKgSomhqJfblFCtd6vID84oriVROz47gw+aY79Whf38bt1Clh02jy4TMG2wqnjFpgdrkqX+ttdRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(186003)(16526019)(426003)(508600001)(336012)(2616005)(1076003)(47076005)(7696005)(26005)(82310400005)(36756003)(8936002)(6666004)(8676002)(36860700001)(2906002)(110136005)(4326008)(70586007)(86362001)(70206006)(6636002)(5660300002)(81166007)(316002)(356005)(83380400001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 11:30:30.2911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 437e1ecc-0cd1-41f2-e477-08da22c12ce1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2773
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
index ad3b8560b2ca..eaf7fd0bd5d7 100644
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
 static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *obj,
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

