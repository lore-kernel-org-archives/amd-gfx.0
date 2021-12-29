Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E246AC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Dec 2021 06:33:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3899210E40A;
	Wed, 29 Dec 2021 06:33:12 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2084.outbound.protection.outlook.com [40.107.100.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AD0D10E404
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Dec 2021 06:33:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLkyS5mhPrKgmZe9fwKHu7aMiGwDLBC5+AyPwAiTBteebhq2fyoxV6dmLz5CkxhbMDLxNFSFQ2N1lk6miYattdSx+khGQ+rKCXWaIq/d62Xlq5mIALABphHGqJZJ59r5FtnkZtccZFsCX2iYiXoSZts0NDK+yuSWptVlyYQ1v6gDpMbdv3H+e4SjqvlKR848Rky0/+URUoM3kY1VvTjTJdVR8b2/hlnk1T8nAeEdXG/gE04uZ1b71RQ2wLvyUBITubemB5Y9TDTa53Is3YvyKhR4mH3rqkIOXKfr7h8ga+LUBEAkr8VNDIZZ4GcrqXBZ/3Jb9OQqos8Zdc88Umr8iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnPYRB1FdGnF2yhfUy/SPTGovE9ls1rAks37beK2Ni4=;
 b=MpX5gSTA8Ax4pYvuD+oBU4hzV7zrlRh3WIev/+hTtQQjISz9/fXjhkrCb9fiybBh0jYOSciGwoyTopjmtcoP/gYFGFqPBt0v/SUxH/lxpvOldsvxLS2YzSM2xdL87KKw4+IjgXsYkk6RE9ZwLgivP3PPlhbNE9VUHN6ibx2T8oSkI0XpwQ/x12Y/sw7LbB+SG07OBUzUVsLvgiGElr3rWcipR6ziTyVWdLpW5LrIaqCdRV9pDPolePXCQrsprDpqsItb4nOFQakBn9mRF5OlSwudizPvs9l2NwSrmsviGKgtS6FvsJCNvnkBQp+GgRdChmBA9awwjHo9//6YDit9Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnPYRB1FdGnF2yhfUy/SPTGovE9ls1rAks37beK2Ni4=;
 b=2Wa/H6siLL1baF3AuHmgHUTY9aZuHEuR7h8ks/D7BZSqP454briAce+zjY7LRV2Z81+DkiZJjKWueUIZ2CdADDAW1ha0yuhsmQYIWcpwB8UxX2uPHgLEaGc/uGZdnckrcg/GSVExWfwsBDjvqF5zRAMmNg9EXnAB3brAHgCdkoA=
Received: from MW4PR03CA0285.namprd03.prod.outlook.com (2603:10b6:303:b5::20)
 by BL1PR12MB5304.namprd12.prod.outlook.com (2603:10b6:208:314::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13; Wed, 29 Dec
 2021 06:33:05 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::f8) by MW4PR03CA0285.outlook.office365.com
 (2603:10b6:303:b5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14 via Frontend
 Transport; Wed, 29 Dec 2021 06:33:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Wed, 29 Dec 2021 06:33:05 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 29 Dec
 2021 00:33:02 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 07/12] drm/amdgpu: Modify nbio block to fit for the unified
 ras block data and ops
Date: Wed, 29 Dec 2021 14:32:06 +0800
Message-ID: <20211229063211.43840-7-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211229063211.43840-1-YiPeng.Chai@amd.com>
References: <20211229063211.43840-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67c009cb-5778-4004-1441-08d9ca95121c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5304:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB53048DAC14AA173CA4B83C1AFC449@BL1PR12MB5304.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p5pUsJANdGnuNMTqO9QrVW1ez8Noj+sFpnNRLpWY7WA3pRz7F3Ol5i5q4WtsOQPwJUcIT0y+YLiPRX/Q05lJM3AZBUux26szxumrtd7JmgaqlYCAyUixZOYT9VzhX7uGhMoNHTzRJqFjYfushaEEziNMxACow+IxiAO8bebiLHR15QPOJ/HbyComEV2PDixQtETvlgHvnfdhLyfVZB4K3tSpE1HVvaAhDTDiXgLFlEKZWXnZjpoltJg5X1qzY0mtCNgsd03CYliAhP71D3/pHB24mdP+W+sVbdHaFkQM3Q02GC/2p6PDppAaXcmkf9HRsGTw90Mp0KrkZ4BzqlfP+YbWt7Ajl2ZA9pAMvFfvwG5DtBTEeMU4ihcA5zV/xUZRxzc1fr+rrabnG6b6yNUZGAR54h6/EyQaZSq/nnm9QoRN1/2Z8+mMfUKddE4F8KTsD0JCezrsIDc11v+AOTLxhVZmna5j5bgOveXOJ+ae4wjsVZNexw4u02u8ZpIN/yWwViNjTUCNfe2JH1a1dPd21kCay/pUfVjmaAizyG569T+oiBBEj3E5pQld8N8ITXw4ZqJ2gH4xKouVHDqdqSB+RpBT2EmvhH5oj/BZ3ZEIAoVsGyt0GfQaJyC557Zl9VqJ+PiEE7WEEk1HeE0uCAsxOa4kxY0XKGFEP066mxky6+VaK1m+mF4CCynWV5r8O/C+ft1lxcsrvH0rLJ6Iwswlioy3vWc4nuGBQErmNP+I/8w/c9W1Bgh5jrZ8Sz2FSWutoWeLHca1c3gJa/mNEzDlx0HceVePlp0Tg5cKaCyHJ46YNpzuKoTvySCvAfFJykq6DqYwm5Z9GRbgZt+qMPIhLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(4326008)(508600001)(7696005)(336012)(6916009)(47076005)(36756003)(2906002)(2616005)(8936002)(1076003)(426003)(316002)(8676002)(36860700001)(83380400001)(40460700001)(70206006)(54906003)(70586007)(82310400004)(186003)(26005)(16526019)(81166007)(356005)(5660300002)(86362001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2021 06:33:05.0685 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c009cb-5778-4004-1441-08d9ca95121c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5304
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1.Modify nbio block to fit for the unified ras block data and ops.
2.Change amdgpu_nbio_ras_funcs to amdgpu_nbio_ras, and the corresponding variable name remove _funcs suffix.
3.Remove the const flag of mmhub ras variable so that nbio ras block can be able to be inserted into amdgpu device ras block link list.
4.Invoke amdgpu_ras_register_ras_block function to register nbio ras block into amdgpu device ras block link list.
5.Remove the redundant code about nbio in amdgpu_ras.c after using the unified ras block.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c  | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h | 11 ++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 22 ++++++++++------------
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c   | 17 +++++++++++++----
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c       | 18 ++++++++----------
 7 files changed, 43 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 5208b2dd176a..24feceb51289 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -208,13 +208,13 @@ irqreturn_t amdgpu_irq_handler(int irq, void *arg)
 	 * ack the interrupt if it is there
 	 */
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__PCIE_BIF)) {
-		if (adev->nbio.ras_funcs &&
-		    adev->nbio.ras_funcs->handle_ras_controller_intr_no_bifring)
-			adev->nbio.ras_funcs->handle_ras_controller_intr_no_bifring(adev);
+		if (adev->nbio.ras &&
+		    adev->nbio.ras->handle_ras_controller_intr_no_bifring)
+			adev->nbio.ras->handle_ras_controller_intr_no_bifring(adev);
 
-		if (adev->nbio.ras_funcs &&
-		    adev->nbio.ras_funcs->handle_ras_err_event_athub_intr_no_bifring)
-			adev->nbio.ras_funcs->handle_ras_err_event_athub_intr_no_bifring(adev);
+		if (adev->nbio.ras &&
+		    adev->nbio.ras->handle_ras_err_event_athub_intr_no_bifring)
+			adev->nbio.ras->handle_ras_err_event_athub_intr_no_bifring(adev);
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
index 6201a5f4b4fa..f54c183f1b1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -22,7 +22,7 @@
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
 
-int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev)
+int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, void *ras_info)
 {
 	int r;
 	struct ras_ih_if ih_info = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index 843052205bd5..4afb76d3cd97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -47,15 +47,12 @@ struct nbio_hdp_flush_reg {
 	u32 ref_and_mask_sdma7;
 };
 
-struct amdgpu_nbio_ras_funcs {
+struct amdgpu_nbio_ras {
+	struct amdgpu_ras_block_object ras_block;
 	void (*handle_ras_controller_intr_no_bifring)(struct amdgpu_device *adev);
 	void (*handle_ras_err_event_athub_intr_no_bifring)(struct amdgpu_device *adev);
 	int (*init_ras_controller_interrupt)(struct amdgpu_device *adev);
 	int (*init_ras_err_event_athub_interrupt)(struct amdgpu_device *adev);
-	void (*query_ras_error_count)(struct amdgpu_device *adev,
-				      void *ras_error_status);
-	int (*ras_late_init)(struct amdgpu_device *adev);
-	void (*ras_fini)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_nbio_funcs {
@@ -104,9 +101,9 @@ struct amdgpu_nbio {
 	struct amdgpu_irq_src ras_err_event_athub_irq;
 	struct ras_common_if *ras_if;
 	const struct amdgpu_nbio_funcs *funcs;
-	const struct amdgpu_nbio_ras_funcs *ras_funcs;
+	struct amdgpu_nbio_ras  *ras;
 };
 
-int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev);
+int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, void *ras_info);
 void amdgpu_nbio_ras_fini(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index fa0ebd484c7e..26bd9da31ffc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -969,10 +969,6 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 			block_obj->hw_ops->query_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__PCIE_BIF:
-		if (adev->nbio.ras_funcs &&
-		    adev->nbio.ras_funcs->query_ras_error_count)
-			adev->nbio.ras_funcs->query_ras_error_count(adev, &err_data);
-		break;
 	case AMDGPU_RAS_BLOCK__XGMI_WAFL:
 	case AMDGPU_RAS_BLOCK__HDP:
 		if (!block_obj || !block_obj->hw_ops)	{
@@ -2351,24 +2347,26 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	case CHIP_VEGA20:
 	case CHIP_ARCTURUS:
 	case CHIP_ALDEBARAN:
-		if (!adev->gmc.xgmi.connected_to_cpu)
-			adev->nbio.ras_funcs = &nbio_v7_4_ras_funcs;
+		if (!adev->gmc.xgmi.connected_to_cpu) {
+			adev->nbio.ras = &nbio_v7_4_ras;
+			amdgpu_ras_register_ras_block(adev, &adev->nbio.ras->ras_block);
+		}
 		break;
 	default:
 		/* nbio ras is not available */
 		break;
 	}
 
-	if (adev->nbio.ras_funcs &&
-	    adev->nbio.ras_funcs->init_ras_controller_interrupt) {
-		r = adev->nbio.ras_funcs->init_ras_controller_interrupt(adev);
+	if (adev->nbio.ras &&
+	    adev->nbio.ras->init_ras_controller_interrupt) {
+		r = adev->nbio.ras->init_ras_controller_interrupt(adev);
 		if (r)
 			goto release_con;
 	}
 
-	if (adev->nbio.ras_funcs &&
-	    adev->nbio.ras_funcs->init_ras_err_event_athub_interrupt) {
-		r = adev->nbio.ras_funcs->init_ras_err_event_athub_interrupt(adev);
+	if (adev->nbio.ras &&
+	    adev->nbio.ras->init_ras_err_event_athub_interrupt) {
+		r = adev->nbio.ras->init_ras_err_event_athub_interrupt(adev);
 		if (r)
 			goto release_con;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 91b3afa946f5..bcd9d72e7888 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -638,16 +638,25 @@ static void nbio_v7_4_enable_doorbell_interrupt(struct amdgpu_device *adev,
 		       DOORBELL_INTERRUPT_DISABLE, enable ? 0 : 1);
 }
 
-const struct amdgpu_nbio_ras_funcs nbio_v7_4_ras_funcs = {
+const struct amdgpu_ras_block_hw_ops nbio_v7_4_ras_hw_ops = {
+	.query_ras_error_count = nbio_v7_4_query_ras_error_count,
+};
+
+struct amdgpu_nbio_ras nbio_v7_4_ras = {
+	.ras_block = {
+		.name = "pcie_bif",
+		.block = AMDGPU_RAS_BLOCK__PCIE_BIF,
+		.hw_ops = &nbio_v7_4_ras_hw_ops,
+		.ras_late_init = amdgpu_nbio_ras_late_init,
+		.ras_fini = amdgpu_nbio_ras_fini,
+	},
 	.handle_ras_controller_intr_no_bifring = nbio_v7_4_handle_ras_controller_intr_no_bifring,
 	.handle_ras_err_event_athub_intr_no_bifring = nbio_v7_4_handle_ras_err_event_athub_intr_no_bifring,
 	.init_ras_controller_interrupt = nbio_v7_4_init_ras_controller_interrupt,
 	.init_ras_err_event_athub_interrupt = nbio_v7_4_init_ras_err_event_athub_interrupt,
-	.query_ras_error_count = nbio_v7_4_query_ras_error_count,
-	.ras_late_init = amdgpu_nbio_ras_late_init,
-	.ras_fini = amdgpu_nbio_ras_fini,
 };
 
+
 static void nbio_v7_4_program_ltr(struct amdgpu_device *adev)
 {
 	uint32_t def, data;
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.h b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.h
index b8216581ec8d..f27c41728822 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.h
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.h
@@ -28,6 +28,6 @@
 
 extern const struct nbio_hdp_flush_reg nbio_v7_4_hdp_flush_reg;
 extern const struct amdgpu_nbio_funcs nbio_v7_4_funcs;
-extern const struct amdgpu_nbio_ras_funcs nbio_v7_4_ras_funcs;
+extern struct amdgpu_nbio_ras nbio_v7_4_ras;
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index f9d92b6deef0..5578d952aaa1 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1385,9 +1385,8 @@ static int soc15_common_late_init(void *handle)
 	if (amdgpu_sriov_vf(adev))
 		xgpu_ai_mailbox_get_irq(adev);
 
-	if (adev->nbio.ras_funcs &&
-	    adev->nbio.ras_funcs->ras_late_init)
-		r = adev->nbio.ras_funcs->ras_late_init(adev);
+	if (adev->nbio.ras && adev->nbio.ras->ras_block.ras_late_init)
+		r = adev->nbio.ras->ras_block.ras_late_init(adev, NULL);
 
 	return r;
 }
@@ -1408,9 +1407,8 @@ static int soc15_common_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (adev->nbio.ras_funcs &&
-	    adev->nbio.ras_funcs->ras_fini)
-		adev->nbio.ras_funcs->ras_fini(adev);
+	if (adev->nbio.ras && adev->nbio.ras->ras_block.ras_fini)
+		adev->nbio.ras->ras_block.ras_fini(adev);
 	adev->df.funcs->sw_fini(adev);
 	return 0;
 }
@@ -1474,11 +1472,11 @@ static int soc15_common_hw_fini(void *handle)
 
 	if (adev->nbio.ras_if &&
 	    amdgpu_ras_is_supported(adev, adev->nbio.ras_if->block)) {
-		if (adev->nbio.ras_funcs &&
-		    adev->nbio.ras_funcs->init_ras_controller_interrupt)
+		if (adev->nbio.ras &&
+		    adev->nbio.ras->init_ras_controller_interrupt)
 			amdgpu_irq_put(adev, &adev->nbio.ras_controller_irq, 0);
-		if (adev->nbio.ras_funcs &&
-		    adev->nbio.ras_funcs->init_ras_err_event_athub_interrupt)
+		if (adev->nbio.ras &&
+		    adev->nbio.ras->init_ras_err_event_athub_interrupt)
 			amdgpu_irq_put(adev, &adev->nbio.ras_err_event_athub_irq, 0);
 	}
 
-- 
2.25.1

