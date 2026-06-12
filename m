Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8B2CD98CE
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 05:53:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA25510F23C;
	Fri, 12 Jun 2026 05:53:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zrO7A1MN";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012010.outbound.protection.outlook.com
 [40.93.195.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B4D510F23C
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 05:53:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eO3QreuE0aNS7l5NQm07N205CS02YqIt5lLt5W7XmGNlPIibLdbpenid0/ewLK9fXae/NKrJmtxmsI0bAw9PqOOERxtUkTPnEbRFmFsVcspcD24ly1RcpICtYeXO8J8BdJLhX4/rcEyUbYYIlq4F/aAhT1HrIOYLAcVgrROYiiWLOESlsXKDcKiC4j0/PtlD0Q0c3JnQjrCoIKv0WNV97pMnt8B+Tp4StnesGxKCYKngZj/q84i18lqXH8Ce1ycTjQ1rNv5A2WwC1fMzvMZ0IMF2iAU7n6QtV0X7K0Prtf/AuY7QfQm68wUe/8CD0yhODlsJF9/T1Hp8/Mg67m8pqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmLdIvtNAuOWLMjWtnD+DG4/ejo/8dBvtGzSTM3dZhM=;
 b=cB34tc8ch7WuU+ooMQm24r9CcfiTHmDHx/NHhu+0fOKteOXcju25Z0x+UIRGK/MzK0tx6TsxZZHkRJVioc5wmmyavzRku6ddv8MaCSqbWHSUseru4uGtFfrkapKahs9YBGWZAx1J4MjD/k860ndUq6WI5lVpAkWnB5raBCBjYgsGpqgLChbF9qLgzNGdxMZvLyDTA8e33mn3MxWvrHjsJaz9JnUZnAnnE0yGSWX89uIcsWbcBDtzddxxnDUQ9utyGo9MrGcfpgsSmbkweKV27GBD8AmKhGQ3RjUzAzkrmk9JIBkO3Qypg+AUiErG0uXqIiRRf1bjXdJxEc8xJKjD5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmLdIvtNAuOWLMjWtnD+DG4/ejo/8dBvtGzSTM3dZhM=;
 b=zrO7A1MNhLYuFdSvirawIs58xAsbAyn2d91pzf5C1NHSbWxpUEGlpmIzEUbvUfNnBP3xZ+1535RJcI0CkvWeiiBhl/ZfB9I66R+NFKbtcFCQAcu53+Yo26o7+jXIwKGTlC8DAVeYs9tQhQiCxw8xWuJwSX5c1ORQyId9TfH8YUE=
Received: from BY3PR10CA0007.namprd10.prod.outlook.com (2603:10b6:a03:255::12)
 by DSWPR12MB999153.namprd12.prod.outlook.com (2603:10b6:8:36e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Fri, 12 Jun
 2026 05:52:55 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::2a) by BY3PR10CA0007.outlook.office365.com
 (2603:10b6:a03:255::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.15 via Frontend Transport; Fri,
 12 Jun 2026 05:52:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 05:52:54 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 12 Jun 2026 00:52:53 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 0/5] drm/amdgpu: Wire GPU events into EVENTFD notifications
Date: Fri, 12 Jun 2026 11:22:21 +0530
Message-ID: <20260612055226.2879270-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|DSWPR12MB999153:EE_
X-MS-Office365-Filtering-Correlation-Id: f46d15c1-7272-4d87-d6b7-08dec846d92d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|13003099007|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Z+Fw4tpfo/w0pARWedRNrczkfX+nVm9IOJijfhNMmB2l7Z+fbGPGguJO2qsI07e7DG8JsseQ/5kdOZUS+OEIBf+EBYXtCdrPTMMlxz070d+0lEDLF1i9gHJMiBZ9UNH2n+nmvWFi8qBpv+FB0KsmV3m4xZToyV1ZYcPg6MeRIteSYQMn8U9WbvUUS/Gov1FhIHeDbR6GMFDoV2RRvU/RF1Co1CRMZY8PQjKpX5OCyDjx31U1iegwbT+lAj/oAK/Pvrqqy81PnvTT9F0aBiFTBKVoH1qE4U2lrqg5zwmIKMtsjOPlizSsWq8zVloLeQxFhs9/eaUR5YE9oc3X7Obs5RmhKcl0OTb27AxlWVmR3cjXiXEPc9cjokJ+WKKZmfRDOSCgaNnfWmBHGtb7qqKxir/R95n38ix9ogWbEqaps0Mn21J1+4Ctjj3G7TxI8FTQujECZY+sMt4P0mGS42QZz9rJQ6WK7LFWH+OIgKDoxyiHNsvJ8Y1bG6wTP24kDr7AFt6XHZxHvJ+ZC8tUmkwm4sfItRQ8N1yBt4p7u9TAxQa5s+1EdPXieFGwnaFNFvicY2BSxj1QnHnTOiD2TyJ8H11A78PM1MzxhCuHicBaUApT+Q46Jk97dHVkXt7HON8RcVeIzfL3Hd+BXj/99JKrseIdBi4h/TLPNaD1fw5XyK4w91LM7CnXxb4K1IUULfGV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(13003099007)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZgDigmHtKXDkXLJNbTgfu/X9C6MgLJYVQoAB9ywhk02QfFG62NpZtFzOhsXyZxUyLwPFpMEFMFSdv10yk53rjsRqQ/ZmKwHBdbPaSlU2iRvb85m0+GeiVuyKlPDPIUdKw7inG7tmtGRUlqrCS4+/OHgi8V9MsrToprEOR9VgjDeNeU8lNIjLoFyp8ecICpNeYpWY3pJwkaFywEt7SycVy+sMqysSHP3+b5eNyv8Q35X2TmMckoFwK4xfLCqYvpVDbmDsC8GolFIiYJ37rYnmW0+lbQ3UVYfKNWamIWAR0fjsfp0/bCdeWX5I4OkZG+xd/mL910lWBfe4YNv5Jl3N41Ei7xO4jpTZ49kaRyxh7ydZg0DJ9itG2868v6truzEOXtL/UyQsOLcVRg3Lq9y5VgpAo+xhYPKe83q6D7LQDQzP5eLW5T+HeOi/PJKimE1I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 05:52:54.8942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f46d15c1-7272-4d87-d6b7-08dec846d92d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999153
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

This follow-up series wires existing GPU event sources into the
render-node EVENTFD subscription infrastructure.

The EVENTFD infrastructure and subscription handling are provided by the
base series:
https://patchwork.freedesktop.org/series/164618/#rev7

This series adds the event producer side by reusing existing code paths
that already detect these conditions and notifying the matching EVENTFD
subscribers.

The events wired up are:

USERQ_EOP
QUEUE_RESET
MEMORY_EXCEPTION
SCRATCH
GPU_RESET

USERQ_EOP, QUEUE_RESET, and SCRATCH are queue-scoped and use the
affected queue object for signaling.

MEMORY_EXCEPTION and GPU_RESET are GPU-scoped and do not use queue
objects. All subscribers associated with the device are notified.

EVENTFD remains notification-only and does not carry event payloads.

Compile-tested only.

Srinivasan Shanmugam (5):
  drm/amdgpu/gfx11: Signal USERQ_EOP EVENTFD notifications
  drm/amdgpu: Signal QUEUE_RESET EVENTFD notifications
  drm/amdgpu: Signal SCRATCH EVENTFD notifications
  drm/amdgpu/gmc11: Signal MEMORY_EXCEPTION EVENTFD notifications
  drm/amdgpu: Signal GPU_RESET EVENTFD notifications

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 30 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  9 ++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 15 +++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c     | 14 ++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  9 +++++++
 5 files changed, 75 insertions(+), 2 deletions(-)


base-commit: 43b7fade995f082c15e0c0935d14aecba3e50356
-- 
2.34.1

