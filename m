Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0060BCAC581
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 08:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96B5D10E492;
	Mon,  8 Sep 2025 08:49:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2VW2l+le";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4311F10E487
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 08:49:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpd/9pHHRcsnM9U05/PK41ekkxzzCCh9zI8t6zbFJenhU/zgaaruF8xDzr7emqzUaJt5wU6YXB1iiLILf6Hss1HKg7L0LE685sABZkzLxk3KZMNswa7Rd2iCmA8hN8B1b1h6ihr6r2T3afB3tcpTjrxpG+BNbGnQrbZ6RbTR2PkGKctNMWsMW8lO9crpZfJhRVzqzMYQAj26NGKA6wra/dve7ZFs/GnYe1SDqCerPyECRK19J8XUF4pVicSbqcSQu8VJdFf5gk3RPI03XaRo8ayjWJvIzxdpq8EEFoGxjfbkfsC0YdU4IKGfanebd6pOgek2r5VHYwZPoOuqyX3oUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ijcdt7sIW0o4zBhFcRX+t5xiYD6B3XIQIKIHGtP8J/c=;
 b=PMfdl/GzHi40IkSBhnN92hIHQWrLRzgTbg+J4UmkJxa5fa2g0cWYn8DpNzuNBgFroW7SyzYMa/UHByPQ85ob5wyZHlm6mDFiQBCLDskUl7cVjZKNI6lEUq5psMHSM4LMXlOJROWsVzvOBMPWs9cN6p36pc7BasMMHcYbnqiKkhbBCnSqIsOCw/2fMRteZXikAf14MSVmQ3BnZNXYNHwlWQ4kq9LLX9gcfC+Z5xar3W/KLVwpxcuJ+FBMj49k3dpPlTVvVUcvBw+QppQ64O7zzS16IzpjIbDFjdJT4u5paSb7dk3AVyvlVUaUaCnFWx+HLDxGw538n2kNM6e/5T4+og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ijcdt7sIW0o4zBhFcRX+t5xiYD6B3XIQIKIHGtP8J/c=;
 b=2VW2l+lePrq1er6EgZOlBNe2DkU9rqo1xE8x57VXSE1I9MEWsQwEP0bcTKj2cWi6rF5jKfUPaVUq3HZ8n7wH9J+SJoikHI3Q135nxMgXBTh6VUPadbz+M4z4K5wblrQsHdsa244DMpuUZZeCZPN5y426BlMhKpy93QSJ2ZiPyv4=
Received: from SJ0PR03CA0226.namprd03.prod.outlook.com (2603:10b6:a03:39f::21)
 by DS0PR12MB8413.namprd12.prod.outlook.com (2603:10b6:8:f9::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.19; Mon, 8 Sep 2025 08:49:18 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::19) by SJ0PR03CA0226.outlook.office365.com
 (2603:10b6:a03:39f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 08:49:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 08:49:18 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 01:49:07 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v10 06/14] drm/amdgpu/userq: extend userq state
