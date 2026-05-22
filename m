Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A59CD5BAF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:22:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2B5310F472;
	Fri, 22 May 2026 00:22:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PfIMGU5R";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2243F10E63B
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:22:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMJyXNx4XX8WdxXS8HOPRttUptQYtIOE5IV+CEYfXtwpdLg351GE+h26VQKUfIfbKD6pStfMc9avCBykgmgssNbwtLG/om1rvq9aDengLu74R2FwbznvLf54zQu6D/3DBaO4p+xbZeznOsQbCktex/UbnJ8+Kxg2LDEkiWALwhs3wDWc2Qv9TJfT0HotVBcqrOLnNogpKz8DUd+MV51Zx1rP0d/XTXWyZvfAh4vby5fZkygC/YenT7Stu1Kaai7G7JTFAPadL5qYUf4Bn+6k52g8smDyphcFtdgCvsGnm8OCk25YE/kr4Ux//Z+SO+ofM4YDCMaSIeJmf7a6zivv5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOCMmIsCb0PeDAq5C2G0aFbvhyKjykXM9pLaWEZep9w=;
 b=gUqGy0CjAbUfB7/bgSMVu2WHNPmGkXZc+LW2/b8DVOnBNhZI8otO82ekCsZ/e/ymjHhBys0NmPRownlAzIuOvLqI9puvKjKB9MyGzf13hComGSiqbdt0nL6OrTCCEoLjyPFRL8alwRIJlGzyHgImRYsM2kVVWX4wv3f8U0lZicRXboU5YeP3vK2dEW6CIzTMxxSKYsjKSt84QIUCE2wO5nwPs7hTiOiduCNmW5zJvGxe2Z082VQnxPCami3e+zdZe7FLbiN8v/urQW1ygLG1bSK6w9rp0xzDE6ty31vcnPgmlnuZlJLQW/EjJKivhWHhyDltF1pNvU6CR5o7AHqpXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOCMmIsCb0PeDAq5C2G0aFbvhyKjykXM9pLaWEZep9w=;
 b=PfIMGU5RAYyjG3a5X9+7LYOj1sdU7hmx5gbb0MhqOhdXcWmSIJKoTLHTv8HGbyI7GW4sW2dsRI6iRECT2zo8zrRITgAQz4PwoQLEqrK7HxNSpUKL431UlJa2vVaG1d1yfywHrj9vnH54OMJCpN01jybs73uhF0lUxWW/nMAOrtM=
Received: from CH2PR11CA0007.namprd11.prod.outlook.com (2603:10b6:610:54::17)
 by BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Fri, 22 May
 2026 00:21:56 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::94) by CH2PR11CA0007.outlook.office365.com
 (2603:10b6:610:54::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.21 via Frontend Transport; Fri,
 22 May 2026 00:21:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:21:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:21:55 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:21:55 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:21:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 21/42] drm/amdgpu/userq: add mes userq reset callback
Date: Thu, 21 May 2026 20:20:27 -0400
Message-ID: <20260522002048.98506-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|BY5PR12MB4292:EE_
X-MS-Office365-Filtering-Correlation-Id: cb8ddb9a-3643-4bdb-f63d-08deb7982174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|11063799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rpB7WMzndjQlycOlinBfqkNb3bMLL0JdP3HWDArgnA7RxKWdPs4ht+sSJy4IOwFM7iOihNSdr4k7xvIs6znNwwk4MbvTk0oXmAxF9uNSMU4B9hTZd9AZkjBiTuXZ+gIU2urqQeUCAngguwAE9xt8KtVR1rIh64mDUlNniLMKUOIHTa5pRfTPFbLuAW59ES0uUQd0Hq67MUlOMa5GIPJ3rjbEvTsbLp/F7GJ0BABzWItTVkUfo1lY9xoAtyIg1MO/miBg3gRt2mP+tkkwSUPoawU6mwP1G40dWc+AyNl1iKUg4cKAqyx89ZQX6HG0lHX+6vlPSZLwNW1QS2ojLdvzwWlPtNddhSnjxUjIqR1aSMXS9rGJC5OQ5jgT6aCEgtl2NgRhgsJ6seGzIwM3LtGdgMu49h5We4Q1P4rQoqvaUkM986EE6BH48KNtZXWncOUSMhYi6xenchb6gtezzvqcBs9FnTTHbtJJ+IiyVSjCSfHZTmTFlsf9MknrCETAl/1b0vHuFHxuEHTYTq/7idwBmaJ0HK+SLC31fX/dNar8webI1w7hGYN9Pca6XQuG+6QcIY454acN5BXNvq8q5MvXBVL3JlF2fUQ60S5SuBmbf9CJ3zTKk29G7FenE0CcspS3fKp0Z82RjJqTJduI4Vym5bDwHwyFoJBgQn5j1bvvjyU2W2oiPtpsjAV3m2VIeKaCYMwCyPgq7TaJJhGZVq+rsacLErRqghFfn07txkGOPaM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dy7F0pcDg8zZKFyspPkmBLr+6sbBv0RrUXQnJ+o1luGFE1cV5kB+7pyVGpoTLYLqkyLzV+jyIuY0QdAGShH28EmPjkoWNTMkSsuLHmLmYKaRqIdbIt3V0QhDVvUa/cJxyAmOQH4wyEa7M22Cm+WhXAv+OyQiqaJ9SZyLBawIFvU/btRqjT+9e/SwF9+pbOxD6dQ0K1AdqOE/zvwvAbBy//9IuRijz31kKnK5pmCP+ucFBvWH3U6srB2FD6m43VPtP+RbjPTF/hHQ6KhdqXm3wGYEdQaWinvPrmiST2w6Fjs8KqcE6yOYf9hxZyXFd4eBplKjsF23Wp3wnegmLj46UHRQf17Jt+rfhMZ/PaT3E1ObGEYGuvz+wrA1h23Glp/66KvRopxnxNpEVIQ940hGLQ3ZaboIcm8doMVSdhE9BxOyz4ZBRm7wVpbNrHyg04a2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:21:55.6874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8ddb9a-3643-4bdb-f63d-08deb7982174
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292
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

Enable per queue reset for MES managed queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 14db2124ff81c..4f285a8218ddb 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -177,6 +177,26 @@ static int mes_userq_unmap(struct amdgpu_usermode_queue *queue)
 	return r;
 }
 
+static int mes_userq_reset(struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct mes_reset_queue_input queue_input;
+	int r;
+
+	/* XXX: add a FW version check for SDMA per queue reset */
+	memset(&queue_input, 0x0, sizeof(struct mes_reset_queue_input));
+	queue_input.doorbell_offset = queue->doorbell_index;
+	queue_input.queue_type = queue->queue_type;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r)
+		return r;
+	return mes_userq_unmap(queue);
+}
+
 static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 				      struct amdgpu_usermode_queue *queue,
 				      struct drm_amdgpu_userq_in *mqd_user)
@@ -528,4 +548,5 @@ const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.detect_and_reset = mes_userq_detect_and_reset,
 	.preempt = mes_userq_preempt,
 	.restore = mes_userq_restore,
+	.reset = mes_userq_reset,
 };
-- 
2.54.0

