Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C8AC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 10:53:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42BC86F43E;
	Wed,  1 Dec 2021 10:53:50 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2048.outbound.protection.outlook.com [40.107.100.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E3976F5EF
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 10:53:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPevK93KxPsW5AM5QDOHvK30M/R7IXhEepflssC2xy+BoojVJZgRdmXgvjVvcf62dM1K82/w4p971oM5kL68KStfOVj0lp/9abgEelXuzMw0D324LqOh6EZBUuhO6Vt7LAfByuiAmOeRgv8s+Ne8f9YnpmOv8Jak6e04H1DzLqGxPmYghl8VKVtO/ayanImq2Tm8ii1/M880KWIr5EtlG95RP6W4QbjEsQug7LuPlbs45A25oY28G7J3yHc1mAeTI7c6332jpTYK+dZ+6ij6dq4bstEEg8v9Wxo6OBa7N5amGv8nQGsLnWCkGOV7OT7a6l/MpNTG3PvbZKt/EhKj/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIO1I34vnlVMl609V/kmYesArsVe96HRVDS1OdZr3ss=;
 b=PT5+Z/zIhlAkBaXbztmGHNGzXneAC9XFau1uOt2GLn0ymyhBgE812JVbFnYhZxCxRRsrSzNlic2VaAIemf8lRv7Tzbhn/OS0WSQeqCQiA3WPCWQ0IfsqFNWbMa0ZCK06QLm2Jc/h/kwVTROLPwEM7uT5f86Xgyf9MKYTSRAH7F+hgoKSzoxGdDB+txURBtBas8K/nLk/eD6cqSNcb6+fe6E2e5LTS7tAgC9CYL2ytZ3iLUMiI0JB3LdYwAHDAct91jusrSwJl16P8noqxN8cKlWpbPcp3AoG4DwzV/q0cQKKl3XJYyIsrEXsFVAVtHrhovfzuJg/pU8hS3Lloi1TNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIO1I34vnlVMl609V/kmYesArsVe96HRVDS1OdZr3ss=;
 b=0uQFJo44jN/yW39/CUdiHJDSAyxKLZAoPZk9XmZYhBoqqEPD47MUEw7NLaYiUa+b5F3F8Qk4eUCotWadCI5nJ897y/8NK1X3AGihvh5ZJ5616o+i0BZ1FG2VSdSP13FujveMBza4E+nSEVQON2Ut22qD1IsBSHU4O9RWyICR2mc=
Received: from BN6PR14CA0010.namprd14.prod.outlook.com (2603:10b6:404:79::20)
 by BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 10:53:45 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::50) by BN6PR14CA0010.outlook.office365.com
 (2603:10b6:404:79::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Wed, 1 Dec 2021 10:53:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 1 Dec 2021 10:53:45 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 1 Dec
 2021 04:53:43 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 07/11] drm/amdgpu: Modify nbio block to fit for the unified
 ras block data and ops
Date: Wed, 1 Dec 2021 18:52:46 +0800
Message-ID: <20211201105250.298525-7-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201105250.298525-1-YiPeng.Chai@amd.com>
References: <20211201105250.298525-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 853ff36f-aa50-47b1-9404-08d9b4b8d8f6
X-MS-TrafficTypeDiagnostic: BN9PR12MB5068:
X-Microsoft-Antispam-PRVS: <BN9PR12MB50685F144E60ADFA4E609ECFFC689@BN9PR12MB5068.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MF3eJAGqC6XszNB9J2D9FqLkYFNUkS6nLLizhTGXWlboOYg5gNY6cIccGpc24tfUEkyxV3brHqRX/dFCDOno20OP+d8eMIQ2wj3vzQnsD1DB0IyBMGg9HdnC7/MmDG9vw2DiHxjfnyWES/2SXA5GM4ZwkDKmCUNeFgqRYhGQTlBYq2s82f8iMlgh+Ui+QUOyVif2ui4jOcfQ7zx5+eMj6UPJOho74DnmamWyWyV7YlRAXak/HxGoj81thatALA86SJbg4/8U/OlFOUmQb5HY/xByq5/YnMlVQbyS+19f+2SEhdIMSgYAHUU7mkZp4Y4plrbT8Mn3VO+TrnqLK1d+4Ei6sFZAAKQ1AaFDpNv/tP7lUNwM4OVw1izJGKUQ2ds/dBsWJ7B7oKtcKDxs+dYzlzPXWavCPMccqh6yBalsbIJKjLIrlKOEXwTOxJzJ2EWPHKUmoHxSbR3FDjpciSqXdXI2bm7rAcadLYZA43rWOTdF3oLyR8DaKZnLx66lLHZzJet3T8J1Lb94krBk7H4SPYpfRUIecD++0R2IdyeJbcNYjIDChiq/PPe396PyHKaQd5S+tktAli+OAGO7uxvh4Sc+5GQlDncxbsMbQXNnvxKSMSdPu2LVsnWdM1YSV5AAUKv+cLCyEJ/UZ2GP4W+PLvzaM+epk1QnXqe9b1/TmAlmOQlAQF0d4wg0bYhpIc0uQXy+G3QnfIhtjSwsTyD32nI7OsRBx2/uMESsu+dXccVhdPtt45Rps4Npm0QXmeERm+VJoyjLrr1PJDFldN7LEoPUEBlip0ojSGNXyiX71YlLRsHzKDLYOAirVFdTMJ/m5VeiB2CrgEq9mYC5VfOEaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(82310400004)(2616005)(8676002)(6916009)(5660300002)(70586007)(2906002)(36756003)(54906003)(40460700001)(81166007)(7696005)(426003)(8936002)(70206006)(16526019)(356005)(508600001)(26005)(83380400001)(316002)(47076005)(36860700001)(186003)(1076003)(336012)(86362001)(4326008)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 10:53:45.6207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 853ff36f-aa50-47b1-9404-08d9b4b8d8f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5068
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, yipechai <YiPeng.Chai@amd.com>,
 yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1.Modify nbio block to fit for the unified ras block data and ops.
