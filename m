Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08440F9D0CD
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 12:44:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9846D10E5ED;
	Tue, 14 Apr 2026 12:44:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o3RsJFfq";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013049.outbound.protection.outlook.com
 [40.93.196.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBE2110E5E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 12:44:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaeOtqj0XV/NZO2q0eCSl3P0xjUD6NISw+fxV/tzNHI9EnMZrSHNmIxTP2nrlevMqCkR9f1Cp8kkBiqYQeU4JfHZ6DYQg/VQyEWD5J9FR0v7AU/PssFUnf4FSzFgqDtc4viFpxeU81U5Z0KB8uCSeMce164ryGHtcFTq6y97/BQYkwCdd8xkm2Tls5ofFh/+YAKC3CynLZZBIEff6Dcv7zr8stwTGpTHKNk9EQFZc+szO42tYkHBWEj0f5mKlTWfRHwQBDY7bO8fe6Ig6CRSsf8wBdd+5jdstCwYD3UMKtPsztvd8N2C9We2XGCVjRKwb66qevfWdBT5qu1Jm0+0Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViDMoovZVKZ++rUqxeTIm98tarAB5c5HsYl2/jc6FaA=;
 b=qrI2A3QQZWe0IpCQsqRNGjX4Frc8Az0AJML+KILgXlTtqvTQGbXrnuIxMNJz8pw6ywDT5tLLnPJKWWN1FoBN7A1LdHm2rU66AUKhlEUvhoTwOjOOHdi/UcPHD+R1VqPRqZMQhzXzprZWEnrJiOgR/VNfb96eiqrV9rIqvxMZeSjeUNWtw3g8M4evj+bG6keXKvlwqPkHHeqKKBtMPbac3FEy3DSe/w5aKZqq8TVqZd4uH39rSRP+Al/HWa8cV8Q36zzut9oalNUxFXpKB+bQHqIkWZBh8u2gvkh7Nt6BGXwTQIcLMEoqllnKIN2atj8lA7LrbZKqCLRVO6HoJQU3lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViDMoovZVKZ++rUqxeTIm98tarAB5c5HsYl2/jc6FaA=;
 b=o3RsJFfqfScMmwnKZwy+HYZ/pG6+1JpEw//8kw3GuARmqEtU2kGxIj0Qbg+kNYyhfVGBIV+qKcsCnIzNt/3qaJ0+rUcH23VJBe0O/ojF6hvnplnLrTt/Sx6M898CFlGpUCacBrMBjIZdzJqAGga2Rm6Bq7dQlLwc8ge/ViXtCHI=
Received: from CH0PR03CA0341.namprd03.prod.outlook.com (2603:10b6:610:11a::18)
 by SJ5PPF000ACABD1.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::984) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 12:43:55 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::fb) by CH0PR03CA0341.outlook.office365.com
 (2603:10b6:610:11a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 12:43:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 12:43:54 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Apr 2026 07:43:52 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v2 4/7] drm/amdgpu/gfx11: Queue USERQ_EOP records for
 WAIT_EVENT
