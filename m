Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0949C61DD7
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 09:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34FDC10E39D;
	Fri, 28 Aug 2026 09:53:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZOpVTT6v";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012002.outbound.protection.outlook.com [52.101.48.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A70C510E29C
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 09:53:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjP6IeBHpsZPADlv6ay3T8/8v+3wsZq9RbncWhz8+nDtnHIEDcL1sfu2SnGO9YmjPtIAAbMktT2o5HonBguSwII4VVGpfhUozrcjUaxVf0CLO6kH6wT5xhss6szeR/Jm/oTwxyxxx3hsvuU34Ho8sfhMZI8HDbbsDz22jPbgwp346AnvLAayTOogivuIZnY6Hh70CHJjNV9wkO5BEObLFvxcei5VTV2V9MAtXwHQ3N4z94ciVehOqegaJosgs5udw96h6Wq3TUYfjQ/ifNaVXlMjMlqxtbVNXDsntbCHe6BvHUItM+xC6XoFUTQLy9VzUmuev04fkfy3V5sCGDILvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTLzS58KjaSWV+ddtx07426NMQ+8eY581FqCPreZxZg=;
 b=a51M4lMS+trYpSQfptUgZMype+UURpzfiJEJTTJLIr5iyk3BL2OWmU3Riz4c2sNCQkDTSyMxad8hHiQc9QLZfpRHrVrkkQYRJg3dLq/TcsaUWxpcpY92rjjJuto48NbcvAbqF6im9rULWGLYpY77+bIM7e2CwceOYWNWx2st9dLU+k9NvRWoCFXmqu9WeN+AHDMQJ633xw93/95dMAeNktrlZzbB6VVfhm0zKP6TGQTHEYql3pvwHdSYej31y6OBx4gHBephMrmeLjL2oJvTKLU7TdcyWE9aFaaKpm9jgqdsWPC3UR3DjgNQ6gDPlqgcA2qgpYUdphe+yXERrCM1xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTLzS58KjaSWV+ddtx07426NMQ+8eY581FqCPreZxZg=;
 b=ZOpVTT6vL8OCcTfLZMwxrgo2Eqkpt6ifx8xH9AiBiSwjrZ0HCJtEQTcLvx/xIoNPFbXqePisNhCAmk3dM1SgqUOMRFwEzTD4aUfvAxvHEp71VBINTqiNF1ww13pyTqxSJ0vm6jvpyTTR/hM9Y5jt01pmb10KH4oXLng6waE00BA=
Received: from DS7P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25c::16) by
 CH8PR12MB9790.namprd12.prod.outlook.com (2603:10b6:610:274::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 09:53:52 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:8:25c:cafe::af) by DS7P221CA0020.outlook.office365.com
 (2603:10b6:8:25c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 09:53:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 09:53:51 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 28 Aug
 2026 04:53:49 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH 06/10] drm/amdgpu: hold userq kref in MES reset
