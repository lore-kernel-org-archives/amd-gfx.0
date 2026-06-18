Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B1ACD98E4
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 01:23:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7752E10E694;
	Thu, 18 Jun 2026 01:23:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uiA2/518";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011006.outbound.protection.outlook.com [52.101.57.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A05BB10E694
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 01:23:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGopiL7igeUuAUmoWYNANGrVF83rp/HwutaxwzI4HUwlISqoN+iFSI/0YGcz6mzkoq6Yey7VCoAsWsiY21MSJvnhQMX22ZB5sMBdQMqQ2T1iBycEJsDYwn+j+A2c2mYkyuqJYrdKXdQ3fyShq2lei6HxSKzdS81Gqgtuiegem2iyy1+X0Y/+OE5tCW1nEzjDqgPEXhiyy2/+iVTnhzi8tI4Sveq31vark+6veKRYtbvT9vWju98WJvVUhlKthrKJcB7j43aF3UNiUEWe8AnxmLLl7pEiS9tEhAnnU9W58RS1kvj0zcdjz8D7CfG5rgCRrTcN72zEeZh7Q2PltTc75w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQIUafZDBAXG6HKDmUWY9s7YY0kPxFFfhzI0JV31XYw=;
 b=ZxHYVvGnggTIPMH5K1unXyjjY5+BqhhODMQmgDE3DOJWQbTf0NLxd23htmb3QiNgzFALqvmzEKPIo1nnRjKwqxu258u2rOAUxLxk+6LbR1a1kO3HXhZflr/4UPk9b3Kw59DeVayNFbloDDwLBSqkwpgEj3OM3gb2SkSHLPQNE88qTqRox1y9LVDdtbXgwBhLf0NEhuRliN4cNUcMRAFzjIhWEMzH7xapd6NogUQJ1sp0Id2/P+AzSMH7l2ow/BAH9R4t0SStNiIinENtlIvkGaZjZzPIPUibRMoYXavG5Kj07dQJj4MBTDyi7Lwh8Q4PDvdUl7GIUDrowK10Kzlwkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQIUafZDBAXG6HKDmUWY9s7YY0kPxFFfhzI0JV31XYw=;
 b=uiA2/518AAEU3sTPYtU5DK7C9ZUr3rD7V67sVWTNZdHoXCki+pfq4sZlRNpeGPTUxT9fEV5xVzUak5rs6uxTBtz/lUwX4xJTs1kNymumTaouD8lqpTZX5RJvNLYHBdzD8/FuySmqX0xxt7ULb56NymBocL9osBMU3x/OjAbpGh8=
