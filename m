Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B89C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 06:33:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53B7E10E134;
	Wed, 15 Jul 2026 06:33:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T/Qkrx0U";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012006.outbound.protection.outlook.com
 [40.107.200.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0F7D10E134
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 06:33:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVlQcqFc1PuVWJ+NPjvOyVs/uSFXx+jk0sEBxBDmHKM8bFUugCFxjLzdfaUxl4buYQyDA38INrv8ldaO4K6r2YslR44hJc6bngTr6RcQSD+xCJjkKLrtysYSQ0jO7yJCB9mYTq24FCmU3P+umtyGsDE9gEX5ivXLL+4yqSKwnsedt2jGFuioyCk19xKE72T1mcN4Q565GA1s2oQ6syvb0dU1PK9RuESlg7XIzdVq/k/WqImXBVL6beDqc4GRJsQZ8eQlzHDNa02rUfE8kbAf27Kd4d4Pf4fJDPaJMzPN8hoD7GLbykhuYcNCHlf81Pz8VU0PbKIBNzaPfwGwSPZ8bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwymyMWHQ88PdSYYckGexz2sn3yW+0tH1hA4g77C6s8=;
 b=MHsmKOiXcaE6jlRka5ZfLpccGUenxq6XZXO2j/ojg9K2W3fTpOdoQWfhCqLWbohNxw2QKtKI5UC8GjM+AFo/t55zVsyPX21rTtB6r96FYdUkMglL5jN2XhnTeoUNv2fqDZvNKd8EThFC3BhQ7TFfAvg4GopQXm51aeC9tvbKfUmEQykJoh7zslgjiYCH3Ig8wAulQXy6YpsjGNKHhm+8bchiHE3dWCjthB+fdPPjRD+N+iFbViM6RpzMykddLv+DkvwEFeYGFGD8dHv8iNZ6l24LJFEWuDbMRDwlnafTL9/CIjmIXjtP1I6ju6hrbcMufJD97NkV7HaAeWAnNsSfTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwymyMWHQ88PdSYYckGexz2sn3yW+0tH1hA4g77C6s8=;
 b=T/Qkrx0U9EB8ei0dOcr127f+Olh/wOSLQu9hN0XnG3XNRloBIGi/KgDvKocB0KttZaU60Qryxmu9BMioOjGCnBhWf4CP1lEH+JTqcrlNZQbWnB6SaUKz3RK8XFqkpaW2TZw5yDLxXWFPL8cg1wPnR9QLmX2SxNCXbkDFkWIzqRw=
Received: from SJ0PR03CA0333.namprd03.prod.outlook.com (2603:10b6:a03:39c::8)
 by PH7PR12MB9075.namprd12.prod.outlook.com (2603:10b6:510:2f0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 06:33:51 +0000
Received: from MW1PEPF0001615F.namprd21.prod.outlook.com
 (2603:10b6:a03:39c:cafe::af) by SJ0PR03CA0333.outlook.office365.com
 (2603:10b6:a03:39c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Wed,
 15 Jul 2026 06:33:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615F.mail.protection.outlook.com (10.167.249.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Wed, 15 Jul 2026 06:33:51 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 01:33:31 -0500
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 23:31:44 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: clean up the userq support redundant check
Date: Wed, 15 Jul 2026 14:31:28 +0800
Message-ID: <20260715063128.581232-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715063128.581232-1-Prike.Liang@amd.com>
References: <20260715063128.581232-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615F:EE_|PH7PR12MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: 725bb956-bea8-4675-18c9-08dee23b0907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: YUl+70Y3jP5W5TRnO1Ahl1OW6UEmm4gykeHh6gnFeGJ0tJVKrEjnvxAQPTrzVmHbpcQbieFRA5Y3dv+378ugR9Db8c0fqHte8vRKBOtvQOWrfxQMJiMzml5QNM3CUxAJJPx/gvr8y8Rejw92gJeknYQYrfq/1ldDP6pz8hBsGS19L8YxAactuLbBgJ8AMTt6dFWx1+C2ZCIIv97QF6M2DNQj8byRZ3c8ih0rGBClpI9vWAGQrhaAxyXr9OG6Rn4qWaY3Qc6vgG59kKin8a923O+6scnKOLgVQ7LJQjmi/2Zid+tbeiXdyAwxW0Vsrtuyh2jSCQe3hwNHZEgKWVN1nhF6EAOkfx3f4gDHHqvZdHsH+sEvMO/lACYDhrX7HzfcUPCt+RFGlPQg7Yb6sMQ7NJkcsWxc/vja5OELWPB+qRRvmpeHm9++MG40AsvRcd/bPc8lAkFTbSUH+R6Z4+z2jbDiwsIkgO5BqrhIv0wNPb8ff/u7uJbTm5KeU7eOG9DDRrVxivybMnaICroPcmDwUuCsOMs9Q6msIOLvo/wg5E0ia8pnBzeH86PFW17uir6sIG9PIVCS1U0Pt5H8Is3ZyAh6TwtrJjnDqBqTy8YoGcSZkIPRY26G1tx5xrHIdeUonMOipuEzUUGdP+zAZzWlIjP2o60ZehGPEl0t46en8HNYuFTdKMCei/4ui0kys+NqcV1qUPLhpp+qDFXH+C1IZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sICAXgW+xuIfamI2r5LJjPTnNYx3F5pCw76pamjxUDe2Yqo56NAORrJwK9zKCFLR0/SGFBWw1pibmC1x5ntKueUN1AqsxcrmmhAFBRUKTxXHqcV2vOJgbLCKMlkQX/ic/a6G89vimoga+Pv70jAqig+jWEg+fllry5UuyrwRQU0tm6avRxNu2+vIxb2aelDmYN2veOZAotumXtuNkwVcxxFSwJJR4LQmOu+HWdIHqUZvxI0m49y0zvUJtvdADxKWx+SBKHvU8fBeVZa+gNDCy4AVhx139yyASG7qCuFcyrQTfbPNA2ZkA/D8x2ZiBQIwocmyuwETgqv+lpfiNKEu9uaZBi8G13klXJFTR7zcXiPab1rYMh2n8vJSYZSvbWWFlaXfml6INNDkaJ+yXFpP/A9nnt7SF4hayurfOcZluJGHVpm+4UubeTchO69dqH2j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 06:33:51.4806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 725bb956-bea8-4675-18c9-08dee23b0907
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9075
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

If the userq doesn't support in a system. then there's no
valid userq_doorbell_xa entry to walk over and then has a
no-op.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index d34572bb6fd4..439d4047a085 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1308,15 +1308,11 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 
 int amdgpu_userq_suspend(struct amdgpu_device *adev)
 {
-	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_userq_mgr *uqm;
 	unsigned long queue_id;
 	int r;
 
-	if (!ip_mask)
-		return 0;
-
 	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
 		uqm = queue->userq_mgr;
 		cancel_delayed_work_sync(&uqm->resume_work);
@@ -1333,15 +1329,11 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
 
 int amdgpu_userq_resume(struct amdgpu_device *adev)
 {
-	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_userq_mgr *uqm;
 	unsigned long queue_id;
 	int r;
 
-	if (!ip_mask)
-		return 0;
-
 	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
 		uqm = queue->userq_mgr;
 		guard(mutex)(&uqm->userq_mutex);
-- 
2.34.1