Date: Fri, 28 Aug 2026 17:53:45 +0800
Message-ID: <20260828095349.9797-7-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828095349.9797-1-lingshan.zhu@amd.com>
References: <20260828095349.9797-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|CH8PR12MB9790:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce0aeef-7571-4556-648a-08df04ea43dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DToZOZPRXdj0OX0Lhac7KUlem8OWJiIKCF3IGQ5NcjYQTuI5Gvbae3o7Wlsc4zSBtNQxKO6Rn/jEYFjaAHuK8PCl6bZdqFfKL21Kb5SdZXKvYgJhr48TyHuGEig2brzu8Lhq1xmkh8Zu/irEQnn75rbKEg2xWyYiSJ+O0oRWBn3oSg/XrJ+mTU3pga82pq+yd37C7jNvfFrnAWr9gxe2JAQO6yWGd53zqb033c6I3GN52+Ql2yY+dt0bku83K5P4YEvRwTXABn0huBU+4LOcxMNFM0IfUXZPDHX3gzo1BLHpHOPSQNIVcilyQvTp8HNnP/ov4SE6IgZpwC9B8zv714AuDGPAhWcMUV+mJk/RSizWyhJGNnniZ7kvlud2ngtLfdoFP7pOPaO110MhDOu+Cv5TBFGhB8iEGg3XunTcrDPq9eIDF3xVdMy2QNzkQjRwbKPuCiMEVspsqHe9CNiPX6oCRt+lcKC+gQUySTn9nZs3/nJCcuNiuysV8NC/S5ijO6AkCVf3A5Guvi3KhmiCKAyoYv1CrR4q0yDQ1yya/H2aKc2HTa3kfhMfzErZhNbZKBJCysbWANrHvdXG9aQdzFBK84N4g+cknJkfQ8WAyJDzgVa2nRIsoCMlV+0MRCxygKn4lmSD1654KVaI//uE3YfC9+F3Q/hCLwueerHu6K7f9qOuAnaxE++akC9iVg3RSynVdYqHiq+3F4ICYheIzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9uyhhw21qM/ginVwbTugYJTQXk+t9q/dvkbPrsUVA1HaQZbZgMmw+j7meckhbRr5SQJra/apZIrsb0YFVSjRfq1WDJdf6LguynkxTxQy//QzxfZP+4XhPkrypXtbGfD3WLB6AHma4I4jODEpvJmYsjePninVFk68INhm454N+8WZMxq3TIZa2EWD4HeqejZ5AVVj+Ds4bfR7CMuffngWPJ6DHHFFtbR6yZaq6AHc89vC59PnpS5XeRaHGqpZbHQO6axBV99+sTV9QX4o/+/cFyp5cDvJpIor428dSFbJKCUt/oVwU6zKBre9J59vqdPT24vQtRgaPxmhZpHJsCmb5IZ+1yj3T5zYZa5UdgSZfcANB/u/qXtU5aSY5oqahRzt79TZcvwqKX0JYPDIkFyrLJlqMXzq1zlbi63T9Tlq6H6X5Bzq04yGHTbmTGutP61b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 09:53:51.6818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce0aeef-7571-4556-648a-08df04ea43dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9790
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

Current mes_userq_reset_queue() walks the
user queue doorbell xarray without holding its
spin lock and does not take a queue->kref when
if finds a queue. So the queue could be
unexpectedly deconstructed and casuing an
use-after-free problem.

This commit fixes this problem by using
the helper amdgpu_lookup_queue_by_doorbell()
to properly acquire the spin lock of the xarray,
and hold its kref during processing the queue.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 46 +++++++++++-----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 7f334f718cd8..3de71615cde0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -244,30 +244,30 @@ int mes_userq_reset_queue(struct amdgpu_device *adev,
 {
 	struct amdgpu_usermode_queue *uq;
 	bool use_mmio = adev->gfx.mec.use_mmio_for_reset;
-	unsigned long uq_id;
-	int r;
+	int r = 0;
 
-	xa_for_each(&adev->userq_doorbell_xa, uq_id, uq) {
-		if (uq->queue_type == queue_type) {
-			if (uq == guilty_uq)
-				continue;
-			if (uq->doorbell_index == db) {
-				uq->state = AMDGPU_USERQ_STATE_HUNG;
-				if (use_mmio)
-					r = amdgpu_mes_reset_queue_mmio(adev, queue_type, 0, 1, pipe, queue, 0);
-				else
-					r = amdgpu_mes_reset_user_queue(adev, queue_type, db, 0);
-				if (r)
-					return r;
-				r = mes_userq_unmap(uq);
-				if (r)
-					return r;
-				amdgpu_userq_fence_driver_force_completion(uq);
-				break;
-			}
-		}
-	}
-	return 0;
+	uq = amdgpu_lookup_queue_by_doorbell(&adev->userq_doorbell_xa, db);
+	if (!uq)
+		return 0;
+
+	if (uq == guilty_uq || uq->queue_type != queue_type)
+		goto put_queue;
+
+	uq->state = AMDGPU_USERQ_STATE_HUNG;
+	if (use_mmio)
+		r = amdgpu_mes_reset_queue_mmio(adev, queue_type, 0, 1, pipe, queue, 0);
+	else
+		r = amdgpu_mes_reset_user_queue(adev, queue_type, db, 0);
+	if (r)
+		goto put_queue;
+
+	r = mes_userq_unmap(uq);
+	if (!r)
+		amdgpu_userq_fence_driver_force_completion(uq);
+
+put_queue:
+	amdgpu_userq_put(uq);
+	return r;
 }
 
 static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
-- 
2.53.0