Date: Mon, 8 Sep 2025 16:48:38 +0800
Message-ID: <20250908084846.1873894-6-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908084846.1873894-1-Prike.Liang@amd.com>
References: <20250908084846.1873894-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DS0PR12MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: 524b8687-408b-47ae-8ed0-08ddeeb498c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u2QV9mc7NpKzZUZ0TcZ05LZ+PUZHr6Px6gphAOHKpW9WzwsO3YLJAKTj6GHO?=
 =?us-ascii?Q?teW5rHsvC6Z3EBwOx3yXBytU4NWJ+8RNx4vujCo1vXYI1cJ6UQXFFGWVELdR?=
 =?us-ascii?Q?gz7jU3sadVY4TnocoIWPYHWXThGmR6OsKnjKMsw5NdOkTZkDRzO5mbnAHygk?=
 =?us-ascii?Q?dCEIJ99+19NKu5byG3HuS+4KsHeAuuzh37iblbg1B1tFje/ydpsNAvQttA+n?=
 =?us-ascii?Q?AYWH8jVbpW+Te6aDsPi7jnLRj0I4SO+76xDLvyEZ+QTei0Jt3D51YlYbQCV+?=
 =?us-ascii?Q?5alSDzCSbNq4piYDYicH+emJnc8gK7DknjLekwuadDG7Q7sbJwM0xm5zO8Vq?=
 =?us-ascii?Q?kS3hUDQi052u8YfHUf59VniEKEqzd64LKVaCGGX6ohbD+26+r608LfSWVXMy?=
 =?us-ascii?Q?gaiM5mWgvNTwtaIJWTa3qAkGlZIznkBg0oqyYkD6w13x+rA2XkoCJAnCTLNa?=
 =?us-ascii?Q?OsJ4tJd8fMKYG28njKmpjVNMcKzqZvzU4VX5DhycUVbEfGrTib3+p18jCSPS?=
 =?us-ascii?Q?q+2kBo/CZqK2YY0iKQPkxnVoAlTXgdYseCVnyLu8ZbcNxsLAsfrfjni9wYz9?=
 =?us-ascii?Q?ypcYaCbc4J9vvpUoZEXEc2zwGg+KsRAQLtmhzhpIw408FWEzvTEN/ROr7UVq?=
 =?us-ascii?Q?wqxRAeXmrvrfPgOBb5XtzlqyUwFYOGMo5huURAANdMkwUbTMqtaKSd2MRKwn?=
 =?us-ascii?Q?m40JMHtgFgfOuXJRtgkHyNO57jCxowd5ztfCKyYZmnjb1vQlU+J7UPyG9gkA?=
 =?us-ascii?Q?cJ0oonQgn6Woknlrvy8puTpCNhRVWAjoUT3qw0B3hcC3d4xfhR4avs9zTRQC?=
 =?us-ascii?Q?JCVP5wpX4iBiN0dmR/c2NOihrz6QGpZU2a07iS3MDCnMzPjwSKQMzTTr92/Z?=
 =?us-ascii?Q?n/h2o2oC3cficGD8c3YFJsMoObMbHUm9KCvyxKnNtI5Dg5+T/ZiRzj8kBNlY?=
 =?us-ascii?Q?QZ7qkskKxXZGo5hOVxoM7wA33ewO3MPfAHvzT90PlpXWCzlE1WH2aR8CH/kf?=
 =?us-ascii?Q?ffjeJCHnkclEmj3O2Tn10cFttMpdaL8RyKWAFh5vbIPWBpG7xSK9EDiuP1GV?=
 =?us-ascii?Q?ONTOkcyYoXxqRU6+HyNeOr+bzrPx4L2ZwZfrCNDEFE3TJ45QhW3B38vFfKQP?=
 =?us-ascii?Q?Yqyeu1FzqMsHbgOja+WBXHtiKYR/pm+Ag7jhXfwTyQVOPRsngMal2CbBF3n6?=
 =?us-ascii?Q?7CEM29mL1qcS4OwwaMMxeJiR9qPmFWfmUHTBvLkKF4w7Yfs3TGIVG3wkVWny?=
 =?us-ascii?Q?puR9NjLT/6vh0aACfD7ej6XPoAFWQXgKNYszR0d3Cx9gmMFAKd54fV1Cl016?=
 =?us-ascii?Q?muPzqWkvO1CvC1n+sjBke8Fs9xVLu0juhQOkSVRKfHekLjUOxMZCfnhaFSvT?=
 =?us-ascii?Q?UoAQXWgBVcdeGSAA3KG3Yt50szzmvnQKQAIWIZOfIwrtVmpRh/Mny3hCK+9k?=
 =?us-ascii?Q?Kth4Zcw7S6ZmfdJJTKrCerVIbeXaeko3sN57Y/7OLT+JESWWZ7CHugY+B4YY?=
 =?us-ascii?Q?hcAZK0qDcr4oIG6q+V2NadIAouWrq+lxrIAR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 08:49:18.0477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 524b8687-408b-47ae-8ed0-08ddeeb498c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8413
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

Extend the userq state for identifying the
userq invalid cases.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 75b7e39ee576..8cdb1880315b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -496,6 +496,8 @@ amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG;
 	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
+	if (queue->state == AMDGPU_USERQ_STATE_INVALID_VA)
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA;
 
 	mutex_unlock(&uq_mgr->userq_mutex);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 48722936ff70..743f08c9bd71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -37,6 +37,7 @@ enum amdgpu_userq_state {
 	AMDGPU_USERQ_STATE_MAPPED,
 	AMDGPU_USERQ_STATE_PREEMPTED,
 	AMDGPU_USERQ_STATE_HUNG,
+	AMDGPU_USERQ_STATE_INVALID_VA,
 };
 
 struct amdgpu_mqd_prop;
-- 
2.34.1

