Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB29DC5DF9C
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 04:23:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6785F10E5D8;
	Tue, 25 Aug 2026 04:23:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3xnPqn9P";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 022CE10E112
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 04:23:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLz4MdM4GyvJjWgsEQtHhapfJ5K20Ds0z9VwZ/sXFMWpkRmizYG174zygRNEqi/i0k9bOEdXTzRz2x+Hh6o/x7/AEB/8Rp6Ju+oOTSKQqPE/JcfrpAxpE6v0WCs3RgJb5QbtxR/nx+X3Q1f40+T3NtXbgdy7E2IZnX7v0re4cYqfJ6g2KA0ktNlMxqVRnu8SwUHxC1bBfb2/VkyJVG5D/pLyuNqdS7w4NdZRcxFGMWMWJTxNQGb8JbaZKxGdm/36ORMuMk6ICAfIv4fGisq5i7v6F3AN6u2Sa7z5uXeQCoXBT2UNuGufDG5gMt2J02L9nE7RuixC72fcmglg57N51g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8ReyRLebfkIU6OA502OAlXjDzKuEqfNXBFblzqCoJk=;
 b=hSqiT/dSP+Ie2L1wA2Ad3mmzyNrKcNoRZMOyvsh7/kDfscdaIuorJh5RucCjIIZ22V3bC4AFi2m2jSffaO9s6Nvd1Rr0mq5LiK0vn5Vx5ofQLbn5cuw8a8NcLYHIj6Idv9woR6SNwSlbnKsFy8u4mJZXlRFiB9eDAHtJCPfRZ4N42JsKA50f4xGuxL9D3Oz/x0pythDlvv9V9CSJ9DWH1zYa0E23r/vBj421rWUOcvz/Jg4B9bDp2gjcK++70rhraHoPd6Aa6+qX7DQG/WHnX854JL9y+V2xALlXbRhQfIokoHj2cFX/KvCINljaQdIbLRxNraoPuXEnlCYQfNptKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8ReyRLebfkIU6OA502OAlXjDzKuEqfNXBFblzqCoJk=;
 b=3xnPqn9PaXdrvGPWirFb5+q2C5NuC+iAk9uYcwEHBFs2n2B3DjWkaBnd9/2+OkVkEYhjnJAJ24G/qf6y9udQAj8Ue8aCTnvgcT53PbmLXuPnjTKGuqaHzQbL3+6JNVju3XVITkYlcU+wAqm5D+tnUZY8lUA92wryxQ81dyD4iMg=
Received: from BN9PR03CA0853.namprd03.prod.outlook.com (2603:10b6:408:13d::18)
 by CH3PR12MB9147.namprd12.prod.outlook.com (2603:10b6:610:19a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 04:23:03 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:13d:cafe::41) by BN9PR03CA0853.outlook.office365.com
 (2603:10b6:408:13d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 04:23:03 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb08.amd.com (149.199.90.133) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 04:23:03 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 18:30:52 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 18:30:50 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, Vitaly Prosyak
 <vitaly.prosyak@amd.com>, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: cancel hang_detect_work before taking
 userq_mutex
Date: Mon, 24 Aug 2026 19:30:02 -0400
Message-ID: <20260824233040.125300-3-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824233040.125300-1-vitaly.prosyak@amd.com>
References: <20260824233040.125300-1-vitaly.prosyak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|CH3PR12MB9147:EE_
X-MS-Office365-Filtering-Correlation-Id: b76d3639-89c2-4eb6-4835-08df02608e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: wahgIxqA0uewxsRUWc7E3fPvh5lvSImNhN4LTQ45sBZY3KI0t5sEIP2neFI8ysILF8l2NODdNBma4wImUi9e3eeWPMnym3p7cbG31ACnu00KSGdd44YBrfsU3+KuK5F0mB/SPO+rSGBTCgVthvG94Tebardaqmfw0syGvh1DmudI93ce0VSMAGd/ltA+y4bV7dEyqK5crUrWJ+M1C7Ca916Rq6odAGuh0FUhSgkm68sl0ZOc1xBLafe3zYonfx/05EA+V/PaNQp+7Brm8AgONUNuM1godJx6kacn+ZKrJKFuIRHMtQkbXaV+g7QuMOC36kjc1vh0GuTOG0/Yst1Z5xvCNwlki+Fz9PSpmgGxjqLLcx6mOGNKOP9dvHdI5C5mCszVKVFJCASjmCoYbiZI9K6PxYNkbMVImZm2MmtWEa75mtjMi4sb2aMemj3rDOv6tKvMA1zYaxqGWmGdkG9CGeR4NADndfL3RtVbNEhcSi48yDPK/ICRCaxstDp5JqmH1vurp0NvyKjM81E8Q3tzFt376pH1rxaREG69KRt15QH1vDx2gkzbA7yNNCD2PulZu1hES9JpsrOj2YrwMy+nNGonxBxlQ51Vd3/0op32VtBKMt4ptNyOyOVraThgUCSLGsn4ZgEKBY805Xnz45Ul1AZ8bUUsM1p7dItJ0dxE3ikcqdfhmTibnbD+Y8D6s8TeYK82EOGc8r87vE9PQr+veQ==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5S8CCnWPN/fBH7S47fSxyjRPRTrYTGdTeySO2NOtC5oX7v1Xl7XKVYKBQbK0mxh3fjnMGagBrgyV8D00mObe4jRxxDsg0kOTFL4LjKHpEbNKZpNCe6mtCumt7mcB6Ztc0d117TjwgLPXmFxycB89xFd9mEo8CltfhT6iyWTfEyVtoN5Q+iqpd/eul2allLfLNM7e0epTOT1sFLL/PnaSPqlbW2KQ1MExaoszCz5eRgA5F23TXKMpZd9ekAJsLdOUBChEX71h1+WkE0uTu7dCNESXc0YHK0kzh08RCwBbXqSWLPofoj680067ksOaSletnuE0rwQ9GrWxCNcw6J9er/SFH6KoanopEe5aKcmlpSBcfYRo2tYBy+p6ifR1CmS3G3r3Ykd7elMh9binD9GyG0GfiA3jhJ8UwWzCB+kB2JpEHU2ADvnd9UxQ9gTyvr2R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 04:23:03.1218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b76d3639-89c2-4eb6-4835-08df02608e09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9147
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
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
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

