Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB4FC61DF0
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 05:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03FEA10E251;
	Mon, 31 Aug 2026 05:25:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XYC7phKt";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E68610E251
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 05:25:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1rwb+7yvYpMAk1PU/gosl6IEmYCce7iRBSNw6k3z5cKdA2uLzBxrY0ypVDkqGJ8wwbH43W0SBOeNw5lU3lKDv331vh6bNdWtIrG5LdYaWIPw5HXdpIYUCvRLmAxMx63V7Uj7fYCUVrAn3BOVJfkwonUDM5v/1aHzDbh1Y2XkrAnjiqzl6yPUPRi92EVZQpw8JQkTLwdK3jbTjOrPA9NoFXhYLwv7KAaLGU7w6bplUrSI077haxg3gbpVCVTskXNyPNGOBYa3aFV8wogwZ1wBkrT1OB23DhYMiGFiL0biIHsN9xQig4Pkt8GQ5KEiVLmLgDOP2nQ4rsUfxDhOUhbbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZ0oTGXcAjdk4OL3zH9oLM3QlJxaQ73qKA1e2wSu2io=;
 b=mE5ERvOfvECF6zpHNVAjt7kdWQYlFlcIV/yojISaOpdo0bynXA/d4/nysO5qKxehSgvWY5UuwRXPw/PfY9dg217Q7c8z9/TzuiCWMCwV5d4dbQwyQFWw+GuQyvq/iw7jGMH+osItZ0e7aTUBt8N3vFi9NxZAqE7jTqrS9mwPhEAwCSArOxfCIugMPxDz0ohZt646Hnip/LkxVquZcEqalVxkTom8TJC2yV0BAFjKRCHPkbau/IhdQBEUvoOtjLQNRkuboklQaaBDjww5SN7+7V4P/PKJQcA71AKi+712EDUSSPKjDyCVeNpOSLTtGA7Xjfn1O+ajDLN8heVS74VYZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZ0oTGXcAjdk4OL3zH9oLM3QlJxaQ73qKA1e2wSu2io=;
 b=XYC7phKtfyX0X8maEYTRv+xJ2PjsCt/YxGmvQLHA2xKFRMQNSB4IMe+8OL+C6chh++9AtsFU0pGA3E4P6eL8JxGZpkpb0EKkAXguH9+pVN/+8UvClDyTn4JJUdoM9vqCZDsrh7luJT+SHBv4jA9Cj1vIqL2YHzOHd+pATwZtJSE=
Received: from BY3PR10CA0029.namprd10.prod.outlook.com (2603:10b6:a03:255::34)
 by BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 05:25:17 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::30) by BY3PR10CA0029.outlook.office365.com
 (2603:10b6:a03:255::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 05:25:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 05:25:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 00:25:16 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 00:25:15 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 00:25:14 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V3 01/10] drm/amdgpu/mes_userqueue: refactor mqd_update into
 per-IP helpers
