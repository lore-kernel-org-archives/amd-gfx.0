Return-Path: <SRS0=b4Qt=JW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1640C433ED
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Apr 2021 07:09:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9778E613C2
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Apr 2021 07:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9778E613C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CE406E0A5;
	Sun, 25 Apr 2021 07:09:48 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B348B6E0A5
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Apr 2021 07:09:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnK1qTN1xk4AFvwAYLvOVrAqr8b9i0JahNHQZSyo6TITenE32WLV0qJUk5TJJ5V4h8mN5MMzRVkWLfLu8kM76qsAkjUimeeRJxdk/hhEYbXapTfsqljNoNUnYbtS9kjTcwOSKWH1DEVLZgZVFIxhj8ALcEMIVGkx39HxdY0Hmo44UgwuIk4T8JP142fRPOme3914CBXXqb4aQ6tKufPyUEecj9gaGU/uzJBBJ51k9soiX4VQOZIQgDsQCEKvJE/Q5kTsxz4EDJJxe11rbpe1ssLwJ4STlxXdXs3eJ2RKb6Wbhi2uE4C5oMOSLKF7Nk3OB2KSSUOUeZkNEd/g8cb+Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFD5miyY9BKo27mQLZoIYBubFWJvG+oI3C1rvs3xm5Q=;
 b=QS8RooUziUcRN9DYMPRHpoq8HGItk8yYah0Dhwzr73Kr04Tc/vyGm84pGdqD729atwniANEoK4Zm2HUuXkDzU5KXhKBp5xwZtxlRyLhEhCO5Lu7rp4gL5rwyXJU4jS9e0JPjn8zwINzeto1b8XzxiHrNEjTR3GHw8KZTZes9xkjXpxHILqW30dlaHJAe7fZen9PnsJvTXlj9HJutsnCTQRyRQQ17If9ICgi7+DRdC+XEc9S+KpFRi7TNBfLDrN1ZftM6iUHlckRIqaGdfEqKJ0Kk01on7Hzrgt2G9dtcaPlRaUcFQjvlWmY5JdhQpSE4bYTEPPkR3Uk9fnHZ8DXjBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFD5miyY9BKo27mQLZoIYBubFWJvG+oI3C1rvs3xm5Q=;
 b=IDlCWpscP5wr/O4+/kYRA4rALZT2gPMWo8x7c96pJFYQInMYfOby8N+2t383NTjkiuhCmdvGWn53mgwaBJ6Si95RIa5B2B+JtEYU0J0lE6AJ52nS32nbOEz0DWrBPk0oK+7j4FtjqXo7rqxYKFpahaWibdf4a6JPdFPDbTo/oqs=
