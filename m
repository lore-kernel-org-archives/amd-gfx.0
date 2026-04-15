Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD4AF43857
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 16:07:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A39E10E71F;
	Wed, 15 Apr 2026 16:07:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0r2VqSGz";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013010.outbound.protection.outlook.com
 [40.93.196.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DDA910E71E
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 16:07:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJOJDoKHcQdq2+dVPPBOKHfmffKPsAph9UoEXVRafSl3nmtSQX+eKRZXm6Pl5es18o71WF/E84guuBZm9UHMCaPOoiwCHvhKF9zE39O1HZ7UF0eOmwRYBecQuiA2p/vTglXYxZ8JbHn2jFSVDFndSCVpM6Lx3EbiFkiMq9ZEFcaydo1vsLK8Fr9+O0HM1hmq36kfWg0ydNOi3G4+9a1rAJKMzJo6NgGcJKEr/zx4AC0+WwCjXsF3AbDyYWPtCIZBSIiJzom/3/V/kqW5vHCr/5G2TLt0Q3nRlLWCmV8kljYenSH+YjmfilyJfK8BcrmlcIM93O6PyR1OD2YDs6//6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFV0I/NA2Arkbm8AhsMzXdnGJpkiDAqpruJSrMSr7wA=;
 b=OpDdLTF53r4d/Ktm48t4J+nASLQ6+HopQTNXP1x4+E/Gz4AMyC5R9JLTWeklZkJijEzo5i3E7c9oW+4x8t6kq34iAAtpiI6VrG+7EmiZd3vgi+8q/zefrwQgflUVG8V+lhIAue+u9ZjtsbAXx8LlCNfIPkvxNrXzuG7zklr0EoB8SO3q+Mu079tK/fjedlqOLrgP8kuqImp4SzSbBmWv3zitBrFik8sB35QJ7JaRGu2ThdyJnL37mMLA3F5jgWojRfRlo4r8d7RdXS8nU+QVKNGtR9WGP6vsVeeKSk1iXQPc39TOTqtF7O8BSoYu3+azV0vq/fv69wI9opOoNGgRAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFV0I/NA2Arkbm8AhsMzXdnGJpkiDAqpruJSrMSr7wA=;
 b=0r2VqSGzm6K3vVDcAvxoYWPEcQX24uvSYvK+ORhY1HUUANDv7304GS/EDafTq+TkDuBd3sL9aFChVB1+83NlR4PBi+VePKlIGRFpxKMSr3f5CfTxYGyzqPAwZm/oY/A4g87Jtdje01ftaj0D4Q2Avh23ewx1zQWYQLYpHHQ9G00=
Received: from SA0PR11CA0154.namprd11.prod.outlook.com (2603:10b6:806:1bb::9)
 by DM4PR12MB8497.namprd12.prod.outlook.com (2603:10b6:8:180::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 16:07:48 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:1bb:cafe::13) by SA0PR11CA0154.outlook.office365.com
 (2603:10b6:806:1bb::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 16:07:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 16:07:48 +0000
Received: from rtg-navi32.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 11:07:46 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v3 08/10] drm/amdgpu: Add queue reset records to WAIT_EVENT
Date: Wed, 15 Apr 2026 21:37:09 +0530
Message-ID: <20260415160711.261553-9-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415160711.261553-1-srinivasan.shanmugam@amd.com>
References: <20260415160711.261553-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|DM4PR12MB8497:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4764cb-3d45-4560-ca3e-08de9b092375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1AMpkyOe6GAUy6eBKU5PqVd6tRUbBKIFjQXb+D5CKxt1D4ItyJqTMhvbiOgOkL+lqD0LrVC5uQwZv8Yq7GZazLa6Dn2AaD463Bnxz/v0Q26L+SK6cA1LTzIcCwvmmacvi4yf8rWIQwoUhsoP6bxUtzkdVsD9cXqgWHuwL5YaiIv+1ZsokZS+iSG5wnEtkC6T0nSc7SWu5WVBrK2e0A5yzxjRiNHnFquYBvfMZy1Y0nrVovi3f5kxP1ll28vkA/1gEOhF8jrM+5nUfTlmLNiauZdt9JN6Zviqey1vtlpnsrqTpWcx+ptMigBsH4fRMXYia+UW1YgZjxhMxAMW0pfqAQePuKHl9jaSGJgEDunuTOPDLqalOubCd9Oi/TMGL5DJtD7h+9Ksi6WTtLswRAQtT/kBbK5Ft/vNux/hEXNgGjN+MWcMukV7lCnlU/McwPeGLXmK+SJuDeQlZrMpf4tnM9xrfNX+fs/xQwQe3yhibLvoXb7Xh9B/Cuwmh6vTRTdocORGDBsg2UY8HEGXpiGjT+i22YjhsDo+t8zFdZJY8EHbsVB2RePEAS8T2Vi+A0E1OKEwu5BIWFTj6YOo9vGKNxCK4QTcT7Hj1+eidpYzT+WyBFjCZFAKyiZUz9JYoyPH9l7LNawF25fb3lY3m6e0eCvEzxoLPk2Lfm85n6iqO50YKV1Xzn7vKTExvV9dq1yc05aCXYmOQs5HMauOoSXWyCWe+zE5EYeoi/Gwd3QvUQD75UGAIrcUR/JWJf90IjrLk/cplRzxSWiBY9fT3Tvtwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AzRix5tvzyDEJoERd2FiTT2g3YeTq057NmmUTQ6+SOXvT9NFuJdFDh0fg11HInadSAk+/n01et36CmWahcO5acOsf9g69htV39BTpMHpBlGHwIIArWVz45JTz7xy1i1tAGki0Ee4lgDMegjBUNTnreMwmj4hH0S2DwKLGJj5FxyLc+l01waJ6D4Dbd98FY4II6tss1YEitWPgYnYgK5fuDTCFR8Dj670GSAQSvJqeARYSARcNk1asJpU5uI+yTcbMoFK3EPv9dIacpEXMXCWHun8+Dc/Wvc085FylKtOqY2/hjNXgHVQ+W9QugR8voKTVRKDU+4c7UUScYvzIqrNxmY/yM65UDvQrs1BR3/0u3ksdwOcnEKLf9bZfx8kjRbzpod93Mv0x8cY8r2O1eXQlDEXzsWOoO/eJhb4sjiQd+DMPMglftAi9RPErgWS6+28
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 16:07:48.4759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4764cb-3d45-4560-ca3e-08de9b092375
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8497
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

Queue reset records into the WAIT_EVENT path when hung user queues are
detected and reset.

The user queue reset path already identifies the affected queue and
marks it as AMDGPU_USERQ_STATE_HUNG. Reuse that point to queue a
queue-scoped WAIT_EVENT reset record keyed by the queue doorbell index.

This does not change WAIT_EVENT UAPI semantics.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index d12cd1b7790b..bd943d0322c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -24,6 +24,7 @@
 #include <drm/drm_drv.h>
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
+#include "amdgpu_wait_event.h"
 #include "mes_userqueue.h"
 #include "amdgpu_userq_fence.h"
 
@@ -254,6 +255,14 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 				for (i = 0; i < hung_db_num; i++) {
 					if (queue->doorbell_index == db_array[i]) {
 						queue->state = AMDGPU_USERQ_STATE_HUNG;
+
+						if (queue->userq_mgr &&
+						    queue->userq_mgr->wait_event_mgr)
+							amdgpu_wait_event_push_queue_reset(
+								queue->userq_mgr->wait_event_mgr,
+								queue->doorbell_index,
+								0, 0, 0);
+
 						found_hung_queue = true;
 						atomic_inc(&adev->gpu_reset_counter);
 						amdgpu_userq_fence_driver_force_completion(queue);
-- 
2.34.1

