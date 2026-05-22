Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D94DCD5BB5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:22:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C27510F475;
	Fri, 22 May 2026 00:22:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XdzLh+Nd";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC99C10E63B
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:22:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+Aev62g71sT4E14n4FQy/rqzFTVAPgHLiwB+sGgQ0zK+yQB1RqFBRK5zglK6/kVikqloUZWvrt+QMPztgvWxix4vrTWvUESN7+s0ArBr6Q+ivE/WaWRfh5/PP2UmpPwzwKsVW14Efur2kSamtfanaQUJvHgwcrgEzWDP6GQRWi0dIuzsh2UkxqErWQFKXSluq9Wv3mOkNdW3E3mhGkZLVPtV0LtaAvE8F4YGUrRS+pe1dJPJZ/rFdh7olqTusHMsT0dWs3lRnl0AEpympZ2F70g1Ee/TKToPupDNEuPyghaGzncfjQ9qsUej4gyVH/sfueeAY8ljRtG8WxKkcOpNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iK7uHRzKWaRf7aDvAlMbGiVlzfHm9PztGKVhPxWMVY=;
 b=hY/pBNyUFEdpbK1TRysOoI/dCv7oZ8IDdZiFNJee8udCqbWdarH6EsDQY6CrcFbXLaRuqw/Tic7eFEaDDNbX0pAEi5gLlANkYgBIP/zW+Img93umSuvbVSQPeWXqPyD9DJ5I/yr8K66FjKbxMeIf5ST1FeYXLCBzW5Sy726fETD7XdJZZLTxtYkQMkZj9zp0vihsaMzqxIahOqUhkTFOreHX5JYmUa3cszcIm0E9a3UxOwyTm5nScTwaRzoRM0pIeFhfAEWykPCe30wS57qoGlwezQN64xcsLHsPQdDstALlxkbVYzsNheUimKRZq0Y1LKWyJvgPzq1mtgrJyQdnyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iK7uHRzKWaRf7aDvAlMbGiVlzfHm9PztGKVhPxWMVY=;
 b=XdzLh+NdhtiisOjfhRsRVCnxGIY41bOYJnvvC9MZ3q4PbiU14Lm2UJllwPjjO0vPyTL7R4XjJFs9RUk4kG5GNY1vT8DephzpMCwGcYvoglRTFMCE5QJEXHZ9irOdPmM2dL4JjSNdXm9DiFWKuOA2pKnDknFLZOeeS/Svx/Ms6pc=
Received: from CH2PR15CA0009.namprd15.prod.outlook.com (2603:10b6:610:51::19)
 by IA4PR12MB9836.namprd12.prod.outlook.com (2603:10b6:208:5d0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Fri, 22 May
 2026 00:21:57 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::c) by CH2PR15CA0009.outlook.office365.com
 (2603:10b6:610:51::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:21:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:21:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Thu, 21 May
 2026 19:21:56 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 May
 2026 19:21:56 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:21:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 23/42] drm/amdgpu/userq: drop detect_and_reset callback
