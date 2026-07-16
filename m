Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDC7C44516
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 13:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4161710F305;
	Thu, 16 Jul 2026 13:21:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E/aIxoTK";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2393910F305
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 13:21:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkFQXbQPsaANel/5zXze0oGtlaLdIJz+9btfms4cNCPVdW/D47u+weycYXcb8gMdyezOWU3zX5h33M7KxQx7h//HM79dpUXpK9DtYK4CSn43FY2rU6C6GxTmZIMhGm5OIyz29HdtSFzAP2OhXWtfec0mRS9Aean9U+YUEJFjqe0EqQfl6Q2Gi2wrp3JkCFw3hK4ajsIBZ6/jOdRAWGoOnPOWljBxExD6mtc+kvSKyJlM39pLUvzkA54t50UVK/QpFWEVUNuVFdzXi3i4n+B1cXkfjJW2NaALf4p/uJXJtPuV7I3WLs9bvR63/ohXfWRntWbqtg6dHZNuTh3l5K4Oxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dqk2WWdwbzHJGb33MVpsbkv3Q8JvlPaj/z3EkPa6vRM=;
 b=lQJ7Z3P4jvwdhf9f+tPJ2qJd0Dy6W9zTpLSZp6Zb9hS2bzZaqJtm1cn00Z7LCBTfw99ArYjhC2RO/82WoqUfg95dJTJodYeNe5lwpTUFl1Q5EBdAOI1p+CiKgzAx0bwOBUzHV4BwgtZO6TbAGQfrpoe2m5Rq+bb0icNish0jt8c3q7Q9uzt7ECSY1VADfi/2Nc8+s7nNCN0EoM335uJszHOTqIRt1wvXt7OB7a1BSz8C45gV9FzBKlClKZVGrd0Ekbv31/UkH4lddBdxzX6HK48vqvjjw194RzaqWffhDhaAwdZ1vtdqp4/QN/IknIX5MTvR5PQGbyBt3O3gm1L2CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dqk2WWdwbzHJGb33MVpsbkv3Q8JvlPaj/z3EkPa6vRM=;
 b=E/aIxoTK/kWnr9lvAdWNS/PksQ1TEECF/0X2/h5hRuQm9NYLSATdPKFpxVM3nQyAU/86yywurMk4o5QeC62YCc3oKOUlqdPleNSH1pmJYtQMUuUzvL2dprBPFzZSVgGfN2h9dLtHlWsqlMnWWUtiJOF6S3L0SG48FM0eb7i1tHM=
Received: from DS7PR03CA0015.namprd03.prod.outlook.com (2603:10b6:5:3b8::20)
 by SN7PR12MB8435.namprd12.prod.outlook.com (2603:10b6:806:2e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 13:21:38 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::5c) by DS7PR03CA0015.outlook.office365.com
 (2603:10b6:5:3b8::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 13:21:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Thu, 16 Jul 2026 13:21:38 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 16 Jul 2026 08:21:35 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v12 5/5] drm/amdgpu: Record QUEUE_RESET WAIT_EVENT
 notifications
Date: Thu, 16 Jul 2026 18:51:00 +0530
Message-ID: <20260716132100.3496327-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260716132100.3496327-1-srinivasan.shanmugam@amd.com>
References: <20260716132100.3496327-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|SN7PR12MB8435:EE_
X-MS-Office365-Filtering-Correlation-Id: eebb714a-c082-47dc-b4ad-08dee33d2ad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: i2m6KF7O+kEI4WKhJLcvfC0MSYPudE1vuJwxELrg7lsHpWzPuf0engJlW2pX7tld8bxjdd9Jji1tj2RyhR81pB6VH/1sDxUC56ACr1CfEo/eVv6pZKh5E49KrIUL65w96GpQgSxuwOOd3W2SeIulEWqg//jtFeX0vmwUEjmzxjXwAIfDLFNLSwQOrU8gF/eHzQ7cXsvFX42pUHqXWkvkebNnXCnlwkZ5b5bNpl++AcWt5jhhifAVaB5IrL0TN5wsLyKvBcDu2a8VSN0DWlpLWjdPt0+D0zcIcCXDpQ8lYirSfnle+rGIIJxjlQxuPb9DWRDIZaoPdwauFdQ3jvLhieEbLyDXP/Yt4vXWUBksy6DWhhUbIlSyvDM3A8TYHhpM7Li8L/0Au2wfts25N7x1lNQe2NcNgVTeNxQi0chHmrcNli0U178oyWHpRYhZRvgFRjjT7KRBYBbJnebpyJ/BfoNjkFxGi0zpMeLsTDASNwmiClEPK+00lp+v2DKkY9k+O/HQAZ5LPZ+wuVcVZEW4q4Cd2VlhCpfxzu2gZgM9/YZWh5JI5nU3dEDXAbZkdJKnJ0e3EAV4+CsgljFRT/29pcV+BAADgM58rvq3C3Axjnjhpq4f6bBSAMV8lp43Pl8wSOIR3GD7ywSjJKaunKHLbrVOh+i5tk9aC89sIWhGMH4ZVPxEV2HeIUtPO8Av6gWyhh5YDwXrQuT9H2r96bc8YQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DxeCCzinOIuEChToDQ7gpEq8fwShK8OSfGBi38YBGZDnJK7W20MwbTKzMr5gAT1jzmGSdGvzJhAE0qAT9nx6U4VlH2NUsqLHFVkQ9IK63R3Qv+u6fAEsgeGUuJlP1pg4ZqNVhyCsZrxUm2q+jCKvoy0KCBI4Ro79JvrWwAoPbdQCEW5dBV45S2AnmZEODZrhEDY5G2QEzJd12g+xDLfSmUEXB2IsGIXVdENI8Y8RhXnWhcH0eMIzl+cgQyzDASUjlYAB0dnIzRXDFW8LTkpfoDiBxwdlGNyfQJmlcH4tImeQyMUhoqaZfbg3Pi3N25loZsoTBP/eOuVggsWZ/KEhyQS8F437yLeOXeSyzHkNxYxQp5VRIrJ+JgmaOfVfPgbR2fN7Pr0CxA9j85Wyo+OLuaLbXRFXmI5Gtvn1OAXHR8ZyamI9OyqN+WJilj2zovqZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 13:21:38.3367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eebb714a-c082-47dc-b4ad-08dee33d2ad2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8435
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

