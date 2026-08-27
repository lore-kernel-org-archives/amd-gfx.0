Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D421FC61DB9
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 22:25:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14F4C10E117;
	Thu, 27 Aug 2026 22:25:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hAKAlX4u";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010025.outbound.protection.outlook.com [52.101.85.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6F3B10E117
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 22:25:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/gTCljnx+QuC/73bIwu3XjfreoRW52i2/RK1OyHCHu7aJI5/Y5ncU+N3BA3iSWmCg1Qy1R6HsTkkyuIt+ayBaqDoArfBgPLYmYUnRxtMyNMkZYD/9OpZM2CF2V4QgTqb01US8XRsjkWZOMkFxF32EUpdxfKaIB4CS5nr9uPfSxfnWSsEFJyFXB56h3iuK7Ch1zOGoVYT305xuisZSzuzcNsm5VeeWu1BrNb6zD3mT0xk4cX9vUS3vFzN8ZQQmILT57n5xakyPlN+0/eTURdqP7NgxUkgib8EfInw52qJ8tHSbytA/mCDdshm8IDK9fmMc5lMZLcIef3lQ8IHFJpzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqdE17L17Hij+9jpmUWDQt7ps1lU/WQPPiBH6GnTxBk=;
 b=P1bXlmF7ASNw8G6f9K2cg3Fju1RVQ70GrsautZvlXXtXMznQBCnCJIJoQ8etZH0ALAhZ9orhWsvAXAWLW2cgsd2tUzejeEe8fUWP2Hy4FeDVYmYkV51viTVdMbcZHlVfm5WY/huy89DJ01xyjT/DLMAPz/4bPZWnfU9bqDh+vFtIIwU3gYIMelzGkhuZNzu/bXx8vXWspVpIM/sARQiDFIEpfwm6xXNZtEf27UhOQRQUjlrAvFf/EmvWb6A+QmkbRtncA7CdglrVK53b1/QHrcH2eG7+HvuRltI85llyiEHedoRTxOXhHVsWb+MzQfxCYEPRkTETtg7hEk2Iey6egA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqdE17L17Hij+9jpmUWDQt7ps1lU/WQPPiBH6GnTxBk=;
 b=hAKAlX4u8ulHQXO80Y+rsgqvH53zBgN1g4Eo+8DvupRCSnHFdUTpTzYcPsBUBfrcwSAd76HMJyqOoZdNYKFaNxay6nmK7cHBj671M1AsGGPV6I+1L/R00Y6cvOdaoV25brC2/y9D6lwR0+/J2k3B+Z631gikP8ze9GV86DBi4BE=