Received: from BN9PR03CA0604.namprd03.prod.outlook.com (2603:10b6:408:106::9)
 by SA1PR12MB7152.namprd12.prod.outlook.com (2603:10b6:806:2b2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 01:23:30 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::25) by BN9PR03CA0604.outlook.office365.com
 (2603:10b6:408:106::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Thu,
 18 Jun 2026 01:23:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 01:23:30 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 20:23:29 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Jesse.Zhang@amd.com>
CC: Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: Remove extra function
Date: Wed, 17 Jun 2026 21:23:13 -0400
Message-ID: <20260618012313.139892-2-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618012313.139892-1-Amber.Lin@amd.com>
References: <20260618012313.139892-1-Amber.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|SA1PR12MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c7ceac5-c313-4932-0d90-08deccd834d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: NjPNd5KmgUi8r15sd4CC4EnBhkdHHJfnJTHjPzoUhjNpgya4Tq1bn6+I4Rrw+UPQQfBh8s6plDZdco4XLOTSZAGBDpFiYel90JU3KLApHSUjRIXmX7R1mj03C2hBOk7Q8ncj2OQjXS0xKBYL+vX/bMQ2N1WTx3a/k3L0UwSI9FyjyK8T7mNLngCVFRc5cyDmo39Cqq7O7sJFjMMiFUsy5G+a+nSq5Bz4XTZiQgyvUmXWT0UFOuH+6avh8wQYgvgqYJ+8j9L/DVu+KHxjlbE4+4UZY4pohkuRxUqzDdYxXA5T6IoYUe5zvoo6NH9OHoE4Mcken3K4FSUTOW1GxRo5Q5ZcGB/fHkSZyC+0rRiEMSprC6yb2fWA+26eLlcfxLKEC3ueDciU8mQv6cKJ5U/fJp1lgfYel5a44JJArZ20aOhaRnUvwmfVz6szV07wEBExR+ux/U9+1X6toOmLTstgeYtQ9dvm0TpRVgAjMeP4SHBBI6EVFdu5tXta5p+4j0+le4sJD/J+ENf1hT7XALSyX1DDP4oNLftD+YZwT8IHFxz89QGgktEjBHiBBRuNCHhAtO99RDAboAqGZCbyqRSQQR3+3YYiRIFZTsD5g3wFfoR2U22yHawu9ruAl+t76ElhqUjZc1+j0emquJdXfyFxgVWts51H181ByZsGjlD8nbeyqRy8HcjOBZXrnE+cCaqE0ZoXiNnG8WOoBba+AtEtPunOuXs4epOT1J6IgrGIlXM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cO0BwhHb+DClXovZjit9K0m2WWVxWCT8xRky6w+583ysqW9jdrk0bwtdXwm2uabx9ycgBd+ZSHkSOOJCm8UvuVFo7z/yr4BJXWTlM4QwQd0SyQvWdqMj/Ys8A1OrbsXbYh2nYXFzD3jheiqdR+/oEPSyaQmvBqVYmePkkdt88BUiGDYXiLQoTP6Rrv/LHf4UjFHyW6+XoV/19cC/fQAgCZHpTZGELeEkrH9I7wvOSTNHfDokJuC5nzx6hwicjWKLuzoF/i7dfGMZke6zS4stY6FPuU/g0Kmtpw49hSujX2lJXyMPi1Dz8Rs6NKa/S1NPqTS0zrcH6wk/ndDIIHrnE7RNFXJnaOBe0/F4cTBcd43v1yNL2BB7JlwGoI30lneYRsHPRZ88+8AJ1G2KkGFOJKa0WDjEaXEtCc72IQiu615XXO7Kt/pnnoAGpQpy5Css
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 01:23:30.4265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7ceac5-c313-4932-0d90-08deccd834d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7152
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

recover_bad_queue_mes is not needed. Call reset_queues_mes directly.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 4e60d9364e37..83be54372b18 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -72,11 +72,11 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 				struct queue *q, const uint32_t *restore_sdma_id);
 
 static int reset_queues_on_hws_hang(struct device_queue_manager *dqm, bool is_sdma);
-static int recover_bad_queue_mes(struct device_queue_manager *dqm, struct queue *q);
 static struct queue *find_queue_by_doorbell_offset(struct device_queue_manager *dqm,
 						   u32 doorbell_offset);
 static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q,
 			       struct qcm_process_device *qpd);
+static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q);
 
 static inline
 enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum kfd_queue_type type)
@@ -333,11 +333,12 @@ static int remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, st
 	amdgpu_mes_unlock(&adev->mes);
 	up_read(&adev->reset_domain->sem);
 
+	/* If is_for_reset set, it is a mes internal cleanup */
 	if (!r || is_for_reset)
 		return r;
 
-	/* remove_hw_queue failed. try to recover */
-	r = recover_bad_queue_mes(dqm, q);
+	/* remove_hw_queue failure indicates a queue hang. reset the queue */
+	r = reset_queues_mes(dqm, q);
 	if (r && amdgpu_gpu_recovery) {
 		dev_err(adev->dev, "failed to remove queue from MES, doorbell=0x%x\n",
 			q->properties.doorbell_off);
@@ -488,16 +489,6 @@ static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q)
 	return r;
 }
 
-static int recover_bad_queue_mes(struct device_queue_manager *dqm, struct queue *q)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
-	int r = 0;
-
-	r = reset_queues_mes(dqm, q);
-
-	return r;
-}
-
 static void increment_queue_count(struct device_queue_manager *dqm,
 				  struct qcm_process_device *qpd,
 				  struct queue *q)
@@ -3269,7 +3260,7 @@ int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32 doorbel
 
 		list_for_each_entry(q, &qpd->queues_list, list) {
 			if (q->doorbell_id == doorbell_id && q->properties.is_active) {
-				recover_bad_queue_mes(dqm, q);
+				reset_queues_mes(dqm, q);
 				q->properties.is_evicted = true;
 				q->properties.is_active = false;
 				decrement_queue_count(dqm, qpd, q);
-- 
2.43.0

