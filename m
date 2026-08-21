Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD6DC5DF87
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 09:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E422010F2BC;
	Fri, 21 Aug 2026 09:54:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m5txIWcy";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012052.outbound.protection.outlook.com
 [40.93.195.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA39910F2BC
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 09:54:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQc3JzgGBhPT65ue9RkpOb0qvfgNWJwdQPmmiKm8M8zlVGdMbOYrS4CspSRrAU3RFmgcO5gLrnlThnO8D1BvpNr4WGpHyiiVqsmNYXBHKmPhxXyXqH09Xkgk5jItjI33Vezfudps/IHIcAr64yYc/7+vUzrJIDxvPT5oZnYZBNz/8R3qZPQs8wEYu75jkkEcg8NSaGt1yywPGFWtSmx9muc3HJ2veZwRz+UxkmuwM7P9YVE7YAcoH7YFdvjH9rlg/KeXc+j6PcaAIJVMYLGs1ehnIOFzJV+Xx8qv5dZdfPHB8xeH5oOTSZ00pD4jPNnvfQjl6kPPtXMs543fRZ7vpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZ0oTGXcAjdk4OL3zH9oLM3QlJxaQ73qKA1e2wSu2io=;
 b=WeFADcsW3wacQQ2/ESE+ub4Gz1l/Ii3uKK3ITcXkJQARDjSs1GUflcIDKFRtvQTVrlXpV0Y6rX7n5A7txWzE8Ik+Byse5F8lx60jCv5z70oTqb3ismU352PxvjrIq/Jd8Of+kvOrvwCFe5Zd0KeedWhySqy+3F7TUHBHmCZ4l5GPa9+I+a2WfmoZAA7/htmCvl2Ve8pk+S7yxA+r4geLc0lqIttFz4t56TLz7DsNR4/dy6XJ73VuRAja6cdFN4ugV7AH3cPx8T533vrp0aymv3Fh2tfCs0k/5RZ0cRUqYtBBKUPtMJ0nstdOsWKHdzXVlaNNRoN92YaksICKTRShXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZ0oTGXcAjdk4OL3zH9oLM3QlJxaQ73qKA1e2wSu2io=;
 b=m5txIWcyZZRJI5TknQNqeUw1VI7pUiC7g1728/MUZk+IKXagdNFCk1qBuckU3BzEftabVWNPankIBc8EnUTCoOVEXovP/6q271sWGouykH5y9VKunNyLYsWteuWdV9PmoeSF93Dn34eKhAXDel1MDNg0Y00K/hHE3fehR7eYFn4=
Received: from BY5PR04CA0017.namprd04.prod.outlook.com (2603:10b6:a03:1d0::27)
 by DM3PR12MB9434.namprd12.prod.outlook.com (2603:10b6:0:4b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 09:54:30 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::15) by BY5PR04CA0017.outlook.office365.com
 (2603:10b6:a03:1d0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 09:54:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 09:54:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 04:54:29 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 04:54:29 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 04:54:28 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 01/10] drm/amdgpu/mes_userqueue: refactor mqd_update into
 per-IP helpers
Date: Fri, 21 Aug 2026 17:52:10 +0800
Message-ID: <20260821095427.2361126-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|DM3PR12MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: 778b6060-a02e-4ffb-55ce-08deff6a31f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: MmE76pQPqrOePvXd6OWhgPiTrcQMOnlKStrjMAxsmqaNzmJyAfeesGTxPDzNfNkXs8UyVbQlIqeEU5d4K6YZusQTdv9m/Fkdb6vS79SrmU6Wpl8Iqf1sVL9mOsKjIQhZLZ+HaVEO1HIcnBFOQbwGm3ejDcB2WWg3XSw2j3zJKylAWLW1Ja1zm1+tZxR+GXSmLmLGhrtEyG/mzVxtwES+i06TX6CUKL8/J24iTkyDoy6qsHL0sfFCz8kKLN+uANoLuY60YDe+51w1Yh09yioRyPrFmD/WWjcBn41bJyZNI2Y0j+NlnxN82E+9VDMIHH59ezk+MKtcPJTOg1AZlPdnbCsz4fgiypZhVE+tw0x8gGr7tZXmUV2DiXWEiKcL/XeI3BIvt73V+T3gVhsoS+abB+7gbpFeQagReuSFsNm1V9YkwmdSXAxWzdEB8ddugNq8A6qkkSrpcGS5lskKCWb/OI8NzSG8HPINy6RdVRKq/VePbiyjvn9j7cKsoVTzkn6kWyDRK3+FVDENDP/NPhM4ujYcrAyZ1FWy6M/f/3Pj0elYswDoBPG+tkz2IHKh+W7LH8+ayLl/dWwyqE+SSgFkA1l3ZgIAyzpLYfs8MPEKuA2Hkz0thNcWjVZWBTZwZgXrlFscNc1AjgTTeanqHMSdikX/qVyEShn0tqvyU9e5zRnD/hk2o5OuYOVgIfHIz+1374pS0VdCy14/9DcqSRG/iw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1qBJ0AKHmWzawghD0R3Ivft31QWpCFUgOLyR+sEcKVpyS3lnSkMAzZ9bvrBp//oWrnmb4q8TACnkoUrjOfXdJtVafICQ8SlprAEYR2MAnEKInNyDGK7GEt1OgduRMIBlJouQhh07Uc4VJnGbw/7Mm0GItr1oE+2NO2+QZi82rOpVsxWFfIUZlyu4TvRBJel4dks2sc+dkDxkIO7wjs4EGnPckehAb0lVQOUnXcUTf1PbBUuPCNIIprwJkNdykWV2GLO6UhOs5UpZG98xORPHEwyK7ltX1+vv6nSxzh8iWPCz/zGm7Cv56E5ta4taqCn8XhsW28+4ISEDog2eqJgMHHkP6PQ5HRikCWdqzssALeX0v6pSXO7Nycwgnli4QJbIDpgPpkucrZ4GKE1WBwkcO0UBBpbp1Ta98ACyNMaqA1pLShke73th2qpZ2U631WBJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 09:54:30.1753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 778b6060-a02e-4ffb-55ce-08deff6a31f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9434
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

