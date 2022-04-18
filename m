Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C86EC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Apr 2022 16:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE6E010E12F;
	Mon, 18 Apr 2022 16:44:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4DBF10E12F
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Apr 2022 16:44:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akre19563haY42Dx+Pmrz5Mg843Rh0U0/PYk7KS4aajmn1DKi1zs1paBAlLeYJmp+WK7YW72gziiyccWlzt8/rknv5XYP7OucFR0sX1AD+wfSI153DuNMOjW43fu3lADNFPy0SQ8CZituDO9g+I9Gg4pSoy1k7TQtv37UidCZIwvSI0xAITERAztrUea24cmz9AWrN4RbTi1X1gurkUMpfrIOb/6zOjWA7JhY0IocI5tIYrBGGx+fjXol23hY45yL80CE0l47CoQnFA6gIKVRTlCAxABlsrCwbHkl9UxX3IIgsAsnLxIe6tFmoJWhy5ur/1/RHjYNIHtdbLWIwTzlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tb19PxvmL/hLz6q92uyQyh/QLb/qUlwD/WqLIdfZOY=;
 b=WlTdFMpK5BVnK6tnT1umQemXxQRyG4NieG7gya20OVa+ZJNFrFgZ6uDk3t0pLllh8UcdOgV5Qp3wXwD5pZPqIoEhJh2O6JxjmA0a6hSqlR0kakyQncLygNydA2+0fG/JMTVA8G+STFSUPaqeK+5PNkStDnmw3vBpjLG7Ximm9B8w/2nuBgIXv4e8pRKVLZl3Xpuz8G00w8aoOo87p+jsu060YO2ADB9hADacl25hPwvuT8jSkaN//rCINKVWmxKqpCAMX7Nz3SLNnxF1Ln4oGcQc5t4X0BHcMrDJr3AjZpHTulv9eYLiVBOr1bLpDSdXAydh+pAYNhSELmcpVnT3zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tb19PxvmL/hLz6q92uyQyh/QLb/qUlwD/WqLIdfZOY=;
 b=gyhw4BYJDCRVLPynD92XAzkpxkv/1XwDNRbsJFWZV2c0/KF5h3Kf1iT7SBq0ldsaVHIokmOoReBLBIyrfCZV3xN1yEjdMcca+EOtHJj+wXsgL0pr35KWFRZ7OYsCbOyjNHDErn4Bl9zs1ENYaHsRUuODgvZcO5atbgrab8FRvB8=
Received: from BN9PR03CA0961.namprd03.prod.outlook.com (2603:10b6:408:109::6)
 by DM6PR12MB3546.namprd12.prod.outlook.com (2603:10b6:5:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Mon, 18 Apr
 2022 16:44:50 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::14) by BN9PR03CA0961.outlook.office365.com
 (2603:10b6:408:109::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Mon, 18 Apr 2022 16:44:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Mon, 18 Apr 2022 16:44:49 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 18 Apr
 2022 11:44:48 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amdkfd: CRIU add support for GWS queues
Date: Mon, 18 Apr 2022 12:44:37 -0400
Message-ID: <20220418164437.1875319-2-david.yatsin@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220418164437.1875319-1-david.yatsin@amd.com>
References: <20220418164437.1875319-1-david.yatsin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb7375b7-b256-4373-927d-08da215ac144
X-MS-TrafficTypeDiagnostic: DM6PR12MB3546:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3546D663BB287C52072774AA95F39@DM6PR12MB3546.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: czhnBO8k0fk9J3UyQxjeeUpObGnyGf1rZg71mve5cllicEMdyrhAX2cka5hmgv/TDRm+qoy5Q03OU81yxI3LQKEllOm84NcnXeaplZyqW2DlZTh0q3ViFQgqzqChszpJg4Ej7DoQSQ2AD6cBSKn7molE4qjKCt9HA0bCjjG3NC15XGbmwJnlTYlWwVoygqQINtavIrExt5X1k+RlMXRKK9u4iFuze2pE53l7liXntyGtUfnLB8M82MNbpOf6etqx1alfELA5ha31JNx8OdN1qU1jMZ3xvTynipAe4/iHPZgRo5xsf9iV/LCeg/ma2TdRgTT5C3xNGmj89EN/AHisI5qbUdtfgYmT8sty05wn99A7hqeLtRuVbfPRnaLK65gf9cvJ7sMW5kQhXeyg3pZQBUeqqXXTtjFCD8Mzjo4wAqf3ymVwNXbwDNrSQV5hm9lxemGCv41LJhdZ2cRweYtJs7qRcSb+CZw1viRbPrvSwg4J4rp9a3idvD/9xLvvpH6Ob6KjXn0EGAt9oBz6k580YDKu+hm0SNMvVG+Y+/fSk6Zj4DJcJ3EypjgbV1fcL8ioz7d9N05PBxOt2MvnyebbNqBaOxm7DfWcifB9NBMJ59871F23sJp6pl6Vlym7yUi0Z0eQXY7yvpMWFxdUwlcd5ojaq9Sjwjno4ZDJS6757dwNFJ8sf342uUKTqK+RESYgL4AwC+RgnL9PVmJZyy4dn1ABtXMYFr4tLK2v9EdI3kA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(6666004)(81166007)(186003)(426003)(47076005)(26005)(16526019)(336012)(83380400001)(54906003)(6916009)(2616005)(1076003)(356005)(316002)(2906002)(82310400005)(7696005)(508600001)(86362001)(5660300002)(8936002)(8676002)(70206006)(70586007)(4326008)(36860700001)(40460700003)(36756003)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 16:44:49.8835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7375b7-b256-4373-927d-08da215ac144
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3546
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Adding support to checkpoint/restore GWS(Global Wave Sync) queues.

Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                  |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 10 +++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index f36062be9ca8..192dbef04c43 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1102,7 +1102,7 @@ struct kfd_criu_queue_priv_data {
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