Date: Thu, 21 May 2026 20:20:29 -0400
Message-ID: <20260522002048.98506-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|IA4PR12MB9836:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e098403-3193-4a3f-dc51-08deb798226c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: k/4IsAD/Ay3oDS+ZrRtif5QO8BeFDKDJGUOgaV9NyP5HTTLB0Irfgax87DXccjAkbPwqm7b5gmwFN67qpjMj9clOSz0TXM6tPUeQg0nV/J9nN5t6vla7cxy9inj6DIPovw7p6pDR05yRrAzdMNwjCXrEcgsyKyjQB5LSH5P3Wzs2HBT+nfjSUn61ah1v2rZ1PUp1pibcgjbJEQ1Z5pQRVj8vcPg44Z3FQeFoiFWsYR1mF5VKHSu0uQT+5EnRblKsQdth1dwp/JgiwXAfJH9SA4vyVQeTavBih++yqBk7TS0w7wnpQUjnWuZxtdEOfIpsWaZN9tRM2Onb1sMjn8oAS6NqKzyGmDnXnDnnmVt8RJVW5B44rA7EyCokx/J5rRKaS3fBXpdK71CedNdhyHiTLC6hmWebr6GHF2qjRVXGGkFLEmcFRU1mgZ5aYgs2dt5Ts9ZaL/cp8IR7BZC9uBV9h48wKi/VlcSVjckIo54zf39Sy+j0td7kAd1LIo2VKezQsGGgKh9ZfNS3djBrTxIpAmwRqOO8RNasZpTXbl/w4GTSiJQO4A87g5vfdrxItGnKtzZZJzPMtYx3/OxBH4et8KcIV6M4skFjvfRyTe3/dAQaIKa25kYLes4hyCsobOCBPVr1Ve9dumAtEgD7uBd+knbRcEq1LGFwn9YmJ2BSjmhAwzGFsBOsL/QJ+hTICK0ITJCOkWtgkm0bh91vvQYmCHmxSwHXrtH0olBbtFJs5QU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(11063799006)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /bPd4wHkYBNnR+ptN1Rt9mcemOfajd2DbS13jiKiUt+D9IYbbgeOVW8kKmkhnh8ZguKT9dLkCU18ywTeLgNtn1CyHkGAhJQYr5jJbGFcqmOHtv6z1VyJN7c5AyW5rM1Hb6owM/i/T+FGBMCZnzExBz0SJXywlIx85ZgU/Q8cCgoHcDDHrDc7CU++qyucVhmQaoUtSnleHOP+wiZ+wb3/eum6lXhd6c4cZPH+ww185oB8asjSozo96Up3lMWGqwn+sCi4ZxzrV3UzhDhLz2reIy0OoK020aPUXqrQQI6TYA/HFegP/J7h98Zpay905Ad50RXHWdKza0LX7N9c4sjvUoXSkEDuUu0O+ZAIRQnEN4wG4HQEMk0pGyHeEUyxSrwkMWUGTtj1Ac+OequQImcpZN5plCr3sGScD9kvqn2FaAl/poTNQiAoedDQHfby7b+e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:21:57.3114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e098403-3193-4a3f-dc51-08deb798226c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9836
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

No longer needed.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 -
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 53 ----------------------
 2 files changed, 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 2403a5d990f23..631315f89bb19 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -106,8 +106,6 @@ struct amdgpu_userq_funcs {
 	int (*map)(struct amdgpu_usermode_queue *queue);
 	int (*preempt)(struct amdgpu_usermode_queue *queue);
 	int (*restore)(struct amdgpu_usermode_queue *queue);
-	int (*detect_and_reset)(struct amdgpu_device *adev,
-		  int queue_type);
 	int (*reset)(struct amdgpu_usermode_queue *queue);
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 4f285a8218ddb..cf7e2ab66d109 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -219,58 +219,6 @@ static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 	return 0;
 }
 
-static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
-				      int queue_type)
-{
-	int db_array_size = amdgpu_mes_get_hung_queue_db_array_size(adev);
-	struct mes_detect_and_reset_queue_input input;
-	struct amdgpu_usermode_queue *queue;
-	unsigned int hung_db_num = 0;
-	unsigned long queue_id;
-	u32 db_array[8];
-	bool found_hung_queue = false;
-	int r, i;
-
-	if (db_array_size > 8) {
-		dev_err(adev->dev, "DB array size (%d vs 8) too small\n",
-			db_array_size);
-		return -EINVAL;
-	}
-
-	memset(&input, 0x0, sizeof(struct mes_detect_and_reset_queue_input));
-
-	input.queue_type = queue_type;
-
-	amdgpu_mes_lock(&adev->mes);
-	r = amdgpu_mes_detect_and_reset_hung_queues(adev, queue_type, false,
-						    &hung_db_num, db_array, 0);
-	amdgpu_mes_unlock(&adev->mes);
-	if (r) {
-		dev_err(adev->dev, "Failed to detect and reset queues, err (%d)\n", r);
-	} else if (hung_db_num) {
-		xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
-			if (queue->queue_type == queue_type) {
-				for (i = 0; i < hung_db_num; i++) {
-					if (queue->doorbell_index == db_array[i]) {
-						queue->state = AMDGPU_USERQ_STATE_HUNG;
-						found_hung_queue = true;
-						atomic_inc(&adev->gpu_reset_counter);
-						amdgpu_userq_fence_driver_force_completion(queue);
-						drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
-					}
-				}
-			}
-		}
-	}
-
-	if (found_hung_queue) {
-		/* Resume scheduling after hang recovery */
-		r = amdgpu_mes_resume(adev, input.xcc_id);
-	}
-
-	return r;
-}
-
 static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 				struct drm_amdgpu_userq_in *args_in)
 {
@@ -545,7 +493,6 @@ const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.mqd_destroy = mes_userq_mqd_destroy,
 	.unmap = mes_userq_unmap,
 	.map = mes_userq_map,
-	.detect_and_reset = mes_userq_detect_and_reset,
 	.preempt = mes_userq_preempt,
 	.restore = mes_userq_restore,
 	.reset = mes_userq_reset,
-- 
2.54.0

