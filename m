Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA875C79F9E
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 01:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D10310E076;
	Mon,  7 Sep 2026 01:46:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="twLsUO8E";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5E1E10E076
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 01:46:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwYcS6WwJERBYYC2d/YYmZ1GFG08JGJtWRQV5z74HPM6ws5LTh9gbx7ISuTMJ1Ou230+Yr5mTlAQ2QYaMnbM7kpeqBgJbfbR9Mh2PtU960LDehLQn+P/x1EGAh1ygKX6NhoI3Rb+j0ECWH1cvhBRUg8ryOdRevvh0P98Dce2eVeWqZ1wP1MmgJy7AefU+0d0ZRKMO4DNLqGPWYRYdI0Pdg9XTEE1KInrJGbGMUUPBWPZb4I5IllZkmUeaih1EOyAHMhX1xLJAPEX0XAAZz8jXEi52URLSQh99eHGG4TqHJ8P80aswLa83zJKKvlMNfG9+zhd/2LZhiviLVIa7TU/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZ0oTGXcAjdk4OL3zH9oLM3QlJxaQ73qKA1e2wSu2io=;
 b=GUWcaz1bOVcEsa60TcTyNN57IREDg3dRtimqrJP5gk1lhPLRwUh7xsE0lIZLWQyClFYzJ6nETLkWeGaAjXhA53NvefeEIG4x1HkNV6YtHS67z5cebwLjVOwJcMdF3RZK4O1FAk0Mp95pXdajomt04AuyDbdKT8CVQv1iEASYUcCaOg8ADjxS5RR2qfxP06Sbnf7mY4hJMm63j/OBU2QTXr6++rwzDpiES9jEk3PfhddBuBDbCOutyy/lmfNopk4f0Evmrj91+HQ93i0nXWiForMRN5/2h7RSIfbwXBpSSBhQ5MwsUjVD4L2IB6udoLcZKcKEkkppTfTljCaYx6+GaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZ0oTGXcAjdk4OL3zH9oLM3QlJxaQ73qKA1e2wSu2io=;
 b=twLsUO8Ej2yB7drzXGf6ihhS4VBFx7NsjeDK1wOat3VU95HzM4SWElkZFSaEySuStNOh7AgWTCt+DnhgImw+gMi16Vq4hF5NInatUWI9CBV188JEdGWa5EwnmmMb80TzVWI6C0yjUY82eO9fiurprXXTESz90oNwu2BXrruEYv8=
Received: from BN9PR03CA0505.namprd03.prod.outlook.com (2603:10b6:408:130::30)
 by SJ2PR12MB8182.namprd12.prod.outlook.com (2603:10b6:a03:4fd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 01:46:38 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::61) by BN9PR03CA0505.outlook.office365.com
 (2603:10b6:408:130::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 01:46:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 01:46:37 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 6 Sep
 2026 20:46:36 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Sun, 6 Sep 2026 20:46:35 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v4 1/8] drm/amdgpu/mes_userqueue: refactor mqd_update into
 per-IP helpers
Date: Mon, 7 Sep 2026 09:45:28 +0800
Message-ID: <20260907014629.2186163-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|SJ2PR12MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d2010a-b781-4f30-0126-08df0c81db36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: pEpaLlxSV/T+OM4I0esXRlVRCenNUZ0HxAuRegZX3lGvg9xZPohWbhYE7J4pMkgetDlO2g1d9dPlnmjK+0PJ9guPnR49UoHFUrcrZcj9kBD6IWbTgcPTs6dJoFkvD491gOx6/59KG9ZUst8b/18g7bHsxAocpEcf0HUv7t0w2yiif9pHJMesTMCl5U+jldcDaKyumgBQkZrxxtKbagFrN1FyaNq6VLDAfATw9ZDLzOCZNKcr5jPzdDkIWrzJC9nlZGP2+9wsRmh9iTlw7iSHIJFccbjGa86MHvbEmJ4q6+dl6Bp0qLABZApfwkfJk0ei1voN7OPKviKynxG32heBVwm7zehDoMqiNQ61kcu4SYPU0oAFL9jwrms0FxY1Q2UDBLV7qdV6aapmlnaNwpXHr1YrtVEpU2y0ACuoJb7dDg9TTQVCK5n4HHQSP8gdx5/Qj0/kKuqYiBP9uwdZSjZSs/n7h69U8SZo80uPs64BGaS/Xn6Y2AJdv9ijSxPLSmbmlUFORYTT5f3DzRvpQV1r89BThHhzFWC1jdBNe92qBBxnW93r/MFmJHQrPv5jee8rF2v9HT0b2S/DoVPSZ5meoh3ISevaJ745rTD0c7mxDNOMq9pwAUZLWHDsWQNE6g/diGR7wds+0jebs9qvyCTlFB8ezhFHqxr/UdMFoZ7V+X9T/NJlt8zpX2Y1HgcgJK80AkBMMt9mT9LAlZRbW640WA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DpNjdnLP862qpBCSm41lgkFz2zOWgjnwgXqSqN0E1GW3rcChe1ePPa8c8g5hAy2O/HGlHqbaFPi4RW75KcvPWLd5u05v36osxzlfYzMpT9biSOzmaqGJLSlINI+FH62YoI/K/jBnL1+nm/xmzKG1NDc9kJOI0vcKVy4wGgyHHHepqmSfUUa+T2dIRQmjRwDZFuAtZUHto5KthzjcG5pVfliaSavrxlswuNbfU8mRaBBAOuv/9lSilSXSVCF+F0NVwxwjdBtQPtOwJ4A+eR9c/s9l+wS/C9OK+mndXWwZw8muk2hi8jZPtzcmuIR0six24ygtPrkbXGhZL7MbJE3+MDqzGWHpX7pjqU6EHTmFJOeQBXtQvrMTp+V93zpxA600b7Bh0jWZhaF4MNL+gQQf1E0hmVO4YV1ipuyja+GScpbaIjLKuOPQsLas05oK0jSs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 01:46:37.7530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d2010a-b781-4f30-0126-08df0c81db36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8182
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

