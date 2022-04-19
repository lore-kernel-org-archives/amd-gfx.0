Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BD0C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Apr 2022 01:32:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74FFC10E1F5;
	Tue, 19 Apr 2022 01:32:52 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2056.outbound.protection.outlook.com [40.107.96.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 509B410E1F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 01:32:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gd3+abayhHElApn0gpzGTtKaEVXuls6rKBDY+89vQntPmZLXyhlVSLObtXzQYGF2joqFk+2vzUYvAIvIHT+482Mm3XAsdjPaeqq1JhNz8tq0GHWUTKawGkyXUMH22layL8xAmgTCOzbtAs/4VOUaE9p+D9tfczmrZ1bf0KiB3yXcT+irGplsAfeLLDuIcrJcJwezTIQAWu1sGhypvoEWMxZyx4Enj6ODXWgsG97Csus+TUkpxyG4g/nr/g5BnEt5cipGjOrch9gCwkJ13lCinVIgWVX2WE+cS28BF9CqlpFiwgje79pjNpSOLoPcuymjGtAVWcpJesWQ3dREjWe93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lub0MOyWM/B3xOzH6yYQuwUStQzEjNupK7bjmCY2Cac=;
 b=Oo2HApol4ljyop6RCEhvPmV0+/cmXeF7rIi0dewDQNbE32qTT0qPTB0ihZFbXiHg3RFQkTphEPUZEmu+PvOKD8HZ24Y2xTOPuA/k5lY0Zyx6QCtSG88YfDpRh3AG5cJh2VZ6ZPLt3kFBtjITETtDjpB/TRWfKheGbZMX55p2pBkxTyzitmW0n6GksagduLqKaSKhdPOhehjp5mnkRr+aM6/89OwxO9NR/lLkkczxmfhJUhlP4Ij6NUbebiG/bER0K18IXTdqJjt+g4F6zN/fV8/rbVMO2oEMjOjPYRV1rHBfHmJR5LR43pxtAKgH4A0w1lZHgjWQDVazHyMZF4oveA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lub0MOyWM/B3xOzH6yYQuwUStQzEjNupK7bjmCY2Cac=;
 b=biph0kS2j/6TiS+qQlHcx2ZnEFqSnAX60J4ZCzT1JkXD97CpbV+wP5Wei5dB5BMU3PCR2N63Xvsdm93g9xyuK8Nw8ym2d2+S1jj28LxwkZEVS74VMJehVCuWjYRWvpzMNJoheOIeqGKPPTCHOnPWx5wfcbCfldmtToRzYH6XWzA=
Received: from DM6PR07CA0132.namprd07.prod.outlook.com (2603:10b6:5:330::25)
 by CY4PR12MB1669.namprd12.prod.outlook.com (2603:10b6:910:3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Tue, 19 Apr
 2022 01:32:44 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::15) by DM6PR07CA0132.outlook.office365.com
 (2603:10b6:5:330::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Tue, 19 Apr 2022 01:32:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Tue, 19 Apr 2022 01:32:44 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 18 Apr
 2022 20:32:42 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/2] drm/amdkfd: CRIU add support for GWS queues
Date: Mon, 18 Apr 2022 21:32:27 -0400
Message-ID: <20220419013227.2509204-2-david.yatsin@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419013227.2509204-1-david.yatsin@amd.com>
References: <20220419013227.2509204-1-david.yatsin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe7d142a-6d88-437c-6127-08da21a480a6
X-MS-TrafficTypeDiagnostic: CY4PR12MB1669:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB16690983CBA9CAD06AE093ED95F29@CY4PR12MB1669.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SPjLN9w0/Jtk9Jip0/yu7G2wZo7ymLFpLTm5ErF3IhuNn66HZJsLfAT04IQC/x7Cinv0D4fhkgqTWDv9hRwGf1ARlSUGly5YIS3wTNxurINeUe8SWMQoqRBqVCeQ2c7re1fPdc+hPenayusPGDbY9ALm4PBhc5M2+klTDAY+KTgUy5qTfe1zJxJJQfMr5eHcAU8BW3pvkm7pdnEhp2Y6z0rpw3txS+RYAq+h2lniPkDVsSE9ImX0HVSZcuCKuxrSyjYnjmX3rDJBil1N9SqE1CXVJzRL5xhUlejD7S1DZ4zRXxgP348FpsRnGgz+BkLBo3bdaKgVAr0ljvj+HLurjVtqr8+1olRaX/5HVgeioQaDIr64/QcfUdzDLFkyxUWbjTE+HUr7lZA7oBObXlARYZIjujTW4jt1UKibDniBcbwPQjKLDSjV8RFXqc27jhhD9Qys7RZBPDF9qwUKvEUNg82/Gipjto6iZxqa+Lck/YxwdEgNP+82urk4erFTyRrnD/V1ADbycDrCwwZuNqgflyJ0+KWiTSZzWYwcPcLhya5tTLnBMXtRut3YtILQ3vOCNNo3ngb83btxtXGuDJYIW2dIFMEoq30Oc6FbJ7WFrVaZnFH4kRsN2cH9mZbRv52tuXuOUJt59JAgyuhPvt1uUhfNjuw8ptwzoLF3iUrbEAmMxMxxoKNQHmmTNuEup5LL8Mrk/IiLW0ZUBSCLzR0rus4029+oD5kzrBgkULfG7E0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(83380400001)(186003)(16526019)(316002)(54906003)(47076005)(26005)(6916009)(426003)(336012)(86362001)(82310400005)(40460700003)(1076003)(2616005)(4326008)(36860700001)(70206006)(70586007)(8676002)(508600001)(5660300002)(36756003)(8936002)(2906002)(356005)(6666004)(7696005)(81166007)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 01:32:44.1837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7d142a-6d88-437c-6127-08da21a480a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1669
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
Cc: pmenzel@molgen.mpg.de, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Adding support to checkpoint/restore GWS (Global Wave Sync) queues.

Signed-off-by: David Yat Sin <david.yatsin@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                  |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 10 +++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index aff6f598ff2c..33e7ffd8e3b5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1105,7 +1105,7 @@ struct kfd_criu_queue_priv_data {
 	uint32_t priority;
 	uint32_t q_percent;
 	uint32_t doorbell_id;
-	uint32_t is_gws;
+	uint32_t gws;
 	uint32_t sdma_id;
 	uint32_t eop_ring_buffer_size;
 	uint32_t ctx_save_restore_area_size;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 6eca9509f2e3..4f58e671d39b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -636,6 +636,8 @@ static int criu_checkpoint_queue(struct kfd_process_device *pdd,
 	q_data->ctx_save_restore_area_size =
 		q->properties.ctx_save_restore_area_size;
 
+	q_data->gws = !!q->gws;
+
 	ret = pqm_checkpoint_mqd(&pdd->process->pqm, q->properties.queue_id, mqd, ctl_stack);
 	if (ret) {
 		pr_err("Failed checkpoint queue_mqd (%d)\n", ret);
@@ -743,7 +745,6 @@ static void set_queue_properties_from_criu(struct queue_properties *qp,
 					  struct kfd_criu_queue_priv_data *q_data)
 {
 	qp->is_interop = false;
-	qp->is_gws = q_data->is_gws;
 	qp->queue_percent = q_data->q_percent;
 	qp->priority = q_data->priority;
 	qp->queue_address = q_data->q_address;
@@ -826,12 +827,15 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 				NULL);
 	if (ret) {
 		pr_err("Failed to create new queue err:%d\n", ret);
-		ret = -EINVAL;
+		goto exit;
 	}
 
+	if (q_data->gws)
+		ret = pqm_set_gws(&p->pqm, q_data->q_id, pdd->dev->gws);
+
 exit:
 	if (ret)
-		pr_err("Failed to create queue (%d)\n", ret);
+		pr_err("Failed to restore queue (%d)\n", ret);
 	else
 		pr_debug("Queue id %d was restored successfully\n", queue_id);
 
-- 
2.30.2