Received: from PH7PR13CA0001.namprd13.prod.outlook.com (2603:10b6:510:174::7)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 22:25:41 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::50) by PH7PR13CA0001.outlook.office365.com
 (2603:10b6:510:174::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8 via Frontend Transport; Thu, 27
 Aug 2026 22:25:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 27 Aug 2026 22:25:40 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 17:25:40 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 27 Aug 2026 17:25:39 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>, Christian Koenig
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Sunil
 Khatri" <sunil.khatri@amd.com>, Prike Liang <prike.liang@amd.com>
Subject: [PATCH 1] drm/amdgpu: cancel hang_detect_work before taking
 userq_mutex
Date: Thu, 27 Aug 2026 18:25:23 -0400
Message-ID: <20260827222531.127950-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: a9c3dfab-e7fd-4928-3b49-08df048a2099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 3+sA4sTb86RHW/t17ck0PB+JinYxjemx7eD60v2So3X5+EbC5u8an4fJtu2VXJUvWJ7zEhl2ysXXlrDyNi1PylnP3K4n42cb7ycJXPy4VqBt0lxFjcTBtFOpJZuteVMkkr1b7QI4biLXz8emVcZ/8gnqiCgECS4+Fockw2YWSTXBrENely2ZIjsRoS5yPrzmSRoSgaR1Y3SqDiZwGqjwxfINw07aFpj44/rCJkOKbA8V0tJx7vtzHAG1YMofhJJhHsdhsI+Qm6BQHoX3lbG8pSHTrgouyItHb8A2qi+Y5udkh5cmi2h5SFbBY0huSwd1wMOZJOcpaU9I3rfiwN7ED0VkOHsOJg4zf4+pSpKJrkMvwLjkCK8S/XitJpEicdEmlQoxaUQbBoPAj5mNjZtOO4OAsgYcQe6YgiawZJy+qAcJvEVIq2jTbF9Ff/CJK2y5D+BzE3OCTBXGsaZaXm8FAW1XIZD2C7V0HZCdpb8s9EiWWXxc3wPPpo8JSOjSiNaSbXxM3j72RShAdyzdh8117jHRcFPbvVe83eEQbgMCD98Po6b6v0mRtFjU+H30hHeTC7bHW7uT6P0+/AKYqt7s3IctQxvC4C9NguzZJK5aeyAasppvl3zI6z9uu36Q3g9k7OiKRlpBC2MD11ih4uQjGpQ6EX2P82gayPfbrwyFQqZy8QEGE8azzz12xKDOVwxjqSVrgHYoAO3QjpSTHtaYjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /td9kLH4KE7v20+76dkToWCk7RicJQcP4zXpYlU+3KEQwg/rUu+X+yxHUFFg0rLG12GQMUjeQRNT4uop3K6KX3jmiH6ZrtIi0q928Qy+cJPWPaD4BmZ53doP06YDjTOOoLhO0vAbmbecFRMsoKtePGxzNAKV7l+rwi9FGJA81bNAKM6HrOxkuTTLhWFICZfLiX2Qul4piN+FRymgDgXZ7QbvTGa0kbqh1EgD08+7uce6qauL60+pzKJsh7BIDqIfQ0GLPMKk6BfOjfZoAbXTUqyV1Lx1+IivJ6ccEk7KzArzth+mZcde1xOH+sY9RA9tXYD716o2i3srYm0lqbICEh44C8W7yaulaESrjeSSUFDVDhehDMvWRdF/JhVmfajzoSrsHCalWg44wV5z9nSbRxxFaGcz4+HP0Hcfos2Gp+ibr3uFt8tA+mhJVTT13d0N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 22:25:40.7940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c3dfab-e7fd-4928-3b49-08df048a2099
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

cancel_delayed_work_sync() waits for any running work instance to finish.
hang_detect_work takes userq_mutex during its run, so calling
cancel_delayed_work_sync() inside userq_mutex in amdgpu_userq_destroy()
risks deadlock:

  amdgpu_userq_destroy holds userq_mutex
  -> cancel_delayed_work_sync -> __flush_work (waits for work)
  -> hang_detect_work (running) tries to acquire userq_mutex
  -> DEADLOCK

  WARNING: possible circular locking dependency detected
  amd_basic/3761 is trying to acquire lock:
    (work_completion)(&(&queue->hang_detect_work)->work), at: __flush_work
  but task is already holding lock:
    (&userq_mgr->userq_mutex), at: amdgpu_userq_destroy+0x76/0x3e0 [amdgpu]

Move the cancel before mutex_lock() to eliminate this dependency.

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Cc: Prike Liang <prike.liang@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Reviewed-by: Christian Koenig <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 0a816b3c5ff9..52cd7d1c9f2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -543,12 +543,15 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	trace_amdgpu_userq_destroy_start(queue);
 
 	cancel_delayed_work_sync(&uq_mgr->resume_work);
+	/* Cancel before taking userq_mutex: cancel_delayed_work_sync() waits
+	 * for any running instance, which itself takes userq_mutex.
+	 */
+	cancel_delayed_work_sync(&queue->hang_detect_work);
 
 	mutex_lock(&uq_mgr->userq_mutex);
 	amdgpu_userq_wait_for_last_fence(queue);
 
 	amdgpu_userq_detach_doorbell(queue);
-	cancel_delayed_work_sync(&queue->hang_detect_work);
 
 #if defined(CONFIG_DEBUG_FS)
 	debugfs_remove_recursive(queue->debugfs_queue);
-- 
2.54.0

