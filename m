Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0ACCD6E55
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 16:35:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8960F1120CC;
	Wed,  3 Jun 2026 16:35:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OsC5ce2T";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FB251120CC
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 16:35:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/Rsy8XxdXm43eANclCTfFc7M2JWKUMCTAPBENV44vvwxholYhQR8mJEcIu1CyxSmK6B7yzvkTdAr16+CsAVlBpTEbxz5vyKN+QyeOPA/7xHPxsEfBEpE9Hk7DIGirQCYPK3akG4iFgy/oaUXTPvC/+sU1M1PCv8NhCvm/SbHvArl7LKBCRULXA7yfCJOCPFngpRfEPttgrPU+2Ow6xu8GGtsrMjXzhuIBCIoa6toOKRbvkqIgFkinIF5rQ2Go4dMGFY/CDikV3yrWCjW3wfFbBlnrxf+itGh3OhlbA5l8zAyTolcZ5KKPc+P55vGPMrXNLjhWG3PURYKwRSe/oBlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEiet4DJj0jC41paTq/+VhgjeAV32AUOd/WIkvEhHDM=;
 b=fDHQAA43nkUwhLcMdQAkNDdoKKZY91JdfMjpXKp/vob09LlTy/HIAHCNDJkKg55V5lyFunC2Wlvo+Txkj3hKpM/ippM7jDbVVF9UHfWaHxxdMZbYjWMlbAKaIYmTcQfsMyMwZpfS27RDwaGWko/mmX0/TdZJdDUCQwe3IVMNi0mzSBDyAaaGF4n9Kb6UduyAJrlNybdo4YR0G1NQBBNhjPWmNLhFAbYLvF6Fx//MdY01lA9L/cDXArI3BRON33uHAyEfEoV6Rgu/hk5guAlHIc6qvSCYavJN9DewnaFBPFvW9X8FbmuDyUq8A4oU4zzkM4NRUvjk7x71imT4m6vUsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEiet4DJj0jC41paTq/+VhgjeAV32AUOd/WIkvEhHDM=;
 b=OsC5ce2TaotT8RWQCGSgg1Gk2JgXe4tNuWE+sBpFk3KcZAtzMlMr/dNlXJNaltROQykQm0Dlioa26XZ+hiiWqMYO/sxiNHTn55/cR+IUnsPkMlfNY1Q6Y9KskFkV80j2c2GA6OuDWswMXLz8p/yFF9DKtVPP2K3qizC94dyEHvs=
Received: from BLAPR03CA0167.namprd03.prod.outlook.com (2603:10b6:208:32f::23)
 by PH7PR12MB7161.namprd12.prod.outlook.com (2603:10b6:510:200::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Wed, 3 Jun 2026
 16:35:07 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::89) by BLAPR03CA0167.outlook.office365.com
 (2603:10b6:208:32f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 16:35:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 16:35:06 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 3 Jun 2026 11:35:04 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v6 00/11] drm/amdgpu: Add WAIT_EVENT ioctl for render-node
 events
Date: Wed, 3 Jun 2026 22:04:39 +0530
Message-ID: <20260603163450.2678374-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|PH7PR12MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: 51829907-d108-4ead-5114-08dec18e11fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: f0FRZ59V0JqOenS9OMEXsuojJIThHctWfbIJm1WvNPejIQZsNcDiTfUI60CK+q29+TLucWrTE3egxvUxveO2dTzU1JOh8VReWBMsESBD3VQBS3Dul4mvKK2SMTJajDmnhIlmK4DdwXMqFisRXKhvQaIQ3h9i9P+3LjN8OOzA9pcWd8mvcvksF8NZkWzCLNdEbDjsiRPgHm6ovsUyThWBk7pkEMuNE0x1L6rDp8T0bcLu/nJ1ovJeNL9G8GYab1HvgV6CFHs9E4mkNPmKGuFGj2yUUDtrqQlkSig/m2JQiLkqCRil8/w3cICf8oRag6QKHS105oC3i4xmKLESY1/bO2xnnsQEUySWSIjh3yuk9xr+w0Lv9k94yjuCXV2jI9Y8iedKmF+5b8SSyfuoNn4B+R83/CAmFA/0CcBU2gjKd2HzgGLg6VWMr5WE1OXa2u5c2TqSn06km9wmHXLsseAFNS1ojfNXoCSc85v263umN7+d+bTw6+9U6vmzVKGu3mMnlQCheix3NNxcnhSRdQU3G+Prh7gJDkGMXJj7j+nc0/UqB2DD1jRxoQF8vpLBDYcETxPIv1wrNhL7EvXCKMo6BgKP+kYjqTfvsFy12qo+CvuyVeAJAb15h0f2l6uR1NC9BvKSZz6DuoIXY0oJibXPjleDx183hmwbWKwR6gCm7BbkzOYs3cQGUVuugz4+UaHnTQ3vBvuTYqpXYHthCa+4eB736ctywcRq4+nBwJUxr0M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ksXReFuH5q8v4UUiuV9xSsBbUfshUy59Nk/PNLZk1v6TU3nWvBSlXVQMIF//vJuUTMQBxjzsohO+CV+K6qvq/YKOWjqPGNj+nSTi18yJTdRbOJkc8VUeZADQ2iC7xbLnoMOmq4bGcxLWaBMsBznbOexqmEJAC7ha6XmSNhlFpLbZ/lxujxD+YUDDJZsjXm1xn3EgiGu2e4o5ITPQXt9+4b3yLFY2QjvOaxnvRWY8A+KjA0MYw+WNiE58WEV5nUs51flz8ammmGY6SLQa5FbaP0p3mOc//M8wcD6y/rf9HX6woyINngODQWX0LdTuUynMkz+i/WvAzz0Hnd5WFoEojPn9J2mlu2V2+Z8MyOmzLPt5LRMWSvR14aFhe21xPJ3McKyVfnsAqoz+dcERcIcM4Uayj2qKiFmFyvLRzLTbz4adISlfoZNnDo29vKThoERP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:35:06.4071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51829907-d108-4ead-5114-08dec18e11fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7161
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

This series is rebased on top of asdn commit:
1b4722a07966 ("drm/amd/display: Disable FRL and add module param to enable it")

Testing:
Compilation tested
Driver load/unload tested

Srinivasan Shanmugam (11):
  drm/amdgpu/uapi: Add WAIT_EVENT ioctl and metadata structures
  drm/amdgpu: Add wait-event manager and per-file lifetime plumbing
  drm/amdgpu: Register WAIT_EVENT ioctl
  drm/amdgpu/gfx11: Queue USERQ_EOP records for WAIT_EVENT
  drm/amdgpu/uapi: Extend WAIT_EVENT with optional condition wait fields
  drm/amdgpu: Add userspace condition support to WAIT_EVENT
  drm/amdgpu: Document WAIT_EVENT condition semantics
  drm/amdgpu: Add queue reset records to WAIT_EVENT
  drm/amdgpu: Detect queue reset in WAIT_EVENT
  drm/amdgpu: Add memory exception records to WAIT_EVENT
  drm/amdgpu: Add scratch records to WAIT_EVENT

 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  37 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   3 +
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.c    | 401 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.h    |  95 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |   4 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  15 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |   8 +
 include/uapi/drm/amdgpu_drm.h                 | 127 ++++++
 12 files changed, 692 insertions(+), 9 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h

-- 
2.34.1

