Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B67C83F03
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jul 2025 10:33:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 951BD10E9FC;
	Fri,  4 Jul 2025 10:33:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SczrDSfo";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D29CD10E9F9
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jul 2025 10:33:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uhu9r8XI2ipm8oCNLSJ9E4tcYr2AEpFcvZ+u2Qwyqt/fBLXSF0z/DIx/TRrAkR9t5ECXPLaxoTrijZJu8r1bGRWYJk3WEgE6HUFeQDdb8xGaO5KkCAYFDpYk870MZ6d9pMImzGyX66T1belSBH+SvfEb9XH4AlSZR0T5v1Dkq8GFxBIhexurLidiYlcIXkWUtf/RQHfEwVzBqiIuKKAKyg1JxOZz5XRlDraDlkZ0QOm46Xee8MLbSqstkP7MK+vXJzxLptteDD3wJu3NfZb8ZQq8e3nNWesj0QGJgnIP6KzP6PqfJpuspSyRd5XcYpzkdcZ6OugdSj6fnTV2kXCWVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ne5N00edNmR8fuIJBFYgsT2yxRM6fQ2hRJ3GhMKR7TI=;
 b=e4l/Gb3u3N20AVPnk+o/0wv3w4V8bBckmVP8DUAqzTQ1UNUbT/FV/YnLsMwOseJPHZz5+6j8cUOE4NpHofosO1nDG1b+Xyn1G1jtXyx42/76XCDh4BsLgiJ1O9gj7zYK4+aqraEsu3FJ2rvZINDJPXV9kOpX0YvNclCWOwepwKpxhInDttDnuHFE9jxU9dinXEK0lj38AmD5n2pbp1K+fRh7dW/ympHwIvAR3jyFEXKJT0g46gXbmxlftnCpBZnlV6t4qF69pMAT3LQ9Ebw3lybpfWLU8Ru4aqCJU/w7GZE/T7XdaTTOK3e7z3Ux9KDE4k6hfZFtnxfYaCONKydGbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ne5N00edNmR8fuIJBFYgsT2yxRM6fQ2hRJ3GhMKR7TI=;
 b=SczrDSfoUNhZW2aRaFSB7N+SfBGOGu6i//RamqXmpcUH6UDE/oJF+HJqf5/mHXydnqlMnRFxCErvB106LisRB4+xJyIHO6Wf/jiLoMuY5J314TXQkxAzU6rEz8nATylkdVoGJAIaID133f2428MbZU1JdU/2yCNynKkl1pZ8a+s=
Received: from SJ0PR13CA0081.namprd13.prod.outlook.com (2603:10b6:a03:2c4::26)
 by CH3PR12MB9124.namprd12.prod.outlook.com (2603:10b6:610:1a7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.38; Fri, 4 Jul
 2025 10:33:34 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::90) by SJ0PR13CA0081.outlook.office365.com
 (2603:10b6:a03:2c4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.12 via Frontend Transport; Fri,
 4 Jul 2025 10:33:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Fri, 4 Jul 2025 10:33:33 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Jul
 2025 05:33:31 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v5 9/9] drm/amdgpu: clean up the amdgpu_userq_active()
