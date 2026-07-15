Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C59C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 14:26:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C9CE10F0DC;
	Wed, 15 Jul 2026 14:26:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ECqZTDXv";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010011.outbound.protection.outlook.com
 [52.101.193.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A1A010F0DF
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 14:26:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yd4gXjWh3bAT3dP9zxinE9/ARrqKrPgwFxCDWuTbua8Y4C9+fYIszXRsTBKIQy2uoaafa2JyEljUHgieHxNy2hbKtR73Xb9Sdt4fS0JovLVmYWXGL+YNfm7oFTBIR229SUz2x2MJtl93rMDGdRc9kGKfRnH+8oi41tnSuXYUej4PEVWhCI3Gm3qgjmUnBwNcpKTlaJMbD9NGmiYzrnHx2TlDVrkSYlpbcxWHCltIP/mfj/5Ok8L/88kXmULYxmgwMOuLEAYglDOHnsQo6DKHaYuO6JpVJHI1YGOKR5TRz1RhDll1SZiVvUJZD1SqIIwVMHev2TnM1U3VnpNsrvKO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dqk2WWdwbzHJGb33MVpsbkv3Q8JvlPaj/z3EkPa6vRM=;
 b=NXE0Fn0g9ZV/8vXcCXIe4dkq+Fg0cu1Hr0n6WsBfz8zmODjLKKB13pqoA1OT/nfCKJ9qSLRt7ZkU3wngxH6Aeoo6irH990UwhaAsdYz3PijkVt8NGxRvRJdT3fdhR1A7lsflxLg2WRixhsYCkxOgKEpwfManBq+Y9Y0VACWApG4C38oAL1KopE2YbGwkbT7WBwwwYAMSuaIiR13mVJEEfUoSuBIuadTDYHYU3SCYQI4HXxU3pRaawpIIVFmvwJxDtJ/YEe1V+Zq+ZYMEE+mN8ocmhmLxz2sFbufctRqmZUj0RJtlB0/ktpPkZJ6Z1v9APILrQbTBE3MVoOPDzjpKiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dqk2WWdwbzHJGb33MVpsbkv3Q8JvlPaj/z3EkPa6vRM=;
 b=ECqZTDXv6T8H0oW4q276roMfmwBCyOIpJAEVqoAUqPI/ytBdGP83X8SqyP9wTw5YwwdwxMxFA9zoTeL9GspVmnyh8Am59yMHShPGgIRGoEOOW5tGf5N2bq+hWKtK6cFZbT0vnNv1+jXRg5OT0ruTo6hl9GejvtmOb3BYENJYoBg=
Received: from SJ0PR13CA0034.namprd13.prod.outlook.com (2603:10b6:a03:2c2::9)
 by IA0PR12MB8695.namprd12.prod.outlook.com (2603:10b6:208:485::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 14:26:08 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::9b) by SJ0PR13CA0034.outlook.office365.com
 (2603:10b6:a03:2c2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Wed,
 15 Jul 2026 14:26:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 14:26:07 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 15 Jul 2026 09:26:03 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v11 5/5] drm/amdgpu: Record QUEUE_RESET WAIT_EVENT
 notifications
Date: Wed, 15 Jul 2026 19:55:42 +0530
Message-ID: <20260715142542.3475265-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715142542.3475265-1-srinivasan.shanmugam@amd.com>
References: <20260715142542.3475265-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|IA0PR12MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: 28a96c27-00ca-46ff-706c-08dee27d02d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: PLFFCB/Q7u0G3si8FyFK0Sq+GjcEKoFuHdeLnclVzy0R+5y4QJO4lJZyM5gwWfXY9lC5xDUlmx/MgLr4tMhJzpkGFw77rvwaS37yobuBf7DPDbTCHMzdX/usovHrd8mFsyh6rJYxj1uWroQRps718riOxdmVTqiQHeDTLGvbre4AUGvkWpXLa8i6yvV9QiSxs95LucA1XZjdzqtm71yKZhJZRxzvWZkQxjFp66n91M4rpfldlp6LaA44/sXweTHV7EGSdWybM8cPo4LuAmu62dg75dFRRXrf4NltWlzoIUsfONyqr/TYuxmM4Q1wf2ZUZinFvTYJnEpCoL5cfcKTkLKTUX4Osnjq53pKzORxx4cmN+nT3bfg++p7M479GNuXoiAdEjlUrBtnzDCNh+VcJX/jCKSzq4pUPztK/Yk6Vo1miswBwssrDD0BFpfHYgXQUjBNOmNWJHw9/PejMOetqLmQ+WWYiB7eaZ+QaOaEywM+mKJt2DdeOnC++6j8jic3KNG2xlEbD0RkR/VErfQFfIStESNP22tykYqn623oWi1FvJcpFPcvLv4lq4SCDhf57NyIfBZy5n3QBL4yq5DpK4F6vPd77IIPWz41fhNLlDqVJ1T84j1D/UuFg0A6EQQRwAldeXPrJj0EVWutoDpath4x+EryA69BhbEgfm/TATlWmKCofYDWhAuOfz95ET/eaD5iPowyLMS2Q8eeKcsPrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GQEO0LfF4K2cdCOEM4zmJhe+bpaPqS10wbScbeWaNICuv+gqk2kB/7Nwc0tgQJvK60Jz4Wemq6mHebBvGagGwdiLtm22GGJjPSkTddVnEFqON+kGbFHgKp31UmF51ab8cvz6EJLKiFVoapX8LeukEAth0uxXhD/qvoRrSz33eUv7jgh89KznjsZs5WWdW2bWkHfsy4EIkHZ+VlvmjhjGHLKEvmjlo7YtfpacUdTTipjZxxbmxG/huebFZ9f2y+vTLgtCUPmur27uxW8X/UpuWBSy7Ois0VsvD2tjgTS1BiQulXKAMH5OtVlrJaV2fvhYP5lE9a6j/2obq+y2zRL2ndZKXinqIoy91m/uFCUhtaX5rFZZJNay1uw/Zi3iYTAmQnKVMWuIVE/CACLMFHxT6hcALaH2IgOBGC15U9LA7/tAwn8Tpq+bjGqJOW+Ia0vx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 14:26:07.8117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a96c27-00ca-46ff-706c-08dee27d02d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8695
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

The queue reset path already resolves the affected queue directly from
the doorbell and funnels successful reset handling through
amdgpu_userq_handle_hung_queue(). Reuse that common handling point to
create the corresponding WAIT_EVENT record.

Keeping the notification in the common helper ensures that queue state
is updated before userspace is notified and that both EVENTFD and
WAIT_EVENT observe the same reset. It also avoids duplicating the
doorbell lookup or adding a queue scan in the MES reset path.

No MES or GFX interrupt changes are needed.

Changes since v10:
- Rebase on the latest user queue reset handling changes.
- Record QUEUE_RESET WAIT_EVENT notifications from the common
  queue-specific reset helper.
- Keep device-level reset accounting and wedged-event notification in
  the top-level recovery paths.

Changes since v9:
- Document the existing USERQ-before-postclose teardown ordering in the
  WAIT_EVENT manager patch to clarify the manager lifetime used by this
  reset producer.

Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index edf6c3e91900..0ba87e0e3951 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -158,7 +158,7 @@ static void amdgpu_userq_mgr_reset_work(struct work_struct *work)
  * @queue: affected user queue
  *
  * Mark the queue as hung, force-complete its fences, and notify matching
- * QUEUE_RESET EVENTFD subscribers.
+ * QUEUE_RESET EVENTFD and WAIT_EVENT subscribers.
  *
  * Device-level reset accounting and wedged-event notification are handled
  * separately by the top-level guilty-queue reset path.
@@ -167,6 +167,7 @@ void
 amdgpu_userq_handle_hung_queue(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_eventfd_mgr *eventfd_mgr;
+	struct amdgpu_wait_event_mgr *wait_event_mgr;
 
 	queue->state = AMDGPU_USERQ_STATE_HUNG;
 
@@ -176,6 +177,11 @@ amdgpu_userq_handle_hung_queue(struct amdgpu_usermode_queue *queue)
 	amdgpu_eventfd_signal(eventfd_mgr,
 			      DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET,
 			      queue);
+
+	wait_event_mgr = amdgpu_userq_wait_event_mgr(queue->userq_mgr);
+	amdgpu_wait_event_add(wait_event_mgr,
+			      DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET,
+			      queue);
 }
 
 static void amdgpu_userq_hang_detect_work(struct work_struct *work)
-- 
2.34.1