Date: Mon, 31 Aug 2026 13:24:13 +0800
Message-ID: <20260831052513.1518180-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|BY5PR12MB4049:EE_
X-MS-Office365-Filtering-Correlation-Id: 7367e8d6-44e4-4ebd-6031-08df07203de5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: jWaGIYjryXwvs4OjX5FUg8XYe8x8w8ssxlcVCbQaJdqreBkh3+fRV/xHtCbxQAGIIRQ3mNyzLOamGqFN89jWq/PLf9hNoOEypyfnBN6z6pZfxRVXrOvPjKP4CwIGdaDoDfBCY7tESIzGZ7YKoog46UQxeH1GYjd0W9k3SfD2AMwlh66e+W/wjWpBfFfZWe2zBFu1Tjy+k8urkLLse+N3UKEyw7Q96rDB9BoxpKytx0gj3HayQ7KloEXlGVjcl3HIA4PCfRE+eBKhhoO+QXtk4g5J9xyry0jQMg7w3586NZTvuSEmtUY8Sr7Py82LbXZqQyZkwlfCIloCZn27LpaLH9GyKezuXAD2asqh6YLanr3c8VJy9IIxqP8W7TnTPLC7ECzYBEd7kqb1T7x8/H63huJXmpvwcITPq2q6ssH5Fvp89b78nltM36tCTuER0IswdE5nah2yUQVooK9kg2yDnB67xPvnQuCbj2IYB8ptZYCg8FB7TwsmcNupx07eqz6jQepSsgc723h2uoDYsP8KGfYCiSAiu/8BoAeFiGLjFSCTsoUNRb4d8Tc+aWyBE/OaqsSqxq3Zj2KY3VvxQIz92A10mGIX/9d6Q1ah0qEmDRdR1cRyKFIyYTdIAliqknBTj72RFsZ/9gr/kWZvcFQvypxCtqaORexOtip9R1bCQGdONcDAndvrpYrlV0n4Ro9819G2NNBd5SuGEO7w3XzpEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wXcPZ+p99zJL30GeigT2IC9XizXlQ7Z/bMKY3dEDfcyZ52y8r4yl62wVVcmHW1SW98hW9BzYQgBEc7Hk9I2SHM9nNmxqZ0G2bzx/KNlNSuHmCAFJ/T4ZlcDh6fSiUAq1sCLE610fmJX25Yd8mJ9h2CvN6HE3Snk0HOmWXOtREHe6EqUMmLDTxJ6k2jN5JpfXetVA+vs8wxCUHxINNmmD8GNU59QM1lc95YH1JVGRFApP0Cdw9yQoU5y4jyu3ux5kFqJcV8NOtNSZ46HeYlvIhmQC07hykbxkbO19g5i4n7sRlEUOCb7WIEnCHQk6MJkdyBHMOcwKyBh4aBDmxhijNC8be0nhcO5UHusf0LkmeKjCmVtc3AfdxcIOkc7kig/SH01IxcZgG2mBU/HTG9WFc/K+2mWKKVQRVh3NW/7VZ5IOYxPGOW/DrBqfiYxebUkN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 05:25:16.7410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7367e8d6-44e4-4ebd-6031-08df07203de5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049
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

Split the inlined compute path out of mes_userq_mqd_update() into
mes_userq_compute_mqd_update() and turn the former into a dispatcher that
switches on queue_type, giving other IPs an obvious place to hook in.

No functional change.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index ad72ced472dd..82bb4369451e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -681,7 +681,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	return r;
 }
 
-static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue, struct drm_amdgpu_userq_in *args_in)
+static int mes_userq_compute_mqd_update(struct amdgpu_usermode_queue *queue,
+					struct drm_amdgpu_userq_in *args_in)
 {
 	int retval = 0;
 	struct amdgpu_device *adev = queue->userq_mgr->adev;
@@ -689,12 +690,6 @@ static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue, struct drm_
 	struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
 	struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd_v11;
 
-	if (!queue || !userq_props)
-		return -EINVAL;
-
-	if (queue->queue_type != AMDGPU_HW_IP_COMPUTE)
-		return -EINVAL;
-
 	if (args_in->mqd_size != sizeof(*compute_mqd_v11)) {
 		DRM_ERROR("Invalid compute IP MQD size\n");
 		return -EINVAL;
@@ -720,6 +715,19 @@ static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue, struct drm_
 	return retval;
 }
 
+static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue, struct drm_amdgpu_userq_in *args_in)
+{
+	if (!queue || !queue->userq_prop)
+		return -EINVAL;
+
+	switch (queue->queue_type) {
+	case AMDGPU_HW_IP_COMPUTE:
+		return mes_userq_compute_mqd_update(queue, args_in);
+	default:
+		return -EINVAL;
+	}
+}
+
 static void mes_userq_mqd_destroy(struct amdgpu_usermode_queue *queue)
 {
 
-- 
2.49.0

