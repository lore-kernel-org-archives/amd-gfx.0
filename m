Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F7DCA5FAD
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 03:47:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DA7510EC8D;
	Tue, 29 Sep 2026 03:47:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cDh9RL5M";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C40510EC8D
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 03:47:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDm0HEbJiVsJYw8RU01lkL/KmtpLOBHbhAwZp2wD0WmfpPW463Pq96a3NwnukU2qwyDQUXd5TtdWMXPQC/xRpUFj8cc3Bdv01czRUJvL1NbRhDktMU5QFMcxgaCPx10PrPOqYhtupozCOxjbAwui+epu8cubR2YY+yPRuxqCmMGoWBRsnm4/VllW2McgYfWUHmCpKZnZZx6Z8xLfisP77tdUGi/E4EqRGr9wa+hlpyUyvTxgWVFIvxgLcSlggB6MKiKlx33jc1nPJF8UzHo1Yla+XNA3okBcmLBfVPe77I1pmBywQVqrLzFxQPl5rN9KQctDYAilPhdIXqgQH/bRLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mh/WFrHpOrX8F/nN8VQC+P0qSehx5qUjNOaieLv38ik=;
 b=Wabgk7c+fYk1wpO+sdWFHmHZm2IdAibrx7nvWiL13n8Q2KliftJYoMzK4oLIa5CVNVzmur0k79S7JqBv6uK0ZlxhZFmA6CRu+5i1yLXMZ6iVVRm0e3kU7tfJcPGWbyrBitGIwxJPBU4DSXto8tPTiBo+dzGqvC0scm+umGYGeYavmeA2fgYvpMIQ5N/PrNtJ5dQKKUFOy2pCHyHXR80z36+/g80VSdcKwwsUechX4kuWtuD7VXL18XT/o/KaBtOAeGHCn+8MX1P8BdSGs7nb2xncEwFbADg3XAaT1FS77V/H6j0jmTnkgE/b3djPsE3DAGsYzZSdkf1gpopSiadmmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mh/WFrHpOrX8F/nN8VQC+P0qSehx5qUjNOaieLv38ik=;
 b=cDh9RL5Maxpew8sO39Xa71d5ktasKTAMAg9YUFjOkxwPsFxZFnWy78nMrPf1a4cv2qe2LXDIrjtKscqhGB3o/zpB4jfR+fCEG2M33iI+JsxSFxj/Y7WNPM1BURPwv3M26mtYVqgqC1r8MpLskraSMrr9MHHZtAR+3damqRPRx/4=
Received: from BN0PR04CA0082.namprd04.prod.outlook.com (2603:10b6:408:ea::27)
 by DM6PR12MB4172.namprd12.prod.outlook.com (2603:10b6:5:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 03:47:20 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:ea:cafe::4) by BN0PR04CA0082.outlook.office365.com
 (2603:10b6:408:ea::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 03:47:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 03:47:20 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 22:47:18 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v2 12/14] drm/amdgpu: bracket pre-reset userq removal with MES
 suspend and resume
Date: Tue, 29 Sep 2026 11:46:48 +0800
Message-ID: <20260929034650.2393125-12-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929034650.2393125-1-Prike.Liang@amd.com>
References: <20260929034650.2393125-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|DM6PR12MB4172:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c21bce-bdae-43fa-70f6-08df1ddc5d5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: b5V/fo+8HzeJ7ARXP6a1RGczWVHMlI4Qppz3tl3yInSj7b7VbTPs30lSbsnHv+Pewj74KzG4lNOSe8FsVEZ6gBDCmyn7A4WMpaGNcfvPbvi2ersXm0sfgRHcXiB9mKxmqJCpuFwSz26JeQN2clZsJcJge430VSHvOudgBXUOBXEaqi+WSbVqkIE16eMSRWdUugJTikkige/rcaFjvUNu27x/r8+XmKmK0PJpachMEuJusaKAGYudk41roIiV/EeIbYCyEw9Er0fXTItLs8m6sUK9Jd4fhAxD5OJ7s5Iy59cD5hze2Z8tUcpLAqF8zGvJJ095IOePsjDBjL7H0itDgyBF7YEPXdN3uhuVoK8HPQPVPuR7VcJG7fNJW98pJ/8IoemDsQIodxNrVZdYb+KdN/NI+AAFsQHFn7e+lhYI1WRi6Uvla8uc213o3Oxi0w5UOcendB7k7sEVpBoSkomuvqTKgwNbYYpgQoFSZDeyFh5VXfQCtVjulFxIGlzlT6lXQ+JpYLlk5sV79PDG95PCBq0phgWmUaSn9+qc9HvnM7Gh/SCThLIyZejoMrSviraKzOFnwAdIlz8b3EO3OXykyywfci86rGpBmRVLOtQuhctI0lgQZ3CUAEnFN32M8KVgwVKN7ja7+niSY88zzGRJfUIgZKum2h6X0v4O35up7jJ5TDeEJip4jHynSeHF9ppSH22LTBcrMvnBSnUCm2OwzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yIClXbFVqO3Ilyk/uJiqm28wxiBItQGj4kBTRQZFl1m8Zta2SEnx4j1089po6Jp5dhziVdqUe2J3lVK1W2bzQQOrKV7IhRNW3o01Wtcqb28jfFfEs3sixwT3diY2YrDqr78ADDsgRSKbVXzJbwYYUHiSlMxUL9XPGfQp/bLf7WExVQYOX8O9i9IfE8w+a1+hYNRtAM1zCXlXGIXi9SrJklSJD7lqDf7VSnZiVwjJ8hn0yMDA0Pvbm7xMAUlLDG8ogM8MbukSqaAeE5xzp7L6jgwIOzl1JFjDzeuFLpL6C4EBGu3BKs9wv08Wg2+DkSP7/kuKxdz6j6s1eV/pqI7zIzgkakhJARZ3TmVoWy8pY3Zxg7RcltXS8ocis8jugo30lXY12NNvTtzvfd+9CNekCuQzIDF5I/OKZq23oj5vXXebNHcz1mFL1qlk2GYCEOqh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 03:47:20.5673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c21bce-bdae-43fa-70f6-08df1ddc5d5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4172
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

Suspend MES gangs before attempting to remove user queues, and resume
them in the same function. Skip the operation when there are no user queues.
Suspend, removal and resume are best effort while preparing hardware reset;
a firmware error must not prevent that reset or be treated as proof that DMA
has stopped. Queue and process fences remain pending until hardware reset
succeeds.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 2eba234a504e..e6ce9d12bdb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1607,6 +1607,12 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
 	unsigned long queue_id;
 
 	lockdep_assert_held_write(&adev->reset_domain->sem);
+	if (xa_empty(&adev->userq_doorbell_xa))
+		return;
+
+	/* Best effort: only the subsequent hardware reset proves quiescence. */
+	if (amdgpu_mes_suspend(adev, 0))
+		dev_dbg(adev->dev, "Continuing GPU reset after MES suspend failure\n");
 
 	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
 		if (queue->state == AMDGPU_USERQ_STATE_MAPPED ||
@@ -1619,6 +1625,10 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
 		trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_RESET_PENDING);
 		queue->state = AMDGPU_USERQ_STATE_RESET_PENDING;
 	}
+
+	/* Pair locally, including partial suspension and failed queue removal. */
+	if (amdgpu_mes_resume(adev, 0))
+		dev_dbg(adev->dev, "Continuing GPU reset after MES resume failure\n");
 }
 
 /* Called after successful hardware reset, before allocations during resume. */
-- 
2.34.1