Received: from DM5PR06CA0083.namprd06.prod.outlook.com (2603:10b6:3:4::21) by
 MWHPR1201MB2476.namprd12.prod.outlook.com (2603:10b6:300:de::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Sun, 25 Apr
 2021 07:09:39 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::4b) by DM5PR06CA0083.outlook.office365.com
 (2603:10b6:3:4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Sun, 25 Apr 2021 07:09:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Sun, 25 Apr 2021 07:09:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 25 Apr
 2021 02:09:38 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 25 Apr
 2021 02:09:38 -0500
Received: from fiona-codemachine.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Sun, 25 Apr 2021 02:09:37 -0500
From: Feifei Xu <Feifei.Xu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: correct sdma 4.x irq.num_types.
Date: Sun, 25 Apr 2021 15:09:34 +0800
Message-ID: <20210425070934.44672-1-Feifei.Xu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d21b615f-7675-44d3-d2cb-08d907b9175d
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2476:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB247693A6D68544AA1FB45015FE439@MWHPR1201MB2476.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U1iqA9oPK/BeEYHLdm4JRzDc3FR/O5zSthv6lGEToinEmy12AJIr6VBH1TmQ2AfoIpbSkx/IwaCW7XPtdrrAtpymQRtaptVccAssbHAHGX+mTH6CYgTXJXsSxHUr877oobFZSKyFNL3wGn+zeEKOelAr8yhjoaVZ1DxBUQG2ODnFq9Oed0jdmRVEVUydkD3WNyhExKfOi1nQxdc9MwkVW8lI48HXwghk3NP+GlQmeIe4XdHOtbaB0nPA+aVnPJCaiYyZlUB/Nj4UNvQuxuKX+uZNfmN9y9Rx4y3CJuBo7BXppfIMYjOQN+pzhUPv3q2ubaQeiubu8eIEwq6fU6/uPzBUt+XtkdprksPe1mE+XOfp22YY9MKjatWVRpNbj/fEdTy3jJTvRV7g8yj7Y0zqHWRTJoGsry7EdBkIpKfeiS+NIW+iGAV8OE5DM5ZSgALeGtVv7Lu+G7z0AcrgtjSUH34lYSvpXuCWhvMoP7kShORfVb6SDtEpOaqZFAGMwMABqOZhy3b+FSx70Wv7lN47ZiMRGe4Gmb2MuSsQvdCohebHpEkdXGWuwtgw3Z5H4PpH/6t9Lyaizqe0640k3XXn5C9m1dKIUzQJyGcUF1ZxjJDktTaV5ghwtKSPX4R47DH2PCM+/lMooVMefvLhERcB5F3mTtE7Vt1Clry1yg9krfQBxGj1vUM/87D/yE/JbI+0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(46966006)(36840700001)(82310400003)(70586007)(1076003)(70206006)(86362001)(356005)(2906002)(26005)(82740400003)(81166007)(8936002)(8676002)(7696005)(2616005)(426003)(316002)(186003)(83380400001)(36860700001)(36756003)(6916009)(54906003)(4326008)(336012)(5660300002)(478600001)(47076005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2021 07:09:39.1105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d21b615f-7675-44d3-d2cb-08d907b9175d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2476
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change the sdma interrupt info print level to debug.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 28 +++++++++++++++-----------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index fbb701560ced..7870fd09d98d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2220,7 +2220,7 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
 
 	instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
 	if (instance < 0 || instance >= adev->sdma.num_instances) {
-		dev_err_ratelimited(adev->dev, "sdma instance invalid %d\n", instance);
+		dev_err(adev->dev, "sdma instance invalid %d\n", instance);
 		return -EINVAL;
 	}
 
@@ -2230,7 +2230,7 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
 	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
 	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
 
-	dev_info_ratelimited(adev->dev,
+	dev_dbg_ratelimited(adev->dev,
 		   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
 		   "pasid:%u, for process %s pid %d thread %s pid %d\n",
 		   instance, addr, entry->src_id, entry->ring_id, entry->vmid,
@@ -2243,7 +2243,7 @@ static int sdma_v4_0_process_vm_hole_irq(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *source,
 					      struct amdgpu_iv_entry *entry)
 {
-	dev_err_ratelimited(adev->dev, "MC or SEM address in VM hole\n");
+	dev_dbg_ratelimited(adev->dev, "MC or SEM address in VM hole\n");
 	sdma_v4_0_print_iv_entry(adev, entry);
 	return 0;
 }
@@ -2253,7 +2253,7 @@ static int sdma_v4_0_process_doorbell_invalid_irq(struct amdgpu_device *adev,
 					      struct amdgpu_iv_entry *entry)
 {
 
-	dev_err_ratelimited(adev->dev, "SDMA received a doorbell from BIF with byte_enable !=0xff\n");
+	dev_dbg_ratelimited(adev->dev, "SDMA received a doorbell from BIF with byte_enable !=0xff\n");
 	sdma_v4_0_print_iv_entry(adev, entry);
 	return 0;
 }
@@ -2262,7 +2262,7 @@ static int sdma_v4_0_process_pool_timeout_irq(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *source,
 					      struct amdgpu_iv_entry *entry)
 {
-	dev_err_ratelimited(adev->dev,
+	dev_dbg_ratelimited(adev->dev,
 		"Polling register/memory timeout executing POLL_REG/MEM with finite timer\n");
 	sdma_v4_0_print_iv_entry(adev, entry);
 	return 0;
@@ -2272,7 +2272,7 @@ static int sdma_v4_0_process_srbm_write_irq(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *source,
 					      struct amdgpu_iv_entry *entry)
 {
-	dev_err_ratelimited(adev->dev,
+	dev_dbg_ratelimited(adev->dev,
 		"SDMA gets an Register Write SRBM_WRITE command in non-privilege command buffer\n");
 	sdma_v4_0_print_iv_entry(adev, entry);
 	return 0;
@@ -2609,14 +2609,18 @@ static void sdma_v4_0_set_irq_funcs(struct amdgpu_device *adev)
 	case 5:
 		adev->sdma.trap_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
 		adev->sdma.ecc_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+		adev->sdma.vm_hole_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+		adev->sdma.doorbell_invalid_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+		adev->sdma.pool_timeout_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+		adev->sdma.srbm_write_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
 		break;
 	case 8:
-		adev->sdma.trap_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
-		adev->sdma.ecc_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
-		adev->sdma.vm_hole_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
-		adev->sdma.doorbell_invalid_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
-		adev->sdma.pool_timeout_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
-		adev->sdma.srbm_write_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
+		adev->sdma.trap_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE7;
+		adev->sdma.ecc_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE7;
+		adev->sdma.vm_hole_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE7;
+		adev->sdma.doorbell_invalid_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE7;
+		adev->sdma.pool_timeout_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE7;
+		adev->sdma.srbm_write_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE7;
 		break;
 	case 2:
 	default:
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