Date: Fri, 4 Jul 2025 18:33:08 +0800
Message-ID: <20250704103308.1325059-9-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704103308.1325059-1-Prike.Liang@amd.com>
References: <20250704103308.1325059-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|CH3PR12MB9124:EE_
X-MS-Office365-Filtering-Correlation-Id: c91459cd-04d4-47f2-feb3-08ddbae63a4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AtkQvIBVDyPIhLKOd/JH1wINN1JE+6HJvrK/atBCpMyeD9VCG5Ga6dFA3xhM?=
 =?us-ascii?Q?VVKA2m7nf3gb4c2wTWjoq+WW9JSIC/fTa7x05ftSviyp4eZJicK9vdoa05pb?=
 =?us-ascii?Q?tLJENwJQ48dwKIhINuKppaZGRyYNGDtFXKJJaw+KVSRt3rQoq2MtSjOFfRlU?=
 =?us-ascii?Q?me+vA4WL8mJOr6JYS2Ucg3YrRtwYQmnJLqu2RxqoapUxBu8TeRij6wSiKboH?=
 =?us-ascii?Q?i5ienZ/LQL129B+Fns+udgQZFZybL1G+Hqw7LRNp4FO9+/ZN4pGzy7WGR4vR?=
 =?us-ascii?Q?wrW+1Shm3XyjEM9Qu9TaclGMiB1nV0Y297WodGp/j7JHXd3dtO3Mg1ucUbiU?=
 =?us-ascii?Q?LwnU3tilzv2uDNUaGlJFNWXBDkBqwF3BL8nk6W5dVNLf3mMu0dVj4rrGW8Px?=
 =?us-ascii?Q?D2eDShYztXeOahSFCljfjm/gWc6THRXAjt+EEaMtpX8E5yjbKOn/jqud6SaQ?=
 =?us-ascii?Q?2gdsrwFwrb+yEfjab9Rtbz2F/wjlu+J4YXtyc7cgiUablHXPnlZ4jrnfj8EZ?=
 =?us-ascii?Q?f4hYc81vEL+qKev2OpL4yd5E9iS4RQ7Fi9Itknp49LdUiOMKNauK/CAfFfX8?=
 =?us-ascii?Q?+hsptBxNujppLdiDsjzau8z5Q5sSbAl1sdkDVlIN3nUfKvoqLEgY3BTEG3ye?=
 =?us-ascii?Q?5OnOD5bqzmmY1DvAISr/r80z3AuEgap1ImnYAJ8kdy2dObHpIL9W9qv3XF6z?=
 =?us-ascii?Q?Yr9QnL4VhNv9SBglVtzubL+MHPBLRWgwgO+ZQ/NiXtdK8xhKX8RSE9x8wcBi?=
 =?us-ascii?Q?DCBORj3kxMC0aLSzXEch8ESgDYY2Oi91+Wv8k3qipmGv2Bkd9J4xVHJzp6lW?=
 =?us-ascii?Q?E5TuKCs6Vo7aKsRxz28Zaf4qspZL7n099T0Tb9MwrVmWXcKf0WCpcDc1kSG3?=
 =?us-ascii?Q?YCSMfcDRTyjMfgCxNfrt1EhTx6nApNuPNmR2kYFZIJvmQpXeBNEaF0/8UVlV?=
 =?us-ascii?Q?5yhy9gBbjjG5Ce5L8cE2aSCSZFvPsBcQ+yJ4Z+t9aEhOl1lm3Yw0J+R6DGW4?=
 =?us-ascii?Q?d3pM7boVcJ8ubb38e1LJCJn4SDiV9J0ngV8GfcLyhvMB66hckP+XeDx6LQFH?=
 =?us-ascii?Q?4cDUoVRKMtPdPUTBrTH3VWMrui2AA05MqFt4tk5W6OJJQrCXFNqE46rPjDm7?=
 =?us-ascii?Q?4rFCn1bDgbdoHCTJJ8wWxALj+oqGso1+wRGMtF6olq5lfMG2OI2mSgoGDrr+?=
 =?us-ascii?Q?rOLYvEgzmrELYenACZStbz5JeQJTn0Dfmmb4Z4mI11ojKKS8sNjInA7mI1Zm?=
 =?us-ascii?Q?fX3rBBuZsq4WVhiR9zz1T42Se+S2daCyDN1cHzbEV7jbGW1UO2D9h+BUB04M?=
 =?us-ascii?Q?TDFGg+CXYG6X0ifS8zLi+PFdK4alrLExeRrkBgqtJVpymB6idi/8gzZqbEw6?=
 =?us-ascii?Q?slmdPMuvSWDceVEDQo4/GlZXYP6YE+DhN9vGUDFfFjrzkSJHnbmOFR3YeYJb?=
 =?us-ascii?Q?sB3ugp7VRmETTn77suyLEWMMuaNr985kJWnNrt1DgKyDguuIeIwG1xxTsW98?=
 =?us-ascii?Q?FG2xDt83KYN6l5wBo4bv8ELa07XjwsXD8g+b?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 10:33:33.8633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c91459cd-04d4-47f2-feb3-08ddbae63a4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9124
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

This is no invocation for amdgpu_userq_active().

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 ----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 --
 2 files changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 221292b6417a..57e53f403def 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -314,22 +314,6 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	kfree(queue);
 }
 
-int
-amdgpu_userq_active(struct amdgpu_userq_mgr *uq_mgr)
-{
-	struct amdgpu_usermode_queue *queue;
-	int queue_id;
-	int ret = 0;
-
-	mutex_lock(&uq_mgr->userq_mutex);
-	/* Resume all the queues for this process */
-	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id)
-		ret += queue->state == AMDGPU_USERQ_STATE_MAPPED;
-
-	mutex_unlock(&uq_mgr->userq_mutex);
-	return ret;
-}
-
 static struct amdgpu_usermode_queue *
 amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 08c49d738ec1..687583688c6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -121,8 +121,6 @@ void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
 void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
 			struct amdgpu_eviction_fence *ev_fence);
 
-int amdgpu_userq_active(struct amdgpu_userq_mgr *uq_mgr);
-
 void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
 				  struct amdgpu_eviction_fence_mgr *evf_mgr);
 
-- 
2.34.1