2.Implement .ras_block_match function pointer for nbio block to identify itself.
3.Change amdgpu_nbio_ras_funcs to amdgpu_nbio_ras, and the corresponding variable name remove _funcs suffix.
4.Remove the const flag of mmhub ras variable so that nbio ras block can be able to be insertted into amdgpu device ras block link list.
5.Invoke amdgpu_ras_register_ras_block function to register nbio ras block into amdgpu device ras block link list.
6.Remove the redundant code about nbio in amdgpu_ras.c after using the unified ras block.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c  | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  9 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 22 ++++++++---------
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c   | 30 ++++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c       | 20 ++++++++--------
 6 files changed, 56 insertions(+), 39 deletions(-)

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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index 843052205bd5..4a1fb85939d6 100644
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
@@ -104,7 +101,7 @@ struct amdgpu_nbio {
 	struct amdgpu_irq_src ras_err_event_athub_irq;
 	struct ras_common_if *ras_if;
 	const struct amdgpu_nbio_funcs *funcs;
-	const struct amdgpu_nbio_ras_funcs *ras_funcs;
+	struct amdgpu_nbio_ras  *ras;
 };
 
 int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index d705d8b1daf6..273a550741e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -957,10 +957,6 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 			block_obj->ops->query_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__PCIE_BIF:
-		if (adev->nbio.ras_funcs &&
-		    adev->nbio.ras_funcs->query_ras_error_count)
-			adev->nbio.ras_funcs->query_ras_error_count(adev, &err_data);
-		break;
 	case AMDGPU_RAS_BLOCK__XGMI_WAFL:
 	case AMDGPU_RAS_BLOCK__HDP:
 		if (!block_obj || !block_obj->ops)	{
@@ -2336,24 +2332,26 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
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
index 91b3afa946f5..14f7265d954e 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -638,16 +638,38 @@ static void nbio_v7_4_enable_doorbell_interrupt(struct amdgpu_device *adev,
 		       DOORBELL_INTERRUPT_DISABLE, enable ? 0 : 1);
 }
 
-const struct amdgpu_nbio_ras_funcs nbio_v7_4_ras_funcs = {
+static int nbio_v7_4_ras_block_match(struct amdgpu_ras_block_object* block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index)
+{
+	if(!block_obj)
+		return -EINVAL;
+
+	if(block_obj->block == block) {
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+const struct amdgpu_ras_block_ops nbio_v7_4_ras_ops = {
+	.ras_block_match = nbio_v7_4_ras_block_match,
+	.query_ras_error_count = nbio_v7_4_query_ras_error_count,
+	.ras_late_init = amdgpu_nbio_ras_late_init,
+	.ras_fini = amdgpu_nbio_ras_fini,
+};
+
+struct amdgpu_nbio_ras nbio_v7_4_ras = {
+	.ras_block = {
+		.name = "pcie_bif",
+		.block = AMDGPU_RAS_BLOCK__PCIE_BIF,
+		.ops = &nbio_v7_4_ras_ops,
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
index f9d92b6deef0..897c7e784701 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1385,9 +1385,9 @@ static int soc15_common_late_init(void *handle)
 	if (amdgpu_sriov_vf(adev))
 		xgpu_ai_mailbox_get_irq(adev);
 
-	if (adev->nbio.ras_funcs &&
-	    adev->nbio.ras_funcs->ras_late_init)
-		r = adev->nbio.ras_funcs->ras_late_init(adev);
+	if (adev->nbio.ras && adev->nbio.ras->ras_block.ops &&
+	    adev->nbio.ras->ras_block.ops->ras_late_init)
+		r = adev->nbio.ras->ras_block.ops->ras_late_init(adev);
 
 	return r;
 }
@@ -1408,9 +1408,9 @@ static int soc15_common_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (adev->nbio.ras_funcs &&
-	    adev->nbio.ras_funcs->ras_fini)
-		adev->nbio.ras_funcs->ras_fini(adev);
+	if (adev->nbio.ras && adev->nbio.ras->ras_block.ops &&
+	    adev->nbio.ras->ras_block.ops->ras_fini)
+		adev->nbio.ras->ras_block.ops->ras_fini(adev);
 	adev->df.funcs->sw_fini(adev);
 	return 0;
 }
@@ -1474,11 +1474,11 @@ static int soc15_common_hw_fini(void *handle)
 
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