Date: Tue, 14 Apr 2026 18:13:19 +0530
Message-ID: <20260414124322.2335906-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260414124322.2335906-1-srinivasan.shanmugam@amd.com>
References: <20260414124322.2335906-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|SJ5PPF000ACABD1:EE_
X-MS-Office365-Filtering-Correlation-Id: 3004b4e2-99dc-4a83-3fc5-08de9a237d07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Y9ivja4P2FlKWod0N6J82bnugKZNTrIdo9cWJfijwYHti2ta0BD3IKcXsjmyrd2FjC8RYHQJhm42wP0kiC+RT/h7QkzvHFvvGaiEOuCCFmMhyXPYkm6fxPaE0TO/fTEDkzptxZsy8RZPl7JtufLPP9HB0eCpzxjAPSCiSZZuoQAtAy9jOnUedD0xid/NwC0UkPXvtA7X0C+DfGbBrvN9H0Y5qfZiESBffTkb7xnW00EJz30wIin5XAnUYd3u5govt8JGfnDdtDPq5NFWKnjJxOVp0Q22S3j4THuYBAfCPX7xPK1WjCPbVtqpZqZ6sEC60b9BpH4xaRrzs3QHzJt+tq81nP+eCiw9gNk3pZ0hPlE1VYW2ud46Mk3vKTH+QK9MfbvmBrWhEypCwS1RXK7eM6rhAEd4p4bZM+NDVGpO1mHjpl52PAAL2Tk3LrLV7YJtysb0zQIt9j+WNHm72cnGNdbAzz8JB16/KMhoga7vtXGypo+dhPX9cIReD6dTAWxlzBsmm0maQZviICcHJVGrhTfPe5z3HdlHT7zn0YYrfuOSMZ6mba9xP+2/R+7RInHuLmoiRWjR8//JW7HoNdwRfzjf9FAwkpk0WB/2T8B9kdKQAtOqTWZCAE2cPkknInVFsf9Mpupz71dIiJGCSbVaGMNV2fK5hjftLjJ4noVQgM6v61yR2T2QHM5+xNX01tXCvxbKTTrq2INHiceCIGzH2uSgMTHgLGeHR/4QwDXBWBrFZFhvKSy6HlD273+1T1EYcQAoq5lyfbDidIwACKeu3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YyXZBP0xwHCxa7/nW8a6COoJq5R2Khp++uTYH7aRFZxu/9A9bkyyX+fpmqAK035IxI+SxLVCgiFcDtrEKC1qe+LytHs7ErNnnAWjEobNrkThW+Q/Kg4WKa/mw8Az9+d8P8WD/Rf7ZXo+jiQIZ0ankpnfH7YM/ssUlvgeWWEOiyL2lkoXaIErmF3MEI1zpB6KBriR3xY0HjoVdKW2AP4iJWQU/P+uce/4llhGs/sCvrT4SA9J+7MBAyT8y4zwlFznuPtiyuJm6DJ0WgaOzmFW0KH0wG4hLntqoIBstxQ0Bt5ybUAlVsxpN4FZfJ2htn2MiEkZxYMi3Nwu+Ckdx62U5A9lqjFOE9Kf2Nxgp1bqzn3PSnxRg4ofqP0WkCMv7vAog1M896r6ztzsxWsr+us8X/t33v/552b0HYzclRY67BZlgrmUmAP0y91jv/6SPog6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 12:43:54.5110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3004b4e2-99dc-4a83-3fc5-08de9a237d07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF000ACABD1
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

Queue USERQ_EOP event records into the per-file wait-event manager from
the gfx11 EOP interrupt path.

This wires the first producer into the WAIT_EVENT path.

Use the doorbell offset as the current queue selector for queue-scoped
waiting. This keeps the initial wait path independent of a separate
logical queue id definition.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 00e9a265c9a7..d3c2cce44db3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1319,6 +1319,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
 	userq_mgr->adev = adev;
 	userq_mgr->file = file_priv;
 	userq_mgr->eventfd_mgr = fpriv ? &fpriv->eventfd_mgr : NULL;
+	userq_mgr->wait_event_mgr = fpriv ? &fpriv->wait_event_mgr : NULL;
 
 	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 8ce039eec2b3..725c33ab5c44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -106,6 +106,7 @@ struct amdgpu_userq_mgr {
 	struct delayed_work		resume_work;
 	struct drm_file			*file;
 	struct amdgpu_eventfd_mgr	*eventfd_mgr;
+	struct amdgpu_wait_event_mgr	*wait_event_mgr;
 	atomic_t                        userq_count[AMDGPU_RING_TYPE_MAX];
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ff43902a9c48..20864d12ab33 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6546,6 +6546,10 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 					      DRM_AMDGPU_EVENT_TYPE_USERQ_EOP,
 					      queue_key);
 
+		if (mgr && mgr->wait_event_mgr)
+			amdgpu_wait_event_push_userq_eop(mgr->wait_event_mgr,
+							 queue_key, 0, 0, 0);
+
 		xa_unlock_irqrestore(xa, flags);
 	} else {
 		me_id = (entry->ring_id & 0x0c) >> 2;
-- 
2.34.1

